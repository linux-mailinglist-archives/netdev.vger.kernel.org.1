Return-Path: <netdev+bounces-268337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G+IENaQuGkSgAEAu9opvQ
	(envelope-from <netdev+bounces-268337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:23:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 619F82A1E91
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82E7B3004629
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882283793CC;
	Mon, 16 Mar 2026 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CczJ7RB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FE370D55
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703377; cv=none; b=ts5lfmMf94gdWRsDzYnNe9qGoG8ksPV4t8xdC5v9r/p5fY463nQ3T3OfwjcFaVWfk6bsypP0zCaufRqW8VfxzXJ2oQYIa9MhUNPiY36Xd1mmszr4fRM9OmMUVELOJLD3yVqKA9tRl5sBO15CQgP7BANV4cgACWG/O4iHQyvrBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703377; c=relaxed/simple;
	bh=LAKl72ZmaO6iexowzgNQBKY1zqj80RT76u4H4EhUFWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkB0b/ZEmyDAeRq4E8HKiWCbRXr6sp3P2vPDD74rmFgMUUuH1PS4RREx2KUfIZ0XVmJRJXGTU42PMShCeJop0G+exX4+nJZ6yDhSw8O8D7VVW16s+qO3+IS2g4BeILENKPol38jtirpSeNjrX4aSjFNnyFHvNMQtLvST1LLXcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CczJ7RB7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48374014a77so54219375e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773703375; x=1774308175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0P6yT4kuIK+aAZf2vpQSGaWL6i0OapbU7Os6PrAW52I=;
        b=CczJ7RB7n4GrAR/cGCzPhtInyovLGg96XaFLUYPqlb7I8E08Li72Kx79mm5IUpuQAi
         fZC1EprbiAhDzYywJ8T/HVkWKyZn/8887viMAR7z2HnGoqtdLpDzATSZYWJPXJG1MqRG
         qPEZAgn7GGhr29n8yz1mnDSlHwfp6+vI62TMXG9SVb40unsxPzUpnYFa+oVJXq07jcSW
         DzkTmxhRapqTvAdLCEo+eZAIqB+SQTUXxirjd2J/ujjzSdGf3R3BpzGvsf07LhdlL4Mh
         2V+1g0R5bveXa/Qnx+U4wrikjgDjdD+L13u7E1vf2q8s3YsKW1Mu5W+RxLNo73cTGGG1
         2uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703375; x=1774308175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0P6yT4kuIK+aAZf2vpQSGaWL6i0OapbU7Os6PrAW52I=;
        b=sbJ61usJ6ATBFNJkJ3+CEeLz27UUUIO7b24QBzwvf79hyI+5W7sZH7iyK9v4WJxR2w
         IszjudLjh5Rv2RwSkRrP4QtF1MNJ4ko9eieAWqMhNOAJumxheZHwf6YYGw/GgCCYqldZ
         MCNdsivtRefbPIunrYDULYsy7612DraVo4KSnm3/ZVCXnk/jPCsrQo3+Fh3lqwWOog+p
         B1Du4iqaiqfNUYpz5HVt0YyW39whHuj82Ir+iFhB5Tky+l9szwgfXxAfGkq2Q4nnOTn6
         iNO0/DpeQ+iIvjWstLJbbPvVMzZG2Q5kgImmw2FZ9mC1lkMaxLi9LikSqu1h4/wqw+CB
         LqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU44DyJOWVvCvNp67l7Pjb2iX7WHIXlwb4dh8YDUcfD6qPqTE5M+6dP2YDU+gouTS1qwLyOXKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHDQWtR+ikn1Y5A8x537tZMS2FG90vlKr66cOTxuMFFJoNlFK
	RhVgqynz+0WXqDlR/tWldzhrJMSlTNRBgtsHxbkTNscZIvK0SsZm+jYxwwm8Cw==
X-Gm-Gg: ATEYQzzeYwwpL8eFSnKJocp5Qqtn16RFn479Z0nzCcJBzO2JhlzyUjqSN/F8ElrAX+w
	GMv40zpswpUpNfSan5IfZ3rQuo4FAROJYJwmk7E4fvuCPYy6F0gKDAaA9UrZHUwuMBomij1Bn44
	icHtEf8A5faT6RQceK433tM8moaw16xl7XGZnyCvmIK6tvVMD/t+blikirj3nxjstt9Z0b4kH1T
	q+d8fFp6P8sFmMXaXJqkBfwbm07QXN1nuCE4xnoMQcy5Np7wJ4eB27cfhWanfp/Hj1rQfikYEDR
	3XtclGjeLkzZ0QKIcE0tB1AczOZfWN7eHwUsckzozL2iJCP2SlDH4UMy4L3EwKQGTiEvj0RqlKT
	1OEK8//tNnOt6Rm5aLd2YjxKlKZ2qqQfIbCmfyT9QXgQR3Hv8qSr7KFf2SzY+mHF6+myBV6D5zS
	lh1hbFd+Dyf5OtM8bKQFf6YJOxx4T6USmHL/7ziXiXdCt1xvHB+K6lOSU2nGcGd9P1SL2Mm+q0O
	TDe4FL6hGmQFzkpsfP/TjrHP1jDZxw56w0UW608YAg0/Ng6kKOBBRsFZEF8NPzAgkHJ4fDPsVS7
X-Received: by 2002:a05:600c:6289:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-485566cfa26mr239762865e9.2.1773703374478;
        Mon, 16 Mar 2026 16:22:54 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaa4fb0sm26849855e9.12.2026.03.16.16.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 16:22:53 -0700 (PDT)
Message-ID: <231361d3-dfaa-422d-a246-03f9a51b89f2@gmail.com>
Date: Mon, 16 Mar 2026 23:22:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: cast id to u64 before shifting in
 io_allocate_rbuf_ring()
To: Jens Axboe <axboe@kernel.dk>, Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260316150636.2123-1-mohd.abd.6602@gmail.com>
 <1f79957a-5b23-4bbd-af8d-9d1c86791645@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <1f79957a-5b23-4bbd-af8d-9d1c86791645@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 619F82A1E91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 19:37, Jens Axboe wrote:
> On 3/16/26 9:06 AM, Anas Iqbal wrote:
>> Smatch warns:
>> io_uring/zcrx.c:393 io_allocate_rbuf_ring() warn: should 'id << 16' be a 64 bit type?
>>
>> The expression 'id << IORING_OFF_PBUF_SHIFT' is evaluated using 32-bit
>> arithmetic because id is a u32. This may overflow before being promoted
>> to the 64-bit mmap_offset.
>>
>> Cast id to u64 before shifting to ensure the shift is performed in
>> 64-bit arithmetic.
> 
> I'd be impressed if 'id' could be large enough to cause this to
> overflow. AFAICT, you'd need more than 64K interface queues registered
> to hit this. So I think this should be reframed as a cleanup, to appease
> smatch.

Pretty much so. I'll queue up the patch targeting 7.1, thanks

-- 
Pavel Begunkov


