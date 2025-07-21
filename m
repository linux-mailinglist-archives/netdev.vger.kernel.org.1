Return-Path: <netdev+bounces-208545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D82B0C1B4
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC1A18C19EC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2FA286889;
	Mon, 21 Jul 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGu2jwug"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB928C5BE
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095051; cv=none; b=KBQwO/ZOyySzPTMRu6c2s04HH4+IoKU+woYRfH8MpDyfWA+FSqVeTo1Bg8TYd2C3psu25WDHEiJSYr8KDHVaTws07SEMpSgZoniKnzLceV2MLfsuHKSPal0G2tY2YCPthHg2JgrNqtFeoAR1pw3CVJq5huufslLdZHPg7CwpnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095051; c=relaxed/simple;
	bh=2CZYKaEq5g6GHChLwykhoaeWGTojHcAFNR4tJ/lzdB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jr2PIpEs7hy1AWGzW9qNGKF1ORpuNMphau3drnyHB8W5STZyFcoJJt2uFEaj7vy5ccTP056Un9+XXYAdHS9cvxhZAWrTipu4XFXfiPortmdruCi+zMrMoCRLJbuHT+0N1yG7cBemqkVXba0LYqAD/m8IMeYNJbskubsd1wLpEaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGu2jwug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753095047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRpQ4DxFMGmlwfitlWtBNmR9ufdYNudda4uozyzE9ZY=;
	b=CGu2jwugHZcm3XO3K6nTXood2nLVJWF+jVoVsLXJMnSDqWD0Xf9BH3uNEymtA63nbqV6go
	ax666WQ34Sps0xCVJP5kj4DcFoxEvHsav9SiJWRdq80P60BayCCyvYNPEosmIXOeYqiEW+
	izxQQVZdCct1yM3zaTNJL54gojt3JWw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-lP9hJyvePIKtUen_ItTfIw-1; Mon, 21 Jul 2025 06:50:45 -0400
X-MC-Unique: lP9hJyvePIKtUen_ItTfIw-1
X-Mimecast-MFC-AGG-ID: lP9hJyvePIKtUen_ItTfIw_1753095043
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a58939191eso1855767f8f.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095043; x=1753699843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRpQ4DxFMGmlwfitlWtBNmR9ufdYNudda4uozyzE9ZY=;
        b=iAJvXaTe6iMZWqiobA7qAIMzbrIJNhw+J1b28tl3KuyFCedqb/PC4uQ6di3Duec9Lf
         y4Z+bQfSo00VHYVry6CAS6eOu/us5uclpGjAhFSmly8bb30OvyErztUqkjZVw9c+18o2
         hKUstdeTWEJfLO6l/CUAQG0NjIXmJDf2MkEyP4gR9p5yCjBYYC5R83Fi3wd/wi88vOeu
         DSjQxOofsWKhVmm298kzt5cidkuLDXpqZt7LjjZS6wZSH33RxUJLWEMd+gduWZ9IOwV2
         gm6bM9J5pdJSJkMn7qVDljs35CTWMOcBbkSEZf4t0pExkQQ46Z8FqHLUjW/xdBWQFk+B
         Z5Ag==
X-Gm-Message-State: AOJu0YziuZmFiS3CBdv9JUsd7XTXOM67UaQArKDI8kRtIgiaPGHbqwHv
	1gwrhGB9dWOAvhXUacUyeuyjrw1jaZvu9L5osqlEfnQP8HdnWUggHJCc9gNbajRDW8i7gm3iTcl
	tKU0yrhaMqptZpEKzt4q2X3gCbm+XnyLOc3+bLJ3wA4GqY2VI+6S8Gebr9g==
X-Gm-Gg: ASbGnctH5eRPPd0mmxyWyqcGe1asDjoQx4H8qqy9Lql595CU3CbT2cw79+oIeOO19GX
	5/tueRJpSn5byDh4MxIBVuLUBNnhxiZPUhZO16oAN3Q0naGZPSWXrc3UZU2/CAsVSMqtyv+19Cl
	pdZAeRPvye/H1jFUBvf8SI3nTQzoFQsC35Tmm9sGpoP5wZpMzNLUfgiUT3Kad92j75NizsO5xeN
	zXx1hv63ll3xbVtber0g+HmbB9iuqFzENfqfIUstUHG/A53pgwURjw4WGVpJVhRmVNDM981gGIl
	ZdvV7k5u3ssUXq/3XhDGRKOXM3fvBrtHChFLck5qG4mbp4ub2CW17IB5Yztp3/B2NPALYCXS1wZ
	SREGg4/GmgTQ=
X-Received: by 2002:a05:6000:280a:b0:3b6:18e5:6ec4 with SMTP id ffacd0b85a97d-3b618e57009mr5855734f8f.30.1753095043430;
        Mon, 21 Jul 2025 03:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuUW6Nzh2QxXperrpR1wmL5Qrh5x+MKNSKk5UaO8ZvDvNAwuzu5QXkbLSE9x9tnNUFmnh0OA==
X-Received: by 2002:a05:6000:280a:b0:3b6:18e5:6ec4 with SMTP id ffacd0b85a97d-3b618e57009mr5855715f8f.30.1753095042919;
        Mon, 21 Jul 2025 03:50:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2b803sm9769561f8f.19.2025.07.21.03.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 03:50:42 -0700 (PDT)
Message-ID: <f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com>
Date: Mon, 21 Jul 2025 12:50:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Matthieu Baerts <matttbe@kernel.org>
References: <cover.1752859383.git.pabeni@redhat.com>
 <3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
 <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 10:04 AM, Eric Dumazet wrote:
> On Fri, Jul 18, 2025 at 10:25 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> The nipa CI is reporting frequent failures in the mptcp_connect
>> self-tests.
>>
>> In the failing scenarios (TCP -> MPTCP) the involved sockets are
>> actually plain TCP ones, as fallback for passive socket at 2whs
>> time cause the MPTCP listener to actually create a TCP socket.
>>
>> The transfer is stuck due to the receiver buffer being zero.
>> With the stronger check in place, tcp_clamp_window() can be invoked
>> while the TCP socket has sk_rmem_alloc == 0, and the receive buffer
>> will be zeroed, too.
>>
>> Pass to tcp_clamp_window() even the current skb truesize, so that
>> such helper could compute and use the actual limit enforced by
>> the stack.
>>
>> Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  net/ipv4/tcp_input.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 672cbfbdcec1..c98de02a3c57 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -610,24 +610,24 @@ static void tcp_init_buffer_space(struct sock *sk)
>>  }
>>
>>  /* 4. Recalculate window clamp after socket hit its memory bounds. */
>> -static void tcp_clamp_window(struct sock *sk)
>> +static void tcp_clamp_window(struct sock *sk, int truesize)
> 
> 
> I am unsure about this one. truesize can be 1MB here, do we want that
> in general ?

I'm unsure either. But I can't think of a different approach?!? If the
incoming truesize is 1M the socket should allow for at least 1M rcvbuf
size to accept it, right?

> I am unsure why MPTCP ends up with this path.
> 
>  LINUX_MIB_PRUNECALLED being called in normal MPTCP operations seems
> strange to me.

The code path hit:

	!tcp_can_ingest(sk, skb)

in tcp_try_rmem_schedule(). Perhaps the scaling_ratio is a bit
optimistic due to unfortunate packet layouts?

Let me check if I can grab more data.

Thanks,

Paolo


