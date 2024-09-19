Return-Path: <netdev+bounces-128898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1E097C5D3
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1211B1F24338
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9026194C69;
	Thu, 19 Sep 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux/2guPp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B10198A02
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734503; cv=none; b=WNvBkVp8/GL+RkaERIe2GgBgcYImEWfPsVzz+ggVNr+Ca54EFYztJ/ltWPaT5BDkA5R8IPtcqdN8vkGJ8Dxb98dfBDCw/wafxy7WfIaE4qYNAoc3TMH9FBSks8udN077srlFHtYn+4WE5B461BNU8k/8BiEPwB9SIZUm3YIgwVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734503; c=relaxed/simple;
	bh=2gP72M6YFehKxS7DvcQxqVtz0w8XMZ6zsRmrqlVay9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s9saZ4Vj0ujdkW1R8akU4bJlGVkKEtTF1kSN7BQ5jTUOPDegv1tDH49o6ZeH4jcNj/u4Mz+P3D77/nvpEzyOY8eseI7moHuX1QKHpxBuy7uE2LYvWGNRs6xhppIw3ZOhKOILmL8JbAbhVz9D0ZPpts5seX0WilmNOoc52W4P4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ux/2guPp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726734501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIvo4RERn6UxJSjQ1HziLRAQS2oan3Er/vAsptTFqv8=;
	b=Ux/2guPpN2kj7fkXi3Zw/BxMxn1NEkT+VuZsPHj4x9fTsRx//tplJE9bOInHJAvrkm9LT5
	zKuPDQQhyKmnt77fwvFhQr8TS7X3oRPGv5AB2e8fK7X7WNShb6e02aDAg9D2v0VgQDIewI
	36J1/Ma6ZnERFm/Xodwl8w3G707+Drs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-R5R-M814OhCM7qNtCimLgw-1; Thu, 19 Sep 2024 04:28:19 -0400
X-MC-Unique: R5R-M814OhCM7qNtCimLgw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb857fc7dso4088205e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734498; x=1727339298;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIvo4RERn6UxJSjQ1HziLRAQS2oan3Er/vAsptTFqv8=;
        b=hXxecWOjKDAGJsMyk/VEY4IT6Wo/OLXSoe8LnW2cN+0/h/AoXX/gebX3uceNA4wl55
         SixQzrITBy/dhhfGTlE5Q2fRnjpr1DX6AEolQfRKWTk3xHJCgkvpODVo2mYKlJSBD7CF
         G+VzReCUaNKQXjPc3AKe/EwUhuONFxRHbOKRBi/gwysaBNF+3Nuo5bD7UpWmyYAG60fa
         fZGXbjh418ECLUqZBrsAAltkuvVZYcgZzMLnGhUF1F8nCzAg/FLx3+jVW5v/2oJ0MhWY
         VmHXU4Ub61B5/g1ZplUeIMbvZj91BGq3Pjz/KkavbfV9xliX9HdL2o65MKA5SZmTuaY4
         GDNQ==
X-Gm-Message-State: AOJu0YyXtx+fm3ZaHg1KWTb4fecXIAhqGXrcwcueqTGHZDmnquHetjTF
	2GrLAMtSWhoTovEHXaFyCftgqs0bKqSFaCzapuZvf3pH+XVNnko37ruWRiOKmIQ3TCFyDDvvEhX
	FYdMKJKFnxn/YD1pkFPqpA4kjR3Ay3U4cUWyQoto3heQ96sKpXnfhzw==
X-Received: by 2002:a5d:5c88:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-378fe6e51c7mr4537702f8f.5.1726734498278;
        Thu, 19 Sep 2024 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKAUzDZrvhgfNjEKeku8qMzKR68uKK/JreYx9wIbas9L0dAYzL4X6Z2WGnz1JAE1Og2rQx7A==
X-Received: by 2002:a5d:5c88:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-378fe6e51c7mr4537686f8f.5.1726734497887;
        Thu, 19 Sep 2024 01:28:17 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37a3b340c9csm1107459f8f.84.2024.09.19.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:28:17 -0700 (PDT)
Message-ID: <404e37dd-2794-49b5-913a-2e3455f8c07f@redhat.com>
Date: Thu, 19 Sep 2024 10:28:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 V4] selftests: net: improve missing modules error
 message
From: Paolo Abeni <pabeni@redhat.com>
To: David Hunter <david.hunter.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240914160007.62418-1-david.hunter.linux@gmail.com>
 <a2462a8d-97b1-4494-8bc4-c5a09eee7d1b@redhat.com>
Content-Language: en-US
In-Reply-To: <a2462a8d-97b1-4494-8bc4-c5a09eee7d1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 10:10, Paolo Abeni wrote:
> On 9/14/24 18:00, David Hunter wrote:
>> The error message describing the required modules is inaccurate.
>> Currently, only  "SKIP: Need act_mirred module" is printed when any of
>> the modules are missing. As a result, users might only include that
>> module; however, three modules are required.
>>
>> Fix the error message to show any/all modules needed for the script file
>> to properly execute.
>>
>> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.11 and therefore net-next is closed for new

FTR, typo above        ^^^^^ is actually v6.12. The rest is accurate.

> drivers, features, code refactoring and optimizations. We are currently
> accepting bug fixes only.
> 
> Please repost when net-next reopens after Sept 30th.
> 
> RFC patches sent for review only are obviously welcome at any time.
> 
> See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle


