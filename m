Return-Path: <netdev+bounces-256859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPfSBSvOg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:54:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E0ED1CE
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951373032764
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254938F23B;
	Wed,  4 Feb 2026 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="BchI3Ei5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724C393DD2
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245582; cv=none; b=nxrdQEjj4EUAQFsZGLAoO4tLxGXNZYhq83kwgCD+5UtaiP0BCeMmY1b6AmSOocZWjCr0Wh3of5V03BZFSTME0kVX6lmZMK07T2AOOp9Cn1L1uJ6jEXhgHGQgi9yllc6XmYUaZCIhlvYcG1Ce7npmNcRubJ/dWsAfhn4/pDZsbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245582; c=relaxed/simple;
	bh=Vq6xRGyTpH0iEQe09p1CIiRtWu/WfwcPUX4GcS5YWdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aysdYwdhLg9W7nLkkOYzXvC0VtABN+amHRkaLRCvgfV8xHVuEpr4YpP2rh961hZqIo6IxI+UKZGWbMVUCzgEKQbF6a7nprfwutlkCIhkwhnGQs3Oub0tsi4TK2Sx/n0j4CYCPDyqFSgJ4ZW+3SLKb4d4Bh46xYi5ovcMF7RCiec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=BchI3Ei5; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b7da62b487so474988eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770245581; x=1770850381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mY3Mwf3kbUehINVS0Clo/UV9dTKwLOYFhMfajfgBMGI=;
        b=BchI3Ei5IaoELA6mVUemxE1pSa1XNfKBQQGpqmLks2RrGFjA9WRPevfMxljH0CdIsy
         U6daEvgyDB7A8fyGha5niPHdm4grWFGp+8heHhZdfTezM5baIJaadvZDhRptsrzw04B2
         16OyfQrsMzc3AnGjo2p9b76ceuUpiIBLsLEmH/INJngvnKJad6JBF9oCuGU1uundwVQa
         v8ZVwqdWjpqKpPpuHKp86mDIkUfViTasz4baSqCRhnzHZigrZszxV8V3SGLT4B+nZYFf
         51TX/BhYV/Am1PGL/0N9mJK90QHaSFcOTqM4ZysOVUd+EaEk6V4sJTztroBcu5v5dpiX
         pOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245581; x=1770850381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mY3Mwf3kbUehINVS0Clo/UV9dTKwLOYFhMfajfgBMGI=;
        b=woKaNqKQN13KYY6fJeL85sOYko/4BeTfV4/zbRGj23Lcer+zql90fU6zJDfF0Tp09D
         McNE8x+VaLfcP2AxXXd7TaBsKsva5YDqdrzNE8E+nshQaCjwR6vHfL0FBNiNpFSudmlT
         kLwE+ijfhL0ubrZbSRdMzaizWBQkNHVcGtFYziK/S6qHXGe0wWDWHBPZ4jbUSZfskEUx
         a596sV8NbFtf336jGeNf/QJpnY1OJBa+1JdDB0czf4xnkfDMdr6oYXS4nusPP4d+pWEt
         NBVo5sD9ZSGOtUO3D2Qi3HUMO+icVi7198pkb8yuj79GRBknAwYnBi/o3C8MZuS4Ansp
         YXCA==
X-Forwarded-Encrypted: i=1; AJvYcCXsdi+IvShBwLEQAg+2UNCDzLOSMCQu2soRBz5nydYqkI+8s46xxbrlI8ndBtnxbYnfBr3JBpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnWrl3wZ0Wi637k2tWATUC3uJQYCXH47nF9VWtC4wu8IGixjk
	JZuxW/PDiHVdOP4XBvFT6pZy1cRyiwxpYYWEQhTMr6+xqZveVuZofrGdmHyc0wl7zA==
X-Gm-Gg: AZuq6aIwmSH3FTFP0THDvhthnWMtlVXL5wlm1iprFz5RWonHDKe0fi0mGrtMeQFRvPB
	K1HpXuKCs4KevsFVmKLQA8rJprTYVs9lOGBKLQOimohJgXo/GiI0L4wu1Czz+9kIcqT4lVjjjUt
	MAAoaRsPwuwWMVokx1Juy6xsTyF/TYxh3NIU1f6mLMoIdfFFkixsXoo/WiPOlGISVrmVdpSgp45
	/XjVNNAyliqRMwhBjct+KdDUIWxobgjRY1FlBf6iQdRp0NkxaSzdQpp5pn61lS8GWZUv3I+MyPW
	dcPD7pGGopu3VLmcgHHL7kK7p0QnSViOqv5GMF4txsurHXlmuQYM/ZT4jFvUTRMsRbe2XUD+Ojh
	+y9K5InyydvnlOl6pdGUtDHy/8RfFeNW6kEibYP7nu/70JkACgMKB0dR+b52O3zSOz6AgA4Ngtg
	rj4WU87bPg/wP1b+AxuoG26YcaX5zYkoUjpt4w2Z2W9JOnsFr1b7gA367w
X-Received: by 2002:a05:7300:dc08:b0:2b7:3955:f51f with SMTP id 5a478bee46e88-2b8329c531fmr1877241eec.38.1770245581164;
        Wed, 04 Feb 2026 14:53:01 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:5ee7:5720:1d16:9b50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm2587040eec.35.2026.02.04.14.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:53:00 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v7 01/10] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Wed,  4 Feb 2026 14:51:45 -0800
Message-ID: <20260204225154.58245-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204225154.58245-1-tom@herbertland.com>
References: <20260204225154.58245-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256859-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 650E0ED1CE
X-Rspamd-Action: no action

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
index 209fdf1b1aa9..6cc18f35216f 100644
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
@@ -1033,7 +1034,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct net *net = dev_net(skb->dev);
-	int extlen;
+	int extlen, max_opts_cnt;
 
 	/*
 	 * skb_network_header(skb) is equal to skb->data, and
@@ -1041,7 +1042,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
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
@@ -1054,8 +1057,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
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


