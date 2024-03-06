Return-Path: <netdev+bounces-78037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE00873CD0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926DB1C236E9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E38137935;
	Wed,  6 Mar 2024 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OSrE7Cdw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B279F13BAF1
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744413; cv=none; b=GyHI4DgD9DYg02XgJZNqajS7qGkk6upu/Da/TlgnH4BwSU9tiVNAQ0buIcKdnxTnoykNgCMaE+roJqNK+31Gdu360PnM8YXO31pLoCVP8dO3D+OPQSRR0hKq3BLa3Aj28aKU0P6AmgdjYiOPG0lphtv7CaYzH01c3QiZoF6uW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744413; c=relaxed/simple;
	bh=i7q8FxhF1vVOcK6bokFQ/71N9MFzoOBybv77Vp99v6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlPmSM+oMK6YWnwShTnbOGw+rr9/kvs6LJLyLMv7TzHWQz8sq8qcARCohK543y+TJK+Nan1Y3L6UtGgVJha4aMn5pSPHt+RQTy6OLD5M1e3MhufBmmGI3R/OZL0gSc+M1cYQ17Akuh9MEvzizNQgNZfR63tgt6PRR1H8bFq4rU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OSrE7Cdw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412e784060cso6856785e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709744409; x=1710349209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SS0NRBHuVjXJEm0e2EQJiFfHLmy7AHC7SVYxOl3bBaY=;
        b=OSrE7CdwsK2UeUe4dyulK+Ow/3abtwtKWxTEtlr6ODHp9tb29Wa0s8/+EeGLPxGb3y
         UCweib280BbMtB53OLzmebQhgYIXW4vpiGRYzVUr0P7kgJv5gYfEXwDfMk1x3N68Jxri
         sct2EFOp9Pj0KgxT50J8HZVyhXJhBLgHN/3jmkfMvd+6bGNKMpu9RRtd0xXAu0SVQueQ
         ufkrUHI5qz41Cj+cwOoGIryIcjLtbJ1WkJucenawshO2Qhc03Uf/7v32+RN/pOeUwDVE
         6DdXkH/RevvfnXqWpxa900+Wm1mg6+O/kQU/pS729XC/rj5xcYs2dxkSquG18D2fqzyL
         Y8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709744409; x=1710349209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS0NRBHuVjXJEm0e2EQJiFfHLmy7AHC7SVYxOl3bBaY=;
        b=RLaBM5PV8JSqZ8TMV74wktGTeOuESvI0hQQqeWC2ry2e7H1EIu0FxQrupQEpc3s8S1
         z9K4U4uwxgXv6e6KJhaMH0Jq+il4cemoeWckXnlgzunLN6KznfQAXtiSJe8wLdr+0qy6
         4g3YDNU4fqZG3JxhtJMXtGkZ00Q/4SOH2bj+rdJb2K/XNkRebPxJk4jdjCmjL96jj8vf
         Y9gu/Slu1LQr/RhX7q0/jPoKGQPvhyFhXIV84558sZ9NGMbb2QM8WW1pbUAZk5wAh8wG
         W3yvohL79RqZF/g4b2SWAOAPwewaGtzuvzFwVg1AsYtAZjXzbOOheUZglQK5/s7T1mm0
         3WyA==
X-Forwarded-Encrypted: i=1; AJvYcCXXKzzpCGj8vBxZz0aKKG6TH9IvBkah6eYWPte2tOzKAq8JN/yNmtudBxGcapvLQKuea+mO1TFiT6bJm11i0fxSGvVR8i9b
X-Gm-Message-State: AOJu0Yzy3EaK09g9SUq1V5+5DBcqavpOPCWCNQoMHQDJqFdVZb1KlMdo
	38SrlTtXtmzNwec079XGr3iadVSyPfpu+7qNF+31URRwDyrMq+GYOTDHbnRGfgg=
X-Google-Smtp-Source: AGHT+IEwlxXfRGecyIlwJLY5axCnmYvHcaYij05RysgU+GJaiTlUs5/S/eVb1Riyqfl+ZemMD0AnfA==
X-Received: by 2002:adf:a197:0:b0:33e:601e:3c21 with SMTP id u23-20020adfa197000000b0033e601e3c21mr408wru.19.1709744408660;
        Wed, 06 Mar 2024 09:00:08 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id co17-20020a0560000a1100b0033e3ca55a4esm9270153wrb.21.2024.03.06.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 09:00:08 -0800 (PST)
Date: Wed, 6 Mar 2024 18:00:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH net-next v2 1/3] ice: add ice_adapter for shared data
 across PFs on the same NIC
Message-ID: <ZeihFVgwBBLOZ4CL@nanopsycho>
References: <20240306162907.84247-1-mschmidt@redhat.com>
 <20240306162907.84247-2-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306162907.84247-2-mschmidt@redhat.com>

Wed, Mar 06, 2024 at 05:29:05PM CET, mschmidt@redhat.com wrote:
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
> drivers/net/ethernet/intel/ice/ice_adapter.c | 85 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_adapter.h | 22 +++++
> drivers/net/ethernet/intel/ice/ice_main.c    |  8 ++
> 5 files changed, 119 insertions(+), 1 deletion(-)
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
>index 000000000000..b93b4db4c04c
>--- /dev/null
>+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>@@ -0,0 +1,85 @@
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
>+static struct ice_adapter *ice_adapter_new(void)
>+{
>+	struct ice_adapter *a;
>+
>+	a = kzalloc(sizeof(*a), GFP_KERNEL);
>+	if (!a)
>+		return NULL;
>+
>+	refcount_set(&a->refcount, 1);
>+
>+	return a;
>+}
>+
>+static void ice_adapter_free(struct ice_adapter *a)
>+{
>+	kfree(a);
>+}
>+
>+DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter_free(_T))
>+
>+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>+{
>+	struct ice_adapter *ret, __free(ice_adapter_free) *a = NULL;
>+	unsigned long index = ice_adapter_index(pdev);
>+
>+	a = ice_adapter_new();

Please consider some non-single-letter variable name.


>+	if (!a)
>+		return NULL;
>+
>+	xa_lock(&ice_adapters);
>+	ret = __xa_cmpxchg(&ice_adapters, index, NULL, a, GFP_KERNEL);

This is atomic section, can't sleep.


>+	if (xa_is_err(ret)) {
>+		ret = NULL;

Why don't you propagate err through ERR_PTR() ?


>+		goto unlock;
>+	}
>+	if (ret) {
>+		refcount_inc(&ret->refcount);
>+		goto unlock;
>+	}
>+	ret = no_free_ptr(a);
>+unlock:
>+	xa_unlock(&ice_adapters);
>+	return ret;
>+}
>+
>+void ice_adapter_put(const struct pci_dev *pdev)
>+{
>+	unsigned long index = ice_adapter_index(pdev);
>+	struct ice_adapter *a;
>+
>+	xa_lock(&ice_adapters);
>+	a = xa_load(&ice_adapters, index);
>+	if (WARN_ON(!a))
>+		goto unlock;
>+
>+	if (!refcount_dec_and_test(&a->refcount))
>+		goto unlock;
>+
>+	WARN_ON(__xa_erase(&ice_adapters, index) != a);

Nice paranoia level :)


>+	ice_adapter_free(a);
>+unlock:
>+	xa_unlock(&ice_adapters);
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
>index 8f73ba77e835..413219d81a12 100644
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

