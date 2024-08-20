Return-Path: <netdev+bounces-120158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F94958765
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B751C21B35
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4560818FDC8;
	Tue, 20 Aug 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZpkfSSg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ECA18FDC4
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158409; cv=none; b=L6hxVTlxpEwsym2K9cwmgoICUkDN7yGP5QVgugtmyKWskxnIA9msJOI+iP7ZsfcVcNNr0pBieuhNDT1TikRAJqDf+owMHX7b6bxF9NPSYwKue+qNr09V6TVGLjv2Ry5fvoQkXHQRDYG+TuRwoG9eo3l121wXxhQ12GsotpUlCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158409; c=relaxed/simple;
	bh=2EgkA1HMh6F8wgPlCtIm5Z9RvNY1D14KZHOSR7GRXlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ9p01kbpLQ9e1b8mwMJTjy8Pd7Xl8m5CaPFtBS/Is2l6rG4Y+SACIdw0ayrKgDchwVCjOaFYhzmGmEdiSZsroujEKtdfFsPqHY+3zXpKZXStZ6R+tTE75/mqURtaWLilfIqbwhM1uqZBTqANWwlJgYG+7dRSYyshuyzZoMIYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZpkfSSg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa086b077so569059866b.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724158406; x=1724763206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/Q4C6LXCVgmbT6trcLASQuz550xXj+nAUpmdGrtj58=;
        b=PZpkfSSgSryZDgyIJBj6W21WruPR8NplxuWSlt3s9KFr6gn94dEMMTAzt81GmMK/ya
         QS+AJvan+lkyz8k1D061VnJhUMQB5YAY+M3XJa345EDBHZG4F1hkhHWtcxqqbKGSLedO
         Q7wtQpEtaB2QGjAwLUy63bFJ8Of4/y85LbLto72VFlSPYGGLFPuNG9sxD2piuI7OMmy8
         Bjeoa4rSYhYHwd0WQDJmiziQZMIvZL3CpIZNCw2CCyM0Yd6nWrLc8mbzqjRda7zpdf2X
         SdN0EpyDbpxquOqSaSzX8OzII3H1YM8eunpzDIxNqtzrM28Lae+PewRVzzLw0ZY7yJ0s
         x2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158406; x=1724763206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/Q4C6LXCVgmbT6trcLASQuz550xXj+nAUpmdGrtj58=;
        b=LN+orOXQzrv1ngx6y1T+jO0odwjkHvqjPMnNR5D6aFH6d5fpEph3UzHK7wdOGW5ooH
         0beQjlb4d/ARSJ1QtxCXfVau8kXejRex5EX26snVYV9zG4oxcquPVXVIvnMUg9/xxskZ
         x93aNDqbfPHAS6nZOzA30l4AFPC2F5xjgrMXa/Y6pH/f5XhKXRopKO8EqTLJHXf4JMx7
         Wz3H//HqKXUXSYCltv7L8/OrlpHj+ql6lLibPQuzGNBN+arSpcs0B3PM6fmcUhoPFyqS
         ylUXA8mGG0hp+PKPkN9d4JM3C0CkFFOW68Ry1ibkgfsZ7xldsJdcxUg4kzqrVCP0PApg
         Ftpg==
X-Forwarded-Encrypted: i=1; AJvYcCVuPidlJC2tBjjbkUAut9D9vVybFz1hMG9X9HdMkyPlpiGufDAzUaVLpi2UW70zqoRHNBEEWPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpbqIvF/8NSL27LSfQRKB01WKuw626LVa+0GbLg6goyJXE3uv
	St3H/buTmnSXynWxiFBBGzJL6Takoqjjwy7ATYr3UGCdJKyeV8daItWb21FBU4u3ea41FhNHpQh
	NXomfKiWZ2/n4MQrHuwILDIPwp4Li98veNDuy
X-Google-Smtp-Source: AGHT+IH2tRes6OrUDfCb1HGtuyNgPl0vPQoK732Scdy3Mwdbw2cH5e0dseR0ByZvk4+oWyUC8POxTfm61/n09wVXY04=
X-Received: by 2002:a17:907:7d8b:b0:a80:f79a:10c9 with SMTP id
 a640c23a62f3a-a864795e138mr166900866b.12.1724158404924; Tue, 20 Aug 2024
 05:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817163400.2616134-1-mrzhang97@gmail.com> <20240817163400.2616134-2-mrzhang97@gmail.com>
 <CANn89iKwN8vCH4Dx0mYvLJexWEmz5TWkfvCFnxmqKGgTTzeraQ@mail.gmail.com> <573e24dc-81c7-471f-bdbf-2c6eb2dd488d@gmail.com>
In-Reply-To: <573e24dc-81c7-471f-bdbf-2c6eb2dd488d@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 14:53:13 +0200
Message-ID: <CANn89i+yoe=GJXUO57V84WM3FHqQBOKsvEN3+9cdp_UKKbT4Mw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Mingrui Zhang <mrzhang97@gmail.com>
Cc: davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:36=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.com=
> wrote:
>
> On 8/19/24 04:00, Eric Dumazet wrote:
> > On Sat, Aug 17, 2024 at 6:35=E2=80=AFPM Mingrui Zhang <mrzhang97@gmail.=
com> wrote:
> >> The original code bypasses bictcp_update() under certain conditions
> >> to reduce the CPU overhead. Intuitively, when last_cwnd=3D=3Dcwnd,
> >> bictcp_update() is executed 32 times per second. As a result,
> >> it is possible that bictcp_update() is not executed for several
> >> RTTs when RTT is short (specifically < 1/32 second =3D 31 ms and
> >> last_cwnd=3D=3Dcwnd which may happen in small-BDP networks),
> >> thus leading to low throughput in these RTTs.
> >>
> >> The patched code executes bictcp_update() 32 times per second
> >> if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd=3D=3Dcwnd.
> >>
> >> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
> >> Fixes: ac35f562203a ("tcp: bic, cubic: use tcp_jiffies32 instead of tc=
p_time_stamp")
> > I do not understand this Fixes: tag ?
> >
> > Commit  ac35f562203a was essentially a nop at that time...
> >
> I may misunderstood the use of Fixes tag and choose the latest commit of =
that line.
>
> Shall it supposed to be the very first commit with that behavior?
> That is, the very first commit (df3271f3361b ("[TCP] BIC: CUBIC window gr=
owth (2.0)")) when the code was first introduced?

I was referring to this line : Fixes: ac35f562203a ("tcp: bic, cubic:
use tcp_jiffies32 instead of tcp_time_stamp")

Commit ac35f562203a did not change the behavior at all.

I see no particular reason to mention it, this is confusing.


> >> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
> >> Signed-off-by: Lisong Xu <xu@unl.edu>
> >> ---
> >> v3->v4: Replace min() with min_t()
> >> v2->v3: Correct the "Fixes:" footer content
> >> v1->v2: Separate patches
> >>
> >>  net/ipv4/tcp_cubic.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> >> index 5dbed91c6178..00da7d592032 100644
> >> --- a/net/ipv4/tcp_cubic.c
> >> +++ b/net/ipv4/tcp_cubic.c
> >> @@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *c=
a, u32 cwnd, u32 acked)
> >>
> >>         ca->ack_cnt +=3D acked;   /* count the number of ACKed packets=
 */
> >>
> >> +       /* Update 32 times per second if RTT > 1/32 second,
> >> +        * or every RTT if RTT < 1/32 second even when last_cwnd =3D=
=3D cwnd
> >> +        */
> >>         if (ca->last_cwnd =3D=3D cwnd &&
> >> -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> >> +           (s32)(tcp_jiffies32 - ca->last_time) <=3D
> >> +           min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))
> > This looks convoluted to me and still limited if HZ=3D250 (some distros
> > still use 250 jiffies per second :/ )
> >
> > I would suggest switching to usec right away.
> Thank you for the suggestion, however, I may need more time to discuss wi=
th another author for this revision. :)
> Thank you

No problem, there is no hurry.

