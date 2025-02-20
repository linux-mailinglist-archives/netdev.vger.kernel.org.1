Return-Path: <netdev+bounces-168324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F8A3E83E
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCAA188C806
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4FB266192;
	Thu, 20 Feb 2025 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlxp7dEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E9266B72;
	Thu, 20 Feb 2025 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093584; cv=none; b=pjT2HnYwi0Rh6QxrO6wKNN3m0EGGZ+NSM8vQ3ZYOvambWw+nGcPDBoAnduD6wFlO0SbKIeMfb/4W1IIzMhpZ3+hWCgzX/SZIEd5jVWDKBdOKXsh4uBYRCTF/afpX3H9ogX7inicroNpf04GmvLZfhVvEgm7FEn0waRM4PUOC7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093584; c=relaxed/simple;
	bh=TWGs/K4wKLtD2SLkheis6/+gZzVhnhpvBNBEymNM8W0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nR2eWom7096toWU5+Z+q/PqvZy+9/kVaaRhUoT8vWf8rigCErCRKCkGEDFBnXhC/B/HnY45QCwwBnRmJpLbrXw74Mr3LiXygQi0ufaqUbC+BGHkMxHui/zdNkehLYia5P59MfknL6Rs3rRIzTTV3zuKur5ArkUWcnYjA0aEqTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlxp7dEG; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0c5682c41so81005085a.2;
        Thu, 20 Feb 2025 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740093582; x=1740698382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vtm5c20sZxBO6gWOMijL+8GxrfYrKDreGU7AJ8SoFw=;
        b=Tlxp7dEGot/ThQk+QovIhR592EugOEgH2EoEmGo4KfolMqm9lpeidiAI7nbBsInwU8
         gVD+03Levp25j75RaO/Ltbnse9MQ8LKqzyjE8sm94fgtqBI8UrA+bmNX4HOAKOG3ufOC
         HcsfMHOApkgWtMoqNYc1RGcyPr87ef0RzhMBjE24zORmFOxsQw9L6kkyqauzNJ7NMynj
         jTqQpRb8IJC5URlsx3moJZ8tRAofTcW4PKM9Fm1Rmi3/Vx+hHrLoo+5Z5VpCCs2d6Fg9
         PWhpkpmSOSOouNb9Y5Q1qpb5sJfr3OrjacgENrK0XVrT+wLJBEMsn9LfTDw6Vnrw4ozq
         K/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740093582; x=1740698382;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Vtm5c20sZxBO6gWOMijL+8GxrfYrKDreGU7AJ8SoFw=;
        b=ep16H9phmbVbOQf1QKBL+tZt95pJZJiQSx4X+ruGKHnNCzx7khcfO5++O9MiKK+2Pp
         tZjL669vyoXC4Yu6OCT3SQp/9sDDnqrNGe7B+sxJQk3pFh/dmNKsXSUraE9y63RcVDV6
         x8tNn2XxkYHHmxkZy5UnDMR7rv7u6U72AORFpv9eGt0o8Z0dmkfB9YDV6EJ0jMuUa21y
         Mt9cy+SjFeBrdpRMfwKNFTazWg3HZ2C6U3JNAkcwFMYDLMOlMKjO/qWsBJ8Uid4ovlDi
         7ZwSQEhopuSdYTw5ikopTploXCGLb19FuAfTRwBWZqM3PDN3z4XKZzAG3uPlbwbJuQ8z
         cThQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPfCK+0dWwypYZJ4tevA24qMK8lwF4L+EMhyX2oDPAPyymYt4R7is++GYX4RatBk8Mc95rVDt8L0IiPu15Utc=@vger.kernel.org, AJvYcCXRa8uBqEw46aqVT4WDctiyqPnEM5zPe8fgffJVbBwziBkOc01dGDSn1LTw33WcHnoOpr7e6S8s@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCLCr5VsY0HAIO3lf1ypTrXsmCAU0I/QkDGbuPo/33OQpZoKz
	3p/o9KBDNrQ2mLN9Ev1ROk5nAySFbJfOegr0raFSoGAEyhvzgxKL
X-Gm-Gg: ASbGncsx65kqPy4xIJ8Z/163XDNTuTU3bGs25ahMWtQgWE0GTIuqngW+tr+jIeKSZKv
	BvqCplrTvCh99eKyPJgXjd1q5WvOBoc4cc3k4eK7h1ykmb69jMREPBrU9zYoKlDbNJHrzUXYWSO
	uYP1JHqz44+x9Qkq69Ye9voQGgsLTLcHmBP2MivSp8dKskL/ahjZ8zcgZFdm20Ly4l/aE+TdF3i
	8yQ983VXdQH9N2vmaPB1kX3PImGhwSKWmPAd8UWa3JEmBVajNxv576rsc4tskJH6ifzLw02rp8d
	7DXWkk2b/sFQk4RCcL+SCg0TZAHMz/UfekteR7elFU+RbBMsoPG0FgE7KSCi8nM=
X-Google-Smtp-Source: AGHT+IHmLkngWYNIu2ii8H5nd/WWRDiujVd5OQkCUV801fHA3nmz+VUVnaFpBWDNReEHieZhKNgbbw==
X-Received: by 2002:a05:620a:880f:b0:7c0:b685:1bba with SMTP id af79cd13be357-7c0cf8cd09fmr82272085a.19.1740093581627;
        Thu, 20 Feb 2025 15:19:41 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0aaee775asm412430485a.66.2025.02.20.15.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:19:40 -0800 (PST)
Date: Thu, 20 Feb 2025 18:19:40 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 gerhard@engleder-embedded.com
Message-ID: <67b7b88c60ea0_292289294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b74c47c14c7_261ab62943@willemb.c.googlers.com.notmuch>
References: <cover.1739988644.git.pav@iki.fi>
 <b278a4f39101282e2d920fed482b914d23ffaac3.1739988644.git.pav@iki.fi>
 <CAL+tcoBxtxCT1R8pPFF2NvDv=1PKris1Gzg-acfKHN9qHr7RFA@mail.gmail.com>
 <67b694f08332c_20efb029434@willemb.c.googlers.com.notmuch>
 <CAL+tcoDJAYDce6Ud49q1+srq-wJ=04JxMm1w-Yzcdd1FGE3U7g@mail.gmail.com>
 <67b74c47c14c7_261ab62943@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH v4 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn wrote:
> Jason Xing wrote:
> > On Thu, Feb 20, 2025 at 10:35=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.f=
i> wrote:
> > > > >
> > > > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software t=
imestamp
> > > > > when hardware reports a packet completed.
> > > > >
> > > > > Completion tstamp is useful for Bluetooth, as hardware timestam=
ps do not
> > > > > exist in the HCI specification except for ISO packets, and the =
hardware
> > > > > has a queue where packets may wait.  In this case the software =
SND
> > > > > timestamp only reflects the kernel-side part of the total laten=
cy
> > > > > (usually small) and queue length (usually 0 unless HW buffers
> > > > > congested), whereas the completion report time is more informat=
ive of
> > > > > the true latency.
> > > > >
> > > > > It may also be useful in other cases where HW TX timestamps can=
not be
> > > > > obtained and user wants to estimate an upper bound to when the =
TX
> > > > > probably happened.
> > > > >
> > > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     v4: changed SOF_TIMESTAMPING_TX_COMPLETION to only emit COM=
PLETION
> > > > >         together with SND, to save a bit in skb_shared_info.tx_=
flags
> > > > >
> > > > >         As it then cannot be set per-skb, reject setting it via=
 CMSG.
> > > > >
> > > > >  Documentation/networking/timestamping.rst | 9 +++++++++
> > > > >  include/uapi/linux/errqueue.h             | 1 +
> > > > >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> > > > >  net/core/sock.c                           | 2 ++
> > > > >  net/ethtool/common.c                      | 1 +
> > > > >  5 files changed, 17 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/networking/timestamping.rst b/Docume=
ntation/networking/timestamping.rst
> > > > > index 61ef9da10e28..5034dfe326c0 100644
> > > > > --- a/Documentation/networking/timestamping.rst
> > > > > +++ b/Documentation/networking/timestamping.rst
> > > > > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> > > > >    cumulative acknowledgment. The mechanism ignores SACK and FA=
CK.
> > > > >    This flag can be enabled via both socket options and control=
 messages.
> > > > >
> > > > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > > > +  Request tx timestamps on packet tx completion, for the packe=
ts that
> > > > > +  also have SOF_TIMESTAMPING_TX_SOFTWARE enabled.  The complet=
ion
> > > >
> > > > Is it mandatory for other drivers that will try to use
> > > > SOF_TIMESTAMPING_TX_COMPLETION in the future? I can see you coupl=
ed
> > > > both of them in hci_conn_tx_queue in patch [2/5]. If so, it would=
 be
> > > > better if you add the limitation in sock_set_timestamping() so th=
at
> > > > the same rule can be applied to other drivers.
> > > >
> > > > But may I ask why you tried to couple them so tight in the versio=
n?
> > > > Could you say more about this? It's optional, right? IIUC, you
> > > > expected the driver to have both timestamps and then calculate th=
e
> > > > delta easily?
> > >
> > > This is a workaround around the limited number of bits available in=

> > > skb_shared_info.tx_flags.
> > =

> > Oh, I'm surprised I missed the point even though I revisited the
> > previous discussion.
> > =

> > Pauli, please add the limitation when users setsockopt in
> > sock_set_timestamping() :)
> > =

> > >
> > > Pauli could claim last available bit 7.. but then you would need to=

> > > find another bit for SKBTX_BPF ;)
> > =

> > Right :D
> > =

> > >
> > > FWIW I think we could probably free up 1 or 2 bits if we look close=
ly,
> > > e.g., of SKBTX_HW_TSTAMP_USE_CYCLES or SKBTX_WIFI_STATUS.
> > =

> > Good. Will you submit a patch series to do that, or...?
> =

> Reclaiming space is really up to whoever needs it.
> =

> I'll take a quick look, just to see if there is an obvious path and
> we can postpone this whole conversation to next time we need a bit.

SKBTX_HW_TSTAMP_USE_CYCLES is only true if SOF_TIMESTAMPING_BIND_PHC.
It cannot be set per cmsg (is not in SOF_TIMESTAMPING_TX_RECORD_MASK),
so no need to record it per skb.

It only has two drivers using it, which can easily be updated:

	-                if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_USE_CYC=
LES)
	+                if (skb->sk &&
	+                    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_P=
HC)
					tx_flags |=3D IGC_TX_FLAGS_TSTAMP_TIMER_1;

They later call skb_tstamp_tx, which does nothing if !skb->sk.
Only cost is a higher cost of accessing the sk cacheline.

SKBTX_WIFI_STATUS essentially follows the same argument. It can only
be set in the sockopt. It has a handful more callsites that would need
to be updated. sock_flag(sk, SOCK_WIFI_STATUS) will be tested without
the socket lock held. But this is already the case in the UDP lockless
fast path through ip_make_skb.

SKBTX_HW_TSTAMP_NETDEV is only used on Rx. Could shadow another bit
that is used only on Tx.

SKBTX_IN_PROGRESS is only used by the driver to suppress the software
tx timestamp from skb_tx_timestamp if a later hardware timestamp will
be generated. Predates SOF_TIMESTAMPING_OPT_TX_SWHW.

In short plenty of bits we can reclaim if we try.

SKBTX_BPF was just merged, so we will have to reclaim one. The first
one seems most straightforward.=

