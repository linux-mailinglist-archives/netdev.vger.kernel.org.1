Return-Path: <netdev+bounces-118787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C7C952C71
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997961F22A8F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A91AC88B;
	Thu, 15 Aug 2024 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQTkgAPZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3771AC88E
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716225; cv=none; b=AwqJNA/8SHsyzn/4IA+2OVDPHzCIT7jFLEE+1FJA7oVMrZp1XeL9NxXdFs3xf9sMjDk3GsIUKjigewsTL6+dEY/yEPpi06mJQ3ShTK1VCrUaqTtjopCU/O3hOvCYxjugvRAZ7gmH/9dH5AfPTgcIkst4q55Qmm6+eyZwBGG9okI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716225; c=relaxed/simple;
	bh=Hq61VZl2PQwCd1Myuh7nn0sfHgbbJA5Yn6xA2+BPr8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPga+ZaRybr2gSSNq2SVvxrxfqCPjOUfnzVUFyy4COJFgJODEXDVOECcgdWFMKdod78FenJjB0HFwLO7rsZk4+TU6SLaPbmKeN1OKwZE9LRkJMev+3rTh62VX3V5+EtFtmeUe75lePvngY1KSFzPMPMci5XiHEEHFPv0rRvUJFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQTkgAPZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723716222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJUhFCoOWZPiwHxmmBDyfVRuaHTQLrPoUkJoZyMzMJo=;
	b=eQTkgAPZoIgZQGPhoi7DFZ9YgYypS8QbyQM7xLV2vKyRBZZvOsoWymf9BOS0Ispy2aNqxw
	BXV3Y2GB13b5lnjm9DXZxAa5LcCgt3bNSrzrf25X8qazyvjLQmm/pL3NxcFsAzN+D33iYi
	a8QxqRA1TLxq6ni4z+/3k9W4REBfAcg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-CBNV-jMgPbetXHMewbrAIg-1; Thu, 15 Aug 2024 06:03:41 -0400
X-MC-Unique: CBNV-jMgPbetXHMewbrAIg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef2f58ff63so912421fa.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716220; x=1724321020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJUhFCoOWZPiwHxmmBDyfVRuaHTQLrPoUkJoZyMzMJo=;
        b=EW71l2GhRZcYDdU8rCWBFwOliD63Pxq379xI9jdq7q55D3eTWHPGmYwrBcjltliJWr
         +ahBA62uiEDs8QJ8ZtlrBD1HTb9M5jAeISgn3byED6gqpiILHKQXh6Yju5lFHhiAjeUv
         t9+JvYQsRb9ddC7hRPWBO4WtUQIvu6xWtMcDe3qRIH5Ve8odg28LdGF0vctVChZy9BPI
         zNP23KaA8Mjfu/qopua3JlLXQvnCWmg2K8UBVVDC/NxyXjxcfoquHkClZOuKgHX+XMEU
         tDbQv/UzDFzGuC+KBNN9z24/Mu8oAz6TCS4oAEGYmBH5izGKsY/2teo64SILUzTVLmDc
         KKgQ==
X-Gm-Message-State: AOJu0YxjGkUVacW0kBNbZJr91TQQovqT9fe1xAxhbWyQad2wBxsmhRKn
	98uIDPXPR0+5ruU/xM/Jjq/agx6zUed8Ixglbyy7snB8LxaNQ4ALJjtMv+tEDA1G6WXzey0GRBf
	ncnVf0f/Xhr3fFa7LmfzjCV7/e7Qbzb/bqHLaphMVxqz+BaiJtmAgEw==
X-Received: by 2002:a2e:bc10:0:b0:2f0:1ea8:63a6 with SMTP id 38308e7fff4ca-2f3aa1f63a2mr20134751fa.8.1723716219681;
        Thu, 15 Aug 2024 03:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9XCWV8qb0cRquJAHOhV6xsa8CpbbAvrLEvCglEFmqADhP3Gppg+vUjxHnqpIiaBgrgjz78Q==
X-Received: by 2002:a2e:bc10:0:b0:2f0:1ea8:63a6 with SMTP id 38308e7fff4ca-2f3aa1f63a2mr20134491fa.8.1723716219047;
        Thu, 15 Aug 2024 03:03:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19670sm43940295e9.9.2024.08.15.03.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:03:38 -0700 (PDT)
Message-ID: <e6171479-28b4-4155-8578-37a14dabee50@redhat.com>
Date: Thu, 15 Aug 2024 12:03:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: do not release sk in sk_wait_event
To: sunyiqi <sunyiqixm@gmail.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815084907.167870-1-sunyiqixm@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815084907.167870-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/15/24 10:49, sunyiqi wrote:
> When investigating the kcm socket UAF which is also found by syzbot,
> I found that the root cause of this problem is actually in
> sk_wait_event.
> 
> In sk_wait_event, sk is released and relocked and called by
> sk_stream_wait_memory. Protocols like tcp, kcm, etc., called it in some
> ops function like *sendmsg which will lock the sk at the beginning.
> But sk_stream_wait_memory releases sk unexpectedly and destroy
> the thread safety. Finally it causes the kcm sk UAF.
> 
> If at the time when a thread(thread A) calls sk_stream_wait_memory
> and the other thread(thread B) is waiting for lock in lock_sock,
> thread B will successfully get the sk lock as thread A release sk lock
> in sk_wait_event.
> 
> The thread B may change the sk which is not thread A expecting.
> 
> As a result, it will lead kernel to the unexpected behavior. Just like
> the kcm sk UAF, which is actually cause by sk_wait_event in
> sk_stream_wait_memory.
> 
> Previous commit d9dc8b0f8b4e ("net: fix sleeping for sk_wait_event()")
> in 2016 seems do not solved this problem. Is it necessary to release
> sock in sk_wait_event? Or just delete it to make the protocol ops
> thread-secure.

As a I wrote previously, please describe the suspected race more 
clearly, with the exact calls sequence that lead to the UAF.

Releasing the socket lock is not enough to cause UAF.

Removing the release/lock pair in sk_wait_event() will break many 
protocols (e.g. TCP) as the stack will not be able to land packets in 
the receive queue while the socked lock is owned.

Cheers,

Paolo


