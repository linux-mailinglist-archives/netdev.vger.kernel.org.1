Return-Path: <netdev+bounces-185797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA7A9BC22
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 03:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308A14C0DE0
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CCA1CAB3;
	Fri, 25 Apr 2025 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItoprWEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4735958;
	Fri, 25 Apr 2025 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543472; cv=none; b=GG9vzJj6v3hcaZxaW5cJ9uCmTPYgmL9Ytvrr+6qg47DWtvCMLuxtXWjf1BULUpeBERjqiwEdAtWiFu62UtQD61yLxeD0APtW+1orOmJFedhEewC9SOD86r2qAgj5KO7ImysBRnp7FjjD1Z4wYv5HCzUT6txRLKgReHE1I5Shw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543472; c=relaxed/simple;
	bh=nLGs66opo0N3EZCpUzbatYQwr3fTWpeVoulS6yXDICc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOK6fVJ/AM+ua2SK0MogBBEilo1BGFV1cBPi6XCqrUpitScLoXZiujM8u4qCp+8zuMy6d78ws82Ek1SMXpVLkn4ybBb586bxA9XGng4BcSv5VufaIn4MayD/fi0BUDT5iMK6ITAzcz9nEkHzZK7RsZhZACbURVf03BFWR1ZcIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItoprWEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D6DC4CEE3;
	Fri, 25 Apr 2025 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745543472;
	bh=nLGs66opo0N3EZCpUzbatYQwr3fTWpeVoulS6yXDICc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ItoprWEXhQVfmXnGYnnfQd/7KVz/3MGTTbymR1IqOuAw4RL9yWdeVvtkFhFNI1+2S
	 M1D9SjbUawnI3/VFmowyD1LgJfJSMbX/7Yw/DsYU4ztcH1JQ0DH6aUJSaK2fcnlyAA
	 QttW+qiXmxC8OeSqh5t5Ugd5RFlerUXGET2VWuftPxM0VjPETrGsiRMtCnU/eDKrDk
	 4olu3wpqRVELbzbDHAHZuSP45Yr8eK6oxlsCI+vFrOrDFZFddqijuX7JYZQr1O6iwl
	 97PA+TEVD02Wl8HNeLe9EI2AdrV22TBzw5LV/LSCeYlZzbH5G3k4eu4RykrUg4gQqP
	 vCN2D/8n+qJOg==
Date: Thu, 24 Apr 2025 18:11:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v7 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250424181110.2734cd0b@kernel.org>
In-Reply-To: <20250423072911.3513073-5-lukma@denx.de>
References: <20250423072911.3513073-1-lukma@denx.de>
	<20250423072911.3513073-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 09:29:08 +0200 Lukasz Majewski wrote:
> This patch series provides support for More Than IP L2 switch embedded
> in the imx287 SoC.
> 
> This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> which can be used for offloading the network traffic.
> 
> It can be used interchangeably with current FEC driver - to be more
> specific: one can use either of it, depending on the requirements.
> 
> The biggest difference is the usage of DMA - when FEC is used, separate
> DMAs are available for each ENET-MAC block.
> However, with switch enabled - only the DMA0 is used to send/receive data
> to/form switch (and then switch sends them to respecitive ports).

Lots of sparse warnings and build issues here, at least on x86.

Could you make sure it's clean with an allmodconfig config, 
something like:

make C=1 W=1 drivers/net/ethernet/freescale/mtipsw/ 
-- 
pw-bot: cr

