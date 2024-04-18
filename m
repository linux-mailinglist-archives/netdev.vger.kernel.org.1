Return-Path: <netdev+bounces-89355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14A8AA1E0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B511F21C1C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97A178CF2;
	Thu, 18 Apr 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2eUgFCR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B251779A4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464104; cv=none; b=QE7yjhR6U5dpGRwD1aDvQlB7z2MbRJmT+DtkkWCDBzAf3QZat/RqhgguUWGt5im2tHx+fNkf8w6zUFxkaTLSr377nSfKuBLxbvx+EJPJZ/Y8wVIYUJBn3El3R50KaAShM4dh4M5NvWyD75kRnU83EXvp6sgNMJpjS25fOjC8+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464104; c=relaxed/simple;
	bh=sHnc9Ty9ZBylFTgS4GO/bXBPHyGMDl0qNemyvH9HmS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjfY88vvrPlBII8Zye0BLsUcxdP+WEhQprZEpPkQS5WKzfHuDG0jH+eoDjSZlxtnDjuPY/wAaHJPZ9tiFhgIRnmji2U76nfjBRm3xkL9VfjovbsPFl5gGBLxYglKAdZrPZg7ejUd2GLBYhE6uN+C4kJ+b6hv3MdpQu8Zqngiq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2eUgFCR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so1526a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713464101; x=1714068901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+0H5bEeW9H+5dSIHmxgeadOXEGR0iMit7ezUlU/hIc=;
        b=Q2eUgFCR9TQP2Uf6rXKO2I84tVMoCPz3r/2yuCcukY49MaR9EM33f7rnBN29j+nU3x
         FdHKPHr6XjEEwZnRtS2uHke8piUGhYnzsHN7+3kL1dk6mrGkZz0toopiQCY2mter8+pE
         X1+pLFWALrh2Q47krHXkyCGXnRuxorhytR1pS6R9v9egMMY+oEMEhNuatfbkqptGFDWE
         PWFP3593IX3vCneNgcKaleFm6gwpKcb2XNP/LYMn80Dog/QnSndhaXUNlBj6Tbpg/xj8
         h7lXQN10/Xm7yGyY6i7oVXeIB2ZryHT8NTBChekTQbfjqtaDPiopovIXC9sjaVnRzpz9
         iy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464101; x=1714068901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+0H5bEeW9H+5dSIHmxgeadOXEGR0iMit7ezUlU/hIc=;
        b=EkRW5RZv5f7Mo83XwquTq5ryIr7lQY2vMwU0TTu/LUT/zE/xtBx/rq7bu6TFNtgOSU
         f+M23oCdHnL0Gqn2EEfq0vhq3b0Z46Ix60EmRoTeXZtZj0Jdag6h2Xwm/5sXto2WdsSX
         WWI1dQ7WEKSQdfw7UGpAPlIIcBhDoRs6aC26qvbG2mzuPM6G9QxGwf7IzbMB9/otWcmb
         TQrgqF/zoCb8JgCNdQNBDYy+mPRmW/UbzRqtsaT97YBCXmVpFLAU81QH60oOwO+LBhfc
         UR0A7xpMS0sAHMcyMRU0FovUwQtU0NAnX12ImaibJs+07lLuq+FN0CeHnD6yYCHMQbK8
         IE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX608p0J/tfcsQukwXMHYrpaXyBp7r4iBp+udoVUh+S1/WtAEXYZPGmFA2TSkGIijeyZg+O61Kaj26XPuTN5lnyUAJCKsGf
X-Gm-Message-State: AOJu0YzXasUSUJ0IS8CLN8SgS9Wkak+PPPJssAakHcNU2LrAa+e+bekU
	eEriGYOln0OJaf352wXiKtCri53NnefHoaHn4dF04BFeFhxLPUZOUGxvztyhvyMLolK7Iycu4CP
	WRvbKsTc6fg1Cg9hmMqReG4euyzDHfwUwJiINhWExisV0CVaAvGux
X-Google-Smtp-Source: AGHT+IHlfGNwL8CYy7fs2hSytH0UQPCuldP85+cg36K2Qz1llLTftnASo/ci/iLyxzd1uRIJyGuqN5FxSjKkVeY5z5s=
X-Received: by 2002:aa7:c511:0:b0:570:49e3:60a8 with SMTP id
 o17-20020aa7c511000000b0057049e360a8mr6667edq.7.1713464101086; Thu, 18 Apr
 2024 11:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com> <20240417165756.2531620-2-edumazet@google.com>
 <e332d0b8fa7b116003dfd8b47f021901e66b36b9.camel@redhat.com>
 <CANn89i+-cjHze1yiFZKr-cCGG7Fh4gb9NZnS1u4u_77bG2Mf6Q@mail.gmail.com>
 <CANn89iLSZFOYfZUSK57LLe8yw4wNt8vHt=aD79a1MbZBhfeRbw@mail.gmail.com>
 <7d1aa7d5a134ad4f4bca215ec6a075190cea03f2.camel@redhat.com>
 <CANn89iJg7AcxMLbvwnghN85L6ASuoKsSSSHdgaQzBU48G1TRiw@mail.gmail.com>
 <274d458e-36c8-4742-9923-6944d3ef44b5@kernel.org> <CANn89iJOLPH72pkqLWm-E4dPKL4yWxTfyJhord0r_cPcRm9WiQ@mail.gmail.com>
 <20240418110909.091b0550@kernel.org>
In-Reply-To: <20240418110909.091b0550@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 20:14:50 +0200
Message-ID: <CANn89i+b-Unz959gZzBgn_7Zk7nyGRVgxP2+smaWeYK4_o0mjw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 18 Apr 2024 19:47:51 +0200 Eric Dumazet wrote:
> > > You have a kernel patch that makes a test fail, and your solution is
> > > changing userspace? The tests are examples of userspace applications =
and
> > > how they can use APIs, so if the patch breaks a test it is by definit=
ion
> > > breaking userspace which is not allowed.
>
> Tests are often overly sensitive to kernel behavior, while this is
> obviously a red flag it's not an automatic nack. The more tests we
> have the more often we'll catch tiny changes. A lot of tests started
> flaking with 6.9 because of the optimizations in the timer subsystem.
> You know where I'm going with this..
>
> > I think the userspace program relied on a bug added in linux in 2020
> >
> > Jakub, I will stop trying to push the patches, this is a lost battle.
>
> If you have the patches ready - please post them.
> I'm happy to take the blame if they actually regress something in
> the wild :(

The series with the 2 patches has been posted already.

The remaining part is a nettest.c fix, that David is not happy with.

diff --git a/tools/testing/selftests/net/nettest.c
b/tools/testing/selftests/net/nettest.c
index cd8a580974480212b45d86f35293b77f3d033473..23d56797900f19890923028af0b=
7ba162d9d5794
100644
--- a/tools/testing/selftests/net/nettest.c
+++ b/tools/testing/selftests/net/nettest.c
@@ -1744,6 +1744,8 @@ static int connectsock(void *addr, socklen_t
alen, struct sock_args *args)
        if (args->bind_test_only)
                goto out;

+       set_recv_attr(sd, args->version);
+
        if (connect(sd, addr, alen) < 0) {
                if (errno !=3D EINPROGRESS) {
                        log_err_errno("Failed to connect to remote host");

>
> We're pursuing this because real application suffer real problems
> when routing changes cause transient ICMP errors. Users read the RFC
> and then come shouting at us that Linux is buggy.

