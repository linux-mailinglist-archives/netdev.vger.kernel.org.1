Return-Path: <netdev+bounces-69557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B817384BAC0
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54F81C23057
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6536541C7C;
	Tue,  6 Feb 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfFH7mos"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CC134CCA
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236508; cv=none; b=QfxIJ+PzPJqL9mof/VyHKInHt2l0OCsj6mdOyivMsqCPiWGyP3+dXKqpgWz8KbUpeSpykLkTW7xUl1dFYVOf3P3dzcvSf3Ibmmll5sw8A2YVN3KGW0evKOxExqyKAIP+TyIHCdoPOTlpqi9yL+bYt1sep7CTTAxpVLOgFJzbzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236508; c=relaxed/simple;
	bh=COlihfcJ7A7raKl+fyuaIJuY8j1LS1xV5BIwdr37fg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6GtINIVWUPlARgvhlBq1OjQTY3eQ8DDiX//L1WUMxGSKOzxxCGIB9FpF3UelgDGszKx6NpUOkB7w7/Bq8bQejv0JpixQ+yHI9noZpz20Kz9K9ipZrzODrxcfIjLQ8EshQs2KAZvxTjGsMFiVGpeV7kufUpSuvEf91eyQfUUl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfFH7mos; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5111c7d40deso9700867e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707236505; x=1707841305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc5GoqhRjBcxYyRUYwBLJ5o9DEAMfdDRWymvEOet8n8=;
        b=IfFH7mosw0C0yyDss7MzgKmPeQZggaMU1ooQReNApBQGieiVn99PMh8nGALsYLcAqh
         9ZbCSmG6QNaGt8n/DEM+MpgE3BlUHk135G+pjda8xZ0tMbl2M0fSRJi8PGZVV60wv256
         QfqcyTWalEniATrpye+ptmaqAcKxiSGIQ71FjV8p94FFHa8c46ZC5hQ4ftrT8AuQfOUG
         V+mIvN7RcHsgXDwES4AarhR4nOkSGWBW2UAgkH01mb2ojzFcIkTovJCSLlpn0C+YKSgo
         PXpIV4DdptzBsCbwDhfTKn02MgklK31qbZkcUio6nOZSSKjsTJTActacH5fSCwPDRBSE
         lmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236505; x=1707841305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc5GoqhRjBcxYyRUYwBLJ5o9DEAMfdDRWymvEOet8n8=;
        b=poFRyiqU7gBfPF6zcb7LOltn0Jh58jWlY/RIg/F+UZUbLCa2kONxLPdlesg+0JB/vu
         Uuz0/I9QVCi1ME6XGiXNvFU5fC7QYTR2j2OD0bkLP43JeSAdC+QIlWsEqs0zopcGB/Wa
         5tx9RJ30Kz9yXUxUqOY0lWjlmkVYMbhQJMDxD4O6MLRCj9u/3JxR1x7kMVBNISkpybjx
         83dam7BuvZl89LHD40HkXyIcKXlhbdM7s6nptzGqELktB15/MdQ7YT9icFVO3wbffwI1
         QNMGz9SQ9J8Wc/7bEqRPsKopJCr3zCHlcLKCojHTrhZd8fVoehbyBkpDJ/LGlmswNNp4
         0YoA==
X-Gm-Message-State: AOJu0Yz2v5Tcf3x5CjIvVKgSiVnWolEUie2DngTdaAPJSRVZAF0tO66X
	TBs6bFOOBK2v60sydGiLTHTlZgymgKRnXcRRLux11Wxo1QsVfVE4/tVAz2rVpNEoKL9Szg9O9mS
	hykcLAcmKlbqO9QLkLws6plq+Fgi38YwX/LQ=
X-Google-Smtp-Source: AGHT+IEBtVtbqTFNnn6q9vFunii7i0ocpmkeyqbGtzFY0Dixb3XVLbD7V0l+ikQoN7kvBsNzQF0/ioK9b+Uxv09aA2c=
X-Received: by 2002:a05:6512:470:b0:511:558f:f398 with SMTP id
 x16-20020a056512047000b00511558ff398mr2247594lfd.27.1707236504497; Tue, 06
 Feb 2024 08:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF6A8582QOWc1k7c9sgeX5ebwY79SDAmXzfbBumW6qGoyu6HRw@mail.gmail.com>
 <6f3cccef-2397-4cdd-8626-6259ec19c619@lunn.ch>
In-Reply-To: <6f3cccef-2397-4cdd-8626-6259ec19c619@lunn.ch>
From: mahendra <mahendra.sp1812@gmail.com>
Date: Tue, 6 Feb 2024 21:50:40 +0530
Message-ID: <CAF6A859v6jpSEG-uR6zfNvm=AUoNjWS+ZgY+YJzzjt3q2nVDDg@mail.gmail.com>
Subject: Re: [Kernel 5.10.201] USGv6 conformance test issue
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for multiple posts. I was not sure if the one I sent really
got posted as I got a message that it got rejected. So I tried sending
it again.

Thanks
Mahendra

On Tue, Feb 6, 2024 at 9:07=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Feb 06, 2024 at 02:50:26PM +0530, mahendra wrote:
> > Hi Everyone,
> >
> > We are executing IPv6 Ready Core Protocols Test Specification for
> > Linux kernel 5.10.201 for USGv6 certification.
>
> Posting three times in quick succession is not going to help you get
> an answer.
>
>         Andrew

