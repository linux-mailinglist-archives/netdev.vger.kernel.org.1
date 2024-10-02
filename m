Return-Path: <netdev+bounces-131338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05FA98E234
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 20:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43411F2484F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A94212F08;
	Wed,  2 Oct 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZzK0ug6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98E212F04;
	Wed,  2 Oct 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893270; cv=none; b=LsjWQKa/AGiFgWbLXi3GZEfP8O/UiY3IMPCnz91Maolt40RFcchoXgSiBRXE+fX/T8O9NQ8wRujpj5Yov5yKa2g5VzqzWAVqbw8A+bPdjrKT+lEn9APB+aRn1r754I2mas6Y4pjCWS6JeJxM6MmTAygfTYroVTNPAZfFd/zHFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893270; c=relaxed/simple;
	bh=hPdpVDsCrGTU5WT161rWXyLlYVaN7bsNYvjZMDplt7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVh7l0LF0OyXraOEi1fInxwl5VGm4DuePEonqqTib5KrSy/kCwpxXDblvqo9Gq6g2a6TbhHldpoAN6qS7feKwI717DA/xU0Sp4ufcFfOIUXpiqQKBwbSCYW9EAIsJ4/QKkOOpsuvD0Tn6lCbiQHaY1qTJqTOckRDoRiVUYKu87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZzK0ug6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cca239886so72250f8f.2;
        Wed, 02 Oct 2024 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727893267; x=1728498067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcHxLYnLTIbgSNaqFbGV229B42GhTMbV7RRVChU65pQ=;
        b=GZzK0ug6FAtWcReo2PdY9loxU8ZFO3FimtyRcnG+q6teHB4vqiLiHMGZO2AQobS+/k
         kfdUIjcw8tOUBk4kf++XE/hdhJXTCEB3VcfgoVY0bynK5YBLNESlGZcqp9t9BIINp7Ji
         rx2WsIlowiRjoKD8OdueQdaEwtAaxX4PJ0kblgc1Hx53DPQFdiXfkvtDhzW68DGLrfnl
         ecMg06f2mGxEnq7mbvMAqpalNKRuI1gqPvSGLG4U+yWncIy/Q8zkj4sLzp5Zi1hAqVch
         PmD2GrTUovLX0HDex2Q4VcdO5k2eYan2IJfYXAuAYlo4um6cDUlufEop0JvuYSfpR6IJ
         JDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727893267; x=1728498067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcHxLYnLTIbgSNaqFbGV229B42GhTMbV7RRVChU65pQ=;
        b=wcr0eT83922JaZ8Bpzv2ej6bgnOAR4/I1a79CIbExwNTB9i2bXJNdB8w3Z9EGl8NnY
         TmYdP+kZVv9Mj3Fizb4l3n7sCOvosANMQ/HExGjmBzVceqhl5ml9XPOsTmyu3pED34f+
         TloZGnnBvcu0lhMOQ3xEGm23/uieRhuRzEiCGWFM9hv4dH6tInm/2FpxplMneiS2sjdx
         9MZthIkZ6f+qyzcax3ru9TGmfQxf4EbOrKgwxD+/8lP74Sfino6Hp5comlVv7ungEvN8
         M897HaZ6GKXhyCfp05KmZ3DjgLEtEy2IApcVXsg09idG1LvTjOVyaF8EZJic9buHG+vT
         HDaA==
X-Forwarded-Encrypted: i=1; AJvYcCU7IYhcVSlsq/+S025rfu4I1/Fhr9wy5RhldZhOMEslyQcSXUCavWhdEG9sLIMqCqQt0c7T41nCILWQ2Nc=@vger.kernel.org, AJvYcCWUoMLUyNXYOPhNA4jaFD+U+B2xbyCUUvo+UpNjCtrSGQ3DRrz8V2aHLrn2PgQ0wjxrt7sdwZlJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdheAmoybJCnn2biaOSJbi39MEtWN1mKaogQtBsEyFPbupIf9
	/cB16CThLv85miFQu05LEM46MCfknWiyhKXCB22pQN1fvXqZLihc
X-Google-Smtp-Source: AGHT+IESxt1FuolPgZUDq2iAri400mySBOJw/9ODZjUKojpeyviUhp2hg3+MAS+yVKUPdDGcJw1uZA==
X-Received: by 2002:a05:6000:50f:b0:374:bd48:fae9 with SMTP id ffacd0b85a97d-37cfb8d066cmr2778922f8f.20.1727893266694;
        Wed, 02 Oct 2024 11:21:06 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01f514sm25748765e9.32.2024.10.02.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 11:21:06 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:21:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac4: Add ip payload error
 statistics
Message-ID: <lebai2y7xgrf72tbhwcxklhs5u3y6uz24vyrew2fjssspwn35d@pnxj5t6trnm4>
References: <20240930110205.44278-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930110205.44278-1-minda.chen@starfivetech.com>

Hi Minda

On Mon, Sep 30, 2024 at 07:02:05PM GMT, Minda Chen wrote:

Since v3 is going to be required anyway, here are several nitpicks:

> Add dwmac4 ip payload error statistics, and rename discripter bit macro
> because latest version descriptor IPCE bit claims ip checksum error or
> l4 segment length error.

s/dwmac4/DW QoS Eth v4/v5
s/ip/IP

L4-segment is a too broad definition in this case. The doc says about
just three protocols: TCP, UDP, or ICMP, so

s/l4/TCP, UDP, or ICMP

Other than that the change looks good.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c | 2 ++
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> index e99401bcc1f8..a5fb31eb0192 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
> @@ -118,6 +118,8 @@ static int dwmac4_wrback_get_rx_status(struct stmmac_extra_stats *x,
>  		x->ipv4_pkt_rcvd++;
>  	if (rdes1 & RDES1_IPV6_HEADER)
>  		x->ipv6_pkt_rcvd++;
> +	if (rdes1 & RDES1_IP_PAYLOAD_ERROR)
> +		x->ip_payload_err++;
>  
>  	if (message_type == RDES_EXT_NO_PTP)
>  		x->no_ptp_rx_msg_type_ext++;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
> index 6da070ccd737..1ce6f43d545a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h
> @@ -95,7 +95,7 @@
>  #define RDES1_IPV4_HEADER		BIT(4)
>  #define RDES1_IPV6_HEADER		BIT(5)
>  #define RDES1_IP_CSUM_BYPASSED		BIT(6)
> -#define RDES1_IP_CSUM_ERROR		BIT(7)
> +#define RDES1_IP_PAYLOAD_ERROR		BIT(7)
>  #define RDES1_PTP_MSG_TYPE_MASK		GENMASK(11, 8)
>  #define RDES1_PTP_PACKET_TYPE		BIT(12)
>  #define RDES1_PTP_VER			BIT(13)
> -- 
> 2.17.1
> 
> 

