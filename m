Return-Path: <netdev+bounces-183004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3DA8A90C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323897ABA52
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5542561AB;
	Tue, 15 Apr 2025 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR/opIAZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115C25394D;
	Tue, 15 Apr 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748162; cv=none; b=s0Y/irGgJ/N4VnXa1Vt/xAj8tJpKjCelc7jKd9VSo8ljxjkikCe+Qu+BvsvqGdkllbLAjmTF2pSokO2Bbx6xYuH2O+4RHa+AD17bIKKwwESp0NP4sMVvjIEniMevMleufViKe337Vxw+J9jytqeq8jNUR3Lx02Ks1485ZwxxMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748162; c=relaxed/simple;
	bh=onoj2sY2pyRxx4KUIk19sDKIQq9HSXI7b26/f+g5/H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4rjzPvrgBRYAv6iOYHfIdCGcQMr+O3XtNIbZMi3cBlM4SjaJG/jVqz8xCDEmlxxD2pAQ3SdKpWHSs5GPu73myc6NTl94uHVVjv3wDEFqTi5ujj8HSLy+3kjcUO/60NRwG7S8FA8VVe51nBjbiTu0nndrHYAo/Mb9ONzMwIrjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sR/opIAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC866C4CEEF;
	Tue, 15 Apr 2025 20:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744748161;
	bh=onoj2sY2pyRxx4KUIk19sDKIQq9HSXI7b26/f+g5/H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sR/opIAZgI/JM4gAz42+NTOAd9pYk557QzcLMeVNiNsHRZj/cM1mgaTUM1DYhHN9q
	 B/GjrV7+ImrPxGFTnWSLz9mpniB8tlKb3nzqVsn8x2FjY1ya7qid9viXvtcrSpytru
	 y5JbFPur9TUmBlgLIqiugRNhEjdSnuj4t0ls6qJihhAk+NCJjQwWGJqIeIqK2E2VqH
	 xYxF5olNRHXaR4WgW6IFl76b6WsHM1+4X3TCh5QqBWIaD7mITcUtnSZNqFwbkOUeCG
	 oqaPut7Mh0Jlfw8Q3I/FfgATvp9I082ATAmmAtb1jknPY4UyxZ6wZ1E78WK5gbC8Jg
	 aVxNO8fssfV1A==
Date: Tue, 15 Apr 2025 21:15:52 +0100
From: Simon Horman <horms@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	tony@atomide.com, richardcochran@gmail.com, glaroque@baylibre.com,
	schnelle@linux.ibm.com, m-karicheri2@ti.com, s.hauer@pengutronix.de,
	rdunlap@infradead.org, diogo.ivo@siemens.com, basharath@couthit.com,
	jacob.e.keller@intel.com, m-malladi@ti.com,
	javier.carrasco.cruz@gmail.com, afd@ti.com, s-anna@ti.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratheesh@ti.com, prajith@ti.com, vigneshr@ti.com, praneeth@ti.com,
	srk@ti.com, rogerq@ti.com, krishna@couthit.com, pmohan@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v5 11/11] net: ti: prueth: Adds PTP OC Support
 for AM335x and AM437x
Message-ID: <20250415201552.GJ395307@horms.kernel.org>
References: <20250414113458.1913823-1-parvathi@couthit.com>
 <20250414140751.1916719-12-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414140751.1916719-12-parvathi@couthit.com>

On Mon, Apr 14, 2025 at 07:37:51PM +0530, Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> PRU-ICSS IEP module, which is capable of timestamping RX and
> TX packets at HW level, is used for time synchronization by PTP4L.
> 
> This change includes interaction between firmware/driver and user
> application (ptp4l) with required packet timestamps.
> 
> RX SOF timestamp comes along with packet and firmware will rise
> interrupt with TX SOF timestamp after pushing the packet on to the wire.
> 
> IEP driver available in upstream linux as part of ICSSG assumes 64-bit
> timestamp value from firmware.
> 
> Enhanced the IEP driver to support the legacy 32-bit timestamp
> conversion to 64-bit timestamp by using 2 fields as below:
> - 32-bit HW timestamp from SOF event in ns
> - Seconds value maintained in driver.
> 
> Currently ordinary clock (OC) configuration has been validated with
> Linux ptp4l.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>

...

> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h b/drivers/net/ethernet/ti/icssg/icss_iep.h
> index 0bdca0155abd..437153350197 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.h
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
> @@ -47,6 +47,11 @@ enum {
>  	ICSS_IEP_MAX_REGS,
>  };
>  
> +enum iep_revision {
> +	IEP_REV_V1_0 = 0,
> +	IEP_REV_V2_1
> +};
> +
>  /**
>   * struct icss_iep_plat_data - Plat data to handle SoC variants
>   * @config: Regmap configuration data
> @@ -57,11 +62,13 @@ struct icss_iep_plat_data {
>  	const struct regmap_config *config;
>  	u32 reg_offs[ICSS_IEP_MAX_REGS];
>  	u32 flags;
> +	enum iep_revision iep_rev;
>  };

Please add iep_rev to the Kernel doc for struct icss_iep_plat_data.

Flagged by ./scripts/kernel-doc -none

...

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h

...

> @@ -337,6 +343,7 @@ enum pruss_device {
>  struct prueth_private_data {
>  	enum pruss_device driver_data;
>  	const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
> +	enum fw_revision fw_rev;
>  	bool support_lre;
>  	bool support_switch;
>  };

And, likewise, please add fw_rev to the Kernel doc for struct
prueth_private_data.

...

