Return-Path: <netdev+bounces-202289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDBAED141
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306B83B526F
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8A20E71D;
	Sun, 29 Jun 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="o4N6MLkz"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691461DED53;
	Sun, 29 Jun 2025 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751232425; cv=none; b=VaHKS7M74SlqLNiBDGarzNxvKEoj50QvmU4v43sSecj+/WX8ZcCssYonyo30+rvpUb21iAnY4GIBDbJEYb99oMyk4HcAGJU9sCGlos7+epVo6fgi1+jvcjDdt2cmaomJSpSOmaGAbmyW4r3Z810FRqMRAGUxvcHlyyY9zyKt2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751232425; c=relaxed/simple;
	bh=35S/WivfntZxWsMNhWhCyaWvXHIb/3hZKJWCDgxo7Ek=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eJjvlpm6dZFTXtMeoJU8TihxxycN1RcbOf/SAOxmdG5CGK7Ge7ZIrCq489eHzlsBYS9BmzEoOyzY6G+70bG8lHXcHW9npxl3L7phh8Z4pKbCHBbE4SE8I4AlG+h8BMFkXNRRFcovWeillDiok4Gd0lZGo+6PT10dbXJ0LwWATsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=o4N6MLkz; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uVzY1-009BTz-LU; Sun, 29 Jun 2025 23:26:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=3Db7t+Id+WCD6+D4JwBwuk89pQUuYtBqYMAcKOc5Fss=; b=o4N6MLkzWh1r19m6HFK0d+6YTg
	T7pPUK8UCnT312kREsQ2L4O8+DW/Dcxj3Frc9S+KYXhJMwZQpFcvWww14XJoXhp1HKhroPcUSaB2q
	/nGZpDl1JAw7bK58v1oGw9Rz0DtRievQGfzZatyIdT+/qhSsW4B7fWbNM6/GHpFg7RDOPvIUzOzmw
	262G13rlfCtn7HojyAu4kgxb3lG0ou016eZM222yJyjmr9FOgfJR01JCcgI83FfiCHsltAPlgXBWa
	iakJS9zDpZKwfWGoQ2+0z0TsXu7703eXpXF0iwpcd1CZc8qmrvqwuPwQv5IeDme9Y15l9Mx3fep8P
	793IPWPA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uVzY1-0008T7-CP; Sun, 29 Jun 2025 23:26:49 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uVzXi-00CwbT-B8; Sun, 29 Jun 2025 23:26:30 +0200
Message-ID: <65da0d87-7b84-409f-9ffa-2ae4e0c9c745@rbox.co>
Date: Sun, 29 Jun 2025 23:26:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH RFC net v2 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID
 to check also `transport_local`
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-3-02ebd20b1d03@rbox.co>
 <uqap2qzmvkfqxfqssxnt5anni6jhdupnarriinblznv5lfk764@qkrjq22xeygb>
 <0adde2db-3a75-4ade-a1c8-8c3bc2a0b1fd@rbox.co>
 <b3fx4pma6l2zgfw7azvzliqfwu3ldjdlvbnegmzcuef5ryldux@2mbc5qsgkf45>
Content-Language: pl-PL, en-GB
In-Reply-To: <b3fx4pma6l2zgfw7azvzliqfwu3ldjdlvbnegmzcuef5ryldux@2mbc5qsgkf45>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 10:10, Stefano Garzarella wrote:
> On Wed, Jun 25, 2025 at 11:23:54PM +0200, Michal Luczaj wrote:
>> On 6/25/25 10:54, Stefano Garzarella wrote:
>>> On Fri, Jun 20, 2025 at 09:52:45PM +0200, Michal Luczaj wrote:
>>>> Support returning VMADDR_CID_LOCAL in case no other vsock transport is
>>>> available.
>>>>
>>>> Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> ---
>>>> man vsock(7) mentions IOCTL_VM_SOCKETS_GET_LOCAL_CID vs. VMADDR_CID_LOCAL:
>>>>
>>>>   Ioctls
>>>>       ...
>>>>       IOCTL_VM_SOCKETS_GET_LOCAL_CID
>>>>              ...
>>>>              Consider using VMADDR_CID_ANY when binding instead of
>>>>              getting the local CID with IOCTL_VM_SOCKETS_GET_LOCAL_CID.
>>>>
>>>>   Local communication
>>>>       ....
>>>>       The local CID obtained with IOCTL_VM_SOCKETS_GET_LOCAL_CID can be
>>>>       used for the same purpose, but it is preferable to use
>>>>       VMADDR_CID_LOCAL.
>>>>
>>>> I was wondering it that would need some rewriting, since we're adding
>>>> VMADDR_CID_LOCAL as a possible ioctl's return value.
>>>
>>> IIRC the reason was, that if we have for example a G2H module loaded,
>>> the ioctl returns the CID of that module (e.g. 42). So, we can use both
>>> 42 and VMADDR_CID_LOCAL to do the loopback communication, but we
>>> encourage to always use VMADDR_CID_LOCAL.  With this change we basically
>>> don't change that, but we change the fact that if there is only the
>>> loopback module loaded, before the ioctl returned VMADDR_CID_ANY, while
>>> now it returns LOCAL rightly.
>>>
>>> So, IMO we are fine.
>>
>> All right, got it.
>>
>>>> ---
>>>> net/vmw_vsock/af_vsock.c | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>> index a1b1073a2c89f865fcdb58b38d8e7feffcf1544f..4bdb4016bd14d790f3d217d5063be64a1553b194 100644
>>>> --- a/net/vmw_vsock/af_vsock.c
>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>> @@ -2577,6 +2577,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>>> 		cid = vsock_transport_local_cid(&transport_g2h);
>>>> 		if (cid == VMADDR_CID_ANY)
>>>> 			cid = vsock_transport_local_cid(&transport_h2g);
>>>> +		if (cid == VMADDR_CID_ANY && transport_local)
>>>> +			cid = VMADDR_CID_LOCAL;
>>>
>>> why not `cid = vsock_transport_local_cid(&transport_local)` like for
>>> H2G?
>>
>> Sure, can do. I've assumed transport_local would always have a local CID of
>> VMADDR_CID_LOCAL. So taking mutex and going through a callback function to
>> get VMADDR_CID_LOCAL seemed superfluous. But I get it, if you want to have
>> it symmetrical with the other vsock_transport_local_cid()s.
> 
> Yeah, BTW for transport_h2g is the same, they always should return 
> VMADDR_CID_HOST, so I think we should be symmetrical.

Heh, I've missed that VMADDR_CID_HOST completely :)

Thanks,
Michal


