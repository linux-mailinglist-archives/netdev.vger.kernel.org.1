Return-Path: <netdev+bounces-280743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D/yLmkP6mn4sgIAu9opvQ
	(envelope-from <netdev+bounces-280743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:24:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64358451E9A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE883067754
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E2B367F44;
	Thu, 23 Apr 2026 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CO3G2xhL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563FA2566E9
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946617; cv=none; b=HV6IbpNQrYVUj0iNHS74yFlexh9IgTsFGVkS9/k8n7o9SyhvhftswTkLe0LapvKn+uHLJOlva80NbJ8hNNZqbPkVJ9j4RadPuiIfuPXGPZaTmQon3vEbkFRan/krQdO8IPyaF4xWerVtZvEDX7yJgDpAlkGdzUt9BAvIAknOAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946617; c=relaxed/simple;
	bh=MVSy/b2zs4eMwVilksbzNLBuINbkq1HqDh7W/xQXFj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLBLErJL54M5BE/AaI3a6eMJ94NZNg/vuCY6d7q1oaHxDQ7aWIG0XOohAbQnTT6Qjw3LgBksLhE5zGpITtWWSLuKXm6gxvs3E95qig2cq8yUlStl64QfOoPnTJ++wnLqOeilGX7bAkxVCxetShB5428qohyVUt6ZVRYTmROyOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CO3G2xhL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso60354215e9.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776946615; x=1777551415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OCW1iKu5JZl6Immgti+owr5Q7Y2w+aOD0REQBcnm8Jw=;
        b=CO3G2xhLi2LzTqtBmx1ONsRAvUUG1orMDtfNQoLBw6yQo9n+kPviixq51KiAic0laB
         tKDxCXXuGXMn93D1lI+y7VoLmvodUyRv5s7jVtxSUhQTSwBcpR9S5ObFDpin5tExwLFy
         cQUdyPYFEM1id+pRyPQILuvUjHQYHokyCmqHown6GKGB8j0mQxEODmK8Aurv8ka7/0VE
         CKtmzla12PA9EezlGHhwBHdO/otum5NUkduEINebpjC9ka/zk7MYUdMj7Klcnvel5/aQ
         UppwAItQ7l7MP4VLGWCUuKbNYgIY96dW2xfrznHy8mZCGCZTYxQ9exZPzK0dYYGJNSAS
         NTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776946615; x=1777551415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCW1iKu5JZl6Immgti+owr5Q7Y2w+aOD0REQBcnm8Jw=;
        b=erBfAGJ5vu0YqdRGvlHIlVYLVhzC1zleZYJy9xP4ABQzxlyZ4U1Bwbg8Uim3W7tRm9
         pX+GStraVfKozaXS0bgqbs5rTqqTqP7kyB6JuXClPfDVCAQmIzaoiE7w5POjyzKlMcH9
         dis7o7Dfci2NhxsldSroALQO/twouj7ZyekTj4t/kkAup4nk0n4Yfvih1nwg4ejaGEo/
         p5wHxH2xY0tCfZguankfyL/XYyq+/kVpoyhJXR754ZB+zYthEh8nBD0NhhbyLUCExc3R
         yR8XiPeBJp68MRbLlmUvIs5K2rsfzHEfPt38ocEb47t3ZbxOciIjx3NqV+R9x5TOIZJv
         2xdQ==
X-Gm-Message-State: AOJu0YxWqGOKQapwYEScWPCept23Jj19KtkCMOzWXsx/EMO8r+V1A5Lv
	1cy1qPL/9iUmL2CQbQsHnfQ1bBik3LvhD4j5TATWemGg3Y3vJWiISEUxP8DCZFvMkiLsJYEQP3X
	41kgt9kDm1XwTY3IuxJowHyvzdMUVwzgnoeqrE+YnytEj4e3IzxhQWbDKEAm8N0Uc3W8=
X-Gm-Gg: AeBDievf7vDyAkw0M+lL170wr8WByFuzylp9PsKBwiIUdahOHvT4j52uE1gjAAUmpOd
	dMnKZ6GfvYtLKOA20f98kdhY5X10HDzlxwsxdtQxSAEaZ73bm8PehkgWxJIUEoMZJQCltuT7fxC
	Yam8LfBxvIbRI+F22jeHeZi9qOKN04qXtixEK8qKoxrrQR3OsGKyKGsq72MsFPY6hjPFJtQ6V/s
	FF8jLjGCwua99eSb4w1Mx4gVvs4p9aLxgkX65luMDBOSxIo5g/slcU8/VF6+E3RWtvKWv0MbqiA
	105y0xQYi1M8+LXOT4Qk31EsL7dvyFyOX+/faEYV5p4wUAnALxHmub7Yx4Gm4k9o9zj3q4mtpmJ
	d1n8dBcFgqdo2a8LCxkyAMKjA4ev+jNdIML/4XOnsg2dt1mZHfELJtBHCVMEU55ReYH0lRVTo8e
	dHkijMV3sdQx2WqvoM4hr5FBurJYtGkgQrilh0KYbKYjjNsgXMU6of2wRqw0Jqf11wQj3AAMft
X-Received: by 2002:a05:600c:1993:b0:489:e696:836f with SMTP id 5b1f17b1804b1-489e69686a7mr224314095e9.10.1776946614647;
        Thu, 23 Apr 2026 05:16:54 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8a7c:a6e2:5f00:730a? ([2001:67c:2fbc:1:8a7c:a6e2:5f00:730a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm52410107f8f.16.2026.04.23.05.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 05:16:54 -0700 (PDT)
Message-ID: <7481bc31-44f6-43ae-b3aa-07002644d9e6@openvpn.net>
Date: Thu, 23 Apr 2026 14:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 Ralf Lici <ralf@mandelbit.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Hyunwoo Kim <imv4bel@gmail.com>
References: <20260422123242.530882-1-antonio@openvpn.net>
 <20260422123242.530882-2-antonio@openvpn.net>
 <20260422192050.7c4ca760@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260422192050.7c4ca760@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,queasysnail.net,mandelbit.com,redhat.com,lunn.ch,davemloft.net,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280743-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 64358451E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/04/2026 04:20, Jakub Kicinski wrote:
> On Wed, 22 Apr 2026 14:32:42 +0200 Antonio Quartulli wrote:
>> +	/* Prevent adding new peers while destroying the ovpn interface.
>> +	 * Failing to do so would end up holding the device reference
>> +	 * endlessly hostage of the new peer object with no chance of
>> +	 * release..
>> +	 */
>> +	if (ovpn->dev->reg_state >= NETREG_UNREGISTERING)
>> +		return -ENODEV;
> 
> AI review suggests wrapping reg_state read in READ_ONCE(), I think
> that's legit. Also nit: I think > or != REGISTERED would be more
> idiomatic than comparing >= UNREGSITERING ?

Agreed on READ_ONCE. Will fix it.

As for your second point, I am fine with "!= REGISTERED" as that's the 
only state we should be accepting new peers in any case.

> 
> If you agree make sure Sashiko doesn't complain about anything else
> once it's public:
> https://sashiko.dev/#/patchset/20260422123242.530882-2-antonio@openvpn.net

Is there any way to get earlier access to these reviews? (at least for 
patches somehow related to me/ovpn)


Thanks!
Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


