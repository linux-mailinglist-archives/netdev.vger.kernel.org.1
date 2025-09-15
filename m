Return-Path: <netdev+bounces-223197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA594B58421
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F154C4083
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACC2C032E;
	Mon, 15 Sep 2025 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aRf31/9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305792BEFE6
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958983; cv=none; b=TcRZ8gGwtbmu4rZxNn62bX4JbhtXShh2e8zi3QJTcXuJycE6mXS+l85l7cYp2HXr71S+wISrSH4s0HxJhbIV58funVPILh30osHCmC6xb4cYKtW7Q1SHIdyEePrZoo5J5BkCCqs8MiFr9enYwC75fGTwAQZxt3c2s6cZsA7pZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958983; c=relaxed/simple;
	bh=pyln1+t7r3NReffU+GcqGlg7dQEAIsHl0+sNo5XvP3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEGIqNOfRK6D2QBTI9/M4SWJIy8C65AAD43YoGf14Ze8BgqLEgj1FJO2e4TwDJ1sTMCY+kYx4xqEwXG3ASKIknW0eK4CIvPsOmo2JsUeCBBMIBa2TD/M/2CNEDzGzRobd/kD5BAAN0tptstzPGKkHz5mbP0+Uj1U1P+8Nua0Wxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aRf31/9J; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-8b32453d838so2413183241.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958981; x=1758563781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJbRTFvItIOxNjF8btTHP0zPk7LDQHPgGj0UqdfwXlI=;
        b=BWYrr6FD9Ty1g/3qg1PHFY94KvQbCLZpRE0yHK99d82yu/H0KQQYAS/NITe2uvjf7E
         Y2pwET/9jIwrqAUq2ViMyxGoPq5qwqGR0b+EARK+WhQd2qoAiUDtfc7BUrDntuU/H6wH
         cegYilXAYUgrhUQP6WurjhqdP7aw6LcslihLHwbozCvoazpaewfIYUTNdDs/X9sO3of/
         bhiYDOsuzA48buAAdFnD5ppIMThzONR8TzJpFhQFOTKQnnf0/Piv5/EfzOoFDM1yLph7
         mOsY7U02EVEbq1ea0q74XIDwAGaHldWNX4EqOYXEtIXDZtfOK3LrQtTGDpXYEZE5hVP8
         xg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfxhQYlgf5lJE/SPEgeIVEl4E57SIqhVwx19isxz5qn6ugd+zK5WwFpOXbDsEUcigNzNU/SZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN56o3zdye2Kr0fhNNQLWOgB9D94d4DbQ/w6zWD/FOaIo60fWj
	vZgeWSX+0342G5X6Z2u44KB0156/fWkGiLg/FvJjqFm7PLOeSxFd8mIYclt0Trx92J3fxtsmHJT
	jcHu6xKdUlkAnW3L7GWhHv/MEeCPqlDm+d2PwdwlfQvkBxuPFs/zzElBbqrV3TAuQ/Iyy1EBvpb
	3B3RwMmraEndkJUW/OPjeC425D03AogbCm/H/A225Wq9vDB4WfBodRbPlFbqcdf2XXsDMx6rBNA
	sU1Ol/laebyoVO9Mf8S
X-Gm-Gg: ASbGncsTwXB+X77YTr++fIirmN+KJwEe2uYzGEhNB2kXvN8eD2iMhWe5J1s7qVVTtoN
	1vYMBk3YK7J0l3M7CgPXUNalW7uoO5uwGIIliVsLYu6Nw18whhagdMO7h3CXzEcaYGI8i6Zl5y3
	zQxh3EkLijpsugj4/AEmAySW9AFki8aysQa9j8H5kynBLlzv2HYacMIpSA8TTQzlwmI1NoheQvG
	R4cgozdSibJIlpTDga56Wo/6H0pM79+s0sf1lgvW8j7HKH7WenLGeu58ENV0BY1TvQUFs2GT5v+
	hs+Ul5KHYJR9DNQfn7zg+BQbd5TpMlaKx+9ElsWvjh6+RboolJUS1Nln4oX3tHg2Z1AgHy2dEKe
	LbHgaWApwvH5VaqtNyzaMNyiLTfLTgiMvOi6GCuaeJOnDgKcMajfzGoiI3Cfq4A/mGL3UJU8EKK
	nv2nLb1mVa
X-Google-Smtp-Source: AGHT+IEEavVE89FdIkFyvr5DEgqIQ64AZX32YhifyCO4Gbn+SlvJ6W+tVuV7JDHZs/3C0Di7HDRxQT8GwGLk
X-Received: by 2002:a67:ee1b:0:b0:55b:fceb:36d2 with SMTP id ada2fe7eead31-55bfceb4796mr2269343137.32.1757958980950;
        Mon, 15 Sep 2025 10:56:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-55370931fecsm954146137.1.2025.09.15.10.56.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 10:56:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54ac2658acso2580490a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757958980; x=1758563780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJbRTFvItIOxNjF8btTHP0zPk7LDQHPgGj0UqdfwXlI=;
        b=aRf31/9JQbh8ec3DAbRVvMVqKx3GfFBU6DwSZHcWhEJWYKXzQaWzLq6yELYPy5pFZO
         I0HQQdAnJ0Zv4vGhA21arm2KGdJevP0CeHbmY338/AjetaZ/vrmpM/9NimfXGGNbIwFN
         3jU6M4LZ1Sdq4A/By36m4TJ1esIm8LK0fNeYQ=
X-Forwarded-Encrypted: i=1; AJvYcCViFGn3A/YYpH4zGYD+rLvzIsqOhtvZ2uKxyel9SuukpOzlGoXdU7ujMTAO9t7um0Deg9lWV+k=@vger.kernel.org
X-Received: by 2002:a17:902:dacd:b0:25d:8043:781d with SMTP id d9443c01a7336-25d804381bcmr158134755ad.21.1757958979780;
        Mon, 15 Sep 2025 10:56:19 -0700 (PDT)
X-Received: by 2002:a17:902:dacd:b0:25d:8043:781d with SMTP id
 d9443c01a7336-25d804381bcmr158134515ad.21.1757958979436; Mon, 15 Sep 2025
 10:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-7-bhargava.marreddy@broadcom.com> <20250914133150.429b5f70@kernel.org>
In-Reply-To: <20250914133150.429b5f70@kernel.org>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Mon, 15 Sep 2025 23:26:07 +0530
X-Gm-Features: AS18NWAdwcC_lAEZq2uYBCaX6F8v5R_jkiei_yxqCSuPoChdSZfVNZ-cFOt-fRU
Message-ID: <CANXQDtaB7HcSujG1R9i90YUB6PdOin4=CsKzGvNX6tGMw8n+mw@mail.gmail.com>
Subject: Re: [v7, net-next 06/10] bng_en: Allocate packet buffers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com, 
	vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, Sep 15, 2025 at 2:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 12 Sep 2025 01:05:01 +0530 Bhargava Marreddy wrote:
> > +static void bnge_alloc_one_rx_pkt_mem(struct bnge_net *bn,
> > +                                   struct bnge_rx_ring_info *rxr,
> > +                                   int ring_nr)
> > +{
> > +     u32 prod;
> > +     int i;
> > +
> > +     prod =3D rxr->rx_prod;
> > +     for (i =3D 0; i < bn->rx_ring_size; i++) {
> > +             if (bnge_alloc_rx_data(bn, rxr, prod, GFP_KERNEL)) {
> > +                     netdev_warn(bn->netdev, "init'ed rx ring %d with =
%d/%d skbs only\n",
> > +                                 ring_nr, i, bn->rx_ring_size);
> > +                     break;
> > +             }
> > +             prod =3D NEXT_RX(prod);
> > +     }
> > +     rxr->rx_prod =3D prod;
>
> You should have some sort of minimal fill level of the Rx rings.
> Right now ndo_open will succeed even when Rx rings are completely empty.
> Looks like you made even more functions void since v6, this is going in
I changed those functions to void only because in this patchset they can=E2=
=80=99t fail.
> the wrong direction. Most drivers actually expect the entire ring to be
> filled. You can have a partial fill, but knowing bnxt I'm worried the
> driver will actually never try to fill the rings back up.
I believe the driver should return an error if any buffer allocation
fails and handle the unwinding accordingly.
What do you think?

Thanks,
Bhargava Marreddy
> --
> pw-bot: cr

