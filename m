Return-Path: <netdev+bounces-247353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 358B0CF829B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E5243054C25
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C16322C88;
	Tue,  6 Jan 2026 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brHkBekn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E8324B2D
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700386; cv=none; b=W3+iOm48ueH25FcFdlEDNuZ3Ke685XkNTAuBSpaceVvhFnHwPI5ovFZsQk9aFbKEKYVt0NDvbJKRfHzJ2Y+jDhnrfuz3U85R5CqcFEJtguY1BDGUlwHZGzVLHlaU5fijv/W2/HY6IoHtMNCQk8wPaOwJnTdrdNioJHuUHDkWKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700386; c=relaxed/simple;
	bh=u0O5nXv0qgE6JRn3E3YK1+6ZpteCwPYttz4HnYc0fhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYRVwHpyj+IA/bMEs6f8Ef6ndm6Fw4BvjJYXN2pyuEETKnwIZe/a8k6WJ9u6OHAmXJhjNwX+Ocs3QvYKcszhXLXtxQwDJ9cGFDZ9j2NOLYYD4LdSmCwWTzhaZFrWQWylXhCwKYS9Oh+qmDImg0LTjGshJLgs05Ir7fjr3XKF+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brHkBekn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so1386444a12.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767700382; x=1768305182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI5gPkr3nnlJ78tS77I+iKWLeaeIhuT+4KTSoONDQbY=;
        b=brHkBeknsEzm0pXV1o1LwjkzsasVl7JV5k9F15r8oIRWDPOYG98nPeP4+sjUDCvhb3
         3I0owqG0vjel0Cni+7n+Z++Ib+h3/s4dgX3K6TPpK+wuPibPGAiLPYcQXuqCpWX/CWTP
         q/FnkiCtXkG88fTmAMhxHdRvLvbBLb49YVqjxI/UIGHIyDfeMy3i8Nga5/rUYqOpsq4D
         cRR/Qza7ndyDCIHPq2OUuW+/Ndqb7G0mxJQFMuf6nx668dcQxQKWfznJ4nurly0MYwVL
         uOPdQ4lurUKBbrNKxmGG3TSMUl4Gk78TFJRuwnr7G7rVFNtIxVT0VvEuK+nMxpYkRloy
         +s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767700382; x=1768305182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CI5gPkr3nnlJ78tS77I+iKWLeaeIhuT+4KTSoONDQbY=;
        b=M7v8uV9uSEzHuUj2dMbe+Hus/fKzwotHO5clv3PDmFYw+lRx4l6zDfosMIxlePR0+2
         rK7GTRX+I/0nySV2gzG4qCEbNlVzWdWeykNqRSsVCIFCuHmzSBjeYb0nNFEYZEgulJFn
         0xUaCPOdufbRUcU0md1AiE73EIReNqHR5fFBuKIk6F4du7qIeZxHtbWwLy9BLL/YQ84N
         st0kGukWzvTwDPWDCsq6EPTWbelFkPR7g3uJhy0dI2sGu5QHo1/8hKPjaiqrCms/WXyB
         0Dm6H2UYjLNEMlMxZjg2I8mngenlZp/8+JqKa2OwqbZ9cxAH8N1hcH0pAlIA0lAo1GZd
         zxHQ==
X-Gm-Message-State: AOJu0YxXHKUX42fOf/raOJudFAhMR5jp/gdf1UE3ZEFIUaboXuOLljxF
	JS6+gMv1zeSWVxMl1fotOQIjyYpvoFLHNz6Xvsg4D9MBkjXkTxXk4BM0iDtYTiCen6FYc/zJ0Zz
	G+tWjZqxgKD5N0IKtFUsgtublUifWwOxXchE4
X-Gm-Gg: AY/fxX6aF+NGx3auMYqAMSHiRa6u1VVMtl5jfN2iTWh7HJJRyCXjAlzaNjTFS/42LB0
	PY63hAK5FkGPld7ZTLwEv8DXEXf1PzrF6FqOn2kS6TtPrJDYT6T/Jrc9B8rq48JXF9A3Rh7bMtu
	WBi3ysymAYcvnc+pKYlxXWw8kOQhvDjMw6gUiqZlWmoM3P9R+RrkQEoHvA42WStcaqfgtj29ZFD
	yuwtggqN4qlv3EOFMEyKcv8OxDDc0hNjwnF3s0WydrKH6Hnp8rmKJvC+ftGVRw4BReLmE+IgA==
X-Google-Smtp-Source: AGHT+IE3z8aG0QqWLHhU4mFkc1PyMoBvW7aZpmzMuYBM3c4hZOWsJ1o7kUsMCSdP6snS3qjyE6XSh0ZW7r9FkIiIi+g=
X-Received: by 2002:a05:6402:270c:b0:64b:7dd2:6bc2 with SMTP id
 4fb4d7f45d1cf-65079219a44mr2431974a12.7.1767700381563; Tue, 06 Jan 2026
 03:53:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105180712.46da1eb4@kernel.org>
In-Reply-To: <20260105180712.46da1eb4@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 6 Jan 2026 20:52:50 +0900
X-Gm-Features: AQt7F2qD31N1POu89k5a3HcelAQ_uaFuejzvzkRmoot9vBJuxxhfk-tLh9VX3uI
Message-ID: <CAMArcTWF12MQDVQw3dbJB==CMZ8Gd-4c-cu7PCV76EK3oVvFXw@mail.gmail.com>
Subject: Re: [TEST] amt.sh flaking
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the report!

> Hi Taehee!
>
> After migration to netdev foundation machines the amt.sh test has
> gotten a bit more flaky:
>
> https://netdev.bots.linux.dev/contest.html?test=3Damt-sh
>
> In fact it's the second most flaky test we have after txtimestamp.sh.
>
> All the failures are on non-debug kernels, and look like this:
>
> TAP version 13
> 1..1
> # timeout set to 3600
> # selftests: net: amt.sh
> # 0.26 [+0.26] TEST: amt discovery                                       =
          [ OK ]
> # 15.27 [+15.01] 2026/01/05 19:33:27 socat[4075] W exiting on signal 15
> # 15.28 [+0.01] TEST: IPv4 amt multicast forwarding                      =
           [FAIL]
> # 17.30 [+2.02] TEST: IPv6 amt multicast forwarding                      =
           [ OK ]
> # 17.30 [+0.00] TEST: IPv4 amt traffic forwarding torture               .=
.........  [ OK ]
> # 19.48 [+2.18] TEST: IPv6 amt traffic forwarding torture               .=
.........  [ OK ]
> # 26.71 [+7.22] Some tests failed.
> not ok 1 selftests: net: amt.sh # exit=3D1
>
> FWIW the new setup is based on Fedora 43 with:
>
> # cat /etc/systemd/network/99-default.link
> [Match]
> OriginalName=3D*
>
> [Link]
> NamePolicy=3Dkeep kernel database onboard slot path
> AlternativeNamesPolicy=3Ddatabase onboard slot path mac
> MACAddressPolicy=3Dnone

I will try to reproduce in my local machine then will try to fix this probl=
em.
Thanks a lot!

Taehee Yoo

