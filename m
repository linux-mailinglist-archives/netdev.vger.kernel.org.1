Return-Path: <netdev+bounces-202288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A0AED13C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87A73B45C8
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C8241670;
	Sun, 29 Jun 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Xzr7O2Kv"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349902405ED;
	Sun, 29 Jun 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751232400; cv=none; b=Ksv4ZlPWGv7fm0HfNBDrWXQUORFhW99Fft4WRt5hf+b3G6Kxi68gnMCgDZzBgWu10oXO7NlxbcA9sVa3X9ZAsjbVPFvue9vi5dqTcKjC6NpeM1CDugeUQVYB6GjIBMzMYtiebLGNHRERe8xOAFnxp3cGloam29QPGWeV25jGWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751232400; c=relaxed/simple;
	bh=Vc6DXlTA2rqkZ5El9SS1QnPc5+V0zOJ7fTZ6U74Jq1Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JSb4yhF64wFrsUisrzljm4s11KtHQ4iDmIVFukYrYbC5uD9ZDwggPmvrIiUwFa1ado7uY/i7H2WttN+EqzsD8UxRHvBr3CFlLro8eXyLHPiwTpTe8byd8gUPp/jRLI8PQG4WNkmljH6HcXWXfBR52YPL8MmWYTat4p+8dlQwwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Xzr7O2Kv; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uVzXh-008qOw-D7; Sun, 29 Jun 2025 23:26:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Gt887sZKxHDX2H0BCePTA8Ra8yh4q7O48JvyGarnNKo=; b=Xzr7O2Kv2+l9BUSNiU0BrfJ3y1
	85ACbk2jBiz/516bZzAxKN78JaouSQtz4g7lQA8lKj6cd7rP8FaUm5FbIs+kfYFuSLAGRMNh7IsRk
	XcnMBBKkIjm0D917yLIqTCSxcaAeQVEN46gjM/QUhFVfDx8retsAfYktb3lEdUgrHjmnnIsxxMRGI
	RmGLZKLgB5+kiYacN9gsxOG27D7tMsPUTy00uS7gSkdk/9dU9ZhqYimhOZvLJo2AWK5j0XkkkcLWY
	xANKxnTgBEEUdHlEAnN6Oa3RbiEr1Vgzfj05bMxK2o0nBJEaWtvpMb9GNGzoEAD/AxoQfa0uWHwCi
	wzOOTbYA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uVzXh-0000IA-3t; Sun, 29 Jun 2025 23:26:29 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uVzXe-00CwbT-D4; Sun, 29 Jun 2025 23:26:26 +0200
Message-ID: <b0b49299-6373-4fea-914b-271f6451e27b@rbox.co>
Date: Sun, 29 Jun 2025 23:26:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH RFC net v2 2/3] vsock: Fix transport_* TOCTOU
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-2-02ebd20b1d03@rbox.co>
 <l6yqfwqjzygrs74shfsiptexwqydw3ts2eiuet2te3b7sseelo@ygussce5st4h>
Content-Language: pl-PL, en-GB
In-Reply-To: <l6yqfwqjzygrs74shfsiptexwqydw3ts2eiuet2te3b7sseelo@ygussce5st4h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 10:08, Stefano Garzarella wrote:
> On Fri, Jun 20, 2025 at 09:52:44PM +0200, Michal Luczaj wrote:
>> Transport assignment may race with module unload. Protect new_transport
>>from becoming a stale pointer.
>>
>> This also takes care of an insecure call in vsock_use_local_transport();
>> add a lockdep assert.
>>
>> BUG: unable to handle page fault for address: fffffbfff8056000
>> Oops: Oops: 0000 [#1] SMP KASAN
>> RIP: 0010:vsock_assign_transport+0x366/0x600
>> Call Trace:
>> vsock_connect+0x59c/0xc40
>> __sys_connect+0xe8/0x100
>> __x64_sys_connect+0x6e/0xc0
>> do_syscall_64+0x92/0x1c0
>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
>> 1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 63a920af5bfe6960306a3e5eeae0cbf30648985e..a1b1073a2c89f865fcdb58b38d8e7feffcf1544f 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -407,6 +407,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>>
>> static bool vsock_use_local_transport(unsigned int remote_cid)
>> {
>> +	lockdep_assert_held(&vsock_register_mutex);
>> +
>> 	if (!transport_local)
>> 		return false;
>>
>> @@ -464,6 +466,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>
>> 	remote_flags = vsk->remote_addr.svm_flags;
>>
>> +	mutex_lock(&vsock_register_mutex);
>> +
>> 	switch (sk->sk_type) {
>> 	case SOCK_DGRAM:
>> 		new_transport = transport_dgram;
>> @@ -479,12 +483,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> 			new_transport = transport_h2g;
>> 		break;
>> 	default:
>> -		return -ESOCKTNOSUPPORT;
>> +		ret = -ESOCKTNOSUPPORT;
>> +		goto err;
>> 	}
>>
>> 	if (vsk->transport) {
>> -		if (vsk->transport == new_transport)
>> -			return 0;
>> +		if (vsk->transport == new_transport) {
>> +			ret = 0;
>> +			goto err;
>> +		}
> 
> 		/* transport->release() must be called with sock lock acquired.
> 		 * This path can only be taken during vsock_connect(), where we
> 		 * have already held the sock lock. In the other cases, this
> 		 * function is called on a new socket which is not assigned to
> 		 * any transport.
> 		 */
> 		vsk->transport->release(vsk);
> 		vsock_deassign_transport(vsk);
> 
> Thinking back to this patch, could there be a deadlock between call
> vsock_deassign_transport(), which call module_put(), now with the
> `vsock_register_mutex` held, and the call to vsock_core_unregister()
> usually made by modules in the exit function?

I think we're good. module_put() does not call the module cleanup function
(kernel/module/main.c:delete_module() syscall does that), so
vsock_core_unregister() won't happen in this path here. Have I missed
anything else?

