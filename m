Return-Path: <netdev+bounces-166359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C790A35A7D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF501891BAF
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A8622D799;
	Fri, 14 Feb 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YMKbeLq1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71F20B20B
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525879; cv=none; b=rS72HmS/9LVosvvrI+xEwxz52cP01pfYeNjaOX/1WMIJrD0IoupQDFYGTtip8B+am5gLvz0X2ofNv5uhFtBjhJiiUmfFPrW6hbUJ4vTFahExHYietlIF8c+ZrS19WlaLL/8T4sPcFuNSDdyfHwjqBkRex2bpsST/c8Nkr1IxQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525879; c=relaxed/simple;
	bh=AQTS7z4EF6Kj4x9dUNFEDjbX5gbKif/DgWy1UeycRTc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FVHrQaZioIadL3K6W+NiyAz8dTHUVgIqUtTcll7KvQR0B+vlHGRwyYjBGZ5LA3x0BI+hlpS+/5djkzTTSWWTopnDazpBrKQYSUxbgNXjD9wr9aQSRunPKNTH/2QSDg/HeMTNnmu39boLPTj/Hj1WgBsKITKMa5iY/SQvq2EjJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YMKbeLq1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5nqrO012347;
	Fri, 14 Feb 2025 01:37:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=s+sj44ScQJ1xb0+gk2XwZxhVIlCMD0GRpZaxPw3WjFo=; b=YMK
	beLq1HRWBH3DSPOb3dq5yxSA5+QJxpSE4e717HDM3m5/P2PGNs89NmL/wQPrFfd2
	uwe5/aQ8nPx3sqljaLMyLPcziym4eJPpMrs4gZ0tQTJ3IhO6PUnwxLhPT5jIswOs
	sr8lMLLT2QayBDYIAQYzA3JbDpzasUXcOrodTpxQrO3lTDq+NPpYLiFpB2oUSIQM
	SLLhgPW2vjAvYEHZaJWgYoFOBk4DU+7PAS1CsaNosUSmKyTVPYqbGDKXOodhHyjc
	9MASAUzuxfb2xn2jF/xZ3sTG4ya7bFGQg0gjptacXEZrd0hJcmrf+VMhwvxPskpC
	V6ZlUVFIMvpE2rmrKAg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44t01f0b6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 01:37:41 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 14 Feb 2025 01:37:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 14 Feb 2025 01:37:40 -0800
Received: from 285c454e7213 (HY-LT91368.marvell.com [10.29.8.52])
	by maili.marvell.com (Postfix) with SMTP id DD8595B6927;
	Fri, 14 Feb 2025 01:37:36 -0800 (PST)
Date: Fri, 14 Feb 2025 09:37:35 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Alvin ipraga <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        <netdev@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] net: dsa: rtl8366rb: Fix compilation problem
Message-ID: <Z68O34EauNyyxak7@285c454e7213>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: enHcGK9O42FWM0d_a-3GWhZiA_18rI39
X-Proofpoint-GUID: enHcGK9O42FWM0d_a-3GWhZiA_18rI39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_04,2025-02-13_01,2024-11-22_01

On 2025-02-14 at 08:59:57, Linus Walleij (linus.walleij@linaro.org) wrote:
> When the kernel is compiled without LED framework support the
> rtl8366rb fails to build like this:
> 
> rtl8366rb.o: in function `rtl8366rb_setup_led':
> rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
>   undefined reference to `led_init_default_state_get'
> rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
>   undefined reference to `devm_led_classdev_register_ext'
> 
> As this is constantly coming up in different randconfig builds,
> bite the bullet and add some nasty ifdefs to rid this issue.
>
to get rid of this issue

Rest looks good to me.

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502070525.xMUImayb-lkp@intel.com/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/dsa/realtek/rtl8366rb.c | 53 +++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
> index 4c4a95d4380ce2a8a88a6d564cc16eab5a82dbc8..b914bb288f864ed211ff0b799d4f1938474199a7 100644
> --- a/drivers/net/dsa/realtek/rtl8366rb.c
> +++ b/drivers/net/dsa/realtek/rtl8366rb.c
> @@ -372,12 +372,14 @@ enum rtl8366_ledgroup_mode {
>  	__RTL8366RB_LEDGROUP_MODE_MAX
>  };
>  
> +#if IS_ENABLED(CONFIG_LEDS_CLASS)
>  struct rtl8366rb_led {
>  	u8 port_num;
>  	u8 led_group;
>  	struct realtek_priv *priv;
>  	struct led_classdev cdev;
>  };
> +#endif
>  
>  /**
>   * struct rtl8366rb - RTL8366RB-specific data
> @@ -388,7 +390,9 @@ struct rtl8366rb_led {
>  struct rtl8366rb {
>  	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
>  	bool pvid_enabled[RTL8366RB_NUM_PORTS];
> +#if IS_ENABLED(CONFIG_LEDS_CLASS)
>  	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
> +#endif
>  };
>  
>  static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
> @@ -831,6 +835,7 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
>  	return 0;
>  }
>  
> +/* This code is used also with LEDs disabled */
>  static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
>  				      u8 led_group,
>  				      enum rtl8366_ledgroup_mode mode)
> @@ -850,6 +855,7 @@ static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_LEDS_CLASS)
>  static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
>  {
>  	switch (led_group) {
> @@ -988,26 +994,6 @@ static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
>  	return 0;
>  }
>  
> -static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
> -{
> -	int ret = 0;
> -	int i;
> -
> -	regmap_update_bits(priv->map,
> -			   RTL8366RB_INTERRUPT_CONTROL_REG,
> -			   RTL8366RB_P4_RGMII_LED,
> -			   0);
> -
> -	for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
> -		ret = rb8366rb_set_ledgroup_mode(priv, i,
> -						 RTL8366RB_LEDGROUP_OFF);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return ret;
> -}
> -
>  static int rtl8366rb_setup_leds(struct realtek_priv *priv)
>  {
>  	struct dsa_switch *ds = &priv->ds;
> @@ -1039,6 +1025,33 @@ static int rtl8366rb_setup_leds(struct realtek_priv *priv)
>  	}
>  	return 0;
>  }
> +#else
> +static int rtl8366rb_setup_leds(struct realtek_priv *priv)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/* This code is used also with LEDs disabled */
> +static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
> +{
> +	int ret = 0;
> +	int i;
> +
> +	regmap_update_bits(priv->map,
> +			   RTL8366RB_INTERRUPT_CONTROL_REG,
> +			   RTL8366RB_P4_RGMII_LED,
> +			   0);
> +
> +	for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
> +		ret = rb8366rb_set_ledgroup_mode(priv, i,
> +						 RTL8366RB_LEDGROUP_OFF);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
>  
>  static int rtl8366rb_setup(struct dsa_switch *ds)
>  {
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250213-rtl8366rb-leds-compile-issue-dcd2c3c50fef
> 
> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>
> 

