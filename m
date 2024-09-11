Return-Path: <netdev+bounces-127542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB1975B62
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960881C22354
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292541BB684;
	Wed, 11 Sep 2024 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KqZxMWUR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D387224CC
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085477; cv=none; b=iSFvJ/J1HnYE3c8jubYB1NmM1Mlw6oa0BOSTMeVB4EVJR9o0E25MmB+0irdbEqCTCOl5y8/7yXGJ1WHkbn6CFPEzOQJ5WUIfzemkwdt5N/jJiabZ76nd9quakFo7qtHdVzdw+OeL5QrsyUDgrBOU7c4K48jYccdLu+luNAbDb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085477; c=relaxed/simple;
	bh=Gfeo0pts1aKNrhuuvPiQZjscjhY8caWDURFJ6yrEmk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpTA2gQw6Kdfllrg2yf7IFblDm40k0sCE+MKuiQIoiIXGkvyilW265Mbw0mZkvzgh9K5TPpmt4SD2XXruh5DHeC6E/gF1pjbTzWagOLdQ/MKuPKl2exVdA00PpulDrT4YY4trFgWr1XB/VwalwdV/R+Rl39dx9bY2ibm4Fu+KhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KqZxMWUR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a81bd549eso25668166b.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726085474; x=1726690274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gfeo0pts1aKNrhuuvPiQZjscjhY8caWDURFJ6yrEmk0=;
        b=KqZxMWURz12DTuanXNAkhlaFENkt4el1ZbJMGCwTB6KKJx/EUsFphZp4jJl93YfRXn
         bJW5TjoIioeNCTZOgZoqhZoYDlINNF7aRC2C+pYOJeA9Ki6JZVsgFCkDIbBBAzHnGlGh
         Gs5BOrOzHOfAZ/zS7iHgmv06mGZDRSGKu/dJlgV5zxdJ4ocUJY+BKIPrcEt1GZ1OOjD8
         oIPXljeUkpItp45aFmdb5mBGLTgdWtyVEDB4d6R4JsOhLwsi0Azt+LtiowB3O0XQSKQn
         ws7lDEdJAaVOKbENPKw/Usxm8NtilvjvVhrL4ZLOTO2Yam5MInXR41s4f0jz23O8xfAb
         xz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085474; x=1726690274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gfeo0pts1aKNrhuuvPiQZjscjhY8caWDURFJ6yrEmk0=;
        b=qMFM9Xf2PZ5tshTsdCWabIB7gmd1kcR6/5ywO3qGRjwlPcNeZPDV6MG0TBpUdq/byM
         OuYwLnHtIQh9pNwIh8ZinQ0WzFBmWyF9p67YGAGpr5Kyk3HWA/ijLKYJFuCsODcnXPrQ
         qHKqpsEc7i5Ec046ksyqxLNQ2nqtkBfNNpgWxiQhmWkO+WtPF/1MHDuQObOGml5csnyr
         efF+pFRC4DINx2ybgUYn34+3ddbwCHcKplc7t5i8giAsUyPi4imgEIh5BroTN2kKhSfg
         CM6ve5Qr++E3Yg/F4UpgDh56jhmu9yiE1SSLt21iOodvobzo+i1JHPZ7VXuIB3+jaoLT
         qCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU86CSDKum6irsY0KEWZJlcLKzO+qNWE+rEjqyiSmlRn9kSiQEHtCFzRrC11wbPWhdG3cGSxsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HsSvwvs+ITukKQ76K40h1xdchMsDyUfAcrzBWrYZNXf6cMgq
	7GVJ6NzSHMccV5nuBnf7GOPFyJm9OqBZE4lj4JE0dMDYMKXobekMnwWrtCYxjr4u/yenL2GBK0k
	USIdAVTzgpk4JMzbXQdhW5WNspL0Ut7lCC7A=
X-Google-Smtp-Source: AGHT+IEIPUvxfxiC/iShx6EyMhl3F1u2Ko7IlvNDcawQ5GwM9Undm13TQ81z5iIhuD0VQFKe6gSCIeQbTrbZ4sveDIc=
X-Received: by 2002:a17:907:e620:b0:a8d:250a:52a8 with SMTP id
 a640c23a62f3a-a90294aac4dmr59191666b.3.1726085473510; Wed, 11 Sep 2024
 13:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-4-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-4-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:11:00 -0700
Message-ID: <CANDhNCr67G3NH-K5rEJiiDPZJhX6jCvjwchv==GhUaWWXpdTRQ@mail.gmail.com>
Subject: Re: [PATCH 04/21] ntp: Cleanup formatting of code
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:17=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Code is partially formatted in a creative way which makes reading
> harder. Examples are function calls over several lines where the
> indentation does not start at the same height then the open bracket after
> the function name.
>
> Improve formatting but do not make a functional change.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

