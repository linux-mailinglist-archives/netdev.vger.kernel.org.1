Return-Path: <netdev+bounces-135707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B5999EF92
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C741F282A55
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC91B2191;
	Tue, 15 Oct 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="DRyvCX+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C51FC7CF
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002460; cv=none; b=NcVUgUS9D6NvM0iRVLH8aqaqxGVZ0UmeiYGlKyR60l4YUY7QCPfwHMmUgwy9008SsAGyBT4BBuZRRN33KCOTQZSxVHsWDeVjxSE7hVdVqwBKzpYzxvgJQnGBT/2HmuzGNyIhInbJkWgnUZsKuxHE+2IldK4T1koRM7R4QKFfQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002460; c=relaxed/simple;
	bh=LDzREMPg7lm2XsgZ8PR2Q84HmhIy8W3ICTO+bfYBdC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6xRx6rOo4p2C+8dRBBIzF8+R3tRFPkuC346+BZ4cWu/yKzvqUqhhzbKW5REvIO9vq2KoaYuNuQNZ6Mpt7ye1zwXQvWxlJcYwvOrRJwe/TUdQGO6PfyUDWCBn7nLE8pP7OAf5T+JXXnUpmxlHjOEE9xBtEImyLmgdmbNKTFhF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=DRyvCX+t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43054ddfd52so8597325e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1729002457; x=1729607257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yi99XkZJIaPDLoptMZdMGj58uMQ96xCRMxR+hnXQ+Vs=;
        b=DRyvCX+tdq9+ih6+5c40XpWe3zze6SRcN2+ekqlew+egWTa7yeykgepkyrdR4hcfS4
         cu0SSb3Zn0iLmUKWJNn2oUcPtUxDU5c5URbjmVinAZY7e1k/+u5t+fISzk+tmRaLGE5b
         QybPqZLALl8DixHPfVeaK0x3YUos0yDCWSO/07ivgxbTKAnUsLdeSI+5g+7jAlyPVYkm
         vE91NlJOQXjHOmHPgDmu0szBnzmIsGobLFu0rw8/NI6vqvo0UU/Kih+SFwBzRAy3kX5k
         kdgw4syu+6GK9BIryqH7633hWJzX7urLqwCQ243wEg5uHKmv+F1JNdWJosxuspfmsZbe
         DKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729002457; x=1729607257;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yi99XkZJIaPDLoptMZdMGj58uMQ96xCRMxR+hnXQ+Vs=;
        b=g5fATuDLguctrFhf9kaaWOOaYwSFodFhe5Ki2MqY6DvgRzIZMV7sMUXuXXKv2HTJ8w
         EtQN5M6D05EJiqUNcFNHE+vHJdJ9ofZWvrCgyrFWam+mLmnj7u0YH4AHjxB9ODgMumdE
         WCyvgPWRCKSSR1YHty8afB+xX5ymCLQ4cds58D5LhxmoA33Pl5NJM/dGkgeMPYaVMP2V
         6CpNuEE/lASAyM6IDc9GiouTPYu6m9pB+6xMT8NYgJ6y6iMFvVhlBO/FBMh/I7v7sxWa
         isYVz/6DZEe1aB9Hv2cywRudc7+cQ8C9CZmZ637BJN7WpaesZ+KQFMu0fJFPw33/0YqR
         WQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXkey16I3f3xTkWIY6NS/fqcgMLVVLv7wHVMUBzyuq0R1OdylPn7ttUNvJGAMcqGmQrCPgsZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZtnqI8pBYFDU4P7lQXfm/nCER4VTzY3MVy58Ar31wzzTDJ/6
	WUEH0/atiJOr9KbauYzSlH7R58W/8bUDvgasAU7zZCAMJn3zdsfEdBLdxJnIYWM=
X-Google-Smtp-Source: AGHT+IELfz1xN3SZCuBaGn63eBUgGaRq0Mqnasucs7o4LA38NmF57Vi7Do5vPXmFQPMTMgxloFqhmA==
X-Received: by 2002:a05:600c:358d:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-4311df5642dmr57250275e9.5.1729002457266;
        Tue, 15 Oct 2024 07:27:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:74aa:e3b:2e9d:4f58? ([2a01:e0a:b41:c160:74aa:e3b:2e9d:4f58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b3215sm19306635e9.34.2024.10.15.07.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:27:36 -0700 (PDT)
Message-ID: <652493a7-ce23-450a-8552-b8abab60fc71@6wind.com>
Date: Tue, 15 Oct 2024 16:27:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2 iproute2 2/2] iplink: Fix link-netns id and link
 ifindex
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20241011080111.387028-1-shaw.leon@gmail.com>
 <20241011080111.387028-3-shaw.leon@gmail.com>
 <3ad78fb0-4aa2-424b-9e91-8c32b1c266f5@6wind.com>
 <CABAhCOQ_EYqsdrAH+aDKvK3h_s3cBfhrYsmAuqCeGkpgx3WUZg@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CABAhCOQ_EYqsdrAH+aDKvK3h_s3cBfhrYsmAuqCeGkpgx3WUZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 15/10/2024 à 11:06, Xiao Liang a écrit :
> On Tue, Oct 15, 2024 at 3:45 PM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
> 
>>> @@ -618,20 +653,25 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
>>>                       if (offload && name == dev)
>>>                               dev = NULL;
>>>               } else if (strcmp(*argv, "netns") == 0) {
>>> +                     int pid;
>>> +
>>>                       NEXT_ARG();
>>>                       if (netns != -1)
>>>                               duparg("netns", *argv);
>>>                       netns = netns_get_fd(*argv);
>>> -                     if (netns >= 0) {
>>> -                             open_fds_add(netns);
>>> -                             addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
>>> -                                       &netns, 4);
>>> +                     if (netns < 0 && get_integer(&pid, *argv, 0) == 0) {
>>> +                             char path[PATH_MAX];
>>> +
>>> +                             snprintf(path, sizeof(path), "/proc/%d/ns/net",
>>> +                                      pid);
>>> +                             netns = open(path, O_RDONLY);
>>>                       }
>> This chunk is added to allow the user to give a pid instead of a netns name.
>> It's not directly related to the patch topic. Could you put in a separate patch?
> 
> Currently ip-link already accepts pid as netns argument, and passes to
> kernel as IFLA_NET_NS_PID. This patch converts it to fd for
> simplicity, so that it can be reused in later setns() call (before
> opening RTNL in target netns).
Right, I've misread the diff.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

