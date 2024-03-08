Return-Path: <netdev+bounces-78754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA1876571
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316711C207BF
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F92381AB;
	Fri,  8 Mar 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl3LbHT/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FD23767
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904966; cv=none; b=bGV15oEGbXHJul2U/CPlfDjJuTTRk460jOEQyjxchKrym7GsSeuoijp7cuQIMCBuxTsIgayYUiMFpbNB2KF0sCshcxfPueTgx4vI/r6sXNpYz22uL6poqZvI+14yQP5FvrSQkNij9GjEmX4FXdSWR8PH9FPF3I7Ro9bz1g+9DJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904966; c=relaxed/simple;
	bh=ENbewuMF3h9UJH3Bt2uDyFiclQaVSEKnu5cTlqPPHds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSGLvHgpyOw2xe1erxFeFNBIzWxpiCI3g3i3xNys4AW/WqswmZ6eKfK98F2E2n7G8elfe12a9vNixeyAanEFe8JvBSHA4R25tg9etVX2A8Sb12oawI3IoigHNZz2MNnbBxe2M+ReFTrU4qrW9ljFb4ltH6xvYQK8iB1lcTclLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl3LbHT/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709904963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OVN+DUpohAJwpDuw4iW9LzvNFYeUKlYIl1TEylYcowI=;
	b=Bl3LbHT/8qgT5N1G4GNuL0cKteP38D/naSQJh/zndzU+fKy/S74UmKYMHUnubTTVa2TAET
	8/ioUvh5HJCcD4Ib8JhHpqgcyHGffbRTLDfdZSmE/CvhmrgIXo2WtAdwxmj1yRWSPtYbFn
	TyGVxAGj5XGTzaUvqmoR+c/lnOe0nKQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-VsECrhrUOo2KcE23w_iyug-1; Fri, 08 Mar 2024 08:36:02 -0500
X-MC-Unique: VsECrhrUOo2KcE23w_iyug-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5679dcc29c5so1043544a12.2
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 05:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709904961; x=1710509761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVN+DUpohAJwpDuw4iW9LzvNFYeUKlYIl1TEylYcowI=;
        b=gXNvbLMg7GLFIXI6ifUpQSGanLN52XM4/CCPkxqjG/1n/1Jpzstvd0Ctp9ivozmMJ9
         SN1zJQlNfBBnRo+5PBNjk3BWeC1XNs8++KgoUS3APVbsuOebbtYgpmTwY4/eupKuOAbd
         ITNQcG/Mxi/uXSW9s3ZkLxuTh70FZQu0j5cBzM1zzJe8foA3J9pDAYrcqnK/d7TcRPEP
         TRHvdKo07i6ptk9XayOrVEssT//kqh3d+fkEaIRo9XTczXiKEtJ57/ofcuPvyhKbozBa
         mmkkn8GH/CYFUGIVKwJKfC4VX/6X+gv13OxfOtrpkq0UW6aPIgtnS7qsJEZE5XGSG9bU
         ENIg==
X-Forwarded-Encrypted: i=1; AJvYcCXw7eQR0RcQ/ZIuyiMkktglax/vTYkanA3BNQ+mAaFau8dH+kJ+4c5GNOH+Ymbjh5MTks5bPdlxXoLcRS3GIU6TbahfBOu1
X-Gm-Message-State: AOJu0YxoCdSEq2ei+SqWdZng+W7JjZdpjqVse62bcSpndkW7KHRWit3e
	tH5FyWlj5GfJft2QbbNeBDf4jpFmxnSmCwifHLYfTama/avABOCVnkkB/0P5u3ffn/mcVPGZvMV
	rrsTkTPVm7OG/E/T3H3ELQTXL8Qs9V47DE9tBTbTKES0DAskUHMqmJV8FsymKmrseM093X9V9mx
	BY7aKYo47wjfCbcbgUO0EgZslpDafX
X-Received: by 2002:a50:955e:0:b0:567:1797:426f with SMTP id v30-20020a50955e000000b005671797426fmr2071682eda.24.1709904961365;
        Fri, 08 Mar 2024 05:36:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgSAyf1DSDhK474qE/kgu1rGJXm5N9O+6G16RkAUpT7163rTvhQT0SCt0k0ga0MGQNeEuG9fsShjcFKi7qt7s=
X-Received: by 2002:a50:955e:0:b0:567:1797:426f with SMTP id
 v30-20020a50955e000000b005671797426fmr2071664eda.24.1709904961000; Fri, 08
 Mar 2024 05:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307222510.53654-1-mschmidt@redhat.com> <20240307222510.53654-2-mschmidt@redhat.com>
 <0a13e22c-790e-4ac2-ad6c-eb350ef8c349@linux.intel.com>
In-Reply-To: <0a13e22c-790e-4ac2-ad6c-eb350ef8c349@linux.intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Fri, 8 Mar 2024 14:35:49 +0100
Message-ID: <CADEbmW1hG_et13ZSMcX8R-6FFjaEPUvnUveeg8_dEic0QqLS+Q@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/3] ice: add ice_adapter
 for shared data across PFs on the same NIC
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 11:57=E2=80=AFAM Marcin Szycik
<marcin.szycik@linux.intel.com> wrote:
> On 07.03.2024 23:25, Michal Schmidt wrote:
> > There is a need for synchronization between ice PFs on the same physica=
l
> > adapter.
> >
> > Add a "struct ice_adapter" for holding data shared between PFs of the
> > same multifunction PCI device. The struct is refcounted - each ice_pf
> > holds a reference to it.
> >
> > Its first use will be for PTP. I expect it will be useful also to
> > improve the ugliness that is ice_prot_id_tbl.
> >
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/Makefile      |   3 +-
> >  drivers/net/ethernet/intel/ice/ice.h         |   2 +
> >  drivers/net/ethernet/intel/ice/ice_adapter.c | 107 +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_adapter.h |  22 ++++
> >  drivers/net/ethernet/intel/ice/ice_main.c    |   8 ++
> >  5 files changed, 141 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
> >  create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
> >
> > diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethe=
rnet/intel/ice/Makefile
> > index cddd82d4ca0f..4fa09c321440 100644
> > --- a/drivers/net/ethernet/intel/ice/Makefile
> > +++ b/drivers/net/ethernet/intel/ice/Makefile
> > @@ -36,7 +36,8 @@ ice-y :=3D ice_main.o \
> >        ice_repr.o     \
> >        ice_tc_lib.o   \
> >        ice_fwlog.o    \
> > -      ice_debugfs.o
> > +      ice_debugfs.o  \
> > +      ice_adapter.o
> >  ice-$(CONFIG_PCI_IOV) +=3D     \
> >       ice_sriov.o             \
> >       ice_virtchnl.o          \
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/etherne=
t/intel/ice/ice.h
> > index 365c03d1c462..1ffecbdd361a 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -77,6 +77,7 @@
> >  #include "ice_gnss.h"
> >  #include "ice_irq.h"
> >  #include "ice_dpll.h"
> > +#include "ice_adapter.h"
> >
> >  #define ICE_BAR0             0
> >  #define ICE_REQ_DESC_MULTIPLE        32
> > @@ -544,6 +545,7 @@ struct ice_agg_node {
> >
> >  struct ice_pf {
> >       struct pci_dev *pdev;
> > +     struct ice_adapter *adapter;
> >
> >       struct devlink_region *nvm_region;
> >       struct devlink_region *sram_region;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net=
/ethernet/intel/ice/ice_adapter.c
> > new file mode 100644
> > index 000000000000..6b9eeba6edf7
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// SPDX-FileCopyrightText: Copyright Red Hat
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
> > +#include <linux/slab.h>
> > +#include <linux/xarray.h>
> > +#include "ice_adapter.h"
> > +
> > +static DEFINE_XARRAY(ice_adapters);
> > +
> > +static unsigned long ice_adapter_index(const struct pci_dev *pdev)
> > +{
> > +     unsigned int domain =3D pci_domain_nr(pdev->bus);
> > +
> > +     WARN_ON((unsigned long)domain >> (BITS_PER_LONG - 13));
> > +     return ((unsigned long)domain << 13) |
> > +            ((unsigned long)pdev->bus->number << 5) |
>
> Magic numbers?

5 bits for the slot number, 8 bits for the bus number. 5+18=3D13.
I did not find any existing definitions for this purpose in pci.h, but
I can add some local macros.

> > +            PCI_SLOT(pdev->devfn);
> > +}
> > +
> > +static struct ice_adapter *ice_adapter_new(void)
> > +{
> > +     struct ice_adapter *adapter;
> > +
> > +     adapter =3D kzalloc(sizeof(*adapter), GFP_KERNEL);
> > +     if (!adapter)
> > +             return NULL;
> > +
> > +     refcount_set(&adapter->refcount, 1);
> > +
> > +     return adapter;
> > +}
> > +
> > +static void ice_adapter_free(struct ice_adapter *adapter)
> > +{
> > +     kfree(adapter);
> > +}
> > +
> > +DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter=
_free(_T))
> > +
> > +/**
> > + * ice_adapter_get - Get a shared ice_adapter structure.
> > + * @pdev: Pointer to the pci_dev whose driver is getting the ice_adapt=
er.
> > + *
> > + * Gets a pointer to a shared ice_adapter structure. Physical function=
s (PFs)
> > + * of the same multi-function PCI device share one ice_adapter structu=
re.
> > + * The ice_adapter is reference-counted. The PF driver must use ice_ad=
apter_put
> > + * to release its reference.
> > + *
> > + * Context: Process, may sleep.
> > + * Return:  Pointer to ice_adapter on success.
> > + *          ERR_PTR() on error. -ENOMEM is the only possible error.
>
> What about ERR_PTR(xa_err(ret))?

The Xarray call can fail with -EINVAL or -ENOMEM. The -EINVAL would be
the result only if I'd attempt to insert an unaligned pointer, which
I'm not doing, so that leaves -ENOMEM as the only possible error.

> > + */
> > +struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
> > +{
> > +     struct ice_adapter *ret, __free(ice_adapter_free) *adapter =3D NU=
LL;
> > +     unsigned long index =3D ice_adapter_index(pdev);
> > +
> > +     adapter =3D ice_adapter_new();
> > +     if (!adapter)
> > +             return ERR_PTR(-ENOMEM);
>
> ---8<---
>
> Thanks,
> Marcin
>


