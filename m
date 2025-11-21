Return-Path: <netdev+bounces-240731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8790C78D5F
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5976A28DB1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9108134C9B5;
	Fri, 21 Nov 2025 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTfJ7ThJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8FC34B430
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724971; cv=none; b=uxkNcKz6ZC8X+IH1BCaljDPC0hfI0P4lYyNA7p1EDLWSuyT+ktBrEplJBAC4a+mdJI+Sg+My6hZiTdKYq6OykEiPyBxDJEgJZfs2CmCHB9B7axqUyVo1ylrkZgj7zb+DlIZw/LAhyikuifF5grfXkSDj0SuhDetDX60DGqo3CLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724971; c=relaxed/simple;
	bh=txNrbR4kjc/pY51+xvNJPPLRbwZbm/EM4zTlrSM5lhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0DfEQZYKePKptvELht7RpRqbFEKc02tSXwQSvhZ98py38G0MsvEcxJ6tggV2shonSlKSGYhJr9nNz4KhiZDa9qY6xIar2QvMKzAiYS36YJGQhpX9x6zjchoy04SaFSACec+2wCDbN3QhMlYrzBmZQQMPH1NAuMQGmZ13E1Tw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTfJ7ThJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47789cd2083so11736535e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763724967; x=1764329767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkXvNfxvuRshzrX3T7DmPxZ6UESlXh/M5H4rR5c5zXs=;
        b=dTfJ7ThJI1xlL7R/hBx5DVskgFPSntxVjwwKejb4CYoAxxLtjIgMl87b1CByEQ0uKC
         FPDgneU8bOz1kJteTQXaPLV1zA4eKIldW33vFgFMzVXipjLxpLatmNBtLy+mcMRzJ2gP
         i+KlT+v3wwhZQvgxTJVT8l84NdBxjF92SM6FRGAgKZJ/tX2h4wxJicKQHY+OmJ4U2YiC
         Ho0EkTI+v67vh2ck2RcTn5ufXuK+qyI69Jk0YQC1GVfOzGe8JLTycHeI5PvoQT6kpObf
         f+Nv+IwVX19l2jnmB7P6N5WEBjORUZEBNpmhxfxGTm0RnlXtnRPF1uP9FDGDxulvjoWW
         QfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724967; x=1764329767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkXvNfxvuRshzrX3T7DmPxZ6UESlXh/M5H4rR5c5zXs=;
        b=XRTfwSosT+Hi3iEnj5JuFBZWS48k6oeJf0DctH2mGthkSZQ82tUs4WHJ9qOaQpGE2r
         ye3tOoOfzi43INsK0P0rJ5cX7L19rz9lv4gNC6Z/osDlc88GtYF90h6Jwae6yL+H50+S
         bdnf5nbr3vrortPJAOsY8Ig7NUa7bYfUy5sEpG26fxJlkaS2BM0IC/8eDQU0RodlPpFJ
         TYQa6v/qU1uAIvD03DUd1VPTsvYO1iEfJXy66TaXWP+v2AMucE2UHXXHclzSmo1vWqm0
         VN5NbK0NRmlJLj/rVux6NhFf5P3ijozcKEtLOjPmGYaln0BjBly4jC5MTdnkl+Aysk3Y
         l/jw==
X-Forwarded-Encrypted: i=1; AJvYcCWcNUksUafyS30guBhfw+5NTg3beLyVpkMfgnBi3hEGtql+yeiw9mBysOnf3Rf99PS6/N6xqTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSBj5e98Wcn7GalsFV0TYhBLw0zV1/H7sC8fXx7KK3c8S7s90
	QTbaOrLv0YrvWFJyj7xKT+Y1UHzGeoR3N5rKQcayPQxh77+dyT0z6a9o
X-Gm-Gg: ASbGncup+4VmfbqkJiQTHug6eFbuFloaE54zOdhZ4Q8WmfvvzgWGizRMv8oo7R0ymyh
	6l/6iZFYiii4KnyxkXTewJ7NsUZquz4JM8LZ8P7iOf5OWb70BFbFDaTd339rldnhqSWCloikWJf
	t92sePXfQmTrOtW41DNeYtk9EedyDd85ivRnWYEaRgH50iMLeZtKYRpB3bVnHtn6wAWi6lfUdXy
	PxT3G07zyd3PMK5P9/6LP5ED4POyHvzcZ8u/NTNfxL7y0htW4wa0weAPcCOSP23u/bkCX4khFda
	Rgo3gGkxU+IKZ/ZsOB6PVa2iXDk2+PRU149Bhxiv+S+MjlHVEvoGqI2aQ6meFEb5Db9Ci6xfqAs
	UiO9NM7QmQc+ydTd0ZGS3Jljax4FNPWCtAkZ/I/8Bn9naTYf0wM7o6AAOqiRxpP3ix67LHRoPto
	ZSQsSZ+CAGcFEzhlDNjy2uQx4CSBXw7yNoQAk=
X-Google-Smtp-Source: AGHT+IFBmFYvdBEIuzrTSbSnwbk43MBJtoPoX7HxLBKhni5O1VX3pQuLjHyH3K2qpXRDhjoQjPVdbQ==
X-Received: by 2002:a05:600c:c492:b0:477:429b:3b93 with SMTP id 5b1f17b1804b1-477c1143089mr17859875e9.18.1763724966973;
        Fri, 21 Nov 2025 03:36:06 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9cce:8ab9:bc72:76cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm38732465e9.1.2025.11.21.03.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:36:06 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next 03/11] net: dsa: Kconfig: Expand config description to cover RZ/T2H and RZ/N2H ETHSW
Date: Fri, 21 Nov 2025 11:35:29 +0000
Message-ID: <20251121113553.2955854-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Update the Kconfig entry for the RZN1 A5PSW tag driver to reflect that
the same tagging format is also used by the ETHSW blocks found in Renesas
RZ/T2H and RZ/N2H SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 net/dsa/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index f86b30742122..a00eb3bdcd0f 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -159,11 +159,11 @@ config NET_DSA_TAG_RTL8_4
 	  switches with 8 byte protocol 4 tags, such as the Realtek RTL8365MB-VC.
 
 config NET_DSA_TAG_RZN1_A5PSW
-	tristate "Tag driver for Renesas RZ/N1 A5PSW switch"
+	tristate "Tag driver for Renesas RZ/N1 A5PSW and RZ/{T2H,N2H} ETHSW switches"
 	help
 	  Say Y or M if you want to enable support for tagging frames for
-	  Renesas RZ/N1 embedded switch that uses an 8 byte tag located after
-	  destination MAC address.
+	  Renesas RZ/N1 A5PSW and RZ/{T2H,N2H} ETHSW embedded switches that use
+	  an 8-byte tag located after the destination MAC address.
 
 config NET_DSA_TAG_LAN9303
 	tristate "Tag driver for SMSC/Microchip LAN9303 family of switches"
-- 
2.52.0


