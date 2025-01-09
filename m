Return-Path: <netdev+bounces-156728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CDEA07A02
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E6F1884D76
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B2A21C19A;
	Thu,  9 Jan 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii7G/fsj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EF218EA7
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434824; cv=none; b=MJyxpq264PsUtWu0FS6fBR50CBkhf91ICr0556hPRF8MtQl3tiOmqlJa3q2etV5XqNruHiqvgJMlWtzis2UXvBsvh443S3ks1yiPv1gmPvz7SIzod3uN1tZuvRPoHu8sLLZpercla7hUwDdjySBWgoD2lkRMN+i4Tm7h43V8cjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434824; c=relaxed/simple;
	bh=hnLZdAJIzKCNu8IoInf8E4RIhsekeiJk1lpPLOMSWEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsuFpEkYKXjLbWOLeNuGrpAPsCs3nKb46jzYH3q/Nup3+44Kl+SUxIAs17MuMR/XNUwAfGJ333HU6Y5SDBUaWaCQo6to5C1LyrXwQmK5PQpCKT05ksP+/+zh1L/ALTGb++hDSIvgLt55SG3DQnrFasLo7eO3utAjpWXLmyYJSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ii7G/fsj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736434821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o05o/7Mxj4KVai2AnUEf3T0uGeZuV/vmCjsNpFWRxW8=;
	b=ii7G/fsjkp/F0U/VicoyiDZuH1QIxfqNpKC2It6VS/lMLdw9TQc/B2/mmjPF35wLWOOCpf
	t1QWCYb7Ol9tQQ70FuyCRKRKaPvt2h17oxKbdJZr23/jQcTh5Z46fLIkG/kdHdFcbCutyr
	mZKEs7y4HsmN0nqj8CENe2dUTJ3IPJc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-c3qDjWWOP9W_xG5tCpK6-w-1; Thu, 09 Jan 2025 10:00:19 -0500
X-MC-Unique: c3qDjWWOP9W_xG5tCpK6-w-1
X-Mimecast-MFC-AGG-ID: c3qDjWWOP9W_xG5tCpK6-w
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43628594d34so5659765e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 07:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736434819; x=1737039619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o05o/7Mxj4KVai2AnUEf3T0uGeZuV/vmCjsNpFWRxW8=;
        b=MX7VslwdBXl60f9trpUWIx3a79IeA1v3kxFutgLlP0b3UiCbwq85qH7Z+QGMs5RaBC
         /2pM58J6MXXuqLb/MdggsfbS6cSO41ureEKdx/vXhx84nforfGKnG0myDS+LPEeRPGI5
         6M67mXNuO++SaykJ7T5i+FpfnbFtPqRro1bI+flanRW3XEuaaybyiH/MGMMgoGqxo5MX
         2fFArDw+KV73tuMDKiYGTixJJocFKrQHjBtAca61Z7Bpsna2xu58XRayZ+xroYSmYRg+
         lXM2YgOEhNfzhNyVMckz5Tm54e/CqEAkOrS8XHC4usKHY5eoyZxVhOtB6iHe0XbRFDkS
         me2g==
X-Forwarded-Encrypted: i=1; AJvYcCV2GtoibMn15cqbgCud/wnm06N/vhzqoTGTiWo4LZf/SZ3s4URqmFHHvapyUwUwPNbjWYnRMSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJ7JeTW5MxFUQYOb0EK3Csgh4yct8DygTHzWDGctygnyxKM2K
	TOvhN/82FK+5WGXWVt5QHfxn6VASyDYia5aom4SUx27OTakmdQJxR+JKATmW12EznjYTO3E6skB
	bNAhV7N4n3ejB2+Ea0sipSCW5y055H3niNXwuhbnekb0pCX4l2mIaeQ==
X-Gm-Gg: ASbGnctut3v5AkmqqvqzYMQ+ckwT0O0u2yb3pjpX8ikRhe8D3jqX0Re3uz8oWUcgBXK
	HbKBK/D+w9oSOXzHPt4mNFh2GpjN+tJC2PZRPlqPf7UWTTJwNZjGH/hF57388u2+1ymCtdCL/06
	6Yf5Xlm6RKEUVjCqIW55RibpnJ3xSS4ptKrOaVG++iQv6g3lkSjax4/0IiINqWP2Q8L+ngzoqs7
	+dcET81N6TvtDobf45YoJ5AC/bABi3cTh8vhsRY0LH4hQ6Hc6QRwMDWPTBSL1zKktD1oHzbbjTW
	8ZeNReq2
X-Received: by 2002:a5d:47a3:0:b0:38a:4184:2510 with SMTP id ffacd0b85a97d-38a872db629mr7036762f8f.23.1736434818618;
        Thu, 09 Jan 2025 07:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0qpefjzwggolZbq54RnTPm+ZuDN/XJ1XaE+4DqwqaPVubWYTbEoLSIZAP8E8huVRHQ5WKJg==
X-Received: by 2002:a5d:47a3:0:b0:38a:4184:2510 with SMTP id ffacd0b85a97d-38a872db629mr7036723f8f.23.1736434818145;
        Thu, 09 Jan 2025 07:00:18 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c6dbsm2083082f8f.55.2025.01.09.07.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 07:00:17 -0800 (PST)
Message-ID: <5ed1d572-b2e4-46f9-b9a5-6c4c0190fe7d@redhat.com>
Date: Thu, 9 Jan 2025 16:00:16 +0100
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
 <133b8da8-a2da-4bac-b0bb-7dcaebc219b9@redhat.com>
 <31a45fb4-acb6-4eb6-9ffb-ff1be798a064@ti.com>
 <45fac9f0-b31a-495d-bd1b-ccf0fbe19653@redhat.com>
 <b8d46941-aeb2-466a-acd5-8ad5be832649@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b8d46941-aeb2-466a-acd5-8ad5be832649@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 10:40 AM, MD Danish Anwar wrote:
> On 07/01/25 11:57 pm, Paolo Abeni wrote:
>> On 1/7/25 11:47 AM, MD Danish Anwar wrote:
>>> On 07/01/25 3:12 pm, Paolo Abeni wrote:
>>>> On 1/3/25 10:20 AM, MD Danish Anwar wrote:
>>>>> Add multicast filtering support for VLAN interfaces in dual EMAC mode
>>>>> for ICSSG driver.
>>>>>
>>>>> The driver uses vlan_for_each() API to get the list of available
>>>>> vlans. The driver then sync mc addr of vlan interface with a locally
>>>>> mainatined list emac->vlan_mcast_list[vid] using __hw_addr_sync_multiple()
>>>>> API.
>>>>>
>>>>> The driver then calls the sync / unsync callbacks and based on whether
>>>>> the ndev is vlan or not, driver passes appropriate vid to FDB helper
>>>>> functions.
>>>>>
>>>>> This commit also exports __hw_addr_sync_multiple() in order to use it
>>>>> from the ICSSG driver.
>>>>>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 67 ++++++++++++++++----
>>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  6 ++
>>>>>  include/linux/netdevice.h                    |  3 +
>>>>>  net/core/dev_addr_lists.c                    |  7 +-
>>>>>  4 files changed, 66 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>>> index 1663941e59e3..ed8b5a3184d6 100644
>>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>>> @@ -472,30 +472,44 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>>>>>  
>>>>>  static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
>>>>>  {
>>>>> -	struct prueth_emac *emac = netdev_priv(ndev);
>>>>> -	int port_mask = BIT(emac->port_id);
>>>>> +	struct net_device *real_dev;
>>>>> +	struct prueth_emac *emac;
>>>>> +	int port_mask;
>>>>> +	u8 vlan_id;
>>>>>  
>>>>> -	port_mask |= icssg_fdb_lookup(emac, addr, 0);
>>>>> -	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
>>>>> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
>>>>> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
>>>>> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
>>>>> +	emac = netdev_priv(real_dev);
>>>>> +
>>>>> +	port_mask = BIT(emac->port_id) | icssg_fdb_lookup(emac, addr, vlan_id);
>>>>> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, true);
>>>>> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, true);
>>>>>  
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>>  static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
>>>>>  {
>>>>> -	struct prueth_emac *emac = netdev_priv(ndev);
>>>>> -	int port_mask = BIT(emac->port_id);
>>>>> +	struct net_device *real_dev;
>>>>> +	struct prueth_emac *emac;
>>>>>  	int other_port_mask;
>>>>> +	int port_mask;
>>>>> +	u8 vlan_id;
>>>>> +
>>>>> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
>>>>> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
>>>>> +	emac = netdev_priv(real_dev);
>>>>>  
>>>>> -	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
>>>>> +	port_mask = BIT(emac->port_id);
>>>>> +	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, vlan_id);
>>>>>  
>>>>> -	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
>>>>> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
>>>>> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, false);
>>>>> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, false);
>>>>>  
>>>>>  	if (other_port_mask) {
>>>>> -		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
>>>>> -		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
>>>>> +		icssg_fdb_add_del(emac, addr, vlan_id, other_port_mask, true);
>>>>> +		icssg_vtbl_modify(emac, vlan_id, other_port_mask,
>>>>> +				  other_port_mask, true);
>>>>>  	}
>>>>>  
>>>>>  	return 0;
>>>>> @@ -531,6 +545,25 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> +static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
>>>>> +				   void *args)
>>>>> +{
>>>>> +	struct prueth_emac *emac = args;
>>>>> +
>>>>> +	if (!vdev || !vid)
>>>>> +		return 0;
>>>>> +
>>>>> +	netif_addr_lock_bh(vdev);
>>>>> +	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc,
>>>>> +				vdev->addr_len);
>>>>> +	netif_addr_unlock_bh(vdev);
>>>>
>>>> At this point, isn't emac->vlan_mcast_list[vid] == vdev->mc?
>>>>
>>>>> +
>>>>> +	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
>>>>> +			   icssg_prueth_add_mcast, icssg_prueth_del_mcast);
>>>>
>>>> If so, can this function be reduced to just:
>>>>
>>>> 	__dev_mc_sync(vdev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);
>>>>
>>>> ?
>>>>
>>>
>>> I don't know but for some reason __dev_mc_sync() doesn't work here. My
>>> initial approach was to use __dev_mc_sync(vdev, sync, unsync) however it
>>> didn't work.
>>>
>>> When I use __dev_mc_sync() and print the vlan_id in function
>>> icssg_prueth_add_mcast(). It always prints vlan_id as 0 implying
>>> __dev_mc_sync from here never gets called. Whereas when using
>>> __hw_addr_sync_dev() I see the appropriate vlan_id in
>>> icssg_prueth_add_mcast()
>>
>> It look like the above needs more investigation, right? is
>> vlan_mcast_list[vid] different from vdev->mc? why? At very least you
>> need to provide a clear explaination of the above.
>>
> 
> I did further debug on this. At this point vlan_mcast_list[vid] is
> actually same as vdev->mc in terms of the multicast addresses.
> 
> However the sync_cnt and refcount of the addresses in both the lists are
> not same. Due to which vdev->mc doesn't work here. I will explain it.
> 
> __dev_mc_sync(vdev, sync, unsync) will call __hw_addr_sync_dev(&dev->mc,
> dev, sync, unsync)
> 
> Now in __hw_addr_sync_dev() sync is only called when ha->sync_cnt == 0
> for the given mac address. If ha->sync_cnt is non zero, sync will not
> get called.
> 
> When we add a multicast address to the vlan interface using below command,
> 	
> 	ip maddr add <mac_addr> dev eth1.6
> 
> ndo_set_rx_mode() gets called for the vlan interface i.e.
> vlan_dev_set_rx_mode() [net/8021q/vlan_dev.c] which syncs mc list from
> the vdev to the real_dev of vdev by calling dev_mc_sync(real_dev, vdev)
> 
> Now dev_mc_sync() sync addresses from vdev to real_dev using
> __hw_addr_sync().
> 
> __hw_addr_sync() calls __hw_addr_sync_one() which after successfully
> syncing an address from vdev to real_dev increment the ha->sync_cnt. As
> a result at this point the ha->sync_cnt == 1 for the above address
> passed by command. After this vlan_dev_set_rx_mode() calls the
> set_rx_mode() of the real_dev.
> 
> Now when icssg_update_vlan_mcast() calls __dev_mc_sync(vdev, sync,
> unsync), it calls _hw_addr_sync_dev(&dev->mc, dev, sync, unsync) and
> checks the ha->sync_cnt for the given address, since sync_cnt is already
> 1, it doesn't consider it as an newly added address and sync / unsync
> callbacks are not called. [1]
> 
> list_for_each_entry_safe(ha, tmp, &list->list, list) {
> 	if (ha->sync_cnt)
> 		continue;
> 
> Since for addresses in vlan interfaces, sync_cnt will always be set as
> vlan_dev_set_rx_mode() will sync the mc list of vlan interface with the
> real dev. This will mean that the driver implemented sync / unsync APIs
> will only be called for the real_dev and the real_dev won't have any
> information about the vlan_id which I need in my sync / unsync APIs to
> populate the same in the hardware maintained FDB table.
> 
> To overcome this, I am maintaining a local copy of vdev->mc named
> emac->vlan_mcast_list[vid]. I will sync address from vdev->mc to this.
> and then call __hw_addr_sync_dev() on this list as the sync_cnt for
> address in this list will still be zero. Which will then trigger my
> sync() callback on the vdev which will help me obtain the vlan_id in the
> sync callback. I can now populate the same in the hardware maintained
> FDB table.
> 
> I hope this explains why I am using
> 
> 	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
> icssg_prueth_add_mcast, icssg_prueth_del_mcast)
> 
> instead of
> 
> 	__dev_mc_sync(vdev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);
> 
>>> Anyways, Even if I use __dev_mc_sync(), we will still need the export. I
>>> am exporting __hw_addr_sync_multiple() not __hw_addr_sync_dev(). The API
>>> being used by me `__hw_addr_sync_dev()` is already exported.
>>
>> I fear there is a misunderstanding. I'm suggesting dropping
>> __hw_addr_sync_multiple() usage entirely. If that is not possible, a
>> clear and complete explaination of the reason/root cause must be provided.
>>
> 
> As explained above, I need to be able to sync addresses from vdev->mc to
> my local list. Now this can be done using two APIs.
> 
> 1. __hw_addr_sync() - This is already exported and is actually the first
> choice. However this will fail syncing address from vdev->mc to my local
> copy.
> 
> __hw_addr_sync() only syncs the address if ha->sync_cnt == 0. If the
> sync_cnt is non zero, this will skip the address. As explained above,
> for mc addresses of vlan interfaces, sync_cnt will always be set as
> vlan_dev_set_rx_mode() will sync the mc list of vlan interface with the
> real dev. As a result the addresses will be skipped and __hw_addr_sync()
> will not serve the purpose here.
> 
> 2. __hw_addr_sync_multiple() - This actually works perfectly fine here
> as it sync address even if sync_cnt is non zero. As a result I am using
> this function in my implementation.
> 
> Since this is not public, I have to export it so that the driver can
> call this.
> 
> So I am afraid dropping __hw_addr_sync_multiple() is not possible here.
> I hope the explanation above makes sense to you.
> 
> Please let me know if this is OK with you. If you have some other way> through which I can make this work please let me know.

I think it makes sense and I can't think of simpler ways on top of my
head. Please repost capturing a synopsis of the above in the commit message.

Thanks,

Paolo


