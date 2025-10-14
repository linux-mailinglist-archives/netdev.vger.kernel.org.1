Return-Path: <netdev+bounces-229161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D46BD8B70
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16FA04E5CE4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF12ECD10;
	Tue, 14 Oct 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEVRacHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09F2EB878
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437159; cv=none; b=QnR3QQrbynsv4INVKcBnUGjQtd1/3RRDu8z6E9O7c5S/dXytV945EJXSgDnE7Oe32YVRpVrSCMNwgwTXegpdRZfSDgSpzTKBsPNlNq1oBjOGYZO0V4oH6NXYvmUq+ChWtBaUk77+632D/WsiD65vsPZl/lt216+Hd1IUFP5vrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437159; c=relaxed/simple;
	bh=XX+rZvIXhJtvIL7uOxz4xW1dsb6uuqCSyoLnZXBNsS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf45c0yb6A+hjqIv0dZEA5HxLIxRstr796Xv/iRPT3P51P8aHEARvT3N3S2EvruNmdsa1mlbYOJZ+PXKS7UOaNkxfsbgn1HL7DtN3mBDhW/l9YGfXmsNxlRgrSq11ueuC+ceqy31MBVFitB6XUO2CHvXuiBeJoVZa8J8S7dBHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEVRacHY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-84827ef386aso484586285a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760437157; x=1761041957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GhdPCYEOIPlUxhGKbw+Pmeq+R0XeZpDT4H4TE9DD8w=;
        b=YEVRacHYlyKqcZVQlt+WexZtwvOXk9UVLKgP64Ayn+4XASsRHsLO+WmxzMgxa2qbwb
         +Klo+CPTmMljRK0NC93SlWyo5I4DN2CKOt3jcNoKRC5ECZJTJArIWynlreEyj2O0aWPX
         p0hN2N8LMUamDTzii5ftX0BvrfmtK8DTOiGJduZvwkTtW3PohHRrKUoEmBsy5FZOGGlk
         DG0B5gYdfYNHcrmNwarcueAnlXBzroNzwe177n2SIWa8SkA7JGyh0N+XznpVRx7AMnrI
         a+5rbFzUlJqyuE6YgYQo8rTXcJ5icnTxVVZyGdePtHzc7bRYSdKtD7jzy520WkJB+hox
         iPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437157; x=1761041957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GhdPCYEOIPlUxhGKbw+Pmeq+R0XeZpDT4H4TE9DD8w=;
        b=JcNRh8n8fNDr8XLSZ9XSIDu5EuZwBhGtSV+qFLuELLqNcgfABZbIgYOORGFiEp62sL
         Ssxw7/ZaKVfb9z/eIjjVb06dL/FlhKV3Yxqghh67f8HdFcY6rPVU/iUuOlCPy/SDfhsZ
         uy8BfIe38aL8g38FQ7GrxIR4KBMqj7vSxhYEy2QMlxXUKlRDSrvepdAyENDwxmvReO7m
         dItVzAc104R94EyPWTyqU0+TqeeGPiFlNoy8Qngc9LPIJUgFgj2OUq4pzlptmxqDodRd
         C8UcSIN7X4F8K471B2Bs21kL72gkRGrtBRx/xIX2mh+8MKdpRYMNiey8Afz4QCRgQKpF
         H9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUqter9H0NJpoLGpSVqW3q/TYIC3LCPTYHlzsy8NqCUxPD+WmrLD/m4sZeAFehG1mnzBP/VB+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48ukZfJEuVW7ZXufP6Hy+2+L6aLUwJvd/PIjLj15E1dHKtTpp
	nq3CxgDdaHWzkXK36yLrToJT3pZ4jLhEwar5DKmzFC6t9MGReqxHmTPHud8IpZVe3Yne2JRKAjo
	33ImabfQc/F/tFQKwzQ50HcBtdO3SyWI=
X-Gm-Gg: ASbGncvAiNQ0bSZX/tfZqyOzUJWTpxcgT2laQrbAo2nSm1kiWVcVNvNM3AY7SQ6KDxl
	L0uzgmr400Xd2xtmdmW4AuNOIeihR8cspE+00SRC81UMTrwmHnaR5c74ohtJ8i4Ba+QNufm1hFg
	QtUiH8Ss9znE/6Z5ch0hOw9VvH0FXZ2levz5MnqiPZkgSBlMhebKd97LSKGq6Oc4Y0Lw0JfhojU
	GJz4uk6NKhFdMiPi0dLZSrMKEuvrDyFFOqKYwq2MIde6oW5fuuTTZFM49dmy4nOsFyo
X-Google-Smtp-Source: AGHT+IHkG+3MijbAqPzBuX6WT5qM1UH5wFEx4+o96mRJarvePfqJF8HiiyZhUvW6BxCxk3W2HxXrCx44GyONpuhGsYg=
X-Received: by 2002:a05:620a:1a82:b0:864:c4b9:da16 with SMTP id
 af79cd13be357-883570ce5e8mr3684480185a.73.1760437156675; Tue, 14 Oct 2025
 03:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
 <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com> <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
In-Reply-To: <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 14 Oct 2025 18:19:05 +0800
X-Gm-Features: AS18NWC6N5v2tw8omBV7hBy3g3GX8bmzsyDFnwNBZ4EEXltiuUXlhijttlnObnI
Message-ID: <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Eric Dumazet <edumazet@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >
> > >
> > > I think you are missing something to control how much memory  can be
> > > pushed on each TCP socket ?
> > >
> > > What is tcp_wmem on your phones ? What about tcp_mem ?
> > >
> > > Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat
> >
> > # cat /proc/sys/net/ipv4/tcp_wmem
> > 524288  1048576 6710886
>
> Ouch. That is insane tcp_wmem[0] .
>
> Please stick to 4096, or risk OOM of various sorts.
>
> >
> > # cat /proc/sys/net/ipv4/tcp_notsent_lowat
> > 4294967295
> >
> > Any thoughts on these settings?
>
> Please look at
> https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
>
> tcp_notsent_lowat - UNSIGNED INTEGER
> A TCP socket can control the amount of unsent bytes in its write queue,
> thanks to TCP_NOTSENT_LOWAT socket option. poll()/select()/epoll()
> reports POLLOUT events if the amount of unsent bytes is below a per
> socket value, and if the write queue is not full. sendmsg() will
> also not add new buffers if the limit is hit.
>
> This global variable controls the amount of unsent data for
> sockets not using TCP_NOTSENT_LOWAT. For these sockets, a change
> to the global variable has immediate effect.
>
>
> Setting this sysctl to 2MB can effectively reduce the amount of memory
> in TCP write queues by 66 %,
> or allow you to increase tcp_wmem[2] so that only flows needing big
> BDP can get it.

We obtained these settings from our hardware vendors.

It might be worth exploring these settings further, but I can=E2=80=99t qui=
te see
their connection to high-order allocations, since high-order allocations ar=
e
kernel macros.

#define SKB_FRAG_PAGE_ORDER     get_order(32768)
#define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
#define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE_MAX_SIZE)

Is there anything I=E2=80=99m missing?

Thanks
Barry

