Return-Path: <netdev+bounces-178688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB97A78404
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE803AA7D8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42661EFF96;
	Tue,  1 Apr 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRglROpU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2991204F6E
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543010; cv=none; b=XJ3GaJ5xneQNydDFnjfOVK5XpuuJ/hgdPmAXGx68LyKYt5HPDXzrzlcGU7LAfpUrwbEzjEGrCSz5zd3G9sj4eNNimaHFIZpUahJEk/9IOKj3erRaSTZxX7CDbqMRSrL3uvIudoK/bv1FuE11ZpXMzB3jl00LEOczlS+u7Xm6SpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543010; c=relaxed/simple;
	bh=wwyo0LgWvt+4IBjBvdZHAc0CUJKp8k4bfCj5fdOUats=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHzqZYMrEGc3VGw334+9dA0CX8qPmAC/3Mspfd7cXtMiYtOV+WU6IzDpMy5hcOdlo1ktmBeRHSHDhUbr43Zo+AnI4/BXvJvr4aoJw6d2y+KGcNt1WlFJk3qjlfRcGLdrUyHqKsCBRbFV53pWHYh6cciY7VQx8BHsnJZULAp9aHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRglROpU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2279915e06eso124413865ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743543008; x=1744147808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8tZTsgFV95G1RpNriOWM6jediUbS/l+nOAJ3TKTvjfw=;
        b=NRglROpUdczxSogN8oAu6v4hsC7rdrHdQQDK9cEstTL5lO1/Eo2Q4Cq2phntdQjbpU
         ZnaIHY1QG8FpGahMkeIDtqZIiAjaaDmi5W6/5E0/YLGmb9rnHLQaoCJO2mfcmPmOOHln
         8S0DVHd3djzLXvcLWRPtcDXOWOSB49PfKgLLcvvYuAQk6IvOxl3ZGHmtjlv1Rh2MjggA
         EZWhFEF3hyrcdSLwrx4K/eQsURrAJvQet3Ooce7jLrgsHYxg1kWZdEuSxzqjOvIwyu4l
         2fK0YUwKsWxbDVkBYBorhsl9LA+bVsiVVdOqgJ0CDPq29IfxcK9nQG2c/XKcjMgelpEd
         f8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743543008; x=1744147808;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tZTsgFV95G1RpNriOWM6jediUbS/l+nOAJ3TKTvjfw=;
        b=kEWKkQcF2an4m7Dn4dnKNf6+Ccm9mZZKrR2C7ICIkOSM4gzRjE8CulLDtc/YV9VOqS
         rr4Laaw2v+OhcpRApNiNHRaQSldwPXztgg1gvUYXVV7R3hrwIETq6D+VnNb7pBdltWz6
         dbXBdRVB0tfpkVBke8b17lmYwPaY8ILijDQ/pzL1EUMpFMDW0xi1CiYwE9768EfQq7GL
         dP26dJrDdjH5DW7mMJHG/KEtbla5dDWk6E2ow0+G3lP0srp4qDtgcRMAoDW37RmMkU+c
         OPGMSLrZtWqwpB1AHexTSmAV1dxodXp2w+jWQyq7gKHabTZrL3o5sRQWhlxrIPl7wzHD
         49Wg==
X-Gm-Message-State: AOJu0Yw4HB/et6hBxt4FdmM6sEOd9+EO1SjwZeqx5P2Y/y8Szwgscgki
	gqlGEbV/c3csJ7OlOYiehGdNzdQ2igj7fQ+Nyip0thDXrnayyzbWR6lOGA==
X-Gm-Gg: ASbGncvPBK5tec2Ye22NEg2h5VMoyyf7OktSv5shq6Hmf3f+9TLamnpaPP7g3OWYsjW
	sMg+qPZNn8Y94CHGEuegMudjiFdxO8gqZBBiDc+GhJcbsnNEv0U+FUNejmyWg4LQXKn0o9+ozdr
	bhlk9yZkhEAen168/gNEs60eMLielH5b+o0OpibEkW4Rp8vzUOCUSsmAgH5QuZ1UrapYa+a6Gif
	ZWZDzfFNQJpwY3/GUFScSNqKjs6AMBg1v2fvtDFto0kvJhCiEe8DN2EGSrp7qoyWtsKTacmhOut
	SWfRA6PED/+wlu1xI5Cf8iQqXxLg/A2Bao0toIypnRamqkYRnOrIdZc7sBA6a1aINar7WPQThMj
	Huj4=
X-Google-Smtp-Source: AGHT+IFTO6S0bMIxqczU3jnmQOabVu7CcvZK93TBhmBWqgg3DVxTZ0IRKJ4eSGpDXVrhebZKzOPiNQ==
X-Received: by 2002:a17:902:da83:b0:21f:5cd8:c67 with SMTP id d9443c01a7336-2292f974bacmr214241455ad.31.1743543007945;
        Tue, 01 Apr 2025 14:30:07 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1e00e0sm93898515ad.209.2025.04.01.14.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 14:30:07 -0700 (PDT)
Subject: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com
Date: Tue, 01 Apr 2025 14:30:06 -0700
Message-ID: 
 <174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The blamed commit introduced an issue where it was limiting the link
configuration so that we couldn't use fixed-link mode for any settings
other than twisted pair modes 10G or less. As a result this was causing the
driver to lose any advertised/lp_advertised/supported modes when setup as a
fixed link.

To correct this we can add a check to identify if the user is in fact
enabling a TP mode and then apply the mask to select only 1 of each speed
for twisted pair instead of applying this before we know the number of bits
set.

Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phylink.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 16a1f31f0091..380e51c5bdaa 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -713,17 +713,24 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 		phylink_warn(pl, "fixed link specifies half duplex for %dMbps link?\n",
 			     pl->link_config.speed);
 
-	linkmode_zero(pl->supported);
-	phylink_fill_fixedlink_supported(pl->supported);
-
+	linkmode_fill(pl->supported);
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
 
 	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
 			    pl->supported, true);
-	if (c)
+	if (c) {
 		linkmode_and(match, pl->supported, c->linkmodes);
 
+		/* Compatbility with the legacy behaviour:
+		 * Report one single BaseT mode.
+		 */
+		phylink_fill_fixedlink_supported(mask);
+		if (linkmode_intersects(match, mask))
+			linkmode_and(match, match, mask);
+		linkmode_zero(mask);
+	}
+
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mask);



