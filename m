Return-Path: <netdev+bounces-160425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EABA19A22
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 22:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF73188485D
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802921C5D48;
	Wed, 22 Jan 2025 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="MwFxacYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4451C3BE6
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737580036; cv=none; b=mdsNbRvskWoMr3O2lDVBMboL8OQDeW11SWaGpG488sEvyXHU9ZKtD+ld96Bh8B5Bv6ZwAkka99sknp5Ne/p8tgD0vI3ShKp+I9fPvcp7Ba/7zwLkdxqganGFNX27Qxosp1rJ4SMDFxifDk3fWRM5m9A8+oqqqk/j88GzELq5iQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737580036; c=relaxed/simple;
	bh=YCX0JJm8fcJFUBgTrrJ5szr6Osr0RcH27eMQFti0McE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6TfT4Iq2vUiVJUJO6fGeKPHQ/6Qo1CRgVu09mFEzUcOh+xMFrKcXNt2FoX82kO20EkhyuutptTr9iA46Vpzou+STH3HJCWxaeaadF6lgff737WTIgUcnBK4gFMp2hSKccQs+3447XHW/+tCyB7PVnNqyUzrMyIID298Et94u+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=MwFxacYZ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tahwJ-004SUe-IB; Wed, 22 Jan 2025 22:07:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=hmrWbbTxefnc98BndVVOSLMebnZm1/mh9e2FMfyE7hA=; b=MwFxacYZj9RKhHXzdFpuFLN7bz
	62G6t5IUDW2zYy1koOBv+Q8PMakYLajjeJM/iYREPv8/PQUByJljHAKSAJmWbnm0dQPV79K3eoG88
	6pAx/twHPFkxlYGVKPQpfY5qR+rI49LZtAkPOzKSRjGrg7Vlg8nXAi0iWcMloHBoKfhZqiAXLmkVF
	PSA7EPvrN1UbD/zYvDk3+UqY9Jpk2ayVF0yBc2Pvmrszwidh25IhPxQThvu4kG7KPt+ge+MpPB0yY
	WsszqXXWgBwmuz/K25DIMPx1OHM7BxtaKelDIkmNu6zV5UB+k1zRdGemN7TPy6kIF96uv+PV0ZqH0
	j/2VFBsA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tahwI-0007Gg-Vp; Wed, 22 Jan 2025 22:07:07 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tahw4-001qAb-Sd; Wed, 22 Jan 2025 22:06:52 +0100
Message-ID: <1b9e780c-033f-4801-ac8a-4ed6ba01656d@rbox.co>
Date: Wed, 22 Jan 2025 22:06:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/6] vsock: Allow retrying on connect() failure
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-2-aad6069a4e8c@rbox.co>
 <sfqi47un2r7swyle27vnwdsp7d4o7kziuqkwb5rh2rfmc23c6y@ip2fseeevluc>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <sfqi47un2r7swyle27vnwdsp7d4o7kziuqkwb5rh2rfmc23c6y@ip2fseeevluc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/25 17:28, Luigi Leonardi wrote:
> On Tue, Jan 21, 2025 at 03:44:03PM +0100, Michal Luczaj wrote:
>> sk_err is set when a (connectible) connect() fails. Effectively, this makes
>> an otherwise still healthy SS_UNCONNECTED socket impossible to use for any
>> subsequent connection attempts.
>>
>> Clear sk_err upon trying to establish a connection.
>>
>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index cfe18bc8fdbe7ced073c6b3644d635fdbfa02610..075695173648d3a4ecbd04e908130efdbb393b41 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1523,6 +1523,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>> 		if (err < 0)
>> 			goto out;
>>
>> +		/* sk_err might have been set as a result of an earlier
>> +		 * (failed) connect attempt.
>> +		 */
>> +		sk->sk_err = 0;
>
> Just to understand: Why do you reset sk_error after calling to 
> transport->connect and not before?

transport->connect() can fail. In such case, I thought, it would be better
to keep the old value of sk_err. Otherwise we'd have an early failing
vsock_connect() that clears sk_err.

> My worry is that a transport might check this field and return an error.
> IIUC with virtio-based transports this is not the case.

Right, transport might check, but currently none of the transports do.


