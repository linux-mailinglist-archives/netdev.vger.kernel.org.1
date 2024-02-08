Return-Path: <netdev+bounces-70374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4726584E955
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7095288FB8
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1A381D9;
	Thu,  8 Feb 2024 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="xnhMIqW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838413BB48
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422732; cv=none; b=iYNahGPOy1qbZEarEvrV8I2KlJwERcJn1tyrTXR0fttbDlrwNWVTXZq3R064KRMokZE2m6p0ZA3orKsHdktPJ/LQoFHsk3w5i2svkld4sDvLbo+73DqwHzOskcUcTCpt63vIcnS1acoIt3L8x4eJ2EJ1JqGEpQwz3qrbCPEkBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422732; c=relaxed/simple;
	bh=b0erufqngH0XANmygyhHky6T29fb/E3eZdVUw6EtyBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpdDdJU5pxyDJSe+UmNBHSkOXQGyuog62I8SSVQE4rNPqDvacq/c7NBTqvHNghDGJhTFhT2xZkzv7fOWyxFn9bkfdMw2dVeYi2vI62FCdoNQIjQdTfpz7eRXMKcZVdFA2kszN1Pz5NQVygz2EgMVLxWWFqvQm/GujKQ7A24OAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=xnhMIqW4; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so85062241.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1707422729; x=1708027529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+thI0GQWbgIZe2DVaHYcsRJiUher6NBYWQsaoiVRU88=;
        b=xnhMIqW4tPvUA+lL7dXU9gVTOW6Vr0+IuJeXRVPJ+zqzyroAEK0TNC7/JmG4gKkaB4
         ySUcxVKGsS6UbONMFdkVVgGrQIdxkBXyRiHY+j+BwML8ga2IDLyeMP0b64yjebL7HvYG
         xqUKlcmIZLkAHEXP4/3xWpNbDYPhNP/WMN1TDhOvNVRDUpm3/lklM8zpBiWHolMY9q+2
         c2sg1B6oNUUhH6bKVTJ3Q/1wBs2nXNrYV/iamIf5I0DfcbCUdIans8CoRNwTGdpwIG7n
         7EGtF9NQ75dN0K5W0LX/rYkAUym24/9/M7VGgSyChRwNmHuK2aHVb0p+m9kyBANhLuDZ
         O1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422729; x=1708027529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+thI0GQWbgIZe2DVaHYcsRJiUher6NBYWQsaoiVRU88=;
        b=wY8FPJQmbRmBOYr2SKhGNvRidSzu1uRcPQoCYjp+9MVOWaecGimp1Uql4/2HqxIpzN
         QHcVlI0yc3B2DCJHQofOyijV9IbOw0LntKkFSjKbupNudvY00tPfG4yO5TZs3Zm7sPxX
         AIB9rVbGhwCpQ84mEQ5KFAo11GsRBQUw5Y9j/dfdMZ17CV30lthvFCC4qsq3ccYqPImY
         ZZX3Sl3kZjl3BPiwmi+IDMa/+Wl8fbycrol69oVh88wGmYfAicFsiUjjf8RQG+mxmAHW
         eUsNBbPP2WGANbn6LGl/DLXYhNw/bn1uN10SjYj771wB+vx4Mi51DTYlsOk5cLrmiYKH
         QvUA==
X-Gm-Message-State: AOJu0YzxQLgFK+4VUZ35mM/cOrcj1yXDOeROzTeEJoDlTSFfW9DFRhwT
	yi1D5alHz0EJDKLqfYXDOPcfsyTElyTwWBO9R357mZ0cg7DyzXXMGkDi6BTzuiwDF6b335OHUDc
	9r7Q8E+y534ChHbCq65V8/ChhVVTP3NXG2c0L
X-Google-Smtp-Source: AGHT+IEy746WHk21qraZE/BX+JaDD0dhTMsgAML+3tVh1nWKxMJefgCoVaVU7r/ZHaGBUA1+FqeRuPHA1vyrcNkJX1g=
X-Received: by 2002:a1f:eb01:0:b0:4c0:1918:27de with SMTP id
 j1-20020a1feb01000000b004c0191827demr582960vkh.16.1707422729328; Thu, 08 Feb
 2024 12:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
 <f454d60a-c68e-4fcc-a963-fc5c4503d0ee@linux.dev>
In-Reply-To: <f454d60a-c68e-4fcc-a963-fc5c4503d0ee@linux.dev>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 8 Feb 2024 12:05:17 -0800
Message-ID: <CALCETrWu63SB+R8hw-1gZ-fbutXAAFKuWJD-wJ9GejX+p8jhSw@mail.gmail.com>
Subject: Re: SOF_TIMESTAMPING_OPT_ID is unreliable when sendmsg fails
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Network Development <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:55=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 08/02/2024 18:02, Andy Lutomirski wrote:
> > I=E2=80=99ve been using OPT_ID-style timestamping for years, but for so=
me
> > reason this issue only bit me last week: if sendmsg() fails on a UDP
> > or ping socket, sk_tskey is poorly.  It may or may not get incremented
> > by the failed sendmsg().
> >
> Well, there are several error paths, for sure. For the sockets you
> mention the increment of tskey happens at __ip{,6}_append_data. There
> are 2 different types of failures which can happen after the increment.
> The first is MTU check fail, another one is memory allocation failures.
> I believe we can move increment to a later position, after MTU check in
> both functions to avoid first type of problem.

For reasons that I still haven't deciphered, I'm sporadically getting
EHOSTUNREACH after the increment.  I can't find anything in the code
that would cause that, and every time I try to instrument it, it stops
happening :(  I sendmsg to the same destination several times in rapid
succession, and at most one of them will get EHOSTUNREACH.

>
> > I can think of at least three ways to improve this:
> >
> > 1. Make it so that the sequence number is genuinely only incremented
> > on success. This may be tedious to implement and may be nearly
> > impossible if there are multiple concurrent sendmsg() calls on the
> > same socket.
>
> Multiple concurrent sendmsg() should bring a lot of problems on user-
> space side. With current implementation the application has to track the
> value of tskey to check incoming TX timestamp later. But with parallel
> sendmsg() the app cannot be sure which value is assigned to which call
> even in case of proper track value synchronization. That brings us to
> the other solutions if we consider having parallel threads working with
> same socket. Or we can simply pretend that it's impossible and then fix
> error path to decrement tskey value.
> >
> > 2. Allow the user program to specify an explicit ID.  cmsg values are
> > variable length, so for datagram sockets, extending the
> > SO_TIMESTAMPING cmsg with 64 bits of sequence number to be used for
> > the TX timestamp on that particular packet might be a nice solution.
> >
>
> This option can be really useful in case of really parallel work with
> sockets.

I personally like this one the best.  Some care would be needed to
allow programs to detect the new functionality.  Any preferred way to
handle it?

