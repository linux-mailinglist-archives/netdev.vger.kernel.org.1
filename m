Return-Path: <netdev+bounces-174235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD1A5DEC1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 15:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A7517A460
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B624DFEF;
	Wed, 12 Mar 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="OvoGhgcA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB702033A
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789212; cv=none; b=pYMKkKb8OdokHU4i5vXIepHAp8eFPDsh+zn28skym3EejAjiT1xqQG1d3YNQ5IUEKfHXafyCjTXVJRPmfMtNWdU+v5X22ldbvI5y82PO6MxayEFk1tfBIO/LUnMuCipAcYn+DTt9xHFAxDrjn9pY5Win6VWYGQP0Wi9gCPV/Nis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789212; c=relaxed/simple;
	bh=d36XfEjHsb/LASvwjZhgKztn+JaRVGnRgzRhjuVi9n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/dO73ml2Uf6eKCb+3NO854uBy+MpSMj9yLhlkvtN4tvbmBFHRuyseEPuizEokqrcF/G71a55cMlFtemaOFRan7cjRWJcm+GsS71n4avkK0CMca5Wmt90kY0X1wbkFloO1jutl5/0KER/mntS68UpoIGf+3hduyyEyaEYFPdX94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=OvoGhgcA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0892e4b19so686817285a.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741789210; x=1742394010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NxjEW2IK1lZmdC3Aka9pG0G7KKs2I3DMM01JAI0Qo+M=;
        b=OvoGhgcAh7P0ADiuB1b6XPjEexSmI7Hxr6KuyHS7LkZ4h2NpQSJ60vypNLLfk5j665
         MVhRV+5Qi71E5H1op3C40uWhdTp1Kj0NeoMifX05vIXyCsmYe7UCU472LWcTKwX5zvFz
         dlEW8ii6xlPDxPDOMRs5iGheCZMYL0/Sr3lf21qSGyicJteRM4GbKuQpTav+YJz9fnOa
         afPBJcu0zcR30rdJX66svwNseg+F1dsZcDKPvcamHy1rCGGGusbfsGOyWrhgP5RF+nL6
         BT6tcFqPcwj67tbO4zcMUXSOzDq1IRmDk8s37hWTrsqopG0AS83Kol7coXgQYuMJpnYS
         Xmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789210; x=1742394010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxjEW2IK1lZmdC3Aka9pG0G7KKs2I3DMM01JAI0Qo+M=;
        b=akmLJ6/Eo52cn5KdggToQf7rSuyZNTLzVTRploTnGDGAJIqNhNoO/Sz7lgh/mGyTmG
         gx/XrPdN9N8vNfmztJl/eskR7HF0yudZOA8ni6I0iVKkeWBL4DBqRnvWrGR0pjpvarcY
         wQYaH9CIalhu6K/0HSu86Xcm248pyM+uHGZd0Y3QXPPSZljzqQiwq5B8ZCzhC+4lP7TO
         nYTxJL1JhDNkdlfky1s9DR3f2zd7nO/yYL3ctWEY11k5PeX1BPdNmgA6cTg8KkOPTimh
         xGp3nYG251Ofk2VMhOdczbFDQ1T46e/3hFBkoC+3cOfEDFeSzjt0ilt7CUNdcXgZ9/sM
         il0Q==
X-Gm-Message-State: AOJu0YzQT8UD5Zjx0fjNmlPMYGcmgYByj5bQ4yUUmQvfFUBnwUbMQDt8
	z3+NB1bXhtJbn6+SleVGws99kGF682oMKUT60DU0+qB9y1i2XuVXDNBHvOlzFVM=
X-Gm-Gg: ASbGncv2AVjTRhZaYld7i4xMocF95J9urNlFK+DQejQK/wcBIsy/fi/uKs23fcXpDSw
	B3mca1USgpHfPalZ6MghjXhRXfdWIhuXKS2ador/kYwgYftLqBZbalpwI1yJEWiVGLOIm4oluAb
	Eyx3wANuWIhPUvQZHWOTEraI50kp6JfREyr3ejcz+KXG7KHSCBC6atn644O8zyW4EZ0plNX+/qR
	sEY/Dy5T4g84um6flmVENc6Epc9SZNdJ/+vdvxAA+lM9aVsZw0NPSA35DcSDycCMYHsvX1jQ6GD
	aSmBzcfECceTBu6fgYyAYiCOAqM0kXPmGuDiq5FLsTbo8OWSmEnI
X-Google-Smtp-Source: AGHT+IE9rBvVo4fWQGgmfzUj48CSmR8hVtF8QFZrxBGYAeYwyU2dpXL8gA/GGMkix24jg6jxPXvkxQ==
X-Received: by 2002:a05:620a:6410:b0:7c5:6e5d:301d with SMTP id af79cd13be357-7c56e5d30a8mr268787385a.1.1741789210067;
        Wed, 12 Mar 2025 07:20:10 -0700 (PDT)
Received: from [172.19.251.166] ([195.29.54.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a028sm9659269a12.50.2025.03.12.07.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 07:20:09 -0700 (PDT)
Message-ID: <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
Date: Wed, 12 Mar 2025 16:20:08 +0200
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
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
In-Reply-To: <20250312112921.GA1322339@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
>> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
>>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
[snip]
>> Also we have the ephemeral PDC connections>> that come and go as
needed. There more such objects coming with more
>> state, configuration and lifecycle management. That is why we added a
>> separate netlink family to cleanly manage them without trying to fit
>> a square peg in a round hole so to speak.
> 
> Yeah, I saw that you are planning to use netlink to manage objects,
> which is very questionable. It is slow, unreliable, requires sockets,
> needs more parsing logic e.t.c
> 
> To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
> fits better for object configurations.
> 
> Thanks

We'd definitely like to keep using netlink for control path object
management. Also please note we're talking about genetlink family. It is
fast and reliable enough for us, very easily extensible,
has a nice precise object definition with policies to enforce various
limitations, has extensive tooling (e.g. ynl), communication can be
monitored in realtime for debugging (e.g. nlmon), has a nice human
readable error reporting, gives the ability to easily dump large object
groups with filters applied, YAML family definitions and so on.
Having sockets or parsing are not issues.

Cheers,
 Nik



