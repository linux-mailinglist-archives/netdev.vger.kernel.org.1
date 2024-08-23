Return-Path: <netdev+bounces-121413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF2D95D002
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0612D285D7B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3440A190047;
	Fri, 23 Aug 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFxT4gMY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEB1917C0
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423018; cv=none; b=NE9nIfNa+WdnhwQj/GL9Ox45ZveQZLCpJwLYECITMOJfzL4e4j1QfBnLHPw5aYMCxMtUi3aLXeXp1g8/sqKiaaK6wEglIEsm2yPRjUZFO/9RbeEJ64ZRO1YBmzxqjsOkbSHkTJ1MhYyL5gzz6wlWrPde3sHV0X5KCLI1q8Cesn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423018; c=relaxed/simple;
	bh=pSwwgVW44liiS3Jm0DMpZQmBnXDnfvDYXGuHadXSSDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAOqDgiMDSa7HTBoFc6z4rYnYx7EJv9myhC03RutgHAhs7BvAHqEm8sGeglrKSrLM73Nl49OVobn51aJOrtgmYUm950hO24p0/Gg6WEc9w86LfY4uS5OA/oUKZYddH+UvzzzZA1BVi4eanA994pevv9p6GE52N4aZuiSYWRsVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFxT4gMY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724423015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNL0Ru+Z+Mrtb4FEqdY1Yw7u1Ft5opNIjcxP+RKIros=;
	b=VFxT4gMYa2clzpjdwrVa0jzqaKIxS8s2298u0FEBAPiWMAAtfmlfQo56vUy1RAfR5OqEjH
	V0D4OiXa1p3LY0slGyFarbm8yRF5lsHkyDIn0aaJISEZzrL9sf7U/EsB8K6GZCVFl4L6RL
	f+fLZYvfie2yzSnS16Kl/6+bDS6udZ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-KiyTJIbhNoyqmY1lTSInpg-1; Fri, 23 Aug 2024 10:23:34 -0400
X-MC-Unique: KiyTJIbhNoyqmY1lTSInpg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso17900935e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 07:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724423013; x=1725027813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNL0Ru+Z+Mrtb4FEqdY1Yw7u1Ft5opNIjcxP+RKIros=;
        b=Rnu9/Oj63LJKmpuJtJITbJNkFogfZBs2Ibl1Mq4DvKtQ1ce7hYpWTZ1wRwrD0eUGR/
         Dqy1BvNF4NEeT+sAr0Q6MLznIU0Jwn/Hlz+biJtYuH7lrITbQFRhiY8Ly2/hFKEB17xo
         sQoYLtEVfZ8uq9nbz84cTidEKyzAl6q2wh/jNkjzMjh8pDJXMEftukOpKr1kSUnxYeNN
         k69XRAwao6gvtEywqa9GIKC3RmS1A1bav3LQ5Mzky2TjmAXjqaZ6YV/GwaeNS+3PakaZ
         9xo1OrxEq08UaZ1DrLFK3Q+Ij4Pygo2b8+FcJ6aHiZdeOr/maJyoblB+ph8ZYhTNzbnz
         6LgA==
X-Forwarded-Encrypted: i=1; AJvYcCWqOOfcQ+xYATnqIoVpPXVngAmc0IX/wYtOT0JukDjerTo2xpCPFkwVPyd3Eb54oS4vOLVCFCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxisNlY1bLZ1+S80klviLvDFSMvjUNwjq6kR7Arog263MY+TqLh
	com9ZcJOZ0Y8vF7FB/ozzeLOsPf6ec+KfBjMqtxGlDbx2CDoGBHD1lCLeUPlgYLP+UXpL8CA7AU
	v1ELnjFc0u8VKl9vAzxcks2jquyFjgJ2TiHvOWp2A/bN81dMvENzDSg==
X-Received: by 2002:a05:600c:3c8e:b0:428:f1b4:3473 with SMTP id 5b1f17b1804b1-42acc900555mr17426085e9.26.1724423012865;
        Fri, 23 Aug 2024 07:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+DYNhQ+DjTBPsLZlpiDabHOup4c0PdBpONXd+uM+lzpFjreCHEzKp61u+RzaRRAyqRQ+zvg==
X-Received: by 2002:a05:600c:3c8e:b0:428:f1b4:3473 with SMTP id 5b1f17b1804b1-42acc900555mr17425825e9.26.1724423012317;
        Fri, 23 Aug 2024 07:23:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10::f71? ([2a0d:3344:1b51:3b10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5180123sm61337495e9.44.2024.08.23.07.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 07:23:31 -0700 (PDT)
Message-ID: <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
Date: Fri, 23 Aug 2024 16:23:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
 <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
 <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
 <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion> <20240822074112.709f769e@kernel.org>
 <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
 <20240822155608.3034af6c@kernel.org> <Zsh3ecwUICabLyHV@nanopsycho.orion>
 <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
 <ZsiQSfTNr5G0MA58@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZsiQSfTNr5G0MA58@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 15:36, Jiri Pirko wrote:
> Fri, Aug 23, 2024 at 02:58:27PM CEST, pabeni@redhat.com wrote:
>> I personally think it would be much cleaner to have 2 separate set of
>> operations, with exactly the same semantic and argument list, except for the
>> first argument (struct net_device or struct devlink).
> 
> I think it is totally subjective. You like something, I like something
> else. Both works. The amount of duplicity and need to change same
> things on multiple places in case of bugfixes and extensions is what I
> dislike on the 2 separate sets.

My guestimate is that the amount of deltas caused by bugfixes and 
extensions will be much different in practice with the two approaches.

I guess that even with the net_shaper_ops between devlink and 
net_device, there will be different callbacks implementation for devlink 
and net_device, right?

If so, the differentiated operation list between devlink and net_device 
will trade a:

{
	struct {net_device, netlink} = 
net_shaper_binding_{netdevice_netlink}(binding);

preamble in every callback of every driver for a single additional 
operations set definition.

It will at least scale better with the number of driver implementing the 
interface.

> Plus, there might be another binding in
> the future, will you copy the ops struct again then?

Yes. Same reasons of the above.

>> The driver implementation could still de-duplicate a lot of code, as far as
>> the shaper-related arguments are the same.
>>
>> Side note, if the intention is to allow the user to touch/modify the
>> queue-level and queue-group-level shapers via the devlink object? if that is
>> the intention, we will need to drop the shaper cache and (re-)introduce a
>> get() callback, as the same shaper could be reached via multiple
>> binding/handle pairs and the core will not know all of such pairs for a given
>> shaper.
> 
> That is a good question, I don't know. But gut feeling is "no".

Well, at least that is not in the direction of unlimited amount of 
additional time and pain ;)

Thanks,

Paolo


