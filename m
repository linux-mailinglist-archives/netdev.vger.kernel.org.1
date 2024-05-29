Return-Path: <netdev+bounces-98886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43018D2E69
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DEC1C21518
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08615B0E5;
	Wed, 29 May 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rC4JZhMK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD11E86E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968360; cv=none; b=ihyZjn2++IJ57lJEoNXml+4e4Q6fe7xn2isn3VU/8Zi0ZEZfaK4AkQ24byptTYYAiKTOm3wLoqgKga5jLBIw24X/S18qgmk5YKHkTtmkfmRAFM+BROQ1CjW9doPjBIaJPgwk3re7KGdY41/NxKzFDPKL8BSqC7jqXsCfJFkYGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968360; c=relaxed/simple;
	bh=zqSga+Cfk+QgqzDDg9f/t6hKmun4jgbCSz3D8vkR2ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mS6sVU2xcgbG/NKiYtRIidqfKE1MV1PA/pR8TH8XZvDOIkRjJBZA9Uqql6kdc1025qVmthb5SbC+098MVGP9r1TM+0X3IWb/t+SDff2LGlBvChvWT43Kdimb31/zQN9/+BPiXH5IrCcNYWCgAY4c7tOmjt6HdwOgWvn5n4DJWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rC4JZhMK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-579ce5fbeb6so6739a12.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716968357; x=1717573157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfyKHygS+8WJOQiwgej5G3TXseMROgxQQqzYmTIxdVE=;
        b=rC4JZhMKA0zXB4YzbtaJVurHpuMyHKyjs8mZ/UkOlwtiIAGRJ9cyccCYrY+LOWqRyX
         73S8Ceq2P+tIo2VGBpDJ36eoPJVe96Ns4gXagWr/GtytpmCgl1LdFY1jP6ERV6sUyK7w
         x2rsaqbl36bB2kgPT2d+nVPnJNta9i1uU6cTKHjbyOw67JPuzRfKdOeK27OB2kCC9HTR
         KraNe5+ptayot6MCo+zyWXOSdQhSflhB2WQ5c/lyr8mNYSdK9DXl//aCvK4VuAlOaMUu
         kRWaQ2t+o4Cb6YHrMMnRBqQy+8bQZRlhltV3DJXD0P0UngxU+WAIFijdWDtVdl8lR47f
         nQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968357; x=1717573157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfyKHygS+8WJOQiwgej5G3TXseMROgxQQqzYmTIxdVE=;
        b=R3Y/0GDRPwFbSsKaoFul0VErETmeTd12gedwkl6koRW0NaPq1lUlSRCHEBJDJ7TA6q
         thII+pLQTqVqu49ku03sTAf9hZJf8ukxjkcErDfmyyA3+SreqWKSwO1/MmZ/9B0MfFbA
         c4O4wDIcCw3WMX8eDw4AyGZGbnZ3C236NOMKpv1pLnIRW8A3jaE+CLkM1SjCza2Mqf8O
         Ia8u0R1IxJIgL8uR1Xof9E2ESgQY8etEjnKESDuNFwbkZof+3qfwvNALHNk+MTDOlHXO
         XD8uC/uiq26+ZUPEfBxe0OhIgrBv6ipt2D/OGnVah+GSHX1qkEmXltRKvgLpexKpx2jw
         cZFA==
X-Forwarded-Encrypted: i=1; AJvYcCVWU666WH04KQPpCNvYo4sMnnOD+ht/N4rKIgqXOzcpJRCv9MYlo5IJ5kjUeS4AHYy9UR6+POkBb8vFRHRPhVEWvG3/nRvp
X-Gm-Message-State: AOJu0Yzc7m9g/AkIU0biFiMugqu4MIk9KvnpJnjiM1odwpkVeWEqYjQ7
	Pi+vDVmEd6VYHlAdERCVSxnrQrY7u9dVCsowyvlOVZQbaVt7fxluyDQYHkgOMVFpwlzFL1jrEev
	5RWTFPc6oYajCds2UqlkGgNuuGOjBrIRbqVxh
X-Google-Smtp-Source: AGHT+IFGFNTyXAT6muUr8hLD1oUFSM6Tvj29lmxUXlJXdNSf6oQnhJAxFUbMzSRdWoXDZkOx7xRbBlGsvC3113L8rMM=
X-Received: by 2002:a05:6402:1347:b0:579:d7e8:fc6 with SMTP id
 4fb4d7f45d1cf-57a033ae5b3mr109100a12.4.1716968356503; Wed, 29 May 2024
 00:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com> <CAL+tcoCR1Uh1fvVzf5pVyHTv+dHDK1zfbDTtuH_q1CMggUZqkA@mail.gmail.com>
 <CAL+tcoA0hTvOT2cjri-qBEkDCp8ROeyO4fp9jtSFPpY9pLXsgQ@mail.gmail.com>
In-Reply-To: <CAL+tcoA0hTvOT2cjri-qBEkDCp8ROeyO4fp9jtSFPpY9pLXsgQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 May 2024 09:39:02 +0200
Message-ID: <CANn89iKb4nWKvByBwGFveLb5KL_F_Eh_7gPpJ-3fPkfQF7Zf0g@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Kevin Yang <yyd@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:00=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, May 29, 2024 at 2:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Kevin,
> >
> > On Wed, May 29, 2024 at 1:13=E2=80=AFAM Kevin Yang <yyd@google.com> wro=
te:
> > >
> > > Adding a sysctl knob to allow user to specify a default
> > > rto_min at socket init time.
> >
> > I wonder what the advantage of this new sysctl knob is since we have
> > had BPF or something like that to tweak the rto min already?
> >
> > There are so many places/parameters of the TCP stack that can be
> > exposed to the user side and adjusted by new sysctls...
> >
> > Thanks,
> > Jason
> >
> > >
> > > After this patch series, the rto_min will has multiple sources:
> > > route option has the highest precedence, followed by the
> > > TCP_BPF_RTO_MIN socket option, followed by this new
> > > tcp_rto_min_us sysctl.
> > >
> > > Kevin Yang (2):
> > >   tcp: derive delack_max with tcp_rto_min helper
> > >   tcp: add sysctl_tcp_rto_min_us
> > >
> > >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
> > >  include/net/netns/ipv4.h               |  1 +
> > >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> > >  net/ipv4/tcp.c                         |  3 ++-
> > >  net/ipv4/tcp_ipv4.c                    |  1 +
> > >  net/ipv4/tcp_output.c                  | 11 ++---------
> > >  6 files changed, 27 insertions(+), 10 deletions(-)
> > >
> > > --
> > > 2.45.1.288.g0e0cd299f1-goog
> > >
> > >
>
> Oh, I think you should have added Paolo as well.
>
> +Paolo Abeni

Many cloud customers do not have any BPF expertise.
If they use existing BPF programs (added by a product), they might not
have the ability to change it.

We tried advising them to use route attributes, after
commit bbf80d713fe75cfbecda26e7c03a9a8d22af2f4f ("tcp: derive
delack_max from rto_min")

Alas, dhcpd was adding its own routes, without the "rto_min 5"
attribute, then systemd came...
Lots of frustration, lots of wasted time, for something that has been
used for more than a decade
in Google DC.

With a sysctl, we could have saved months of SWE, and helped our
customers sooner.

Reviewed-by: Eric Dumazet <edumazet@google.com>

