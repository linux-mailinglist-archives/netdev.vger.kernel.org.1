Return-Path: <netdev+bounces-74026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF085FAC7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C843289078
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC314A08F;
	Thu, 22 Feb 2024 14:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FD13341F
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610784; cv=none; b=sA1iM0ho8N3HL7FXTnXveUuc3GJtok8i/DCxTmpO4T0wFT8Ht/3MZ+1FlBRr1AYoEnOBVRYS9I1Cyatlx8x4yT5bBKvyYbMYzFvs+NNwdCnjof2Ebjh+NTzF9K7ufGaLQo0rGpc27167OAZmvLHLoKdNDWMRWGyOOUcFfiZNlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610784; c=relaxed/simple;
	bh=lNMNrhSql6efyyvdH+prK/tqg80QuxRFYS1jbSRFxU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX7G0lEWo2VgY2/PBjitU9QgZTA/pSeOT5o7Qy7pmziUCIIBAaXZmn80x8Tf40EvcIXrbIUr3tAQ/BXsGJ+IjDTqsy9xdrCtdt0KwwCbEVmAe3unk3Y30qmUs2oYHb8TRA8jPaQJ9JoPJabBnHRp9DuoNbLUStucl29ARLeO8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rd9iN-0005Zi-B8; Thu, 22 Feb 2024 15:06:19 +0100
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
Subject: [PATCH net v2] net: mpls: error out if inner headers are not set
Date: Thu, 22 Feb 2024 15:03:10 +0100
Message-ID: <20240222140321.14080-1-fw@strlen.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iJZnY_0iM8Ft9cAOA7twCb8iQ4jf5FJP8fubg9_Z0EZkg@mail.gmail.com>
References: <CANn89iJZnY_0iM8Ft9cAOA7twCb8iQ4jf5FJP8fubg9_Z0EZkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpls_gso_segment() assumes skb_inner_network_header() returns
a valid result:

  mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
  if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
        goto out;
  if (unlikely(!pskb_may_pull(skb, mpls_hlen)))

With syzbot reproducer, skb_inner_network_header() yields 0,
skb_network_header() returns 108, so this will
"pskb_may_pull(skb, -108)))" which triggers a newly added
DEBUG_NET_WARN_ON_ONCE() check:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 pskb_may_pull_reason include/linux/skbuff.h:2723 [inline]
WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 pskb_may_pull include/linux/skbuff.h:2739 [inline]
WARNING: CPU: 0 PID: 5068 at include/linux/skbuff.h:2723 mpls_gso_segment+0x773/0xaa0 net/mpls/mpls_gso.c:34
[..]
 skb_mac_gso_segment+0x383/0x740 net/core/gso.c:53
 nsh_gso_segment+0x40a/0xad0 net/nsh/nsh.c:108
 skb_mac_gso_segment+0x383/0x740 net/core/gso.c:53
 __skb_gso_segment+0x324/0x4c0 net/core/gso.c:124
 skb_gso_segment include/net/gso.h:83 [inline]
 [..]
 sch_direct_xmit+0x11a/0x5f0 net/sched/sch_generic.c:327
 [..]
 packet_sendmsg+0x46a9/0x6130 net/packet/af_packet.c:3113
 [..]

First iteration of this patch made mpls_hlen signed and changed
test to error out to "mpls_hlen <= 0 || ..".

Eric Dumazet said:
 > I was thinking about adding a debug check in skb_inner_network_header()
 > if inner_network_header is zero (that would mean it is not 'set' yet),
 > but this would trigger even after your patch.

So add new skb_inner_network_header_was_set() helper and use that.

The syzbot reproducer injects data via packet socket. The skb that gets
allocated and passed down the stack has ->protocol set to NSH (0x894f)
and gso_type set to SKB_GSO_UDP | SKB_GSO_DODGY.

This gets passed to skb_mac_gso_segment(), which sees NSH as ptype to
find a callback for.  nsh_gso_segment() retrieves next type:

        proto = tun_p_to_eth_p(nsh_hdr(skb)->np);

... which is MPLS (TUN_P_MPLS_UC). It updates skb->protocol and then
calls mpls_gso_segment().  Inner offsets are all 0, so mpls_gso_segment()
ends up with a negative header size.

In case more callers rely on silent handling of such large may_pull values
we could also 'legalize' this behaviour, either replacing the debug check
with (len > INT_MAX) test or removing it and instead adding a comment
before existing

 if (unlikely(len > skb->len))
    return SKB_DROP_REASON_PKT_TOO_SMALL;

test in pskb_may_pull_reason(), saying that this check also implicitly
takes care of callers that miscompute header sizes.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>
Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")
Reported-by: syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/00000000000043b1310611e388aa@google.com/raw
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/skbuff.h | 5 +++++
 net/mpls/mpls_gso.c    | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 28c7cb7ce251..1470b74fb6d2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2894,6 +2894,11 @@ static inline void skb_set_inner_network_header(struct sk_buff *skb,
 	skb->inner_network_header += offset;
 }
 
+static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
+{
+	return skb->inner_network_header > 0;
+}
+
 static inline unsigned char *skb_inner_mac_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->inner_mac_header;
diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index 533d082f0701..45d1e6a157fc 100644
--- a/net/mpls/mpls_gso.c
+++ b/net/mpls/mpls_gso.c
@@ -27,6 +27,9 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
 	__be16 mpls_protocol;
 	unsigned int mpls_hlen;
 
+	if (!skb_inner_network_header_was_set(skb))
+		goto out;
+
 	skb_reset_network_header(skb);
 	mpls_hlen = skb_inner_network_header(skb) - skb_network_header(skb);
 	if (unlikely(!mpls_hlen || mpls_hlen % MPLS_HLEN))
-- 
2.43.0


