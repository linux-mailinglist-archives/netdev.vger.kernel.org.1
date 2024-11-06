Return-Path: <netdev+bounces-142478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17219BF4CB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA6A1C23889
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F232076CD;
	Wed,  6 Nov 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fUOWUF6d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A12076C8
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916271; cv=none; b=AKRI91pP9/deouvA2KWdykujnfzFNm9M9YLuKWafRsBgzoZJIHPA5OrYZBH6rLT/6i0Z9v32q+U4Scq9BWs3CRiIqTafX6HnZIPH8jxiHWu0DXyI4kCYPJqOz9FfkYxTeMUyNp7a0ot2N4rqYicU0wHIQj9jM9FyYXef7TbO3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916271; c=relaxed/simple;
	bh=aPavd3k6m2hYDZ2vRxkB4CEqQM4/XeTkYOJpEGwW38M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3AaLMR6M2PMQvfypx8tw9xj9mstYOvQSfGA93oiBoC0ZgI+rHFUufRi4k+OM4JsdpaT65u/2KEHXdwz9AZSfhGxKK/wdWk3wnYqkQT806ms7TFBkvslQ9NLKyoTIRTUkRgp/Cm+KjrXh9aH/5as1yHQ16TeUa1Er97h2pWmHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fUOWUF6d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/BSemyVMGpWRmaclhSQib1OHQ2qqrpJSSSRuHRaY9Tg=; b=fUOWUF6dHNWVDwLgJ6CgXfzzJR
	JAYPsmgTh+NvEfMz1y+4ppmx2ACqt6TcZ6GPSWhCvf70puDXwCCU9Axfm4yzh+04egG3piG88he7y
	y4PhVZRtbugVm3Fz9YQhf98tK0vIcwiHiqDwbE/f/gAhEB96OfnV1YeF3hdJ0YDHMF9I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8kOH-00CMh5-A8; Wed, 06 Nov 2024 19:04:25 +0100
Date: Wed, 6 Nov 2024 19:04:25 +0100
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
Subject: Re: [PATCH] [net-next] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to
 5000
Message-ID: <d2f54fde-1d98-4925-866a-1d755956bbce@lunn.ch>
References: <20241106104005.337968-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106104005.337968-1-wojackbb@gmail.com>

On Wed, Nov 06, 2024 at 06:40:05PM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Because optimizing the power consumption of t7XX,
> change auto suspend time to 5000.
> 
> The Tests uses a script to loop through the power_state
> of t7XX.
> (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
> 
> * If Auto suspend is 20 seconds,
>   test script show power_state have 0~5% of the time was in D3 state
>   when host don't have data packet transmission.
> 
> * Changed auto suspend time to 5 seconds,
>   test script show power_state have 50%~80% of the time was in D3 state
>   when host don't have data packet transmission.

Please add the justification for changing this globally, that you
tested a number of different machines using the t7xx and they all
benefited from this.

    Andrew

---
pw-bot: cr

