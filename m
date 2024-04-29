Return-Path: <netdev+bounces-92141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF578B5906
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E5B28BF35
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04FF3771E;
	Mon, 29 Apr 2024 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gaM/NZtx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175210971;
	Mon, 29 Apr 2024 12:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395012; cv=none; b=Pi1Dd9DHXxyPjTuTzyjF1R4+S20zQ38oSljcbtvEXpoOMNiLQHCauAK8GXv2U4ns8TUnt9dilnnWlVpoybmYt7DKbM1gKZyUo1TnnZDT4WdV0ZPOhFDvSS5sJTxF6ABMTgDepuAlMwCRYaUwr3Os4IPBup1tO/wyzqDtljw5Syg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395012; c=relaxed/simple;
	bh=3bCfWRhZDG5RMBFy4B87guz7rihAVZVJAV0wmeZj5N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK2t/OrTfyUjfSytyZcpRCBqdJiYDAS2kXhhyERXGxZ3ovHD1DByDq3fKvemGruu89ya41kOe8P8X9JRaLya+DZRr/5vJ15jM3ALtLuZ1M2pJt00QeOBWIkQmN9aC7RQ0xln4L8pLTv3CU8AcL63oXOj4e17wu1KRThAIYzT+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gaM/NZtx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KWQYXuDuosAhIoS7yaKxvAY/333rDoKrL+wGRGUy7tE=; b=gaM/NZtxcxE+rJFwU11gku/dTr
	LZ1qKm3fD6gW+U5HfTyktM1YdR8KwfbWY0Cc8HvD78fW/0gCK/c3NhXjNME5VumgoTQetM8ANuHXp
	dp7zp+uGoEjqlSVtJ2+EoLcuPF3UPga7TVS+P2aeuk7FUnFp7uV/uq2kMxOLNG8BCs14=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1QSG-00EFdQ-UJ; Mon, 29 Apr 2024 14:50:00 +0200
Date: Mon, 29 Apr 2024 14:50:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: Add SW TX / RX
 Coalescing based on hrtimers
Message-ID: <e061956a-59e6-435e-99fe-6c6c7b2d6a5d@lunn.ch>
References: <20240429071501.547680-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429071501.547680-1-danishanwar@ti.com>

On Mon, Apr 29, 2024 at 12:45:01PM +0530, MD Danish Anwar wrote:
> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
> driver, which can be enabled by ethtool commands:
> 
> - RX coalescing
>   ethtool -C eth1 rx-usecs 50
> 
> - TX coalescing can be enabled per TX queue
> 
>   - by default enables coalesing for TX0
>   ethtool -C eth1 tx-usecs 50
>   - configure TX0
>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
>   - configure TX1
>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
>   - configure TX0 and TX1
>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
> tx-usecs 100
> 
> Minimum value for both rx-usecs and tx-usecs is 20us.
> 
> Compared to gro_flush_timeout and napi_defer_hard_irqs this patch allows
> to enable IRQ coalescing for RX path separately.
> 
> Benchmarking numbers:
>  ===============================================================
> | Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
> | ==============================================================
> | Default Driver           943 Mbps    31%      517 Mbps  38%   |
> | IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
>  ===============================================================
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

