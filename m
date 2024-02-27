Return-Path: <netdev+bounces-75431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14526869E84
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0124E1C20E19
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9224EB46;
	Tue, 27 Feb 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeOlTK5D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D24C63D
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056941; cv=none; b=jMnbhOIMJxGSujqUlM3/nFom4nH5RgevlpbXz2ur1l0xO+buHuAVj4rEdo50Sppk2eyMaEnNdP+D1tRcG5lw8haHW9+lCYubQqoRPb3FbhqMgapXkhsK8fzzbolXKchzr/8FpuLVhbb5ntzLUmu/hh+L+d+0/WzTjvpv8COXB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056941; c=relaxed/simple;
	bh=9srZA86tRQ0Lc6f+G5Z/wjNPWsbOftV358BYgV3yd4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBqRxvySovN6h8MsXAJO7E3M6etdZp80OdGMVgZh/cIXlllNx2LhurJRhgkk1gViRro9ul4vm26HlbRlNPs1ZmDmfJt8tCRE2IayOz/u9g8cXemim/nJobZTNIL0xUdZIw7BaNi6owZGf+zNIG5R/ZT36FjgOwtzv7125upDy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeOlTK5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709056938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxNc/aFVnNDKr6nzABJwfQofcGO3o2pWudIkQ0RdBpM=;
	b=XeOlTK5D9UJCZNraGwT15E8NWY2cZ6q2VWuAxzVf5DNjW+7GOGEVYZJFLZW5c2spr9DMvD
	o56vJFoFAaMWeT+Zhh4Qex5tP8qLQ0NZM6jXdbnnRP1tCLJusibvKGFaRBN1I+FVHljMah
	6XrZixLG6NdDuP5Mq3uK0//YujfwHYc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-TkfoeDqzOsyF4bdtdhz5tw-1; Tue, 27 Feb 2024 13:02:17 -0500
X-MC-Unique: TkfoeDqzOsyF4bdtdhz5tw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42c7a807fd0so47740591cf.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056937; x=1709661737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxNc/aFVnNDKr6nzABJwfQofcGO3o2pWudIkQ0RdBpM=;
        b=MJhv1Za6Af3r22pEObILLsu5hH1RO6hURRnwqHTDY5MqjgdFanbPLBq99w4AmJ/tBo
         ws+3gzlNP+WJhqM+tRLdbFalqh8ywkTF7iGASlD2mDWO8JU0Qf5ILAdX1qLSoXBRj/5M
         uRHR8ttju8tZt8ZSMKZolaVdDgiGSnJgzvCvvLBXioHf2oEbuBL3dKmtiijIvD6F17Li
         6u93sioW0nSEmWXfLuE7FllLr1Dpr1P6fQEYQGCs4Vfje0vCGM25ze9KLTvoWQDyes66
         lLZfJ5W88oIRayMYBLZEzWmifrDIM7wI0seKzUTVS5r2pW/7cSaGChNvRKOijE/WUZPy
         sEcA==
X-Forwarded-Encrypted: i=1; AJvYcCXUpd+LBuMp3Uam4LjMPfLdm8oGCwZMsZ7eFgGA83TkAr7u8+p3EuWTk6r2kO+l8n0BKkLtGg1t0w+IP4Sic7cTXEfqZGk/
X-Gm-Message-State: AOJu0YwHSK/W/FUtHu2uOUdaAppUdvd01MtoxnKEb5f+VYb8QEDzeHOU
	QmCN/C3RSl6XjQassTTEoKlHldch6ZyxbojBia9I59NN+8BRY/TQMWnXs+2blE5lwJiQgsKhk76
	0pXOVPGoWygMqnvXKt27Vjobp1pj3txV5WxWsU/1rqPPN2+sxQ8FLJQ==
X-Received: by 2002:a05:622a:1a97:b0:42e:a717:cbca with SMTP id s23-20020a05622a1a9700b0042ea717cbcamr802362qtc.41.1709056936787;
        Tue, 27 Feb 2024 10:02:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdFPNupQsoGCNMoyarnVyVV+samDOQcNLB9zEJi7UDBBSyn6KQpoOrEG/VbkkBYeBv36V0Uw==
X-Received: by 2002:a05:622a:1a97:b0:42e:a717:cbca with SMTP id s23-20020a05622a1a9700b0042ea717cbcamr802291qtc.41.1709056936129;
        Tue, 27 Feb 2024 10:02:16 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id f12-20020a05622a1a0c00b0042c7b9abef7sm3766020qtb.96.2024.02.27.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:02:15 -0800 (PST)
Date: Tue, 27 Feb 2024 12:02:13 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Sarosh Hasan <quic_sarohasa@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Prasad Sodagudi <psodagud@quicinc.com>, 
	Rob Herring <robh@kernel.org>, kernel@quicinc.com, Sneh Shah <quic_snehshah@quicinc.com>, 
	Suraj Jaiswal <quic_jsuraj@quicinc.com>
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac-qcom-ethqos: Update link
 clock rate only for RGMII
Message-ID: <3refwt5x2xplibxkne5sae4ybic7inzmfwna4vkhprpf3nyqom@lwng6mkbe3gc>
References: <20240226094226.14276-1-quic_sarohasa@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094226.14276-1-quic_sarohasa@quicinc.com>

On Mon, Feb 26, 2024 at 03:12:26PM +0530, Sarosh Hasan wrote:
> Updating link clock rate for different speeds is only needed when
> using RGMII, as that mode requires changing clock speed when the link
> speed changes. Let's restrict updating the link clock speed in
> ethqos_update_link_clk() to just RGMII. Other modes such as SGMII
> only need to enable the link clock (which is already done in probe).
> 
> Signed-off-by: Sarosh Hasan <quic_sarohasa@quicinc.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

> ---
> v2 changelog:
> - Addressed Konrad Dybcio comment on optimizing the patch
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 31631e3f89d0..c182294a6515 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -169,6 +169,9 @@ static void rgmii_dump(void *priv)
>  static void
>  ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
>  {
> +	if (!phy_interface_mode_is_rgmii(ethqos->phy_mode))
> +		return;
> +
>  	switch (speed) {
>  	case SPEED_1000:
>  		ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
> -- 
> 2.17.1
> 


