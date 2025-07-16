Return-Path: <netdev+bounces-207645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F85FB080EB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874C51C40BF3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489C28A3F5;
	Wed, 16 Jul 2025 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seYe5Jmi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9F9460;
	Wed, 16 Jul 2025 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752708258; cv=none; b=ulRtngkkuYOUdnt1wZm02BGjQeID4M+7nTW3sbZegxVSuRFox8voMr3NA4uzXWh7LIdZeumnWE2IKQDl3EjltXfKJT6wz6/3fo5zO2IRZQ6ZDwDuvgb4il7/B9z6xT6Jq7WJeLnUTbCosL4V458y5ah+nxzHG7onQfHxuQvzaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752708258; c=relaxed/simple;
	bh=87yrPSCfmOseXmUWruhQbrJgqmJmo4l2gdof8XUTvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUC4frDE4uhMsORtE/WXI1wAIBQQQSWN+9QmeRncjjrxfhM9fmGL/tH80I+DyFXgXb4wirPfkgVeMBWxKSA5dBI7DYcfWVkzUH0DcvZvMTNkPr/D1n3YGTcUv5h9bAR4U9Idk7niLyHO1B/gVFWulrQiOKLlyWoKrm9MK4oNVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seYe5Jmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67B2C4CEEB;
	Wed, 16 Jul 2025 23:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752708258;
	bh=87yrPSCfmOseXmUWruhQbrJgqmJmo4l2gdof8XUTvzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=seYe5JmizB05LtTRIjZ5S90UDFKCFmvFSi1F9y5Vz++QjSx/3edE4eZkS/fnmcmsM
	 nKxhAqUe9XmfLiCpiMhv6/SUWewunbIGCBACzfwDOwZUP6yEKnqQuhF7FUCJ8SqGpj
	 d441VEybt6VQEv7M6pvRYQ9c7WJO6dL+X5Cmow18EYVbwSpjxY4S5LFnSJt7R2E6r6
	 FO6wo5DTiypsnpkJuPiZ1e1AeE/hx4z5bpIvFt6jp4JemEdTZUY0i8vVnEPYaOEjnU
	 az+DtvrB8PWRfsh8uZJ3sfOkgkCZd4vvuksawN99Je3VFiwJstlmXn3UUU70O6fgQ7
	 nD15M9dSr74Tg==
Date: Wed, 16 Jul 2025 16:24:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, "Subbaraya
 Sundeep" <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Tomasz Duszynski <tduszynski@marvell.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [net PatchV2] Octeontx2-vf: Fix max packet length errors
Message-ID: <20250716162417.1d691576@kernel.org>
In-Reply-To: <20250715111351.1440171-1-hkelam@marvell.com>
References: <20250715111351.1440171-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 16:43:51 +0530 Hariprasad Kelam wrote:
> +	netdev_stats_to_stats64(stats, &netdev->stats);
> +
>  	otx2_get_dev_stats(pfvf);
>  
>  	dev_stats = &pfvf->hw.dev_stats;
> @@ -149,7 +151,7 @@ void otx2_get_stats64(struct net_device *netdev,
>  
>  	stats->tx_bytes = dev_stats->tx_bytes;
>  	stats->tx_packets = dev_stats->tx_frames;
> -	stats->tx_dropped = dev_stats->tx_drops;
> +	stats->tx_dropped += dev_stats->tx_drops;

Please don't add new uses of netdev->stats.

	struct net_device_stats	stats; /* not used by modern drivers */
-- 
pw-bot: cr

