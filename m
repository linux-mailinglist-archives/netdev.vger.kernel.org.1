Return-Path: <netdev+bounces-186284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F8A9DEC8
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 05:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6665C463B13
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 03:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD81DE3A8;
	Sun, 27 Apr 2025 03:07:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB937A930;
	Sun, 27 Apr 2025 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745723222; cv=none; b=dAcViOB9ywefzHKjIs05HqTX6vN3pPN0dYz3I6MKxwMJ8aSmLFNs3Is1sruDX0SCevc46TrehddNL3GpilVZlxPjjMQnY5vjIzNEqQuMQw5LQtRb2DyIVL9+1O2hR7OELVIB63ZNAYqB0pVje/aN4vFjYmfuwXTot3jf4e6G7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745723222; c=relaxed/simple;
	bh=rEICvCV1FekVGkUaonF/ktjdSyKg+00nNCVgOU7bKG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hW5ctdc/WgmoUDGF6dKLCN4A1Ww0VQGjUOUT3R7hm+TjpFEFOoLLwU4G4u3DJ8OUE3hMFcYWhHCTsecd3oTKtPEGNJig/mhJblErpGyduFOXt6kFGUf7exNQnGAuqFiCNRLD4yLo6f5Z6aqBn8vuKmKLcAJBDRxQrAJI/jgLM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZlWc43QQ9z8xCc;
	Sun, 27 Apr 2025 11:03:16 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 41ED41800B2;
	Sun, 27 Apr 2025 11:06:41 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 kwepemg200005.china.huawei.com (7.202.181.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 27 Apr 2025 11:06:40 +0800
Message-ID: <11fb538b-0007-4fe7-96b2-6ddb255b496e@huawei.com>
Date: Sun, 27 Apr 2025 11:06:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bonding: hold ops lock around get_link
To: Stanislav Fomichev <sdf@fomichev.me>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jv@jvosburgh.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
	<syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com>
References: <20250410161117.3519250-1-sdf@fomichev.me>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250410161117.3519250-1-sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200005.china.huawei.com (7.202.181.32)


在 2025/4/11 0:11, Stanislav Fomichev 写道:
> syzbot reports a case of ethtool_ops->get_link being called without
> ops lock:
>
>   ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:63
>   bond_check_dev_link+0x1fb/0x4b0 drivers/net/bonding/bond_main.c:864
>   bond_miimon_inspect drivers/net/bonding/bond_main.c:2734 [inline]
>   bond_mii_monitor+0x49d/0x3170 drivers/net/bonding/bond_main.c:2956
>   process_one_work kernel/workqueue.c:3238 [inline]
>   process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
>   worker_thread+0x870/0xd50 kernel/workqueue.c:3400
>   kthread+0x7b7/0x940 kernel/kthread.c:464
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> Commit 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> changed to lockless __linkwatch_sync_dev in ethtool_op_get_link.
> All paths except bonding are coming via locked ioctl. Add necessary
> locking to bonding.
>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
> Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
> v2:
> - move 'BMSR_LSTATUS : 0' part out (Jakub)
> ---
>   drivers/net/bonding/bond_main.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 950d8e4d86f8..8ea183da8d53 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -850,8 +850,9 @@ static int bond_check_dev_link(struct bonding *bond,
>   			       struct net_device *slave_dev, int reporting)
>   {
>   	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
> -	struct ifreq ifr;
>   	struct mii_ioctl_data *mii;
> +	struct ifreq ifr;
> +	int ret;
>   
>   	if (!reporting && !netif_running(slave_dev))
>   		return 0;
> @@ -860,9 +861,13 @@ static int bond_check_dev_link(struct bonding *bond,
>   		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
>   
>   	/* Try to get link status using Ethtool first. */
> -	if (slave_dev->ethtool_ops->get_link)
> -		return slave_dev->ethtool_ops->get_link(slave_dev) ?
> -			BMSR_LSTATUS : 0;
> +	if (slave_dev->ethtool_ops->get_link) {
> +		netdev_lock_ops(slave_dev);
> +		ret = slave_dev->ethtool_ops->get_link(slave_dev);
> +		netdev_unlock_ops(slave_dev);
> +
> +		return ret ? BMSR_LSTATUS : 0;
> +	}
>   
>   	/* Ethtool can't be used, fallback to MII ioctls. */
>   	if (slave_ops->ndo_eth_ioctl) {


Hello, I find that a WARNING still exists:

   RTNL: assertion failed at ./include/net/netdev_lock.h (56)
   WARNING: CPU: 1 PID: 3020 at ./include/net/netdev_lock.h:56 
netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]
   WARNING: CPU: 1 PID: 3020 at ./include/net/netdev_lock.h:56 
__linkwatch_sync_dev+0x30d/0x360 net/core/link_watch.c:279
   Modules linked in:
   CPU: 1 UID: 0 PID: 3020 Comm: kworker/u8:10 Not tainted 
6.15.0-rc2-syzkaller-00257-gb5c6891b2c5b #0 PREEMPT(full)
   Hardware name: Google Compute Engine, BIOS Google 02/12/2025
   Workqueue: bond0 bond_mii_monitor
   RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]

It is report by syzbot (link: 
https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086).

Because ASSERT_RTNL() failed in netdev_ops_assert_locked().

I wonder if should add rtnl lock in bond_check_dev_link()?

Like this:

   +++ b/drivers/net/bonding/bond_main.c
   @@ -862,10 +862,12 @@  static int bond_check_dev_link(struct bonding 
*bond,

        /* Try to get link status using Ethtool first. */
        if (slave_dev->ethtool_ops->get_link) {
   -        netdev_lock_ops(slave_dev);
   -        ret = slave_dev->ethtool_ops->get_link(slave_dev);
   -        netdev_unlock_ops(slave_dev);
   -
   +        if (rtnl_trylock()) {
   +            netdev_lock_ops(slave_dev);
   +            ret = slave_dev->ethtool_ops->get_link(slave_dev);
   +            netdev_unlock_ops(slave_dev);
   +            rtnl_unlock();
   +        }
            return ret ? BMSR_LSTATUS : 0;
        }


