Return-Path: <netdev+bounces-203773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22CFAF725A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3E1528E36
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652362E5433;
	Thu,  3 Jul 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="enLfw1jg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D72F2E49A7
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542334; cv=none; b=iUChlG2TgO34GU50xq+lzL7D5PZzjSIam/RhMpuF7uRmJCIAc5PC9wEQhjWVJvCrrOcJzUAipqRgTYV9DvC4dvfEAT/sNVKm72+pwCM3GdSXLHzlK/Fufqh8EQm6UUb6whorDN6rL9TrHpVcCrN2D9rg0ftd/C2B94xu6ZaQfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542334; c=relaxed/simple;
	bh=t7Rw2RFmoV5p0XvR9cNzRijdgWOmQ/h3xPMKrPegB+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8NzqouAnFm7xsj0kD2K3Bg/G+o8gj8tHZtAlKoVZMlPCk4bve0/pioZ34OKegGrSDS/q7+CI0sroLLQGrvatAvb2HrKv3RIMyShxozA/MbZAFRNaObOMWoroeuCztE4ug4LOjnYC9XGHhW2UYwass8oz5NsSP3WtHQQ33SA5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=enLfw1jg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso9588890a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751542330; x=1752147130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXZnqCa0GQL8uQA7nEZMoZ/7kqCQBMLXqTrUarlA00A=;
        b=enLfw1jgOSJBB6fO8uI/NUWysFYBAoLAjNXl5qQh+KVYf/dr7bLpbGd0CbWVbA7rEf
         nenUkkbEUUDf83g3ZDpzz+dg7uPH4Kx0J/A8pyFBMvcxf3LseNrBNBv9GMS4RkKtss8y
         xFa1DcnngnBbAMhWx7Gdscs4YU/kIv5CQIKNVqStAVsfwLIt9ybsDe8sBrajZOb53j4w
         tjjKzSnRU9U8PBaI1ZDziXHxJPuvvjwYGlLltlaw8na0NOQwk33B9A/+ORxUKczfa3Zq
         dThJu+L+np+70RsC5ty3kFYLUBs5yN8m8odHe7yEpYWQy+7hmQuvYsY4L66WTHVfhhAO
         tyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751542330; x=1752147130;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXZnqCa0GQL8uQA7nEZMoZ/7kqCQBMLXqTrUarlA00A=;
        b=WL/7IwSkaUbatZYujTv1VXE0ny3d/1KTZoNLp2TcvAySoxbdi7LkGKTJLWscB+GGQS
         Sgj77sdl8OjKmqa2m8Y0WymDrLv6EfzAZO+OYXDk1too3cmWZp6WNYwlenncampw0+jp
         +vfOoNzLNmiUlu3+CxneTK/+asIDuqyTxXT4tMdxAMom44vswxu2yJcMGNH+z6HbSkIv
         YHkaEcGjA16H6XzwtywBpn+HnkH3JE4yHuYBVYKEV9G0QqxPZj2YP7AK1n3gbdL65Hog
         g06thQV+Qdq5jv9g8/vOgP0sGbTJguXNSu8SNpbkHntn69EXsq1l5NW0kcrwQk1q6R2f
         1H2g==
X-Forwarded-Encrypted: i=1; AJvYcCW0sELYCj0IlcDWQz8Gj1+tFkREiuRcXhf9dLLmjolrZyVMGEcy9q54SST3dsclP2L//6ScAXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqzlU0BlLUZetxsizAebvkdpylte0x0er/bsKoSR4apLkK47F8
	j6RYctrhznZvfCLxnXEhPeofjcXNNPvH50a33Yz/HbY7t6tewKkjJzSiNmp7OA829uo=
X-Gm-Gg: ASbGnct1wP11v7sajGEKdzyaZ62AKgrS0paOB2nBLHyxp9ZFQAIQNZbEBR6ub6MGrCo
	hGBgdR3pM5rGxwYqQLJ1q7U0/iMKtXy2scV+pkWmAKoitZi6xYRFqhZS8cXe+xTyNYepoRGiCfw
	B8Pp8AR3+JPoLbGmk/zAlCpkvmZ/VVYu+mFcaA7cwcSCA064h5PfdhfGjfs27I0QRye6fvQvwCQ
	9QAjbaJnFLS0BDN4szUrrBS7wY9UDQ+mzgUodaMZcJFWpUriEstXB6Ykr+nxyqX/qLu2saXr6k4
	FMXYyHSm8uWSvm+4lZI9ZjqPBH4Ixn1tONd4mJf8i8Uxg6ktkP/kRBk=
X-Google-Smtp-Source: AGHT+IG/30qzCkmB/dakJpdO+CkEBFRX2NB7Ny4KqfhIDtujGNiL6196Rp1R2ZZmiDcj3wDcKkRUWQ==
X-Received: by 2002:a17:906:c141:b0:add:fe17:e970 with SMTP id a640c23a62f3a-ae3c2b854f7mr632069266b.14.1751542330402;
        Thu, 03 Jul 2025 04:32:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:c2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a0fasm1245712166b.63.2025.07.03.04.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:32:09 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,  netdev@vger.kernel.org,
  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zhoufeng.zf@bytedance.com,  Amery Hung <amery.hung@bytedance.com>,  Cong
 Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v4 4/4] tcp_bpf: improve ingress redirection
 performance with message corking
In-Reply-To: <509939c4-2e3e-41a6-888f-cbbf6d4c93cb@bytedance.com> (Zijian
	Zhang's message of "Thu, 3 Jul 2025 10:17:09 +0800")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
	<20250701011201.235392-5-xiyou.wangcong@gmail.com>
	<87ecuyn5x2.fsf@cloudflare.com>
	<509939c4-2e3e-41a6-888f-cbbf6d4c93cb@bytedance.com>
Date: Thu, 03 Jul 2025 13:32:08 +0200
Message-ID: <87a55lmrwn.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 10:17 AM +08, Zijian Zhang wrote:
> On 7/2/25 8:17 PM, Jakub Sitnicki wrote:
>> On Mon, Jun 30, 2025 at 06:12 PM -07, Cong Wang wrote:
>>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>>
>>> The TCP_BPF ingress redirection path currently lacks the message corking
>>> mechanism found in standard TCP. This causes the sender to wake up the
>>> receiver for every message, even when messages are small, resulting in
>>> reduced throughput compared to regular TCP in certain scenarios.
>> I'm curious what scenarios are you referring to? Is it send-to-local or
>> ingress-to-local? [1]
>>=20
>
> Thanks for your attention and detailed reviewing!
> We are referring to "send-to-local" here.
>
>> If the sender is emitting small messages, that's probably intended -
>> that is they likely want to get the message across as soon as possible,
>> because They must have disabled the Nagle algo (set TCP_NODELAY) to do
>> that.
>> Otherwise, you get small segment merging on the sender side by default.
>> And if MTU is a limiting factor, you should also be getting batching
>> from GRO.
>> What I'm getting at is that I don't quite follow why you don't see
>> sufficient batching before the sockmap redirect today?
>>=20
>
> IMHO,
>
> In =E2=80=9Csend-to-local=E2=80=9D case, both sender and receiver sockets=
 are added to
> the sockmap. Their protocol is modified from TCP to eBPF_TCP, so that
> sendmsg will invoke =E2=80=9Ctcp_bpf_sendmsg=E2=80=9D instead of =E2=80=
=9Ctcp_sendmsg=E2=80=9D. In this
> case, the whole process is building a skmsg and moving it to the
> receiver socket=E2=80=99s queue immediately. In this process, there is no
> sk_buff generated, and we cannot benefit from TCP stack optimizations.
> As a result, small segments will not be merged by default, that's the
> reason why I am implementing skmsg coalescing here.
>
>>> This change introduces a kernel worker-based intermediate layer to prov=
ide
>>> automatic message corking for TCP_BPF. While this adds a slight latency
>>> overhead, it significantly improves overall throughput by reducing
>>> unnecessary wake-ups and reducing the sock lock contention.
>> "Slight" for a +5% increase in latency is an understatement :-)
>> IDK about this being always on for every socket. For send-to-local
>> [1], sk_msg redirs can be viewed as a form of IPC, where latency
>> matters.
>> I do understand that you're trying to optimize for bulk-transfer
>> workloads, but please consider also request-response workloads.
>> [1]
>> https://github.com/jsitnicki/kubecon-2024-sockmap/blob/main/cheatsheet-s=
ockmap-redirect.png
>>=20
>
> Totally understand that request-response workloads are also very
> important.
>
> Here are my thoughts:
>
> I had an idea before: when the user sets NO_DELAY, we could follow the
> original code path. However, I'm concerned about a specific scenario: if
> a user sends part of a message and then sets NO_DELAY to send another
> message, it's possible that messages sent via kworker haven't yet
> reached the ingress_msg (maybe due to delayed kworker scheduling), while
> the messages sent with NO_DELAY have already arrived. This could disrupt
> the order. Since there's no TCP packet formation or retransmission
> mechanism in this process, once the order is disrupted, it stays that
> way.
>
> As a result, I propose,
>
> - When the user sets NO_DELAY, introduce a wait (I haven't determined
> the exact location yet; maybe in tcp_bpf_sendmsg) to ensure all messages
> from kworker are sent before proceeding. Then follow the original path
> for packet transmission.
>
> - When the user switches back from NO_DELAY to DELAY, it's less of an iss=
ue. We
>  can simply follow our current code path.
>
> If 5% degradation is not a blocker for this patchset, and the solution
> looks good to you, we will do it in the next patchset.

I'm all for reaping the benefits of batching, but I'm not thrilled about
having a backlog worker on the path. The one we have on the sk_skb path
has been a bottleneck:

1) There's no backpressure propagation so you can have a backlog
build-up. One thing to check is what happens if the receiver closes its
window.

2) There's a scheduling latency. That's why the performance of splicing
sockets with sockmap (ingress-to-egress) looks bleak [1].

So I have to dig deeper...

Have you considered and/or evaluated any alternative designs? For
instance, what stops us from having an auto-corking / coalescing
strategy on the sender side?

[1] https://blog.cloudflare.com/sockmap-tcp-splicing-of-the-future/

