Return-Path: <netdev+bounces-196581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B4AD5792
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E417A7E44
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F1289E19;
	Wed, 11 Jun 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="d0/+qU2W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27641E487
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649922; cv=none; b=HMcRhUpMIciPsp4Egh4kni/ZzIdOLgUw/uy2uKG547yr87yuSAiuuMAo/xtONe/5H++MEGzo9VhXpsfitLkbKdODCOCPEIawWcLyV+Fd68aXfnoOajigGc5NcXLX4s/yNzbFKd4ftcr4zqeLe9mOrv0HzwpJFunXHrWtfXLin68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649922; c=relaxed/simple;
	bh=IQg6sE+GXGtuGT5EQ5comWisqQkhImYrlyIoJDnpRqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPSpLshKVnWEJR7cmM0gxeEQweNZ9tT+J7rsaaNiS46MCzFFYaCo+mSneHy0br71MGGHlpcupQYYR7LA06PTYv6vMUgAUUkk8z/v9HBmWMXO4U8NEpv4bSPx9WdzqH3v9q9QOvc+QSZVwcRE6/87Q/MkR8w8dwWxOeHsZNcuIJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=d0/+qU2W; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so81652455e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749649918; x=1750254718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk07ZvZc5eFy3eUxLG9h1u7SCyvu16FN4Lb9FHyD5Yg=;
        b=d0/+qU2WYrNGiH1HgXB1oVaVzBI9EiEZqgE2TwmKdPWzDv875VNcSXWG3pEcqf8tqj
         YOCL4L7UWUXZidzAsc6oN2YOiuH0KTX1/FFrgTdTQCQh0xxOPA2kcq7Dq8U0CGcpQjR1
         UVZ0LAZWB6bJGuXZ/YETZRBtBoAQ9EU8ekPdPHfLQoPEdPTNCDxvWTNpS7dnXyN4+3MP
         brU0oqYbGIzwBImd08/KltmEXtqW0nZQ3SnU13BIUxIGD3scL8bVBdcVaZjwmznKKhSC
         0Ok3/nfv9epU82Q4aSAOOulXWFMuZ0pnD5kL3Zla8e3xOllscCrZ4WnW0VSpOPjXhQ2E
         5SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749649918; x=1750254718;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk07ZvZc5eFy3eUxLG9h1u7SCyvu16FN4Lb9FHyD5Yg=;
        b=k55VW1ku0+vHL9kyh1tiL5u+mpuWzwHSGmqemvesEQDeG15jZ9112hCI7w1LyPE9a5
         wxYUk0xFZc0JEBIZyw6NZ8vz4tvw8+rXEyF2XeGyGm4QmZjdZowmf3Pzh7HO6n/+B7Hu
         Bu5A26Ws9LkBqKlZ/3CxcQ5TjoX1MoLp8vFbKV9OnG53rEv/PC+0DreFvwDabgepxb5H
         fLo0e60zpb4eTr3eAP6QtAEAadW8bAjbdp0oY3BTwbPN4hlq5PYR2WYo44B6DXxgh8w7
         ElM2BKmxJiZ0hdzatuenbZpe4WnHwnsEzUjtlmfSMjn+x1LlHcRGFqGp/KHDz3rjCzSk
         zRew==
X-Forwarded-Encrypted: i=1; AJvYcCUqB4S0zemMYWpy2a2CaL8fw1t2vHMCVsmEaQHgDbGUKL5TlUjEwXFM6CCWafDTvYico5m5D/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8+cn83CHIZXZJDjwoW3Lr8hkQ0y27ANNPmig2Xqah+tEtp6n
	cRAWaTMXNROduMjY9I4EN9i5SIkOHkLU51SSRLge+Iypx7AyBnc98PYh4Lsxvnjd5pE=
X-Gm-Gg: ASbGncskCNatt6kJH6GoeVDenmV+eEz+SKogUfa9nbx6bfTyZucaQHNWLIYErmIphOR
	pCpkfIl39Xg8uOd393raxs1CPLLmrHuTz89erAVdTGH+LqJb479+AzpENAflC4ydudHVNXVwAoq
	n9gVJ7AMGxo1C6p7YZyxoBhifWCPhXDnedJbKh6HUvwikyHljR0TmBZBXNtH8HhPq8zFkdq6eNT
	Pte/Zivpj8gv07cIcZzCknKcw4Qc+igsN7quVUm6v+CFNxskwAKtymGveKd7JBR1SRJJD73NOxO
	52clXMd3iIqPBIbuxtboKfn97P9lU0ZnrFfTXgLmgwc5h191eipuzTCxHpxxAbv7fCM=
X-Google-Smtp-Source: AGHT+IG9nZtd3+hc45FxaZnApDjwjY+12DSVJ111XehV5YK/VpAjb4ZvVhEVhVJntSmvf+qT+b6/nQ==
X-Received: by 2002:a05:600c:83c6:b0:442:ccf0:41e6 with SMTP id 5b1f17b1804b1-45324879755mr36028615e9.3.1749649917743;
        Wed, 11 Jun 2025 06:51:57 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45325191994sm21839805e9.29.2025.06.11.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:51:57 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:51:53 +0300
From: Joe Damato <joe@dama.to>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next 1/2] rtase: Link IRQs to NAPI instances
Message-ID: <aEmJ-b8ogdb3U5M4@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, horms@kernel.org, jdamato@fastly.com,
	pkshih@realtek.com, larry.chiu@realtek.com
References: <20250610103334.10446-1-justinlai0215@realtek.com>
 <20250610103334.10446-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610103334.10446-2-justinlai0215@realtek.com>

On Tue, Jun 10, 2025 at 06:33:33PM +0800, Justin Lai wrote:
> Link IRQs to NAPI instances with netif_napi_set_irq. This
> information can be queried with the netdev-genl API.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 4d37217e9a14..a88af868da8c 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1871,6 +1871,18 @@ static void rtase_init_netdev_ops(struct net_device *dev)
>  	dev->ethtool_ops = &rtase_ethtool_ops;
>  }
>  
> +static void rtase_init_napi(struct rtase_private *tp)
> +{
> +	u16 i;
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		netif_napi_add(tp->dev, &tp->int_vector[i].napi,
> +			       tp->int_vector[i].poll);

Maybe netif_napi_add_config can be used either in this patch or in an added
3rd patch to this series to support persitent NAPI config?

Otherwise:

Reviewed-by: Joe Damato <joe@dama.to>

> +		netif_napi_set_irq(&tp->int_vector[i].napi,
> +				   tp->int_vector[i].irq);
> +	}
> +}
> +
>  static void rtase_reset_interrupt(struct pci_dev *pdev,
>  				  const struct rtase_private *tp)
>  {
> @@ -1956,9 +1968,6 @@ static void rtase_init_int_vector(struct rtase_private *tp)
>  	memset(tp->int_vector[0].name, 0x0, sizeof(tp->int_vector[0].name));
>  	INIT_LIST_HEAD(&tp->int_vector[0].ring_list);
>  
> -	netif_napi_add(tp->dev, &tp->int_vector[0].napi,
> -		       tp->int_vector[0].poll);
> -
>  	/* interrupt vector 1 ~ 3 */
>  	for (i = 1; i < tp->int_nums; i++) {
>  		tp->int_vector[i].tp = tp;
> @@ -1972,9 +1981,6 @@ static void rtase_init_int_vector(struct rtase_private *tp)
>  		memset(tp->int_vector[i].name, 0x0,
>  		       sizeof(tp->int_vector[0].name));
>  		INIT_LIST_HEAD(&tp->int_vector[i].ring_list);
> -
> -		netif_napi_add(tp->dev, &tp->int_vector[i].napi,
> -			       tp->int_vector[i].poll);
>  	}
>  }
>  
> @@ -2206,6 +2212,8 @@ static int rtase_init_one(struct pci_dev *pdev,
>  		goto err_out_del_napi;
>  	}
>  
> +	rtase_init_napi(tp);
> +
>  	rtase_init_netdev_ops(dev);
>  
>  	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
> -- 
> 2.34.1
> 
> 

