Return-Path: <netdev+bounces-94407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE818BF5B1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CD5282E44
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6BB1863C;
	Wed,  8 May 2024 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzaVhwjd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D923772;
	Wed,  8 May 2024 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147065; cv=none; b=DvLnlp+IFJwSiLeb3q0HREG5XkJIBx+6a7KbH23lQv83lwOl+dUYfEprnmAcODbs09+p8sRYEnMe/H8CaiAtSy9LKciQ3I2+VoHwaT7p9VdX+X+y9i1P4SOi8Ng5ml9WHp/Z1kzfjV+q39DP99qJb3+++15lpeHHNcF2dmrLFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147065; c=relaxed/simple;
	bh=g0QKnentJGiost6G7V+VKDbo7VqtLa6zkLDH8d+Xvl4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a9NHp4sTTFrJhDjU4eEEHVoNJ8w1QA0IG1e/oU9iUxaOXB9WQzt8kbvV09rg59nz1fDWXlHI/e3WhwvOYqYXXhOOD37vaG/sAn74KQFPM+5CRNH/fYNAO+Ci9653Jm2mYEY9qqz6p7CAGQxV9aBMRtsPIpdK2c67p8jUu9AUp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzaVhwjd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59ce1e8609so83518366b.0;
        Tue, 07 May 2024 22:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715147062; x=1715751862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tWp+2HJ0ZBVj/8UDTxv5UJsC8X6e/fyQU24aWtEM2tI=;
        b=EzaVhwjdM9SXp1uqkYrThf6JSmTZloGBA20qYw+tujNQZWA0nJBpCX1SFzjMwfgqLG
         /6uDqRKdUxA9fsMz04udnxhSLF4gyIiUFO4Dg6PAV3O/VnI1jZ5qHXTSowDejFMn0WSA
         /QXxn2yG7KHDA9ydmFy6oQJGa6kaUobKXcLG8so8PxhKJIkHjZ00GSIjRJBFAgathnTE
         DqvS5prBbBo+fo0rP3h3A3ttAKX5a8VYB7B3GcLxprRD5JAsjwWPx3QeBBx6pPbdldMz
         5bRXys8UhTw6FfzlvTw4qkO9aHQjsivMCsC8jozAsvDa1yBye6xwDD4wOb+NTpRBC0rO
         36VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715147062; x=1715751862;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWp+2HJ0ZBVj/8UDTxv5UJsC8X6e/fyQU24aWtEM2tI=;
        b=Yi4RzIF2rImULAUIC+Ca75GHQd3w3VDKvmnMITI8i8qaLqlwvPQsgL2lCuazei0+by
         i+CRmw95sxeViLWPx4YunZ7hS0wBT+WOmR+IYrNmaAy0pWBV9aS376Ooz90tCSXRXjX5
         k4PZaN7ucxj6qsJxXnuKUXlx8OizAonmAKQFhMZhTqfFQfT0pmLYVwaKIISQ11vp6Sl9
         ybgClmSlNqgHg4Rv1L43WXPMVoj6ugPDclTEVdfqbsvCWOCdDM7vFwXr7PeIS+964sW8
         5g08fP5wAiI3PGdZYPGefERH6OP8LJbQVreR+xY111GIF3z0++43SoFJb263ysV8payk
         euLg==
X-Forwarded-Encrypted: i=1; AJvYcCWNBhXktsFWMI9g4neMafxAayUoMA694GlwqmGCmDR9KDw+hgWSIvC+Oc97P3UtbU7eVfCbFk7izoh9OlxbZPChmIly3qNzi3qcvbRr
X-Gm-Message-State: AOJu0YzfLi8uOkUsGTiH6BxaQnNaBeMA0Za3GjmEuJZO7aAILcau3eeD
	wAO1VHqrfLPbpwb0bL1cgxXxF8R8etLjmdlNP9NG6lVcpP9Cfo1R
X-Google-Smtp-Source: AGHT+IHMH+dhBxg0aaWFyBp9dd8DZ05OWVV+ablPEEa9JqZx+ELP1XPZZCU+orednsvLOXZfo3Yxqw==
X-Received: by 2002:a17:906:4a8a:b0:a51:8672:66e4 with SMTP id a640c23a62f3a-a59e4cf82c9mr379969566b.22.1715147062065;
        Tue, 07 May 2024 22:44:22 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5ec:1600:f15f:edb4:9cd5:3c38? (dynamic-2a01-0c23-c5ec-1600-f15f-edb4-9cd5-3c38.c23.pool.telefonica.de. [2a01:c23:c5ec:1600:f15f:edb4:9cd5:3c38])
        by smtp.googlemail.com with ESMTPSA id j8-20020a50ed08000000b0056e718795f8sm7168133eds.36.2024.05.07.22.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 22:44:21 -0700 (PDT)
Message-ID: <6cedd632-d555-4c17-81cb-984af73f2c08@gmail.com>
Date: Wed, 8 May 2024 07:44:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 2/2] net: phy: phy_link_topology: Lazy-initialize
 the link topology
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>
References: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
 <20240507102822.2023826-3-maxime.chevallier@bootlin.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240507102822.2023826-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.05.2024 12:28, Maxime Chevallier wrote:
> Having the net_device's init path for the link_topology depend on
> IS_REACHABLE(PHYLIB)-protected helpers triggers errors when modules are being
> built with phylib as a module as-well, as they expect netdev->link_topo
> to be initialized.
> 
> Move the link_topo initialization at the first PHY insertion, which will
> both improve the memory usage, and make the behaviour more predicatble
> and robust.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Fixes: 6916e461e793 ("net: phy: Introduce ethernet link topology representation")
> Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> ---
>  drivers/net/phy/phy_link_topology.c    | 31 ++++++---------------
>  include/linux/netdevice.h              |  2 ++
>  include/linux/phy_link_topology.h      | 23 ++++++++--------
>  include/linux/phy_link_topology_core.h | 23 +++-------------
>  net/core/dev.c                         | 38 ++++++++++++++++++++++----
>  5 files changed, 58 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 0e36bd7c15dc..b1aba9313e73 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -12,29 +12,6 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/xarray.h>
>  
> -struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> -{
> -	struct phy_link_topology *topo;
> -
> -	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
> -	if (!topo)
> -		return ERR_PTR(-ENOMEM);
> -
> -	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> -	topo->next_phy_index = 1;
> -
> -	return topo;
> -}
> -
> -void phy_link_topo_destroy(struct phy_link_topology *topo)
> -{
> -	if (!topo)
> -		return;
> -
> -	xa_destroy(&topo->phys);
> -	kfree(topo);
> -}
> -
>  int phy_link_topo_add_phy(struct net_device *dev,
>  			  struct phy_device *phy,
>  			  enum phy_upstream upt, void *upstream)
> @@ -43,6 +20,14 @@ int phy_link_topo_add_phy(struct net_device *dev,
>  	struct phy_device_node *pdn;
>  	int ret;
>  
> +	if (!topo) {
> +		ret = netdev_alloc_phy_link_topology(dev);

This function is implemented in net core, but used only here.
So move the implementation here?

> +		if (ret)
> +			return ret;
> +
> +		topo = dev->link_topo;
> +	}
> +
>  	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
>  	if (!pdn)
>  		return -ENOMEM;
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index cf261fb89d73..25a0a77cfadc 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -4569,6 +4569,8 @@ void __hw_addr_unsync_dev(struct netdev_hw_addr_list *list,
>  					const unsigned char *));
>  void __hw_addr_init(struct netdev_hw_addr_list *list);
>  
> +int netdev_alloc_phy_link_topology(struct net_device *dev);
> +
>  /* Functions used for device addresses handling */
>  void dev_addr_mod(struct net_device *dev, unsigned int offset,
>  		  const void *addr, size_t len);
> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> index 166a01710aa2..3501f9a9e932 100644
> --- a/include/linux/phy_link_topology.h
> +++ b/include/linux/phy_link_topology.h
> @@ -32,10 +32,12 @@ struct phy_device_node {
>  	struct phy_device *phy;
>  };
>  
> -struct phy_link_topology {
> -	struct xarray phys;
> -	u32 next_phy_index;
> -};
> +#if IS_ENABLED(CONFIG_PHYLIB)
> +int phy_link_topo_add_phy(struct net_device *dev,
> +			  struct phy_device *phy,
> +			  enum phy_upstream upt, void *upstream);
> +
> +void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
>  
>  static inline struct phy_device
>  *phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
> @@ -53,13 +55,6 @@ static inline struct phy_device
>  	return NULL;
>  }
>  
> -#if IS_REACHABLE(CONFIG_PHYLIB)
> -int phy_link_topo_add_phy(struct net_device *dev,
> -			  struct phy_device *phy,
> -			  enum phy_upstream upt, void *upstream);
> -
> -void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
> -
>  #else
>  static inline int phy_link_topo_add_phy(struct net_device *dev,
>  					struct phy_device *phy,
> @@ -72,6 +67,12 @@ static inline void phy_link_topo_del_phy(struct net_device *dev,
>  					 struct phy_device *phy)
>  {
>  }
> +
> +static inline struct phy_device *
> +phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  #endif /* __PHY_LINK_TOPOLOGY_H */
> diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
> index 0a6479055745..f9c0520806fb 100644
> --- a/include/linux/phy_link_topology_core.h
> +++ b/include/linux/phy_link_topology_core.h
> @@ -2,24 +2,9 @@
>  #ifndef __PHY_LINK_TOPOLOGY_CORE_H
>  #define __PHY_LINK_TOPOLOGY_CORE_H
>  
> -struct phy_link_topology;
> -
> -#if IS_REACHABLE(CONFIG_PHYLIB)
> -
> -struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
> -void phy_link_topo_destroy(struct phy_link_topology *topo);
> -
> -#else
> -
> -static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> -{
> -	return NULL;
> -}
> -
> -static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
> -{
> -}
> -
> -#endif
> +struct phy_link_topology {
> +	struct xarray phys;
> +	u32 next_phy_index;
> +};
>  
This is all which is left in this header. As this header is public anyway,
better move this definition to phy_link_topology.h?

>  #endif /* __PHY_LINK_TOPOLOGY_CORE_H */
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d2ce91a334c1..1b4ffc273a04 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10256,6 +10256,35 @@ static void netdev_do_free_pcpu_stats(struct net_device *dev)
>  	}
>  }
>  
> +int netdev_alloc_phy_link_topology(struct net_device *dev)
> +{
> +	struct phy_link_topology *topo;
> +
> +	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
> +	if (!topo)
> +		return -ENOMEM;
> +
> +	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> +	topo->next_phy_index = 1;
> +
> +	dev->link_topo = topo;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(netdev_alloc_phy_link_topology);
> +
> +static void netdev_free_phy_link_topology(struct net_device *dev)
> +{
> +	struct phy_link_topology *topo = dev->link_topo;
> +
> +	if (!topo)
> +		return;
> +
> +	xa_destroy(&topo->phys);
> +	kfree(topo);
> +	dev->link_topo = NULL;

Give the compiler a chance to remove this function if
CONFIG_PHYLIB isn't enabled.

if (IS_ENABLED(CONFIG_PHYLIB) && topo) {
	xa_destroy(&topo->phys);
	kfree(topo);
	dev->link_topo = NULL;
}

> +}
> +
>  /**
>   * register_netdevice() - register a network device
>   * @dev: device to register
> @@ -10998,11 +11027,6 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  #ifdef CONFIG_NET_SCHED
>  	hash_init(dev->qdisc_hash);
>  #endif
> -	dev->link_topo = phy_link_topo_create(dev);
> -	if (IS_ERR(dev->link_topo)) {
> -		dev->link_topo = NULL;
> -		goto free_all;
> -	}
>  
>  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
>  	setup(dev);
> @@ -11092,7 +11116,9 @@ void free_netdev(struct net_device *dev)
>  	free_percpu(dev->xdp_bulkq);
>  	dev->xdp_bulkq = NULL;
>  
> -	phy_link_topo_destroy(dev->link_topo);
> +#if IS_ENABLED(CONFIG_PHYLIB)
> +	netdev_free_phy_link_topology(dev);
> +#endif
>  
Then the conditional compiling can be removed here.

>  	/*  Compatibility with error handling in drivers */
>  	if (dev->reg_state == NETREG_UNINITIALIZED ||





