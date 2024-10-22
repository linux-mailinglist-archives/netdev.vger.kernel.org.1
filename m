Return-Path: <netdev+bounces-137793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1F9A9D7B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D64B211C1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20508188CB5;
	Tue, 22 Oct 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LltE9fh+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7518859B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587220; cv=none; b=GwFQq5jPUl46rN6RfCXmzi1wJUUk+7BG9263jHgwPA6l4g+FfwGjkCXMa3kMCi7yw8dFXOQCBqw87ud0Fi5dXkDb4vas12oVA0z2v6HqZ/T+Whbzr7JDRLmuug2Ar83w4VyJ0XbvIWa2rAD9PNRnVnOqQx6aB5INx7PsqugGke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587220; c=relaxed/simple;
	bh=cKtXFYPVfhBJOy6EHknIwPU0b2HCujr8GrXpYY+I2kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2bZRlgD49Ms6La/ZeYkpxHZlbxBUq15/fDy9FNvjUf5WJjq4sBXpdS5V2HxxfgbDX1G8a4BICgXc5Z2AcJklFGC+m0tZzfoDAenEhKTMOopZpUdXznnLcLIVW2VeCZNAqMXfFsH0A4/Lm2Ezj3CB4b43zWK3T0QVKVEImoFjgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LltE9fh+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729587217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSwxcd394RFwa4Hfv38biRG3d2Xti1xiJnOygZU8iaI=;
	b=LltE9fh+ovl6Quro2JT0u7ecl7yZFX8ZeY/V2aO7nQIogll3gwfkC8sLAbRDSnZHPxgN/x
	VDKOv/JHM3NtZZokWT2ej0uK5eFf52WOuncTTyYDlOEMCjKltJnpuUBzW9D24v3t4H/6mu
	Fa+Cbb9o8NidLhBzK+ABJV7peIXL43M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-fvFiwK4AMMCfCMvninXiew-1; Tue, 22 Oct 2024 04:53:36 -0400
X-MC-Unique: fvFiwK4AMMCfCMvninXiew-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d67f4bf98so3211297f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 01:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729587215; x=1730192015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSwxcd394RFwa4Hfv38biRG3d2Xti1xiJnOygZU8iaI=;
        b=QkE1QGKG6Fz4QkCvwc/w/LTI7nsO9WkuQr22CUf6OjpRj+l/HrBc9eKuegqnASH6LB
         VrgxtoaJBEqEdOdIZSImgqTjKHM9nbUqpeN4i6pXWYbLbHYUQTm6QcJPya+KYT08k/K6
         3MLPpKwopO3Ek4EipyAk/5KYT5BFkvX3XKoxKtw8NQ8/2AccWINMkdcXczkPgDEVtLdg
         xq3BYS4aWJPo45yNMa/C5gce+8STIVaxFRjC7i7QhdzdQty+HLika+6JGOemnzrxeEOe
         21/C7+r0i/By6S/BD30t7qre/8LALWpPZfhxU9/5yPN9v4mLd9ufnFEoKc0bB1+/i9l0
         3Ocg==
X-Forwarded-Encrypted: i=1; AJvYcCU2bTOzVztyMLU/3uytl1EgukOB8MtAC0/tNquNxzuEUVFqA6SwjgCxUVquYeK58k7ig7+ry58=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0wXa7l6ia5JJz5Lkk/lRrVADcDgHi4OSJmeLIZUPxL33fTNK
	ItlCm3EDH4cBHT07Q7USVCXEZt07X3SEXmXxbg+5zcRSKSk8Cs8MFg2xtfSQS71mYuG6Vi1al26
	es06GY8paW+P1+by9UBkRX9+YM7hyunDmB+Xue72Jh/PrvQhqRNc5uQ==
X-Received: by 2002:a5d:45cd:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-37ea21de065mr10182749f8f.6.1729587214818;
        Tue, 22 Oct 2024 01:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpFYWJ+H8xIygZdpC++Yhhy91R5G3vLOyR0VBobgOhf0o3ovJvhIc/FdR1JA1y/U5eZ6oSjw==
X-Received: by 2002:a5d:45cd:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-37ea21de065mr10182724f8f.6.1729587214488;
        Tue, 22 Oct 2024 01:53:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b5asm6116473f8f.10.2024.10.22.01.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 01:53:34 -0700 (PDT)
Message-ID: <ec78e7dd-a0c4-45e3-afe6-604308f7240e@redhat.com>
Date: Tue, 22 Oct 2024 10:53:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 13/14] rtnetlink: Return int from
 rtnl_af_register().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 David Ahern <dsahern@kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
References: <20241016185357.83849-1-kuniyu@amazon.com>
 <20241016185357.83849-14-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016185357.83849-14-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 20:53, Kuniyuki Iwashima wrote:
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 445e6ffed75e..70b663aca209 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -686,11 +686,13 @@ static const struct rtnl_af_ops *rtnl_af_lookup(const int family)
>   *
>   * Returns 0 on success or a negative error code.
>   */
> -void rtnl_af_register(struct rtnl_af_ops *ops)
> +int rtnl_af_register(struct rtnl_af_ops *ops)
>  {
>  	rtnl_lock();
>  	list_add_tail_rcu(&ops->list, &rtnl_af_ops);
>  	rtnl_unlock();
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(rtnl_af_register);

kdoc complains about the missing description for the return value. You
need to replace 'Returns' with '@return'.

Not blocking, but please follow-up.

Thanks!

Paolo


