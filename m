Return-Path: <netdev+bounces-141891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF29BC9E0
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754E41F231D4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D014B1CF5C7;
	Tue,  5 Nov 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWK+0SUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D218F2F7
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801003; cv=none; b=DHxLrvetj6Da8PzM2uQ5pmTwS/cOcJZEvIKBby47Kv8go6Z49dB4hhF6F7UsDhSwqCvNG7USxu79rjiISYcd+Fb/u0w2JhUe4UZ9xq6t8Fu+Pi6Dn395SHFIWmdJopnDiLffnvjVNnWHNPKypAuujCWpo+s17qbLG5OZMTaFin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801003; c=relaxed/simple;
	bh=BaF0wzuPEUJAYWOn5Vuel0BojFI/gn6vtsm/k2Am+60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZlI2eSSA2w3ifSUvlkUn3j+ZgUWjvL1Ujvk5PyehCXCTMQvVQ3gHfUD+71iKePu+AQKi54jdF68S+JzP3yHvuHyHQi3KQlB281IseHaTprEoHQa5yps+7Zr7N1QSwpxECicd65rtWc7ndDYHcFLmlMavm4t58bIfOri9nmKenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWK+0SUU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso3840251a12.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730801000; x=1731405800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z0zDjEHRjC9Hfy868GHIkGTopMm6yXCtknHbsE1cok=;
        b=AWK+0SUUvLS7bh+x0OeFTdaBgoyEb65X/DlF0HmL7aWdyHFooDyp+t+gBZBzCUCK4e
         5F56a5/4Ti1eUf+LG5O8t4uMIAWMwdGtDkLoRZxAppDIGPlvv31SFaOpE+FNcl9xzAru
         Nf5PamrbA+vY+Fj/ARKbzKfsYtmEghy//JWCoKQMUtyyie4wC4FpQF4iP9OxEzhzBpnc
         HWBWdRjeHn8a8kY3T5vjZinype/ikZyBIwN+6Zxoglx6D4Wcz1nRX6HTg2WvCTUI38mJ
         sgvAZmQHhQUZ3LTyoHCng0AzQaWhu/FoT79SslIqXrP5cT+F2LkBmbWnOWJQh0LctEDj
         sitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801000; x=1731405800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1z0zDjEHRjC9Hfy868GHIkGTopMm6yXCtknHbsE1cok=;
        b=wncsUPSOIgKmJJ2JHEVWsaZpqL4uUT/jQJB0a18/B2a7ZHux82tx250DupboU6OFeE
         LBk+8c87R1pnVV4B1bVcLmfYytZDiPnyF2IbEICcZMe8OzusGp8Rad77cy524SFa/GQP
         e7ykCM/mFmt7OMXYJZ35Nt39eFyRIRK8tu6G6tawbwwZoH4tb7xE4NzC6yE0/NxochRO
         AlK5NuFq2DsBGJub97J7AKCPsxS2rwu3KAtGEMZUPrwajc23eqyTyRXLcLwN1FxscoxR
         G4DH8BUP+SZghlLURRDhrfXVYQ/SxYZqqk1c2XlGLFTeFwEDsKIcmagRcq7NS5Ue4ztA
         qxcw==
X-Forwarded-Encrypted: i=1; AJvYcCVGsRZ6S/G1IwNdfsI/tkZJlkVbPMa85AX0banG9MnKo6raVCDf13ZXfbCyOWixLfyMpoeR5os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAdl7oWSj7lif0y9Vn3WrfdWpyQcK+//Oczj7iWC77se5FAp5
	wvm1hQSSsqUxed0l+knFitkaJiSUDYRciuEfSpznpA8T/169ZscQ3m/pvxqWkiljwB+XeuPIq2y
	Mz+CaJFxwdUEJl8UFpit5fxe4qvcf76KzTyns
X-Google-Smtp-Source: AGHT+IEyI8/rO3O6vCmIdqpoUCThcWAuJk2RjWyvjFO7qe0jt1NnbcDP73Gpn0wkWtGACbeM0/IJ3Zp2xvjpe+OkAD0=
X-Received: by 2002:a05:6402:350e:b0:5ce:cfef:1d08 with SMTP id
 4fb4d7f45d1cf-5cecfef1e06mr7705656a12.32.1730801000129; Tue, 05 Nov 2024
 02:03:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105010347.2079981-1-kuba@kernel.org> <20241105053115.59273-1-kuniyu@amazon.com>
In-Reply-To: <20241105053115.59273-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 11:03:08 +0100
Message-ID: <CANn89i+pzZaPL5tpZ6f5crWQ3K9LGYNHdJpnTXDsGTNzZ4og4Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] netlink: terminate outstanding dump on socket close
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, davem@davemloft.net, johannes@sipsolutions.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 6:31=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Mon,  4 Nov 2024 17:03:46 -0800
> > Netlink supports iterative dumping of data. It provides the families
> > the following ops:
> >  - start - (optional) kicks off the dumping process
> >  - dump  - actual dump helper, keeps getting called until it returns 0
> >  - done  - (optional) pairs with .start, can be used for cleanup
> > The whole process is asynchronous and the repeated calls to .dump
> > don't actually happen in a tight loop, but rather are triggered
> > in response to recvmsg() on the socket.
> >
> > This gives the user full control over the dump, but also means that
> > the user can close the socket without getting to the end of the dump.
> > To make sure .start is always paired with .done we check if there
> > is an ongoing dump before freeing the socket, and if so call .done.
> >
> > The complication is that sockets can get freed from BH and .done
> > is allowed to sleep. So we use a workqueue to defer the call, when
> > needed.
> >
> > Unfortunately this does not work correctly. What we defer is not
> > the cleanup but rather releasing a reference on the socket.
> > We have no guarantee that we own the last reference, if someone
> > else holds the socket they may release it in BH and we're back
> > to square one.
> >
> > The whole dance, however, appears to be unnecessary. Only the user
> > can interact with dumps, so we can clean up when socket is closed.
> > And close always happens in process context. Some async code may
> > still access the socket after close, queue notification skbs to it etc.
> > but no dumps can start, end or otherwise make progress.
> >
> > Delete the workqueue and flush the dump state directly from the release
> > handler. Note that further cleanup is possible in -next, for instance
> > we now always call .done before releasing the main module reference,
> > so dump doesn't have to take a reference of its own.
>
> and we can remove netns & reftracker switching for kernel socket
>
>
> >
> > Reported-by: syzbot <syzkaller@googlegroups.com>
> > Fixes: ed5d7788a934 ("netlink: Do not schedule work from sk_destruct")
>
> Do you have a link to a public report ?

I only had reports for old kernels (6.1 stable), but the repro seems
to work on current kernel.

>
> Previously syzkaller's author asked me to use a different name for
> Reported-by not to confuse their internal metrics if the report is
> generated by local syzkaller.

I definitely have upstream reports (latest tree) but no repro yet.

I can release them, but IMO this would add noise to the mailing lists,
already flooded with such reports.

Reviewed-by: Eric Dumazet <edumazet@google.com>

