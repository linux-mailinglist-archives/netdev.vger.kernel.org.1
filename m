Return-Path: <netdev+bounces-191794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B251ABD457
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361151BA09AE
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF525D216;
	Tue, 20 May 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mg7bPV/N"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A920C473;
	Tue, 20 May 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736259; cv=none; b=kphW7rZtZIJoVgF5ecTgiAGXNLV2lZ3LovdGf8eDfGNINmLQVqfIN1SdwAjoMwyKhB7mTonQ7bwEcHIPSWqtWPUcaRp4dCHCIMr7+CVP6xin7oSOKnFBV3Ni32tl7nmcHPCTb+NvGc3UYDIA+NBPXj5kcQCPd9tPBl3Ulcy6LAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736259; c=relaxed/simple;
	bh=lztmPtS30ZevqKydVmDOVzb5SAQsRr7i7DGMRE/a6g0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tAOOZHr06rew+WxdKOZtx+U0s9LFLA/cAFkeJbdMAEK4ue079oU1+/OWnVE0twgKMtQzn6Ko46AsaIiFiz2CixGaSqbcY/7KR091GPaO2NeqHdaQOb36TjxC/EgHjo6ccAjrtTkSJs1C1R3Q7TZrEb/SALHlTKrxTJROQy8Zq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mg7bPV/N; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747736255;
	bh=lztmPtS30ZevqKydVmDOVzb5SAQsRr7i7DGMRE/a6g0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mg7bPV/N1atkKzr5TpefdCZ6m5af5Z6H9Yjk/qPcAq/nTiw7g7hXnT0c+e3n9Zihd
	 ruhWleo4pvMpDHB2arOe1i5JBSTRqGaapLkjcFlNDEGg7GIU4WrCmuEf1O0qsmRaVa
	 lk4/yzYgvhRz36rmEmChHlrB93zm03X6vzn0/CjVQOAmWz0B2uE723L+JA95wPGVZe
	 f30PUeLWGOgp2TSn8Y+oXQrgouDo9H8YHtte75OdWTb87MNwM7L+8pMjTYtPSfACDF
	 nuVu+ty7fypQ1LP1g1RTM7l/6VxRQfjqfoIdD4yUy74xh0oo1S0l6ZNDc6Q/j9Afg4
	 Tprrzi/8NV2Uw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0A2E017E0FA8;
	Tue, 20 May 2025 12:17:33 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20250516180147.10416-1-linux@fw-web.de>
References: <20250516180147.10416-1-linux@fw-web.de>
Subject: Re: (subset) [PATCH v2 00/14] further mt7988 devicetree work
Message-Id: <174773625395.3349397.13086242383163646813.b4-ty@collabora.com>
Date: Tue, 20 May 2025 12:17:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 16 May 2025 20:01:30 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This series continues mt7988 devicetree work
> 
> - Add SPI with BPI-R4 nand to reach eMMC
> - Add thermal protection (fan+cooling-points)
> - Extend cpu frequency scaling with CCI
> - Basic network-support (ethernet controller + builtin switch + SFP Cages)
> 
> [...]

Applied to v6.15-next/dts64, thanks!

[04/14] arm64: dts: mediatek: mt7988: add spi controllers
        commit: 21e0977b4c074c393205b601509574820e534122
[05/14] arm64: dts: mediatek: mt7988: move uart0 and spi1 pins to soc dtsi
        commit: 35818d5038e8003745f31d8a535dea245483b61a
[06/14] arm64: dts: mediatek: mt7988: add cci node
        commit: 05c81fe3a6aab2a9df7a067b035ef7f269b66e24
[07/14] arm64: dts: mediatek: mt7988: add phy calibration efuse subnodes
        commit: 22ebf43c4eef099beffc510ec0b2a2549668d8e5
[10/14] arm64: dts: mediatek: mt7988a-bpi-r4: Add fan and coolingmaps
        commit: 1b8747157f8eda93545163f0401d9493780026fe
[11/14] arm64: dts: mediatek: mt7988a-bpi-r4: configure spi-nodes
        commit: 91c09be53d9a66cc93e998d8c3252dc4ef469ae9
[12/14] arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
        commit: 2bb566a7f04bc775120d016a232d6b69005f3c97

Cheers,
Angelo



