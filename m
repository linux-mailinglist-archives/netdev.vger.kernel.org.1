Return-Path: <netdev+bounces-16660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB9674E2E7
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 03:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940BE1C20C66
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C129382;
	Tue, 11 Jul 2023 01:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4DA196
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 01:00:46 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E745C0;
	Mon, 10 Jul 2023 18:00:44 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R0Mw33VjMzTmNY;
	Tue, 11 Jul 2023 08:59:31 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 09:00:41 +0800
Subject: Re: [PATCH net v2] can: raw: fix receiver memory leak
To: Oliver Hartkopp <socketcan@hartkopp.net>, <mkl@pengutronix.de>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<penguin-kernel@I-love.SAKURA.ne.jp>
References: <20230707075342.2463015-1-william.xuanziyang@huawei.com>
 <5c396de6-afab-6af9-f9d9-a698b9367873@hartkopp.net>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <242454ca-8b67-8169-fa30-5d605538ea63@huawei.com>
Date: Tue, 11 Jul 2023 09:00:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5c396de6-afab-6af9-f9d9-a698b9367873@hartkopp.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Hello William,
> 
> On 07.07.23 09:53, Ziyang Xuan wrote:
>> Got kmemleak errors with the following ltp can_filter testcase:
>>
>> for ((i=1; i<=100; i++))
>> do
>>          ./can_filter &
>>          sleep 0.1
>> done
>>
>> ==============================================================
>> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
>> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
>> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
>> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
>> [<00000000fd468496>] do_syscall_64+0x33/0x40
>> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>>
>> It's a bug in the concurrent scenario of unregister_netdevice_many()
>> and raw_release() as following:
>>
>>               cpu0                                        cpu1
>> unregister_netdevice_many(can_dev)
>>    unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
>>    net_set_todo(can_dev)
>>                         raw_release(can_socket)
>>                           dev = dev_get_by_index(, ro->ifindex); // dev == NULL
>>                           if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
>>                             raw_disable_allfilters(, dev, );
>>                             dev_put(dev);
>>                           }
>>                         ...
>>                         ro->bound = 0;
>>                         ...
>>
>> call_netdevice_notifiers(NETDEV_UNREGISTER, )
>>    raw_notify(, NETDEV_UNREGISTER, )
>>      if (ro->bound) // invalid because ro->bound has been set 0
>>        raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed
>>
>> Add a net_device pointer member in struct raw_sock to record bound can_dev,
>> and use rtnl_lock to serialize raw_socket members between raw_bind(), raw_release(),
>> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to free receivers in
>> dev_rcv_lists.
>>
>> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice notifier")
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> ---
>> v2:
>>    - Fix the case for a bound socket for "all" CAN interfaces (ifindex == 0) in raw_bind().
>> ---
>>   net/can/raw.c | 61 ++++++++++++++++++++++-----------------------------
>>   1 file changed, 26 insertions(+), 35 deletions(-)
>>
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index 15c79b079184..7078821f35e0 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -84,6 +84,7 @@ struct raw_sock {
>>       struct sock sk;
>>       int bound;
>>       int ifindex;
>> +    struct net_device *dev;
>>       struct list_head notifier;
>>       int loopback;
>>       int recv_own_msgs;
>> @@ -277,7 +278,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>>       if (!net_eq(dev_net(dev), sock_net(sk)))
>>           return;
>>   -    if (ro->ifindex != dev->ifindex)
>> +    if (ro->dev != dev)
>>           return;
>>         switch (msg) {
>> @@ -292,6 +293,7 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>>             ro->ifindex = 0;
>>           ro->bound = 0;
>> +        ro->dev = NULL;
>>           ro->count = 0;
>>           release_sock(sk);
>>   @@ -337,6 +339,7 @@ static int raw_init(struct sock *sk)
>>         ro->bound            = 0;
>>       ro->ifindex          = 0;
>> +    ro->dev              = NULL;
>>         /* set default filter to single entry dfilter */
>>       ro->dfilter.can_id   = 0;
>> @@ -385,19 +388,13 @@ static int raw_release(struct socket *sock)
>>         lock_sock(sk);
>>   +    rtnl_lock();
>>       /* remove current filters & unregister */
>>       if (ro->bound) {
>> -        if (ro->ifindex) {
>> -            struct net_device *dev;
>> -
>> -            dev = dev_get_by_index(sock_net(sk), ro->ifindex);
>> -            if (dev) {
>> -                raw_disable_allfilters(dev_net(dev), dev, sk);
>> -                dev_put(dev);
>> -            }
>> -        } else {
>> +        if (ro->dev)
>> +            raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
>> +        else
>>               raw_disable_allfilters(sock_net(sk), NULL, sk);
>> -        }
>>       }
>>         if (ro->count > 1)
>> @@ -405,8 +402,10 @@ static int raw_release(struct socket *sock)
>>         ro->ifindex = 0;
>>       ro->bound = 0;
>> +    ro->dev = NULL;
>>       ro->count = 0;
>>       free_percpu(ro->uniq);
>> +    rtnl_unlock();
>>         sock_orphan(sk);
>>       sock->sk = NULL;
>> @@ -422,6 +421,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>       struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
>>       struct sock *sk = sock->sk;
>>       struct raw_sock *ro = raw_sk(sk);
>> +    struct net_device *dev = NULL;
>>       int ifindex;
>>       int err = 0;
>>       int notify_enetdown = 0;
>> @@ -431,14 +431,13 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>       if (addr->can_family != AF_CAN)
>>           return -EINVAL;
>>   +    rtnl_lock();
>>       lock_sock(sk);
>>         if (ro->bound && addr->can_ifindex == ro->ifindex)
>>           goto out;
>>         if (addr->can_ifindex) {
>> -        struct net_device *dev;
>> -
>>           dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
>>           if (!dev) {
>>               err = -ENODEV;
>> @@ -465,28 +464,23 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>>       }
>>         if (!err) {
>> +        /* unregister old filters */
>>           if (ro->bound) {
>> -            /* unregister old filters */
> 
> Please move this comment back as we only unregister old filters when the socket is bound.
> 
>> -            if (ro->ifindex) {
>> -                struct net_device *dev;
>> -
>> -                dev = dev_get_by_index(sock_net(sk),
>> -                               ro->ifindex);
>> -                if (dev) {
>> -                    raw_disable_allfilters(dev_net(dev),
>> -                                   dev, sk);
>> -                    dev_put(dev);
>> -                }
>> -            } else {
>> +            if (ro->dev)
>> +                raw_disable_allfilters(dev_net(ro->dev),
>> +                               ro->dev, sk);
>> +            else
>>                   raw_disable_allfilters(sock_net(sk), NULL, sk);
>> -            }
>>           }
>>           ro->ifindex = ifindex;
>> +
> 
> Why did you add an additional empty line here?
> Please remove.
> 
>>           ro->bound = 1;
>> +        ro->dev = dev;
>>       }
>>      out:
>>       release_sock(sk);
>> +    rtnl_unlock();
>>         if (notify_enetdown) {
>>           sk->sk_err = ENETDOWN;
>> @@ -553,9 +547,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>           rtnl_lock();
>>           lock_sock(sk);
>>   -        if (ro->bound && ro->ifindex) {
>> -            dev = dev_get_by_index(sock_net(sk), ro->ifindex);
>> -            if (!dev) {
>> +        dev = ro->dev;
>> +        if (ro->bound && dev) {
>> +            if (dev->reg_state != NETREG_REGISTERED) {
>>                   if (count > 1)
>>                       kfree(filter);
>>                   err = -ENODEV;
>> @@ -596,7 +590,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>           ro->count  = count;
>>      out_fil:
>> -        dev_put(dev);
>>           release_sock(sk);
>>           rtnl_unlock();
>>   @@ -614,9 +607,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>           rtnl_lock();
>>           lock_sock(sk);
>>   -        if (ro->bound && ro->ifindex) {
>> -            dev = dev_get_by_index(sock_net(sk), ro->ifindex);
>> -            if (!dev) {
>> +        dev = ro->dev;
>> +        if (ro->bound && dev) {
>> +            if (dev->reg_state != NETREG_REGISTERED) {
>>                   err = -ENODEV;
>>                   goto out_err;
>>               }
>> @@ -627,7 +620,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>               /* (try to) register the new err_mask */
>>               err = raw_enable_errfilter(sock_net(sk), dev, sk,
>>                              err_mask);
>> -
> 
> And here you removed an empty line?
> 
> Please omit such mix of fixing a bug and change the coding style.
> 
>>               if (err)
>>                   goto out_err;
>>   @@ -640,7 +632,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>           ro->err_mask = err_mask;
>>      out_err:
>> -        dev_put(dev);
>>           release_sock(sk);
>>           rtnl_unlock();
>>   
> 
> The rest looks fine now, many thanks!
> It also reduces the code size.
> 
> When you send the v3 you can add these tags:
> 
> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
OK, Thank you for your comments.

> Best regards,
> Oliver
> 
> .

