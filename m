Return-Path: <netdev+bounces-134179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389E699847A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681581C210F1
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762001C2DD4;
	Thu, 10 Oct 2024 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJig6mhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7C1BFE12;
	Thu, 10 Oct 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558382; cv=none; b=Ft5a1hzFX4Vopx7nC9sijPJfNNUPZJcQp6swGcOGh1l6rG1iMb3YA41AJ6Zccrhe5qdG7iEUwAZr1YuqjEMWqEX7Iwg/PwVCPTIUq/32ZmdWNv+h/siYxtwhhgOvZuXq5yaHGdUgi1+HIoY08I2Ng6oGGkljrf9b7QT9TSzLMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558382; c=relaxed/simple;
	bh=2U7+swKAAmw08h0DPcAMPCat1Scw7idxysE2ZzSVzJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYNEfR0HRg+7jbukJ/vHewpU3r/FIY3Z+ngnNpGa6Nr1VOZXB+b/EpRzV7Jm6C5j+LIdIGiAhPPxHk2uHQ/8S6sGdBVoy2RTEABwHj9s77oDKFjkPgfs4WAXO8sHndr8hi3GG3R2u15NQp1ScfLaDmWy1Ut1mDzph9ZFpOTb0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJig6mhT; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso826322276.0;
        Thu, 10 Oct 2024 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728558379; x=1729163179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U7+swKAAmw08h0DPcAMPCat1Scw7idxysE2ZzSVzJE=;
        b=cJig6mhTUZ9K8a9YDNseP93tylbgZdkQaJn0PZSjP3X1quhU64a0si4qrR4akxPYWB
         0DxjFxDfvyGwo5v8TXTduG1eI76T4jSkov/yp7vdERZa18O5TrbYDfxEMKhwi/iHoi/e
         f35uifEQ4dtQb/ijsDhF++PawaDTbenyEYXBFvHmL6q/rqI5FRqXY125hyi6uBUY1gbt
         gHdozKOcgdixaftrcD91oBgGPLhxrAxlPY3/kPiPX2QfYn+Y5WoTfJ68GnpQuFbAaXH7
         ANax7GoHc9mRlwvUzgVfFvnHS3iHqiEvwf0t9EzbsWiQIiZJ5jmrpssf99M3dzrBuifi
         4ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728558379; x=1729163179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U7+swKAAmw08h0DPcAMPCat1Scw7idxysE2ZzSVzJE=;
        b=M0ESPE2qRPfpA+Iri7Z866IT0dM9EuYU3zZMpUoHwjOVr/+WZVDHddrfH84XJ1ow8z
         gmlCqmiV5iR4gPGegLignbGF8ZvkGGUTaj8BJSjZZLGPvxz0K5S+WkMMggrfpMSS+YZf
         olICAZBFLHLvnC8FRV1HLdXbCKDpW0qw/Vjoplx6BJxWhmpqXIc7Pxyx2hdQts8Z38LN
         vXO4bxlX7j9f6QRZoOdTkMmin5yxD4xp9VGnEhmI26TUEQmUnWQvEuLM/xvcIvLxWJLI
         Ab2EU5AwEYyeVORwN75yh8QEQD0ZE1+m3DQ07jtLOZ+EfwUIF7G9R+jPbl8x5DNBJke4
         LHYw==
X-Forwarded-Encrypted: i=1; AJvYcCWSGulo1940gsDVU+EOV6g6F8o9rZEEqp6v0GNmu/VPT4g3MCDS9k5BLhVe1VQTM9XDZ99CGup8@vger.kernel.org, AJvYcCXASYKy/iox44Vqyaz3e5jB5CbrgGz+YTrxdSWseWLOds0b95MS0Mc3mDADm4y9pmLsPhz1BL76PXmYOog=@vger.kernel.org, AJvYcCXnVkhKaqlX9L1+ghl+9R6k69JoecXWFW72jstLw8OkCrBIX8sf5FV4dmdMlDvrCuSm4ljAVjTGIUM29Bu0P5SBwl4J@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpKpcb8s5DtIDi+tzqbHXCSYgwLPftz287Ti1NW3cn8sBUgJg
	9esTyxc4AyJAY7XC+wU5grQrf9x09BkTz2eL0zz/DCjfwWOYoxOpmL26ND4qC8M4PDjMcrr7wfO
	4LMQBzaVTOrdq3p/hOttGY3lDE3M=
X-Google-Smtp-Source: AGHT+IFVVZzZzpFh1Fx2ik7fwEcjo6mL58ZZLuyObjsrW8NPsx7AoOnKFrHOY58Oywki1hSOLCcNo65JzO3qJLGyrT4=
X-Received: by 2002:a05:6902:18c6:b0:e28:75c8:49b with SMTP id
 3f1490d57ef6-e2909b34092mr4244261276.0.1728558379383; Thu, 10 Oct 2024
 04:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009121705.850222-1-dongml2@chinatelecom.cn> <CANn89iLKVh0_wkgZ-a2+Dr9xz6wOs58CE8PpwzZEH8ZHMn=jsA@mail.gmail.com>
In-Reply-To: <CANn89iLKVh0_wkgZ-a2+Dr9xz6wOs58CE8PpwzZEH8ZHMn=jsA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 10 Oct 2024 19:07:01 +0800
Message-ID: <CADxym3YonoJ5GUToUxJTnVpd3O-_SsSZK2tPMmUkXCzs3Oy-XQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: add tracepoint skb_latency for latency monitor
To: Eric Dumazet <edumazet@google.com>, vadim.fedorenko@linux.dev, 
	Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	dsahern@kernel.org, yan@cloudflare.com, dongml2@chinatelecom.cn, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:53=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Oct 9, 2024 at 2:17=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > In this commit, we introduce a new tracepoint "skb_latency", which is
> > used to trace the latency on sending or receiving packet. For now, only
> > TCP is supported. Maybe we should call it "tcp_latency"?
> >
> > There are 6 stages are introduced in this commit to trace the networkin=
g
> > latency.
> >
> > The existing SO_TIMESTAMPING and MSG_TSTAMP_* can obtain the timestampi=
ng
> > of sending and receiving packet, but it's not convenient.
> >
> > First, most applications didn't use this function when implement, and w=
e
> > can't make them implement it right now when networking latency happens.
> >
> > Second, it's inefficient, as it need to get the timestamping from the
> > error queue with syscalls.
> >
> > Third, the timestamping it offers is not enough to analyse the latency
> > on sending or receiving packet.
> >
> > As for me, the main usage of this tracepoint is to be hooked by my BPF
> > program, and do some filter, and capture the latency that I interested
> > in.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
>
> Big NACK from my side.
>
> Adding tcp_mstamp_refresh() all over the place is not what I call 'tracin=
g'.

The tcp_mstamp_refresh() is optional, as we can update skb->tstamp with
tcp_clock_ns() directly instead (maybe with a control of the static branch)=
.

As @Vadim says, @Jason Xing already has a similar series on the
networking latency monitor before, which is based on BPF.

(what a coincidence :/)

So let's focus on Jason's series.

Thanks!
Menglong Dong

