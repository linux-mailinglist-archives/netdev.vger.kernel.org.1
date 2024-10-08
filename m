Return-Path: <netdev+bounces-133203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D69954A4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13BFB29569
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5961E0DEF;
	Tue,  8 Oct 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eAKYmwx0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938D224CC
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405664; cv=none; b=ZECAg/T6kn0dvPP+tMxQHZvyUOzu1psIoVy4zRRfW8QQ0phEJpKwO8bUTC1cpaQS1VjqlzrVqzgBY4LO4nu7ASMElDQnrdh5kVxJPWphcdtjb8AxIWCgw7aC8GqNUnq6a6PRjYJdmeizvBMXTArT8av3Q/Pfb2MtLf01PhbHl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405664; c=relaxed/simple;
	bh=eaqFyjnYVZJa7EpGLNisj7RyHPWPHmDHcPGLL7yBuV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCXhUE4r2ZkucDHxZstqQtTU+fTUT69hamYC07UztdEVHAe74Ly4pT8GIRFPwhSzu3uQyddAd3YgaRZbNVhs2tQqJZZ8W5NW2eCZN1InZUdbM47LqdyVx869z7Xt+ks46KhB9xeWcPdNzI1BMxvd2WYmVp5/MibNBuPsBDstMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=eAKYmwx0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e01eff831so1796919b3a.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728405662; x=1729010462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1ofpTVsMl+ci9JFO6gCYRXleePbqrosApKBXPk9t/U=;
        b=eAKYmwx0Pg6927P68SZp4YU50X3DsmcRZZKXuCiKftkQx9+Wz75pGFJyAEZlcRpGCO
         EsTGRZX9iREmAdUELWmMln5jywHsR5cyJ9fZyfej4isuQmfxFz23bbD1WqAmrL6Us/I/
         L+dqGNDQueUfobB5n+dXLUTncZTsTFfKXmQOIM5dfipiJXTnbhl0hoCDoKBQ3FQb5tXh
         xX+mm61Tg7Teq9kGDhpSdZfgycYc4yDJvzBNPvtrdWoeSDC63fB40tJayB9PHnhTfroS
         HcZ3UuEwWI6bnVQ1CG8+Gw2rkHknhQYJ5LL8l+Ok2FM6fMYtSLogsgEY6VAazUjmAgi3
         S/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405662; x=1729010462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1ofpTVsMl+ci9JFO6gCYRXleePbqrosApKBXPk9t/U=;
        b=Uu35dGRj7XIOoLc9HV9HZk1hCghIqR1ISR+pU+8/7H6SfBvqofiWv5lWfK8fmgwZSd
         Aa9EfzdsS+0hQJZ+fchGqtd5bx1HyULDSsT1zzOkobBleeYBMSfPECB9nusppSxRQ6Fh
         DIzU+wjkEi6GO4nrfxkvfIqApTSRp4XTw4QUab3j7UvLImF87hm989y05web94611SuY
         OgWE508cm4dOtQ01vRbnVlo0h3Z0goJ5oTV1uMfhax5f/qELJxb+90gTuq7yJ9/3cRsc
         8ocQfqmNeA6l0L+nKC8rftEsyVUvpp4bHWdTAgkxAbBv1TdOcQLm8P6dTkib015Pb/zU
         ETmA==
X-Forwarded-Encrypted: i=1; AJvYcCU5tmYyzPoql7ScKuZhJADG2wxxoG44hINDwqXdFbE3kR3xoB3e67ECbJNhsfbbm8pPEfp22P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbIwZ4jivHB+patv8qnGW9rJ+9Q0FMg93km41KMwWVx80Pazh
	/bQQYPXobkwf3M/4X0pAvFSOm6h22ynd8mZfHIeMogxaiyAFxVDULk8ypm72YIQ=
X-Google-Smtp-Source: AGHT+IF8oTsNsx/W6mDqxg3nwsTG4km+lDAb9QMGiXIoBrE6D2DlVMgMHrFShGa3V/8eoEvuwBxK3w==
X-Received: by 2002:a05:6a00:21d2:b0:71e:1e8:8b7c with SMTP id d2e1a72fcca58-71e01e88f11mr12566325b3a.15.1728405661701;
        Tue, 08 Oct 2024 09:41:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::7:762b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbccffsm6340250b3a.32.2024.10.08.09.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 09:41:01 -0700 (PDT)
Message-ID: <6b57fb43-1271-4487-9342-5f82c972b9c5@davidwei.uk>
Date: Tue, 8 Oct 2024 09:40:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/15] io_uring/zcrx: add copy fallback
Content-Language: en-GB
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-14-dw@davidwei.uk> <ZwVWrAeKsVj5gbXY@mini-arch>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZwVWrAeKsVj5gbXY@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-08 08:58, Stanislav Fomichev wrote:
> On 10/07, David Wei wrote:
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> There are scenarios in which the zerocopy path might get a normal
>> in-kernel buffer, it could be a mis-steered packet or simply the linear
>> part of an skb. Another use case is to allow the driver to allocate
>> kernel pages when it's out of zc buffers, which makes it more resilient
>> to spikes in load and allow the user to choose the balance between the
>> amount of memory provided and performance.
> 
> Tangential: should there be some clear way for the users to discover that
> (some counter of some entry on cq about copy fallback)?
> 
> Or the expectation is that somebody will run bpftrace to diagnose
> (supposedly) poor ZC performance when it falls back to copy?

Yeah there definitely needs to be a way to notify the user that copy
fallback happened. Right now I'm relying on bpftrace hooking into
io_zcrx_copy_chunk(). Doing it per cqe (which is emitted per frag) is
too much. I can think of two other options:

1. Send a final cqe at the end of a number of frag cqes with a count of
   the number of copies.
2. Register a secondary area just for handling copies.

Other suggestions are also very welcome.

