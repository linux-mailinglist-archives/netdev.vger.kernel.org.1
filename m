Return-Path: <netdev+bounces-75197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41417868982
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA172283579
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762253813;
	Tue, 27 Feb 2024 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="K+egudjD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203A52F9F
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017538; cv=none; b=HcFf9DMILuOlV+BvoWY64Z96uCy9OtoCjEdW9Yb/XIHoTjTVS1mDfci4E6uPSeuEs5/XLHvdNPakOPiavaJ3jDza52BdTzPeOipNh/xbt+6aTVafhkrUScmU24JMKmYg5/P9jE/hFD+RA+msNYwcaZDfLM38c5ND6V+dCDwvu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017538; c=relaxed/simple;
	bh=C4bq9SaDGmneF8+UbrRpfP94Ml1jtqANbMF5/y09cjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJvFwMTfnijqs4mpRUe2UZYJk7L1p4I3Dt8UKYelSKC0tmBPHvCprj45D2ogNeXciYJDjpo+kD89BL93jT6VwesQBC8B3OtAAjV0U47giGpq3+HrC3IY8oU6BObhPgkdpp8+3JPaBrYiF3gfjqcEZx14VUWn+JwnV+4o1F7ytC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=K+egudjD; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so45498641fa.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709017532; x=1709622332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXtEex9VuQR1EP3e/5JdrfpeNpYD0e7hgfGq456hgR8=;
        b=K+egudjDfWv1h7yOwHLjxk7jQIrlnZl9niH7/OYtrGGNoESENbLY7Ls0ExttealXgU
         sKGKvUS6urerddOFMioaLSRBnQzWuT3X/5b2cmlZgUO5AvPCulWrtXacAsYIzVi6l3XP
         LovNSZbtrh+WotIGyEp25Jse23fCNlfJ5ZyzLY0+5+yu1HRxrYmMrXSwuyYulsfhdSkT
         4oerPHvtVUzWpZKYUBNwvuW15duWkW22nZ30y3H60VC3nX1U5OC7Nou1cQkokbmgKAuw
         jjIZEHJqrPkuKzmHOQHASVUNpDuh95RjFxo6M32ubBsEtxrn+YfjRJg4ZFQ0GhBG7nE+
         J2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017532; x=1709622332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXtEex9VuQR1EP3e/5JdrfpeNpYD0e7hgfGq456hgR8=;
        b=knAYGWjZ7l1wmQ0CQ46D3IYWIR1/iFcs5MLrwVtgSZdGom02DA2CBTcUsmSMl7A4Pf
         yPW1BhDTHHsCImBY6Zy+qeJU/a7g0mefN6B4dgL8pqJfkFFzTkTgUSY5eneRLtj5EbEH
         dx1tcxMQ1rM5Uy5sC1t39hW5XEZkiAgPAZedD0GOFA5ZgZm6F72Qnjdhj70CEacGEahw
         ZUwzbJjyYqLbY2uX8MlsRxWiD90kHePqj+0NUrnfFWgr3w8hB7ppZgOuXKIJ1r1izQCF
         eulAtMHPaAvk2j5+fFqgqGCvYNE3abzbt458yhFrcNLkauTvclZn3120dcUBSW7ceEKz
         vV6w==
X-Forwarded-Encrypted: i=1; AJvYcCX9OeHH8G77R+aWKhVWLGgek2nP7IUehzHthPxC522sF7dE/ythlm2XCHzD5IHwG4Xk6xZKRtppOdjDZsT7D5CR6Kvwh/qd
X-Gm-Message-State: AOJu0YzhR6fZfHsfL4uVQoHSnazHOe2gHYB1cU1oo2DLUjobItsBnf2+
	23EWzzftRZSGBG8P7sNrl5f3OCthuoVSazpCeaSpOrOeQKu9weLwVeEGtKGgagw=
X-Google-Smtp-Source: AGHT+IHMIHGl/kzP+ATyzsjuczq1RY307sP0jV7fhxbh+RXvsF+7aiwa5DH2o5hrqgxIZaIX+9nM9w==
X-Received: by 2002:ac2:4203:0:b0:512:ab3d:d551 with SMTP id y3-20020ac24203000000b00512ab3dd551mr5703787lfh.19.1709017532294;
        Mon, 26 Feb 2024 23:05:32 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c00d400b00410b0ce91b1sm14061609wmm.25.2024.02.26.23.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:05:31 -0800 (PST)
Date: Tue, 27 Feb 2024 08:05:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] ice: add ice_adapter for shared data across
 PFs on the same NIC
Message-ID: <Zd2JuVAyHigIy5NR@nanopsycho>
References: <20240226151125.45391-1-mschmidt@redhat.com>
 <20240226151125.45391-2-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226151125.45391-2-mschmidt@redhat.com>

Mon, Feb 26, 2024 at 04:11:23PM CET, mschmidt@redhat.com wrote:
>There is a need for synchronization between ice PFs on the same physical
>adapter.
>
>Add a "struct ice_adapter" for holding data shared between PFs of the
>same multifunction PCI device. The struct is refcounted - each ice_pf
>holds a reference to it.
>
>Its first use will be for PTP. I expect it will be useful also to
>improve the ugliness that is ice_prot_id_tbl.
>
>Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
>---
> drivers/net/ethernet/intel/ice/Makefile      |  3 +-
> drivers/net/ethernet/intel/ice/ice.h         |  2 +
> drivers/net/ethernet/intel/ice/ice_adapter.c | 67 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_adapter.h | 22 +++++++
> drivers/net/ethernet/intel/ice/ice_main.c    |  8 +++
> 5 files changed, 101 insertions(+), 1 deletion(-)
> create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
> create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
>
>diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>index cddd82d4ca0f..4fa09c321440 100644
>--- a/drivers/net/ethernet/intel/ice/Makefile
>+++ b/drivers/net/ethernet/intel/ice/Makefile
>@@ -36,7 +36,8 @@ ice-y := ice_main.o	\
> 	 ice_repr.o	\
> 	 ice_tc_lib.o	\
> 	 ice_fwlog.o	\
>-	 ice_debugfs.o
>+	 ice_debugfs.o  \
>+	 ice_adapter.o
> ice-$(CONFIG_PCI_IOV) +=	\
> 	ice_sriov.o		\
> 	ice_virtchnl.o		\
>diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>index 365c03d1c462..1ffecbdd361a 100644
>--- a/drivers/net/ethernet/intel/ice/ice.h
>+++ b/drivers/net/ethernet/intel/ice/ice.h
>@@ -77,6 +77,7 @@
> #include "ice_gnss.h"
> #include "ice_irq.h"
> #include "ice_dpll.h"
>+#include "ice_adapter.h"
> 
> #define ICE_BAR0		0
> #define ICE_REQ_DESC_MULTIPLE	32
>@@ -544,6 +545,7 @@ struct ice_agg_node {
> 
> struct ice_pf {
> 	struct pci_dev *pdev;
>+	struct ice_adapter *adapter;
> 
> 	struct devlink_region *nvm_region;
> 	struct devlink_region *sram_region;
>diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
>new file mode 100644
>index 000000000000..deb063401238
>--- /dev/null
>+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>@@ -0,0 +1,67 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+// SPDX-FileCopyrightText: Copyright Red Hat
>+
>+#include <linux/cleanup.h>
>+#include <linux/mutex.h>
>+#include <linux/pci.h>
>+#include <linux/slab.h>
>+#include <linux/xarray.h>
>+#include "ice_adapter.h"
>+
>+static DEFINE_MUTEX(ice_adapters_lock);

Why you need and extra mutex and not just rely on xarray lock?


>+static DEFINE_XARRAY(ice_adapters);
>+
>+static unsigned long ice_adapter_index(const struct pci_dev *pdev)
>+{
>+	unsigned int domain = pci_domain_nr(pdev->bus);
>+
>+	WARN_ON((unsigned long)domain >> (BITS_PER_LONG - 13));
>+	return ((unsigned long)domain << 13) |
>+	       ((unsigned long)pdev->bus->number << 5) |
>+	       PCI_SLOT(pdev->devfn);
>+}
>+
>+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>+{
>+	unsigned long index = ice_adapter_index(pdev);
>+	struct ice_adapter *a;
>+
>+	guard(mutex)(&ice_adapters_lock);
>+
>+	a = xa_load(&ice_adapters, index);
>+	if (a) {
>+		refcount_inc(&a->refcount);
>+		return a;
>+	}
>+
>+	a = kzalloc(sizeof(*a), GFP_KERNEL);
>+	if (!a)
>+		return NULL;
>+
>+	refcount_set(&a->refcount, 1);
>+
>+	if (xa_is_err(xa_store(&ice_adapters, index, a, GFP_KERNEL))) {
>+		kfree(a);
>+		return NULL;
>+	}
>+
>+	return a;
>+}
>+
>+void ice_adapter_put(const struct pci_dev *pdev)
>+{
>+	unsigned long index = ice_adapter_index(pdev);
>+	struct ice_adapter *a;
>+
>+	guard(mutex)(&ice_adapters_lock);
>+
>+	a = xa_load(&ice_adapters, index);
>+	if (WARN_ON(!a))
>+		return;
>+
>+	if (!refcount_dec_and_test(&a->refcount))
>+		return;
>+
>+	WARN_ON(xa_erase(&ice_adapters, index) != a);
>+	kfree(a);
>+}
>diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>new file mode 100644
>index 000000000000..cb5a02eb24c1
>--- /dev/null
>+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>@@ -0,0 +1,22 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/* SPDX-FileCopyrightText: Copyright Red Hat */
>+
>+#ifndef _ICE_ADAPTER_H_
>+#define _ICE_ADAPTER_H_
>+
>+#include <linux/refcount_types.h>
>+
>+struct pci_dev;
>+
>+/**
>+ * struct ice_adapter - PCI adapter resources shared across PFs
>+ * @refcount: Reference count. struct ice_pf objects hold the references.
>+ */
>+struct ice_adapter {
>+	refcount_t refcount;
>+};
>+
>+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
>+void ice_adapter_put(const struct pci_dev *pdev);
>+
>+#endif /* _ICE_ADAPTER_H */
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>index 9c2c8637b4a7..4a60957221fc 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -5093,6 +5093,7 @@ static int
> ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
> {
> 	struct device *dev = &pdev->dev;
>+	struct ice_adapter *adapter;
> 	struct ice_pf *pf;
> 	struct ice_hw *hw;
> 	int err;
>@@ -5145,7 +5146,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
> 
> 	pci_set_master(pdev);
> 
>+	adapter = ice_adapter_get(pdev);
>+	if (!adapter)
>+		return -ENOMEM;
>+
> 	pf->pdev = pdev;
>+	pf->adapter = adapter;
> 	pci_set_drvdata(pdev, pf);
> 	set_bit(ICE_DOWN, pf->state);
> 	/* Disable service task until DOWN bit is cleared */
>@@ -5196,6 +5202,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
> err_load:
> 	ice_deinit(pf);
> err_init:
>+	ice_adapter_put(pdev);
> 	pci_disable_device(pdev);
> 	return err;
> }
>@@ -5302,6 +5309,7 @@ static void ice_remove(struct pci_dev *pdev)
> 	ice_setup_mc_magic_wake(pf);
> 	ice_set_wake(pf);
> 
>+	ice_adapter_put(pdev);
> 	pci_disable_device(pdev);
> }
> 
>-- 
>2.43.2
>
>

