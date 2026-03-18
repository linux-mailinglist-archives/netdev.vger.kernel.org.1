Return-Path: <netdev+bounces-269053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB6HCam+umkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:03:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B52BDC79
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59B773014C47
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8DB3D7D9E;
	Wed, 18 Mar 2026 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Uph/m+Jb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F57337EFFF
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845650; cv=none; b=smAwQqrssHhU3BFR6/9+aAhFREde2xsn5HrFP5RWdTqW6UG5NhRQeNBBInkYxyoWkSXkwDWVOGqKHawZjBuwjJF2t64fb9LOJoi1BqpopjmQQsnQpAM3FyU9oHjJv8c57dCBxRT8qfsYTkIJJizCBg7fi8o/qHsUMEZRy7ILDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845650; c=relaxed/simple;
	bh=phrZMY/iUGqX9FbeAjQ9S4m4uoKH9/LsPe1PYJCUU9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGU0aYbqQC6dMvtBOesnzE5UU8N/YUyWWYCVrAXvoNdMqglkO7sodIi1bcYqreYLC4q7DQ9bKVdnuvHe0dols4gzGXvCKOofFFUnFr7VHeuGLy5/O2gq3T1g+lE//3bmCnMJTiQdMJR0W8K53AzDcqXxpbCeLUAtQ/mWTOfuwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Uph/m+Jb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so27677975e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773845647; x=1774450447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzi5TLVbzrwenc6vxPwdtQ+F2R3dH5U7IECzTFPhoOY=;
        b=Uph/m+Jb3NH0S4u2hSfy09FB4lDmRb3NDhHMiZnTIRk8KthWlVXRS18o/OS2AnzmaB
         UAAh8u1k8xdUYYtVOlPs6MBXesSG3buI9WgbQ3BDpEERrizme0r9R8YVmnv+HX1OgAcC
         cH+H1BGPPYXeJZkZPAhC6Tine66EOPdwrJtgoPeK0Gg4ZTzCgc8XNlMGo+gV4+pZUtdj
         R8M3sViUu8OyAAAMrZgbm6XWWuW/OYkKo3LQSTEbUaWVYp4z58QxHrVZsDp2m/M7igBQ
         /3DEc1puubz04uGDE7UzzacKOc0imF8dERizigc3OfXgHDZyh13kpEtsXwRWM+sN3ezv
         xrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773845647; x=1774450447;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzi5TLVbzrwenc6vxPwdtQ+F2R3dH5U7IECzTFPhoOY=;
        b=MCOFlaakZxelWoBcrY/Tol7CGdvXFSugAnVyt+a86ft1mCPz1i0G0rQ6E1myHGwaZu
         6Regn7k+Sc2cJwSPZe06TaP/7h5rufm7zmurkzHWnBHEAzM4ClV9FbyifRSlruLOy2oM
         +BHOlB6ZnJ5tyIHTj2HOtPNic3nNpROLmD/kqVb+FQUA7Gcs1rfjG+7znFTTfvYYVBbC
         TKk5Ybcax9WwYGKLfSwjS5L9PNg6Tro7iOJ61WSBgAes1Wu64KaMIFDbr1CR+5OkY8KT
         vn2v3K4mZHxNuHvsArAYQL7Qcgv1EVHayN4XsUvpXRsq33MX1qmByd1FiHJO3suqOgcY
         dQCA==
X-Forwarded-Encrypted: i=1; AJvYcCUPi7s8DIouG8bWCQqGFTq+DeKw8qQVOe+h/HpCqVdy4tFe4b36UKrDimSk75vN8CBU/QI5eiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9GhpmduqH1QOPcfJ0FJCGI9QbOy4IpUw7GfsrCrotJsHMVlk
	JHQG+pcuTGgV4NieS5wKZeFRxEoNnE17/tqRaaxGW7Z6OICkiGFBW591xkgsd0galX0=
X-Gm-Gg: ATEYQzwn54aWobSRTamwVW10q2o5hmwRJpY4AORhf1C2iG0YxiFmAlQXpDdwo9aBkys
	YFYzlc/149DYF/YJ6d03QygPoT788q/2T4Io/1KfM9T3ZzMzKpLlAWu7/Glxxd9rRfajo7p8Hzh
	wpuuLbB0uw7wpYDYaoQBjy97nFwsnjDQ7a/WYH7GEsDgCBP3yPVb5GVgVc+Ny+g9qnipC/qaxov
	DfJ6DiHcBzQz0HoolxXpDB24xxvrZ+fo0gjtxidn+9+GiBNmLdnOrvPqyHLdIXToZJg9jJT9qpj
	CtySX6Jbfu/1E24yHin9+6ze2gKX00B6CiVaCelxN8HAB+DTpcxRC+RxFVPiSsYRb7kC801kO49
	B9blNOD8MGuUqpbf1yrmU70MtbcfT7pkNlBLdBuxpsEriHa98gs1y7EhVR5VyVP3ufBr2I/XX8T
	uNKLqYQhwnT97CCtz6ZNfJ4KyjjjBaxco2wap6kYVgo8B7jrHVcrOGZENY44IlUbRtYPnKl5fPf
	B0NO1WgUBM0x0M=
X-Received: by 2002:adf:ec4d:0:b0:43b:54c9:7d25 with SMTP id ffacd0b85a97d-43b54c986e9mr2949187f8f.38.1773845646415;
        Wed, 18 Mar 2026 07:54:06 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852ab3sm8733045f8f.12.2026.03.18.07.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 07:54:05 -0700 (PDT)
Message-ID: <b17134a2-c95e-4019-800e-ab6ec6982ea3@linbit.com>
Date: Wed, 18 Mar 2026 15:54:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] genetlink: add multi-version family support for
 protocol negotiation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316151507.3958299-2-christoph.boehmwalder@linbit.com>
 <20260316113736.1085a124@kernel.org>
 <085c9532-5440-4879-bcde-4d70c980c839@linbit.com>
 <20260317151745.4562eefc@kernel.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260317151745.4562eefc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linbit-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-269053-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E9B52BDC79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Am 17.03.26 um 23:17 schrieb Jakub Kicinski:
> On Tue, 17 Mar 2026 16:47:44 +0100 Christoph Böhmwalder wrote:
>> Am 16.03.26 um 19:37 schrieb Jakub Kicinski:
>>> What's the delta between the families? Do you have any examples of 
>>> the the version ends up being used?  
>>
>> The main difference between DRBD 8 and 9 in general is that 8 only
>> replicates to a single peer, while 9 has support for multiple peers.
>> This also introduces major changes in the genl family. For example, the
>> "connect" command works completely differently between the v1 and v2
>> families.
>> In v1, it takes all the net_conf parameters and immediately sets up the
>> connection.
>> In v2, you need a new_peer / new_path command first; the net_conf is
>> passed to new_peer in this case. The connect command then only
>> "activates" the connection.
>> So the semantics are completely different.
>>
>> Other commands (like "state_info") were removed entirely and split up
>> into different commands.
>>
>> The specific exact diff is available as part of our prototype DRBD 9
>> branch (included in linux-next):
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/diff/include/linux/drbd_genl.h?id=11b8887a3efae2868037f2bd8dbbc68a8591f66c
> 
> This uAPI header wrapped in DRDB magic tells me nothing.
> 
> The macro wrapping that DRBD does never gained broader adoption and
> should be considered deprecated. Please take a look at YNL and the YAML
> specs. (I mean this as a nack).

We are actually working on exactly that as part of our upstreaming
efforts (implementing YNL-based generation of the genl headers for
DRBD). So the macro magic will be removed soon.

>> As for the usage: the plan is for drbd to register its family with
>> min_version=1, max_version=2. Then we would dispatch the v2 commands
>> normally, and the v1 commands through a thin compat layer.
>> In the in-tree DRBD, the version is currently unused. In the (still
>> out-of-tree) DRBD 9 though, we do check that the version is what we expect:
>> https://github.com/LINBIT/drbd/blob/master/drbd/drbd_nl.c#L426
>>
>> This would be replaced by the mentioned compat dispatch logic once we
>> have in-kernel infrastructure for supporting multiple versions.
> 
> I still feel a little bit in the dark as to what you're doing but the
> normal path for Netlink is to add new attributes and commands in a
> backward-compat manner. In case of DRBD given how "special" the
> existing code is we could probably start a new family using modern
> constructs.

The new family indeed sounds like a way out. So we would register two
families: the old "drbd" for the compat case, and a new "drbd2" with the
new command set. Would that be more in line with the "standard approach"?

Thanks,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage


