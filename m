Return-Path: <netdev+bounces-15940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1731C74A8B3
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 03:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDEB1C20E7D
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 01:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA239110F;
	Fri,  7 Jul 2023 01:59:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA17F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 01:59:05 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18E19B7;
	Thu,  6 Jul 2023 18:59:03 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QxxQ04PLtzqVf0;
	Fri,  7 Jul 2023 09:58:32 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 09:59:00 +0800
Subject: Re: [PATCH net] can: raw: fix receiver memory leak
To: Oliver Hartkopp <socketcan@hartkopp.net>, <mkl@pengutronix.de>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<penguin-kernel@I-love.SAKURA.ne.jp>
References: <20230705092543.648022-1-william.xuanziyang@huawei.com>
 <2aa65b0c-2170-46c0-57a4-17b653e41f96@hartkopp.net>
 <4880eff5-1009-add8-8c58-ac31ab6771db@huawei.com>
 <2a035aab-d10a-bb6f-d056-ea93c454a51d@hartkopp.net>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <18374b78-dd42-c096-85bf-d7dd2e9c5fe8@huawei.com>
Date: Fri, 7 Jul 2023 09:59:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2a035aab-d10a-bb6f-d056-ea93c454a51d@hartkopp.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On 06.07.23 14:48, Ziyang Xuan (William) wrote:
> 
> (..)
> 
>>>>        }
>>>>       out:
>>>>        release_sock(sk);
>>>> +    rtnl_unlock();
>>>
>>> Would it also fix the issue when just adding the rtnl_locks to raw_bind() and raw_release() as suggested by you?
>>
>> This patch just add rtnl_lock in raw_bind() and raw_release(). raw_setsockopt() has rtnl_lock before this. raw_notify()
>> is under rtnl_lock. My patch has been tested and solved the issue before send. I don't know if it answered your doubts.
> 
> My question was whether adding rtnl_locks to raw_bind() and raw_release() would be enough to fix the issue.
> 
> Without introducing the additional ro->dev element!?

Understand. Just add rtnl_lock to raw_bind() and raw_release() can not fix the issue. I tested.

We should understand that unregister a net device is divided into two stages generally.
Fistly, call unregister_netdevice_many() to remove net_dev from device list and add
net_dev to net_todo_list. Secondly, free net_dev in netdev_run_todo().

In my issue. Firstly, unregister_netdevice_many() removed can_dev from device
list and added can_dev to net_todo_list. Then got NULL by dev_get_by_index()
and receivers in dev_rcv_lists would not be freed in raw_release().
After raw_release(), ro->bound would be set 0. When NETDEV_UNREGISTER event
arrived raw_notify(), receivers in dev_rcv_lists would not be freed too
because ro->bound was already 0. Thus receivers in dev_rcv_lists would be leaked.

             cpu0                                        cpu1
unregister_netdevice_many(can_dev)
  unlist_netdevice(can_dev) // dev_get_by_index() return NULL after this
  net_set_todo(can_dev)
						raw_release(can_socket)
						  dev = dev_get_by_index(, ro->ifindex); // dev == NULL
						  if (dev) { // receivers in dev_rcv_lists not free because dev is NULL
						    raw_disable_allfilters(, dev, );
						    dev_put(dev);
						  }
						...
						ro->bound = 0;
						...

netdev_wait_allrefs_any()
  call_netdevice_notifiers(NETDEV_UNREGISTER, )
    raw_notify(, NETDEV_UNREGISTER, )
      if (ro->bound) // invalid because ro->bound has been set 0
        raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists will never be freed


Thanks,
William Xuan

> 
> Best regards,
> Oliver
> .

