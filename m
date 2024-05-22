Return-Path: <netdev+bounces-97511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F2C8CBCBD
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF796B219B1
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94267E0F6;
	Wed, 22 May 2024 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RUevMas/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0F77F30
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365751; cv=none; b=e7pJ8FLtUoITePPbB4QT9N2mRuJJ/6HN1NumHz+ayCU7J7k8dmw7pXxVCZxWygQQY2n5QN/W6E6wCqSqjxcZcelbrAKaU60hEPOgrv6EdHh9X2u9eyJCa4C8151rF1emNHaS5KvFu7kBoVlj/+nFZE7DDpDdYv+5x63YWuBMMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365751; c=relaxed/simple;
	bh=wLKk7Vqlj6B58mPDQFHEZTGCHQI1AwWd1MZqpYQ4Ut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGX8gCC3A6FFrAh5pvBdIV+BFTA/CBl6v8nJzvH5Dy/QHXYuzwKK0BN2FIuaY9bdCCI3KRHBTMqbWynayseKj5QGWt9YpO3IOan1B7zAtILEuyTa5jYMAHVrOdqIRYImprTR566madQg8v/c9WlVtavBhm2iJxKsCidxgW1F4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RUevMas/; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so11017440a12.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716365748; x=1716970548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MhPNRcnuyP7BkD8fC61aKpxOVUnapMjMRFkNKjZ+XU=;
        b=RUevMas/jNorUjqDdcFAbeM8tk+17HiXntHFEH1Vq0w0VMD9jlIXyRGbp54aI8uu2n
         6/hshxKjH5S9/RO015Z/VaPlFPJBEyBtMzn8A57gjG65lBItYGeey3cL4y/kNv/qCSG2
         OiLo62Yge1fhSeGgYbXrqgeulAjXoNaOo3jEtSb5xP0ifcnv137Yf+oO1RVjRkD9JjPp
         in/3kyeK1w58LSRpwpq3VAytjVpvD4qlVEC2tJMLjIUYvnBLm58cUcw5kFIGKYhg9gRK
         GhrGBXmGbX9nusSQqOsbHjw8SFr//rNgG0EcNgKkq1H+e2MizIXyK1W6fDtA6Yg5c0l7
         yAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365748; x=1716970548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MhPNRcnuyP7BkD8fC61aKpxOVUnapMjMRFkNKjZ+XU=;
        b=C+6Ssu96inPtH12gQs7eenHfu01AqHyZRFCbBU0ZYbfJfacOy2ZQCIK4xX4PTbSpL0
         QbFw3/zZsAPyFgZFwmioMuYX0Tr6a1rwvY35eQDlgGDyfP4c7Ykva3ewjQChyoxXp82o
         wAsWUBnHs+TDQRgBCnB6oM4TaRqJvkPLzSGFbp7bsiw2iLx9JhfXHgWk8EA0BsMfqCZw
         iHRoZN5W79rmpDKoAb2W0f+gNX3ApUAfNg4vnDVLg8z/gGg+iVbJw/tX9J/tqlbjiIUw
         ml81HzFGVgD3e5VxJrfI/6dEk+CcW44Ohq2K5Sgz3MmN3Eid9wGNWISRes66ejBXRj4K
         TTXg==
X-Gm-Message-State: AOJu0YwGF2Wl4NFVc+ZYnA9pVVUjzze4uSX0rPDpMkN8qN4QWeAvA9Og
	5drA4K8LrJN+G+HfGlTZolsY3QA6yY53gX5BNt8o5lTyLFPhtDLPvc+luUH05h8=
X-Google-Smtp-Source: AGHT+IFgjUs3XYXnJ5gpRUo7z32zTzlS8onNa4URoJ9xhLqosNIblJ/8IieAwPMrjeeg4nqbXKq1Uw==
X-Received: by 2002:a17:907:1749:b0:a61:c730:ac57 with SMTP id a640c23a62f3a-a622818fb09mr89506366b.74.1716365748367;
        Wed, 22 May 2024 01:15:48 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1792228csm1749728566b.92.2024.05.22.01.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:15:47 -0700 (PDT)
Date: Wed, 22 May 2024 10:15:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 2/2] Revert "virtio_net: Add a lock for per queue RX
 coalesce"
Message-ID: <Zk2pskOYxnSdNf-O@nanopsycho.orion>
References: <20240522034548.58131-1-hengqi@linux.alibaba.com>
 <20240522034548.58131-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522034548.58131-3-hengqi@linux.alibaba.com>

Wed, May 22, 2024 at 05:45:48AM CEST, hengqi@linux.alibaba.com wrote:
>This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.

This commit does not exist in -net or -net-next.

>
>When the following snippet is run, lockdep will complain[1].
>
>  /* Acquire all queues dim_locks */
>  for (i = 0; i < vi->max_queue_pairs; i++)
>	  mutex_lock(&vi->rq[i].dim_lock);
>
>At the same time, too many queues will cause lockdep to be more irritable,
>which can be alleviated by using mutex_lock_nested(), however, there are
>still new warning when the number of queues exceeds MAX_LOCKDEP_SUBCLASSES.
>So I would like to gently revert this commit, although it brings
>unsynchronization that is not so concerned:
>  1. When dim is enabled, rx_dim_work may modify the coalescing parameters.
>     Users may read dirty coalescing parameters if querying.
>  2. When dim is switched from enabled to disabled, a spurious dim worker
>     maybe scheduled, but this can be handled correctly by rx_dim_work.
>
>[1]
>========================================================
>WARNING: possible recursive locking detected
>6.9.0-rc7+ #319 Not tainted
>--------------------------------------------
>ethtool/962 is trying to acquire lock:
>
>but task is already holding lock:
>
>other info that might help us debug this:
>Possible unsafe locking scenario:
>
>      CPU0
>      ----
> lock(&vi->rq[i].dim_lock);
> lock(&vi->rq[i].dim_lock);
>
>*** DEADLOCK ***
>
> May be due to missing lock nesting notation
>
>3 locks held by ethtool/962:
> #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
>				ethnl_default_set_doit+0xbe/0x1e0
>
>stack backtrace:
>CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>Call Trace:
> <TASK>
> dump_stack_lvl+0x79/0xb0
> check_deadlock+0x130/0x220
> __lock_acquire+0x861/0x990
> lock_acquire.part.0+0x72/0x1d0
> ? lock_acquire+0xf8/0x130
> __mutex_lock+0x71/0xd50
> virtnet_set_coalesce+0x151/0x190
> __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
> ethnl_set_coalesce+0x34/0x90
> ethnl_default_set_doit+0xdd/0x1e0
> genl_family_rcv_msg_doit+0xdc/0x130
> genl_family_rcv_msg+0x154/0x230
> ? __pfx_ethnl_default_set_doit+0x10/0x10
> genl_rcv_msg+0x4b/0xa0
> ? __pfx_genl_rcv_msg+0x10/0x10
> netlink_rcv_skb+0x5a/0x110
> genl_rcv+0x28/0x40
> netlink_unicast+0x1af/0x280
> netlink_sendmsg+0x20e/0x460
> __sys_sendto+0x1fe/0x210
> ? find_held_lock+0x2b/0x80
> ? do_user_addr_fault+0x3a2/0x8a0
> ? __lock_release+0x5e/0x160
> ? do_user_addr_fault+0x3a2/0x8a0
> ? lock_release+0x72/0x140
> ? do_user_addr_fault+0x3a7/0x8a0
> __x64_sys_sendto+0x29/0x30
> do_syscall_64+0x78/0x180
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Fixes tag missing.


>---
> drivers/net/virtio_net.c | 53 +++++++++-------------------------------
> 1 file changed, 12 insertions(+), 41 deletions(-)
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 1cad06cef230..e4a1dff2a64a 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -316,9 +316,6 @@ struct receive_queue {
> 	/* Is dynamic interrupt moderation enabled? */
> 	bool dim_enabled;
> 
>-	/* Used to protect dim_enabled and inter_coal */
>-	struct mutex dim_lock;
>-
> 	/* Dynamic Interrupt Moderation */
> 	struct dim dim;
> 
>@@ -2368,10 +2365,6 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> 	/* Out of packets? */
> 	if (received < budget) {
> 		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>-		/* Intentionally not taking dim_lock here. This may result in a
>-		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
>-		 * will not act on the scheduled work.
>-		 */
> 		if (napi_complete && rq->dim_enabled)
> 			virtnet_rx_dim_update(vi, rq);
> 	}
>@@ -3247,11 +3240,9 @@ static int virtnet_set_ringparam(struct net_device *dev,
> 				return err;
> 
> 			/* The reason is same as the transmit virtqueue reset */
>-			mutex_lock(&vi->rq[i].dim_lock);
> 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> 							       vi->intr_coal_rx.max_usecs,
> 							       vi->intr_coal_rx.max_packets);
>-			mutex_unlock(&vi->rq[i].dim_lock);
> 			if (err)
> 				return err;
> 		}
>@@ -4257,7 +4248,6 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> 	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
> 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
> 	struct scatterlist sgs_rx;
>-	int ret = 0;
> 	int i;
> 
> 	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>@@ -4267,22 +4257,16 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> 			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
> 		return -EINVAL;
> 
>-	/* Acquire all queues dim_locks */
>-	for (i = 0; i < vi->max_queue_pairs; i++)
>-		mutex_lock(&vi->rq[i].dim_lock);
>-
> 	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
> 		vi->rx_dim_enabled = true;
> 		for (i = 0; i < vi->max_queue_pairs; i++)
> 			vi->rq[i].dim_enabled = true;
>-		goto unlock;
>+		return 0;
> 	}
> 
> 	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
>-	if (!coal_rx) {
>-		ret = -ENOMEM;
>-		goto unlock;
>-	}
>+	if (!coal_rx)
>+		return -ENOMEM;
> 
> 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
> 		vi->rx_dim_enabled = false;
>@@ -4300,10 +4284,8 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> 
> 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
>-				  &sgs_rx)) {
>-		ret = -EINVAL;
>-		goto unlock;
>-	}
>+				  &sgs_rx))
>+		return -EINVAL;
> 
> 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
> 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
>@@ -4311,11 +4293,8 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> 		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
> 		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> 	}
>-unlock:
>-	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
>-		mutex_unlock(&vi->rq[i].dim_lock);
> 
>-	return ret;
>+	return 0;
> }
> 
> static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>@@ -4339,24 +4318,19 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
> 					     u16 queue)
> {
> 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
>+	bool cur_rx_dim = vi->rq[queue].dim_enabled;
> 	u32 max_usecs, max_packets;
>-	bool cur_rx_dim;
> 	int err;
> 
>-	mutex_lock(&vi->rq[queue].dim_lock);
>-	cur_rx_dim = vi->rq[queue].dim_enabled;
> 	max_usecs = vi->rq[queue].intr_coal.max_usecs;
> 	max_packets = vi->rq[queue].intr_coal.max_packets;
> 
> 	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
>-			       ec->rx_max_coalesced_frames != max_packets)) {
>-		mutex_unlock(&vi->rq[queue].dim_lock);
>+			       ec->rx_max_coalesced_frames != max_packets))
> 		return -EINVAL;
>-	}
> 
> 	if (rx_ctrl_dim_on && !cur_rx_dim) {
> 		vi->rq[queue].dim_enabled = true;
>-		mutex_unlock(&vi->rq[queue].dim_lock);
> 		return 0;
> 	}
> 
>@@ -4369,8 +4343,10 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
> 	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
> 					       ec->rx_coalesce_usecs,
> 					       ec->rx_max_coalesced_frames);
>-	mutex_unlock(&vi->rq[queue].dim_lock);
>-	return err;
>+	if (err)
>+		return err;
>+
>+	return 0;
> }
> 
> static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>@@ -4404,7 +4380,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
> 
> 	qnum = rq - vi->rq;
> 
>-	mutex_lock(&rq->dim_lock);
> 	if (!rq->dim_enabled)
> 		goto out;
> 
>@@ -4420,7 +4395,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
> 	}
> out:
> 	dim->state = DIM_START_MEASURE;
>-	mutex_unlock(&rq->dim_lock);
> }
> 
> static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>@@ -4558,13 +4532,11 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
> 		return -EINVAL;
> 
> 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
>-		mutex_lock(&vi->rq[queue].dim_lock);
> 		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
> 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
> 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
> 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
> 		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
>-		mutex_unlock(&vi->rq[queue].dim_lock);
> 	} else {
> 		ec->rx_max_coalesced_frames = 1;
> 
>@@ -5396,7 +5368,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
> 
> 		u64_stats_init(&vi->rq[i].stats.syncp);
> 		u64_stats_init(&vi->sq[i].stats.syncp);
>-		mutex_init(&vi->rq[i].dim_lock);
> 	}
> 
> 	return 0;
>-- 
>2.32.0.3.g01195cf9f
>
>

