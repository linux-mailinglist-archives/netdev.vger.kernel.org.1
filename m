Return-Path: <netdev+bounces-135907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF2C99FC01
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782331C26297
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096411D63D0;
	Tue, 15 Oct 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qd2vWfI3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A121A0B07;
	Tue, 15 Oct 2024 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033329; cv=none; b=HYsEynOQbOAVVURWAvyEbtjKnJNE4Z4oDcQD0UkLB6hvQ/epsoCqKqrgMEFrkQHdBD4NzCaPYyCmt22rNyDrg42RbdImX4ty0n6GhYzDh67K2QnAf4HFiiakBPTC+kvcjhXB6kkvfBeGg7jN99IbEQCLrsPNi7NgT/pKkHYvi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033329; c=relaxed/simple;
	bh=sxqU6EcUk8DvoT4B7jYVxfYQVgW1xGwF9+1H+ah6yg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1BwXNWwsTqoAhmUMNvecXCO97H7fmsAzJtQQfiNCeqlSskdqN8IPVTqAkpEdLjtvKHqrDJa8oDO4ERmUdyJKS3Yv++Wso9FfTMeHNz3jt9o3RG9dGoFQsgaBsBcBD689tvWfcAxuaeXILmWYjTu3CqwKHWVuB9Fq+z7KLSaEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qd2vWfI3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mUFuUDjPLb+T13crf9T6WeNqvmmZOjE+1O9AdsG9ipM=; b=qd2vWfI3e7rgHEMZNX9dxj2kbz
	Ic4V1IerIJC807KDM9PXjN29Gle5kMyhV1ByvlEoDQekg4sZHMG/+XoUuhCIPojHxa59pIrvZVqPb
	8NxmDPdTHh2tyJcY4FmarWCIDbaJ7HoMKpoZz5026Jxbz27r45lXKV5YjiXzMkNVcQ9s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0qY1-00A5JG-Cn; Wed, 16 Oct 2024 01:01:49 +0200
Date: Wed, 16 Oct 2024 01:01:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Richard Cochran <richardcochran@gmail.com>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Jianguo Zhang <jianguo.zhang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Hsuan-Yu Lin <shane.lin@canonical.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	fanyi zhang <fanyi.zhang@mediatek.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8390-genio-700-evk: Enable
 ethernet
Message-ID: <0e72a636-19e1-4f2d-8ea2-f1666c525400@lunn.ch>
References: <20241015-genio700-eth-v1-0-16a1c9738cf4@collabora.com>
 <20241015-genio700-eth-v1-2-16a1c9738cf4@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-genio700-eth-v1-2-16a1c9738cf4@collabora.com>

> +&eth {
> +	phy-mode ="rgmii-rxid";
> +	phy-handle = <&ethernet_phy0>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&eth_default_pins>;
> +	pinctrl-1 = <&eth_sleep_pins>;
> +	snps,reset-gpio = <&pio 147 GPIO_ACTIVE_HIGH>;
> +	snps,reset-delays-us = <0 10000 10000>;
> +	mediatek,tx-delay-ps = <2030>;

Can you set phy-mode to rgmii-id, and remove the tx-delay-ps property?

    Andrew

