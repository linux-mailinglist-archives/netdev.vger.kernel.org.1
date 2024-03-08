Return-Path: <netdev+bounces-78761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16D876624
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD801B2283D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90240840;
	Fri,  8 Mar 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgoEtwqL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E54381C1
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907513; cv=none; b=qtkEGcBIp4uxYrcGFejWg/GjfNuyS/bP9j7F3qGnwpJqeHS0D30zrVT46wdrgIiHCclWaQZiBGGuJxrGXBP6Zcglu3QRDnhiGh+EqDec5NLGqVOnOvgs+jhCliTeF1VRcjeTDDo2jwN2Y5gdRPVspyZhRFRyU2L17a3+2dYRtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907513; c=relaxed/simple;
	bh=oDAgEoylb57IzHi8Tw0QqiIcPK0dWZ4RPwW+w9xWoiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibKwizTerJ1eFCGmmi9CFr5au31Rd8ryuC5AlpP70YWs0yykIghDo/8cGEZ3nYYLKPcSWt2lYou9KACkH8vzzDXUX3FrpgcmuI3wrovISXOW7OY/r6WLJlSc7YfwP/EU5wzcB8geKModzQ4cuTjuaeljnBJ+1eTPidyYa7Fh1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgoEtwqL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709907510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw3mWHahveAGVm+pK1DUDmIOCxbBK1Ng2FsD+Kgwpi0=;
	b=RgoEtwqLqoCAGcs5yiCNhHgCdgkP4AUudBJZoNq1jACFsLRs1Rr6RagCRmGZXXJkqRMwR3
	kYgcoi/XNxexqAZ/xxHO9P4RbPt4D03UqohzlOXxmkUt+r0PGjETdVw441tnLxS0HlADmu
	amX0iD1i5L5OaMcGJKX9AWBcj7QVdOM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-YQpMm6UpMIiabQVKNQT-Vg-1; Fri, 08 Mar 2024 09:18:29 -0500
X-MC-Unique: YQpMm6UpMIiabQVKNQT-Vg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-568196fe2c1so1073684a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 06:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907508; x=1710512308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw3mWHahveAGVm+pK1DUDmIOCxbBK1Ng2FsD+Kgwpi0=;
        b=cNfLuN6N4kZp88h52Vcb4A0FZlgUiF65TWgCo0asnwasesrQWdF+fqfmZ+WVIWWGGQ
         7L9VfrRhWQ9TdjtHc6wjWAlSVxir6PVr9v25fhxz6aIwB+38Zsgk1931C0vOjRSG1EFe
         aQuKPDMkKnXtiEekDTtwzf5qTFr8E7/35MmDnxJ722y5uKS/KdSEugJudsJv6Bn5BHOG
         mXgZS4N4Gc00X52c0bEGGN3jpgPzFA/6XMxsK5Qr+sJrw2vV+h0FpgbeYUA3+cORPB3M
         WyfihcVHQHL917SR00gD8a3C/krUmnEiUS1az24a1+0zZawr3Ee47hfAlFYQLzBOZZxZ
         dkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5zWkoQkCTUYg1Y2J6SqQGS/p16xF+1ErRhN9tVIUaSIx1XHSmoaLgsdQvMRHksjQ+G6yk5bYxdpUPkd8uFK3r+Bcn/rn/
X-Gm-Message-State: AOJu0YwXhadty9XlcAlWbo1Dxlh6K+q1YazRAdeA5MruwPfpj154L4zv
	xnJuuJy8rVDGX/PvNlCDaeHniWJvfLlzaPyNK/nm3O1Bv0yoGBba28Z+m5naBWenw297MCkj68b
	EGds5YI+CgfMb8UUQ11nRIRR9ozZK3jUMo5HHFSceeg+1W2hXK0N+NzrxJFfExwHvekT6btGMST
	FaQmQfLvHVTQVmSf3+ZsEEuD4PZWc5
X-Received: by 2002:a50:cd45:0:b0:566:9fef:1ee9 with SMTP id d5-20020a50cd45000000b005669fef1ee9mr2365150edj.22.1709907508002;
        Fri, 08 Mar 2024 06:18:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXkDDbbTKP5fbtwbqdREHaj7YoHnaMdzZLoij5YG6WeNYkV7j9a1ZrE/FZQ5IXn2lsjYhU/tEvwLZG3anPDPk=
X-Received: by 2002:a50:cd45:0:b0:566:9fef:1ee9 with SMTP id
 d5-20020a50cd45000000b005669fef1ee9mr2365130edj.22.1709907507551; Fri, 08 Mar
 2024 06:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307222510.53654-1-mschmidt@redhat.com> <20240307222510.53654-2-mschmidt@redhat.com>
 <c15b5a98-ce71-4ffb-a641-83f586b9970a@intel.com>
In-Reply-To: <c15b5a98-ce71-4ffb-a641-83f586b9970a@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Fri, 8 Mar 2024 15:18:16 +0100
Message-ID: <CADEbmW1YeugjaPOUKyVLw+vDh6ahK+XTJjY7RF9qN2r=B8XoMg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/3] ice: add ice_adapter
 for shared data across PFs on the same NIC
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 1:17=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> On 3/7/24 23:25, Michal Schmidt wrote:
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
>
> Thank you very much for this series, we have spotted the need for
> something like that very recently, I have already pinged our PTP folks
> to take a look. (+CC Sergey)
>
> Why not wipe ice_ptp_lock() entirely?
> (could be left for Intel folks though)

I am doing this too, just not yet in this series I posted, because I
did not want to expand the scope of the series between reviews. See my
gitlab branch I linked in the cover letter, specifically this patch:
https://gitlab.com/mschmidt2/linux/-/commit/89a1bd2904ac8b0614bcfc2fce464bf=
5f60b0f0c

> please find the usual code related feedback inline
> (again, I really appreciate and I am grateful for this series)
>
> > ---
> >   drivers/net/ethernet/intel/ice/Makefile      |   3 +-
> >   drivers/net/ethernet/intel/ice/ice.h         |   2 +
> >   drivers/net/ethernet/intel/ice/ice_adapter.c | 107 ++++++++++++++++++=
+
> >   drivers/net/ethernet/intel/ice/ice_adapter.h |  22 ++++
> >   drivers/net/ethernet/intel/ice/ice_main.c    |   8 ++
> >   5 files changed, 141 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
> >   create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
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
> >   ice-$(CONFIG_PCI_IOV) +=3D    \
> >       ice_sriov.o             \
> >       ice_virtchnl.o          \
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/etherne=
t/intel/ice/ice.h
> > index 365c03d1c462..1ffecbdd361a 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -77,6 +77,7 @@
> >   #include "ice_gnss.h"
> >   #include "ice_irq.h"
> >   #include "ice_dpll.h"
> > +#include "ice_adapter.h"
> >
> >   #define ICE_BAR0            0
> >   #define ICE_REQ_DESC_MULTIPLE       32
> > @@ -544,6 +545,7 @@ struct ice_agg_node {
> >
> >   struct ice_pf {
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
> > +            PCI_SLOT(pdev->devfn);
>
> xarray is free to use non-0-based indices, so this whole function could
> be simplified as:
>
> /* note the PCI_SLOT() call to clear function from devfn */
> return PCI_DEVID(pci_domain_nr(pdev->bus), PCI_SLOT(pdev->devfn));

This is not equivalent. My function encodes three PCI numbers into the
index: domain, bus, slot.
Your version would have only: domain, slot. The bus number would be
lost. And also, higher-than-16 bits of the domain would be lost
unnecessarily.

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
>
> I would say that this is too thin wrapper for "kernel interface" (memory
> ptr) to warrant it, IOW just place kfree in place of ice_adapter_free,
> that will also free us from the need to use DEFINE_FREE()

I am anticipating the need for struct members to destroy here. Eg. in
order to replace ice_ptp_lock entirely, I will add a mutex, which will
require mutex_destroy to be called in ice_adapter_free.

>
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
> that's inconvenient, to the point that it will be better to have a dummy
> static entry used for this purpose, but I see that this is something
> broader that this particular use case, so - feel free to ignore

Perhaps I don't get what you mean by a static entry. Maybe a static
singleton instance of struct ice_adapter? I don't want that, because I
can have multiple E810 NICs in the system and I don't want them to
share anything unnecessarily.

Besides, this allocates only a small amount of memory and the
allocation is GFP_KERNEL. It won't fail under any realistic scenario
(afaik, the "too small to fail" rule still holds in the kernel). This
is called only from ice_probe, which surely allocates much more
memory. I am not calling this every time I need to access the
ice_adapter. I'm keeping a pointer in ice_pf.

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
> > +
> > +     xa_lock(&ice_adapters);
> > +     ret =3D __xa_cmpxchg(&ice_adapters, index, NULL, adapter, GFP_KER=
NEL);
> > +     if (xa_is_err(ret)) {
> > +             ret =3D ERR_PTR(xa_err(ret));
> > +             goto unlock;
> > +     }
> > +     if (ret) {
> > +             refcount_inc(&ret->refcount);
> > +             goto unlock;
> > +     }
> > +     ret =3D no_free_ptr(adapter);
>
> nice solution, but this is an idiom that we want across the kernel
> instead of opting out of auto management in such cases as this one?
> (esp that you have open-coded locking anyway)

I will follow up by changing the xa_lock usage to a guard if my
recently proposed patch ("xarray: add guard definitions for xa_lock")
gets accepted:
https://lore.kernel.org/lkml/20240228135352.14444-1-mschmidt@redhat.com/

> I would expect to have explicit two stores (first to ensure index is
> present, second to overwrite entry if null) easier than cmpxchg
> + unneeded allocation (that could cause whole function to fail!)

For reasons mentioned above, I am not worried about the allocation failing.
I am afraid moving away from the cmpxchg approach would force me to either:
 - Re-add the additional mutex I had in v1 of this series and that
Jiri Pirko asked me to remove and rely on xa_lock; or
 - Allocate ice_adapter under xa_lock, i.e. with GFP_ATOMIC. That
would only make running into ENOMEM more likely.

> > +unlock:
> > +     xa_unlock(&ice_adapters);
> > +     return ret;
> > +}
> > +
> > +/**
> > + * ice_adapter_put - Release a reference to the shared ice_adapter str=
ucture.
> > + * @pdev: Pointer to the pci_dev whose driver is releasing the ice_ada=
pter.
> > + *
> > + * Releases the reference to ice_adapter previously obtained with
> > + * ice_adapter_get.
> > + *
> > + * Context: Any.
> > + */
> > +void ice_adapter_put(const struct pci_dev *pdev)
> > +{
> > +     unsigned long index =3D ice_adapter_index(pdev);
> > +     struct ice_adapter *adapter;
> > +
> > +     xa_lock(&ice_adapters);
> > +     adapter =3D xa_load(&ice_adapters, index);
> > +     if (WARN_ON(!adapter))
> > +             goto unlock;
> > +
> > +     if (!refcount_dec_and_test(&adapter->refcount))
> > +             goto unlock;
> > +
> > +     WARN_ON(__xa_erase(&ice_adapters, index) !=3D adapter);
> > +     ice_adapter_free(adapter);
> > +unlock:
> > +     xa_unlock(&ice_adapters);
> > +}
> > diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net=
/ethernet/intel/ice/ice_adapter.h
> > new file mode 100644
> > index 000000000000..cb5a02eb24c1
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* SPDX-FileCopyrightText: Copyright Red Hat */
> > +
> > +#ifndef _ICE_ADAPTER_H_
> > +#define _ICE_ADAPTER_H_
> > +
> > +#include <linux/refcount_types.h>
> > +
> > +struct pci_dev;
> > +
> > +/**
> > + * struct ice_adapter - PCI adapter resources shared across PFs
> > + * @refcount: Reference count. struct ice_pf objects hold the referenc=
es.
> > + */
> > +struct ice_adapter {
> > +     refcount_t refcount;
>
> this is refcounted always under a lock, so could be plain "int",
> but not a big deal

Yes, I know, but the over/under-flow checks provided by refcount_t
keep me warm and fuzzy :)

> > +};
> > +
> > +struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
> > +void ice_adapter_put(const struct pci_dev *pdev);
> > +
> > +#endif /* _ICE_ADAPTER_H */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/et=
hernet/intel/ice/ice_main.c
> > index 8f73ba77e835..a3c545e56256 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5093,6 +5093,7 @@ static int
> >   ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_u=
nused *ent)
> >   {
> >       struct device *dev =3D &pdev->dev;
> > +     struct ice_adapter *adapter;
> >       struct ice_pf *pf;
> >       struct ice_hw *hw;
> >       int err;
> > @@ -5145,7 +5146,12 @@ ice_probe(struct pci_dev *pdev, const struct pci=
_device_id __always_unused *ent)
> >
> >       pci_set_master(pdev);
> >
> > +     adapter =3D ice_adapter_get(pdev);
> > +     if (IS_ERR(adapter))
> > +             return PTR_ERR(adapter);
> > +
> >       pf->pdev =3D pdev;
> > +     pf->adapter =3D adapter;
> >       pci_set_drvdata(pdev, pf);
> >       set_bit(ICE_DOWN, pf->state);
> >       /* Disable service task until DOWN bit is cleared */
> > @@ -5196,6 +5202,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_=
device_id __always_unused *ent)
> >   err_load:
> >       ice_deinit(pf);
> >   err_init:
> > +     ice_adapter_put(pdev);
> >       pci_disable_device(pdev);
> >       return err;
> >   }
> > @@ -5302,6 +5309,7 @@ static void ice_remove(struct pci_dev *pdev)
> >       ice_setup_mc_magic_wake(pf);
> >       ice_set_wake(pf);
> >
> > +     ice_adapter_put(pdev);
> >       pci_disable_device(pdev);
> >   }
> >
>


