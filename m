Return-Path: <netdev+bounces-16156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734AC74B975
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE96B2817CA
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FAE17ADF;
	Fri,  7 Jul 2023 22:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273CC17ACF
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4007EC433C7;
	Fri,  7 Jul 2023 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688768425;
	bh=V6mWHSuijLWaOg8M372s0HWlisfuFF180RFFb2O8Bt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UbgFK85PCU+dfkK2T34t+04/xA+3Z7+9buUHlgKST7gMun7AFrtafCIuvWNJ5vunb
	 Z/NX2uc/a1452Yrd0NJn+O0zCtd/zLLw11tACZl6HGjh52gSfVYhTh3DoN+rHMKS3h
	 /usl3glPlvcQpube8L2UbVHXllxfGFbGEx1i8WLbrD3XskMKgbar9SHCYruzJQGQCf
	 CNa9RThNvx9gr8g9eiNIdBq+ILO0nLfd8X9IGrglXZj8wQfG8X01zbvYmy8a6wQwqv
	 zl3CZDINXBJTjKC5PSSWgZSr1ijq0dqGl+u5WSftfh0G1pOJ3mg9ZsN1ntpB7JZYe7
	 MREWILO0YBTvg==
Date: Fri, 7 Jul 2023 15:20:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, haiyue.wang@intel.com, awogbemila@google.com,
 davem@davemloft.net, pabeni@redhat.com, yangchun@google.com,
 edumazet@google.com, csully@google.com
Subject: Re: [PATCH net] gve: unify driver name usage
Message-ID: <20230707152024.0807c5ba@kernel.org>
In-Reply-To: <20230707103710.3946651-1-junfeng.guo@intel.com>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jul 2023 18:37:10 +0800 Junfeng Guo wrote:
> Current codebase contained the usage of two different names for this
> driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
> to use, especially when trying to bind or unbind the driver manually.
> The corresponding kernel module is registered with the name of `gve`.
> It's more reasonable to align the name of the driver with the module.
> 
> Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
> Cc: csully@google.com
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>

Google's maintainers definitely need to agree to this, because it's 
a user visible change. It can very well break someone's scripts.

> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 98eb78d98e9f..4b425bf71ede 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -964,5 +964,6 @@ void gve_handle_report_stats(struct gve_priv *priv);
>  /* exported by ethtool.c */
>  extern const struct ethtool_ops gve_ethtool_ops;
>  /* needed by ethtool */
> +extern char gve_driver_name[];
>  extern const char gve_version_str[];
>  #endif /* _GVE_H_ */
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 252974202a3f..ae8f8c935bbe 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -899,7 +899,7 @@ int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
>  
>  int gve_adminq_report_link_speed(struct gve_priv *priv)
>  {
> -	union gve_adminq_command gvnic_cmd;
> +	union gve_adminq_command gve_cmd;
>  	dma_addr_t link_speed_region_bus;
>  	__be64 *link_speed_region;
>  	int err;
> @@ -911,12 +911,12 @@ int gve_adminq_report_link_speed(struct gve_priv *priv)
>  	if (!link_speed_region)
>  		return -ENOMEM;
>  
> -	memset(&gvnic_cmd, 0, sizeof(gvnic_cmd));
> -	gvnic_cmd.opcode = cpu_to_be32(GVE_ADMINQ_REPORT_LINK_SPEED);
> -	gvnic_cmd.report_link_speed.link_speed_address =
> +	memset(&gve_cmd, 0, sizeof(gve_cmd));
> +	gve_cmd.opcode = cpu_to_be32(GVE_ADMINQ_REPORT_LINK_SPEED);
> +	gve_cmd.report_link_speed.link_speed_address =
>  		cpu_to_be64(link_speed_region_bus);
>  
> -	err = gve_adminq_execute_cmd(priv, &gvnic_cmd);
> +	err = gve_adminq_execute_cmd(priv, &gve_cmd);

What's the problem with the variable being called gvnic_cmd ?
Please limit renames, if you want this to be a fix.
-- 
pw-bot: cr

