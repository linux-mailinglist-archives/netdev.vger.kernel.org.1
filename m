Return-Path: <netdev+bounces-144960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880239C8E71
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD37288DAE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E085118D63C;
	Thu, 14 Nov 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rUwt46Ze"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C891632EF
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598402; cv=none; b=EqTSC7kpk4wklBzIl9zYdyaYRRF9g4WxHgXNVen0vrvhdMOY8+fZyFGGr+qdsFRDRx5GO6p/jVTxb5rgl6M4DUndkeZrN+MiuAJH+SLmZzkBtWoCF4NJ+zCAo9MuMUNf0vUOKMA/sOmSHaJFXzot0nfOfi+ixmLImbAiucnUQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598402; c=relaxed/simple;
	bh=4NJ5/kx8A96DpPqLZgnNF4G1MvnTwJpwAggWwcXLYSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5xrc6gHHX1JSeEec6BNTZ420PPlTha+ilXXGIwZoO/gnu5VpTY7UyZKP8fmNshVE4AKV4B5/8RsZK4pwiP6tjMBmuRAyN4aFiaOBdefv/Aw5iOnKpPoI+eO9WXV+g8IDApceStFrbPjTekRwpERdVBagDpDub8wFkfamxiI6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rUwt46Ze; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G4EZ3jl6nOJdqJAgt3wJNi7n9xQj+CzVY+eMw04jHG4=; b=rUwt46Zez10UJ8W0ckfKsbtoTq
	x2S5LRlUHPXEcceM7uJZuiR9eRSfX8dvUz1C+V4g4K73c3YOI53zwAyzVsKK4A/XvXkdZcI4dV5Pv
	6pu12wjuWJHLBtM4IX87wOayueKLhV6oAEhIqQyK0aldO5epFecK07i1o33aSeO/iXPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBbqO-00DJTv-Ey; Thu, 14 Nov 2024 16:33:16 +0100
Date: Thu, 14 Nov 2024 16:33:16 +0100
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
Subject: Re: [net-next,v2] [PATCH net-next v2] net: wwan: t7xx: Change
 PM_AUTOSUSPEND_MS to 5000
Message-ID: <546f1456-87f2-4e54-a486-86cac1504a3d@lunn.ch>
References: <20241114102002.481081-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114102002.481081-1-wojackbb@gmail.com>

On Thu, Nov 14, 2024 at 06:20:02PM +0800, wojackbb@gmail.com wrote:
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
> 
> We tested Fibocom FM350 and our products using the t7xx and they all
> benefited from this.
> 
> Signed-off-by: Jack Wu <wojackbb@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

