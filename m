Return-Path: <netdev+bounces-256716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO0QA9dTg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:12:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61378E6E5F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D8833025D3F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9540F8E8;
	Wed,  4 Feb 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Un7UE1p0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4E40F8D8
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214248; cv=none; b=cn3cUy6664Qbwbvb4SFo9B920uZAIGPuqDFa9bLjOxPOTHNbm4QsEIdd/rLL2tIh+GHVw3xhTCnXeGZJy3ast3PCuE4pSHWOSz2O8zPUW6ZyiBUs+Ql+JX/kx6l6anehURH8PBw7enFX4pb2vKTxsLQdO0MUsD2OFt7tXFbZBDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214248; c=relaxed/simple;
	bh=lb97kICqZkEfNJskybYsm8xXdoYlzU+8Qh2sDn3m/DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQJjEujSuLG2+bGQfgw7GctOQ+yTJRREKljTz1wcA/ctlst3T9DTwrnUfyjz5KxejOXk57pp6p7/YqpQyTSIahGv7lJJg2+D5xLIQg58GuxVJ09eIJx2bOsesYSJ1Vt4RdgQKC9vrPV1DxXkuYoXBH5PjBFJXKQG5G8mvYN2cXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Un7UE1p0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso68745925e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 06:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770214246; x=1770819046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5g5tu7NkC1NyRumZnXOyzW94w4dTwG3/sJw/iTzzC2Q=;
        b=Un7UE1p0OHcaXaTAp8m7ikncU6AnJAdeaQt5TgtMXNtRhKGycZaKJbHS65m+ZXZ+OD
         drmz9T7iz1/EH+orWTlVO6JpT3LuqUY3+Z97twAWsiC147ecY8EQl228FGXK1wRL57Dt
         Ql0WrMuu6nP8Ch8oFT9/AG6bAc9yPZ2RAwkfyXTGnjqYSeQCxJrMWWskEFNsQnX36tb8
         nhF9WQyo2XiBRZ2P7cGOvyoHut44h0qWPI/XEQlGpLR8hWrmdD9h5k7f8liCINgoj6GD
         GEZ5GyAZJB0Ma1LKA1DVRyqVlq8u2cLj2ZQdXeRmSs2Af3g3cf2NwEhp2fdQ3W4dcOrB
         HHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770214246; x=1770819046;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g5tu7NkC1NyRumZnXOyzW94w4dTwG3/sJw/iTzzC2Q=;
        b=gkIbCwQXkx9V8s5yOHbS+0lyYl/nDXVxzdgQtCGUVUxeiRICQsKr3PvJU8L9jDQfKh
         y+RWiAqlIkQ7F7k9F72PPk8S4bbF4h8gb/cfGP0GeU5USWIVv72Xl6mFwOC1LQ/k/Kdu
         +p54L1DQGJtH7GqgnaE19HTy80SJCRPQhH1TQgr47jS4Tgz4kOS2WAj5fhx/rxr/u2J+
         xAEHZsTqkTqCXJjgdnD2SDhY4V4OIu5Lqcr2tp72uVRIdqXTh1qjJPeJpe/mYkppQVuT
         ldov402qleJatsTyYrzr/NJX0GR6XpBhAPhbp3/49UtmTdPO9PS0aeS5841sSg+bSevJ
         R56A==
X-Forwarded-Encrypted: i=1; AJvYcCW3V2WbFmolpTZckbD+s1Sxc/FYNKiB4rb9wkAQmoDhibcClp4biv8EKEBLM5TLkt40SaeHPMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQ2tTZ6cL/Gbv4HiugQDDzsDWg1tg+oUfz0WvX3bWz6Urigwe
	yH1NRTyAlkckSq8UvunANAgpvsKe1XqjszZ7dyxnfCIGBEqfjP9VZK1F2dVhz9D5gLgIo8xQezs
	ybL1S5zPAYgaaOP5JVUc1OQ0heHwSt1DCCg7VXtMWo/ei8v8kUnE=
X-Gm-Gg: AZuq6aIlqbCeQuG6v+PJPKxi5U38zEDP+tqyvnOESXKrUB90noiZeTyMMzjXmF4yWCY
	LOgaphl0M20Uyvmb1kfYJvozqoW3gnsM0U9QnFD6wclkrcqIdfZ+SL61HvAAZJDFcUxrCKb5JjE
	xP9NURw1DsRRCGKhvHDw5Iu7oQPXr4GVIHW4VQ162Qc33UGGm9Kz9VfPTv7OXGArfRTtYJ7aK7E
	roBYEvy1wHmPrf53aRQSIBwUwaxMZWz74yqGdQ/UHGChvuyaFQEBvoPGPdpMP+3HV0FmKxZRDkk
	Rqf+9UMIcWKWahukZjqpz5j5jdevK/406BdQ8tUj/8g0sUOZbfjZLJmrBWWj8cLhIBbmBAPH5LK
	X74lXhm7PJrDB+jwqlizQ2w2BAj7Xpohlj5h23iPeYAHo7pGBgppJZQ5w/UmmG4kkohXWLFaEgG
	sqihFgEEshWQpKMzTru7ViFt/UY+GZlMw5tucP5+WFoMUKTXW0oQ==
X-Received: by 2002:a05:600c:1387:b0:480:1b65:b744 with SMTP id 5b1f17b1804b1-4830e97951emr41836555e9.28.1770214245843;
        Wed, 04 Feb 2026 06:10:45 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4ddc:7186:b823:f29a? ([2001:67c:2fbc:1:4ddc:7186:b823:f29a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831091a0e9sm81705425e9.10.2026.02.04.06.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 06:10:43 -0800 (PST)
Message-ID: <8d597858-a3e5-42dc-8289-2b74cd362d33@openvpn.net>
Date: Wed, 4 Feb 2026 15:10:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ovpn: Replace use of system_wq with system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20251224155006.114824-1-marco.crivellari@suse.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251224155006.114824-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,linutronix.de,suse.com,queasysnail.net,lunn.ch,davemloft.net,google.com,redhat.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256716-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61378E6E5F
X-Rspamd-Action: no action

On 24/12/2025 16:50, Marco Crivellari wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>     commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>     commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> Before that to happen after a careful review and conversion of each individual
> case, workqueue users must be converted to the better named new workqueues with
> no intended behaviour changes:
> 
>     system_wq -> system_percpu_wq
>     system_unbound_wq -> system_dfl_wq
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Hello Marco and sorry for the delay.
The patch looks good.

Acked-by: Antonio Quartulli <antonio@openvpn.net>

Jakub, do you mind picking this up directly in your tree?

Thanks a lot.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


