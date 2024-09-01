Return-Path: <netdev+bounces-124001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154A96746F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 05:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4222825B2
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 03:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC50037708;
	Sun,  1 Sep 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcB77Cpj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00E1DA23;
	Sun,  1 Sep 2024 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725161446; cv=none; b=XWj6xxuQok9Y2ZQARBKw8zUsv+GVP+pVjj/u4+29EoMdCNlHloayOC8t8sczo+cooOOO/oyhbkwPIyMUh5VOH/0mT+lLA5SmtSAECur41AgxfrD90W2RrixaC5kTDjG1VpzTQShA94VVlS2PZK1Ew77GOScekSDvtBCJbPLq8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725161446; c=relaxed/simple;
	bh=/I1IUomCUBzCJEBvZ6x4hE86QXAU9pw47lEt5lqLm+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjX2YDGDqmrAkLfUr9ZV4OQI8AvJAw33yD1Bo4l+PGaYsmRMO7DMCcMDoVT8ljAE66x4FyqD7m0IEwuiFFhRCZycHLdOM5z+h4wCfo1aKis3b+TF5eeKWwzQ8Fo52q3Cqtrdd8hzcHCr1FWvj89H0EVR4F9uOYmOtXBn6pjpspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcB77Cpj; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e116a5c3922so3065686276.1;
        Sat, 31 Aug 2024 20:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725161444; x=1725766244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqg3nqXYUnOP0+z0hD/lLQVtKLhKFtTUOnsu7km9ivQ=;
        b=KcB77CpjPYUw+9SrPCRzTp4DIi/DWHkMt7xe9sKJgYxI8zKqS6HIMdi35Kv57VCDYt
         Ak+TCzdxbuUdtZPZ/D6UZJduL+vM66wPGuPI9GMJIAxSXNNUsGiYFNFimdz5fLAvuWsI
         em1PJANNYv/847eG7JilgQ3GGit9ifwHh/MFphohfjlmf9RXi4KosYKQrxDRmHKgNPYI
         4mLfsAQB+G9AgSol0g03eSpcCw9XC25eXKI1amDaVX/t0wbeh7nVT/wLh2yHNDlvUGYf
         xiAVtFh7mQ2JJ7puGmYMra1CvSKs7Y12mTWXVFsUevg/jvUUoh60yHnUCh+Yl5b7m4nf
         dnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725161444; x=1725766244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqg3nqXYUnOP0+z0hD/lLQVtKLhKFtTUOnsu7km9ivQ=;
        b=ckLOZKpAJKin8Osw4rOtcPVkQ83NgvmMz0LY/HFnN2FYR97tyl9ehzhyBxGZx28rqe
         tl6DWObIH7V2p2zO1JHLXPNfVsklTxDgDHLFL2dypLt/9dj7V6347xX+ACVxcKFpk/e3
         xcgg6rgqJMDk6dNOH+XVZq4KjpbA1tQwgxiNBwsuwbJy8BWOnkEAEofMHgXnPuT4UYxs
         aQ7VQ8TpMsfShLltjyG7LbNfsVnaIYqyNSE1eE2BNu9/zTLmQCbln0yR1+X+uWwhga0A
         3w4PP47+iO1uz+/8R4GqpV6pFb58NOrST3HyYE1kAqEtqgfIz3Fp+Vet7iTOthxr07bz
         IUBg==
X-Forwarded-Encrypted: i=1; AJvYcCW7xLb8I3hnVjbfKEKePYY9+k9IMAz4xBWWH8lze7ykoYgYYMffQCCGBtCbHX2JDEBbtwlYqVDe0Fcnq8g=@vger.kernel.org, AJvYcCXz/Z1L8ChcbjOlquDW0yNf1vz/8T9jm6/JbIaOGY+cq1+gGIQ2TOg8oHeOB/EMcv4SUCln2YuC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5wTtkHTYSTJ/vP2DpPL8uMZTcomnbpFt3t/39YjSrFZdBOcw
	yGaIu6tmN5IoeMwJJIMN6Q8LyeiYzExJOgyPgGMwSBnUMEcy5gIppUFoHGGOi4cCnF9gZxPbbBT
	CIUnFSBaDhoGCMQ0bmo/8UehCGfs=
X-Google-Smtp-Source: AGHT+IGxs8e1tn3D0Wpo8Ov3XXA1j7K8XAhvF8sC7Ubb9XE9sshjdhFkrnae696HF2A2v1Eo4+kr1HXnDxgf/ZPLBRw=
X-Received: by 2002:a05:6902:1188:b0:e0b:eb96:fd81 with SMTP id
 3f1490d57ef6-e1a7a009527mr7911948276.15.1725161443906; Sat, 31 Aug 2024
 20:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-2-dongml2@chinatelecom.cn> <32b49d2d-fac7-47cb-aa78-c21e8bd2f479@intel.com>
In-Reply-To: <32b49d2d-fac7-47cb-aa78-c21e8bd2f479@intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 11:30:45 +0800
Message-ID: <CADxym3ZC4_GzvgK3gPz=8xHWMky0=9x-nH1AT0eaSTv-uMbGhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/12] net: vxlan: add vxlan to the drop
 reason subsystem
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:43=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Menglong Dong <menglong8.dong@gmail.com>
> Date: Fri, 30 Aug 2024 09:59:50 +0800
>
> > In this commit, we introduce the SKB_DROP_REASON_SUBSYS_VXLAN to make t=
he
> > vxlan support skb drop reasons.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  drivers/net/vxlan/drop.h          | 25 +++++++++++++++++++++++++
> >  drivers/net/vxlan/vxlan_core.c    | 15 +++++++++++++++
> >  drivers/net/vxlan/vxlan_private.h |  1 +
> >  include/net/dropreason.h          |  6 ++++++
> >  4 files changed, 47 insertions(+)
> >  create mode 100644 drivers/net/vxlan/drop.h
> >
> > diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> > new file mode 100644
> > index 000000000000..6bcc6894fbbd
> > --- /dev/null
> > +++ b/drivers/net/vxlan/drop.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * VXLAN drop reason list.
> > + */
> > +
> > +#ifndef VXLAN_DROP_H
> > +#define VXLAN_DROP_H
>
> Empty newline here please after the guard.
>
> > +#include <linux/skbuff.h>
> > +#include <net/dropreason.h>
> > +
> > +#define VXLAN_DROP_REASONS(R)                        \
> > +     /* deliberate comment for trailing \ */
> > +
> > +enum vxlan_drop_reason {
> > +     __VXLAN_DROP_REASON =3D SKB_DROP_REASON_SUBSYS_VXLAN <<
> > +                             SKB_DROP_REASON_SUBSYS_SHIFT,
>
> Maybe make SHIFT start at the same position as VXLAN, i.e. align the
> former to the latter?
>

Yeah, that looks better.

> [...]
>
> > diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxla=
n_private.h
> > index b35d96b78843..8720d7a1206f 100644
> > --- a/drivers/net/vxlan/vxlan_private.h
> > +++ b/drivers/net/vxlan/vxlan_private.h
> > @@ -8,6 +8,7 @@
> >  #define _VXLAN_PRIVATE_H
> >
> >  #include <linux/rhashtable.h>
>
> Also an empty newline here.
>
> > +#include "drop.h"
> >
> >  extern unsigned int vxlan_net_id;
> >  extern const u8 all_zeros_mac[ETH_ALEN + 2];
> > diff --git a/include/net/dropreason.h b/include/net/dropreason.h
> > index 56cb7be92244..2e5d158d670e 100644
> > --- a/include/net/dropreason.h
> > +++ b/include/net/dropreason.h
> > @@ -29,6 +29,12 @@ enum skb_drop_reason_subsys {
> >        */
> >       SKB_DROP_REASON_SUBSYS_OPENVSWITCH,
> >
> > +     /**
> > +      * @SKB_DROP_REASON_SUBSYS_VXLAN: vxlan drop reason, see
>
> "VXLAN", uppercase?
>

Okay! I'll change this commit as you advised.

Thanks!
Menglong Dong

> > +      * drivers/net/vxlan/drop.h
> > +      */
> > +     SKB_DROP_REASON_SUBSYS_VXLAN,
> > +
> >       /** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
> >       SKB_DROP_REASON_SUBSYS_NUM
> >  };
>
> Thanks,
> Olek

