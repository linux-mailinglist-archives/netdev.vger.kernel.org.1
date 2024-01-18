Return-Path: <netdev+bounces-64169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC52383189C
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 12:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281441C22EA6
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462E241E7;
	Thu, 18 Jan 2024 11:46:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD7134A8
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578413; cv=none; b=FVfAMWeQOPoK5Fgky/jKWgj4oOjovWseujAXGxCDwEPGyAX998hpx4DLk9dYZCNIbba4epbfggztBtdkurz3QOTuzJj9SNDaGDzfG5ZjMvUOtvF/HtWPz2d7jXQ12QhRgbM9FnqzFgZKhpvSLkSHZ4aobG/QP1S9FYCsc+bvbPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578413; c=relaxed/simple;
	bh=4AZLLLj6En0qd1g7HVU8YDlmftcG2SxF4s3d6xqbXkk=;
	h=X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:X-SMAIL-MID:X-SMAIL-UIID:
	 From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=Md7uI4s/6WWXGEZwhOdeuqF0xcrFYqNimDUZ4JhghcaxHYZk+nOViCRHQsmqv1LI3jNDjrfhCw4G78lJLqkolKv3DAOQx8qi5mXvouQkDnfhAdbax9ibeGpOrGtzWCxSgERaSjnl0eXwTiWJJUeEmRWiXBKQNw9QK9BSbLWjygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (10.75.12.45) with ESMTP
	id 65A90FA1000003BF; Thu, 18 Jan 2024 19:46:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 28741731457794
X-SMAIL-UIID: 9A0FB41A7E02475087B772CEB43C0DD1-20240118-194644-1
From: Hillf Danton <hdanton@sina.com>
To: shaozhengchao <shaozhengchao@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Manfred Spraul <manfred@colorfullife.com>,
	jack@suse.cz
Subject: Re: [PATCH v2] ipc/mqueue: fix potential sleeping issue in mqueue_flush_file
Date: Thu, 18 Jan 2024 19:46:31 +0800
Message-Id: <20240118114631.1490-1-hdanton@sina.com>
In-Reply-To: <fee3ec1c-5af6-aad2-c0d0-843de59494a7@huawei.com>
References: <20231220021208.2634523-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2023/12/20 10:12, Zhengchao Shao wrote:
> I analyze the potential sleeping issue of the following processes:
> Thread A                                Thread B
> ...                                     netlink_create  //ref = 1
> do_mq_notify                            ...
>    sock = netlink_getsockbyfilp          ...     //ref = 2
>    info->notify_sock = sock;             ...
> ...                                     netlink_sendmsg
> ...                                       skb = netlink_alloc_large_skb  //skb->head is vmalloced
> ...                                       netlink_unicast
> ...                                         sk = netlink_getsockbyportid //ref = 3
> ...                                         netlink_sendskb
> ...                                           __netlink_sendskb
> ...                                             skb_queue_tail //put skb to sk_receive_queue
> ...                                         sock_put //ref = 2
> ...                                     ...
> ...                                     netlink_release
> ...                                       deferred_put_nlk_sk //ref = 1
> mqueue_flush_file
>    spin_lock
>    remove_notification
>      netlink_sendskb
>        sock_put  //ref = 0
>          sk_free
>            ...
>            __sk_destruct
>              netlink_sock_destruct
>                skb_queue_purge  //get skb from sk_receive_queue
>                  ...
>                  __skb_queue_purge_reason
>                    kfree_skb_reason
>                      __kfree_skb
>                      ...
>                      skb_release_all
>                        skb_release_head_state
>                          netlink_skb_destructor
>                            vfree(skb->head)  //sleeping while holding spinlock
> 
> In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
> vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
> When the mqueue executes flush, the sleeping bug will occur. Use mutex
> lock instead of spin lock in mqueue_flush_file.

It makes no sense to replace spinlock with mutex just for putting sock.

Only for thoughts.

--- x/ipc/mqueue.c
+++ y/ipc/mqueue.c
@@ -663,12 +663,17 @@ static ssize_t mqueue_read_file(struct f
 static int mqueue_flush_file(struct file *filp, fl_owner_t id)
 {
 	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
+	struct sock *sk = NULL;
 
 	spin_lock(&info->lock);
-	if (task_tgid(current) == info->notify_owner)
+	if (task_tgid(current) == info->notify_owner) {
+		sk = info->notify_sock;
+		sock_hold(sk);
 		remove_notification(info);
-
+	}
 	spin_unlock(&info->lock);
+	if (sk)
+		sock_put(sk);
 	return 0;
 }
 

