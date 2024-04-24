Return-Path: <netdev+bounces-90930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3058B0B63
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9C51C232A4
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C13E15D5C3;
	Wed, 24 Apr 2024 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhHfN6FW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368915CD6F
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966211; cv=none; b=L526s8KhAI3j1UpcV9dIervlb3A5XrvjKL/upgK/4fhZTLn2nYKixmclQFMJcknF8TJAcK6kOn5fDmu1mRrj8HvJSXaY0X32oeQqqoTzoK+oO2JTw1Eq8uQAtXAmcS4Wiqn5upQuZmtzPVRMNjv2fdMKgmvVE6ECH2vwnlA8Rns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966211; c=relaxed/simple;
	bh=enIq3rOjo69RcPcCmgdBwJJK6m49S2ThPAK1bf/uijI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuFLMff32zdVO3Gn4vyotY1oJuTq1amWhdTS3WuvXum8JHA4+kqBo4m5iPWIHzm9kCV90UhwtUziQfT1irnG/GXbSzRvElmX+jOryu/zSReMjxs63wkrl24lOqmTCh5W2jxFOby5xPUDIW7HeZS/TBNsVVpPlXhbp0Jsr+OSWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhHfN6FW; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so6150232a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966208; x=1714571008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmTGyMHN1tsiyGbtMZWbmbt5FVtHtQX9ZSQWdDaUOjw=;
        b=UhHfN6FWroxg2VWYKfa4hbgaqJtuq+hau40RUQtVh6Svoos9aVthwsvWu9tl1yp3F+
         OqTJPYHKSFqejzJrd6e4mLZh7/pelUuv/M3SD8zb0Ri3BnZfDWbn8GZV4gbtsg5Dsc5B
         nXN1H7QEBC0v9p9E1NutWizFVilcvaredgmXhuplBGUNYe64C1Ke2u43H8i6nVci7pbP
         5/87uWLSyFawle2VS8NP/XEOCw473T9EgUOaeopu7+AvEZpV8GyjQiQrlcLlSjvE+hdr
         qj+i7pwUdc1LX8B5uek9+nlqMidZAWaKZrOBO86WPIqSeVzKlbs2BDWyUdaZPL7qp2lg
         T3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966208; x=1714571008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmTGyMHN1tsiyGbtMZWbmbt5FVtHtQX9ZSQWdDaUOjw=;
        b=iD0UcydHRqjb80xakdNOgJyKgoNwPCQTTxCMwWgUQpL8EbD9szVM/miU9X0/Ovwrpw
         kN6Lym0qHZW1lJSYolwf+8v68uRcSJ9cMog3GfraaRoUOF9hERtG0jBWlcKo1E5k+nD4
         g+j9A8vFKW1pwVE8C2vFmuH08jctlxBwUUJm6lv1ZXHFgQ3425TgeP5Zm2CGU4nG8odx
         bphtItOnWQ2f0PkxixOeaxaBmbxoMWrGIB6fAz7wg3QDMy5B/3RN7lIfPUfRwA3lX9pz
         XSywGDQdLFVYHWgJGoyNXYfBSkseWYonqejocyKHFqVLNtrkSbUmionC0T3ugdJJi7O9
         UxAg==
X-Gm-Message-State: AOJu0YzoTkoUqL16OypX/TaJzIKp2QOEH5tQ8AjRbCCF0h7Ps+NmxoiN
	FkgVV8glhSuhxglQb0j3qcJZnO67AmxkqzTRWFMrC3GbOk1n5yujOy0BJ0i/FuAg1jS+scdevNw
	QajVmf124InRlz8nwNbU945EintFLWMqH
X-Google-Smtp-Source: AGHT+IEmoudr4hI3kxdjZoOen/odr7sl2qkO8/oEVbP8FcnU2lVWk4XSNhyVX1mKkvGtxRqTQJJ8rnjKXhGrPNCZtMQ=
X-Received: by 2002:a50:c050:0:b0:56e:2464:7c4b with SMTP id
 u16-20020a50c050000000b0056e24647c4bmr2000018edd.10.1713966208042; Wed, 24
 Apr 2024 06:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423070345.508758-1-chenjiayunju@gmail.com> <20240423083548.49573c93@hermes.local>
In-Reply-To: <20240423083548.49573c93@hermes.local>
From: jiayun chen <chenjiayunju@gmail.com>
Date: Wed, 24 Apr 2024 21:43:15 +0800
Message-ID: <CABiRo3kmBkUOLNRoQ3_U2stZuD8QgPHvJX662T9CGwLMXAf-UA@mail.gmail.com>
Subject: Re: [PATCH] man: fix doc ip will exit with -1
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, shemminger@osdl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

But a checker based on the manual doesn't know
what such an undefined value means and how to
handle it.

So I suggest fixing the manual only, not the code.


On Tue, Apr 23, 2024 at 11:35=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 23 Apr 2024 15:03:46 +0800
> Jiayun Chen <chenjiayunju@gmail.com> wrote:
>
> > The exit code of -1 (255) is not documented:
> >
> > $ ip link set dev; echo $?
> > 255
> >
> > $ ip route help; echo $?
> > 255
> >
> > It appears that ip returns -1 on syntax error, e.g., invalid device, bu=
ffer
> > size. Here is a patch for documenting this behavior.
> >
> > Signed-off-by: Jiayun Chen <chenjiayunju@gmail.com>
> > ---
> >  man/man8/ip.8 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I wish Alexey had used the semi-standard exit codes from bash.
> The convention is to use 2 for incorrect usage.
> Probably too late to fix now?

