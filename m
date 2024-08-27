Return-Path: <netdev+bounces-122504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F95961890
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2342B213DF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A5185941;
	Tue, 27 Aug 2024 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+PMiXmf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62702E62B;
	Tue, 27 Aug 2024 20:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790952; cv=none; b=hROTB+adj4i8toXvMod8XoBjNSgE+N9VMH7jv8KiWdGq3PoPsvXpQdRc0uDTsaffOkc2ErpOMpREyBqJChWCU4mQprfVI9cdzhwrGwAV2Y+nI/8lAB353c2LaW1XkaQZDyZKGD6NGBCtzSwuUIhjwq6MPMzIGmMyUew9rgzhmNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790952; c=relaxed/simple;
	bh=OWYzOMG6g7t+0eoQkiYO5f3+n07R9zTk0dBvb/bLYf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfjSAH/dlRQwvqelqhmpG4WXo7bINWr8iPs+I66e1MvWiL1ov5fZkIZF07WKIDJceamu4x+0LCKZHd1LDrXZcrsdbZFo+yJIv4XJq7+7odhInjF4TfIVT9hIvQ71Sloa95TxoWzYMKlPHKm05JoCxgyrmOlUgVuhftt1xd1f3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+PMiXmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBECC32786;
	Tue, 27 Aug 2024 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724790952;
	bh=OWYzOMG6g7t+0eoQkiYO5f3+n07R9zTk0dBvb/bLYf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G+PMiXmfYwUXhJGsiUMlUFIpiNGLhwmcn4Yr2XR1okg6PP2b4RtiINnS3IFIFaqTP
	 eTQ6CASU4KpS3HFZO+7+NVbN2phjKEnT25rGE0a32dO+xrRdDYf6X6rHp9J/K4s4iA
	 bdh1jnMGGXKWUkL8nQVGONSdIr5J7Qf3Vy86ky6gFy4ZiuBHb2wcWqVJyYc7vNMmdn
	 J+4pXNMZBfHUr6QDqlPmoVtGJZvoU9BZQFqm2Ojkv+qaIAsifF0bqetEBN6BGI1zr8
	 ZC1k0XgStFmf1C+qy0qPhkb2VqnrxHjIiWZ5lEM9EiHsOQ6vuE7mkddrzEabqbn0lQ
	 mB93V0Szmx4Bw==
Date: Tue, 27 Aug 2024 13:35:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, David Wu
 <david.wu@rock-chips.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, kernel@collabora.com
Subject: Re: [PATCH v3 3/3] ethernet: stmmac: dwmac-rk: Add GMAC support for
 RK3576
Message-ID: <20240827133550.19c9eee4@kernel.org>
In-Reply-To: <20240823141318.51201-4-detlev.casanova@collabora.com>
References: <20240823141318.51201-1-detlev.casanova@collabora.com>
	<20240823141318.51201-4-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 10:11:15 -0400 Detlev Casanova wrote:
> +static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
> +				int tx_delay, int rx_delay)
> +{
> +	struct device *dev = &bsp_priv->pdev->dev;
> +	unsigned int offset_con;
> +
> +	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
> +		dev_err(dev, "Missing rockchip,grf or rockchip,php-grf property\n");
> +		return;
> +	}

Seems like there's plenty of precedent in this file, but seems a little
strange that we just print a message and carry on, without returning an
error.

Would be better to return an error or add some info to the ops
struct, so that the caller can check if the correct (of the two)
regmaps are set

