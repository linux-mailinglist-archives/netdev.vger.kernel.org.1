Return-Path: <netdev+bounces-99342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CF8D4904
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A11C21434
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DC915ADBE;
	Thu, 30 May 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I4eKtr1M"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCC155335
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063066; cv=none; b=tginossar/qWHowxWmuFbM2b634cCRBxMAFFVJCTvZV7j6SVTMEop7EvJc+S0+c6pG/LyeL1GoRoK+dx2Fl2L57Lu6Ef/62f16JGs5i8VTbGJlDCRz0IToRBpxDi8BlEDbm/ScXpmWJ/029MHu1gLXrynWC0zDbOAzHzORYmXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063066; c=relaxed/simple;
	bh=5eB/L7hkmtLXKZDKTo5GXqhn2Ueo+rHcGZT8s+I0fEo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qOV9o+rGOYkgMMenv6nnwDgbcDlmJwm4sIOThM3gXNA13pgM3DQKHpsB5acNCUq4WLi4MogHXVpd1PDhO//pX7RhlmTbbcDjnpfcDkm0ZECwlVZTmmIHwLQldzKgfLh/60NNCEtLzruwgpBqOQNSGDVbAGT+IAQWG3sXZ4C30bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I4eKtr1M; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717063061; h=Message-ID:Subject:Date:From:To;
	bh=HuM/wA4hvKxfW5Mf4GN3euKVd03+xrTW5J497YHW3wU=;
	b=I4eKtr1Mws72brU1KxANGdcelFV7MKkyCF6nKpmoJ1Q+t3TTaRhADCv4zDmbzGr6qTIi/uOCloljFM3mabKaqPmxcyxXEWCoZRo31+sfxJa/qzSitVDHly2pYYWz22PDdrvgxTfs2libUwgXHk294D2XPGdv0fY12y062YtV5k0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W7WbvrE_1717063060;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7WbvrE_1717063060)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 17:57:40 +0800
Message-ID: <1717063051.9626064-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v3 2/2] virtio_net: fix a spurious deadlock issue
Date: Thu, 30 May 2024 17:57:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Jurgens <danielj@nvidia.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-3-hengqi@linux.alibaba.com>
In-Reply-To: <20240528134116.117426-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 28 May 2024 21:41:16 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> When the following snippet is run, lockdep will report a deadlock[1].
>
>   /* Acquire all queues dim_locks */
>   for (i = 0; i < vi->max_queue_pairs; i++)
>           mutex_lock(&vi->rq[i].dim_lock);
>
> There's no deadlock here because the vq locks are always taken
> in the same order, but lockdep can not figure it out. So refactoring
> the code to alleviate the problem.
>
> [1]
> ========================================================
> WARNING: possible recursive locking detected
> 6.9.0-rc7+ #319 Not tainted
> --------------------------------------------
> ethtool/962 is trying to acquire lock:
>
> but task is already holding lock:
>
> other info that might help us debug this:
> Possible unsafe locking scenario:
>
>       CPU0
>       ----
>  lock(&vi->rq[i].dim_lock);
>  lock(&vi->rq[i].dim_lock);
>
> *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 3 locks held by ethtool/962:
>  #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
>  #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
> 				ethnl_default_set_doit+0xbe/0x1e0
>
> stack backtrace:
> CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x79/0xb0
>  check_deadlock+0x130/0x220
>  __lock_acquire+0x861/0x990
>  lock_acquire.part.0+0x72/0x1d0
>  ? lock_acquire+0xf8/0x130
>  __mutex_lock+0x71/0xd50
>  virtnet_set_coalesce+0x151/0x190
>  __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
>  ethnl_set_coalesce+0x34/0x90
>  ethnl_default_set_doit+0xdd/0x1e0
>  genl_family_rcv_msg_doit+0xdc/0x130
>  genl_family_rcv_msg+0x154/0x230
>  ? __pfx_ethnl_default_set_doit+0x10/0x10
>  genl_rcv_msg+0x4b/0xa0
>  ? __pfx_genl_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x5a/0x110
>  genl_rcv+0x28/0x40
>  netlink_unicast+0x1af/0x280
>  netlink_sendmsg+0x20e/0x460
>  __sys_sendto+0x1fe/0x210
>  ? find_held_lock+0x2b/0x80
>  ? do_user_addr_fault+0x3a2/0x8a0
>  ? __lock_release+0x5e/0x160
>  ? do_user_addr_fault+0x3a2/0x8a0
>  ? lock_release+0x72/0x140
>  ? do_user_addr_fault+0x3a7/0x8a0
>  __x64_sys_sendto+0x29/0x30
>  do_syscall_64+0x78/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/net/virtio_net.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4f828a9e5889..ecb5203d0372 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4257,7 +4257,6 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
>  	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
>  	struct scatterlist sgs_rx;
> -	int ret = 0;
>  	int i;
>
>  	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> @@ -4267,27 +4266,27 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
>  		return -EINVAL;
>
> -	/* Acquire all queues dim_locks */
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		mutex_lock(&vi->rq[i].dim_lock);
> -
>  	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
>  		vi->rx_dim_enabled = true;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			mutex_lock(&vi->rq[i].dim_lock);
>  			vi->rq[i].dim_enabled = true;
> -		goto unlock;
> +			mutex_unlock(&vi->rq[i].dim_lock);
> +		}
> +		return 0;
>  	}
>
>  	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
> -	if (!coal_rx) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> +	if (!coal_rx)
> +		return -ENOMEM;
>
>  	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
>  		vi->rx_dim_enabled = false;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			mutex_lock(&vi->rq[i].dim_lock);
>  			vi->rq[i].dim_enabled = false;
> +			mutex_unlock(&vi->rq[i].dim_lock);
> +		}
>  	}
>
>  	/* Since the per-queue coalescing params can be set,
> @@ -4300,22 +4299,19 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> -				  &sgs_rx)) {
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
> +				  &sgs_rx))
> +		return -EINVAL;
>
>  	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
>  	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		mutex_lock(&vi->rq[i].dim_lock);
>  		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
>  		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> -	}
> -unlock:
> -	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
>  		mutex_unlock(&vi->rq[i].dim_lock);
> +	}
>
> -	return ret;
> +	return 0;
>  }
>
>  static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
> --
> 2.32.0.3.g01195cf9f
>

