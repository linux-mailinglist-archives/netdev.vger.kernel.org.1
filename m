Return-Path: <netdev+bounces-144745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ACF9C85B5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831A3B2BCC6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7E1DE3B7;
	Thu, 14 Nov 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHE2PumO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA92E573
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575170; cv=none; b=AN1WFG/TM5L6g4wy4jCn67GiVJZh4vWWz15piizPyOTnAFq9RgWZjwa6LEemznvj8PKoZnDtMoEbq7fseo5JdJUbWGQSLYwiSyESIPDp08KAjFJsv9w92zAp9M3QJeYDBMWSOx0XNAK5W7aXRZqhZZdybtA7Oz1lQLfamP5gKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575170; c=relaxed/simple;
	bh=aFILYSe1c8y2SA8XZwkqPjVURhldMo/+d5BMIpxd1Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FHFFT1jO+LX5Ys2bHjsyTHa745oBZaCywmvCHaZLg0Y2d96rEeZ37+NowYJ/yFVFhjqNZRLs8ZWefG1hz6NHyew1OzFMDwCttlRnN0CUPj3zueAJBusewvpUgk9RZOq1QqeRY6/M+RXpiNBlW0lAPLwereyBm/Bxop5tcZ6swf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHE2PumO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731575168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gk4fvCl2AelIitnEUCkAjtoqB7Mo6yKzoNwrEKOPpYQ=;
	b=YHE2PumOi56pFxDfNzju0Ds8UpsXcwqXwi3KGcUlJUz5I27OtnUaeD2DaJ+G1q73e94ksp
	ml1xQ4h+tVIO3AUNLJsDrme32KP/7wDOdnp3M+W+xAuhiwxogN9eIDjVxsFzQh+co7WKsQ
	5qnko81JSrJMV3neujMurZIuCGJ8ha8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-vHrB1yxWMY2hwxdYQUZDdQ-1; Thu, 14 Nov 2024 04:06:07 -0500
X-MC-Unique: vHrB1yxWMY2hwxdYQUZDdQ-1
X-Mimecast-MFC-AGG-ID: vHrB1yxWMY2hwxdYQUZDdQ
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e60970ed1dso399857b6e.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 01:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575166; x=1732179966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk4fvCl2AelIitnEUCkAjtoqB7Mo6yKzoNwrEKOPpYQ=;
        b=YfRVZ11vdoRS7Qbq8ik6Y4jvohuZnlR10OLKntnOKsw9+n7sceK5SFtpBg4XNODPFt
         RGZFwhd037njX4GCBCiKCTA2A3zf+uzr5IpzsloqlTlYXNrbAX6Pi+wK2u/CogESBjhw
         M5lXS3dBfuVl1C1CvP2YFnGCw2eUoSG+ihnojmIF8Y7jIk6bNU7yJWW90mPYrkuAwNq3
         HvrIoWNkesUZJA98MzbPauoLfgjqvknO48K12P7+Xzx59NHquX/trbDL6pQzBcIP8rKk
         Z1n+fAI6rbADBfwkUamuSMGDlwH1e+JS5/bRXET45aMnM7iRU7Oc3AlZzyy4VdwVIhMt
         /YzA==
X-Forwarded-Encrypted: i=1; AJvYcCWW6ZaFxIkUhMBRQwnJ6CwO30OVbp/3eL1pTGgIrzhu4p+leknusXtoaqEI9PjCYUiluV1wAbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuz7ttPR+rVExSaNci5ezN3ilwUc/daJ8/J3mK7BSNV3YFebJ
	Ld1mHXjLFD0s+gNONioWmETIw77EECbtjnkfFXiHbJpUlg6hxXnmpi/U9JsHOBYJ350J7QqlDwA
	InPK+zZwFMCu73YW/w9lzX7xgMiQUXtGDKo9cCG89lXdPJOOcNnk2/A==
X-Received: by 2002:a05:6808:1986:b0:3e5:f43a:5d77 with SMTP id 5614622812f47-3e7b0ae1e37mr5537412b6e.42.1731575166372;
        Thu, 14 Nov 2024 01:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJjqamCyS7gbasbpR+3EbOmIKtyYOg8obpLq/VvCFTX5e8vsr5EFqGrfeUbWedvmAQvmsXTg==
X-Received: by 2002:a05:6808:1986:b0:3e5:f43a:5d77 with SMTP id 5614622812f47-3e7b0ae1e37mr5537394b6e.42.1731575166037;
        Thu, 14 Nov 2024 01:06:06 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee933d15sm3223896d6.119.2024.11.14.01.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:06:05 -0800 (PST)
Message-ID: <bf14b6d4-5e95-4e53-805b-7cc3cd7e83e3@redhat.com>
Date: Thu, 14 Nov 2024 10:06:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2 0/2] Fix rcu_read_lock issues in netdev-genl
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, mkarsten@uwaterloo.ca,
 "David S. Miller" <davem@davemloft.net>,
 open list <linux-kernel@vger.kernel.org>,
 Mina Almasry <almasrymina@google.com>, Simon Horman <horms@kernel.org>
References: <20241113021755.11125-1-jdamato@fastly.com>
 <20241113184735.28416e41@kernel.org> <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZzWY3iAbgWEDcQzV@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/24 07:29, Joe Damato wrote:
> On Wed, Nov 13, 2024 at 06:47:35PM -0800, Jakub Kicinski wrote:
>> On Wed, 13 Nov 2024 02:17:50 +0000 Joe Damato wrote:
>>> base-commit: a58f00ed24b849d449f7134fd5d86f07090fe2f5
>>
>> which is a net-next commit.. please rebase on net
> 
> I thought I asked about this in the previous thread, but I probably
> wasn't clear with my question.
> 
> Let me try again:
> 
> Patch 1 will apply to net and is a fixes and CC's stable, and fixes
> a similar issue to the one Paolo reported, not the exact same path,
> though.
> 
> Patch 2 will not apply to net, because the code it fixes is not in
> net yet. This fixes the splat Paolo reported.
> 
> So... back to the question in the cover letter from the RFC :) I
> suppose the right thing to do is split the series:
> 
> - Rebase patch 1 on net (it applies as is) and send it on its own
> - Send patch 2 on its own against net-next
> 
> Or... something else ?

I'm sorry for the late reply.

Please send the two patch separately, patch 1 targeting (and rebased on)
net and patch 2 targeting (and based on) net-next.

Thanks!

Paolo


