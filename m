Return-Path: <netdev+bounces-289055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB0DKeALC2pN/gQAu9opvQ
	(envelope-from <netdev+bounces-289055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:53:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1139256D16D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E265A30A766D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A5436362;
	Mon, 18 May 2026 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="a528SPgj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992742EEBD
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108398; cv=none; b=OUsqI3fea7TbML7Sv1mm74OpZjYWq9ZiWIBRk9JrXdbwbX0oRSoaoMy3LR/juguaP1UsjLlcWMXlaT/avVRmuotWDw1JDA8BuwQHUphMQ9s1QUS/iM4V0agyb6VBbfELDEUDkxtmx9x9HfPhLb/S2uhWOcS6NKKt22gxNzHLAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108398; c=relaxed/simple;
	bh=WxfkEGBSDDZghQhEd8cunw4cIMQIp0QRK4UAokQx9ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAh7YWQWSeIjumRrAq3E8l6LXm0SnpzO5vtwlfx/6cE2ts9Xpwo9PW/uDTRGiTg07sHUbvK4xTCU/YNd2dT9Rf/8zTlFDhjnkM2deE6EM3o2U20ATdBl9EgZ/okV3h4DAHqaiK+HWx2wEghp46t/H3reZ4FCJw/CdQ3vAYCFUAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=a528SPgj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48e72b02bf6so3001375e9.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779108395; x=1779713195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XkbPTf87WHcjTkOIdvBF4Uyie2ELBq9sAWg2d8Lhc/w=;
        b=a528SPgjg5pAce01xmAki5KbGVZGe7/DMH0CNJkfn+YFCxFzVmAOheqstQ4lDHt9lS
         HajOEnY73LfIczgVvlgxIQXVG2gjgLXJrMkq6AF5Cmja0JChpwCDg8JKebbOLNPTD5f6
         qsLd3zoR3cGBroLyvD7fuQK0ew2BljCqWR1BugqWCycwrvEDIns/vOtWgtfkHywi7kC4
         G0WMIUwaXkNIN5Fn2Cr26uNDCjJwUAX+m6v2uxLrL9nnnru7ojU3LMsblNlGWf5MA7lo
         sPu0g+oSPjBvKn1HrPWWy+MFszfvjOcMo8T7e8ST141+hun1sJRhv+UaEsw7tXK0CmIe
         6/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108395; x=1779713195;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkbPTf87WHcjTkOIdvBF4Uyie2ELBq9sAWg2d8Lhc/w=;
        b=Uzc+up2wvM/SL7Go6JYeD7uwnfIMEftRGRVQphh6nCVj0UDM+7LGvQGPuScr26TBbC
         STQmdk13/SexZb9CHHHxre8kCkp5Lrqd4Xq+2dCc43mSbiunIIhceKDVjlSw+ZIINz71
         XWEzhodmbFnvFnXPZeQQwb+/dzQvMofoLcNHPONYyWM/nZ01okmm3ZU69ZsFyh92ec0X
         3/ifrys5QjJD5lj/eK7k45CHIdXmAWGefPYgvknNHJL2BcPLsw4DL7HKCzD4InNn1EAq
         vXkus6Lup3iENUKxZg2Et5hK0jZu5NEE0rW3CTONv9/TkH/icqjwzJ0AodZ1IvT+z4//
         VZXw==
X-Gm-Message-State: AOJu0YzphRM0IqYP5SlXHa6WPT2r+qjJ3N2ne16HnZuu9yhfdyH0DZPE
	OKfTEL++ghNl0XR+mI+FyoJlpBe3EW/cO8D+f3re7kX0HkrB9XF8+1AI4Kho+J2JxQ0=
X-Gm-Gg: Acq92OHZXVU99/qZohVubuAtjzMo+mFT8zV2MWiuVmMVhl+5iMH4k59Y3v112DgDOJR
	s7z+NWKDjlTFUuh53YM6L8na5r/PCvij5WyMPfostitA6b3oLf7Y84iFcUJs7KlT7U6NAqEQpF5
	YzQRwh30Tz/S/b9VbF32x/fOwE2hPCZcpwlfaYWeEgtnmFjCXEs3o8vumhLFgDqy6BC8k2EUV5g
	aZZohUY4+Cxl4ykr/bc5a+QH6wDgDvSg2uTGf4nDGDyamiBg6gqXQnX3sdTADBwceby1uDJqUWz
	xfkqh8XxRorlv8xdCEEFnwwf9Lj+h8EyyxdYOTqJCacTh/HShUwnHfV14jDmfv6PhGp2TovcGt0
	AEsV+nC0Dl0Z9Zc2eQ6F0/ApctJh/Hk+/Nlgj2IFs40mcRQhpz/ImrymaGfO2keYfGsO2QldP6l
	71mnxiwU51tTahSB7MgyA1oCBOx+E23I1skvnl8fe6EKbkpWHR8XAnDYoTDEUSX3HqgYfPRVSbG
	tkn
X-Received: by 2002:a05:600c:4455:b0:489:1fa8:b895 with SMTP id 5b1f17b1804b1-48fe5fcb2dfmr116067445e9.2.1779108394716;
        Mon, 18 May 2026 05:46:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab7c5sm265288175e9.12.2026.05.18.05.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:46:34 -0700 (PDT)
Message-ID: <5d4467d5-f081-4f7e-ac3c-9134ee8ddc6e@6wind.com>
Date: Mon, 18 May 2026 14:46:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/5] net: rtnetlink: fix link nsid reported when the
 link is local
To: Ilya Maximets <i.maximets@ovn.org>, Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Matteo Perin <matteo.perin@canonical.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-2-i.maximets@ovn.org>
 <20260518082138.37522db0@griffin>
 <8aa4e92d-0498-4335-b3b1-dabd7e507ed7@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <8aa4e92d-0498-4335-b3b1-dabd7e507ed7@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1139256D16D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289055-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com]
X-Rspamd-Action: no action

Le 18/05/2026 à 14:11, Ilya Maximets a écrit :
> On 5/18/26 8:21 AM, Jiri Benc wrote:
>> Hi Ilya,
> 
> Hi, Jiri.  Thanks for your thoughts on the matter!
> 
>>
>> IIRC this was added because Open vSwitch needed it. I'd expect most
>> users that need to deal with cross-namespace detection to just switch
>> to the given netns prior to issuing RTM_GETLINK; at least, that's what
>> I'm doing in the tools I wrote.
> 
> Yeah, that's also what other projects like FRR are doing.  It's a bit
> of a hustle for multi-threaded applications, as AFAIK, there is no way
> to just move one thread into a different namespace, so if many threads
> are doing something with the network and you suddenly need to check
> something in a different namespace, you can't really do that without
> pausing all other threads first.  But that's a separate thing, unrelated
> to the series.  I'm just ranting. :) 
Hmm, not sure to understand. setns() is per thread (see man setns()).

> 
>>
>> On Fri, 15 May 2026 22:19:20 +0200, Ilya Maximets wrote:
>>> But this doesn't work for link nsid in cross-namespace RTM_GETLINK
>>> requests.  For some reason the code checks if the original device
>>> and the link are in the same namespace and not if the querier's
>>> namespace is the same as the link's.  So the logic becomes:
>>>
>>> - if NSID is not reported, then the link is in the same namespace
>>>   as the queried device.
>>> - if NSID is reported, then the link is not in the same namespace
>>>   with the queried device.
>>
>> I'm not sure I would call this a bug; the original idea was to use
>> IFLA_IF_NETNSID to switch to the point of view of that netns but
>> without actually switching to that netns. Hence, the netnsid is
>> relative to the caller's netns but otherwise, you get the same reply as
>> you would if you switched to that netns. If you think about it that
>> way, the current reply is consistent.
> 
> It makes some sense, but the fact that all-nsid notification and the
> cross-namespace RTM_GETLINK provide different IDs makes it inconsistent
> in my brain.  We have:
> 
> 1. nsenter(target) + getlink(local) = target-to-link nsid.
> 2. getlink(target) = caller-to-target nsid  + caller-to-link nsid.
> 3. all-nsid-notiication = cmsg(caller-to-target nsid) + target-to-link nsid.

all-nsid-notification appears before cross-getlink.
The goal, for all-nsid-notification, was to be able to receive netlink messages
of a subset of netns in one socket. So these messages are provided as-is, ie
like if they were sent on a netlink socket opened in the corresponding netns.
It's generic, there is no need to patch every subsystem.

cross-get*() have been added later. The chosen behavior is friendlier at the
cost of patching every subsystem that is supported.

[snip]

> If we don't consider this behavior as a bug than I'd rather just document
> it and solidify in tests, i.e. drop the code change and update the tests
> I made in the patch 2/5 to make it clear what is the actual behavior.
> If we change the logic in the next tree only, it will not be possible for
> applications to understand what is the behavior without checking the
> kernel version or introduction of extra flags, i.e. we'd have to make the
> new behavior opt-in.  Which may be fine, I suppose, but will require
> application changes to take advantage of.
+1

Regards,
Nicolas

