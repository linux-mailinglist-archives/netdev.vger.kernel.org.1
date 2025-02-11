Return-Path: <netdev+bounces-165158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F4A30B7E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256207A49BD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C883025332F;
	Tue, 11 Feb 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWzCX/nN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521E24C671
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275918; cv=none; b=JpxjEbBPzFzcU14QRqt6rfpdtkVNl9+tlhGnIYcus1byZZbTPT3LlIREJyVQWInbHG8lPsz6F23OwB5XDqwvXAxEoR0T6/mWG3DHNCXmIdKP4ua7plcTg8o8dj+S/EkHM+qxDVSREtzJhypwue287dhviSWr01Nxb2oF4E3eB6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275918; c=relaxed/simple;
	bh=9kUhc7xl6mK6FtG9qv/EtCxmuNix+RvSOrWwAt/0ImY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awIencfbKfH1rR0xhUAYVElMTm7DrJo0XdG5/ps7Bm/FsVgj0N4IrZ+Y2F/unKN2PBftJKklvgXaJGdwmYyZBezGA7/vgLZqvVdzXqkYK4yH6Z36ANpquxkk2p9DQkhjK6iKfSi9rjqEwDpUKdoB2Aw3m+Mj+HjmN8CcVka+gV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWzCX/nN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso6054968a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 04:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739275915; x=1739880715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noORodC8eJauXHSwu7JFMsa7CCMymPsH7IaAfTCYkT8=;
        b=FWzCX/nNJRdhr9beVdlLQJKSYGmQoWrLnlUVihL7Ezz3AMKvguGtxyEP9n9cyFRD7d
         IGN7Gbr+3qja/Cn8G/ysubw1SVBMaQDQeXFzqejvBv07hA7lZPsbPWr/ZUZL388s/GPx
         4AZ8/iZmV+whrqmWIBwQ3LCP3lnVKACI8D6ZUhYuciZ0/DjVKEaMSo/0MlFAjFMLpPwt
         FQQFrGhD4kFdXSlp6/1mOvq9G1jIdv5NbNGoTYPCvfaxdbHIkjsYEB5FykTAX0nb+mcG
         ugx9O/FHKFsiOri1Ah/Mr05gfSGM8m87e0rja2Xa9cQZWLpFz/KKTQH4IXaU7avQ6nWr
         yaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739275915; x=1739880715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noORodC8eJauXHSwu7JFMsa7CCMymPsH7IaAfTCYkT8=;
        b=iUPC/K1fHsz+65ujIcxaDklDBHA+4JblHTOH8DaeYtYGGn4VfX3Wr6BiwcBIhDgFGL
         6ztOIJut75QAJysdRgTuBSYX0fuXtWImVt93vEucTot/2dhjra7n/TLAakVs1mqODC1p
         xKvs0AKAiBzCxXzhrrpV/Ls2wtFUDhNTYxq+HDa9tkOer35YOmpgWqEwP7zC9RY3sald
         u9g6R8Mr2t43ruUsMWb6mB4mY/+C/yePtQ4zYlpJTbF+cYpADAt2wQ6xhvuTZXfDpBJV
         3j3X+JbTt4rrXK2DV4X+1ySniShwR++tUJaACvKuoSw5v1dAtiXXEh/98a9YSMniRsec
         G0ew==
X-Forwarded-Encrypted: i=1; AJvYcCVUH5Nz7eThS+78gDSayXXqaPUDDSMq4CPDIjjUOrODAIsmQ07R+FCivOXkJZJLzHdoyFxxJ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21tsDbGIoyjhX09epwAab3pos8Fx8Qr9Gkd6zQEN2UCVj6/4t
	X07HMrLq7elmMc2RdDS/0pdBiOdfDWupMbtu1JvlhnvbaxLCYd7Wj08FK3DwUMDiumKkzycon7E
	0myQzldKV1Dvmv0F6ggp9fr+SzVPuyVME4Iyu
X-Gm-Gg: ASbGncstOPkGBZBHcKtGJA0lkremE8DK6wsT0yPFCKVkYTDKb+h6yu7xvKMscaVpStA
	dvtUtPR0uYMghFup2d5HiTQSdpdSXeNLoIe9SU9UuYBIkwALgjoDmDnRo7N+XogZVJXe+Ruw=
X-Google-Smtp-Source: AGHT+IFBxztBYpfICsyJIWE1dpWOwhxEB7LLhq6al5vWh0ZOYPHdFhb048EfHLyedbvE6WIgBTPV4R+XdwEIM3DCXhA=
X-Received: by 2002:a05:6402:254e:b0:5dc:7374:2638 with SMTP id
 4fb4d7f45d1cf-5de9a394514mr3181412a12.7.1739275915228; Tue, 11 Feb 2025
 04:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY8P300MB0421A0CA0D6C69A8BE4767A7A1FD2@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY8P300MB0421A0CA0D6C69A8BE4767A7A1FD2@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 13:11:44 +0100
X-Gm-Features: AWEUYZkkWwiCaZee0oA7l-edrRXJciPS57JSeEV9SVREQ1J2ULGF-WM2UrxXs84
Message-ID: <CANn89i+7cj3y05h9ee1ha1dykbSx6J=7QubBp7NMphQqtpA1iA@mail.gmail.com>
Subject: Re: BUG: corrupted list in nsim_fib6_rt_destroy
To: YAN KANG <kangyan91@outlook.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:04=E2=80=AFPM YAN KANG <kangyan91@outlook.com> wr=
ote:
>
> Dear maintainers,
>
> I found a kernel  bug titiled "BUG: corrupted list in nsim_fib6_rt_destro=
y " while using modified syzkaller fuzzing tool. I Itested it on the latest=
 Linux upstream version (6.13.0-rc7) .
>
>
> After preliminary analysis, the bug is triggerd in  nsim_fib6_rt_destroy =
function  drivers/net/netdevsim/fib.c
> when kernel try to delete node from list :  list_del(&fib_rt->list);
> the node has already unlink from the list.

This analysis seems to be AI generated, this is literally rephrasing
the call stack.

>
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: yan kang <kangyan91@outlook.com>
> Reported-by: yue sun <samsun1006219@gmail.com
>
>
> I hope it helps.
> Best regards
> yan kang
>
> Kernel crash log  and reproducer are listed below.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Syzkaller hit 'BUG: corrupted list in nsim_fib6_rt_destroy' bug.
>
> netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 fami=
ly 0 port 6081 - 0
> list_del corruption. prev->next should be ffff888112b16f28, but was 00000=
00000000000. (prev=3Dffff8881083184a8)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:62!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 9911 Comm: kworker/u8:4 Not tainted 6.13.0-rc1 #5

This is not 6.13.0-rc7

