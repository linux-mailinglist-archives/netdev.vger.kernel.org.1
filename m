Return-Path: <netdev+bounces-246588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F42CEEB7B
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 581FD300D17E
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A6D3A1E67;
	Fri,  2 Jan 2026 14:00:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2CEEBB
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362450; cv=none; b=euHoPXZv9bTD5ax9sKhqsepKRNOMFGC6BeuDJN0d5FRZYeVNiB1j3SCmB5nhC/GfyHfJZAOkfXJJWaYNwjJyHYh5t3S64E8qk4kGewLg2EFB3VYIomc+8d2D8UQkY8yNn59QtS4LTKnvmtd80T4yTCpaPUx4fVOZ0ebLFjgLf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362450; c=relaxed/simple;
	bh=s3utorbSSo/daQapsq6QQCIizAg3tqu/G85i1AZtpvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y014SwZRaP+wkAYJjgUbIRbu2oO4SW8eZtFizfJpMCbrOEZ6YLRScCjmrjYQA8TQ7Dea4Q1M8VXrtiPEBl9B3MqrznRht0lToGXDM64ifWsUujYFihJMMscfYFWy90wQ+imIohsXfGGYyfTMWuiGgad7FPg6mRwT+RI9wIdW+YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5174B6015E; Fri, 02 Jan 2026 15:00:46 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	Florian Westphal <fw@strlen.de>,
	syzbot+4393c47753b7808dac7d@syzkaller.appspotmail.com
Subject: [PATCH net] inet: frags: drop fraglist conntrack references
Date: Fri,  2 Jan 2026 15:00:07 +0100
Message-ID: <20260102140030.32367-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub added a warning in nf_conntrack_cleanup_net_list() to make debugging
leaked skbs/conntrack references more obvious.

syzbot reports this as triggering, and I can also reproduce this via
ip_defrag.sh selftest:

 conntrack cleanup blocked for 60s
 WARNING: net/netfilter/nf_conntrack_core.c:2512
 [..]

conntrack clenups gets stuck because there are skbs with still hold nf_conn
references via their frag_list.

   net.core.skb_defer_max=0 makes the hang disappear.

Eric Dumazet points out that skb_release_head_state() doesn't follow the
fraglist.

ip_defrag.sh can only reproduce this problem since
commit 6471658dc66c ("udp: use skb_attempt_defer_free()"), but AFAICS this
problem could happen with TCP as well if pmtu discovery is off.

The relevant problem path for udp is:
1. netns emits fragmented packets
2. nf_defrag_v6_hook reassembles them (in output hook)
3. reassembled skb is tracked (skb owns nf_conn reference)
4. ip6_output refragments
5. refragmented packets also own nf_conn reference (ip6_fragment
   calls ip6_copy_metadata())
6. on input path, nf_defrag_v6_hook skips defragmentation: the
   fragments already have skb->nf_conn attached
7. skbs are reassembled via ipv6_frag_rcv()
8. skb_consume_udp -> skb_attempt_defer_free() -> skb ends up
   in pcpu freelist, but still has nf_conn reference.

Possible solutions:
 1 let defrag engine drop nf_conn entry, OR
 2 export kick_defer_list_purge() and call it from the conntrack
   netns exit callback, OR
 3 add skb_has_frag_list() check to skb_attempt_defer_free()

2 & 3 also solve ip_defrag.sh hang but share same drawback:

Such reassembled skbs, queued to socket, can prevent conntrack module
removal until userspace has consumed the packet. While both tcp and udp
stack do call nf_reset_ct() before placing skb on socket queue, that
function doesn't iterate frag_list skbs.

Therefore drop nf_conn entries when they are placed in defrag queue.
Keep the nf_conn entry of the first (offset 0) skb so that reassembled
skb retains nf_conn entry for sake of TX path.

Note that fixes tag is incorrect; it points to the commit introducing the
'ip_defrag.sh reproducible problem': no need to backport this patch to
every stable kernel.

Reported-by: syzbot+4393c47753b7808dac7d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/693b0fa7.050a0220.4004e.040d.GAE@google.com/
Fixes: 6471658dc66c ("udp: use skb_attempt_defer_free()")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/inet_fragment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 001ee5c4d962..4e6d7467ed44 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -488,6 +488,8 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 	}
 
 	FRAG_CB(skb)->ip_defrag_offset = offset;
+	if (offset)
+		nf_reset_ct(skb);
 
 	return IPFRAG_OK;
 }
-- 
2.52.0


