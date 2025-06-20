Return-Path: <netdev+bounces-199799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF0AE1D37
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE31A5A38A2
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF728DB4A;
	Fri, 20 Jun 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="k8To1SOW"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21634C79;
	Fri, 20 Jun 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429416; cv=none; b=F8+uSou8QNnkox1zxYB4voNtEccd88akpIOZlptO1yYty7jzGdkODxWo3m7DbrQThyojnLP5BPMJgwo8WlYWu0bpI3ZcPsjcvpnZieZtd3zrh5AptDH9etQgdTHn0YavsGjPmHMPHyOOrzkFhJJKfIIFA4DKHAfj1SP/PZsKqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429416; c=relaxed/simple;
	bh=l3XhOSHTNZroVMzNR2+6Q0mvyT4UKPGMoBHQBADHQ9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCKAzDYGois9VPJo7SiVrcc7ioPkmkaZ2l8YJrdh6NtEPTaw7MGqrolXTud41VcVjI8vYBEq+EKJz4LSMtBRWRRWU6BITYX5M/y8v9b8SQFflFZaWZSbCh9+YUv0vJQKP8RTwJaThZIELZg+9Z0wpjVqAYPi0y13oi8XqFpveAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=k8To1SOW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uSceN-000HOY-EW; Fri, 20 Jun 2025 16:23:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=lP0loMAPyzVsIfOKqivfcGIEGx4G4b6mLzOjVforSRw=; b=k8To1SOWxESaEvwsZjVHOaDPB6
	QWuH5oErGRcVMtY549ZwXrZwq7FuaK8DQOh081vxbvJjyY+dd71T2OJp99C2K3g5rpLL0oxI9kiVA
	MJIntIV0ziPnpOMw18fLGHFBT6/cPJyV2AI5i+cCf/d6xegyAxE5uog6JPWjrdYtjX8rZXtQRVlNr
	IZzOIlgWCcmOWKefUUkkKsD4i1fsLrp47MnAODa5U+jn+TUV/2tNfO5iv+sl4ls0v+rQpZCquZbFQ
	ldYNlPrv6aagh29KSFjIN/2CcVFQn7CenFpU1m2QHHKkLptT+NWSLrUyR2zrZ2GZZtRbRw6Npbwxt
	Lu2f1HQQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uSceM-0003PV-2L; Fri, 20 Jun 2025 16:23:26 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uSceD-00B7zB-D6; Fri, 20 Jun 2025 16:23:17 +0200
Message-ID: <4f0e2cc5-f3a0-4458-9954-438911e7d104@rbox.co>
Date: Fri, 20 Jun 2025 16:23:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] vsock: Fix transport_{h2g,g2h} TOCTOU
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
 <20250618-vsock-transports-toctou-v1-1-dd2d2ede9052@rbox.co>
 <r2ms45yka7e2ont3zi5t3oqyuextkwuapixlxskoeclt2uaum2@3zzo5mqd56fs>
 <fd2923f1-b242-42c2-8493-201901df1706@rbox.co>
 <cg25zc7ktl6glh5r7mfxjvbjqguq2s2rj6vk24ful7zg6ydwuz@tjtvbrmemtpw>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <cg25zc7ktl6glh5r7mfxjvbjqguq2s2rj6vk24ful7zg6ydwuz@tjtvbrmemtpw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 15:20, Stefano Garzarella wrote:
> On Fri, Jun 20, 2025 at 02:58:49PM +0200, Michal Luczaj wrote:
>> On 6/20/25 10:32, Stefano Garzarella wrote:
>>> On Wed, Jun 18, 2025 at 02:34:00PM +0200, Michal Luczaj wrote:
>>>> Checking transport_{h2g,g2h} != NULL may race with vsock_core_unregister().
>>>> Make sure pointers remain valid.
>>>>
>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>>> Call Trace:
>>>> __x64_sys_ioctl+0x12d/0x190
>>>> do_syscall_64+0x92/0x1c0
>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>
>>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> ---
>>>> net/vmw_vsock/af_vsock.c | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..047d1bc773fab9c315a6ccd383a451fa11fb703e 100644
>>>> --- a/net/vmw_vsock/af_vsock.c
>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>> @@ -2541,6 +2541,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>>>
>>>> 	switch (cmd) {
>>>> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>>>> +		mutex_lock(&vsock_register_mutex);
>>>> +
>>>> 		/* To be compatible with the VMCI behavior, we prioritize the
>>>> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>>>> 		 */
>>>> @@ -2549,6 +2551,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>>> 		else if (transport_h2g)
>>>> 			cid = transport_h2g->get_local_cid();
>>>>
>>>> +		mutex_unlock(&vsock_register_mutex);
>>>
>>>
>>> What about if we introduce a new `vsock_get_local_cid`:
>>>
>>> u32 vsock_get_local_cid() {
>>> 	u32 cid = VMADDR_CID_ANY;
>>>
>>> 	mutex_lock(&vsock_register_mutex);
>>> 	/* To be compatible with the VMCI behavior, we prioritize the
>>> 	 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>>> 	 */
>>> 	if (transport_g2h)
>>> 		cid = transport_g2h->get_local_cid();
>>> 	else if (transport_h2g)
>>> 		cid = transport_h2g->get_local_cid();
>>> 	mutex_lock(&vsock_register_mutex);
>>>
>>> 	return cid;
>>> }
>>>
>>>
>>> And we use it here, and in the place fixed by next patch?
>>>
>>> I think we can fix all in a single patch, the problem here is to call
>>> transport_*->get_local_cid() without the lock IIUC.
>>
>> Do you mean:
>>
>> bool vsock_find_cid(unsigned int cid)
>> {
>> -       if (transport_g2h && cid == transport_g2h->get_local_cid())
>> +       if (transport_g2h && cid == vsock_get_local_cid())
>>                return true;
>>
>> ?
> 
> Nope, I meant:
> 
>   bool vsock_find_cid(unsigned int cid)
>   {
> -       if (transport_g2h && cid == transport_g2h->get_local_cid())
> -               return true;
> -
> -       if (transport_h2g && cid == VMADDR_CID_HOST)
> +       if (cid == vsock_get_local_cid())
>                  return true;
> 
>          if (transport_local && cid == VMADDR_CID_LOCAL)

But it does change the behaviour, doesn't it? With this patch, (with g2h
loaded) if cid fails to match g2h->get_local_cid(), we don't fall back to
h2g case any more, i.e. no more comparing cid with VMADDR_CID_HOST.

> But now I'm thinking if we should also include `transport_local` in the 
> new `vsock_get_local_cid()`.
> 
> I think that will fix an issue when calling 
> IOCTL_VM_SOCKETS_GET_LOCAL_CID and only vsock-loopback kernel module is 
> loaded, so maybe we can do 2 patches:
> 
> 1. fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`
>     Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")

What would be the transport priority with transport_local thrown in? E.g.
if we have both local and g2h, ioctl should return VMADDR_CID_LOCAL or
transport_g2h->get_local_cid()?

> 2. move that code in vsock_get_local_cid() with proper locking and use 
> it also in vsock_find_cid()
> 
> WDYT?

Yeah, sure about 1, I'll add it to the series. I'm just still not certain
how useful vsock_get_local_cid() would be for vsock_find_cid().


