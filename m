Return-Path: <netdev+bounces-302045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4VfnButbPWo+1wgAu9opvQ
	(envelope-from <netdev+bounces-302045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:48:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 948436C78CA
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:48:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BbTceOUm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302045-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302045-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D11BD301CFF4
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106DC3E9C1D;
	Thu, 25 Jun 2026 16:48:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB51A9F87
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:48:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406091; cv=none; b=jY1qQOMpTO5LAAUD0x0BlDUkO/p/zhCuzi6LInZFKUDlVqvf20rXXzM43P4uoxrFSxcLafdExOuwtQXSf3ruqUXKGnuxl5fTa4umbHOJ0rtHBarhDP5K7f2g2mmS55x3iI7oQ7exP/szJp4yLm4JwgdE8HeGrxGcpYdU+t03SqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406091; c=relaxed/simple;
	bh=qJXI9cST/Ra4iPabxPsgyOZ02qsLz7Yx5c5nuJyWipc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8N07IY06ODHjnVBTtJL3kZeFKawTclKoAlLD9tbRd43PRRXyoFdg7J04KnJesqZXmKe3HZL5TjNbufRs5Y7f7TgqgxrPnakVF05vQmXXjM4UxchZhhozPUUo3oOdV2u1jFING5TGiwLL8sDS0kf4dZe1Ka9l2I1hSRRn24LdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbTceOUm; arc=none smtp.client-ip=209.85.208.182
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3996c9eeebeso1371131fa.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406088; x=1783010888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pAbo57p2f1Q9HCCJXSOkq8MR7Ngd8saF5gl2eKPd+4=;
        b=BbTceOUmtGQvPj5dQ4/HO469r73QPy1QKeBBapzHSVHuaB8Je2a+DhP85Ikvm3vgyg
         bYRWIB8yJJrzax3iiW89TCj9joiRuKs+Q/RcXKqYLEm27SNJ6l92T+KL3qVR6U6Gpea0
         iPJGhSfTkySq+abPKMvswVLv0PId8lmK/u5NtgfmPLRY9c7pgdjk6hIES4HF7YhFQOqx
         2gMz/h8PCj1SAWU943cvEtelazpaIPb2dz1xV+36Ys/EzCnyx0y2vtHkMgl+WRruNdsL
         0g3TysQqTZ/KIoncx8f3LRch5oElY6KtkyhFMCWjd179/CZl7eIye++8P7TooP1xQuLu
         tCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406088; x=1783010888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3pAbo57p2f1Q9HCCJXSOkq8MR7Ngd8saF5gl2eKPd+4=;
        b=QU//e4BxrXBDiwzkzFJ5DHFuw2KHbryYiIEucS4C61R3Zcg4Nzo8SXI9QpVa5dT6kh
         sXqoYnb9lAS/Iirb7uyBmQIGa6HzqH/JxFeWbFmdzBbg75o7zigmFgaDRD+Dk9/lwbM6
         OqyS51lvjC2kpNVchO8UBGNj4L/kcjj20wk+krZrONUTIpytTCBMamtcxj9dRyoHoXkL
         AM43funrXas6PLIN5gC+Lsz9ma405Om6eRIxD7XPBJ88AASQg3IiQ44xfA9v4jlA0H2/
         iNPy67GRvep9Vq8Dum3cguwuUZcLJebIClqh+no+xTlP0LFNFfgoNvBDvlWfOdjIbu68
         7frg==
X-Forwarded-Encrypted: i=1; AHgh+RrE3O5L0KpWci7VWBNhwXVTF2yJr/C2TxpBx09LjK22jyagciFlg8f8pTv4f3N+BTLnZ31JOtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPI5LToTZmgx/u7egBiHcVYdPi6rHzZc7b+AE6eiU6CQsnWs6J
	DmCs/l/rPV9iAjakqVcDrpNacZQqmSMz3DfCCN47Hpwin0seMnN3ZMIl
X-Gm-Gg: AfdE7ckWDVufU5w0IYu96y1ihfYHltkFHqOzoOPe4EE6wvzK3sF2tbs9aVbl7LRZq3D
	kkNDaLFryGMbDsRPB/3ifjh+Jeu7Zomox9MvomV9OtA6X3lu81lfP+Rszl+PvY9HqhEYrrPQkMM
	7NjW01wNUlP5omzJkFjOqqJQona0EgFvfiuFbBGYmYG65v8iXP0grGjoJM8oxYGmHtuVMVYwAf3
	P1iK0zlDwln7pPCak/lhRXCS+QbPRNZMZhndBUzC6IDVn15SYuo9Xij4fMrZnLpwwuqRZrCuu2o
	dw3z+uAGTAoeSKAzuLISnhvz9kS5DxVVCWvHodKlb7ayXnISmzbRak1oTAPwod6Yl5suP2VbFpu
	OyZqTG4q9qYk/p4/3lnQ7s5aOxaLZbQmMsVAqK0m0X3z0CQqTyjVO+NOvFLoQE+VmBR5GDXegHO
	sYOM8CzHRyYgnmahEyjwnJXFNZj5foZBdff/wRrbI=
X-Received: by 2002:a05:6512:228e:b0:5aa:6b0b:1f40 with SMTP id 2adb3069b0e04-5aea1f3481dmr1155973e87.2.1782406087610;
        Thu, 25 Jun 2026 09:48:07 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69555c45sm2785934e87.36.2026.06.25.09.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:48:07 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: sashal@kernel.org
Cc: alexevgmart@gmail.com,
	bestswngs@gmail.com,
	coreteam@netfilter.org,
	davem@davemloft.net,
	fw@strlen.de,
	gregkh@linuxfoundation.org,
	kaber@trash.net,
	kadlec@netfilter.org,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel,
	pablo@netfilter.org,
	stable@vger.kernel.org,
	xmei5@asu.edu,
	yoshfuji@linux-ipv6.org
Subject: [PATCH v2] netfilter: nf_log: validate MAC header was set before dumping it
Date: Thu, 25 Jun 2026 19:47:55 +0300
Message-ID: <20260625164755.161383-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625054005.0003.nflog-510@kernel.org>
References: <20260625054005.0003.nflog-510@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:alexevgmart@gmail.com,m:bestswngs@gmail.com,m:coreteam@netfilter.org,m:davem@davemloft.net,m:fw@strlen.de,m:gregkh@linuxfoundation.org,m:kaber@trash.net,m:kadlec@netfilter.org,m:kuba@kernel.org,m:kuznet@ms2.inr.ac.ru,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel,m:pablo@netfilter.org,m:stable@vger.kernel.org,m:xmei5@asu.edu,m:yoshfuji@linux-ipv6.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,davemloft.net,strlen.de,linuxfoundation.org,trash.net,kernel.org,ms2.inr.ac.ru,vger.kernel.org,vger.kernel,asu.edu,linux-ipv6.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302045-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 948436C78CA

From: Xiang Mei <xmei5@asu.edu>

commit a84b6fedbc97078788be78dbdd7517d143ad1a77 upstream.

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
 net/ipv4/netfilter/nf_log_ipv4.c | 4 ++--
 net/ipv6/netfilter/nf_log_ipv6.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
 
diff --git a/net/ipv6/netfilter/nf_log_ipv6.c b/net/ipv6/netfilter/nf_log_ipv6.c
index 8210ff34ed9b..cc724870a467 100644
--- a/net/ipv6/netfilter/nf_log_ipv6.c
+++ b/net/ipv6/netfilter/nf_log_ipv6.c
@@ -309,8 +309,8 @@ static void dump_ipv6_mac_header(struct nf_log_buf *m,
 
 fallback:
 	nf_log_buf_add(m, "MAC=");
-	if (dev->hard_header_len &&
-	    skb->mac_header != skb->network_header) {
+	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
+	    skb_mac_header_len(skb) != 0) {
 		const unsigned char *p = skb_mac_header(skb);
 		unsigned int len = dev->hard_header_len;
 		unsigned int i;
-- 
2.43.0


