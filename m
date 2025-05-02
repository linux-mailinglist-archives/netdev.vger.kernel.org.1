Return-Path: <netdev+bounces-187501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA41AA77F3
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32997189397E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E351A5BBE;
	Fri,  2 May 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g67pc0bP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE328E7;
	Fri,  2 May 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205510; cv=none; b=QWQHOVYX+bPYl4EzoLICoaag4FWuvioKo/g9rF2MLw1ix+VbJ44jjs1OuuqhhA/OKcBDULmwq4Yk3IiDiIOqAS4zyvoFjLtBLE6uM9AbD/oymaKODgqdsTwgOU4qZm84Bk8zZlLtc0Fw7QoNXb9Er88Vbc5JjLbD49SNb4ZBLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205510; c=relaxed/simple;
	bh=ek3lW6S6ZXPfwiXtViPbi2/fuP4PwGB3UcVaXyxgnck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcFzsN61h7esA02F34QIhbVTATLvwH1BYw2CB30NmMhr9aQlIdxrGAMfZRJ1bKpka8X40yGXAdsHZWOV2u6Y2OjJqIkAZUIo0zzkZW0V8YOVz5ruUhjPm7xYiDLbghQ8c27SKEU/eR6Bk5dj17P1HjIb1ddnkZaYD7rUNLORf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g67pc0bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24688C4CEE4;
	Fri,  2 May 2025 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746205509;
	bh=ek3lW6S6ZXPfwiXtViPbi2/fuP4PwGB3UcVaXyxgnck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g67pc0bPZYbRvCZLgYd62jYJ7v2/yoFtWcawBDZNlz1eJUQiE6HKBhu1UKw0qVoKU
	 E8ujvyItq3hjRADZN8atRqNR4pe/tf9TsplXl3F9kRk1hdoY0tcDuZ3JrPQYUp+yQs
	 DZ3fhlRtBrFiMok2K9xWw1FbRp5iF2f9Khp4dJjz2bMDdyXdE46MwBTlRkQ6aIWiGq
	 QIq059SsE2ypCxhlzXWARCCxGcEofL3vUzyaP6iXmC8RHSL3S3gAmiuGbwMCTQJuph
	 OCRLKv0mNKQTOYSO0mnwYPrX1tsDFun/3b3qYAispqSQDNvFF0W8TYSh/HssAEnhHG
	 C6MyJSP1qkh7Q==
Date: Fri, 2 May 2025 18:05:03 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [net-next v10 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250502170503.GN3339421@horms.kernel.org>
References: <20250502074447.2153837-1-lukma@denx.de>
 <20250502074447.2153837-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502074447.2153837-5-lukma@denx.de>

On Fri, May 02, 2025 at 09:44:44AM +0200, Lukasz Majewski wrote:

> +static int mtip_sw_probe(struct platform_device *pdev)

...

> +	ret = devm_request_irq(&pdev->dev, fep->irq, mtip_interrupt, 0,
> +			       dev_name(&pdev->dev), fep);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, fep->irq,

It looks like the 2nd argument to dev_err_probe() should be ret rather than
fep->irq.

Flagged by Smatch.

> +				     "Could not alloc IRQ\n");

...

