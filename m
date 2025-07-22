Return-Path: <netdev+bounces-209052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D50EB0E1E0
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505271893C03
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA127A906;
	Tue, 22 Jul 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8vHy8OQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D55234
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201708; cv=none; b=DFAjCArnyGrdp7Uxz65ugYSRgyf2SD5Dh1YIXfInyogHba8b1ACVa2CtMOCg4QvwrizFEYGtt59zN1b3gFVqBfuJg+DMW08aD9LLr8Q5SVhRWNjHHLy9iB1/ShoS1Omw7g0am7ZswlKWD36HBPvYjS7pS5xJhPfFAqYpt/+YTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201708; c=relaxed/simple;
	bh=2ngJ2kRGxmj//2+PG4hWPab7EQBzvrPtsys183PFZbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIfb6cdZJ1dYHk/yYvFpCEIfN64Ty4Ly0kh1T/VnjiVG6kJEJdUDOj1sV3uSie5p3oByhIV81Adh5SzSjbhk7EAKaE1hLT2Oo7FVxegEGUbCKqMEIRa3/OVLkkj5Vuo3spX4PPyBkd0fFVQExbUz7uOKufU5HnIZfSWSO4eTPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8vHy8OQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab63f8fb91so49069681cf.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753201706; x=1753806506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sCVh46Bww8YRXEQZffVRJrwKL4AozPZ8WZKTowec4g=;
        b=N8vHy8OQ9bsblLRAzmvynCHnw0vLIt+CFVyvhvdlDniFHfYd9TxvQgfU+p6upH4gjn
         YltGolAWxmtkvHQ3aB0TnmkKd4kMsngQt5aeBtoP1O3OOwoDQoA/Y8ZxOxHN0PKdbeca
         ApQGypgC5Nda5ihtdsoN9fMA0sPazRrDIBc53j7bZkX8qawu6cwSNT//qoFOmKlnqYsE
         U4yBhKrCXtIfNkEnV2mQ7BHs1H1+rMV1ZKFdrqSJgS2+hLO9snm2V/HT00gZi9/6zadF
         Fjuv9ZQe41MEEEZWQjVHphlgbppl4G55cKzn4ruNpm8HSCNX4Vj4XqDNwxeWnazvMS4b
         mOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201706; x=1753806506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sCVh46Bww8YRXEQZffVRJrwKL4AozPZ8WZKTowec4g=;
        b=lXCatJeGj+qbSYm2aAxz9eoeupKxcsw9MFYFuzHdNGT4lzMfID5vs+VzJIIoZCaZll
         ZwTD+0rNtjbXzA/l8P80/TGOQJHjHtpUp4qC2uMxuQUC4Klry+x9hVwDOonRzZQClA+C
         CO4XdFgDP5MKjVaDnrpZrOJvx2cvdd/9mH1+4nEZPrMnKnI5rbzGk6Wtj9lq2NzBwRxD
         Y0pjlpsAViFkhwc5mwaUt8FeuS+gsrGwI2bu7b3OEIUp1tuf+KYz9B21LXeeCb5jvMDw
         bFx3AVBqYB4UnZbGn7v0BYwztoXnC8zBWtB9zaa9glDgBc+dly0iS/od8MnzpfsoUhzc
         gArw==
X-Forwarded-Encrypted: i=1; AJvYcCV+vPajxa873E8xOuX3JQVBSN1EmQcjrhxoXVpWqn+Gd23Ob3+Y2hmBdQpgHK3mSpsSCwjVdBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKm2ojwFNxupFddi+lhrTVX2A+coEHNT3oxseUkcsFfHzo280
	X/ZTNKMhut7BDnLzJGH69qzmbugktKdpA9p4/6UIc/GFP1OIbMRnLzwf+GeMhSZHeZ+2sNIh1FL
	vRMpOvx0NRB1QFKcbpMlBgjFNIyZ/KXTa+6+roYYB
X-Gm-Gg: ASbGncsYrvf4Y7AAlVOskFgt5AM5fg5HYGq4MyyV4PEjMJOOPZcDEw7FFmkLcBISaM8
	cZGNF66HgQhZNZgW7C5K3YD4l4vPsCaujQLxm44eym0TOdLYaGvkTgjFLgFnynsDJ4ZxctnztnM
	QizXGvQ52NPvdT7QwURQLkrllv4/CUhZiiK3/QSnjKYevHyCprMm/SxePLpVUQXU4Db7bx6WDOq
	U3QmFHgQtj+1+JA
X-Google-Smtp-Source: AGHT+IGKZynev0wRanI4s1eGTM+ft5BRNAdPwJV6J2EKTZZT9RumWxttQkZsc++d0yfo5VetxU5YpsYhHadXnkW1sEs=
X-Received: by 2002:a05:622a:15c1:b0:4ab:6e68:117d with SMTP id
 d75a77b69052e-4ab93d4837amr332784471cf.24.1753201705864; Tue, 22 Jul 2025
 09:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
 <CANn89iJgG3yRQv+a04wzUtgqorSOM3DOFvGV2mgFV8QTVFjYxg@mail.gmail.com> <CAO9wTFgzNfPKBOY5XanjnUeE9FfAGovg02ZU6Q1TH-EnA52LAA@mail.gmail.com>
In-Reply-To: <CAO9wTFgzNfPKBOY5XanjnUeE9FfAGovg02ZU6Q1TH-EnA52LAA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 09:28:14 -0700
X-Gm-Features: Ac12FXy4knn3eMDleOqMY1e7I4kseMX2vfET1LKRx4dKWQ_shE1ef1-YvpuilDg
Message-ID: <CANn89i+dif2qjKM6oO1o=BKutXoO6w9kWnnPfc50BDBJ7VpAeQ@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, sdf@fomichev.me, 
	kuniyu@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:22=E2=80=AFAM Suchit K <suchitkarunakaran@gmail.c=
om> wrote:
>
> >
> > WRITE_ONCE() is missing.
>
> Oops, I'm sorry about that.
>
> >
> > > +               while (i >=3D 0) {
> > > +                       qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> >
> > What happens if one of these calls fails ?
> >
> > I think a fix will be more complicated...
>
> I did consider that, but since I didn=E2=80=99t have a solution, I assume=
d it
> wouldn=E2=80=99t fail.

But this definitely could fail. Exactly the same way than the first time.

I also have a question. In the Qdisc_ops structure,
> there=E2=80=99s a function pointer for change_tx_queue_len, but I was onl=
y
> able to find a single implementation which is
> pfifo_fast_change_tx_queue_len. Is that the only one? Apologies if
> this isn=E2=80=99t the right place to ask such questions. I=E2=80=99d rea=
lly
> appreciate any feedback. Thank you!

I think only pfifo_fast has to re-allocate its data structures.

Other qdiscs eventually dynamically read dev->tx_queue_len (thus the
WRITE_ONCE() I mentioned to you)

