Return-Path: <netdev+bounces-93320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D038BB311
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC31F21089
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED941A80;
	Fri,  3 May 2024 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCXUBVFd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526A1586CF
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760933; cv=none; b=R/deNRB/RJzX8AVnYyDwUQOVKMPAycdB8d+MqHcFmqQjKSuraIlee+Buhmqo44KoxzwrLzuqvWeJ86YZtihZ538i/vyPOezJgdheDoO0GrtXByFjZAT9h0eC2N8ieQsToFn7g7GsXVP6+qlyKHTXc2+N+O2X/jfUI1YSXNARER4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760933; c=relaxed/simple;
	bh=npffo0e1zRq6R4twLVRetRUpQI6hMdSILB1zHl38IHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYMyRmwW8sVMJqdpDO5/78F+An/rIiOZgkws8sUNd/aNUBMQNi3VusDlxEuIbgT0Lmyo7ix874nY4PT6YzJcREIfHuKhvhZvPBr3Ol5r5g6siIguJtnwz7uI4OZlXclncvZVvu8ePqV4TMZzc5hZOzRhSqrqhlak3FFkEgHJLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCXUBVFd; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so72002881fa.3
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714760930; x=1715365730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrLew+ZRWyWSe5glkfxZkdrbhALrKHoP30MwVK/uBPM=;
        b=CCXUBVFdiRIvrU2zKAhNvvk3YSDVluc7EhV0yqSN7KviALbCvGEkRU8aw4LhzLK2aw
         Bf8t7jOEaXUQPp9vc+NSVe/74uJ0P65AbVSSTek9UJZ3g1Lwt4yMHzgn4tZTNF7zGR6L
         oSpA74p6IvCQgiHxds9+TS0d0ZyUmaJPqR7gmCbm/TsYSiNYIilFXkGUjG3Sv07K1cu1
         wAMZJhRnBpA0vRgTGgLeZtHKVEiKS/K0nRfaGj5phvaPwJb5reX9yrLX1WsS0I2SO3hx
         9RfzDiHB9BtbpJBJuAGp7iHp3NfEgwjc5l2FA079UGvvn2Bd8baeuZQWx99uQoLgDbM3
         mTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714760930; x=1715365730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrLew+ZRWyWSe5glkfxZkdrbhALrKHoP30MwVK/uBPM=;
        b=E51/AlidnFx3lnU3IqXRVS8E+R+3MVxUBPI/thjbiTERgZmVmV5LaJClN3qBPuuoVH
         JcGut+fwIErAydY/sTorIeY2iBjM4jCRwLtoWobOn14F9p3zFo+x6g+o0kkfBmyiNNTP
         W3l3dWk5ZiLlqVJcPv6OGXv7L8RC4Sfx84Jox//k7JCP7ByfjqzxpbeUiu4vIgPeRn0t
         HR//oXrajUXF5+nWJQTYJItGahQbqHtSIyUvmwr+v0aWi6urs//T6VYDtKGNosgjitqk
         NN5OB/WKa9KRCpCV794NipFH3jPhqgoz8ObKDcVMTlOeLgNS3Wqvst7FyiUqEU7i96OB
         ABeA==
X-Forwarded-Encrypted: i=1; AJvYcCUmvT8d1DUdPxJNG0wrwUcQTMZiAf/2CiXXKqYG0fkuSS9JyJ2e0PW0r8wcgFhdjlsU4KmMZmilw32H6YO7cvF5jRWyGYQR
X-Gm-Message-State: AOJu0Yw60YHCG9Lfqj5qdgdAI9uFfSpThUeL6kQRoA0XnDuOSGVUGLS9
	orHs3PE5Nqa/U2P1Vg4XTpED6PQ9VtEB8SAMdBck9V6KoS5LA8Mr
X-Google-Smtp-Source: AGHT+IFp0Ub+dAS1SSR679BWs2uU8A0MR4TOSQd/r7+uLZX/E4EAPz/0djLxvvZOG2iHzUOWzUXqXA==
X-Received: by 2002:a2e:924a:0:b0:2d6:e295:e81f with SMTP id v10-20020a2e924a000000b002d6e295e81fmr3046565ljg.35.1714760930040;
        Fri, 03 May 2024 11:28:50 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k16-20020a2e92d0000000b002deeb97685fsm598690ljh.32.2024.05.03.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:28:49 -0700 (PDT)
Date: Fri, 3 May 2024 21:28:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 08/15] net: stmmac: dwmac-loongson: Add phy
 mask for Loongson GMAC
Message-ID: <uc3stkm4yyaudv7x3gaarx2xipxglrrnwo4ixht35gkaq2bec2@zpg6roiq5pnu>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d0607989f5bf64c4251259af72d8816469e8865f.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0607989f5bf64c4251259af72d8816469e8865f.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:06:11PM +0800, Yanteng Si wrote:
> The phy mask of gmac(and gnet) is 0.

First of all the GNET PHY mask won't be zero as you setting it up to
~BIT(2) in the patch 13 yourself. Secondly the stmmac_mdio_bus_data
structure instance is Z-malloced, thus it will be zeroed anyway. So
the only reason why the explicit stmmac_mdio_bus_data::phy_mask
zeroing would be useful is to signify the difference between the GMAC
and GNET devices. But that difference could be relatively easy
inferred from the code. So to speak IMO the patch has a little value.
I would drop it.

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9f208f84c1e7..f7618edf4a3a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -48,6 +48,8 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>  {
>  	loongson_default_data(plat);
>  
> +	plat->mdio_bus_data->phy_mask = 0;
> +
>  	return 0;
>  }
>  
> -- 
> 2.31.4
> 

