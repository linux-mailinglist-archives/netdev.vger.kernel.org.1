Return-Path: <netdev+bounces-96243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149A8C4B25
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F8D285035
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA4849C;
	Tue, 14 May 2024 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUs+DTMe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949191C36;
	Tue, 14 May 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715653037; cv=none; b=sS2R3gOx9gIuNDAO5w+TKmwk8rMM9r553ES41ykAWBUKJ/Cd/82sa/NyOaxrO7QzWqWicYDy59NkxAoVJ5hNCDYE+TKvsnV0y+GdgJPD2VE+bw5J+FUAEf68odGbUvIrKK/alu5bvVJAbtLpqkDY9Ww+kH9dz90yaZuBE/26194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715653037; c=relaxed/simple;
	bh=8lCoZs3r2WSbncL4Yblb+n5qHniaUx60epd3ZlZAIFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dz/xZkoeRLVFA57uATwkynnhxB1tA/m95OzXU77FtfTIM7+Ua7GK4+qlDVuJd43SCkrUMlTFSz6EAGF7tO8Y9FKyKdHET0JfpOKu4cMjLpm1ID2PdfWhqxg0DplkeRWrklxASFU19/j3s09hUQuTOvvDW2jSzT+POEQYCnYyZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUs+DTMe; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso89326281fa.0;
        Mon, 13 May 2024 19:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715653034; x=1716257834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOU3sr0VwyeQ5VPfDspJSP2TH2XsFUIDFfay9rLOt6Q=;
        b=HUs+DTMeF3cQ1hVzbe8c1A8nzA+OK9GCj8ruWZ3GIxpS9bQqm0ZTWUMwmeMXUCqIB3
         rXwoyaXkXjrArGHi9Cg69GCKMbA+4e3Kn5UUU3Gu2h4oQ+OOKw0dbE94KXJeYv9DdqAj
         gwcZZHnZDChJBxsBmB1VRMwFVm5XVbXFvrEpIvNv3DeLo4XKe49xoMwQZJlGP5pU+7+r
         ItQAfWl+7hddTv+tLwKuhFCk95QJRBgyISQQE2n8WJZxjp7SlAQadSqMZlI0+MJswbhp
         QbwH3YW9Wd+TkbUoAlZDGA+rqp9M1wT3uf58N+2jJUvwYhmXHf30XizPboJDTSUyMbz6
         ciFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715653034; x=1716257834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOU3sr0VwyeQ5VPfDspJSP2TH2XsFUIDFfay9rLOt6Q=;
        b=u9uZS4USgpPxjHD0C2qHXuZrv642luUWMHL2Mp49vQGB+uhPJf9zzrZH+nTvkj0jzc
         mPlkYJrYpUqe9KYeVmOt9BnQx0YLpdirEdVbvcdITG6jfp4zdxFn709cYHsIwyKbtpgr
         q9WbiRN3QJNN5tZcw7pZRQxutRVgDu9pj3ZAgYe18Fw5RYdRFDqhM2MJPq5pwynhUM/P
         MlVXuLHCS3msqA18fIjpjmyoSOe0uFeVQ4Le6PMYKjfm74tBx/YTXVvuM01FtrBhpaWB
         t2BGJoYEYljqTSYrVRBKTnvlG4dngJhTlZTP70GZ03Ozv2P9tffsLf4BGm2Ovk4OTr0e
         zjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLz0XWmkzjpjkDnGKUudhcz3kDPI0iAqvZmzY7XTBSdZukcutbwzKTj0PC5UTlcEEkzANXQxn2sCD7H7kDStGS9EnoG1M+w89tH0Qj5fgIQxBFnOme09C2kL5zWbPF5Kx8SntHksDk
X-Gm-Message-State: AOJu0YyJV0hwM5CJWLDsalGUIIXCpBy111PApXK9Vo+feXyR4UL5s2P6
	MMPQqwESxj07DuhyTF8Pr+RJJiDAg1plATfP85r1d0N2cUnKK5UXJvXsivRk5CxQXHoWuxZHg9p
	/NGNcBJ8UeD+BflNbjqhDrqkxM+Y=
X-Google-Smtp-Source: AGHT+IHV0OJXLUR1dpmBCwuPPmTdb6AuBkelR8C/jeGZVHX6SfQMYqQfEWxHMbxC9f1UpFdE9nOwAoke0potR3dnxps=
X-Received: by 2002:a2e:4a02:0:b0:2e6:be3c:9d4d with SMTP id
 38308e7fff4ca-2e6be3ce5demr17037401fa.12.1715653033495; Mon, 13 May 2024
 19:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org> <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org> <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com> <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
In-Reply-To: <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 May 2024 22:17:00 -0400
Message-ID: <CABBYNZKdbvyev+BV=CMGrzWPECJraP4OVJeysQYV=EFLKf_WVw@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

On Mon, May 13, 2024 at 10:09=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Luiz Augusto von Dentz wrote:
> > Hi Willem,
> >
> > On Mon, May 13, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jakub Kicinski wrote:
> > > > On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote:
> > > > > > There is one more warning in the Intel driver:
> > > > > >
> > > > > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'cause=
s_list'
> > > > > > was not declared. Should it be static?
> > > > >
> > > > > We have a fix for that but I was hoping to have it in before the =
merge
> > > > > window and then have the fix merged later.
> > > > >
> > > > > > It'd also be great to get an ACK from someone familiar with the=
 socket
> > > > > > time stamping (Willem?) I'm not sure there's sufficient detail =
in the
> > > > > > commit message to explain the choices to:
> > > > > >  - change the definition of SCHED / SEND to mean queued / compl=
eted,
> > > > > >    while for Ethernet they mean queued to qdisc, queued to HW.
> > > > >
> > > > > hmm I thought this was hardware specific, it obviously won't work
> > > > > exactly as Ethernet since it is a completely different protocol s=
tack,
> > > > > or are you suggesting we need other definitions for things like T=
X
> > > > > completed?
> > > >
> > > > I don't know anything about queuing in BT, in terms of timestamping
> > > > the SEND - SCHED difference is supposed to indicate the level of
> > > > host delay or host congestion. If the queuing in BT happens mostly =
in
> > > > the device HW queue then it may make sense to generate SCHED when
> > > > handing over to the driver. OTOH if the devices can coalesce or del=
ay
> > > > completions the completion timeout may be less accurate than stampi=
ng
> > > > before submitting to HW... I'm looking for the analysis that the ch=
oices
> > > > were well thought thru.
> > >
> > > SCM_TSTAMP_SND is taken before an skb is passed to the device.
> > > This matches request SOF_TIMESTAMPING_TX_SOFTWARE.
> > >
> > > A timestamp returned on transmit completion is requested as
> > > SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a software
> > > timestamp taken at tx completion cleaning. If anything, I would think
> > > it would be a passes as a hardware timestamp.
> >
> > In that case I think we probably misinterpret it, at least I though
> > that TX_HARDWARE would really be a hardware generated timestamp using
> > it own clock
>
> It normally is. It is just read from the tx descriptor on completion.
>
> We really don't have a good model for a software timestamp taken at
> completion processing.
>
> It may be worthwhile more broadly, especially for devices that do not
> support true hardware timestamps.
>
> Perhaps we should add an SCM_TSTAMP_TXCOMPLETION for this case. And a
> new SOF_TIMESTAMPING option to go with it. Similar to what we did for
> SCM_STAMP_SCHED.
>
> > if you are saying that TX_HARDWARE is just marking the
> > TX completion of the packet at the host then we can definitely align
> > with the current exception, that said we do have a command to actually
> > read out the actual timestamp from the BT controller, that is usually
> > more precise since some of the connection do require usec precision
> > which is something that can get skew by the processing of HCI events
> > themselves, well I guess we use that if the controller supports it and
> > if it doesn't then we do based on the host timestamp when processing
> > the HCI event indicating the completion of the transmission.
> >
> > > Returning SCHED when queuing to a device and SND later on receiving
> > > completions seems like not following SO_TIMESTAMPING convention to me=
.
> > > But I don't fully know the HCI model.
> > >
> > > As for the "experimental" BT_POLL_ERRQUEUE. This is an addition to th=
e
> > > ABI, right? So immutable. Is it fair to call that experimental?
> >
> > I guess you are referring to the fact that sockopt ID reserved to
> > BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usage in
> > the future, yes that is correct, but we can actually return
> > ENOPROTOOPT as it current does:
> >
> >         if (!bt_poll_errqueue_enabled())
> >             return -ENOPROTOOPT
>
> I see. Once applications rely on a feature, it can be hard to actually
> deprecate. But in this case it may be possible.
>
> > Anyway I would be really happy to drop it so we don't have to worry
> > about it later.
> >
> > > It might be safer to only suppress the sk_error_report in
> > > sock_queue_err_skb. Or at least in bt_sock_poll to check the type of
> > > all outstanding errors and only suppress if all are timestamps.
> >
> > Or perhaps we could actually do that via poll/epoll directly? Not that
> > it would make it much simpler since the library tends to wrap the
> > usage of poll/epoll but POLLERR meaning both errors or errqueue events
> > is sort of the problem we are trying to figure out how to process them
> > separately.
>
> The process would still be awoken, of course. If bluetoothd can just
> be modified to ignore the reports, that would indeed be easiest from
> a kernel PoV.

@Pauli Virtanen tried that but apparently it would keep waking up the
process until the errqueue is fully read, maybe we are missing
something, or glib is not really doing a good job wrt to poll/epoll
handling.

--=20
Luiz Augusto von Dentz

