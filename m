Return-Path: <netdev+bounces-253580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F6cOE7Fd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A6F8CC30
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F61D3013A79
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD0B24C076;
	Mon, 26 Jan 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Y9mK/1Mh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E322848BE
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456922; cv=none; b=ooq96Y1vyYMyDXU+stV47n3kVnsQQEU11BWUfahHma6gavWIum6RFiD2Ef9Xs1KpOtHF6153kt6mttzkjlV1exlH/7zzzXquoEU0Xb8J0sz/jioISnorKd92C5l/o8hdPV1gPDMYnyK8B7BjwBEkoERe9jDLV16CSaJO94mJIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456922; c=relaxed/simple;
	bh=ZO2DlK0gG6HeTzTlKYYiTtr+d1PQpnvz3+0huwsvOO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYhT8LJOryPr+cSu/Ik0lOR/K6bXm2Wu266yZ0oalzXSMisCE+EwPtgXYQJXHtbF5TISvu2sbaAbNrDIHii27m9xf5FDZQc7zo1D5oubgIRT+aBijN8oXI22XUTI2QYhjtileeVEwFwHAnTySfS6AcIYOutRwXRlEtqwcFoisvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Y9mK/1Mh; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1249b9f5703so712424c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456920; x=1770061720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO5ziOuB+Mt0loslW5tH21Z/PnhizP1Tteanz3pk5vE=;
        b=Y9mK/1Mhgrnt6hQxxWfph3L+sWjCMhOVnZFbHxNOJm0/ziT9WcRUej2fDUZ1tFFgwe
         Pkw4ZyRqEJfIghTvo3xnQb9uAjW02zNnGdhx7/vjBqXCkwY2DfwfYlPcNSpm79XUvQaj
         GMr2NmOjxiMnNwGSMZ33cz2mGNoWE9dIqG/Nyy2ZGR+jbRo0yhoEVVENrSvF8xhrnvmE
         JNgfVe18sPXUPY0rQ242omUozX7z8M4vwuhm7RFsgKhEY/GVUr5z+lsPVhDjQvLj87Qn
         SbxwvwIiEta0HlYo1LADEiZ7kmxmfBMiuxbTSJ2nJ9ktV0XmQMD4F1k8HCgdmIFDP//O
         6Uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456920; x=1770061720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dO5ziOuB+Mt0loslW5tH21Z/PnhizP1Tteanz3pk5vE=;
        b=VfjcQbmqPy5UwBNaxeSaHoeql6qyNkXcBm+djXv2O1fjSh0Iutwgv8nPfHCnq5GFQ8
         /qGRFEEWVAMBj9shEHcwAgs2Z8b7kWFPMZu3ID/20GORrvunA2fKjHRjHlHFo6czqDhJ
         fvqc4PPWimljXSVmy/IShXb0KL5VsD1WU31W4dqkVetxdhJuoWMbeCSdttTBqpVzWfip
         PBL0jFpPJiY2ruBiwinrFwbPeW0HKBuGmIsftuDCg8tbbGqIZq4/hWU5jBkkcN+6jVX7
         lJDRfSK/nWh1/jJ7GZ6bBFqqnPaGL12NAMGR+woN2n+9Jd+bwiOndxqlDaMdS9zlklRA
         bdsA==
X-Forwarded-Encrypted: i=1; AJvYcCUrjdvvPZkIW65SB2bNfuJFJ/wr479tZjQJeNRJiiDB1B0s6yzPAnj/+Y9zQeTmgWc4a6EekVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKqU9L6Hsuo2IwyLCyQNi0eEc62Rbiuhqtod5HmROMuMMyzeK
	EEna3lN2zBlhquae+0VYsex2YamGmd9x5UDR++jTVtq3IhPt0aslGKKRquxI23jfdJ4DLMEmY0Q
	dCgg=
X-Gm-Gg: AZuq6aKsZgqwcSlMhX4X9BIJNpQayUBc0zYjaoaeWTz04vA14F2bKLFCIXbPFJ7cCZk
	1K6vEbO8sUkvBrXC48go8Y++3sgwoK+9ACUtJ3mwZUHrNs0DxrIBrABDm7cNArS6WFPfPmDnDZm
	JEeLB4Iqemvwkgq9xkMIUd8E+86/KkSgIm7ab5aj/Eu2i44HpMFgQl0pobQhqmh2aO53Q3YOT0U
	bKSvPWe25eouaJUWQcFwkBBbYMUSW4vDBu+fXTMUOe150P8qxi4q6OeU9tdieO1nEMVudx4Kv3J
	paZLvpanCTp2WkBDDQB1Td75YBhkimEVbdWrIuZqzAYDRI+IJ4JgMZQuNaI1FfVCWy3/lOXs/bp
	9/KwN/dpNyoWJFsWhA0SspyjQKNTubBcNyKpMc+yB8P/LWG19w/xoNPrdQzvDVrlAVRFfSmD5OY
	VeJfiB2fB+lW8tmHqGY/LV26Km8F4QN8Y/JIsL7jfxD18VAXxlz55Y3nk=
X-Received: by 2002:a05:7022:e21:b0:119:e569:f62e with SMTP id a92af1059eb24-1248ec730d0mr2710281c88.39.1769456920372;
        Mon, 26 Jan 2026 11:48:40 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:1485:5851:22a:4c2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d99804asm21121295c88.12.2026.01.26.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:48:39 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v5 1/7] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Mon, 26 Jan 2026 11:48:20 -0800
Message-ID: <20260126194826.236075-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126194826.236075-1-tom@herbertland.com>
References: <20260126194826.236075-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253580-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40A6F8CC30
X-Rspamd-Action: no action

In IPv6 Destination options processing function check if
net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If it is zero then
drop the packet since Destination Options processing is disabled.

Similarly, in IPv6 hop-by-hop options processing function check if
net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If it is zero then
drop the packet since Hop-by-Hop Options processing is disabled.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 net/ipv6/exthdrs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 54088fa0c09d..b9d186784b96 100644
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


