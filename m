Return-Path: <netdev+bounces-201324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AD0AE902A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC057B09CD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEB4215798;
	Wed, 25 Jun 2025 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="uEX3HVbe"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79511212B18;
	Wed, 25 Jun 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886652; cv=none; b=Ix8OCR0fk5+cTrkG9hAxQEaB38psVjuKok6uYDDGg4MKJBD/etW76gC5sap3RTFEnMrTopfGH09naFpjGpvHXuFE3bTk+gkL9NS4twx88WuaKt2ldG9Fxnf+YR5X0irN+i7aYeUdOjSFfxzfAa1Ff5V2gCeWhiXdWj1O1YDxrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886652; c=relaxed/simple;
	bh=KEpJcmKGcCYF2L/SDwnju58D5Yhp8c+xA0XOMtXs3d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4Gt9LVdFJ/G/BO2yQlgFQ9MRyICYd3bDJwd9Ztpe11uAJdPPrCqCMptb2o8iSpUGlcglr763yHQFjNz+BkZW+GmMfTO/qS+dFWR6FKZ+3K9HJYYrtQuR0yD0O2UFxbu5lVi29bYqzJZNfLiBIZnMNTFlS2EAQnd/yLigBkBUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=uEX3HVbe; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUXbA-00FIuM-KF; Wed, 25 Jun 2025 23:24:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=pJYr0jfRjntGUQtF5EWSLv9Zz4nbgA73uYDj8Xo5Axk=; b=uEX3HVbeUODZRh4KJFyGUQr2ee
	NHMIG5PInSAFIXJBXfl1wk19fSjUnpGiFm9ap+QuhepbzWJpOKkI2QSpQ4Wqn5mPUc3eyX+FT3rvF
	C8UyB9J+oJ/RUOGiO6na0eN3F/pVdG71WtWQECBoM83HYQ1KcCcDi484eNlrQ1z3hLtQ4hQMxtPht
	qyegM8HDcNErXp011N82z49uEtjMaYbyRoZpJ6WGGN9qJWviF85ClGbnerrLYVVqqnsX18pmhAfDd
	jPgyImoZ+wlic890jVF4bFn69ZzEt0F1K80FNnacpN+c1Jxz+e67w4Ep6X6VqxK4KUZbcvIDKeRO2
	utTGY4vA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUXbA-0002JW-9l; Wed, 25 Jun 2025 23:24:04 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUXb1-004uhN-Rn; Wed, 25 Jun 2025 23:23:55 +0200
Message-ID: <0adde2db-3a75-4ade-a1c8-8c3bc2a0b1fd@rbox.co>
Date: Wed, 25 Jun 2025 23:23:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <uqap2qzmvkfqxfqssxnt5anni6jhdupnarriinblznv5lfk764@qkrjq22xeygb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 10:54, Stefano Garzarella wrote:
> On Fri, Jun 20, 2025 at 09:52:45PM +0200, Michal Luczaj wrote:
>> Support returning VMADDR_CID_LOCAL in case no other vsock transport is
>> available.
>>
>> Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> man vsock(7) mentions IOCTL_VM_SOCKETS_GET_LOCAL_CID vs. VMADDR_CID_LOCAL:
>>
>>   Ioctls
>>       ...
>>       IOCTL_VM_SOCKETS_GET_LOCAL_CID
>>              ...
>>              Consider using VMADDR_CID_ANY when binding instead of
>>              getting the local CID with IOCTL_VM_SOCKETS_GET_LOCAL_CID.
>>
>>   Local communication
>>       ....
>>       The local CID obtained with IOCTL_VM_SOCKETS_GET_LOCAL_CID can be
>>       used for the same purpose, but it is preferable to use
>>       VMADDR_CID_LOCAL.
>>
>> I was wondering it that would need some rewriting, since we're adding
>> VMADDR_CID_LOCAL as a possible ioctl's return value.
> 
> IIRC the reason was, that if we have for example a G2H module loaded, 
> the ioctl returns the CID of that module (e.g. 42). So, we can use both 
> 42 and VMADDR_CID_LOCAL to do the loopback communication, but we 
> encourage to always use VMADDR_CID_LOCAL.  With this change we basically 
> don't change that, but we change the fact that if there is only the 
> loopback module loaded, before the ioctl returned VMADDR_CID_ANY, while 
> now it returns LOCAL rightly.
> 
> So, IMO we are fine.

All right, got it.

>> ---
>> net/vmw_vsock/af_vsock.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index a1b1073a2c89f865fcdb58b38d8e7feffcf1544f..4bdb4016bd14d790f3d217d5063be64a1553b194 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -2577,6 +2577,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>> 		cid = vsock_transport_local_cid(&transport_g2h);
>> 		if (cid == VMADDR_CID_ANY)
>> 			cid = vsock_transport_local_cid(&transport_h2g);
>> +		if (cid == VMADDR_CID_ANY && transport_local)
>> +			cid = VMADDR_CID_LOCAL;
> 
> why not `cid = vsock_transport_local_cid(&transport_local)` like for 
> H2G?

Sure, can do. I've assumed transport_local would always have a local CID of
VMADDR_CID_LOCAL. So taking mutex and going through a callback function to
get VMADDR_CID_LOCAL seemed superfluous. But I get it, if you want to have
it symmetrical with the other vsock_transport_local_cid()s.

Thanks,
Michal


