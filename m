Return-Path: <netdev+bounces-157741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684FA0B7C4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED7B188776E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4B235C08;
	Mon, 13 Jan 2025 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ueNkK4HP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567C235C09
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773792; cv=none; b=u8S2gGIcfRGhkKAEMFtfA+W09BcVTXtKLvpOSn/w2KPkoxxL8IAjRAGY+j7ps8T+VhyG3CjL20gf3M2BID3zYqS+r8SOXTI+hEwJzBLBV9tbnN/VXVi7zbSavnkWbJeKO6C2wKVgVMEEI7EfaQ+1Hh53HDb+5HMwYtPwRixu+9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773792; c=relaxed/simple;
	bh=ENgcB/HIV9FFeR8OtaxuDv85G8i4erePRK97tplqCDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtRNRYw7WCIYWLd2pdDVJC2Yc1lKntyreuhjWUownYo2yEM5VOgW6cVQk8BQzyS7iYPtNJ8Tl8hP7xBYwxDrCzjmgoER0KuVkIytinEUs39fzOxGGozhWtpFrO/ept4oYZ0g7KfYMV2j3grogkI4F9/DIoa/r4hTyWPdVqhOM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ueNkK4HP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so6029477a12.2
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736773788; x=1737378588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENgcB/HIV9FFeR8OtaxuDv85G8i4erePRK97tplqCDE=;
        b=ueNkK4HP/YC9BLNgBv0rKhuIuaq+/lJYF6rwgxTYZHg7fSbbW9iLDUAUcHhTYcO9zm
         49uQJqn089sOYiwACiuONjpqhbmH2hh4hprbVIg5gQVbjcHp8gu2ckqqwIuZPWU8YA2p
         GJKdkYJIQ1x8CGXrUc9WcknpTp/vRpWtCieXNo+bV4zD44flrdZJnD/h4MiA8fUMqDQh
         Ow529XnVkTYHUwOaHXA3AoWL0c6XgJOIxmueqBFfQpziwCF8BEQqNMuLalZSbKAosJ5+
         dSa4UnnoaaIplcPfP1khK7YBlhf8o1PkWtPsCupEJ82MFWv02tP0o+t3J0Kx1bWQ0TEM
         eHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736773788; x=1737378588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENgcB/HIV9FFeR8OtaxuDv85G8i4erePRK97tplqCDE=;
        b=aVBTyvvKcwvGAdoydPGF1bBL4WgV+BqGKI1uFYcKw6eJ9c1pVdB1U6+sZZo/Ga81K/
         NBOjYJeDOimsXkpWGZCrHVzq0rsngQqVdTH1bYYm+0yC2HqjS2HHq/2tuDWjhl9c6pSp
         Hxu9uYHWJQcykiazXcBdi8LM5cvhv8I59UNfsrS8LOsyl8bylHhIVB6xcbiGCGxmZX03
         cYDgN7+725f73ERdLN5TIPx5NulIShvKeC6WPYcyL0h/ul073sU5tgCx/LtdZ18iLXCd
         /fFy9F+jp75QLJTxBwKWOfIOYME0CnOtpLy+pvA3mvYwaZWRqe/9Fca41Q/+RDCiJtCB
         /kug==
X-Forwarded-Encrypted: i=1; AJvYcCWWXibGlny12Slsmlfk6DMgbvbFV61fczLJt1WvuwpuPLakMi7i9Xojlly/Ek36m9or3Ug8sT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0GaTu7+1Fl5G/2CjSJgG30fUJxoh/gO55X3mI0epyvEjb7Mf
	MASy2O7QaipG4Fc3JXlSmnydk8Fa7keEhMnxqyS18yAEIkYd8kKK50ofwgsrJ0bRTCXa1X5Yk5I
	kDJbM/zJ3P36y/kWujaNf/Xs+7TyG10W/d1+/
X-Gm-Gg: ASbGncuLSBC5SzSDfk8aSvVtKye1VvlRrE9I87BzCiwR5KCcOxnOy4D4Bs14guS/DlV
	Om8dW80CuN/eVht5H6RAYI5f3n8EwkNHBet2icw==
X-Google-Smtp-Source: AGHT+IEK66vZDkDQVYRjwXrnMMdtAGPdWe9DC32W3ASCxqNFiQu5Jz6vgehqTt08DAaBJAmu+XsUvKeDpQ0Xbo83SEc=
X-Received: by 2002:a05:6402:400a:b0:5d2:7199:ac2 with SMTP id
 4fb4d7f45d1cf-5d972e00032mr49676421a12.2.1736773788413; Mon, 13 Jan 2025
 05:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com> <20250110143315.571872-3-edumazet@google.com>
 <CAL+tcoDit2HQ9r-keyZjkSJF4esj-tB2rBAtFX7QBPueCaA8NA@mail.gmail.com>
 <CANn89i+x3mLp=RKDRzs-KjQgZMJxnLqciERt3mbotzE6KPHbXA@mail.gmail.com> <CAL+tcoA8SdpKo94z9MsFyMPEHgns9kzb505v6hybenot4CpCXg@mail.gmail.com>
In-Reply-To: <CAL+tcoA8SdpKo94z9MsFyMPEHgns9kzb505v6hybenot4CpCXg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jan 2025 14:09:37 +0100
X-Gm-Features: AbW1kvbn0olzVmIHWz9WelIPKXS9XbKrDVRNoh3tSNC1LVWnfaY3oHpwn5aWLoQ
Message-ID: <CANn89i+bYZuR_XL4HoL0cNtpiGax2Tuayd5kp_MbmTz1R1Ku7w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add TCP_RFC7323_PAWS_ACK drop reason
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 2:00=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Jan 13, 2025 at 3:37=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Jan 13, 2025 at 8:22=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > Hello Eric,
> > >
> > > On Fri, Jan 10, 2025 at 10:33=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > XPS can cause reorders because of the relaxed OOO
> > > > conditions for pure ACK packets.
> > > >
> > > > For hosts not using RFS, what can happpen is that ACK
> > > > packets are sent on behalf of the cpu processing NIC
> > > > interrupts, selecting TX queue A for ACK packet P1.
> > > >
> > > > Then a subsequent sendmsg() can run on another cpu.
> > > > TX queue selection uses the socket hash and can choose
> > > > another queue B for packets P2 (with payload).
> > > >
> > > > If queue A is more congested than queue B,
> > > > the ACK packet P1 could be sent on the wire after
> > > > P2.
> > > >
> > > > A linux receiver when processing P2 currently increments
>
> Maybe P1? If the receiver processes the P2 packet (as you said, with
> payload) earlier than P1 (pure ack) and it really returns with a drop
> reason, I think it should hit #1 case instead of #2 case.
>

Sure, this is a typo of course.

> IIUC, the receiver processes the P1 and finds that P1.seq < rcv.nxt
> because P2 already updates rcv.nxt earlier.
>
> > > > LINUX_MIB_PAWSESTABREJECTED (TcpExtPAWSEstab)
> > > > and use TCP_RFC7323_PAWS drop reason.
> > > > It might also send a DUPACK if not rate limited.
> > > >
> > > > In order to better understand this pattern, this
> > > > patch adds a new drop_reason : TCP_RFC7323_PAWS_ACK.
> > > >
> > > > For old ACKS like these, we no longer increment
> > > > LINUX_MIB_PAWSESTABREJECTED and no longer sends a DUPACK,
> > >
> > > I'm afraid that not all the hosts enable the XPS feature. In this way=
,
> > > this patch will lead the hosts that don't enable XPS not sending
> > > DUPACK any more if OOO happens.
> > >
> > > So I wonder if it would affect those non XPS cases?
> >
> > Everything is fine. The non XPS cases will be handled perfectly well.
> >
> > For the record, all TCP packetdrill tests we currently have are passing=
.
> >
> > Feel free to cook a packetdrill test to show exactly the issue you are
> > thinking of,
> > chances are very high you won't find a concerning problem.
>
> Thanks for your reply. I don't think it's a concerning issue either
> even if it happens. Admittedly, OOO pure ack happens really rarely
> from my experience.

Good then :)

