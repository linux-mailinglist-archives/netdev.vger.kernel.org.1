Return-Path: <netdev+bounces-188328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF1AAC2E6
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763CD508454
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82D27A928;
	Tue,  6 May 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6PHgUXO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91822B5B1
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531720; cv=none; b=JkQV6fxpZLNLXmuQQJdM1tydfTvT3PMpJUZCQ3pp5GDGaarJKKmQR2yIcNUBJIUEbbHsTds/HzZX0d1dy5nsFJRoykBYck1rP7YwJls0RVe0yFr6mTFSijNA1FwplixlPSHON+RrH7ROn1RMS+pHkArczHS9+DLjc7foAQ6eeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531720; c=relaxed/simple;
	bh=OlsGua0of71q9mWTtXzHVW4iedzXAc9V0InixfWiw7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGjXAj/aOQelmUzZ00GYs8XGRzGynkcwbZLrzV7rLeZ1S8E8jQseK4/K7z67vwdzXaCOTtdqBcWCKcBVgFfXt7mj/oxTH5s6/jKudBftIMNKxDeexdCm/p6uxmicBlkCSu/UsvdRkV/3ERouQYRdJjb6DDbIKPYoZYufpJvPnXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6PHgUXO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f6214f189bso10434767a12.2
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746531717; x=1747136517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlsGua0of71q9mWTtXzHVW4iedzXAc9V0InixfWiw7A=;
        b=E6PHgUXOuxZYWeBmkdeeqDQhd5prNjUkZOo9F6RTCj94vof31FBRhdfX3EW21/uqSY
         oLXvcFGTASYJm/R2hZCsoyEeCIZRTsYjkei/YUCERF6NQVTPqSq68dITfLCnGl/+l3EA
         /mbSzfnfwB8n7cRL8RX33+ral5rsvSAHy/yOFYBepkK8Sq/ov+6R5nkYrLwwFmTCM2xa
         IFmjQbwU8WOj7bkvEGKl+84leuxUsVEk5GemlIc8agwye741qK34euuoXxUp4iczV0ql
         pyOojuj5ieAK8+JEw165rLGRmE5a3VEbx8yLs0CEexzzcJbz7dynqrFSL+XObbDCRJGm
         kP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531717; x=1747136517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlsGua0of71q9mWTtXzHVW4iedzXAc9V0InixfWiw7A=;
        b=rAZ1zBIMA0wIQ/NJP57eeGGyjMNmDbqlmPNEk1wrVsSTsw3FwOK8Vv3LPFGG8/U098
         O/O88A9sXUHz8Slk9aMswhq/bJ8EwHDgWUXD5Hw1ugdwUUkxJWpRZS/xg1cTDFH4YuwL
         t95aEY3eJXA9a5bfW0QQqoSlhNFed6nZTgz17agIvgiXyRN0yNlD/hNE2/9/WQdGp/JK
         DkYV2XZK3ImLilJ3Yz0F1PA5fV3edplmWgr97VaixqghfZ53BcMaTAV2l+rsbvqUKczU
         GcjWk4Nhf2DDsspYSFW7IwJ3ZYYuBintgzSKoevutWqqSr0/JSfJMbdvJpL7eQEC/Nnh
         YYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4MjvGeVxWlJfU45DBeCfCkiB80ZRFGH5oOW0H8oY2kS2SJTt4MTB9q3vcVdn1mC4phtETlTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1QBBMqgp4rt+c6LNOG4yJHbGflIAgd78ExsHpx9pv9jcHxcX
	gKmclrpEXHfle3Hs1GgTw4Ejm6D4ww1aWl7j7tpGV/mrcUtklczryfCqejXWPtfpx4JDKxiagUT
	1ofn1rrsSLtFEF3JV09k+QqdyMxs=
X-Gm-Gg: ASbGncv0u/tdvCqGLL7y2mnTlxLwuNhIDZr0lWvvCLz8J00w4x5hUdS1D5rVpgT2Ild
	kj7/StHUiSOEBI4j2Tkj8uHw1Z+m9neFtjdQpOsp8zRbu8/1lbs5uznSgCfO8xZGtmn4KkC9hNg
	Vu5D64K/RJF375Uui1IF3x3dw=
X-Google-Smtp-Source: AGHT+IHHaJU2uYHjT9Uisz6tInLL+QbwcDnJ3lFUCVfNX6XBwxoEejSA3RKTZDy8P5cPK6f8g1WVC2pNtR8kadEDQAU=
X-Received: by 2002:a50:cc0b:0:b0:5fa:9222:e89b with SMTP id
 4fb4d7f45d1cf-5fa9222ea17mr10530702a12.13.1746531717197; Tue, 06 May 2025
 04:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415092417.1437488-1-ap420073@gmail.com> <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
 <Z_6snPXxWLmsNHL5@mini-arch> <20250415195926.1c3f8aff@kernel.org>
 <CAHS8izNUi1v3sjODWYm4jNEb6uOq44RD0d015G=7aXEYMvrinQ@mail.gmail.com>
 <20250416172711.0c6a1da8@kernel.org> <CAHS8izMV=0jVnn5KO1ZrDc2kUsF43Re=8e7otmEe=NKw7fMmJw@mail.gmail.com>
 <CAMArcTVog3pUQtXrytyRppkXvwBH6mHvcTsh9OsHZ3zPQYytiQ@mail.gmail.com> <20250505103419.1965365b@kernel.org>
In-Reply-To: <20250505103419.1965365b@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 6 May 2025 20:41:45 +0900
X-Gm-Features: ATxdqUEjmCjT6FTfc-bIGc4iLEmvI3G7jlRHG_uRCkXQG0spHIXTvMe0oY5J4uU
Message-ID: <CAMArcTVxZVDDY0kd9_tzdr9UGb+u=K+co13xTeGb2g16g0p9Rg@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close after
 module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 2:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 18 Apr 2025 19:52:43 +0900 Taehee Yoo wrote:
> > I=E2=80=99ll send the patch over shortly.
>
> Hi Taehee!
>
> Are you still working on this problem? I haven't seen any patches,
> I think it's the last known instance locking problem we have.

Oh, sorry for the late!
I will send the v2 patch today!

Thanks a lot!
Taehee Yoo

