Return-Path: <netdev+bounces-235812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FD4C35DBA
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752C33B9826
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F566321F2A;
	Wed,  5 Nov 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJzNBrXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0F36B
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349606; cv=none; b=ngdchB1AahDEfwyUkwekNJvqswb5ygNil7KqyLsNeHrqCDabxMM+OtB9GNaU/S5Q72oGLLs9J8sA06xbeIgWedxO9cTPSzJ5Hgq3TBtd2v+U4PERxzlCZ3qRE/l70dU5qGsocJhK5nKMrAzufYXD9jXmAMay8Dl55KMl8OjzPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349606; c=relaxed/simple;
	bh=U1F3sTOuHUQFLv3TEGbA/DSFmdBXlQ3siYXEh6JECNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sc4iGqmj2dp5UsJrm2ehspULuk3VbJnNn5YxgqPh6VvHZ3kZW9Ju1szaR9Agt7dmepyyjFnau6XAShaiDaaT0D3yterp0diwnj3vWH/8IyzXJxo+zUvLD5swZtRMp4M4t6eJ/Mr9Q4218PDl7k6XKyY9ioV7ABqdP/qfWenArgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJzNBrXd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso593557f8f.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349602; x=1762954402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tfu97VMOCBozBOXYMMrX6xpt41aHtuKwXkexARt1yc=;
        b=FJzNBrXdG/9b4c+DV1ehf5Lpl4/qtktcHuerCW9ZeIFr3ZHBzkQKHwgmCAjPqaVh6s
         kH8Q6YupB3LKVtMaY9ytrggAUGJh2qNWuPAoCKCubXSMlb+qEHaGZPbK/KDGuQ18oDJG
         PNrMeSyfuDIdpHDTOl7UP7zS1CEiVxusCJ/4BUlSb3ho3e5Q5toOKJdCvSZdrUwZV6kJ
         EXIPWYKzwUP5wh4Lg7Ls6Q0VKU6OtJ2HaFO5jCGChDNT206fVUDxXxpKWaenqEsDMbA/
         bDf4pWwGHAX3QV/bXtzFpNz+BJs5whrwoTffw2gQayl6kAJ+abXzOwmldpVF1Ua+kooF
         6fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349602; x=1762954402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Tfu97VMOCBozBOXYMMrX6xpt41aHtuKwXkexARt1yc=;
        b=a2VtTmjIOTxSeCKpGKTJ7DkUQ6TcecEOlaglI3VC8HACA4sHgapKpdjtwcL5QFnErn
         H1H+TuaAuCk2ejlv42MqSOUJcW5AknbGMf9JthxgTfZ2yFdJ3EAVBsVxIbQ1aKp77ok0
         S3hvzv8wR/3LjskxntsViG0z0RWMZGZCCJ/5O8FDxxr0uuzsKn4SkrRLRrul2OgVk+fk
         TmKprvDWvfFvoDxjjTKQ2zvvb3eWRSpTb5HBRh6YtlZyUFitdxLnoU0fyGBsrx7nyQb+
         YV21BUL8/AA9fl5mEEXFd1r66hVXFCWnmcuT44LQ19Fw62vsTyTbaX4pFtVHGeaUn7t+
         on1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3tqSB0UtSVNPi9MaazLxSMi3s+BEPfQlpS+crH6/Mo/nX3vIdSzd3k6W13U/c193y+X7xEKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ/xcKe+uuQuLaJbJ65EK7A68TGkNErweQ4tiosnxuWCnR2mib
	54zDVQTl8Fo5iLrS8md3VmaeTmE/2yedlnvhuG30fWWlLoaz13KMuAvwch82yjSiNG/gX5HOfA7
	9LfBB+wAdJHTxdAtsfFAjiwQwoe24PLmA2roDgMY=
X-Gm-Gg: ASbGncvQ03P9gPbtOpb569VpkK/i9cd8uBL9YuZuHcGUMD9J7nQnf+h3ubbTvhLmJzV
	6FJ0dUYR4NYLYy5hvvQhgiDCBFqMrkUzWWkos1ETwCBvqRl0TBvkh/S9DD3of9d8wyyDTLIBt8c
	z5jvkCLL/8VqJ86Cq5WdzQp+SQIik2rObQcnFZR1rKxhF/80MGGEYv3ZYrOTG+WcFXVs3+iM3Cg
	zHxNCnQsK2+MMCOPj04tXymZu0/rlEy/kEwoTYJqCmjjYCavrfRf4AWn91v
X-Google-Smtp-Source: AGHT+IGvCIWq+0rMKhHvfniW+bwuHBHFAQHkMM11oGaxNLETqDrXu4Eu7COom09OEhCJJdAFILKAhozPdMoJet07vlc=
X-Received: by 2002:a05:6000:310d:b0:3e7:6424:1b47 with SMTP id
 ffacd0b85a97d-429e2d88922mr3412833f8f.6.1762349602259; Wed, 05 Nov 2025
 05:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210601005155.27997-1-kabel@kernel.org> <CA+V-a8tW9tWw=-fFHXSvYPeipd8+ADUuQj7DGuKP-xwDrdAbyQ@mail.gmail.com>
 <7d510f5f-959c-49b7-afca-c02009898ef2@lunn.ch> <CA+V-a8ve0eKmBWuxGgVd_8uzy0mkBm=qDq2U8V7DpXhvHTFFww@mail.gmail.com>
 <87875554-1747-4b0e-9805-aed1a4c69a82@lunn.ch> <CA+V-a8vv=5yRDD-fRMohTiJ=8j-1Nq-Q7iU16Opoe0PywFb6Zg@mail.gmail.com>
 <bd95b778-a062-47b1-a386-e4561ef0c8cd@lunn.ch> <CA+V-a8uB2WxU74mhkZ3SCpcty4T10Y3MOAf-SkodLCkp-_-AGA@mail.gmail.com>
In-Reply-To: <CA+V-a8uB2WxU74mhkZ3SCpcty4T10Y3MOAf-SkodLCkp-_-AGA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 5 Nov 2025 13:32:56 +0000
X-Gm-Features: AWmQ_bkvWW9Syr048xGuiGtl0UoycvbDjswru0s_sXAuWV-WFnJJ1Z_S-s_DosE
Message-ID: <CA+V-a8snRfFrZeuJ7QSt==B5vWAyTpHzdNj0Jx6oz_aaozbGYQ@mail.gmail.com>
Subject: Re: [PATCH leds v2 00/10] Add support for offloading netdev trigger
 to HW + example implementation for Turris Omnia
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	linux-leds@vger.kernel.org, netdev@vger.kernel.org, 
	Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Russell King <linux@armlinux.org.uk>, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Jacek Anaszewski <jacek.anaszewski@gmail.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Oct 17, 2025 at 4:23=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Andrew,
>
> On Thu, Oct 16, 2025 at 8:44=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > > I haven't explored the current leds code tbh. Can you please point me
> > > to any PHY which uses leds if any.
> >
> > ~/linux/drivers/net/phy$ grep .led_brightness_set *
> > air_en8811h.c:static int air_led_brightness_set(struct phy_device *phyd=
ev, u8 index,
> > air_en8811h.c:  .led_brightness_set     =3D air_led_brightness_set,
> > as21xxx.c:static int as21xxx_led_brightness_set(struct phy_device *phyd=
ev,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > as21xxx.c:              .led_brightness_set =3D as21xxx_led_brightness_=
set,
> > bcm-phy-lib.c:int bcm_phy_led_brightness_set(struct phy_device *phydev,
> > bcm-phy-lib.c:EXPORT_SYMBOL_GPL(bcm_phy_led_brightness_set);
> > bcm-phy-lib.h:int bcm_phy_led_brightness_set(struct phy_device *phydev,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > broadcom.c:     .led_brightness_set     =3D bcm_phy_led_brightness_set,
> > dp83867.c:dp83867_led_brightness_set(struct phy_device *phydev,
> > dp83867.c:              .led_brightness_set =3D dp83867_led_brightness_=
set,
> > dp83td510.c:static int dp83td510_led_brightness_set(struct phy_device *=
phydev, u8 index,
> > dp83td510.c:    .led_brightness_set =3D dp83td510_led_brightness_set,
> > intel-xway.c:static int xway_gphy_led_brightness_set(struct phy_device =
*phydev,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > intel-xway.c:           .led_brightness_set =3D xway_gphy_led_brightnes=
s_set,
> > marvell.c:static int m88e1318_led_brightness_set(struct phy_device *phy=
dev,
> > marvell.c:              .led_brightness_set =3D m88e1318_led_brightness=
_set,
> > marvell.c:              .led_brightness_set =3D m88e1318_led_brightness=
_set,
> > marvell.c:              .led_brightness_set =3D m88e1318_led_brightness=
_set,
> > marvell.c:              .led_brightness_set =3D m88e1318_led_brightness=
_set,
> > marvell.c:              .led_brightness_set =3D m88e1318_led_brightness=
_set,
> > mxl-86110.c:static int mxl86110_led_brightness_set(struct phy_device *p=
hydev,
> > mxl-86110.c:            .led_brightness_set     =3D mxl86110_led_bright=
ness_set,
> > mxl-86110.c:            .led_brightness_set     =3D mxl86110_led_bright=
ness_set,
> > mxl-gpy.c:static int gpy_led_brightness_set(struct phy_device *phydev,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> > mxl-gpy.c:              .led_brightness_set =3D gpy_led_brightness_set,
> >
Sorry for the delayed response.

I started investigating adding PHY leds. In page 53 section "4.2.27
LED Behavior" [0] we have an option for LED0/1 combine feature
disable. For this is it OK to add a new DT property?

[0] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductD=
ocuments/DataSheets/VMDS-10513_VSC8541-02_VSC8541-05_Datasheet.pdf

Cheers,
Prabhakar

