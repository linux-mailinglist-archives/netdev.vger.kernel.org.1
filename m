Return-Path: <netdev+bounces-297549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WN/FEVcnKWqCRgMAu9opvQ
	(envelope-from <netdev+bounces-297549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:59:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1366786A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:59:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=b4GV6tBf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297549-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297549-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FB5632D2D11
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D343B71A4;
	Wed, 10 Jun 2026 08:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D703B583C
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:52:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081541; cv=none; b=dTGcAiaf9FHCLpoNqNiFPP8ogC6a9UbuzJR107cKg90NCykKfggDKnkU7ylXaNEGuTclL49xtSbECgcutV9b57/7qQmEUXmLzCUIZLqpOjfIZB1ICk+pEBwstUL0uwMYjYFBtuQkeUVEGqqoPyAs8prGpU65bPI27/kxW/wc1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081541; c=relaxed/simple;
	bh=005kqibYyfonRcnHCwlpzKy2wPXsZAtXExaHgcOqx2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3AG+AW89KvSgLlIxbXV7swSklzmB0DPxpW6hUKv3pUbEJznnK+Dmm0dzURXZWR+NemxPdZDtvEwnOmBWsa1tmtwQueKFW9uEuO5WKmY6FqruFF6ZRLny+3sUfB8lqTk0PtaVfXQv/7Nd3B7eEwgEsWi3TXnJDatiNXC7/HTZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=b4GV6tBf; arc=none smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68f0fc103easo771833a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781081538; x=1781686338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=keO9Q9d4wSuesQmYGtEo2JR0GnYAaSiDUln8Q5/lybM=;
        b=b4GV6tBf8+7tjGcAO9sUPh2xtm6sI1zM6D8eeaNJkPftnLoMPvNmX8ID/7bvE6Cqnb
         sEcLO/J1Exie2QtMVAGJf7V5ZSedoLe/LjdOb9cEzU7igO0jRrIvSKexonPQhP22HGxM
         d4wkJ986PCMGH0BB+ReJlaooXGlHBkpmScm72FJTNlSg1gemxi2yiswtUnVc62iBjJZJ
         DTJPAG2aLhKmudxn8lGpaAJwS2mqJOHPPM53oBRJuhs0XXO4rsAQm2Vxz2h36og7MVP1
         65naL/qvhYfnLKPHKRjjCy4ERbujPNTcQ9je/BzDpUfQgOHHXWHcFl8gpKBX/Vl4kwNN
         sfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081538; x=1781686338;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keO9Q9d4wSuesQmYGtEo2JR0GnYAaSiDUln8Q5/lybM=;
        b=sfX9xvSGqOWPRrH6yI5mFkat6n2i3CaOj33Ate1XfFicgVo5IPA1DQES8MpbZ2i5Bo
         hLnhuhCfg/YGAAo/X3bSZ8IoI3vIAw/3TGq3daG5du67dcK7nJwzczmSN8ZBFGeN4wqD
         M4gXd4Jxam55z9S/QtFQHdK3mu/lLmr2tg887iT0towccc1B28W7/xBk6xkeQGBWrD+a
         8yEAViF43lOYjophLdbWcc2QE4dQu8tz+NoMLB/4qnFUzdApc1GP2lz+sWoaC2K2GhNL
         KRdauGGvYKj71qj8C9ZxORMIKLobqqcztH8h+NSpdP4kIGgXxVjwDbAW3i97r+e5EekE
         iADg==
X-Forwarded-Encrypted: i=1; AFNElJ9NbE7FStG/Wz43dFx3dz3dDq5Ji9KzdEqhZrz9v+MdZzRyKHYPJU+ZziJoqX3Njo7f97ZYtug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9UfizL+9zh8JVn3MAfF3VFo/ZvUaXQ1JUm1Tdo4S4XLjjukS
	udtRN9nceioRRgYDTKThb01QcOKtdPEWs7oPm3JsjMzXNiJvGmySABNRzZhNIvTBq1E=
X-Gm-Gg: Acq92OFkk6HHXqv3GZ444P+7k9TUZAYQ6tp9Pr8CEEszsMp370ksVoiAAif1vA/itDW
	/znHbMvkbEHcSxm1N+LNkSRzRav9NB1lx9xAa33cmUniKUGoXWsaKLZA3ZEf7UKiomy2wfS8v4U
	/Zjhl5vlQ18PdjEGxO+s2HBKiHW87eoLZ+WQKIYVb3NgcHFgh4MNz6aROhQclfspu4nc5OnCDUO
	8tgZPhId71bQX4qqSed7uRD51RnPVrCFky5CLQRUT3FkM/H/3WD74VvIXF23jIo/ZGv3m5WBp+w
	0Mpjvv831WXcOV4ggoYYvkds8I+LtwKlCDIG5okMgid9jlHds7LYiROMiepovmU2z4IOsfzZOyM
	DOCOJrMNLKCRqqyiy0OKo0KjP7UDQgu1djeXyLjSlMZd0Aq9B+Ce+fLvYsQA/KCZ081GuvRhdtQ
	gu3WMD1NvyhtUilIy+2cLVTwo4O1U8syHqiP6+QWNcIKM3Lfr4Ol3iuewJALD0TRQF4hbUkFfbA
	WJqrKSjJhOxYwk=
X-Received: by 2002:a17:906:5a61:b0:beb:7979:47d5 with SMTP id a640c23a62f3a-bf93a7144efmr115138566b.6.1781081538525;
        Wed, 10 Jun 2026 01:52:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e05199sm1125952066b.29.2026.06.10.01.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 01:52:18 -0700 (PDT)
Message-ID: <5224a3f8-16e9-4967-9fce-14e1a0fc5205@6wind.com>
Date: Wed, 10 Jun 2026 10:52:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv4: igmp: remove multicast group from hash
 table on device destruction
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260609122646.2297540-1-yuyanghuang@google.com>
 <fdcc6f4b-6f81-4422-bfbc-7376dd5cd19f@6wind.com>
 <CADXeF1FaYn2sDyM3Kfic5eyP2oQO9uQE_rFbwwRZFrOqyWSJcQ@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CADXeF1FaYn2sDyM3Kfic5eyP2oQO9uQE_rFbwwRZFrOqyWSJcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297549-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:from_mime,6wind.com:dkim,6wind.com:email,6wind.com:mid,6wind.com:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91C1366786A

Le 10/06/2026 à 10:37, Yuyang Huang a écrit :
> On Wed, Jun 10, 2026 at 4:50 PM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
>>
>> Le 09/06/2026 à 14:26, Yuyang Huang a écrit :
>>> When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
>>> the multicast list and calls ip_ma_put() on each membership, scheduling
>>> them for RCU reclamation. However, they are not unlinked from the device's
>>> multicast hash table (mc_hash).
>>>
>>> Since the device remains published in dev->ip_ptr until after
>>> ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
>>> can still locate and access the multicast group after its refcount is
>>> decremented. If the RCU callback runs and frees the group while a reader is
>>> accessing it, a use-after-free occurs.
>>>
>>> Fix this by unlinking the multicast group from mc_hash using
>>> ip_mc_hash_remove() before scheduling it for reclamation.
>>>
>>> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
>> A 'Fixes' tag may be useful for backports.
> 
> Thanks for the suggestion. Per discussion in the following thread, we
> don't need to add the Fixes tag for a trivial fix.
> 
> https://lore.kernel.org/netdev/20260604101728.GA771160@shredder/

I probably misunderstood the commit, but you are talking about a
'use-after-free', which doesn't seem trivial for me.

