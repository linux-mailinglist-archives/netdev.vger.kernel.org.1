Return-Path: <netdev+bounces-96240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA188C4B1B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351721C21926
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975F74C8D;
	Tue, 14 May 2024 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmBHOqxg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288917FF;
	Tue, 14 May 2024 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652598; cv=none; b=OJd5ueW74Qki2MMJ0dEvKwXwg/Ab8qNqMyR2OVhYQeYDNwMlzykhWk2jyf6QTz718PUbQKKRgEVZNG2O7PfPcHQmVnSrYn7CwQpKtpVnqZrobBTBlDa206JMSnOV1t45PR70e8NfC6ely5YqxaXmnte7e5P/uM4Nc/DKVesDVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652598; c=relaxed/simple;
	bh=LjVa81Cc5m7AOnunguLpwL9peFPj3/e+0t7PxmX0Fek=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Nld9HwOj4zxnxtSZN8AI8l803JQV4IYxwBEoNp23N5IxVgEZWWCqCFdyYvYd73yJ2n2XWLoUrpfwSCsxL+Ga1r8thZIGTMKpkSPpQNvuMewxcgXy3IHsQJRh4CeAvaGH/iVMiR8SfBzslwA9xjuh4Yk8H0gv4EJvkocBriiySoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmBHOqxg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43ddbdf2439so37525871cf.0;
        Mon, 13 May 2024 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715652596; x=1716257396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7lQLibbRGW3D7/zNxSSQ75VtkW8i2/oQG5s8KE0RjA=;
        b=lmBHOqxgIaG3iL9u79vpVVpdIRWIPSgx2oLwAXiOtXsZQKJzToxt/FU4O5RLsRt4vy
         /LCXRJxNmny8FnekQA7I1dVchLsp65sByivdm6aNXIvfLnWyygjIVvhJxBf3A9pMFwSM
         Y6H7klRVowNDOh5YVIWMM6yNJ2+6A/0fttq3YYrZ/FEAHFhVK58s2WxKEKdr+PFfAPcR
         gQ81CqH45ezFBbnSdU1RRx1jqzF0u3/e4RE0S1qj0a/Ao8aXqgCjbUUwGSDxssAf2LzW
         l2iVt5lmfKW1mvdmO1/c93sUpfZsLCYEoPJ7r/LB3sZZv5MdBSDMV0Wj4JmCNoJNbgNg
         MzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715652596; x=1716257396;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P7lQLibbRGW3D7/zNxSSQ75VtkW8i2/oQG5s8KE0RjA=;
        b=Mb7J+J+72vIDS6q7xpsjv5ZzaFyHknxfPDftYk4p1VqgR3DikfHOWV/qpgzZTzbB8W
         j9yVbmgy7SXTYapjcUQ4a+HaZto5+AMwMIg6uywFnzjS8THz8gsFfhyxrLgYCkFpzmDK
         YDd9xecJz0FgRH1fI41cRTbXjgeO9GV4C/MwCgxcG1qHYa4gv4E31pM4cDCHAhof0X6X
         KakMj+dSftdrJEGsHuMQdR5op9iGb8drDxlaJyCFwYoMLlOELvGiEaTjoTC8HPbwO2pR
         KF6g7oN23FA0yRAEICIEnKcGzXfXRFFAmmr9A2LuSrVw4/AG2ebhQRO5V+1No+xyP7sE
         4sQg==
X-Forwarded-Encrypted: i=1; AJvYcCWAae3dgSbIcfEdlRellU63LZ1m1cwFawLHA7eYRrNp56M848PNt52u5MBGa/OhOwMYVfEaib+NDpJQl2DVQ+ATo24nXbOQAHpLz1jGcYMQF5iIq9JkIv1J6N8yqX2EaxdQ4CcpXzZ4
X-Gm-Message-State: AOJu0YzH/U4GAX12LzcwwyvfKAiRQq12DEqjY8RBlALmSVaJ859N7Q2d
	7U1/0vddi5ud8SaZIhsxdpTv1WyhBeiO2TmI8PcRhRTL9DL2Ks80
X-Google-Smtp-Source: AGHT+IEqk3BXUCceDeODrcxZDDohXTcsGIkaucB5ThAXDWhWdmUSzK0h9nabJF/X/1Z/mVCr7dfxhQ==
X-Received: by 2002:ac8:5802:0:b0:43a:d7a9:390 with SMTP id d75a77b69052e-43dfdb4c7bfmr154413581cf.29.1715652595778;
        Mon, 13 May 2024 19:09:55 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e069a24basm43277161cf.67.2024.05.13.19.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 19:09:55 -0700 (PDT)
Date: Mon, 13 May 2024 22:09:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net, 
 linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Pauli Virtanen <pav@iki.fi>
Message-ID: <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org>
 <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org>
 <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Luiz Augusto von Dentz wrote:
> Hi Willem,
> =

> On Mon, May 13, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jakub Kicinski wrote:
> > > On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote:
> > > > > There is one more warning in the Intel driver:
> > > > >
> > > > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'cause=
s_list'
> > > > > was not declared. Should it be static?
> > > >
> > > > We have a fix for that but I was hoping to have it in before the =
merge
> > > > window and then have the fix merged later.
> > > >
> > > > > It'd also be great to get an ACK from someone familiar with the=
 socket
> > > > > time stamping (Willem?) I'm not sure there's sufficient detail =
in the
> > > > > commit message to explain the choices to:
> > > > >  - change the definition of SCHED / SEND to mean queued / compl=
eted,
> > > > >    while for Ethernet they mean queued to qdisc, queued to HW.
> > > >
> > > > hmm I thought this was hardware specific, it obviously won't work=

> > > > exactly as Ethernet since it is a completely different protocol s=
tack,
> > > > or are you suggesting we need other definitions for things like T=
X
> > > > completed?
> > >
> > > I don't know anything about queuing in BT, in terms of timestamping=

> > > the SEND - SCHED difference is supposed to indicate the level of
> > > host delay or host congestion. If the queuing in BT happens mostly =
in
> > > the device HW queue then it may make sense to generate SCHED when
> > > handing over to the driver. OTOH if the devices can coalesce or del=
ay
> > > completions the completion timeout may be less accurate than stampi=
ng
> > > before submitting to HW... I'm looking for the analysis that the ch=
oices
> > > were well thought thru.
> >
> > SCM_TSTAMP_SND is taken before an skb is passed to the device.
> > This matches request SOF_TIMESTAMPING_TX_SOFTWARE.
> >
> > A timestamp returned on transmit completion is requested as
> > SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a software
> > timestamp taken at tx completion cleaning. If anything, I would think=

> > it would be a passes as a hardware timestamp.
> =

> In that case I think we probably misinterpret it, at least I though
> that TX_HARDWARE would really be a hardware generated timestamp using
> it own clock

It normally is. It is just read from the tx descriptor on completion.

We really don't have a good model for a software timestamp taken at
completion processing.

It may be worthwhile more broadly, especially for devices that do not
support true hardware timestamps.

Perhaps we should add an SCM_TSTAMP_TXCOMPLETION for this case. And a
new SOF_TIMESTAMPING option to go with it. Similar to what we did for
SCM_STAMP_SCHED.

> if you are saying that TX_HARDWARE is just marking the
> TX completion of the packet at the host then we can definitely align
> with the current exception, that said we do have a command to actually
> read out the actual timestamp from the BT controller, that is usually
> more precise since some of the connection do require usec precision
> which is something that can get skew by the processing of HCI events
> themselves, well I guess we use that if the controller supports it and
> if it doesn't then we do based on the host timestamp when processing
> the HCI event indicating the completion of the transmission.
> =

> > Returning SCHED when queuing to a device and SND later on receiving
> > completions seems like not following SO_TIMESTAMPING convention to me=
.
> > But I don't fully know the HCI model.
> >
> > As for the "experimental" BT_POLL_ERRQUEUE. This is an addition to th=
e
> > ABI, right? So immutable. Is it fair to call that experimental?
> =

> I guess you are referring to the fact that sockopt ID reserved to
> BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usage in
> the future, yes that is correct, but we can actually return
> ENOPROTOOPT as it current does:
> =

>         if (!bt_poll_errqueue_enabled())
>             return -ENOPROTOOPT

I see. Once applications rely on a feature, it can be hard to actually
deprecate. But in this case it may be possible.

> Anyway I would be really happy to drop it so we don't have to worry
> about it later.
> =

> > It might be safer to only suppress the sk_error_report in
> > sock_queue_err_skb. Or at least in bt_sock_poll to check the type of
> > all outstanding errors and only suppress if all are timestamps.
> =

> Or perhaps we could actually do that via poll/epoll directly? Not that
> it would make it much simpler since the library tends to wrap the
> usage of poll/epoll but POLLERR meaning both errors or errqueue events
> is sort of the problem we are trying to figure out how to process them
> separately.

The process would still be awoken, of course. If bluetoothd can just
be modified to ignore the reports, that would indeed be easiest from
a kernel PoV.


> -- =

> Luiz Augusto von Dentz



