Return-Path: <netdev+bounces-96238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264B48C4B0A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB201F21D58
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AEB1C36;
	Tue, 14 May 2024 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRL91vMd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05337E;
	Tue, 14 May 2024 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715652088; cv=none; b=sknbstoIJ2j2PantAc+KbrdPGM5sLsFSvRmJkqKpkiRSfI/JCWeDfDoCr22UGVu7ALtemV0eduxnS5V566kCjhthFhhS4mq1eC0ZsyspR8GxfQf25C6noYzaew1wJqqwTM49W5LTbUgXTMwAVmDjjPgPX6W5FpDW7c4FsDs6IyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715652088; c=relaxed/simple;
	bh=P4266udIk1kTA9hr9/NWp2eRfavDEJtZUKiIJP3fKac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTxMmuDxDhUcm9F9AAWA12V2HcdFcyisS5OamfZZYKZfcRI5EZ1nS7SMYDuy7yBsOLbjNwC+O/h1+Yo1jQVC/YAr7XFAWJLrEaiwdYaIvkG1qN1Uy7D3hrEMA5Vfi71BVV5QiDT/X8sSwC0zhaygg5d6TfVhroDsVNyLvGWiR8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRL91vMd; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so39611241fa.1;
        Mon, 13 May 2024 19:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715652085; x=1716256885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBIbT1+z/UG8r876DsuaiHGNkQ3y0jDhRxoR140bF/A=;
        b=eRL91vMdqaf7iM9chmVZ45O6VGsUFNghUyPBiuLKYvHBqAZm/byyhcG+9AKNTInuoZ
         pdhC/ibgEcEkm19N6O3b3O69wGO7Sp7prsvKeORIaZ9RQcWEV/04ZfFQQSUJ1IXMvdlP
         dYqoR5BNfowSJRWZpSdQ2nkv7O9NWE0hZMHkyK0oPXuzXauLT5DpAWDKjnSgo7wonM/q
         7cT+8MQDxSAoJq4oCJEr9+JvF0L8G4xfBPg8GaYyBzoy8yj7LCPuED7mGQRo/w14geev
         ZrzwZ5B1Em5z0XsGYQBkNKRgZDcHmhlPbhcvU8ylk6pUoP9H42lBmpNK5I2VxRHCSEpU
         CPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715652085; x=1716256885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBIbT1+z/UG8r876DsuaiHGNkQ3y0jDhRxoR140bF/A=;
        b=a5a7rRj5EAOQqXKnHfNpgwIQKPvyBaD1cYot3oTywuHqua6A7q8icFuENn+g4UV71t
         FiLZcH/shMf4OtenLCGFsrnShcT2XsCiTZLgU9/A8mBXE4fgjuZ0tAYvuUroJ9x979TH
         R9e4kobss4FUDy4q4YjBvhrO82WwiDWcakGnCAFHhMPrsmIKYr9SOBbLPSbZwLezTk4x
         EgyX/hzIR23PtfM5hkVGRBe2eynChHiyw5m4I5o1mJbGKDmk15EL015NG8/DJKMM+dtV
         F5enEEc1kGOCiwN25Y8Vg4hEJJ4rpC0HPaMiVFNQMYf0O8SwyrDJzpatDkWi9SAN9dx+
         dgkw==
X-Forwarded-Encrypted: i=1; AJvYcCUly1VonvGDjHAD1TMXde9vwSTLV5gk55ZZ1ivS+IcxaKrMiPToZIp5FRIFLiaNpPQKroN1SYRXNIw/UgozDa3D/2lzII133wbEZYDu0nbGQzDIqAoVA9e7/6u4PIfSeCCiOxldp64X
X-Gm-Message-State: AOJu0YzaHxN7cSLkBr54gMLKEDEgwTtJIPzKA+wb6ZFdcQUu15Xr5J9g
	GESCoXkr3QTr/c+M1/G004dh4CwGVY1z7lRb5jNq9hqQIOLHwbdsr4Eqr+75dguwNcfUx9GB+VE
	3xomfbYOYnDHSQbc8wJmUJWTSOpI=
X-Google-Smtp-Source: AGHT+IET7ta6lBI99PQq3TaG4ZO+dxRteM5+ujR/OkvBGtDyjuyQ8IvKOKYvXdgnzciRonA7ecwJYpMDk3HHZ77tlB0=
X-Received: by 2002:a2e:b618:0:b0:2da:50f8:dfab with SMTP id
 38308e7fff4ca-2e51fd4a80bmr66233941fa.7.1715652084535; Mon, 13 May 2024
 19:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org> <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org> <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 May 2024 22:01:12 -0400
Message-ID: <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

On Mon, May 13, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote:
> > > > There is one more warning in the Intel driver:
> > > >
> > > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'causes_li=
st'
> > > > was not declared. Should it be static?
> > >
> > > We have a fix for that but I was hoping to have it in before the merg=
e
> > > window and then have the fix merged later.
> > >
> > > > It'd also be great to get an ACK from someone familiar with the soc=
ket
> > > > time stamping (Willem?) I'm not sure there's sufficient detail in t=
he
> > > > commit message to explain the choices to:
> > > >  - change the definition of SCHED / SEND to mean queued / completed=
,
> > > >    while for Ethernet they mean queued to qdisc, queued to HW.
> > >
> > > hmm I thought this was hardware specific, it obviously won't work
> > > exactly as Ethernet since it is a completely different protocol stack=
,
> > > or are you suggesting we need other definitions for things like TX
> > > completed?
> >
> > I don't know anything about queuing in BT, in terms of timestamping
> > the SEND - SCHED difference is supposed to indicate the level of
> > host delay or host congestion. If the queuing in BT happens mostly in
> > the device HW queue then it may make sense to generate SCHED when
> > handing over to the driver. OTOH if the devices can coalesce or delay
> > completions the completion timeout may be less accurate than stamping
> > before submitting to HW... I'm looking for the analysis that the choice=
s
> > were well thought thru.
>
> SCM_TSTAMP_SND is taken before an skb is passed to the device.
> This matches request SOF_TIMESTAMPING_TX_SOFTWARE.
>
> A timestamp returned on transmit completion is requested as
> SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a software
> timestamp taken at tx completion cleaning. If anything, I would think
> it would be a passes as a hardware timestamp.

In that case I think we probably misinterpret it, at least I though
that TX_HARDWARE would really be a hardware generated timestamp using
it own clock, if you are saying that TX_HARDWARE is just marking the
TX completion of the packet at the host then we can definitely align
with the current exception, that said we do have a command to actually
read out the actual timestamp from the BT controller, that is usually
more precise since some of the connection do require usec precision
which is something that can get skew by the processing of HCI events
themselves, well I guess we use that if the controller supports it and
if it doesn't then we do based on the host timestamp when processing
the HCI event indicating the completion of the transmission.

> Returning SCHED when queuing to a device and SND later on receiving
> completions seems like not following SO_TIMESTAMPING convention to me.
> But I don't fully know the HCI model.
>
> As for the "experimental" BT_POLL_ERRQUEUE. This is an addition to the
> ABI, right? So immutable. Is it fair to call that experimental?

I guess you are referring to the fact that sockopt ID reserved to
BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usage in
the future, yes that is correct, but we can actually return
ENOPROTOOPT as it current does:

        if (!bt_poll_errqueue_enabled())
            return -ENOPROTOOPT

Anyway I would be really happy to drop it so we don't have to worry
about it later.

> It might be safer to only suppress the sk_error_report in
> sock_queue_err_skb. Or at least in bt_sock_poll to check the type of
> all outstanding errors and only suppress if all are timestamps.

Or perhaps we could actually do that via poll/epoll directly? Not that
it would make it much simpler since the library tends to wrap the
usage of poll/epoll but POLLERR meaning both errors or errqueue events
is sort of the problem we are trying to figure out how to process them
separately.

--=20
Luiz Augusto von Dentz

