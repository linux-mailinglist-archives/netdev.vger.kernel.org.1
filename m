Return-Path: <netdev+bounces-96695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBEF8C72DC
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35A21F22E2B
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30C013C681;
	Thu, 16 May 2024 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z4m6DUZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3C13C66C
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848296; cv=none; b=mK/ltAJg7gn5oWFDp8ROw4xUfvmAmyGd2ysXcQBDFoyIJQGCI27xEDG8bQF74Y1EWpID867jx+j83gB4SR92paDhudHsFkB+C9FhmPQUkH0SlwrowctHx1jQNjqKgLq4M8TPacPPMK8LDKkLCwfD8mrFPAt4xUYQWLXGQwPPPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848296; c=relaxed/simple;
	bh=NwDV5Bjg9tXIvWilC7uCDdRbgkFftYzUmeN1CESZZ7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugBiYRAKUNRwRu3U+Hx/vfPTDtaDzcTAFbw8rIFm9uy3f6QEYgKN3p+QnsnoB05EZvBwhxCZ8hFaN7bu3K2L2BMA/czYwCqKDYV8VNnC0gT0sxsfAH4ZmLOMs5LCyaI5TC9ZqI8ExRWPtTLtHBAwuEO8nifbz14gS0oxG98mGw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z4m6DUZS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so407395e9.1
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715848293; x=1716453093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5WaBwiXkllwrMI3UTFa3jloDkhUa3pGnM04R1YtsgA=;
        b=z4m6DUZSCBa2EaxPJjB5aaVHfA4sPgXTNAkFJx90vvRiFfKZlsGt0BSA3j2ZfZmOP8
         AI8nvBD8xlK93dG0oqa/toXITBEH08QAo6Y4A2OjNWkWEaCLFu2mlPCuvijw2dAteT5e
         KW9P0K+cNyjCPMNdnVCHjszAiOKB51LjjvHqx2mwcIQ2MlDrZrd+Z6URhbm7Xez0W4kH
         yjesGMyvaJCG1yJzwBxKr5w8kbtrJmErdYE2E9AtjMLGuQTo3mligFI+OesB4PmnuroV
         br9O74mK1zOaBXVlSgTvwx625ha+zAaGu6Lq6y9Qw2OYNHZ0VOaQXONu2HRgx+RhlxkV
         +2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715848293; x=1716453093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5WaBwiXkllwrMI3UTFa3jloDkhUa3pGnM04R1YtsgA=;
        b=MWxW3ttFIIoK4wqoLUNQua1hJOCGnEzAhO5VQjGNpuAUoyGECpKwjuIZimCjnhvYWN
         pZm+6blSJmBbUIO8sT/hbIux3K3FzuMdPFkUSaJIo1QJ9ETiJqgnLYhv6Pxy1clpHa7U
         w/0zyPFJSVWLSj2h36EXYViEDVAbFMSpfC/dzOumPU3Ll4jmLAmucfbgqqzSudu09mvW
         QxkkxgHwhclJ0XbiHRRdDrSS5q06Rtl3Bt0pNMSNnyvHjVI8aPP/CHt3+ouwfAmfjcVr
         NCF/JEg0FcdW0pJgKFh3WdoOoU4Tz0QlBfVnfLML7QjHml5STBAsWDwHIiQi3h3Fx4Ur
         x3AA==
X-Forwarded-Encrypted: i=1; AJvYcCWnvOMgK9u6JKSt+DHk7Dzo9bnduAsj8JvH7ko7c7qzMmGw755Ktf77zNIp5GB+ZO021fGuIRZYSp0haa3M2xc9qWAa/x9x
X-Gm-Message-State: AOJu0Yx9Ggdd90QgBOSQ7Eu/xKCL/FLIa7rlj2pw8e5ngOqKuf88l8/p
	N5Wveu915LANpTeSyw1HCAZ0eWaiUEmHHT9it7wTQbRaVMJlhunH/mR9eUg2MUjLbhSFHjnY7kN
	1h4pPiphrSNOrIPejngkhvkpjOIgIWGdhCFZZ
X-Google-Smtp-Source: AGHT+IG55rB7hrBQPkOu9uddNHznikL4xvUvOsk4ywEOoBhZWOX4LfTpzKKouDHkSouxKCYCyGx9ukM4UIr5gSZfTTk=
X-Received: by 2002:a05:600c:1d9e:b0:41f:a15d:220a with SMTP id
 5b1f17b1804b1-4200ee380d0mr11358775e9.4.1715848292730; Thu, 16 May 2024
 01:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
 <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com> <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
 <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com> <CANn89iKPqdBWQMQMuYXDo=SBi7gjQgnBMFFnHw0BZK328HKFwA@mail.gmail.com>
In-Reply-To: <CANn89iKPqdBWQMQMuYXDo=SBi7gjQgnBMFFnHw0BZK328HKFwA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 May 2024 10:31:21 +0200
Message-ID: <CANn89iJQRM=j4gXo4NEZkHO=eQaqewS5S0kAs9JLpuOD_4UWyg@mail.gmail.com>
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	quic_stranche@quicinc.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 9:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, May 16, 2024 at 9:16=E2=80=AFAM Subash Abhinov Kasiviswanathan (K=
S)
> <quic_subashab@quicinc.com> wrote:
> >
> > On 5/15/2024 11:36 PM, Eric Dumazet wrote:
> > > On Thu, May 16, 2024 at 4:32=E2=80=AFAM Subash Abhinov Kasiviswanatha=
n (KS)
> > > <quic_subashab@quicinc.com> wrote:
> > >>
> > >> On 5/15/2024 1:10 AM, Eric Dumazet wrote:
> > >>> On Wed, May 15, 2024 at 6:47=E2=80=AFAM Subash Abhinov Kasiviswanat=
han (KS)
> > >>> <quic_subashab@quicinc.com> wrote:
> > >>>>
> > >>>> We recently noticed that a device running a 6.6.17 kernel (A) was =
having
> > >>>> a slower single stream download speed compared to a device running
> > >>>> 6.1.57 kernel (B). The test here is over mobile radio with iperf3 =
with
> > >>>> window size 4M from a third party server.
> > >>>
> > >
> > > DRS is historically sensitive to initial conditions.
> > >
> > > tcp_rmem[1] seems too big here for DRS to kick smoothly.
> > >
> > > I would use 0.5 MB perhaps, this will also also use less memory for
> > > local (small rtt) connections
> > I tried 0.5MB for the rmem[1] and I see the same behavior where the
> > receiver window is not scaling beyond half of what is specified on
> > iperf3 and is not matching the download speed of B.
>
>
> What do you mean by "specified by iperf3" ?
>
> We can not guarantee any stable performance for applications setting SO_R=
CVBUF.
>
> This is because the memory overhead depends from one version to the other=
.

Issue here is that SO_RCVBUF is set before TCP has a chance to receive
any packets.

Sensing the skb->len/skb->truesize is not possible.

Therefore the default value is conservative, and might not be good for
your case.

This is not fixable easily, because tp->window_clamp has been
historically abused.

TCP_WINDOW_CLAMP socket option should have used a separate tcp socket field
to remember tp->window_clamp has been set (fixed) to a user value.

Make sure you have this followup patch, dealing with applications
still needing to make TCP slow.

commit 697a6c8cec03c2299f850fa50322641a8bf6b915
Author: Hechao Li <hli@netflix.com>
Date:   Tue Apr 9 09:43:55 2024 -0700

    tcp: increase the default TCP scaling ratio




>
> >
> > >>
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tre=
e/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c?h=3Dv6.6.17#n385
> > >
> > > Hmm... rmnet_map_deaggregate() looks very strange.
> > >
> > > I also do not understand why this NIC driver uses gro_cells, which wa=
s
> > > designed for virtual drivers like tunnels.
> > >
> > > ca32fb034c19e00c changelog is sparse,
> > > it does not explain why standard GRO could not be directly used.
> > >
> > rmnet doesn't directly interface with HW. It is a virtual driver which
> > attaches over real hardware drivers like MHI (PCIe), QMI_WWAN (USB), IP=
A
> > to expose networking across different mobile APNs.
> >
> > As rmnet didn't have it's own NAPI struct, I added support for GRO usin=
g
> > cells. I tried disabling GRO and I don't see a difference in download
> > speeds or the receiver window either.
> >
> > >>
> > >>   From netif_receive_skb_entry tracing, I see that the truesize is a=
round
> > >> ~2.5K for ~1.5K packets.
> > >
> > > This is a bit strange, this does not match :
> > >
> > >> ESTAB       4324072 0      192.0.0.2:42278                223.62.236=
.10:5215
> > >>        ino:129232 sk:3218 fwmark:0xc0078 <->
> > >>            skmem:(r4511016,
> > >
> > > -> 4324072 bytes of payload , using 4511016 bytes of memory
> > I probably need to dig into this further. If the memory usage here was
> > inline with the actual size to truesize ratio, would it cause the
> > receiver window to grow.
> >
> > Only explicitly increasing the window size to 16M in iperf3 matches the
> > download speed of B which suggests that sender server is unable to scal=
e
> > the throughput for 4M case due to limited receiver window advertised by
> > A for the RTT in this specific configuration.
>
> What happens if you let autotuning enabled ?

