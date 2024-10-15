Return-Path: <netdev+bounces-135765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE3599F210
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F30B1C230AA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5F1DD0FF;
	Tue, 15 Oct 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nXn0Hjn+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3D1CB9EB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007790; cv=none; b=dbX6rk87++HXfbG+2qSyiOFS2UDvlcblVY5R4itCqPMXiMCDufQ2qss8HWGlZyut0AUCOd7Fc9rCr8qB0B4EVA4aka9tzMbT18kzZCQzPf/meGXiZC3ib/7WcIoKxcs4Ejue1ckKjVOlP+KMIGZOv1qsn2aeKTTrJOCATfx/i38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007790; c=relaxed/simple;
	bh=A4aSlMS3npW1r8pP2wqIvP5yMZMzeaXPbcDUtBoG1/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY7yC4TELm4rbOw+bQyU+V0NjJ4lQj2gCZhCmQ2DcTbjzAGrrAwoXOOy9hJ9Bryyyr4WRbEK77VumqCRXyIxtOfjX8gjrXUrYeM/O7nCwxyxB8JMPtBFDLQRWKz3+UivS5SkBmDjstjd/Bma7wLUUelYf4L5oJ4prsMeHRcyOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nXn0Hjn+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RRX6r5xYRXgboqStl2B9PLAY7QMuBPCcEaoMbKKhPX8=; b=nXn0Hjn+54jccvb2X4iDnCTjER
	5MvwIZi4dN7zxugpOtMobRLAxxl3PcV55TCn6u6kdazyu13+x50xAabDZSxJF48t0wGkoDdt12XL/
	oXza0Qw9WLehXZ6Vtg5FF3xd9HTNODtLB1C0ybfMaO5G3p53XBxJJk1YuQc8JB1h5lDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0juJ-00A3A8-Vo; Tue, 15 Oct 2024 17:56:23 +0200
Date: Tue, 15 Oct 2024 17:56:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH] [net,v3] net: wwan: t7xx: add
 PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Message-ID: <85cda68e-93d9-4f69-a59e-6c7c292f3a25@lunn.ch>
References: <20241015032820.2265382-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015032820.2265382-1-wojackbb@gmail.com>

On Tue, Oct 15, 2024 at 11:28:20AM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Because optimizing the power consumption of Dell DW5933e,
> Add a new auto suspend time for Dell DW5933e.
> 
> The Tests uses a small script to loop through the power_state
> of Dell DW5933e.
> (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
> 
> * If Auto suspend is 20 seconds,
>   test script show power_state have 5% of the time was in D3 state
>   when host don't have data packet transmission.
> 
> * Changed auto suspend time to 5 seconds,
>   test script show power_state have 50% of the time was in D3 state
>   when host don't have data packet transmission.

There are still open questions on V2:

https://patchwork.kernel.org/project/netdevbpf/patch/20240930031624.2116592-1-wojackbb@gmail.com/

    Andrew

---
pw-bot: cr

