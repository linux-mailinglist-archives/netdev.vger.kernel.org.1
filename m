Return-Path: <netdev+bounces-115324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90CA945D54
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D131C20BFF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11681E2105;
	Fri,  2 Aug 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IWbm6vLg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0661E2118
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598878; cv=none; b=h+tciCRzCJ+KPHZH1jKYcIBBeaqzn9xThVeP5i5PIb27wXNOOK77EZkV6zpk6XDFvH8YzGfPwjelwwFPMUyJnuRA7ikO8QPDcmahBRL+DBUl3Nv+4ba978nS8J4cS4Ejp7FV7gWKBDhTwb+KzoZvT+GbtK9aeQQuRQBQfD8G9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598878; c=relaxed/simple;
	bh=WFT1iaNNwgF0ci66lz9D9MAlL7cEmGUPjEj8flbq3HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9a8f9M+6TuwOc40pYXLZWHJ2emVI7NsWm5kaxCjdRJYt/bO3CX79oIAJEFep7oBsPVadbekuHx3NBIBRa+C8RWEAOTyw4T7j2XliQIVfqAn7NvbXYiV1Y3B/hbPxcuojd0pi9O0Sli+BrTwSFCrwjdUggtCnK2pdd07cNmISc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IWbm6vLg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3684eb5be64so4551957f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722598875; x=1723203675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwuPrOt9sOuzNuXXK1pGjQ2yImAbf38/J1YLsXxB/nI=;
        b=IWbm6vLgSnVBN4AQmquhSXEy/hpD7y1zsE6GJlhaColcNIm3ZXMECnSUNZNN5BM4CL
         rCNS41LI+PYLMpjWC9Bgqhv2JIR/u67FMNB+kmHdqXurQq5cDQGU8/A70ML89GGNU0Fg
         +jQ+KHyEEwLKBbaAMkVs2dX9AYnfg+zCEruT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722598875; x=1723203675;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwuPrOt9sOuzNuXXK1pGjQ2yImAbf38/J1YLsXxB/nI=;
        b=P9SxDFB+lZ83iQab5q61YzGRd/bm1g+9b6QGvnEctAbKT6b20tuhgqEjoXU6U7VLeb
         jnhEeGcmUw86fCGCi44EHqJkXN3AkJDrEOf52nTkAKyrODKrilwbIdLBzWKiDEOahXCk
         gJfYXAWbJOSUldmmUx0shiGumnWC0BpU+v+LPZOE5KnkIa2ZeohyGFmVFLwr7ooyPs17
         JaAUNodAgdBGRYfU3pZ0nWcavdbtEvM4G9MN0RGJfC+8IYzdVNXjQj+cBA0YY+5HSu7f
         tjSpBqK3clXRoBaLvAMTNgdNPUAaG4pJok7WZ9yG9XUo4YQEv2P0AVSCL/G2KOi73peX
         q4Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXSOOfdQRYkwSmI7FHbAWwIA/jhcUF0EtwcVH+UpU5GnZP+njSaX16ceDpPQfqQ0247UPJ7QuXKQWpG1Tk265SSqx67m6Xc
X-Gm-Message-State: AOJu0YxTKX4l0ntthTjCbfKGxnCoKQprK4Mz39rTnt9KHrHUcLVuMCAn
	09WX4/PSaggnCmSAToOs2DxXJoV6SyJB/92hdFuNHO+elLUXY5D5tYerKZ1FDyk=
X-Google-Smtp-Source: AGHT+IFjgIZPM/wTkxtpuEU+EUVJy/m5C+7oDBmvhyxI75kL+CM+uIAz/Vm5E0mJYJnHroEmHrjovA==
X-Received: by 2002:a05:6000:1e97:b0:366:e89c:342b with SMTP id ffacd0b85a97d-36bbc1d220dmr1864206f8f.52.1722598875066;
        Fri, 02 Aug 2024 04:41:15 -0700 (PDT)
Received: from LQ3V64L9R2 ([62.30.8.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc83sm1796247f8f.1.2024.08.02.04.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:41:14 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:41:12 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 05/12] eth: remove .cap_rss_ctx_supported from
 updated drivers
Message-ID: <ZqzF2H4ToRwJSr-U@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240802001801.565176-1-kuba@kernel.org>
 <20240802001801.565176-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001801.565176-6-kuba@kernel.org>

On Thu, Aug 01, 2024 at 05:17:54PM -0700, Jakub Kicinski wrote:
> Remove .cap_rss_ctx_supported from drivers which moved to the new API.
> This makes it easy to grep for drivers which still need to be converted.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 1 -
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c   | 1 -
>  drivers/net/ethernet/sfc/ef100_ethtool.c          | 1 -
>  drivers/net/ethernet/sfc/ethtool.c                | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index ab8e3f197e7b..33e8cf0a3764 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -5289,7 +5289,6 @@ void bnxt_ethtool_free(struct bnxt *bp)
>  
>  const struct ethtool_ops bnxt_ethtool_ops = {
>  	.cap_link_lanes_supported	= 1,
> -	.cap_rss_ctx_supported		= 1,
>  	.rxfh_max_context_id		= BNXT_MAX_ETH_RSS_CTX,
>  	.rxfh_indir_space		= BNXT_MAX_RSS_TABLE_ENTRIES_P5,
>  	.rxfh_priv_size			= sizeof(struct bnxt_rss_ctx),
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index e962959676ac..ceafac832f45 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -5786,7 +5786,6 @@ static const struct net_device_ops mvpp2_netdev_ops = {
>  };
>  
>  static const struct ethtool_ops mvpp2_eth_tool_ops = {
> -	.cap_rss_ctx_supported	= true,
>  	.rxfh_max_context_id	= MVPP22_N_RSS_TABLES,
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
> diff --git a/drivers/net/ethernet/sfc/ef100_ethtool.c b/drivers/net/ethernet/sfc/ef100_ethtool.c
> index 896ffca4aee2..746b5314acb5 100644
> --- a/drivers/net/ethernet/sfc/ef100_ethtool.c
> +++ b/drivers/net/ethernet/sfc/ef100_ethtool.c
> @@ -37,7 +37,6 @@ ef100_ethtool_get_ringparam(struct net_device *net_dev,
>  /*	Ethtool options available
>   */
>  const struct ethtool_ops ef100_ethtool_ops = {
> -	.cap_rss_ctx_supported	= true,
>  	.get_drvinfo		= efx_ethtool_get_drvinfo,
>  	.get_msglevel		= efx_ethtool_get_msglevel,
>  	.set_msglevel		= efx_ethtool_set_msglevel,
> diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
> index 7c887160e2ef..15245720c949 100644
> --- a/drivers/net/ethernet/sfc/ethtool.c
> +++ b/drivers/net/ethernet/sfc/ethtool.c
> @@ -240,7 +240,6 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
>  }
>  
>  const struct ethtool_ops efx_ethtool_ops = {
> -	.cap_rss_ctx_supported	= true,
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_USECS_IRQ |
>  				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> -- 
> 2.45.2

I didn't review the mvpp2 change earlier in this series because I've
never read that driver before and I don't have one of those devices
to test on.

I have no idea if I can give my Reviewed-by for this patch (which
depends partially on the one I didn't read), but assuming that other
patch is fine:

Reviewed-by: Joe Damato <jdamato@fastly.com>

