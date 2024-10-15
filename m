Return-Path: <netdev+bounces-135621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C544F99E8DA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670821F20C17
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5B1F8F05;
	Tue, 15 Oct 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oq7Wihvi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0971F8F03
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994135; cv=none; b=MGo++kD1l0+FArFPsDmupzw4ofhcU1FAskqBbHeLL9tFoeo2SB8rwlL3Kxr1FVHiBDFLaGv+TfjbSUnFVRm9BXTru5vk0k7MlkOAUFy8o3ynycflC8+bh28U9rhaXP5hbtcdcXmC9a+eQ8eHI0/9wIInBeZgZFRwnLNW75/MVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994135; c=relaxed/simple;
	bh=LMg+qC3GpapOJTqPuu7/tbziQjUFoXkQImoXQtdY9pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFmDpzTqSgtF1I8TRxVLOmrVkeaAS6DYjieuSTTBEnFIMJ7VDstQTvVsDdM1VIrvKZ46NnyVvmOYUD7vWg/wTC36l0YMhGlwmMzGdYgKIZFAZzQ8zcI34S0DZJZBW3mqzCdshQK5wsx9eO0A919gDS+XVfxlCV9Yg/XTr++hrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oq7Wihvi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2XP5y9z+Zc+jzgswAxP/FFf9hvKLL+uAJ4Hn3GaWj2A=; b=oq
	7WihviQrPVKXcxGTit4/qgULQrRYwGRWyF+PyYkezLoWslXj2GzuLJb7AP6IidoDfsv+nPv6BqRHm
	d07M4irZbYJtD3hYhXZaLatHHzX63e4BQtnBq1qem8SdbjqntHFBI92EyS8Td7UlzFcDLCL4Ejo25
	Dl+FXtB+qDaY+7c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0gM3-00A1eh-EX; Tue, 15 Oct 2024 14:08:47 +0200
Date: Tue, 15 Oct 2024 14:08:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5ZCz6YC86YC8?= <wojackbb@gmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH] [net,v2] net: wwan: t7xx: add
 PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Message-ID: <562c8ee8-7ce3-4343-9d93-b01be1235954@lunn.ch>
References: <20240930031624.2116592-1-wojackbb@gmail.com>
 <e2f390c7-4d58-47fb-ba86-b1e5ccd6e546@lunn.ch>
 <CAAQ7Y6Z2xkgxv36=WOxbUArCw3eBeY0nx_7nAH36+Wicjs_fPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAQ7Y6Z2xkgxv36=WOxbUArCw3eBeY0nx_7nAH36+Wicjs_fPg@mail.gmail.com>

On Tue, Oct 15, 2024 at 10:48:15AM +0800, 吳逼逼 wrote:
> Hi Andrew,
> 
> We have a power test that uses a small script to loop through the power_state
> of Dell DW5933e.(/sys/bus/pci/devices/..../power_state)
> 
> We expect that PCIE can enter the D3 state when Host don;t have data packet
> transmission,
> but the experimental result of the small script test is that it is only in the
> D3 state about 5% of the time.
> 
> We analyze logs to found that Dell DW5933e occasionally sends signal change
> notifications, and ModemManager occasionally captures Modem status.
> Although these situations are not very frequent,
> However, since the default auto suspend time is 20 seconds, the chance of PCIE
> being able to enter the D3 state is very small.
> 
> After we changed auto suspend to 5 seconds, PCIE have 50% of the time was in D3
> state, which met Dell's requirements.

So you answered some of my questions. But missed:

What makes this machine special?

It is maybe because this machine occasionally sends signal change
notifications? There are modem status changes?

Have you compared this to other machines with the same hardware? Do
they do the same? Or is this Dell special? If it is special, why is it
special?

	Andrew

