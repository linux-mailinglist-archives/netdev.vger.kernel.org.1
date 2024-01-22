Return-Path: <netdev+bounces-64596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A6835D73
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 09:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192151F253F2
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B56639AF0;
	Mon, 22 Jan 2024 08:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE539AEA
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913833; cv=none; b=HTVx7ytAi5QrnYXlwRj/pbzBcgt/sD9xhCSEYsZj2UF9llHZ31mhOQFkIhamnezdCb3/7rAfGPRU/qL/olH9S4YMD0odVLM9mTGHLjCM35z+k6/SZfEGXq6f/ZwWP0WtH6MV/vXMs4otoc2HizrY+wYRjp/RTuFDR5/Aw7ItEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913833; c=relaxed/simple;
	bh=1jcCvsdjNMV3GDJ4KZaJE8c1CpXgEwfJ0Xvj4k+6mek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoQKFfO3b65OV+iVJn13iimvhvY0/HEeAfS1q/c7PI2cxXIY4XUDrbOi4BNoWo6jfhIcQWcwt7c0fvXTBUmFyc2ZU2Xo95uuWvP2VUg45PjMNIj1Su1hPCoR96LFowrxkedY6xQsHIOyXMhQXt+HCdMlEcKTVTsrB4PUzkN13nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=45324 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rRq6y-003Dnp-GL; Mon, 22 Jan 2024 09:56:58 +0100
Date: Mon, 22 Jan 2024 09:56:55 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	anjali.k.kulkarni@oracle.com, kuniyu@amazon.com, fw@strlen.de,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net,v4] netlink: fix potential sleeping issue in
 mqueue_flush_file
Message-ID: <Za4t110BCZAnlf1o@calendula>
References: <20240122011807.2110357-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122011807.2110357-1-shaozhengchao@huawei.com>
X-Spam-Score: -1.9 (-)

On Mon, Jan 22, 2024 at 09:18:07AM +0800, Zhengchao Shao wrote:
> I analyze the potential sleeping issue of the following processes:
> Thread A                                Thread B
> ...                                     netlink_create  //ref = 1
> do_mq_notify                            ...
>   sock = netlink_getsockbyfilp          ...     //ref = 2
>   info->notify_sock = sock;             ...
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
>   spin_lock
>   remove_notification
>     netlink_sendskb
>       sock_put  //ref = 0
>         sk_free
>           ...
>           __sk_destruct
>             netlink_sock_destruct
>               skb_queue_purge  //get skb from sk_receive_queue
>                 ...
>                 __skb_queue_purge_reason
>                   kfree_skb_reason
>                     __kfree_skb
>                     ...
>                     skb_release_all
>                       skb_release_head_state
>                         netlink_skb_destructor
>                           vfree(skb->head)  //sleeping while holding spinlock
>
> In netlink_sendmsg, if the memory pointed to by skb->head is allocated by
> vmalloc, and is put to sk_receive_queue queue, also the skb is not freed.
> When the mqueue executes flush, the sleeping bug will occur. Use
> vfree_atomic instead of vfree in netlink_skb_destructor to solve the issue.

mqueue notification is of NOTIFY_COOKIE_LEN size:

static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
{
        [...]
                if (notification->sigev_notify == SIGEV_THREAD) {
                        long timeo;

                        /* create the notify skb */
                        nc = alloc_skb(NOTIFY_COOKIE_LEN, GFP_KERNEL);
                        if (!nc)
                                return -ENOMEM;

Do you have a reproducer?

