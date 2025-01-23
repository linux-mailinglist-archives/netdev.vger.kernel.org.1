Return-Path: <netdev+bounces-160555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95489A1A263
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617933A7659
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F020CCE3;
	Thu, 23 Jan 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRhRSpFl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BEE1C5F14
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630076; cv=none; b=Cnyz9H+WsGpsldRkITvr3v/bgZs+Nd8h4QtC1OztdXRtqo5nlvNcam7Tl5g5EOBOiJWon4ruUw3Gde+UDsiRLEJWT5LntlJzKSzQEKSp2cNNhCvAF1dxz+Ytv/0Ip+lgDohg7TeeU/LmtVRYZS5QzjAPSq5uhJRcpKHXSl1kTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630076; c=relaxed/simple;
	bh=KtDANyD9/osuMC7CVYxJnZRboxoCPbMAFvGu++rDke0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KE7zDYU0+2zLMXznitryzfpdfZp19UI2KYUjGC6pUr2UNFHZQoDB7hYk+lAYS4yHtp8hsh+LSkjTURKo94cI+tFM9nSP877LAcASedHS1CZLonK7rGGjN27AVf/f/vLqCNaoT8ty7U50aRbhhgPCpJ0bz1eBfKyxWzuGoLvzv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRhRSpFl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737630073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVFvlsMfxq0V5HAtv3hPGyTsmZRqbThPam/nCN6/K4w=;
	b=CRhRSpFlxKUMcmJVEF4vsqz27Nu891fY0p7hgEP1hDzuIsBpekmfmMYLI4ygRFCcjA7ZpI
	mUMUjipGn0+JLEcscHWRsMwm8+INz1wAmFTqLKmZO0ymBTj9DPqe/Xi600inh7Rx6JZ/b8
	uWmHb/4xf1chT8+T/PLKlEviFNJ9RMM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-jtQCi_cWPP-s8mOjSCQiiQ-1; Thu, 23 Jan 2025 06:01:11 -0500
X-MC-Unique: jtQCi_cWPP-s8mOjSCQiiQ-1
X-Mimecast-MFC-AGG-ID: jtQCi_cWPP-s8mOjSCQiiQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so3554815e9.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 03:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737630070; x=1738234870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVFvlsMfxq0V5HAtv3hPGyTsmZRqbThPam/nCN6/K4w=;
        b=Mbm6DXRrNctEI8zgVO+BZ0Wt38wlrhSzsT/2s+vyEY9eIv8oOIaJpLsYkQBpkOJTuP
         pzX8uBggbPxO5tNYQsJl3Ok070qZBGhdxVCkXJzIaOsVxZUp1zQsGN+yxloWrRQJi7Ys
         EOkBcW+C1VqsWkSe2DpbMCxCoJML0QNRF75rYVX0NMLLTQBHUH2jFNaHzfjbphhvBjJK
         LW5e8lKgwtJj0T/NZ2Hf5SbKFr1iZRFrKgMKszVhyy9YpbV8IgOY0DWbYuBwj6fkwNkI
         6lm4gXZZeADl900sGUoWn7qpI8mZ5PXzj1ukbn+zkke28ZWi+jRG9ykNNd+D038y+87R
         2erA==
X-Forwarded-Encrypted: i=1; AJvYcCU6IYye4PVoA41DgmXrw1x24wCEirYUqjc1JejAt4vU80+9F0EbFMqUyUgZL0PGd9twtqPWhrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsIDWblec6jlmuhyy45+6TT776MfSZV5IgKU8f3hOy93HSq3X
	l6IXMhZMbuiYUFAVAOcQOIs3xDx8/G9NAjRNJKDuxAcEJwKJez9vCjI2BxTrsbI0PTQUEY1rBHS
	hrIXR0kS9sQratja7DrpPo4Xer4VA4YzC1/GAOfDaNKB+AZUc1Q05mw==
X-Gm-Gg: ASbGncvVFpcKNmW1+oUDh9BaAkRgFfzYwYFZpldFu6yUJkyT1oJrHoF2iKUnXzH3aNo
	D7r8afKzroa710YXY3HgvswWUWZSGLtueTvzh7OZ4JlhiyUv+/v5OO3TuM8/hc4WlSMnaH4JKTu
	k6tt0xCl8IWnqZkYKley3mkUWhjZ1wFmUKg+5drhciUGM0H8mV8nqUg2g6POHN+jTr4PAg5l0x6
	1uaLTNVwJvc9QN5FvyaOK/qMxwztZuEjV026UQbwA68+NNwTsWWAkQ0PT5DXHqwtp9hJXEcUaWK
	5r1ZNmN3j5HZFq/fVXHYjKdc
X-Received: by 2002:a05:600c:46cb:b0:434:f1e9:afb3 with SMTP id 5b1f17b1804b1-438913bea88mr231678055e9.3.1737630070271;
        Thu, 23 Jan 2025 03:01:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH7kkjdPMy6i3wvH9FFcJt7PHEbVtyHIqQJmuEhTRAVmLZLikJtA2o50DHcchuyXLUbTM//A==
X-Received: by 2002:a05:600c:46cb:b0:434:f1e9:afb3 with SMTP id 5b1f17b1804b1-438913bea88mr231677635e9.3.1737630069837;
        Thu, 23 Jan 2025 03:01:09 -0800 (PST)
Received: from [192.168.88.253] (146-241-27-215.dyn.eolo.it. [146.241.27.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31afaf8sm58730635e9.21.2025.01.23.03.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 03:01:09 -0800 (PST)
Message-ID: <08c42b4a-6eed-4814-8bf8-fad40de6f2ed@redhat.com>
Date: Thu, 23 Jan 2025 12:01:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/12] net: homa: create shared Homa header
 files
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-4-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250115185937.1324-4-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/25 7:59 PM, John Ousterhout wrote:
[...]
> +/**
> + * union sockaddr_in_union - Holds either an IPv4 or IPv6 address (smaller
> + * and easier to use than sockaddr_storage).
> + */
> +union sockaddr_in_union {
> +	/** @sa: Used to access as a generic sockaddr. */
> +	struct sockaddr sa;
> +
> +	/** @in4: Used to access as IPv4 socket. */
> +	struct sockaddr_in in4;
> +
> +	/** @in6: Used to access as IPv6 socket.  */
> +	struct sockaddr_in6 in6;
> +};

There are other protocol using the same struct with a different name
(sctp) or  a very similar struct (mptcp). It would be nice to move this
in a shared header and allow re-use.

[...]
> +	/**
> +	 * @core: Core on which @thread was executing when it registered
> +	 * its interest.  Used for load balancing (see balance.txt).
> +	 */
> +	int core;

I don't see a 'balance.txt' file in this submission, possibly stray
reference?

[...]
> +	/**
> +	 * @pacer_wake_time: time (in sched_clock units) when the pacer last
> +	 * woke up (if the pacer is running) or 0 if the pacer is sleeping.
> +	 */
> +	__u64 pacer_wake_time;

why do you use the '__' variant here? this is not uapi, you should use
the plain u64/u32 (more occurrences below).

[...]
> +	/**
> +	 * @prev_default_port: The most recent port number assigned from
> +	 * the range of default ports.
> +	 */
> +	__u16 prev_default_port __aligned(L1_CACHE_BYTES);

I think the idiomatic way to express the above is to use:

	u16 prev_default_port ____cacheline_aligned;

or

	u16 prev_default_port ____cacheline_aligned_in_smp;

more similar occourrences below.

/P


