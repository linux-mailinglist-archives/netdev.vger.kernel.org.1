Return-Path: <netdev+bounces-236414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C981DC3BF5F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BE18972BB
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8419334C24;
	Thu,  6 Nov 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeVVNqYh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GF89fZyq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7F1FCFEF
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441490; cv=none; b=uKYrEq3OSjbkhfwp8WsQOTKPtSl/PimROBiVUNC1gM4P9eeHwT7aomrnnUON8RJacaytSwomDVW/vGmMz/UJBIeXSIh+eRaKJ6attjQvPPB9YN8txCAEbYLaET1vXoYI0VB5cDtwHspauaPZg0eD1XcCMbr0M2bOMLKsYCqzdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441490; c=relaxed/simple;
	bh=PQ5No5hZSmgmGqg5+iQ28DDZkSeRQR2T2rRjI0K5Vv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4QaZECciqSrfKLb0wTcTPSIRMSTt/o8zetisXua8QwxBlIuIctnm0flsWV4+NB3/OrjSMfJTB0E1nD9FkqdK+dSuCEUEwrDiGFKVP4mYWjomtjTvZ8q/KZE4jpLHf9K/VWM330w4hPu58D+4DtbN8FjnTxHkx4po+8KSw29TXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HeVVNqYh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GF89fZyq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762441487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUJRA39E1s7TgQLtsgYBhAt4MEyjWtwC5B/uGX1m8fY=;
	b=HeVVNqYhYFWYo8/ieo3DQx/Ir5YdjxYw2uj/fzsFeiWeqdnlXkmaL0FPt1bWRxN1ubyP9t
	BgJHj5ujchTZRR1xNYgQGVwJfJLo0NdGu5h2cGrl8BPqhpLheJc3URfqZZ0VozDICb5Cdf
	7V9li0OSSSGzAnXlfApGACophBIZjZA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-v79lLdZmPLWyMFwO_T3KLA-1; Thu, 06 Nov 2025 10:04:44 -0500
X-MC-Unique: v79lLdZmPLWyMFwO_T3KLA-1
X-Mimecast-MFC-AGG-ID: v79lLdZmPLWyMFwO_T3KLA_1762441483
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106720618so8509605e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762441483; x=1763046283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUJRA39E1s7TgQLtsgYBhAt4MEyjWtwC5B/uGX1m8fY=;
        b=GF89fZyqz8wq62MPiI/2MXXwuuXaF3AUsthjUx7X3ippXi+sYz/l3TnitzJvllSLFL
         wo6fgI+SmNzMOiqq8H/C+tXDybFsZgv6s33DRwINt3OUj98bscpv1EGQEikMN01rPdHE
         a7AuRDKhEY8ETxQTMkKIT4sU5hkcxhbfmJeT+15poRvOLFFyPbehRiXMGQALeembMuYd
         O17lKvsNrgpN/LtlD1+YWYkw45o9DBsbtg43ac334zo6sT18jBwWEkDsFFGBVPCcexSU
         Wzi0c2g/aEXmM3J/TBACMwvipUq79QWDlEgdppDLQWFbv2ujTQ9LcZ5ZbobqMAI0ernA
         7AgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441483; x=1763046283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUJRA39E1s7TgQLtsgYBhAt4MEyjWtwC5B/uGX1m8fY=;
        b=ficuK9cJu3AaNjTJe9CMhNYrG4Y4HpKLJwiY1LSkwtOf5SMTS28OTnTwsRqKTa2/QM
         Dqzh7E19grZ9hUzUn+7/LJdHNCN19zaWakqa1pTpRxwmF4tLTpdhluL/O8PruRZMDFDc
         f3u4J1DdvPw+uN+0yIQDvTxOz9KU73HdZTUSZSw/iWN3uQ5W1Gr/4Rt1shfomuUwRw2/
         FjiLgkQppgOeEtmisztfL2SAsTRxUTx+R9SW2MkXjw+AHjqclfVQ4F1pMcITUeM1Q8hB
         OwtA95lUym7RlCAS0F8RMPJnI9PtFthBAnQVwc7RxaPaywrimxNeNzZkIffWDXs0mYQw
         DHMA==
X-Forwarded-Encrypted: i=1; AJvYcCXU2/hxJS6pH/gm5/992lYvYptpcYMg6sWNqIXlg9nUzIJYGloJIURR8O6+fJORFyxQwQUdi7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTA7BVtF8x5vX1/pZ74q3ZRtS17qS2E7v9wm7IgBJw5g0v3Cg
	rxH8dEtatHWqNEgLJizZaQBrnVYkUsXbfAfj+UDJalUb1clXov1lfWqYyIxOQJmoWe2ZDlhorvU
	sJ6A5WWvExQ46acR3nPW+04XaawdeC0ua4isEqDHPel80I8JtYsRzmnjbtQ==
X-Gm-Gg: ASbGncvSIoNHKclKIpXRP57lKxJ5+uts4oxVrXZJyayPJb9+ssY9GfbgXEaCLoQeivo
	D+r86GuDt6PZ1rXl7AxLmlG03CcPkiLHRVyCArn65Jut9HqqiYUfu/oC+6p0Y2HJ/w2Q4inMKtp
	EnLiI1sb9/sA5/2NhYe/lRu3cMcqtsNIudAWv4FGqR4FHlPgayOG070aXUazjjF3lKVfayxNLFI
	vIkhLKXM7I1BEaCIW02SVcWN6DCHhCUbFIPEv7Juo1uCVYV0yuc94aiuxMSAuJ4Wy57xfXFfM/Q
	Sqd4HR1xBKi7HIKrqckf4iBZP5emKNAViaKGeLxXs54SSjAM9NfrkyQ8GD+SenukeXdSA/8v0K2
	3FA==
X-Received: by 2002:a05:600c:3b13:b0:471:115e:624b with SMTP id 5b1f17b1804b1-4775cdcf9aamr70151965e9.17.1762441482623;
        Thu, 06 Nov 2025 07:04:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6KAQ2WEctCjGzvorvUYBqoUPDrgbaWUZ++9zneDrC2B9sVjsu3rfCx5iL3l2lJ+Jpi7V+xw==
X-Received: by 2002:a05:600c:3b13:b0:471:115e:624b with SMTP id 5b1f17b1804b1-4775cdcf9aamr70151445e9.17.1762441481919;
        Thu, 06 Nov 2025 07:04:41 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fba3esm19161105e9.6.2025.11.06.07.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:04:41 -0800 (PST)
Message-ID: <fbe1bbe2-3ecb-4d9b-8571-f1da6faee98d@redhat.com>
Date: Thu, 6 Nov 2025 16:04:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: add prefetch() in skb_defer_free_flush()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251106085500.2438951-1-edumazet@google.com>
 <8ef591e6-9b05-4c7b-8d75-82ced4dd2f31@redhat.com>
 <CANn89iJwTydUJG4docxfc0soY98BU7=g-nh+ZAvRi6qD5Bt_Ow@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iJwTydUJG4docxfc0soY98BU7=g-nh+ZAvRi6qD5Bt_Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 10:13 AM, Eric Dumazet wrote:
> On Thu, Nov 6, 2025 at 1:05 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 11/6/25 9:55 AM, Eric Dumazet wrote:
>>> skb_defer_free_flush() is becoming more important these days.
>>>
>>> Add a prefetch operation to reduce latency a bit on some
>>> platforms like AMD EPYC 7B12.
>>>
>>> On more recent cpus, a stall happens when reading skb_shinfo().
>>> Avoiding it will require a more elaborate strategy.
>>
>> For my education, how do you catch such stalls? looking for specific
>> perf events? Or just based on cycles spent in a given function/chunk of
>> code?
> 
> In this case, I was focusing on a NIC driver handling both RX and TX
> from a single cpu.
> 
> I am using "perf record -g -C one_of_the_hot_cpu sleep 5; perf report
> --no-children"
> 
> I am working on an issue with napi_complete_skb() which has no NUMA awareness.

Many thanks for sharing!
> With the following WIP series, I can push 115 Mpps UDP packets
> (instead of 80Mpps) on IDPF.
> I need more tests before pushing it for review, but the prefetch()
> from skb_defer_free_flush()
> is a no-brainer.

FWIW, the napi_complete_skb() makes sense to me, looking forward to it!

/P


