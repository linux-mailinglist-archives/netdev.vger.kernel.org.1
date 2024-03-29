Return-Path: <netdev+bounces-83183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B78913C3
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 07:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8671F22BD8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE75A5F;
	Fri, 29 Mar 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQsNlhpA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66838FA7
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693897; cv=none; b=ZrNtqG+4b/lF9+RkJSGfPnTNMJECIuyKFg5lulWg0id1cjn32+42fP4T7OcW/oC7MfjNiZJz94rgHJWuF85wT+UqJEQM3X6F786n3mB9EV2GbPV8wRyiPJkrPUDnj+mWR9DJGWbUenC5b5DxsP7xzgajgYPBBHzz0/0o+KxDbmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693897; c=relaxed/simple;
	bh=5aM3pUD0MWZusWlY5JUCnBQEzBYx9oWVSEfURSLwXDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1krZaD8p1XHtbM3otYjkd7NWJuBP6Ws0R8iSn9YUehQETdyMYvZJ4dgGayotbh10pXZqw9l+qd1SPs2e8nGFu767CD57cl5Cv2Oqnnq6At75lWFExUhUUF6+FC9Sft8qjvyoX9d4TGRhGb+jOP2s33DZyEX5rPTlYJt5vSQckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQsNlhpA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c63f4a468so3067a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711693894; x=1712298694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aM3pUD0MWZusWlY5JUCnBQEzBYx9oWVSEfURSLwXDk=;
        b=hQsNlhpA5d9hEKvhLf31F1NLaTeaYWyCJcu+hNOmqYwHXqBqdaxx2NHWjnVU/5uKnM
         /mDi14cgC25xA7Ze5NCDINaGnS2Ds6kWQlwKkGmobnivECx+SsXnP++x/fgLq9lCq55b
         50irVh0M7Fpr4YLCBQuXV7XCH++2PpSCHfEPEV7w97fN+Ea1ZH0J34Zt3LmZKeaqboAo
         tQRXgRHvhxJM+JjJz4sp1c8IZex5fHbsM9L1n3DOl5gmvF7MwC2oDNM6eHI37Ji+Gt+H
         KUv+oMrm0KtL+ihKRpg4qyBvsOk9ozjLKGoKP70kMpkkW0Vs3wEjwycU6GPX7z8ZvH7p
         WIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711693894; x=1712298694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aM3pUD0MWZusWlY5JUCnBQEzBYx9oWVSEfURSLwXDk=;
        b=iGWw48ytuVPTXnwZNERVslICUobIfFvYvnReVBi5TapoqkmQtmcRfySJE0348MyX70
         qo3/G763dQX7xPp8EqSyX8htS9t7SSTV8tU1ASxGb1Y6MX7XRho4C37RNBswJ11s9KOu
         Ox6T05FIfQf92gyo+i85kEmUwHJdVqQLKRhh6P22HNISOZ2rk/uYSCzEdk2Qyu8i+N9B
         vQDV/2csIcqSjVKzb7UYPBc5gLnXEgzxuJfN5FdLZXNIpwGJwXF19/m37DqN+KEReDf5
         lIQ1yUWInTBOptEhhZcuok6z0coeQHfPbxsGZXtIIYBQhMH4ojCzm4Pz4Df/8Gll4+nr
         ocPw==
X-Forwarded-Encrypted: i=1; AJvYcCUamj4y95fbDAbeM8Gq6VO5bwBUwDDL7OP5tEi2Xr71i3UqFyYJAnwa+9JFTcCvHHpX3UCEtuigFjOTKL3BOnYmp0LDu5O6
X-Gm-Message-State: AOJu0Yzj1hO6IVPU9po83gsjI7Nwpy4xmSPV6gI0iaT71DIuYudILNUk
	UM9p0vDZUOL+06dUJVfEfN5cVe2lEB078wqFxI+Ge3qyYr564eX4IbgZUppURRHeCOg9MGsbV7P
	znrtHb8AHR7e7HKvjne06kT6YBbp/VZQTXvlx
X-Google-Smtp-Source: AGHT+IFlGtdWua/Kk52SVK7MJkBb4Li8Z6SguWT+HYAzo1aQ+5hkWp6vpQXSHKuAf4H39r+CPN96dFe4k5K60kJCEVM=
X-Received: by 2002:a05:6402:524b:b0:56c:5dc:ed7 with SMTP id
 t11-20020a056402524b00b0056c05dc0ed7mr127861edd.4.1711693893486; Thu, 28 Mar
 2024 23:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com> <20240328170309.2172584-4-edumazet@google.com>
 <CAL+tcoCOwddRuis=3NYOXv0Qwuw9qaLPHY2OAOPyYamKwBHbQg@mail.gmail.com>
In-Reply-To: <CAL+tcoCOwddRuis=3NYOXv0Qwuw9qaLPHY2OAOPyYamKwBHbQg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 07:31:19 +0100
Message-ID: <CANn89iLpY7iWppW1Vxze6Gf0ki5YFN9qF-w=+ig+=YfLqaLZyg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] net: enqueue_to_backlog() change vs not
 running device
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 4:21=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Mar 29, 2024 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > If the device attached to the packet given to enqueue_to_backlog()
> > is not running, we drop the packet.
> >
> > But we accidentally increase sd->dropped, giving false signals
> > to admins: sd->dropped should be reserved to cpu backlog pressure,
> > not to temporary glitches at device dismantles.
>
> It seems that drop action happening is intended in this case (see
> commit e9e4dd3267d0c ("net: do not process device backlog during
> unregistration")). We can see the strange/unexpected behaviour at
> least through simply taking a look at /proc/net/softnet_stat file.

I disagree.

We are dismantling a device, temporary drops are expected, and this
patch adds a more precise drop_reason.

I have seen admins being worried about this counter being not zero on
carefully tuned hosts.

If you think we have to carry these drops forever in
/proc/net/softnet_stat, you will have give
a more precise reason than "This was intentionally added in 2015"

e9e4dd3267d0c5234c changelog was very long, but said nothing
about why sd->dropped _had_ to be updated.

