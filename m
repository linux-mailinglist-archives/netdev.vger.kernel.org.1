Return-Path: <netdev+bounces-199754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1C2AE1B58
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270155A44F2
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228428B4F0;
	Fri, 20 Jun 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EHG1iWW4"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0728AB11;
	Fri, 20 Jun 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424341; cv=none; b=VAM24dqbOBf8CNVOVfq4mUdgFQlnbmD1TZSoISx62mMaILOQ0HQ/t832aVm8AsdqhZqdogS2C+sfelVLNuYLwUvqQrKsZfrPffVTzTV/aX08EGPVhDhud4a5JrOPdrHiHZve+Xzs6tQavjMwUdvWTyI44xBijtbRt7D2gWTGOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424341; c=relaxed/simple;
	bh=KIYnJyvfLLQZY8dOiAzbOJCNFpN9oV15l1W65TMa9q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1u+afvOpxmxQRaWTn71qrOmq6GTXqpa/V8DNqEy+hH3Jhkwa5XRrGYXj4s5fo6G/RP+L1EVuXtbKPJj2j8IAapP4FExshwL34WDtyHi5HTr8hXS1fqTyrrz0okO2RzNEMNj5jAXVSsNQ2tm7KDs0UMRRXN85TimwV9n2BxgYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EHG1iWW4; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uSbKW-00HLP1-Rv; Fri, 20 Jun 2025 14:58:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=UJ5ca2MMOgMZ7TfbXbB+tMHmzuecN31xCJX2LHjhkXY=; b=EHG1iWW4prYz57diPMlrZfKzRd
	Wm5yHA6y+2DnHSwKSCDjdnVn6GB7+/3KynUgYybTQ2gelTklCJrUa0tB66sE6IEigz9VmSDaAdZyR
	aE5x8pR/jgzdqWO2qT0F/lsG7UmHErTNafMRngOe+4mAjl7S0kwgL9zObOmIV3K/AXK3spnf8BqCQ
	swLAQztNr/5nEzpVo6wwg1TGQLFpq9LRbgLH+Lotx7pY+e/ndzrUA5lMfwuaT2gzu6q/F91njuz5E
	ypDo1p3svj4MQM5hb5XR4eelQ25AGj3XMaJ1Yl8pUExrGZzAKDJVfsEl6RnzjzpnzrTep47YtEaEw
	5XKGpcoA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uSbKW-0003JG-7c; Fri, 20 Jun 2025 14:58:52 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uSbKU-00Ammu-RA; Fri, 20 Jun 2025 14:58:50 +0200
Message-ID: <fd2923f1-b242-42c2-8493-201901df1706@rbox.co>
Date: Fri, 20 Jun 2025 14:58:49 +0200
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
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <r2ms45yka7e2ont3zi5t3oqyuextkwuapixlxskoeclt2uaum2@3zzo5mqd56fs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 10:32, Stefano Garzarella wrote:
> On Wed, Jun 18, 2025 at 02:34:00PM +0200, Michal Luczaj wrote:
>> Checking transport_{h2g,g2h} != NULL may race with vsock_core_unregister().
>> Make sure pointers remain valid.
>>
>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>> Call Trace:
>> __x64_sys_ioctl+0x12d/0x190
>> do_syscall_64+0x92/0x1c0
>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..047d1bc773fab9c315a6ccd383a451fa11fb703e 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -2541,6 +2541,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>
>> 	switch (cmd) {
>> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>> +		mutex_lock(&vsock_register_mutex);
>> +
>> 		/* To be compatible with the VMCI behavior, we prioritize the
>> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>> 		 */
>> @@ -2549,6 +2551,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>> 		else if (transport_h2g)
>> 			cid = transport_h2g->get_local_cid();
>>
>> +		mutex_unlock(&vsock_register_mutex);
> 
> 
> What about if we introduce a new `vsock_get_local_cid`:
> 
> u32 vsock_get_local_cid() {
> 	u32 cid = VMADDR_CID_ANY;
> 
> 	mutex_lock(&vsock_register_mutex);
> 	/* To be compatible with the VMCI behavior, we prioritize the
> 	 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
> 	 */
> 	if (transport_g2h)
> 		cid = transport_g2h->get_local_cid();
> 	else if (transport_h2g)
> 		cid = transport_h2g->get_local_cid();
> 	mutex_lock(&vsock_register_mutex);
> 
> 	return cid;
> }
> 
> 
> And we use it here, and in the place fixed by next patch?
> 
> I think we can fix all in a single patch, the problem here is to call 
> transport_*->get_local_cid() without the lock IIUC.

Do you mean:

 bool vsock_find_cid(unsigned int cid)
 {
-       if (transport_g2h && cid == transport_g2h->get_local_cid())
+       if (transport_g2h && cid == vsock_get_local_cid())
                return true;

?

So we need to check transport_g2h twice; in vsock_find_cid() and then again
in vsock_get_local_cid(), right?


