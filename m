Return-Path: <netdev+bounces-189546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC97AB292B
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4955C17018E
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1871C25A344;
	Sun, 11 May 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1wLr7n6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AC18DB17;
	Sun, 11 May 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746974379; cv=none; b=oHyGPDfSHetitUaaQVKZT+6hAPFSBGDfRSEwiFiY4LYnF+bH65RVJgMNo/8vq9zcpCDr9Dq3z/uuxUuEXjzmI9OqC1yjGAfWP68FekTCt9tJfdJw/uWp+L2MwXuy5qcGeh2cPZqvzqQCiTQBy0LTTX1mf+LL5h2lkpDxtCWoq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746974379; c=relaxed/simple;
	bh=nREYfRkNxtqCY8dIKvYj9Jh5KaZKikw2GU45g1FpGQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCbenC3XBokBVTfFZtRz/pD0WlhpU72OZJJUpMuCGXjrfw6vUVsCgTbAFCg0Pn0OdtDpI/gWoGj/2aZD+KviRbkOI65sRl+T6vHLmd6l5An+dyAgbcS7rvWpK+WDc7ln/deoXyeibKX41PZ+y5G+jwoBc7hYiHYYXkrKu113Y8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1wLr7n6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acbb85ce788so613654666b.3;
        Sun, 11 May 2025 07:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746974375; x=1747579175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SW9lPAAE0aWJ1XdpLge8jdASEs+iW6MBQ78bn7L4jUQ=;
        b=I1wLr7n6RhvfqkPPovlZB+Nddd5sq0hwP++WccDgqCSC6BBRwmFiDQfftIpZRFoBCf
         /na94adwpmoP4x1D5HiCVdN0SnUYG5nW6RyJXdtPMyOeSMwOo1vDICxWwnGSnltwgUdZ
         V3C/IazqkhGa66t3zG7AQx/CWFlz8ytp4BpDPumu6kWboCQzlnYuG2hdj+yM74HVY9jq
         raTIr8yw3QZkgsgyfA1Dthb4VDnRsr1fCdlhSjQgv3XCrcTu7a16cHtLbPrugxTuHsPd
         mlIRVZk1NeEdB66Lds1VKJLoG9gB9ruzMqoFHvLeq1JrqzBfFyBsj0ctOSKLlm9uy1gQ
         ltmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746974375; x=1747579175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SW9lPAAE0aWJ1XdpLge8jdASEs+iW6MBQ78bn7L4jUQ=;
        b=IvIuMr5K/lWJJVdPXivV/h0BEG9rQJuz9p+SV/6hJVquc5VptSWouAFKYEcJettoPC
         ysKQPArDOCfY5oluV7b3/2ZCgjuNXSzzJFKdcPHmqPg0pwHlIopJwYJsoiwlQvI9Tm/Y
         lmSOQwXCiHuvKLKHNS9xcsqB2tctBQX6FxEcFzu6+k6OEblVbFTVTBEciLhky+bTVpMg
         QbpRaqZZUG6Oi8OCBEv2vylJBKVj5BuNA1AETWrT88a6kjZjfE/cx+BRZfeEZPq2E0TI
         OC5UyFOcXK35ek9HGFltqbQjnUvbcBtASVqGaMOwxzXBSQgWXAXM7iCHaa8hbcLQj4v4
         bMgA==
X-Forwarded-Encrypted: i=1; AJvYcCV76iLoM2tAupGNapGdjmrrGNQcKpOzylfsG61r1dG1yjGK+TvyJzgTDZf4KHhAi8XOhJufgbUNsv4WKVg=@vger.kernel.org, AJvYcCViY1mhDQJ3OXQ7ZptPAoNy6gg693QlOiYRLi69tKEOcBc7ythYpzBEepsSHGXrOoIMIzx643b3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dwVHLeMdemM+EzKv6Po5ESbHf1njyrfpOktcYEjGg+PfLlNT
	pXzu0B1mQgYRh61wB4ssL7J8zHzA1jg7TLsf5j5XLJWozTyj+iEaHzxuI2AuhwbSuTFVPD9GVio
	2iasO+Cb9QIayxzUzBWVXOr96TBs=
X-Gm-Gg: ASbGncuNk4fIspk5KAxiyKbyD4f6TNJY5NvYVTOgsaXjfa/lhIVu5YsDP8ZLUxSZcGj
	6GM705obtiy23avjnxGO900Mjts60dYFHOUHLaIQj78HNDKBPdLPox0d4BNvN5zh4lR8gzoWNk3
	C84N5LYUJ610mZseAsQ2FMXDwS5DXxj/o=
X-Google-Smtp-Source: AGHT+IFYNyvgAxBG3Acg9dXAO4GQZ3XGZxpJ7V5Zf6tJ1+NzpJsFY7JOcZqsfAKSniAzDvWWL61zOUYq/uEllgmmrmg=
X-Received: by 2002:a17:907:7da2:b0:abf:7453:1f1a with SMTP id
 a640c23a62f3a-ad219024691mr945003866b.36.1746974375118; Sun, 11 May 2025
 07:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508071901.135057-1-maimon.sagi@gmail.com>
 <20250509150157.6cdf620c@kernel.org> <CAMuE1bH-OB_gPY+fR+gVJSZG_+iPKSBQ5Bm02wevThH1VgSo3Q@mail.gmail.com>
 <CAMuE1bESfcs92z-VowaQjgWG25UK6-fTzgDqFagOyK1yifH5Lg@mail.gmail.com>
In-Reply-To: <CAMuE1bESfcs92z-VowaQjgWG25UK6-fTzgDqFagOyK1yifH5Lg@mail.gmail.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 11 May 2025 17:39:08 +0300
X-Gm-Features: AX0GCFtkrIJ_upTlXJEbOst2K0yfMZQokkgBTNnx_HvNT2FI0TO8PCOtikNFXEM
Message-ID: <CAMuE1bHL1-t_YD0B5v1LuY_b558U5qbseSYJXvnm734+Vb-v_w@mail.gmail.com>
Subject: Re: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store functions
To: Jakub Kicinski <kuba@kernel.org>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 12:03=E2=80=AFPM Sagi Maimon <maimon.sagi@gmail.com=
> wrote:
>
> On Sun, May 11, 2025 at 11:16=E2=80=AFAM Sagi Maimon <maimon.sagi@gmail.c=
om> wrote:
> >
> > On Sat, May 10, 2025 at 1:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu,  8 May 2025 10:19:01 +0300 Sagi Maimon wrote:
> > > > The sysfs show/store operations could access uninitialized elements=
 in
> > > > the freq_in[], signal_out[], and sma[] arrays, leading to NULL poin=
ter
> > > > dereferences. This patch introduces u8 fields (nr_freq_in, nr_signa=
l_out,
> > > > nr_sma) to track the actual number of initialized elements, capping=
 the
> > > > maximum at 4 for each array. The affected show/store functions are =
updated to
> > >
> > > This line is too long. I think the recommended limit for commit messa=
ge
> > > is / was 72 or 74 chars.
> > >
> > will be fixed on next patch
> > > > respect these limits, preventing out-of-bounds access and ensuring =
safe
> > > > array handling.
> > >
> > > What do you mean by out-of-bounds access here. Is there any access wi=
th
> > > index > 4 possible? Or just with index > 1 for Adva?
> > >
The sysfs interface restricts indices to a maximum of 4; however,
since an array of 4 signals/frequencies is always created and fully
accessible via sysfs=E2=80=94regardless of the actual number initialized=E2=
=80=94this
bug impacts any board that initializes fewer than 4
signals/frequencies.
> > > We need more precise information about the problem to decide if this =
is
> > > a fix or an improvement
> > >
> > > > +     bp->sma_nr  =3D 4;
> > >
> > > nit: double space in all the sma_nr assignments
> > >
> > will be fixed on next patch
> > > >
> > > >       ptp_ocp_fb_set_version(bp);
> > > >
> > > > @@ -2862,6 +2870,9 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, st=
ruct ocp_resource *r)
> > > >       bp->fw_version =3D ioread32(&bp->reg->version);
> > > >       bp->fw_tag =3D 2;
> > > >       bp->sma_op =3D &ocp_art_sma_op;
> > > > +     bp->signals_nr =3D 4;
> > > > +     bp->freq_in_nr =3D 4;
> > > > +     bp->sma_nr  =3D 4;
> > > >
> > > >       /* Enable MAC serial port during initialisation */
> > > >       iowrite32(1, &bp->board_config->mro50_serial_activate);
> > > > @@ -2888,6 +2899,9 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, s=
truct ocp_resource *r)
> > > >       bp->flash_start =3D 0xA00000;
> > > >       bp->eeprom_map =3D fb_eeprom_map;
> > > >       bp->sma_op =3D &ocp_adva_sma_op;
> > > > +     bp->signals_nr =3D 2;
> > > > +     bp->freq_in_nr =3D 2;
> > > > +     bp->sma_nr  =3D 2;
> > > >
> > > >       version =3D ioread32(&bp->image->version);
> > > >       /* if lower 16 bits are empty, this is the fw loader. */
> > > > @@ -3002,6 +3016,9 @@ ptp_ocp_sma_show(struct ptp_ocp *bp, int sma_=
nr, char *buf,
> > > >       const struct ocp_selector * const *tbl;
> > > >       u32 val;
> > > >
> > > > +     if (sma_nr > bp->sma_nr)
> > > > +             return 0;
> > >
> > > Why are you returning 0 and not an error?
> > >
> > will be fixed next patch
> > > As a matter of fact why register the sysfs files for things which don=
't
> > > exists?
> > > --
> > The number of SMAs initialized via sysfs is shared across all boards,
> > necessitating a modification to this mechanism. Additionally, only the
> > freq_in[] and signal_out[] arrays are causing NULL pointer
> > dereferences. To address these issues, I will submit two separate
> > patches: one to handle the NULL pointer dereferences in signals and
> > freq_in, and another to refactor the SMA initialization process.
> >
> > > pw-bot: cr

