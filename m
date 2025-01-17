Return-Path: <netdev+bounces-159251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A27A14EE6
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C913A793F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55341FF1AE;
	Fri, 17 Jan 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Sg3xfcVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0B1FF1A9
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115076; cv=none; b=Ov5uNG5tuZZGxyS9ZKE6kytsnwIR2y2TjNs+G2VSDOvErrkLWR42OFKMgYaNjiejZyFYUbKW1N7jlep2q2afgC8qFKfPfVbV1vtiJFsPRCwkeoUpb2Oqc3+Md/J+Q1xTTLZCYY5m3QcuB0Y7KuK7e+k+ZpAFpX3Q4fSbW+y3IgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115076; c=relaxed/simple;
	bh=YymlBsnFVXS2JR5yhS2bdd3WwTyuqlIWPB7GSZhWdwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8V4FHSqaMk3nQicmC/36EoHTz//LXX+YE4PoiVkt2uTbUnpnMX9riSPyI8QomBSt/CHgzfH8wcKQFTCNqdXrJ/fwNBQpiK/dg185vx7iZ19y4zHJv/1uLEzoz02b5XXB69Io+AcMUo2/oSEJMYlua13SRWKSsaIxfcz3lTQgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Sg3xfcVS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-386329da1d9so1064542f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 03:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737115073; x=1737719873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwL1kRDzXLX9ihTqfaCo5eJQXJDVGnB1/f+6pPJBK6c=;
        b=Sg3xfcVSS+usJpfClNbS8hZ9CX4gQiCmOwKfH3/axeEdjC7WAyUflSSlERiMbk+Cqu
         yvHBCKoiQEFC9OpSal6472dXWHQlC0tKDEmD+g5tVeuudqN29C2crd5UjAOjWLX+ss2S
         zRrwCzh3Ay6SkkstZnFkkRvgwHYwo90pK6KtXW4BlgootMwSLHZyjQOIH19CIbviMslA
         Lp+uGmwMDdQRZLSnpYov0BAF6VJD2as7RXYL649e4Dvy+8rtGVnqlclSjS1BTs/u3ULq
         AEHYbte1XynmiT0A7mBqGC0SIUJ8wH0yfGSCeMLU7JC8n472Hqd1dLZPC8AbA9XpPgaa
         FafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737115073; x=1737719873;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwL1kRDzXLX9ihTqfaCo5eJQXJDVGnB1/f+6pPJBK6c=;
        b=fHqvJU1tN8JGQg7sVh9ZOD3mKFTFG//WbKOhEoMyaQGYa57xQioevBHxY7N/gEIGnk
         14zWZZouPpYtCkxgECoTOQdG17hvTsm5CdQwjDGCzxR0AVbB96Nkp8CcOGd/EA3Htf3s
         LuYWEEOVC0Zf2FzaqU84dU5YzvGMqQbcbt8LJANPH1Ehf9b3DMOMfEXzhCngYAU8bcrz
         c1Sb3srbQYHdbQ+N2BOYiJLkLwPcYOFntSxQTzLwYkwIKPoSFx1JD+LoTbB43vd1UT2a
         8nlTNIRhKD7U4VjLw2sA2FkI5bWsNlnhaLjUefsXqJsoOlttQAqP1cE8J+zSO2thZYtl
         fQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB+yU0ubPD8n26YrVMJWZeoaWO/PukNgGutasVwnL1ILEkbiq+PnYSzii9euSKm6atjocG6iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60RjkNooV6ixa4UNIi3UM293qcn1BEdt6drGYc52Hp2AwAFwe
	YupODdz6olcNpewuG7qLBXOj6gkqEjn8KsGKfLzASv4BrfdNXuUfo0xgSzy80Sg=
X-Gm-Gg: ASbGncv4/rYhZRQR5LWp8jcfED5hmgolu97knSOg3aGo/5mqoA6OUd6bVCd0YjVvAcV
	Y1uDThtkvWnv6RES1JzbsrK4VMsPXLTGeO4kBz36GjIJVr1/ihk9RZYmjRKpjck1NFSxMLju4+3
	OoTIfcDXGCTMYhib9zYaGgjT9ZtRWPjq2tvY2aRi8knCkkY1JHmrGEbCxxNTRG4argbn4HLFOZt
	BZrbp6JMpO3BgD+XqcQ4HB6uQzgZq1td6vOrFkBM/mtd1oJu/aUquNouWEMnPMY9Q==
X-Google-Smtp-Source: AGHT+IHiuxeIRc4MgzZ8PBiJP2iALdJkJyZlTFcrABxOgUE2CpVlMsLdsJs0c2D3vNb+q6fwKeKaAg==
X-Received: by 2002:a05:6000:b04:b0:388:caf4:e909 with SMTP id ffacd0b85a97d-38bf566f3camr2084516f8f.25.1737115072539;
        Fri, 17 Jan 2025 03:57:52 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321503fsm2384372f8f.12.2025.01.17.03.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 03:57:51 -0800 (PST)
Message-ID: <4c6419d8-c06b-495c-b987-d66c2e1ff848@tuxon.dev>
Date: Fri, 17 Jan 2025 13:57:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 3/5] net: Add the possibility to support a
 selected hwtstamp in netdevice
To: Kory Maincent <kory.maincent@bootlin.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>,
 Shannon Nelson <shannon.nelson@amd.com>,
 Alexandra Winter <wintera@linux.ibm.com>
References: <20241212-feature_ptp_netnext-v21-0-2c282a941518@bootlin.com>
 <20241212-feature_ptp_netnext-v21-3-2c282a941518@bootlin.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20241212-feature_ptp_netnext-v21-3-2c282a941518@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Kory,

On 12.12.2024 19:06, Kory Maincent wrote:
> Introduce the description of a hwtstamp provider, mainly defined with a
> the hwtstamp source and the phydev pointer.
> 
> Add a hwtstamp provider description within the netdev structure to
> allow saving the hwtstamp we want to use. This prepares for future
> support of an ethtool netlink command to select the desired hwtstamp
> provider. By default, the old API that does not support hwtstamp
> selectability is used, meaning the hwtstamp provider pointer is unset.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

I'm getting this error when doing suspend/resume on the Renesas RZ/G3S
Smarc Module + RZ SMARC Carrier II board:

[   39.032969] =============================
[   39.032983] WARNING: suspicious RCU usage
[   39.033000] 6.13.0-rc7-next-20250116-arm64-renesas-00002-g35245dfdc62c
#7 Not tainted
[   39.033019] -----------------------------
[   39.033033] drivers/net/phy/phy_device.c:2004 suspicious
rcu_dereference_protected() usage!
[   39.033054]
[   39.033054] other info that might help us debug this:
[   39.033054]
[   39.033068]
[   39.033068] rcu_scheduler_active = 2, debug_locks = 1
[   39.033084] 5 locks held by python3/174:
[   39.033100]  #0: ffff00000ba8f3f0 (sb_writers#4){.+.+}-{0:0}, at:
vfs_write+0x1b4/0x378
[   39.033217]  #1: ffff00000f828888 (&of->mutex#2){+.+.}-{4:4}, at:
kernfs_fop_write_iter+0xe8/0x1a8
[   39.033321]  #2: ffff00000ae3f4d8 (kn->active#47){.+.+}-{0:0}, at:
kernfs_fop_write_iter+0xf0/0x1a8
[   39.033418]  #3: ffff800081910958 (system_transition_mutex){+.+.}-{4:4},
at: pm_suspend+0x120/0x274
[   39.033508]  #4: ffff00000af8f8f8 (&dev->mutex){....}-{4:4}, at:
device_suspend+0xf4/0x4dc
[   39.033597]
[   39.033597] stack backtrace:
[   39.033613] CPU: 0 UID: 0 PID: 174 Comm: python3 Not tainted
6.13.0-rc7-next-20250116-arm64-renesas-00002-g35245dfdc62c #7
[   39.033623] Hardware name: Renesas SMARC EVK version 2 based on
r9a08g045s33 (DT)
[   39.033628] Call trace:
[   39.033633]  show_stack+0x14/0x1c (C)
[   39.033652]  dump_stack_lvl+0xb4/0xc4
[   39.033664]  dump_stack+0x14/0x1c
[   39.033671]  lockdep_rcu_suspicious+0x16c/0x22c
[   39.033682]  phy_detach+0x160/0x190
[   39.033694]  phy_disconnect+0x40/0x54
[   39.033703]  ravb_close+0x6c/0x1cc
[   39.033714]  ravb_suspend+0x48/0x120
[   39.033721]  dpm_run_callback+0x4c/0x14c
[   39.033731]  device_suspend+0x11c/0x4dc
[   39.033740]  dpm_suspend+0xdc/0x214
[   39.033748]  dpm_suspend_start+0x48/0x60
[   39.033758]  suspend_devices_and_enter+0x124/0x574
[   39.033769]  pm_suspend+0x1ac/0x274
[   39.033778]  state_store+0x88/0x124
[   39.033788]  kobj_attr_store+0x14/0x24
[   39.033798]  sysfs_kf_write+0x48/0x6c
[   39.033808]  kernfs_fop_write_iter+0x118/0x1a8
[   39.033817]  vfs_write+0x27c/0x378
[   39.033825]  ksys_write+0x64/0xf4
[   39.033833]  __arm64_sys_write+0x18/0x20
[   39.033841]  invoke_syscall+0x44/0x104
[   39.033852]  el0_svc_common.constprop.0+0xb4/0xd4
[   39.033862]  do_el0_svc+0x18/0x20
[   39.033870]  el0_svc+0x3c/0xf0
[   39.033880]  el0t_64_sync_handler+0xc0/0xc4
[   39.033888]  el0t_64_sync+0x154/0x158
[   39.041274] ravb 11c30000.ethernet eth0: Link is Down

drivers/net/phy/phy_device.c:2004 is pointing to this commit.

Haven't got the chance to investigate it, yet. It seems this commit is
triggering it. Do you know if something needs to be changed now in the way
the PHY is disconnected to avoid triggering this issue?

Thank you,
Claudiu

> ---
> 
> Change in v8:
> - New patch
> 
> Change in v10:
> - Set hwtstamp in netdevice as a pointer for future use of rcu lock.
> - Fix a nit in teh order of setting phydev pointer.
> - Add a missing kdoc description.
> 
> Change in v13:
> - Remove an include from netdevices.h.
> 
> Change in v16:
> - Import the part of the patch 12 which belong to the hwtstamp provider
>   selectability of net core.
> 
> Change in v18:
> - Fix a doc NIT.
> 
> Change in v20:
> - Rework the hwtstamp provider design. Use hwtstamp source alongside
>   with phydev pointer instead.
> ---
>  drivers/net/phy/phy_device.c    | 10 ++++++++
>  include/linux/net_tstamp.h      | 29 +++++++++++++++++++++++
>  include/linux/netdevice.h       |  4 ++++
>  include/uapi/linux/net_tstamp.h | 11 +++++++++
>  net/core/dev_ioctl.c            | 41 ++++++++++++++++++++++++++++++--
>  net/core/timestamping.c         | 52 +++++++++++++++++++++++++++++++++++++----
>  6 files changed, 140 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index b26bb33cd1d4..1a908af4175b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -32,6 +32,7 @@
>  #include <linux/phy_link_topology.h>
>  #include <linux/pse-pd/pse.h>
>  #include <linux/property.h>
> +#include <linux/ptp_clock_kernel.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/sfp.h>
>  #include <linux/skbuff.h>
> @@ -1998,6 +1999,15 @@ void phy_detach(struct phy_device *phydev)
>  
>  	phy_suspend(phydev);
>  	if (dev) {
> +		struct hwtstamp_provider *hwprov;
> +
> +		hwprov = rtnl_dereference(dev->hwprov);
> +		/* Disable timestamp if it is the one selected */
> +		if (hwprov && hwprov->phydev == phydev) {
> +			rcu_assign_pointer(dev->hwprov, NULL);
> +			kfree_rcu(hwprov, rcu_head);
> +		}
> +
>  		phydev->attached_dev->phydev = NULL;
>  		phydev->attached_dev = NULL;
>  		phy_link_topo_del_phy(dev, phydev);
> diff --git a/include/linux/net_tstamp.h b/include/linux/net_tstamp.h
> index 662074b08c94..ff0758e88ea1 100644
> --- a/include/linux/net_tstamp.h
> +++ b/include/linux/net_tstamp.h
> @@ -19,6 +19,33 @@ enum hwtstamp_source {
>  	HWTSTAMP_SOURCE_PHYLIB,
>  };
>  
> +/**
> + * struct hwtstamp_provider_desc - hwtstamp provider description
> + *
> + * @index: index of the hwtstamp provider.
> + * @qualifier: hwtstamp provider qualifier.
> + */
> +struct hwtstamp_provider_desc {
> +	int index;
> +	enum hwtstamp_provider_qualifier qualifier;
> +};
> +
> +/**
> + * struct hwtstamp_provider - hwtstamp provider object
> + *
> + * @rcu_head: RCU callback used to free the struct.
> + * @source: source of the hwtstamp provider.
> + * @phydev: pointer of the phydev source in case a PTP coming from phylib
> + * @desc: hwtstamp provider description.
> + */
> +
> +struct hwtstamp_provider {
> +	struct rcu_head rcu_head;
> +	enum hwtstamp_source source;
> +	struct phy_device *phydev;
> +	struct hwtstamp_provider_desc desc;
> +};
> +
>  /**
>   * struct kernel_hwtstamp_config - Kernel copy of struct hwtstamp_config
>   *
> @@ -31,6 +58,7 @@ enum hwtstamp_source {
>   *	copied the ioctl request back to user space
>   * @source: indication whether timestamps should come from the netdev or from
>   *	an attached phylib PHY
> + * @qualifier: qualifier of the hwtstamp provider
>   *
>   * Prefer using this structure for in-kernel processing of hardware
>   * timestamping configuration, over the inextensible struct hwtstamp_config
> @@ -43,6 +71,7 @@ struct kernel_hwtstamp_config {
>  	struct ifreq *ifr;
>  	bool copied_to_user;
>  	enum hwtstamp_source source;
> +	enum hwtstamp_provider_qualifier qualifier;
>  };
>  
>  static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index d917949bba03..2593019ad5b1 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -82,6 +82,7 @@ struct xdp_metadata_ops;
>  struct xdp_md;
>  struct ethtool_netdev_state;
>  struct phy_link_topology;
> +struct hwtstamp_provider;
>  
>  typedef u32 xdp_features_t;
>  
> @@ -2045,6 +2046,7 @@ enum netdev_reg_state {
>   *
>   *	@neighbours:	List heads pointing to this device's neighbours'
>   *			dev_list, one per address-family.
> + *	@hwprov: Tracks which PTP performs hardware packet time stamping.
>   *
>   *	FIXME: cleanup struct net_device such that network protocol info
>   *	moves out.
> @@ -2457,6 +2459,8 @@ struct net_device {
>  
>  	struct hlist_head neighbours[NEIGH_NR_TABLES];
>  
> +	struct hwtstamp_provider __rcu	*hwprov;
> +
>  	u8			priv[] ____cacheline_aligned
>  				       __counted_by(priv_len);
>  } ____cacheline_aligned;
> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
> index 858339d1c1c4..55b0ab51096c 100644
> --- a/include/uapi/linux/net_tstamp.h
> +++ b/include/uapi/linux/net_tstamp.h
> @@ -13,6 +13,17 @@
>  #include <linux/types.h>
>  #include <linux/socket.h>   /* for SO_TIMESTAMPING */
>  
> +/*
> + * Possible type of hwtstamp provider. Mainly "precise" the default one
> + * is for IEEE 1588 quality and "approx" is for NICs DMA point.
> + */
> +enum hwtstamp_provider_qualifier {
> +	HWTSTAMP_PROVIDER_QUALIFIER_PRECISE,
> +	HWTSTAMP_PROVIDER_QUALIFIER_APPROX,
> +
> +	HWTSTAMP_PROVIDER_QUALIFIER_CNT,
> +};
> +
>  /* SO_TIMESTAMPING flags */
>  enum {
>  	SOF_TIMESTAMPING_TX_HARDWARE = (1<<0),
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 1f09930fca26..087a57b7e4fa 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -6,6 +6,7 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/phylib_stubs.h>
> +#include <linux/ptp_clock_kernel.h>
>  #include <linux/wireless.h>
>  #include <linux/if_bridge.h>
>  #include <net/dsa_stubs.h>
> @@ -269,6 +270,21 @@ static int dev_eth_ioctl(struct net_device *dev,
>  int dev_get_hwtstamp_phylib(struct net_device *dev,
>  			    struct kernel_hwtstamp_config *cfg)
>  {
> +	struct hwtstamp_provider *hwprov;
> +
> +	hwprov = rtnl_dereference(dev->hwprov);
> +	if (hwprov) {
> +		cfg->qualifier = hwprov->desc.qualifier;
> +		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
> +		    hwprov->phydev)
> +			return phy_hwtstamp_get(hwprov->phydev, cfg);
> +
> +		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
> +			return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
> +
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (phy_is_default_hwtstamp(dev->phydev))
>  		return phy_hwtstamp_get(dev->phydev, cfg);
>  
> @@ -324,11 +340,32 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
>  			    struct netlink_ext_ack *extack)
>  {
>  	const struct net_device_ops *ops = dev->netdev_ops;
> -	bool phy_ts = phy_is_default_hwtstamp(dev->phydev);
>  	struct kernel_hwtstamp_config old_cfg = {};
> +	struct hwtstamp_provider *hwprov;
> +	struct phy_device *phydev;
>  	bool changed = false;
> +	bool phy_ts;
>  	int err;
>  
> +	hwprov = rtnl_dereference(dev->hwprov);
> +	if (hwprov) {
> +		if (hwprov->source == HWTSTAMP_SOURCE_PHYLIB &&
> +		    hwprov->phydev) {
> +			phy_ts = true;
> +			phydev = hwprov->phydev;
> +		} else if (hwprov->source == HWTSTAMP_SOURCE_NETDEV) {
> +			phy_ts = false;
> +		} else {
> +			return -EOPNOTSUPP;
> +		}
> +
> +		cfg->qualifier = hwprov->desc.qualifier;
> +	} else {
> +		phy_ts = phy_is_default_hwtstamp(dev->phydev);
> +		if (phy_ts)
> +			phydev = dev->phydev;
> +	}
> +
>  	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
>  
>  	if (phy_ts && dev->see_all_hwtstamp_requests) {
> @@ -350,7 +387,7 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
>  		changed = kernel_hwtstamp_config_changed(&old_cfg, cfg);
>  
>  	if (phy_ts) {
> -		err = phy_hwtstamp_set(dev->phydev, cfg, extack);
> +		err = phy_hwtstamp_set(phydev, cfg, extack);
>  		if (err) {
>  			if (changed)
>  				ops->ndo_hwtstamp_set(dev, &old_cfg, NULL);
> diff --git a/net/core/timestamping.c b/net/core/timestamping.c
> index 3717fb152ecc..a50a7ef49ae8 100644
> --- a/net/core/timestamping.c
> +++ b/net/core/timestamping.c
> @@ -9,6 +9,7 @@
>  #include <linux/ptp_classify.h>
>  #include <linux/skbuff.h>
>  #include <linux/export.h>
> +#include <linux/ptp_clock_kernel.h>
>  
>  static unsigned int classify(const struct sk_buff *skb)
>  {
> @@ -21,19 +22,39 @@ static unsigned int classify(const struct sk_buff *skb)
>  
>  void skb_clone_tx_timestamp(struct sk_buff *skb)
>  {
> +	struct hwtstamp_provider *hwprov;
>  	struct mii_timestamper *mii_ts;
> +	struct phy_device *phydev;
>  	struct sk_buff *clone;
>  	unsigned int type;
>  
> -	if (!skb->sk || !skb->dev ||
> -	    !phy_is_default_hwtstamp(skb->dev->phydev))
> +	if (!skb->sk || !skb->dev)
>  		return;
>  
> +	rcu_read_lock();
> +	hwprov = rcu_dereference(skb->dev->hwprov);
> +	if (hwprov) {
> +		if (hwprov->source != HWTSTAMP_SOURCE_PHYLIB ||
> +		    !hwprov->phydev) {
> +			rcu_read_unlock();
> +			return;
> +		}
> +
> +		phydev = hwprov->phydev;
> +	} else {
> +		phydev = skb->dev->phydev;
> +		if (!phy_is_default_hwtstamp(phydev)) {
> +			rcu_read_unlock();
> +			return;
> +		}
> +	}
> +	rcu_read_unlock();
> +
>  	type = classify(skb);
>  	if (type == PTP_CLASS_NONE)
>  		return;
>  
> -	mii_ts = skb->dev->phydev->mii_ts;
> +	mii_ts = phydev->mii_ts;
>  	if (likely(mii_ts->txtstamp)) {
>  		clone = skb_clone_sk(skb);
>  		if (!clone)
> @@ -45,12 +66,33 @@ EXPORT_SYMBOL_GPL(skb_clone_tx_timestamp);
>  
>  bool skb_defer_rx_timestamp(struct sk_buff *skb)
>  {
> +	struct hwtstamp_provider *hwprov;
>  	struct mii_timestamper *mii_ts;
> +	struct phy_device *phydev;
>  	unsigned int type;
>  
> -	if (!skb->dev || !phy_is_default_hwtstamp(skb->dev->phydev))
> +	if (!skb->dev)
>  		return false;
>  
> +	rcu_read_lock();
> +	hwprov = rcu_dereference(skb->dev->hwprov);
> +	if (hwprov) {
> +		if (hwprov->source != HWTSTAMP_SOURCE_PHYLIB ||
> +		    !hwprov->phydev) {
> +			rcu_read_unlock();
> +			return false;
> +		}
> +
> +		phydev = hwprov->phydev;
> +	} else {
> +		phydev = skb->dev->phydev;
> +		if (!phy_is_default_hwtstamp(phydev)) {
> +			rcu_read_unlock();
> +			return false;
> +		}
> +	}
> +	rcu_read_unlock();
> +
>  	if (skb_headroom(skb) < ETH_HLEN)
>  		return false;
>  
> @@ -63,7 +105,7 @@ bool skb_defer_rx_timestamp(struct sk_buff *skb)
>  	if (type == PTP_CLASS_NONE)
>  		return false;
>  
> -	mii_ts = skb->dev->phydev->mii_ts;
> +	mii_ts = phydev->mii_ts;
>  	if (likely(mii_ts->rxtstamp))
>  		return mii_ts->rxtstamp(mii_ts, skb, type);
>  
> 


