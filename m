Return-Path: <netdev+bounces-234511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 78884C226FA
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF0CB34E22D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34889311944;
	Thu, 30 Oct 2025 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggVmHUC3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C99B301004
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860373; cv=none; b=Wqw8npFKS+G4hGEweRH/RnBDIbKMZCMio+OvWfwCQ7s4ur6bkAz5vCl5rutxwhWc9pyEOqc2/Pp0f4HtQDadIIz+M96jHKJKcjXS8JH0hF05qFCNcjJgBnOqGauyo38EswSmUrSKB7SLFDzqyHc+R631xs+hlvFWh0hKvWnBEDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860373; c=relaxed/simple;
	bh=WFlyIexI14gzzzuldNdHGJV4JITfsrwcYTRONb/7CzE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RWKRnNXRlCDhmcEQx6Y/Jc+pwZKHHLR4FRGRfMsVxDpYfyvtna8OJlO1hAng6RQEPoaLibPq5p2TFayElInWBd1rfMY3//5qQwtZpaDREzqLeiCTiWCejYI64WH+b49s8nGRmnp57VLoN3G27GtQdw/2wumNDyZsOS7RwS4Xzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggVmHUC3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so297001966b.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860370; x=1762465170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+Z4aBFRbBiE704Kr78L6ktIIDMs4HdMIeAn+6hqXnc=;
        b=ggVmHUC36obTP9JFIqIhKPLSHdv5+bSd9Ls9ZVMXNBiKFngDKwGt2rVSMQyPvciD64
         U/vp+26ma3a4M97PnRPqUpZrzNUhVfsrBgjBlGj5Kum/ndDqQfupziu1jkXiEluhUUGd
         +S6XVN+UoASc6iFLvVH/sxNSBaQL6YKHHxPgNnTVCqLhqqPwpoPRLVKQKQi9+0CAxcAx
         cfhcQrXR/uXVwWe1OYr50RHCBXKz/Mj4eFBr+yrLa/KeUasQ2HPv1tgvlWRzJxGqA/Nz
         Eb5snN16WcXGHELRzPd530HyDllu/AOdKRXAbV0npunx8orvXvnagB2LYCs4P55p0mag
         7v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860370; x=1762465170;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+Z4aBFRbBiE704Kr78L6ktIIDMs4HdMIeAn+6hqXnc=;
        b=PnFKqX2OP92w23EANGhqK7rgcFGuEzUKoKb6qKiDAV7FCMvAuNxgNlXMYd9xZm9JEq
         ULK/wRL13lOGvN7NVEJlPxzLMvItQ9kFB3nlhjpjc6z4mwVCRAJVrTQySVJA1oT9FVRT
         /dgO0WUCqN33Oic3IDXFBScM7APFT+WyQ6MHYKnEoNZD9fCjucg01AsI/kzBy/s0HLJz
         XNBlELkL7924oCo+1GaOedaZoU60KVjKjC8/BgztVegvWUIvrEAXFPAG01DJUmJQRjXz
         ns6TqJIklOJ18lL8snJRx0OtkDTmnymTd/5S95ol+WokP/vAlp4/GLzDVO51j2J0Om8Q
         /2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUGAR5Nawn9Alhj28LgUE4m2UJECfg0pWAzt4CDMBMBXjFLbyt067ekCHTKnuTigZaV+2O2teE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4ZcnhqgSk/ech0KwBidmVHTt+wGgAudnpuOnxmhHxbCfthmX
	+UepWazUdOXa1qXKMslWVmanSIEAPv0vqtKdlwrpVGW8Gr1ddwMwyBLV
X-Gm-Gg: ASbGncsR9fLgg1Lpo9pV0kWHDsFXH/jg+ZYF4B6xGFeqh/pRycI+RNckJeizmqOpKQz
	1IZEcIj20JuLItmFhrH01OLZvimxOA3GcYet2OhXlBs6+JMn1UkaiceXAEBBkLPOzq87qjcwD8x
	eEj16somsjknd4R0av1CczCtHWfb1hYpB8mclO8SjZ3gg+YL646IS++wffAA98oa/DigEwWWty6
	YGIhA488RfDCqc+HnUxLrmQg5DWxM2ZRTHMedyGWecgHPiA4BRUEo9ajf2f1MIGW8zhxm7MPXR0
	bXhHETht2TGr438WzRH5vXLlobCPmbd+iBZk7FtBjd2oTR62/TOrxRLhPuwq7fMqgLhSSTAyilT
	uxJisWokyoFAHSapn+VzzHV7WEBvwuHKNF0RrCypfunG+zu49Dw8gf/K/CpnRzW2tBwRWu7qr73
	NuUEfxsSMA97lNgh3vbCZOeaHlLLmJTZO+nje8+6rfyNm6HqKkZf0pXhy7dtgUfILDQ9RXsZtAT
	oyi+dM9U322u6IB2uERfvSVVRcEiaivso2zgL9uxGtuTWI5Jjxjkw==
X-Google-Smtp-Source: AGHT+IH33A3IZf5JH3qGVGFsjIEcTWzgSwfEhDPkDUgrYDxBSHDFAWfg2IEswXtHcRF99P2jtkDStQ==
X-Received: by 2002:a17:907:7286:b0:b3c:a161:684c with SMTP id a640c23a62f3a-b70701055e6mr122986666b.2.1761860369354;
        Thu, 30 Oct 2025 14:39:29 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f48:be00:f474:dcfc:be2f:4938? (p200300ea8f48be00f474dcfcbe2f4938.dip0.t-ipconnect.de. [2003:ea:8f48:be00:f474:dcfc:be2f:4938])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8534d99dsm1855428866b.21.2025.10.30.14.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:39:28 -0700 (PDT)
Message-ID: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Date: Thu, 30 Oct 2025 22:39:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/6] net: phy: remove fixed_phy_add and first its
 users
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Hauke Mehrtens
 <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Chan <michael.chan@broadcom.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fixed_phy_add() has a number of problems/disadvantages:
- It uses phy address 0 w/o checking whether a fixed phy with this
  address exists already.
- A subsequent call to fixed_phy_register() would also use phy address 0,
  because fixed_phy_add() doesn't mark it as used.
- fixed_phy_add() is used from platform code, therefore requires that
  fixed phy code is built-in.

fixed_phy_add() has only two users
- coldfire/5272, using fec
- bcm47xx, using b44

So migrate fec and b44 to use fixed_phy_register_100fd(), afterwards
remove usage of fixed_phy_add() from the two platforms, and eventually
remove fixed_phy_add().

When I proposed helper fixed_phy_register_100fd() first, there was
the question whether it's worth it, and Jakub asked to submit the
full series:
https://lore.kernel.org/netdev/20251021182021.15223c1e@kernel.org/
Apart from this series, there are two more places where the helper
can be used to simplify the code: dsa_loop, ftgmac100
I left this for a follow-up.

Heiner Kallweit (6):
  net: phy: fixed_phy: add helper fixed_phy_register_100fd
  net: fec: register a fixed phy using fixed_phy_register_100fd if
    needed
  m68k: coldfire: remove creating a fixed phy
  net: b44: register a fixed phy using fixed_phy_register_100fd if
    needed
  MIPS: BCM47XX: remove creating a fixed phy
  net: phy: fixed_phy: remove fixed_phy_add

 arch/m68k/coldfire/m5272.c                | 15 -------
 arch/mips/bcm47xx/setup.c                 |  7 ---
 drivers/net/ethernet/broadcom/Kconfig     |  1 +
 drivers/net/ethernet/broadcom/b44.c       | 37 ++++++++--------
 drivers/net/ethernet/freescale/Kconfig    |  1 +
 drivers/net/ethernet/freescale/fec_main.c | 52 +++++++++++------------
 drivers/net/phy/fixed_phy.c               | 18 +++++---
 include/linux/phy_fixed.h                 |  8 +++-
 8 files changed, 66 insertions(+), 73 deletions(-)

-- 
2.51.1


