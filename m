Return-Path: <netdev+bounces-240729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B6C78D53
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17BCD365316
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668EC34B691;
	Fri, 21 Nov 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPauthpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A83491D5
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724969; cv=none; b=qyyrlDX6EGGMnc9MkaWj3GmoznTModROXnDvWap5jMedOV5H/+6XJUdP7oljn4NepTK3W1l8P/HF2FTnXx5lETGJgKQEa0FOsoV02b8KIKZKMVQhWkXTcAqmsYxxlVCIE1pOftVzHdzu6FXZwJ2VMgMFJlyW9Y+hSXoyCdTfSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724969; c=relaxed/simple;
	bh=ZuNR+n37++XWeuZmswx8Jk/VFwASvL7IpG6/C6NgGj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZygmJtT47wrYJH7HfzMj5EQ5KFD6N0iapZl2PYz19AJmoFC1AW0qrDKsS5ps35SnQt2ZaVJgMees74S1Urz4iXhfG+ogQSzCYCg/R8BOO4x01cYe9O+ABU/WuV8uqErhSEQpN5qqW703/NyQmRRd7bIeQglwCs+fEedKG0W3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPauthpu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47790b080e4so10607915e9.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763724965; x=1764329765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVGvRm888PHJPhrnHWR5oOq8+UrzZ+D6x/y+ufMZnjU=;
        b=hPauthpuV/avzJKlAqyXmBaXDSZUdBBAIzf6jN4MfIL2U4s9yk8ijzLBxUT3XkPw/4
         Nz1pA7YiKLH/IqqqkDIV26U9H43YMSbSaP8T3Nnt10Gr0modGsUGr9nxVE9KlKWUjrIH
         tzjRkJcoVRkn9/OpA8etXggrJB6rUP5DNmzXKNE9HSstTZABk4kkFwJvwFFGKJH5Cvyb
         BgfLSM+8yIh9gSd9BYplU9kdXwlVJKQMqqUOQ4aeKx2M9hwIsGYAny70SB303OKRDSZl
         jInjWnmCtGvyONc58e/QuenApo8xPV5s08H/P51awyMB0CMbA4b9MDdkTzGavJAzDV5b
         Lbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724965; x=1764329765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aVGvRm888PHJPhrnHWR5oOq8+UrzZ+D6x/y+ufMZnjU=;
        b=W5Lubux1laSxRxHh5+cmLqKkSyaDgExkB9ZDpYjpzmfrHrGgEcH4vyy8uV2EaJADc+
         oc7H73I92/HWbtWrhu5l7NFRS0ax5+ewFyfL0bv8JL4K8967MksEg+NdPX6ENpooKn9u
         9kz0jSjWDd9CVaEHwudgaXn+bfrwM6f/YKsQh3AQk7cvQcPKidr+bf3FzrtixjFPAedE
         //5SSpaSCRst96OEVAll8cE6O+wfGDwvnjz1OSt9gO9ZNwKODMc856/1qCD+H4+inos6
         9UkWXUyd+P40vz/ub0UyadtEwSL67y/0TDalY4zMZD7wKGQzsNsTf4un5sVvD9+RzDDK
         bGDw==
X-Forwarded-Encrypted: i=1; AJvYcCVE0yyawThmdg9ZgVp0Ui8eZ1gfuifHjeRPrI6A8SlrkfqOCwRzNyLIIeYNT34ACJNyWiTNBqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yPJ2yKEMfV5D/llyFbS8HDDOIQRvObIlQUEEvhJ0137l2R1F
	0MAH6qNDQxG6PYGRW2JK4sHlLOBlxHonbuM8bQlinlun8gKBzs7TRs12
X-Gm-Gg: ASbGncudfcSvTEx9tsoOWej3e5mjRoGpkPlW0EyWLl7g+Ye+ilPxa2tOboZY2cM12Gc
	LIckrQDf63958YotkyUpdWoL9oHNCE2ejjAtGy6Zq9mm4YSKIZZA8P5I6p75M3QefShT3rsvqiK
	E9HQnfl0jT9jYc2kF1QuYUm6yktBoEnr5LenYZ3/vvPG96+hgXqKRAGlC8N/2569em7nBhdKo1N
	qILfKtQsp5iXagiJjHZVHb61PNYeBxyvz5rP0o47Kw0qf8i5vMs1z8XY1iQPHGxn6os1r2JCjvs
	+1zI4XYNDZGagzhD3ohHLY8qj96QuTL1eswNfGz31javbxhlVS3UHXB3Kx7dn/syNP/kYKgV5Ht
	YoBGqIjVz5KJqzwG+XHC9ahhZBzN0A01w4p7bEDouSjY5pu4vGLY3BBJ4IFT+7gzyHko26dSjCG
	kgSDobgbG70qbUK4vanAuEUbNFCHlz51D0tYw=
X-Google-Smtp-Source: AGHT+IGP6qqVCFXHN+cAZp1IvVwnJnp7t5C04e1RX3baXyzOnx75Ofa1ghx3/gF3/D/CgYSw36Gteg==
X-Received: by 2002:a05:600c:4f82:b0:477:952d:fc11 with SMTP id 5b1f17b1804b1-477c11175a9mr22994005e9.16.1763724964758;
        Fri, 21 Nov 2025 03:36:04 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9cce:8ab9:bc72:76cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm38732465e9.1.2025.11.21.03.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:36:04 -0800 (PST)
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
Subject: [PATCH net-next 01/11] net: dsa: tag_rzn1_a5psw: Drop redundant ETH_P_DSA_A5PSW definition
Date: Fri, 21 Nov 2025 11:35:27 +0000
Message-ID: <20251121113553.2955854-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Remove the locally defined ETH_P_DSA_A5PSW protocol value from
tag_rzn1_a5psw.c. The macro is already provided by <linux/if_ether.h>,
which is included by this file, making the local definition redundant.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 net/dsa/tag_rzn1_a5psw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/dsa/tag_rzn1_a5psw.c b/net/dsa/tag_rzn1_a5psw.c
index 69d51221b1e5..201782b4f8dc 100644
--- a/net/dsa/tag_rzn1_a5psw.c
+++ b/net/dsa/tag_rzn1_a5psw.c
@@ -24,7 +24,6 @@
 
 #define A5PSW_NAME			"a5psw"
 
-#define ETH_P_DSA_A5PSW			0xE001
 #define A5PSW_TAG_LEN			8
 #define A5PSW_CTRL_DATA_FORCE_FORWARD	BIT(0)
 /* This is both used for xmit tag and rcv tagging */
-- 
2.52.0


