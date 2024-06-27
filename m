Return-Path: <netdev+bounces-107323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D891A8E8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4F7B26A3A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46248195FCE;
	Thu, 27 Jun 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="lyIOkJ05"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1A195F1A
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497556; cv=none; b=D4GGL0fyHO7U+xphpNr5rB0yx7MkbT1enpzRMHjFZJ82Bf0y8inf19O6c1ASwHLXCbfMsH23HpcEFNB4DSMStRN/B7u4uTAOZoX34d+0nPxslMOf3filRQwpSCGbqrGUswPsn/VjuXcjVMPMq14j7H3lgG+DC87r75I+fcsmebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497556; c=relaxed/simple;
	bh=gY4Q4/1PM/RDP+0xWn2eRTcG6CNIwP755Og3YUmyLW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxmx/1ivOPX3CzExmUbkhiwouHYjS/q3rX4Wkbv0Q+uMfd9yWLb/vd5z2Jgb6OoISu7uainz8cHQEsvl+2e9ES2E0Hs0Iyq4x9yBj8vC/YPt3U8cN14wyPBk603mWkwhTISaMFsj7bmFBcxgooBoiwC3jfz59RmxFKiPHd1CATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=lyIOkJ05; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec5779b423so59324861fa.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719497552; x=1720102352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTT90OGoRel9hOYp2EFf1nDcNSmQMtkxjpE0hZS59dE=;
        b=lyIOkJ05HpWqkHilFHHWcCZq9LxZUF9ZYIPz3A2deRHccFVEwohIbD1Dw2Xxua/zQG
         8+6zh9jERv4crY1Cx75Iqb0HCsox62t641sdE0DXDeKx5HvSZOO1pey//EXrFLeuIi2V
         nYXxQBJwPYsLWqx25SDz5giEHnUquM6wkwiU5/vpP9/s37qXQ+72Jl/tvT9KpGZlgz1e
         QpaazdssZAZm+zdYRQ0w44RSOp8dhgA09prK3DFKhE/YjVnvUXyRZtm2q1ZjNXN6lGSE
         3CKpq0vVn7ZOgNE9KIrOX2JPhgEQLQSsQULXnzM3YBn0/zpSSjXkxH2rRDyNCmYSxTFE
         mUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719497552; x=1720102352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTT90OGoRel9hOYp2EFf1nDcNSmQMtkxjpE0hZS59dE=;
        b=rRvHJwkpLhGyKAz8NZa1/iVHuthe+Gj6VhaIoIsDsYBZ3J4iQ3LPpXg6kZP4ifGr5T
         Q39joM2fTIh49k3CkzlUkdVySEuxQ/wwd8XIT+h1sOpJBM2M6z5YI1TZWNn1Z6ihHGFz
         SXkZ4tMnEQTyvIp53g0e2ZDHf0PUh7lIQRKqvQWvivo7/FttwDvhKs0Ta9oxOnB3/01m
         687RECmWxej/2Qn9ut3qACpuGFKvwp95ygF9ITIwXrak6OyOEDjBvhJsrHzQ6osXCbDm
         MIbLMuMgnbZn22ZHY550uLeTjXQpyiCoyqxa8VnWXsVEf2xPfkDicywvWNOB7NN6SoAR
         mAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwiYvEWavyQSFzv5Z8XES3Qm5gulpV+NamSe+RkkNt2nwRPfUTfXKzkvkmLeX3nfB8SM6Wyw6NxUjKZJMa2ZW4bwMp8lmo
X-Gm-Message-State: AOJu0YwSoFkC/Q2Kf5O3F6uHpv+7QvB6GUS90eUTQWjRk0oEULkfHbPx
	CAz3dMmfAgsU+hqGETzf63uXmoxCSo7syh8zw1wgM+SPqkLQCsHXRGt8qs3LO9M=
X-Google-Smtp-Source: AGHT+IHPBg2ombsm1Fu//cFjlqwhC2otnKH/tHQvSElvv3SrldkNfebTn9aQLa68ZDubk6Umw3eVag==
X-Received: by 2002:a2e:9f10:0:b0:2eb:fc08:5d83 with SMTP id 38308e7fff4ca-2ec59389fffmr94063171fa.44.1719497552376;
        Thu, 27 Jun 2024 07:12:32 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d278120esm920856a12.60.2024.06.27.07.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 07:12:31 -0700 (PDT)
Message-ID: <d459d0a7-750a-4cd2-9c68-8031a55f9e9f@blackwall.org>
Date: Thu, 27 Jun 2024 17:12:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
To: Hangbin Liu <liuhangbin@gmail.com>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org> <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Zn1mXRRINDQDrIKw@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2024 16:17, Hangbin Liu wrote:
> On Thu, Jun 27, 2024 at 01:33:10PM +0300, Nikolay Aleksandrov wrote:
>>> Yes, but at least the admin could get the latest state. With the following
>>> code the admin may not get the latest update if lock rtnl failed.
>>>
>>>         if (should_notify_rtnl && rtnl_trylock()) {
>>>                 bond_slave_lacp_notify(bond);
>>>                 rtnl_unlock();
>>> 	}
>>>
>> Well, you mentioned administrators want to see the state changes, please
>> better clarify the exact end goal. Note that technically may even not be
>> the last state as the state change itself happens in parallel (different
>> locks) and any update could be delayed depending on rtnl availability
>> and workqueue re-scheduling. But sure, they will get some update at some point. :)
> 
> Ah.. Yes, that's a sad fact :(
>>
>> It all depends on what are the requirements.
>>
>> An uglier but lockless alternative would be to poll the slave's sysfs oper state,
>> that doesn't require any locks and would be up-to-date.
> 
> Hmm, that's a workaround, but the admin need to poll the state frequently as
> they don't know when the state will change.
> 

Oh wait, that wasn't what I was proposing, I was thinking about the port's oper state
which is already available via a sysfs attribute. Generally sysfs is getting deprecated.

> Hi Jay, are you OK to add this sysfs in bonding?
> 
> Thanks
> Hangbin


