Return-Path: <netdev+bounces-146110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4099D1F37
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67626B236DF
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE6C14A639;
	Tue, 19 Nov 2024 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/58nPyf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C313B287
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990390; cv=none; b=Azefi8sjLGDe7iFrLd8gJobWgoxrN/qfKC4AslFj7eSqPE5Fh4u82TlsXH7VTy7zDJSrhK4SksYPoTmKrfj8sLBujYrTKydsmlpG0HYiY+JnyqHK9pWD8YJOPqssuF1UZBjRLlPcwddx4HH9BFePZ2IMbNYrLA27oG82N9D+rbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990390; c=relaxed/simple;
	bh=CR3f5GMW7PsgWXLYekVtB0VfStBWpbK7OXMzzdtwhgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXD2rdK0VK1Ir2S7X3DzEr2XOe59jR4DyIVWl+B/PMrmc7JvlGNx5GIo13nzOEaSZhueJvIXTic+AKqJ4zPu4aO4VCTp2nbcVDDWxW8EpCuGVimXYl+J0rnPsMH3hmuHaYo25QJOikH+ykr0hTnntBVd6DxE5cw6MV89tWFRjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/58nPyf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e044d4f7so7e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 20:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731990387; x=1732595187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDXPQkZOVm9U/Mg881fGci+SQNaJQQyzgFI30o6wQ1Y=;
        b=q/58nPyf64wWgooYm2eEhNb6Ha5PPyz7mJFAyYn3S6PoP1rB60WqMygRlMKlZeIDSr
         ga8MCFUSNe06sXSQPqn3PLQ5tEWgXwkOzO3UR4SX4uBnDoPet8InEmvgxEJis4RrwZq8
         r1RXZS5bEoR1WyEjRPtSDtullV+SyYJFiaangiT58KPJbedDqvR0CbNq8cUiisPUTrgd
         x+8vjWTf/hYdYl3M3rWTHZ9hGZaU11dF026UTi9jdFo08r56aVYEAP+j//nku0T2BaAZ
         q/4yhXpwUmMCCZMqeqK0CCgDu1FbSz/exVH/w6Shp9FielZIg3AQIM1ny27GaxjPm21X
         0Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990387; x=1732595187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDXPQkZOVm9U/Mg881fGci+SQNaJQQyzgFI30o6wQ1Y=;
        b=bTs0YP2e/jZlWQx0iVK8B8e1rsM+wGfP9gyuTB2K4yElxQemuNvEY4oaECr4iucSii
         XiGYSOkY2hXy7ZTXPOZiBNhvihYRLxLq0Nsb+g2w59gRLo4m5asFTQQODXHLZKK1WQr/
         64SoCSGClH/k4ZGsMMsBy4k01W3VoioKhMQmoHcAuRFmm545FtdFur2iQXOC+Y7eJYLU
         d0tqA5cmshrjykdzWOKa2FTmaX9ghHnwVI/OyRwYx0LKvsWdo/zkdFvgKApPxV1MatKs
         9Qb0ECCr7NAmzslTDfuUwWlHKXLNcB4TEi/GTxmNcaYMyIx+PEp8NGY7QZYb3xxCVAJR
         MuJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCjt3NLvUJIEbewQmPAdslO3NJQqYfMLcknuY4IWmidT/W6VMPVLm+TlsiwU/3U95qpjqkq9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaafGfwySFKk+5AdVUwoWCrRUYN4+9BQ+Kl3Mtmk50ki3xATw
	uzN1XkAI39dPq1fqjjpXwuuHKcfDEXiCu5dmSaU8NQkXzWtcSWfqXYsZ+4PK0qBfDQp+gNndOUi
	2ggs+pmOkj6IK3eCMpZJwExVTnP5HGIRwPL2S
X-Gm-Gg: ASbGncuxPcL8U8O3SMrBCe6BFooOWr+J6ihUCNBKYdiUn8jjibeejizlJmsk3I4NcJE
	FhWRidBUrTlhoNfwT+cIJprjJThgjI6BLBOuMzARpJIGuopZ1jQhwDk7tq6JbfQ==
X-Google-Smtp-Source: AGHT+IF/r1teah4k0VGmjNjfXaRe4AN/tqYp/s0yMS6JVvMmza7AfV5ROErruWiVnCxutT4SeralMwUY8LJHWHPgsv0=
X-Received: by 2002:a05:6512:1316:b0:53d:a866:ff6e with SMTP id
 2adb3069b0e04-53dbe605e24mr1904e87.2.1731990385926; Mon, 18 Nov 2024 20:26:25
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117141655.2078777-1-yuyanghuang@google.com>
 <Zzs0xDi-3jdQSuk0@fedora> <CADXeF1GqzSWYmSFO3v6x7+KTc=Q+U9hUiTd+x5yvZaViSKSkOQ@mail.gmail.com>
 <695a0358-6860-40d0-989e-614e066a9170@lunn.ch>
In-Reply-To: <695a0358-6860-40d0-989e-614e066a9170@lunn.ch>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 19 Nov 2024 13:25:48 +0900
Message-ID: <CADXeF1FivD14xVJ-12dMDO-b9TPX7Ya8H_1iBBgCNd_6Mu1+yg@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] iproute2: add 'ip monitor mcaddr' support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, 
	jiri@resnulli.us, stephen@networkplumber.org, jimictw@google.com, 
	prohr@google.com, nicolas.dichtel@6wind.com, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion! I will split the patch into two parts in v2.

Thanks,
Yuyang

Thanks,
Yuyang


On Tue, Nov 19, 2024 at 10:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Mon, Nov 18, 2024 at 10:19:59PM +0900, Yuyang Huang wrote:
> > Thanks for the prompt review feedback.
> >
> > >No need changes for headers. Stephen will sync the headers.
> >
> > The patch will not compile without the header changes. I guess that
> > means I should put the patch on hold until the kernel change is merged
> > and the header changes get synced up to iproute2?
>
> What you can do is have two patches. The first updates the headers,
> the second adds the new functionality. What then happens is that the
> headers get syncd once, and then all patches queues up for merging get
> applied, dropping the first patch of each series.
>
>         Andrew

