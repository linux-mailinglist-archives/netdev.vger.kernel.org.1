Return-Path: <netdev+bounces-279500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3rbEEAp+42nPHgEAu9opvQ
	(envelope-from <netdev+bounces-279500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FB4211B2
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E1A302307E
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E195332EA2;
	Sat, 18 Apr 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUTQfnFD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11103264DA
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776516615; cv=none; b=mguw7abbYlfZ/GyWn4mvITtuyAnWweYr5aCGzZY/XWQ2RFmDHKRirEMaX6k3C+fbq7yOEWmtv/0P09h4k3sGSdg/6b8CbkXBALv+anc+baNPZs1+rqn9N7cr7abPo9aizxUU1sy3L1oiBMNf/RJpeNPIvRbslmKeoJk6VUvsu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776516615; c=relaxed/simple;
	bh=M0tXSfT7JM044VXBCzuzKbh8vX5g2KQq9XAi4sUhsAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgaZnozYM3Av92XXxCfLtlC2jvCEZFaRVUrM9/0+YtuoeJyhWl5+Na1uUB1Cag5AgVH5pNNE7+YdG1r3u3XddOUcwCKEOm+0Ns1N8FqubHV0yMzjtkScxOLFnllbVwObsAWocnJv4m3AhEfL5hiXs0Xk+C05rqh3RncejM0/e10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUTQfnFD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48909558b3aso1496745e9.0
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 05:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776516612; x=1777121412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HcAorhwCpH8XF2HjpZdeJJq6NDSEecmHHFm7IXbwBws=;
        b=aUTQfnFD8LcgfaVIKdYkfkIQCj1fOGmax9AH8qlLJGXK6THfbU4mVrF6x/yztxqp6Q
         hqsLKfumQfR+XZlbHQomG5NiWykzuRvj8yrJc/p7RWiFpgWHf1ign+DOoj4w57qpUH6T
         +zSPjcYbHLXLKTGSgoR5KjjuJ3AQO+wyaFTPe9c3vUcLa9YxqEiNJIZiDJfsxCiYk4qO
         lYU2xdSzwUbjIHV2GGSsPDtD48Rv/Ou52RimoTcxEf+b1f2x2KjhcemK5PtpkJ7Uvdvu
         Q/60FFtwAhMmdaENmxejwulS3tT6aX8C5ZSGUmiL/RmRHM4QGADGh5iIl5Jey2mWZjTj
         67BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776516612; x=1777121412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcAorhwCpH8XF2HjpZdeJJq6NDSEecmHHFm7IXbwBws=;
        b=SXO5hR164CxP6602+P9KdxFRKM3GibzzpzejJjbO534DU8HS5DVLb5FLYVl3XthWwE
         A/J1O0oBzxNPwkEZ7qbIj07zXVZo7le0k0BgTOyTb8ehso0M/gfeGY6n6tbRYEYNeaNZ
         qJ22zAqvXX3WuqC/rIldiffT3FFSziYuvp2WNgZ/yZqj0tRfNN7NaiQFaG07kQ/1iZ+P
         Vtb/BGaYXTqyeiP+loAVzX4OGLtDlrcQtm+yMcq/8KFDcNJTXfwuWAicXD5947cI3HuK
         z7w0E5grWJ0FiR5Ud2oCkOXNEeRSWRxIFdGHrQd/VvlEauYxyeBTkoyh/nSyIx3BG4T7
         mcpg==
X-Forwarded-Encrypted: i=1; AFNElJ9P0HJfjO9BLwLUks/0FZI5ykJi86Lxyr6x9ybNXd0XPuvw7RGonPY48Iirdt930IwmayoZUGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6S91TPmHskUFIY4jy3cF4DagQjB35J/mkzc5FIp3zILuebaW
	Ni9Ih+BVnWEGdQQAV2JEauhnnZk3Evi7YXin/vbwioXvQaJQc9Cx6jVR
X-Gm-Gg: AeBDies0QwMXQiszWDEXQIpuXPwHDTP71qcjq8tyOaLAhZywRASDoGONMusaekVpo3A
	0nGxz2Ep67Td9e2SRE3k2MrE6V6MjE1o1ybEOMrelmwU5Tjo7fAvrdy8HO+Dit208PXEIQXnMKs
	pdrBh76NhTGYHq6RYHY/XbxNv0wYtWq4UdRFsJwPzWKoHewWtc9Zu0/Y5IpN9cqE6Rqm6tjWdnp
	9vYOh+B+MuRSr1oI+3FrKxKrQ09mxmZyr41Zs+RG8IU+ftJE9iKsEFOqRp2zlOPwbh4fPB2EcoC
	9jApVNgilQjV4peK1YfDsiE1Nygr2vPmRNa5CE+3TwNzrLObIZmVw+pENImqZ4u743y9j3uPwda
	LnNasga8qDJA/POEs7A7jmbr8Jf4FSEBGDm3/F+FxbH3zJlycTHdpRzWNIUo2GmawfYz9XVnouH
	smP9R388Hyt4xl1MCF6UQBj8g38u61PS/htpakDdIornbUx8EtyuQ6PXB62Ld/z28CdZvtrm5F0
	+L7Ye4ZQWAOWKVZ
X-Received: by 2002:a05:600c:5252:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-488fb768483mr105189905e9.18.1776516612109;
        Sat, 18 Apr 2026 05:50:12 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5273:4380:96ab:9087? ([2a02:a03f:a75e:9a00:5273:4380:96ab:9087])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm203612145e9.3.2026.04.18.05.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 05:50:11 -0700 (PDT)
Message-ID: <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
Date: Sat, 18 Apr 2026 14:50:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260417171831.687053-1-daniel@iogearbox.net>
 <60b47924-dae4-4a10-b977-75b92e1094c0@gmail.com>
 <ae053593-907e-4891-90fb-03b4c5d8f5e1@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <ae053593-907e-4891-90fb-03b4c5d8f5e1@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279500-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ietf.org:url]
X-Rspamd-Queue-Id: A05FB4211B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 14:26, Daniel Borkmann wrote:
> Hi Justin,
> 
> On 4/18/26 1:45 PM, Justin Iurman wrote:
>> On 4/17/26 19:18, Daniel Borkmann wrote:
> [...]
>>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>>> index d2cd33e2698d..93f865545a7c 100644
>>> --- a/net/ipv6/sysctl_net_ipv6.c
>>> +++ b/net/ipv6/sysctl_net_ipv6.c
>>> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
>>>           .extra1        = SYSCTL_ZERO,
>>>           .extra2        = &flowlabel_reflect_max,
>>>       },
>>> +    {
>>> +        .procname    = "max_ext_hdrs_number",
>>> +        .data        = &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
>>> +        .maxlen        = sizeof(int),
>>> +        .mode        = 0644,
>>> +        .proc_handler    = proc_dointvec_minmax,
>>> +        .extra1        = SYSCTL_ONE,
>>> +    },
>>>       {
>>>           .procname    = "max_dst_opts_number",
>>>           .data        = &init_net.ipv6.sysctl.max_dst_opts_cnt,
>>
>> NACKed-by: Justin Iurman <justin.iurman@gmail.com>
>>
>> +1000 on the need, but NAK on the way it is done. IMO, we don't want 
>> yet-another-sysctl for that. Instead, we have (well, not yet, but it's 
>> about time) this series [1] to enforce ordering and occurrences of 
>> Extension Headers, which is based on an IETF draft [2] (FYI, draft- 
>> ietf-6man-eh-limits is dead). I think we should enforce ordering and 
>> occurrences in this code path too, instead of relying on a sysctl. 
>> Let's keep both code paths consistent.

Hi Daniel,

> Hm, that series [1] should probably go to net instead of net-next, but atm

+1, would make sense.

> hasn't moved since a month. I'd still think max_ext_hdrs_number would be
> useful given it has less complexity also for stable, but I guess ultimately
> up to maintainers..

In the short term, I agree. What worries me is that we end up with a 
redundant, or even useless, sysctl once the other series is applied, 
which will only increase user confusion.

Cheers,
Justin

> Thanks,
> Daniel
> 
>>   [1] https://lore.kernel.org/netdev/20260314175124.47010-1- 
>> tom@herbertland.com/#t
>>   [2] https://datatracker.ietf.org/doc/draft-iurman-6man-eh-occurrences/
> 


