Return-Path: <netdev+bounces-207443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB32B07483
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6954E565DAF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1C2F2375;
	Wed, 16 Jul 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RC7XYkoO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6E2F3C2F
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664833; cv=none; b=Pb0gQ6pT2OJAyVrqVaTPPhyGyPuGJqY9/hfoWF+vQt0WwIY45kW9lwTcbPJaB08yVteI9EL1Iz6IMtU7lEGfCLhX34jj96vGKyZWgDc02bbMxYPUdHNx0T1dlabD0//jOnO3Sems2aO08ofzXHCYL/DSHzU/bkBRTXykwc4Tx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664833; c=relaxed/simple;
	bh=rdVfHRyHli6kYrkwY39Hd8R+U1nb5c5moANmUD9cIOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lugU5t5ZWfM8Muc1wZam1Jf+wokdEaCiEKqUWQ00klgXhEP3z1/TiZwkTKZR5RVy6UUrxmBknbcXzK/4blrNFBAybLMKc7YNYltbhgnRWSSuwfRresId7OYyWpOwOMat+XgMmgkYGafisZTZv7svT9wzMLOUaCSwpx6f5628CUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RC7XYkoO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7426c44e014so6310520b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752664831; x=1753269631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBkJ72ZaxCg3y6ThdifmajrH59yMRxqhR6Yi2cpcKlM=;
        b=RC7XYkoOReC6AcaAVyNDNbmfpIjG3coIy8kTvyU6U2yKpE2O5vyEOh89dXUXe5byvA
         r1V5EBakRK+nMGdxfT3JdP3+Rf0D0AccQpGVEssgwse0fUdiI3s3x847B09rFTfY57zd
         dVJdOXhUcDxTdCLWFOywyaPBjL0Sh6O/l21COBMUWfpF22HKBdLu10VPhCXloQLdnRcH
         aC/1PE17fuSnDrnW9FmGVbrWvIGdGeaBeXKjORqRyn3GSDkZ80APG5PMXv0q0XkU73Ft
         kGB5FHFaoaPEzFrW85p3dRrTUaVqN3Jvl//I3Ec3MbXcidB4drhiDB+0wDhT525JpLt3
         WBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752664831; x=1753269631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBkJ72ZaxCg3y6ThdifmajrH59yMRxqhR6Yi2cpcKlM=;
        b=g9WTDJQj/4cvBSx5bP8uhbiu0vLEr3iWMdXWhaoxwwYkxZeSrLNnT+I9KuwZX9BwRR
         dyslgJAHENh3kb+Zx9Ez/sdtqdUonSihTmsAeC58SmbMaEkw3awg7Qz354vFxgdtDMxR
         6D8/E9cKHcRt7/7ggSpTBsyWIbyw6Sl6zNI9rehi2DU5NSKftBPbMvBY4Vjqu+S2kDXD
         QvBGoY1nrWGS9l52GaA6WHKML8UwJlXW07GkJdgvw8ZoVFbFn9nNvH6ab/WnUbXzoNtd
         rHICHP4wehRgkSDbNov13BiuTsBQyuWnbotTV6AIxfHSJpgaaRskT0ti2tIP2KOy2VMF
         qz/g==
X-Forwarded-Encrypted: i=1; AJvYcCX4SKSri2OChBcKOKOXZq6Qmc1Sv18HqZT9uWQgcf9ubjLJpTll//VxbQippvbg+gNfPHnZyGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYk0bu1Q/UnCNN3bEFakinueqnn7c4TnMOLdWQG2Wc4XajITi
	aSDgS8DjXMznGPgTGuUMqt4P/HyvsRpc3s3rQZComNTnv/qeJHVEDekE0sDzteiAyCg=
X-Gm-Gg: ASbGncs+bviak5IKiwKZxcNDQrGj3KVCnkcIMBS7CNOmemT8SdgwGJ7ji1AMsvUCgVE
	GMZjMhwIm4WS9Dup9EQ7QVuAzZSo/01Uvg2rXtCXaqdkYAvZ1Q4vRbjGRZ1F0/q/320nVIIjuM7
	M8uzVY9EG2qWQlLWg2wLXElBpqIOGWjZJBdfmgBqiFJvOu13ogpmoBMqcuA2rhS6/B7C4xhyDjx
	hHF+5KCLhOwuHaOZGQmtpKrC6yjcUNZhxdOoZ+CywuUiRwiuD0YegUAGfpCwUONdENUmZv6h6ko
	/ikfzJvOgKr8pDA68wZf5BtLXlV/3k10aJ3M8ty6FrsaM6Xhge4pkmBpU2lA4k6pM+JxtWjlA8D
	JVK+brO0pRsBhMyXDgtT8Ywnx/bz+EkDgy9oBtEsVACo=
X-Google-Smtp-Source: AGHT+IGlAPLsLx7LcyONRmAEOzWgymSbYJ0QmJ8EZHjtr8ZNky5ajwfD9mZageUtIzN0LsSNejopBg==
X-Received: by 2002:a05:6a21:3299:b0:231:c295:136d with SMTP id adf61e73a8af0-237d5a04b98mr5085396637.14.1752664831266;
        Wed, 16 Jul 2025 04:20:31 -0700 (PDT)
Received: from [10.74.26.146] ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4bc51sm13775462b3a.116.2025.07.16.04.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 04:20:30 -0700 (PDT)
Message-ID: <9a2b5887-3874-4d3d-bbd8-0b5a25d3e605@bytedance.com>
Date: Wed, 16 Jul 2025 19:20:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: Re: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock
 during probing
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zuozhijie@bytedance.com
References: <20250702103722.576219-1-zuozhijie@bytedance.com>
 <CACGkMEvjXBZ-Q77-8YRyd_EV0t9xMT8R8-FT5TKJBnqAOed=pQ@mail.gmail.com>
 <d5ad1b10-f485-4939-b9de-918b378362b9@bytedance.com>
 <CACGkMEvZ5dqjc6+1uwoq98x-78eymGFHXpOJtbViG3U9mOyn8g@mail.gmail.com>
Content-Language: en-US
From: Zigit Zo <zuozhijie@bytedance.com>
In-Reply-To: <CACGkMEvZ5dqjc6+1uwoq98x-78eymGFHXpOJtbViG3U9mOyn8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/25 10:47 AM, Jason Wang wrote:
> Hi Zigit:
> 
> On Tue, Jul 15, 2025 at 7:00 PM Zigit Zo <zuozhijie@bytedance.com> wrote:
>>
>> On 7/15/25 5:31 PM, Jason Wang wrote:
>>> On Wed, Jul 2, 2025 at 6:37 PM Zigit Zo <zuozhijie@bytedance.com> wrote:
>>>>
>>>> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
>>>> the virtio-net driver is still probing with rtnl_lock() hold, this will
>>>> cause a recursive mutex in netdev_notify_peers().
>>>>
>>>> Fix it by temporarily save the announce status while probing, and then in
>>>> virtnet_open(), if it sees a delayed announce work is there, it starts to
>>>> schedule the virtnet_config_changed_work().
>>>>
>>>> Another possible solution is to directly check whether rtnl_is_locked()
>>>> and call __netdev_notify_peers(), but in that way means we need to relies
>>>> on netdev_queue to schedule the arp packets after ndo_open(), which we
>>>> thought is not very intuitive.
>>>>
>>>> We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
>>>> QEMU sending the announce_self rapidly while booting.
>>>>
>>>> [  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
>>>> [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
>>>> [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>> [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
>>>> [  494.168260] Call Trace:
>>>> [  494.168329]  <TASK>
>>>> [  494.168389]  __schedule+0x27c/0x6b0
>>>> [  494.168495]  schedule+0x33/0x110
>>>> [  494.168585]  schedule_preempt_disabled+0x15/0x30
>>>> [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
>>>> [  494.168835]  __mutex_lock_slowpath+0x13/0x20
>>>> [  494.168949]  mutex_lock+0x3c/0x50
>>>> [  494.169039]  rtnl_lock+0x15/0x20
>>>> [  494.169128]  netdev_notify_peers+0x12/0x30
>>>> [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
>>>> [  494.169377]  virtnet_probe+0xa48/0xe00
>>>> [  494.169484]  ? vp_get+0x4d/0x100
>>>> [  494.169574]  virtio_dev_probe+0x1e9/0x310
>>>> [  494.169682]  really_probe+0x1c7/0x410
>>>> [  494.169783]  __driver_probe_device+0x8c/0x180
>>>> [  494.169901]  driver_probe_device+0x24/0xd0
>>>> [  494.170011]  __driver_attach+0x10b/0x210
>>>> [  494.170117]  ? __pfx___driver_attach+0x10/0x10
>>>> [  494.170237]  bus_for_each_dev+0x8d/0xf0
>>>> [  494.170341]  driver_attach+0x1e/0x30
>>>> [  494.170440]  bus_add_driver+0x14e/0x290
>>>> [  494.170548]  driver_register+0x5e/0x130
>>>> [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
>>>> [  494.170788]  register_virtio_driver+0x20/0x40
>>>> [  494.170905]  virtio_net_driver_init+0x97/0xb0
>>>> [  494.171022]  do_one_initcall+0x5e/0x340
>>>> [  494.171128]  do_initcalls+0x107/0x230
>>>> [  494.171228]  ? __pfx_kernel_init+0x10/0x10
>>>> [  494.171340]  kernel_init_freeable+0x134/0x210
>>>> [  494.171462]  kernel_init+0x1b/0x200
>>>> [  494.171560]  ret_from_fork+0x47/0x70
>>>> [  494.171659]  ? __pfx_kernel_init+0x10/0x10
>>>> [  494.171769]  ret_from_fork_asm+0x1b/0x30
>>>> [  494.171875]  </TASK>
>>>>
>>>> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
>>>> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
>>>> ---
>>>> v1 -> v2:
>>>> - Check vi->status in virtnet_open().
>>>> v1:
>>>> - https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
>>>> ---
>>>>  drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++----------------
>>>>  1 file changed, 26 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index e53ba600605a..859add98909b 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -3151,6 +3151,10 @@ static int virtnet_open(struct net_device *dev)
>>>>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>>>>                 if (vi->status & VIRTIO_NET_S_LINK_UP)
>>>>                         netif_carrier_on(vi->dev);
>>>> +               if (vi->status & VIRTIO_NET_S_ANNOUNCE) {
>>>> +                       vi->status &= ~VIRTIO_NET_S_ANNOUNCE;
>>>> +                       schedule_work(&vi->config_work);
>>>> +               }
>>>>                 virtio_config_driver_enable(vi->vdev);
>>>
>>> Instead of doing tricks like this.
>>>
>>> I wonder if the fix is as simple as calling
>>> virtio_config_driver_disable() before init_vqs()?
>>>
>>> Thanks
>>>
>>
>> That might not work as the device like QEMU will set the VIRTIO_NET_S_ANNOUNCE
>> regardless of most of the driver status, QEMU only checks whether the driver has
>> finalized it's features with VIRTIO_NET_F_GUEST_ANNOUNCE & VIRTIO_NET_F_CTRL_VQ.
>>
>> We've made a little patch to verify, don't know if it matches your thought, but
>> it does not seem to work :(
>>
>>     diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>     index e53ba600605a..f309ce3fe243 100644
>>     --- a/drivers/net/virtio_net.c
>>     +++ b/drivers/net/virtio_net.c
>>     @@ -6903,6 +6903,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>>                     vi->curr_queue_pairs = num_online_cpus();
>>             vi->max_queue_pairs = max_queue_pairs;
>>
>>     +       /* Disable config change notification until ndo_open. */
>>     +       virtio_config_driver_disable(vi->vdev);
>>     +
>>             /* Allocate/initialize the rx/tx queues, and invoke find_vqs */
>>             err = init_vqs(vi);
>>             if (err)
>>     @@ -6965,9 +6968,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>>                     goto free_failover;
>>             }
>>
>>     -       /* Disable config change notification until ndo_open. */
>>     -       virtio_config_driver_disable(vi->vdev);
>>     -
>>             virtio_device_ready(vdev);
>>
>>             if (vi->has_rss || vi->has_rss_hash_report) {
>>
>> For reproduce details,
>>
>> 1. Spawn qemu with monitor, like `-monitor unix:qemu.sock,server`
>> 2. In another window, run `while true; echo "announce_self"; end | socat - unix-connect:qemu.sock > /dev/null`
>> 3. The boot up will get hanged when probing the virtio_net
>>
>> The simplest version we've made is to revert the usage of
>> `virtnet_config_changed_work()` back to the `schedule_work()`, but as in v1,
>> we're still trying to understand the impact, making sure that it won't break
>> other things.
>>
>> Regards,
>>
> 
> Thanks for the clarification. Now I see the issue.
> 
> It looks like the root cause is to call virtio_config_changed_work()
> directly during probe().
> 
> Let's switch to use virtio_config_changed() instead so that we can
> properly check the config_driver_disabled.
> 
> Thanks
> 

Yes, we just wonder why there's a change to `virtnet_config_changed_work()`
in commit df28de7b0050, and therefore try to keep this behavior as much
as possible, to avoid breaking something.

Anyway, v3 will be sent off soon, thanks for the reviewing!

Regards,

