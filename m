Return-Path: <netdev+bounces-284006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PQoKQTr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:52:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2167F4C2C41
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D41CA300D624
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF93E6DC9;
	Mon,  4 May 2026 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="LY6QWqRm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1EC3DE454
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920768; cv=none; b=AoFZOFyGoWwrDtBLryGZInMiqZSuuJDXpHzOF2q84sSU3QtDOGrWcjBkqdV30chmDtEo6bjNI/doJj4um1TvcylK96mU0YNxLqJ5DmnAyKB8X0h0VskiYhpM2SX3lvoqxzv8WauppH3zQqUzh4iFmZiiCB6YGnanYCTsqEGEDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920768; c=relaxed/simple;
	bh=4aj9iecjHicjVhsDK7tsQ2RIPQ3msYan9b2Z5jYT4EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/9p5zhefF3EkLwu7ViJUyqlu3N+d1Qz8WGBQ3UDbsWFijQR9ZdcAz+V71pB+i5wj3yxtsuiqJMLMqQ2QqnsngX9j39Bd+7acTTnYTJO+3NgNwvMINOyz17SvDAXaJxbclgzZ2bV3hNYEIDI2sMsHydd37672FlxgkxdBZ9ntb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=LY6QWqRm; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ee1054627bso2980410eec.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920766; x=1778525566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luZzlA3I7UGQtJudJQzGOLTlhlCQMcCk46M66DXSLck=;
        b=LY6QWqRmPIUPEr1C4z384XYe7fpYzu4pw5IVw872NqSY5Vm/pKbB5TL4RaAEQskGNN
         pi1MFhkpr5qscEAhQDEvYDrlvMuedrI6fn1JyPY2Ubb+R6IoexFiBe+SNQZUbuEfeQvU
         tR2sfKaO0tGpjs2XKN3pXO89CZz9YjaRUr6gJA7WkLKG94pC1hUDJnZ/201cGES/osJQ
         bmwCP5wNbDU54Rd2VAQatCQ8TbHQjaL+wwX9Mx5kxcz009vaGxnehFRnvN7iMnb8fXeJ
         BraI7GXV/JNJMGI+dcdramfLx/J3KE2TfFPhlWjOeT0feR+I1PgLjR716Er/m8Tp63+q
         jHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920766; x=1778525566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=luZzlA3I7UGQtJudJQzGOLTlhlCQMcCk46M66DXSLck=;
        b=GR6nEjB8NJCWPj5C80jMqh0hZaI7KQ7PuCN8vAEI1bYf/NMfKiCpvmnW9tdh0i/sUL
         X2edCRjB7d2H5iNdR4ZRAbuLxMNZF9katyy+H69OlCXt4c6uXHg8r0j4c/6CbgJyAD44
         S6Smh7bxKgJwrpGenlbOTgoxcKs0OZv35Nsans6hW09Gx9hT85a32NVovTSxc7jLvpWs
         mrkri+r9UlL+7KSolBauPtCfAOngTWx35P6EW/u0GgY6X4Xk78QkhQIOmmG+8ErugFvd
         BlgB7nYpo0pUxwSbNlU/MPztDRvTOwiNMbSM6HGK28LkvgpbPutnja7S4wtVc9ja1hOM
         Otzw==
X-Forwarded-Encrypted: i=1; AFNElJ8TG50P5HGJjBwkrBU/wpc4E1yt4c/0eexXDgG5aRUWOiYWJRtMsCCmUCGBwz0x6NrGXfO/ass=@vger.kernel.org
X-Gm-Message-State: AOJu0YxekertzNE4y8ibcDdcrTg87Uo4UiVtUP7IuARzJjJ+Qfe4cxov
	G7ypEk3V+jq4GMqy5LcVymk2s14pWU6zk/fufRH4JguDdEMXFgZeNiRE/Gpe+TtYPw==
X-Gm-Gg: AeBDietuUyFJIG10bRrnsFKDm9PDGDSgONyUPEyBX5Y2AiVAQNqTn8fysMbBlvQQecA
	SbO9FlQJY7PkKqLqhNFcVxcXYouZ4AmTefzQLaaMwQKjGjeS4Q5w4oZ5WE7DWLQ/ixfo6wx3t7t
	umfElyYlmplo7mOgl2otR/FzH47kdgSDt9VrfSJp1uDVjSFd488dD2Dz9aaPHFsGEC3ed6+oNvj
	3x/SsETXhwMZKw6JONPBoiIJiBXquq/6W0I8MxfVVgKAABzhlmG4XiaWDAG4wsWJJeDiGEzUSKW
	pEcsUJFAxUKG8aCCufjng6duZYFgOQls40BIJA0IWriBPGgCDof9vNYbjEnD19WjgH5lqvUSDI4
	XZYsJ80LCe2PxyjrWvtZW54clAKAVccmNsBJiZ0II6/F/7E5E/5RglSr6e/YMv+HBNWAKxlmxMv
	1TOoLUsXPC3+Lp/PhRN3broCSX2uJdHwaTydRn1ENWlvHK3G/VmJHhaNQNAFw8tGChi6FPnngJ
X-Received: by 2002:a05:7301:7c12:b0:2d1:9b35:4edb with SMTP id 5a478bee46e88-2f3cb70f4a0mr422797eec.0.1777920766405;
        Mon, 04 May 2026 11:52:46 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:52:45 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v10 01/10] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Mon,  4 May 2026 11:51:13 -0700
Message-ID: <20260504185122.50642-2-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2167F4C2C41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284006-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdpnet.ai:mid,herbertland.com:dkim,herbertland.com:email]

From: Tom Herbert <tom@herbertland.com>

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
index 03cbce842c1a..64e85189489c 100644
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
@@ -1045,7 +1046,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct net *net = dev_net(skb->dev);
-	int extlen;
+	int extlen, max_opts_cnt;
 
 	/*
 	 * skb_network_header(skb) is equal to skb->data, and
@@ -1053,7 +1054,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
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
@@ -1066,8 +1069,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
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


