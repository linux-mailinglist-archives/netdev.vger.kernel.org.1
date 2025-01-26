Return-Path: <netdev+bounces-160951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC98A1C659
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 06:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB81166FAC
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 05:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3B3BBC9;
	Sun, 26 Jan 2025 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="HrYaNufR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82DC1372
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 05:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737869639; cv=none; b=q9lU4C25UNS+xMUBKIQLlKawX719kajU435b0CPxIBkCeRP6fYVhINImch8VHH2aCQL0L8UM7mIhBpeR8lkpM7V6cWwH+sKck1d/XVx1eor9agtL5L7ih6puxp4Df6Y/T0QAagIlAFlxutZ8lF1k5JV02wa6yApONfsVPUwXHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737869639; c=relaxed/simple;
	bh=2gYxR5d7da66lnF5h+7BWq8060+/bZgFrmKa+kIh1hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojVqNWKJ3LVOnKAadrSFKQK7yvOSeDsHQeNmZdg5dvyWMr+8QCH/Df1Fao5n/0B18/3oj1afiNUm1NHKfuOtFdmF/yfosK8boaAezs/bdU0lvFWm2GIBF+h0KhmXEiXL/zrxW6dFu/Z/isjI5GIRlzTbiuS4jy2AJpEOHBBY/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=HrYaNufR; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IY2Dr/a1H5FXWZ7dMUxgXEROqvjQkfpO6JP9Gih7SBs=; t=1737869637; x=1738733637; 
	b=HrYaNufRVsaEEJzjiVlfmqNEE+Cdvputm7NV6kavXQco598V0glzNMov/oOZ7LI8N3/ARN9WoDF
	AWjiQP1XyRQmyNqTuyeRQ9DgGIQlHUj5fsIQKf2M3X08a5bbVIIdMUgjNf6jkOFDn74w5MVD58Udg
	TjRESLU+KS2L+cXIcVPd/y52k5mF4bwo7wMWXdFQrG5uc9jDTdf2QuT53O0ZwB6rcXP8Hq6Ts0D7f
	gstsS259JUJwrWOXjJ1cctMXoKWCoeL/geNZoqRDeYP3SQKGAKn718WSR289n0Pu8O3l7WsPKPrpQ
	htLJmoYJ8rzYTDtN9EyzuSWiVJ4Dekcmq3uA==;
Received: from mail-oa1-f48.google.com ([209.85.160.48]:60536)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tbvHK-0004vP-OW
	for netdev@vger.kernel.org; Sat, 25 Jan 2025 21:33:51 -0800
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2a3a40c69e3so1917873fac.0
        for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 21:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIBkDQB0ljxdzhbIeQ8VsZoXyDoYqBwUCcwrcCyHuVTWRaLtajajw1zdUXpvNUibSQ6k4NbtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDDin8GkJ82KGfTzyvzqNV/Ql1R883ixa2Ft5B0V3X6Py5fk5
	hLSJPhXdbxhTjiYRrpIc4v3Iq9/tR9vJUDSC1fKdQvcWmL8Cl/sFVuNRqjzYX7ISSF+limhT0U7
	+OgV+T76WmIeogbvOyfhyZboJ/QA=
X-Google-Smtp-Source: AGHT+IGf4GmDt0/f/MFSdMoVrOUVlCHfeVOXXodSvGgan20H9ZtSEzIovNELvOPj/qOTyetfIuoJU1qp1X93yi4HdrA=
X-Received: by 2002:a05:6871:7887:b0:29e:6547:bfe1 with SMTP id
 586e51a60fabf-2b1c0842a07mr20713314fac.4.1737869630197; Sat, 25 Jan 2025
 21:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-5-ouster@cs.stanford.edu>
 <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com> <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
 <c5a5f0da-f941-4818-8dd7-b181cbfdca30@lunn.ch>
In-Reply-To: <c5a5f0da-f941-4818-8dd7-b181cbfdca30@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Sat, 25 Jan 2025 21:33:14 -0800
X-Gmail-Original-Message-ID: <CAGXJAmy3QB84Jp7nTCF_4s0Cwj6Yg4csX+aHUz7qYpw+QsvOcw@mail.gmail.com>
X-Gm-Features: AWEUYZmGHL3jzC1aEl87908niWkm5o9BHmxPaZX3l-mG6H207mhwTkwlp7XuElI
Message-ID: <CAGXJAmy3QB84Jp7nTCF_4s0Cwj6Yg4csX+aHUz7qYpw+QsvOcw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and homa_pool.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 67f4a389e065da33eb5969ecb4726704

On Fri, Jan 24, 2025 at 4:46=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > +     homa_sock_lock(pool->hsk, "homa_pool_allocate");
> > >
> > > There is some chicken-egg issue, with homa_sock_lock() being defined
> > > only later in the series, but it looks like the string argument is ne=
ver
> > > used.
> >
> > Right: in normal usage this argument is ignored. It exists because
> > there are occasionally deadlocks involving socket locks; when that
> > happens I temporarily add code to homa_sock_lock that uses this
> > argument to help track them down. I'd prefer to keep it, even though
> > it isn't normally used, because otherwise when a new deadlock arises
> > I'd have to modify every call to homa_sock_lock in order to add the
> > information back in again. I added a few more words to the comment for
> > homa_sock_lock to make this more clear.
>
> CONFIG_PROVE_LOCKING is pretty good at finding deadlocks, before they
> happen. With practice you can turn the stack traces back to lines of
> code, to know where each lock was taken. This is why no other part of
> Linux has this sort of annotate with a string indicating where a lock
> was taken.
>
> You really should have CONFIG_PROVE_LOCKING enabled when doing
> development and functional testing. Then turn it off for performance
> testing.

This makes sense. I wasn't aware of CONFIG_LOCKDEP or
CONFIG_PROVE_LOCKING until Eric Dumazet mentioned them in a comment on
an earlier version of this patch. I've had them set in my development
environment ever since, and I agree that the extra annotations
shouldn't be necessary anymore. I'll take them out.

-John-

