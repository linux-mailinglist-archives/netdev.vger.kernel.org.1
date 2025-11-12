Return-Path: <netdev+bounces-238006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF63C52ADA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70AE05016A8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225133F8A4;
	Wed, 12 Nov 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKuYFh16"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AA33F39D
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955881; cv=none; b=gM08Z+Oqs1B7z/vfAsuhPHrFceRSy8IevMocgMP4R5h2JHQPWPqVZLqDGYy/9V5C0H+BpbozMnjqbaNdODd/lfrfEnO82yaPqd3MOYEs+As8nmQIlESwLls0DB7S16VKsd8Bu0I4EvppyMsbsBZDCUtXWqFeChOSSzxLft7H4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955881; c=relaxed/simple;
	bh=TVib8KoMScZCb+KPT85+QmKKvlCH8lixAtnRmNJ3Neg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8L8LwZQbaLwilY0MN2LqlDK7dUunUHxDn8J/iZn80o7HQib8OOu1NLd75kQ/ObtEIwmGquFzCXLD5pJgcZ/M1lZFFxVwrs0fI7XBXyM1aX72Lyw9ubSD7EYJxDxrHaeaCuo3X1nACdPHMrN+nC7lDGqak92AVeYchaLpGigiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKuYFh16; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aab7623f42so972361b3a.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762955880; x=1763560680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1/MI7fuOzyKPjB007+f1We8KvicofZrvdYQ3ilyzeo=;
        b=lKuYFh16/6rkyavH4eqTg6FQaEhDKqJQ9T7YdWTLOsH2HVZAG4cmn6wTPORrzSaa76
         YZv6hKrXeQrk64ik8lj1cD1PduE4FtX/J2EjCEOTboCTi0XqeA3/yJ80z98r58pNfCup
         8bLYppRSnhhG4vLiT+SlznkSaqncHb7c/r9j8GQUwBCn3AFtai4U1CmbLVw8C+7HcqMf
         E0TGmlGCAlvSpnJrk5+YtYmEaYjhLblAGsTkRdjtnuBPS0Nq05cpKSYJ2YMee+hEvovE
         kqqdDLSbQttumlkIt4DWZLGexew1tmzChcqLiNfKf/7sIbkOINlRQBsjU8R2VTt+Ky0t
         Rf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955880; x=1763560680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1/MI7fuOzyKPjB007+f1We8KvicofZrvdYQ3ilyzeo=;
        b=XeJe0DTW/9BhuTPy9oAIQDJDCUo4sTJxmDm7v5Xwzh9EpJVEh/Gu+ziQK5ZGjgPh50
         tBfT8Ck/5X9K3cfxgAi79V3UTUYwMgWuIQiOprbG3VUYK0vpO5Cjq/nGEETEfCNc0iC9
         XIA8tw+iP0yY8SVnLEzVWYK2/Yb7g7xNnniihjM+NVXQskstuNTIL6dl02lvmKH+mJJX
         DDEUSQ69Gm+yo7zNJExutpiVDB682i9PSmovErTmnPRtucdH009ls/Tl3SWhXQBKW62w
         3mhLL8Gt72GswnTI8ZvTf2wbZn+BxLi7GbDxg5NGUUCcmI1Dzssyc7ltSjBmH6aoNRqS
         bJpw==
X-Gm-Message-State: AOJu0YynYwZwOCtjdn1p7sHvBerq9ux65Q1LKC7Hx26bsNra/oMmbE+S
	uNl55YWD8BZICc4XfoZzDqg94FVnTd+LbHQJiClDWYeYMuK8COQJwqe/
X-Gm-Gg: ASbGncuh+qBrqRdHCznoPh4nGLDxyHF8k5mrsO7jy9rd/sX94y50e3gYowV1NVAQ4dX
	CrX95QUluIzfJdWU1yxZIIkIPwzvVV894Nof0p1KWSyaRskkQlzqwmuTAGYTDhsxLqqCO0gEQGg
	Wes3nfF/79nogcibL4Dzx9kC2sFPL+eieAedG5GCNq/XLuvnUI4xHQkn2arPz5L4NUX/HtSuk7q
	BNQeH7xKhLCLFxj5g6h3qVsq3lD1buKFFcRSu10P8vSkiNlbO6eeZ0jDq2btvfrVeL2JGY2bPF7
	z+XjWuuQCK88M178og5K10owuzp9RMSqHvqWBZuvAJr1HEgSt5de44hVMXMFwDQ1eMBWbViL/pz
	IK6VRIGqIWj7xzSn6LBwDRq1JVS8NQgk/HwIREUgZ26mac1LCJofweCmBIeZ+Z2YpUiY+wS6Pqt
	ekEaSBFo/szJvGdpvcPao0
X-Google-Smtp-Source: AGHT+IHyp9NWySH+cDzcnVvq8I6ZIzBl9JYoz2ufTq/3+N/RimV2Z+kLAg6PlRzSKztugHPQfUdG5g==
X-Received: by 2002:a05:6a00:88f:b0:7aa:d1d4:bb68 with SMTP id d2e1a72fcca58-7b7a46ff44bmr3401593b3a.20.1762955879820;
        Wed, 12 Nov 2025 05:57:59 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:1c6:5ce6:4f04:5b55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0f9aabfc0sm18361299b3a.13.2025.11.12.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:57:59 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Parthiban.Veerasooran@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 4/4] net: phy: mscc: Handle devm_phy_package_join() failure in vsc85xx_probe_common()
Date: Wed, 12 Nov 2025 13:57:15 +0000
Message-ID: <20251112135715.1017117-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

devm_phy_package_join() may fail and return a negative error code.
Update vsc85xx_probe_common() to properly handle this failure by
checking the return value and propagating the error to the caller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- New patch
---
 drivers/net/phy/mscc/mscc_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 21fcaf07bc6d..2b9fb8a675a6 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2264,8 +2264,11 @@ static int vsc85xx_probe_common(struct phy_device *phydev,
 	/* Set up package if needed */
 	if (cfg->use_package) {
 		vsc8584_get_base_addr(phydev);
-		devm_phy_package_join(&phydev->mdio.dev, phydev,
-				      vsc8531->base_addr, cfg->shared_size);
+		ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
+					    vsc8531->base_addr,
+					    cfg->shared_size);
+		if (ret)
+			return ret;
 	}
 
 	/* Configure LED settings */
-- 
2.43.0


