Return-Path: <netdev+bounces-189515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27930AB2769
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719251896431
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83498191F7F;
	Sun, 11 May 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R//1qAs+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9563433A0;
	Sun, 11 May 2025 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746954216; cv=none; b=NpT//JDAEKN6uTDP4hJUScIuuSucRCcxfqeIyOrigjKMTM8DiV7poOzzk6vthTaFjZK5mjRtvx4f9ksa+JjNQiy2XfBOdGW09FDSzQxWMw8tAif+H0r0FwVxAo2o2/s0vC/QndHrUCA3RInW2bp9c1gk7Riv6Fzxqn2bjZwEZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746954216; c=relaxed/simple;
	bh=+iwo2cPgXV9J7n3F5bXPF+0rZCkQS1SryJ0VjeO55YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6wUdQkllhC+/zp9798HFC9xhVP/lRY4uZ+2O2YZOFg8ZqXMw6PLKowkmfB8szGsJKzylc5Z3zK6VoB1sSYLXmEwnWUf0WEwtNSfpytAqhGqRy1xXBuK/npRQilmOca+LUI4ZCDGcNcA6kBdPdJftQTc/i5CT6e0hegvqO7Lh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R//1qAs+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so6542934a12.3;
        Sun, 11 May 2025 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746954213; x=1747559013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbFWRuX8tel2v5tQe7uNf7DvnTcb5ryFMr2htCDZBwA=;
        b=R//1qAs+ahF7PxxguC2SFGI+uJfrkXhtqzXO1vhOBhIBPZsmRAOiCboNw9T14+GNu4
         GxX/7ftFPMq0HsjVA4I5hD/CxgkXF+Lco4caU9phu1CsA8+alnaToTFDgkKeMPAUdYL7
         Y5KtZssOFzXLhmXxmwQ9l7qL3o/CIvRlJc02i+I5lF+HjlFAuXa4bjbC58GfXN0F/Tkf
         q4FlnUnmolWqvC6Y/d7B5pXfEgvchg69egE6glpNynjqG6RLU0KHqEC7Ws2eHrRHcAEx
         2SQEvvbJdaRTrq0EW2kOIYf6v00LK78xbyIUD8XOb8wYruOxTltJ68VtsoVj9WSqzAcw
         TKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746954213; x=1747559013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbFWRuX8tel2v5tQe7uNf7DvnTcb5ryFMr2htCDZBwA=;
        b=HcjKlIZh7zDd3zi9HHfiywECutTbE/NrihX1X9WQ5gLr+n4uPCxeCRFCu3YcKOFuc1
         AZBDmacSKA8NfygWN/glm1XxcYICciBEgWBUjtshwZihPCohuQe8wYWyojHrAx4KASnv
         9ImGgy8XRE5BjS33nmQGAwejbUseodZi0jxxTSk1WCH5F0f+9W5NhqPiXWkcRx8KwXKm
         F47cvXkPyApiy88CFKUesWthfM2rBc15xxLforWw3dcq1gpEtUbzEbrV4292IWALVNJX
         24i8Pj8AE+k/uyes5+WeGtnfnrrgGEBTzKLEwMla3aKo11jEvK1d62pap1b5osR1GwTm
         tHyA==
X-Forwarded-Encrypted: i=1; AJvYcCW4qVQwXDlrvQgDNMCF0Gz1iAVub+NDO6H3axJEy/Kac/zfHvDPxotm98QIUhLfnDkF2aC2CDkHExczkA4=@vger.kernel.org, AJvYcCXF/hHgRXYvAi6eW+gk1Y0CP6pUODgsFZEzL6Xf+ODB2m6exO7iHo4i2XmAF5ZMYVIbUThV40DQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyVqL1wDvIii3uryFFMTx8deHCM4lVoLteTPm5LraU9Ii54L6ES
	1SPjl5tih8syoDTm1ubwwj3GvBawMpjNj4sVHNP+QyfJfVmKpFq3lp4GBsvRzB796g1M98GKkbB
	5sjhP6GUgXiF7xplvRJ9K1VveXPA=
X-Gm-Gg: ASbGnctPnOTQ0k/kBUAXwtOE2R2jRfrZUrAr2BiQ0SV2bOtUhG9ZY7IaI60AAzje+sw
	Fu1PFFsFEdsVZ3tlK/CKTW+4PD6Cdlhrf7BY7UsaWUXQI1g/O3B6u9BWtKqYQKKgq3OrU3wVoD6
	UXw6LSRof5+nMosNCmFgcZdUUjDLhOQWY=
X-Google-Smtp-Source: AGHT+IH9M20OPMLG4pjKzhjF2OIhFNqH2DoTTtqo0qrSWEWxlbcpB258yEpa9IQ2BWNBT54nDhp7eMClyGPO/6stXhw=
X-Received: by 2002:a17:907:94cb:b0:ad2:47e7:3f39 with SMTP id
 a640c23a62f3a-ad247e741c2mr207640566b.54.1746954212694; Sun, 11 May 2025
 02:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508071901.135057-1-maimon.sagi@gmail.com>
 <20250509150157.6cdf620c@kernel.org> <CAMuE1bH-OB_gPY+fR+gVJSZG_+iPKSBQ5Bm02wevThH1VgSo3Q@mail.gmail.com>
In-Reply-To: <CAMuE1bH-OB_gPY+fR+gVJSZG_+iPKSBQ5Bm02wevThH1VgSo3Q@mail.gmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 11 May 2025 12:03:05 +0300
X-Gm-Features: AX0GCFuZtW-0lO60Nx2XArV621gaMLnzSTjwBygHChZFJLCryTcsNyvzjdOJz3s
Message-ID: <CAMuE1bESfcs92z-VowaQjgWG25UK6-fTzgDqFagOyK1yifH5Lg@mail.gmail.com>
Subject: Re: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store functions
To: Jakub Kicinski <kuba@kernel.org>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 11:16=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.com=
> wrote:
>
> On Sat, May 10, 2025 at 1:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu,  8 May 2025 10:19:01 +0300 Sagi Maimon wrote:
> > > The sysfs show/store operations could access uninitialized elements i=
n
> > > the freq_in[], signal_out[], and sma[] arrays, leading to NULL pointe=
r
> > > dereferences. This patch introduces u8 fields (nr_freq_in, nr_signal_=
out,
> > > nr_sma) to track the actual number of initialized elements, capping t=
he
> > > maximum at 4 for each array. The affected show/store functions are up=
dated to
> >
> > This line is too long. I think the recommended limit for commit message
> > is / was 72 or 74 chars.
> >
> will be fixed on next patch
> > > respect these limits, preventing out-of-bounds access and ensuring sa=
fe
> > > array handling.
> >
> > What do you mean by out-of-bounds access here. Is there any access with
> > index > 4 possible? Or just with index > 1 for Adva?
> >
> index > 4 is possible via the sysfs commands, so this fix is general
> for all boards
this is true for signals_nr and freq_in_nr arrays.
> > We need more precise information about the problem to decide if this is
> > a fix or an improvement
> >
> > > +     bp->sma_nr  =3D 4;
> >
> > nit: double space in all the sma_nr assignments
> >
> will be fixed on next patch
> > >
> > >       ptp_ocp_fb_set_version(bp);
> > >
> > > @@ -2862,6 +2870,9 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, stru=
ct ocp_resource *r)
> > >       bp->fw_version =3D ioread32(&bp->reg->version);
> > >       bp->fw_tag =3D 2;
> > >       bp->sma_op =3D &ocp_art_sma_op;
> > > +     bp->signals_nr =3D 4;
> > > +     bp->freq_in_nr =3D 4;
> > > +     bp->sma_nr  =3D 4;
> > >
> > >       /* Enable MAC serial port during initialisation */
> > >       iowrite32(1, &bp->board_config->mro50_serial_activate);
> > > @@ -2888,6 +2899,9 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, str=
uct ocp_resource *r)
> > >       bp->flash_start =3D 0xA00000;
> > >       bp->eeprom_map =3D fb_eeprom_map;
> > >       bp->sma_op =3D &ocp_adva_sma_op;
> > > +     bp->signals_nr =3D 2;
> > > +     bp->freq_in_nr =3D 2;
> > > +     bp->sma_nr  =3D 2;
> > >
> > >       version =3D ioread32(&bp->image->version);
> > >       /* if lower 16 bits are empty, this is the fw loader. */
> > > @@ -3002,6 +3016,9 @@ ptp_ocp_sma_show(struct ptp_ocp *bp, int sma_nr=
, char *buf,
> > >       const struct ocp_selector * const *tbl;
> > >       u32 val;
> > >
> > > +     if (sma_nr > bp->sma_nr)
> > > +             return 0;
> >
> > Why are you returning 0 and not an error?
> >
> will be fixed next patch
> > As a matter of fact why register the sysfs files for things which don't
> > exists?
> > --
> The number of SMAs initialized via sysfs is shared across all boards,
> necessitating a modification to this mechanism. Additionally, only the
> freq_in[] and signal_out[] arrays are causing NULL pointer
> dereferences. To address these issues, I will submit two separate
> patches: one to handle the NULL pointer dereferences in signals and
> freq_in, and another to refactor the SMA initialization process.
>
> > pw-bot: cr

