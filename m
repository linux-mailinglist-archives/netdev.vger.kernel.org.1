Return-Path: <netdev+bounces-183446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51628A90B46
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3691787EA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D0221F18;
	Wed, 16 Apr 2025 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aypdB+/2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B10221DAB
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828099; cv=none; b=XEENNFOV9HJKGND1MHCyKP0keHPPFTvTURLfqql3BMMSlDzSAPnd566R1eGxcenUpSayfqswq7iGrK2EWJ2WWQ3mcpy10F5x7+Ym/h+5ztCA9uM3BT227KZbZtvH9QBj+cTobWoDMUJ+CmUESYh10VAnlryItHQ0OdQBa1KDP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828099; c=relaxed/simple;
	bh=bUBb5mFoJb9G5BgJnxotUeKRdbd+vsxPnYgjdZX4OYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKzdBXDLB/ifo/ZJ6MDBzMlezx4V3O8oOhjuHrMmtPguKosD1t52clsCdq2TUEW1dxQz3EQUQ2uq7yNsshItm/Tq2NCmLM4qVZUELgbgkoiwQd5yW3gUKw3Iqo6TOD6dsZCCXlBww6+faJ8LBcAuJNpcjBjNyz5HOkzmUek72ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aypdB+/2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744828096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqpDy6pI/eQq6luBbGPAlrOSVzuf9WMRWlny/FPlhAY=;
	b=aypdB+/271X3TECmfscE4GK1bGr0NeWpXRAof9MGEKpoVaKhdV3nh2ywhOxNAqTcnuPvfR
	BiOjwYw1l7ZvjwCIDDOhLcKzeIL5281ZwM6a7M0Ebuuc9Cw0nQlUf4Z0gNcesTbxPZEggE
	I48zs2dw56U4WXBWmNSZOB2sXm3sDe0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-eoEH4gA2NoO5zzSlrtefXA-1; Wed, 16 Apr 2025 14:28:11 -0400
X-MC-Unique: eoEH4gA2NoO5zzSlrtefXA-1
X-Mimecast-MFC-AGG-ID: eoEH4gA2NoO5zzSlrtefXA_1744828090
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3db5469fbso633393766b.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 11:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744828090; x=1745432890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqpDy6pI/eQq6luBbGPAlrOSVzuf9WMRWlny/FPlhAY=;
        b=nB/NqTvR1cR1KGtS7vqRWWmKitWcBa92JdblWHHVRYL3nfktIx+8LAP0aTMJrWIhDa
         CJNcz5U8Rst3JRnVARBK52qu533rP4vCJQtQOwlMRb/7c7RGlFSGBiDt4NeRjSJnbXbm
         VRRKdb2EFwa8wl2n2uj1Bvh/R+abzYPAPlkiiMtzY+N7K1UHbrvEvlI9BqVP9bsd/8AL
         vp9ei4ERKgf4UHe7Ouah0VGCshT88Tz3QUhqHqeLQVQOeJqkUOij7KgLHXDH1rWESqyj
         K4dwbCvcGlMfOssNN7kztdigIxcVWlD5+t4cx/MnayqJALHoETkVwJmtLjp4u6zfEVq/
         3+mg==
X-Gm-Message-State: AOJu0YwdknQ9ool0LwNQcBzy8oPI3+cqTl9KfUfn8O5RxhKSfp5E+rwN
	J5Fi9uefUfVD4u2FWQ6ahoBbx/AVNN2/w31E9m5rPF7MN9Bo7p6lh4jvINKXzNqFRRfxTi/sG0L
	Rlf3cFn35lPqkgaGCJtVfURLPZrdocXUXcTJnwvy9EvRTzwCPKlg7Fc3NCZyWEtLiQhmnmMEiFj
	zRykRscw4RIGwNM/xtjTic50mQQOGy
X-Gm-Gg: ASbGncvWVJn+0DjALOsNrVNAJ/j55hKb/xyOM/6UpYQv9OWT8dCbbshWRw6hbp8BONg
	voHjy93kwl1uIYvUaSk3RWJKsS7HCmamRrDteNoMeWPC4K3VLlRUXA1DE8BGLahEvp2O+wip03T
	zaZUa0D+RhERqCxpnySKC088o=
X-Received: by 2002:a17:907:dab:b0:acb:35e6:eacf with SMTP id a640c23a62f3a-acb42870b74mr259874566b.4.1744828090402;
        Wed, 16 Apr 2025 11:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSoF42j4ymXh4k2DWlxZNaW5OkZRSSUqi4pxp1gEEVEvZ1VJluzXf3BKzOlO4E7zUkwC3XtYHE9JkFfyjbrOY=
X-Received: by 2002:a17:907:dab:b0:acb:35e6:eacf with SMTP id
 a640c23a62f3a-acb42870b74mr259872766b.4.1744828090052; Wed, 16 Apr 2025
 11:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416162144.670760-1-ivecera@redhat.com> <20250416162144.670760-6-ivecera@redhat.com>
 <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
In-Reply-To: <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
From: Ivan Vecera <ivecera@redhat.com>
Date: Wed, 16 Apr 2025 20:27:46 +0200
X-Gm-Features: ATxdqUE-ky5T4DA1oVeKdaFaD--po_j_TkYXO-lqG89DNt53ozs0tBAdouq5muw
Message-ID: <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:32=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/**
> > + * zl3073x_mb_dpll_read - read given DPLL configuration to mailbox
> > + * @zldev: pointer to device structure
> > + * @index: DPLL index
> > + *
> > + * Reads configuration of given DPLL into DPLL mailbox.
> > + *
> > + * Context: Process context. Expects zldev->regmap_lock to be held by =
caller.
> > + * Return: 0 on success, <0 on error
> > + */
> > +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index)
> > +{
> > +     int rc;
>
> lockdep_assert_held(zldev->regmap_lock) is stronger than having a
> comment. When talking about i2c and spi devices, it costs nothing, and
> catches bugs early.

Makes sense to put the assert here...

Will add.

>
> > +/*
> > + * Mailbox operations
> > + */
> > +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
>
> I assume these are the only valid ways to access a mailbox?
>
> If so:
>
> > +static inline __maybe_unused int
> > +zl3073x_mb_read_ref_mb_mask(struct zl3073x_dev *zldev, u16 *value)
> > +{
> > +     __be16 temp;
> > +     int rc;
> > +
> > +     lockdep_assert_held(&zldev->mailbox_lock);
> > +     rc =3D regmap_bulk_read(zldev->regmap, ZL_REG_REF_MB_MASK, &temp,
> > +                           sizeof(temp));
> > +     if (rc)
> > +             return rc;
> > +
> > +     *value =3D be16_to_cpu(temp);
> > +     return rc;
> > +}
>
> These helpers can be made local to the core. You can then drop the
> lockdep_assert_held() from here, since the only way to access them is
> via the API you defined above, and add the checks in those API
> functions.

This cannot be done this way... the above API just simplifies the
operation of read and write latch registers from/to mailbox.

Whole operation is described in the commit description.

E.g. read something about DPLL1
1. Call zl3073x_mb_dpll_read(..., 1)
   This selects DPLL1 in the DPLL mailbox and performs read operation
and waits for finish
2. Call zl3073x_mb_read_dpll_mode()
   This reads dpll_mode latch register

write:
1. Call zl3073x_mb_write_dpll_mode(...)
   This writes mode to dpll_mode latch register
2. Call zl3073x_mb_dpll_read(..., 1)
   This writes all info from latch registers to DPLL1

The point is that between step 1 and 2 nobody else cannot touch
latch_registers or mailbox select register and op semaphore.

Thanks,
Ivan


