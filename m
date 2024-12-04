Return-Path: <netdev+bounces-149028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C99E3D03
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC21B35740
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC5209F51;
	Wed,  4 Dec 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/N+NBeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF420A5EA
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322978; cv=none; b=XOwfwPFktNWhFZ9tmzi8Z8xKfezI2rNmAdZTmCF0n4yVjSJHx60/dKXNYxwdlHQiPANWeZOvreMvs/uVTGMJre930ZbyM10SKVDHEqH74b11km0hfSUTE40xrjbZG4eRXrkaK/HypO9efFxAX9MuwDe6fXl+9FutYYRkxbJ8okc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322978; c=relaxed/simple;
	bh=0bmVTFLt+sSuwGomKHtqnx/4VeqH+qO24iiSXNbBrC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjMkpSOn+b6CrjPKXydyZvchWACub9yfkUp4eplmAGS7xdkQmwaoCu5GxGoVDmecJ8c5kcqvjnqr/cnVdOOtdSKU/me+022vWOClwx8e+ojGQDeQ6r78hlX0QsMr4ID5Y+z482f2G10+bO5+K6AdqFcx3awi5Cq+iXgmIoGPN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/N+NBeD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso3827499a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733322975; x=1733927775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbAqviTrMDFEsTtVuuw8r7wXVGU0Ghm0Gjor+kN86R8=;
        b=d/N+NBeDo+aFN6UpVAwGsjyR/CahMSWfKkk8jB3lB49aOF6MHsOam1xVkR/Duk8UwC
         HFGG7mrjeRBPGCMdFSWwNTWd0EV3VStjDaX2nkmzGQRUtCVJBch7MDyLeENc9/6qalBr
         y9n7K+nR6b9m687aXra6bvN8h6ZV8u2ovIGftx3wFKf9YXsGdREsiB0DG/U0rvinYfzZ
         5kYCyqSQhYcZQxDDl5Ub4f4biMmIVew7Qhvi5ZmPc/tHft4WZ7kfTu7v3C1mg9mFtoUN
         tVy5yTOgReUKdH7it23NmSpm6yfXnmKLKSo8qZu1ex494eRR0uvHXygDK9IVpid4Piuo
         zaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322975; x=1733927775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbAqviTrMDFEsTtVuuw8r7wXVGU0Ghm0Gjor+kN86R8=;
        b=M8HRVTeCpDAIkcZACKrcNNXalpWjdFaDeOjIuxbx/cgY7iDj8D5eXW0B4L0b9Oxi5U
         v9YOGn142LlqUDgL52hxCyR9ZTu0gw6St99EHejd2DfJVHKOZ3QnSXPhybjBjnn+AlLI
         2LHzKC35MF2AubfGYk8j2liY8pwG+hqraOGumj9dbsUBbPw7B5449g+wt6SJhuVrNuy+
         Sc6dXSU/94UCeM/YZ9pINotJuNHqTopNX/lXrgwgjMHXqp7uVTUN+7XCG5MnR2A6rpMP
         BHaQi3MvP4H81hsSmdnWJstF+/zggpe9Bdlzb5YgGiBWPqdWQ0KNbdUpU523uFm58XDe
         EaPg==
X-Forwarded-Encrypted: i=1; AJvYcCXDTdCVLT0LVzfGbBNxxQiwEKwCTMXuO5GiipTq5x3iG/xDvwOjA7MqkK276DWFYIAEwDzkI/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85NK6rFuF3WHe0bAZC++0Mflm29YK1Z+AEKdFL+WQAIoKI9Cy
	8Oga2WHd3Ivn2vsVVN7qWXgJJg2UHkYsBafrbT+PuFY+IQkpOGqzYUePKF/9TvncJNTvGlPpnKq
	YHbIg3i+4uVvw6hwb+rssk/4G9txrLkzBLvbd
X-Gm-Gg: ASbGnct0GyLrBDPnO+3HgHEpQ6YClsliV0v341WXQR3/1tfb0xsNCjpbAEFktMRbIVs
	5Hjti0FcxF0ByZqRVdDAsv6DsndIDzV/P
X-Google-Smtp-Source: AGHT+IGqiljbVJjmQnZSRdM2ia+5ZMDXyoUQDvZMEhHDr/1UgtgLahldyAAKyV3ach4I6XtjDqMwCUGI8KTP1sEJZS4=
X-Received: by 2002:a05:6402:4405:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5d10cb8017fmr5185516a12.26.1733322974391; Wed, 04 Dec 2024
 06:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140230.23858-1-wintera@linux.ibm.com> <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
In-Reply-To: <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 15:36:03 +0100
Message-ID: <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Nils Hoppmann <niho@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:16=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Dec 4, 2024 at 3:02=E2=80=AFPM Alexandra Winter <wintera@linux.ib=
m.com> wrote:
> >
> > Linearize the skb if the device uses IOMMU and the data buffer can fit
> > into one page. So messages can be transferred in one transfer to the ca=
rd
> > instead of two.
> >
> > Performance issue:
> > ------------------
> > Since commit 472c2e07eef0 ("tcp: add one skb cache for tx")
> > tcp skbs are always non-linear. Especially on platforms with IOMMU,
> > mapping and unmapping two pages instead of one per transfer can make a
> > noticeable difference. On s390 we saw a 13% degradation in throughput,
> > when running uperf with a request-response pattern with 1k payload and
> > 250 connections parallel. See [0] for a discussion.
> >
> > This patch mitigates these effects using a work-around in the mlx5 driv=
er.
> >
> > Notes on implementation:
> > ------------------------
> > TCP skbs never contain any tailroom, so skb_linearize() will allocate a
> > new data buffer.
> > No need to handle rc of skb_linearize(). If it fails, we continue with =
the
> > unchanged skb.
> >
> > As mentioned in the discussion, an alternative, but more invasive appro=
ach
> > would be: premapping a coherent piece of memory in which you can copy
> > small skbs.
> >
> > Measurement results:
> > --------------------
> > We see an improvement in throughput of up to 16% compared to kernel v6.=
12.
> > We measured throughput and CPU consumption of uperf benchmarks with
> > ConnectX-6 cards on s390 architecture and compared results of kernel v6=
.12
> > with and without this patch.
> >
> > +------------------------------------------+
> > | Transactions per Second - Deviation in % |
> > +-------------------+----------------------+
> > | Workload          |                      |
> > |  rr1c-1x1--50     |          4.75        |
> > |  rr1c-1x1-250     |         14.53        |
> > | rr1c-200x1000--50 |          2.22        |
> > | rr1c-200x1000-250 |         12.24        |
> > +-------------------+----------------------+
> > | Server CPU Consumption - Deviation in %  |
> > +-------------------+----------------------+
> > | Workload          |                      |
> > |  rr1c-1x1--50     |         -1.66        |
> > |  rr1c-1x1-250     |        -10.00        |
> > | rr1c-200x1000--50 |         -0.83        |
> > | rr1c-200x1000-250 |         -8.71        |
> > +-------------------+----------------------+
> >
> > Note:
> > - CPU consumption: less is better
> > - Client CPU consumption is similar
> > - Workload:
> >   rr1c-<bytes send>x<bytes received>-<parallel connections>
> >
> >   Highly transactional small data sizes (rr1c-1x1)
> >     This is a Request & Response (RR) test that sends a 1-byte request
> >     from the client and receives a 1-byte response from the server. Thi=
s
> >     is the smallest possible transactional workload test and is smaller
> >     than most customer workloads. This test represents the RR overhead
> >     costs.
> >   Highly transactional medium data sizes (rr1c-200x1000)
> >     Request & Response (RR) test that sends a 200-byte request from the
> >     client and receives a 1000-byte response from the server. This test
> >     should be representative of a typical user's interaction with a rem=
ote
> >     web site.
> >
> > Link: https://lore.kernel.org/netdev/20220907122505.26953-1-wintera@lin=
ux.ibm.com/#t [0]
> > Suggested-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> > Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> > Co-developed-by: Nils Hoppmann <niho@linux.ibm.com>
> > Signed-off-by: Nils Hoppmann <niho@linux.ibm.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_tx.c
> > index f8c7912abe0e..421ba6798ca7 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> > @@ -32,6 +32,7 @@
> >
> >  #include <linux/tcp.h>
> >  #include <linux/if_vlan.h>
> > +#include <linux/iommu-dma.h>
> >  #include <net/geneve.h>
> >  #include <net/dsfield.h>
> >  #include "en.h"
> > @@ -269,6 +270,10 @@ static void mlx5e_sq_xmit_prepare(struct mlx5e_txq=
sq *sq, struct sk_buff *skb,
> >  {
> >         struct mlx5e_sq_stats *stats =3D sq->stats;
> >
> > +       /* Don't require 2 IOMMU TLB entries, if one is sufficient */
> > +       if (use_dma_iommu(sq->pdev) && skb->truesize <=3D PAGE_SIZE)
> > +               skb_linearize(skb);
> > +
> >         if (skb_is_gso(skb)) {
> >                 int hopbyhop;
> >                 u16 ihs =3D mlx5e_tx_get_gso_ihs(sq, skb, &hopbyhop);
> > --
> > 2.45.2
>
>
> Was this tested on x86_64 or any other arch than s390, especially ones
> with PAGE_SIZE =3D 65536 ?

I would suggest the opposite : copy the headers (typically less than
128 bytes) on a piece of coherent memory.

As a bonus, if skb->len is smaller than 256 bytes, copy the whole skb.

include/net/tso.h and net/core/tso.c users do this.

Sure, patch is going to be more invasive, but all arches will win.

