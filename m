Return-Path: <netdev+bounces-174270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647C3A5E150
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E537A3B2DC9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6714D599;
	Wed, 12 Mar 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="FKwB1OJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6601DFF7
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795223; cv=none; b=TRl9jJM4YRX3iRbzEMOzsi5zrT26RnReGivH/P2xOofq+nOrLUxp3K8rgq6qXvTSUx+TQoPTr+xw9yc4otmZi3Fr6FjUBagpjbgaCV1JGIdi82g+DF3HulpOaemvEZleYnxDHstlJRTRN47z59w+23QjONC9yuzYYEc/93+11hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795223; c=relaxed/simple;
	bh=YuZCLLOe74+CbDXV6Qpl+EcrF4BAurI+0vwAQibPmIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPPe7pY5vmiTXCMMbFwGOYOQtc8H3iP+sKUIuXyo7amMa3P5m3rkyP/R4W8IwlLi+QkPzhTkJUgqQvhhBo2GhGlRTUusjr0NZqUJwcFFhDvDHvQmonu+P+n1Z+3xowbawf9A4LeenIJ2egV+VIXrFlTKxCJrlqOS+96cIiRVYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=FKwB1OJo; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476ae781d21so8491001cf.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741795220; x=1742400020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIYof9v88hwRZiv0dm3khNPjBDWTfg5Jw6z157GPEOU=;
        b=FKwB1OJoJTONumQtNL5+BzfcXGFqYffFxvO6YBTkcAQUa/RYjblvlBUzdb9YD+Uqez
         EJm+3MYa1Qz1WfUI6mbVWVW30FUH95PpYH+1kWaUooqDRE5G+flxbigCaGANAjCScOWm
         8WjDfDaWZXIsNWOf4Gob7WUnrS4RH45pnR09zkmqXyukuHi4B+tzY8cWlSeTEU5hGVWf
         9hzAv5SKN+ctvC7ny3cNemGY9cYJW/+SpcbP8IwBHUbelAXs+3XQVqWztTcy4j0Vb+0o
         WQVOogHJwAD33hQti3rL4mJbdz/npEvHyESsx4XUxKWCJs9TIJxqmSNLHmwEKkGa+jcF
         4r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741795220; x=1742400020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIYof9v88hwRZiv0dm3khNPjBDWTfg5Jw6z157GPEOU=;
        b=RFcElxerzUC4eA8rT2esUcGm7RmmWQwqTCB6rIm/KUYDu/DExOivm2yJA/Ql7d4bNt
         5Ai/Q/euUVdJZ3PtXwUFAndqtIHWYg2e/tDxtujVNODypQ70AQv4Tv+4e9pY733CGNik
         R6AKyZmOYxBmsQRi2dOCeTjKyxpLG4VUYdXpf+RawU4DAPSaty9vQFt/jSsJBRtqduFD
         3lQN+Z0NZKSPPSyWnl1UmTWtgxsF0FnyfRE3qHxsmwr9K40GBU4RqsZSIaaofMlQZ/kc
         Rjzg8NUNfREYg7lsgaZNZN3/2l/VJTkgN+lQuVWPFqkvQSbjkbCBS5NjTASbS80oJWO+
         nfmg==
X-Gm-Message-State: AOJu0Yz9iGXaXma0QpkzvBruE5K0EKY5rJSVvi6k7OoGKJ1obb9TuWBL
	U2QpJ3GOTIz+VU2DUCHLgPWyyNXSy4brv//wVGEgs7iF28f2ZbNjGt0GQNDiB/A=
X-Gm-Gg: ASbGnct0UocGxIMxOyfMSFEA5NlxjR88e7lAC9aFp+gTun5mgD3OCgUbbVebhD+X0Eh
	nTyuUhSwYPcbf3xpin9oDdI1HbqK9TmaWOauJU/7QENd3ZSo13csML4Np7j5NjRBdWg7NGpjI6x
	uZF8SvM14k36d3/4L0DmYFofCGKrCBq6MaxNWKdG+uckl/Ku3a8knw/GoP2ZkdlBlJtOqH17FrV
	m/R4v0fdteKn9Cwq0zPR60mEriS2JW4qld8RovYwq+uG8pRkQx49u6uGYxewoNRE6mUFdJPE++q
	KN+WKi9jyUkduQyd+vHBsNOLJ5BTTq5CY3oaezwOwrFp267ja7E9
X-Google-Smtp-Source: AGHT+IE/9xv5X1igt6yD3kXyRMvuAsSySnPOjkvdLMDhBbZtwNPc2G33aWO50kIh2RqJtWfK/GhIlA==
X-Received: by 2002:a05:6214:f27:b0:6e8:9535:b00 with SMTP id 6a1803df08f44-6e900621ae6mr239485956d6.12.1741795220383;
        Wed, 12 Mar 2025 09:00:20 -0700 (PDT)
Received: from [172.19.251.166] ([195.29.54.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fca8sm9736288a12.4.2025.03.12.09.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:00:19 -0700 (PDT)
Message-ID: <1742b7e9-b815-4c12-9c22-aea298afe822@enfabrica.net>
Date: Wed, 12 Mar 2025 18:00:17 +0200
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
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
Content-Language: en-US
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
In-Reply-To: <20250312151037.GE1322339@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 5:10 PM, Leon Romanovsky wrote:
> On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
>> On 3/12/25 1:29 PM, Leon Romanovsky wrote:
>>> On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
>>>> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
>>>>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
>> [snip]
>>>> Also we have the ephemeral PDC connections>> that come and go as
>> needed. There more such objects coming with more
>>>> state, configuration and lifecycle management. That is why we added a
>>>> separate netlink family to cleanly manage them without trying to fit
>>>> a square peg in a round hole so to speak.
>>>
>>> Yeah, I saw that you are planning to use netlink to manage objects,
>>> which is very questionable. It is slow, unreliable, requires sockets,
>>> needs more parsing logic e.t.c
>>>
>>> To avoid all this overhead, RDMA uses netlink-like ioctl calls, which
>>> fits better for object configurations.
>>>
>>> Thanks
>>
>> We'd definitely like to keep using netlink for control path object
>> management. Also please note we're talking about genetlink family. It is
>> fast and reliable enough for us, very easily extensible,
>> has a nice precise object definition with policies to enforce various
>> limitations, has extensive tooling (e.g. ynl), communication can be
>> monitored in realtime for debugging (e.g. nlmon), has a nice human
>> readable error reporting, gives the ability to easily dump large object
>> groups with filters applied, YAML family definitions and so on.
>> Having sockets or parsing are not issues.
> 
> Of course it is issue as netlink relies on Netlink sockets, which means
> that you constantly move your configuration data instead of doing
> standard to whole linux kernel pattern of allocating configuration
> structs in user-space and just providing pointer to that through ioctl
> call.
> 

I should've been more specific - it is not an issue for UEC and the way
our driver's netlink API is designed. We fully understand the pros and
cons of our approach.

> However, this discussion is premature and as an intro it is worth to
> read this cover letter for how object management is done in RDMA
> subsystem.
>
> https://lore.kernel.org/linux-rdma/1501765627-104860-1-git-send-email-matanb@mellanox.com/
> 

Sure, I know how uverbs work, but thanks for the pointer!

> Thanks>

Cheers,
 Nik

>>
>> Cheers,
>>  Nik
>>
>>


