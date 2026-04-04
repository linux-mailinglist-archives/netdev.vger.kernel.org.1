Return-Path: <netdev+bounces-275324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OObDKCv0Gnm+wYAu9opvQ
	(envelope-from <netdev+bounces-275324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 08:28:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111339A21C
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 08:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 743433027309
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C507037997A;
	Sat,  4 Apr 2026 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4M/5nzd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7137702B
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775284119; cv=none; b=TJDdW4D+IHixe11LtSY3MRpTLPuOQPVXKwqYaCFzVDynaqPIj1BrtgLbz9Nn4fDqI/eutJxRh3v7FeRFuv8tbRATDr2zAePUc5OL4oIHWAXsPeaMoYUtV6VyQKl7vvF5DG20MdUhyllCVLGfVM/u/Kcd5d1Ig40V3MtzzQwxR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775284119; c=relaxed/simple;
	bh=hwTFZRoADlXh/N6qW8gpb06kXvexppjqxyBSIsIzn0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K0Ue0qOj/KZKdq65sYfB4prxjCnd9VbKwC6hXtWpq2GVrIMSo35MbydlGfdvOt1qpgN4OMwlQsXqwiQod/UYJg8FtsiBFQjk3EabO9v8vpAb6Qb4sjo8FaBt+mrSsjd6Owp2QJiP1MW+gZeTUDx54y2IXDf2Rnm/3Bf49rWZANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4M/5nzd; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2228992eec.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775284117; x=1775888917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cgZZLGPezZdvn7l9dIMqmT3RJ+IWbeo+NSrliAQXbM=;
        b=p4M/5nzd+Dr18QEyK5bADWvrdYjlSw5J1wGDOmv6CFUGRC3PdwE44QVe21DS7NRL7W
         WO5M49jQSYOo/r+hWyv8UEzwZqK70QkQ9UgZyvDgvo2Q5+p3qJLSAxwwrrzsFtLJKgWM
         WOguI2Jr2akCSZ+uxjZE7ynXmMWI+c297i6SdTtEqH/aFiEFzyzgg07hyc6IRVaPXVSF
         wowzH/AorGjkHeGZxQYX3MHXxGsVFGZLSDx/u7O/XCPKiMkH8qEToMwI5MkQ5PFEQiGb
         7QbB9aaEgkp4OXenJODUJU2GONAoSM/cf6DpKxONGyhnTGT9+rJHv7T9atrR2ghMy2k1
         AqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775284117; x=1775888917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cgZZLGPezZdvn7l9dIMqmT3RJ+IWbeo+NSrliAQXbM=;
        b=LRxsMC0mKM6rvmW9NMIWKmUjKo4DeGmA0Acu8INkrsfB/tKD53cunbIEI4qAKsrzFZ
         8uqAqxUYRZD3yZ9HKqdtlaH4wks8fYzRRjGcySm594x6rNSG9heQl1tBKueRSviQjegT
         A3StxcR/JJ7hTbX0GFTYXG5Z84KZL4YbYVUOzMQ4PQaRh50ok6IiN3Ca7uhPyUMbKo/j
         hdnE1q/i2BsMAi8M1RPPg/N0sV68bVnBDxCn1qrTgIKnCNXT/NOnVkzrjG4IT36742zv
         uMMhc6hwDJxmQ4QuUkmUGvUsHQPv7MwB/i74IQdeJrQUCvh577J4ee7r9/uCQfvX4tTq
         2kqA==
X-Forwarded-Encrypted: i=1; AJvYcCUehZcj0VLlcDCw6iv3rHvflgOHhZbKHDiffL1FPQ0JB2H81myzSGNv3DFBj/PQbJH72808blo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLVt1Qb4610VYC5g8S/6gf9ZOD1BgCa2uuD6BgybmzcV9ggxF
	M8Uolbdxqop9mAdBpPsg6pq7wkpSypaCy2M1a6WrkPXCHUmLU1kxSWeS
X-Gm-Gg: AeBDievTEdZznktIuxOQYZXhERxzfgWz05Jd+uj+rtv7qNOcKR4zL1Ka6PqAdIzHoai
	fq/wxhPecjAO2TeAMSnXQ4I2wIgaT+ip1P2E2ETelU8sAsD2lxbrFRJaKbdWZetEnzA6XfOvIhH
	boqj9vUpXXffg91J2/NFQT+AquSkn0FtEfbfMRBfZdmDoHqTU93FXU1sYYndMQbsZMGzs1kzUt0
	+pAT/LXhYKk1Er0KsLkgXlF8QS6BwQ72BspXu2IFD5awgcfNP/kaHmB9pwaa9b5LVAWh0M9HHst
	DUhZq0rVUP0baFOxqmRqjXao4WRd9WYFRAmz/alZY4fJ4cu7CYea2R5Oy/vZJvbFW0IjCCJ4aQC
	hKyIxTwmOxXsCQONkllCqLBVKjajPZZZJEQXI62YtnN0DtZPGDyu91o+J2cs4NOjEwoAzs33cUx
	62bklL+Y4R1jBsFoJJxloZqYTj1/yjwJTPLJNh3Y0YW8MRQUcdzUIbZiL/KmI8
X-Received: by 2002:a05:7301:1001:b0:2cb:990a:b5e with SMTP id 5a478bee46e88-2cbfa5bfb54mr2868306eec.15.1775284116940;
        Fri, 03 Apr 2026 23:28:36 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1057? ([2620:10d:c090:400::5:9b00])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc6e17e0bdsm3433390eec.31.2026.04.03.23.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 23:28:36 -0700 (PDT)
Message-ID: <62c3fcc1-6758-47c4-984e-f6940139de0c@gmail.com>
Date: Fri, 3 Apr 2026 23:28:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: mana: Fix probe/remove error path bugs
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403070948.9225-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260403070948.9225-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275324-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9111339A21C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/3/26 12:09 AM, Erni Sri Satya Vennela wrote:
> Fix four pre-existing bugs in mana_probe()/mana_remove() error handling
> that can cause warnings on uninitialized work structs, masked errors,
> and resource leaks when early probe steps fail.
> 
> Patches 1-2 move work struct initialization (link_change_work and
> gf_stats_work) to before any error path that could trigger
> mana_remove(), preventing WARN_ON in __flush_work() or debug object
> warnings when sync cancellation runs on uninitialized work structs.
> 
> Patch 3 prevents add_adev() from overwriting a port probe error,
> which could leave the driver in a broken state with NULL ports while
> reporting success.
> 
> Patch 4 changes 'goto out' to 'break' in mana_remove()'s port loop
> so that mana_destroy_eq() is always reached, preventing EQ leaks when
> a NULL port is encountered.
> 
> Erni Sri Satya Vennela (4):
>    net: mana: Init link_change_work before potential error paths in probe
>    net: mana: Init gf_stats_work before potential error paths in probe
>    net: mana: Don't overwrite port probe error with add_adev result
>    net: mana: Fix EQ leak in mana_remove on NULL port
> 
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 28 +++++++++----------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
I believe mana is already in the mainline so fixes go to the net tree?

