Return-Path: <netdev+bounces-201323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09009AE9026
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E634A52AC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 21:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C41215055;
	Wed, 25 Jun 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Miy8tqN5"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E74204E;
	Wed, 25 Jun 2025 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886636; cv=none; b=cWXT/n1KkqcywdZsj3fMC9wCl86LAgoiEnJ3+Gt2b3hPF/PNpO/V5uEXwyQCSf9fuR0IrEDjgaOejnBJNOhupvzsYDi3E3p8ilDbV6m7KdKLudk4f6IhUh6VSnrVuqWhVI2R6gDAohvh2cnPSlbhZ8yyCXyE96t41PPGJhVtAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886636; c=relaxed/simple;
	bh=SjOERE9lk7t+BeQIGQMgKSHjyxIpRmYnMbWS3Out3VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbW8rb6egwLveAuB87zPrmMGTbHljzibjNuTnPOBL9WK59fpnAYrlgefuGdsi2lZg5u135UA+dWQ9fXT6YlY8Wre9yOuWmCnA54GbhSB96IKt0duaErTlzHNskyxtf45Havlx0rY2YGQaIMuIopKIfmzs808KYmw6tZw+yxwvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Miy8tqN5; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUXas-00FItu-1j; Wed, 25 Jun 2025 23:23:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Xitjpa1nEC5ejKfbqjYMNW/UtglAOa02RUILsmFf+eg=; b=Miy8tqN5TIZr5vnQOoT+VVLCl2
	/m1+8bekhUcSQWnCpfQMRe6ttrnM1h93OmG6loTyM2H3Qz08dFOTXfcENYXlS2bmu1AK8muDB59Dw
	M9/azCmUDIQbE7FlqHouO4WDkGLb7xHpstpzPbE7oHJ9S68kdmeKk0GOwdEY/AAGafmoOu0G3Ph35
	gCmQdHxTkVDE89DnCvDuswP2imLTWQuvsvWqQcIaREi2eizA2FEk9SkKmwmcCTEbBp/NIpY/C/AQP
	vjdvgFFAHjk0zJVmDQfgrAc1KFZEEZDx6aKNRzYbGw93hBhm/5YMnOT8uYdcxJWhLLneAiM5ao02z
	KOsZHbMA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUXar-0002J5-8j; Wed, 25 Jun 2025 23:23:45 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUXad-004uaP-OR; Wed, 25 Jun 2025 23:23:31 +0200
Message-ID: <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
Date: Wed, 25 Jun 2025 23:23:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 10:43, Stefano Garzarella wrote:
> On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>> vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>> transport_{g2h,h2g} may become NULL after the NULL check.
>>
>> Introduce vsock_transport_local_cid() to protect from a potential
>> null-ptr-deref.
>>
>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>> RIP: 0010:vsock_find_cid+0x47/0x90
>> Call Trace:
>> __vsock_bind+0x4b2/0x720
>> vsock_bind+0x90/0xe0
>> __sys_bind+0x14d/0x1e0
>> __x64_sys_bind+0x6e/0xc0
>> do_syscall_64+0x92/0x1c0
>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>> Call Trace:
>> __x64_sys_ioctl+0x12d/0x190
>> do_syscall_64+0x92/0x1c0
>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c | 23 +++++++++++++++++------
>> 1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..63a920af5bfe6960306a3e5eeae0cbf30648985e 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -531,9 +531,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> }
>> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>>
>> +static u32 vsock_transport_local_cid(const struct vsock_transport **transport)
> 
> Why we need double pointer?

Because of a possible race. If @transport is `struct vsock_transport*` and
we pass `transport_g2h`, the passed non-NULL pointer value may immediately
become stale (due to module unload). But if it's `vsock_transport**` and we
pass `&transport_g2h`, then we can take the mutex, check `*transport` for
NULL and safely go ahead.

Or are you saying this could be simplified?

>> +{
>> +	u32 cid = VMADDR_CID_ANY;
>> +
>> +	mutex_lock(&vsock_register_mutex);
>> +	if (*transport)
>> +		cid = (*transport)->get_local_cid();
>> +	mutex_unlock(&vsock_register_mutex);
>> +
>> +	return cid;
>> +}
>> +
>> bool vsock_find_cid(unsigned int cid)
>> {
>> -	if (transport_g2h && cid == transport_g2h->get_local_cid())
>> +	if (cid == vsock_transport_local_cid(&transport_g2h))
>> 		return true;
>>
>> 	if (transport_h2g && cid == VMADDR_CID_HOST)
>> @@ -2536,18 +2548,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
>> 			       unsigned int cmd, void __user *ptr)
>> {
>> 	u32 __user *p = ptr;
>> -	u32 cid = VMADDR_CID_ANY;
>> 	int retval = 0;
>> +	u32 cid;
>>
>> 	switch (cmd) {
>> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>> 		/* To be compatible with the VMCI behavior, we prioritize the
>> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>> 		 */
>> -		if (transport_g2h)
>> -			cid = transport_g2h->get_local_cid();
>> -		else if (transport_h2g)
>> -			cid = transport_h2g->get_local_cid();
>> +		cid = vsock_transport_local_cid(&transport_g2h);
>> +		if (cid == VMADDR_CID_ANY)
>> +			cid = vsock_transport_local_cid(&transport_h2g);
> 
> I still prefer the old `if ... else if ...`, what is the reason of this
> change? I may miss the point.

Ah, ok, I've just thought such cascade would be cleaner.

So is this what you prefer?

if (transport_g2h)
	cid = vsock_transport_local_cid(&transport_g2h);
else if (transport_h2g)
	cid = vsock_transport_local_cid(&transport_h2g);

Thanks,
Michal


