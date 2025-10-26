Return-Path: <netdev+bounces-232950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5EC0A24E
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 05:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF233A4708
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 04:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4F24A066;
	Sun, 26 Oct 2025 04:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DXkndTTu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F52472B5
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761451844; cv=none; b=W0+bhYN0678tHugPKrZ38vfmYjfmVS9lmcbHTz826H9RbNyP9RvUxJl+VdLQJZjawGC6AeP49qkRchRFCdgZtiwyF5DI5bTTJ7XqMsDcKzfI1aIjT3AiWUv+cromMe4uqO7Ct0OGI3NO30bDUfGYOVONuDnLoqcl68gDuZUYQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761451844; c=relaxed/simple;
	bh=AgpxVYwn1pQ3rBUhZpRPVe6/W1kVz/lD1kFCSCUd3Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ugj8cKsVQD0WrxLP6dGFTQzeHP2pydengoiKBRqPzAT73Huu/n9w7DrfHT/576vd8H4Lbcq/Pbc37ClV0KdVQfemAWJhF5sxjg75QxcqGjp6IHRIepGLoeoKHAOANq/jdsS7TNAJmXx/Sesdwrgld5gcrfa4KiOIbalAZGwjQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DXkndTTu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e074dso35097675ad.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 21:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761451842; x=1762056642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qgDvs7YmNxOVkc3/4Op0G6CwX5vejYhixYA4j+OPrU=;
        b=DXkndTTumd/oI0Y8b9YR79j3miKapPtc3nz7SAZDITrjXEIG4D3ot4Xhy1YlrSmihq
         sPAgrLn7PUUO6IFJFijfft8wc1jDr2T+wLFb6tnbM8wx742THZkj/B1uJ8+HfiX6pKuN
         70144PCBXdMmbgVNinntXLGbHOnPPQkPpJg71Q/6DYggOjaJDH0HHozV/+G4qn0qbEOF
         8aTYFouwnm6ak+imbTq8pC4DinWUsk8dLOgK+dZ9TNbRcUOPgsuOEsggpDgwKhPOrbIX
         xbKukgQYImFFSvCh9c2LE03fzJ91xYxpyA9Q2KSlGloEHAnetOX5fpKrlkdQFuCxJzeP
         /Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761451842; x=1762056642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qgDvs7YmNxOVkc3/4Op0G6CwX5vejYhixYA4j+OPrU=;
        b=BFyYY8oK/CXAYQFNcIAX8M0TxKeTfZwofF8BC7Db+1tw/MG0Ycy4DkPj2eo07NrK2K
         vYJMmhWYsjymBN08whdWnu8uedKZU8PHcvvqy/0FaF4Cfubsfi/t9f/+261ixqqmjEEM
         1ppTIsUJIkPTWl3fIhpQfJAodGCKOhYtuve17GPpWJwamatb379TcaDYlp/rzpddiYnP
         lVP8igZx9h5rGCQkJFTroevU0ML0ebodcvLZEmoqvyW0CFFS0HEyQ9qX0wQDmUrnvQtP
         YO9q+HDhFb8iPrhXmGOHT0cGk5UV+qv39atsE37TW98FBYCpTmvx7UOQMWXkKfn9cgW8
         V+2A==
X-Forwarded-Encrypted: i=1; AJvYcCUjGWZ+ktxs95FndltDw8W7pj9loa5WY2zTW44WMXHdv3GNrGWiVLi+AZ0ttFqttmFzn7g9qRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+g8VpZv7j+TDM8BAr1vKMveP7+DPIdlkReSmsV3/kPnRbkWGU
	9rPqjIz/ShLWnyJLUwQMBTeVb/EJzTvIdN52zykxF23NTgN0wTkzP2WfnSYBWGL6pXs=
X-Gm-Gg: ASbGncvcDKN9MJNTtADHRr7xJUNZPZ8gZmK7p0SVrbhOtPNtP7/s6fuwHdh5rLS6tn4
	RAwKRClu7QDWuZOM8JvPm/ljMHcSmmnsB8fuJHmzUd9QUykdiZR4Cgm9ti896Vl8gkDvgNIhPm7
	f+UNnBYdfW/NZ6MvEMO9bnjmTmRJUhbw4QbLJR5uYZ680aOxTRW3XnBcMBvJfIpk8+WMKjiby3T
	j1KLhKb+0wEoIQqo1e4blZ422pDWG5IY5RM4McV87DwyUYGzE9FlOUt6dE27Q9TaB1GhbD1khxm
	ARbq9sM3ZC77l2GA9SlrXIBo7iaZDsMgErA2cW+0BCYEyVvFL8gQh/f4Z3K0CJ9AQ4xq2hJCPeK
	BwVhgREgldMbO/CtGf3hbi5pD1bXGiKzhPXaKHxKpwqX8YuReA7YgnntSXXujKA68h6z/lpjwHT
	sRWn7kI6jFsnf28bwBbQvwFcjMwJJEBxc90mOVyid162ThVmBHpw==
X-Google-Smtp-Source: AGHT+IHT25KbYA8Cz1HCr276xOt3xPKUQTvV4NjXAGqAs5DDgHlwNumJfi/0NShjNtB8CFI5b8dCaA==
X-Received: by 2002:a17:903:32ca:b0:290:b92d:907 with SMTP id d9443c01a7336-290cb376121mr466851585ad.53.1761451842227;
        Sat, 25 Oct 2025 21:10:42 -0700 (PDT)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0a329sm38340405ad.36.2025.10.25.21.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 21:10:41 -0700 (PDT)
Message-ID: <74ce4fb9-3654-4a1d-9b8b-abee8aba9ca9@davidwei.uk>
Date: Sat, 25 Oct 2025 21:10:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] io_uring/zcrx: add refcount to struct io_zcrx_ifq
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
References: <20251025191504.3024224-1-dw@davidwei.uk>
 <20251025191504.3024224-3-dw@davidwei.uk>
 <0a9d9e34-a351-4168-bbdc-3ca3b6c3e17b@kernel.dk>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <0a9d9e34-a351-4168-bbdc-3ca3b6c3e17b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-25 16:37, Jens Axboe wrote:
> On 10/25/25 1:15 PM, David Wei wrote:
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index a816f5902091..22d759307c16 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -730,6 +731,8 @@ void io_shutdown_zcrx_ifqs(struct io_ring_ctx *ctx)
>>   	lockdep_assert_held(&ctx->uring_lock);
>>   
>>   	xa_for_each(&ctx->zcrx_ctxs, index, ifq) {
>> +		if (refcount_read(&ifq->refs) > 1)
>> +			continue;
> 
> This is a bit odd, it's not an idiomatic way to use reference counts.
> Why isn't this a refcount_dec_and_test()? Given that both the later grab
> when sharing is enabled and the shutdown here are under the ->uring_lock
> this may not matter, but it'd be a lot more obviously correct if it
> looked ala:
> 
> 		if (refcount_dec_and_test(&ifq->refs)) {
>    			io_zcrx_scrub(ifq);
>    			io_close_queue(ifq);
> 		}
> 
> instead?
> 

Yeah, good idea. Your comments prompted me to try to find a better
solution that gets rid of ifq->proxy. Turns out xarray has 3 bits per
entry that can be 'marked'. With this I can get a cleaner solution. Will
respin tomorrow.

