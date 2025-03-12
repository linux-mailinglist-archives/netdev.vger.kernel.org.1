Return-Path: <netdev+bounces-174149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FD5A5D9B4
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671697A595B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D091223BD14;
	Wed, 12 Mar 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="dQzQJwpY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC623BCF6
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772410; cv=none; b=lUVJINfLRRpJZqQRvUI+hH94yMxj/JwYSiITMDvVr7FbbfYB0G88Jn1tnzjgaELBTOdQigBK9QCdpePd5M7YUjV7PBW1uWxR1eVVQvpZh8iItU64lhfbCAQZsFkQtk1GIPElOUWI4iZMv9nMEOJszpq65Nvo5egmGiIEgt/7n64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772410; c=relaxed/simple;
	bh=2dfhfOYEZya2F/+8TXgINOUG/sPDfgWSkt185LIIP64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDaudRhGdJEUyuj3p3WuIWXTlaKIWo35s3ob0PvFdzMsFx9yasMFUSmnlcX7QlRWUgcL8evWOLqfpt5797IOoTOjdkpY4XZ9CLMYEHTP56k5aPsAkXj29bHp5ocIvQeTVCj5Au/Y7BM784TCQNLxeYsVy3s/tc7PZfDu1f65p6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=dQzQJwpY; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd1962a75bso41061396d6.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741772408; x=1742377208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udjj9fCl9LBtiIbmOdyvcIwBX67qERUexr1e4MBTcnM=;
        b=dQzQJwpY3EeKT8Empz3/22mps+rvNL4hSkdtlY7Mm4m/aO1MU60Fl/2NQByT14owj/
         7PZvim3p8xqwk74L+rMQNvIiHYNpsrq9wLLES/yhBPVJQ4nh2VaWYmtHZjiKEEsN5G82
         qK9MPxfSTI9Efi5ezknpKPnvfSAFtQKqbcoNw9TETVH6BbKPT6ESL3Q3WZ0rj9QCXE8M
         cDPobMnleWLRaIf1e9KptZYXIHwAKYrXunvzWYTEWkudchaJgAhXC1Nz0ijgFYs2WwyQ
         ipXaf4vSwmTzJCzUv2JSCrq3KG6+lPCC5I+EX3e8gXKaTdgjSAWSgja1lT8UZd42N0rA
         Hnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741772408; x=1742377208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udjj9fCl9LBtiIbmOdyvcIwBX67qERUexr1e4MBTcnM=;
        b=ZPratKv26YotJFe/HbXLpJ4A/z7+yQLMeG1rnZNocirq1g9oOB3NIKwtHX2lG+6EJs
         4sminXbuOeSBaM31OMSYJQOL9VSh1NIFgCYD2QLqMP1rE1vuxIKTFL5aZrw6TMPFQq31
         RJtpmhvc3hwg8or+PbkZR7SBbCr1cQpP5JwgF9GPwBrG6EsNLiPV5Rj9+gW1yqroiavR
         rZfVf7cQLTZR1m7mKBt40DRqBJjcYvPnJPEF+5CW+CmGk3l2gfytGt3VvqGvTbW8jp/9
         dFwNqg1r2QrUrUjzPtFxaEqbY/SvKcxlMmQzKunXCqKXMwLApbhNgE5hLbzPwux/l/j8
         s5RQ==
X-Gm-Message-State: AOJu0YyqzQbEZn/L0hVTa5r4yegiFZ9tD0kX3DosSfi6wYy8+EXwVyA1
	m+pH75GSkFyp7Wctkvh0FmbIDzi8Rj6EaGWJXjjLCEY4N+JD2xD+xC+5bLHpHz4=
X-Gm-Gg: ASbGncsildd0vBwP/kxY0gmA8w7A8Dj8g0Gjik1gTB4hyK47jvqxslqYHk8oQ6cljMB
	9t7ccw9atQxEaS32kSIP+aUWr5P6qaiMYycIWhcSNZRs+t+YUDgHMI+SMhmDzG8Hx7v5UJAUF4m
	uXR+sCwg2YLcReU/llb2XYRvtc7VJtOFdtl8x8yWMB3WUr2Sk4GHrXtc0bfLcxBbLVROmLJV2ED
	FDlGasWaCD8MuhyJSnibT4rPm8ttwIVdIIMRTLSZ/ULCfAd2EWSgtshfOYPDkWkojL7EAQTIgph
	HPVaQpQY5ix+v3giILexOB5/H/hEYeoFDAn12sTv6hZbRi9dWwUm
X-Google-Smtp-Source: AGHT+IFZF4mdG/bEmIMD8dAADQJR8NHoCAL3S+neVFwZEscYnba7g81wnhrW7ciHRjjCuTX7gr/vOw==
X-Received: by 2002:a05:6214:226f:b0:6e4:4331:aae0 with SMTP id 6a1803df08f44-6e9005b6680mr265863526d6.1.1741772407942;
        Wed, 12 Mar 2025 02:40:07 -0700 (PDT)
Received: from [172.19.251.166] ([195.29.54.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733f8aasm9486244a12.5.2025.03.12.02.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 02:40:07 -0700 (PDT)
Message-ID: <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
Date: Wed, 12 Mar 2025 11:40:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, shrijeet@enfabrica.net, alex.badea@keysight.com,
 eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
 bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
 dan.mihailescu@keysight.com, kheib@redhat.com, parth.v.parikh@keysight.com,
 davem@redhat.com, ian.ziemba@hpe.com, andrew.tauferner@cornelisnetworks.com,
 welch@hpe.com, rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
 linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
In-Reply-To: <20250308184650.GV1955273@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
>> Hi all,
> 
> <...>
> 
>> Ultra Ethernet is a new RDMA transport.
> > Awesome, and now please explain why new subsystem is needed when
> drivers/infiniband already supports at least 5 different RDMA
> transports (OmniPath, iWARP, Infiniband, RoCE v1 and RoCE v2).
> 

As Bernard commented, we're not trying to add a new subsystem, but
start a discussion on where UEC should live because it has multiple
objects and semantics that don't map well to the  current
infrastructure. For example from this set - managing contexts, jobs and
fabric endpoints. Also we have the ephemeral PDC connections
that come and go as needed. There more such objects coming with more
state, configuration and lifecycle management. That is why we added a
separate netlink family to cleanly manage them without trying to fit
a square peg in a round hole so to speak. In the next version I'll make
sure to expand much more on this topic. By the way I believe Sean is
working on the verbs mapping for parts of UEC, he can probably also
share more details.
We definitely want to re-use as much as possible from the current
infrastructure, noone is trying to reinvent the wheel.

> Maybe after this discussion it will be very clear that new subsystem
> is needed, but at least it needs to be stated clearly.
> 
> An please CC RDMA maintainers to any Ultra Ethernet related discussions
> as it is more RDMA than Ethernet.
> 

Of course it's RDMA, that's stated in the first few sentences, I made a
mistake with the "To", but I did add linux-rdma@ to the recipient list.
I'll make sure to also add the rdma maintainers personally for the next
version and change the "to".

> Thanks

Cheers,
 Nik


