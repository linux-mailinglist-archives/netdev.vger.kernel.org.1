Return-Path: <netdev+bounces-299399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XNy7MNfZL2qxHwUAu9opvQ
	(envelope-from <netdev+bounces-299399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF753685808
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:54:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CT26Ye4a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299399-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D336F300443E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987C370ACA;
	Mon, 15 Jun 2026 10:54:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C736F418
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:54:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520849; cv=none; b=XCajEaOukEOx9UnPHNMk9SP8X3HVwuL4Kt12Xj9g78/EmB+oRF091ZPCNJpyz+LaJ5QXP9XkpNMHg99ivHepNrv59uu8R8EfOiGHN2LLd23i0S6lPwwSgsqAoTjQs/oLESQrsYWIrdvaiqPz1R2x8ZNx84GtBzovLib7dp4wmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520849; c=relaxed/simple;
	bh=4J3fSrNCPDhGA0QB+mqJ0TBAkY6A11NOolVtpoUxBJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZb8IHz3Eoi5DgehstqSleufzU1MMNgQzj507aPBQBEK+ijrXvN+OP6cGE89gwZdgh5f1N0tzEO1rO2+PUX4qo1h7Z2af55jrEpkATtABLE1wrv0Pd5ZRX9kvhxI4fj4EAP6cNpd0iCCfTj4iW3z2w5VEkNVd/PJkQvRilrzGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT26Ye4a; arc=none smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68f36e1663cso5352524a12.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781520846; x=1782125646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP70DMXPOdSRIBKba6A8xHTfphyJ3bhzhgpyBfZO6/M=;
        b=CT26Ye4a9Nsjwk17tW8uSg0q/UHqDoMSghXJaNNT6Kg8g7wJFiZ8Th7mYnqgKGqpUv
         hkIp6y9nut+KOsGZxH9no7DZ/orY0lmfphAxsaW9FFWQvDvesLRvGzxoUhEdpO/isbCn
         f+jDw1lcVAiHc6/j0k1gcbKh0jqAMPNr2J7zFxTU1db4RV8xTbDAVtSEw+FP3ksl0Nuw
         HPJPWN3f7wjDbXTa3tQao7KC5vb+BeR/hR4Vdo3RPJ/K7wgNoe5LXJLz2EbGC5yn8BRC
         ej30f6ZskjsJSGHNvxlD8lyngcWURsgxMeqrO4V1qyqu2niC/Hq+77U8azvm6vJVBgjc
         /NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781520846; x=1782125646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hP70DMXPOdSRIBKba6A8xHTfphyJ3bhzhgpyBfZO6/M=;
        b=hDCbq0SwTYysZ6E1augANyQ3P0D2vYyB/5WEPKIlGMPsteAHzufJ5E1ueYdT3Ca/Ff
         L0xWE2J4L1djg3zCZsvVu7GPC8yrHa43XVDLKGiHgeHU0IE9FclUyNbUAfl5YcfqU/Ie
         ECthiOMpayMKyUfkKOrZ3ZhvwRwHRWFbTuDj8ZKdjBkM/RBCW8DrwbkMolBfa5k39Cm9
         fy7eFXGieOMenTEGgLoyHR93ol7oP2l3tnn9J9a05JVH2azvia4tTyFdSlu5hILdfvAA
         CUDhtUSlM+suRvYyqKFfO7lafxIK6ONlP5qCkgalmRWs7v4WNOXDZCf8+5e+UdjtCQNZ
         bEAA==
X-Forwarded-Encrypted: i=1; AFNElJ9+0UA9cHCnCsylXrdU3rtqnxaj/Ev2ypylybGhyX7xHEWyiLhHFFXaEqadC8wWPfPJ6JUoHRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WmQm8jdmr6e1NFhzLZlUwfPMxwCAuVw28LHVJjCaDiBqdJBg
	D+m/HvLiLHIi/LhQOx86HBt6IvTMypH7Pzmc4TwLh7S7Zsbevkoh03hp
X-Gm-Gg: Acq92OGvLwqi7qP+1D8s136U8J0pMUE/Va+VrYTgKWZn+iIFFuxspRWEUyNazNRBb4j
	a5JRE1nTjcpDh1K82ncVie72gI6zdHfgAhSpuSrocut0jSd7xoVHtQcItdhb1i7xvBlRRY72/RE
	uxpRFt1ADOEu4aa3rG1xce0AmzvPhQsA3jJ1xNjO86BqQA+JZKo9X5/J3zirLJQV/u4hbKIM7pG
	PtfHJmckTP1VyypzLkB8dianG3tFl5N8aJM2zKRJXyJLvtTlp4h+HTFYUb0W6rmfqR82kFlbMHR
	EmhUWxuRxyjc1iIpNgxB7wBDTKeaSQIWECTmt22Zw2e4bR6y+Solmh35BQ2sC7Tp2swyo4T7VJz
	0+gCF64HdmTmu3nV1vqg9MNUm+ssD6VPf5I5HqQ8tAviINpbFYCJHf1sOEnCdZNqUtQz6pMApgX
	WzADWouZIbZqX6OJiXW3ydhOaVmiagTl1KFLmbjZXKk5KjFnRaeTD4U6d+0WVYZv6ohQcneFcqd
	maC6sWMgdvuuXU3nV0s3e5+OAWWmLAFelCNgQOh1iE9M8qeZkMJXUUpC2WPlXGYnB0RXw==
X-Received: by 2002:a05:6402:42c6:b0:686:9c15:3121 with SMTP id 4fb4d7f45d1cf-69378600b25mr6363559a12.12.1781520845572;
        Mon, 15 Jun 2026 03:54:05 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:2bf9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6940c7456a8sm1879319a12.16.2026.06.15.03.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 03:54:04 -0700 (PDT)
Message-ID: <991fd6d5-41f6-4cc7-b6f8-d56e4be6c638@gmail.com>
Date: Mon, 15 Jun 2026 11:53:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] netdev: expose io_uring rx_page_order
 order via netlink
To: Dragos Tatulea <dtatulea@nvidia.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jens Axboe <axboe@kernel.dk>
Cc: Yael Chemla <ychemla@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org
References: <20260612211709.1456966-2-dtatulea@nvidia.com>
 <20260612211709.1456966-3-dtatulea@nvidia.com>
 <d0401fab-61c5-43e7-93ae-d4757433eb7a@gmail.com>
 <b581d253-135b-4c75-a50d-2049c6d6e249@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b581d253-135b-4c75-a50d-2049c6d6e249@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dtatulea@nvidia.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:axboe@kernel.dk,m:ychemla@nvidia.com,m:tariqt@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:io-uring@vger.kernel.org,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,kernel.dk];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF753685808

On 6/13/26 15:09, Dragos Tatulea wrote:
> On 13.06.26 11:53, Pavel Begunkov wrote:
>> On 6/12/26 22:17, Dragos Tatulea wrote:
>>> This adds observability for the io_uring zcrx rx-buf-len configuration.
>>
>> It might be nicer to look it up in the queue, e.g. rxq->mp_params,
>> and make it a queue attribute instead of zcrx specific one. In either
>> case, no objections.
>>
> In io_pp_nl_fill() or in page_pool_nl_fill() as it was done in v1 for order?

I didn't see v1, so yeah, I was thinking along the same lines as
your previous version. Oh, well

-- 
Pavel Begunkov


