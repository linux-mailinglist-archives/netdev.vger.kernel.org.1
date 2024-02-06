Return-Path: <netdev+bounces-69537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD984B9A2
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966991C23614
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584911332BC;
	Tue,  6 Feb 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ4yYnvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802E13248D;
	Tue,  6 Feb 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233552; cv=none; b=cff59AG2UJOogvDlJm/MF2/1uNLVBacPeb3SzSlsDnazteswvC/LGZLAgqGXJ5Zs940NklpgG16BaGDsDsSzzzKr5uu/r3o+4hqIXGfhbtz/cV+j5+b7k8spiBVGH8E0UVSPFT/bVSi725KlxM5QhlOMW3mfnJdSABV7ZS9dXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233552; c=relaxed/simple;
	bh=sSTfBjPa2OKvxZqmlKxDQerR+hnQq5myr7FOwzacFZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzdfIA8n/wqk7QxDcvmPB/YUi9XC0d47VEGjkDqtkEkA9hqL6juZkRzjuO60eQSBSWJFrcesrP7qzKP72WyaRppCcfS9yEaxbv1gr8efOKJ7i0VIqMr8uPJQbYYRH2kd74JXvdKvEyiml0Na26Oq659dj8bdZvWN8F3UVTzNXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ4yYnvl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d09cf00214so37409561fa.0;
        Tue, 06 Feb 2024 07:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707233549; x=1707838349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jppKsHEiy3l7sr1E4JGdAFlhrgOsBfJQrDFcaHJIybk=;
        b=JJ4yYnvldAiAi9tNnfxEvU3yqHvy0bJhMy99irZJL9ucLM1Twn9irSkWszVXkiiVmp
         hwI6euS11cIsxmk4RoZJUjZbyylIs2v5v9ONMz4bEJwA9nsNsrdgF4pHm/4Gda9XypK/
         w2zy4SKyxhKEQqHAFPJYor5/XjqDDSZCrF4x81e8TmhEvdAdXmC55yQmWwkzNb0PHr5P
         ecQPhfBSUYpwlMUAFaOCvI4i2xv1d0ybWpHuwyWD2KwLXXAtwzq7ncMu6At9D6ctjHgi
         Vids9K68iTfM1sajiiOMq3Qia5pm552jPxfOJbtKJu7Xgi/x0/O3/TgpfF50rl08kMxL
         qc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233549; x=1707838349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jppKsHEiy3l7sr1E4JGdAFlhrgOsBfJQrDFcaHJIybk=;
        b=CbFkGWSwEf7tTfiVFESyUXFHGII8dN1wQ4n2ivp4yq3Am4VV1UtT/yi5U5IUqTGCuN
         AqAp+M5CXXBVzegZSt1qsP1A3xdKNr/1skQxsCfGOG633yN4UuPx2gI/YCModBG8ZXcM
         ccmW6ym75V4+qagoieBoT+Ol81O3xmgQoT+K9PRZR0TEu0SNsYB/jxoK/KW0RzgHNrPX
         I1D9k9olV1y6vthFbugWqetAV2Dhmwi8zcxc9LDWyUcH2CJgfre79oPmjUnBdrrAlx9k
         mx8KEsz0vT/gGw6I3M/PDrpA2UmVGJg04vYDCwBqNPEc2w6q+ByAAgfRW8dnaUCo7E7Z
         pyCg==
X-Gm-Message-State: AOJu0Yxwq3KUDFj7DU0bjIk/49XCGd+WtKej2V0mCnMoHAXCvNhErrEA
	yMvlLjlW6FT2yrHh0/Cv3ZV7fp7DfHYhoH4jf+yVp2xhwD/GiC572vof3XPfKArMi9eSjWdJckt
	IGXE1EpxBfz0DuTITYybtGjrjvktzLXj8VoE=
X-Google-Smtp-Source: AGHT+IHaA1XviD7PBxKN1yfpw3QUmrtgPaBXtV/tEfHlJd49xqJQMkpZoeghYBehyQwSuuoIdI8AsHYMQwSwWgyidWg=
X-Received: by 2002:a2e:9018:0:b0:2d0:aa86:8cd1 with SMTP id
 h24-20020a2e9018000000b002d0aa868cd1mr2410990ljg.9.1707233548501; Tue, 06 Feb
 2024 07:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202213846.1775983-1-luiz.dentz@gmail.com>
 <f40ce06c7884fca805817f9e90aeef205ce9c899.camel@redhat.com>
 <CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com> <69c9e55b40ff2151ed456d975755d9d4e359adf0.camel@redhat.com>
In-Reply-To: <69c9e55b40ff2151ed456d975755d9d4e359adf0.camel@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Feb 2024 10:32:15 -0500
Message-ID: <CABBYNZL4vUMUgHGd_TFWTwKtZzsBRazg_NVnVcqzgJpgybZPMA@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-02-02
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Tue, Feb 6, 2024 at 10:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2024-02-06 at 09:45 -0500, Luiz Augusto von Dentz wrote:
> > On Tue, Feb 6, 2024 at 9:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > > On Fri, 2024-02-02 at 16:38 -0500, Luiz Augusto von Dentz wrote:
> > > > The following changes since commit ba5e1272142d051dcc57ca1d3225ad8a=
089f9858:
> > > >
> > > >   netdevsim: avoid potential loop in nsim_dev_trap_report_work() (2=
024-02-02 11:00:38 -0800)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
.git tags/for-net-2024-02-02
> > > >
> > > > for you to fetch changes up to 96d874780bf5b6352e45b4c07c247e37d502=
63c3:
> > > >
> > > >   Bluetooth: qca: Fix triggering coredump implementation (2024-02-0=
2 16:13:56 -0500)
> > > >
> > > > ----------------------------------------------------------------
> > > > bluetooth pull request for net:
> > >
> > > A couple of commits have some issue in the tag area (spaces between
> > > Fixes and other tag):
> > > >
> > > >  - btintel: Fix null ptr deref in btintel_read_version
> > > >  - mgmt: Fix limited discoverable off timeout
> > > >  - hci_qca: Set BDA quirk bit if fwnode exists in DT
> > >
> > > this one ^^^
> > >
> > > >  - hci_bcm4377: do not mark valid bd_addr as invalid
> > > >  - hci_sync: Check the correct flag before starting a scan
> > > >  - Enforce validation on max value of connection interval
> > >
> > > and this one ^^^
> >
> > Ok, do you use any tools to capture these? checkpatch at least didn't
> > capture anything for me.
>
> We use the nipa tools:
>
> https://github.com/linux-netdev/nipa
>
> specifically:
>
> https://github.com/linux-netdev/nipa/blob/main/tests/patch/verify_fixes/v=
erify_fixes.sh
>
> (it can run standalone)

verify_fixes.sh HEAD^..HEAD
verify_fixes.sh: line 201: $DESC_FD: ambiguous redirect

Not really sure where DESC_FD comes from, perhaps it needs to be set
in the environment, anyway can you send the output it is generating?

> Cheers,
>
> Paolo
>


--=20
Luiz Augusto von Dentz

