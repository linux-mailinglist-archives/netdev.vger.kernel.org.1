Return-Path: <netdev+bounces-150748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F09EB67B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59511889BE5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9CC1BD9E6;
	Tue, 10 Dec 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NWil/PWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BC19CD07
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848315; cv=none; b=QcxXGRKjjrpS8ee5pC2XfjnYo+TVdn2emGm1MzMI4tlJDWswf2Xcl9jyNeLcDjnqmDX8q1hrw79PR34WzESfewpON9B0TBEVasNKupT20dIIBvMjabwHPQm8iKV6HdEv+3cF+MfSmecXZQ6FZ6fBa482PkMBre0HOD7bW90OL4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848315; c=relaxed/simple;
	bh=MbymunpG4Tg6pwj907QfL1JaKGoGIQxLU+/wk+SrDeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKsbpxSvGZ0N40n1uz0NyG9kGS5150L7kZt63aeSrGkRwfJBouauFq6an5pk53m535xj1pcuueT9Q2eW0LNwkmk7nfzFaZ8JzUZHDzq+lWtbo2J/YmioM5QlcbXsiT6uzsqJbajA86PRPnIw1CFTbnAL2Xw0XqToC97745bgziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NWil/PWx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2156e078563so43563865ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733848312; x=1734453112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04+nKyOhNxhr9+R06CVsOzBWAakxrxBJNO0Kw1iHJJs=;
        b=NWil/PWxQkpW7PFLAU9N3wYioxSlhql6ilyHDBZEwbliMRdyqIkrIgt/m2zfoRW7wC
         nwkGYOlg2sy5SBxKQq1nPK6e6/K44LbdFkFBfHnxP63bVZRbnW3puuODlpkewQsrsZFv
         5YSibp8DG59cNAky5esXNEeoXbTJGB7TqHW4sjbx1jn/RcFurRIlxwOOtnIonmctmZaf
         bcANko6ENHfbeS5XcS7injU/b1pbwnEfZJQui5tbjlmow8cZzwXTupRu/s5R+xYnVc0F
         WyxRSWoAfGWxFPZwWoEibCjRFQs9fy3STolXJrK2HWRVfsI1EIOkW5QzRBTx57wRl6Iq
         ZBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848312; x=1734453112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04+nKyOhNxhr9+R06CVsOzBWAakxrxBJNO0Kw1iHJJs=;
        b=M0EQSEassfJHzr8JmXung/ZLQU3g+Ya5GN4A9MirivomMJ+3lAcF1CksKPn9FkeyBQ
         yFAyI4DUCQyWd5mCPzxp9UoWOlgSkLiMK9ItQwPVqObTCXxs7dW2MLCGluAfpSXV4rx1
         +7EHi5B0cncmWQ10ltJwgOi+bDI+9KUvO5GQ3LrYQN16Rs7knHH0ALE0GjQdfYxINQsh
         QxnQOF+daF2pt1C95v8E5zwcAh1Hf73XNpNbwsmaTVLivLsf02zqu/p1BMW5k+3hubM5
         jh1ym/wSfuGKy6UtXpIVknNlqE63KGNJlEwVWCmZ1jkIxkEG11ZRfNEFMTIvjrNdjNDE
         Zy7A==
X-Forwarded-Encrypted: i=1; AJvYcCXeCPrkAG/Jsy3lCUCZhMc9D5fbCfsLkpPGHnVBdLpuILHJ/oZj+D4kpx8JsHdZwO85PhryLhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+uBlI46tO5UVJpYjign9qBiLu1SylClgQcrCndg4jNjxPFHi
	VDD03+F/ysvKouk8TMjyEoQT8y7rCW9APVaMYBPPvwJiU4MDuils0LGcOgNQIKg=
X-Gm-Gg: ASbGncuw5H/smq1C/wNIdOAHeTzhWJ6l98i38rLs5iQAWEiORdMHeM7YXdS2wA+MSmB
	Yk646R958I8oXUxAe9jJLcVXYjDDYa1vATHvTl1qQ/sj3PSV1Vg4FRVLfWsUT4zwqvEcveYW3wF
	qu6f3Y0iNeloqi8kdgWPxAppOV1E77x+3Ax52ybnDi2EAc7ke5voHd6gw8brYvIq/XrVLk17Ijp
	GSJ+LH8OyjsB/bvW3nn9T4Pz563mybvgwQchVlDejnbNHR5OmAn+7azduTrFv1Z5Q9ET1VLMmB/
	SbsPQ5k2wz2+JVw=
X-Google-Smtp-Source: AGHT+IHktnFG7hLp9TTbz/Lwut4eNDgocWHIkFC0W2siRZDCevHYZg8zkBLCoMrKQPifFI3CWXISUA==
X-Received: by 2002:a17:902:e5cc:b0:216:539d:37c3 with SMTP id d9443c01a7336-216539d3a86mr132265095ad.24.1733848311930;
        Tue, 10 Dec 2024 08:31:51 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::6:fd3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2162d26718bsm58306815ad.213.2024.12.10.08.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 08:31:51 -0800 (PST)
Message-ID: <e76f0903-b85f-4a22-a5c6-b42c04b5fb95@davidwei.uk>
Date: Tue, 10 Dec 2024 08:31:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/17] net: page_pool: create hooks for custom
 page providers
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241204172204.4180482-1-dw@davidwei.uk>
 <20241204172204.4180482-4-dw@davidwei.uk>
 <20241209190230.2df85b79@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241209190230.2df85b79@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-09 19:02, Jakub Kicinski wrote:
> On Wed,  4 Dec 2024 09:21:42 -0800 David Wei wrote:
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index f89cf93f6eb4..36f61a1e4ffe 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -284,10 +284,11 @@ static int page_pool_init(struct page_pool *pool,
>>  		rxq = __netif_get_rx_queue(pool->slow.netdev,
>>  					   pool->slow.queue_idx);
>>  		pool->mp_priv = rxq->mp_params.mp_priv;
>> +		pool->mp_ops = rxq->mp_params.mp_ops;
>>  	}
>>  
>> -	if (pool->mp_priv) {
>> -		err = mp_dmabuf_devmem_init(pool);
>> +	if (pool->mp_ops) {
> 
> Can we throw in a:
> 
> 		if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops)))
> 			goto free_ptr_ring;
> 
> here, to avoid any abuse?

Sounds good, I'll add it.

> 
>> +		err = pool->mp_ops->init(pool);
>>  		if (err) {
>>  			pr_warn("%s() mem-provider init failed %d\n", __func__,
>>  				err);

