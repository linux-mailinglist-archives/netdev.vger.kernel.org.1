Return-Path: <netdev+bounces-213018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12683B22DA3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3997624615
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE72FA0E7;
	Tue, 12 Aug 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AS0PaIDD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24762FA0DD
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015848; cv=none; b=Gx2j1l32MgzbElghmtCYAJogVDPS7hxzTTbyX2aHgXDfS/Bkm6P5OZKj/KxqUs43xF93UgF+8HS1CEfcHvRtg/eebske5nWmXS+sFAaFHWum274YApPudEE+nCA2x45djXcvz4uStDAIvkDfVcNHDi2Q+R3VzaYCIh0ey3Cd9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015848; c=relaxed/simple;
	bh=/ER6f5wKsAdYIZPqBjFZAtf33yzWXq79xrA8udzzwxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJcdJebooJGxa1ZoMetI1m1wPHRMfWjLLlAbkZDSVNhOvIjKlSlxhNSQ+pMEnVQb6WraBlth8YJr7LSjVKOR1yCLZvIzMliuOW+cJfnoSH8JlrfIap12zF92wA7+mhJLHH5Vh3VP/MAGGUBg6Lkr0L05TsTOgEmuirqviWFlViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AS0PaIDD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755015845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maWtxKCUaRWYHdCmxfw96mUNXiNl/KJh+3ma5G2HCtQ=;
	b=AS0PaIDD6YsveOBjZgWwzQ0dRHLUB4Ki9tqAYku+G8uEK+033keADoPtZF/eHrB7feYkGG
	8/QaOFDOuLbBpeQluajqF9WtDkCAJSOes0fN2WANM5aaRWY32pvwvpk8K7i//ZOruR8xrf
	FDxNlKAm642rg0sAFHmlyaOMIqsMJkQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-ZyBgD-MyMsmMTGInYjIgaQ-1; Tue, 12 Aug 2025 12:24:04 -0400
X-MC-Unique: ZyBgD-MyMsmMTGInYjIgaQ-1
X-Mimecast-MFC-AGG-ID: ZyBgD-MyMsmMTGInYjIgaQ_1755015844
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e348600cadso1332901685a.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755015844; x=1755620644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maWtxKCUaRWYHdCmxfw96mUNXiNl/KJh+3ma5G2HCtQ=;
        b=BL8P67PAIhcv/kIAZrCoPIdM8mh7Vf7IeovsQvLjgAhRuip8kvrdWD2dPVLb+UAWh1
         xKyxDjqa0WfILFAaUwPUa6D7P3Z8IBmSdDQ19uwbxvjQubmGEh1sW30mRWIgHtKbQ6jf
         h/Caj28m9db6Y4nXq2yoWaFw8VWovxwxczx4cNCQYyfF05mTkKeqzzbRjsEdUzknISwh
         69wy4iMgttlTUJ3SdNRywjENzNU4LKCaeNRqwuHuUUtBNikWgw0RenvI995w+QeIPp1H
         OjnFgpGx+MI2XpN7LAYHYVWpwBHmGxloVoxrOcRwjdwUr+LNv47hDvQF6B6sKc7h9AMO
         e3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFzY/iprZlLiluq1NtOdRvK0Zv2TesNerF+aLjT10+Em2lE2ApEijTZfdaVXpX9xvNv0gVm7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jPHLpzi3YjdPwsLKwPm7fCFijkOMJIpQwxwNqgWrtCGSW1LR
	o5cgMVtEF+fe48aLrx8ro5Mw3m4v7Yy99EoQEnqjzNfQTxHKEVev7s8VoUAtG0KrRQSrzX7tpa8
	Bu8i/5wzKLve/s9DnM8pazLiJIyxrRfcMfdyOCgPVUXqTW/0Fmgo1qP4XGQ==
X-Gm-Gg: ASbGncv4/duYlk60U8UH4nttRx1WyUMzFzj6+NFngcTJo5A9OIrGTYizlzR02m3/IQS
	0Bl70oU/kNKP3T++Hz9V19XIujrs4QK2VBL12I1lOvcLH9oBnsQ8YPjj06JeQcQkehcpXS4rGUV
	UNcxStwpNwkImrFRm089ZMK/DsFFvH8dmeEPm7U1x6aM4BpItv5IyN+joV9dmW2t5cGNWUiHNom
	Ot70/gZp+hl3RzvUvNXj56HgGdTDmuuqmwsomQSyeWPOSIQuKRmtpeS4sZMytHLPXItOKKVF4qZ
	37XnZjm1XNcib6fwm99O9VktYqFqtDMOBctZie0AFEtBcOuo8WFbK5Yn8NU8hC+C2uMrY/e74Pq
	8mavyrgZKSew=
X-Received: by 2002:a05:620a:9150:b0:7e6:9b39:6f10 with SMTP id af79cd13be357-7e864654550mr35420685a.61.1755015843787;
        Tue, 12 Aug 2025 09:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUZOpIX8ME8P1/zbKmcThEYzGtWD1LRv70+Qx5g144GKeuzIvmx2X7DcVxpCNWPGo7DzZgNw==
X-Received: by 2002:a05:620a:9150:b0:7e6:9b39:6f10 with SMTP id af79cd13be357-7e864654550mr35416685a.61.1755015843245;
        Tue, 12 Aug 2025 09:24:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e69e15f5e0sm1449283685a.69.2025.08.12.09.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 09:24:02 -0700 (PDT)
Message-ID: <50a1e8ea-986c-41f2-899c-746098b6b1b7@redhat.com>
Date: Tue, 12 Aug 2025 18:23:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] tls: handle data disappearing from under the
 TLS ULP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 sd@queasysnail.net, will@willsroot.io, savy@syst3mfailure.io
References: <20250807232907.600366-1-kuba@kernel.org>
 <b3a83032-8ed4-4d5d-9df9-6dbd02acac1c@redhat.com>
 <20250812062825.391c030c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250812062825.391c030c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 3:28 PM, Jakub Kicinski wrote:
> On Tue, 12 Aug 2025 12:45:56 +0200 Paolo Abeni wrote:
>> On 8/8/25 1:29 AM, Jakub Kicinski wrote:
>>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>>> index 549d1ea01a72..51c98a007dda 100644
>>> --- a/net/tls/tls_sw.c
>>> +++ b/net/tls/tls_sw.c
>>> @@ -1384,7 +1384,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>>>  			return sock_intr_errno(timeo);
>>>  	}
>>>  
>>> -	tls_strp_msg_load(&ctx->strp, released);
>>> +	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
>>> +		return tls_rx_rec_wait(sk, psock, nonblock, false);  
>>
>> I'm probably missing something relevant, but I don't see anything
>> preventing the above recursion from going very deep and cause stack
>> overflow.
>>
>> Perhaps something alike:
>>
>> 		released = false;
>> 		goto <function start>
>>
>> would be safer?
> 
> It's a tail call to the same function, the compiler should do that for
> us automatically. Can we not trust the compiler to be sensible? Both
> clang and gcc get it right.

Sound reasonable, I dumbly did not consider it. I'm fine with the patch
in the current form.

/P


