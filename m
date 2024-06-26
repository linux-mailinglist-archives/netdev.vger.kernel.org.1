Return-Path: <netdev+bounces-106974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D881C9184F4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FE01C212C2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0297186289;
	Wed, 26 Jun 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arXtvvLW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BA1850B8
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413695; cv=none; b=dsaKY829J7q1Tm8VTu+jVuGolbCXUW9mQJlTMhHvrjwyEEpV4Hkp9j5rMznxrzcOz8IWqDs3BManJ6G7v+o99uRx9ajSNLvlIcKMUncrB2HSUxrgLiJ7FkG4/6d+3dm4nDvILaPg2ZK9esu3QeJZtYw49U+FjHJCsZpk2ljtpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413695; c=relaxed/simple;
	bh=ToVPHIWzkFAgSpb6L6E/HYsaFQq0ccl5RG4nq4ckWes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdeyPo7EAgUR5KuexTo/C/meldop7U65MmK49ITmJbk6TavjSvi0YUSYnQGJvX1nkjF+2f7sJ+ILgR0xR0/Y/0fTLoW3QdBa8B5zQLgba5e/2rzW/kwjYY+WHFHAr/d9qGflMCmCsyYV2FOFRw28mmbHKarPf2cJk10iB+niYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arXtvvLW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719413693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//2/DtIq0ARa2uL83ir1t16NVZrzvNrg5uroU1ouOJc=;
	b=arXtvvLWs+ar8iRaggjwEAU7s232EA3QciFGWjuTf0RdQebeMyEXaQrXah24q9x7yyHoHM
	o+uf8ozgNIe72YAJOk/aJOZMFHTGvzjWT440Im8GPwjdiRTGi3Wg0KetT1TR91XNxPoM/H
	FGs0oZd5O2mni9Gv74f3uR5pWCh0iXo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-2aej7RnvOHqTmoQhBPSAgA-1; Wed, 26 Jun 2024 10:54:51 -0400
X-MC-Unique: 2aej7RnvOHqTmoQhBPSAgA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b22e2dfa6cso118601316d6.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413691; x=1720018491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//2/DtIq0ARa2uL83ir1t16NVZrzvNrg5uroU1ouOJc=;
        b=Euf+Evo+aKMtfsinsSnP955Su4Cz8q2seol6l7k01kg77QgQLVv6dZy2XSjxU47dw3
         Rav/OObBwC9qsLfRYo3i7LDf00KuVrYrb/Kg4tBBht+444i5/byCDQXQQvaVECahLB+b
         KICaGWW2l272L9OX8NX4VXkjvj9/awHXIq5Gw/rvEyoikRuz0Ya66lC+LyuTPldzzzgQ
         m4utiiI4h7DF4u7s0SvmCQ6N6UVOuTgTV4Jl1B3+x37uPjhiNn3ykA6vTBFVod9MDttU
         ua9MLcQTe6xQEvyvXL5KqxHHkk1Nz6i+/haR5sdBHsx+tHNMbM5gtrzYaKLRRzVSZE+g
         tFMA==
X-Forwarded-Encrypted: i=1; AJvYcCVdGV6I/vayYwsB3fEgOG3xxuE3rpQxqEpv1sZLBT6Aazg4KbUeAvE7HbbYSim38/XB/wRdpctzqAtjTY46JxLTGsb0zLWc
X-Gm-Message-State: AOJu0YyT+I0aZB+6WIMN8hZkugYxR1AbUg94m4jUXkeh6bPYq2XkDO9z
	uwRADtvcHpWHV7SRLJ7qxebZ3YwhegcA6FM4zvtGVQreRhulbkAOFs94MTtjgDPHDtItCfnQQqN
	9P+GaPvRknWOlt4RLgOTDYjlp2aAwCSA1pQ0LUiSZNlNbEx6tHpHDzw==
X-Received: by 2002:a0c:8d8e:0:b0:6b5:4bf8:57f0 with SMTP id 6a1803df08f44-6b54bf859b1mr86412256d6.48.1719413691346;
        Wed, 26 Jun 2024 07:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2KWuzVgP6gdLOaQfx8FcyTgNfdnV8FG80Y5HA1R10pLIJSc4H3+AKQ0TSGSjJssFCY/jspw==
X-Received: by 2002:a0c:8d8e:0:b0:6b5:4bf8:57f0 with SMTP id 6a1803df08f44-6b54bf859b1mr86412086d6.48.1719413690987;
        Wed, 26 Jun 2024 07:54:50 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef54b40sm54996006d6.114.2024.06.26.07.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:54:50 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:54:48 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, kernel@quicinc.com, 
	Andrew Lunn <andrew@lunn.ch>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: stmmac: Add interconnect support
Message-ID: <owkerbnbenzwtnu2kbbas5brhnak2e37azxtzezmw3hb6mficq@ffpqrqglmp4c>
References: <20240625-icc_bw_voting_from_ethqos-v2-0-eaa7cf9060f0@quicinc.com>
 <20240625-icc_bw_voting_from_ethqos-v2-2-eaa7cf9060f0@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-icc_bw_voting_from_ethqos-v2-2-eaa7cf9060f0@quicinc.com>

On Tue, Jun 25, 2024 at 04:49:29PM GMT, Sagar Cheluvegowda wrote:
> Add interconnect support to vote for bus bandwidth based
> on the current speed of the driver.This change adds support
> for two different paths - one from ethernet to DDR and the
> other from Apps to ethernet.

"APPS" is a qualcomm term, since you're trying to go the generic route
here maybe just say CPU to ethernet?

> Vote from each interconnect client is aggregated and the on-chip
> interconnect hardware is configured to the most appropriate
> bandwidth profile.
> 
> Suggested-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h          |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     |  8 ++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 12 ++++++++++++
>  include/linux/stmmac.h                                |  2 ++
>  4 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index b23b920eedb1..56a282d2b8cd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -21,6 +21,7 @@
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/reset.h>
> +#include <linux/interconnect.h>
>  #include <net/page_pool/types.h>
>  #include <net/xdp.h>
>  #include <uapi/linux/bpf.h>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b3afc7cb7d72..ec7c61ee44d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -985,6 +985,12 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  	}
>  }
>  
> +static void stmmac_set_icc_bw(struct stmmac_priv *priv, unsigned int speed)
> +{
> +	icc_set_bw(priv->plat->axi_icc_path, Mbps_to_icc(speed), Mbps_to_icc(speed));
> +	icc_set_bw(priv->plat->ahb_icc_path, Mbps_to_icc(speed), Mbps_to_icc(speed));
> +}
> +
>  static void stmmac_mac_link_down(struct phylink_config *config,
>  				 unsigned int mode, phy_interface_t interface)
>  {
> @@ -1080,6 +1086,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  	if (priv->plat->fix_mac_speed)
>  		priv->plat->fix_mac_speed(priv->plat->bsp_priv, speed, mode);
>  
> +	stmmac_set_icc_bw(priv, speed);
> +
>  	if (!duplex)
>  		ctrl &= ~priv->hw->link.duplex;
>  	else
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 54797edc9b38..e46c94b643a3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -642,6 +642,18 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
>  		dev_dbg(&pdev->dev, "PTP rate %d\n", plat->clk_ptp_rate);
>  	}
>  
> +	plat->axi_icc_path = devm_of_icc_get(&pdev->dev, "axi");
> +	if (IS_ERR(plat->axi_icc_path)) {
> +		ret = (void *)plat->axi_icc_path;
> +		goto error_hw_init;
> +	}
> +
> +	plat->ahb_icc_path = devm_of_icc_get(&pdev->dev, "ahb");
> +	if (IS_ERR(plat->ahb_icc_path)) {
> +		ret = (void *)plat->ahb_icc_path;
> +		goto error_hw_init;
> +	}
> +
>  	plat->stmmac_rst = devm_reset_control_get_optional(&pdev->dev,
>  							   STMMAC_RESOURCE_NAME);
>  	if (IS_ERR(plat->stmmac_rst)) {
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index f92c195c76ed..385f352a0c23 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -283,6 +283,8 @@ struct plat_stmmacenet_data {
>  	struct reset_control *stmmac_rst;
>  	struct reset_control *stmmac_ahb_rst;
>  	struct stmmac_axi *axi;
> +	struct icc_path *axi_icc_path;
> +	struct icc_path *ahb_icc_path;
>  	int has_gmac4;
>  	int rss_en;
>  	int mac_port_sel_speed;
> 
> -- 
> 2.34.1
> 


