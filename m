Return-Path: <netdev+bounces-96418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76008C5B38
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0004D1C216EA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85128180A79;
	Tue, 14 May 2024 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJpfq7qr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC053E15;
	Tue, 14 May 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712045; cv=none; b=XDWipH57yIT4MfcrMrGZvxrfbJEo/lwFVSKPEUvKHX18tyQcDceAF9uDf+rwT3bsZY3qs2hbh8OG0WKiyV3zqB02XZ1HiWQG+YFpQtTXTu8qipD/jnz4R0soqk6bGLDlKrsFUqmQ8M5Grvy41EjQssdFHBZS8FsDlGsN2M4UDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712045; c=relaxed/simple;
	bh=oHcbb/g3hbbdZs+n5OLyf9ODnhoz2rORoTCmNemLMlI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rig0inlpAHTsM3umCZuMiSD7bejOZVVJQiK547jDdagWtREgRgh+Wlp76DqRayG1QJeg6678Rt7Ej0RcVPrVFr4CF0rUcTNI4oH0AUnV/ufLFLJ1LY1n6BUpAlIJuoKIXQGCc8MqkKHfYzyB0D6Qg0bfF5GObFp8W09oHtB1dH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJpfq7qr; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c9963a2205so3007398b6e.2;
        Tue, 14 May 2024 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715712043; x=1716316843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYVv37Cb2rHIFfAh5rl3nrtOVh/HPxc6lLBjjhwArr0=;
        b=BJpfq7qrtn8NoWZuD/rCG52aFDkkN+d8rG5liduWD4VNjoxP5J5zLV/UrTbyJPFNTg
         AHl6AeGhUgcgEFxaHF82VneSWx0uctsOCE26UGl7gN3jDOnB7zdKTsAth36XF7WWm/gs
         YY1kSe/i/dJb+HSHkQ0dPuA+QA1vqX1pEszYfLHaDh9u//o0vSDPuTeeMQpHMIbVRNSp
         Xgg+jvp1AZCgcG5Uo33AehqgYz64IOTkHWSNjELdz7VjA9dSxuiY6fnW011DMX2ecajn
         XInwPvLhS+3duDf2uCmdhpmFDqybEasrUmJlqCcLPETqQS//kMUub6zmY3iHsRfXPUhw
         OuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715712043; x=1716316843;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYVv37Cb2rHIFfAh5rl3nrtOVh/HPxc6lLBjjhwArr0=;
        b=qW2InYBUaSEk3r/jpfjJC7LJaDam6tXVAyKee40+OqetFNPalQ89Mg7FK3nn7pYmrE
         Hah0fO9o8UdO+onMhACinhIsNRkL3xKGBp/iffXGrx7HIbVJl+ZRl8jNoxOL0XQ3wISO
         +94ZpM+M1C3V413Z2TfawQAlBqbd/MkydnO6FmKCEki77HrVBqlF8Il21/S7z19xvaYR
         1vrYO82ob1E2Y6pGGoRRrj+0VFAhayLqsBvX8vJ+DfhzvkQEE2CtUukN9tzKhvK5v4aq
         HVqIuWwoWCQovB2f45DqZrQwH2r9pJVvYZi7xV6/3PA9OU8oj36GutDKrZ5iH2VfyCcA
         c8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Fg9C0t1NYoQ5DOotzl1y3GzQ7LBXEPfEjEmHfBLWLq+mVrfD8EnudJLP55bKnyw+LfERW9mryhauBV7ps72EdR8hG+yW4PWzM3SsNU3CZTNPKYt/Q0sJYkN+tNodxoqRgN8Nhu4n
X-Gm-Message-State: AOJu0YwlcauL6FNSpn+9BAF7VblrgogiK3IIKGS4GG8WkZ5vfwF+vY8X
	YMIU86JFnLPBfnDrWlcHto6DS+T9YelsQyO75KFdRq9XVnqI+Brpf4Zo3g==
X-Google-Smtp-Source: AGHT+IHOadRFy6VmWEeBR2Un0QI3M8vr5jLXoo4w+6rmL/dMYYkqkjuR0bK8rqvEkyxWhDGU5HKL1g==
X-Received: by 2002:a05:6871:813:b0:23c:9f74:f6d4 with SMTP id 586e51a60fabf-24172f617ccmr16254189fac.52.1715712042814;
        Tue, 14 May 2024 11:40:42 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e12b42801sm36096921cf.55.2024.05.14.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 11:40:42 -0700 (PDT)
Date: Tue, 14 May 2024 14:40:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net, 
 linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <6643b02a4668e_2225c7294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <7ade362f178297751e8a0846e0342d5086623edc.camel@iki.fi>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org>
 <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org>
 <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
 <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
 <7ade362f178297751e8a0846e0342d5086623edc.camel@iki.fi>
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

Pauli Virtanen wrote:
> Hi all,
> =

> Thanks for the comments, I guess the original series should have been
> Cc'd more widely to get them earlier.
> =

> ma, 2024-05-13 kello 22:09 -0400, Willem de Bruijn kirjoitti:
> > Luiz Augusto von Dentz wrote:
> > > Hi Willem,
> > > =

> > > On Mon, May 13, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > =

> > > > Jakub Kicinski wrote:
> > > > > On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote=
:
> > > > > > > There is one more warning in the Intel driver:
> > > > > > > =

> > > > > > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'c=
auses_list'
> > > > > > > was not declared. Should it be static?
> > > > > > =

> > > > > > We have a fix for that but I was hoping to have it in before =
the merge
> > > > > > window and then have the fix merged later.
> > > > > > =

> > > > > > > It'd also be great to get an ACK from someone familiar with=
 the socket
> > > > > > > time stamping (Willem?) I'm not sure there's sufficient det=
ail in the
> > > > > > > commit message to explain the choices to:
> > > > > > >  - change the definition of SCHED / SEND to mean queued / c=
ompleted,
> > > > > > >    while for Ethernet they mean queued to qdisc, queued to =
HW.
> > > > > > =

> > > > > > hmm I thought this was hardware specific, it obviously won't =
work
> > > > > > exactly as Ethernet since it is a completely different protoc=
ol stack,
> > > > > > or are you suggesting we need other definitions for things li=
ke TX
> > > > > > completed?
> > > > > =

> > > > > I don't know anything about queuing in BT, in terms of timestam=
ping
> > > > > the SEND - SCHED difference is supposed to indicate the level o=
f
> > > > > host delay or host congestion. If the queuing in BT happens mos=
tly in
> > > > > the device HW queue then it may make sense to generate SCHED wh=
en
> > > > > handing over to the driver. OTOH if the devices can coalesce or=
 delay
> > > > > completions the completion timeout may be less accurate than st=
amping
> > > > > before submitting to HW... I'm looking for the analysis that th=
e choices
> > > > > were well thought thru.
> > > > =

> > > > SCM_TSTAMP_SND is taken before an skb is passed to the device.
> > > > This matches request SOF_TIMESTAMPING_TX_SOFTWARE.
> > > > =

> > > > A timestamp returned on transmit completion is requested as
> > > > SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a softwar=
e
> > > > timestamp taken at tx completion cleaning. If anything, I would t=
hink
> > > > it would be a passes as a hardware timestamp.
> > > =

> > > In that case I think we probably misinterpret it, at least I though=

> > > that TX_HARDWARE would really be a hardware generated timestamp usi=
ng
> > > it own clock
> > =

> > It normally is. It is just read from the tx descriptor on completion.=

> > =

> > We really don't have a good model for a software timestamp taken at
> > completion processing.
> > =

> > It may be worthwhile more broadly, especially for devices that do not=

> > support true hardware timestamps.
> > =

> > Perhaps we should add an SCM_TSTAMP_TXCOMPLETION for this case. And a=

> > new SOF_TIMESTAMPING option to go with it. Similar to what we did for=

> > SCM_STAMP_SCHED.
> =

> Ok, I was also under the impression TX_HARDWARE was only for actual HW
> timestamps. TSTAMP_ACK appeared to not really match semantics either,
> so TSTAMP_SND it then was.
> =

> =

> The general timestamping flow here was:
> =

> sendmsg() from user generates skbs to net/bluetooth side queue
> |
> * wait in net/bluetooth side queue until HW has free packet slot
> |
> * send to driver (-> SCM_TSTAMP_SCHED*)
> |
> * driver (usu. ASAP) queues to transport e.g. USB
> |
> * transport tx complete, skb freed
> |
> * packet waits in hardware-side buffers (usu. the largest delay)
> |
> * packet completion report from HW (-> SCM_TSTAMP_SND*)
> |
> * for one packet type, HW timestamp for last tx packet can queried
> =

> The packet completion report does not imply the packet was received.
> =

> From the above, I gather SCHED* should be SND, and SND* should be
> TXCOMPLETION. Then I'm not sure when we should generate SCHED, if at
> all, unless it's done more or less in sendmsg() when it generates the
> skbs.

Agreed. Missing SCHED if packets do not go through software queuing
should be fine. Inversely, with multiple qdiscs processes see multiple
SCHED events.

> Possibly the SND timestamp could also be generated on driver side if
> one wants to have it taken at transport tx completion. I don't
> immediately know what is the use case would be though, as the packet
> may still have to wait on HW side before it goes over the air.
> =

> For the use case here, we want to know the total latency, so the
> completion timestamp is the interesting one. In the audio use case, in
> normal operation there is a free HW slot and packets do not wait in
> net/bluetooth queues but end up in HW buffers ASAP (fast, maybe < 1
> ms), and then wait a much longer time (usu. 5-50 ms) in the HW buffers
> before it reports completion.
> =

> > > if you are saying that TX_HARDWARE is just marking the
> > > TX completion of the packet at the host then we can definitely alig=
n
> > > with the current exception, that said we do have a command to actua=
lly
> > > read out the actual timestamp from the BT controller, that is usual=
ly
> > > more precise since some of the connection do require usec precision=

> > > which is something that can get skew by the processing of HCI event=
s
> > > themselves, well I guess we use that if the controller supports it =
and
> > > if it doesn't then we do based on the host timestamp when processin=
g
> > > the HCI event indicating the completion of the transmission.
> > > =

> > > > Returning SCHED when queuing to a device and SND later on receivi=
ng
> > > > completions seems like not following SO_TIMESTAMPING convention t=
o me.
> > > > But I don't fully know the HCI model.
> > > > =

> > > > As for the "experimental" BT_POLL_ERRQUEUE. This is an addition t=
o the
> > > > ABI, right? So immutable. Is it fair to call that experimental?
> > > =

> > > I guess you are referring to the fact that sockopt ID reserved to
> > > BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usage=
 in
> > > the future, yes that is correct, but we can actually return
> > > ENOPROTOOPT as it current does:
> > > =

> > >         if (!bt_poll_errqueue_enabled())
> > >             return -ENOPROTOOPT
> > =

> > I see. Once applications rely on a feature, it can be hard to actuall=
y
> > deprecate. But in this case it may be possible.
> > =

> > > Anyway I would be really happy to drop it so we don't have to worry=

> > > about it later.
> > > =

> > > > It might be safer to only suppress the sk_error_report in
> > > > sock_queue_err_skb. Or at least in bt_sock_poll to check the type=
 of
> > > > all outstanding errors and only suppress if all are timestamps.
> > > =

> > > Or perhaps we could actually do that via poll/epoll directly? Not t=
hat
> > > it would make it much simpler since the library tends to wrap the
> > > usage of poll/epoll but POLLERR meaning both errors or errqueue eve=
nts
> > > is sort of the problem we are trying to figure out how to process t=
hem
> > > separately.
> > =

> > The process would still be awoken, of course. If bluetoothd can just
> > be modified to ignore the reports, that would indeed be easiest from
> > a kernel PoV.
> =

> This can be done on bluetoothd side, the ugly part is just the wakeup
> on every TX timestamp, which is every ~10ms in these use cases if every=

> packet is stamped. EPOLLET probably would indeed avoid busy looping on
> the same timestamp though.
> =

> In the first round of this patchset, this was handled on bluetoothd
> side without kernel additions, with rate limiting the polling. If
> POLL_ERRQUEUE sounds like a bad idea, maybe we can go back to that.

We have prior art to avoid having timestamp completions on
MSG_ERRQUEUE set sk_err and so block normal processing.

Additional work on opting out of timestamp/zerocopy wake-ups sounds
reasonable to me.=

