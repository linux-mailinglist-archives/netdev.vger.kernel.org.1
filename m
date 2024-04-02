Return-Path: <netdev+bounces-84005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C189542E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67071F23D58
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB227F7D3;
	Tue,  2 Apr 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="efIQtZGC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BJxwbdik"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A133D1
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063168; cv=none; b=YC0XJxvUxbE5xVtgM1swvihd8YdNFmaq2CRvsRAt41FDSANYbLxhpY2Xhd+GV5aVxg3aryki+tnyMXnOo+FwySM/KAzcVrRIAcsavTn3mi+bwFftOfx/U/KDEKG5UJDAZ0OZeBhAjVxuHnf9r0fJ9Lp1njLqONjU4fAD7iE//Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063168; c=relaxed/simple;
	bh=lDBaETv2m8IfelAL0kfhpYsoTT+XqtaWGwWHkzeEVqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syPcxpUkHirj0oPt5JLG0ooDlAamEWe0tfFXFNeCxQ+l7fV7dngaQx7nJYfCHy54u3tSxz48td/f4RethfhSvEgRe/CtDj62gPLp1doa+1k2euQwuGhDJcne7XhYFckKHIBi8KGCtUN2WLxYUb6/yC+KdflWLe+4qoaO5nOnwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=efIQtZGC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BJxwbdik; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDAC633E88;
	Tue,  2 Apr 2024 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712063163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/7Q2r3iAGHodeC475qh76Th/GklAFr9NGZSScFmidw=;
	b=efIQtZGCrYqkV3rhZopZ16LMeGalXr4bhcQJJk/3cHxNV77cZdn6vNIhCJB1WLFSoUn3cL
	AM4W4VMt+3Fa4yymYMrFeNJ+XXDcS7r1/APmVv7RYI4DptxPdYyI0rUtm40TEmqfKO2t5I
	6KzLsMY5r4opttlVOy8kTadEQOCLZAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712063163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/7Q2r3iAGHodeC475qh76Th/GklAFr9NGZSScFmidw=;
	b=BJxwbdikHFFmKHVH+tzU8hWURisNAhLRFJsBSovdH81gH+vA+6expEEbRJocHisZMkOwKk
	m7zJF9ETkV/0PcCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A6BD13357;
	Tue,  2 Apr 2024 13:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cKK9GrsCDGYITQAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Tue, 02 Apr 2024 13:06:03 +0000
Message-ID: <e5eac29d-a9d3-4f03-86bc-64013be2cc39@suse.de>
Date: Tue, 2 Apr 2024 16:05:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4 net] RDMA/core: fix UAF with ib_device_get_netdev()
To: Ratheesh Kannoth <rkannoth@marvell.com>,
 Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, jgg@ziepe.ca,
 leon@kernel.org, syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
References: <20240401100005.1799-1-dkirjanov@suse.de>
 <20240401133518.GA1642209@maili.marvell.com>
Content-Language: en-US
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240401133518.GA1642209@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -0.60
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[marvell.com,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[5fe14f2ff4ccbace9a26];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EDAC633E88



On 4/1/24 16:35, Ratheesh Kannoth wrote:
> On 2024-04-01 at 15:30:05, Denis Kirjanov (kirjanov@gmail.com) wrote:
>> A call to ib_device_get_netdev may lead to a race condition
>> while accessing a netdevice instance since we don't hold
>> the rtnl lock while checking
>> the registration state:
>> 	if (res && res->reg_state != NETREG_REGISTERED) {
>>
>> v2: unlock rtnl on error path
>> v3: update remaining callers of ib_device_get_netdev
>> v4: don't call a cb with rtnl lock in ib_enum_roce_netdev
>>
>> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
>> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
>> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
>> ---
>>  drivers/infiniband/core/cache.c  |  2 ++
>>  drivers/infiniband/core/device.c | 15 ++++++++++++---
>>  drivers/infiniband/core/nldev.c  |  3 +++
>>  drivers/infiniband/core/verbs.c  |  6 ++++--
>>  4 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>> index c02a96d3572a..cf9c826cd520 100644
>> --- a/drivers/infiniband/core/cache.c
>> +++ b/drivers/infiniband/core/cache.c
>> @@ -1461,7 +1461,9 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>  		if (rdma_protocol_iwarp(device, port)) {
>>  			struct net_device *ndev;
>>
>> +			rtnl_lock();
>>  			ndev = ib_device_get_netdev(device, port);
>> +			rtnl_unlock();
> Why dont you move the rtnl_lock()/_unlock() inside ib_device_get_netdev().
> ib_device_get_netdev() hold ref to dev, so can access ndev safely here.

Makes sense. and it makes the whole change pretty small
> 
>>  			if (!ndev)
>>  				continue;
>>  			RCU_INIT_POINTER(gid_attr.ndev, ndev);
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 07cb6c5ffda0..25edb50d2b64 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -2026,9 +2026,12 @@ static int iw_query_port(struct ib_device *device,
>>
>>  	memset(port_attr, 0, sizeof(*port_attr));
>>
>> +	rtnl_lock();
>>  	netdev = ib_device_get_netdev(device, port_num);
>> -	if (!netdev)
>> +	if (!netdev) {
>> +		rtnl_unlock();
>>  		return -ENODEV;
>> +	}
>>
>>  	port_attr->max_mtu = IB_MTU_4096;
>>  	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
>> @@ -2052,6 +2055,7 @@ static int iw_query_port(struct ib_device *device,
>>  		rcu_read_unlock();
>>  	}
>>
>> +	rtnl_unlock();
>>  	dev_put(netdev);
>>  	return device->ops.query_port(device, port_num, port_attr);
>>  }
>> @@ -2220,6 +2224,8 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
>>  	struct ib_port_data *pdata;
>>  	struct net_device *res;
>>
>> +	ASSERT_RTNL();
>> +
>>  	if (!rdma_is_port_valid(ib_dev, port))
>>  		return NULL;
>>
>> @@ -2306,8 +2312,11 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
>>
>>  	rdma_for_each_port (ib_dev, port)
>>  		if (rdma_protocol_roce(ib_dev, port)) {
>> -			struct net_device *idev =
>> -				ib_device_get_netdev(ib_dev, port);
>> +			struct net_device *idev;
>> +
>> +			rtnl_lock();
>> +			idev = ib_device_get_netdev(ib_dev, port);
>> +			rtnl_unlock();
>>
>>  			if (filter(ib_dev, port, idev, filter_cookie))
>>  				cb(ib_dev, port, idev, cookie);
>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>> index 4900a0848124..5cf7cdae8925 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -360,7 +360,9 @@ static int fill_port_info(struct sk_buff *msg,
>>  	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_PHYS_STATE, attr.phys_state))
>>  		return -EMSGSIZE;
>>
>> +	rtnl_lock();
>>  	netdev = ib_device_get_netdev(device, port);
>> +
>>  	if (netdev && net_eq(dev_net(netdev), net)) {
>>  		ret = nla_put_u32(msg,
>>  				  RDMA_NLDEV_ATTR_NDEV_INDEX, netdev->ifindex);
>> @@ -371,6 +373,7 @@ static int fill_port_info(struct sk_buff *msg,
>>  	}
>>
>>  out:
>> +	rtnl_unlock();
>>  	dev_put(netdev);
>>  	return ret;
>>  }
>> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
>> index 94a7f3b0c71c..6a3757b00c93 100644
>> --- a/drivers/infiniband/core/verbs.c
>> +++ b/drivers/infiniband/core/verbs.c
>> @@ -1976,11 +1976,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>>  	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
>>  		return -EINVAL;
>>
>> +	rtnl_lock();
>>  	netdev = ib_device_get_netdev(dev, port_num);
>> -	if (!netdev)
>> +	if (!netdev) {
>> +		rtnl_unlock();
>>  		return -ENODEV;
>> +	}
>>
>> -	rtnl_lock();
>>  	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
>>  	rtnl_unlock();
>>
>> --
>> 2.30.2
>>

