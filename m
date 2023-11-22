Return-Path: <netdev+bounces-50029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D37F44F6
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 12:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0397CB20FE4
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1855773;
	Wed, 22 Nov 2023 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWeQ6Y0l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C3197
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:35:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5491eb3fb63so1293155a12.3
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700652940; x=1701257740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1W86YF+32RvS2d1KL4UiuvsWqCTBd28clEPSBX/GPw=;
        b=kWeQ6Y0lijTgBfBo4f4rZ0XbXoWABq8MjjF2zqS92fnr29tzDrEapaOv66CkqxQsGK
         qZWfymz1P9ZJJ/sx0wFI0jQWXnyeyJ2ks7CIcR8S0heeB8ox6MB5q01h7TkDFkFJl1yx
         kg1Cb5BBtrCzykYvZyjYozScun1PLOV+4Kd72Oh2uGuFlB0RTDg8gy+9ok63pNrXcV+U
         S4xQIjcTQktStBtFku4WZwKFcRg8Xsauld1ND1NHypmrvGzDLFPZWC18mCQ92NzPGM4z
         C8YYMCCf8SZafhuz46XUiuyo+2oTytMYi34y8MpT5u63gQWZJdnobe4KC8wIDrxZ1FOy
         ZAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700652940; x=1701257740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1W86YF+32RvS2d1KL4UiuvsWqCTBd28clEPSBX/GPw=;
        b=MGGezmOLiwNb7hWsArTillW+3M6/tcAahXrvAST5flM8vjVcA4dJXPm1tYJwzpLIG9
         UrBoJCXvW3wWxwt/hDqBd9O0I8CDemND0oIigwNqTrhWHB0FzC/qEEHm3cRDNZn7s4rm
         MFGCwt9u/dLCn9q5mDZELzi6o8OWrLtmlqlwXblMgtTgB2djl4E1exJCOkcGGF0WJmSa
         T92SHoI8vHWSFpOz33zVQXMn6RfnhzPD+XZNhcq6mSt7ZbaEkyQ+5GhiR8J8xCe9Bujm
         FUdF5G7bAWf0MP+m6ExMp854Tsr8IIskwgvZ9+n3J1fXw4iJPsdC372i9ATSZ99j3A6+
         bByg==
X-Gm-Message-State: AOJu0YxtPuyVvyNTNMtrKcjOmvk0LU52lGmLzCFd0sfqXyPOMKO7NgHB
	aVjLVbFgXu0ON9UKgZJS6Vg=
X-Google-Smtp-Source: AGHT+IG8ecHOPAQACbwIAztSLg9TNIa1Au/HrqLxpyFPBGoxcX2LGqrhAFn8zvo3ayGVk11vdEM41Q==
X-Received: by 2002:aa7:cd0b:0:b0:543:7f7d:4a3f with SMTP id b11-20020aa7cd0b000000b005437f7d4a3fmr74865edw.30.1700652940288;
        Wed, 22 Nov 2023 03:35:40 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id r22-20020a50aad6000000b005407ac82f4csm6186861edc.97.2023.11.22.03.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:35:39 -0800 (PST)
Date: Wed, 22 Nov 2023 13:35:37 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Per Noergaard Christensen <per.christensen@prevas.dk>
Subject: Re: [PATCH net-next] net: dsa: microchip: add MRP software ring
 support
Message-ID: <20231122113537.o2fennnt2l2sri56@skbuf>
References: <20231122112006.255811-1-rasmus.villemoes@prevas.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122112006.255811-1-rasmus.villemoes@prevas.dk>

On Wed, Nov 22, 2023 at 12:20:06PM +0100, Rasmus Villemoes wrote:
> From: Per Noergaard Christensen <per.christensen@prevas.dk>
> 
> Add dummy functions that tells the MRP bridge instance to use
> implemented software routines instead of hardware-offloading.
> 
> Signed-off-by: Per Noergaard Christensen <per.christensen@prevas.dk>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 55 ++++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_common.h |  1 +
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 3fed406fb46a..b0935997dc05 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3566,6 +3566,57 @@ static int ksz_set_wol(struct dsa_switch *ds, int port,
>  	return -EOPNOTSUPP;
>  }
>  
> +static int ksz_port_mrp_add(struct dsa_switch *ds, int port,
> +			    const struct switchdev_obj_mrp *mrp)
> +{
> +	struct dsa_port *dp = dsa_to_port(ds, port);
> +	struct ksz_device *dev = ds->priv;
> +
> +	/* port different from requested mrp ports */
> +	if (mrp->p_port != dp->user && mrp->s_port != dp->user)
> +		return -EOPNOTSUPP;
> +
> +	/* save ring id */
> +	dev->ports[port].mrp_ring_id = mrp->ring_id;
> +	return 0;
> +}
> +
> +static int ksz_port_mrp_del(struct dsa_switch *ds, int port,
> +			    const struct switchdev_obj_mrp *mrp)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	/* check if port not part of ring id */
> +	if (mrp->ring_id != dev->ports[port].mrp_ring_id)
> +		return -EOPNOTSUPP;
> +
> +	/* clear ring id */
> +	dev->ports[port].mrp_ring_id = 0;
> +	return 0;
> +}
> +
> +static int ksz_port_mrp_add_ring_role(struct dsa_switch *ds, int port,
> +				      const struct switchdev_obj_ring_role_mrp *mrp)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	if (mrp->sw_backup && dev->ports[port].mrp_ring_id == mrp->ring_id)
> +		return 0;
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ksz_port_mrp_del_ring_role(struct dsa_switch *ds, int port,
> +				      const struct switchdev_obj_ring_role_mrp *mrp)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	if (mrp->sw_backup && dev->ports[port].mrp_ring_id == mrp->ring_id)
> +		return 0;
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
>  				    const unsigned char *addr)
>  {
> @@ -3799,6 +3850,10 @@ static const struct dsa_switch_ops ksz_switch_ops = {
>  	.port_fdb_del		= ksz_port_fdb_del,
>  	.port_mdb_add           = ksz_port_mdb_add,
>  	.port_mdb_del           = ksz_port_mdb_del,
> +	.port_mrp_add		= ksz_port_mrp_add,
> +	.port_mrp_del		= ksz_port_mrp_del,
> +	.port_mrp_add_ring_role	= ksz_port_mrp_add_ring_role,
> +	.port_mrp_del_ring_role	= ksz_port_mrp_del_ring_role,
>  	.port_mirror_add	= ksz_port_mirror_add,
>  	.port_mirror_del	= ksz_port_mirror_del,
>  	.get_stats64		= ksz_get_stats64,
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index b7e8a403a132..24015f0a9c98 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -110,6 +110,7 @@ struct ksz_port {
>  	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
>  	bool learning;
>  	int stp_state;
> +	u32 mrp_ring_id;
>  	struct phy_device phydev;
>  
>  	u32 fiber:1;			/* port is fiber */
> -- 
> 2.40.1.1.g1c60b9335d
> 

Could you please explain a bit the mechanics of this dummy implementation?
Don't you need to set up any packet traps for MRP PDUs, to avoid
forwarding them? What ring roles will work with the dummy implementation?

+Horatiu for an expert opinion.

