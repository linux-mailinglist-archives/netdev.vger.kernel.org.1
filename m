Return-Path: <netdev+bounces-267802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB/fMC6gtWn42gAAu9opvQ
	(envelope-from <netdev+bounces-267802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:51:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6228E369
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CB023010B4B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9B431E83F;
	Sat, 14 Mar 2026 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="YDbVPoIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A712D1F1
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510699; cv=none; b=egEmSVWDd7gZ7WhcSt7OiUASreerKrzUUFETrnog5QWxojcqsaK3mKsj0BhoiyCaT9DQ/4C8yh9NnuJDb2unFKxfE0GALnnr7WLpQ8BJafX43ifOFz2l2G5mqPn0eVfeT9AJytqQf9YvYWeDtTxQ0PDoRPEE3bwnT+NNSO/UM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510699; c=relaxed/simple;
	bh=4LbmtBHzYALFvFQ0U8udb0Ivx9LX4bQHl0xdPpINKzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9gqplxcwxhrgrR3P/2V2ZvY4kQRMvScRaqLrDdoHKF9NpzL2OHWcP8amVmwhL4HQMKBN/ljeUOjIwjsHKBX7wmTV+otzPxKD+r6mkUuUhcC4EfWUHxR7pQzz60bTxT0VYfwmM7HzZQWEL/yZoa6YXc6F3xwJGo0AxG7rvA+OIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=YDbVPoIx; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12776bebe9fso2449512c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510698; x=1774115498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzvVEYWtLc/GZAPL9MwPdTmnjc7MZE3YaxWzSwgtNE0=;
        b=YDbVPoIxw1Dotj51Z+3aRD9Ps0OdSLEqElLtxQdaF8t2o1N85hFDlAbXaP8xIaSZWG
         cwNtsIa2jW2BuemMnAICxR+xLSjo1eBJExejp+GUcX26uiadzvMDzUGmwJpY3QZqp03f
         L8ZOFK2eBTtWFPAymGVJnzs1fWSBqtwsWdg3/bPYPurN9eCYSVO/Q/eUPdXBH9REq4ZE
         tsiSNqmGDAP0Gr4MS3z92HRmUkandRULS4PAYNcqWbxhn1BmV7tqFf5AZ78k+RW++B5D
         bNl4MWswtuSi3ralirnU1St5IfXp3GhWYmdfTRta0As0QHfpTjr6WV7BTg0X4jEBeh2S
         2X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510698; x=1774115498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzvVEYWtLc/GZAPL9MwPdTmnjc7MZE3YaxWzSwgtNE0=;
        b=no3r0/2NeuxKoZ2EidyVY6h+/NYfb2VQQZiRpvOUmLL9X/TQy5qchbddAiCjZPrlSK
         pKRWHzp4W1AbJD8a2FlQshSJsmgnhmVVqBTFDkIC9Fci7/eZ05RcvlBDqtplt9zPZsSx
         aF0jFkbCdYHqiyEbdU934ElGpx2pVLUT97vWsbSA03si4dJOaog8MqFf8CYZU7Uztz1c
         3C/Fv0QvEvjUnnYGsElCDhgI1KNE6yw/cTYIhJZi+Kg9fY3o+Yg4SI+1362kE8VtV2Si
         HKsrrZx21d/YinGGcAkK1Mvk/6U6auaco5y34+7UjSowXbXMTncEgOotC66ZAGDisQpa
         90kg==
X-Forwarded-Encrypted: i=1; AJvYcCX8sipkAMclSnXMAxFmheN/NMdyQdfAI4onyz7q7lfHuWePNEIvhPNqEqxBubVZvqAM8b3Pw28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwWpTepdUGWGqLgOXIFwRv/Zb53ZTCy1AlIvgF5w9sObWLz/s
	S+fRcEEvFuqLTgQFELffZnESxv+oRz1QPXuyvOZ5N+vido6ZSdt7wixVmQaC/jFn9/I+OQ3qUBT
	v4mY=
X-Gm-Gg: ATEYQzy5bJYyIVFLTKukvj4R+lYE0blcBz0guPFTxVWg9B7il8NHhQ4sFdbmcOguFsd
	zaDmVpXXiqckaZOpBG0olXz2bH8bhvR1aY8cgjYtpoTyswMqlS537AmVh8h4fl5vvPxTG6vWAgd
	04T32m2Anz++7Nm0PWBnYR69ih5cPcn8rOsyw4T8On25XekZuXe8bjrjThO+jKyvAOtuowo/O1h
	mBFABgak4/aiIFShJccs74x9kpgqLZ0VbfH5+hT5Vuh9x0yRPZfk3GtGQ02p2UYCgWAOMwfxLWx
	agt/VWRt5TpoYc7worRJ68xjCw3Pv8smCIDRdi5d2XBcYJlVi4a141WA0fUNgVbLyPsoNXc5BJi
	i1tk3kPCiB7Y2wuhSD8MsT3oHtczfU00PzYzVrDe94Ji/BodGrmiagZ0Qu5Iz/Jsy+FfxcJZCnl
	vaOm7dSadKqb7DkLYuW9DSkUS5braAMJXYEuI+faxkO7u3bI8pGBVxlUOvsYxrRcDQH57Iog==
X-Received: by 2002:a05:7022:51b:b0:128:d6ed:e898 with SMTP id a92af1059eb24-128f3e18a6dmr3692159c88.29.1773510697670;
        Sat, 14 Mar 2026 10:51:37 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384f6csm5917206c88.9.2026.03.14.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:51:37 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v9 01/10] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Sat, 14 Mar 2026 10:51:15 -0700
Message-ID: <20260314175124.47010-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314175124.47010-1-tom@herbertland.com>
References: <20260314175124.47010-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267802-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:dkim,herbertland.com:email,herbertland.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72C6228E369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In IPv6 Destination options processing function check if
net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If it is zero then
drop the packet since Destination Options processing is disabled.

Similarly, in IPv6 hop-by-hop options processing function check if
net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If it is zero then
drop the packet since Hop-by-Hop Options processing is disabled.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/exthdrs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 5e3610a926cf..113efbc19abe 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -301,9 +301,11 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 #endif
 	struct dst_entry *dst = skb_dst(skb);
 	struct net *net = dev_net(skb->dev);
-	int extlen;
+	int extlen, max_opts_cnt;
 
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
+	max_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt);
+	if (!max_opts_cnt ||
+	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
@@ -322,8 +324,7 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	dstbuf = opt->dst1;
 #endif
 
-	if (ip6_parse_tlv(false, skb,
-			  READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt))) {
+	if (ip6_parse_tlv(false, skb, max_opts_cnt)) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 #if IS_ENABLED(CONFIG_IPV6_MIP6)
@@ -1038,7 +1039,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct net *net = dev_net(skb->dev);
-	int extlen;
+	int extlen, max_opts_cnt;
 
 	/*
 	 * skb_network_header(skb) is equal to skb->data, and
@@ -1046,7 +1047,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 	 * sizeof(struct ipv6hdr) by definition of
 	 * hop-by-hop options.
 	 */
-	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
+	max_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt);
+	if (!max_opts_cnt ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
 	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 fail_and_free:
@@ -1059,8 +1062,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 		goto fail_and_free;
 
 	opt->flags |= IP6SKB_HOPBYHOP;
-	if (ip6_parse_tlv(true, skb,
-			  READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt))) {
+	if (ip6_parse_tlv(true, skb, max_opts_cnt)) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 		opt->nhoff = sizeof(struct ipv6hdr);
-- 
2.43.0


