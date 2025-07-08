Return-Path: <netdev+bounces-204895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5FAFC6CF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511833A6992
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434662C08B2;
	Tue,  8 Jul 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Dkn5joZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EE228C99
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966020; cv=none; b=T0a+mMT2IVSMO2PK7vllnC+2BwzJGwLhnr6ciCS1x/O38CwaF22rAfdV2fXyLWPmM2ezyJTLMj91/uOH+0mJbC16Nroc6v3yaCLDcTAUUOm9an5kkn4D/bQSwuvQy+qxI4wmnOumKbe5DcaEYKCzxro/fWfXbTPrBVuiJGGxFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966020; c=relaxed/simple;
	bh=hoEEqO3Qklfq2nHsFjNKTKCPuQC6JoeMSNaq70kNm9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZcnD6Ylyv3q25gCuB40mGCvVy1X6bHz1ddkVqh34WOdJ0LcTqGQ2wwKx/v6LHuT6UQoGcKWk2zxRd+ypma1uA2SAFynpsiPmhGTUn48rav4HywhMfu/68l03Y2F8KJodMuwrn6R7IUQkIHcFv60D9wkd6nefURTlrW5KcyshevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Dkn5joZL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so6466391a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751966017; x=1752570817; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGBuLa4+/X9CGMXDy7CrS+ViwZNstaHE5BZc1yXonfw=;
        b=Dkn5joZLgHlkIxRgPdzonwi5zGRb70xZa+mfD6tIX8RR1B7c9+nCn8FRLzBJwGpZIN
         +vpcK6mxI/HAIZogr3rqp05hhYbISuInKOTYsgGw/rEdOJvzQo9pdzKJu03SLKVzaHCF
         MQu0NwgOSn4QJAkXMECO44PrQtgWp51ZKpXTYDCNEdDDls1++fyBZ0n80P/Mo4J4rXq0
         uPfXD9M0ZU4WBPC/p/JQ8afbwnXNMDObuOO35zkW5xyQYBIje6wcrJ65wPB+LXKtnbbm
         nHGAMCDvjnOi39x2DOESkxqAPndBuPjjzaw8fPjhvl9xatOXqurBjU/zwYyOwoMs6p88
         jPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751966017; x=1752570817;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGBuLa4+/X9CGMXDy7CrS+ViwZNstaHE5BZc1yXonfw=;
        b=hyhBH1LPGn81jV2jXdzOzMJXb4aInr/r48c5E9iVVOIdUAfxJn0P2hvKsBjsAw77FV
         X8GVR96FhIEhfc2TEMTNEYfan3bhc1Y03dij8zR5jAaUg+R06Q81FdObZ+9yTUh8XZ5+
         oxZ3YzHSJAk0PdjUYAfeFa723zKgIZcpcYP0PQgnRd1fkuiAtBzhIoB+ilzoDlZCbQ3t
         KS5KyMfw/ARRWKbjY5PwHijcnTlyUSypMYtB11mBUlBSj6q4KcEFUVs7rMCN6bImzSuW
         R7bmnxSz3So4C0LovP1Gae6gYAy8RIG00XGPdsbdh1lCXjH53wkd72sh8V6D9GRfbq17
         TMtA==
X-Gm-Message-State: AOJu0YzhGBPrs6EkWByIGsIvOc7tuESjgShc+PeYEB4GgN7ZjVZBLSJc
	ESGK9F7oEGoRnIURIMH5EenOfreIn55FcIwzV0tZL5s8wAQ9PnpT0cqWY5uAkymd8rM=
X-Gm-Gg: ASbGncsMr5vL67mabK7DJTVSXjElvHvDiuMwLRWx1/uob/PY0ObvJ8tVfiaysn/CUkK
	DGymUnE+8nxLdDiBeS7jHSx5RScZ7kypNvbHXlVOblay6gsRJh+spJ2WbeY9Os4AqLfTcE8llSp
	4tw79QFIxwEs2uUR/2gduNEMPANHdMdDgbyKExz0/6iPhycTN7BpjkNkewX3CCPmUIBCAzQr65m
	2CIICrNCf5YsFKJZeebXzp9v6MXznv8mGWSJIMwg5AQSaM5crygNGOr5hzK6N06I+4eh3t8V2Ni
	SLhW6/Ek7xm3HnXCLZiAptR1oJbYCrLgEUqnyGs9S96vX5f7xjIzEQ==
X-Google-Smtp-Source: AGHT+IHugGDAbekQCQaZL0jXTuohfu03MyWyMKhsjGlwdBexAz0WT/V5ETu3qZL5enns9DGC3utSwg==
X-Received: by 2002:a05:6402:4405:b0:5fb:c126:12c9 with SMTP id 4fb4d7f45d1cf-6104ae42e4amr1810786a12.25.1751966016521;
        Tue, 08 Jul 2025 02:13:36 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c892csm6920447a12.38.2025.07.08.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 02:13:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  "David S. Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Neal Cardwell <ncardwell@google.com>,  Kuniyuki
 Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Lee Valentine
 <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Consider every port when
 connecting with IP_LOCAL_PORT_RANGE
In-Reply-To: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
	(Jakub Sitnicki's message of "Thu, 3 Jul 2025 17:59:36 +0200")
References: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
Date: Tue, 08 Jul 2025 11:13:33 +0200
Message-ID: <878qkzgi4i.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 03, 2025 at 05:59 PM +02, Jakub Sitnicki wrote:
> Situation
> ---------
>
> We observe the following scenario in production:
>
>                                                   inet_bind_bucket
>                                                 state for port 54321
>                                                 --------------------
>
>                                                 (bucket doesn't exist)
>
> // Process A opens a long-lived connection:
> s1 = socket(AF_INET, SOCK_STREAM)
> s1.setsockopt(IP_BIND_ADDRESS_NO_PORT)
> s1.setsockopt(IP_LOCAL_PORT_RANGE, 54000..54500)
> s1.bind(192.0.2.10, 0)
> s1.connect(192.51.100.1, 443)
>                                                 tb->reuse = -1
>                                                 tb->reuseport = -1
> s1.getsockname() -> 192.0.2.10:54321
> s1.send()
> s1.recv()
> // ... s1 stays open.
>
> // Process B opens a short-lived connection:
> s2 = socket(AF_INET, SOCK_STREAM)
> s2.setsockopt(SO_REUSEADDR)
> s2.bind(192.0.2.20, 0)
>                                                 tb->reuse = 0
>                                                 tb->reuseport = 0
> s2.connect(192.51.100.2, 53)
> s2.getsockname() -> 192.0.2.20:54321
> s2.send()
> s2.recv()
> s2.close()
>
>                                                 // bucket remains in this
>                                                 // state even though port
>                                                 // was released by s2
>                                                 tb->reuse = 0
>                                                 tb->reuseport = 0
>
> // Process A attempts to open another connection
> // when there is connection pressure from
> // 192.0.2.30:54000..54500 to 192.51.100.1:443.
> // Assume only port 54321 is still available.
>
> s3 = socket(AF_INET, SOCK_STREAM)
> s3.setsockopt(IP_BIND_ADDRESS_NO_PORT)
> s3.setsockopt(IP_LOCAL_PORT_RANGE, 54000..54500)
> s3.bind(192.0.2.30, 0)
> s3.connect(192.51.100.1, 443) -> EADDRNOTAVAIL (99)
>
> Problem
> -------
>
> We end up in a state where Process A can't reuse ephemeral port 54321 for
> as long as there are sockets, like s1, that keep the bind bucket alive. The
> bucket does not return to "reusable" state even when all sockets which
> blocked it from reuse, like s2, are gone.
>
> The ephemeral port becomes available for use again only after all sockets
> bound to it are gone and the bind bucket is destroyed.
>
> Programs which behave like Process B in this scenario - that is, binding to
> an IP address without setting IP_BIND_ADDRESS_NO_PORT - might be considered
> poorly written. However, the reality is that such implementation is not
> actually uncommon. Trying to fix each and every such program is like
> playing whack-a-mole.
>
> For instance, it could be any software using Golang's net.Dialer with
> LocalAddr provided:
>
>         dialer := &net.Dialer{
>                 LocalAddr: &net.TCPAddr{IP: srcIP},
>         }
>         conn, err := dialer.Dial("tcp4", dialTarget)
>
> Or even a ubiquitous tool like dig when using a specific local address:
>
>         $ dig -b 127.1.1.1 +tcp +short example.com
>
> Hence, we are proposing a systematic fix in the network stack itself.
>
> Solution
> --------
>
> If there is no IP address conflict with any socket bound to a given local
> port, then from the protocol's perspective, the port can be safely shared.
>
> With that in mind, modify the port search during connect(), that is
> __inet_hash_connect, to consider all bind buckets (ports) when looking for
> a local port for egress.
>
> To achieve this, add an extra walk over bhash2 buckets for the port to
> check for IP conflicts. The additional walk is not free, so perform it only
> once per port - during the second phase of conflict checking, when the
> bhash bucket is locked.
>
> We enable this changed behavior only if the IP_LOCAL_PORT_RANGE socket
> option is set. The rationale is that users are likely to care about using
> every possible local port only when they have deliberately constrained the
> ephemeral port range.

I was wondering what the maintainers' outlook on this change is:

Does this sound acceptable?
Or should we start looking in a different direction?

Thanks,
-jkbs

[...]

