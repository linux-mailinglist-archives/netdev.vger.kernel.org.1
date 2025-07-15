Return-Path: <netdev+bounces-207132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3832B05E46
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78400501C97
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3DF2E3B19;
	Tue, 15 Jul 2025 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soq+l7x0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2C2ECEA5;
	Tue, 15 Jul 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586710; cv=none; b=tTNwpNRDGjlS5ADSnu+DSvpkOZL1GjYEzlLpno4DOjhxdsIxJ7M5P5s2SPdEvMXlsv4qD4NJyLBxn0bSVbFe7Z4AuVyaume3Aj+kzPw67rQCX3BqmFSHmRO13CPmyI2Mcz67FEJMSrdGb9qsNpTFJ1yVjAkvuBHH3hPmrSrDenk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586710; c=relaxed/simple;
	bh=DMKIf8aWEIGOaSziFnfi3lGFRGwvJS/wmrcYpsZO8SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovlR7b6ID5iJDFK5BBTQ7KgsLhY8Dtq5J7qRGFiVF+D+DClxBf00+niUOlreJA2JzIDzwOVmC2/X1cV8wK+8UXwRoTn6fbL/V4SA4UKMcAsaMX32DTlX6Bn9oPD0RqkfNEmSABnRjBj0O2RkeNWyE1IJacUFKmblUMb54oqbKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Soq+l7x0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e33fa45065so25996885a.1;
        Tue, 15 Jul 2025 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752586708; x=1753191508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQi1T6NwkTeZfxo29WdZM32LKwWG4+C0TAJA/JztXec=;
        b=Soq+l7x04dAdwIAB/4VNT4bVrCaq01uMuRuQd3X1yLDtokYe/nuQc/3jVaHKjesl55
         1jQQNXvlwZw79skeDTtUaJ7GzT1DEYtXgqdO1nd+sU3sdhdbyLzsPBtZp+cKNjgHjh2i
         kRD82M2api9Xg5t48Zl1FnUj61OZin3NUuQCtnLPcFoELBFpcILonhaEZjD/jrPjILj/
         KVYhhE7N2M3n/QK4cD3jJudGR49Xxi1s1ZMFEAP4jml1/jvZATDNgPmAcgg3ki+TI8ot
         9rWd9Tqu40PmpxHxNhdWXiatBxPo1Nys79ncVa6FWYRpDyDd1fjoSpIcSQZBkDCtUQNw
         gbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586708; x=1753191508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQi1T6NwkTeZfxo29WdZM32LKwWG4+C0TAJA/JztXec=;
        b=uKYBBv+FCbSzIDeV/gQCzEgnZeZcIG7AQa+wc1cXndolZztfZF/cDEXJWPFF/9EpNz
         CpX+Xma0FSPMVaFnCTJIxJyjzMhbldhnFxB2ubBD6P/07N75dgwW8e7i5BT8aqnZ0Hrf
         0udjzzVMcJlU3pTTe4XA2lNBUb+N/sY3YSXfaR1zGG6J0i9P/MT2eBbVPFn+vM0NJQL2
         yHJ5lsBlwsidH5sLD9+7wWPZX3RCkQ+wmQO4n+dZ3PH4755YoFcw2MrJbG/8nr+rO4De
         aXF7rgRRAw401LOsqSjgGfIPYYaehW4p/8+SF9DYnMlWluL9egYnSFuLUqLeal4zi2Pu
         NxdA==
X-Forwarded-Encrypted: i=1; AJvYcCUSXQkPQlcKqCvcDrQgtpXEM6q3q2IOcMWBJhHIOOYBj1sVnRQWU5fBjq5Co/d3xCssQocsmS8OVrlquTk=@vger.kernel.org, AJvYcCWBALj1WmFoQQay8mKnGsmzg7lWqzJScMOhzVjEZJMAgHeHbjCX0Isqsb5D6tpoHpBUZg+ViiuB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2veCIAw0aN+iaAWt/Tiogd0ZjJdLBWNd6mi5BbjuIffZTyLpt
	dJp5am79/mX446SLbspSgjLdNPH7YpgFLkeTxa4MCaYVk1Wnhn/tyciYgYqgyV/qS/i6VN4NxWr
	t+I0MmzCZc5sVhfTk9TuMGUdSqkAROj8=
X-Gm-Gg: ASbGncuepiZ4t4KsrS8yWbOyKQT2LslgHaD+jHDQfnpE9kd3F2abuODyZ7875CwH5uS
	NRaVMQRfcZoCrDdu0yecsnopOYSgkdrBBu5fUtInuxQFmhJnpq8XJMXpFEID08ptFkWxaBIc2wu
	u94TwsvHAmX1BV3nvAoXqIWT8Ko68PsCN7IjVC/6qBZ72Yb/GF/QJKcvsKGh0W1pqZCkEe2s4vg
	pz9pQ==
X-Google-Smtp-Source: AGHT+IHjynnQLckw4oi7+qn+5RKS+0q+ovWs1yb2i3TtOQjxqFzMNv30VLwUR0Z8x+NFVm75a2J8FWKhUJ3NCqqtKug=
X-Received: by 2002:ad4:5f0b:0:b0:6fd:609d:e924 with SMTP id
 6a1803df08f44-704a7047431mr347735046d6.36.1752586705013; Tue, 15 Jul 2025
 06:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com>
 <20250714181032.GS721198@horms.kernel.org>
In-Reply-To: <20250714181032.GS721198@horms.kernel.org>
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Tue, 15 Jul 2025 21:38:11 +0800
X-Gm-Features: Ac12FXyAi6q58E5yk-hrfOil0SX6R5fhR2UitDOMIIisELNeKoalCEdt2-Sj3WU
Message-ID: <CANZ3JQQtC1ytmaqGR3xx6eDVyV-ZJp=hCZDcAJV-ktA2RHvTYA@mail.gmail.com>
Subject: Re: We found a bug in i40e_debugfs.c for the latest linux
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thanks for the clarification.

We=E2=80=99ve observed that i40e_dbg_command_buf is
initialized with a fixed size of 256 bytes, but we
didn=E2=80=99t find any assignment statements updating
its contents elsewhere in the kernel source code.

We=E2=80=99re unsure whether this buffer could potentially
be used or modified in other contexts that we
might have missed.

If the buffer is indeed isolated and only used
as currently observed, then the current use of
snprintf() should be safe.

We=E2=80=99d appreciate your confirmation on whether
this buffer could potentially be used beyond its
current scope.

Regards,
Wang Haoran

Simon Horman <horms@kernel.org> =E4=BA=8E2025=E5=B9=B47=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=8C 02:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jul 10, 2025 at 10:14:18AM +0800, Wang Haoran wrote:
> > Hi, my name is Wang Haoran. We found a bug in the
> > i40e_dbg_command_read function located in
> > drivers/net/ethernet/intel/i40e/i40e_debugfs.c in the latest Linux
> > kernel (version 6.15.5).
> > The buffer "i40e_dbg_command_buf" has a size of 256. When formatted
> > together with the network device name (name), a newline character, and
> > a null terminator, the total formatted string length may exceed the
> > buffer size of 256 bytes.
> > Since "snprintf" returns the total number of bytes that would have
> > been written (the length of  "%s: %s\n" ), this value may exceed the
> > buffer length passed to copy_to_user(), this will ultimatly cause
> > function "copy_to_user" report a buffer overflow error.
> > Replacing snprintf with scnprintf ensures the return value never
> > exceeds the specified buffer size, preventing such issues.
>
> Thanks Wang Haoran.
>
> I agree that using scnprintf() is a better choice here than snprintf().
>
> But it is not clear to me that this is a bug.
>
> I see that i40e_dbg_command_buf is initialised to be the
> empty string. And I don't see it's contents being updated.
>
> While ->name should be no longer than IFNAMSIZ - 1 (=3D15) bytes long,
> excluding the trailing '\0'.
>
> If so, the string formatted by the line below should always
> comfortably fit within buf_size (256 bytes).
>
> >
> > --- i40e_debugfs.c 2025-07-06 17:04:26.000000000 +0800
> > +++ i40e_debugfs.c 2025-07-09 15:51:47.259130500 +0800
> > @@ -70,7 +70,7 @@
> >   return -ENOSPC;
> >
> >   main_vsi =3D i40e_pf_get_main_vsi(pf);
> > - len =3D snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
> > + len =3D scnprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
> >         i40e_dbg_command_buf);
> >
> >   bytes_not_copied =3D copy_to_user(buffer, buf, len);
> >
> > Best regards,
> > Wang Haoran
> >

