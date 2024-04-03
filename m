Return-Path: <netdev+bounces-84262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD318962B0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 04:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A6F287B57
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58481B952;
	Wed,  3 Apr 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="RPxbavw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EA1B815
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112666; cv=none; b=jTXstvf+Qtzp9fpvBeU2uIpPhhQWYqoCtXxCV9DDPoqvIinSqqMxewwfctcCuWZK6DeswxVkVAd+R+xCX9PtOBqLbgFRmKEWjeGaW2ENyJ1WcWFAq0QRqDYHCkt5yZbo2olnXDWtAYGglRgNTVIAY0BVP93fp4enPA4imKnZc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112666; c=relaxed/simple;
	bh=UD1id9vQsm3zxRZyXz3MGDJDaSN5smpRKuo3BMIhJS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBYJzwvuN5ML5IgTMxOXNFNQrRpcvFZbHUVaDynbxiqcY6NY9IDblCMGHrZCRKrsIkRP/k3Cb2OOb1vV8D2EXYohYevp0YB/6+YnXw7Ko798/psPAo6QJJwSi/PKY5tCQ+E4zmEaMWkGVCoD6ZMNV3Le4teTNZ25tPrOynp+B3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=RPxbavw6; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3aeef1385so4283798b6e.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 19:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712112663; x=1712717463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvNCN7b/5A+DFcsDCFKgdbvgot6yvnB3BUodDkQmmg0=;
        b=RPxbavw6iMx4vl4LFfRqssmlpHg3qwUHBkwgwdhG4Ip4OQYzuLt6t253T9d3D7LO79
         vxxVNYHLqGv7Kr7NrmCgqYO5mWb6Sh667cKVbmQ9YmG2f9KOnWWiVwstiWwh2OajIKvi
         hBwNQmBx/fyEbaE3Wf9wA3YRR2lERQGa46FSKvymNXM9JD7s/xLnwMI5YQza+xw3/8aL
         wTxxyqkSLfjIffRZBcMS/+/nWvCu4w6Fy9JkS4R4c1kH1BK5Qglj/I2VwcbDcb3gt3Dh
         eiNYltTd1alTs06rDTlRGY5FCrnpaFmKV//5+dUCsRSBny7g6cMNDRCcY+58tNAldNxQ
         TaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712112663; x=1712717463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvNCN7b/5A+DFcsDCFKgdbvgot6yvnB3BUodDkQmmg0=;
        b=NLdqCimG/1q7+pzXzFY1XGK1naYNH1J5eY31D+HEj5RRjPHsqJ5s0wQxGOOoS8MjSJ
         6fi5Qt1APPcGLZrGhLpSZPxhol9FFfsTqpqavH0dcZhOeEUrLu3s8EoF0E2WmMBgbjXp
         CcJiwNydA3MCOxzJ1YDNc14IaAKt/NEvjLmmjuvjm+1eOFCXaaEF3dmLPL2HtlPS5VWt
         BDKX7edn9cAYmp6Te8IYhcenmPkFlkBhDu9uF64POIE4iFw4ydDithp8QA4odGKQzp/O
         8aleBEWxIbjrF+eaWlqFx0W0c1NQ6MmvAhxLsh5JikWzB3FR2HA3ziyDGGA1e3kczPC1
         c33g==
X-Gm-Message-State: AOJu0YzJ+zNu43+Z/61KqvSfe9+xHj1MNfCKjBAtAnrshVYk3+ZdHGAa
	9yc77HU8d+9RrtatpqH3eU5z4clDKi0OZHjgQn6iL/Jj432JQKnLNjR7d7BDWM0=
X-Google-Smtp-Source: AGHT+IFLNbA5tGs9D8K1m995WGY502JvTsOPr8auGr+q5hn2J89zIUTgZGaaR1uVoTdH2Xg7j02ZUQ==
X-Received: by 2002:a9d:6f12:0:b0:6e9:2e80:5a0d with SMTP id n18-20020a9d6f12000000b006e92e805a0dmr2534695otq.28.1712112663022;
        Tue, 02 Apr 2024 19:51:03 -0700 (PDT)
Received: from [192.168.1.26] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id n28-20020a63591c000000b005dcc8a3b26esm10325041pgb.16.2024.04.02.19.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 19:51:02 -0700 (PDT)
Message-ID: <7fd250f7-30e9-4392-ae1e-c3664222f9de@davidwei.uk>
Date: Tue, 2 Apr 2024 19:51:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] netdevsim: report stats by default, like a
 real device
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, donald.hunter@gmail.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-6-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240402010520.1209517-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-01 18:05, Jakub Kicinski wrote:
> Real devices should implement qstats. Devices which support
> pause or FEC configuration should also report the relevant stats.
> 
> nsim was missing FEC stats completely, some of the qstats
> and pause stats required toggling a debugfs knob.
> 
> Note that the tests which used pause always initialize the setting
> so they shouldn't be affected by the different starting value.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/ethtool.c | 11 ++++++++
>  drivers/net/netdevsim/netdev.c  | 45 +++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index bd546d4d26c6..3f9c9327f149 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -140,6 +140,13 @@ nsim_set_fecparam(struct net_device *dev, struct ethtool_fecparam *fecparam)
>  	return 0;
>  }
>  
> +static void
> +nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats)
> +{
> +	fec_stats->corrected_blocks.total = 123;
> +	fec_stats->uncorrectable_blocks.total = 4;
> +}
> +
>  static int nsim_get_ts_info(struct net_device *dev,
>  			    struct ethtool_ts_info *info)
>  {
> @@ -163,6 +170,7 @@ static const struct ethtool_ops nsim_ethtool_ops = {
>  	.set_channels			= nsim_set_channels,
>  	.get_fecparam			= nsim_get_fecparam,
>  	.set_fecparam			= nsim_set_fecparam,
> +	.get_fec_stats			= nsim_get_fec_stats,
>  	.get_ts_info			= nsim_get_ts_info,
>  };
>  
> @@ -182,6 +190,9 @@ void nsim_ethtool_init(struct netdevsim *ns)
>  
>  	nsim_ethtool_ring_init(ns);
>  
> +	ns->ethtool.pauseparam.report_stats_rx = true;
> +	ns->ethtool.pauseparam.report_stats_tx = true;
> +
>  	ns->ethtool.fec.fec = ETHTOOL_FEC_NONE;
>  	ns->ethtool.fec.active_fec = ETHTOOL_FEC_NONE;
>  
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 8330bc0bcb7e..096ac0abbc02 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/slab.h>
> +#include <net/netdev_queues.h>
>  #include <net/netlink.h>
>  #include <net/pkt_cls.h>
>  #include <net/rtnetlink.h>
> @@ -330,6 +331,49 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
>  	.ndo_set_features	= nsim_set_features,
>  };
>  
> +/* We don't have true par-queue stats, yet, so do some random fakery here. */

nit: per-queue

> +static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
> +				    struct netdev_queue_stats_rx *stats)
> +{
> +	struct rtnl_link_stats64 rtstats = {};
> +
> +	nsim_get_stats64(dev, &rtstats);
> +
> +	stats->packets = rtstats.rx_packets - !!rtstats.rx_packets;

Why subtract !!rtstats.rx_packets? This evaluates to 0 if rx_packets is
0 and 1 if rx_packets is non-zero.

> +	stats->bytes = rtstats.rx_bytes;
> +}
> +
> +static void nsim_get_queue_stats_tx(struct net_device *dev, int idx,
> +				    struct netdev_queue_stats_tx *stats)
> +{
> +	struct rtnl_link_stats64 rtstats = {};
> +
> +	nsim_get_stats64(dev, &rtstats);
> +
> +	stats->packets = rtstats.tx_packets - !!rtstats.tx_packets;
> +	stats->bytes = rtstats.tx_bytes;
> +}
> +
> +static void nsim_get_base_stats(struct net_device *dev,
> +				struct netdev_queue_stats_rx *rx,
> +				struct netdev_queue_stats_tx *tx)
> +{
> +	struct rtnl_link_stats64 rtstats = {};
> +
> +	nsim_get_stats64(dev, &rtstats);
> +
> +	rx->packets = !!rtstats.rx_packets;
> +	rx->bytes = 0;
> +	tx->packets = !!rtstats.tx_packets;
> +	tx->bytes = 0;
> +}
> +
> +static const struct netdev_stat_ops nsim_stat_ops = {
> +	.get_queue_stats_tx	= nsim_get_queue_stats_tx,
> +	.get_queue_stats_rx	= nsim_get_queue_stats_rx,
> +	.get_base_stats		= nsim_get_base_stats,
> +};
> +
>  static void nsim_setup(struct net_device *dev)
>  {
>  	ether_setup(dev);
> @@ -360,6 +404,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>  
>  	ns->phc = phc;
>  	ns->netdev->netdev_ops = &nsim_netdev_ops;
> +	ns->netdev->stat_ops = &nsim_stat_ops;
>  
>  	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
>  	if (err)

