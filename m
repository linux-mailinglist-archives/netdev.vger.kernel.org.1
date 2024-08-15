Return-Path: <netdev+bounces-118918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2302953848
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533631F24833
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2C1B9B49;
	Thu, 15 Aug 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbsVmKtp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452991B1429;
	Thu, 15 Aug 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739578; cv=none; b=uiB8sZwSaHRxq88l3l5xEPiP9b+jZlh5syTvaAdZBckfZlyUttxGqOoSczr73U+BW7p0xy0tfZ1AGPngvyL5xZ9oOODkRzvssMSBE+AAbzxz+nc4aPkPe2gjaiYqcfrfwPCk60PP0Kqol8dsli0PkSCJGDwqmYcgFFpCaHr3HPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739578; c=relaxed/simple;
	bh=oex+NN6RpNLLdno9D4x6XuydzPruIYMG1hE1IXuZRM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7xniKssbeVNDWk+xGiJQKLrG+qdLZd6NRZLbkIbHvSiG0QqjBHWssXEsyatLUJovajLYMAJF7B0LEYPjL6MtvtRd6TtO6pzbL0PQUDXUv8EP08KXN5PFXe4m5YNVtaNc+mQK6dz54pBSfJHbN8oCH2lYQxKhKIKLsr112/pGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbsVmKtp; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f025b94e07so13148151fa.0;
        Thu, 15 Aug 2024 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723739574; x=1724344374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YPHhglnz9AoIQWEr0RxYjspKNhJlZykA7F7KTO9WhY=;
        b=RbsVmKtpqzfEAdSFoODLS/ZKbp/rkxD33hL7tXBd2bky16RREth4B2RUgtoLDjS0kO
         6WMCnhSLLu0SixZCdKcfB5N5+G07EBDGJtLd2XZOjb1/En5SM/+xixYvh/ZphovwYrLx
         syWUdcIYC0AQozqIoowwyF/5d/FsKrnmQX9v1LvngfTEcTnWkBE3DgbtNtcDwinAcYe6
         nl+aPdFIHSWjiDANX1iiwc6vn0f4eFLf2OPkzOIqjyVHH+cZx9vrHsl5LhlegOChjn7J
         EedGpTqo9I2s6QgmW54Y4dYGilyqSk5UYROVbwkikeOFk3idsYPEvqL4724yww+qs9c9
         vkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739574; x=1724344374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YPHhglnz9AoIQWEr0RxYjspKNhJlZykA7F7KTO9WhY=;
        b=G4LfaYeQ8W1NB0ytCBjecMN+iwPV0tvFMIWcXggngbM7dWd0cJ9AMjwVpSNj1CineS
         pLJUj1WF5D6ZMQorlpM6WaLmecgCx+72aOul4/Y1Wbo9AlOwsuLDVezVth7sJqoC0udm
         ZWwZFVw+jMKjaatLPsPMFOgppFe/QqtmzhFz5sLSOQ0o7ScTBRbQqBY7IF3SOPWGGWuz
         tSExYm3mfA/cmSD/eVATiY5GLlYpwCCwlMZX33QW1aiX7SbCol9nLwCRUtZyi5QZWA5U
         d4GZMGDLQlENqJlkmmgKwB3BgI2ouPM9Ifmfmbv+TGuGiuTlFhEkeNTt6aGWRAEbEH/w
         0NGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Zd5YmHWv1Ylj7nHAB7AUr+XQHaAzX1+hfkvijHPbLEG4sNsxfT9QNiMoGSJPqOAzwJGUFdqS0oHnY6c9c59dFyO7s1fKy8gtf9j0Curfp0ArIYeUOWauk0tyDEPPeXA25qx1bbt8
X-Gm-Message-State: AOJu0Yyk7L3yb2k8xaG4Sf5wKVcA71HoTljpOEq44LAZ7DCoud/MSG8v
	5ulTrCdQu8qdaDq8ELcGwmDg075GNQxxaHpKOvdhBVFf/Juap2bR6zDtaNYVGRwMyy3J1ZGt/sI
	o05+vteXQbG8hmeY32JvwkKGm99OYRT6p
X-Google-Smtp-Source: AGHT+IHtUB/ZB9bSRJKkA5F6lU6s40qmXBUALwJKt7aJT1CtiPF7hLpDBlgVAesiIXOcCXARUeuEXrtDoHJH8LYKJlA=
X-Received: by 2002:a2e:6111:0:b0:2ef:18ae:5cc2 with SMTP id
 38308e7fff4ca-2f3be5a1facmr1512131fa.21.1723739573816; Thu, 15 Aug 2024
 09:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807210103.142483-1-luiz.dentz@gmail.com> <172308842863.2761812.8638817331652488290.git-patchwork-notify@kernel.org>
 <CABBYNZ+ERf+EzzbWSz3nt2Qo2yudktM_wiV5n3PRajaOnEmU=A@mail.gmail.com>
 <CABBYNZJW7t=yDbZi68L_g3iwTWatGDk=WAfv1acQWY_oG-_QPA@mail.gmail.com>
 <ZrZ0BHp5-eHGcaV-@zx2c4.com> <CABBYNZ+3yMdHu77Mz-8jmEgJ-j3WPHD8r_Mhz8Qu-bTJbdspUQ@mail.gmail.com>
 <ZrZ6MUj2egxakWUT@zx2c4.com>
In-Reply-To: <ZrZ6MUj2egxakWUT@zx2c4.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Aug 2024 12:32:40 -0400
Message-ID: <CABBYNZ+usGWfFjHeO0n=ndyb4+xLZTQasAPeQM37y=2AUektYQ@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-07-26
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Fri, Aug 9, 2024 at 4:21=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
>
> On Fri, Aug 09, 2024 at 04:02:36PM -0400, Luiz Augusto von Dentz wrote:
> > Hi Jason,
> >
> > On Fri, Aug 9, 2024 at 3:54=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.=
com> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Aug 09, 2024 at 11:12:32AM -0400, Luiz Augusto von Dentz wrot=
e:
> > > > Hi,
> > > >
> > > > On Fri, Aug 9, 2024 at 10:48=E2=80=AFAM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Jakub,
> > > > >
> > > > > On Wed, Aug 7, 2024 at 11:40=E2=80=AFPM <patchwork-bot+netdevbpf@=
kernel.org> wrote:
> > > > > >
> > > > > > Hello:
> > > > > >
> > > > > > This pull request was applied to netdev/net.git (main)
> > > > > > by Jakub Kicinski <kuba@kernel.org>:
> > > > > >
> > > > > > On Wed,  7 Aug 2024 17:01:03 -0400 you wrote:
> > > > > > > The following changes since commit 1ca645a2f74a4290527ae27130=
c8611391b07dbf:
> > > > > > >
> > > > > > >   net: usb: qmi_wwan: add MeiG Smart SRM825L (2024-08-06 19:3=
5:08 -0700)
> > > > > > >
> > > > > > > are available in the Git repository at:
> > > > > > >
> > > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blu=
etooth.git tags/for-net-2024-08-07
> > > > > > >
> > > > > > > [...]
> > > > > >
> > > > > > Here is the summary with links:
> > > > > >   - pull request: bluetooth 2024-07-26
> > > > > >     https://git.kernel.org/netdev/net/c/b928e7d19dfd
> > > > > >
> > > > > > You are awesome, thank you!
> > > > >
> > > > > Im trying to rebase on top of net-next but Im getting the followi=
ng error:
> > > > >
> > > > > In file included from arch/x86/entry/vdso/vgetrandom.c:7:
> > > > > arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c: In function
> > > > > =E2=80=98memcpy_and_zero_src=E2=80=99:
> > > > > arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:18:17: error=
:
> > > > > implicit declaration of function =E2=80=98__put_unaligned_t=E2=80=
=99; did you mean
> > > > > =E2=80=98__put_unaligned_le24=E2=80=99? [-Wimplicit-function-decl=
aration]
> > > > >
> > > > > I tried to google it but got no results, perhaps there is somethi=
ng
> > > > > wrong with my .config, it used to work just fine but it seems
> > > > > something had changed.
> > > >
> > > > Looks like the culprit is "x86: vdso: Wire up getrandom() vDSO
> > > > implementation", if I revert that I got it to build properly.
> > > >
> > > > @Jason A. Donenfeld since you are the author of the specific change
> > > > perhaps you can tell me what is going on, my .config is based on:
> > > >
> > > > https://github.com/Vudentz/BlueZ/blob/master/doc/test-runner.txt
> > >
> > > Could you send your actual .config so I can repro?
> >
> > Here it is.
>
> Hmm, I did a clean checkout of net-next, used this .config, and it built
> just fine. Any oddities I should look into?

Something is wrong with asm/unaligned.h on my system, if I do the
following change it builds properly:

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index b230f0b10832..c1a18f5c6fe3 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -10,7 +10,7 @@
 #include <vdso/getrandom.h>
 #include <asm/vdso/getrandom.h>
 #include <asm/vdso/vsyscall.h>
-#include <asm/unaligned.h>
+#include <asm-generic/unaligned.h>
 #include <uapi/linux/mman.h>

 #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {
         \

My system is based on meteor lake, not sure if that is affecting the
build with a mix of LP+E+P cores?

> Jason



--=20
Luiz Augusto von Dentz

