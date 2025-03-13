Return-Path: <netdev+bounces-174429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6DEA5E8FB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 01:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180ED178B9E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 00:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB574A3C;
	Thu, 13 Mar 2025 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX7z5Lhb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40122E3399
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825602; cv=none; b=Pv3fjWEpI23PcXpGc9hJv74KG7fspy6O4DR3f/lZIRlqE/kP16Av65tftn3x16OnlCh6MkS8jyHdTaGp9Cz8FftFb2UsSmxZzNTxPhvStmRKzUei767w7jeW2nsikdmibVnHtgeyw5DGqrUGxFnWaCJqEdJxNHpAdBxlABibuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825602; c=relaxed/simple;
	bh=6Rc6J3Ph6dfxqwkjoMVz7ABCl1ew9fnFyyH4KQ9IHWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5B+NxKG69b+D8Zvyj4cF8B56ZwRHVmSfuQVi9tkGoadgU9WMKWVAiVCpHpVswRw7uigxmTLNpICsyD8X/wR3yTlQcYZFd1T/6xb+AawIcfpWY24MY8AD5qeMo7iEbC3/9SpXkQA9uwIjg/hOQ8du0RWieJzUvDbAC+P0H/Abug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX7z5Lhb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741825599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xc6FM+mqWnW8B2obbyayW6a16PfjrreKGG+xe06AIA=;
	b=JX7z5LhbYkuCYcKZ316/UPPHr7cZ1TAM29cn5pTmA6YOP5w4FnsNEGUq3w0OKJ12AFt4ph
	c0MwdSrJkYvLmsuF4yjcdgeDsgDj18n6emsRga7eeW8wmeZ+v8f2fsesUDVp8bi81d6CpF
	J9z4E5RWyr7n4pPuUdEPNDPdKyPSRkY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-c1ZAoxmyMk29ZujxGbOVBA-1; Wed, 12 Mar 2025 20:26:38 -0400
X-MC-Unique: c1ZAoxmyMk29ZujxGbOVBA-1
X-Mimecast-MFC-AGG-ID: c1ZAoxmyMk29ZujxGbOVBA_1741825597
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3010db05acfso660749a91.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825593; x=1742430393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xc6FM+mqWnW8B2obbyayW6a16PfjrreKGG+xe06AIA=;
        b=LjPYQcU0wMStQcbUa8op/OOkWPofBgavdcYMOJVf1ME2U1UQTFHZdduNMIdjZSwFKP
         050KZBpYqaEIG2HD9X7K7l/nmR9KyKZ92Ak82//7um+Hm1XWeuvKHh9M7S5Pt97J1VEn
         XHoYFNe/TY6LiGEWDD/iS/HZKCczr32b4EsSXXGADKc3uzIF+Er+LyM8w/YnTK+/gIVL
         jG212FKRc0xfIhs9XuTCFtFnBUOI1ryXfvGYk7tThb+T0v5YFOAtr4BT5yELe1Cm1PtL
         afBokjr3FAa1s+N6Kw9AsRN6LUKFrUDV4pwttxck3Xj4d0LzUT8LVXNbQyj1DG2nJfsV
         b2+A==
X-Forwarded-Encrypted: i=1; AJvYcCWnBAS4O/Dwye3hTQ8tBsgU7RjZhXbN5JQH8E0KNZ0wJwFdKEvP1xkC5vsbUeYqxtlta5/wGMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExCeR00ATPQxP8z2+QojGDsf6adZBz57He4yniGsPAjGAWsA0
	x8Uxpu84BGfx427l+8CRS+4lw45wf3U5xxy2InhY/i87PjyxYMXU+ElpumDeLReo+xl4ZEhUIHX
	qgvh6Ucr5qf11vJrIXcaAsllx7HwkjYXR/5okTpX64zQwocPEo3wBHrYQnp/oESpW9DsO8w2tFO
	TwiJf0xCA4HiuxnPrZd0rncl4WNk2I
X-Gm-Gg: ASbGnctT3PwLDJADYljUdXXTby6o8AwmTJogE3k/Ct2K6KmPCDBVbeFVim/8cPukhDx
	Xm7P5OdXUhpjdaOIz6EOHgmmrK4L8n95aaj12OcQzf2K1Vhqo6/oxEiRqAAgaJVNyQE00Ew==
X-Received: by 2002:a17:90a:d2c6:b0:2ff:4f04:4266 with SMTP id 98e67ed59e1d1-2ff7cef5c11mr28261647a91.23.1741825593461;
        Wed, 12 Mar 2025 17:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3dWZ4QwsfIUvoSozMvh5gYtrSDcXVdnTP4UK28eIoOYkpHPAKxIFpR9h9De/pEc9Z+J0NEctSIkQBCBJ5tuk=
X-Received: by 2002:a17:90a:d2c6:b0:2ff:4f04:4266 with SMTP id
 98e67ed59e1d1-2ff7cef5c11mr28261612a91.23.1741825592977; Wed, 12 Mar 2025
 17:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr> <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora> <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
 <Z9GL6o01fuhTbHWO@fedora> <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
In-Reply-To: <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Mar 2025 08:26:21 +0800
X-Gm-Features: AQ5f1Jotgxkur0pCBX2T6-2ZHfB5Ly_E8Asn7gts-0i5WF5UC5k-dBCU_8yc-ak
Message-ID: <CACGkMEtHZB8bLMqepRxd3qvtXWA8g_5pofNBw1=XvxF4ANr6Cg@mail.gmail.com>
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, Harald Mommer <harald.mommer@opensynergy.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:36=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 12.03.2025 14:28:10, Matias Ezequiel Vara Larsen wrote:
> > On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> > > On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > > > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > > > Hello,
> > > > >
> > > > > I thought there would be some more comments coming and I could ad=
dress
> > > > > everything in one chunk. Not the case, besides your comments sile=
nce.
> > > > >
> > > > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > > >
> > > > > > Hi,
> > > > > > a few nits below, should there be a v6.
> > > > > >
> > > > >
> > > > > I'm sure there will be but not so soon. Probably after acceptance=
 of the
> > > > > virtio CAN specification or after change requests to the specific=
ation are
> > > > > received and the driver has to be adapted to an updated draft.
> > > > >
> > > > What is the status of this series?
> > >
> > > There has been no movement from the Linux side. The patch series is
> > > quite extensive. To get this mainline, we need not only a proper Linu=
x
> > > CAN driver, but also a proper VirtIO specification.
> >
> > Thanks for your answer. AFAIK the spec has been merged (see
> > https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4).
>
> Yes, the spec was merged. I think it was written with a specific
> use-case (IIRC: automotive, Linux on-top of a specific hypervisor) in
> mind, in Linux we have other use cases that might not be covered.
>
> > > This whole project is too big for me to do it as a collaborative
> > > effort.
> >
> > What do you mean?
>
> I mean the driver is too big to review on a non-paid community based
> effort.

If you can split the path into smaller ones, I'm happy to review.

Thanks


>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


