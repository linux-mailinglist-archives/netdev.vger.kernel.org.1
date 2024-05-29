Return-Path: <netdev+bounces-98878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827498D2D82
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D08A2895A7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321516939C;
	Wed, 29 May 2024 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZoWmJ2f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5316936A
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965025; cv=none; b=IH1+gJpAEyvhZ9/3gYjF3rcr62W8e1Xnv1CJRSA1GSNDPmFzpNwR+FbRvZg6xPjK5MGvjvrUrl4qoytCj7FV5UswLe7i55TrziwGtaOw/MoGLP+EvBU83Oac0m4aTwVXbmc+YJfHRvroNiQreJZxtjTvZ9jHylN7VKYbeyp98Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965025; c=relaxed/simple;
	bh=qty0aOKAhNQG+IWLhTwyQIMvCbllWmpCH0YEJpuoWmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glcGtkUS3Bo3fzKOqyO/jgXUY9farHzatOK2D7FYlx/hbsE40+w1JWZeKqlA3kYNpj4kLIviQREmEjjtsOlqgbv/usxsXgLofVBllbVJxyQR3ES2sPQaCOu1XWp2KdFVqmAaq1JADfWSBFpeAXAfeARKoZcEtm2A1/JSszPXkJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZoWmJ2f; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a034697fbso509012a12.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716965022; x=1717569822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfu+1W/s3mFAiw093dLDm5CJwrx9DcOcPf2IYJRcwcw=;
        b=PZoWmJ2ftZme9timFMfHTyYIjZgY3b5fdxLzwv0PDSeBqCKM7oQFWnEjydaYfJS3dk
         YUdProD/OT0f3xl5XmD2vrZK0uJ7I5+63023ylMRQ4c0AUAdC/nBk85nqZC/8trqe06R
         tqPcmv9DE25P7hQnQxpuhriIZCwmfulszJP2cCQ5TDsL3KKvQUCjpTjaQ/mLu0PUxF4W
         Kj7z7Q37isV2xaSJljw/iQQBi5nW4qdqAAvBe5tV4ZmlgxL62s86MO5iuZlrrYTJtW8N
         Doqs8kesZ2g5AavktWD9kyyKu89Sq+D/QfX5ARo2iWUFHpip5bWYAOyyca1HmKyfkQT9
         ASqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716965022; x=1717569822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfu+1W/s3mFAiw093dLDm5CJwrx9DcOcPf2IYJRcwcw=;
        b=o5arxveMdEO628PtGM0yF2rO4GpnDepwR1/jasBcxS0tCl5h97z7b6GvlU3sQEyqvN
         6Izbyu7d3ixVycH50cInrqpkAPjkekx92F5yF4JW0ifmBtTiCDkdX6uGZYN5yIvqQV4r
         40mHrUl3zwZKNBo992hCtHxRGQ9HWU7nUmAc47EVjV/lgAjGIJjKfqFwz+KcEvvmnkMr
         TdPQxEy+kxJ1WFLtMocBVLFj4tYjk/UN1Ib3vpvNgvmbRR1mZNpi6kcM+sZoCfWCHFH8
         ZtlKpibE8B+4/k4ChonzsHvz7wQsXPKWVTLwbS7jXaVn3UklUvF7Bv4fF1MiKDBwERK7
         yu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+pBGVaweCLMGYsRq0OKobIyK7knLE1PneMLbuGq2Lnif/4IeGNPHqI2fTCktty5aXuUXRgtbCQtd6V0PIYSRgHM7H7Do/
X-Gm-Message-State: AOJu0Ywk2L7UOuVfGO4HOEXF1LTwXAuqUuHvZnISe/k7ke83+grjvmiE
	1riZYmfR5pikJ1RA2D07VE9Qg8hkerJpOOhWexMbImlztew+bG3TFhMRktKXmxgfDwC9zYi8p6j
	tzGOqb9Rcy/QZFl10Ovdhl6emgTM=
X-Google-Smtp-Source: AGHT+IHCQpqA3OR7PTPRUggUmbJVGvBoYTYWQYiq2erRJighcntVkoIu8SJgAsF9B84xznGMlLLjTnfCK7P6rK+UTBM=
X-Received: by 2002:a17:906:3f87:b0:a59:aa3a:e6b6 with SMTP id
 a640c23a62f3a-a62641ded24mr841597066b.18.1716965022119; Tue, 28 May 2024
 23:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com>
In-Reply-To: <20240528171320.1332292-1-yyd@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 May 2024 14:43:05 +0800
Message-ID: <CAL+tcoCR1Uh1fvVzf5pVyHTv+dHDK1zfbDTtuH_q1CMggUZqkA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
To: Kevin Yang <yyd@google.com>
Cc: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Kevin,

On Wed, May 29, 2024 at 1:13=E2=80=AFAM Kevin Yang <yyd@google.com> wrote:
>
> Adding a sysctl knob to allow user to specify a default
> rto_min at socket init time.

I wonder what the advantage of this new sysctl knob is since we have
had BPF or something like that to tweak the rto min already?

There are so many places/parameters of the TCP stack that can be
exposed to the user side and adjusted by new sysctls...

Thanks,
Jason

>
> After this patch series, the rto_min will has multiple sources:
> route option has the highest precedence, followed by the
> TCP_BPF_RTO_MIN socket option, followed by this new
> tcp_rto_min_us sysctl.
>
> Kevin Yang (2):
>   tcp: derive delack_max with tcp_rto_min helper
>   tcp: add sysctl_tcp_rto_min_us
>
>  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
>  include/net/netns/ipv4.h               |  1 +
>  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
>  net/ipv4/tcp.c                         |  3 ++-
>  net/ipv4/tcp_ipv4.c                    |  1 +
>  net/ipv4/tcp_output.c                  | 11 ++---------
>  6 files changed, 27 insertions(+), 10 deletions(-)
>
> --
> 2.45.1.288.g0e0cd299f1-goog
>
>

