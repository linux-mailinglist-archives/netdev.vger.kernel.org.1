Return-Path: <netdev+bounces-185276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D69A9999D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DB04621A5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293E269AFA;
	Wed, 23 Apr 2025 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTdCQmA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677151C8639
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441223; cv=none; b=CFfXl/jcU40+EG3wUAvtvhZvDxa+KcJeCmV60kJKqZ/f69VQj1RxL7EqN6AoijevIybXO5QvNeNfR65htBijhdIdgmcYR5hmJVMY1EfClMX+l79LBoL4PTmWfWV175yeS5n8TnlwYUaGUMmgMvf5cL4b++04fwztPVOZi9oILxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441223; c=relaxed/simple;
	bh=snhV2XiNpG4U8XzST8X2IiBFztNuEg7ofnejtq0sGFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MttVntIkIzAZ5GgWDiC6KNChMMbOVxPbKq0nx9C8r6XSunVTB3Ks7hmr9wWiHv0e32kuBBoEZAuB0zarv4g0vJSL+dCgNdhpVcVlz4x/vHOkywNJRkMDhMHKk7zcoDuMFe9ZOCR2mzeeDX0D4Wmc5A0waKQazAKF7MpheQy5AD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTdCQmA6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe808908so17995e9.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745441219; x=1746046019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFkS/yyfa25uyiibdv8tLizNMHglHTEPA9b7aVCxr88=;
        b=QTdCQmA6gPv5PbQRZk8hIpPeRjR+gv7Vehhb125d+mrcOFBbYNW/NuP9Wp9dxvoFha
         ctw72j0tY0kKcCFwVKQifwYaksLGmg47KogCgClsk/1DfZxEnaLKRghFzgMsQc9oesAb
         2fnDm6JOu6gettKrb+JADv7EropPNYoX4mg6HFCPPdZ70Dz73edWHKKV12s7fPe9ss2C
         xahWfoc/mSuekrdLRQ45uZFkMFecGfo+EOQG8XdlLP1yRtZ3mRdd2MS2rInThXQm4NEU
         X+NoV1ajjYetfK63/9LDvlUAhdQgzrElD5uEW9tL2ajk+G2JooHEGSYBsOGuDWsXKXdE
         UIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441219; x=1746046019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFkS/yyfa25uyiibdv8tLizNMHglHTEPA9b7aVCxr88=;
        b=Lg36W0xYMojeustviG5AylHSkE3G+E4Y0JFRtw8zY2d5mejri5AwgWjnX/b3oJZIVT
         jGunndlOFs8fpOx8QM5wrMx4Xs5YXj055Sogjj56ZD+5tiAAsVJYnM1K8B67rlQ/6XwX
         QRxHhYEha6XBcspxaDXA0w0Wo9RN2dOIHmhRgEuSn6m4G3+qcTt64MsEiLrdt6GXp89L
         OHYSoHp3VlcBM2F5Ls3ZOpUGlQQvTcOlXs4gMNON4zQwjM6mnsfOeihyEBlxBf6lOAbW
         6Bp/RhVFTAROpAZrsvjMOt31mwJcA7NBTjhcgvtxY+V2RcxZnwyUViYSP2TgKQi09lCB
         +jfw==
X-Forwarded-Encrypted: i=1; AJvYcCWTEJBmw3kBh3dRf/1DiusuTZPrZXcoTYa1L+0DWJ5rI1EZWS/GBoNmIFFYTQ9SZGJBIeKbOUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZaWnOImxh4MvmFL42no1NCHDu6eWfNBXfBTzMJp0JEEEHQzVn
	J2zVEDg0E2AVFQwkoL1A5JTamEyA0avVKI/6Lx0OaEL6Cf0c9cmrxOjPJ12BSTIi+hAAYSdvr6S
	bJ2Jtjf6rIQSyB/FWQzzkjXgjHXs8tk2kTyTK
X-Gm-Gg: ASbGnctHgWe4ob6zwXYrzE1bGCe62fBUU9OjxNdevlSYzJlitvElKd96C0TqFoOEKoT
	8a1r1O1WYwP7RPD1ef5qAWCf1dtEsgDkEIRfiTx9z+vK24EDvmX0ycKXJcWIBg7+FbUMnq5xzKz
	dBTGvYUpPZ7/kTdMpcimCuZZu6zUYcHsj9iX4KbM9K8GSIutg/FG0W
X-Google-Smtp-Source: AGHT+IGEAejb+q0eYprUhrjih1DfSbXp5RpbqXJTJQJ5gPUdM0VLt77TTPHPCf9I9+WeRUkPGH/szPwHF5TaK/eZhZ0=
X-Received: by 2002:a05:600c:1c29:b0:43d:169e:4d75 with SMTP id
 5b1f17b1804b1-4409bca45afmr122455e9.1.1745441219476; Wed, 23 Apr 2025
 13:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418221254.112433-1-hramamurthy@google.com> <d3e40052-0d23-4f9e-87b1-4b71164cfa13@linux.dev>
In-Reply-To: <d3e40052-0d23-4f9e-87b1-4b71164cfa13@linux.dev>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Wed, 23 Apr 2025 13:46:47 -0700
X-Gm-Features: ATxdqUF7GLWp2UyqWvifI0Ek-kzWh0WRuL_TLzs86Rr0wZt9m6nYIFIt3D6I-pI
Message-ID: <CAG-FcCN-a_v33_d_+qLSqVy+heACB5JcXtiBXP63Q1DyZU+5vw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] gve: Add Rx HW timestamping support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	yyd@google.com, joshwash@google.com, shailend@google.com, linux@treblig.org, 
	thostet@google.com, jfraker@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 3:13=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 18/04/2025 23:12, Harshitha Ramamurthy wrote:
> > From: Ziwei Xiao <ziweixiao@google.com>
> >
> > This patch series add the support of Rx HW timestamping, which sends
> > adminq commands periodically to the device for clock synchronization wi=
th
> > the nic.
>
> It looks more like other PHC devices, but no PTP clock is exported. Do
> you plan to implement TX HW timestamps for this device later?
> Is it possible to use timecounter to provide proper PTP device on top of
> GVE?
Yes, the TX HW timestamps and PTP device work is undergoing. Those
would be sent out in separate patch series when they are ready.
>
> >
> > John Fraker (5):
> >    gve: Add device option for nic clock synchronization
> >    gve: Add adminq command to report nic timestamp.
> >    gve: Add rx hardware timestamp expansion
> >    gve: Add support for SIOC[GS]HWTSTAMP IOCTLs
> >    gve: Advertise support for rx hardware timestamping
> >
> > Kevin Yang (1):
> >    gve: Add initial gve_clock
> >
> >   drivers/net/ethernet/google/gve/Makefile      |   2 +-
> >   drivers/net/ethernet/google/gve/gve.h         |  14 +++
> >   drivers/net/ethernet/google/gve/gve_adminq.c  |  51 ++++++++-
> >   drivers/net/ethernet/google/gve/gve_adminq.h  |  26 +++++
> >   drivers/net/ethernet/google/gve/gve_clock.c   | 103 +++++++++++++++++=
+
> >   .../net/ethernet/google/gve/gve_desc_dqo.h    |   3 +-
> >   drivers/net/ethernet/google/gve/gve_ethtool.c |  23 +++-
> >   drivers/net/ethernet/google/gve/gve_main.c    |  47 ++++++++
> >   drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  26 +++++
> >   9 files changed, 290 insertions(+), 5 deletions(-)
> >   create mode 100644 drivers/net/ethernet/google/gve/gve_clock.c
> >
>

