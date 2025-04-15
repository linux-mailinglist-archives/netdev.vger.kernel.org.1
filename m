Return-Path: <netdev+bounces-182648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55979A897AD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1CA7A3A59
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626CC27FD6E;
	Tue, 15 Apr 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPm9sD18"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A440027466A
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708496; cv=none; b=iNLyY3/VhvcHZ/N1YcpX5yXDQ7wfHCeckN5o7jU9ds79SdpRzUhI0CatAJowoyFfozeRRykosD77CYALDyLdP7JuaV8erwCEZBBu4+tUlh6hrOiCmZkR+BZfJqDsUSPWTP1ymBLH0A+vHfDt+oawA7G4LSCsKsvHMyNkfpNE5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708496; c=relaxed/simple;
	bh=0eUTeZWOvy/sEdBDw2DnwA5spT7b3OSAoKHMZ2s8vQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frdJ0m8S4UHweuwsywWv6L17jwrdYlCEHPsy5lgew8IAjj+2QZq6pIIcEE5yccjnxVZdFaKtRTAjRQ9fAnsTTFUezRDIziQ0Xz1CBwLwDSCuwIroFQQhP4rL2snbSyNpmW8liB5SG5SQnRbflHwfAwVHiQuoszO9R5vMaQ6yCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPm9sD18; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744708493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xBj6wYND6XkoPsEsHNHqa6He4rhHss1QsFv4wuPqUQ=;
	b=dPm9sD182yGClriC0lxt74jgBaKlm5/tw+lhh8YIWBAg0I0AhZjfFPCw2gOFNS6H0LbQGR
	2pRBIxPIjy5JLzQmQEiERhNxEdEO+RbHxR9RdQAhrVCGRLFxTW7+n0gMnS+EjFyK4w4UB7
	hac9QiezRVmKZfONljw0S+Nqr1eTm3A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-td_cKLYRO1O7H2Jfc8Kj_Q-1; Tue, 15 Apr 2025 05:14:49 -0400
X-MC-Unique: td_cKLYRO1O7H2Jfc8Kj_Q-1
X-Mimecast-MFC-AGG-ID: td_cKLYRO1O7H2Jfc8Kj_Q_1744708489
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so32836845e9.2
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708489; x=1745313289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xBj6wYND6XkoPsEsHNHqa6He4rhHss1QsFv4wuPqUQ=;
        b=lJiXM+e34PxpVCV6g1BEbB5Ildtc7pQpgD+r/z+dAvtA2rkPnoVGmiO1DoCeu+PQ9j
         7n3l1KU7LV9UEMKiJO09GhXteAfD5KApW6NdX+WdBjVMR5OXFqtb3lUaO2z9lDEeH0f/
         ISkgXU7k69Y0hkCVWmVIHuQIEWhzda/H64hzuNGxpdOx0FxmiGR2C0PmcvKRwOc3gulR
         L7qBjYOVCRF1ShraEGOnC/N5OGs5p+rN/BlTRHQEYLMLddOqfBSxN4pnWF18T0TaNH7W
         rw64hS8qbJL/ps3DmBZhvlZXjmcalSYO2pENHtNma/FLLmTsfgn807sNgHr2xBaXmqEc
         Mqcg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Y0NXYnO1CQm3PRoHOFj41uM+qMd4La1QbsNJmMvUTHHBnAVG0rIPYn5nLfFsPV17wALKrAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7UEGLaAOS0TjCeW0+UbqTwxFZa8UQ1E72JtpjazFvnh6niMgP
	wzBd9o1/AxLhFNdirjTAGnigtwE9II9e3yyRRwOqrQiJ/J6wr11KITM6kB+4bhPdTdVTu/5QEOV
	clsqSGifK+I62q82iSpRzKVPXQ6u3ret8x8c4SXyqYIxbi3YCBS1URw==
X-Gm-Gg: ASbGncv2QzK7yM+zc2TF3TE9D2066Y4WxV4ERDoxygr2dg+krgyKuOLRSTmv5n5Mrxb
	plpp7t6d3xaSVKia5UFsJuGmGLVMXeWNHUYIXXVYsk6KnNGPPDPb6oa5Iow+eqZd/DRKU+Fzu0d
	AEz6ak+skiFsyblPG5sAbVQo9Pgi1gAIXrzT1l3XsjwBMJn69gvcdRK+QZsQAIU9hjwQbOUA/1A
	bKAUyqN/LO3ZnIKk1nYUsCzGj2oWuz5x/dWAhOvxgdEcta0U63aut1jPieJdzlA4+Pi7yPKX0ta
	/4vr9oeLsMfEwNAyXCLug2N5rODRHXJ6gWE8niY=
X-Received: by 2002:a05:600c:4704:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-43f3a9af837mr161581185e9.30.1744708488734;
        Tue, 15 Apr 2025 02:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfovw9rzSF7/UhE9C8ntddanjESFbdGIFJq3+2VnKz80vs7HYJjirXobBVEqXPkTQJgbF6JA==
X-Received: by 2002:a05:600c:4704:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-43f3a9af837mr161580875e9.30.1744708488359;
        Tue, 15 Apr 2025 02:14:48 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9797aasm13673088f8f.56.2025.04.15.02.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:14:47 -0700 (PDT)
Message-ID: <6851d6b8-109c-4de0-89a8-a56659c87cf4@redhat.com>
Date: Tue, 15 Apr 2025 11:14:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1] net: stmmac: starfive: Add serdes PHY init/deinit
 function
To: Minda Chen <minda.chen@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250410070453.61178-1-minda.chen@starfivetech.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250410070453.61178-1-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 9:04 AM, Minda Chen wrote:
> To support SGMII interface, add internal serdes PHY powerup/
> powerdown function.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> index 2013d7477eb7..f5923f847100 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
> @@ -9,6 +9,8 @@
>  
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy.h>
> +#include <linux/phy/phy.h>
>  #include <linux/property.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> @@ -28,6 +30,7 @@ struct starfive_dwmac_data {
>  struct starfive_dwmac {
>  	struct device *dev;
>  	const struct starfive_dwmac_data *data;
> +	struct phy *serdes_phy;
>  };
>  
>  static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
> @@ -80,6 +83,26 @@ static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
>  	return 0;
>  }
>  
> +static int starfive_dwmac_serdes_powerup(struct net_device *ndev, void *priv)
> +{
> +	struct starfive_dwmac *dwmac = priv;
> +	int ret;
> +
> +	ret = phy_init(dwmac->serdes_phy);
> +	if (ret)
> +		return ret;

This is called also in case of PM suspend/resume. Do you need to keep
the init here, or should that moved at probe time only? Similar question
for phy_exit() below.

Thanks!

Paolo


