Return-Path: <netdev+bounces-107406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E391AD6B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8030D283944
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067A19A2B4;
	Thu, 27 Jun 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhxwQcjH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31F199E89
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508053; cv=none; b=J6Jw2+O6WqWx7xQGbVwUNAc+9aaDtuQfiX5THRwxumInX4oM06z4eNHjJcObDL/Cd5fdQDveL7rDnjyEJKhV3kjbW1/cCCjgqaKb10SOytu/SZPX69n2eM0YSwABmKhPzuDaGGoKKsLmSEr6/bz4l/M0WsJMKuu/FrCExSYq9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508053; c=relaxed/simple;
	bh=TilR43KIjFBeRdL1uCN+cULd4RllUEvgtbiOqptaisg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Z0f8TshvkzurHSEQvH6jLB2ZLC52+WwtgRXYPLNTsYWqQl9h2Ma2YIuYR3gz1ZKzyWQU7s170WhxsVZ2FJ/dbg6t/dstHuTZLWPiaXJp5GV9cIi2HWX9fO5NeqdcJGq6txOfw5FMbKpyYOf8bUvkbM/t1n/LTjZO/bUN3Y12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhxwQcjH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719508051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIxdFP2i4FT3D9Pm46UxMYOadfBkfMsZfXfJZXYueno=;
	b=YhxwQcjHYsFF+/e6gp8Wqg/lUWLGGAYhgljYQ4v0j/mGJXGJx2ecxcQKD913FVllo0wzMg
	XXImUt2y5YgRSEKhHLCo4Ph05r4qxL1pgRfIvJVAjC5c6eyddDicJ5q/fc2kgLNqygeTkH
	LrVWaxtsQhD6BivePdAUTy+5Y7Q29SM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-BrPMaSBXMRKFuEo5mIJFVQ-1; Thu, 27 Jun 2024 13:07:30 -0400
X-MC-Unique: BrPMaSBXMRKFuEo5mIJFVQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79c0ffc2351so403234885a.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508046; x=1720112846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIxdFP2i4FT3D9Pm46UxMYOadfBkfMsZfXfJZXYueno=;
        b=CjuKGthuj1KfSL9rmKZjHI9kF1SPlS6FLfnoSRSJJjooQCGgbmOXOTCQtHe2J6yrm5
         onGW0T7LIL/tkTeSb1SN6nz4+3NH6fu79/61/tOPD4QyUW62N4Yz3O+SSI7PkF/zmzSj
         kIUzk/acZT/k6eSWSFN1BIxYteSQlB1gPYlyoYV1jKZ5sSxf2R+UaVdq+h7EEZ7drES8
         ziKCjfDdsdusdn8H6htb9h+H8Izk+zJJVdKVK7eoaoTHOos69WETMLvKakisLC+08Oqs
         itfJ69go9fDs4E4rrIQ/L12QMX7V4FzSVdF68EmRpKlFpi7Ggb3bq/y1Y0ZNn9yFcwwP
         LWtw==
X-Forwarded-Encrypted: i=1; AJvYcCVSctq+vK99PFxw0FvCcbRjKKBkIfEynEiRxKvk4hKALFpmpuJx2WjKsUeS0dKJJwqWy5PcNGW8qlrg2F/kwF8BWd9+okl8
X-Gm-Message-State: AOJu0YwZ52nrIo/66D/p9lSyfd/VTnzfjN2FLk5z7PUC9GTAKCXgNQ+f
	VgkdSatleT18uxJouGg7XRVqHP0ftTAtSSNbos5Q53fTNJ30r3mnGQFf+X1arBZwjjDbVIm+MMg
	rbagUe5nlgW6+4JETgHCI5hWMqwNef8WZKRlX5kCFwY31xYWxSNCn2g==
X-Received: by 2002:a05:620a:394c:b0:79b:eb0f:7781 with SMTP id af79cd13be357-79beb0f7ec3mr1437498985a.53.1719508046038;
        Thu, 27 Jun 2024 10:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg/oiENJqDup3/M9UZYUuyNol+/22Ovf586SY/3tWxk/8vPIZ1xZuirsW0Zy9NbkOXr7WPng==
X-Received: by 2002:a05:620a:394c:b0:79b:eb0f:7781 with SMTP id af79cd13be357-79beb0f7ec3mr1437493585a.53.1719508045405;
        Thu, 27 Jun 2024 10:07:25 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8117e0sm72061285a.52.2024.06.27.10.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:07:25 -0700 (PDT)
Date: Thu, 27 Jun 2024 12:07:22 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 2/2] net: stmmac: qcom-ethqos: add a
 DMA-reset quirk for sa8775p-ride
Message-ID: <td5jbseo7gtu6d4xai6q2zkfmxw4ijimyiromrf52he5hze3w3@fd3kayixf4lw>
References: <20240627113948.25358-1-brgl@bgdev.pl>
 <20240627113948.25358-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627113948.25358-3-brgl@bgdev.pl>

On Thu, Jun 27, 2024 at 01:39:47PM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> On sa8775p-ride the RX clocks from the AQR115C PHY are not available at
> the time of the DMA reset so we need to loop TX clocks to RX and then
> disable loopback after link-up. Use the existing callbacks to do it just
> for this board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Sorry, not being very helpful but trying to understand these changes
and the general cleanup of stmmac... so I'll point out that I'm still
confused by this based on Russell's last response:
https://lore.kernel.org/netdev/ZnQLED%2FC3Opeim5q@shell.armlinux.org.uk/

Quote:

    If you're using true Cisco SGMII, there are _no_ clocks transferred
    between the PHY and PCS/MAC. There are two balanced pairs of data
    lines and that is all - one for transmit and one for receive. So this
    explanation doesn't make sense to me.


<snip>

> +}
> +
>  static void ethqos_set_func_clk_en(struct qcom_ethqos *ethqos)
>  {
> +	qcom_ethqos_set_sgmii_loopback(ethqos, true);
>  	rgmii_updatel(ethqos, RGMII_CONFIG_FUNC_CLK_EN,
>  		      RGMII_CONFIG_FUNC_CLK_EN, RGMII_IO_MACRO_CONFIG);
>  }
<snip>
> @@ -682,6 +702,7 @@ static void ethqos_fix_mac_speed(void *priv, unsigned int speed, unsigned int mo
>  {
>  	struct qcom_ethqos *ethqos = priv;
>  
> +	qcom_ethqos_set_sgmii_loopback(ethqos, false);

I'm trying to map out when the loopback is currently enabled/disabled
due to Russell's prior concerns.

Quote:

    So you enable loopback at open time, and disable it when the link comes
    up. This breaks inband signalling (should stmmac ever use that) because
    enabling loopback prevents the PHY sending the SGMII result to the PCS
    to indicate that the link has come up... thus phylink won't call
    mac_link_up().

    So no, I really hate this proposed change.

    What I think would be better is if there were hooks at the appropriate
    places to handle the lack of clock over _just_ the period that it needs
    to be handled, rather than hacking the driver as this proposal does,
    abusing platform callbacks because there's nothing better.

looks like currently you'd:
    qcom_ethqos_probe()
	ethqos_clks_config(ethqos, true)
	    ethqos_set_func_clk_en(ethqos)
		qcom_ethqos_set_sgmii_loopback(ethqos, true) // loopback enabled
	ethqos_set_func_clk_en(ethqos)
	    qcom_ethqos_set_sgmii_loopback(ethqos, true) // no change in loopback
    devm_stmmac_pltfr_probe()
	stmmac_pltfr_probe()
	    stmmac_drv_probe()
		pm_runtime_put()
    // Eventually runtime PM will then do below
    stmmac_stmmac_runtime_suspend()
	stmmac_bus_clks_config(priv, false)
	    ethqos_clks_config(ethqos, false) // pointless branch but proving to myself
	                                      // that pm_runtime isn't getting in the way here
    __stmmac_open()
	stmmac_runtime_resume()
	    ethqos_clks_config(ethqos, true)
		ethqos_set_func_clk_en(ethqos)
		    qcom_ethqos_set_sgmii_loopback(ethqos, true) // no change in loopback
    stmmac_mac_link_up()
	ethqos_fix_mac_speed()
	    qcom_ethqos_set_sgmii_loopback(ethqos, false); // loopback disabled

Good chance I foobared tracing that... but!
That seems to still go against Russell's comment, i.e. its on at probe
and remains on until a link is up. This doesn't add anymore stmmac wide
platform callbacks at least, but I'm still concerned based on his prior
comments.

Its not clear to me though if the "2500basex" mentioned here supports
any in-band signalling from a Qualcomm SoC POV (not just the Aquantia
phy its attached to, but in general). So maybe in that case its not a
concern?

Although, this isn't tied to _just_ 2500basex here. If I boot the
sa8775p-ride (r2 version, with a marvell 88ea1512 phy attached via
sgmii, not indicating 2500basex) wouldn't all this get exercised? Right
now the devicetree doesn't indicate inband signalling, but I tried that
over here with Russell's clean up a week or two ago and things at least
came up ok (which made me think all the INTEGRATED_PCS stuff wasn't needed,
and I'm not totally positive my test proved inband signalling worked,
but I thought it did...):

    https://lore.kernel.org/netdev/zzevmhmwxrhs5yfv5srvcjxrue2d7wu7vjqmmoyd5mp6kgur54@jvmuv7bxxhqt/

based on Russell's comments, I feel if I was to use his series over
there, add 'managed = "in-band-status"' to the dts, and then apply this
series, the link would not come up anymore.

Total side note, but I'm wondering if the sa8775p-ride dts should
specify 'managed = "in-band-status"'.

Thanks,
Andrew


