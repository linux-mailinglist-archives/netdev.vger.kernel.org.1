Return-Path: <netdev+bounces-152618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599499F4E39
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73795167378
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5451F706E;
	Tue, 17 Dec 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqHQ23rN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA11F706D;
	Tue, 17 Dec 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446950; cv=none; b=kwJMwkjUuEHal77C51Uhj56WdaEPG8iAOxi6Woomhj1ZPfMtdwwqrJobdz6WCz1iH3qz2o98JNYPR68Kzb44adM5cRM2Dl8u0g7cy8wWmvGRCGE6usDnQVqt+z5YR9P5SQXhQZtIONebRGhd7Wqb7aLKO/yqP5OfABdbfbeDQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446950; c=relaxed/simple;
	bh=S5/ik6fbwrpyH3KSs+GVUj/CwVH+gNMOhnzP7q730h0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjhSxD6hYhFUp6kwxtn9EI+tiMbsr4SWz/o/FEt0LlR6cfqjEI8RC4riFbzLsCnwocmvD5oSSRN7oVQ/j4rrnytOeVgR5FovD2K5rcNc1g1aJJiTaEskioWv9SM5nC2PObF0jCFU11wfh9i7HDo1/Ln3+lw9Y1pDaD9rcXyiclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqHQ23rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC30C4CED4;
	Tue, 17 Dec 2024 14:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734446950;
	bh=S5/ik6fbwrpyH3KSs+GVUj/CwVH+gNMOhnzP7q730h0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IqHQ23rNJvtV2zSWtz1Es0/zYfqBOVMSlTnIkbbPmk2R1d5jMnegR/jaVbOQdNwy5
	 FVMq/xQd+jsedpESIGo7NCI+aQtoUtPuU4EcrT9DeTBmDfAD+h/at4RRBKhpQx0w5V
	 /mj54HSZ1Cf0TzeGBfxwsSywidecWbwuBpOd4MY6kcKUsY6fOihCe+DXedu6u0rHV7
	 upgf8hqlwkc9fm/M6L00ZcFJKs2XC2JRXZJCdeacJ3PKJagahHY/fjLsE9YjOLiXy+
	 0GOsrJH+VuoIhHw9kzWHb/6mIVDM3SZZTxhTIBN4Cuxw7LnRu1ABU0nBAz8s3An6Rf
	 WSlKf7rBrlnEQ==
Date: Tue, 17 Dec 2024 06:49:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Set interface
 modes from Lynx PCS as supported
Message-ID: <20241217064907.0e509769@kernel.org>
In-Reply-To: <20241217135932.60711288@fedora.home>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
	<20241213090526.71516-3-maxime.chevallier@bootlin.com>
	<Z1wnFXlgEU84VX8F@shell.armlinux.org.uk>
	<20241213182904.55eb2504@fedora.home>
	<Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<20241216094224.199e8df7@fedora.home>
	<20241216173333.55e35f34@kernel.org>
	<20241217135932.60711288@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Let me triple check ;)

On Tue, 17 Dec 2024 13:59:32 +0100 Maxime Chevallier wrote:
> - The priv->phylink_config.supported_interfaces is incomplete on
> dwmac-socfpga. Russell's patch 5 intersects these modes with that the
                                   ^^^^^^^^^^
> PCS supports :
> 
> +		phy_interface_or(priv->phylink_config.supported_interfaces,
                              ^^
> +				 priv->phylink_config.supported_interfaces,
> +				 pcs->supported_interfaces);
> 
> So without patch 2 in the series, we'll be missing
> PHY_INTERFACE_MODE_1000BASEX in the end result :)

"Or" is a sum/union, not intersection.

You set the bits in priv->phylink_config.supported_interfaces.
Russell does:

	priv->phylink_config.supported_interfaces |=
		pcs->supported_interfaces;

If I'm missing the point please repost once Russell's patches 
are merged :)

