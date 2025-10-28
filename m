Return-Path: <netdev+bounces-233477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEB1C140A1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13AFC4E8040
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCF2D4813;
	Tue, 28 Oct 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZE6JGDOo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9019E82A
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646593; cv=none; b=CjfBDbdSOLss6WcsJSVr97tKiJyU5tXH3yyLXQz+6oPheTHq+cns+QRdtYh0n04WvMNj3JzB6GwqDl/B/bOyHoQQ1qFI+sUiOrSUO6CrYFJ2T7Ozyt4yY4BqnwV0ag8WDOPIz7/AbSylLnHkxQgIx0YAodfG7NxzLiF+/Aq+7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646593; c=relaxed/simple;
	bh=qYkSNjVRC4huW3BOIeZ7ligdjSUf5E+H3Pi1sGaKGTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjnMOVb9soolFMh6weU7lCiQ/PecwA8YVGincC1VSY2vbtQGqukPhk65Un1w7nbVe3X0wVar6vFpXDNBpnXhQweos46F2pMMn3zOFEclx6idSk82hXGFEzuVBHxUK5L4VAHEuKvzSasIMfH3Yxdn1mTC4U9hM/gz+Xeu//JAojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZE6JGDOo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AAF79C0C408;
	Tue, 28 Oct 2025 10:16:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3F8E606AB;
	Tue, 28 Oct 2025 10:16:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7D061179B09A;
	Tue, 28 Oct 2025 11:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761646587; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=qYkSNjVRC4huW3BOIeZ7ligdjSUf5E+H3Pi1sGaKGTU=;
	b=ZE6JGDOoX/OJXZ0LOEM3oy69yMuQAYK5M1YXgue5oYH7XCOttwhDf/7shVjzM0SdXm8+Y/
	hgJl5upKofTjs1nPPeCSZMI0w8W/bWyYCZsHzRc3+HasMQpH1y6E91LjVGmZ1G1AAZxx15
	hRZGUGv/VQ6fDfuVF7azTAiIBjrBC/x9XllDyp+Fwg8i6Ys7XnxMwCz4u+KInwxcIn9Yz2
	Db9c4onUPoBG+GVDsrFLGJbNWr2kpHUGZbtxGajI53YPSaUi8EyWJKlXiElJ1vgHhawgVn
	/H69KBXCwRSFqJ5H4K/R/Wq9gtHsM0SbutsmVmBSwIDJq4SE8h0CF74QvLROjg==
Message-ID: <604b68ce-595f-4d50-92ad-3d1d5a1b4989@bootlin.com>
Date: Tue, 28 Oct 2025 11:16:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: stmmac: add support specifying PCS
 supported interfaces
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexis Lothor__ <alexis.lothore@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Furong Xu <0x1207@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Yu-Chun Lin <eleanor15x@gmail.com>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <E1vClC5-0000000Bcbb-1WUk@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vClC5-0000000Bcbb-1WUk@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Russell,

On 25/10/2025 22:48, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Maybe this needs a commit log, even a small one ? :(

Maxime


