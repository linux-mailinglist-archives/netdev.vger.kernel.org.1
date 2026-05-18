Return-Path: <netdev+bounces-289059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD2kOQYPC2pN/gQAu9opvQ
	(envelope-from <netdev+bounces-289059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:07:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7156D48F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 15:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F14A33008502
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5BF4611E5;
	Mon, 18 May 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="MzLlTkUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BF947885F
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108990; cv=none; b=ljkgb/CAWEUJ5O2MQzfPO//yzR7wblEkc05JBVUNL26SrEVlX+gO8palOXhIuyaCrUX9i2ZE02RRaX7UEEGfUKyd9usJqwIdJHZY6C/ieYbxtu6tPM75qDqJh219hIRBxfp8tPjzEGO3hFhUXfC4qgfBe0Kk2eBAUPkcL6/RWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108990; c=relaxed/simple;
	bh=ZAuMBx6unadbACjjupcjZEyuZSeHhtlA21qQueRbAfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gu7XBbBMpJMqlRkxJZA5YxgQWvm3wjg/cINIPFdy2MP/RA3EKIQgx+wABKsjOI22+lvHXkcior/NbscY3vVuqYR4tpzZ4qMj+W159v+RZykw0NRl8cCwFuC0QBnu22SewFt3RaWBsX0ndRkR+kEA4jhQ3Tpgo5I5XbkhATIfyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=MzLlTkUR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891c569cb1so2615885e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779108984; x=1779713784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0NWlYTSwdMpd9k30WRuv0VLgXhIMq511o0HjE5SQVdk=;
        b=MzLlTkUR/qQFe8Ry+d7kbnM+cnh1pI2DB6qZm+HNjGelgChWSnB0y/eI2NdwFuRbrw
         9H11PnIafcW7bPvepSeQ4//qXsyqxGKierwBTWDnbat3xhn4RA3mdnZK3SfQ98A7RgJR
         mhNT/AspgfDaf9vIM3sJXri2UlyVle2Ef6QHESdvuxGOj4U0yi4QhwM99ZCiIDkk/ApD
         vdMpRIr8U7dUNV3VTW0ruIATNuU5cKuhU1V9jDNQr6Vpf9xQBFlwS85DCDImIFK1PRrz
         GnnrIPz6iVHNz1hGj74bBDRKOV6EVJyqaUD6ci6ieHbUhrp3CT7suBck9bw+vIB95R0Z
         bwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108984; x=1779713784;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NWlYTSwdMpd9k30WRuv0VLgXhIMq511o0HjE5SQVdk=;
        b=nabXNfLidwEQXUaD/fySXfjlgzRhI95sYqNxZmlm8kw2uInnGCp8zoQSdLpiw+jiag
         Yq0oia4+MCKiLBXrSnsQy2FWUBhIjzbbnI88Q+ZfPx8/ktsy6ECdevebOem+KDYnNvlZ
         3A0Rq7F2WkRIbOiO8aiXBUKvaySZy3KwRS7QzLXne/26914MyFBSsU+OSi9SMYmzf3EV
         cT5/O/cSbAEuJrFqrUqm+Ow/p+7D0Dwri+oIXIeTEJISxH3Aaknmx+DaEeYVHPOWLxsj
         oRG0l9BmVrudw1p1sSMXYGgbbyLkxmIO11q2nlkOiO+A09eHID2SlCntskzu0l63QnN7
         iCDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aEGNwa67wA6WRk8KAUW2naFgQPD8cyLQR7HSBydSmzl6jPRPnxLHP3uMcBngjo8k35my25JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcF9EHJFE3G0soM8TUmjN/Tysr/PNZgZ+eIuw+KnIIfOqCNmkF
	CoD0/46QLxy6wG66Cbz+xEf31wXqIEmL3Jt6JJdtS9+tfKOeroWIPXkAZlsDPB1iW6kh8uToSen
	3P2zi0so=
X-Gm-Gg: Acq92OEE1g8IGw9ObauRzmJHgvEayDlmNMhUp7XeJ1HTClmBQoN3mqu11rwQNWWlSv0
	fOiJsmN+bx4lox1ePEbPgBsEfQq3ufzLTurB+mUifsgvGC1ow90rYruWCxS+JgALhXqvk6/3dBQ
	4/Q1rJhgqlCPTh6qHm0U+w8S82j+w/wfeDDGHkBwUZjn2nTdoFJ1EEOKPz0fTEbXuBX49/ysAiW
	VCbd5hj+ZBCYlpCV8y9r/A/5ImQ96Q2xayya1H9998nsIfgfVxXrik4NMcgoy6jirBGF1cgJ9Vt
	Bqu4pb6Bydpw+SFWwOlFhdBbCVaUIMAyYY/1qTjqtgccYdEMpDsb+bb8bcvs1Echm4yAU8EddK/
	96LlV8Sy8f3MXK988zdr/VAzlti9kXwGG9Sy8k8IwrHmW3J3F6yUYrdXOm4EVJTfnaxwn3iyzrR
	oVMqjaPI0OGATnZqy92/jmx6OrqxOArsBUa7UJavGnhxvvVgAYXNr8M9avaMtU1o8klke9wC3UF
	lE6
X-Received: by 2002:a05:600c:1d0d:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-48fe59b071bmr114106455e9.0.1779108984558;
        Mon, 18 May 2026 05:56:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm149189915e9.4.2026.05.18.05.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:56:24 -0700 (PDT)
Message-ID: <5d19e543-ac3b-4d32-a464-377d03cde500@6wind.com>
Date: Mon, 18 May 2026 14:56:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 3/5] net: netlink: don't set nsid on local
 notifications
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, Jiri Benc <jbenc@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
 <20260515201937.2813983-4-i.maximets@ovn.org>
 <40603dce-f801-42ad-96ec-c8c0a57e5aae@6wind.com>
 <5344852f-e920-4232-9b54-5b22f6c8a1d3@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <5344852f-e920-4232-9b54-5b22f6c8a1d3@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 44E7156D48F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,canonical.com];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289059-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com]
X-Rspamd-Action: no action

Le 18/05/2026 à 14:46, Ilya Maximets a écrit :

[snip]

> True and also not really.  The main problem is that ID can be allocated
> at any point in time, so the application needs to listen for NEW messages
> on the same socket that it is listening for the events that are interesting
> to it (to avoid races), if it doesn't want to make a separate GET request
> per notification or track all the IDs that were previously checked.  It's a
> non-trivial amount of code depending on the application structure.
iproute2 handles it ;-)
You certainly need to maintain a cache, but once a nsid is allocated, it never
changes until the netns is deleted.

> 
> Alternative is to always try and allocate the self-referential mapping on
> the application startup and remember it, and then check that no-id, -1 and
> the allocated one all mean 'current'.Yep.

> 
>>
>>>
>>> A search though open-source projects doesn't reveal any projects
>>> that use NETNSA_NSID_NOT_ASSIGNED and rely on metadata to contain
>>> self-referential NSIDs.  Quite the opposite, ovs-vswitchd relies
>>> on the metadata to not be present to separate local and remote
>>> events.  And the 'ip monitor' relies on the metadata to not be present
>>> to show '[nsid current]', though this is more like "print 'current'
>>> if there is nothing to print" situation, but still can be a little
>>> confusing for the user to see an ID for a local event.
>>
>> We (6WIND) are using NETLINK_LISTEN_ALL_NSID. Like iproute2, 'current' is
>> assumed if there is no nsid, else the corresponding netns is checked (which may
>> match the current netns).
> 
> OK.  It sounds like this one patch will not affect your use case than,
> which is good to know.  Thanks!
Probably not, but I didn't say this ;-)
I need to make some tests with your series.

Regards,
Nicolas

