Return-Path: <netdev+bounces-147501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A649D9E10
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699A8286E09
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A9B1DE4F8;
	Tue, 26 Nov 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KV/zz3Z5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD371AAD7
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649634; cv=none; b=cU37K6mezuTkLE4WfXtC8apGsKq8Wr6Gawi4ac2EcYmWZ3nmTBWY07cQKx8iPPRPk79sja/uM5jWKqKHf5Pl4A69LYktTgQQKY7t0rGY0yMWnGzf0WDVzHw1DI+acZYnfqJ2v/V5i23Ws8QhvMtwZp2MJNkxu9T7xifU/Z4IEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649634; c=relaxed/simple;
	bh=3tviE1lTFBA8fdfWxEbi4Y4ht8DBwW9525Hj7o8hU1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFWwqRqZ23O7Q+EOv2ojQFGjSNVfRXZ2oYCtEM4x+O8Ciq7yytej4Y+JlWcuQzqZl7dRU1V+s/gD0wcQiXV+ja+ZQu1hbAGCNcoWAp9ZnuQqyVt1Wh+uqWweUQ8DkdmNug7jynJq0muTZtZfwTSNrqk5THGsmmrlCKxMQ7ANcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KV/zz3Z5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9aa8895facso955527066b.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732649631; x=1733254431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tviE1lTFBA8fdfWxEbi4Y4ht8DBwW9525Hj7o8hU1U=;
        b=KV/zz3Z5bp8pBuZD6RYaRZBjN9HnfFzCo1lG96LCZiCcYfUl48JqNo1Tm6dy30BCiy
         eUzBpun7vF9mL50YI0nXvfdGj+nJRAb0WFEOKiI/2GRLqS2kdAQyoa91prEiQ9OhwDFH
         0DSWb5jbDsSw5ejvuzmtV+lENlXc2x7f1D6VbE+TdLYXS2RxTppsNcU5rog47ovlviHb
         bT8J7WjYQ1MjpXmekLXap0yeQmp/r1lHM6cIvhf4Ven/AY4SuHWPsue+TeeNzy2o5G/U
         4rqEVO1+fA2xxmxj3Q8B/ikyycopS43JiqbAZD+QGEnZ3mJfCs3XcTgr0MYt4fvCKQts
         d2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732649631; x=1733254431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tviE1lTFBA8fdfWxEbi4Y4ht8DBwW9525Hj7o8hU1U=;
        b=QgqD/Ba9ryDRpR4NDMY8SAyRfU/QJ9cdT9ObPX4YwfDAR+TFnXvJZydMF9FCWsf9HV
         M/Hf2LxB8b8446/gp4pPZPWrgrEBlUlQg7DljpjO6sIco+9iew/BPg43oXOnJHNnlPnr
         EZL2ZHkq0XeneoGM+mf2uZI1nRr10DCTOP5RZXy64nkPB3F4KEDnZMUgoiv9TXAQIVAk
         kqZTBHheGO5EGqZib3du/VVmNvWkfbsGcE7owZJQY+hrOW+fP4epzqfU9AT7//Y+uh9X
         jk8RdivnvgoyOAXtQGakmVp6DfTF1pMY1S8YZ0ayF065hpl7I6vxPLMXUv6AI7cidE3y
         hgxg==
X-Gm-Message-State: AOJu0YwrPZDjk40+uvWoO/hkKF83JDfyHgIfOhfv9lyqt3xxzqsxxWOA
	e2efbflyP8RN97X5c6AOcusWq1qarqIivgUNx3N6qDZWmLugh1ZFBCgE/HuaeIFUttFtluRH56w
	tqKI2ZijZWBr+PRGP45gQ+0EgfWNIDAZgpU/S
X-Gm-Gg: ASbGncs0GL+JOhTLeb2bHowvA7UxUcHn5YVx+EmICkm8SPcOPVXjCLnvQDnedW4hvSq
	/bbZnNVoVfd82lVV+0FeKb7BmdbQuTvkO
X-Google-Smtp-Source: AGHT+IGcvN6wIrDp5E7Dz0TYhT1oIrFTq4N40vkQJntaPqJbNldn4hfL3vD057zDvOVMSfw6sWgCZN9BMkWZ+6qc+Rw=
X-Received: by 2002:a17:906:1db2:b0:aa5:4434:2b2c with SMTP id
 a640c23a62f3a-aa5810768f6mr10169466b.55.1732649630783; Tue, 26 Nov 2024
 11:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126175402.1506-1-ffmancera@riseup.net> <CANn89iJ7NLR4vSqjSb9gpKxfZ2jPJS+jv_H1Qqs1Qz0DZZC=ug@mail.gmail.com>
 <CANn89i+651SOZDegASE2XQ7BViBdS=gdGPuNs=69SBS7SuKitg@mail.gmail.com>
 <85bce8fc-6034-43fb-9f4e-45d955568aaa@riseup.net> <CANn89iLF_0__Ewy9TXpCs7NP4FB-18iGfnn=cXgXu4qMbxyhwQ@mail.gmail.com>
 <8506e3ba-c2fc-4981-9a51-041565a9337b@riseup.net>
In-Reply-To: <8506e3ba-c2fc-4981-9a51-041565a9337b@riseup.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Nov 2024 20:33:39 +0100
Message-ID: <CANn89i+OtPYN7U_noe_izHx5wYjV+kyq_JODD0-8LROA8noZ6w@mail.gmail.com>
Subject: Re: [PATCH net] udp: call sock_def_readable() if socket is not SOCK_FASYNC
To: "Fernando F. Mancera" <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:30=E2=80=AFPM Fernando F. Mancera
<ffmancera@riseup.net> wrote:
>
>
>
> On 26/11/2024 20:26, Eric Dumazet wrote:
> > On Tue, Nov 26, 2024 at 8:18=E2=80=AFPM Fernando F. Mancera
> > <ffmancera@riseup.net> wrote:
> >>
> >> Hi,
> >>
> >> On 26/11/2024 19:41, Eric Dumazet wrote:
> >>> On Tue, Nov 26, 2024 at 7:32=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> >>>>
> >>>> On Tue, Nov 26, 2024 at 6:56=E2=80=AFPM Fernando Fernandez Mancera
> >>>> <ffmancera@riseup.net> wrote:
> >>>>>
> >>>>> If a socket is not SOCK_FASYNC, sock_def_readable() needs to be cal=
led
> >>>>> even if receive queue was not empty. Otherwise, if several threads =
are
> >>>>> listening on the same socket with blocking recvfrom() calls they mi=
ght
> >>>>> hang waiting for data to be received.
> >>>>>
> >>>>
> >>>> SOCK_FASYNC seems completely orthogonal to the issue.
> >>>>
> >>>> First sock_def_readable() should wakeup all threads, I wonder what i=
s happening.
> >>>
> >>
> >> Well, it might be. But I noticed that if SOCK_FASYNC is set then
> >> sk_wake_async_rcu() do its work and everything is fine. This is why I
> >> thought checking on the flag was a good idea.
> >>
> >
> > How have you tested SOCK_FASYNC ?
> >
> > SOCK_FASYNC is sending signals. If SIGIO is blocked, I am pretty sure
> > the bug is back.
> >
>
> Ah, I didn't know SIGIO was going to be blocked.
>
> >
> >>> Oh well, __skb_wait_for_more_packets() is using
> >>> prepare_to_wait_exclusive(), so in this case sock_def_readable() is
> >>> waking only one thread.
> >>>
> >>
> >> Yes, this is what I was expecting. What would be the solution? Should =
I
> >> change it to "prepare_to_wait()" instead? Although, I don't know the
> >> implication that change might have.
> >
> > Sadly, we will have to revert, this exclusive wake is subtle.
>
> If that is the case, let me send a revert patch. Thanks for the fast
> replies :)

Please wait one day before sending a new patch, thanks.

