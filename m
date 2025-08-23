Return-Path: <netdev+bounces-216211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252BB328D8
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD5F188AC51
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5025BF1C;
	Sat, 23 Aug 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lls9MeGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0F244670;
	Sat, 23 Aug 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755956680; cv=none; b=B5vPYd3zNqPEAF+qhY8rs8Y5Fhgyj+s8WqilqasTjB6U359Qx1MV5TWw5srL8Skm3C4e5bg6+v2/tdRHigWS3m7lo8ngIyvEk2iVzfsLUB2Ek6xI9DlNd2LQ4ZtoCnbJwkVUHTPRxx7mXfMOo0fvzNLqKSiI1/KANe5SYTTG5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755956680; c=relaxed/simple;
	bh=4NY2yeWwO1/lySCuscD0X6YTArnddn4170u6EFF+HfY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofz7AhweuKvaegxIjvirAXf7Sn7PzmT1nug8C2p29P+hmZ1bF0BQQ1wZCCN/H+XZxQytFLtAPwMd7XA4WOt7KLBdWyqAyX8jimL04Q1SABXqncDbXWq6Sz942JKB3kmNTZITFQ6VAoSbhMzZA/JRlnol+vEyHapbtdApJKhqZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lls9MeGH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso15095505e9.3;
        Sat, 23 Aug 2025 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755956675; x=1756561475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxX71PXS3MJnJ5r/8RA04vZAE4FRLUH21Dt1zod0mbQ=;
        b=Lls9MeGH62yFWV2agt8Ov7cl95McqR/jJncnZV96i9dXYc88xCwwsTmClXPiVBg6AG
         kJo89CDDjvLwFeey5TNBrWI9Y+1du2TSrl2XY68XuUFBLY2PxxYF747XGY4PMZ3mVyww
         ztRAcSWx6IHRs5lyuP56SqlKvWP/3IQk4e2mYKLgT4E6THFxFkkImKVYibRDNBK/wP38
         8XWyJscab2rAuXTDA8cXQAX5KukefZEi8YxkY7ZcDUuK026nO5IH7EwuwzJoL3egJaCX
         Q6fepGjw+AmkBS7QKSSvAH+DXmhsM34tEvdKPYaqk6IxYx1fj20WgtBkQ6LoJiPLkEMQ
         Xklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755956675; x=1756561475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxX71PXS3MJnJ5r/8RA04vZAE4FRLUH21Dt1zod0mbQ=;
        b=YyOrxRUWOFIy2EdJIxh9mO7JR4QBty25wQ8Z//ueEj78G0bgKoEsyRZ6YkW53PlETa
         Qz2yBrqCyZwkEn5u7fLdXaK+srOBoSkZjSwsQVBOcCrblcZ1bOjiFRhz9Ih3Kfl1KIhU
         tMomkx+XWCVuLg3nPJh4cu3T9WTPkzFnUQ9PUvv+sctKWlDvB/1+QSksDl2/P1wSUHM4
         T3PhA4P+1XzzGVhHrJBdwMQX4Nmzg1RZKQYJ1RBtMFgVG5EBc4wl0tVnNHv+BIEehPM6
         Eq0QHLBxO99QB1yF629UmShuVMJl4P+K5yLGmh+OzmFBpwl+il4yOYSXsmvzQbjUvV+U
         bLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1RN+UsHL+gNdkD4lSckTM5ZfTh8Pb2M8m/E8xdVvia08HS935ljDvrET0PZQtG/3tljE5KQyrTmNDveg=@vger.kernel.org, AJvYcCU9ZmApdBWvYf/0YD5RjBGvUepQIQFZfS5z4GYFBpo/I83XmFd1mArXXQ0NMloqfyWZNUA/gnbj@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJ2B1OfePuc/FF18s3E1TbYFESqrqjCwBex7jpq0kglW92mPo
	+O+IgytjgFm5ydXZYe+/QUldmsK6U4sb4uEQACkBrOISp/TdC+Jjgddz
X-Gm-Gg: ASbGncuELwg5p0VRHb/pHufh/ow5laAvlZHz+3qNa+e+OgWlCgIrk9HQEPiuw61HeGZ
	EtDJPa2HkFUIGQ2X6hJP6H88/SUMMy9UaRrUcauRJftAEfVVxpfbPng0PYme1Q/NatWxQqAKDLL
	09qSM3Svt7KSvi0dFicCJPjWyO/iHHf0SoZN1L+NTxKkeCJSmZiabNT4IM4HP+KLc8ycO3iC86F
	8FVWEQPIzvU+Jl4OPB73j4uctSq0+2yhoTe+rq38B6qkdcLVL7Bn0pYt/zXYrUzHgP+Ll/i2F3J
	BuOltB8zzAl2yeq+aKoSVO5N1kuVkM8GtE79miRqAavaJ9TjxhPQWSf651tbJyRH8yAB9X9jYjd
	TsqquAdmfVwnYcxqMd8IPUTEHZJu5PniSCMuXt1yY2+fWOx2nm3dBnDT2Qs0h3B9Q1ki+x7M=
X-Google-Smtp-Source: AGHT+IFXdbKOfUopKjvXDg6dQXtQ2fg8P7GgpoV+RVJxAHuph7/KLKt+fCVdWxWGoAMT9T2AgUzZMg==
X-Received: by 2002:a5d:5f55:0:b0:3c8:2667:4e36 with SMTP id ffacd0b85a97d-3c826675780mr198469f8f.45.1755956675412;
        Sat, 23 Aug 2025 06:44:35 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-251-209-58.retail.telecomitalia.it. [95.251.209.58])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c711211b19sm3761466f8f.39.2025.08.23.06.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:44:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 2/2] net: phy: as21xxx: better handle PHY HW reset on soft-reboot
Date: Sat, 23 Aug 2025 15:44:29 +0200
Message-ID: <20250823134431.4854-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823134431.4854-1-ansuelsmth@gmail.com>
References: <20250823134431.4854-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On soft-reboot, with a reset GPIO defined for an Aeonsemi PHY, the
special match_phy_device fails to correctly identify that the PHY
needs to load the firmware again.

This is caused by the fact that PHY ID is read BEFORE the PHY reset
GPIO (if present) is asserted, so we can be in the scenario where the
phydev have the previous PHY ID (with the PHY firmware loaded) but
after reset the generic AS21xxx PHY is present in the PHY ID registers.

To better handle this, skip reading the PHY ID register only for the PHY
that are not AS21xxx (by matching for the Aeonsemi Vendor) and always
read the PHY ID for the other case to handle both firmware already
loaded or an HW reset.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 92697f43087d..005277360656 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -884,11 +884,12 @@ static int as21xxx_match_phy_device(struct phy_device *phydev,
 	u32 phy_id;
 	int ret;
 
-	/* Skip PHY that are not AS21xxx or already have firmware loaded */
-	if (phydev->c45_ids.device_ids[MDIO_MMD_PCS] != PHY_ID_AS21XXX)
+	/* Skip PHY that are not AS21xxx */
+	if (!phy_id_compare_vendor(phydev->c45_ids.device_ids[MDIO_MMD_PCS],
+				   PHY_VENDOR_AEONSEMI))
 		return genphy_match_phy_device(phydev, phydrv);
 
-	/* Read PHY ID to handle firmware just loaded */
+	/* Read PHY ID to handle firmware loaded or HW reset */
 	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID1);
 	if (ret < 0)
 		return ret;
-- 
2.50.0


