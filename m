Return-Path: <netdev+bounces-69530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F159584B950
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3006A1C24BA6
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E94133429;
	Tue,  6 Feb 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkOXFtD/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5B1AB7EF;
	Tue,  6 Feb 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232631; cv=none; b=EA1K6TyL2vMLlRNnjTsLur3/wMV3HSOFvkbHc5wI2wzuebsfnBjNgIIO/aNHI89M/oLuluYViI24VtTfKar7BLzsenr81WoVEyGLxx6e5ECeDSxUmggMA4elGPR1cNW8X9PjErDFHFWpti/xqInC75a+Oe0BswlcxyqdBARvEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232631; c=relaxed/simple;
	bh=0ckM6fZgf++iAr1JDimPJABwX76/VE5NhVh0xlSb+qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLHnLRc7USyOkiymmR5P/9hxwGghITH3bUFjuMtTU/ZMBuh8MokBHcoc78gf+3Kyh9DBq1FCgYGIQo019z8u1mBHZSmCaFzgliAJmEPOUm9tjawiP8pQgDkjCgF04wUMSUeefZkozRDiaZMjIq+0w5Z8uUhn+5egCVzxbB1T2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkOXFtD/; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d09cf00214so37177231fa.0;
        Tue, 06 Feb 2024 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707232628; x=1707837428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKVaao2DpcCkw7P8vyvoZ0bxnn79N7JE/jGb8UlDF30=;
        b=lkOXFtD/nkj+mHSeSrWKn1mKxxpEqY6bzA5t0sYaUVU9oqUFz5SQnIeKVpaFxOgCzj
         EewPi6ljqer+QcEsMw0FMVXM9T97fhu2px2wesK7VA4MFD3AXG3esupdUtR5+z6weH5a
         25HziBToyTP9luwvWf3y8ASXinbANz58wNL0uWKjjVZwVcqSbMOWgZp0D+QgS2FSMRTi
         WE1TrvVAd4wAg53H47XzNI8BL9+YakA2zIbaJVPSwHMv3tenNbH7LdqAq1MVLo1r6UUK
         xnTAAX4wuLxrnphTtWyA98vYvtyO5wr1CfcmmsQ91NsN5AjieXWt68USQbh9NF6zLeC1
         fYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232628; x=1707837428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKVaao2DpcCkw7P8vyvoZ0bxnn79N7JE/jGb8UlDF30=;
        b=hAoy7+lLJ/jUdgYOkG8GX78aajStpUdlXJh0KlgCTf90HQ1F49yea1PNMvNKbAViO3
         XaVm0kL/5b5w2NLnXboKHE/+TAuCDb5j4V+ReELEzLFnlNrtOsHhJrb0kt890LIscm0F
         mXHQE3LWw+NvEGpXkrS8/TpjVM+yh6Nyg0pPk9uFneMQ5q/t6mfdsI6x2oBNxkKPUNQA
         AMdD0NWtUbexshYqT4fZ9kzU0uuz1HrT1e9gf40bvYvnkGIEaNcHc11Bse8QFiFKZG3i
         dzmPShrF/LEwGbBViYkfYNlD2bpCTR0NTmrkY501pTtbDwhTBf54Q1jpyHTu1bpZQnP6
         hp2A==
X-Gm-Message-State: AOJu0YyAfspR2IeES8H86jsWW4caxCf+y89zjdRvDqstxfxf626Iv83z
	uIJz/U6GwCVUUKhkgtljdF9ja9eDZFEI8EFcehjzbm9d8FdTjuAbHYZOa/1NpBLQ3angLNoTUKq
	xH4EtDjzlJWH+2IchpC/r+3gVowc=
X-Google-Smtp-Source: AGHT+IH4rjtAPsRaUl13fGXSZfDDz9lrUDxmw9d/8qDs75ETAepY+Mq39tdBxkJ1Uf6m4ZekWeuTNfbSmeJhDQT57wk=
X-Received: by 2002:a2e:9792:0:b0:2d0:85dc:bf9b with SMTP id
 y18-20020a2e9792000000b002d085dcbf9bmr2046593lji.14.1707232627522; Tue, 06
 Feb 2024 07:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202213846.1775983-1-luiz.dentz@gmail.com>
 <f40ce06c7884fca805817f9e90aeef205ce9c899.camel@redhat.com> <CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com>
In-Reply-To: <CABBYNZJ3bW5wsaX=e7JGhJai_w8YXjCHTnKZVn7x+FNVpn3cXg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Feb 2024 10:16:53 -0500
Message-ID: <CABBYNZLxbLtFM8A61H+Du1uGisCc7r155G9fFuGkF8X33Mgreg@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-02-02
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Tue, Feb 6, 2024 at 9:45=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Paolo,
>
> On Tue, Feb 6, 2024 at 9:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > Hi,
> >
> > On Fri, 2024-02-02 at 16:38 -0500, Luiz Augusto von Dentz wrote:
> > > The following changes since commit ba5e1272142d051dcc57ca1d3225ad8a08=
9f9858:
> > >
> > >   netdevsim: avoid potential loop in nsim_dev_trap_report_work() (202=
4-02-02 11:00:38 -0800)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it tags/for-net-2024-02-02
> > >
> > > for you to fetch changes up to 96d874780bf5b6352e45b4c07c247e37d50263=
c3:
> > >
> > >   Bluetooth: qca: Fix triggering coredump implementation (2024-02-02 =
16:13:56 -0500)
> > >
> > > ----------------------------------------------------------------
> > > bluetooth pull request for net:
> >
> > A couple of commits have some issue in the tag area (spaces between
> > Fixes and other tag):
> > >
> > >  - btintel: Fix null ptr deref in btintel_read_version
> > >  - mgmt: Fix limited discoverable off timeout
> > >  - hci_qca: Set BDA quirk bit if fwnode exists in DT
> >
> > this one ^^^
> >
> > >  - hci_bcm4377: do not mark valid bd_addr as invalid
> > >  - hci_sync: Check the correct flag before starting a scan
> > >  - Enforce validation on max value of connection interval
> >
> > and this one ^^^
>
> Ok, do you use any tools to capture these? checkpatch at least didn't
> capture anything for me.

So I rebase it locally checking if each Fixes tag actually points to a
valid commit, all of them seem fine, what I found to be a little
different is that those 2 have an empty line added after them, is this
the problem?

> > Would you mind rebasing and resend the PR?
> >
> > Thanks!
> >
> > Paolo
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

