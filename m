Return-Path: <netdev+bounces-90247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6335E8AD476
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4906B239AD
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7B1154BFF;
	Mon, 22 Apr 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsjLx4QE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F55219E0
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812357; cv=none; b=XLC2MDzjllNKx9CEFveAF0SiMOu381WwQfQDPKGkMYZT1dSuz+VR3pizFXkOn9XgqKWaeZDKeeG+uuA7qZ6aJMiaV2wj809Pa+IBYAq1QCbZdQU4QbJs5Cf1xvSJL3nHEqWSF2UDhz/7rv5lgcZs/vAe2flaU/1N+QmOl4QFHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812357; c=relaxed/simple;
	bh=w5mkKWDv+xPZkodqX0VVkauahsjn3UdgjIwXjdmVsJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lWco3erMTKSGnpQDd+FkbSwy0tXqmqP4MBJzczNyXSti39WMR3Wfu0a1aNPmBNAb756rdL7zYco2BegRbNXLrM6dUQR4daHXQVFuvLJEqStgAP03V0XiZyHnNrouxzfrm1Kf7YmCgDutazM8NO/rJItlwreKVMQexEf+cgj4uUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsjLx4QE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ac16b59fbeso3323355a91.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713812355; x=1714417155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F63EaTuOX+i9vnajnLo8miRPeFLvwd4PtJtjaPMpLv0=;
        b=EsjLx4QE1rZmutBmqpDMt6KAS3J8s/nW5f0rEo3Vil71Rv2o0CxDBbsJbMVzHpXaQv
         Y6d1iOKCOKIbzoamYfFyyHMvsGmDHdTcXhhZkkICC1jdH6gJSPU7DSOLgvaeUGzmEpua
         dAAe2uwF4J17PsuGtGpk0fdY72xekkM5QxkXeM5l9vT+ei91nGhSLeNS8M0J2JmDHXaF
         8dI5/R752x/t3LenRkvjDjRlCbUkUCZUYpkT0hqR+sOfgHwUdiCecANvCwTufDWyDlP7
         rOZIB5/8xGwVGCukAuozWIHIHflV2EJsGWO9qZVQWnCrXClEqVFJSrCtLK6iebFZDgB3
         7a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713812355; x=1714417155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F63EaTuOX+i9vnajnLo8miRPeFLvwd4PtJtjaPMpLv0=;
        b=u2hnn9oI/FWAT0cp6NyjSTPQC4XzvNgic9DuzK2hsRcNheIMTmQg/lzPk92q06Qw8t
         f/1OhcINV3/bvjykiY4F7mWFsDuIJlsRexRGY0ptUbR2OoZNpqhhodYgchG23NOJiVG/
         gRgGag6rATU4zsNRHwXAHTSK1LEjRswbpRdPUmre+m5Z9p7YKfu0EQYNSCo+nmnwENiO
         PY8IV7BaIGsYYGRgnC9O8HcpAlgZd44/+ZbPXEkb7kWUQ9DBEr9r6TjGxKHYcgsOHDVu
         17rZtTaJYh++URMbf/Z7IVNd5O2Y4ad5Vkoppu4jcUQ2Y3pDR8qBL5tpxEh+2aw3k277
         7LMQ==
X-Gm-Message-State: AOJu0YzhL2DyjRt6cGmcHOE8DDor5yeMihhXJSASysLbPkK6VnLLnnoL
	jNT8k6aFt54t3+FVG/u1HAnp/Z1pSxPcukAvntOcqsjoYiKY2lcRyN5lug==
X-Google-Smtp-Source: AGHT+IGpg8HUsKZckHhWTBRkEVMx10AUY5J5SxqcAG7TBujKmfyQsGNUqvwGALWYUOYMDswhvWEurQ==
X-Received: by 2002:a17:90a:fa8c:b0:2ac:513b:b314 with SMTP id cu12-20020a17090afa8c00b002ac513bb314mr8154755pjb.1.1713812355044;
        Mon, 22 Apr 2024 11:59:15 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d6-20020a17090ac24600b002ae0227cd2asm802265pjx.1.2024.04.22.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:59:14 -0700 (PDT)
Message-ID: <c3c155131582acf447ed0a370bf4e7701c76b425.camel@gmail.com>
Subject: Re: [net-next PATCH 11/15] eth: fbnic: Enable Ethernet link setup
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, 
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Date: Mon, 22 Apr 2024 11:59:13 -0700
In-Reply-To: <bffafcca-3b02-4f76-929b-fc5e30284c2b@lunn.ch>
References: 
	<171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	 <171217495098.1598374.12824051034972793514.stgit@ahduyck-xeon-server.home.arpa>
	 <cb2519c4-0514-4237-94f8-6707263806a1@lunn.ch>
	 <CAKgT0UdaMtDtHevCX5cM+=4Z1krVCbQg56YJEiNX880H-+cxVg@mail.gmail.com>
	 <bffafcca-3b02-4f76-929b-fc5e30284c2b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-22 at 17:52 +0200, Andrew Lunn wrote:
> On Sun, Apr 21, 2024 at 04:21:57PM -0700, Alexander Duyck wrote:
> > On Fri, Apr 5, 2024 at 2:51=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >=20
> > > > +#define FBNIC_CSR_START_PCS          0x10000 /* CSR section delimi=
ter */
> > > > +#define FBNIC_PCS_CONTROL1_0         0x10000         /* 0x40000 */
> > > > +#define FBNIC_PCS_CONTROL1_RESET             CSR_BIT(15)
> > > > +#define FBNIC_PCS_CONTROL1_LOOPBACK          CSR_BIT(14)
> > > > +#define FBNIC_PCS_CONTROL1_SPEED_SELECT_ALWAYS       CSR_BIT(13)
> > > > +#define FBNIC_PCS_CONTROL1_SPEED_ALWAYS              CSR_BIT(6)
> > >=20
> > > This appears to be PCS control register 1, define in 45.2.3.1. Since
> > > this is a standard register, please add it to mdio.h.
> >=20
> > Actually all these bits are essentially there in the forms of:
> > MDIO_CTRL1_RESET, MDIO_PCS_CTRL1_LOOPBACK, and MDIO_CTRL1_SPEEDSELEXT.
> > I will base the driver on these values.
>=20
> Great, thanks.
>=20
> > > > +#define FBNIC_PCS_VENDOR_VL_INTVL_0  0x10202         /* 0x40808 */
> > >=20
> > > Could you explain how these registers map to 802.3 clause 45? Would
> > > that be 3.1002? That would however put it in the reserved range 3.812
> > > through 3.1799. The vendor range is 3.32768 through 3.65535.
> >=20
> > So from what I can tell the vendor specific registers are mapped into
> > the middle of the range starting at register 512 instead of starting
> > at 32768.
>=20
> 802.3, clause 1.4.512:
>=20
>   reserved: A key word indicating an object (bit, register, connector
>   pin, encoding, interface signal, enumeration, etc.) to be defined
>   only by this standard. A reserved object shall not be used for any
>   user- defined purpose such as a user- or device-specific function;
>   and such use of a reserved object shall render the implementation
>   noncompliant with this standard.
>=20
> It is surprising how many vendors like to make their devices
> noncompliant by not following simple things like this. Anyway, nothing
> you can do. Please put _VEND_ in the #define names to make it clear
> these are vendor registers, even if they are not in the vendor space.

Yeah, I am not sure how much of this is the synthesis of the IP versus
the mapping functionality of our device in terms of how the registers
got ordered. I'm thinking if nothing else there may be a need to break
this up into logical "pages".

From what I can tell the layout is something like:
CSR Range	Register Block
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0 -  511	PCS Channel 0 (within spec)
 512 - 1023	PCS Channel 0 Vendor Registers
1024 - 1535	PCS Channel 1 (within spec)
1536 - 2043	PCS Channel 1 Vendor Registers

I said we weren't using channel 1 registers but after looking back
through the code and starting re-factoring I believe I was thinking of
channels 2 and 3 which would be used for 100-R4. Basically channel 1 is
used in the 50-R2 and 100-R2 use cases.

As far as the vendor registers themselves most of this block of
registers is all about the virtual lane alignment markers. As such I
may want to export the values to a shared header file since they should
be common as per the spec, but the means of programming them would be
vendor specific.

> > > > +#define FBNIC_CSR_START_RSFEC                0x10800 /* CSR sectio=
n delimiter */
> > > > +#define FBNIC_RSFEC_CONTROL(n)\
> > > > +                             (0x10800 + 8 * (n))     /* 0x42000 + =
32*n */
> > > > +#define FBNIC_RSFEC_CONTROL_AM16_COPY_DIS    CSR_BIT(3)
> > > > +#define FBNIC_RSFEC_CONTROL_KP_ENABLE                CSR_BIT(8)
> > > > +#define FBNIC_RSFEC_CONTROL_TC_PAD_ALTER     CSR_BIT(10)
> > > > +#define FBNIC_RSFEC_MAX_LANES                        4
> > > > +#define FBNIC_RSFEC_CCW_LO(n) \
> > > > +                             (0x10802 + 8 * (n))     /* 0x42008 + =
32*n */
> > > > +#define FBNIC_RSFEC_CCW_HI(n) \
> > > > +                             (0x10803 + 8 * (n))     /* 0x4200c + =
32*n */
> > >=20
> > > Is this Corrected Code Words Lower/Upper? 1.202 and 1.203?
> >=20
> > Yes and no, this is 3.802 and 3.803 which I assume is more or less the
> > same thing but the PCS variant.
>=20
> Have you figure out how to map the 802.3 register number to the value
> you need here? 0x42008 + 32*n? Ideally we should list the registers in
> the common header file with there 802.3 defined value. Your driver can
> them massage the value to what you need for your memory mapped device.

Similarly for the RSFEC portion things seem to have been broken out
into 4 blocks w/ multiple sets of registers. The first 6 are laid out
in the same order as the spec, but they are starting at an offset of
(2048 + 8 * (n)) instead of 800. So I suppose the big question would be
how to convert the standard addressing scheme into something that would
get us to the right page for the right interface.

> If you really want to go the whole hog, you might be able to extend
> mdio-regmap.c to support memory mapped C45 registers, so your driver
> can then use mdiodev_c45_read()/mdiodev_c45_write(). We have a few PCS
> drivers for licensed IP which appear on both MDIO busses and memory
> mapped. mdio-regmap.c hides way the access details.

The big issue as I see it is the fact that we have multiple copies of
things that are interleaved together. So for example with the RSFEC we
have 4 blocks of 8 registers that are all interleaved with the first 6
matching the layout, but the last 2 being something different.

Since I am not accessing these via MDIO I am not sure what the expected
layout should be in terms of deciding what should be a device, channel,
or register address and how that would map to a page.

