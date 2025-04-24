Return-Path: <netdev+bounces-185666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258AEA9B46F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FA71B81D11
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE2628A1CA;
	Thu, 24 Apr 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsvqyVCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2C1A23BE
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513238; cv=none; b=ZDBeGv3ylUt1XAyCgXrb+H3/N5cGXpJD5TzdoL2F1HewqRtlgNM0rQO/z+Xk7o4rsOHtNfDMefvIVfx3cKicCBov/aWCBgiTV05HV0heOfAwbIcy7O6UZT39cvMYdDQArYzTb3E80SYEml/2vtJP5ipqEN/ERw6xNs1M/bF2HEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513238; c=relaxed/simple;
	bh=0f8o8ggcrr8CNxbIrOe4CpkhYVZSBWqA5HmCOdwcb/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk34//8alVeLeGCF+NzRwwfP+edh+bpONJN2bIFHyksx7OQd4QX2qqkLCsft9H1ZUH9p4yGYuhFVKIaUGLoFxC+1VAC/ZS+aBcy4dfumrnh7T40T8JbcQAC9hFwYETVERsUSGkKt4vkKvOomD6J7xKU6Kd8PgPtN0a3cKh/KAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HsvqyVCK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47690a4ec97so14511051cf.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745513235; x=1746118035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrHAIXfmfIQ8jGFOWzV+7yMp1lmDdXbraFupzxGgZtc=;
        b=HsvqyVCK+aZ8xbXCnl+S9K+sROfMFodjQNeruhKFZ4uAvuezL+lav9MpKpHIgOEGhV
         WJGRUZgsv4JYAjAFI+LD+bb551OWRnVVZtsR+omuyk+s6PZ1xTe1BCEu+z61xZvqTRy5
         157bDzN80XFkvHZmms84mRKj1mDILQOVjRKTIs5WOgjOGFL+gyX4oCIFOB0W2cpczwrf
         CvDrcbufgliWaLz48tAZmseKx6VuYLRK9KDqH/6AzF+rXkJXFuGNkizocSp2gofRspRO
         ZU9vxMo/ASace20J0nDAxITea/DDxJig4zXNXsXb3ZiI6hTtGXW++WgK8nme9kTkdJlr
         cDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513235; x=1746118035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrHAIXfmfIQ8jGFOWzV+7yMp1lmDdXbraFupzxGgZtc=;
        b=wqYUbg69NjldN5riZKfZc2Z2mPk55nEVcq5TR6GJZ+W/9EB1f9pXjEhnPFnhDI7YiB
         li1rLPqYFunNp7egqAQmXzPRA2Q30BGH2gFytiv5R/u2/UyH4HCxGDYaDCvCy7sJwVlq
         ESAt06Wd/A77WhwuoVkZO7G1DmO9Ea3+ShQqnXy3OQg/MpC1kFvUB7/74150SUmA903c
         XY+KdDm8V5WHRMEiQlxxFV8t4jA5J7Hw8SdCtdNEO+l39md//87M4M9nAfHlOje0M1hI
         4jwhPwEGGAhKUrymQeMqaxfUbQFLGHijR8Ko9kmmZt+4AapCHqdY5NtfEd9xNNuxCxex
         a93w==
X-Gm-Message-State: AOJu0Yw1UfYfmK16cj1Q/1BofVkAldqwPptW756iq/x/wBdqpJj+0ZXZ
	ZJESkFdEzh9sGZrkukoTawcslP1BkX8ZjXATj6qG1dnbrOUo5nuf6ORoMuK+vm98mjV6r7lAdEE
	l5M5U3BQeLBa3uhXdmFrbcDkqlU/ZTGtQkHRaK1rNvQaZlCTGjA==
X-Gm-Gg: ASbGncuWmKPQLrDaQEO3HyD5oVCRVhLUHnWnf37RCSYsY3VTfLGNBpiR1WcmWRu9fBw
	JwDlJxIl8h1WeWdw36XEWTDrUEO0yMxpOvgd+srZu5QAbeUk5GATPDLdOKdwl+/asJMr22i3d24
	NIPPi34TK113+QUQj5gcoP8yUS9T0+JFdKn/nGNjmqbMlYu4keBAo=
X-Google-Smtp-Source: AGHT+IH4HoxZgNqSBX1HcSaFcO3nDfhb5BoNyiCS7uKICma3hFepFqyQkq6E4rUmKF2oBT4biGVh9Fjvak1CfwXYACU=
X-Received: by 2002:a05:622a:e:b0:476:6d30:8aed with SMTP id
 d75a77b69052e-47eb51bd076mr51610691cf.49.1745513234982; Thu, 24 Apr 2025
 09:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424143549.669426-1-willemdebruijn.kernel@gmail.com> <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250424143549.669426-2-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Apr 2025 09:47:03 -0700
X-Gm-Features: ATxdqUFLJ_1crxXMqmRz7R1ykowq3tFs3Flm3laMONpWcm_5UzBg5-vVZYAcLsc
Message-ID: <CANn89i+ve7zU1+BceKCH4Sp2ycMcRsO=_i7Vn1oo9PGFWUg1Mw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] ipv4: prefer multipath nexthop that
 matches source address
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, idosch@nvidia.com, 
	kuniyu@amazon.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 7:35=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> With multipath routes, try to ensure that packets leave on the device
> that is associated with the source address.
>
> Avoid the following tcpdump example:
>
>     veth0 Out IP 10.1.0.2.38640 > 10.2.0.3.8000: Flags [S]
>     veth1 Out IP 10.1.0.2.38648 > 10.2.0.3.8000: Flags [S]
>
> Which can happen easily with the most straightforward setup:
>
>     ip addr add 10.0.0.1/24 dev veth0
>     ip addr add 10.1.0.1/24 dev veth1
>
>     ip route add 10.2.0.3 nexthop via 10.0.0.2 dev veth0 \
>                           nexthop via 10.1.0.2 dev veth1
>
> This is apparently considered WAI, based on the comment in
> ip_route_output_key_hash_rcu:
>
>     * 2. Moreover, we are allowed to send packets with saddr
>     *    of another iface. --ANK
>
> It may be ok for some uses of multipath, but not all. For instance,
> when using two ISPs, a router may drop packets with unknown source.
>
> The behavior occurs because tcp_v4_connect makes three route
> lookups when establishing a connection:
>
> 1. ip_route_connect calls to select a source address, with saddr zero.
> 2. ip_route_connect calls again now that saddr and daddr are known.
> 3. ip_route_newports calls again after a source port is also chosen.
>
> With a route with multiple nexthops, each lookup may make a different
> choice depending on available entropy to fib_select_multipath. So it
> is possible for 1 to select the saddr from the first entry, but 3 to
> select the second entry. Leading to the above situation.
>
> Address this by preferring a match that matches the flowi4 saddr. This
> will make 2 and 3 make the same choice as 1. Continue to update the
> backup choice until a choice that matches saddr is found.
>
> Do this in fib_select_multipath itself, rather than passing an fl4_oif
> constraint, to avoid changing non-multipath route selection. Commit
> e6b45241c57a ("ipv4: reset flowi parameters on route connect") shows
> how that may cause regressions.
>
> Also read ipv4.sysctl_fib_multipath_use_neigh only once. No need to
> refresh in the loop.
>
> This does not happen in IPv6, which performs only one lookup.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

