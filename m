Return-Path: <netdev+bounces-89900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8358AC217
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 01:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41821B20E76
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6F344369;
	Sun, 21 Apr 2024 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld/QF3yY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A83D0CD
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713741758; cv=none; b=BKuN+PiLFjc9LTQFdmG+WoecQwn8tfzrj6D/6OBPP7zluPttyNOoSpnZVjR8V2TgOoZjgjv4IfShav2Tm6gfbJA04jnpg1w4+95KKH6Eu+eGnjdAQKSvKymvqdxHifNd7IQTrzXZQ57R2ejM/SnuFjSPmTFlVhc6IlAMMBBr68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713741758; c=relaxed/simple;
	bh=Dm7YHHjbjRbmSShic9KMChCcR3Z/hnf5d5z1pa2lpGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNer/3VWij5s4TLFpjrR1A/7/jVqp+KmuDsoHRDjc+Ythxn/zw63zQBW//rIV4JRfdfsw27uzKF+RQpoDTSxKexDMDeCfsvYTPJPoSRCcZzt1TFFDQ9BdVRRV+xA9WM1KCt6cZMbcdkWabKdTHKuana+Yl/jnCcvqvb2N3IVLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld/QF3yY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so3464534f8f.1
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713741755; x=1714346555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DddNeHQ6cJo82rLir+VkXAvxBH2Wkut/xxX6pZ+DNpc=;
        b=ld/QF3yY3Y/tHCt8Xs1ZZ7CeMFaNMuWeu6n3BPFS9ylJiaU97JAvkuK8PJLXniyfNZ
         VPr3i0vap3tcDaIckibkgFNPE8ULXjKwlUzWse6wHtI85BHyPT6g8n3LJK7qPBKesii3
         OrI6hNJa7NFj+Ja1N7XA2Ery987BAqLMAdFnGu+UT3Vp37SMp5N8OqojPol7aVLnsFdZ
         w57KY2J4B/9tUQ1cqV7vWrXvoPkfaAZjBC4cxlZSDYHZ7SbxghK0HTx2jdD0ZLPnLLLT
         ZQkmSyaUEX0Ss71U6vbC531pH9vdtBnQ+5bAp81DgtgvYeCoi/gKrUSBbUcn2kdH91W9
         EFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713741755; x=1714346555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DddNeHQ6cJo82rLir+VkXAvxBH2Wkut/xxX6pZ+DNpc=;
        b=UviXLZYRGNicIuo9yKABMXLITtoLiFu09rFhxWzkOAEZzUHZtko8Zf9DXcrWIgOH76
         VBXIkC/qo6yM13nYEoXGcCWlYpvAExzhdjscBu9CbZLQmzoS4WqL+kkUTO9KOmypm5Z+
         k0rCwhl+jKBp7mAZJyrOPcaX1RwhUX5H07ddOuPijZepROtP9u+Y+LJcX3Ji3c2Y9Y3J
         hmiFG39jws6PiwPb3pvYmUarhQR5J+hZSTzgPhINSwXy0R0nDJuSDHJuK9sJ71Ft5AvF
         I3XcVcYtzT/oLdIbhqoHt04kgpQDc7GVL4c5LmcUftmPRSqd9SJXfX0sbddTGKV+Qzv2
         5klw==
X-Gm-Message-State: AOJu0YyKFWEyTY2HEQzPvmWhGq2+syz0UbXvMxEbjfJjxJ//89hXGe2w
	Y6Ulizrt2CTiliESuGzmLZzDOiwYKOu9+BvrMzsaMvu95SqY13WfxtUl+Epz7JxiFq4T19gKUdJ
	i6H2VoNql3Mpx8w+oy1ItBGb5i3Y=
X-Google-Smtp-Source: AGHT+IH89qphMd3C98ZhHPGv1wkGUAnGP1DdZBi8LhtjrqsDcNxg8d27TLoybQP5+22pqAJJrYEC3u3w41jbABqpIvc=
X-Received: by 2002:adf:e509:0:b0:34a:961:62cc with SMTP id
 j9-20020adfe509000000b0034a096162ccmr5300656wrm.44.1713741755158; Sun, 21 Apr
 2024 16:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217495098.1598374.12824051034972793514.stgit@ahduyck-xeon-server.home.arpa>
 <cb2519c4-0514-4237-94f8-6707263806a1@lunn.ch>
In-Reply-To: <cb2519c4-0514-4237-94f8-6707263806a1@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 21 Apr 2024 16:21:57 -0700
Message-ID: <CAKgT0UdaMtDtHevCX5cM+=4Z1krVCbQg56YJEiNX880H-+cxVg@mail.gmail.com>
Subject: Re: [net-next PATCH 11/15] eth: fbnic: Enable Ethernet link setup
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +#define FBNIC_CSR_START_PCS          0x10000 /* CSR section delimiter =
*/
> > +#define FBNIC_PCS_CONTROL1_0         0x10000         /* 0x40000 */
> > +#define FBNIC_PCS_CONTROL1_RESET             CSR_BIT(15)
> > +#define FBNIC_PCS_CONTROL1_LOOPBACK          CSR_BIT(14)
> > +#define FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS       CSR_BIT(13)
> > +#define FBNIC_PCS_CONTROL1_SPEED_ALWAYS              CSR_BIT(6)
>
> This appears to be PCS control register 1, define in 45.2.3.1. Since
> this is a standard register, please add it to mdio.h.

Actually all these bits are essentially there in the forms of:
MDIO_CTRL1_RESET, MDIO_PCS_CTRL1_LOOPBACK, and MDIO_CTRL1_SPEEDSELEXT.
I will base the driver on these values.

> > +#define FBNIC_PCS_VENDOR_VL_INTVL_0  0x10202         /* 0x40808 */
>
> Could you explain how these registers map to 802.3 clause 45? Would
> that be 3.1002? That would however put it in the reserved range 3.812
> through 3.1799. The vendor range is 3.32768 through 3.65535.

So from what I can tell the vendor specific registers are mapped into
the middle of the range starting at register 512 instead of starting
at 32768. So essentially offsets 512 - 612 and 1544 - 1639 appear to
be used for the vendor specific registers. In addition we have an
unused block of PCS registers that are unused from 1024 to 1536 as
they were there for an unsupported speed configuration.

> > +#define FBNIC_CSR_START_RSFEC                0x10800 /* CSR section de=
limiter */
> > +#define FBNIC_RSFEC_CONTROL(n)\
> > +                             (0x10800 + 8 * (n))     /* 0x42000 + 32*n=
 */
> > +#define FBNIC_RSFEC_CONTROL_AM16_COPY_DIS    CSR_BIT(3)
> > +#define FBNIC_RSFEC_CONTROL_KP_ENABLE                CSR_BIT(8)
> > +#define FBNIC_RSFEC_CONTROL_TC_PAD_ALTER     CSR_BIT(10)
> > +#define FBNIC_RSFEC_MAX_LANES                        4
> > +#define FBNIC_RSFEC_CCW_LO(n) \
> > +                             (0x10802 + 8 * (n))     /* 0x42008 + 32*n=
 */
> > +#define FBNIC_RSFEC_CCW_HI(n) \
> > +                             (0x10803 + 8 * (n))     /* 0x4200c + 32*n=
 */
>
> Is this Corrected Code Words Lower/Upper? 1.202 and 1.203?

Yes and no, this is 3.802 and 3.803 which I assume is more or less the
same thing but the PCS variant.

> > +#define FBNIC_RSFEC_NCCW_LO(n) \
> > +                             (0x10804 + 8 * (n))     /* 0x42010 + 32*n=
 */
> > +#define FBNIC_RSFEC_NCCW_HI(n) \
> > +                             (0x10805 + 8 * (n))     /* 0x42014 + 32*n=
 */
>
> Which suggests this is Uncorrected code Words? 1.204, 1.205? I guess
> the N is for Not?

These are 3.804 and 3.805.

From what I can tell the first 6 registers for the RSFEC are laid out
in the same order. However we have 4 of these blocks that we have to
work with and they are tightly packed such that the second block
starts at offset 8 following the start of the first block.

> > +#define FBNIC_RSFEC_SYMBLERR_LO(n) \
> > +                             (0x10880 + 8 * (n))     /* 0x42200 + 32*n=
 */
> > +#define FBNIC_RSFEC_SYMBLERR_HI(n) \
> > +                             (0x10881 + 8 * (n))     /* 0x42204 + 32*n=
 */
>
> And these are symbol count errors, 1.210 and 1.211?

I think this is 3.600 and 3.601.  However we only have 8 sets of
registers instead of 16.

> If there are other registers which follow 802.3 it would be good to
> add them to mdio.h, so others can share them.

I will try to see what I can do. I will try to sort out what is device
device specific such as our register layout versus what is shared such
as PCS register layouts and such.

Thanks,

- Alex

