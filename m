Return-Path: <netdev+bounces-133794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A059970E2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B81C232A7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D991E5714;
	Wed,  9 Oct 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEjdEXiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3671D27A5
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489190; cv=none; b=J7Y3lSfuOLKfRCHKC5JKJPanG4ykqCDAobiYS/ka9RzkHO6QYEZk/W8QbAFRjbK6ZhmuNEJiqJs1H6moDMBLaRHORlMRbGZxD5AL+EUCJW0jyQoxjkz6s6JxDi2FGV3uazyWmHR16b4VrsxxBURuu38AM+KfJ1ZTXN/lViqhalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489190; c=relaxed/simple;
	bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t56wYmGFqa4O1lCMGfEE93vtMLf7IFAfeY50WIrJ3MObftqgNfdT6/Ej3XFOaMB+H+trZU1otFz1fe0Gp6+hLR0z5OoA2nEi/+M8Gy18Gc4UgYtYHpCHK8SV/ofA2JFbWaBHIOeZLCM6a6Bov4yJGkCj0wE5sHopF9N73ne+nNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEjdEXiZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso3703589a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489187; x=1729093987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
        b=FEjdEXiZVKFh5ePrG+OLjHRd9heDbh9wOtMVIWoM3fr3aNs3b839XsmlCR7lzfSODO
         b3Z6sq9FNLjTt1GFSGf4MRu4Hm8T7z/CvqyJhtfszd7QSPgFoYdEWMoca9QN4Dg0nu+M
         ozaV2FA2IV2yhDXWsTdjuhIoKNPvIpcJkN3sjBXFaBzvv+eHfBqyK6VUv37yfrOIzopz
         Mu8kzkw0TxQvzNyWZmLI37DRurqvMaavKxG4OkJXHOH7U3mMYsqZLitHDzy+Ia+TS08w
         ZxUtjBe6mRi6yKtajsAUz1vuNCuCxqt8NLUX84sSfuC6X8e0PjEGu28tU8pp/HekL5VV
         NwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489187; x=1729093987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY3+Z+3Bq6ZOCLy/wmsIjJJC3n70MViMpYQ5o+VGqBU=;
        b=CCiydSdCt0xqPnIdqFLFwZtMWFjz1W6GiXCivI2VT1zHOg7QlfUyay6kjfnhnevSXC
         8i2I2oYCKQAWFV2DhCav+Cu5o1s8WL1L+v7TG+T/His7ZzadhbF19VkTdApn0USoqUgf
         TnryTf7AqDJz8PHHXa5oIODdYMU5+qCUdVR73Vc7HYvnH+khbpaioMiwqAufdWRd+OW6
         bvsT039z6jyYuALpqoemmdpT4h28tbHQ0LY0BNK7cLtTqNVeHk/MXrpw9K89zq4f9nJa
         5R7TmEDc3KilOOJISdV/AJgCSYUfmrXLKKOF8IOtj4CMpSIUbGP1S05aO3Ej274q/KJG
         Rh6w==
X-Forwarded-Encrypted: i=1; AJvYcCVw5a/f9kFAXys7UObi73TB0yGprzz90AAyK7Ew0lI4SJSZLLBzOwJKlhAx5fD59CoDseljkw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2VzMSfgt+GV9FfAQvKIV11dfBnexIeOPUfi2xorf/MrHL2Qy
	Wq6Tv++1IW52SzclQGKvfWVLxbSD4XJbhnN9SAgSo6zfzoGXp1wTVwNjNL7X+Wq/3BvzCGWCK9S
	qZEGywiezjp5cdeUp9dCkQPNJoUlG9O6XN52d
X-Google-Smtp-Source: AGHT+IEQV7nAbPoM6W+RrSQoV1u726+qXXT1p852mGQFg9Gw4itkSxdL7eXhWxwSO/6myLTg4/DgHQkXtgpF3yoCFr4=
X-Received: by 2002:a05:6402:4414:b0:5c8:84b2:6ddc with SMTP id
 4fb4d7f45d1cf-5c91d68c9c1mr2454867a12.33.1728489187004; Wed, 09 Oct 2024
 08:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009121705.850222-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241009121705.850222-1-dongml2@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Oct 2024 17:52:55 +0200
Message-ID: <CANn89iLKVh0_wkgZ-a2+Dr9xz6wOs58CE8PpwzZEH8ZHMn=jsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: add tracepoint skb_latency for latency monitor
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	dsahern@kernel.org, yan@cloudflare.com, dongml2@chinatelecom.cn, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:17=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> In this commit, we introduce a new tracepoint "skb_latency", which is
> used to trace the latency on sending or receiving packet. For now, only
> TCP is supported. Maybe we should call it "tcp_latency"?
>
> There are 6 stages are introduced in this commit to trace the networking
> latency.
>
> The existing SO_TIMESTAMPING and MSG_TSTAMP_* can obtain the timestamping
> of sending and receiving packet, but it's not convenient.
>
> First, most applications didn't use this function when implement, and we
> can't make them implement it right now when networking latency happens.
>
> Second, it's inefficient, as it need to get the timestamping from the
> error queue with syscalls.
>
> Third, the timestamping it offers is not enough to analyse the latency
> on sending or receiving packet.
>
> As for me, the main usage of this tracepoint is to be hooked by my BPF
> program, and do some filter, and capture the latency that I interested
> in.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---

Big NACK from my side.

Adding tcp_mstamp_refresh() all over the place is not what I call 'tracing'=
.

