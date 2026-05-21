Return-Path: <netdev+bounces-290399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBHOL+D9DmrrDwYAu9opvQ
	(envelope-from <netdev+bounces-290399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:43:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222245A4FE9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DCE1308D1AC
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27763D5C0C;
	Thu, 21 May 2026 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="KDSGlPfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FA385D9A
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366980; cv=none; b=aQkriIv9T1aRbsS1UYeVTu8DgcRUBENJX6faaGPiW3qCl5i4jalBObU12Nt0sFJ1mCx8G+GyEc2QOAoCgZ2t18lzVaLpNtUgIi73ky66twoOgUow/NfyqzXCXJ5ZV1HDNu8xFC0rUHP4iU1K0aPDsnHHxtGok2gBS+vFnJPHjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366980; c=relaxed/simple;
	bh=uJWKKIto+eGw/Y8Qn5mFfXiI77w3A5Y0n2+GfY+7Hqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDNGOjZ2a8foobwvRl8UWpwXfJ1jZALwRZMmxGQdG7drY0Pne6zB2eAYPJLtjaVMf8PEGwSGEByY1UMpkMsmyKrpDnJns9BpL+C+N1iJRkn0CJlzxRFQSWlGZ/ds7Bf8slCMyMiLNoXZlTqleVnEwyWu2y3HfoI1TRYImd08vA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=KDSGlPfN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so795969f8f.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779366975; x=1779971775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv2DG/vKNY6iKYozQd3io+YpWsjZ5YJkp1OxFatMD2k=;
        b=KDSGlPfNt55MLmWI5QMvXmYxfaST28x3I9ulkgLhEUYYjj08kfH8575Hvy5GL4n+vo
         LOJLqwI7K3zrHOS0S15BgvN3CO0bd61PZ5+i1myo7nrmLLophJvbVQXIc2q13Iju7u0E
         aRrTgllYpDbdjUdJbH5IlMtP3A+gwpRM8QqbY9cQMgT0D/Hs5ug2OEL/yr4ZjjcNwrwL
         O0b9V7hPzBX9Yu8bI3hg7+INnQnrZSXYDcM74rKrHqxy9dn08idnqclC3dGBBDA0N2Uw
         zsxU+I/wKUTDNaH3+oi4zSCtFJf00s1ewFPHdTN+UrI08IdQi9tiEXPeNC6HkFPoYTwA
         5Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366975; x=1779971775;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv2DG/vKNY6iKYozQd3io+YpWsjZ5YJkp1OxFatMD2k=;
        b=KfaTmcXc66nW/PFIGRFNJdE9k8dkO+/Nx9hb8TR0RsmJnLhE0dx30HHMb8djAw4YvP
         EPRyvIwMPW/X6Cn/zcoDZSCnd9GE0WMItj7eLDuE1H5Po+/DShVBxcbuBKSif7XaTYEt
         oJ72W370s/J58A0EW1JYnS2IKVjdtI1GKXPPNgoEgEm1FBM3aV69sgGQ23aNaIB57495
         w1n2f6nY2zULLvnTOIXMRE83SBFwJKVxpyJCd4TX8qweZ5j5eALUh8WpykK0Lwac/Y3Q
         GKvjZv1njWr1p33yt6gcZXcihe1n6dVJBUTpy/XyAcJjVEynolTaod6lOpb31GbuU42Y
         4WMg==
X-Forwarded-Encrypted: i=1; AFNElJ/PVBVPgqZn4esmyaDQD9PovByxq8A43bErx2GT7+hOBNubOV0vdnRMQf5KKiTXrKnbHW2XQBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpghajmoDllH4V6U7J4JFSWjLMub9gP3k+XLDJofLqt4ai8jG
	xySUr00kH5zYst13KWYnk9fn8pcd6qSHIgZ6aA2opq0uPSZ5qj2OIK5el2StQH20VEo=
X-Gm-Gg: Acq92OFPv0ym3CKAu7LdcXWh2XumzQCBgYfslSkAXi71JdW5h/3bclcuhK3gJ4IJfcB
	ehH9fSmxZIbtDdrvigkI9F3v3EarA5fjqEnZCgrdQ4hp/g4DRqP7ORs23Ch7vk3/9PjWQQS7sTN
	+cWvygqBMJwHa68hWIEM+Nkk8NfEgwM3bSxIAO3VfDWMfHDUQrM3ahTMAD2dHbQalBmAEobUW/t
	2U5QNt2UJ5iuDs0kvX7lJ0vpCyW0xGPOq8aNWEA/LdgQfwgMb/QhZNudMA9XMHCgcNNQIFRZJ0l
	lAF/apWv4/rcIIO1gErQH4e7wzML6XgQpWzuu3W+w53T3yu4GpIL4NX6qhZRXZqK7R2zfm4bEXj
	gCFhq6XFoLIMCgMwsbkZ596WK/SUqxiLArH6iVPYJ8SAj9NH3zXTwiW6WEJfDI+FOE6kFvouwAG
	8mC5uxzT2t7j6agCp3ZQh/a9eerzVOLKEAtuSnxQJwUywhwgvd4x3jzK/0xKhOxJ5IszUB+txD4
	yXy
X-Received: by 2002:a05:6000:389:b0:451:b39:a206 with SMTP id ffacd0b85a97d-45ea3cef56dmr1551400f8f.6.1779366974045;
        Thu, 21 May 2026 05:36:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa937e69sm2356434f8f.32.2026.05.21.05.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 05:36:13 -0700 (PDT)
Message-ID: <bd9c0751-55ea-459e-8b22-8bd24abf235c@6wind.com>
Date: Thu, 21 May 2026 14:36:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/4] net: netlink: don't set nsid on local
 notifications
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, Jiri Benc <jbenc@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
References: <20260520172317.175168-1-i.maximets@ovn.org>
 <20260520172317.175168-3-i.maximets@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260520172317.175168-3-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,canonical.com];
	TAGGED_FROM(0.00)[bounces-290399-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,6wind.com:replyto,6wind.com:mid,6wind.com:dkim]
X-Rspamd-Queue-Id: 222245A4FE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 20/05/2026 à 19:22, Ilya Maximets a écrit :
> In most cases, notifications on sockets with NETLINK_LISTEN_ALL_NSID
> do not contain NSID in their ancillary data in case the event is local
> to the listener.
> 
> However, when a self-referential NSID is allocated for a namespace,
> every local notification starts sending this ID to the user space.
> 
> This is problematic, because the listener cannot tell if those
> notifications are local or not anymore without making extra requests
> to figure out if the provided NSID is local or not.  The listener
> can also not figure out the local NSID beforehand as it can be
> allocated at any point in time by other processes, changing the
> structure of the future notifications for everyone.
I don't understand the use of NETLINK_LISTEN_ALL_NSID without being able to
associate an nsid with a netns.

> 
> The value is practically not useful, since it's the namespace's own
> ID that the application has to obtain from other sources in order to
> figure out if it's the same or not.  So, for the application it's
> just an extra busy work with no benefits.  Moreover, applications
> that do not know about this quirk may be mishandling notifications
> with NSID set as notifications from remote namespaces.  This is the
> case for ovs-vswitchd and the iproute2's 'ip monitor' that stops
> printing 'current' and starts printing the nsid number mid-session.
Why does ovs-vswitchd use NETLINK_LISTEN_ALL_NSID if it isn't able to do the
nsis <-> netns association? How are used nl msg with an nsid?

> 
> Lack of clear documentation for this behavior is also not helping.
> 
> A search though open-source projects doesn't reveal any projects
> that use NETNSA_NSID_NOT_ASSIGNED and rely on metadata to contain
> self-referential NSIDs (expected, since the value is not useful).
> Quite the opposite, as already mentioned, there are few applications
> that rely on NSID to not be present in local events.
> 
> Since the value is not useful and actively harmful in some cases,
> let's not report it for local events, making the notifications more
> consistent.
I still don't think that this is the right "fix". The app is broken. Even after
this patch, the bug could be easily triggered again by a third party.
There is nothing wrong with assigning a self-nsid. It would be a lot more robust
for the app to assign itself a self-nsid when it starts.

Regards,
Nicolas

