Return-Path: <netdev+bounces-119640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DF956725
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEACA1F22E98
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F5157A5A;
	Mon, 19 Aug 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGDwNQUk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC215B14C
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060019; cv=none; b=qwgFpZn2aIv6/PA9+mOJJoGvflerWkLJi5qiDPcLBosAPDt4rAV2oBi13cNPOT4xDUfsdSTpnXha2gSYf3VhV2iB70g14k+epOT5rlFuNk8InZag1kNPk9OTxt+nAt3EeUbBbospte+zNH/UUnfJK4L+KU7MrVTofgiMuRzSUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060019; c=relaxed/simple;
	bh=tH9y1PtFjDgkk/6TxDfwbOwEUcAasfwymRC9jfdbHPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/NgD2slBq+w8e9/pI8KYr5GNKFLgJvh/gk+FapZ8OZBiQM0ZIp2bmi01th4v6u6rlwjPdDeDOerYxH7xnjNVq6RLmvLDALZa54URmxOivNFcnGeqRfNekSP8jB94FCW5RKPH81By2sEaCsXI3AHUZtXFRzp1EV0dqdD+FdMeks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGDwNQUk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724060016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHMFgXHpp+lNaevcXzVX+1MxOHeWwuQTgxK8j+G3IpQ=;
	b=CGDwNQUksC4zwbiX5gLGr2rSAURwCGfyVrNN2NlqXj3gxKuHZkDgMgbXMl9Q42KW9lCzgX
	rAY3HUW9vbU1tygbfizcgqAf6/IfbMETYeEMhOC+Dl8wG4boDW28gSM8u/fLr572sP0NSV
	ZIEifOlP4Emoq8ia4i8DybnwFJqzLwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-zIyH0yNoMvuJq8PTer6PXA-1; Mon, 19 Aug 2024 05:33:32 -0400
X-MC-Unique: zIyH0yNoMvuJq8PTer6PXA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso7858465e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060011; x=1724664811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHMFgXHpp+lNaevcXzVX+1MxOHeWwuQTgxK8j+G3IpQ=;
        b=CDZzFBYSOu1deau4nqd09vhSH3aCU3O2pxg780gnH/y0Zg3H0DHohQqqaTD6R5or35
         a6+/EqyVCsGju0ZvCCsOXgt3X4A9sT+D8aLvWRlEiUaswWqRdfVEkjzMs+w7iQ3kjeO0
         CCyfwZyrOss/snvkhgPKOTXpp8tg1I6U7fKAm1Oc48iLHDRzDPIMpxn9k9PUhaxDSb+l
         F71tnrJO6azx/E56xDokzAksOjanWQR+hujBrrriqt4bgBOu9w7/UGMGyHgZSRBQ+ZOu
         ZwvLOnaUWCVBf9l0wePz5YZdEsP1g4kkkvPDLxX4rSJvIM9GavvbUZ0XtdirN/E/ITZA
         3bxQ==
X-Gm-Message-State: AOJu0YwU/i5KeqYis8xDs/xSHm9HSqVvhHIeN5lq3sbF53JTwZeOgpMI
	uTuxJiraIavRgeMKQ0MqJyAwrK4eU6UJZkL33KVtENmBR6yTFhX29X/o0N1GJMQZQyp2ADxpVh+
	N1k4/U4i9K5LWLj52hXUGEZw3v0yruNuBx/JN2JSpXEfSujh1JsSuZA==
X-Received: by 2002:a05:600c:35c9:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-429ed784772mr43336725e9.1.1724060011139;
        Mon, 19 Aug 2024 02:33:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ9uOIOEGrGApqZ5BKhAqc4Yjc6R0G7dse1e7qkV0XxHaLDgOZDjJ2RRTRkCXg/a2G6Uin1A==
X-Received: by 2002:a05:600c:35c9:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-429ed784772mr43336645e9.1.1724060010553;
        Mon, 19 Aug 2024 02:33:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b7c:b910:7132:282c:aaad:e51c? ([2a0d:3344:1b7c:b910:7132:282c:aaad:e51c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed658e9esm103785305e9.27.2024.08.19.02.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:33:30 -0700 (PDT)
Message-ID: <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
Date: Mon, 19 Aug 2024 11:33:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
 <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
 <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
 <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
 <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/24 11:16, Jiri Pirko wrote:
> Fri, Aug 16, 2024 at 10:52:58AM CEST, pabeni@redhat.com wrote:
>> On 8/14/24 10:37, Jiri Pirko wrote:
>>> Tue, Aug 13, 2024 at 05:17:12PM CEST, pabeni@redhat.com wrote:
>>>> On 8/1/24 15:42, Jiri Pirko wrote:
>>>> [...]
>>>>>> int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>>>> {
>>>>>> -	return -EOPNOTSUPP;
>>>>>> +	struct net_shaper_info *shaper;
>>>>>> +	struct net_device *dev;
>>>>>> +	struct sk_buff *msg;
>>>>>> +	u32 handle;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	ret = fetch_dev(info, &dev);
>>>>>
>>>>> This is quite net_device centric. Devlink rate shaper should be
>>>>> eventually visible throught this api as well, won't they? How do you
>>>>> imagine that?
>>>>
>>>> I'm unsure we are on the same page. Do you foresee this to replace and
>>>> obsoleted the existing devlink rate API? It was not our so far.
>>>
>>> Driver-api-wise, yes. I believe that was the goal, to have drivers to
>>> implement one rate api.
>>
>> I initially underlooked at this point, I'm sorry.
>>
>> Re-reading this I think we are not on the same page.
>>
>> The net_shaper_ops are per network device operations: they are aimed (also)
>> at consolidating network device shaping related callbacks, but they can't
>> operate on non-network device objects (devlink port).
> 
> Why not?

Isn't the whole point of devlink to configure objects that are directly 
related to any network device? Would be somewhat awkward accessing 
devlink port going through some net_device?

Side note: I experimented adding the 'binging' abstraction to this API 
and gives a quite significant uglification to the user syntax (due to 
the additional nesting required) and the code.

Still, if there is a very strong need for controlling devlink rate via 
this API _and_ we can assume that each net_device "relates" 
(/references/is connected to) at most a single devlink object (out of 
sheer ignorance on my side I'm unsure about this point, but skimming 
over the existing implementations it looks so), the current API 
definition would be IMHO sufficient and clean enough to reach for both 
devlink port rate objects and devlink node rate objects.

We could define additional scopes for each of such objects and use the 
id to discriminate the specific port or node within the relevant devlink.

I think such scopes definition should come with related implementation, 
e.g. not with this series.

Thanks,

Paolo


