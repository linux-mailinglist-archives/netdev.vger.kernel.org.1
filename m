Return-Path: <netdev+bounces-158340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85AA116F9
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E4B3A50FF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0569E2D05E;
	Wed, 15 Jan 2025 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gspADte2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7E1798F;
	Wed, 15 Jan 2025 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736906559; cv=none; b=XjjGxgIASRah1A8SiifaUy0y4KSw1loiKv0QP6ZDSvjSvyP2kuaEN2CQzvMGnZ24mXMquosjXJQaUTp4mvRRJbxASJBhp9uealusjnX52RSdaA3zzHGL/EBNt5wyyDt6KFpd8XU56uKzTCYtrSoHyTMJJduqfzhC/xNF/HeuzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736906559; c=relaxed/simple;
	bh=IOE58w+kX+35ffo6DP+xneaRUS4H4SVBilbxiyBQ5lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbeD9bihBk8pNKnKs+CnmcP9OLZMfgTBpCMmwKzcp4LCKrhEbxIHSfQhza8wS8y/23CNA56RoaKUVKf+jn0FzTTvWk6e9VZWDCBKhLz5QzPovPMP/ybwOwmC5eIolV2no2WEluCs2tJMJl/0rGFds+dhXrv4isrblK/eDEe2p9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gspADte2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8011C4CEDD;
	Wed, 15 Jan 2025 02:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736906559;
	bh=IOE58w+kX+35ffo6DP+xneaRUS4H4SVBilbxiyBQ5lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gspADte2qJ28hiwWRKctj21RsG5zbhm3p2O5HSetf1TkB2x4/mmMo+3pVVlMfyZfJ
	 vuHaUe09c5L/L3OqjMsvnpZxs63Qp8fMUAie3smYxdAjirtbTZfvBorqiSf+X3TGfJ
	 JNLbmigSRqCFTwKiUBhygCMmmWl31iwiDyJ26g3uvpSwGyNRRxrN/qiJVtFjQ2w0pm
	 omVlqWFnPiwUKs1M0kK2Vm0agAWAvrBRHlVNSerkJ8H2JYWsARg1Hm5SuUucWdyxLU
	 EdEW+vmuxeEMfIUTiGApUIU27AYi+o11gUUKhLd2ktDjpYA53EXoemySeWBw1J0cV1
	 KTOOyfNUa0mHg==
Date: Tue, 14 Jan 2025 18:02:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shailend@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, hramamurthy@google.com, ziweixiao@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] gve: Add RSS cache for non RSS device option
 scenario
Message-ID: <20250114180237.33e61fef@kernel.org>
In-Reply-To: <20250113211139.4137621-1-pkaligineedi@google.com>
References: <20250113211139.4137621-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 13:11:39 -0800 Praveen Kaligineedi wrote:
>  static int gve_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>  			struct netlink_ext_ack *extack)
>  {
>  	struct gve_priv *priv = netdev_priv(netdev);
> +	int err;
>  
>  	if (!priv->rss_key_size || !priv->rss_lut_size)
>  		return -EOPNOTSUPP;
>  
> -	return gve_adminq_configure_rss(priv, rxfh);
> +	if (priv->cache_rss_config && !priv->rss_cache_configured) {
> +		err = gve_init_rss_config(priv);

I don't understand why this is here.
Why are you programming the default config the first time user asks 
to set rxfh? And just to immediately overwrite it.

Shouldn't you be doing this on probe or first open?

Oh and in gve_setup_device_resources() you call gve_init_rss_config()

> +	if (priv->rss_cache_configured) {

so you reset what user wanted to defaults, only if user wanted
something explicitly _not_ default. Hm.

> +		if (err) {
> +			dev_err(&priv->pdev->dev, "Fail to init RSS config\n");

use extack, please

> +			return err;
> +		}
> +	}

> +int gve_init_rss_config(struct gve_priv *priv)
> +{
> +	struct gve_rss_config *rss_config = &priv->rss_config;
> +	struct ethtool_rxfh_param rxfh;
> +	u16 i;
> +
> +	for (i = 0; i < priv->rss_lut_size; i++)
> +		rss_config->hash_lut[i] = i % priv->rx_cfg.num_queues;

nit: ethtool_rxfh_indir_default()

> +
> +	netdev_rss_key_fill(rss_config->hash_key, priv->rss_key_size);
> +
> +	rxfh.hfunc = ETH_RSS_HASH_TOP;
> +
> +	return gve_adminq_configure_rss(priv, &rxfh);
> +}
-- 
pw-bot: cr

