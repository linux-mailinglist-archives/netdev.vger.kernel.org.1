Return-Path: <netdev+bounces-166189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125B5A34E44
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889453A52DF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEDF245AEE;
	Thu, 13 Feb 2025 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuOTqbwB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831D15252D
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474019; cv=none; b=b/5APcBaKM3+GIPKb8j9ObFSeTZDUsZXY17lANkh8rnDN1n9tNm/qTVpIToWW1EoR7gGbCVh4YZzdZd4YCFQt5zbeb4UUV58UE+kBqNFp6z6fe5UpLWFkF47eWbVJ9xtoKH8Q0mD6e/RQKVQLzLnA/cAfrvSo6Ct6RAt3h5b+Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474019; c=relaxed/simple;
	bh=myqxPbT7l07+gyMYR8nvxo4kPwy5QkEG9BIQJweMRCs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=EybdoEw6NjMDfbspIdKdPgIOQYNFbKoAQa7PnL6OOndSvvdb1BYlwqKORTKFHnSllteXTc8Kr4urStSMgKUxOzEX2JEB7FTXIS3sufbIGgblMDwXNUux5sWbRt/AeZlH8IW5Lk2xbA/dRGvyDxX7ARABBmAq0bIfwIJL+ZNQvo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuOTqbwB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7e1286126so229147866b.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739474016; x=1740078816; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nwrl6QSVn5BcC1WG50dlm1v6vha1Ybi+hemQFsqdun0=;
        b=NuOTqbwBULY3fFBfk8i1ygDdUItOz1tdgfRtpWv8/dI09vvgYaBXJrkcAktHdGYqIg
         tfTufnVFJoYSO22PDOz7kMAJv+6e8dVUoW6bWCfoWT5ZBWbga/Rcmx1v6Omi+g9eB3H3
         gP+/snk/BOhtGJohXdMs8XCwDo6DIpzqJu+vDd/SRICVBOOliZZWwUvb4UXEvGlkY9Dq
         yIXdYl5h3hrBTzhDMMAEdmVNkO78a/+G08QS9BUrEHduNdV1YW03wTlhHcPmvcn+iuSe
         jZEYqTcaLUMkkh60JH128DiNtzSTS6DkXoG63an0ER59WmigEgy4Ncyw5hvzQqcD0xj/
         RuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474016; x=1740078816;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwrl6QSVn5BcC1WG50dlm1v6vha1Ybi+hemQFsqdun0=;
        b=NWltS5xyxXCRhTqZ8DbEMNWv4Jo+JzYu8o/8WcQYnopIUtPLbptwjQ+N4lGpzCN2Pa
         k9Kx1sGVTlJyblY1rqsRfxfCPrUK/S48qRNfV4P8HyQ7W7NSOLob1PMr1vxC3NbNysxs
         +mFCFXO4BHb3LajrK0gB/nYBYR16AvDCOgLmCxSHPCIjrht7nlhlbQYFgWIR5EctpFLu
         YK7M9xfJBWQxS1yoqFIbunL1Lr5L27WbTXi1WCalTRMLJG+txuMvfw0du9DbVE7vtQAt
         u3yUi2qyXm70g7VD8PZpB2LWbTm/sFemWTEdo5JSTz9S/IoypN2rb2vqeU2cWwhlrVfW
         hryQ==
X-Gm-Message-State: AOJu0Yy4U1zPoqNZic4Mi+BOR1wtIxmtMYXvBeLaEWayc6U08TXENYGO
	C2BDU2vnNlrH0JlZ77NdpQDIDpa+ZfINesQ1EvCMCijcrj23IIeZ
X-Gm-Gg: ASbGncv/tBz2FJZyrbfAXl2jg8AtD6jzjOKLgLP41j4DaRsNBnnn+D1nKvDO45hLwUW
	GwJnOK5eQgzgh50s1R1CN+nbSOSKdHPMMLsWrW8JqbOmdPIhw1HSaViyBbA7J53m/d3456/gGe8
	29qlqruulTgvG6c4/o4uwVhSn7RZ3Fc871Ps19Z2O3Vh4IQ4kQVrNUqO/ZzPoGASg92Zaw9qZKO
	u6TBwqMzVEgwA340i/EVvaJ9UgX3/tdLjk4fJr/wNaLfGDn75EUDFFRqfBrf9p2+GkuhO5hLAWN
	F+vjFHhGMoauIH0dx9umSUX6RO/KkftW7u9P0HBpcFGVXUxX0h5rycgoShaaPpJW83W9U0x0Q2L
	X4hLx/ds4gF2EHMr1VhdecogyTIN3mMLXLiL595OWh9THAGOMwzgs0tLsA+kO2+wxgSZWMABY2T
	uHtqNG
X-Google-Smtp-Source: AGHT+IGiWj/pjTnEfHLSfUmTapKcNYPtWyxw2vzblrHCYjkGtsicHhvyPoKaC99UeMmRggNgfOZBlQ==
X-Received: by 2002:a17:907:608d:b0:ab7:eff8:f92e with SMTP id a640c23a62f3a-ab7f3380d9bmr832833166b.21.1739474015843;
        Thu, 13 Feb 2025 11:13:35 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8140:d035:b1a4:911d? (dynamic-2a02-3100-9dea-0b00-8140-d035-b1a4-911d.310.pool.telefonica.de. [2a02:3100:9dea:b00:8140:d035:b1a4:911d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba532581cesm182761766b.45.2025.02.13.11.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:13:34 -0800 (PST)
Message-ID: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
Date: Thu, 13 Feb 2025 20:14:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next 0/3] net: phy: realtek: improve MMD register
 access for internal PHY's
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The integrated PHYs on chip versions from RTL8168g allow to address
MDIO_MMD_VEND2 registers. All c22 standard registers are mapped to
MDIO_MMD_VEND2 registers. So far the paging mechanism is used to
address PHY registers. Add support for c45 ops to address MDIO_MMD_VEND2
registers directly, w/o the paging.

v2:
- remove superfluous space in patch 1
- make check in r8169_mdio_write_reg_c45 more strict

Heiner Kallweit (3):
  r8169: add PHY c45 ops for MII_MMD_VENDOR2 registers
  net: phy: realtek: improve mmd register access for internal PHY's
  net: phy: realtek: switch from paged to mmd ops in rtl822x functions

 drivers/net/ethernet/realtek/r8169_main.c | 32 ++++++++
 drivers/net/phy/realtek/realtek_main.c    | 90 ++++++++++-------------
 2 files changed, 70 insertions(+), 52 deletions(-)

-- 
2.48.1


