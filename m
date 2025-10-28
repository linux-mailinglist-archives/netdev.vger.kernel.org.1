Return-Path: <netdev+bounces-233689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D368BC176A4
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 589CE355975
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35740306B3D;
	Tue, 28 Oct 2025 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4hiubbC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7C307494
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695658; cv=none; b=TVdZhLNYmrOdFYXF5QlJiCfKbRz0RraVELV0KlWbtdZfxsuIhZly9cZHXq1muoECqI8/TVBmGQ1OBZ2L11tj+kno3hk+GMiRPbpGvWhd9Mm+6xs12a3IeCRurDNt6YMVisRkkjiqFRqmAFhlIOA5o3RrHw6GoNZNxpkLMp/MqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695658; c=relaxed/simple;
	bh=cWlgHGOtfSt7tIaISCcbrIt/pV55e5WSj3LRJbov54U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIXk8qUwbKunNzKel668xwd+kKkR5yWepSid+gIJ41FtJ6BmdhD6aYWzvp5IiFl5Oz6iZocHW3zFofZF5VX9r0pj3UOOh4/BktWqsH1gY8slmKfpNGdYAJFliizKpOWKcMPux+IFvYOTlQro8xO+T1QfJPzQjpryCJiUOT3rboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4hiubbC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6cf1a9527fso274689a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761695656; x=1762300456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWlgHGOtfSt7tIaISCcbrIt/pV55e5WSj3LRJbov54U=;
        b=I4hiubbCZajyJIcq0EzybQmQ+4TBp/+SzA2Rh9wEsGnH/XqMUf6ddMpA5oz2LHY9/y
         U6K5i2kj9ahilHC1zGslEUPVycin10XLvpjGKUmw3cJzk5xIlNAZ2jcvjR2rYOS+TRXv
         NWj5WNgoRzJpRWUQNdhrWg7duJUIr78ukQWhpVXY9oLcAdDuJhpHQHQ9fH/AHhxsRvvh
         bnJVeUvi8B9StMWwLnJvB61+LTVE4mCgXbEQUX5SgGlBk5gop1+ZoOJA/D4zt7mdxYEw
         2PuItCQ66BiDwf5h5++nIurG4DNGjnJD4szqpMmSmbVupNejYInPlEPHnm+FEgPUrm7j
         VXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695656; x=1762300456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWlgHGOtfSt7tIaISCcbrIt/pV55e5WSj3LRJbov54U=;
        b=vxCP5NPX2IjnBL+6oQVuRJ4utkUiD7en0vPx0NWAW60UwPVfdCpePU7MIiPJvglMg7
         mXaQCa/26X0/Frwf6Qrf5IfoE7wa2aqMs1I7GEAtHjkmWHmofZx4g7R4ipgvd2UG9/Q7
         Oe4VDeNPTQpS9u4mvqluqBFtbod0bxk4ktGxSKQIBZ4tVuUBq0lQLdCLigWgYCUfemxS
         siOf3CUi5YYUAjsjKXlStxDmUhThc8tqaZaoTWzRWdsokmQ1MnUHkJBj5hWTjmvmJA8W
         u9fVH+zHbPOFbXW75fRGvIrWx1PnNJHTfg8rS8WncaoAXFoF3b++44WR6rGfhZgRO/yc
         6JUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOMUifAT9/lQxthTLrhV7Y8xB1oIgnbkYcet86l/kwVQHSVSLQG0uNP8yESneifgz4FO9yynw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyccf6QhGz2MsB5btl2FYIQFu3NNU2Pe+DzSLckqyQTyTiVIvKe
	WJX/OfarBOJxHJi5KsaCon8XRIlv8DaG58r4wxdQvbDkszaTQkDzTfHzK6wPQZ3vi9otEAJEeuD
	rZ6FOF2ThSmFn5a1Kzktjzffc5M1tEwknmdzMaBSP
X-Gm-Gg: ASbGncto9ZgcgZj/Q5h8GfgpBS0TVozYlajZsGMY/9QVqpKakFlMPtWUEr8F1wHkZjB
	W/8j0JwtgDvENufyxRjVB95k+8NvjlBlttdi8i8g2dQpf14P4Hf60XDURNrDCeC221uz8Ao13pM
	S7jcm/md5naXNQ8lMyRnogA6wQKQ35JkfC29gwTPVmPwGsFR9ONe2Uq/MHHtmQ5F0ZwQM96JaQ/
	jiiWR/iOVpSASg3nYxgMYqC0EMGarENYRxYwGywmUdmSXYPjwTPEwdZbQJUh7k8TmneBWtAH4jY
	M4VUbjjcplcAzcOyWEjLeUAvwg==
X-Google-Smtp-Source: AGHT+IFup0B2nTqV79YPEbtafgKs655fF3V8G4NXh7YZFmx8qXmynLB/NFFmZEI3BEJKq/dfY7xg41/30IZOzA6kP5E=
X-Received: by 2002:a17:902:e808:b0:267:44e6:11d6 with SMTP id
 d9443c01a7336-294de7f3b95mr12979265ad.6.1761695655715; Tue, 28 Oct 2025
 16:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org> <20251028155318.2537122-1-kuniyu@google.com>
 <20251028161309.596beef2@kernel.org> <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
In-Reply-To: <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Oct 2025 16:54:03 -0700
X-Gm-Features: AWmQ_blCRWQ09fMUDpVGLUvfkkotj1qXZ_C99Ycg2hp8MBCvCnTaAW7B48KRr2I
Message-ID: <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, junjie.cao@intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, thostet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:45=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 28.10.2025 23:13, Jakub Kicinski wrote:
> > On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
> >> From: Richard Cochran <richardcochran@gmail.com>
> >> Date: Tue, 28 Oct 2025 07:09:41 -0700
> >>> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> >>>> Syzbot reports a NULL function pointer call on arm64 when
> >>>> ptp_clock_gettime() falls back to ->gettime64() and the driver provi=
des
> >>>> neither ->gettimex64() nor ->gettime64(). This leads to a crash in t=
he
> >>>> posix clock gettime path.
> >>>
> >>> Drivers must provide a gettime method.
> >>>
> >>> If they do not, then that is a bug in the driver.
> >>
> >> AFAICT, only GVE does not have gettime() and settime(), and
> >> Tim (CCed) was preparing a fix and mostly ready to post it.
> >
> > cc: Vadim who promised me a PTP driver test :) Let's make sure we
> > tickle gettime/setting in that test..
>
> Heh, call gettime/settime is easy. But in case of absence of these callba=
cks
> the kernel will crash - not sure we can gather good signal in such case?

At least we could catch it on NIPA.

but I suggested Tim adding WARN_ON_ONCE(!info->gettime64 &&
!info-> getimex64) in ptp_clock_register() so that a developer can
notice that even while loading a buggy module.

