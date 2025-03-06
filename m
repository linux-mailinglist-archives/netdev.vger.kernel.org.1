Return-Path: <netdev+bounces-172308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE34A5422E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D263A56EE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742F1A23A2;
	Thu,  6 Mar 2025 05:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfc4NtAK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C931A00F0;
	Thu,  6 Mar 2025 05:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239114; cv=none; b=GIEN2fl3I/W7ch38rsOwc+RHUOiYTfqCa1w4V3dRBKK1Ab676dSz+FNIEnlvMSUIKrSQKvbYbC8JJtDO+tY1SguneAVWCOZ+RmVTx4Rz3mhNHS5ZzUOn3cZN9yIHQePUZ5e085HUZldevjbH/Kap8/zQp2W2uC1IVscXRVWQayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239114; c=relaxed/simple;
	bh=jB+SAxV67/XkLO7Ja8VKYB3BnV/TpONenLjNMpQ2DpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OontxcSQwRCkzWqV8KBc3CAS1edA7Gbw66jTzXzrFfu+NKl00hq/2IsTW5Udq9zQNsMH2/DuLLBOWOmMsQnMFOAXDS8GiSRCM+n9d2yO+G0MiHkvJDH+QlQ4PHq3vGiHI/RqJqbkGd+wFnb7WsWrQXRpF8045whPXS+CK+UHXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfc4NtAK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2232aead377so4129105ad.0;
        Wed, 05 Mar 2025 21:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741239112; x=1741843912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNmAyfWjthm2OoYu5rb89I5Fn5ozA8/1Vp5gyVNMnWg=;
        b=mfc4NtAKnNh/OokE3+EWWq29LafQWWmBrUzpVCnWoX9n2njnwXjqmxzftBx+fma6r3
         cud+dRXJWfkLWoorTdaWXrdRAahNfZrFBM8Xwt+FZaw1A6lCq74j2RTAz1MP0RswXHAH
         mboZhpE4VVDkM+VocssMVZN4OLK6ni4BHJ6q3pnL/rvgg91CDgIXGjf9SCvl4F9I5jCn
         jPr/vJwP7wyWl9CM/nxHB32J+XkwuBUpw9n4ow4ZPkN4KR+KML3oDeNG8/YfX9DzjM/h
         7+geDXyy/X5gWsT8I5mKywZQW1aWA28dQV41PCSPqqRiWgVemyNZQy3kPJ8QP7muAhKI
         suFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741239112; x=1741843912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNmAyfWjthm2OoYu5rb89I5Fn5ozA8/1Vp5gyVNMnWg=;
        b=jPfdQwSaMz9s8I7PrQpgltITiTPz2K8LIe4JvcBMSTs/CmLvsekMCRGUIuQY74Wrwt
         7vN8DAmQrlAj/qi9eJkI3VBAeeba5YrSBQvE84bUWVH1XXSaiD5TzrexDv7mL1KlCXPW
         bMdHuXgS456X2gc5adLSFilxTV6+mxjNMyFlCiTpYLIjrAz3OcDKFbfBkPgtdGRjz7oE
         npcCER5AlFintKa92C9Thb8uvTYSRtAPXK9JkrPcdXpo63hSdoIRIV2JctI6iNPrsEKY
         GxIx2/ariUfN4Xag7CwkMfF+PeXiaA/jWHdqQ1PeAm6ILHvI/zhhz38R0Fpv0qGJ1dgy
         Ak1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDZg0AfyH66/uIrHmit6jAYp/6LAFrgcwB+HMZlE0cro7v4c//aUD9e5JSi8L4bC+vdRWKhhzAqU9cJPqB@vger.kernel.org, AJvYcCVOTiCOpmz+UPsh8o4wNNTuj5ZQtvXQdbQmVnKq8WJal8xwxajE7t3ThQMLnZPv4Qhe/bUPDeDr@vger.kernel.org, AJvYcCXI8QPIN0eIXr1ku+kqK5DQ5QvMRUQJHDeTrRBzLiniYY0lSQzApw2GZ2KslJzY7Gts7+l7xuuWIIh1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KNnOdnwsdEUeBZJ62znf5lF9tpqiv0X05quvlPLLKMGQ9hh/
	exNdEEsTCUmHmotiaFKwhYWwUiqmLGfm+K21tLqbDcASeTnM3iJh
X-Gm-Gg: ASbGnctFiUeRVD3U4fS+AJciik95zByyY+2lPvD+e/8Z90M5/sTD90XCR/9Zw6ld4N2
	NFp1ZE/Crg30e0tfq6X/BOvTdw4dMgz6RaC0m8ZCk2PvWuHVXe/dyPua9em12Q4nqb73HpdXqqo
	55zDQvymkt7TQWXHHTahF/UUxkaTGwy39ISaXKoI8sglI1XLVvvzjp6WYetlg5Tr61Fi3J52FnJ
	xpVdKtAKVLSbMSZsvT6KPBOOidZfhJxwsSfRFhxLlRruSZMq6ulJwxyX6Vg/h8KSKNLNat3fRRC
	yZH85a4mAOk/2kNkPqZ7omVs+DROeMoRxOcJVGS/+jNG0i7gEcN1lKuZQ04ZdgyE
X-Google-Smtp-Source: AGHT+IEqJnp+0kABWVU0+Qm+uz5YmN+WDRuFQPegHdPBUQCPPJDk5r60c+pAoAr20/7X1oAHmAwLVw==
X-Received: by 2002:a17:902:fc44:b0:21f:164d:93fe with SMTP id d9443c01a7336-223f1d20b5dmr111318785ad.53.1741239112110;
        Wed, 05 Mar 2025 21:31:52 -0800 (PST)
Received: from localhost.localdomain ([205.250.198.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8ae4sm3470045ad.243.2025.03.05.21.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:31:51 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/3] net: phy: enable bcm63xx on bmips
Date: Wed,  5 Mar 2025 21:30:59 -0800
Message-ID: <20250306053105.41677-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306053105.41677-1-kylehendrydev@gmail.com>
References: <20250306053105.41677-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the bcm63xx PHY driver to be built on bmips machines

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 41c15a2c2037..0f2956ba472d 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -156,10 +156,10 @@ config BCM54140_PHY
 
 config BCM63XX_PHY
 	tristate "Broadcom 63xx SOCs internal PHY"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
 	select BCM_NET_PHYLIB
 	help
-	  Currently supports the 6348 and 6358 PHYs.
+	  Currently supports the 6348, 6358 and 63268 PHYs.
 
 config BCM7XXX_PHY
 	tristate "Broadcom 7xxx SOCs internal PHYs"
-- 
2.43.0


