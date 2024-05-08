Return-Path: <netdev+bounces-94406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174948BF5AE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1902866A8
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B70917BAE;
	Wed,  8 May 2024 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYjlY4pO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3B3A1C5;
	Wed,  8 May 2024 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147027; cv=none; b=f9vVAaAi+DxgXJjkL/nHlylnUeZh4dOsydUbotU08IuKtv8nGuYQ4TZRrkhFU3s71vN6Eg8Gw8IB3TrNojixhczXVt3MNffiqi0M/Eami6r++eIams9HVhO48Rui2J95i1yAhNQN0kYzZZk99BopfLZjxjz7JYozd2Pc+vh58Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147027; c=relaxed/simple;
	bh=QmJ8E0GR6HVfUQpKE6Djv4TCZt/N05vFu7w3L88Kops=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HpDeJRcmNQWh2zxP/0YpMZRL23exI4YhaWmQ8KcS5GzKkQtnzQYB8QLSgMngdgz+5TNOTCtKhmyiEcwUlzwo07gKPT5SF453upg5NywAflp6RuPOKrYqZbx7BHIYr//DGQaZCUMRg0mFs7RK53aQxURdoNgBc9HMkwdvfVYHjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYjlY4pO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59cdf7cd78so770512666b.0;
        Tue, 07 May 2024 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715147023; x=1715751823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fiWPwYiB92tF4WQY1BN+lNYYVhCz5it+Y7g3x7gUTT0=;
        b=TYjlY4pONJqa80oqoPdS63GBp66B120OM9srMfPV/WtZVBwrq8JsFTFZJhbNrXUbdr
         mQpELRqMDk6W93+B5ba8WtkUuP2P1SJiMvDhQQzMN6hXgV4FnGxttmUhmwbOmGaxLExE
         Y5keUNEN6urYG/uNpY5QX2pndwQTHSaz5lZaQ6s+XARnOxJYLLOtAJjXADs0c0NZkqJ2
         TYEXzfhAqZSRGln6yuaI5KxhAuhjuQrkuyRu5bRfkMVqUtKTKWzBAS9APURsSrJ03q0+
         3Q8CHDyDk2ksElSDXlCCraygi5nPDokqvuq+E6NLVlilwJsDU5XRw9zmv8ZXVLzQMcTQ
         OrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715147023; x=1715751823;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiWPwYiB92tF4WQY1BN+lNYYVhCz5it+Y7g3x7gUTT0=;
        b=nGpae4fhzV0/hEHXif/mKsq2arFhAol2kxy+P/ifRYoOENGr0gQxHiaTS+QTMnwgWN
         gEajZfeqWzUW1Kl3SVJzqJWZe20m0KpTR8cGZ9F86HuEgGnJds9s99o28MhsvN0SQy8v
         QH+arfnubX1Cmew77LgWk6U1WZPDO1LiF0bu5D6EF5of/M/xNUwTbxirl9qDxP2I7mh2
         XLcf0PlRGnTfkVqbjmer5jsTRmx3EOFc09rGk0nZZeAZjQjUv0iqAylC1zBCeXXM67K7
         o7pymgqklfSI3ZD1LJ4bYLbvv4WXsMD6JfXJrIL4MG3MvlQbmz1D0MAii2nQhygWSEvL
         72cQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6BTS+JmTcxTS9vBX/V+J08qQj71ZX/l44dstmQGUDGiXcBUlKSXx6PSeQ9kIN7rced/nnUE+AcEvc+XWjzsBGFFMzm8ldJfYr7F1E
X-Gm-Message-State: AOJu0YwJHvDZYV5sqFUlDWMzd45IZiPPcwIZrOWpYaCOEAPqt89rwIjv
	Z1UFX7Unj4d++lVdjP6wJ5/bG2r90sKaBVowhI2H2NuOgmGPZwA0
X-Google-Smtp-Source: AGHT+IF7cIGyFtpEAXYC1YmQO4hzObfVUwPA74DS0TjxiqRtmI/DEc970iSlvGionU5zELgJQe6lFA==
X-Received: by 2002:a50:bb41:0:b0:572:719f:b44f with SMTP id 4fb4d7f45d1cf-5731d9ce2a9mr1060568a12.9.1715147023013;
        Tue, 07 May 2024 22:43:43 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c5ec:1600:f15f:edb4:9cd5:3c38? (dynamic-2a01-0c23-c5ec-1600-f15f-edb4-9cd5-3c38.c23.pool.telefonica.de. [2a01:c23:c5ec:1600:f15f:edb4:9cd5:3c38])
        by smtp.googlemail.com with ESMTPSA id p9-20020a056402500900b005727b2ae25csm7176205eda.14.2024.05.07.22.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 22:43:42 -0700 (PDT)
Message-ID: <b1ef50ce-40e5-453a-a78a-55e373ad36db@gmail.com>
Date: Wed, 8 May 2024 07:43:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next 1/2] net: phy: phy_link_topology: Pass netdevice
 to phy_link_topo helpers
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
 <20240507102822.2023826-2-maxime.chevallier@bootlin.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240507102822.2023826-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.05.2024 12:28, Maxime Chevallier wrote:
> The phy link topology's main goal is to better track which PHYs are
> connected to a given netdevice. Make so that the helpers take the
> netdevice as a parameter directly.
> 
The commit message should explain what the issue is that you're fixing,
and how this patch fixes it.

> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Fixes: 6916e461e793 ("net: phy: Introduce ethernet link topology representation")
> Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> ---
>  drivers/net/phy/phy_device.c        | 25 ++++++++-----------------
>  drivers/net/phy/phy_link_topology.c | 13 ++++++++++---
>  include/linux/phy_link_topology.h   | 21 +++++++++++++--------
>  net/ethtool/netlink.c               |  2 +-
>  4 files changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 616bd7ba46cb..111434201545 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -277,14 +277,6 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
>  
>  static struct phy_driver genphy_driver;
>  
> -static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
> -{
> -	if (phydev->attached_dev)
> -		return phydev->attached_dev->link_topo;
> -
> -	return NULL;
> -}
> -
>  static LIST_HEAD(phy_fixup_list);
>  static DEFINE_MUTEX(phy_fixup_lock);
>  
> @@ -1389,10 +1381,10 @@ static DEVICE_ATTR_RO(phy_standalone);
>  int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
>  {
>  	struct phy_device *phydev = upstream;
> -	struct phy_link_topology *topo = phy_get_link_topology(phydev);
> +	struct net_device *dev = phydev->attached_dev;
>  
> -	if (topo)
> -		return phy_link_topo_add_phy(topo, phy, PHY_UPSTREAM_PHY, phydev);
> +	if (dev)
> +		return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);
>  
>  	return 0;
>  }
> @@ -1411,10 +1403,10 @@ EXPORT_SYMBOL(phy_sfp_connect_phy);
>  void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
>  {
>  	struct phy_device *phydev = upstream;
> -	struct phy_link_topology *topo = phy_get_link_topology(phydev);
> +	struct net_device *dev = phydev->attached_dev;
>  
> -	if (topo)
> -		phy_link_topo_del_phy(topo, phy);
> +	if (dev)
> +		phy_link_topo_del_phy(dev, phy);
>  }
>  EXPORT_SYMBOL(phy_sfp_disconnect_phy);
>  
> @@ -1561,8 +1553,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  		if (phydev->sfp_bus_attached)
>  			dev->sfp_bus = phydev->sfp_bus;
>  
> -		err = phy_link_topo_add_phy(dev->link_topo, phydev,
> -					    PHY_UPSTREAM_MAC, dev);
> +		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
>  		if (err)
>  			goto error;
>  	}
> @@ -1992,7 +1983,7 @@ void phy_detach(struct phy_device *phydev)
>  	if (dev) {
>  		phydev->attached_dev->phydev = NULL;
>  		phydev->attached_dev = NULL;
> -		phy_link_topo_del_phy(dev->link_topo, phydev);
> +		phy_link_topo_del_phy(dev, phydev);
>  	}
>  	phydev->phylink = NULL;
>  
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 985941c5c558..0e36bd7c15dc 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -35,10 +35,11 @@ void phy_link_topo_destroy(struct phy_link_topology *topo)
>  	kfree(topo);
>  }
>  
> -int phy_link_topo_add_phy(struct phy_link_topology *topo,
> +int phy_link_topo_add_phy(struct net_device *dev,
>  			  struct phy_device *phy,
>  			  enum phy_upstream upt, void *upstream)
>  {
> +	struct phy_link_topology *topo = dev->link_topo;
>  	struct phy_device_node *pdn;
>  	int ret;
>  
> @@ -90,10 +91,16 @@ int phy_link_topo_add_phy(struct phy_link_topology *topo,
>  }
>  EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);
>  
> -void phy_link_topo_del_phy(struct phy_link_topology *topo,
> +void phy_link_topo_del_phy(struct net_device *dev,
>  			   struct phy_device *phy)
>  {
> -	struct phy_device_node *pdn = xa_erase(&topo->phys, phy->phyindex);
> +	struct phy_link_topology *topo = dev->link_topo;
> +	struct phy_device_node *pdn;
> +
> +	if (!topo)
> +		return;
> +
> +	pdn = xa_erase(&topo->phys, phy->phyindex);
>  
>  	/* We delete the PHY from the topology, however we don't re-set the
>  	 * phy->phyindex field. If the PHY isn't gone, we can re-assign it the
> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> index 6b79feb607e7..166a01710aa2 100644
> --- a/include/linux/phy_link_topology.h
> +++ b/include/linux/phy_link_topology.h
> @@ -12,11 +12,11 @@
>  #define __PHY_LINK_TOPOLOGY_H
>  
>  #include <linux/ethtool.h>
> +#include <linux/netdevice.h>
>  #include <linux/phy_link_topology_core.h>
>  
>  struct xarray;
>  struct phy_device;
> -struct net_device;
>  struct sfp_bus;
>  
>  struct phy_device_node {
> @@ -37,11 +37,16 @@ struct phy_link_topology {
>  	u32 next_phy_index;
>  };
>  
> -static inline struct phy_device *
> -phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
> +static inline struct phy_device
> +*phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
>  {
> -	struct phy_device_node *pdn = xa_load(&topo->phys, phyindex);
> +	struct phy_link_topology *topo = dev->link_topo;
> +	struct phy_device_node *pdn;
>  
> +	if (!topo)
> +		return NULL;
> +
> +	pdn = xa_load(&topo->phys, phyindex);
>  	if (pdn)
>  		return pdn->phy;
>  
> @@ -49,21 +54,21 @@ phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
>  }
>  
>  #if IS_REACHABLE(CONFIG_PHYLIB)
> -int phy_link_topo_add_phy(struct phy_link_topology *topo,
> +int phy_link_topo_add_phy(struct net_device *dev,
>  			  struct phy_device *phy,
>  			  enum phy_upstream upt, void *upstream);
>  
> -void phy_link_topo_del_phy(struct phy_link_topology *lt, struct phy_device *phy);
> +void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
>  
>  #else
> -static inline int phy_link_topo_add_phy(struct phy_link_topology *topo,
> +static inline int phy_link_topo_add_phy(struct net_device *dev,
>  					struct phy_device *phy,
>  					enum phy_upstream upt, void *upstream)
>  {
>  	return 0;
>  }
>  
> -static inline void phy_link_topo_del_phy(struct phy_link_topology *topo,
> +static inline void phy_link_topo_del_phy(struct net_device *dev,
>  					 struct phy_device *phy)
>  {
>  }
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 563e94e0cbd8..f5b4adf324bc 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -170,7 +170,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
>  			struct nlattr *phy_id;
>  
>  			phy_id = tb[ETHTOOL_A_HEADER_PHY_INDEX];
> -			phydev = phy_link_topo_get_phy(dev->link_topo,
> +			phydev = phy_link_topo_get_phy(dev,
>  						       nla_get_u32(phy_id));
>  			if (!phydev) {
>  				NL_SET_BAD_ATTR(extack, phy_id);



