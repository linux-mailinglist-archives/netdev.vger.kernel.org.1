Return-Path: <netdev+bounces-301614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Fm4BxO5O2p+bwgAu9opvQ
	(envelope-from <netdev+bounces-301614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:01:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB66BD88D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:01:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=f3yWLuUB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301614-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301614-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 222FA304EA0A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271BD314A8E;
	Wed, 24 Jun 2026 11:01:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD92BEFEB
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 11:01:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298867; cv=none; b=cDDVsgfedWtcwDtT7kJH622mV3VWQc2DDlO4mKbZ6AH2w7rVzRMcJinVJuzXnzPgN6KNTlCp9ELqHraxzn4s9OTSPDAcMoaq6AFM2YmKxY96u6iZzo29RKpukWK+aI/JFEsflY/qI645Ipo5pFfiZQjthOwdPqITC1RNCEiHrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298867; c=relaxed/simple;
	bh=Bg/C650zMhhzCeh8uDt6OlrHOje50P0/4D6oNiD3c+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGhDriC2Q/gXmn3T3wytNY/oXZodAUfIfwkb2PuA+SGride0QsPXfLaS6u5voovUzP3QXdsiemOgEOviAhQRczyYsyhBuGQN3vEORydK+iMxJXx7GcJVFypksCzgb1rzCCOIxnKjNCyKNy1/8O71wKpMK0koZmJffRkbDmUakXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3yWLuUB; arc=none smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ad68b30252so1005159e87.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 04:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782298863; x=1782903663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pxuVeaMBnszMeRz8ajoDN+MAccCemdt9YS/JX9ZEN0=;
        b=f3yWLuUBgY0PTcUmu9w6/rRbK+mvr4YY3qFzeHPqT9gOoUZiX0m7TE6mZUyMqJ78eL
         QbsETAYUcMLs8bdD1WQrGo223rNZm5FI0Cvg/YnZusZ8hNCrOwR3QFuc0y5GSk7qImdQ
         CBkOzGYHSvIZQi0ZTLdulBLrDSRnbzO1foYoja6SwT5KE75fXGzjTXUyqw+th1U7E06W
         Moj2BZhAugG6VNL1emjdLkydzCuAcT3AznnxfydKt2T6ngLcLtbg5e6VMEpwfluZe6Gt
         8tYvDKEYSaaRnC4zKqdIQVS/buk0Z9Kt8NkP6y84ib/LEsrhYBeTRM0Szxllo7Ecubgm
         1xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782298863; x=1782903663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pxuVeaMBnszMeRz8ajoDN+MAccCemdt9YS/JX9ZEN0=;
        b=ScJ+yhYBWYPejVWHAATKzbP1t/HjhlkpTczoUVXEm26MfO5Sz0SDVEiu9/pwKAzfpu
         sct7T4bhGDTT4fdZXeNYvaNLdZExB5F+8eUAV8JYBsbfqGti/jyBghg4aJRgyAvaF7xu
         sD38aUR3VNMROUM5YGiymNTspJSOBrbo1dnHStafsChYLuKxxM7+e5AYSwH3AbXX8pis
         NdrlDG4fJtwEN7VB7jnvESRjT0axpDx9iKpD1Ub8ZWm7nZinyrhj4wPNZb4OiXxVDLAS
         GDU8QqhrNHov0A4kDLOC9GKPtn/BqBusel7ocvgMXgsUlP9H7TBk64PH2gUmVUJMUtOv
         ylXg==
X-Forwarded-Encrypted: i=1; AHgh+RrG5ZC7UOYZj0eyuLVCWiPTxw3gm57kqIK61QQUR0dclOAM2qaSf30+OzMXm7cU1G+iy7Ao/sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIn34YvA5WkCijfEA2BDBx/1Law69kEobudaVFRzGDEI9bz+YU
	peQfsmZJz9HgRjQRlf6p8pyEYy2k26mMkchO5/kdlCtz15g3zMUFEgbB
X-Gm-Gg: AfdE7cnMyj4U9briZ8XJg3EuopbDj4dN8WJ/OLZMZUrlVGr5UC6bm3dG27LgOcnHshK
	PqJXPTiKYB1QLU69wFrcCXL277TzUkeCAblQ6bNKPXihKLwtcCV/ZjJYrbmujIaYUvgh0ji+g8n
	XpkAf9C9sH25dm/kLoJmrsXM4K0K0USkKSTcKnDmn5UesgpyL9cLML381I0SxM6994JndAfRG4D
	OseYD3nj7asHRZeRvBfqjVIf5w/uxmYIyqq5mMyFgf8X22sRg4gOH/riTYgujqkZr7q5Q+lA/RL
	TyToaxVAZqHV+m/o1gnPvvZadwaVm2DCEFPEDZ7iNbinp69XwYKEJ2FzMz+VlWYc302pG/ywUnK
	rP8Fw6AvZZ5OX7/+v69Gkf7qBbFy5JO+Nxk/20+QMNvJHxhnei3i0k5qLxMxEqtZXGufxK5xWiD
	4DhVj+3cQiFu8Sz6IFpTZqLWqfgjGPa+A7VvDGC+Y=
X-Received: by 2002:a05:6512:2c0c:b0:5aa:6d0f:d74e with SMTP id 2adb3069b0e04-5ae9d56fe99mr792437e87.3.1782298862200;
        Wed, 24 Jun 2026 04:01:02 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad695509dfsm1630422e87.18.2026.06.24.04.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:01:00 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH 5.10] netfilter: nf_log: validate MAC header was set before dumping it
Date: Wed, 24 Jun 2026 14:01:15 +0000
Message-ID: <20260624140117.19799-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	DATE_IN_FUTURE(4.00)[2];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301614-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,strlen.de,davemloft.net,ms2.inr.ac.ru,linux-ipv6.org,kernel.org,trash.net,vger.kernel,vger.kernel.org,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:pablo@netfilter.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:davem@davemloft.net,m:kuznet@ms2.inr.ac.ru,m:yoshfuji@linux-ipv6.org,m:kuba@kernel.org,m:kaber@trash.net,m:netfilter-devel@vger.kernel,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,asu.edu:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ADB66BD88D

From: Xiang Mei <xmei5@asu.edu>

commit a84b6fedbc97078788be78dbdd7517d143ad1a77 upstream

The fallback path of dump_mac_header() guards the MAC header access
only with "skb->mac_header != skb->network_header", without checking
skb_mac_header_was_set(). When the MAC header is unset, mac_header is
0xffff, so the test passes and skb_mac_header(skb) returns
skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
dev->hard_header_len bytes out of bounds into the kernel log.

This is reachable via the netdev logger: nf_log_unknown_packet() calls
dump_mac_header() unconditionally, and an skb sent through AF_PACKET
with PACKET_QDISC_BYPASS reaches the egress hook with mac_header still
unset (__dev_queue_xmit(), which would reset it, is bypassed).

Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
uses, and replace the open-coded MAC header length test with
skb_mac_header_len(). Only skbs with an unset MAC header are affected;
valid ones are dumped as before.

 BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/nf_log_syslog.c:831)
 Read of size 1 at addr ffff88800ea49d3f by task exploit/148
 Call Trace:
  kasan_report (mm/kasan/report.c:595)
  dump_mac_header (net/netfilter/nf_log_syslog.c:831)
  nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfilter/nf_log_syslog.c:963)
  nf_log_packet (net/netfilter/nf_log.c:260)
  nft_log_eval (net/netfilter/nft_log.c:60)
  nft_do_chain (net/netfilter/nf_tables_core.c:285)
  nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
  nf_hook_slow (net/netfilter/core.c:619)
  nf_hook_direct_egress (net/packet/af_packet.c:257)
  packet_xmit (net/packet/af_packet.c:280)
  packet_sendmsg (net/packet/af_packet.c:3114)
  __sys_sendto (net/socket.c:2265)

Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to print decoded MAC header")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-52942
 net/ipv4/netfilter/nf_log_ipv4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/nf_log_ipv4.c b/net/ipv4/netfilter/nf_log_ipv4.c
index d07583fac8f8..d6164e8e2c73 100644
--- a/net/ipv4/netfilter/nf_log_ipv4.c
+++ b/net/ipv4/netfilter/nf_log_ipv4.c
@@ -296,8 +296,8 @@ static void dump_ipv4_mac_header(struct nf_log_buf *m,
 
 fallback:
 	nf_log_buf_add(m, "MAC=");
-	if (dev->hard_header_len &&
-	    skb->mac_header != skb->network_header) {
+	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
+	    skb_mac_header_len(skb) != 0) {
 		const unsigned char *p = skb_mac_header(skb);
 		unsigned int i;
 
-- 
2.43.0


