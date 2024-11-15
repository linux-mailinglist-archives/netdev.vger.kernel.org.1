Return-Path: <netdev+bounces-145247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684C9CDEA5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0507F1F241EC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630611B85FD;
	Fri, 15 Nov 2024 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLp2kVBu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE214A088
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675076; cv=none; b=ScZAbnh8rpka5sxeowtecdoWnKgc8NZgUD8o5fZ4+SYCDo292Inz7Es1nlD6GwUdVvLqYGEnD6Dc29OlU5tSwVj9xNOKhC70vLb8ph3N7oNxK83FPm4lvxGUS39phk0AW+Ho3UwOUfovTEYYyVK9zLkaVnpokvkRGvWkXMGBRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675076; c=relaxed/simple;
	bh=lSEI3t4D6CYF1nVrPsQ4X7kyHzEljSoE58GvXffqcug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPLHloeR+MTYST6s4nXpRL2LpPZEdPtjH08in9FjlfFSF/xOigIUrERaeU45kNuVcZPNE83mOEfJhIV1JJCAfRry/ibAllm54N4G90oMji1jKXJow8LRRD6w63uBokWQTGNkA/SHSTPoiNqDirVTDs22H6fN8Mhih2WbespbJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLp2kVBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52428C4CECF;
	Fri, 15 Nov 2024 12:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731675075;
	bh=lSEI3t4D6CYF1nVrPsQ4X7kyHzEljSoE58GvXffqcug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLp2kVBuO2Z41k26kjMddkl/mEbunJV7ryEjzkB89zt3px+i3oSYIgsJ6GvqvO4S9
	 /njaEOf0SggN4Bnt4xhgK3cuZ+VvFu3COoyJFtNPaGNil/YOi1zkWTjMpbHmSnfcWG
	 HvnMCNaeA9L5tV6fUokJCyHHMpvfVuYrm/U3WC/EjLIuiUvLBElaSNJ1o3hsy8Ayc7
	 qjnmrQ56IDDBtoVOMs+OuVRxy5nWISoktRkfnE3ZDfq2Re9Ga97BcLzZTIawdLh/Ih
	 rM27vaoVEv1xsIp5jQDEtyEI1yQmK6Z2/DIrR8ztP2IlhuwZVb4yMS83GlR2/I71zF
	 e3PrVT3lELPMQ==
Date: Fri, 15 Nov 2024 12:51:12 +0000
From: Simon Horman <horms@kernel.org>
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH iwl-net 04/10] idpf: negotiate PTP capabilies and get PTP
 clock
Message-ID: <20241115125112.GP1062410@kernel.org>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-5-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113154616.2493297-5-milena.olech@intel.com>

On Wed, Nov 13, 2024 at 04:46:14PM +0100, Milena Olech wrote:
> PTP capabilities are negotiated using virtchnl command. Add get
> capabilities function, direct access to read the PTP clock time and
> direct access to read the cross timestamp - system time and PTP clock
> time. Set initial PTP capabilities exposed to the stack.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h

...

>  /**
>   * struct idpf_ptp - PTP parameters
>   * @info: structure defining PTP hardware capabilities
>   * @clock: pointer to registered PTP clock device
>   * @adapter: back pointer to the adapter
> + * @cmd: HW specific command masks
> + * @dev_clk_regs: the set of registers to access the device clock
> + * @caps: PTP capabilities negotiated with the Control Plane
> + * @get_dev_clk_time_access: access type for getting the device clock time
> + * @get_cross_tstamp_access: access type for the cross timestamping
>   */
>  struct idpf_ptp {
>  	struct ptp_clock_info info;
>  	struct ptp_clock *clock;
>  	struct idpf_adapter *adapter;
> +	struct idpf_ptp_cmd cmd;
> +	struct idpf_ptp_dev_clk_regs dev_clk_regs;
> +	u32 caps;
> +	enum idpf_ptp_access get_dev_clk_time_access:16;
> +	enum idpf_ptp_access get_cross_tstamp_access:16;
>  };
>  
> +/**
> + * idpf_ptp_info_to_adapter - get driver adapter struct from ptp_clock_info
> + * @info: pointer to ptp_clock_info struct

Please in include a "Return:" section, as you have done elsewhere,
to document the return value of this function.

Flagged by ./scripts/kernel-doc -none -Wall

> + */
> +static inline struct idpf_adapter *
> +idpf_ptp_info_to_adapter(const struct ptp_clock_info *info)
> +{
> +	const struct idpf_ptp *ptp = container_of_const(info, struct idpf_ptp,
> +							info);
> +	return ptp->adapter;
> +}
> +
>  #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
>  int idpf_ptp_init(struct idpf_adapter *adapter);
>  void idpf_ptp_release(struct idpf_adapter *adapter);
> +int idpf_ptp_get_caps(struct idpf_adapter *adapter);
> +void idpf_ptp_get_features_access(const struct idpf_adapter *adapter);
>  #else /* CONFIG_PTP_1588_CLOCK */
>  static inline int idpf_ptp_init(struct idpf_adapter *adpater)
>  {

...

