Return-Path: <netdev+bounces-189960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D298AB49A3
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F301B406D4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E951D5CDE;
	Tue, 13 May 2025 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlcqFKN3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A51C2437
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104247; cv=none; b=EoxmHoUepAHTFT2nOIiI7liaKSwzD1yiBVTxzrbntvyb5k/SUaK3Qsx6F+2Wjfk6sClh0d6FkRwDDCdVx2u2EwmxMClIkEu5mLyJ07LshkCQmf7Km3h5pSq25r7xxJaPwWajbH6OOfJlJo0drhTG29YAZiAqa3yYo7xDoqgQWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104247; c=relaxed/simple;
	bh=8Z3gNtiUrVzjQ6mwOFnXbxG8lOzGWoiM2Ptidb9/kmc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=du0vOI/XmLSdoJXV8dOzFxg9Ey7wTowpW+ZtpaIA9m99zP4WfJS5sEL1p6iRcx5GsPsHqcq+GLGMYtsCCCR+u+UcKhcy74NB8gwxOgWfStQpqlXs487w+OOicvsJiHxwtp4Fl1TTM9KrFgkLOpOYp49+6mZ3Q5wSCkr83tkQKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlcqFKN3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4775ccf3e56so75131931cf.0
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747104245; x=1747709045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3Hb6GhanGx7lo5eLS6JucDgyDrR+kwGpQAjNS5NDj0=;
        b=WlcqFKN3S7YBzOv16j0DSH/QlOzjCMrXd39P+WCI79loi31bQFrQI/O4l2w1ExcfcN
         05zYhliZj2XaacSD8e5fQeFmngd+k+l0zxXXKMcA8KxhAM+37A5AajUddwlQsCX3xaHX
         mMS4D7SjeFE5cO4rFLTr5CBss5vaSt/1IIfKtVPUcxcNFjse2F/ymM+Is+mm99GRG0dP
         YKPIDzJP10CEksEmimEvOAVibe3Xi4uxwD97Oc4NxkgZ5GoXAat004QmKN1fbmegCXD6
         CDhjl8NJSvYHF6eSwjQwtiDj5qgiL4IwdOb9c6P+HOGAvsSdOuiQvXw3KmZMfpwR6pvG
         CuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747104245; x=1747709045;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3Hb6GhanGx7lo5eLS6JucDgyDrR+kwGpQAjNS5NDj0=;
        b=EEx4BuMZRTJbA1KsxU5Ozot+gcXWHuh3mHNyEoyXpqcBRQ60SsHoYyd+xc6CFwpg+W
         jSahKuu6J86Z+TxoCKiqAWwiNcY6aMsm2qItRVWaJ1nWls6iuPgp17J54xcKPTUGx76t
         9PZ/n9cvmp5XVTiAR6nEI0vTqRlaX928EUstGZUihN/7iSIUGI+gGD+wFrmBwrL5waVX
         wPZl0koDLPSX4yXmGDW2q7ToVHWhqs0y3R1JnvCv6vFT8oqBafTRaTcPL9s0z7tXsJZQ
         UzR5s7MQWwrrObbxd1xc5KGXniR9lGl3BPscdPTA69BfbeHrmW+E3RCRqNSyvuUWvzG8
         jkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCHP4sMN5v389n0mnIwFaNQi9o7JqaS29wzX0e32PGgXbmXQ/snAbfALC6CD01MSdCDxWl+f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcE1TQqXduCGg+84ihgbFc3X8xRojHQ/bjlGfZlt+ZYzGTB8Ub
	o1F1WtI0whZVozNakHVZZeesr700gY2YBfFYUkJT6KoFKKbTay+8
X-Gm-Gg: ASbGncvUPaAy+XlQAzX3nGdZKA0Zwp2SqACoRnx2FGsn7dlC2tbvZuTg3e+jm806+HS
	Z0Jc6t2Mdcj93lfJphZNV0gVBnLWPCz2EJVfEdykvNFxVwqeJ0frLVVj2H+VRUrXx2XBR7WPvka
	Itk0HnHasPNlW7iUsuU3TzUroz0GzGZf3Vuh57T9s0BC5Ufq5N+/Jh56m2Tckn+gVWy3qbhbFy+
	beWpY1ZpZTZQwltLd8BUOiukWIXDxlE65exmHXnp/e6BSWoiQdxGzkR58KWQXzCjm1tS0ZSJ+5V
	W4WChjp94HZXcLaKTHERoY55DnxmwTsker4kxi3Ojkh+8WCI2/Zf2Rg/yrQgivcJxDeIJgE2Js3
	DVsECMUUt36sD3qLEjV/o/y19eA6OBeZGZA==
X-Google-Smtp-Source: AGHT+IFOTbn8nMfqapNd/FJ1cN5Hpbo8al6t4kqDE882G1V3Q7+2aaTHVUkHl25lSZlwdPbiFFrABQ==
X-Received: by 2002:a05:622a:424a:b0:494:8983:51e with SMTP id d75a77b69052e-4948983053amr13506481cf.3.1747104244864;
        Mon, 12 May 2025 19:44:04 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4945259bd7bsm58772051cf.65.2025.05.12.19.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 19:44:04 -0700 (PDT)
Date: Mon, 12 May 2025 22:44:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: brauner@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com
Message-ID: <6822b1f41c3c0_104f1029470@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250512222011.57059-1-kuniyu@amazon.com>
References: <68224a16ebe11_e985e29446@willemb.c.googlers.com.notmuch>
 <20250512222011.57059-1-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC}
 to struct sock.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Mon, 12 May 2025 15:20:54 -0400
> > Kuniyuki Iwashima wrote:
> > > As explained in the next patch, SO_PASSRIGHTS would have a problem
> > > if we assigned a corresponding bit to socket->flags, so it must be
> > > managed in struct sock.
> > > 
> > > Mixing socket->flags and sk->sk_flags for similar options will look
> > > confusing, and sk->sk_flags does not have enough space on 32bit system.
> > > 
> > > Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> > > SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> > > is known to be slow, and managing the flags in struct socket cannot
> > > avoid that for embryo sockets.
> > > 
> > > Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> > > 
> > > While at it, other SOCK_XXX flags in net.h are grouped as enum.
> > > 
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > 
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 1ab59efbafc5..9540cbe3d83e 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -1224,19 +1224,19 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
> > >  		if (!sk_may_scm_recv(sk))
> > >  			return -EOPNOTSUPP;
> > >  
> > > -		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
> > > +		sk->sk_scm_security = valbool;
> > 
> > Is it safe to switch from atomic to non-atomic updates?
> > 
> > Reads and writes can race. Especially given that these are bit stores, so RMW.
> 
> Exactly, will move them down after sockopt_lock_sock().

So all reads in the datapath are with the socket locked? Okay, that
was not immediately obvious to me. If respinning, please add a
comment.

