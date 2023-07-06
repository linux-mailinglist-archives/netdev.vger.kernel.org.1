Return-Path: <netdev+bounces-15797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E15C749CF7
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E662812DF
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F48F76;
	Thu,  6 Jul 2023 13:06:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49298F57
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 13:06:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80F12A
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 06:06:52 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QxcCp49MjzMq9V;
	Thu,  6 Jul 2023 21:03:34 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 21:06:48 +0800
To: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<hannes@stressinduktion.org>, <fbl@redhat.com>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Subject: [Question] WARNING: refcount bug in addrconf_ifdown
Message-ID: <381c0507-ecba-f536-7c7d-c92cf454d4e0@huawei.com>
Date: Thu, 6 Jul 2023 21:06:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello all,

We got the following WARNING several times in our ci:

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 3 PID: 9 at lib/refcount.c:28 refcount_warn_saturate+0x210/0x330
...
Call trace:
 refcount_warn_saturate+0x210/0x330
 addrconf_ifdown.isra.0+0x1be8/0x1e10
 addrconf_notify+0xa8/0xcf0
 raw_notifier_call_chain+0x90/0x10c
 call_netdevice_notifiers_info+0x9c/0x15c
 unregister_netdevice_many+0x3e4/0x980
 default_device_exit_batch+0x24c/0x2a0
 ops_exit_list+0xcc/0xe4
 cleanup_net+0x2b8/0x550
 process_one_work+0x478/0xb54
 worker_thread+0x120/0x95c
 kthread+0x20c/0x25c
 ret_from_fork+0x10/0x18

The code where the problem occurred is as follows:

static int addrconf_ifdown(struct net_device *dev, bool unregister)
{
	...

	/* Last: Shot the device (if unregistered) */
	if (unregister) {
		addrconf_sysctl_unregister(idev);
		neigh_parms_release(&nd_tbl, idev->nd_parms);
		neigh_ifdown(&nd_tbl, dev);
		in6_dev_put(idev); // WARNING here for idev->refcnt
	}
	return 0;
}

Because we enabled KASAN, and no UAF issues reported on idev. So I thought
the last decrement of idev->refcnt must be by __in6_dev_put() which is just
decrement no memory free for idev. And idev was not be freed.

The functions that call __in6_dev_put() are addrconf_del_rs_timer(),
mld_gq_stop_timer(), mld_ifc_stop_timer(), mld_dad_stop_timer(). They
are all related to timer. I compared the mod_timer functions corresponding
to these functions. I found that addrconf_mod_rs_timer() is suspicious.
Analyse as below:

static void addrconf_mod_rs_timer(struct inet6_dev *idev,
				  unsigned long when)
{
	/* rs_timer is pending at time A, condition not established, no in6_dev_hold() */
	if (!timer_pending(&idev->rs_timer))
		in6_dev_hold(idev);
	
	/* rs_timer is not pending when do the following at time B.
	 * rs_timer callback addrconf_rs_timer() will be executed later,
	 * and in6_dev_put() will be executed in addrconf_rs_timer(),
	 * but this is wrong. idev->refcnt has been decreased more one.
	 */
	mod_timer(&idev->rs_timer, jiffies + when);
}

The following implementation for addrconf_mod_rs_timer() is more reasonable,
and avoid the above potential problem.

static void addrconf_mod_rs_timer(struct inet6_dev *idev,
				  unsigned long when)
{
	if (!mod_timer(&idev->rs_timer, jiffies + when))
		in6_dev_hold(idev);
}

Because the problem is low probability, and I could not reproduce until now.
I am not entirely sure that the problem is the cause of my analysis.

Do you think my analysis is reasonable? And do you have more ideas for the problem?

Welcome to give me feedback. Thank you for your help!

William Xuan.

