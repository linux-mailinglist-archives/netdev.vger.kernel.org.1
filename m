Return-Path: <netdev+bounces-18886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC7758F82
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8ED2814EF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A8BD2EC;
	Wed, 19 Jul 2023 07:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81EC8D0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:49:26 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0041BE3;
	Wed, 19 Jul 2023 00:49:24 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R5SZQ44DNzLntD;
	Wed, 19 Jul 2023 15:46:54 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 15:49:21 +0800
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
To: Eric Dumazet <edumazet@google.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, <socketcan@hartkopp.net>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<penguin-kernel@i-love.sakura.ne.jp>
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com>
 <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
 <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com>
 <1e0e6539-412a-cc8d-b104-e2921a099e48@huawei.com>
 <CANn89iKoTWHBGgMW-RyJHHeM0QuiN9De=eNWMM8VRom++n_o_g@mail.gmail.com>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <3566e594-a9e5-8ba4-0f5a-d50086cebd82@huawei.com>
Date: Wed, 19 Jul 2023 15:49:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iKoTWHBGgMW-RyJHHeM0QuiN9De=eNWMM8VRom++n_o_g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/7/19 13:04, Eric Dumazet 写道:
> On Wed, Jul 19, 2023 at 6:41 AM Ziyang Xuan (William)
> <william.xuanziyang@huawei.com> wrote:
>>
>>> On Mon, Jul 17, 2023 at 9:27 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>>
>>>> On 11.07.2023 09:17:37, Ziyang Xuan wrote:
>>>>> Got kmemleak errors with the following ltp can_filter testcase:
>>>>>
>>>>> for ((i=1; i<=100; i++))
>>>>> do
>>>>>         ./can_filter &
>>>>>         sleep 0.1
>>>>> done
>>>>>
>>>>> ==============================================================
>>>>> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
>>>>> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
>>>>> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
>>>>> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
>>>>> [<00000000fd468496>] do_syscall_64+0x33/0x40
>>>>> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>>>>>
>>>>> It's a bug in the concurrent scenario of unregister_netdevice_many()
>>>>> and raw_release() as following:
>>>>>
>>>>>              cpu0                                        cpu1
>>>>> unregister_netdevice_many(can_dev)
>>>>>   unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
>>>>>   net_set_todo(can_dev)
>>>>>                                               raw_release(can_socket)
>>>>>                                                 dev = dev_get_by_index(, ro->ifindex); // dev == NULL
>>>>>                                                 if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
>>>>>                                                   raw_disable_allfilters(, dev, );
>>>>>                                                   dev_put(dev);
>>>>>                                                 }
>>>>>                                                 ...
>>>>>                                                 ro->bound = 0;
>>>>>                                                 ...
>>>>>
>>>>> call_netdevice_notifiers(NETDEV_UNREGISTER, )
>>>>>   raw_notify(, NETDEV_UNREGISTER, )
>>>>>     if (ro->bound) // invalid because ro->bound has been set 0
>>>>>       raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed
>>>>>
>>>>> Add a net_device pointer member in struct raw_sock to record bound can_dev,
>>>>> and use rtnl_lock to serialize raw_socket members between raw_bind(), raw_release(),
>>>>> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to free receivers in
>>>>> dev_rcv_lists.
>>>>>
>>>>> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
>>>>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>>>>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>>
>>>> Added to linux-can/testing.
>>>>
>>>
>>> This patch causes three syzbot LOCKDEP reports so far.
>>
>> Hello Eric,
>>
>> Is there reproducer? I want to understand the specific root cause.
>>
> 
> No repro yet, but simply look at other functions in net/can/raw.c
> 
> You must always take locks in the same order.
> 
> raw_bind(), raw_setsockopt() use:
> 
> rtnl_lock();
> lock_sock(sk);
> 
> Therefore, raw_release() must _also_ use the same order, or risk deadlock.
> 
> Please build a LOCKDEP enabled kernel, and run your tests ?

I know now. This needs raw_bind() and raw_setsockopt() concurrent with raw_release().
And there is not the scenario in my current testcase. I did not get it. I will try to
reproduce it and add the testcase.

Thank you for your patient explanation.

William Xuan.
> .
> 

