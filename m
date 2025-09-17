Return-Path: <netdev+bounces-224142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3CB812CC
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E72D46486F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2252FDC44;
	Wed, 17 Sep 2025 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlisNqr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB32FBE1E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130142; cv=none; b=fdEXEYhhXxmJ9a+xBJRc2ffb/APrJgokzmMvkfAq792Kpu1qZEz6QGMPsNXMYQRgV8p1NF/gzZ1XosKlWnrGNwxzA9ItfdZDZZGcWp+IIc9r0elFRzZFK2dGUcMHFyFDS/Sf4mbrC1x2vxp0E3I4Yeb3/XFp/zQb2y4G1N2TkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130142; c=relaxed/simple;
	bh=H0/gKaaxvlfYUtn6gGmXwBaSMrd32CreXcUAxjE7SsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i71Ns2791KOCKFK++lxb4ZgV2FEPkCqhzUkYFowJF3RtCZtP+wC8zdBdGKoIcC0M9RGBkndvVe/NF2Ty7SiRXZcfi0rl+7sRM8NMCcwAsRbZHL2tRk1g3lpvk3C3hvdlmD9871YAT4vRzDTvqXH/p+4lzXL1vEcj5vG2cbAE0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlisNqr2; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-424195ca4e6so11925ab.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758130140; x=1758734940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RibQXdSsRsxO3CMdVMzbtMJw7Z5sCxH0F5qvTjzb6hg=;
        b=JlisNqr271lgjusZZ0kBrDI7SWUqscYVkr35CJZ53bao6qQNnsSSR773G8awmSoM/f
         CIpzR1dDMlyCUtSBy6xL+p8nfKUcT8JHH6vsb79XlUoFb54wlCEcUgR9VmBhG6Qe4wlX
         khFskVwVAlUyAuFU8r+PfBaa3xS23JQKZZcNgAWx1XjI6yRCJ2j19jx5X6+7bUA317e8
         ijtIdOaQnMOCkHsD6jZicbFNDithItvMHp3wjTbn6abxfdAGN+a/bmrVCjrgsQF/yGs4
         O7DNprs6w9+fIfUeRMqazGK8442LMBfRtzQzyEN174kk3BhfRd7Oi+0dgFYeihAX8+oa
         lqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758130140; x=1758734940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RibQXdSsRsxO3CMdVMzbtMJw7Z5sCxH0F5qvTjzb6hg=;
        b=Z0gN9dJ5w/vzUKSCXyDdYIz0BSCQvFs0XxU1d0UW1psxRX3cSmlldxU62d9xm7AeI/
         EnLUW+CoNIYirVTfM7gPmzK83RypgREsOvZ0skrikIBd9GUo2EWLPGm1Psa5oIdRQPSG
         VzyRRBnjnV/JZcbh9kYUW44VXGLtykkqhKUL7LVTNMnERND4RKiJKtpDxffwUFXJfINn
         bPjXn0Cvlstm65GayxR40yYO0/dMCaWSRiE7VlDrdyZ/aTIrpz13jhJreg/ZlxMSKNYH
         y0RRkxAmB2RVSAZSd9wa9kl+5wEMzgy/EktPpGjk+XokKlyI67V2YIyX4X1w67XyehLt
         zraA==
X-Forwarded-Encrypted: i=1; AJvYcCVrEDrDuoNz5QkPrwaORxCFcvrRTb+Ugs9pFhGQ4GJx2/OzluTAUM/9roRk+Py2Ik+V9Mhkf1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAAXb53iL8l/F40buYA66bG1sCXAQIq7S10tJ3ICHc27IbNM6
	c0SDu94SMYSA2GEankZpEwLqjqXph/toJCs7M/yZms4ZI0epGMjjIL5enphGWGiRshuVYmCVILZ
	rrBfKP7PpUJYmGYav8hHxLLpYfyBj2StGBywTIh22
X-Gm-Gg: ASbGncuSORrdSgTmEt/rshGbLf2T+aAwSCFHYvQB9K3mAllA10oCClAKv97tH2xAeKP
	DnM2VE2eS4dkZ49FjpfBMGK6Eq7mY284jsp55O2vLq9Fa2WvZTfw0v7KNJioJF5+S18d2P+v3k2
	TKoM+UbbSivnj+W4IYV0mOZVr45t30pWdqNze8hYmyWNXsqsQmwmk6pquimnc+FS9TRGZHqqOM/
	i1UuHd+KOdkd42EWd+6PPlkLeYM+ZWySDrLiV+PRlz0
X-Google-Smtp-Source: AGHT+IFFGrAyXguz20mFyMKBXRRfTnkPERkiQ1wXQwdoDKL/pxWsskk/k1ikwhW0kYf3w5UWArMFVx4/etlizuFuw9Y=
X-Received: by 2002:a05:6e02:168d:b0:422:62f8:20f9 with SMTP id
 e9e14a558f8ab-4241863c4d8mr7806975ab.8.1758130139286; Wed, 17 Sep 2025
 10:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135337.1736101-1-edumazet@google.com> <CAEWA0a6b5P-9_ERvh9mCWOgbH6OYdTUXWVGgA20CQ5pfDC2sYA@mail.gmail.com>
 <CANn89iLC+Gr9BbyNQq-udVY-EZjtjZxCL9sJEpaySTps0KkFyg@mail.gmail.com>
 <CAEWA0a4x4XMZKtpz_pNKruC4zwjETVxUuEMs2m_==Dpib_Jrqg@mail.gmail.com> <CANn89iKZDvL9vKbmDa4ivnrm11e0fc65A-MXs8kY4MxR0CnGTw@mail.gmail.com>
In-Reply-To: <CANn89iKZDvL9vKbmDa4ivnrm11e0fc65A-MXs8kY4MxR0CnGTw@mail.gmail.com>
From: Andrei Vagin <avagin@google.com>
Date: Wed, 17 Sep 2025 10:28:48 -0700
X-Gm-Features: AS18NWDPgb9cZN1-L4a4OUlkwPSMPcDLR2W5EDAL9vUYoqX_KqKda6HCCMD9wfE
Message-ID: <CAEWA0a7fnv3hRJyYGkP9yjcG-dAGFbb0JjdmTF3a5kk6n3RAOg@mail.gmail.com>
Subject: Re: [PATCH net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:20=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Sep 17, 2025 at 10:03=E2=80=AFAM Andrei Vagin <avagin@google.com>=
 wrote:
> >
> >  is
> >
> > On Wed, Sep 17, 2025 at 8:59=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 8:39=E2=80=AFAM Andrei Vagin <avagin@google.c=
om> wrote:
> > > >
> > > > On Wed, Sep 17, 2025 at 6:53=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > Andrei Vagin reported that blamed commit broke CRIU.
> > > > >
> > > > > Indeed, while we want to keep sk_uid unchanged when a socket
> > > > > is cloned, we want to clear sk->sk_ino.
> > > > >
> > > > > Otherwise, sock_diag might report multiple sockets sharing
> > > > > the same inode number.
> > > > >
> > > > > Move the clearing part from sock_orphan() to sk_set_socket(sk, NU=
LL),
> > > > > called both from sock_orphan() and sk_clone_lock().
> > > > >
> > > > > Fixes: 5d6b58c932ec ("net: lockless sock_i_ino()")
> > > > > Closes: https://lore.kernel.org/netdev/aMhX-VnXkYDpKd9V@google.co=
m/
> > > > > Closes: https://github.com/checkpoint-restore/criu/issues/2744
> > > > > Reported-by: Andrei Vagin <avagin@google.com>
> > > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >
> > > > Acked-by: Andrei Vagin <avagin@google.com>
> > > > I think we need to add `Cc: stable@vger.kernel.org`.
> > >
> > > I never do this. Note that the prior patch had no such CC.
> >
> > The original patch has been ported to the v6.16 kernels. According to t=
he
> > kernel documentation
> > (https://www.kernel.org/doc/html/v6.5/process/stable-kernel-rules.html)=
,
> > adding Cc: stable@vger.kernel.org is required for automatic porting int=
o
> > stable trees. Without this tag, someone will likely need to manually re=
quest
> > that this patch be ported. This is my understanding of how the stable
> > branch process works, sorry if I missed something.
>
> Andrei, I think I know pretty well what I am doing. You do not have to
> explain to me anything.


Eric, please don't misunderstand me. I want to get this patch into the stab=
le
kernels as soon as possible. I appreciate your help here.

Thanks again for the fix.

