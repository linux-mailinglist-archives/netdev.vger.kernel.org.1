Return-Path: <netdev+bounces-101855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562049004B2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0F31F24E9D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F13194A53;
	Fri,  7 Jun 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOciSxvA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD699193099
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766649; cv=none; b=G6gCswQ/Zdtbg6H142Y21ZZAaq/n1T0IAgckYFEkut6h6O6xLUrvRktFUcCD51za0okOXJmqSpv8W5vKJxd6iLcwd82pztxnMej29CIUrqefdijbioQKjSH3id5NjQtmP7br3NyDoa7WHR7ElZ/Jg9JnCKQ0JD8BdpJwckpiDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766649; c=relaxed/simple;
	bh=4sM4q5itO1Eb5xJyANREchHwndiUR9sJ2nfSR/sd0ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+q/dZtKuW/rUKCEHc37IUJ0o7Eh2LsSwNJT38B8SKweMjjtgWGG+pL2Rv9xFIwoRSsYV+4k914jWle5t6oghcP8eTIHfFFVolLkz586U966LK9qTWfuEGnYOtperLBUvS7hDTYc3NS3DYOegd6i+G0fjd1KW0EFdwsq0/F0dPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOciSxvA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717766645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0njwWl4Xr7B/zKqo02JfY8aEgwHTV+DbOrvBRuVJ/0=;
	b=YOciSxvAug6nc5BW8/tv2jzIOa+J/QxSBg5IBYPVN8QZw/SC5cgRn3zogtinPRfbGDrsk0
	CQ0tDCJe0L5fCkMk68qowhZnJYSo87Z7UdSuXlOnpaQkWHLGZTAj6//elvQmuKO1DovreD
	NnGqEML9XyXQAWxPaKl3Qm8PzbObshE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-5oQ-IL5bNz6EqPfltnH--Q-1; Fri, 07 Jun 2024 09:24:04 -0400
X-MC-Unique: 5oQ-IL5bNz6EqPfltnH--Q-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25074cbcc9eso1962735fac.3
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766643; x=1718371443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0njwWl4Xr7B/zKqo02JfY8aEgwHTV+DbOrvBRuVJ/0=;
        b=lwGYG3VpD8KjwuNK31DGhqqio15FUTldGm0OPseL5dxvlgDMATeyHsroWn2lsJzC1B
         CTtMYoXegRHTcoUWR2QwVO+FE6T7t7ErvAvh1IAFAzeDEc8rFxK8TeF9nEN8kLsjhrEC
         AVd9X6F1LQ5M6qAHiBUyEIe9fg2m+GBFaD5aqfPfKn/BN8nBSoyuXh9NownhtAmgaUYw
         MiCwLdj1hYXb0MBQH8pwGo8tPr9nJXReGfTDP+HxgU561lsZRLB2T2NoQh2jp0jFqRcK
         XdGy8VKo+vHc76j6xatKI5zX3+hoe370Q1t4DYROq+HGItcV4BIkwpOy3W+YwMHxuUOU
         p+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTWAv2q8KsMu6Ir4TPMhR1dODvibfR22JAK62hchEQVkwUDleL2o0gkFbx+uuSw+/6mTPIGEgCvcbCNgvdEiA4tr0VHZjc
X-Gm-Message-State: AOJu0Ywr6eS3GAeN963pdSwasz22awYam4BYVyg06bo1y66Z97JV57E8
	syj4tPJrhpI7aFiVf9beGBy96jrrXrpXLZ+bDG3bw1xG3apPGcSoec3+gLIWTcpMlreG0/AaDvK
	EpbMXNTFJSUq2QYvwOKNnTyfuiXgwyO5lPiyNRgxCHW2J14qnIRT8fw==
X-Received: by 2002:a05:6870:1647:b0:250:7f7e:fa6a with SMTP id 586e51a60fabf-254644ebe85mr2654543fac.23.1717766643655;
        Fri, 07 Jun 2024 06:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwA2CSDWzl4DWmECTbOWHWFKZGJkdSO88z6FFhYWwsyVS9MiJccFJLIeEIllG1fQtMcqXfeA==
X-Received: by 2002:a05:6870:1647:b0:250:7f7e:fa6a with SMTP id 586e51a60fabf-254644ebe85mr2654518fac.23.1717766643236;
        Fri, 07 Jun 2024 06:24:03 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795332e2111sm163946885a.133.2024.06.07.06.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:24:02 -0700 (PDT)
Date: Fri, 7 Jun 2024 08:24:00 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Jochen Henneberg <jh@henneberg-systemdesign.com>, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v2] net: stmmac: dwmac-qcom-ethqos: Configure host
 DMA width
Message-ID: <jtalwaityx7fyakigggyahhhor23fml76yic3e3xkeoimdqoj2@i7fiqzacowq3>
References: <20240605-configure_ethernet_host_dma_width-v2-1-4cc34edfa388@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-configure_ethernet_host_dma_width-v2-1-4cc34edfa388@quicinc.com>

On Wed, Jun 05, 2024 at 11:57:18AM GMT, Sagar Cheluvegowda wrote:
> Commit 070246e4674b ("net: stmmac: Fix for mismatched host/device DMA
> address width") added support in the stmmac driver for platform drivers
> to indicate the host DMA width, but left it up to authors of the
> specific platforms to indicate if their width differed from the addr64
> register read from the MAC itself.
> 
> Qualcomm's EMAC4 integration supports only up to 36 bit width (as
> opposed to the addr64 register indicating 40 bit width). Let's indicate
> that in the platform driver to avoid a scenario where the driver will
> allocate descriptors of size that is supported by the CPU which in our
> case is 36 bit, but as the addr64 register is still capable of 40 bits
> the device will use two descriptors as one address.
> 
> Fixes: 8c4d92e82d50 ("net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p platforms")
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
> Changes in v2:
> Fix commit message to include a commit body
> Replace the proper fixes tag
> Remove the change-Id
> - Link to v1: https://lore.kernel.org/r/20240529-configure_ethernet_host_dma_width-v1-1-3f2707851adf@quicinc.com
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index e254b21fdb59..65d7370b47d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -93,6 +93,7 @@ struct ethqos_emac_driver_data {
>  	bool has_emac_ge_3;
>  	const char *link_clk_name;
>  	bool has_integrated_pcs;
> +	u32 dma_addr_width;
>  	struct dwmac4_addrs dwmac4_addrs;
>  };
>  
> @@ -276,6 +277,7 @@ static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
>  	.has_emac_ge_3 = true,
>  	.link_clk_name = "phyaux",
>  	.has_integrated_pcs = true,
> +	.dma_addr_width = 36,
>  	.dwmac4_addrs = {
>  		.dma_chan = 0x00008100,
>  		.dma_chan_offset = 0x1000,
> @@ -845,6 +847,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
>  	if (data->has_integrated_pcs)
>  		plat_dat->flags |= STMMAC_FLAG_HAS_INTEGRATED_PCS;
> +	if (data->dma_addr_width)
> +		plat_dat->host_dma_width = data->dma_addr_width;
>  
>  	if (ethqos->serdes_phy) {
>  		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
> 
> ---
> base-commit: 1b10b390d945a19747d75b34a6e01035ac7b9155
> change-id: 20240515-configure_ethernet_host_dma_width-c619d552992d
> 
> Best regards,
> -- 
> Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> 


