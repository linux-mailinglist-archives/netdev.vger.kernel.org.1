Return-Path: <netdev+bounces-198679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393DADD050
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC3716CFE6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603A2C0334;
	Tue, 17 Jun 2025 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp99VU78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DF0225408
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171374; cv=none; b=Vj6eRkEDgY3zh0AiFIZHhtSX1547ltvuKCpA0rsrwS9XFKNR7HtKyjC6JbYaRtnGZa7nEvXHupS52+7UwRUwNVtS1uCTerVRgQ5XDPHg9F/rasEGD7HS4U0WplsxBtRIk5qI78/J9M9i3DIlODtz+f0iWZIIB9eCfhhwipny6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171374; c=relaxed/simple;
	bh=ZWyQbFO8gA8CHI+AZP4vyS0eXjG3Y9F/wz8tXlL7TS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlEGpzVDT5/jBO0lFIqx44Yz7cbj5QuDiAoThtCWP+vKjL24gUqw+h0L/YWP6mN6Q7JdaeiJNkLKEJvL54TXmorhXoRwlvQzFKNoOV9r1NoECtrnNFBHz2Y3+GvxkTM0wsZH7MLZK65XmsYQbr5ZOloQVNLa0phxECy6fe2c9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp99VU78; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso10482947a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171371; x=1750776171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTT3Ay00bDOtenXE3QfyywLQbD/l+TjoQozDgTvCei4=;
        b=Yp99VU78PW9/azpfdyozN/HRmZpOwEP8iBQgyhVqNMzrtbyNULTOCj9p4W9zNL8lkw
         njNRcTpsbg9wmQ39gFeUuNtl6vvIv2dmxP8D8sURaWGY04HPu5JatwS0Z9OJNA0P0qwQ
         V+n5o85u6XQ96ccl4Kbx7xdElbWX3tU0NpCQy0l+ywdgRx/cSb/26fbnzehbgjje+sPM
         XGmOWjIsZE5KbcEcJkG5y6hj0aK8ZK2cHo9OaXULCZi+JsuKLqsa9knOAvzfyJGaCIQ8
         iuz6Daus0YVWQKA2uJOeEKiSFuoakf9BRbCnQ7/Nfs17nxUdR6jcAN40stjp+wrhJvZk
         ATqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171371; x=1750776171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTT3Ay00bDOtenXE3QfyywLQbD/l+TjoQozDgTvCei4=;
        b=USXzFKHDK2FG6OypYhVV3cCkoFi0a0WezIrLI1rrM0lmr2lnvprDpK51vQwSuEQX2h
         vHbC0auLt8rhhgTGsDxbSKaJ+cSxJWJcqQgs7IlWQ9FiZcNTHbMssFfInWTdb5I7v+K0
         FrnG+wvgoeOSeOSI3bkiNfjfxM0jORguDPVdEIJrlgg0ZpsGQDAkHIUeFgqPk/WtX4XW
         djYG96IaC0I3/ckPabc4XhkUwMN3Sfl79dWVov1ty4Rxtfsx/isaMyf9CJFnoqipAHD3
         e3bH6f8LdnUbFOZ/AyIiumRybpKV158zVYI8Uc7CJKYcYa/tMuH7lCXd4WT48EfJobN7
         Xdfg==
X-Gm-Message-State: AOJu0Yz7XQ4Kf5/UFy7fi8kM1jtX9b1xIZcb4frawjpc788tjxXbZyPy
	QUUOXaaUawtc15KV/tUyPPk0WjUkb149bUjmJjvrYTFgfB7jrw7eAyx0
X-Gm-Gg: ASbGnctR7zE7FYKWv7hxY6nsrzRyWZFJkvjkwFjuY0R5CW16xAIKye8KN7n5v4ADOmu
	M8BJPNox1DSUmx0GG71paRuHES7lLTkIO1NDV24adYOaCcPlc6TKhysrdsek9QO7Oo1rfeqa0F9
	y4+brHSvdUgDpiC37xoPPWIVLFRe0QI3F8suw4tPIPLaP2Ymbki02gd4QPf2CZiyRfO4UWXRjGM
	s7urx+cCtYIBQ/gtor7pGHiljovL27ofiU6B78IR21fKh0cm4Ty8p33x8Cq1GDblegE3oVfnysH
	1zZyLt0Cq9bvlbSkvROCs1QFGenQ1t1SPjYjgiXkwRQB/yKoiZoUE8bL4B9N4X5oHnfeDCd17vx
	R9HOCWgx0MHu8
X-Google-Smtp-Source: AGHT+IGtILiW9xllLw7U1/a9B6LhzteLVxUMpDPhlRtGxdUr2TrNhwyOr/lcE6YAE5HJt+a3MoPDkg==
X-Received: by 2002:a17:907:6089:b0:adb:14f3:234 with SMTP id a640c23a62f3a-adfad2a1e83mr1135541666b.8.1750171370364;
        Tue, 17 Jun 2025 07:42:50 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec8158be5sm877215766b.8.2025.06.17.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:49 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 11/17] net/ipv6: Remove HBH helpers
Date: Tue, 17 Jun 2025 16:40:10 +0200
Message-ID: <20250617144017.82931-12-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.49.0


