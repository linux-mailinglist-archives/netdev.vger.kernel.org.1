Return-Path: <netdev+bounces-119643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8813A956751
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B954D1C218A1
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4CB15D5D8;
	Mon, 19 Aug 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVyOScOB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5815CD60
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060531; cv=none; b=iMd5TCyPtsHmojZyZdQ+MqvZ9dZsxlHp56zD+oTvBMnaQUqr1LkSRveOhEvvHb/NOtnq/ab8OHWtk5rzBC+2/hb7WLPqQSiNGtQUVBQqfNJXmzFve5k+hSov2xvQB4sUeg3hcZufOby8NcGY1NF92VuZK5KD0G0K8NGHW0oQoAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060531; c=relaxed/simple;
	bh=HjXbC6JiMRd9xKV/cxv5VTTNEyBw7TRB1i8lbvmC5M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LorvFiyIoYHcm0BffMKYqjOAGg7z057Hz85JUIgFKub6yrFqljqw9oyiiprnx3JtLOokREIxcf7Xn2uPO2mV2ipxBIT3zu+nQR4uoXGw9DiwO0HcTLYP0jgKlDgRWFwW8OR991QPoU6NQhhavFbDyaCTmQwYzYWgt/5YK7Iut7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVyOScOB; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39d2256ee95so17446605ab.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724060529; x=1724665329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjXbC6JiMRd9xKV/cxv5VTTNEyBw7TRB1i8lbvmC5M0=;
        b=gVyOScOBErsPsvg6WZVot+hklgLcs6rixNAzVbzy2r/yLzsgG/d9e24VKCvQDZ8Usc
         OgxJoiejgdOi9TglwBmiqeeJaELWXvxMiRwdoFBdZ5gKgGEvunEGJFkGRA9FxnGpcavU
         S/flJBdR3wjgmcUT7Ygmk1ydUoVWwIjFD2+FkViH8zu28mQSiPlIvRiJTg3Hze3n9Ais
         /yoJ91gLjiNLSDFj9uxrrSuAouiw+Q+h0SMohup2fK3nnbGXh+Tz0dI9Q9BKAaz/XTk/
         kpY9tZS60hVj5JO/7Xz8/j36F89QhE3JDY8hwHwgLIuESuY4Pa2OmkztKgBjtJ/PDOHW
         3jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060529; x=1724665329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjXbC6JiMRd9xKV/cxv5VTTNEyBw7TRB1i8lbvmC5M0=;
        b=tCFztNl2BCoFyuJfoyY6/xSMs6fkB5h/mbG5+HBg51IoMol9q4NUpwV0YMFhI0LP6C
         h6EY8mNQMdinYOaS4rwhDlV1Rv2KP4S92bFroBXdHRI9n1O+nRkQ2+yWsj2YLZXUtcoZ
         zB04o0tJdLKA3l5L8t7je7OfYxjpt0WXc21NyfqvvQmAYZOZ1txtMiXmsbIxKjz30l1A
         IwvjK696sL9JqXXTFYfxPlYDq8ZPF8V5U0kqr8QWVGncQjJVS1IruX0HK/Zc9fm0UZAl
         yF03Up99O0RxY3QFYhD/x3k1IajbjMMv9bFkVhVWPxfnUGllupDz0YjPCWvQ+xmOZJUi
         fw1w==
X-Forwarded-Encrypted: i=1; AJvYcCXvH/K47S7iCdB6qNw65hgVFShLDOQ1SH21AJnHX27Ng7AFZiSbRkqkgJAXlktPq6Jv+9RNKpTzqAk8VTj5xq5/oyiAb8tY
X-Gm-Message-State: AOJu0YzxSSsMJKEW/SpY+gyYy95/M25xtEMvxcF69bEnZd/21137/2fX
	xzqExPl3pU0CNADMsOWlYJPJfEUijXQFE+ugExz34HutUSqqSz/kkQ/dVsf4dtlAeGn5RQScpDz
	ihdLZIPu1edBSMRryTgKAimOx1GM=
X-Google-Smtp-Source: AGHT+IGkmgXNiY1Eg1XOz9pgi0yW8+Z0Ic0MJf9wKBYuiQEf9+nLfBbPx1tYbiD0VxZfa05vxNAvkpbAVTLnpea9Gs0=
X-Received: by 2002:a05:6e02:502:b0:39d:2e35:4d8a with SMTP id
 e9e14a558f8ab-39d2e354fbemr91268045ab.10.1724060529085; Mon, 19 Aug 2024
 02:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDDXT4wBQK0akpg4FR+COfZ7dztz5GcWp6ah68nbvwzTg@mail.gmail.com>
 <20240818184849.56807-1-kuniyu@amazon.com> <CAL+tcoASNGr58b7_vF9_CCungW=ZZubE2xHDxb3QCQraAwsMpw@mail.gmail.com>
 <CAL+tcoDHKkObCn=_O6WE=hwgr4nz3LY-Xhm3P-OQ-eR3Ryqs1Q@mail.gmail.com>
 <CANn89iKxrMH2iGFiT7cef2Dq=Y5XOVgj8f582RpdCdfXgRwDiw@mail.gmail.com>
 <CAL+tcoAEGcaEdCjxs9_nM7ux_r8tuYhjsMtJZfemHQ+DLVqUYQ@mail.gmail.com>
 <CANn89iJmEgeRv5w+YwdOGf0bbS6hNRtYWQ860QGu=KMJqVKZAw@mail.gmail.com>
 <CAL+tcoBVYE0+TeRW8AkmxXAYuJ04Za3XmZXD5T5R=LxqXRWzbw@mail.gmail.com> <CANn89iJ_bzC1aBb8UYc4OAChvCbsBJmDDvEOm2BucKaeQixFYw@mail.gmail.com>
In-Reply-To: <CANn89iJ_bzC1aBb8UYc4OAChvCbsBJmDDvEOm2BucKaeQixFYw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 19 Aug 2024 17:41:32 +0800
Message-ID: <CAL+tcoCZQdU5H3c88g3MMoBRxvMTC81HaVzKF4TL=mA53arwWw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 0x7f454c46@gmail.com, davem@davemloft.net, 
	dima@arista.com, dsahern@kernel.org, kernelxing@tencent.com, kuba@kernel.org, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:38=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Aug 19, 2024 at 11:32=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
>
> > After investigating such an issue more deeply in the customers'
> > machines, the main reason why it can happen is the listener exits
> > while another thread starts to connect, which can cause
> > self-connection, even though the chance is slim. Later, the listener
> > tries to listen and for sure it will fail due to that single
> > self-connection.
>
> This would happen if the range of ephemeral ports include the listening p=
ort,
> which is discouraged.

Yes.

>
> ip_local_reserved_ports is supposed to help.

Sure, I workarounded it by using this and it worked.

>
> This looks like a security issue to me, and netfilter can handle it.

I have to admit setting netfilter rules for each flow is not a very
user-friendly way.

Anyway, really thanks for your suggestion :)

Thanks,
Jason

