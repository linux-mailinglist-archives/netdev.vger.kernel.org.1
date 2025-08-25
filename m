Return-Path: <netdev+bounces-216640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C752B34B89
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966171A810C4
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025062857FA;
	Mon, 25 Aug 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZ5MYoxm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C422C355
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152774; cv=none; b=nbvcbWqPfK6yRq2SS1amAjAbrQ61lnKuuoso6gziUMbylMvNYNyMbSDF/uRN9LX50sSwwx6Et0jp0rmXbf8Ma3tKZNn9BzAKCc1coUcTXD2YTFek/ocwy09tGy1nYw8LlzPRVutQrhiewg0ZCqwRgFidoA++Lcc4s3OXfKR1ehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152774; c=relaxed/simple;
	bh=wKsNU9D3UfD+u45+zddpHRq7h2vPU602OrfZXYFUxUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axHkOPE+zygUqldxiJLmXoRcYhFNVmBBruGOMl511Ajd+cWmmDwx3yOv2rad46B/eBp/RFJ37udSqUIlpQcKyjc1bhI9DaMgy8h0GN9HSKpXX+cQzR6ser3UrTJofdKqjC/j/Ma5Hu4LYRipJGPLC6LE4Uw8kNM+UMko7yG27KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZ5MYoxm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756152771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge5aJkVm13DDes+f3vmdSasrLK5Igm/nVj2nj448RRU=;
	b=IZ5MYoxm6v2ScD1bunrhKSqR8otWYlwtaYOi2DqWOZWSQx/WNL6G61LNy0gfjPaLublzJ0
	L4VqSwXPCq7H8o0+/ullcQkLEKjDM0oM10pfUbxlAYyrzJ4krYqnK5frPD0kgyC3tiT9iw
	S3b2kG6Co1fkgd6jVh8WpWjnKY+ZXTA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-BUpRu6PEOnOQ_fQdmEwSgA-1; Mon, 25 Aug 2025 16:12:50 -0400
X-MC-Unique: BUpRu6PEOnOQ_fQdmEwSgA-1
X-Mimecast-MFC-AGG-ID: BUpRu6PEOnOQ_fQdmEwSgA_1756152769
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso24022235e9.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152769; x=1756757569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge5aJkVm13DDes+f3vmdSasrLK5Igm/nVj2nj448RRU=;
        b=JgW52nTG2wQ7ZkMRze2Vh1JByBxjJ2ldFi6CxGsJIJGA7utuSGqlEVRD6dRc0dUANq
         Ts1jh1sZoyqJaDa4WnHWixHY4IDTsFOqhnxT2hExRP2LviRAs15XH7kA5/n6+tANkwA4
         Moy0iKXIIg3D6fKLtD/vfOybw4E1UaJqdLvbwdBIsXhM7VYKzvv04UdsVsrnbT+J/z56
         G0DOhw17JKd7DFuoQCMxAAevfgyNJnVHIDDbOj1QCDttugls9q4nGaco6/x6kyTZ9VD0
         kUh/KhD2uQGyZp3Odv5WzSKnmb60uUXGErXurv43+OTPhD4/EkgW62A6BBfNJtKqol6M
         TQVQ==
X-Gm-Message-State: AOJu0YwbVJZGZolbJB5G60rQg2kAM2P+ud+JOiZdlx2IM4jbG7qG+fy7
	ihEaVScvFCWjqLo5pgnXLMYd2+RG+N9zJngt382yVBKLUm7GQFnrHWbmHiRHRUd4yPhfMTUZiYI
	uuJkkt5nc68KhG54GEEp5Hue7IKmuk8SoZRt65iRdRd5bcxwAthg01T0S9g==
X-Gm-Gg: ASbGncso8E+O9NPGcPIUj2lE67wcOYjr08noQG3aOUfKhEMIQrlw9hVmcDte5XSWIHs
	ZRZN4tHN0XkA1CPEqnSQf6mBDZN0uqTRdTg/PUdTJKBl2a9njAi7HA6VgpuQumDuzUcfrIIo95f
	+PZK3+jsaJF4aMry3rQn+QsUnupg+HoJWce2vKzxYRbq4vDSUVqJDDDaml8yacGTzeYyprd88Wr
	QItpJSEdp5sE1VN60XIBUyVDEZ0f3tqkdT3yg6jBH/ENW6e9yL+X28856q0Qf0J9EYQIBVmn+Q6
	uFY3LNuTsmDpFUeslvF6J9YkiiUzVTcj8WwFugeGMgM=
X-Received: by 2002:a05:600c:3b18:b0:45b:43cc:e559 with SMTP id 5b1f17b1804b1-45b517cc0eemr110897835e9.36.1756152768862;
        Mon, 25 Aug 2025 13:12:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRLXeJl7aJCa4KIqJLeoq6ckqhrtSz9kGCxKWJy3oTPoUOof+lLez+0mpRqdtSV115Vf/vVA==
X-Received: by 2002:a05:600c:3b18:b0:45b:43cc:e559 with SMTP id 5b1f17b1804b1-45b517cc0eemr110897755e9.36.1756152768489;
        Mon, 25 Aug 2025 13:12:48 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6133d9f1sm48676745e9.14.2025.08.25.13.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 13:12:47 -0700 (PDT)
Message-ID: <dbe283c0-76ea-46ca-b06d-9925b16d2a69@redhat.com>
Date: Mon, 25 Aug 2025 23:12:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] sfc: remove ASSERT_RTNL() from get_ts_info function
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, ecree.xilinx@gmail.com
References: <20250825135749.299534-1-mheib@redhat.com>
 <338a2540-d64c-4d5c-9fa9-fc53e607252d@lunn.ch>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <338a2540-d64c-4d5c-9fa9-fc53e607252d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thanks for the feedback.
My initial version was actually to add rtnl_lock inside 
sock_set_timestamping since that function was added
by this patch:
https://patchwork.kernel.org/project/netdevbpf/patch/20210630081202.4423-9-yangbo.lu@nxp.com/
without considering RTNL and the safety it provides.


I'm not that experienced with locking, and adding RTNL there felt like a 
risky change to me even though it's
a control path so I was a bit hesitant to do it.

That's why I decided instead to send this patch that removes the 
assertion, mainly to get feedback and a heads-up
from people with more experience in this area.

if you think it will be safe to add rtnl lock inside the 
sock_set_timestamping i can rework my change.

On 8/25/25 7:25 PM, Andrew Lunn wrote:
> On Mon, Aug 25, 2025 at 04:57:49PM +0300, mheib@redhat.com wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> The SFC driver currently asserts that the RTNL lock is held in
>> efx_ptp_get_ts_info() using ASSERT_RTNL(). While this is correct for
>> the ethtool ioctl path, this function can also be called from the
>> SO_TIMESTAMPING socket path where RTNL is not held, which triggers
>> kernel BUGs in debug builds.
>>
>> This patch removes the ASSERT_RTNL() to avoid these assertions in
>> kernel logs when called from paths that do not hold RTNL.
> What is missing from the commit message is an explanation of why RTNL
> does not need to be held in this function. Maybe this is a real bug
> and you are just hiding it, rather than fixing it?
>
>      Andrew
>


