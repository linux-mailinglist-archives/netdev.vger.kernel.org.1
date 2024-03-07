Return-Path: <netdev+bounces-78268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62460874998
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A541C21847
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A26634E9;
	Thu,  7 Mar 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NmEF31Em"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0D63105
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800063; cv=none; b=V1YdPZGyjVQ7SbAHLqjs3W5GkOu1wxGb60nSZ4TlCKCRI3Hl+JC8Qp3FHxMhwf7RU2H36TcplLp4hlykLtD+HpQTiioCz4lQBl+W32892ATkSIShIrdAWJ/i5aZw/GAwiDvjADRShhZtJ3b/XC1n8Fq/sWdA2tDiiX+suO9BmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800063; c=relaxed/simple;
	bh=klzMptLDSzY0Kj/qJJe1iw8CHZdWY0KqAPlKAiSf4S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOLMZFeTzZG+xlA4TKp8Lapbd62/XvnjPL5kFXUv82uUh7poOcYQWJ30pLH14dipih+5T017B/gO+lV9Rm6e1IdES4GE5KaZGdWZQ/+c46zCGdEhOX2cYZtTPhDlSV/+YKRjb/ssVTrqALn7p/wjyVe71t6yMI9BVSbRKs4irw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NmEF31Em; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609eb87a847so4503607b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 00:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709800059; x=1710404859; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WLdwKbBSdROedAD9rZYUd374lyBn5xiL+i60HjMcvD8=;
        b=NmEF31Emtw8+yfgR1V/eSXq5+sBN845ApSiJR6l5WsZMsHLf0YS7w+/8JkID5GUgRP
         e35etWEM00DVc/M3JcZTEx+xJg9S4rWow2Hh+UgVJVr3gYaari3zczIpRkJhOq9D+pMe
         PibSi42CPq6p3cB2VUggx3iAmRL5OSD+Ts/UMhk0cYzYTTfnJeDTndjoKWufgLi+jm+a
         eramg5u/CcCmSh4vRKFnn0sx210l7+blPwWxUhw9G7f5fzY4L5Zh2vRmDRWGlROf86Ex
         SbMFu00/KgSjFUM9yGyTt5icFt1EjUpjJkw9UhzLlHbLopwxpbCK8WVmCClxZX8TukCz
         J2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800059; x=1710404859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLdwKbBSdROedAD9rZYUd374lyBn5xiL+i60HjMcvD8=;
        b=toi7PBhipdbiNcudF5oj3TGb9sdzLNM5PHWU4A/7kAhWhnJKHZLHH77oew50s40O1I
         UcKmCy31sFvJgUZn5wkiUCTZGboxypcpYl4o/S7Y9flbzyo9w12w25ynNZjNh29A2vXt
         XrpmU5PXrY+2dquaOyHj6sQKX4DvDG+C3Hk3J6dogDserOyFgnw10jxnj7bfiQFT3xsf
         h+IMJSdosa0M0hx6K3Pr/Gsbv1CiB5Jm6tqe14vUsHWXEpZZXdpmqFZVIOr9NUwzMTF6
         bi+0OyhhCSh5TXwfci3w8RcZv0XzOVQ6ByQWkKcX1+iTiN9yVni2Wcni9rsWIkKPRO+d
         AQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCUFvtDvXbGsV96qaTufLFm30D8d0kRV4If5P8oZO4yiUcPRpHkLrycxXBj+2vjDlIOG6DnYiy6czL9RpKEokRMfZH6d1ldN
X-Gm-Message-State: AOJu0YzkgtK6T9I1Q9cUaOssntJi6vhGFgYjcN6HAIHCtQOkKxyR86kt
	D4S93fXar9UF5+kUafMbejzLYTW77GyIr7njzF72gj5V/BVoLP3dzJdloyE15YU=
X-Google-Smtp-Source: AGHT+IHKnrCpyN9nT9JhDmAhsTl7hjgiZLiQGEH7VKTnqdBVaTui4J2wZEDU7wOl63uVyE5A3gWEVQ==
X-Received: by 2002:a0d:df84:0:b0:609:ed7d:19eb with SMTP id i126-20020a0ddf84000000b00609ed7d19ebmr446046ywe.2.1709800058765;
        Thu, 07 Mar 2024 00:27:38 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p205-20020a815bd6000000b006093e3336b2sm4095339ywb.60.2024.03.07.00.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 00:27:38 -0800 (PST)
Date: Thu, 7 Mar 2024 09:27:35 +0100
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
Message-ID: <Zel6dy7PhfP258jk@nanopsycho>
References: <20240306162907.84247-1-mschmidt@redhat.com>
 <20240306162907.84247-2-mschmidt@redhat.com>
 <ZeihFVgwBBLOZ4CL@nanopsycho>
 <CADEbmW1CtULCvYxW+yyB1=PRzAkAUMOE6LYfk3v6kODJTwXcsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADEbmW1CtULCvYxW+yyB1=PRzAkAUMOE6LYfk3v6kODJTwXcsA@mail.gmail.com>

Wed, Mar 06, 2024 at 08:20:33PM CET, mschmidt@redhat.com wrote:
>On Wed, Mar 6, 2024 at 6:00 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> Wed, Mar 06, 2024 at 05:29:05PM CET, mschmidt@redhat.com wrote:
>> >There is a need for synchronization between ice PFs on the same physical
>> >adapter.
>> >
>> >Add a "struct ice_adapter" for holding data shared between PFs of the
>> >same multifunction PCI device. The struct is refcounted - each ice_pf
>> >holds a reference to it.
>> >
>> >Its first use will be for PTP. I expect it will be useful also to
>> >improve the ugliness that is ice_prot_id_tbl.
>> >
>> >Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
>> >---
>> > drivers/net/ethernet/intel/ice/Makefile      |  3 +-
>> > drivers/net/ethernet/intel/ice/ice.h         |  2 +
>> > drivers/net/ethernet/intel/ice/ice_adapter.c | 85 ++++++++++++++++++++
>> > drivers/net/ethernet/intel/ice/ice_adapter.h | 22 +++++
>> > drivers/net/ethernet/intel/ice/ice_main.c    |  8 ++
>> > 5 files changed, 119 insertions(+), 1 deletion(-)
>> > create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.c
>> > create mode 100644 drivers/net/ethernet/intel/ice/ice_adapter.h
>> >
>> >diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>> >index cddd82d4ca0f..4fa09c321440 100644
>> >--- a/drivers/net/ethernet/intel/ice/Makefile
>> >+++ b/drivers/net/ethernet/intel/ice/Makefile
>> >@@ -36,7 +36,8 @@ ice-y := ice_main.o  \
>> >        ice_repr.o     \
>> >        ice_tc_lib.o   \
>> >        ice_fwlog.o    \
>> >-       ice_debugfs.o
>> >+       ice_debugfs.o  \
>> >+       ice_adapter.o
>> > ice-$(CONFIG_PCI_IOV) +=      \
>> >       ice_sriov.o             \
>> >       ice_virtchnl.o          \
>> >diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>> >index 365c03d1c462..1ffecbdd361a 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice.h
>> >+++ b/drivers/net/ethernet/intel/ice/ice.h
>> >@@ -77,6 +77,7 @@
>> > #include "ice_gnss.h"
>> > #include "ice_irq.h"
>> > #include "ice_dpll.h"
>> >+#include "ice_adapter.h"
>> >
>> > #define ICE_BAR0              0
>> > #define ICE_REQ_DESC_MULTIPLE 32
>> >@@ -544,6 +545,7 @@ struct ice_agg_node {
>> >
>> > struct ice_pf {
>> >       struct pci_dev *pdev;
>> >+      struct ice_adapter *adapter;
>> >
>> >       struct devlink_region *nvm_region;
>> >       struct devlink_region *sram_region;
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> >new file mode 100644
>> >index 000000000000..b93b4db4c04c
>> >--- /dev/null
>> >+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> >@@ -0,0 +1,85 @@
>> >+// SPDX-License-Identifier: GPL-2.0-only
>> >+// SPDX-FileCopyrightText: Copyright Red Hat
>> >+
>> >+#include <linux/cleanup.h>
>> >+#include <linux/mutex.h>
>> >+#include <linux/pci.h>
>> >+#include <linux/slab.h>
>> >+#include <linux/xarray.h>
>> >+#include "ice_adapter.h"
>> >+
>> >+static DEFINE_XARRAY(ice_adapters);
>> >+
>> >+static unsigned long ice_adapter_index(const struct pci_dev *pdev)
>> >+{
>> >+      unsigned int domain = pci_domain_nr(pdev->bus);
>> >+
>> >+      WARN_ON((unsigned long)domain >> (BITS_PER_LONG - 13));
>> >+      return ((unsigned long)domain << 13) |
>> >+             ((unsigned long)pdev->bus->number << 5) |
>> >+             PCI_SLOT(pdev->devfn);
>> >+}
>> >+
>> >+static struct ice_adapter *ice_adapter_new(void)
>> >+{
>> >+      struct ice_adapter *a;
>> >+
>> >+      a = kzalloc(sizeof(*a), GFP_KERNEL);
>> >+      if (!a)
>> >+              return NULL;
>> >+
>> >+      refcount_set(&a->refcount, 1);
>> >+
>> >+      return a;
>> >+}
>> >+
>> >+static void ice_adapter_free(struct ice_adapter *a)
>> >+{
>> >+      kfree(a);
>> >+}
>> >+
>> >+DEFINE_FREE(ice_adapter_free, struct ice_adapter*, if (_T) ice_adapter_free(_T))
>> >+
>> >+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>> >+{
>> >+      struct ice_adapter *ret, __free(ice_adapter_free) *a = NULL;
>> >+      unsigned long index = ice_adapter_index(pdev);
>> >+
>> >+      a = ice_adapter_new();
>>
>> Please consider some non-single-letter variable name.
>
>Alright, I can change the name.
>
>> >+      if (!a)
>> >+              return NULL;
>> >+
>> >+      xa_lock(&ice_adapters);
>> >+      ret = __xa_cmpxchg(&ice_adapters, index, NULL, a, GFP_KERNEL);
>>
>> This is atomic section, can't sleep.
>
>It is not atomic. __xa_cmpxchg releases xa_lock before it allocates
>memory, then reacquires it.

Ah, cool.


>
>> >+      if (xa_is_err(ret)) {
>> >+              ret = NULL;
>>
>> Why don't you propagate err through ERR_PTR() ?
>
>It seemed unnecessary. ENOMEM is the only failure that can possibly
>happen. EINVAL could be returned only if attempting to store an
>unaligned pointer, which won't happen here.

Yeah, the point is that you have valid err, you toss it out, the caller
then does:
	adapter = ice_adapter_get(pdev);
	if (!adapter)
		return -ENOMEM;
And reinvents err. So my point was to propagate it through.



>
>>
>> >+              goto unlock;
>> >+      }
>> >+      if (ret) {
>> >+              refcount_inc(&ret->refcount);
>> >+              goto unlock;
>> >+      }
>> >+      ret = no_free_ptr(a);
>> >+unlock:
>> >+      xa_unlock(&ice_adapters);
>> >+      return ret;
>> >+}
>> >+
>> >+void ice_adapter_put(const struct pci_dev *pdev)
>> >+{
>> >+      unsigned long index = ice_adapter_index(pdev);
>> >+      struct ice_adapter *a;
>> >+
>> >+      xa_lock(&ice_adapters);
>> >+      a = xa_load(&ice_adapters, index);
>> >+      if (WARN_ON(!a))
>> >+              goto unlock;
>> >+
>> >+      if (!refcount_dec_and_test(&a->refcount))
>> >+              goto unlock;
>> >+
>> >+      WARN_ON(__xa_erase(&ice_adapters, index) != a);
>>
>> Nice paranoia level :)
>>
>>
>> >+      ice_adapter_free(a);
>> >+unlock:
>> >+      xa_unlock(&ice_adapters);
>> >+}
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> >new file mode 100644
>> >index 000000000000..cb5a02eb24c1
>> >--- /dev/null
>> >+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> >@@ -0,0 +1,22 @@
>> >+/* SPDX-License-Identifier: GPL-2.0-only */
>> >+/* SPDX-FileCopyrightText: Copyright Red Hat */
>> >+
>> >+#ifndef _ICE_ADAPTER_H_
>> >+#define _ICE_ADAPTER_H_
>> >+
>> >+#include <linux/refcount_types.h>
>> >+
>> >+struct pci_dev;
>> >+
>> >+/**
>> >+ * struct ice_adapter - PCI adapter resources shared across PFs
>> >+ * @refcount: Reference count. struct ice_pf objects hold the references.
>> >+ */
>> >+struct ice_adapter {
>> >+      refcount_t refcount;
>> >+};
>> >+
>> >+struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
>> >+void ice_adapter_put(const struct pci_dev *pdev);
>> >+
>> >+#endif /* _ICE_ADAPTER_H */
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> >index 8f73ba77e835..413219d81a12 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice_main.c
>> >+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> >@@ -5093,6 +5093,7 @@ static int
>> > ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>> > {
>> >       struct device *dev = &pdev->dev;
>> >+      struct ice_adapter *adapter;
>> >       struct ice_pf *pf;
>> >       struct ice_hw *hw;
>> >       int err;
>> >@@ -5145,7 +5146,12 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>> >
>> >       pci_set_master(pdev);
>> >
>> >+      adapter = ice_adapter_get(pdev);
>> >+      if (!adapter)
>> >+              return -ENOMEM;
>> >+
>> >       pf->pdev = pdev;
>> >+      pf->adapter = adapter;
>> >       pci_set_drvdata(pdev, pf);
>> >       set_bit(ICE_DOWN, pf->state);
>> >       /* Disable service task until DOWN bit is cleared */
>> >@@ -5196,6 +5202,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
>> > err_load:
>> >       ice_deinit(pf);
>> > err_init:
>> >+      ice_adapter_put(pdev);
>> >       pci_disable_device(pdev);
>> >       return err;
>> > }
>> >@@ -5302,6 +5309,7 @@ static void ice_remove(struct pci_dev *pdev)
>> >       ice_setup_mc_magic_wake(pf);
>> >       ice_set_wake(pf);
>> >
>> >+      ice_adapter_put(pdev);
>> >       pci_disable_device(pdev);
>> > }
>> >
>> >--
>> >2.43.2
>> >
>>
>

