Return-Path: <netdev+bounces-163251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7427DA29B5F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B0316490A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE8211A11;
	Wed,  5 Feb 2025 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB6fOlbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356D213E6F;
	Wed,  5 Feb 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738788271; cv=none; b=Oe9qHnHgLiNVKcLCwQQ8IQrtYSxd5mhulrWdwhYvA5WpQhK2fzBRFSLVy2LkH09g5NLYoGH+yypFuHBgM1h/BHa64gScsab9s/aek3uZJJwK18+s8yMxIsi7vzhX2APUHSROe+lRhIaoDky8oT7hNjK2+kocuGxq1zkAfheP6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738788271; c=relaxed/simple;
	bh=qndMxOxxKnWdqM+a76uSzfPJrjVl/Y2O9vYoT7Jkp8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC9DKUaa7dkGg3whC9LGgWLcJfPdYPkn3PQ25+AhImgguQ2bA6qWHNz4xP7dTQJVt19vzvNtysfJGuXudrZ84zpNiAuzW9dznB4qSHzuX0lSl046Y/7g8COFPzHx7pRwRV2YctUFQ2i4tmKmkolpKwHOq4DU/3gYCyGi7FxI+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB6fOlbR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a6bso2507121fa.1;
        Wed, 05 Feb 2025 12:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738788267; x=1739393067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvrfykdpYpDVeCEk9xmycfb3t9zq+3KjroqLcl0Nsmk=;
        b=VB6fOlbRqYFHacim7da9gX8Z1cC7JtNw77lzPBK6203VHcSPpkAOyDXr30GQajhP3w
         D9Gd0Set32rpdpygxiQ97SuPFbHESrUZ4dDJqNQMLr4HFjphcoYNL9dDWUrqOoMvlKsg
         sUNrwmdDHY3RWiBm0lIZRfXQQeM+PQIj7/DQ+tqEyeD2wTx/di2fjptIXxlcbOHVf64A
         DTVYCWpPnDDeQhRoaSylNYscSB82U18V7itbNhLeMMFO/OBjTRG53qL+0ZhAaDCRu2Q2
         Y6yB1XeOKv0uo6KfZJe7afrYWZLbyrbSFHWMGouxnXWISb/xYHhLV6UvXjoNCR4SY2z1
         AlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738788267; x=1739393067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvrfykdpYpDVeCEk9xmycfb3t9zq+3KjroqLcl0Nsmk=;
        b=g2i/ytdC1rYrc5lr1ZFf8TwdQVhj1X7NLdNyYN/pVEymq6btPW0VZWdtzpOOG/2TTJ
         rz1z4byS7xcNDTc5PPFWJ13SDSTa3p67b4VmNmfE+NRZCY4zRI0KF44TKpiOYO6DTb6P
         O5O9/C/aSBrw3UIUW5HGzLKbYHCVNckUTPzyDg19h0Jw1T82SrOa1RBYriJreUsXdRdK
         t0a4ppEZ+xmHky0JUO+QK8iAh+goxUf+V4WkUF81OPpMHIbP6iMTqEVgT2b/Oq1gZer3
         5vNBWXbqoLGXommUT7M/gJwG84I8I1DIcfybXxzpsxGAuXdrh8NqSXR0sJhFJKsOS+GU
         pDCA==
X-Forwarded-Encrypted: i=1; AJvYcCVCed/FgrNd7r60OOa1KYEkiAOj54PfhIf/w1NQhXokR/npkBkWBZrPgGtgw3DjyHxbNg8x8R/5@vger.kernel.org, AJvYcCWcP0E5JkgvXJPxR214/Z562e35OVUM0En3gdpqwwDiZFgebjmxvBKr6kvC4vQ3BYPtMSkjyTQ7BHMHYVaS034=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtWlccdiMDlVAROVnkp+vO4apsVr8bzYrigqMqVui0c9WWknZ
	5aeNSul0kdIqzr+TngvWMPY91aZSbVARzbXtmeUr8OghzyOTeWYnJZO849IkYkmKpjKVMDaqWU5
	1zwmd++vLH/zrgHR1EsMClkroJmMj7mXC4Fw=
X-Gm-Gg: ASbGnct6MXUghTcxUfM6i6WawCEmBwFMFJuRGJTP/ZDmQibsyOcw4YVK4TXc2EFUXv1
	kNWqsu71KYYfvESf1avchhQi/OmvLOx0J2VHagJB4k5oH/a8QKKF8mzUS90qjqzbHRUUCmLI=
X-Google-Smtp-Source: AGHT+IHoqtoKEtMzLhXP4arPjZ3ZeRtCF+ck+k+3imvOlGeTZvO5XyttLKybl8oTstqezeT/wBy1HYGxnoxU8oAFo0M=
X-Received: by 2002:a2e:bc0d:0:b0:306:59:58fc with SMTP id 38308e7fff4ca-307cf382a98mr15223781fa.30.1738788267000;
 Wed, 05 Feb 2025 12:44:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org> <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org> <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
 <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
 <7ade362f178297751e8a0846e0342d5086623edc.camel@iki.fi> <6643b02a4668e_2225c7294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <6643b02a4668e_2225c7294a0@willemb.c.googlers.com.notmuch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Feb 2025 15:44:14 -0500
X-Gm-Features: AWEUYZnbsE0KORzZddDECG9qfELbat31SdXwSujDlvmj6mQTnF6FmSbYJ1LzDZM
Message-ID: <CABBYNZ+9D-jSyTsRvzRReHE4enfv6DP=Pr4uZCaLdY3-4D6AHg@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, May 14, 2024 at 2:40=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Pauli Virtanen wrote:
> > Hi all,
> >
> > Thanks for the comments, I guess the original series should have been
> > Cc'd more widely to get them earlier.
> >
> > ma, 2024-05-13 kello 22:09 -0400, Willem de Bruijn kirjoitti:
> > > Luiz Augusto von Dentz wrote:
> > > > Hi Willem,
> > > >
> > > > On Mon, May 13, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jakub Kicinski wrote:
> > > > > > On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote=
:
> > > > > > > > There is one more warning in the Intel driver:
> > > > > > > >
> > > > > > > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'c=
auses_list'
> > > > > > > > was not declared. Should it be static?
> > > > > > >
> > > > > > > We have a fix for that but I was hoping to have it in before =
the merge
> > > > > > > window and then have the fix merged later.
> > > > > > >
> > > > > > > > It'd also be great to get an ACK from someone familiar with=
 the socket
> > > > > > > > time stamping (Willem?) I'm not sure there's sufficient det=
ail in the
> > > > > > > > commit message to explain the choices to:
> > > > > > > >  - change the definition of SCHED / SEND to mean queued / c=
ompleted,
> > > > > > > >    while for Ethernet they mean queued to qdisc, queued to =
HW.
> > > > > > >
> > > > > > > hmm I thought this was hardware specific, it obviously won't =
work
> > > > > > > exactly as Ethernet since it is a completely different protoc=
ol stack,
> > > > > > > or are you suggesting we need other definitions for things li=
ke TX
> > > > > > > completed?
> > > > > >
> > > > > > I don't know anything about queuing in BT, in terms of timestam=
ping
> > > > > > the SEND - SCHED difference is supposed to indicate the level o=
f
> > > > > > host delay or host congestion. If the queuing in BT happens mos=
tly in
> > > > > > the device HW queue then it may make sense to generate SCHED wh=
en
> > > > > > handing over to the driver. OTOH if the devices can coalesce or=
 delay
> > > > > > completions the completion timeout may be less accurate than st=
amping
> > > > > > before submitting to HW... I'm looking for the analysis that th=
e choices
> > > > > > were well thought thru.
> > > > >
> > > > > SCM_TSTAMP_SND is taken before an skb is passed to the device.
> > > > > This matches request SOF_TIMESTAMPING_TX_SOFTWARE.
> > > > >
> > > > > A timestamp returned on transmit completion is requested as
> > > > > SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a softwar=
e
> > > > > timestamp taken at tx completion cleaning. If anything, I would t=
hink
> > > > > it would be a passes as a hardware timestamp.
> > > >
> > > > In that case I think we probably misinterpret it, at least I though
> > > > that TX_HARDWARE would really be a hardware generated timestamp usi=
ng
> > > > it own clock
> > >
> > > It normally is. It is just read from the tx descriptor on completion.
> > >
> > > We really don't have a good model for a software timestamp taken at
> > > completion processing.
> > >
> > > It may be worthwhile more broadly, especially for devices that do not
> > > support true hardware timestamps.
> > >
> > > Perhaps we should add an SCM_TSTAMP_TXCOMPLETION for this case. And a
> > > new SOF_TIMESTAMPING option to go with it. Similar to what we did for
> > > SCM_STAMP_SCHED.
> >
> > Ok, I was also under the impression TX_HARDWARE was only for actual HW
> > timestamps. TSTAMP_ACK appeared to not really match semantics either,
> > so TSTAMP_SND it then was.
> >
> >
> > The general timestamping flow here was:
> >
> > sendmsg() from user generates skbs to net/bluetooth side queue
> > |
> > * wait in net/bluetooth side queue until HW has free packet slot
> > |
> > * send to driver (-> SCM_TSTAMP_SCHED*)
> > |
> > * driver (usu. ASAP) queues to transport e.g. USB
> > |
> > * transport tx complete, skb freed
> > |
> > * packet waits in hardware-side buffers (usu. the largest delay)
> > |
> > * packet completion report from HW (-> SCM_TSTAMP_SND*)
> > |
> > * for one packet type, HW timestamp for last tx packet can queried
> >
> > The packet completion report does not imply the packet was received.
> >
> > From the above, I gather SCHED* should be SND, and SND* should be
> > TXCOMPLETION. Then I'm not sure when we should generate SCHED, if at
> > all, unless it's done more or less in sendmsg() when it generates the
> > skbs.
>
> Agreed. Missing SCHED if packets do not go through software queuing
> should be fine. Inversely, with multiple qdiscs processes see multiple
> SCHED events.
>
> > Possibly the SND timestamp could also be generated on driver side if
> > one wants to have it taken at transport tx completion. I don't
> > immediately know what is the use case would be though, as the packet
> > may still have to wait on HW side before it goes over the air.
> >
> > For the use case here, we want to know the total latency, so the
> > completion timestamp is the interesting one. In the audio use case, in
> > normal operation there is a free HW slot and packets do not wait in
> > net/bluetooth queues but end up in HW buffers ASAP (fast, maybe < 1
> > ms), and then wait a much longer time (usu. 5-50 ms) in the HW buffers
> > before it reports completion.
> >
> > > > if you are saying that TX_HARDWARE is just marking the
> > > > TX completion of the packet at the host then we can definitely alig=
n
> > > > with the current exception, that said we do have a command to actua=
lly
> > > > read out the actual timestamp from the BT controller, that is usual=
ly
> > > > more precise since some of the connection do require usec precision
> > > > which is something that can get skew by the processing of HCI event=
s
> > > > themselves, well I guess we use that if the controller supports it =
and
> > > > if it doesn't then we do based on the host timestamp when processin=
g
> > > > the HCI event indicating the completion of the transmission.
> > > >
> > > > > Returning SCHED when queuing to a device and SND later on receivi=
ng
> > > > > completions seems like not following SO_TIMESTAMPING convention t=
o me.
> > > > > But I don't fully know the HCI model.
> > > > >
> > > > > As for the "experimental" BT_POLL_ERRQUEUE. This is an addition t=
o the
> > > > > ABI, right? So immutable. Is it fair to call that experimental?
> > > >
> > > > I guess you are referring to the fact that sockopt ID reserved to
> > > > BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usage=
 in
> > > > the future, yes that is correct, but we can actually return
> > > > ENOPROTOOPT as it current does:
> > > >
> > > >         if (!bt_poll_errqueue_enabled())
> > > >             return -ENOPROTOOPT
> > >
> > > I see. Once applications rely on a feature, it can be hard to actuall=
y
> > > deprecate. But in this case it may be possible.
> > >
> > > > Anyway I would be really happy to drop it so we don't have to worry
> > > > about it later.
> > > >
> > > > > It might be safer to only suppress the sk_error_report in
> > > > > sock_queue_err_skb. Or at least in bt_sock_poll to check the type=
 of
> > > > > all outstanding errors and only suppress if all are timestamps.
> > > >
> > > > Or perhaps we could actually do that via poll/epoll directly? Not t=
hat
> > > > it would make it much simpler since the library tends to wrap the
> > > > usage of poll/epoll but POLLERR meaning both errors or errqueue eve=
nts
> > > > is sort of the problem we are trying to figure out how to process t=
hem
> > > > separately.
> > >
> > > The process would still be awoken, of course. If bluetoothd can just
> > > be modified to ignore the reports, that would indeed be easiest from
> > > a kernel PoV.
> >
> > This can be done on bluetoothd side, the ugly part is just the wakeup
> > on every TX timestamp, which is every ~10ms in these use cases if every
> > packet is stamped. EPOLLET probably would indeed avoid busy looping on
> > the same timestamp though.
> >
> > In the first round of this patchset, this was handled on bluetoothd
> > side without kernel additions, with rate limiting the polling. If
> > POLL_ERRQUEUE sounds like a bad idea, maybe we can go back to that.
>
> We have prior art to avoid having timestamp completions on
> MSG_ERRQUEUE set sk_err and so block normal processing.
>
> Additional work on opting out of timestamp/zerocopy wake-ups sounds
> reasonable to me.

Id like to follow-up on this, do you have any plans to continue on
this? In addition to synchronization Id also like to experiment
sending on TX complete kind of logic, instead of time based, or at
least I don't have a better way to attempt to synchronize the TX so I
assume if we keep feeding the controller whenever it has buffers
available it should be able to not miss any interval.

--=20
Luiz Augusto von Dentz

