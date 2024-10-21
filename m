Return-Path: <netdev+bounces-137522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E327F9A6C0D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BFF28278D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC821F9416;
	Mon, 21 Oct 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icKeinpD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239C1F8921
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520733; cv=none; b=l57zrlcj4DK9+2AVeiQAKFSKNA/a9pqSMLoPqzzUdf+JF/qCrUQuEjsZmCXdOhFhM9GsBQfpIbf3MjRONY4wKGJ8xkB0+T6i1J7skuoTsmSl4dgk8TxxblVsrnWQuK/wKAYK02nUCGDNTb+e2zbCuTFAFGUArUkkM4mMxCjPpJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520733; c=relaxed/simple;
	bh=R/s/47Tbfl/hcm2r3rccflz2BRFJptCAE9haA5rT5ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQTAam7fmoiblCLBexoS8MptnVn6L1QEKetvsnbnjKI0p9uznXDNb4iiNA0hkfaDiXmmH+uQ0PxN90tPCvJdxpvv5t+BSULIDX+4+rDxpESpm+T8eHTIiWuFiik28lzyt+/vI4aSIcwxXKozflRToAGg+X/a+OskDuLW4JksQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icKeinpD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729520730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UpjokMgxgfuH8Y+WhuenQWYLVdfsv+6Ns4oxoFKG8hw=;
	b=icKeinpDN+1CP6uxTRdt6Nny5KX2dar1TLqOO+SyX8cFohWrBMK70ACggac6MjdpadD6jj
	QH+2oRXKjgp+DXSYhTib25YW9B9E5dMTjMQrhM8qxDxu798WLZQHjf2Ud/FtO5MsY45Mdo
	Ma4OkAPIwBor+m21WGnIL9n1V28pzN4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-6n3TYWCSPxW53Hk4MA5xow-1; Mon, 21 Oct 2024 10:25:29 -0400
X-MC-Unique: 6n3TYWCSPxW53Hk4MA5xow-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316300bb15so24107045e9.2
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 07:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520728; x=1730125528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpjokMgxgfuH8Y+WhuenQWYLVdfsv+6Ns4oxoFKG8hw=;
        b=BqMgsy/X4D20N7y4nZRODLU9yOoSzf6z0PHos+uZIgVs8yPL3ltMbNlhYzW1mBBnhn
         Cr0oBF/HmSoB1FUN/Q1UBZUfP1XpgGjB4fkvMAGbn5wNsVhTM8+fNXVa/wIAzNsJI4jL
         ncqyJMSkfA9ph69nPPbAUnEX0s8kJX4AVYtAl7aia1GXWFuWolmMV5LGL87wL/I1OezB
         +uvdnjseIaHwbhzJHL3wfG8f92hCExDAs6LxwVLJAD2Q81DevkTLZDF+SaitirQ3qLQo
         xY9kWLO/jc/ZLyvA1Pzsch2KYSnuspbahFspNAE+EYx3tOz55jIlxfQOgG2GaLA8bHNO
         4Zlw==
X-Forwarded-Encrypted: i=1; AJvYcCUbMxuuHd2402h9fDDREzBeSRdPUwDzmiunuuu1v7xeFcHWZ+BjT+DY//dIoSJlf07ipD/xd6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynPA6+nwdNySIdeu+urq0RwzzTi4Nryw4yctAUvl9tmXafAZiy
	hfA/Qc8w7M3LGAcGmWGxLx8JZn8pEmTj3jkeaBiH6xrL85QH+wZrFLOZ9CZek3wO8ORKOmZoKlv
	IXxutAwdrXzSJlrmam6UvS6rYSctaq5zNVfIQhWlpk8WPc4cAW5DUcg==
X-Received: by 2002:a05:600c:4341:b0:431:5ab3:d28d with SMTP id 5b1f17b1804b1-4317744af65mr18410015e9.9.1729520727918;
        Mon, 21 Oct 2024 07:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxCWnxcRvxHxsasl4Whn7dZBQ+y7vKC9ouq1kHrZJWF5+knmYUrf1NEelCsaMwv6QBvYYV8w==
X-Received: by 2002:a05:600c:4341:b0:431:5ab3:d28d with SMTP id 5b1f17b1804b1-4317744af65mr18409705e9.9.1729520727602;
        Mon, 21 Oct 2024 07:25:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc921sm58563245e9.46.2024.10.21.07.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:25:27 -0700 (PDT)
Message-ID: <cd9c2290-f874-49e6-bc99-5336a096cffb@redhat.com>
Date: Mon, 21 Oct 2024 16:25:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/15] net: add helper executing custom callback from
 napi
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-9-dw@davidwei.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016185252.3746190-9-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/16/24 20:52, David Wei wrote:
> @@ -6503,6 +6511,41 @@ void napi_busy_loop(unsigned int napi_id,
>  }
>  EXPORT_SYMBOL(napi_busy_loop);
>  
> +void napi_execute(unsigned napi_id,
> +		  void (*cb)(void *), void *cb_arg)
> +{
> +	struct napi_struct *napi;
> +	void *have_poll_lock = NULL;

Minor nit: please respect the reverse x-mas tree order.

> +
> +	guard(rcu)();

Since this will land into net core code, please use the explicit RCU
read lock/unlock:

https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/maintainer-netdev.rst#L387

> +	napi = napi_by_id(napi_id);
> +	if (!napi)
> +		return;
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();
> +
> +	for (;;) {
> +		local_bh_disable();
> +
> +		if (napi_state_start_busy_polling(napi, 0)) {
> +			have_poll_lock = netpoll_poll_lock(napi);
> +			cb(cb_arg);
> +			local_bh_enable();
> +			busy_poll_stop(napi, have_poll_lock, 0, 1);
> +			break;
> +		}
> +
> +		local_bh_enable();
> +		if (unlikely(need_resched()))
> +			break;
> +		cpu_relax();

Don't you need a 'loop_end' condition here?

Side notes not specifically related to this patch: I likely got lost in
previous revision, but it's unclear to me which is the merge plan here,
could you please (re-)word it?

Thanks!

Paolo


