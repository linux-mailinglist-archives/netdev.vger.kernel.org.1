Return-Path: <netdev+bounces-246172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A15CE4A66
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 10:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9735E300BBAB
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72A0293C42;
	Sun, 28 Dec 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnMecPlS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSPFrPvr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32222417C2
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766913370; cv=none; b=S70AaaWK1eAuUvWy8zbvbWfl5xFktek1QadeKFiU73imymdToQoSHTFlFGLWej+da9ZBgM+D7w8NBcWheNpVLv1dS1nkn2HxV7gerRwhey+STLTmu4KUhsj7DKxdAI+ywLrm9d5CQ8aJQ8nUhaQod2HVxnH4HfMfwhBGyXNsnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766913370; c=relaxed/simple;
	bh=nbWeBZR6XGVP524Smmctu9vgqAt5Q8hidLuEr/btmkk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mb8MPHIb5zd5V8Lkag29G9znnHGsdqvCtDhVRmDe2LorTfMgce5ibmEgS9u/VDHBoze1Fo5zuYQB487XsOpHoBGWlbMVt+LCQr2UlUBx6qIowsL5QnJyNYUeW+Y8RE78x8KDJcGC2zHlJ4FEQc5G8nlm0IQpXQEncqCSqogl/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnMecPlS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSPFrPvr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766913367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vF17mDmjfT93oq9WAWMjwFVEZthCFBo8FRT7pwicBMM=;
	b=CnMecPlSSGODzbxaM1b/RyoTrV6e+SL3kgNVlcjdQKkWPfKCoO68Bmcb3W8hisdDiiDfh/
	3dY/q3DJqaFp6m86bJmbUFKDI+Egj/pTmDM+7gg5RKT+rlPw7ZAX7Pw9vd6A11vEygvRih
	9uxUULZlgABQjQvbZmitumAW5mxOjn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-eLFouX9dNIS6ScirSw_7DA-1; Sun, 28 Dec 2025 04:16:06 -0500
X-MC-Unique: eLFouX9dNIS6ScirSw_7DA-1
X-Mimecast-MFC-AGG-ID: eLFouX9dNIS6ScirSw_7DA_1766913365
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso23004605e9.2
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 01:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766913365; x=1767518165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vF17mDmjfT93oq9WAWMjwFVEZthCFBo8FRT7pwicBMM=;
        b=MSPFrPvrE4v2c2UpchBm0vWkmM5wkaBABcFezaTPG9W9yl68ViqBATTmPNRWYS/YWi
         6Ew1xBmu3fh0jw88syyTDDUn/fOJQpbK/pm0+x0bhUwxVjngpQzaXhi6HfU4210+9RR4
         IZ1YRjzgRL0DaT0DojZM1tZD7M83A8yD00wxGFw79nBkwzUHJXo9EgpdqvJhgbnGiAQZ
         ybrTcZEB6YdaN6NaQ3zZWRyXdzcNFiW9kyEVhyFXJd2SmwE2BWJ6MgWMdlUko7zqxykr
         upJfcWHRlxMj4OgJ1aM7+ysd+L6J7e5YplAxbMLY56+RicvdJWp/8skK6HI3xGHlPv07
         h/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766913365; x=1767518165;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF17mDmjfT93oq9WAWMjwFVEZthCFBo8FRT7pwicBMM=;
        b=gzdgCdp3T2d9nOxjcQdN2GyaCf+ESLMTApBlAoofDdawIzIFIsfwmzPBRI23Wh+x6H
         ZRY1jOXJQ6Q+IR7cqMI1bDtCudXABrYRBiVSpXgv2msT7+30RRFKuxgfx+c+MWNsTlbT
         ZdoNGPs/r8bwue23KYyrMG6Azrd+RjIVigSvEUEQFsW6e7tImlgJXf2YyG/TgzoCZAJB
         LMaqCtf697DRt2NICOoLNMf/+/QObtvK/cVdd8QuL1U5aMlsdRvN8JU5kGrsbhk1lQFe
         3VVzYfpgqJfQZkb8wMyCKKZq/EQ2MuaCsDHZY8/1TUsUCP8uMAkoHhUqAelt+bv96y4L
         RWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6o0/6QZBNk6IGBY7ZL03nr3jBhf4qiKrZHSwa/DWvF0nKu2owNDeUtkCmUf3q3CQK+T2LPdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVRE+FxIVoEbxjaRfadOT0+IJEtDK3ULP1Qh5x73EDbn2hiGR
	ijHPXD48mo40Bmi3hOQnB2JbDvGW2gOqO8HDtvDsBL6DKAw8/7S3s4apP8cQ8Pl8Hh/YWWcIa1d
	YilCIHXIOwyK84hvlvLxtSH4b3PG4jIImNb69iTfgZKiD5WQHv+YWhkc97g==
X-Gm-Gg: AY/fxX4CirbaDrq+uCcte0bPiOOChHXmTNdsaIVY15Zm3oqyQE9hdKVi18NmP68efHF
	DsZmwRP0BJdUMPMq/pIYaRQSWuSWO+w6tzrddxGPfamrmY25+6PguU0HG0ZOjZmKmV+PL/l3aii
	oVcnfZj8E9HorMQcwVBhHNyAeI7I84cSfOtzCQNBT9zS9RcmeSYaDPtTj/arWkAuu6WrRVmvtca
	rOyLOaq2pNPc9d35T0NyYRUp+mezDgA1TlXOxyghPuZVPENkYBWHsnEBbjNHTfLEob9mD5KyuXj
	zNyJvq+9091gqDjncFEMf6a4aKlUWt7snuV8OXmFmR690cDiNIKEW6T1PBf16TDZH+Qi1lRu3O2
	CuGUiJHZFegtwgA==
X-Received: by 2002:a05:600c:46ce:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-47d1953c020mr273497895e9.2.1766913365010;
        Sun, 28 Dec 2025 01:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1b7xKiUe0L9lJ/v6U9MSi8Fz0dXWgM5S/Kld+WqDKFXo/imkAnCu4ZFS2hAooiiE7pN9jOg==
X-Received: by 2002:a05:600c:46ce:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-47d1953c020mr273497725e9.2.1766913364558;
        Sun, 28 Dec 2025 01:16:04 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2724fe8sm627616145e9.1.2025.12.28.01.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 01:16:04 -0800 (PST)
Message-ID: <88741cf8-7649-49e1-8d82-5440fccd618f@redhat.com>
Date: Sun, 28 Dec 2025 10:16:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED
 in nfc_llcp_recv_disc()
From: Paolo Abeni <pabeni@redhat.com>
To: Qianchang Zhao <pioooooooooip@gmail.com>, netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Zhitong Liu <liuzhitong1993@gmail.com>
References: <20251218025923.22101-1-pioooooooooip@gmail.com>
 <20251218025923.22101-2-pioooooooooip@gmail.com>
 <c7851c67-dd52-41d4-b191-807aa5e26d9d@redhat.com>
Content-Language: en-US
In-Reply-To: <c7851c67-dd52-41d4-b191-807aa5e26d9d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/28/25 10:02 AM, Paolo Abeni wrote:
> On 12/18/25 3:59 AM, Qianchang Zhao wrote:
>> nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().
>>
>> In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state,
>> the code used to perform release_sock() and nfc_llcp_sock_put() in the
>> CLOSED branch but then continued execution and later performed the same
>> cleanup again on the common exit path. This results in refcount imbalance
>> (double put) and unbalanced lock release.
>>
>> Remove the redundant CLOSED-branch cleanup so that release_sock() and
>> nfc_llcp_sock_put() are performed exactly once via the common exit path, 
>> while keeping the existing DM_DISC reply behavior.
>>
>> Fixes: d646960f7986 ("NFC: Initial LLCP support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
>> ---
>>  net/nfc/llcp_core.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
>> index beeb3b4d2..ed37604ed 100644
>> --- a/net/nfc/llcp_core.c
>> +++ b/net/nfc/llcp_core.c
>> @@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
>>  
>>  	nfc_llcp_socket_purge(llcp_sock);
>>  
>> -	if (sk->sk_state == LLCP_CLOSED) {
>> -		release_sock(sk);
>> -		nfc_llcp_sock_put(llcp_sock);
> 
> To rephrase Krzysztof concernt, this does not looks like the correct
> fix: later on nfc_llcp_recv_disc() will try a send over a closed socket,
> which looks wrong. Instead you could just return after
> nfc_llcp_sock_put(), or do something alike:
> 
> 	if (sk->sk_state == LLCP_CLOSED)
> 		goto cleanup;
> 
> 	// ...
> 
> 
> cleanup:
> 	release_sock(sk);
> 	nfc_llcp_sock_put(llcp_sock);
> }

I'm sorry for the confusing feedback above.

I read the comments on patch 2/2 only after processing this one.

Indeed following the half-interrupted discussion on old revision, with
bad patch splitting is quite difficult.

@Qianchang Zhao: my _guess_ is that on LLCP_CLOSED the code has to
release the final sk reference... In any case discussion an a patch
series revision is not concluded until the reviewer agrees on that.

@Krzysztof: ... but still it looks like in the current code there is a
double release on the sk socket lock, which looks wrong, what am I
missing here?

/P


