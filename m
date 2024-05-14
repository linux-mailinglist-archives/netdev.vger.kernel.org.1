Return-Path: <netdev+bounces-96234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA738C4AEE
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08E71C2168F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39A17FF;
	Tue, 14 May 2024 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHlUJsDu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAB84687;
	Tue, 14 May 2024 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650493; cv=none; b=cppg+VE2DzH6ZomWn8aGzBTa21XyEFKqkY5Ih1QRNuPxASNvL0rIWXBaHZrCUPS1+wY48BLV6VPcuwQ0Buz7lqqjS80vpx+o+6vL+Oe0mBCUBmeCM5sNiP3SeCrL7AhOjlPiy11xsbBt2ckVEuXSd0zlf+f1EWX0lVD1hzzWpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650493; c=relaxed/simple;
	bh=pVg1/5LwDa9KXKWdD1LgDIhN1ENnbY0DYPcYZcjN9lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsavbgNygCZA4M+anWrbheAZxwACdR1x5geR+z5T7sUkJewahDluGRpHY2CyN8U8bjJ+npQ6pseJV3arR1iyWJFMXPsqNsolRbCC3F8zURuFgUa5+UtehDZB/BejT0xqD2CsqOcSohvNobg5J3NtWmCjm7E49s+G/FzFQmwmGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHlUJsDu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2df848f9325so63903021fa.1;
        Mon, 13 May 2024 18:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715650490; x=1716255290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZFoGSojiUtSfY0l+Ph7nDwh2lX0w7himJSw+QTL1IE=;
        b=QHlUJsDuk9nT1aiRjaFP+A+1VaANcCkFyHSQjCwbpF/d/hcdr9YV+UAlO37i5V0WOJ
         JljIjFhN0uFLGFleicpTt4loRWzvAEAv9jKk9DL1TeZMOIVg84IgGiOxjz65BaHNfw8z
         FwVoA3ZAZkLiPx95hm2S/QV62PytPqx26iVaELx/CJQXkLg6yI1ERUs4QtA98ipDvAeC
         jwi7l8IQIjrrfOXR7+79T+T1T/XaWYbTSmL7A2hf6etn3nr14bBcfuhy3T/kR5foe66x
         QH3hvLNpTSCOdJYgF/iQGgVmG+wwk7Plc4FvrECprs/HhYMmdkf4I2vzVdoLb8DjQ5EJ
         tHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715650490; x=1716255290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZFoGSojiUtSfY0l+Ph7nDwh2lX0w7himJSw+QTL1IE=;
        b=Vm/LVmmJWg7P+lDa+eKrsD91aM30qZpQ3hD1xmqI6BmOygqknRIGnrwNiXh3f3aMYI
         bBDMNHqUP/4PqaA49g77HLZ0jmjvJNah+66ujVY85LzB1dbSKALDe3YiX4TcxqcOD884
         42ofN2EmQ1Rk9Txp1tgpfceVsBdnM/0vjhCWtqN4S45iRGYK+8JLHp0P85A62jLd47lB
         +oh2J+alDQvAx0J9/v2/+nATFNDvzhGP4WmpxJ/HnxmFVbqxUiii4pEFvBzZcdM9aOTW
         l62MHUwNAFwFHjJ0zDRY8zR+t7ErfezPEh5/7DFeHlH4lJZzGsYWWlpc93v5XiNfilzx
         s79A==
X-Forwarded-Encrypted: i=1; AJvYcCVFusUhMyIiDZVbtPrX7fJ6mbHudNoTUiCHt/hxCbfTLSWVPhOl8FXCSxXL+daeEtLAjSlOvNT1QIhgsbvCk74lLsU99gRJov5jKWwHErF2yM5odtwFJMy4f/bXXF9VWFonoo3ppRRm
X-Gm-Message-State: AOJu0Ywx5iuHz27lGC2guBnpn8M23ON3uXdu31wkaNDupWgXbXftQlZ1
	8VNY8s+W/6yP245H/RfoKbu9u6Cu3SocJDwbBusFmo5Mz7AUXIQZP5hUGkEESEqgvf3Um14g2N6
	TyH7DywAzRomqe2qBcLo1ZwKCA4M=
X-Google-Smtp-Source: AGHT+IELQqDmfaqzd8KDsvs1lF19V+2G8nOcnSmIv9xVA7zu1xNA068Qe9cZi3YvWhaOw8gWHWe+WAMf/ijHLcfmXYE=
X-Received: by 2002:a05:651c:2116:b0:2df:6fd5:1475 with SMTP id
 38308e7fff4ca-2e51ff4eb08mr98871371fa.28.1715650489402; Mon, 13 May 2024
 18:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
 <20240513142641.0d721b18@kernel.org> <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
 <20240513154332.16e4e259@kernel.org>
In-Reply-To: <20240513154332.16e4e259@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 May 2024 21:34:36 -0400
Message-ID: <CABBYNZJqwGo6VmTsSHFveRLy7pYQ0PJ+4X_aaL9r5if0dyqf6A@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, May 13, 2024 at 6:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote:
> > > There is one more warning in the Intel driver:
> > >
> > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'causes_list=
'
> > > was not declared. Should it be static?
> >
> > We have a fix for that but I was hoping to have it in before the merge
> > window and then have the fix merged later.
> >
> > > It'd also be great to get an ACK from someone familiar with the socke=
t
> > > time stamping (Willem?) I'm not sure there's sufficient detail in the
> > > commit message to explain the choices to:
> > >  - change the definition of SCHED / SEND to mean queued / completed,
> > >    while for Ethernet they mean queued to qdisc, queued to HW.
> >
> > hmm I thought this was hardware specific, it obviously won't work
> > exactly as Ethernet since it is a completely different protocol stack,
> > or are you suggesting we need other definitions for things like TX
> > completed?
>
> I don't know anything about queuing in BT, in terms of timestamping
> the SEND - SCHED difference is supposed to indicate the level of
> host delay or host congestion. If the queuing in BT happens mostly in
> the device HW queue then it may make sense to generate SCHED when
> handing over to the driver. OTOH if the devices can coalesce or delay
> completions the completion timeout may be less accurate than stamping
> before submitting to HW... I'm looking for the analysis that the choices
> were well thought thru.

I guess you want to know if is SCHED is done at enqueing (before
submitting to the driver) or dequeing (after it has been submitted),
right now it is the former, the said the driver should normally just
submit the packets immediately since we do have events from HCI to
informing when a buffer has been freed, so that tells HW queue
situation, so the driver doesn't have any queueing.

> > >    How does it compare to stamping in the driver in terms of accuracy=
?
> >
> > @Pauli any input here?
> >
> > >  - the "experimental" BT_POLL_ERRQUEUE, how does the user space look?
> >
> > There are test cases in BlueZ:
> >
> > https://github.com/bluez/bluez/commit/141f66411ca488e26bdd64e6f858ffa19=
0395d23
> >
> > >    What is the "upper layer"? What does it mean for kernel uAPI to be
> > >    "experimental"? When does the "upper layer" get to run and how doe=
s
> > >    it know that there are time stamps on the error queue?
> >
> > The socketopt only gets enabled with use of MGMT Set Experimental
> > Feature Command:
> >
> > https://github.com/bluez/bluez/blob/master/doc/mgmt-api.txt#L3205
> >
> > Anyway you can see on the tests how we are using it.
>
> Either I didn't grok the test or it doesn't answer my question.
> What is the lower layer that we want to "protect" from POLLERR?

This is more or less explained on the cover letter:

https://lore.kernel.org/linux-bluetooth/713b1d0333eb2f12e63bc8a7b8f423e1240=
abae0.camel@iki.fi/T/

The problem with POLLERR is that there are 2 processes (bluetoothd and
pipewire) monitoring the same file descriptor, so it will keep waking
up both processes to process the errqueue while only one is really
reading those events (pipewire), bluetoothd is only really monitoring
the sockets to know if there is a disconnection but it can't really
process the errqueue otherwise pipewire would compete reading from the
same queue. Anyway I wasn't sure  this was the best approach thus we
decided to go with something experimental until we have a better
understanding how all of this should work.

--=20
Luiz Augusto von Dentz

