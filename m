Return-Path: <netdev+bounces-118925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD17B953869
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDB91F235D9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD01AC8B2;
	Thu, 15 Aug 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS+9wkdO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AE1B9B59;
	Thu, 15 Aug 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739940; cv=none; b=AS3p12FHd3l60FDLK1VKasI0Sy1izf/xcFkFNNxQu+XuDlMoUVP+HlgOXnyfqSLSNLCg9TXeQJWLbgEAjuWvepM8lc2hvxcNOzFyruJLkgDG6VNzYS96vZIm1+0R1zvGuOa+L35Edd4bWfVgQ1JCOSTDh+YEOsLrTayyxyEsKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739940; c=relaxed/simple;
	bh=c4TQb/OkEEVaG8Pi6rTPvz/w2ofTmhjlSrJsCtnO1No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXzExi3QYBtOgqytuCLlrKpkE2msq5tq/SImhMICMsJMQe4ARHZ3a/bcDVch5h4xN6LmsxuKXfHf4fnm2PziKYecjo8ksy//8w5AKWnoBMSWNkc+QZvmYd+bqO8jRmTf47uDuqIHUQRjVB+w3YRyhf54MWbn0XQsJO5UaLUtNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bS+9wkdO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso15814831fa.1;
        Thu, 15 Aug 2024 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723739937; x=1724344737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ltd3dFU6KqzAIVKoCFdt6BnHRMNHVSodtgtZQ7hBEU=;
        b=bS+9wkdOUEMCHYmDQH9702ZISnuRcZQD9aXfRQbrIR+tUtKMoazO3bZB8U3/uM8EfG
         hZcxtFEbzlI5QvCwTOkiKNLMzC57n6nW4Z4jHhrq0zOTyQU94FHwgS8+tvYZKzVHzsTB
         kdaApq24e63w/OtVdMWlYDhpYJkEMWOBMs0D7XjrOTMUsqCFFFZhUTE/VYtBD+wceeBN
         dq5m4gN3TZ7w3yXx7UmUTSPFLb3hNfNSEEabT1K1wPO+Ov0RzPbCZHnDTZIiCM6QttX3
         YVEL/RpkM6ag+9rAut20TNlNg4NXC25uDIoa+YOFBpUKQoGeZofBJ3bbE6J174wie3R2
         p7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739937; x=1724344737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ltd3dFU6KqzAIVKoCFdt6BnHRMNHVSodtgtZQ7hBEU=;
        b=jXOLYc53X26b/jC8Mna2UGOOp9f7AU7lTeOmKnra3Teh52nrNjqX8gj7ktayZGiviN
         nPWFJyInBS+2s20Fh+hDlW0bfbQhI4skFL9Wu52n2fBk7KljdzD7LLZi8f6bPZa9c9hL
         CVBz9j+AGBG4LzswtuVr/vsvzMcrMPzFxro/UOJtD0GL9y1xgVgppAL3ych8cGC1JTDC
         6t94BZI5pW6wYJIZNJ6dyr6/kVA7L5auv48Mp9k7thlJJ5W0Y/LYCt10xYT5TWpkRLqj
         tJoHM56dXF42gHf6Awrb/DnPXcDFV2GuLnoY8Xq9qLgMqh5E/0Un7asEus7FaptyY/Yj
         zvtA==
X-Forwarded-Encrypted: i=1; AJvYcCWnYHJ32yI1iD6FvStuYSS88GeNVBml9yXGzUZJAIR4isPAhO/r4h6PCWh8IShdUBjayXtSum0BZeXNz0A4ADsrMme4VkYo4AV2KdWzhIlUzqf+sE+bQux6aq8uyLldHk0bnZsIzDyF
X-Gm-Message-State: AOJu0Yx/FQxw/EmlgOYbtcZHOIzb3b7IecgP3tn5m33TuN6N8jbbic25
	X2IevQDqHa4rWJCynTRV8XX9Cxfkww2wXOoZM96Q4qqcx1OnKQeE0bW65uj0Tu3qBqiRCPjbp6Y
	95NvizR/DAuwTxh68OaHI+UGTuLU=
X-Google-Smtp-Source: AGHT+IEPAiMG52d+sNXUkj37HOpXZNaWzXULpUX+4pMpK4o+YycvgJ7DOpBMrO/IEc/lS8CKyKbZLiITro2+S9KN8fE=
X-Received: by 2002:a2e:f01:0:b0:2ef:2b1f:6c4a with SMTP id
 38308e7fff4ca-2f3be5f7d90mr1499291fa.30.1723739936106; Thu, 15 Aug 2024
 09:38:56 -0700 (PDT)
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
 <ZrZ6MUj2egxakWUT@zx2c4.com> <CABBYNZ+usGWfFjHeO0n=ndyb4+xLZTQasAPeQM37y=2AUektYQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+usGWfFjHeO0n=ndyb4+xLZTQasAPeQM37y=2AUektYQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Aug 2024 12:38:44 -0400
Message-ID: <CABBYNZ+1QzsPA8KzXBHoRFQdOuE5WGdJ28QYfWOOY1-HE-_a3A@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-07-26
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Thu, Aug 15, 2024 at 12:32=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jason,
>
> On Fri, Aug 9, 2024 at 4:21=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.co=
m> wrote:
> >
> > On Fri, Aug 09, 2024 at 04:02:36PM -0400, Luiz Augusto von Dentz wrote:
> > > Hi Jason,
> > >
> > > On Fri, Aug 9, 2024 at 3:54=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c=
4.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Fri, Aug 09, 2024 at 11:12:32AM -0400, Luiz Augusto von Dentz wr=
ote:
> > > > > Hi,
> > > > >
> > > > > On Fri, Aug 9, 2024 at 10:48=E2=80=AFAM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Jakub,
> > > > > >
> > > > > > On Wed, Aug 7, 2024 at 11:40=E2=80=AFPM <patchwork-bot+netdevbp=
f@kernel.org> wrote:
> > > > > > >
> > > > > > > Hello:
> > > > > > >
> > > > > > > This pull request was applied to netdev/net.git (main)
> > > > > > > by Jakub Kicinski <kuba@kernel.org>:
> > > > > > >
> > > > > > > On Wed,  7 Aug 2024 17:01:03 -0400 you wrote:
> > > > > > > > The following changes since commit 1ca645a2f74a4290527ae271=
30c8611391b07dbf:
> > > > > > > >
> > > > > > > >   net: usb: qmi_wwan: add MeiG Smart SRM825L (2024-08-06 19=
:35:08 -0700)
> > > > > > > >
> > > > > > > > are available in the Git repository at:
> > > > > > > >
> > > > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/b=
luetooth.git tags/for-net-2024-08-07
> > > > > > > >
> > > > > > > > [...]
> > > > > > >
> > > > > > > Here is the summary with links:
> > > > > > >   - pull request: bluetooth 2024-07-26
> > > > > > >     https://git.kernel.org/netdev/net/c/b928e7d19dfd
> > > > > > >
> > > > > > > You are awesome, thank you!
> > > > > >
> > > > > > Im trying to rebase on top of net-next but Im getting the follo=
wing error:
> > > > > >
> > > > > > In file included from arch/x86/entry/vdso/vgetrandom.c:7:
> > > > > > arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c: In functi=
on
> > > > > > =E2=80=98memcpy_and_zero_src=E2=80=99:
> > > > > > arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:18:17: err=
or:
> > > > > > implicit declaration of function =E2=80=98__put_unaligned_t=E2=
=80=99; did you mean
> > > > > > =E2=80=98__put_unaligned_le24=E2=80=99? [-Wimplicit-function-de=
claration]
> > > > > >
> > > > > > I tried to google it but got no results, perhaps there is somet=
hing
> > > > > > wrong with my .config, it used to work just fine but it seems
> > > > > > something had changed.
> > > > >
> > > > > Looks like the culprit is "x86: vdso: Wire up getrandom() vDSO
> > > > > implementation", if I revert that I got it to build properly.
> > > > >
> > > > > @Jason A. Donenfeld since you are the author of the specific chan=
ge
> > > > > perhaps you can tell me what is going on, my .config is based on:
> > > > >
> > > > > https://github.com/Vudentz/BlueZ/blob/master/doc/test-runner.txt
> > > >
> > > > Could you send your actual .config so I can repro?
> > >
> > > Here it is.
> >
> > Hmm, I did a clean checkout of net-next, used this .config, and it buil=
t
> > just fine. Any oddities I should look into?
>
> Something is wrong with asm/unaligned.h on my system, if I do the
> following change it builds properly:
>
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index b230f0b10832..c1a18f5c6fe3 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -10,7 +10,7 @@
>  #include <vdso/getrandom.h>
>  #include <asm/vdso/getrandom.h>
>  #include <asm/vdso/vsyscall.h>
> -#include <asm/unaligned.h>
> +#include <asm-generic/unaligned.h>
>  #include <uapi/linux/mman.h>
>
>  #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {
>          \
>
> My system is based on meteor lake, not sure if that is affecting the
> build with a mix of LP+E+P cores?

Sorry for the noise, it seems that there is some leftover when I
switch branches since on bluetooth-next I do have
./arch/x86/include/asm/unaligned.h but on net-next that was removed
but it was still left on the tree for some reason.

> > Jason
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

