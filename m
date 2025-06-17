Return-Path: <netdev+bounces-198680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0981DADD052
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F012516D30F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EFE2EBDD4;
	Tue, 17 Jun 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imCK/LuM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C732EB5DE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171376; cv=none; b=T5gFc+qzXB3A97aqEIHSmQPLODOdlemIt+4IquX77VrzysOxdy8B8m2gNYlGzfEk0JhzxIXbhPaS/sDM6+hyqfw45rfEFAe4QF9/np2YiKmYzbPCzL5PVqh4PB9zCS+Fhg50WLz7L5RHeK53KAkTlLuQ/XFtKfQSIJiRaa4txHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171376; c=relaxed/simple;
	bh=4kIo3C4wDrpQopnK8cuYNw/BbGenrWqXo299gtUESjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W47z3Wn7wwsQoEC19D0MtQ5JErPcBlAhRhfaJiTFLDkO5C6ll32A7qiFpZ3OYEYukV30Hj5qODO9QApGL7PGBAWwukY9qwauzLMERgl+A+GoypIgfbtoIcyHQOZDKCnaPzZdduHdEl6dPTfpU11kSqGDBpNGpmVoCba1lqAGwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imCK/LuM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo11270013a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171372; x=1750776172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7s3G8jmqAg7zY+PV6tHbUH6+ew0+r3hrfddla6aBio=;
        b=imCK/LuMXyhVGq3xC4XAa2iH6l9RCWos+6spZj24K90kAkmpblwYcPBxRCLJcfwipY
         dyV+xfWLPRcaKjtxQRPuys6jt/lteRXNx6PN979/srNVI6FFmmbB5tL6AsKzGjN/6+FK
         ez3PVc1rJFAhKKtMn9Y1CtJuxWTDtRdAD5WS3mkQmVbtxduXjdkBhPeVo+mOt78fi/Xr
         2PBvW/T6MRldmHeweA2xpu4POqYnwbQNQ7z0zuU9mfMbixI41zcFlsX83mJ/Yorb/3p4
         +gm7yLHwjLAHINP6LG3Q/KZV4CR+mMw8W3nm3d6kkN9K9zPkw7bxsMdE8/PDrYIoCVkg
         JMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171372; x=1750776172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7s3G8jmqAg7zY+PV6tHbUH6+ew0+r3hrfddla6aBio=;
        b=YVAHztAC2JO+QVhG66LhJUL4qwpZlnxrNvB5iaf4q/hRAk490rUYWdq2VDw6QJ79ow
         jBT1C8mHiMWVmO4eypvDU4OPohUhtJLZ9E/8PLjWCe7SqOIGGazZiOOn2k8IL9WaHe0R
         USNBGpTTkMcrW8noPWEUZqPTC+bwNT6Y7OIiq5YBQcvvf51suhHu0+uPJnwU5FbV260q
         NzmvE1uECDvZRcmBxWS/EjHnxP0gISPxD/Mnm0vdVKeGptxMpSUVpHjBSim4RVG89QsT
         6/H3bQ7fyq4FT4JbVaz1n3x+Q89eAfAxh6jr7AJDgL5LL0RuYGftTEjmwyDb2sOY3seT
         vv6w==
X-Gm-Message-State: AOJu0Yx2QlTeu/FbStW9sLwI5T7o60T6it6Ds5UNev3AysCvYFz54n32
	Aa3tugJXX4XrDxPX7TzGo3Dnsg21+srEWC8VvYojDUsZNR3a95DUDtrW
X-Gm-Gg: ASbGncsmomPIqE62m9QpTPQBTHp3F9dUc7jGEepxwAPjruRcofD38TmzEmjS1fs2m1b
	7NZbzop8Cb9JglaUpFCIuuM9HJp8FxD7kcG3m7udivo/wwe+r1DQbWIMGbFJtq+E8mnHhhW693D
	fxajoYy5qnSVao3lBJIzZzKV4XFEahEQpewnYxXYKD1REfQnU/fGb+d6ACf7nLOCdVOyQCaPdys
	O1W6EvlJa7L0kiR5ogTxSv2l+anCyTggp3HIdUw/nlw3hNixd5OhDkZlRUdisrcPs1xZ+NPLR2S
	G/RNnG1AB9Rl2kvshqY1EpL7Pzf0uRAUGQuSRSxHHf5RvicyinjWsSsAraCZPtPnfUhAOU3Zr0k
	pqwQWDdUp5v3GavL7hNy6ucY=
X-Google-Smtp-Source: AGHT+IEn+MW0JMAiSr+IwDXyrhUdzx92Mh+T7merdSwvmfLT2w93uXZ6VRm9uAdq4vzHHSF19zvXjA==
X-Received: by 2002:a05:6402:40d3:b0:609:99a7:f051 with SMTP id 4fb4d7f45d1cf-60999a7fb2cmr1576966a12.31.1750171372201;
        Tue, 17 Jun 2025 07:42:52 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-608b4a91dabsm8206469a12.53.2025.06.17.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:51 -0700 (PDT)
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
Subject: [PATCH RFC net-next 12/17] net: Enable BIG TCP with partial GSO
Date: Tue, 17 Jun 2025 16:40:11 +0200
Message-ID: <20250617144017.82931-13-maxim@isovalent.com>
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

skb_segment is called for partial GSO, when netif_needs_gso returns true
in validate_xmit_skb. Partial GSO is needed, for example, when
segmentation of tunneled traffic is offloaded to a NIC that only
supports inner checksum offload.

Currently, skb_segment clamps the segment length to 65534 bytes, because
gso_size == 65535 is a special value GSO_BY_FRAGS, and we don't want
to accidentally assign mss = 65535, as it would fall into the
GSO_BY_FRAGS check further in the function.

This implementation, however, artificially blocks len > 65534, which is
possible since the introduction of BIG TCP. To allow bigger lengths and
avoid resegmentation of BIG TCP packets, store the gso_by_frags flag in
the beginning and don't use a special value of mss for this purpose
after mss was modified.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/core/skbuff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 85fc82f72d26..43b6d638a702 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4696,6 +4696,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
+	bool gso_by_frags = mss == GSO_BY_FRAGS;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
@@ -4711,7 +4712,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
-	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
+	    !gso_by_frags && mss != skb_headlen(head_skb)) {
 		struct sk_buff *check_skb;
 
 		for (check_skb = list_skb; check_skb; check_skb = check_skb->next) {
@@ -4739,7 +4740,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	sg = !!(features & NETIF_F_SG);
 	csum = !!can_checksum_protocol(features, proto);
 
-	if (sg && csum && (mss != GSO_BY_FRAGS))  {
+	if (sg && csum && !gso_by_frags)  {
 		if (!(features & NETIF_F_GSO_PARTIAL)) {
 			struct sk_buff *iter;
 			unsigned int frag_len;
@@ -4773,9 +4774,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		/* GSO partial only requires that we trim off any excess that
 		 * doesn't fit into an MSS sized block, so take care of that
 		 * now.
-		 * Cap len to not accidentally hit GSO_BY_FRAGS.
 		 */
-		partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
+		partial_segs = len / mss;
 		if (partial_segs > 1)
 			mss *= partial_segs;
 		else
@@ -4799,7 +4799,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
-		if (unlikely(mss == GSO_BY_FRAGS)) {
+		if (unlikely(gso_by_frags)) {
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
-- 
2.49.0


