Return-Path: <netdev+bounces-202921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2086AEFAE5
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEDC18835DF
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1050626B2AA;
	Tue,  1 Jul 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUANSQK4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D6242D82
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377028; cv=none; b=Al43d5caIZFuwgq4FyVS6rycmyjZPsU74P+T0MAVL2xDhTIpqrLP+/B7QOFY1jfZNim2UBD4WnwtXnXdra7GeYsjQCcd2bi/OL/6cLKheSPuk+MOXbqifMjH5sQPRPsQ+FdiX4Y2g/lhMFZGkDKZXKpwBQDptIDzyd0qOibPFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377028; c=relaxed/simple;
	bh=dbSH7WYLQHAQxROOVdyvVqiTWEBoPwcvNH5Bnibzt+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRgXBzM+ZogBIECkxvAYsmO/VpxG4ZwrA5TitTiTkjso5PcX0KcOSIWt97G/VWXSHi08mAZqs8uGYDEd+92mimoyNTjuknpGpb6C5OssIwy8Y9jjiljJhxNQnVBuzm+S9HQb+SVCVg/C59KawhFZPdFJq37sOMhJC8wfn5edWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUANSQK4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751377025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jna8iPcqFIRpxEKTaFIf1JSbH3R+gL7K9xJI5YJQL9I=;
	b=gUANSQK43JGMbta2ukmTIpU5zwYd3Slk3JnHWFDwMSdWEGQZEg7sKo6FmiKSHOcS9G2zSU
	/j9C+g1SX579pj5/jgOY3dIOub5XbNitVD5+pbLjzEZfhWY6+vvM3FeNZPssuFrdbxHpfb
	yjVTYG5mGhChNu672h1vbBD57/hutvQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-ejPmPm-CO0KOoTKey3Q3Tw-1; Tue, 01 Jul 2025 09:37:03 -0400
X-MC-Unique: ejPmPm-CO0KOoTKey3Q3Tw-1
X-Mimecast-MFC-AGG-ID: ejPmPm-CO0KOoTKey3Q3Tw_1751377023
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so2605622f8f.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 06:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751377022; x=1751981822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jna8iPcqFIRpxEKTaFIf1JSbH3R+gL7K9xJI5YJQL9I=;
        b=wldgdWVUJC8qrVCzHc42KkNJbZs9hdu8f0mZqI7u2d2Ygd3m51EkehosyV70EilVeK
         T4oBFxWs+GChKn74eZMDMNmO5mT8XOvJBrrFSA5alMk7OMeelwJf63YSXfllBWl6FgOX
         vofrRMSEka7gVI4t170El3lBAZYhK/yFFSjBSziSglE0+5ccstzEBW1FQgJ/IGQisERF
         t0V7YSQBNxxPhCcuLdFj7eMXvJjys22SDVKZphsqclvDYVqT6qXVmmOLKclStzZzqsbi
         7Hj+pc0GBkxrnn3qB0JdGfIuxiTvk7SYweTcBoYyiSwAp2CZt90KSel8gnIGCSbBcDu8
         Q+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLOq8QSlvyscBnJ2hSgmbZ39Y1FV1sr7n9zYumHVoT0bA8YrcqiDBhy6hxFZP5SdXqofumfXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6Cqb0QQHzDkM9Z7x47a3tDqcP0dgaTAfCAPoK4ZWmmNIp90D
	G78wZzNCcws6heQOdKNNIYK2N9WpIrO/YzHDIbfYoRejBCY9ojn4heAq9jACxd+zsJRHkwnch/U
	N2bWJoffjcDJUeoHaPARfWEEbBeP86HpHPmTDhhCGUMrPxShuXXiIQs6GqA==
X-Gm-Gg: ASbGncsovbV/87mul/Y6fsUirw6gwyB06foUDb3epc6bSCTxEiLd7KY9uvgEjThoJA8
	fN8GTFnxtU19Xh148sCzNYKXeGiUJGEf12Msh0uW+5omme5ccOYJYg/ExeSdKrQvsx/5SIYWt4E
	c1RmFRP2cdNKqHT+z648BTa8wGLin62VxUF2AISTPiAFGoRX5Xua7hbU6YP30HbkH9yXfA7h+Pz
	Ik8hGOn8QiYweojdD0JhgOfpT8giIlWZERR4l3fVaMM2Q/Z3qkn6kv3ioQZpjb2wszuz7G7VEks
	0n9jWFWlAsnFQ0E4VY/f3fU8TRRZP0xJ6pLTF1bxbs25yNTmq9pbRwNXcrXIUnGDuRdUcw==
X-Received: by 2002:a5d:5f4a:0:b0:3a5:7991:ff6 with SMTP id ffacd0b85a97d-3a8fdb2ae3bmr16291065f8f.1.1751377022378;
        Tue, 01 Jul 2025 06:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXqmLWAjaqlxFBOQMzEdeDrDHzEOf4nloaiBPDIxFjnTwfhmfYwU39/eiO2Oq0jIt3rZWX3A==
X-Received: by 2002:a5d:5f4a:0:b0:3a5:7991:ff6 with SMTP id ffacd0b85a97d-3a8fdb2ae3bmr16291036f8f.1.1751377021847;
        Tue, 01 Jul 2025 06:37:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e6214fsm13445402f8f.98.2025.07.01.06.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:37:01 -0700 (PDT)
Message-ID: <6d8db1eb-ec1d-4c8e-8a2e-4de0fd105107@redhat.com>
Date: Tue, 1 Jul 2025 15:36:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
To: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
 victor@mojatatu.com, pctammela@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org
References: <20250627061600.56522-1-will@willsroot.io>
 <aF80DNslZSX7XT3l@pop-os.localdomain>
 <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
 <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com>
 <aGGfLB+vlSELiEu3@pop-os.localdomain>
 <CAM0EoMnjS0kaNDttQtCZ+=hq9egOiRDANN+oQcMOBRnXLVjgRw@mail.gmail.com>
 <aGMSPCjbWsxmlFuO@pop-os.localdomain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aGMSPCjbWsxmlFuO@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 12:39 AM, Cong Wang wrote:
> On Mon, Jun 30, 2025 at 07:32:48AM -0400, Jamal Hadi Salim wrote:
>> On Sun, Jun 29, 2025 at 4:16 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>> On Sat, Jun 28, 2025 at 05:25:25PM -0400, Jamal Hadi Salim wrote:
>>>> your approach was to overwrite the netem specific cb which is exposed
>>>> via the cb ->data that can be overwritten for example by a trivial
>>>> ebpf program attach to any level of the hierarchy. This specific
>>>> variant from Cong is not accessible to ebpf but as i expressed my view
>>>> in other email i feel it is not a good solution.
>>>>
>>>> https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com/
>>>
>>> Hi Jamal,
>>>
>>> I have two concerns regarding your/Will's proposal:
>>>
>>> 1) I am not sure whether disallowing such case is safe. From my
>>> understanding this case is not obviously or logically wrong. So if we
>>> disallow it, we may have a chance to break some application.
>>>
>>
>> I dont intentionaly creating a loop-inside-a-loop as being correct.
>> Stephen, is this a legit use case?
>> Agreed that we need to be careful about some corner cases which may
>> look crazy but are legit.
> 
> Maybe I misunderstand your patch, to me duplicating packets in
> parallel sub-hierarchy is not wrong, may be even useful.
> 
>>
>>> 2) Singling out this case looks not elegant to me.
>>
>> My thinking is to long term disallow all nonsense hierarchy use cases,
>> such as this one, with some
>> "feature bits". ATM, it's easy to catch the bad configs within a
>> single qdisc in ->init() but currently not possible if it affects a
>> hierarchy.
> 
> The problem with this is it becomes harder to get a clear big picture,
> today netem, tomorrow maybe hfsc etc.? We could end up with hiding such
> bad-config-prevention code in different Qdisc's.
> 
> With the approach I suggested, we have a central place (probably
> sch_api.c) to have all the logics, nothing is hidden, easier to
> understand and easier to introduce more bad-config-prevention code.

Since an agreement about an optimal long term solution looks not
trivial, and the proposed code is AFACS solving the issue at hand, WDYT
about accepting this one and incrementally improve it as needed?

/P


