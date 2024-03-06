Return-Path: <netdev+bounces-78085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB165874049
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA2B1C24BCB
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055B13F00B;
	Wed,  6 Mar 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhNVRIn+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43613E7FF
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752850; cv=none; b=BLBuTeeueRXTcwcCzucv5bhF1qaIbLlZYWy5UkQo7Wc4AZ5qGtUI9rFVPe6gY4al2HVmT0yRJYtU/470B+aLMtgcibVV1QcIv+q1ndrrLXrlXtWk7DX7GF1n9u1UULzfalCjt4DpSW3wE7AmuvDkuteT41kfQaOScAcjD9zwsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752850; c=relaxed/simple;
	bh=mo84TLPILoTUagVyQis2ihLzQcWCoFHIXVSFmww+G/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGDBR5CTnZW0rzCiJCAPm3BMmWCfjqhuiulgYvsc/77QtKo2p/YgnROuviPJ581loG0T3zihT0drsYpYZ7BijMVvErzVsaToBwVVnSj+ujkagy1rvH0nEHSWY4Rg70SkLlOkrEXAks/ZyHpIba5Mc1qO8HXQZWvLAbhOdWqLMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhNVRIn+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709752847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92n/2V/ZZRBf/txj6fFiiPCDY877S/i43eKFF6hUfSc=;
	b=PhNVRIn+FnS7j8pgEO0IuESVCmzJJAPtrmwmHpeVF7VsWy1zIs2FsWuagCec2B/pcmbII1
	mPA0Nx8YyjlFvG/olRnZE79tkME0mmsxKfboMxPasZiugypYN/e2/pXuBf+Kh4+LsSWiLf
	Zoh6vDzqpWDqhrSaT0ZoJhM/7LlGKk8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-DOX4ml0mN3avHsmgUYcKFA-1; Wed, 06 Mar 2024 14:20:46 -0500
X-MC-Unique: DOX4ml0mN3avHsmgUYcKFA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-565862cc48fso113091a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 11:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752845; x=1710357645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92n/2V/ZZRBf/txj6fFiiPCDY877S/i43eKFF6hUfSc=;
        b=lzovBkDEG+LCP80tdOsEUeCGidvz/8+r9O+nVR0Br0V0fYTT/OB6H8weWxwsBJ8/Ea
         hzPdfCKxT36kaqQsKkocghwfvJYSJq9EdFmj/KpdFZ61URUkqSlnbRAEvGYt9Oso3FT9
         yLnh0X39+5U43nkkuWB0UPN/fikC26mA9WB6uinB+vrm1ZwuquielSxgSfs4qcsr7LhZ
         PgcjVlEK+dSQSuNDXPJfdxaOxpgJHcY2GaCTkuKeol0HG9Wsb4LI5FuNK1g5Lmg17ZhQ
         P73hssMfoOMIEdRy5et5kRFo67ppFMwOpUTuGCIWKfSa/nPV3qaVcerv/m3ORCCmWBuu
         E+0w==
X-Forwarded-Encrypted: i=1; AJvYcCXiy4byBys/u8QNB/1vlEEpTDnVDnHV57sl1CPxRnqEys1Wvy+QAocS/AKdxBMadwZSA7ltkttb1ihqf3vkrf4ZOaj0iyxi
X-Gm-Message-State: AOJu0YwqsgpezJ9FMT2HDV5t4Ndh5lpvp0zayt7r3Ef+rg6uBu2J0r2p
	V/usQNWu9wX5Rfshy0yj2Sy1WPs+vPjtGjFGjmKC5LnALdREgRaHl9xtJ//AXTAG6jDEH5c7dgI
	BC3xTG2zoPixOL3okegP92vUrM3bEBOT9q+uUWXiArigPxHxtftiglnaPQ/zSaYfaIrcehkxl8n
	uUJVBuFhyWl1no80aWA5D7rZum44SPMVp+GoNK
X-Received: by 2002:a05:6402:1e87:b0:566:d083:df68 with SMTP id f7-20020a0564021e8700b00566d083df68mr5844910edf.21.1709752844856;
        Wed, 06 Mar 2024 11:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ+4MZ+S5iLviZ/Ho7O7H4DVf6nENriFc6UckU20uADT4vFV6ZITae9v4aD6avyEGzhhCiskVSQ5N4bwxtaI4=
X-Received: by 2002:a05:6402:1e87:b0:566:d083:df68 with SMTP id
 f7-20020a0564021e8700b00566d083df68mr5844891edf.21.1709752844530; Wed, 06 Mar
 2024 11:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306162907.84247-1-mschmidt@redhat.com> <20240306162907.84247-2-mschmidt@redhat.com>
 <ZeihFVgwBBLOZ4CL@nanopsycho>
In-Reply-To: <ZeihFVgwBBLOZ4CL@nanopsycho>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 6 Mar 2024 20:20:33 +0100
Message-ID: <CADEbmW1CtULCvYxW+yyB1=PRzAkAUMOE6LYfk3v6kODJTwXcsA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] ice: add ice_adapter for shared data
 across PFs on the same NIC
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:00=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, Mar 06, 2024 at 05:29:05PM CET, mschmidt@redhat.com wrote:
> >There is a need for synchronization between ice PFs on the same physical
> >adapter.
> >
> >Add a "struct ice_adapter" for holding data shared between PFs of the
> >same multifunction PCI device. The struct is refcounted - each ice_pf
> >holds a reference to it.
> >
> >Its first use will be for PTP. I expect it will be useful also to
> >improve the ugliness that is ice_prot_id_tbl.
> >
> >Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> >---
> > drivers/net/ethernet/intel/ice/Makefile      |  3 +-
> > drivers/net/ethernet/intel/ice/ice.h         |  2 +
> > drivers/net/ethernet/intel/ice/ice_adapter.c | 85 ++++++++++++++++++++
> > drivers/net/ethernet/intel/ice/ice_adapter.h | 22 +++++
> > drivers/net/ethernet/intel/ice/ice_main.c    |  8 ++
> > 5 files changed, 119 insertions(+), 1 deletion(-)
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
> > create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
> >
> >diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ether=
net/intel/ice/Makefile
> >index cddd82d4ca0f..4fa09c321440 100644
> >--- a/drivers/net/ethernet/intel/ice/Makefile
> >+++ b/drivers/net/ethernet/intel/ice/Makefile
> >@@ -36,7 +36,8 @@ ice-y :=3D ice_main.o  \
> >        ice_repr.o     \
> >        ice_tc_lib.o   \
> >        ice_fwlog.o    \
> >-       ice_debugfs.o
> >+       ice_debugfs.o  \
> >+       ice_adapter.o
> > ice-$(CONFIG_PCI_IOV) +=3D      \
> >       ice_sriov.o             \
> >       ice_virtchnl.o          \
> >diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet=
/intel/ice/ice.h
> >index 365c03d1c462..1ffecbdd361a 100644
> >--- a/drivers/net/ethernet/intel/ice/ice.h
> >+++ b/drivers/net/ethernet/intel/ice/ice.h
> >@@ -77,6 +77,7 @@
> > #include "ice_gnss.h"
> > #include "ice_irq.h"
> > #include "ice_dpll.h"
> >+#include "ice_adapter.h"
> >
> > #define ICE_BAR0              0
> > #define ICE_REQ_DESC_MULTIPLE 32
> >@@ -544,6 +545,7 @@ struct ice_agg_node {
> >
> > struct ice_pf {
> >       struct pci_dev *pdev;
> >+      struct ice_adapter *adapter;
> >
> >       struct devlink_region *nvm_region;
> >       struct devlink_region *sram_region;
> >diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/=
ethernet/intel/ice/ice_adapter.c
> >new file mode 100644
> >index 000000000000..b93b4db4c04c
> >--- /dev/null
> >+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> >@@ -0,0 +1,85 @@
> >+// SPDX-License-Identifier: GPL-2.0-only
> >+// SPDX-FileCopyrightText: Copyright Red Hat
> >+
> >+#include <linux/cleanup.h>
> >+#include <linux/mutex.h>
> >+#include <linux/pci.h>
> >+#include <linux/slab.h>
> >+#include <linux/xarray.h>
> >+#include "ice_adapter.h"
> >+
> >+static DEFINE_XARRAY(ice_adapters);
> >+
> >+static unsigned long ice_adapter_index(const struct pci_dev *pdev)
> >+{
> >+      unsigned int domain =3D pci_domain_nr(pdev->bus);
> >+
> >+      WARN_ON((unsigned long)domain >> (BITS_PER_LONG - 13));
> >+      return ((unsigned long)domain << 13) |
> >+             ((unsigned long)pdev->bus->number << 5) |
> >+             PCI_SLOT(pdev->devfn);
> >+}
> >+
> >+static struct ice_adapter *ice_adapter_new(void)
> >+{
> >+      struct ice_adapter *a;
> >+
> >+      a =3D kzalloc(sizeof(*a), GFP_KERNEL);
> >+      if (!a)
> >+              return NULL;
> >+
> >+      refcount_set(&a->refcount, 1);
> >+
> >+      return a;
> >+}
> >+
> >+static void ice_adapter_free(struct ice_adapter *a)
> >+{
> >+      kfree(a);
> >+}
> >+
> >+DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter_=
free(_T))
> >+
> >+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
> >+{
> >+      struct ice_adapter *ret, __free(ice_adapter_free) *a =3D NULL;
> >+      unsigned long index =3D ice_adapter_index(pdev);
> >+
> >+      a =3D ice_adapter_new();
>
> Please consider some non-single-letter variable name.

Alright, I can change the name.

> >+      if (!a)
> >+              return NULL;
> >+
> >+      xa_lock(&ice_adapters);
> >+      ret =3D __xa_cmpxchg(&ice_adapters, index, NULL, a, GFP_KERNEL);
>
> This is atomic section, can't sleep.

It is not atomic. __xa_cmpxchg releases xa_lock before it allocates
memory, then reacquires it.

> >+      if (xa_is_err(ret)) {
> >+              ret =3D NULL;
>
> Why don't you propagate err through ERR_PTR() ?

It seemed unnecessary. ENOMEM is the only failure that can possibly
happen. EINVAL could be returned only if attempting to store an
unaligned pointer, which won't happen here.

>
> >+              goto unlock;
> >+      }
> >+      if (ret) {
> >+              refcount_inc(&ret->refcount);
> >+              goto unlock;
> >+      }
> >+      ret =3D no_free_ptr(a);
> >+unlock:
> >+      xa_unlock(&ice_adapters);
> >+      return ret;
> >+}
> >+
> >+void ice_adapter_put(const struct pci_dev *pdev)
> >+{
> >+      unsigned long index =3D ice_adapter_index(pdev);
> >+      struct ice_adapter *a;
> >+
> >+      xa_lock(&ice_adapters);
> >+      a =3D xa_load(&ice_adapters, index);
> >+      if (WARN_ON(!a))
> >+              goto unlock;
> >+
> >+      if (!refcount_dec_and_test(&a->refcount))
> >+              goto unlock;
> >+
> >+      WARN_ON(__xa_erase(&ice_adapters, index) !=3D a);
>
> Nice paranoia level :)
>
>
> >+      ice_adapter_free(a);
> >+unlock:
> >+      xa_unlock(&ice_adapters);
> >+}
> >diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/=
ethernet/intel/ice/ice_adapter.h
> >new file mode 100644
> >index 000000000000..cb5a02eb24c1
> >--- /dev/null
> >+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> >@@ -0,0 +1,22 @@
> >+/* SPDX-License-Identifier: GPL-2.0-only */
> >+/* SPDX-FileCopyrightText: Copyright Red Hat */
> >+
> >+#ifndef _ICE_ADAPTER_H_
> >+#define _ICE_ADAPTER_H_
> >+
> >+#include <linux/refcount_types.h>
> >+
> >+struct pci_dev;
> >+
> >+/**
> >+ * struct ice_adapter - PCI adapter resources shared across PFs
> >+ * @refcount: Reference count. struct ice_pf objects hold the reference=
s.
> >+ */
> >+struct ice_adapter {
> >+      refcount_t refcount;
> >+};
> >+
> >+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
> >+void ice_adapter_put(const struct pci_dev *pdev);
> >+
> >+#endif /* _ICE_ADAPTER_H */
> >diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/eth=
ernet/intel/ice/ice_main.c
> >index 8f73ba77e835..413219d81a12 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_main.c
> >+++ b/drivers/net/ethernet/intel/ice/ice_main.c
> >@@ -5093,6 +5093,7 @@ static int
> > ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unu=
sed *ent)
> > {
> >       struct device *dev =3D &pdev->dev;
> >+      struct ice_adapter *adapter;
> >       struct ice_pf *pf;
> >       struct ice_hw *hw;
> >       int err;
> >@@ -5145,7 +5146,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_=
device_id __always_unused *ent)
> >
> >       pci_set_master(pdev);
> >
> >+      adapter =3D ice_adapter_get(pdev);
> >+      if (!adapter)
> >+              return -ENOMEM;
> >+
> >       pf->pdev =3D pdev;
> >+      pf->adapter =3D adapter;
> >       pci_set_drvdata(pdev, pf);
> >       set_bit(ICE_DOWN, pf->state);
> >       /* Disable service task until DOWN bit is cleared */
> >@@ -5196,6 +5202,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_d=
evice_id __always_unused *ent)
> > err_load:
> >       ice_deinit(pf);
> > err_init:
> >+      ice_adapter_put(pdev);
> >       pci_disable_device(pdev);
> >       return err;
> > }
> >@@ -5302,6 +5309,7 @@ static void ice_remove(struct pci_dev *pdev)
> >       ice_setup_mc_magic_wake(pf);
> >       ice_set_wake(pf);
> >
> >+      ice_adapter_put(pdev);
> >       pci_disable_device(pdev);
> > }
> >
> >--
> >2.43.2
> >
>


