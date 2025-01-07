Return-Path: <netdev+bounces-155776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA431A03B72
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C0B165A54
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 09:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6701E0B77;
	Tue,  7 Jan 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMkLantr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA21E493C
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242958; cv=none; b=XSws2Gxjz/+B5j6RnkapTrxlJm7UuxQC45PkLL39o2iGleD42qJKO9TxUrfnjKvHGdAjOJgLrc3gdv2keujmtnrxNS31lntTvKfEajKa8fuAGzQ0m1249rYacMf8HnOC0Ekg27cB/984huKzRlFsI3lo6FduAwKQnp2ecNRr6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242958; c=relaxed/simple;
	bh=WCvo/h9zR7gSfTAxcV7Tudh/121l95hiUq7XcVF/a9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhR2bH6l5d1+k+co4Vi+wqe8/6/PhOMuFfzvyS+du7Z40h5WaK5rIXP3p1uPjj2I5dh9CIoav0EA4H8aGp8zFwNkK4C/snRBAMn8CGrZYtdM6h7UaCJOI+eoMcawiYMiyxvA6/TYgeJgNce/eu2wds53vFF663xsbwGcJtbMBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMkLantr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736242954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwivxpxVIYDF+4TpEnDi3wGOpGpoKj4iIBPxkHPp/HU=;
	b=WMkLantrECi+3aYZ/cMWYI2YrEppF6c7LrNg1r7uXXBkYLNS3n19gW7EWwRcKeVJ5uMmlX
	xi6y7BdpsZSAt3z45/CBDosOIWCr9c+ppheB3qT02JGBPOJ+Ke6PJc8fJenogmXUG4s4tI
	9JpFPKImyxCxM+wnFHLQtMkXwgjNfYM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-U9GK9O9UOGKiw22eowgJJQ-1; Tue, 07 Jan 2025 04:42:32 -0500
X-MC-Unique: U9GK9O9UOGKiw22eowgJJQ-1
X-Mimecast-MFC-AGG-ID: U9GK9O9UOGKiw22eowgJJQ
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e9fb0436so4771471985a.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 01:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736242952; x=1736847752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwivxpxVIYDF+4TpEnDi3wGOpGpoKj4iIBPxkHPp/HU=;
        b=fg50dz5YNraphJEBIH8gLXJd/USyysssM1Dl4rxi/E7DwKmxvCVn265zDpI/sAIDgT
         QMSRA9lpqcsPp/UH1ZUPTQjio7BmQSwkV67z1QTd6i09HlGdT6oUXZnPwyP9qX7wSiHq
         X25XF/CWahXvUKYRvAJWODVcULcYL28F43pGjUQ2ZhmkCJ2hCH6QlDr8U3AGKFOa8BAz
         JThFeTX5n6ddkpev8HeZ9+qTAtvILcN44/D18rj2cpQpa++rGV+UpoXTy7ZN8MX8iG9i
         HAljNiMXMenO9Z2tePyonOaAN2Yq8VrqrGK3niEvlGME6Gc07xScU+lPH+Zx6AlJDS6u
         rHew==
X-Forwarded-Encrypted: i=1; AJvYcCWKgjSUfE8619fB877wQppOOFl3sW8UgdHM4wURL9cgPu7h3IY+bdKxU2Bk5MXrnVjYCoNNDDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVjH3xoZkQiEXnGhkPUFnPchoLFgeSnQmvC1tsHAdIkVDaclz
	7S/SWNYnPs28qGR6Iz1QHNxYbHLmjHvNt9CRs0XPvVM4Z+EddN2ITQ+OkkVOIru5TtkqO/BdW2R
	WQg3iiiFIS5zBaj9igp+5h2qq9rA9DqXO2Bi1zvl1EiFeFLCDzwu+nA==
X-Gm-Gg: ASbGncvuM7vJnkl1KbGfC6CWspOdqK2/fzFvU6wqFVHjMOxj5W783fB2OxTMsvJkJGJ
	vbCDCzQJrmVem3wYpy/L5lefqNNkz6hfYHB6mXOfygr7+iZTerhFhw701ov+AaotfpupZeQuPYl
	kJwWGXbIi8PmnBOcZmnJ9H37vD2HK5A1M0g3Gc85vbPAsjU6Cb9O+Tp3lZqeh50+E4As8Gm1Obr
	g5HuFfpBItVDuYBMZ6I6ahSGCZe+dZ4Q7WW+eIMZrkUu+pIqwWkZamSz3uzwO8NT2vmmt7gGLED
	hYJy6A==
X-Received: by 2002:a05:620a:1b91:b0:7b6:c6f8:1d29 with SMTP id af79cd13be357-7b9ba7eaea9mr9969596985a.47.1736242952034;
        Tue, 07 Jan 2025 01:42:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoL4ryQ13tVszimld4P2XN/R8atx7/aOaPqZkrzZtIyUBTS11aRRGpCcA8MFJnXniJJtibCQ==
X-Received: by 2002:a05:620a:1b91:b0:7b6:c6f8:1d29 with SMTP id af79cd13be357-7b9ba7eaea9mr9969594385a.47.1736242951690;
        Tue, 07 Jan 2025 01:42:31 -0800 (PST)
Received: from [192.168.88.253] (146-241-73-5.dyn.eolo.it. [146.241.73.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30d87bsm1578478885a.53.2025.01.07.01.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 01:42:31 -0800 (PST)
Message-ID: <133b8da8-a2da-4bac-b0bb-7dcaebc219b9@redhat.com>
Date: Tue, 7 Jan 2025 10:42:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] net: ti: icssg-prueth: Add Multicast
 Filtering support for VLAN in MAC mode
To: MD Danish Anwar <danishanwar@ti.com>, Jeongjun Park
 <aha310510@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lukasz Majewski <lukma@denx.de>, Meghana Malladi <m-malladi@ti.com>,
 Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Roger Quadros <rogerq@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <20250103092033.1533374-1-danishanwar@ti.com>
 <20250103092033.1533374-3-danishanwar@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250103092033.1533374-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/25 10:20 AM, MD Danish Anwar wrote:
> Add multicast filtering support for VLAN interfaces in dual EMAC mode
> for ICSSG driver.
> 
> The driver uses vlan_for_each() API to get the list of available
> vlans. The driver then sync mc addr of vlan interface with a locally
> mainatined list emac->vlan_mcast_list[vid] using __hw_addr_sync_multiple()
> API.
> 
> The driver then calls the sync / unsync callbacks and based on whether
> the ndev is vlan or not, driver passes appropriate vid to FDB helper
> functions.
> 
> This commit also exports __hw_addr_sync_multiple() in order to use it
> from the ICSSG driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 67 ++++++++++++++++----
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  6 ++
>  include/linux/netdevice.h                    |  3 +
>  net/core/dev_addr_lists.c                    |  7 +-
>  4 files changed, 66 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 1663941e59e3..ed8b5a3184d6 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -472,30 +472,44 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>  
>  static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
>  {
> -	struct prueth_emac *emac = netdev_priv(ndev);
> -	int port_mask = BIT(emac->port_id);
> +	struct net_device *real_dev;
> +	struct prueth_emac *emac;
> +	int port_mask;
> +	u8 vlan_id;
>  
> -	port_mask |= icssg_fdb_lookup(emac, addr, 0);
> -	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
> +	emac = netdev_priv(real_dev);
> +
> +	port_mask = BIT(emac->port_id) | icssg_fdb_lookup(emac, addr, vlan_id);
> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, true);
> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, true);
>  
>  	return 0;
>  }
>  
>  static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
>  {
> -	struct prueth_emac *emac = netdev_priv(ndev);
> -	int port_mask = BIT(emac->port_id);
> +	struct net_device *real_dev;
> +	struct prueth_emac *emac;
>  	int other_port_mask;
> +	int port_mask;
> +	u8 vlan_id;
> +
> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
> +	emac = netdev_priv(real_dev);
>  
> -	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
> +	port_mask = BIT(emac->port_id);
> +	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, vlan_id);
>  
> -	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, false);
> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, false);
>  
>  	if (other_port_mask) {
> -		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
> -		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
> +		icssg_fdb_add_del(emac, addr, vlan_id, other_port_mask, true);
> +		icssg_vtbl_modify(emac, vlan_id, other_port_mask,
> +				  other_port_mask, true);
>  	}
>  
>  	return 0;
> @@ -531,6 +545,25 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
>  	return 0;
>  }
>  
> +static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
> +				   void *args)
> +{
> +	struct prueth_emac *emac = args;
> +
> +	if (!vdev || !vid)
> +		return 0;
> +
> +	netif_addr_lock_bh(vdev);
> +	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc,
> +				vdev->addr_len);
> +	netif_addr_unlock_bh(vdev);

At this point, isn't emac->vlan_mcast_list[vid] == vdev->mc?

> +
> +	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
> +			   icssg_prueth_add_mcast, icssg_prueth_del_mcast);

If so, can this function be reduced to just:

	__dev_mc_sync(vdev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);

?

> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index 166e404f7c03..90716bd736f3 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -242,9 +242,9 @@ static void __hw_addr_unsync_one(struct netdev_hw_addr_list *to_list,
>  	__hw_addr_del_entry(from_list, ha, false, false);
>  }
>  
> -static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
> -				   struct netdev_hw_addr_list *from_list,
> -				   int addr_len)
> +int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
> +			    struct netdev_hw_addr_list *from_list,
> +			    int addr_len)
>  {
>  	int err = 0;
>  	struct netdev_hw_addr *ha, *tmp;
> @@ -260,6 +260,7 @@ static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
>  	}
>  	return err;
>  }
> +EXPORT_SYMBOL(__hw_addr_sync_multiple);

I'm asking because this additional export looks suspect. How other
drivers cope with similar situation?

Thanks!

Paolo


