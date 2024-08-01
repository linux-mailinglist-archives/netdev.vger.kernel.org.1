Return-Path: <netdev+bounces-115092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606A945170
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D64283F50
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B581A3BA6;
	Thu,  1 Aug 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWeAl7uB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F413D617
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533238; cv=none; b=LsaMdGv1+Tj4FlJ3HbX30pZuBc4E7XgKkK0FqStktGKNKYgTNxUOK9fpsWHoC4rWUZW3adQESZ/rngLimEMlFBpu/htWbQODbH33RQ9NoHliHOihHtOmOiY8jGmp5HjqcoTGvv+0f0dIjKxk+MdSdgtJ3tQcA+j19T0f3KZiRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533238; c=relaxed/simple;
	bh=B0S+41NYQ07BPI0p5LbbC9oacLtUbGMnTrLBEFaxjHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRVnqvMLOd8uhjBCxqwLcsVg3O3U43H76b25QwnEX/zve7vB2ggjkHUPPC22j/MyQMdiRrhN+PZJanH5+Qwk0nGph0WXoz2itHH2hLj/9Lxg4meoE7he4HP+3U9qaT/EJNZXPV6OS0teFK5u/cdkEp55BqN0g++XwXWItYF0uQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWeAl7uB; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01b8738dso7508842e87.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722533235; x=1723138035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1K2FT8cvcjjCAIw2G241rd6LdGwA1LT2ak19kKTUffI=;
        b=UWeAl7uBb/oX4iJ0HxXy+M3WYh4di7U4482SJHZHSb2ypABCk6AbJA5mr0XxQn0MUV
         QwRiECjayD9c44HKTtxjyWdiVieIoaDSX1GybtzL/q4aXWqNFapLTkmx5A7fikMKeHky
         JcxSlkqAXz4b1mepNA7Ui2/IF6XFRlocFtJWpHZXn1E+v+on8N6+wh8rTOdgEtuPLhKF
         V/HRpPXTGowkc/0phDbkMSHvKG/1omAQTNEgF2CuFjgUzMfQO0GUaVlknoANJkRSQ/HX
         2nlOnvkHZG28VW1Lzht1CLOx0k0pV08QZcvMTbDqK0y6rGkxhka9WNXWXZ5O5P3Bsaqo
         cMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533235; x=1723138035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K2FT8cvcjjCAIw2G241rd6LdGwA1LT2ak19kKTUffI=;
        b=CrODftrZs5yyVwKth3l5akS+qtMtrpvWu+PBuWZ8IpwCF7E54Sg4Ruf0AC8x0jolfv
         c5IGwJEwtifEu8dGakDHy8vdvXGPE1usgCYFtJPVO/lkudMuN7GNCkKinVrmDkjQMgqc
         D23I5xP5xF3cOp8hs4hUtWDZpNQfMd/1oWXl3/gZA302sQwgbre879m/GzpQu7BbOPvP
         9U/3IhI24uWsgy5npe+/WjsbUBzVCwB+IpamIdpVIEZAHCGMJjsYl/lm7ElQacR4jUCQ
         9XGwO83SnIzZUIr3PPkw6msITY0gM5TJP4kd+2rzH+t6biPSWj68j8SDz9KJlJje5pMV
         9Rmw==
X-Forwarded-Encrypted: i=1; AJvYcCU/7l6NjiCIylHTtVkczVTTMSRhx6g83K9av3lcsi/bXaZbsXdzvnn61iKtRDmh+63o7sAmXNJfuanidpFJG460E5cqwIe5
X-Gm-Message-State: AOJu0Yx4XnAKVb08Vsb2J9Y9KTO7rvqMLBvV+bhYITStkUEojCGLAhRH
	7NCdAou2WicbIX+iup/sb5mybpvwlxUIBjsIU6DTiZxUXv4bcunK
X-Google-Smtp-Source: AGHT+IG8ZGOVOG5yDLufbtnlhhvMfhu6Azu2+8uy/siaaJw6PQzJ+3BYVyjJOuAWCRpt2RjGz2CzvA==
X-Received: by 2002:a05:6512:3b06:b0:52c:b008:3db8 with SMTP id 2adb3069b0e04-530bb3a3504mr493718e87.38.1722533234461;
        Thu, 01 Aug 2024 10:27:14 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba3d221sm11285e87.282.2024.08.01.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:27:14 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:27:11 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew@lunn.ch, hkallweit1@gmail.com, 
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	diasyzhang@tencent.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org, 
	linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org, 
	chris.chenfeiyang@gmail.com, si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH net-next v15 14/14] net: stmmac: dwmac-loongson: Add
 loongson module author
Message-ID: <v6qdz4rwtvuw3o5cwrt3y5zudj2qieh4vqlnhhggn4qxkih2fk@s6jp5anujzi6>
References: <cover.1722253726.git.siyanteng@loongson.cn>
 <8b25cf03b936ddd4c29a9883b2ab4d86a2ed7e1b.1722253726.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b25cf03b936ddd4c29a9883b2ab4d86a2ed7e1b.1722253726.git.siyanteng@loongson.cn>

On Mon, Jul 29, 2024 at 08:24:33PM +0800, Yanteng Si wrote:
> Add Yanteng Si as MODULE_AUTHOR of  Loongson DWMAC PCI driver.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 18fc3dd983cb..4666c48dfd51 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -688,4 +688,5 @@ module_pci_driver(loongson_dwmac_driver);
>  
>  MODULE_DESCRIPTION("Loongson DWMAC PCI driver");
>  MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
> +MODULE_AUTHOR("Yanteng Si <siyanteng@loongson.cn>");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.31.4
> 

