Return-Path: <netdev+bounces-188557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F6AAD5D1
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EC116E9DB
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7D1B3939;
	Wed,  7 May 2025 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IStLYA/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305ED14884C
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598633; cv=none; b=CjsWiQ9fFhe51EWLDw88r+Pfi1esf9sGrG2qRmcXXFQW9tlZDb/7pa/zph4MCgW7Y1SsYfMmWdcdd4USh3BWnYvKb7G3ZbSbBoYwkMMgKgc7dvtm0+hC7LI9H+zu9a7VH8pag53I1WmsDKvjWPFL8diWBoTJu6THQrdwkdFiQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598633; c=relaxed/simple;
	bh=fxUC+POU4TSYGxAxTAwRJlNrAbmDzTlhhWDtD1g+PMk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CvcxCVa4dRk0yH3f1UXO061qaycn9J/OCXqVznNhvzURcmKKGchhar5QrUhPViXOdpJxs83NDo5XjnNpMycx3A6s0DOgMmUSc5ODxLW23FA67p729zoL7lAaY/XpHgjPmanxghPCA4K7bror9c2aDwyGmQJ7sm9Fy1mfMQULKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IStLYA/P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso9919435e9.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 23:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746598629; x=1747203429; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHclcOVxLAKl44OZQb+mfQdhLECVjass08E2gEcfSxg=;
        b=IStLYA/PEp96+8d+SLTcBOdkFCFAJDJz2KWwrWVnNwupQ3KmEzpCF15sxazuYFjdt7
         Spgt0hnjKHH/0crLVGol0gbDeF8M0z1vvZdo3kB97mR+PcgZhiudnlJviN3DivLx0ZXp
         z2A1lBZkSh1C1e5uc7StyaBjjsOxGMW+X0Nm4tjR8e3L53O27LW6/TEDq8BuXv9Cy2xV
         1y5OETnw+UbiUCKK3o509ya8eTmoP2TF7JcwkjgBjIDq48e+NQaRG9CHapYu5LHM58Kl
         +7lMSAFOU1wuktiAJnYtepFuzYLCvZyDNnD0+MkBGDpce/LbMkgYjqxANndmNoTOvOeu
         cQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746598629; x=1747203429;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHclcOVxLAKl44OZQb+mfQdhLECVjass08E2gEcfSxg=;
        b=nQ0pb9OM4GJxPVbNKu8M/n7b0Yo6SA0IqqLHqmPLkTwe7i10fmODzsDJclJVTwZYEg
         7BYPZFfvzJHybtoKmm98x+i2lVGP77AraV6thdbcb0k7IrJnXb9oKRN3/aJCRBgXbuzN
         47YZdygle/ukXEe6yu7BVEntDHqZVKs/BvbPR0WWb/ciEjVRw60SXShWF4lngMv+e/D6
         WmS05/z3QxqDq4C/bgECbwXw9wQHLHzK1+Oh9z95LZQ5yIZRcybtAf5Z6ryUbmRldmma
         KooE56tLvkVmxUlXMuWFQlzZ8qT9t5OJ7MMk76JzRG8MS35oQwfSgqQHpXUFH1mRGILN
         5IQg==
X-Gm-Message-State: AOJu0YyUBIXxBm7DesiNStu4m1EpnXeeT0YgMEz1ouMhstfhPVZm7peD
	C1jSN2z9L1ZeAc4cjR/xkU0CN97LcFL7upTz90bcYDejP+rNfxvB
X-Gm-Gg: ASbGncspbTFS6fOaopiqgXcAFpGGixEyJ414DREZWW+G5iU0PFpmX3LN5RUdgIN3e+V
	GmP2ama3yfKM9wwYsqQE9+8qYMCquZyV+8iIj5jX1kD2UdTOUUkxpTyywDB+Hfcpj6+BeMxQkEw
	7iFOnIiwYTJ0NBit7KJ2Iak7r7H2PBiGbNK0haC0vXOZ0KtbrlAP2/wlZkipiQ1b9S8Hug9ee68
	hvhFQc4AmIiT1wdehLL4lf3LdrrODzmTKOj43BysLcuCHBXDBfDn6quOj9/TqKDPvioMblPOSIH
	BQBq4NAemik9lWYOM9wadw7jn9W8R1QH/t3L1ct0ST//6BGXTm+AItjuG1nVwnYVFeT5oruvV36
	Zrx/J6kxIbMmg6Etaw1gAkMs3D/7SWP1IvfmMXrK8RKjWnU2ZRlBaqt/lwPq6kG304IluCuJ5Ib
	NIRM0YraBHxtAVCno=
X-Google-Smtp-Source: AGHT+IElIAxQd9f7AP7aegu2tFlm1Ro5UkUu5nzmi10g7b5IpPUAMmvgOstUmW+/Qjii3YEqvzxLqw==
X-Received: by 2002:a05:600c:1c91:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-441d44e3341mr9329705e9.28.1746598629030;
        Tue, 06 May 2025 23:17:09 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2d:8d00:d1ed:f1f1:dce9:7a6c? (p200300ea8f2d8d00d1edf1f1dce97a6c.dip0.t-ipconnect.de. [2003:ea:8f2d:8d00:d1ed:f1f1:dce9:7a6c])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-441d43465besm18986765e9.16.2025.05.06.23.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 23:17:08 -0700 (PDT)
Message-ID: <9c2df2f8-6248-4a06-81ef-f873e5a31921@gmail.com>
Date: Wed, 7 May 2025 08:17:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, imx@lists.linux.dev
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

MDIO_DEVRES is only set where PHYLIB/PHYLINK are set which
select MDIO_DEVRES. So we can remove this symbol.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/freescale/Kconfig       |  1 -
 drivers/net/ethernet/freescale/enetc/Kconfig |  2 --
 drivers/net/ethernet/marvell/Kconfig         |  1 -
 drivers/net/ethernet/qualcomm/Kconfig        |  1 -
 drivers/net/mdio/Kconfig                     | 11 -----------
 drivers/net/phy/Kconfig                      |  1 -
 drivers/net/phy/Makefile                     |  2 +-
 7 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index a2d730092..bbef47c34 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -71,7 +71,6 @@ config FSL_XGMAC_MDIO
 	tristate "Freescale XGMAC MDIO"
 	select PHYLIB
 	depends on OF
-	select MDIO_DEVRES
 	select OF_MDIO
 	help
 	  This driver supports the MDIO bus on the Fman 10G Ethernet MACs, and
diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 7250d3bbf..f3a6b3752 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -18,7 +18,6 @@ config NXP_ENETC_PF_COMMON
 config FSL_ENETC
 	tristate "ENETC PF driver"
 	depends on PCI_MSI
-	select MDIO_DEVRES
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
 	select FSL_ENETC_MDIO
@@ -36,7 +35,6 @@ config FSL_ENETC
 config NXP_ENETC4
 	tristate "ENETC4 PF driver"
 	depends on PCI_MSI
-	select MDIO_DEVRES
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
 	select NXP_ENETC_PF_COMMON
diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
index 837295fec..50f7c59e8 100644
--- a/drivers/net/ethernet/marvell/Kconfig
+++ b/drivers/net/ethernet/marvell/Kconfig
@@ -34,7 +34,6 @@ config MV643XX_ETH
 config MVMDIO
 	tristate "Marvell MDIO interface support"
 	depends on HAS_IOMEM
-	select MDIO_DEVRES
 	select PHYLIB
 	help
 	  This driver supports the MDIO interface found in the network
diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index 9210ff360..a4434eb38 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -52,7 +52,6 @@ config QCOM_EMAC
 	depends on HAS_DMA && HAS_IOMEM
 	select CRC32
 	select PHYLIB
-	select MDIO_DEVRES
 	help
 	  This driver supports the Qualcomm Technologies, Inc. Gigabit
 	  Ethernet Media Access Controller (EMAC). The controller
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 107236cd6..d3219ca19 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -38,9 +38,6 @@ config ACPI_MDIO
 	help
 	  ACPI MDIO bus (Ethernet PHY) accessors
 
-config MDIO_DEVRES
-	tristate
-
 config MDIO_SUN4I
 	tristate "Allwinner sun4i MDIO interface support"
 	depends on ARCH_SUNXI || COMPILE_TEST
@@ -60,7 +57,6 @@ config MDIO_ASPEED
 	tristate "ASPEED MDIO bus controller"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on OF_MDIO && HAS_IOMEM
-	select MDIO_DEVRES
 	help
 	  This module provides a driver for the independent MDIO bus
 	  controllers found in the ASPEED AST2600 SoC. This is a driver for the
@@ -130,7 +126,6 @@ config MDIO_I2C
 config MDIO_MVUSB
 	tristate "Marvell USB to MDIO Adapter"
 	depends on USB
-	select MDIO_DEVRES
 	help
 	  A USB to MDIO converter present on development boards for
 	  Marvell's Link Street family of Ethernet switches.
@@ -138,7 +133,6 @@ config MDIO_MVUSB
 config MDIO_MSCC_MIIM
 	tristate "Microsemi MIIM interface support"
 	depends on HAS_IOMEM && REGMAP_MMIO
-	select MDIO_DEVRES
 	help
 	  This driver supports the MIIM (MDIO) interface found in the network
 	  switches of the Microsemi SoCs; it is recommended to switch on
@@ -156,7 +150,6 @@ config MDIO_OCTEON
 	depends on (64BIT && OF_MDIO) || COMPILE_TEST
 	depends on HAS_IOMEM
 	select MDIO_CAVIUM
-	select MDIO_DEVRES
 	help
 	  This module provides a driver for the Octeon and ThunderX MDIO
 	  buses. It is required by the Octeon and ThunderX ethernet device
@@ -166,7 +159,6 @@ config MDIO_IPQ4019
 	tristate "Qualcomm IPQ4019 MDIO interface support"
 	depends on HAS_IOMEM && OF_MDIO
 	depends on COMMON_CLK
-	select MDIO_DEVRES
 	help
 	  This driver supports the MDIO interface found in Qualcomm
 	  IPQ40xx, IPQ60xx, IPQ807x and IPQ50xx series Soc-s.
@@ -175,7 +167,6 @@ config MDIO_IPQ8064
 	tristate "Qualcomm IPQ8064 MDIO interface support"
 	depends on HAS_IOMEM && OF_MDIO
 	depends on MFD_SYSCON
-	select MDIO_DEVRES
 	help
 	  This driver supports the MDIO interface found in the network
 	  interface units of the IPQ8064 SoC
@@ -183,7 +174,6 @@ config MDIO_IPQ8064
 config MDIO_REALTEK_RTL9300
 	tristate "Realtek RTL9300 MDIO interface support"
 	depends on MACH_REALTEK_RTL || COMPILE_TEST
-	select MDIO_DEVRES
 	help
 	  This driver supports the MDIO interface found in the Realtek
 	  RTL9300 family of Ethernet switches with integrated SoC.
@@ -204,7 +194,6 @@ config MDIO_THUNDER
 	depends on 64BIT
 	depends on PCI
 	select MDIO_CAVIUM
-	select MDIO_DEVRES
 	help
 	  This driver supports the MDIO interfaces found on Cavium
 	  ThunderX SoCs when the MDIO bus device appears as a PCI
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 0b8cc325e..677d56e06 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -15,7 +15,6 @@ config PHYLINK
 menuconfig PHYLIB
 	tristate "PHY Device support and infrastructure"
 	select MDIO_DEVICE
-	select MDIO_DEVRES
 	help
 	  Ethernet controllers are usually attached to PHY
 	  devices.  This option provides infrastructure for
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 631859d44..59ac3a9a3 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -20,7 +20,7 @@ obj-y				+= stubs.o
 else
 obj-$(CONFIG_MDIO_DEVICE)	+= mdio-bus.o
 endif
-obj-$(CONFIG_MDIO_DEVRES)	+= mdio_devres.o
+obj-$(CONFIG_PHYLIB)		+= mdio_devres.o
 libphy-$(CONFIG_SWPHY)		+= swphy.o
 libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
 libphy-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o
-- 
2.49.0


