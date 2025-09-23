Return-Path: <netdev+bounces-225614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E985B9613E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E65440A56
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2331EE7B7;
	Tue, 23 Sep 2025 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jesQfeOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88F1F2C45
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635300; cv=none; b=Qshg5kMkZo4+1585I6OMuy/D5kw8f8O5niB+m2UlnVDTsQUMTE5QI6mQ199WCBaHmBt+bALWGjHFSkAQUvzgbE0JpLfwh+jNx16eSbejNChiLpZkBbdQcDR0a//a3rSmZAE7T8KTUplRwFqlxgUbjX+PhPAyTTvhIsxyGKXv5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635300; c=relaxed/simple;
	bh=Dea489MYTgMAAscr01Jb3XXM7CWCWJwmT03WT5H3Udw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMuV5EBibuBHM2QvUzVihoiDu2n9CIYAXp6zlerbmHmKcwywueiR3Xb6TpleWTcar5eIB8pScamrT9eJgBmyW8A1mvYR8E/0uhvRFDGsapCZzuVZSg1sI4+Z7nKCbWHAXfiZtjY+WKsXeetvCLGo8iBEXqAu/+VRd9BFuxu8JcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jesQfeOt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46b303f755aso27818865e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635297; x=1759240097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wZCaQ07xtjMvB/PaXsZVCEB7E5r60D1ZTKgnNtEj48=;
        b=jesQfeOtRRMYagBpCev6vytrEzFJAMuaFFMM0eK32ayeLXSAnNy3E5fNCHVvl3Xv3a
         Ws1gj6fEqLAzNUQYQykcq/+/A/aNZN8+lQWnbQvFEUV+Hex+3kEAJC/HZnXqGyKR7oU3
         0SkpPbA4UgJ6e9UJ2at7B7NqjGpcoVEZkIn3A1CYWXcIXb85FedkASBJqE6rUlBEde8N
         ktLoLeq/md4oowaCebOFC+AdXC/wIk5oNuKlXIRRXOLa920DaSCWGNsehR1lp2lJEl/7
         MnM+jQeNX0ZbO0SPaj0dIo/izheTkEQsiiNI23SHnU40oYevsyx4hQ0P0Fk5FHrd0O+k
         YGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635297; x=1759240097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wZCaQ07xtjMvB/PaXsZVCEB7E5r60D1ZTKgnNtEj48=;
        b=rGp9HJ8yNYdcS6uWS2MJeWcQIHc6nSShDG4m8A2LysKZo7xburtXYiUQjZsVUURB2s
         jptABXbCAg/FKpcMxhgnV/5t2Jmq3i+nhE6dKoEiCI42zFAnWBUHRURZJaQmoxs9JSSZ
         sbj4oSFxMiglgpXYDHp7V9qs4nRRJCGVbDS8CW4Qhwe+etp9ryHY93eRgmKmYGtuJ9Yz
         OzEkXbvWlSc4xI2h5qhO8epZDCUGEwU4z688koIfnuByvGdRoy3lt3anldI05GK5m2LO
         jr893m7127J0rC5TkzOL4ICLTJIsFcfZt25z4gQF6nNzrmRHUEGrddtqeJDAo/DcQe4g
         xqWg==
X-Gm-Message-State: AOJu0YwEKA+qNXot6o3/xMTy9kkGO7+Ril+Vht1XfCVs0SIjAcM3OYYn
	oEx6U3c6x1xLMbh/9rAuR8bRlOJ23NSU4GtJBz6uCz2m+bMVW0ARPlTy
X-Gm-Gg: ASbGncuWD/Jz1/cL5InBFzHYIEhoi3WVz4uowzrMa3IP73yYaPlevruaWxqDN06uZYE
	ZovYOKTe2+9rBTdXVV1ohMWru/P992Y5HJ9trrbAN1LcRX5votmDWBuAtCuDINHqOS8D22qU4nz
	cO6Gv1b1Drl+ltpljtGvFzGzKlFyd8AL5uXoCchfeAnsAWT4SbuEzco9oJZGwek6BMwweJIrcTG
	/XM7r3q/bKSwXnLE8gRB9sXzmWNlUtPu/mzHWfwRfoOpTk+nxEHkbBYHtfEeR/MWbdW2g5bQ3Nv
	rE7Y/9YY70qS5/Dl11OdBFIYZYaQZ85C7TKyDH5K6QY8Tak5kECBHdfnla/o0IBop9xutl0qW2r
	JmJO/WkAKW28J7rJ9E7iY13FahxT6Gq3/Cbeha8dAnhXMksPYRMfNwPPZFik=
X-Google-Smtp-Source: AGHT+IHBWRayhmJ2OSZMIhWxFU0xglzkseuyRBy/OlWAEkv7f5IDCROXarkD9Maag2qO09JkWdwLrg==
X-Received: by 2002:a5d:608f:0:b0:408:9c48:e26c with SMTP id ffacd0b85a97d-4089c48e2f5mr197113f8f.62.1758635296895;
        Tue, 23 Sep 2025 06:48:16 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbffaeasm24119282f8f.62.2025.09.23.06.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:16 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 11/17] net/ipv6: Remove HBH helpers
Date: Tue, 23 Sep 2025 16:47:36 +0300
Message-ID: <20250923134742.1399800-12-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

Now that the HBH jumbo helpers are not used by any driver or GSO, remove
them altogether.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 include/net/ipv6.h | 77 ----------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 38b332f3028e..da42a5e5216f 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -149,17 +149,6 @@ struct frag_hdr {
 	__be32	identification;
 };
 
-/*
- * Jumbo payload option, as described in RFC 2675 2.
- */
-struct hop_jumbo_hdr {
-	u8	nexthdr;
-	u8	hdrlen;
-	u8	tlv_type;	/* IPV6_TLV_JUMBO, 0xC2 */
-	u8	tlv_len;	/* 4 */
-	__be32	jumbo_payload_len;
-};
-
 #define	IP6_MF		0x0001
 #define	IP6_OFFSET	0xFFF8
 
@@ -462,72 +451,6 @@ bool ipv6_opt_accepted(const struct sock *sk, const struct sk_buff *skb,
 struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 					   struct ipv6_txoptions *opt);
 
-/* This helper is specialized for BIG TCP needs.
- * It assumes the hop_jumbo_hdr will immediately follow the IPV6 header.
- * It assumes headers are already in skb->head.
- * Returns: 0, or IPPROTO_TCP if a BIG TCP packet is there.
- */
-static inline int ipv6_has_hopopt_jumbo(const struct sk_buff *skb)
-{
-	const struct hop_jumbo_hdr *jhdr;
-	const struct ipv6hdr *nhdr;
-
-	if (likely(skb->len <= GRO_LEGACY_MAX_SIZE))
-		return 0;
-
-	if (skb->protocol != htons(ETH_P_IPV6))
-		return 0;
-
-	if (skb_network_offset(skb) +
-	    sizeof(struct ipv6hdr) +
-	    sizeof(struct hop_jumbo_hdr) > skb_headlen(skb))
-		return 0;
-
-	nhdr = ipv6_hdr(skb);
-
-	if (nhdr->nexthdr != NEXTHDR_HOP)
-		return 0;
-
-	jhdr = (const struct hop_jumbo_hdr *) (nhdr + 1);
-	if (jhdr->tlv_type != IPV6_TLV_JUMBO || jhdr->hdrlen != 0 ||
-	    jhdr->nexthdr != IPPROTO_TCP)
-		return 0;
-	return jhdr->nexthdr;
-}
-
-/* Return 0 if HBH header is successfully removed
- * Or if HBH removal is unnecessary (packet is not big TCP)
- * Return error to indicate dropping the packet
- */
-static inline int ipv6_hopopt_jumbo_remove(struct sk_buff *skb)
-{
-	const int hophdr_len = sizeof(struct hop_jumbo_hdr);
-	int nexthdr = ipv6_has_hopopt_jumbo(skb);
-	struct ipv6hdr *h6;
-
-	if (!nexthdr)
-		return 0;
-
-	if (skb_cow_head(skb, 0))
-		return -1;
-
-	/* Remove the HBH header.
-	 * Layout: [Ethernet header][IPv6 header][HBH][L4 Header]
-	 */
-	memmove(skb_mac_header(skb) + hophdr_len, skb_mac_header(skb),
-		skb_network_header(skb) - skb_mac_header(skb) +
-		sizeof(struct ipv6hdr));
-
-	__skb_pull(skb, hophdr_len);
-	skb->network_header += hophdr_len;
-	skb->mac_header += hophdr_len;
-
-	h6 = ipv6_hdr(skb);
-	h6->nexthdr = nexthdr;
-
-	return 0;
-}
-
 static inline bool ipv6_accept_ra(const struct inet6_dev *idev)
 {
 	s32 accept_ra = READ_ONCE(idev->cnf.accept_ra);
-- 
2.50.1


