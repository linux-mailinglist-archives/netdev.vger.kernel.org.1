Return-Path: <netdev+bounces-118815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D650B952D6F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48248B26342
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659A7DA94;
	Thu, 15 Aug 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNUswaMh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98497DA7F
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720984; cv=none; b=nwFZls5BX/9/pUPARZgGQrC/MOBNOc593Cz0EXipemg9bhMimD3SruCO0xhZi3tkgi2q4O15lieYTx1Ky70zUqF0E29507+UwjSvANUwSpcWrdjXv0BB5r3jhRBUFkwA2MwFl3YwKJ6J4b0tKd2DT6jq1ut6xwKcaOCUzAnwQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720984; c=relaxed/simple;
	bh=oHkaD3Mk1Glf1237vxBvqGVWP0H7gRbQ1W8PhzqPpoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7LFv/GJ3xEDK4tWYeqwNZM1yDST9tNKgBDrjosaESSengV5hZ3tfcnASS9Gj4QNylgt6zkLNmQ8BnSrNC854mSRHaR+wIMdiNwcucoN0yNmr/i8SgGDwH0z+AQw4I0XtD1NHkKtbPhAPQ4YqWFzCdpX6xvsm48vKQRa7ndZzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNUswaMh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723720981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPJdIbPZUO+te2AGhX4vVGwGwmVO3a2Gs7mmB0QUjdI=;
	b=NNUswaMhkVRVO2JAuT/+3txW0KPdQNgMgsfATuAVxuvIEM2XVQ5hk24G4T/b3Od534iImW
	JgukiQE/bYKQrcVdohF8n1vkDP0bLf13lPw6C1Yzd4EgS9JBNpjR2VSL463/L4FVjElVQH
	m9/9I9v+k97DSs5EObQ5P/90HVAvio8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-GaRmvt0LMLSCi0TMv4f-5Q-1; Thu, 15 Aug 2024 07:23:00 -0400
X-MC-Unique: GaRmvt0LMLSCi0TMv4f-5Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso1607595e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 04:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720977; x=1724325777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPJdIbPZUO+te2AGhX4vVGwGwmVO3a2Gs7mmB0QUjdI=;
        b=OdyCW5b42be16oBPN4Wa74HM2hPBgy8ysQU8/Y5zRQifAnC8v+47Y5kF2/qJfAf92x
         cDKp3WMOwmzM0X10KSnMZqROQf+reLtl69wlwRVz9fb2OZOgZ3mqty5lM231m1pqS8TI
         Nru+8e8uBjtvbdCd+K7t//o5PWr1u3tHZ1wefOSnhxg6XM0/LMyQ8FLMLDQt95GJeRvM
         0ndDyJ8qqUCDKH4XT8VQfoEFw0N+H2d5lPXUaTPoVp01ls2DLKn1dpM2xvOCQJPu9ksU
         mL8Ifx6xjs4o+6Sh++BsOjhbBGT2QJIihUeYzWuyDwDmfkvqZpsSHg5jaCL2WRYDZ9sd
         P4LA==
X-Forwarded-Encrypted: i=1; AJvYcCWD3CicVEZgCsWwjPrgUBqXahU1LVa/3BxSHKoWblI6E2p/Hx/XdfMGh1A6B9PiZ7ToAi8JW4Hf/SAdvQf5oTXlSN1oF1Ci
X-Gm-Message-State: AOJu0YwYv5IxP2h54s3C+UjZYJUDLMT7TJbj0adJmMgAtmZrO6bx/8fN
	vEsL+jTWdJqA/E8MElwC0gtcb/T6G0oI1lvLuv0YsAdiMEnEKDIHDfuI5NmfhGU1G3deGCuUe06
	xIA+aSbK+fr0ECQeDo61eB/QSZqhwR8CUewJDneLrB3SAFSAr5j63mA==
X-Received: by 2002:a05:6000:2a8:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3718779c4c8mr994094f8f.0.1723720977472;
        Thu, 15 Aug 2024 04:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsio00dWucXBWDAiGRCOt/NvsJLb8l46U2SH15tjbdNJe1xD0OFM/KHZ9vwKjvoHuQxEzSRA==
X-Received: by 2002:a05:6000:2a8:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3718779c4c8mr994077f8f.0.1723720976773;
        Thu, 15 Aug 2024 04:22:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a311sm1260410f8f.23.2024.08.15.04.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 04:22:56 -0700 (PDT)
Message-ID: <dc46f9de-641e-4b38-8661-4efd4859f49b@redhat.com>
Date: Thu, 15 Aug 2024 13:22:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove release/lock_sock in tcp_splice_read
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: sunyiqi <sunyiqixm@gmail.com>, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240815084330.166987-1-sunyiqixm@gmail.com>
 <66bdb158-7452-4f70-836f-bd4682c04297@redhat.com>
 <CAL+tcoAiOwWEsbkqSJ3kpwLxd8seBBUOAODeBideFdQYV7LfWg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoAiOwWEsbkqSJ3kpwLxd8seBBUOAODeBideFdQYV7LfWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/15/24 12:55, Jason Xing wrote:
> On Thu, Aug 15, 2024 at 6:40 PM Paolo Abeni <pabeni@redhat.com> wrote:
> [...]
>>> -             release_sock(sk);
>>> -             lock_sock(sk);
>>
>> This is needed to flush the sk backlog.
>>
>> Somewhat related, I think we could replace the pair with sk_flush_backlog().
>>
> 
> Do you think we could do this like the following commit:
> 
> commit d41a69f1d390fa3f2546498103cdcd78b30676ff
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri Apr 29 14:16:53 2016 -0700
> 
>      tcp: make tcp_sendmsg() aware of socket backlog
> 
>      Large sendmsg()/write() hold socket lock for the duration of the call,
>      unless sk->sk_sndbuf limit is hit. This is bad because incoming packets
>      are parked into socket backlog for a long time. >
> ?

Yep. To be more accurate I was looking at commit 
93afcfd1db35882921b2521a637c78755c27b02c

In any case this should be unrelated from the supposed issue.

Cheers,

Paolo


