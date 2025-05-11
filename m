Return-Path: <netdev+bounces-189513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F89AB2723
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAF9175D94
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 08:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372019ABB6;
	Sun, 11 May 2025 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIxXtLiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76113774D;
	Sun, 11 May 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746951427; cv=none; b=NFUqppVFmlZrlnaYLqqZKlcd4qVkZ4qPztABc4HNDBWG3cPaT8OPRIJag6HOvZbyb/grTtng35Z8EGAkfBvUk/aGlNSqv0EzZpeCScBoY+REqEpkUvOIJM8Pccb+T3hGvaqoUv1Mr6tl8zd+sXQZ/w9589VxpyeJ8/zmNTvwLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746951427; c=relaxed/simple;
	bh=o4DjkmcqH0CQCvpj+nku8qIxAhWg3czmlViskMBg67s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rfa5fsYtERPPQZhfr/wUX1FyZNqlJFbnlV+ZivxmNtQNURoU0W3KCcCZUw62hVL/5k8JN72juidJfO1FiHP8onk3GU6912fgXf5ZY+t5xHiyhsFdmPjfHOMF3TTfkI53gABYv34JBer2/tCGj4buaAKEfiV79HVjY3E+RUUDPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIxXtLiF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad238c68b35so214174966b.1;
        Sun, 11 May 2025 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746951424; x=1747556224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0yIeowaIbrdAkUcV+diXTwOIqrz0Jk3yzCANqW1Lvs=;
        b=SIxXtLiFBoHp6T77uaR1mPzRvzWBp3j9dv81vAV5GWI3vLZomZYfh+TF+HdXLK5nQJ
         SJ7EUHH26GwGa1I7Gyfd63g4gD1JeN4r3JEpnL1faIxqnghPchXL2vD9JZMtx7wUu08C
         CcTgBMym6L0ipx8//GbFjEIoenJHxqcCZOI0a+Bm8kivazwnydP715/tF9d50CzPbNm8
         Pw7T6rJaHwwaX+ES+lA+Oy/8PgR7Ilu3969wgbYFVDR5oHdtkdFqz9JY9pwcjFvWKoy3
         rRIMjem/R3jOhK27kjkX7GBdallsgmzAsYOQLMOYZJDdqktausZEREGiGRRSn06IpHn8
         ZLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746951424; x=1747556224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0yIeowaIbrdAkUcV+diXTwOIqrz0Jk3yzCANqW1Lvs=;
        b=ts/2fiq6PzuMLC50V31VfuKTZuOzDubetm9QJHtRW4HbNEMQT7S9xZ7F2CxgGg2VS/
         muS8mN1DSYRKfOguREQhVsZr4iVnHr0kqxxvBUEA/rPu25PYDCqiR4V/mRM/3A9y7b43
         XGwVXrZQDHSiU15OKmzJTDGcV0bNZIgbDxr9ar6N7QEH8wzPLz8ctmpkIdWNz47svWuD
         md2/O9v+amuuf4ma8u3khjNKw51LAvbdDG0X8uB0yLkzleO6lSMUkpXEnY3n9p6QBtwC
         SzS12RRiKmq8Jngw9jgA2SO0FjzvYSAyLD47QhyKdJLgakfwo55nXLPK9V/nTYQw7heu
         XLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwks18UqM75NhsneSA4YyXl1P1NIVvN7t9EviYbV4q8lFnVFnK5RDF8xJ87fGjtylCry+zbAT7@vger.kernel.org, AJvYcCWW9fB95OD56yPjOxH6CU/CAzxJBixlsmA4T2ucGtqQUkuzEHUSSFrrHgvlGruYUTlf0JT2mowC4uIOdMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/arCMOyFW2ow88oEhLSXjzf/et8G+QnwgPWR2EqI4ozlw6Tr0
	9Wq6LwrGCaRFMRnM+QXIzQLNJKZbK3mWOZRsH4gTV1PvdJx80su0Pw+PtRAzKgC/oMyDJxclL5W
	/YQ8sY6IfmqvZsFs48wywh2A7+5o=
X-Gm-Gg: ASbGnctMncdtfu8rG1NKUzUOajmV3x6MCVuFUkUz/3uKkhWe/7GPpP4SDcGke2IZFxe
	7Gsdi6Zo6+1yimqFfKQR+7tgAfNY4iKqaQwfnf7vC7QTwZNDHg9Qi6AcXMu4hhn0w/9bHK2KDtv
	2KkO4b7rxewgVwysFUeuYx4ylvTWqkI1I=
X-Google-Smtp-Source: AGHT+IGNxDzG67FJ0vVSkUAOEuJpzRmkUU7lbBEvEVleyQPtoMGTx4Pt/EtSNSsSdGdykLfTj8CVX7O59v3KvViXtWA=
X-Received: by 2002:a17:907:6a13:b0:ac7:81b0:62c8 with SMTP id
 a640c23a62f3a-ad218f8b0b6mr996987666b.31.1746951424016; Sun, 11 May 2025
 01:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508071901.135057-1-maimon.sagi@gmail.com> <20250509150157.6cdf620c@kernel.org>
In-Reply-To: <20250509150157.6cdf620c@kernel.org>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 11 May 2025 11:16:37 +0300
X-Gm-Features: AX0GCFu6rzTuh-ZOaCjTGrjQYgAUVP_Er2JeVxhmIZ9Ym3TQFDC0pXHsfCnIxBo
Message-ID: <CAMuE1bH-OB_gPY+fR+gVJSZG_+iPKSBQ5Bm02wevThH1VgSo3Q@mail.gmail.com>
Subject: Re: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store functions
To: Jakub Kicinski <kuba@kernel.org>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 1:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu,  8 May 2025 10:19:01 +0300 Sagi Maimon wrote:
> > The sysfs show/store operations could access uninitialized elements in
> > the freq_in[], signal_out[], and sma[] arrays, leading to NULL pointer
> > dereferences. This patch introduces u8 fields (nr_freq_in, nr_signal_ou=
t,
> > nr_sma) to track the actual number of initialized elements, capping the
> > maximum at 4 for each array. The affected show/store functions are upda=
ted to
>
> This line is too long. I think the recommended limit for commit message
> is / was 72 or 74 chars.
>
will be fixed on next patch
> > respect these limits, preventing out-of-bounds access and ensuring safe
> > array handling.
>
> What do you mean by out-of-bounds access here. Is there any access with
> index > 4 possible? Or just with index > 1 for Adva?
>
index > 4 is possible via the sysfs commands, so this fix is general
for all boards
> We need more precise information about the problem to decide if this is
> a fix or an improvement
>
> > +     bp->sma_nr  =3D 4;
>
> nit: double space in all the sma_nr assignments
>
will be fixed on next patch
> >
> >       ptp_ocp_fb_set_version(bp);
> >
> > @@ -2862,6 +2870,9 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct=
 ocp_resource *r)
> >       bp->fw_version =3D ioread32(&bp->reg->version);
> >       bp->fw_tag =3D 2;
> >       bp->sma_op =3D &ocp_art_sma_op;
> > +     bp->signals_nr =3D 4;
> > +     bp->freq_in_nr =3D 4;
> > +     bp->sma_nr  =3D 4;
> >
> >       /* Enable MAC serial port during initialisation */
> >       iowrite32(1, &bp->board_config->mro50_serial_activate);
> > @@ -2888,6 +2899,9 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struc=
t ocp_resource *r)
> >       bp->flash_start =3D 0xA00000;
> >       bp->eeprom_map =3D fb_eeprom_map;
> >       bp->sma_op =3D &ocp_adva_sma_op;
> > +     bp->signals_nr =3D 2;
> > +     bp->freq_in_nr =3D 2;
> > +     bp->sma_nr  =3D 2;
> >
> >       version =3D ioread32(&bp->image->version);
> >       /* if lower 16 bits are empty, this is the fw loader. */
> > @@ -3002,6 +3016,9 @@ ptp_ocp_sma_show(struct ptp_ocp *bp, int sma_nr, =
char *buf,
> >       const struct ocp_selector * const *tbl;
> >       u32 val;
> >
> > +     if (sma_nr > bp->sma_nr)
> > +             return 0;
>
> Why are you returning 0 and not an error?
>
will be fixed next patch
> As a matter of fact why register the sysfs files for things which don't
> exists?
> --
The number of SMAs initialized via sysfs is shared across all boards,
necessitating a modification to this mechanism. Additionally, only the
freq_in[] and signal_out[] arrays are causing NULL pointer
dereferences. To address these issues, I will submit two separate
patches: one to handle the NULL pointer dereferences in signals and
freq_in, and another to refactor the SMA initialization process.

> pw-bot: cr

