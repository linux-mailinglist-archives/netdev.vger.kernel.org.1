Return-Path: <netdev+bounces-140886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B39B88D6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569A8280BFC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8B13BC18;
	Fri,  1 Nov 2024 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC+9AZwb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6417BCE;
	Fri,  1 Nov 2024 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425530; cv=none; b=k5Vr8+ymdu/UelUUYGVJwFLrWZeaVn9AUjVjMjjwp3WpSVZ4ReDRwsYKlkluZislINOlNVYXmHHNU5H+/Q+bLitqHptCcS4/H68694h32qBLrrXVJrzWC0Yt2L7uxzTn6mOreCDt6PQ5THPs+1Tvst9SiPnfg/umxQ1T3N1VGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425530; c=relaxed/simple;
	bh=E1Wz2vDPGlaoUMwJuJtoBhWk54UVNXhpWTv/Df1jYpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RC/WdFYfySqFRX40Esxbs8tzwN+9kpldRMb60W6r4lZA1sdiVoMzVy6VeNqGpR2bW2T5oIDJkrMvXveahkSqDc/uICsAMXGRKCoC4cmY6fOBSS5ZCJyaSAAOf8la1k2m+Yzgv8H44+8yTksOfs0lhGYdVkXWoQK8OMN+GjSeffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC+9AZwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C6EC4CEC3;
	Fri,  1 Nov 2024 01:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730425529;
	bh=E1Wz2vDPGlaoUMwJuJtoBhWk54UVNXhpWTv/Df1jYpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QC+9AZwbEoycb1O6H/6hpggvAevIgROpqBYD4sUBm85RlSKftfaf8o5RaY7lhNUjl
	 5lHQAqMjQ/q7wC5Ijc+wRZa5l5OnHGApFWjFCSVvPB5VLIYWzE+smuK4F77WrfwnsS
	 cp5ci91911Hitto4Jq5RnsS8QpVfeCxD/7o2S3mlPSu0hFrUk6mLG13GIaTDTsdPos
	 7ZA9DfnNYJ2Y7HNJ80mga1XD+kK/Zpit+XlQvKAp3nD7G4aFwqeYk6tMJOFrzlQKon
	 Dp9dmw4f4OuR93+xXjcrR3s4eqv4TNo5KQuNZ/e7khOgEEW0SEvbr9NkTfwIN5m1eq
	 Kkfa1gZMeUvKQ==
Date: Thu, 31 Oct 2024 18:45:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 1/8] net: hibmcge: Add dump statistics
 supported in this module
Message-ID: <20241031184527.1d6afe84@kernel.org>
In-Reply-To: <20241026115740.633503-2-shaojijie@huawei.com>
References: <20241026115740.633503-1-shaojijie@huawei.com>
	<20241026115740.633503-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 19:57:33 +0800 Jijie Shao wrote:
> +	HBG_STATS_REG_I(rx_framesize_64, HBG_REG_RX_PKTS_64OCTETS_ADDR),
> +	HBG_STATS_REG_I(rx_framesize_65_127,
> +			HBG_REG_RX_PKTS_65TO127OCTETS_ADDR),
> +	HBG_STATS_REG_I(rx_framesize_128_255,
> +			HBG_REG_RX_PKTS_128TO255OCTETS_ADDR),
> +	HBG_STATS_REG_I(rx_framesize_256_511,
> +			HBG_REG_RX_PKTS_256TO511OCTETS_ADDR),
> +	HBG_STATS_REG_I(rx_framesize_512_1023,
> +			HBG_REG_RX_PKTS_512TO1023OCTETS_ADDR),
> +	HBG_STATS_REG_I(rx_framesize_1024_1518,
> +			HBG_REG_RX_PKTS_1024TO1518OCTETS_ADDR),
> +	HBG_STATS_REG_I(rx_framesize_bt_1518,
> +			HBG_REG_RX_PKTS_1519TOMAXOCTETS_ADDR),
> +	HBG_STATS_REG_I(rx_fcs_error_cnt, HBG_REG_RX_FCS_ERRORS_ADDR),
> +	HBG_STATS_REG_I(rx_data_error_cnt, HBG_REG_RX_DATA_ERR_ADDR),
> +	HBG_STATS_REG_I(rx_align_error_cnt, HBG_REG_RX_ALIGN_ERRORS_ADDR),
> +	HBG_STATS_REG_I(rx_frame_long_err_cnt, HBG_REG_RX_LONG_ERRORS_ADDR),

Please do not dump in ethtool statistics which can be accessed via
standard APIs like ethtool -I, queue_stats or rtnl_stat.
https://docs.kernel.org/next/networking/statistics.html

