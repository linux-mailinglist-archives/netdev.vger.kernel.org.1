Return-Path: <netdev+bounces-145229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160199CDC4F
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D087C284D4C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B241922FB;
	Fri, 15 Nov 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1jdbBMn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0818D649;
	Fri, 15 Nov 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665808; cv=none; b=MssQGODPsEavASjcuzYIe/C/GgeK+GxsG8cRSvvO9WpZg6njP3DKpMSYciNnzpAy2nrjAy408o4HTtAjTnm0uTwC9uBsSfpanVCUMbw86gJVMGJz89YbaVDpzLxrVpoPbVViIW827bW31Xl95XHXM2Z5EKDKNI6uax4mxCtGCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665808; c=relaxed/simple;
	bh=oMze29ANq0WwQxSvrnIM9V2D3J7cDokj8J9g5dDx/nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NieSLOOkL1bid0eh+35XbmMPhtUaSOjjIPnUqKclbesJJTDJIQXPzkGCZMpt7pjcCKfjDKHP3CDbEL8HIcwaKm6GrjxGRD9ocby+CISFE4ibVbCzBSNtj8zYaUlfm4f1uBtfl1MdGdC0IQxgwt/VFHHTuvJRt9qssh5arlL2rQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1jdbBMn; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6eb0c2dda3cso17498857b3.1;
        Fri, 15 Nov 2024 02:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731665806; x=1732270606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYW4S10W1bOXdZFhzL/Q7i/69gOgUi2ezacH0FRB18Q=;
        b=Y1jdbBMnfUtnu/XbHQkLKGDHmWGSb7O4uNsaugRrjymRUBXJSi+VjnfIBwvPrd1cXL
         rGXzW+57b456/d3/da6915VFcEULOu+m6e6D9mqDQuDt+RF7exgrV4zPcBNMMipgh3gR
         Tgq1RhvHUhtBr1JxCIyRoBOWLKbyMugSIjsiH2U9EAdiqhFXtrpa1Bue7q8DdwUJ5bvu
         EEMxWColI4w4dV7L5W9ndizCjhHjn+mZL6Q5iTrMVgwV1IqkxLO6EK9jbsGbLxOZ2/pF
         MWYi4kCwPRtSMq4PflIRyfjuOZ8BJNmPLZNXYYJz8xT0Xr3I3vr2g2xZwcAFPiXz0z2Y
         iiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731665806; x=1732270606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYW4S10W1bOXdZFhzL/Q7i/69gOgUi2ezacH0FRB18Q=;
        b=rwYIvo522PGM+qGzKovqb4SuJy4HaDSIxzWNHMmoUGgReLYT01uueancJ4EDxanEXL
         v7i/0VOKaGDx/Q4WgZjssgbEgADJFRPld0J4CyVafj/0gvI/jmBkIvP/P2d8ajvNc7ag
         rRucu6lgx4QIM85SYyenBPiZ8CRcweUC9V2SG/Gk6B/02GW2L+X+xtSuD4BlI5XUo0E5
         Oq2Hoy7uNhnYCP+qsz12dviWybQYqfWB2q/lGxCHSuLB2nCdM05RYWukjEvzhdwAIS5y
         XemlEGemQhZoq8rhD+7+Ab42net8Bu+ionju4AlTie6WChqmmOXKQ3382H5i/20uPISn
         GUFw==
X-Forwarded-Encrypted: i=1; AJvYcCVTk7Mx9GwGTBqs/nSbcaSGqPp1f4Gjs11OVVQ0WFXW0sq0rr30I6/PZC+fdAbUa7ZH6HqJ04yd@vger.kernel.org, AJvYcCXmK6JVnaei5K3bhEOZaP2znPV/jXYMhL4VjPHsW94+a6W2BtiYA5MuroH4sgsUyxlVVdgo/mTujmIfbhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9cRHqscP0kwWz+8+bV6lQ9JpDhGnLKBZDLusgbHgJGS8q9Hx
	z8ajJHFwRqVh2XflcSsqsKGJcKg9ZMsxXuU6rzpcQNFKIApLi08n4tgzvdhCL80oiJkproslWWj
	d5li15ye91mtoHAHSX9s3rWTw9cHiamXTKZ8=
X-Google-Smtp-Source: AGHT+IELZiDxgEetkDuRcJdTWiPgao36Nh3+w5wUNBouyxYrHIterK978ryr+t9D41kQ6/Q0qVTaYonqu/PoJEJMvds=
X-Received: by 2002:a05:690c:4b0f:b0:6ea:8a5e:7fbd with SMTP id
 00721157ae682-6ee55bbbe47mr34064167b3.2.1731665806378; Fri, 15 Nov 2024
 02:16:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-7-bbhushan2@marvell.com> <e03fbb80-2f44-465b-9152-d85302b9454a@redhat.com>
In-Reply-To: <e03fbb80-2f44-465b-9152-d85302b9454a@redhat.com>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Fri, 15 Nov 2024 15:46:35 +0530
Message-ID: <CAAeCc_=SDXKA6DyS=kBr0TZMxixfnXzK-V9ZW7OUGK3swJKdDA@mail.gmail.com>
Subject: Re: [net-next PATCH v9 6/8] cn10k-ipsec: Process outbound ipsec
 crypto offload
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, jerinj@marvell.com, 
	lcherian@marvell.com, ndabilpuram@marvell.com, sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 6:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> > @@ -32,6 +33,16 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic=
 *pfvf,
> >                                    struct otx2_cq_queue *cq,
> >                                    bool *need_xdp_flush);
> >
> > +static void otx2_sq_set_sqe_base(struct otx2_snd_queue *sq,
> > +                              struct sk_buff *skb)
> > +{
> > +     if (unlikely(xfrm_offload(skb)))
> > +             sq->sqe_base =3D sq->sqe_ring->base + sq->sqe_size +
> > +                             (sq->head * (sq->sqe_size * 2));
>
> Not blocking, but I don't think the unlikely() is appropriate here and
> below. Some workloads will definitely see more ipsec encrypted packets
> than unencrypted ones.

Idea is to give priority to plane packets, so added unlikely.

>
> Perhaps you could protect such checks with a static_branch enabled when
> at least a SA is configured.

This is a good idea, will add static_branch when at least a SA is configure=
d.

Thanks
-Bharat

>
> /P
>
>

