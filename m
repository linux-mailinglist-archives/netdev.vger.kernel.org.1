Return-Path: <netdev+bounces-207928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10726B090A2
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997F61890B33
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC372F85F9;
	Thu, 17 Jul 2025 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="mIoYXInm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091015A85A
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766282; cv=none; b=oB2qSH3R6XxQvjpBDG6E47G5KcnFjxS+9rqMbPAUYZfPmhp91gfanWOrIzyP4EZc2e+47wgT+iMvqHsUCHmB0KlhGMUemF9PSZGt8+/NmOmKJe9lXLNkBDzEGRvIUP9Z+A4IoT+M4HGwhzHiUw1DX86fd1iZ275OCiMKgOv8q84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766282; c=relaxed/simple;
	bh=99I36GBYDeNUmWkoyb+KIqZfHNUGE7tGbW8aIIu+V5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbNh2hnyduQ+uZdOXbqPANkCZhOLCwMmL2BAC3WPhOJqwzPMchaaSpyJ4ilG6ahFMHu+MKheAgBEH1beGliTS42FBk5ybL9jPN3pOHUb+70NQ33tXyOeyZDv4iTd2zOHaDhMQ0s8E/Dr3NvhMpGM433POnKvD4B6ZXTahB0a3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=mIoYXInm; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1752766269; x=1753371069; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=D47TUbC6PKtN5Ps2F2w+d+aNYLg4bLwm/LXLz/LKsUU=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
   b=mIoYXInm46EXNtvppVY8Jd/B952Un+Euw1eGLnofuqX7UYBK4pQWLYxYG3JWW33a+2g9+rFwWOlKCPrP7aHMXszhhePzwNEo5s8i/NbdLeRRENZNV8ojjsfh8K0kPwLDpygT6z8FmvK2VoG4G/pan1Fpxf7/QcTffwEF2Qyf3pE=
Received: from [10.0.5.28] ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507171731080833;
        Thu, 17 Jul 2025 17:31:08 +0200
Message-ID: <924f57a8-deaa-4f7d-93ee-4030e2445a01@cdn77.com>
Date: Thu, 17 Jul 2025 17:31:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] tcp: account for memory pressure signaled
 by cgroup
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
 netdev@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
 <20250714143613.42184-2-daniel.sedlak@cdn77.com>
 <vlybtuctmjmsfkh4x455q4iokcme4zbowvolvti2ftmcysechr@ydj4uss6vkm2>
 <CAAVpQUBNoRgciFXVtqS2rxjCeD44JHOuDNcuN0J__guY33pfjw@mail.gmail.com>
Content-Language: en-US
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
In-Reply-To: <CAAVpQUBNoRgciFXVtqS2rxjCeD44JHOuDNcuN0J__guY33pfjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH: RefID="str=0001.0A00210E.687916CC.0038,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

On 7/16/25 8:07 PM, Kuniyuki Iwashima wrote:
>> Incrementing it here will give a very different semantic to this stat
>> compared to LINUX_MIB_TCPMEMORYPRESSURES. Here the increments mean the
>> number of times the kernel check if a given socket is under memcg
>> pressure for a net namespace. Is that what we want?
> 
> I'm trying to decouple sk_memcg from the global tcp_memory_allocated
> as you and Wei planned before, and the two accounting already have the
> different semantics from day1 and will keep that, so a new stat having a
> different semantics would be fine.
> 
> But I think per-memcg stat like memory.stat.XXX would be a good fit
> rather than pre-netns because one netns could be shared by multiple
> cgroups and multiple sockets in the same cgroup could be spread across
> multiple netns.

I can move the counter to memory.stat.XXX in favor of this patch, if 
anyone has not started working on that yet?

Or are you suggesting to keep this change and also add it to the 
memory.stat.XXX?

Thanks!
Daniel

