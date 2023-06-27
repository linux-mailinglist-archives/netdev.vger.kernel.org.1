Return-Path: <netdev+bounces-14145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2996973F3C5
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 06:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E18E1C20A54
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC701102;
	Tue, 27 Jun 2023 04:54:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03EEEDA
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 04:54:19 +0000 (UTC)
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB225EB;
	Mon, 26 Jun 2023 21:54:17 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
	by mx.sberdevices.ru (Postfix) with ESMTP id 0AA9C5FD20;
	Tue, 27 Jun 2023 07:54:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1687841656;
	bh=p0JWJ2d2p14E6dsxMnE1tu0fwOmNT8jfZ3ZYPNoUIZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=k7m0YQ6WhaPKOgMbJdwl8ILs/bkakY3ztBIvnyVOGre/aEjZUySRPDl/pMaoSdu30
	 XMwc/0j54DHMFJux042yfuPMty7fUNG/Erg6KMWovqgRoyodPqzL7nnjIG+Rbecwsb
	 cbqgDNKcbZUxhKhtn3LqwecClI9w0Tmm1bVXsda899upMAsBLELE55ST7QCb0SjDO5
	 5xBUYWsH+ZkzEKD/6PFAAbfWmJf5MTWgWf4D2j17g2kSaDn5f/0bCAUtHNMY26qFI6
	 DmmCqO8wiIT/HFNAoK4Z/aXB0h8yZJWwr6UciXSYc/YP84qiijMT5OLgUG5bv3tqkb
	 cyei666cOSO/g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	by mx.sberdevices.ru (Postfix) with ESMTP;
	Tue, 27 Jun 2023 07:53:59 +0300 (MSK)
Message-ID: <4d532e35-c03c-fbf6-0744-9397e269750d@sberdevices.ru>
Date: Tue, 27 Jun 2023 07:49:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v4 07/17] vsock: read from socket's error queue
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Bobby Eshleman
	<bobby.eshleman@bytedance.com>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
 <sq5jlfhhlj347uapazqnotc5rakzdvj33ruzqwxdjsfx275m5r@dxujwphcffkl>
From: Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <sq5jlfhhlj347uapazqnotc5rakzdvj33ruzqwxdjsfx275m5r@dxujwphcffkl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/27 02:11:00 #21585463
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 26.06.2023 19:08, Stefano Garzarella wrote:
> On Sat, Jun 03, 2023 at 11:49:29PM +0300, Arseniy Krasnov wrote:
>> This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>> is used to read socket's error queue instead of data queue. Possible
>> scenario of error queue usage is receiving completions for transmission
>> with MSG_ZEROCOPY flag.
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>> include/linux/socket.h   | 1 +
>> net/vmw_vsock/af_vsock.c | 5 +++++
>> 2 files changed, 6 insertions(+)
>>
>> diff --git a/include/linux/socket.h b/include/linux/socket.h
>> index bd1cc3238851..d79efd026880 100644
>> --- a/include/linux/socket.h
>> +++ b/include/linux/socket.h
>> @@ -382,6 +382,7 @@ struct ucred {
>> #define SOL_MPTCP    284
>> #define SOL_MCTP    285
>> #define SOL_SMC        286
>> +#define SOL_VSOCK    287
> 
> Maybe this change should go in another patch where we describe that
> we need to support setsockopt()

Ok, You mean patch which handles SO_ZEROCOPY option in af_vsock.c as Bobby suggested? No
problem, but in this case there will be no user for this define there - this option
(SO_ZEROCOPY) uses SOL_SOCKET level, not SOL_VSOCK.

Thanks, Arseniy

> 
>>
>> /* IPX options */
>> #define IPX_TYPE    1
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 45fd20c4ed50..07803d9fbf6d 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -110,6 +110,7 @@
>> #include <linux/workqueue.h>
>> #include <net/sock.h>
>> #include <net/af_vsock.h>
>> +#include <linux/errqueue.h>
>>
>> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
>> static void vsock_sk_destruct(struct sock *sk);
>> @@ -2135,6 +2136,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>>     int err;
>>
>>     sk = sock->sk;
>> +
>> +    if (unlikely(flags & MSG_ERRQUEUE))
>> +        return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, 0);
>> +
>>     vsk = vsock_sk(sk);
>>     err = 0;
>>
>> -- 
>> 2.25.1
>>
> 

