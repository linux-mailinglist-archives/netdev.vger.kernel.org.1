Return-Path: <netdev+bounces-70680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FC84FF81
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D58285967
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B8210EE;
	Fri,  9 Feb 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxgKSziy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F2364A0
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516872; cv=none; b=uaLOa9FMFZsAT5u5kuOczN1IMsNPKUoIjiHccfgDkWxq5y+F2pCT2TQKqaGTGVZ/rfZ3/uGdnlDrJIeBihYrMpIIzSs7N7Yic9bWgriPmXDtguJlG5QED+hLUYtn7v2k/IyqZtV/z9NWGnxnpQvdw3vHS5zdS6dOFZumfJwMtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516872; c=relaxed/simple;
	bh=FFYOyAs/sdR6PzLDoTFBTgOUpDvSB9setQ8Iw4vmg/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkFNAOy/1d3KVtRFmsZTuBcgSx+OrcIhAPBM667sqo77kUdtPQtFKzOfD9T8SzhXI2LS5AWk/V6Y2s40S5vX0cEoUMnhBAoQowFr1OrGw9c8YiiH9EsTZQXXGihfTsr6fiujzvyNtmFiSBNHXq1hEXttzGGRTGbfZLKBPSwoprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxgKSziy; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c01af010bcso50863539f.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707516870; x=1708121670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fj6b9ZLz/vrQiQA6+bpst5j9mewX/grdzyYScKR194=;
        b=mxgKSziyYJjm8ciCyTxvu5Bz9YV1pZ/A1QHAubmQDhsBt4Ohmi26+3SYs+ry36HRGO
         QbsafQ5k3+aJkra75q6Y/wsS98oMBqx/39sSXeAaeYWUDkX6Okxj6Cv3GlMZJpwT/Dr0
         hY2lE879no7J2oG4Iew9GPIuziwrljvdbPwTIHAP8LKuUrQOSKJqAGPDy3SvC0ARj0Td
         iGshzLGQU3bm9E+t7Hpi7zL+w+j2bs658cCf8zD5ohU07S6tU83S38WwvYEjbuY3gboM
         qaqaJb6rnQaoxUiy7TP0a0xVZmOZpHtQ84ddqwG2ztERFdVsKZCIzpDjav4NupUGbz8b
         2HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707516870; x=1708121670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fj6b9ZLz/vrQiQA6+bpst5j9mewX/grdzyYScKR194=;
        b=Ok653eT/0jH/5qkkCAv4CO3RAeJvIRDS3TcCfE4g3KHv9aLWqQq3echM/Kj2G74Ii1
         0+Tzp4FQtjJt9+zA8OnoRkvHIJZ+RIXLSnIAarxf1oywMafEecHb4MmWt7BMVLbI5LyH
         c5WYrgYP+jhLRzF4DLjkTJs56BZNLISZgfPUtzMmaCiCiezNQta5JCGmtRfbjHZ+rZQ7
         ATrHkhWcm7Tcb7gHQxIU1MimdsDisUqwpzhGk0jv2Y0hUkDwXrOKrwkQisIOYgroWWvX
         Zm7/1L5sEF0MaZTt2A+EwFPNJsjDCPuZ7lUEE3pHEGHQeXk+KKr8sMiRnPjTpmfYAdlw
         dh4A==
X-Gm-Message-State: AOJu0Yz1SIyQSn1km7XfnM4bGm6RUmMdZs1AxFHrjzcoQENIBMBPBT+i
	bpYEu5HLhimpo7rpZ5OFKhXa2CdNr9K92FfK3R8dK0lZO6dlnvTyOOZkTJ22
X-Google-Smtp-Source: AGHT+IHNljSSSjKvjIOZ54wtdXO+8cXDtf6HTIJpc8IPTVUfgNyYY2GawuymNi81rGYtDeyT5MFgPQ==
X-Received: by 2002:a6b:580e:0:b0:7c4:868:e04c with SMTP id m14-20020a6b580e000000b007c40868e04cmr825302iob.3.1707516870342;
        Fri, 09 Feb 2024 14:14:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUX+lHcMhXLpNyK2KAdZarmsefSCNNao9RWMNk43hmygWd2PluILSu0PfOKXtjekmIGNwtyEdRfhj84PMfreWvtu2JdzYMmOBvt0T6ArWqQJXc9S+iPzbg=
Received: from ?IPV6:2601:282:1e82:2350:6861:b3e:ad91:5e21? ([2601:282:1e82:2350:6861:b3e:ad91:5e21])
        by smtp.googlemail.com with ESMTPSA id u19-20020a5ec013000000b007c040fe363dsm72367iol.29.2024.02.09.14.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:14:29 -0800 (PST)
Message-ID: <3730d7e4-058f-421f-8ecf-a9475440ef58@gmail.com>
Date: Fri, 9 Feb 2024 15:14:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, sgallagh@redhat.com
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
 <20240209083533.1246ddcc@hermes.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240209083533.1246ddcc@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/24 9:35 AM, Stephen Hemminger wrote:
> On Fri,  9 Feb 2024 11:24:47 +0100
> Andrea Claudi <aclaudi@redhat.com> wrote:
> 
>> ss.c:3244:34: warning: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 2 has type ‘__u64’ {aka ‘long unsigned int’} [-Wformat=]
>>  3244 |                 out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
>>       |                               ~~~^   ~~~~~~~~~~~~~~~~~
>>       |                                  |    |
>>       |                                  |    __u64 {aka long unsigned int}
>>       |                                  long long unsigned int
>>       |                               %lu
>>
>> This happens because __u64 is defined as long unsigned on ppc64le.  As
>> pointed out by Florian Weimar, we should use -D__SANE_USERSPACE_TYPES__
>> if we really want to use long long unsigned in iproute2.
> 
> Ok, this looks good.
> Another way to fix would be to use the macros defined in inttypes.h
> 
> 		out(" rcv_nxt:"PRIu64, s->mptcpi_rcv_nxt);
> 

since the uapi is __u64, I think this is the better approach.

