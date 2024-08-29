Return-Path: <netdev+bounces-123031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 896AC9637E6
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24ECCB20EB1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F1F1BC41;
	Thu, 29 Aug 2024 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeJIaNG2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5A1B813;
	Thu, 29 Aug 2024 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895682; cv=none; b=cIEyu0v5TCN2dqavLcVtA2eg663K9xPLAfj5Gnq+GWaQ+tG3zyQiIR/msZ4Rx+qn/c5fN2a8b2I2CBb2k0z4trz3oZ8wdX+5F0EGK6kTr8WBxUtPOwJpNOYg9s9Wi6xE1SpTvvpn2DJ/eVba1xPRve5vKExYLlguCfU3uZnBvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895682; c=relaxed/simple;
	bh=khDbw17Mw7vVZxA8xH5ovZxSAgzp2jRuSVqIpJVAloU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzIkTP/LRwYeT+J2mLvCAHWnsbWEZAfD+bpI5qkuBwNKVhcELFORHGasYJsg+eEHeIRQPYfsjhknSLRwcGji9tfrlk+zkNrMH4s264tLR5cTl5M1pTPTCC2d5/7dHuC2v1HG1Uo/pJ2or+nVCt6Qm1lWWVQUfDJ9dHbO1RdTQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeJIaNG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934A6C4CEC0;
	Thu, 29 Aug 2024 01:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724895682;
	bh=khDbw17Mw7vVZxA8xH5ovZxSAgzp2jRuSVqIpJVAloU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SeJIaNG2+SfoIKLgKMUs/qa1dIn7lA/fX+l+Ns2rK7finntLURlFB/luBjlyHS46N
	 A4zuq3GvA6hVyJkv1Uuorxiqoz4rvloRr3dyzW+vFfBL0vHe4Nj1b04snFH/E6wz6U
	 ovNsVaR6AfijsDcC/sLkvExqgTMaYM7fhyI/iFOe3Z+qqZzTul0Z3gmY4N7rjsMO90
	 4lDvwKJxr6cFuwUtDlAysGwmZXF8cXe3Y2BPEqlP5u4PiaMz49keH1O70RAkcQ8JLV
	 FpNMlccLte225ksq3qtD+QZUvDWmhF4xmydJ8GTIA3sDAgfB8+5rurujFqOnKNu3LD
	 fUu34RgQ0ayUw==
Date: Wed, 28 Aug 2024 18:41:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 06/11] net: hibmcge: Implement
 .ndo_start_xmit function
Message-ID: <20240828184120.07102a2f@kernel.org>
In-Reply-To: <20240827131455.2919051-7-shaojijie@huawei.com>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
	<20240827131455.2919051-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 21:14:50 +0800 Jijie Shao wrote:
> @@ -111,6 +135,14 @@ static int hbg_init(struct hbg_priv *priv)
>  	if (ret)
>  		return ret;
>  
> +	ret = hbg_txrx_init(priv);
> +	if (ret)
> +		return ret;

You allocate buffers on the probe path?
The queues and all the memory will be sitting allocated but unused if 
admin does ip link set dev $eth0 down?

