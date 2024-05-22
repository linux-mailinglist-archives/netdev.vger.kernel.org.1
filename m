Return-Path: <netdev+bounces-97524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549CF8CBE6A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 11:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7780B1C20E66
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70D8121F;
	Wed, 22 May 2024 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG+hJIYm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAA8120C
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371097; cv=none; b=psSiKJRpNjYmlFjXrswykCcEPp1kgruafcn9Cmrvro6OtlNsWFjJvqijvy00j7TaW6mBTqYRcSk/BSLqvR6x6o8DT/jKuIiMOG30aHzhhgMUgfNiGbWY37PfihS+HffHWQHZ5SAJeuLXM+2HDkedvFFbG8HhPljl8dNlhghHNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371097; c=relaxed/simple;
	bh=o3dSC4A/yrf77AbjfCmJEI/wVVifE3ERCuf5gFtqxtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntW7jKSAlzE3GIN/6E47B2GmghSeCY7Wih/uMPq6W1EAKKmKnS2DPhoVDZwtOAs++cn6wLVrzvrM6jugBHCCAiRcykSpQnxf9kf6yNQFm6FPtTfdxSUCrM1QXXPzshIKdsG0yVu3rQEB/ZMW7uUnvXH3pWON3prrYKaphpvUZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG+hJIYm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716371094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yUEqXemm8Tz2tuo9rCHkv5Ja9OYwFfnY+SBv7kt09Q=;
	b=SG+hJIYmh1IyWYNkx3uZTv3H6kObp4CK+mZnV0j34Zpd/E8y1wWeUstK1Kyz+FYSUjErGR
	6v1+MZhj8E8dL0rIjACPsSY2Ul/1CZ8GNZlCb1t3Xw5unbAD3qGIhFngv+14do1a0lvBeL
	6LpAexkfi/fiINb2aMraebkN1RrIG6c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ciaEhOETPzCE0HZET6OyqQ-1; Wed, 22 May 2024 05:44:52 -0400
X-MC-Unique: ciaEhOETPzCE0HZET6OyqQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-354c964f74aso1988887f8f.0
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 02:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716371091; x=1716975891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yUEqXemm8Tz2tuo9rCHkv5Ja9OYwFfnY+SBv7kt09Q=;
        b=EN8DiO7av+mj+vph1348u8sm2+1vvC3EHkCkbU8Ju+uUH9h1nT03IxAa2weZjKkO0i
         kHzJyazXM3Ogd4dIHSEBmnJW1j83HgHP8jwEtSAcb0mqKT9kxgNgOpz9ZUOxzrWxsdTt
         7rHUMOtJ/F5y/pwKalaOekgznZtVImUdM/DKDtdR/CGJhD5bP2i+7kc9HBD7hm2FqJoX
         yAYv8kYTD0F3ZtPM0S4zSvMdtwhAAYnOGxYoCvsT35PV0/qPkU3VbPmIZ0aZ9WN2CrR7
         Eun+0s3J8EklT0RGxwXy8lo3PMb1IBzUeBqdgiquDsSnnk2zc7Ej6lcV5TJc7ApTC1Qk
         2/pA==
X-Forwarded-Encrypted: i=1; AJvYcCURXhZAdtayAFgaRgRe2yUnPdklgawLta8HZBLp3Wn4D9Dl9ZuDJc3E05GEdBBsk9fnJjU/SrartjYW9znDYIMTylboUU8V
X-Gm-Message-State: AOJu0Yxf2J/AbilrTIlbpuEWcM4fnUfZUTRc2mdB7fFWtbGkwiuYFusY
	UC5R2ztXLIqeEF5Sm0AmtBoRGlkvGzhE+LkRla0Yvm6F+K51VLzWcNVv5/86LF43HDQTdBqW9zi
	Vjnu3Oq2Kl0m/WJVjruR4sJxlKj11CF904BScdVgB/PfBdBPxaNGUmQ==
X-Received: by 2002:adf:cd06:0:b0:354:f2b8:c75e with SMTP id ffacd0b85a97d-354f2b8c8b4mr29606f8f.33.1716371091309;
        Wed, 22 May 2024 02:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdsuZK1jrYhahu9SXghEtQU/tmeCjC2P1Te4wEPUhaeF2oPmsrhWX9n4bL0FdbKaYtjsPf7w==
X-Received: by 2002:adf:cd06:0:b0:354:f2b8:c75e with SMTP id ffacd0b85a97d-354f2b8c8b4mr29545f8f.33.1716371089644;
        Wed, 22 May 2024 02:44:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:e862:558a:a573:a176:1825])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfb9sm33719841f8f.68.2024.05.22.02.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:44:49 -0700 (PDT)
Date: Wed, 22 May 2024 05:44:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 2/2] Revert "virtio_net: Add a lock for per queue RX
 coalesce"
Message-ID: <20240522053046-mutt-send-email-mst@kernel.org>
References: <20240522034548.58131-1-hengqi@linux.alibaba.com>
 <20240522034548.58131-3-hengqi@linux.alibaba.com>
 <Zk2pskOYxnSdNf-O@nanopsycho.orion>
 <1716367939.5198305-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716367939.5198305-3-hengqi@linux.alibaba.com>

On Wed, May 22, 2024 at 04:52:19PM +0800, Heng Qi wrote:
> On Wed, 22 May 2024 10:15:46 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > Wed, May 22, 2024 at 05:45:48AM CEST, hengqi@linux.alibaba.com wrote:
> > >This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.
> > 
> > This commit does not exist in -net or -net-next.
> 
> It definitely exists in net-next :):
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44
> 
> > 
> > >
> > >When the following snippet is run, lockdep will complain[1].
> > >
> > >  /* Acquire all queues dim_locks */
> > >  for (i = 0; i < vi->max_queue_pairs; i++)
> > >	  mutex_lock(&vi->rq[i].dim_lock);
> > >
> > >At the same time, too many queues will cause lockdep to be more irritable,
> > >which can be alleviated by using mutex_lock_nested(), however, there are
> > >still new warning when the number of queues exceeds MAX_LOCKDEP_SUBCLASSES.
> > >So I would like to gently revert this commit, although it brings
> > >unsynchronization that is not so concerned:

It's really hard to read this explanation.

I think you mean is:

	When the following snippet is run, lockdep will report a deadlock[1].

	  /* Acquire all queues dim_locks */
	  for (i = 0; i < vi->max_queue_pairs; i++)
		  mutex_lock(&vi->rq[i].dim_lock);

	There's no deadlock here because the vq locks
	are always taken in the same order, but lockdep can not figure it
	out, and we can not make each lock a separate class because
	there can be more than MAX_LOCKDEP_SUBCLASSES of vqs.

	However, dropping the lock is harmless.



> > >  1. When dim is enabled, rx_dim_work may modify the coalescing parameters.
> > >     Users may read dirty coalescing parameters if querying.


... anyway?

> > >  2. When dim is switched from enabled to disabled, a spurious dim worker
> > >     maybe scheduled, but this can be handled correctly by rx_dim_work.

may be -> is?
How is this handled exactly?

> > >
> > >[1]
> > >========================================================
> > >WARNING: possible recursive locking detected
> > >6.9.0-rc7+ #319 Not tainted
> > >--------------------------------------------
> > >ethtool/962 is trying to acquire lock:
> > >
> > >but task is already holding lock:
> > >
> > >other info that might help us debug this:
> > >Possible unsafe locking scenario:
> > >
> > >      CPU0
> > >      ----
> > > lock(&vi->rq[i].dim_lock);
> > > lock(&vi->rq[i].dim_lock);
> > >
> > >*** DEADLOCK ***
> > >
> > > May be due to missing lock nesting notation
> > >
> > >3 locks held by ethtool/962:
> > > #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
> > > #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
> > >				ethnl_default_set_doit+0xbe/0x1e0
> > >
> > >stack backtrace:
> > >CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
> > >Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > >	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > >Call Trace:
> > > <TASK>
> > > dump_stack_lvl+0x79/0xb0
> > > check_deadlock+0x130/0x220
> > > __lock_acquire+0x861/0x990
> > > lock_acquire.part.0+0x72/0x1d0
> > > ? lock_acquire+0xf8/0x130
> > > __mutex_lock+0x71/0xd50
> > > virtnet_set_coalesce+0x151/0x190
> > > __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
> > > ethnl_set_coalesce+0x34/0x90
> > > ethnl_default_set_doit+0xdd/0x1e0
> > > genl_family_rcv_msg_doit+0xdc/0x130
> > > genl_family_rcv_msg+0x154/0x230
> > > ? __pfx_ethnl_default_set_doit+0x10/0x10
> > > genl_rcv_msg+0x4b/0xa0
> > > ? __pfx_genl_rcv_msg+0x10/0x10
> > > netlink_rcv_skb+0x5a/0x110
> > > genl_rcv+0x28/0x40
> > > netlink_unicast+0x1af/0x280
> > > netlink_sendmsg+0x20e/0x460
> > > __sys_sendto+0x1fe/0x210
> > > ? find_held_lock+0x2b/0x80
> > > ? do_user_addr_fault+0x3a2/0x8a0
> > > ? __lock_release+0x5e/0x160
> > > ? do_user_addr_fault+0x3a2/0x8a0
> > > ? lock_release+0x72/0x140
> > > ? do_user_addr_fault+0x3a7/0x8a0
> > > __x64_sys_sendto+0x29/0x30
> > > do_syscall_64+0x78/0x180
> > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > >Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > 
> > Fixes tag missing.
> 
> IIUC,
> 
>   "This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44."
> 
> has provided a traceback way, which is not fixing other patches,
> but fixing itself. So we do not need fixes tag.
> 
> Thanks.

Providing the subject of the reverted commit is helpful.
Adding:

Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")

is a standard way to do that.




> > 
> > 
> > >---
> > > drivers/net/virtio_net.c | 53 +++++++++-------------------------------
> > > 1 file changed, 12 insertions(+), 41 deletions(-)
> > >
> > >diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > >index 1cad06cef230..e4a1dff2a64a 100644
> > >--- a/drivers/net/virtio_net.c
> > >+++ b/drivers/net/virtio_net.c
> > >@@ -316,9 +316,6 @@ struct receive_queue {
> > > 	/* Is dynamic interrupt moderation enabled? */
> > > 	bool dim_enabled;
> > > 
> > >-	/* Used to protect dim_enabled and inter_coal */
> > >-	struct mutex dim_lock;
> > >-
> > > 	/* Dynamic Interrupt Moderation */
> > > 	struct dim dim;
> > > 
> > >@@ -2368,10 +2365,6 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> > > 	/* Out of packets? */
> > > 	if (received < budget) {
> > > 		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
> > >-		/* Intentionally not taking dim_lock here. This may result in a
> > >-		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
> > >-		 * will not act on the scheduled work.
> > >-		 */
> > > 		if (napi_complete && rq->dim_enabled)
> > > 			virtnet_rx_dim_update(vi, rq);
> > > 	}
> > >@@ -3247,11 +3240,9 @@ static int virtnet_set_ringparam(struct net_device *dev,
> > > 				return err;
> > > 
> > > 			/* The reason is same as the transmit virtqueue reset */
> > >-			mutex_lock(&vi->rq[i].dim_lock);
> > > 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> > > 							       vi->intr_coal_rx.max_usecs,
> > > 							       vi->intr_coal_rx.max_packets);
> > >-			mutex_unlock(&vi->rq[i].dim_lock);
> > > 			if (err)
> > > 				return err;
> > > 		}
> > >@@ -4257,7 +4248,6 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> > > 	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
> > > 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
> > > 	struct scatterlist sgs_rx;
> > >-	int ret = 0;
> > > 	int i;
> > > 
> > > 	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > >@@ -4267,22 +4257,16 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> > > 			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
> > > 		return -EINVAL;
> > > 
> > >-	/* Acquire all queues dim_locks */
> > >-	for (i = 0; i < vi->max_queue_pairs; i++)
> > >-		mutex_lock(&vi->rq[i].dim_lock);
> > >-
> > > 	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
> > > 		vi->rx_dim_enabled = true;
> > > 		for (i = 0; i < vi->max_queue_pairs; i++)
> > > 			vi->rq[i].dim_enabled = true;
> > >-		goto unlock;
> > >+		return 0;
> > > 	}
> > > 
> > > 	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
> > >-	if (!coal_rx) {
> > >-		ret = -ENOMEM;
> > >-		goto unlock;
> > >-	}
> > >+	if (!coal_rx)
> > >+		return -ENOMEM;
> > > 
> > > 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
> > > 		vi->rx_dim_enabled = false;
> > >@@ -4300,10 +4284,8 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> > > 
> > > 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> > > 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> > >-				  &sgs_rx)) {
> > >-		ret = -EINVAL;
> > >-		goto unlock;
> > >-	}
> > >+				  &sgs_rx))
> > >+		return -EINVAL;
> > > 
> > > 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
> > > 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
> > >@@ -4311,11 +4293,8 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> > > 		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
> > > 		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> > > 	}
> > >-unlock:
> > >-	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
> > >-		mutex_unlock(&vi->rq[i].dim_lock);
> > > 
> > >-	return ret;
> > >+	return 0;
> > > }
> > > 
> > > static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
> > >@@ -4339,24 +4318,19 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
> > > 					     u16 queue)
> > > {
> > > 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
> > >+	bool cur_rx_dim = vi->rq[queue].dim_enabled;
> > > 	u32 max_usecs, max_packets;
> > >-	bool cur_rx_dim;
> > > 	int err;
> > > 
> > >-	mutex_lock(&vi->rq[queue].dim_lock);
> > >-	cur_rx_dim = vi->rq[queue].dim_enabled;
> > > 	max_usecs = vi->rq[queue].intr_coal.max_usecs;
> > > 	max_packets = vi->rq[queue].intr_coal.max_packets;
> > > 
> > > 	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
> > >-			       ec->rx_max_coalesced_frames != max_packets)) {
> > >-		mutex_unlock(&vi->rq[queue].dim_lock);
> > >+			       ec->rx_max_coalesced_frames != max_packets))
> > > 		return -EINVAL;
> > >-	}
> > > 
> > > 	if (rx_ctrl_dim_on && !cur_rx_dim) {
> > > 		vi->rq[queue].dim_enabled = true;
> > >-		mutex_unlock(&vi->rq[queue].dim_lock);
> > > 		return 0;
> > > 	}
> > > 
> > >@@ -4369,8 +4343,10 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
> > > 	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
> > > 					       ec->rx_coalesce_usecs,
> > > 					       ec->rx_max_coalesced_frames);
> > >-	mutex_unlock(&vi->rq[queue].dim_lock);
> > >-	return err;
> > >+	if (err)
> > >+		return err;
> > >+
> > >+	return 0;
> > > }
> > > 
> > > static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
> > >@@ -4404,7 +4380,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
> > > 
> > > 	qnum = rq - vi->rq;
> > > 
> > >-	mutex_lock(&rq->dim_lock);
> > > 	if (!rq->dim_enabled)
> > > 		goto out;
> > > 
> > >@@ -4420,7 +4395,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
> > > 	}
> > > out:
> > > 	dim->state = DIM_START_MEASURE;
> > >-	mutex_unlock(&rq->dim_lock);
> > > }
> > > 
> > > static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
> > >@@ -4558,13 +4532,11 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
> > > 		return -EINVAL;
> > > 
> > > 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> > >-		mutex_lock(&vi->rq[queue].dim_lock);
> > > 		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
> > > 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
> > > 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
> > > 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
> > > 		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
> > >-		mutex_unlock(&vi->rq[queue].dim_lock);
> > > 	} else {
> > > 		ec->rx_max_coalesced_frames = 1;
> > > 
> > >@@ -5396,7 +5368,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
> > > 
> > > 		u64_stats_init(&vi->rq[i].stats.syncp);
> > > 		u64_stats_init(&vi->sq[i].stats.syncp);
> > >-		mutex_init(&vi->rq[i].dim_lock);
> > > 	}
> > > 
> > > 	return 0;
> > >-- 
> > >2.32.0.3.g01195cf9f
> > >
> > >


