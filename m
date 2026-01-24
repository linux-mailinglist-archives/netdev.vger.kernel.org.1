Return-Path: <netdev+bounces-253087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO+3COvzdGlH/QAAu9opvQ
	(envelope-from <netdev+bounces-253087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 17:31:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E077E209
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A64230087BA
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3622222C0;
	Sat, 24 Jan 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJlX1JsI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09D21B191
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769272296; cv=none; b=a1r0lw4+o+TG+XCxpUKKs7jefhO56Y+nIZnpo1gFo9Uv3iiLUDeuWh6FPZDZb/E/dyO2ndHZLcQenoEH6ezj1byCNtQfAShWdfwHAhJr1r/X4VKbigqGtaeum1SjzCUuvR6mqTd1YTaDU23OHm2bVjYTKCfXZ0tSJy1KbWWu9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769272296; c=relaxed/simple;
	bh=1eqMQIkORPHz+LKdyHWjs2l5QZ5Wq4LYksvp1ptRUNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXgT1pV7GTK4JVHJYC25in7xkzAcxKLmuOCCaxLyrWwbxbzS6vcod1ra/R5pvuUysVYsGzYoWB30f2Ge4vlY4PsrYOoWC4IPHpJYdDCMgjHk4nh9J0vEKz1LhxKcLDh8SX4QV4uvpRbESmMJ9P5Jx73e5jAH4jChfVIHuOHvJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJlX1JsI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801bc328easo36654365e9.3
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769272293; x=1769877093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SikO7ZOzq4nMwwsrNbdMlMZbqUgdAVK7GEFvFEDT/V0=;
        b=lJlX1JsIre7Sf/jogqmJkgqBXVSR9D7PcQR6BDL9RbtqZQshEmiWVMczHnjRA6Jqfk
         /p/lWYclxhFe3nVALCCryB9Cue+KIkPN3GlZna0s18SnoODcAUBB/Y7kga6r6yotnSdP
         iTmy5HAm7A0wXVejRUJoxtphW5I1uJLa9+698WLJv21WgCEVsW23kR/2O/9qNOx3LFlu
         pHRPX+/bNrsx66xcE5xxonBcm3KK3BIqKBjBvtm/hxgAi4mMyhr2s2PkbPmSTS2mtOgd
         WcBy8NEJNEZAylFKUneiov+bvm4e6k2bQqqmrXbJ++p6i1rtBeM2TgWt0OjJp99aLOsG
         WnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769272293; x=1769877093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SikO7ZOzq4nMwwsrNbdMlMZbqUgdAVK7GEFvFEDT/V0=;
        b=E6AR/5vR9p9aq+wx5k1b+xVDEtr/UizAL5DsBkt/Jg4vDu7x5D4z5d2m7eJj23+ASa
         DrcuHFmLUVVTrpLhhvTSLSHpnzahpdikN1J4ww3+2g4wsruHrSC+sGjAlovS51BjupF6
         NGzUX+RF6ULpmQTjdD7rBYXupOt+zE4xsLehe3HT2FyvbABsNgJxKaDwmv/O4fDDJ4a9
         yCalony6IVd0duirCjGb5mNR8qKHx2NU9L7dVlOWwin044F/S9FnZVkocUHA+s/zQfHW
         TszpZVF8o1QvcYjYpi49wCgyNGKANInOkNdEZ6ByP7d+6Xb5PV0C2va57RiMGK16OqO4
         DL0g==
X-Gm-Message-State: AOJu0YyfWAkPwkfyCcQs4rWHT3ttdeRr5XHEtRR2eicCPxlrbTYKx1gj
	9GyzFFN9N+C1ZnqswKuDf4ZCBvROMDE3qULgwYmw2uAXoN2B4jNB2eVB
X-Gm-Gg: AZuq6aL8U3Vz9nyVdBXGzwDd31qobhoAjESE4eyJG838Bi2FKo6tvaigGU1t+x18aB4
	PH2Sl9AdPHhoIx5sVtqNxslmXhCemfNFztjz/CeZ/bQzaT1GfNZsfyG5muuQIbZqjRgbWIgpI3v
	xibJ+zuI42HtPHYo6UGMgMyMm9O+SshkUiSUze+fIDogJLIlStqKdFbiYGB6x8mkngpJ/YPoeF2
	R/wsDtAHCu7Q+HnvZ4Uq0LVJLzDVCIcp2m7p9hN32yaUC1rDV54tsjXOIt77Blo6hbGsjpn1Dhb
	X7RcmR6PjM5UTdcgM+I86wprJvwPnQQRjksUiqoJ1140M/6D8luhahQis2SlaInnimWZy04/6ok
	VNg1FMkQtEu/DF5afX1IKK9jPh2DbZdJO/HNjJocaPt4flZmReUixd6WKas7oDA2yD/bHhN0Nn0
	3XA/n4YYJ2IinDUlFYcYYaDJ2LH2FMXGpO64o5Ot1fofdtgA882+DFR2Q129XnG3eNFLizKMnYe
	1ZgUmqZVKnRdld+yQ8lPTr70WEqZw6Kr8jP0GM0YHAGR4zEjpNzP5AcoZddLKzdzg==
X-Received: by 2002:a05:600c:5494:b0:480:1e9e:f9d with SMTP id 5b1f17b1804b1-4804c94810fmr106845805e9.8.1769272293250;
        Sat, 24 Jan 2026 08:31:33 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm305258775e9.2.2026.01.24.08.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 08:31:32 -0800 (PST)
Message-ID: <edc2351c-f8cc-4bfe-8cf0-691f13619c1d@gmail.com>
Date: Sat, 24 Jan 2026 16:31:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/zcrx: implement large rx buffer support
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <cover.1769249792.git.asml.silence@gmail.com>
 <a840a38936ddcaa4c03b81e66e571a38ca68694f.1769249792.git.asml.silence@gmail.com>
 <8ce09f91-0706-4883-9b7e-1855c8dd5c2a@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <8ce09f91-0706-4883-9b7e-1855c8dd5c2a@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253087-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 70E077E209
X-Rspamd-Action: no action

On 1/24/26 15:32, Jens Axboe wrote:
> On 1/24/26 3:36 AM, Pavel Begunkov wrote:
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index b99cf2c6670a..b5166c9118e5 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -15,6 +15,7 @@
>>   #include <net/netlink.h>
>>   #include <net/netdev_queues.h>
>>   #include <net/netdev_rx_queue.h>
>> +#include <net/netdev_queues.h>
>>   #include <net/tcp.h>
>>   #include <net/rps.h>
> 
> Duplicate header? Rest of the patch looks fine to me, I'll just kill it
> while applying.

Looks like it, probably slipped through during rebases

-- 
Pavel Begunkov


