Return-Path: <netdev+bounces-155994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC3A04932
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E313A4A8A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489C1E9B09;
	Tue,  7 Jan 2025 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATQO8z9Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCB86330
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274484; cv=none; b=VA5/oYmWZNIZreiFkuzR1UFI+/HmlMA3n8KukWZnqOMhxbwtM0YrTbuyz3utzPZyuz4CewcP79GNyAPzTFKH/EW4CpLoBwSSvd/XJRfCX77od6B6dHGt6Z3vd5lGR6zfkVByOvssg2Mn17TSw+DFtaD3XVrBVZF8tI5WS+Sns00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274484; c=relaxed/simple;
	bh=xf3qBJ9dM+KyjkImmUMFvg+Yq3g+JgqNHQSj/Nh8+Pg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MoXuszwHhzz7JtV2Toxa7DwM1NQds52GY9AwvrFj4eFwLhBh678Hc4xVmvz7qAxBsDBvqhzSRYksGAAzZS1rW88JgWxql001J47g5+XS4BNieddg4LHwq4KLNPhfVMCIwexlqSnX9kpEZyhHo5mqPK3myb5iuIHQn4JijOB0/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATQO8z9Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736274479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoFNOzzjOpsum/rm1+qrKK5OefFe08iV+YSKMqnMeos=;
	b=ATQO8z9QfrgQM48PS+DC6b+VmeshB5ZUbVCLain+tpU+xMJ9np8vPmZLSDXt6DtnwGJLW+
	YnrwQC5dj67Rl2EPAYEoYer/rJiF4Jzzjdv9b8lUd0ydF86ePSO2InYt8ZguSM7OxK3JFs
	AollriyGGtrKix5ErWWPew1SZBygOxM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-jQhKFT_jM2m_wJJtbyFixQ-1; Tue, 07 Jan 2025 13:27:58 -0500
X-MC-Unique: jQhKFT_jM2m_wJJtbyFixQ-1
X-Mimecast-MFC-AGG-ID: jQhKFT_jM2m_wJJtbyFixQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43628594d34so49250975e9.2
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 10:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736274477; x=1736879277;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoFNOzzjOpsum/rm1+qrKK5OefFe08iV+YSKMqnMeos=;
        b=IJPh0arO9MX1JCpdGlAif+RSV1soZIXWn82M5giR93j2FM+kryD42u+tMLQI7wxvvs
         PEzk8VVs8rq3feQ7GD78Y6FZxVxL54+DwT3+6VUD11DYmHMHY/dB6tAg5uHQgmJ4CJ73
         A5gT7Jy3JlG9nrGQvjxErx+9FnkriLAluk/VbYkJRFXU/zPyl0gmuIDP3YYJyI/vhVM/
         79UJ95gpTAvyeF4FGocrjzysGeHKbvjF6k9lLjONW5pSuY+tv0UkbPnyU5TiIOocRCMc
         rVTvOR2c4YKLgGeMyeeEN/ikasJ0ebdITytezE6caArVd7JN6PGWBTUc3yT1HXO05hsP
         0wHA==
X-Forwarded-Encrypted: i=1; AJvYcCWHvLgMrHSobcR321rd5cGUKm9sAQ3j8um/ewcxgttsaQdy9OpA7fM19qwYGbLjdzuokG3ST3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72AXPkW995XnT71cw9eoG5ZaBZ6pCS0AUwu2G/3s38SUeM52k
	f6P/qCELNFEVRZpJsWMQmZMvqa9MaLNxM9bGVDBeiuHxkjf27Rx1pgH/KHP8Efs1I2SE8wc7aKW
	/536vTxILs/EoWDvilSTZU8eBrUPtbl9ufTK2Se68cMPZGZVuWME8vQ==
X-Gm-Gg: ASbGnctJVA9Gapuos8lHTimFs4xUboyckMEboSEkR0dUULnJB/ZgLHgCl5MrU94OXfn
	ZfEl8VAMJfMzPG959UydHjK0oI1/JaaX9G8AKhE6eTzgCDiiaCAtoZbam7Jd12JdWj5vQpgRNX1
	dexqOG3jCQV+kWyY38eiPIAShud5xXqh2Eb6DhZvb3mNbMvgLeezUGs4V7hHFOpsuBgEcWzDMyA
	mVqquy3fF1qAHr2bDwcwbgmla2uh4gYDjeulwFzvqtlNGL/QpInv3VetCwMgPNWZ9wGhQGqJCuT
	bIZgbKtt
X-Received: by 2002:a05:600c:1c0b:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-43668646750mr570728995e9.18.1736274476962;
        Tue, 07 Jan 2025 10:27:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/F4l7VI4VDRjy6QmIK4U6pdZNWV45Eu54IRB23uZDmpwLQvUEwYU50YAp9uyooOD3ts2jEQ==
X-Received: by 2002:a05:600c:1c0b:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-43668646750mr570728835e9.18.1736274476533;
        Tue, 07 Jan 2025 10:27:56 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1a1sm50411886f8f.69.2025.01.07.10.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 10:27:55 -0800 (PST)
Message-ID: <45fac9f0-b31a-495d-bd1b-ccf0fbe19653@redhat.com>
Date: Tue, 7 Jan 2025 19:27:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
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
 <133b8da8-a2da-4bac-b0bb-7dcaebc219b9@redhat.com>
 <31a45fb4-acb6-4eb6-9ffb-ff1be798a064@ti.com>
Content-Language: en-US
In-Reply-To: <31a45fb4-acb6-4eb6-9ffb-ff1be798a064@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/7/25 11:47 AM, MD Danish Anwar wrote:
> On 07/01/25 3:12 pm, Paolo Abeni wrote:
>> On 1/3/25 10:20 AM, MD Danish Anwar wrote:
>>> Add multicast filtering support for VLAN interfaces in dual EMAC mode
>>> for ICSSG driver.
>>>
>>> The driver uses vlan_for_each() API to get the list of available
>>> vlans. The driver then sync mc addr of vlan interface with a locally
>>> mainatined list emac->vlan_mcast_list[vid] using __hw_addr_sync_multiple()
>>> API.
>>>
>>> The driver then calls the sync / unsync callbacks and based on whether
>>> the ndev is vlan or not, driver passes appropriate vid to FDB helper
>>> functions.
>>>
>>> This commit also exports __hw_addr_sync_multiple() in order to use it
>>> from the ICSSG driver.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 67 ++++++++++++++++----
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  6 ++
>>>  include/linux/netdevice.h                    |  3 +
>>>  net/core/dev_addr_lists.c                    |  7 +-
>>>  4 files changed, 66 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> index 1663941e59e3..ed8b5a3184d6 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> @@ -472,30 +472,44 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>>>  
>>>  static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
>>>  {
>>> -	struct prueth_emac *emac = netdev_priv(ndev);
>>> -	int port_mask = BIT(emac->port_id);
>>> +	struct net_device *real_dev;
>>> +	struct prueth_emac *emac;
>>> +	int port_mask;
>>> +	u8 vlan_id;
>>>  
>>> -	port_mask |= icssg_fdb_lookup(emac, addr, 0);
>>> -	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
>>> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
>>> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
>>> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
>>> +	emac = netdev_priv(real_dev);
>>> +
>>> +	port_mask = BIT(emac->port_id) | icssg_fdb_lookup(emac, addr, vlan_id);
>>> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, true);
>>> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, true);
>>>  
>>>  	return 0;
>>>  }
>>>  
>>>  static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
>>>  {
>>> -	struct prueth_emac *emac = netdev_priv(ndev);
>>> -	int port_mask = BIT(emac->port_id);
>>> +	struct net_device *real_dev;
>>> +	struct prueth_emac *emac;
>>>  	int other_port_mask;
>>> +	int port_mask;
>>> +	u8 vlan_id;
>>> +
>>> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
>>> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
>>> +	emac = netdev_priv(real_dev);
>>>  
>>> -	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
>>> +	port_mask = BIT(emac->port_id);
>>> +	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, vlan_id);
>>>  
>>> -	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
>>> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
>>> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, false);
>>> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, false);
>>>  
>>>  	if (other_port_mask) {
>>> -		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
>>> -		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
>>> +		icssg_fdb_add_del(emac, addr, vlan_id, other_port_mask, true);
>>> +		icssg_vtbl_modify(emac, vlan_id, other_port_mask,
>>> +				  other_port_mask, true);
>>>  	}
>>>  
>>>  	return 0;
>>> @@ -531,6 +545,25 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
>>>  	return 0;
>>>  }
>>>  
>>> +static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
>>> +				   void *args)
>>> +{
>>> +	struct prueth_emac *emac = args;
>>> +
>>> +	if (!vdev || !vid)
>>> +		return 0;
>>> +
>>> +	netif_addr_lock_bh(vdev);
>>> +	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc,
>>> +				vdev->addr_len);
>>> +	netif_addr_unlock_bh(vdev);
>>
>> At this point, isn't emac->vlan_mcast_list[vid] == vdev->mc?
>>
>>> +
>>> +	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
>>> +			   icssg_prueth_add_mcast, icssg_prueth_del_mcast);
>>
>> If so, can this function be reduced to just:
>>
>> 	__dev_mc_sync(vdev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);
>>
>> ?
>>
> 
> I don't know but for some reason __dev_mc_sync() doesn't work here. My
> initial approach was to use __dev_mc_sync(vdev, sync, unsync) however it
> didn't work.
> 
> When I use __dev_mc_sync() and print the vlan_id in function
> icssg_prueth_add_mcast(). It always prints vlan_id as 0 implying
> __dev_mc_sync from here never gets called. Whereas when using
> __hw_addr_sync_dev() I see the appropriate vlan_id in
> icssg_prueth_add_mcast()

It look like the above needs more investigation, right? is
vlan_mcast_list[vid] different from vdev->mc? why? At very least you
need to provide a clear explaination of the above.

> Anyways, Even if I use __dev_mc_sync(), we will still need the export. I
> am exporting __hw_addr_sync_multiple() not __hw_addr_sync_dev(). The API
> being used by me `__hw_addr_sync_dev()` is already exported.

I fear there is a misunderstanding. I'm suggesting dropping
__hw_addr_sync_multiple() usage entirely. If that is not possible, a
clear and complete explaination of the reason/root cause must be provided.

Thanks,

Paolo


