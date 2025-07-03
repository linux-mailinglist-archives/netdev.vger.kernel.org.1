Return-Path: <netdev+bounces-203709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CCAF6D21
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219711C476C3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B17D2D3A65;
	Thu,  3 Jul 2025 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="I4RU9TjF"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F252D29CF;
	Thu,  3 Jul 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531816; cv=none; b=Bbj4fhg0jFl+UyahsiDkZjTl4jhEAd5I2Jf2SMpAfrDalfVd5UVJlfdrxCRKaGWAwCs6N4DNug2CsA1Zwjb4shSsL2KhB6vr8plJROCc2eSa88qZi7FW4Lcmx3XxvBnihvbEvI/qI8bMGC3J6XciBF+sPddAVlwaxEV9Rk6RXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531816; c=relaxed/simple;
	bh=91bla5ktTh31bZ+QC7RyOT+9Zzll21yp330pcc8HPmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/r1CKV5lE8BzFNLuYpU7RTIA7yEwIekh483adewArHSexJBe6IzoGDCIVLrKlyAKo2++Es5oH7JeKmc02ZaB9hu10AAGZE/taUDseEuLxPBfCApduU2ZmJ9eo0EEhfCXrj2CrLL/nO74IzvG1bHxiyAjmYTA0veU6cFfUwD8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=I4RU9TjF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uXFQw-001Lnc-VN; Thu, 03 Jul 2025 10:36:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=ZvbJbTZZn9ydZb429veIWX9aAM3F0/cpPoXKF/bzbOU=; b=I4RU9TjFY7hFOfmKX4ihBRqyiD
	mOEPfS7SFlj/kpgOiUS9u2yn9khXdMI9LskexIr+3AdNTZxpVbCgOmv/1tnhjtJ6jYsuG8E62OqY5
	UVx+xTciMwZWDVDy/Qkd6oD4gEw6EclQcQJNZrMjyFiAKHhhSGf1yEzrREqURmpgTLyBL1rTqaAAF
	hNzxTiieNTJLpPow0sD1PQPlmS/dYFLYQPI+U365qYvHarDpJAjPEz+QQ7+5YIbDsOvAjKNReU/J3
	1zUwhPQrvTn4WbsbZgsU4FeLYytYIjadLmWgUXZHMTQ9lApm0ugnJvFOOULYBF4v3ulXy0mKtU25P
	4U/TuIYw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uXFQw-00044F-85; Thu, 03 Jul 2025 10:36:42 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uXFQd-00DSTl-3W; Thu, 03 Jul 2025 10:36:23 +0200
Message-ID: <e69847a1-7a54-417d-95df-4c0a98a6120f@rbox.co>
Date: Thu, 3 Jul 2025 10:36:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] vsock: Fix transport_* TOCTOU
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
 <20250702-vsock-transports-toctou-v3-2-0a7e2e692987@rbox.co>
 <u36jztpit63o2b33ulnmax2xrw2c6hgrkwabto3fccocdmay7w@xlpkemxcgve4>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <u36jztpit63o2b33ulnmax2xrw2c6hgrkwabto3fccocdmay7w@xlpkemxcgve4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 10:20, Stefano Garzarella wrote:
> On Wed, Jul 02, 2025 at 03:38:44PM +0200, Michal Luczaj wrote:
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
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
>> 1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 39473b9e0829f240045262aef00cbae82a425dcc..9b2af5c63f7c2ae575c160415bd77208a3980835 100644
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
>>
>> 		/* transport->release() must be called with sock lock acquired.
>> 		 * This path can only be taken during vsock_connect(), where we
>> @@ -508,8 +515,16 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> 	/* We increase the module refcnt to prevent the transport unloading
>> 	 * while there are open sockets assigned to it.
>> 	 */
>> -	if (!new_transport || !try_module_get(new_transport->module))
>> -		return -ENODEV;
>> +	if (!new_transport || !try_module_get(new_transport->module)) {
>> +		ret = -ENODEV;
>> +		goto err;
>> +	}
>> +
>> +	/* It's safe to release the mutex after a successful try_module_get().
>> +	 * Whichever transport `new_transport` points at, it won't go await
> 
> Little typo, s/await/away
> 
> Up to you to resend or not. My R-b stay for both cases.

Arrgh, thanks. I'll fix it.

pw-bot: changes-requested


