Return-Path: <netdev+bounces-156192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021E7A05715
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BFD7A114E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A871F1309;
	Wed,  8 Jan 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="emvOYUwx"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7918A6BD;
	Wed,  8 Jan 2025 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329256; cv=none; b=uV43gdU8TLCwg6Qv6N24VvB0IBi1T7G93LDw+nMb9S+7NCL0YMLxvUN/qkyUFyG+NHc1RUEWACoKTm8F5DEFdjhDd+cRggSehWLmloGmx9h/mWSnDJUBgYHFneocUbaDzFtlBH8rMEf4VehpX+ivTQbxh5BwrwZqhnhhRNHh4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329256; c=relaxed/simple;
	bh=R2R1ob8MjWjO0Ho5d/K4vAfwseOJe20BS38o8gkU35Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oTND0nLduMmmMXZ8O5e/8PROlPhkctjMUUYMKURpifgPsQlzLqdMjC+QasDndbhY4SxBG668mB9yqdUZupkRWKvyIuA5jaEckVyYdwADW7mMZNBVr72YGvUWfrPlPIHZ/ZbPI61E4olRK8j2l1tjvtH+xP4fb74bbo5xRnG9eCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=emvOYUwx; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5089eLlM064190;
	Wed, 8 Jan 2025 03:40:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736329221;
	bh=SHqLg2OgtcaiNPNnY3X4GY4PryKUsFXu3JM4uuBTrPg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=emvOYUwxCZqVwKNQFmp5xo5YWjsAUkpXT8mrwx4GvshSIZVR99Dcua4v43VdvjEhH
	 tvAU6NhRML2msBjflwrFuR6Ch9AygwtkXKS6+IzYqIr259tBzIk1DbzNz71F3GJLfB
	 XZW5sjeGSGrE8cN55jPXJZPqRppKfsVr2tllvnyE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5089eL6q017255
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Jan 2025 03:40:21 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Jan 2025 03:40:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Jan 2025 03:40:20 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5089eEJc060529;
	Wed, 8 Jan 2025 03:40:15 -0600
Message-ID: <b8d46941-aeb2-466a-acd5-8ad5be832649@ti.com>
Date: Wed, 8 Jan 2025 15:10:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] net: ti: icssg-prueth: Add Multicast
 Filtering support for VLAN in MAC mode
To: Paolo Abeni <pabeni@redhat.com>, Jeongjun Park <aha310510@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Lukasz Majewski
	<lukma@denx.de>, Meghana Malladi <m-malladi@ti.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>
References: <20250103092033.1533374-1-danishanwar@ti.com>
 <20250103092033.1533374-3-danishanwar@ti.com>
 <133b8da8-a2da-4bac-b0bb-7dcaebc219b9@redhat.com>
 <31a45fb4-acb6-4eb6-9ffb-ff1be798a064@ti.com>
 <45fac9f0-b31a-495d-bd1b-ccf0fbe19653@redhat.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <45fac9f0-b31a-495d-bd1b-ccf0fbe19653@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Paolo,

On 07/01/25 11:57 pm, Paolo Abeni wrote:
> Hi,
> 
> On 1/7/25 11:47 AM, MD Danish Anwar wrote:
>> On 07/01/25 3:12 pm, Paolo Abeni wrote:
>>> On 1/3/25 10:20 AM, MD Danish Anwar wrote:
>>>> Add multicast filtering support for VLAN interfaces in dual EMAC mode
>>>> for ICSSG driver.
>>>>
>>>> The driver uses vlan_for_each() API to get the list of available
>>>> vlans. The driver then sync mc addr of vlan interface with a locally
>>>> mainatined list emac->vlan_mcast_list[vid] using __hw_addr_sync_multiple()
>>>> API.
>>>>
>>>> The driver then calls the sync / unsync callbacks and based on whether
>>>> the ndev is vlan or not, driver passes appropriate vid to FDB helper
>>>> functions.
>>>>
>>>> This commit also exports __hw_addr_sync_multiple() in order to use it
>>>> from the ICSSG driver.
>>>>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 67 ++++++++++++++++----
>>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  6 ++
>>>>  include/linux/netdevice.h                    |  3 +
>>>>  net/core/dev_addr_lists.c                    |  7 +-
>>>>  4 files changed, 66 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> index 1663941e59e3..ed8b5a3184d6 100644
>>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>>> @@ -472,30 +472,44 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>>>>  
>>>>  static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
>>>>  {
>>>> -	struct prueth_emac *emac = netdev_priv(ndev);
>>>> -	int port_mask = BIT(emac->port_id);
>>>> +	struct net_device *real_dev;
>>>> +	struct prueth_emac *emac;
>>>> +	int port_mask;
>>>> +	u8 vlan_id;
>>>>  
>>>> -	port_mask |= icssg_fdb_lookup(emac, addr, 0);
>>>> -	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
>>>> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
>>>> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
>>>> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
>>>> +	emac = netdev_priv(real_dev);
>>>> +
>>>> +	port_mask = BIT(emac->port_id) | icssg_fdb_lookup(emac, addr, vlan_id);
>>>> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, true);
>>>> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, true);
>>>>  
>>>>  	return 0;
>>>>  }
>>>>  
>>>>  static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
>>>>  {
>>>> -	struct prueth_emac *emac = netdev_priv(ndev);
>>>> -	int port_mask = BIT(emac->port_id);
>>>> +	struct net_device *real_dev;
>>>> +	struct prueth_emac *emac;
>>>>  	int other_port_mask;
>>>> +	int port_mask;
>>>> +	u8 vlan_id;
>>>> +
>>>> +	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
>>>> +	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
>>>> +	emac = netdev_priv(real_dev);
>>>>  
>>>> -	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
>>>> +	port_mask = BIT(emac->port_id);
>>>> +	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, vlan_id);
>>>>  
>>>> -	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
>>>> -	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
>>>> +	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, false);
>>>> +	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, false);
>>>>  
>>>>  	if (other_port_mask) {
>>>> -		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
>>>> -		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
>>>> +		icssg_fdb_add_del(emac, addr, vlan_id, other_port_mask, true);
>>>> +		icssg_vtbl_modify(emac, vlan_id, other_port_mask,
>>>> +				  other_port_mask, true);
>>>>  	}
>>>>  
>>>>  	return 0;
>>>> @@ -531,6 +545,25 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
>>>> +				   void *args)
>>>> +{
>>>> +	struct prueth_emac *emac = args;
>>>> +
>>>> +	if (!vdev || !vid)
>>>> +		return 0;
>>>> +
>>>> +	netif_addr_lock_bh(vdev);
>>>> +	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc,
>>>> +				vdev->addr_len);
>>>> +	netif_addr_unlock_bh(vdev);
>>>
>>> At this point, isn't emac->vlan_mcast_list[vid] == vdev->mc?
>>>
>>>> +
>>>> +	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
>>>> +			   icssg_prueth_add_mcast, icssg_prueth_del_mcast);
>>>
>>> If so, can this function be reduced to just:
>>>
>>> 	__dev_mc_sync(vdev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);
>>>
>>> ?
>>>
>>
>> I don't know but for some reason __dev_mc_sync() doesn't work here. My
>> initial approach was to use __dev_mc_sync(vdev, sync, unsync) however it
>> didn't work.
>>
>> When I use __dev_mc_sync() and print the vlan_id in function
>> icssg_prueth_add_mcast(). It always prints vlan_id as 0 implying
>> __dev_mc_sync from here never gets called. Whereas when using
>> __hw_addr_sync_dev() I see the appropriate vlan_id in
>> icssg_prueth_add_mcast()
> 
> It look like the above needs more investigation, right? is
> vlan_mcast_list[vid] different from vdev->mc? why? At very least you
> need to provide a clear explaination of the above.
> 

I did further debug on this. At this point vlan_mcast_list[vid] is
actually same as vdev->mc in terms of the multicast addresses.

However the sync_cnt and refcount of the addresses in both the lists are
not same. Due to which vdev->mc doesn't work here. I will explain it.

__dev_mc_sync(vdev, sync, unsync) will call __hw_addr_sync_dev(&dev->mc,
dev, sync, unsync)

Now in __hw_addr_sync_dev() sync is only called when ha->sync_cnt == 0
for the given mac address. If ha->sync_cnt is non zero, sync will not
get called.

When we add a multicast address to the vlan interface using below command,
	
	ip maddr add <mac_addr> dev eth1.6

ndo_set_rx_mode() gets called for the vlan interface i.e.
vlan_dev_set_rx_mode() [net/8021q/vlan_dev.c] which syncs mc list from
the vdev to the real_dev of vdev by calling dev_mc_sync(real_dev, vdev)

Now dev_mc_sync() sync addresses from vdev to real_dev using
__hw_addr_sync().

__hw_addr_sync() calls __hw_addr_sync_one() which after successfully
syncing an address from vdev to real_dev increment the ha->sync_cnt. As
a result at this point the ha->sync_cnt == 1 for the above address
passed by command. After this vlan_dev_set_rx_mode() calls the
set_rx_mode() of the real_dev.

Now when icssg_update_vlan_mcast() calls __dev_mc_sync(vdev, sync,
unsync), it calls _hw_addr_sync_dev(&dev->mc, dev, sync, unsync) and
checks the ha->sync_cnt for the given address, since sync_cnt is already
1, it doesn't consider it as an newly added address and sync / unsync
callbacks are not called. [1]

list_for_each_entry_safe(ha, tmp, &list->list, list) {
	if (ha->sync_cnt)
		continue;

Since for addresses in vlan interfaces, sync_cnt will always be set as
vlan_dev_set_rx_mode() will sync the mc list of vlan interface with the
real dev. This will mean that the driver implemented sync / unsync APIs
will only be called for the real_dev and the real_dev won't have any
information about the vlan_id which I need in my sync / unsync APIs to
populate the same in the hardware maintained FDB table.

To overcome this, I am maintaining a local copy of vdev->mc named
emac->vlan_mcast_list[vid]. I will sync address from vdev->mc to this.
and then call __hw_addr_sync_dev() on this list as the sync_cnt for
address in this list will still be zero. Which will then trigger my
sync() callback on the vdev which will help me obtain the vlan_id in the
sync callback. I can now populate the same in the hardware maintained
FDB table.

I hope this explains why I am using

	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
icssg_prueth_add_mcast, icssg_prueth_del_mcast)

instead of

	__dev_mc_sync(vdev, icssg_prueth_add_mcast, icssg_prueth_del_mcast);

>> Anyways, Even if I use __dev_mc_sync(), we will still need the export. I
>> am exporting __hw_addr_sync_multiple() not __hw_addr_sync_dev(). The API
>> being used by me `__hw_addr_sync_dev()` is already exported.
> 
> I fear there is a misunderstanding. I'm suggesting dropping
> __hw_addr_sync_multiple() usage entirely. If that is not possible, a
> clear and complete explaination of the reason/root cause must be provided.
> 

As explained above, I need to be able to sync addresses from vdev->mc to
my local list. Now this can be done using two APIs.

1. __hw_addr_sync() - This is already exported and is actually the first
choice. However this will fail syncing address from vdev->mc to my local
copy.

__hw_addr_sync() only syncs the address if ha->sync_cnt == 0. If the
sync_cnt is non zero, this will skip the address. As explained above,
for mc addresses of vlan interfaces, sync_cnt will always be set as
vlan_dev_set_rx_mode() will sync the mc list of vlan interface with the
real dev. As a result the addresses will be skipped and __hw_addr_sync()
will not serve the purpose here.

2. __hw_addr_sync_multiple() - This actually works perfectly fine here
as it sync address even if sync_cnt is non zero. As a result I am using
this function in my implementation.

Since this is not public, I have to export it so that the driver can
call this.

So I am afraid dropping __hw_addr_sync_multiple() is not possible here.
I hope the explanation above makes sense to you.

Please let me know if this is OK with you. If you have some other way
through which I can make this work please let me know.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/net/core/dev_addr_lists.c#n314

> Thanks,
> 
> Paolo
> 

-- 
Thanks and Regards,
Danish

