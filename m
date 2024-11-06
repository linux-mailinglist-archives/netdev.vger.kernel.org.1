Return-Path: <netdev+bounces-142153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9699BDA8D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035381F24051
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82157CB6;
	Wed,  6 Nov 2024 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VZxZk1fh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E43307B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854166; cv=none; b=TVvrlP0ZC1YbBXBYwXlBdh2U286LjCfN75+0LFhYGzm5hiITPU8OjQuzW/oKytxpbt96abYEEm8mA/olSbWIpjze7X4Ak7u3n/S9CBTFLwjNyF8ndfaWyHOH25GzquNPMCv0zcWovwbyT4RLbdewJxWS8RS17ipad14/JB6wYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854166; c=relaxed/simple;
	bh=8alYkSC0d4GDEAmAJNmIFwALZvqsUkrszN/g7X8E+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovOImxsdpGzrYyblSdXzlAB6U96ILYwmycBJ0N+FASd5C2fQjGho0e1EywLWiuQjEl+QR7aKGp4XyVqUNhFNNzDEnttoT6q3MGwP9kanAfNuNcqwmnOpzbV5qgj1oTryfYQycdovJvBih8LuzvUp5q9QAgKr9png9PK8bpo9Feg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VZxZk1fh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720be27db27so4965365b3a.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 16:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730854164; x=1731458964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGRubnZWYrBUFGyU3xJJ0G3R2jRuKcB/j3KXOYeGS78=;
        b=VZxZk1fhpsHS5jO69cyLdil3Lsx3GIPVSWq4TwrHLZbGLmHt8bCzvNYBZgDV2kCKDF
         p5qP7WnK8FDMlGWWH6ltaX9z4RKHsppN1nxoJF2tRFPwDtzRore6/RMv0CTL5IhvTzdY
         3Wf9xo14gdjxDjrPzE2pMvTd0pEXhBMWjwBzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730854164; x=1731458964;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGRubnZWYrBUFGyU3xJJ0G3R2jRuKcB/j3KXOYeGS78=;
        b=HYdB95bpZSf4pjac04MUUlT0JhV0JjRiuBMzN23LQB8NNWa7VZ/Om1XizL117ksVAk
         CAMKgii0xgkau95v5R5rP71KPOk96JUTBzt/Dw/N3kiyNx0IoFTEqMj5GkOsaOD5HFH3
         lpp40dnqj1IdQAqq/Q0wdvr2K7IY0J0mZhpPo7cpd/TY15c8n/NS/53OKqJwlMzu9vwG
         9ImxlgRAb9JjFR5hSuhHTlQGyLTI04wdApAm0dt5y8i1iNkTT4U8+Eam2k69No69lrEV
         ucZQZBCHF+v6M8EvSCwHnNojcVB1rSqIWUiFAt4qzctdNbC9w4dwbz7HFL0W5uWcbND4
         85MA==
X-Gm-Message-State: AOJu0YwqLFIjjDVHDzJelRmTBjs5yLj6tn6yDifmX2lAQNKnY6AuDHyF
	7U9eaQi2XtTMahnN3/hwA3dN0x6VdEOs9L0xggWXBSwHGtO6MXM7kqZQ5n2J+Ag=
X-Google-Smtp-Source: AGHT+IENhlWDEOcWBHMp6biKldszv4g/mbnz2x1xwY0kfgpP4IIHjZB7ymA6YSj2YpiwaHiaQjR2+A==
X-Received: by 2002:a05:6a00:331b:b0:721:19bc:4bf4 with SMTP id d2e1a72fcca58-72119bc986cmr15810887b3a.23.1730854163991;
        Tue, 05 Nov 2024 16:49:23 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e582esm10280160b3a.52.2024.11.05.16.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 16:49:23 -0800 (PST)
Date: Tue, 5 Nov 2024 16:49:19 -0800
From: Joe Damato <jdamato@fastly.com>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <Zyq9D1WCvuykHsUv@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106002625.1857904-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106002625.1857904-1-sanman.p211993@gmail.com>

On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> Add PCIe hardware statistics support to the fbnic driver. These stats
> provide insight into PCIe transaction performance and error conditions,
> including, read/write and completion TLP counts and DWORD counts and
> debug counters for tag, completion credit and NP credit exhaustion

The second sentence is long and doesn't have a period at the end of
it. Maybe break it up a bit into a set of shorter sentences or a
list or something like that?

> The stats are exposed via ethtool and can be used to monitor PCIe
> performance and debug PCIe issues.
> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> ---
>  .../device_drivers/ethernet/meta/fbnic.rst    |  27 +++++
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  39 ++++++
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  77 +++++++++++-
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  17 +++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +
>  8 files changed, 278 insertions(+), 2 deletions(-)

[...]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 1117d5a32867..9f590a42a9df 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -6,6 +6,39 @@

[...]

> +
> +#define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
> +#define FBNIC_HW_STATS_LEN \
> +	(FBNIC_HW_FIXED_STATS_LEN)

Does the above need to be on a separate line? Might be able to fit
in under 80 chars?

>  static int
>  fbnic_get_ts_info(struct net_device *netdev,
>  		  struct kernel_ethtool_ts_info *tsinfo)
> @@ -51,6 +84,43 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
>  		*stat = counter->value;
>  }
> 
> +static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
> +{
> +	int i;
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
> +			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
> +		break;
> +	}
> +}
> +
> +static int fbnic_get_sset_count(struct net_device *dev, int sset)
> +{
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		return FBNIC_HW_STATS_LEN;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static void fbnic_get_ethtool_stats(struct net_device *dev,
> +				    struct ethtool_stats *stats, u64 *data)
> +{
> +	struct fbnic_net *fbn = netdev_priv(dev);
> +	const struct fbnic_stat *stat;
> +	int i;
> +
> +	fbnic_get_hw_stats(fbn->fbd);
> +
> +	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
> +		stat = &fbnic_gstrings_hw_stats[i];
> +		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
> +	}
> +}
> +
>  static void
>  fbnic_get_eth_mac_stats(struct net_device *netdev,
>  			struct ethtool_eth_mac_stats *eth_mac_stats)
> @@ -117,10 +187,13 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
>  }
> 
>  static const struct ethtool_ops fbnic_ethtool_ops = {
> -	.get_drvinfo		= fbnic_get_drvinfo,
>  	.get_ts_info		= fbnic_get_ts_info,
> -	.get_ts_stats		= fbnic_get_ts_stats,
> +	.get_drvinfo		= fbnic_get_drvinfo,
> +	.get_strings		= fbnic_get_strings,
> +	.get_sset_count		= fbnic_get_sset_count,
> +	.get_ethtool_stats	= fbnic_get_ethtool_stats,
>  	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
> +	.get_ts_stats		= fbnic_get_ts_stats,
>  };

Seems like the two deleted lines were just re-ordered but otherwise
unchanged?

I don't think it's any reason to hold this back, but limiting
changes like that in the future is probably a good idea because it
makes the diff smaller and easier to review.

