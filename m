Return-Path: <netdev+bounces-83741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3448939E2
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 12:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04971B21AE1
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7F111A5;
	Mon,  1 Apr 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DxM4rf84";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZOrEatw9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59311119B
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965652; cv=none; b=TaWdfKDyPpJHttBBo/3LKEsP+WCipNVjtPqIzNyTOvVZqDgTbU7Y+9jhEUonYKsRCulxRf+++1qCt79SK+MctO1snEgQMTw6+tcroOffyWF37BP4pP1xbEb5WacTtuEUbPiMbNsRP5BF1XugIVC0BLdLfed3/4poc/avrnMyZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965652; c=relaxed/simple;
	bh=umOYT1H0ylEVO4DvaMT/1w5bmvx9LWLuix/sHjiDsBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnFqnSW7m6s7UU4fUT7mCqty9Z6nOt6bAZEIVO2b9+54iixyD+f8gdHsO5cP1r/oS1iZlkTsoBGiABASz08F5k1o7ox15sziuAIlcRNbiK8u1sGfCkSGpJtbyMrQ+zSkQ1jDLJCwfezIHkkaUnnI/epg6Z6PIvZ54dlvwP4f2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DxM4rf84; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZOrEatw9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAD98200B6;
	Mon,  1 Apr 2024 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711965648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioHbxOTCvtkVXl6Yrmbb5bw9gUU8O+lqqJDCCdWWEYg=;
	b=DxM4rf847XcPv8bSLJ4S/erHp9uco7A1PLb9Vk7N9u7a9ZWTm63UBIjvhPL51A8WtsGTEx
	vazhYmM08BqGPi15YPHqxpqJ9fsER4bCftuEf5N5wHN20ykI0mhKZhW2xDGoJBeVOs+3TU
	IiFepo58UMH4HIBJLTBEb3xtnTkK1pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711965648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioHbxOTCvtkVXl6Yrmbb5bw9gUU8O+lqqJDCCdWWEYg=;
	b=ZOrEatw9fvfNxOXyduYzTO+xFCE3nt/VK05PhTFQ2jrMllZXQacP1KP46eKx/uxCeMeOAj
	G502vx7OiBSJXHBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 400F3139BE;
	Mon,  1 Apr 2024 10:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jQT8CtCFCmb3cgAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Mon, 01 Apr 2024 10:00:48 +0000
Message-ID: <3bb55132-e269-442e-afe7-3bf93628843f@suse.de>
Date: Mon, 1 Apr 2024 13:00:43 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] Subject: [PATCH] RDMA/core: fix UAF with
 ib_device_get_netdev()
To: Eric Dumazet <edumazet@google.com>, Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org,
 syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
References: <20240328133542.28572-1-dkirjanov@suse.de>
 <CANn89iLGZj5MVG-sYpn_eyBTNT7JyunpYgv2aOsxGa9EkNV3Gw@mail.gmail.com>
Content-Language: en-US
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <CANn89iLGZj5MVG-sYpn_eyBTNT7JyunpYgv2aOsxGa9EkNV3Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.60
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FREEMAIL_TO(0.00)[google.com,gmail.com];
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
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DAD98200B6



On 3/28/24 16:42, Eric Dumazet wrote:
> On Thu, Mar 28, 2024 at 2:36 PM Denis Kirjanov <kirjanov@gmail.com> wrote:
>>
>> A call to ib_device_get_netdev may lead to a race condition
>> while accessing a netdevice instance since we don't hold
>> the rtnl lock while checking
>> the registration state:
>>         if (res && res->reg_state != NETREG_REGISTERED) {
>>
>> v2: unlock rtnl on error path
>> v3: update remaining callers of ib_device_get_netdev
>>
>> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
>> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
>> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
>> ---
>>  drivers/infiniband/core/cache.c  |  2 ++
>>  drivers/infiniband/core/device.c | 15 ++++++++++++---
>>  drivers/infiniband/core/nldev.c  |  2 ++
>>  drivers/infiniband/core/verbs.c  |  6 ++++--
>>  4 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>> index c02a96d3572a..cf9c826cd520 100644
>> --- a/drivers/infiniband/core/cache.c
>> +++ b/drivers/infiniband/core/cache.c
>> @@ -1461,7 +1461,9 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>                 if (rdma_protocol_iwarp(device, port)) {
>>                         struct net_device *ndev;
>>
>> +                       rtnl_lock();
>>                         ndev = ib_device_get_netdev(device, port);
>> +                       rtnl_unlock();
>>                         if (!ndev)
>>                                 continue;
>>                         RCU_INIT_POINTER(gid_attr.ndev, ndev);
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 07cb6c5ffda0..53074a4b04c9 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -2026,9 +2026,12 @@ static int iw_query_port(struct ib_device *device,
>>
>>         memset(port_attr, 0, sizeof(*port_attr));
>>
>> +       rtnl_lock();
>>         netdev = ib_device_get_netdev(device, port_num);
>> -       if (!netdev)
>> +       if (!netdev) {
>> +               rtnl_unlock();
>>                 return -ENODEV;
>> +       }
>>
>>         port_attr->max_mtu = IB_MTU_4096;
>>         port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
>> @@ -2052,6 +2055,7 @@ static int iw_query_port(struct ib_device *device,
>>                 rcu_read_unlock();
>>         }
>>
>> +       rtnl_unlock();
>>         dev_put(netdev);
>>         return device->ops.query_port(device, port_num, port_attr);
>>  }
>> @@ -2220,6 +2224,8 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
>>         struct ib_port_data *pdata;
>>         struct net_device *res;
>>
>> +       ASSERT_RTNL();
>> +
>>         if (!rdma_is_port_valid(ib_dev, port))
>>                 return NULL;
>>
>> @@ -2306,12 +2312,15 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
>>
>>         rdma_for_each_port (ib_dev, port)
>>                 if (rdma_protocol_roce(ib_dev, port)) {
>> -                       struct net_device *idev =
>> -                               ib_device_get_netdev(ib_dev, port);
>> +                       struct net_device *idev;
>> +
>> +                       rtnl_lock();
>> +                       idev = ib_device_get_netdev(ib_dev, port);
>>
>>                         if (filter(ib_dev, port, idev, filter_cookie))
>>                                 cb(ib_dev, port, idev, cookie);
>>
>> +                       rtnl_unlock();
>>                         if (idev)
>>                                 dev_put(idev);
>>                 }
>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>> index 4900a0848124..cfa204a224f2 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -360,6 +360,7 @@ static int fill_port_info(struct sk_buff *msg,
>>         if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_PHYS_STATE, attr.phys_state))
>>                 return -EMSGSIZE;
>>
>> +       rtnl_lock();
Hi Eric,

the path from rdma_nl_rcv_msg doesn't hold the lock here and the added assertion confirms that:

[  145.932439]  ? ib_device_get_netdev+0x1ea/0x3a0 [ib_core]
[  145.932656]  ? ib_device_get_netdev+0x1ea/0x3a0 [ib_core]
[  145.932877]  ? __report_bug+0x1b8/0x250
[  145.932944]  ? ib_device_get_netdev+0x1ea/0x3a0 [ib_core]
[  145.933165]  ? report_bug+0xa4/0x1f0
[  145.933185]  ? ib_device_get_netdev+0x1ea/0x3a0 [ib_core]
[  145.933404]  ? handle_bug+0x5e/0xc0
[  145.933428]  ? exc_invalid_op+0x25/0x70
[  145.933450]  ? asm_exc_invalid_op+0x1a/0x20
[  145.933484]  ? __warn_printk+0x16d/0x300
[  145.933508]  ? ib_device_get_netdev+0x1ea/0x3a0 [ib_core]
[  145.933733]  fill_port_info+0x1c1/0x460 [ib_core]
[  145.935304]  ? __pfx_fill_port_info+0x10/0x10 [ib_core]
[  145.935528]  ? __build_skb_around+0x27b/0x3b0
[  145.935570]  ? skb_put+0x118/0x190
[  145.935594]  ? __nlmsg_put+0x159/0x1d0
[  145.935625]  nldev_port_get_doit+0x4f9/0x770 [ib_core]
[  145.935851]  ? __pfx_nldev_port_get_doit+0x10/0x10 [ib_core]
[  145.936109]  ? __lock_release+0x400/0x850
[  145.936251]  ? rdma_nl_rcv_msg+0x147/0x660 [ib_core]


> 
> I am guessing rtnl is already held here.
> 
> Please double check all paths you are adding rtnl if this is not going
> to deadlock.
> 
>>         netdev = ib_device_get_netdev(device, port);
>>         if (netdev && net_eq(dev_net(netdev), net)) {
>>                 ret = nla_put_u32(msg,
>> @@ -371,6 +372,7 @@ static int fill_port_info(struct sk_buff *msg,
>>         }
>>
>>
> 
> Please wait one day before sending a new version, thanks.
> 

