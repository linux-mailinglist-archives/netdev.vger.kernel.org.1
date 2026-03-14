Return-Path: <netdev+bounces-267786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CHjKGyetWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:44:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 950C028E2C1
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 904203009E1A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175FC27FB0E;
	Sat, 14 Mar 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="CBZmDzC4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B91B4223
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510245; cv=none; b=d9nGiovpoPN69QG9IAq8VDpvnnfAjGbSJzkgWuXSKDownwdBGLH6l554ByFFppbVqZ8tvvyf8MtzD7znoG76ef1MsD6ePiYcYTvi6uWQeg4nTouOqYdLy6kd8Y77CvL7BH0LH1RKnhnfDVXe1xRHfEWiiG4pGNQ4LLeyX3BYO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510245; c=relaxed/simple;
	bh=4LbmtBHzYALFvFQ0U8udb0Ivx9LX4bQHl0xdPpINKzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ0JZiEpgFbL6uZtAawSOQ6M/dhTfRMOvOgs0PgquBnKl3etxOLaT3Z8p+naZvD/yUs3vT8i0sKSsgBjVkq9gtAcYG51iblKPaLst0+5jmDJet7nDw74PsL27QPbbsJcHLocu2L86pTJipPQzL+VMsVY15A5yPPBTnoKEfmW11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=CBZmDzC4; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128d7db88b9so3794191c88.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510243; x=1774115043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzvVEYWtLc/GZAPL9MwPdTmnjc7MZE3YaxWzSwgtNE0=;
        b=CBZmDzC45K0RXbenTZKcq8vhkP8UZx6rCIf5uhF3DE5hO5FmfBMk1jFYVgsCLQSam3
         72en1PhKBElzGTuNKEjANBoLtSJW3GoGJVJAfCFkAyXpOG1U5gqpGjUE6QQu0TQ4+H7H
         2XX62MJjyYI4zVtXRdVxB4cMG9XNZSKR7T6J5Lwa5993IVB7xwzW5sy2aVy4oP6YQOs9
         tIsuLc5gfEHzBo/WwfsvFL23juyG+WLH/FEK3+AXiqMAE4gcp9/uHA6eYr22h+IemnZu
         Sb3cniR5BV0ao3+UJhWRK4jjHe4HH2Z2wV4KvXtx9DNx47CD8u5Ir/J3sih4C2rwjng2
         BNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510243; x=1774115043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzvVEYWtLc/GZAPL9MwPdTmnjc7MZE3YaxWzSwgtNE0=;
        b=fXCC7ueHtU9K0QaXj1zfDersp4ZCvhRcPuZOxpb66KOBlNu33k2sK7DbtL0WdgqEt2
         +RfnCmOEW+PAeFjuT0jBNkdq3stVHEeaIem7D90Y8DsZEzaeOHFrR7W+jvk5bKiqRXWZ
         TEJ6W46pJmoFP7p2oOpdQ/SmI3H1X991gYVll8LO7z0SPtmVCm5ntapE/SgYa6SgXOeB
         n0VLX26sOFnWgoSGD46HJxjkkmTkhbA01pLDXCwubijiTMQDuSkmTNAVlel1+5icl/qM
         BYGANUHroc7hO3k18ScQGvAXrgjn1H0Gqgqgn7LAPP/Cdt21ms7j3kuEGPNONkL9kEUG
         P4uA==
X-Forwarded-Encrypted: i=1; AJvYcCVRMnvR80JZQof3dr3lSI6aky/LWfKxekgjmpeUEZF2RcqioLLUbrCz6pPJ+YEexgynoqda5SY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OPTs192CS/elkNhxykrFpL4y6+Zl4whMhGiUHG70TGEsqswY
	bFSGFYVUCJoR3iO0IcrZFL2F51ScjVFCdMr0r8ESXO00QAQcHoTZo69imzf1Biae4Q==
X-Gm-Gg: ATEYQzxOLdJNDuwxCOdbUUOC/Iw6zMy5tnmuVzefh1uKdVGUDmtOn9bmDDENbgZJPiB
	3IQsfcto+9dJsarHO5asMrXgZ2hq90yM4qH6DIyUlTvftwhZV4TyHzH+79vWWMAiuiSzlHnCYBZ
	v3w/nU/hfl+3/0YdzEMAi7RdnHuETF0XvYF5H6v598gJ6yv3Fli3fKlzY045F9MlJn9w79yhTog
	lT4apc9m70ryK0sza2j7HkPmx8cjD5D9GRaiZuu8GvM51UpCnT/mXbNzg5fC3rldyo4YdvTe4Ox
	qhMdN8ijLJV2RdJmDTJpf4heYb8nKMX0Ox4OvLzC3UM5BLF+MXIIK75Et5rrLN3ID2m3nyM1AkA
	6THhbT3F3vikU3rL8ta5OL3V4HJKDdPi836mfZ8EHmGIxUI93GTkB3/hoCv84Tn/4BnCab2j8I2
	zvvemp0rKASCyY4tML9UQIlIF9VpJa8d+lnVGp4qIM//pUUcC54DrUDyDkbNFk+0G2ze9bbdROp
	rPNmFJs
X-Received: by 2002:a05:7022:672b:b0:128:ceac:6da6 with SMTP id a92af1059eb24-128f3dd34b0mr3396330c88.30.1773510242941;
        Sat, 14 Mar 2026 10:44:02 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:44:02 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [net-next v8 01/10] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Sat, 14 Mar 2026 10:43:24 -0700
Message-ID: <20260314174333.46406-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314174333.46406-1-tom@herbertland.com>
References: <20260314174333.46406-1-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267786-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,herbertland.com:mid]
X-Rspamd-Queue-Id: 950C028E2C1
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


