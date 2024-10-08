Return-Path: <netdev+bounces-133321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E49959E1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762011C217DC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C2B1E0DC1;
	Tue,  8 Oct 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad8l4zUt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38992C859;
	Tue,  8 Oct 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425823; cv=none; b=dyiCD3oopTOqJ4ughCwFWX1Oo3ky7hdUnV1Sgy5jvlL9jb3HqGSZq3yWEH43C/NuPhexImNnrkosCiFMSQn8MNoiX9aeYRAn6OlQ4Lh52MYGRpUIhMPf9SY5s9+X3vmCtzijlS/BtT0OnPD8jkroTMD8LCGZbWDwQQ/M7sMjS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425823; c=relaxed/simple;
	bh=SAU/WFf/lqUbxGwwxejYn8EGgUsUCEDLUm+rVG7rgV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UE9C+EBxY8EFWkKcZ7QLF704/hvYNvxxMGqL74KXuXp7BbWKDsv6oo7wJ4sGmzQPSZcwI/7RFBvBg1WjVW4RmAkIUN0Is9NEF15pJyp9BXYIErNw8+rhUliOQjJrXeBXeeAbF93ttSiSZ+n0qWyFDOut/1YMmj6DEowLTPFjKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad8l4zUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B383C4CEC7;
	Tue,  8 Oct 2024 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728425823;
	bh=SAU/WFf/lqUbxGwwxejYn8EGgUsUCEDLUm+rVG7rgV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ad8l4zUtNzKp5K3lyaK6sU2d2mkkml76VlI/RDuk/LHpfpLE+m2DtcOIwrE/ylBe3
	 IcwnfquG+iwlfXfsokPly2T+ybWLT8TrecG4ApE6Pffk7504/e1jM8HLILROuQmhtP
	 E+vJJQMVRnouX7IPPnXr1Mf8SUgyIwS8j2caPVOFRTZU+sm36AK3doLgONZ4rR324d
	 kx6ER9XBEF4HWcM9Ly0POhiAPCiIvUuDVRp8NlZDMT5GPe8cRvPA1X1FAcfSd95eQa
	 Clp3Ax9gPN64lumwA01/Yp+A/1yXlZDKyTa5qaYCHET5abH1lO9HOOb71gFSvCvk0F
	 bOGzoNZl97i+w==
Date: Tue, 8 Oct 2024 15:17:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Pirko
 <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg
 <johannes.berg@intel.com>, linux-doc@vger.kernel.org (open
 list:DOCUMENTATION), linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC net-next v4 5/9] net: napi: Add napi_config
Message-ID: <20241008151701.6f8bb389@kernel.org>
In-Reply-To: <20241001235302.57609-6-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
	<20241001235302.57609-6-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Oct 2024 23:52:36 +0000 Joe Damato wrote:
>  static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
>  					      u32 defer)
>  {
> +	unsigned int count = max(netdev->num_rx_queues,
> +				 netdev->num_tx_queues);
>  	struct napi_struct *napi;
> +	int i;
>  
>  	WRITE_ONCE(netdev->napi_defer_hard_irqs, defer);
>  	list_for_each_entry(napi, &netdev->napi_list, dev_list)
>  		napi_set_defer_hard_irqs(napi, defer);
> +
> +	if (netdev->napi_config)

Could this ever be NULL ?

> +		for (i = 0; i < count; i++)
> +			netdev->napi_config[i].defer_hard_irqs = defer;
>  }

