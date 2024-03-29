Return-Path: <netdev+bounces-83198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7589153C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD33D1F2232D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9514284;
	Fri, 29 Mar 2024 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfAsC7LJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202E6AC2
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711701890; cv=none; b=KZ05au+HKuKND/uuO/Iz/5353B9bdl29AG1x1g0u5ALK8l//MTB8c1w0yww0Z4JqojQvtDlLuTvnNVSX2bWddJUbw8/KHiHnC8c2U7SOKEHOrMHo0VykcU6+4IKCasHBKsiuID6ldoSyHp9csdyVi8ghZIp6qp2YWxLfL0WVFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711701890; c=relaxed/simple;
	bh=wQI1jpq9mS/2nKkNFVQwUfeDn+e4lJjdg5aa9v5Za2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTp+KMpoKJQMPRSJlR0Ty6Z9ll+4Yg2lF38VdQIblEZcSEfDNDCHrAQcI6oK+tHbVefOTo65mp9ca8l9SweiogiZY1izX/MxSEDLlRjrMOSRBKRYeTbwYxYSLZUSKZ9oVE4ADRF8ggroPBdfhyP7l1/S9ypc62vXDq+I+KRfzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfAsC7LJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44f2d894b7so213603966b.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711701887; x=1712306687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQI1jpq9mS/2nKkNFVQwUfeDn+e4lJjdg5aa9v5Za2c=;
        b=BfAsC7LJWV0KrbxExpixH3q4xFXLFlpcrCEWeYbssnD9xVrGYRw4MIofBcwSZsrvaS
         f1J24A4Ryn/psESQ+DQw8suQ/Fe9xUqvU1AlUuyS/VlWXPZRpKNZC7vFXj46h6ZrkhHr
         AsbyK7oLJiS2NkD7j8fbZQFaoSbMDvsQe68nlPh/RxRoWCrlWsdRgEk0CCZB/rqYAvCf
         CG7un0P3LTbj/djXJPMvLcMbYf7Nmm8S3loz+QqvXdbKDFzVIvMzIlW4Zv7zisbmHKlu
         6tK1I12GwxYbE+irkizONOt6dVahEAba3A6TGIfv+AajpYmIkeqWYZoicDWctgqW/Mls
         VSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711701887; x=1712306687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQI1jpq9mS/2nKkNFVQwUfeDn+e4lJjdg5aa9v5Za2c=;
        b=DziruzuE/qseevgRYXxtUfJsXT0f3wMtWMhj6F8mhDYkbliUi9eaYuUMR/wg8txfKD
         DxMK5aOs9fnrRUKCLBLVOmaZIRqmi2OdKq6P+JaYMp3coFOfjdIFUVU346Qr3z+SbeCA
         Y6yAtb2LTXgGLUGTNXGruk8WiKMUczMoFOd/Ikqm2YWpA5ZbaP+4gVGrC1VXjaRNidqU
         SrO0O7/ySYJngim8pDAUEgyKbVN66eDV7hggCR4xnmvxROxMM2z8eNZpHLG1RlBcYzrv
         /MFEWvmx+OMYkPdbl2rKDrKxFVWjhEnwu4BT4rvOmQyFxWIKMe7thkUkTf3tJYFpuasN
         tZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVutjbaV71kweK50FdYbMLUQAVZCWaaDtKBujD2Mrk5VcZ6bW4Krt/q/0H2gAGws5a8/QElrswhAKxiy1PPJFgbr+tAOH9r
X-Gm-Message-State: AOJu0Yx/4t6Myuwz4b9cUFSTvFWFSHUBHp7CgWjhqnp0dsfS27cUI6Nl
	GZvQPao1YwieNv8omfeEB3UVre1ElUu7stFFcm6b98Lr86BPfLj7c3Lo/BmUcigAsiAv/34dkcT
	3SkpBSRyEZlGvPy3ZlyMFB575eMo=
X-Google-Smtp-Source: AGHT+IEE4GJgs7O6p4FVpKEdiQ50JsCJyXL4VlzPoBT7tIhMVMWJmRodZ3MiD7T94ISOsFjIIZLXQ+sWvbsUxd8U1Us=
X-Received: by 2002:a17:906:eec3:b0:a4e:1036:7da5 with SMTP id
 wu3-20020a170906eec300b00a4e10367da5mr1178617ejb.70.1711701886670; Fri, 29
 Mar 2024 01:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328170309.2172584-1-edumazet@google.com> <20240328170309.2172584-4-edumazet@google.com>
 <CAL+tcoCOwddRuis=3NYOXv0Qwuw9qaLPHY2OAOPyYamKwBHbQg@mail.gmail.com> <CANn89iLpY7iWppW1Vxze6Gf0ki5YFN9qF-w=+ig+=YfLqaLZyg@mail.gmail.com>
In-Reply-To: <CANn89iLpY7iWppW1Vxze6Gf0ki5YFN9qF-w=+ig+=YfLqaLZyg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 29 Mar 2024 16:44:09 +0800
Message-ID: <CAL+tcoDq5m5zK9G9t8v8zpRZEhp=BDwYft2jnC4pqwhS1RHPTA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/8] net: enqueue_to_backlog() change vs not
 running device
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:31=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Mar 29, 2024 at 4:21=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Fri, Mar 29, 2024 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > If the device attached to the packet given to enqueue_to_backlog()
> > > is not running, we drop the packet.
> > >
> > > But we accidentally increase sd->dropped, giving false signals
> > > to admins: sd->dropped should be reserved to cpu backlog pressure,
> > > not to temporary glitches at device dismantles.
> >
> > It seems that drop action happening is intended in this case (see
> > commit e9e4dd3267d0c ("net: do not process device backlog during
> > unregistration")). We can see the strange/unexpected behaviour at
> > least through simply taking a look at /proc/net/softnet_stat file.
>
> I disagree.
>
> We are dismantling a device, temporary drops are expected, and this
> patch adds a more precise drop_reason.
>
> I have seen admins being worried about this counter being not zero on
> carefully tuned hosts.
>
> If you think we have to carry these drops forever in
> /proc/net/softnet_stat, you will have give
> a more precise reason than "This was intentionally added in 2015"
>
> e9e4dd3267d0c5234c changelog was very long, but said nothing
> about why sd->dropped _had_ to be updated.

Indeed, the author might think the skb is dropped in the RPS process
so it's necessary to record that and reflect these actions in this
proc file.

Don't get me wrong. I'm not against what you did, just proposing my
concern about changing the meaning/understanding of 'drop'.

Thanks,
Jason

