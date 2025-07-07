Return-Path: <netdev+bounces-204568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD53AFB388
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 14:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10361AA4132
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18B28FFE6;
	Mon,  7 Jul 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EW5dwWOR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612681E51EF
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751892514; cv=none; b=rDaGx4HCs8xMEJI6jUPfkETOMxrJh97B6neQsACLOSwOZXCR91HiiOxhWGUcF8VvpRFJIWFsFzHcQUtg/HAQUzI12lIcL6C2Su6kGb9ZmOm/OfkBOL6eTNK9k1bf6yrLGU/HDT43k2Bzw40VwcwPylmlUujQmM0ocwAPY1rZm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751892514; c=relaxed/simple;
	bh=NXpBj1xWmYSm2okDyKpLvpJZzkmkIQDkt0bkS1rc0rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAnljHCedDWV0gSnuu8u5qLOFMfvgpqbErcAI6zxftBf80Pq14cckemR4LyTSVvQkilQeD7TytrmlPA8SxzU7gGXOUoK3cmG+XIGaf8iJ1ymRtnHvNM7pLEZ4iR/mtMfWaSC5REU+zR4Ajo3Bch5y8I2EWZ2DHX/LZ4fcc/ruyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EW5dwWOR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a5903bceffso46494241cf.3
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751892512; x=1752497312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXpBj1xWmYSm2okDyKpLvpJZzkmkIQDkt0bkS1rc0rg=;
        b=EW5dwWORw1YPgr7fuixxgWCPXokw9thYRtVZiMWvRFBTDeuVAFni012yQRzx6Wk2DG
         ziSiqdvXegPif9nKIK1IY3gFIA+kG8sB1nhWhTccXvFcA1viTYoI8n9GxjKQde5rvl/1
         7WXlR/wp6dyAqvTv+hJF7xFojy/BDDSGnEjQkoLHdmFq7yk9QPcSugRfUnyoS2RhRqOh
         5sj7pa2LBjII7AOB0/Nu4+gL2D0N730byb+tY3sf2f5rqMODIkYCqt0MIffHoKKTghzd
         pvVj1JAVIu2yT43ViNxvljeYo3nZQqFsgcHjZzWRJoQBxt5R673OWVhBxJkGyM2e+Pfs
         zkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751892512; x=1752497312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXpBj1xWmYSm2okDyKpLvpJZzkmkIQDkt0bkS1rc0rg=;
        b=NNcpaxZSL8eph0BiQ0J66LU8GAlSS+Za2dIYY5dnrA39N4dZQcSVirmXujHKu1kM/o
         Nm3ng8g3OcnSTq+2006njElWprNt5AOzrSIuduLwPV/706VMkAPUtanCfjbDOBZ3JTmK
         I9dGERgOOQg7twVw2q/2tQx51crvvGUw5OmwBmJFh3n5XbIn0UerTxSIzmrSLdDKqB8c
         /AKd7YctqxWmd0bVZgouC1lBtgUgeu2bQHuwc2TLe9MuRoxxQY/xunzWQ1FWvkaMhySQ
         lbamfF96W1AvhE6h4w85PgNxMYoDTKv87/lSzLSzRs8JgqMa/8jfGsYsrkQV6ZPfcuTv
         EG6A==
X-Forwarded-Encrypted: i=1; AJvYcCWMeLkAeszFSFyJwQp010JCAf4pmsLgXBdmu3aC/ggFfHmDtcS0+LtgfOh402nddhgL8ee7lic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1b8yPyLAMhL90i1OArnTaa+ebIJhLH7qHUmMRyMh4vG3xmdrG
	gGba+dZuu5LMxbhUf0pFmDZDVIY95xVKO/26g+GCIW82JRLy3Ktd8N3BX7cax+zyW45zUstJoDW
	OY2R60VtXUiYQVqfyeg5bQLh7bDCsZqGZeYkiql8b
X-Gm-Gg: ASbGnctLA38ntTOnR2oq/L2oc/qGcDJDKmN/LxDxsMJ+P68Stm8DQ0Ho89tiiqK8BQS
	2u3Q+/MJAow2XT8Ky1joXh2upv4rzjBw7OUnOJw6r7vaNFhS/R7LCBc+SBI/VKOPG5j/zQDYx1r
	zYapuWvyHAPD8ZNVgDL9Nnws/E//0skxAxcHJEP9LD+co=
X-Google-Smtp-Source: AGHT+IGE1/XRTdSQDLc9V189phd4jHM7XVm3uMpcn0vgf/Ns7dLtQveHK+v9fsiJrfRa4TWVDv16yAZUooYaDzGa39w=
X-Received: by 2002:a05:622a:400f:b0:476:7b0b:30fb with SMTP id
 d75a77b69052e-4a9a6dc6185mr151173411cf.22.1751892511959; Mon, 07 Jul 2025
 05:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707105205.222558-1-daniel.sedlak@cdn77.com>
In-Reply-To: <20250707105205.222558-1-daniel.sedlak@cdn77.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Jul 2025 05:48:19 -0700
X-Gm-Features: Ac12FXzOaT691PWcNP8FePx9AQibU4CArjSNEVwylpr2hqUBjQG3P5r3EGY0ZLc
Message-ID: <CANn89i+=haaDGHcG=5etnNcftKM4+YKwdiP6aJfMqrWpDgyhvg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: account for memory pressure signaled by cgroup
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Christian Hopps <chopps@labn.net>, Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 3:55=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn77.c=
om> wrote:
>
> Currently, we have two memory pressure counters for TCP sockets [1],
> which we manipulate only when the memory pressure is signalled through
> the proto struct [2].
>
> However, the memory pressure can also be signaled through the cgroup
> memory subsystem, which we do not reflect in the netstat counters.
>
> This patch adds a new counter to account for memory pressure signaled by
> the memory cgroup.

OK, but please amend the changelog to describe how to look at the
per-cgroup information.

Imagine that in the future, someone finds this new counter being
incremented and look at your changelog,
I am sure that having some details on how to find the faulty cgroup
would also help.

