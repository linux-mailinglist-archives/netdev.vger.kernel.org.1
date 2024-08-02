Return-Path: <netdev+bounces-115431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB77E9465CD
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179FD1C20DD6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB7127E0D;
	Fri,  2 Aug 2024 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A30We7jC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124178C88
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722636378; cv=none; b=K7J9uo1s8UT/Lz2h3N7sVlEMJ7vZ7STiqz/KF2R1gakMOIL9O+G+6GU+5hMMb6w0pIB/e95OqeyM+zZXz6GadtkRrn7rlkj3uxPt9Q62ifLzJACzvh6DNlgoapCTN23XPZ0fVAFuz701xMBOuFsOTO0CCgC+h/8pXLOL2TlpGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722636378; c=relaxed/simple;
	bh=lx+h9xI5XEa309zSN2+bXWq0jQSNaGN7lU99Nzh+AE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeMngN+C1L906j/3Qn7yPXGFPaI+alLI+cezSPYdXYwGry5PL/FDiq5v6yh1OAiyYcaIDSzUwgXem5l81CkhZYrtXJ2DCzwnKwNobn4dVz/Vwg5Z/2nnj5i1zc8H6e8C9w4kqzLVSlWPu+yOwYBssnx+a3wxKA6+2+6QNOTaUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A30We7jC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so3838828a12.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722636377; x=1723241177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIf2Z8xfUOppJ4QPCEEzWDe13OvSm96VdoVeFbEEidI=;
        b=A30We7jCbGpUEHxIWA0rTAfunxhpgP03/Lk1O5U0D18MJKFOLx1CIimwQJjAMAmxE+
         6c2vAvinKZ1esfbEyTMVmMxNky5KnWk/cFJwAZy2978AGcyhbXvEGjIxxRY+633HK8ld
         0L1SJFPUbfFLt8TsjXtuTBELEGWNQe+7EDJes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722636377; x=1723241177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIf2Z8xfUOppJ4QPCEEzWDe13OvSm96VdoVeFbEEidI=;
        b=KARzIhvEuIKYk0MLUAUA0bM8C/jDmlW9i/1EmCARgx71z/V8GBYDQJeHjC98QY4tkd
         c7ddLFAkf6E7YxQM2ZgISa6Dc8y2WqRqgncBAaEQMdv/sghaI4hrVegjkYp3Uei8oFMB
         rA/IysaISD84emdKQyT/MtZGdlTTBe3XZqcWL0LLh3736GF34o5CPmZhcaF74+trMb35
         Wi92XclwMTYVxoyzCEVLvkgxnUHjnqeoBm/PdGZ5Glt/kuPD5gHh6u/l4a1vgAchfmg4
         +nrjzhXZNgd4/Zs0YqXWjb5hOUFnbx/ZoljS2dKSkiv6pmgkPaLsNl3SyMSSVRJdCIOy
         w4wQ==
X-Gm-Message-State: AOJu0Yy6W/ofOtpemPmDjzvIggSXwDo3vfT1FklEFWLlOeMPFZ7LqSfk
	CwV0hdGZ/WnO9sML0CDyEJ0JKO15kIiiCUNeXfSfW9es1T1imN6sQetMKfjDlBefyDuNxD7ZSjv
	T236GutGiVKpOnS6omW/Kh8Lg9W5C01ZJPQlr
X-Google-Smtp-Source: AGHT+IGxtg3mlYSN2rnmmdH11LPx0I3q2XmRLrpKXRUZmiSUOVEth982q9X6S4T/IQAjtrfS3F02EOw6tsjhv/XAj2A=
X-Received: by 2002:a05:6a20:3d81:b0:1c4:7d53:bf76 with SMTP id
 adf61e73a8af0-1c699624320mr7126559637.38.1722636376546; Fri, 02 Aug 2024
 15:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com> <oul3ymxlfwlqc3wikwyfix5e2c7hozwfsdwswkdtayxd2zzphz@mld3uobyw5pv>
In-Reply-To: <oul3ymxlfwlqc3wikwyfix5e2c7hozwfsdwswkdtayxd2zzphz@mld3uobyw5pv>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 2 Aug 2024 15:06:05 -0700
Message-ID: <CAMdnO-JKfi0hqaR5zrzzv6j-c6OhH-LTZT5WWBCFDOG_+ZxTeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: Add PCI driver support for BCM8958x
To: Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 3:02=E2=80=AFAM Serge Semin <fancer.lancer@gmail.com=
> wrote:
>
> Hi Jitendra
>
> On Thu, Aug 01, 2024 at 08:18:19PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > This patchset adds basic PCI ethernet device driver support for Broadco=
m
> > BCM8958x Automotive Ethernet switch SoC devices.
> >
> > This SoC device has PCIe ethernet MAC attached to an integrated etherne=
t
> > switch using XGMII interface. The PCIe ethernet controller is presented=
 to
> > the Linux host as PCI network device.
> >
> > The following block diagram gives an overview of the application.
> >              +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> >              |       Host CPU/Linux            |
> >              +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> >                         || PCIe
> >                         ||
> >         +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> >         |           +--------------+               |
> >         |           | PCIE Endpoint|               |
> >         |           | Ethernet     |               |
> >         |           | Controller   |               |
> >         |           |   DMA        |               |
> >         |           +--------------+               |
> >         |           |   MAC        |   BCM8958X    |
> >         |           +--------------+   SoC         |
> >         |               || XGMII                   |
> >         |               ||                         |
> >         |           +--------------+               |
> >         |           | Ethernet     |               |
> >         |           | switch       |               |
> >         |           +--------------+               |
> >         |             || || || ||                  |
> >         +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> >                       || || || || More external interfaces
> >
> > The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
> > driver uses common dwxgmac2 code where applicable.
>
> Thanks for submitting the series.
>
> I am curious how come Broadcom got to use an IP-core which hasn't
> been even announced by Synopsys. AFAICS the most modern DW XGMAC
> IP-core is of v3.xxa version:
>
> https://www.synopsys.com/dw/ipdir.php?ds=3Ddwc_ether_xgmac
>
I am not sure why the 4.00a IP-code is not announced for general
availability yet.
The Synopsis documentation for this IP mentions 3.xx IP as reference
for this design and lists
new features for 4.00a.

> Are you sure that your device isn't equipped with some another DW MAC
> IP-core, like DW 25G Ethernet MAC? (which BTW is equipped with a new
> Hyper DMA engine with a capability to have up to 128/256 channels with
> likely indirect addressing.) Do I miss something?
>
Yes, I briefly mentioned the new DMA architecture in the commit log
for patch 1/3.
You are correct, the name for the new DMA engine is Hyper DMA. It
probably started with some 3.xx IP-Core.
This DW-MAC is capable of 25G, but this SOC is not using 25G support.

> * I'll join the patch set review after the weekend, sometime on the
> next week.
>
> -Serge(y)
>
> > Driver functionality specific to this MAC is implemented in dwxgmac4.c.
> > Management of integrated ethernet switch on this SoC is not handled by
> > the PCIe interface.
> > This SoC device has PCIe ethernet MAC directly attached to an integrate=
d
> > ethernet switch using XGMII interface.
> >
> > v2->v3:
> >    Addressed v2 comments from Andrew, Jakub, Russel and Simon.
> >    Based on suggestion by Russel and Andrew, added software node to cre=
ate
> >    phylink in fixed-link mode.
> >    Moved dwxgmac4 specific functions to new files dwxgmac4.c and dwxgma=
c4.h
> >    in stmmac core module.
> >    Reorganized the code to use the existing glue logic support for xgma=
c in
> >    hwif.c and override ops functions for dwxgmac4 specific functions.
> >    The patch is split into three parts.
> >      Patch#1 Adds dma_ops for dwxgmac4 in stmmac core
> >      Patch#2 Hooks in the hardware interface handling for dwxgmac4
> >      Patch#3 Adds PCI driver for BCM8958x device
> >
> > v1->v2:
> >    Minor fixes to address coding style issues.
> >    Sent v2 too soon by mistake, without waiting for review comments.
> >    Received feedback on this version.
> >    https://lore.kernel.org/netdev/20240511015924.41457-1-jitendra.vegir=
aju@broadcom.com/
> >
> > v1:
> >    https://lore.kernel.org/netdev/20240510000331.154486-1-jitendra.vegi=
raju@broadcom.com/
> >
> > Jitendra Vegiraju (3):
> >   Add basic dwxgmac4 support to stmmac core
> >   Integrate dwxgmac4 into stmmac hwif handling
> >   Add PCI driver support for BCM8958x
> >
> >  MAINTAINERS                                   |   8 +
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
> >  drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
> >  .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 517 ++++++++++++++++++
> >  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++
> >  .../net/ethernet/stmicro/stmmac/dwxgmac4.c    | 142 +++++
> >  .../net/ethernet/stmicro/stmmac/dwxgmac4.h    |  84 +++
> >  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  26 +-
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
> >  10 files changed, 825 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h
> >
> > --
> > 2.34.1
> >
> >

