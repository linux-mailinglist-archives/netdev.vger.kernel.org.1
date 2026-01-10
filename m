Return-Path: <netdev+bounces-248706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E07D0D86C
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 16:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 854623004624
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FE5262FC1;
	Sat, 10 Jan 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQDGZUp8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93B3446BC
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057955; cv=none; b=UuytKNhPcNBOugtvoG+V+LiNDw8Me6JWH87H5gWDL0yOdV7Tx0h3MWdAU4kuuO9nhsZRqucYDtfmYjNATZ9XSTpaeXi7hxUX1moeCDt6ig0QcBlmCKKASWbssQlxzsI7BSQ1u7nrwx0EFkyn8Kfp+CvfzugkIMKpN/BIWW09VLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057955; c=relaxed/simple;
	bh=XB7AM/+LrjvMeDFalNsdkFwFF+VBCQ5UXesMO1g9eH8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NslpXcSP+LIU5/+OUP2erX5jk5ehlbTgRpopX01Q1TfTwyBEitS2yDV1ATafFR8xTD1m3BhG+lsWHqFumQxSaXnyuXcShQqQsCJf8I1xTF54PeYk/H2fUILpcwA/KAf+mGcgX4fi3+wOk9Luu5HBBBeIo6NWMH1a6bfgbXNVECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQDGZUp8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so38048945e9.3
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057952; x=1768662752; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnsUPIzxpeObbBHHXqUzBTOfrh1uEICQSF5gw6YoVPM=;
        b=iQDGZUp8wndoVAGt8thFwhgImbB0xqZddQKLoIxol2hM40/XHGjy3skJ/dM6cVatyE
         3HgpFbZmM1q2hkK8rkuTitjXD0QeO37YBlMU1BcJOCbCpX+BEONX7X9zg9FiGqKXRb1U
         c9uc7iw8Ui+ZRZqFXIa6O0i6wSSjEUKwRbes85OYPlTa+CygmMcrow8S4fb/Emk7SovZ
         rnLzPKCOgARPnhg7kt0Kt+DbFMZxlEIaiJ4c+kPGFTycbpqNR7Wike/SvSHRq1oDLCcR
         6UpTvBsWfMN6PHsBKNuJZcIpg0B7YZZnQAa36Lij1wTMntgErUvE3i5xVC3iI8Mw5cJr
         92Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057952; x=1768662752;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnsUPIzxpeObbBHHXqUzBTOfrh1uEICQSF5gw6YoVPM=;
        b=xLKp2cRMKb8fLem1WzjHPSmgq1f4XeY+3jemlRl0zqT1QymUbQ9e9pB/Dz95H6esRz
         KJXmE3eP3UtlH3Kdx5txQ6e7qZhRiaH7HBsCjNW9QeMJHyl3Px186MvBXhKVucYgTgdY
         NN6J3/oWrGw1U8XaAOGNx+DONQ9BFlj3PcnWKgJuFk/yFc0ZwzHSUjwngewo4d4tbRze
         3OlcmsaQgF/sMIIUu1cZdPmKSWXzRCGMKtzAOF3sUW/V8jE/vllodB1muMaub21KjFsZ
         KK3dQb0W6sE+CG2LTdfvneSHyrs2dux4hlpEfWcwcnqXj2+mJtJs636Bn8NWMQ++BNQs
         /rRg==
X-Gm-Message-State: AOJu0YxBgOvzywfqqVf9j9lWw36j71ex4fs9Ehjp8JnBje1yBO2dNk/2
	COf8uRRceac1trdqIIaFTql2D3wc5cJyunhnWuJcMCFPDqCcJX2K7PqA
X-Gm-Gg: AY/fxX7zn4blC5O5CObtOgVC8RBRfnvrhMNP20+ovuY33ZXARfycfl4scf0zNgbwAUg
	zcjlxSCa+6G4vuWrPeeZ9XdPAdDgnO2K8t91IF6LkYNSpy8tbNOqjBGrnO/hj4IVOiTNwy5MSM8
	1IxGDJzy+X+HOC3nvrFcl213UasROd5WTVkF7jlXf5NBW0XjBHZ8OPfjLGOB227gyEzuHLzDZNG
	GzzeHCNGJNFen3aU5k7K/bjLxdHEDJDJDD8p6i/KJcmxbiq+vcusaIrNMsSmDSY6oQE2g3/CR7o
	WY31xrfUMOg2XuI84twBT9UHcQ7n6AoqSIuNk92WsSNtlrtszAte59E2IvA+cgCC/vyBX2HBNkO
	GJr18JQKKCxXXsVEqcSH4p26HqUtF670IEReJIISqvc7u2ZaHBQK7BCPPTMtPM0tbT3vKrE12oV
	LSeChHXU/0kiG2eQfoPfvYnVlGlOzt9plA4PUGMmcGy3j+9/nASvljZlhhMdqYpIvBEWydBgLtW
	Vbe2hRME62a6o+TaY5GriC4rq1a/8rQ0adUv59b3ua7R8pYXGJt9g==
X-Google-Smtp-Source: AGHT+IGyOx8GWV2VTQC8/2wIPeoIjWjSFldInfB0eQgJPiAac68O5gBXDQPD7MGhMainCO8yNXYNKw==
X-Received: by 2002:a05:600c:3493:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-47d84b3471fmr144284015e9.17.1768057952109;
        Sat, 10 Jan 2026 07:12:32 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1c:1800:8cc6:804e:b81b:aa56? (p200300ea8f1c18008cc6804eb81baa56.dip0.t-ipconnect.de. [2003:ea:8f1c:1800:8cc6:804e:b81b:aa56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d87166d0csm90873145e9.6.2026.01.10.07.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 07:12:31 -0800 (PST)
Message-ID: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
Date: Sat, 10 Jan 2026 16:12:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Daniel Golle <daniel@makrotopia.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 0/2] r8169: add support for RTL8127ATF (10G Fiber
 SFP)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
DAC). The list of supported modes was provided by Realtek. According to the
r8127 vendor driver also 1G modules are supported, but this needs some more
complexity in the driver, and only 10G mode has been tested so far.
Therefore mainline support will be limited to 10G for now.
The SFP port signals are hidden in the chip IP and driven by firmware.
Therefore mainline SFP support can't be used here.
The PHY driver is used by the RTL8127ATF support in r8169.
RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
PHY ID.

v2:
- move realtek_phy.h to new include/net/phy/

Heiner Kallweit (2):
  net: phy: realtek: add dummy PHY driver for RTL8127ATF
  r8169: add support for RTL8127ATF (Fiber SFP)

 MAINTAINERS                               |  1 +
 drivers/net/ethernet/realtek/r8169_main.c | 89 ++++++++++++++++++++++-
 drivers/net/phy/realtek/realtek_main.c    | 54 ++++++++++++++
 include/net/phy/realtek_phy.h             |  7 ++
 4 files changed, 147 insertions(+), 4 deletions(-)
 create mode 100644 include/net/phy/realtek_phy.h

-- 
2.52.0



