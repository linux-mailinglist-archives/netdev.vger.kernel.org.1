Return-Path: <netdev+bounces-287698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JsXFhe/BGoeNgIAu9opvQ
	(envelope-from <netdev+bounces-287698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:12:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF329538AAF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 20:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E27430A625D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52173A6F02;
	Wed, 13 May 2026 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxPQyuRA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935833A380B
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695537; cv=none; b=jAF3FVZYVAfX2Jld6rsLtZjtUDT8Vo85+cZiVPgB4mmyjrKZg5dy5lhx9SrvvcIeknNC1pZwSZCA3N4ec57MwFULrGggS9oAf5WVUMrBA/hb4PRtINzdIxsOaYVaTZxaIOC3BaJFBGOmxEBuqbFSVbWjm1f6AxBypm7mjzxPfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695537; c=relaxed/simple;
	bh=tL4X6wi8FZhzdxy8R7zt2Xi3sHY1aMePHUBqZJj1FYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zrj9u2YWPSHAtlxMsehuKhzWTg8WzbLgH7lP3yIqJyf4iqCdSLR8r3UghYHaVK8/nAeWJyWNFjb0KAb+XJUJZcWk4uiXcnVOhJ2j9FW2xcgaQhpQH80lIHlRERn8erdG4UJTf67McjJsEmkL1PhvHoFjRXQ9KDu4s8/Ul3i4XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxPQyuRA; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6ab4476eso66612911cf.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778695535; x=1779300335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tL4X6wi8FZhzdxy8R7zt2Xi3sHY1aMePHUBqZJj1FYI=;
        b=MxPQyuRApj3XszXcCGn5ql/ANKb8pbsQ0i6TlowWK8z1yX3YjaWLPN+jKwOkivQoTr
         RVyzg7EMc4XWlJMrpn/qdmrrrQkhVzFXnq0E344pS96TnZUQKgRtHQ9Uc/+UuIekNDlN
         CFQ+wmtm7Ol8oKz658zFnLR9lxzrarFGAxTv/Z7htbwzROLIAfPrTLLURHnQPajhYdmV
         Cy1K16RwtNX6QsbxwOf4NclLL4fAOrZwd6zTc6nonRzbZNoAq4KXele+24UWtdo4cXh6
         kxXz9YXM0VC/FpC+Gsiy0ffxwlXssbzy94LSuK4HgXcmCAbtXfKU0f3My+PxsxBsagVR
         GWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695535; x=1779300335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tL4X6wi8FZhzdxy8R7zt2Xi3sHY1aMePHUBqZJj1FYI=;
        b=rdpwxKIJ+ZaXUf7sdmEgZ3ChT2bAR56x3LqfNLJUz8SqCjKGNLoC8uwcFvHqY9JMD3
         RhqpT7RZxGYiFbaKLS5e1jv2dM3Hkv0vTu9NFBrn+9zDy0wZBEmTwI/sxOOck5sv5xc0
         pHxslkFt33GQb/jW7nuChA6nraSgTV86Ub+e9GOom1fzPOQ0Yh3yE86S1d1AYeJQd4kr
         CushquWKm2mtdhboWoRgfkMS0hTS0ZsKGj/FGdn94rjyHouGTC4HnkHOAZXQ7kyBsFni
         2rFPo03+vkpBf+3XLmdj9E2BBPXq+bIuUJLxHXr4PkoPsXi9qfLyVmEpmc96RRkl/agS
         UnVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qowV1mfiM+EuLo9JLYsXM8pC/dlU+5rgcouPmObyt34x2wat416irepFtRYmVKFE/APZBdiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/MR1LsfWfvRJlQbmdWCsurfZ3evd3XymIeNO7rpDd7wGsR51
	7X1gDQm7Ta+JucM1QQ/C/zuIOmzMXZ7THZHIDBLDN22s4kqU/3HvUbfO
X-Gm-Gg: Acq92OF44hmLJzIC9FB46jFrC4jKOj7JcH6iEdhYffPsbo4kd7l46Wj2m+5nSBT52T5
	SSS7LxyYlUnTOqZTUFYbn3dr3fsCxpQ95hlH3bzi4TAoAwTgpHfGMMc+CEv18RT2KsMIBVFb1y1
	vSWjUrp7SVDGB5ZdFA+/BOeRKs2l9bwy9IBlNtBdzZjJpOkqjSi+bQKa4fVvgbwju7xtYFP9eet
	Ysa06qnlCFemgFmAEs3YmAJSz9V5DeGxgPo4AZYPi5Fgyh/8qLT4rgLrAQj0INeOuI9+TZcpVw3
	yrOPjOTJv8wwFZ4N9kdXJZTt2Lq9B4Mc/8V8XXtSfV5pN8Ot6YGw7MSz/cRy5qD4ABQY2RRhJZb
	fbF2JxIvw8ZTeQfC5ECk0aYQBQy1HqALIgpiKYlHDkDJUytHAKwX+aQiLtjX+EUm9AOe0OekMaj
	Br2+uSnAh9+yU0h7eAgx7hvOzhvBRD3FUyeLYorBhz1rDTZV6ehAwB/chjMuwgxEo=
X-Received: by 2002:a05:622a:1e0f:b0:50f:c5f0:f2fd with SMTP id d75a77b69052e-5162ff577efmr52982661cf.47.1778695535423;
        Wed, 13 May 2026 11:05:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:7092:fab0:553b:abe6? ([2620:10d:c091:500::afa8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e836e32sm154981091cf.25.2026.05.13.11.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:05:35 -0700 (PDT)
Message-ID: <fbd9e682-9525-4e3c-ab1d-0f5fc483a4fc@gmail.com>
Date: Wed, 13 May 2026 14:05:34 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] netdevsim: psp: serialize psp stats writers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513-fix-psp-stats-v1-0-cdb3174f252f@gmail.com>
 <20260513-fix-psp-stats-v1-3-cdb3174f252f@gmail.com>
 <20260513110346.35c8accf@kernel.org>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260513110346.35c8accf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AF329538AAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287698-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/13/26 2:03 PM, Jakub Kicinski wrote:
> On Wed, 13 May 2026 05:59:38 -0700 Daniel Zahka wrote:
>> The u64_stats_* api requires mutual exclusion on writers. The simplest
>> way to do this is just to add a spinlock to the writer path, rather
>> than making the stats per queue.
>>
>> Synchronization of the reader and writer paths use the
>> u64_stats_update_begin() api and does not require any fixes.
> The spin lock makes the use of u64_stats_t a bit pointless.
> Let's switch to atomic_long instead?


Makes sense. I'll repost the series.


