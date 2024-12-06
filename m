Return-Path: <netdev+bounces-149764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6520D9E7508
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A665E1886DE0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132DF2066C5;
	Fri,  6 Dec 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLu6Vd95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812D1C3C1F
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500884; cv=none; b=ZpgF6ZL6+u13x2qXEDaeMArWSqt2o8ZuFOz1YynQdxI9dqqjWFBPl+Ymq+r94EOHvZ7dIZc+qJG7G9T+fNa4VQycZmCNUSGRE9nq79ZZrIj+n9IoZjbYwZQo07JAGKpmNfNZFiyBAgPxB5B9mEjm5oiTrdNdkue5nrqxduzwZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500884; c=relaxed/simple;
	bh=xdJtx4Q5eoHXzD6F5QhdwJk7ktA9bjO0uZRNGe15Nzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMjZ2dmkzfew7tAIkbHIl4NrKZS1zljZe0Qc837A9bRMdwR5lZkTmG63j1uqFEXJbM/xtgOvBa+uPYuFrAsS5OrlySt/B2GNcCu8yQ+p6q95Ps2SnRetJXo0ts6SUBoQKS6yMHAQLHwZDvt61mM/aDwS5anJ27N3GPZRz93Q8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SLu6Vd95; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so4106222a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733500880; x=1734105680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdJtx4Q5eoHXzD6F5QhdwJk7ktA9bjO0uZRNGe15Nzw=;
        b=SLu6Vd95BRIRwAEv8zIkD5fBlGZc92vgRl0TMbnPPPUw4yC5BH4M8+g4goXRi9wqr8
         xdz9RJjYTnCb3PWaA12AX5f3j/yPToYOsdjtlT0nZD+xLmEUEPzm8WfCh9opSTr6PbfX
         0TtPIHauRlRWyGDMVKnskQYp57CjW3Jt9bha+aa/SVvm9npOOaZj5PTnqbGa5JhypPU6
         76B5fuRTqiRXGQy1bt4k/grfoXN1Ib5VZazojStM0TR+iiPDO/a0YWnImYzcXMgNVqEC
         NANXiuc79/x/XSyUfLnUzS+8NHimyj5ql4L5a1BZRkdxV5CybE3ciGfuPgwhMu5XeQHc
         NDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733500880; x=1734105680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdJtx4Q5eoHXzD6F5QhdwJk7ktA9bjO0uZRNGe15Nzw=;
        b=oeyqZ1uwroYyH2MRQeNKIV+jL/alsQguyfU8o1ltiaMNzMdeBNzl4zJDsGLg3ox9I7
         9/wHxGTbvmFC1Az5AR69eD9KCzWYFAM63tHvRbDB7cxoPLE//jfDWBAQy/Y8QC1/wO4l
         wvOvmQQhutyj341gcmdy7fWLwn+braIMrnHyUyw6FFOd1sAkXWq6gLvzOuRiwu5PZRd0
         eHzCIjbkYcRDzd0v8ybn1PRvRLvfTja13a8YjaReqFjRM6l8GWxawG4ykYmHe+Gh01ta
         GQwoaHNx0lObmLMiiVQVwNgCuzAID5ZM/eVLhOr2LEaidR6vfTc+UE8Tujo9h2KyN+Tv
         YhfQ==
X-Gm-Message-State: AOJu0Yzao4HseyeQkkoDTdtz9MSmwQYQVyCRWKkW9uJ5ds2cT4cEN/Wn
	uo1cBgRW8lU1ziCujK4Rgt5+VxCQY+6rWqZJ8286aoLNaPqf4cYXeoFx5OxDWmY0gOHp0Tg5t3i
	5NyC2BJqtHk3jalgRqUCgdYPOeXTiZauIYRjd
X-Gm-Gg: ASbGncvxt74VcX3kU7ieCng1appZQGgfXWVqORJchNn46McrSwxJ1joKliSbMRMkdgp
	wsvSpeJ6FNgmtbMLQPUDaKLjNy5qcRAE=
X-Google-Smtp-Source: AGHT+IEsVCy9meIMbtiXN+bxL6sOIHvoa/bgQ0BHeZB1kgArmxA8u7pCPRQDEf2biY67kd6C2ft56uspiwaDzR59rC4=
X-Received: by 2002:a05:6402:27ce:b0:5d0:d06b:cdc4 with SMTP id
 4fb4d7f45d1cf-5d3bdccdb54mr3368984a12.15.1733500878630; Fri, 06 Dec 2024
 08:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
 <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
In-Reply-To: <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 17:01:07 +0100
Message-ID: <CANn89i+k11E9XeJZwvgZ7VO0yr1nWge8+U-ESw2GLYDq7-sdBw@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Fred Chen <fred.cc@alibaba-inc.com>, Cambda Zhu <cambda@linux.alibaba.com>, 
	Willem de Bruijn <willemb@google.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:57=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Dec 6, 2024 at 4:50=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > After the blamed commit below, udp_rehash() is supposed to be called
> > with both local and remote addresses set.
> >
> > Currently that is already the case for IPv6 sockets, but for IPv4 the
> > destination address is updated after rehashing.
> >
> > Address the issue moving the destination address and port initializatio=
n
> > before rehashing.
> >
> > Fixes: 1b29a730ef8b ("ipv6/udp: Add 4-tuple hash for connected socket")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> Nice catch, thanks !
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

BTW, it seems that udp_lib_rehash() does the udp_rehash4()
only if the hash2 has changed.

