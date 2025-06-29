Return-Path: <netdev+bounces-202287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29772AED137
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5173A9CCD
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D222A7E9;
	Sun, 29 Jun 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cAgghi3q"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E91C863B;
	Sun, 29 Jun 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751232395; cv=none; b=Bof6J9SZZZ1iMEL9Ag4MTJBumoYdZbJsLneg3cBX08OBn2FM64rD1Fswe4WAFdE9F4QswGC/Us+v94lhMAC11zggpJ75ZJ3iubIpXO8nHqGA6zq4uk+cJXF68GEjahT4YDG3rmzwq2DQvvE6juYduDRoQ+ZrZZsExyuX0X5liMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751232395; c=relaxed/simple;
	bh=r/4CbGX4CPcaoOJYcVGJevC/eJ5UYCOm6KPvHK3tnkU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y7JXktem0f9/kn492PMsdkRH8PTpvlkQlUOZPbAFxACR98c2o6VXr4Kc4y12sRYjc5r9csYIyc+t1POpje0x9NZuQolK/M8UTiXpg7/Rc7JMvdB0jMJVs1JDA7oBBssqnj1+yuFcN8E/gCsjlnRYA9Db3VHNNUoyddEpKuqcG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cAgghi3q; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uVzXW-008qOB-QC; Sun, 29 Jun 2025 23:26:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=9h+y5ih8KWltTHxtpALgezfUxXbLX+28n5btYOMA+tk=; b=cAgghi3qclZQVDYVwcdRFd+Kq9
	yzo4R5snUPfoUKfSInAlC5YTVKDxWPzMACX2WB3hefYfIYUN2Exxzh7F9qElnTOpPbbMWlxJlBNEa
	Rptv/9E0RGdUHfxB50G4XKly1fyRYffJ7q1PAWl96WW0TDDNVKSYEgE7vWk4TnQlaGJ9G6GIid+1P
	b7EWe+7+4tQJhq8d+f9+/2vJ0PL35c57jwK6XKozTiUCGowaW/wQXN+QPg0mr6XVOYZMbTba2JPc5
	t88bTjMFQGGsNBcfushS+Y8OA7lC1SdnCW5wqwuF1W8YZQviixhmLxkUbyipmaeTj6raKLPRFtlQn
	MAiwx42A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uVzXV-0000HV-UZ; Sun, 29 Jun 2025 23:26:18 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uVzXR-00BySK-G0; Sun, 29 Jun 2025 23:26:13 +0200
Message-ID: <e97b5cae-f6ef-4221-98e1-6efd7fdc6676@rbox.co>
Date: Sun, 29 Jun 2025 23:26:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
 <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
 <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
 <owafhdinyjdnol4zwpcdqsz26nfndawl53wnosdhhgmfz6t25n@2dualdqgpq3q>
Content-Language: pl-PL, en-GB
In-Reply-To: <owafhdinyjdnol4zwpcdqsz26nfndawl53wnosdhhgmfz6t25n@2dualdqgpq3q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/27/25 10:02, Stefano Garzarella wrote:
> On Wed, Jun 25, 2025 at 11:23:30PM +0200, Michal Luczaj wrote:
>> On 6/25/25 10:43, Stefano Garzarella wrote:
>>> On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>>>> vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>>>> transport_{g2h,h2g} may become NULL after the NULL check.
>>>>
>>>> Introduce vsock_transport_local_cid() to protect from a potential
>>>> null-ptr-deref.
>>>>
>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>> RIP: 0010:vsock_find_cid+0x47/0x90
>>>> Call Trace:
>>>> __vsock_bind+0x4b2/0x720
>>>> vsock_bind+0x90/0xe0
>>>> __sys_bind+0x14d/0x1e0
>>>> __x64_sys_bind+0x6e/0xc0
>>>> do_syscall_64+0x92/0x1c0
>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>
>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>>> Call Trace:
>>>> __x64_sys_ioctl+0x12d/0x190
>>>> do_syscall_64+0x92/0x1c0
>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>
>>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> ---
>>>> net/vmw_vsock/af_vsock.c | 23 +++++++++++++++++------
>>>> 1 file changed, 17 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..63a920af5bfe6960306a3e5eeae0cbf30648985e 100644
>>>> --- a/net/vmw_vsock/af_vsock.c
>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>> @@ -531,9 +531,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>>> }
>>>> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>>>>
>>>> +static u32 vsock_transport_local_cid(const struct vsock_transport **transport)
>>>
>>> Why we need double pointer?
>>
>> Because of a possible race. If @transport is `struct vsock_transport*` and
>> we pass `transport_g2h`, the passed non-NULL pointer value may immediately
>> become stale (due to module unload). But if it's `vsock_transport**` and we
>> pass `&transport_g2h`, then we can take the mutex, check `*transport` for
>> NULL and safely go ahead.
>>
>> Or are you saying this could be simplified?
> 
> Nope, you're right! I was still thinking about my old version where we 
> had the switch inside...
> 
> BTW I'd like to change the name, `vsock_transport_local` prefix is 
> confusing IMO, since it seems related only to the `transport_local`.
> 
> Another thing I'm worried about is that we'll then start using it on 
> `vsk->transport` when this is only to be used on registered transports 
> (i.e. `static ...`), though, I don't think there's a way to force type 
> checking from the compiler (unless you wrap it in a struct). (...)

I've found (on SO[1]) this somewhat hackish compile-time `static`-checking:

static u32 __vsock_registered_transport_cid(const struct vsock_transport
**transport)
{
	u32 cid = VMADDR_CID_ANY;

	mutex_lock(&vsock_register_mutex);
	if (*transport)
		cid = (*transport)->get_local_cid();
	mutex_unlock(&vsock_register_mutex);

	return cid;
}

#define ASSERT_REGISTERED_TRANSPORT(t)					\
	__always_unused static void *__UNIQUE_ID(vsock) = (t)

#define vsock_registered_transport_cid(transport)			\
({									\
	ASSERT_REGISTERED_TRANSPORT(transport);				\
	__vsock_registered_transport_cid(transport);			\
})

It does the trick, compilation fails on
vsock_registered_transport_cid(&vsk->transport):

net/vmw_vsock/af_vsock.c: In function ‘vsock_send_shutdown’:
net/vmw_vsock/af_vsock.c:565:59: error: initializer element is not constant
  565 |         __always_unused static void *__UNIQUE_ID(vsock) = (t)
      |                                                           ^
net/vmw_vsock/af_vsock.c:569:9: note: in expansion of macro
‘ASSERT_REGISTERED_TRANSPORT’
  569 |         ASSERT_REGISTERED_TRANSPORT(transport);
    \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
net/vmw_vsock/af_vsock.c:626:9: note: in expansion of macro
‘vsock_registered_transport_cid’
  626 |         vsock_registered_transport_cid(&vsk->transport);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

But perhaps adding a comment wouldn't hurt either, e.g.

/* Provide safe access to static transport_{h2g,g2h,dgram,local} callbacks.
 * Otherwise we may race with module removal. Do not use on
 * `vsk->transport`.
 */

? ...which begs another question: do we stick to the netdev special comment
style? See commit 82b8000c28b5 ("net: drop special comment style").

Oh, and come to think of it, we don't really need that (easily contended?)
mutex here. Same can be done with RCU. Which should speed up vsock_bind()
-> __vsock_bind() -> vsock_find_cid(), right? This is what I mean, roughly:

+static u32 vsock_registered_transport_cid(const struct vsock_transport
__rcu **trans_ptr)
+{
+	const struct vsock_transport *transport;
+	u32 cid = VMADDR_CID_ANY;
+
+	rcu_read_lock();
+	transport = rcu_dereference(*trans_ptr);
+	if (transport)
+		cid = transport->get_local_cid();
+	rcu_read_unlock();
+
+	return cid;
+}
...
@@ -2713,6 +2726,7 @@ void vsock_core_unregister(const struct
vsock_transport *t)
 		transport_local = NULL;

 	mutex_unlock(&vsock_register_mutex);
+	synchronize_rcu();
 }

I've realized I'm throwing multiple unrelated ideas/questions, so let me
summarise:
1. Hackish macro can be used to guard against calling
vsock_registered_transport_cid() on a non-static variable.
2. We can comment the function to add some context and avoid confusion.
3. Instead of taking mutex in vsock_registered_transport_cid() we can use RCU.

> So, if we can't do much, I'd add a comment and make the function name 
> more clear. e.g. vsock_registered_transport_cid() ? or something 
> similar.

Sure, will do.

Thanks!

[1]:
https://stackoverflow.com/questions/5645695/how-can-i-add-a-static-assert-to-check-if-a-variable-is-static/5672637#5672637

