Return-Path: <netdev+bounces-224610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EC9B86E1B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99E03B4795
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422C32D63FF;
	Thu, 18 Sep 2025 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="idkAdHuL";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="idkAdHuL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80D3090EF
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226832; cv=none; b=LshlxGdBhdbGTP93Cs2vWYWcE36j02fmIL8HkuaI9pHkikH3tkJu9miTvzdpY1rU1fZBtI09EZ/AEXOL6OfpejmsqsPL75Q6lh0jc1Aaztcj8P41i7R6TCYj6d4sUmsdY35mjhBwVr/1NlsCNkKwc7CUYCt/BEJ2rczucGGosWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226832; c=relaxed/simple;
	bh=Iz1O6jfjq1q9VqakNVUVO7uZ4sHU1u3uu4IY4c2AODg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ep5wmJ00VxN0MdrIVpCjbb7OjSMABPFyEbD41snCtCnFnAGez6IfO3rsK29y6F+MtdgmaOsQHnPgZPIfPHI1cOHjmfMwbRlHy01hkZuTW2P8Gxd8D30SlY4W8rTsUuDB3IlG+qWWgSBxeNrqB6ayvpBcWeQpFlKupUOH8h/mL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=idkAdHuL; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=idkAdHuL; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1758226287; bh=Iz1O6jfjq1q9VqakNVUVO7uZ4sHU1u3uu4IY4c2AODg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=idkAdHuL3LERu69pldFSTewZEkM2ke2QlZR8x3wLMExFHvq3v28C00mmuWZtn+QUn
	 eiTw4pD2Od7CeYDMMY7vXIPAw4MFLnzMkpIhAjgCNiCsxwH3SPv4NSgYOvS6Q/Hr6v
	 N08Xf1Nc8bcps8ZPB1eq+PKJC8WOnA+j+ztxd4GZFj94zHDwE9VAY4Ra4B4GJ7eemL
	 fYs8OfYQ53jk3W64OD8//weQjsy47BKG4k4YxDN1Wz4lr7iKZqIL57hF3XU89wyI/8
	 yhcPYwZ3ibt0CiwmEzBEcTmatzqkJvTXZ7c6y+2Jd+WIsSOInaj66atOwHNfi9bJ3y
	 vU1qIJ0k/wCWw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 762393D55C1;
	Thu, 18 Sep 2025 20:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1758226287; bh=Iz1O6jfjq1q9VqakNVUVO7uZ4sHU1u3uu4IY4c2AODg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=idkAdHuL3LERu69pldFSTewZEkM2ke2QlZR8x3wLMExFHvq3v28C00mmuWZtn+QUn
	 eiTw4pD2Od7CeYDMMY7vXIPAw4MFLnzMkpIhAjgCNiCsxwH3SPv4NSgYOvS6Q/Hr6v
	 N08Xf1Nc8bcps8ZPB1eq+PKJC8WOnA+j+ztxd4GZFj94zHDwE9VAY4Ra4B4GJ7eemL
	 fYs8OfYQ53jk3W64OD8//weQjsy47BKG4k4YxDN1Wz4lr7iKZqIL57hF3XU89wyI/8
	 yhcPYwZ3ibt0CiwmEzBEcTmatzqkJvTXZ7c6y+2Jd+WIsSOInaj66atOwHNfi9bJ3y
	 vU1qIJ0k/wCWw==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id F04BE3D4D3E;
	Thu, 18 Sep 2025 20:11:25 +0000 (UTC)
Message-ID: <64ea0259-30a2-4264-8c05-8fd7df113bb5@mleia.com>
Date: Thu, 18 Sep 2025 23:11:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] net: stmmac: remove mac_interface
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@csie.org>,
 "David S. Miller" <davem@davemloft.net>, Drew Fustini <fustini@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>, Fu Wei <wefu@redhat.com>,
 Guo Ren <guoren@kernel.org>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Samuel Holland <samuel@sholland.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
 <E1uytpv-00000006H2x-196h@rmk-PC.armlinux.org.uk>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <E1uytpv-00000006H2x-196h@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250918_201127_506365_0BB65E3C 
X-CRM114-Status: GOOD (  11.00  )

On 9/17/25 18:12, Russell King (Oracle) wrote:
> mac_interface has served little purpose, and has only caused confusion.
> Now that we have cleaned up all platform glue drivers which should not
> have been using mac_interface, there are no users remaining. Remove
> mac_interface.
> 
> This results in the special dwmac specific "mac-mode" DT property
> becoming redundant, and an in case, no DTS files in the kernel make use
> of this property. Add a warning if the property is set, and it is
> different from the "phy-mode".
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir

