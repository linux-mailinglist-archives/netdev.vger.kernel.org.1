Return-Path: <netdev+bounces-179609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A91A7DD1C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F714170984
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40B32459D0;
	Mon,  7 Apr 2025 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="P8dLPxPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077432459D1
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744027425; cv=none; b=moBtwiYsFKdRtxTfWxugPqkwXk3H3IhpPDxtKO7TkuEFhCvFkkeIuqdHO172ys+eh1/p4pGUYrM6N/XbTzSjnXdUT8Li0+kelOzRAzxzdqqJlzn58HyfBUzE7MHAhD/qvd3rIx4x0s9bkVuVY2UKT66aRXogY+hXh2zEgB9LnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744027425; c=relaxed/simple;
	bh=n7qyY/GiwTXfru8RNW+LsmkzAkJ97ZMOkdcaARh8Ipk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXFcg1wZCEGQm7lmY9n23oyPaAPqUKYrWxCCNRLPXgHJS1Ulnl4gMeOTI9UYASre5wsZePv22aAtFLJvs68oRy7z6B3dnhmZOWNtU6Q2ENuNmkq9OgdAp4E4uw0wprOBRNDgJBhqjpjFhD1rnYUe4urDYwuqd+GHw0602jVcNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=P8dLPxPZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso42549465e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744027421; x=1744632221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C12lql4gahPwXCUXebElvygf5+dGXZFoZDJkgABwuxw=;
        b=P8dLPxPZDDGmSGHT00nLTXSDBuNxgh4Q5lrImhwDUrL2p5/zOqLuTVLct5WLY2ZUQe
         BTdsY9JgJ9VFCfhldN1piahKSA6tzIS68OAEF+BdWRXdQAj5HHfRcBWVpUbs4lNo1UJk
         cZA37mja71Uj47to5Le7IVa7OjcDNwiJ9cTdHcraraiYfpbDVfiV5eI7+nKDSuWf8zWM
         Nzyt0OHRjwBnGYNgRyqm4gTUP0j9bS4halBDonga+hKozDLtPBvjSe4Ot8iyl6VN/I+n
         fS5q+vvXmTeYmodN1YyTOuUSoWcdzTinGlypQO6ZccwYej6xvLDKRFyQ+R61+y5IB3b9
         DNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744027421; x=1744632221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C12lql4gahPwXCUXebElvygf5+dGXZFoZDJkgABwuxw=;
        b=MJuyi4gSxIkA+pFrIdDezn/3ansC/2J04PI0JG05Iox6a+n6mo/nVMDg5Wg4mly57O
         b54BpFRKAyMojbZEePMDfTO+/vmlUhdmtfzz5DycOw8RYO+haQKk5k9DS+y5iwvH8cbH
         qAMPBbII3nR9MVABVG5+Ob/8AwsgPLEPMrxQHxuRrn6LBuhMTKImY3q4dYpTPo6dHssr
         2Uee2jonvbYvcYihCRxSlMuRp3e3dKBMaW2WvNAaW7O2iWCKWH4SRRPjQ6UbHU3tYBDW
         zwSRtZP8MbRN6/Ek4C7Bc2ODmJCjsQVCkKbwX8d+4FAwW1vsb1ysNhDVeWEntIujON/R
         4jkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqcFNV0HjHRCBF1/M1bqVfSkiHRf5FJehGvmBqYu5NIR41Q1z6pGJO/5SCVBVZnmacQHi7Y9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lXbU2uPNsLx6UWfEzyE5c6KGvldf6iz2kWAh0M+rWpRvhj53
	gJDjNjEOwpmYd80sO4WsVNDg8+Owzt+BPFU33KGs1YHj/EUCGeedpVw5/EM4+8E=
X-Gm-Gg: ASbGncsOWz9luHnM5cYJHHWeYfz7GlyNn8THknapfun7LkD5WRwSfHs4JaodX9yRJ1y
	J43b0ggwn+KtF9vbeve1rYlftB3f6NKCfyZrUiAhPfGbKLycMGXUYUVWuPJu3TfK4UBuvkTuvaO
	Rc1QAtEuWhs2e7k7iLuuLK4k1XtroQ2ra3Cy40RL0Cham5HW9fK6sKNY7+v71aNrDOi3mgaon/K
	TEGQb5msMvskHE4a7xufmJTE5Si1c5yh403CIGeRaQz4RT79Ke+VeJAeNY7QnpC+jd10X/EH5Wu
	1czJzFzlP1+e2hJ8s0R6dYMIEaiEW3GC9pyfjrKNHmB0ClJAomPx
X-Google-Smtp-Source: AGHT+IELXe9d7cJXM5xrxldV23WqITZfBAhRcUkgK50uOVSxKr87JLfKlxqrzPPTtf0xmaWE47z2ag==
X-Received: by 2002:a05:600c:35d6:b0:43c:f6b0:e807 with SMTP id 5b1f17b1804b1-43ed0db3b8emr90104625e9.31.1744027420756;
        Mon, 07 Apr 2025 05:03:40 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364c959sm127278765e9.25.2025.04.07.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 05:03:40 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:03:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: use DSN instead of PCI BDF for
 ice_adapter index
Message-ID: <umik2eecoutyaf666hy3h2g2bbbchvfb7veqwrcqkb6aevntxz@yhslcltafqxy>
References: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>

Mon, Apr 07, 2025 at 01:20:05PM +0200, przemyslaw.kitszel@intel.com wrote:
>Use Device Serial Number instead of PCI bus/device/function for
>index of struct ice_adapter.
>Functions on the same physical device should point to the very same
>ice_adapter instance.
>
>This is not only simplification, but also fixes things up when PF
>is passed to VM (and thus has a random BDF).
>
>Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
>CC: Karol Kolacinski <karol.kolacinski@intel.com>
>CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
>CC: Michal Schmidt <mschmidt@redhat.com>
>CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>
>v2:
> - target to -net (Jiri)
> - mix both halves of u64 DSN on 32bit systems (Jiri)
> - (no changes in terms of fallbacks for pre-prod HW)
> - warn when there is DSN collision after reducing to 32bit
>
>v1:
>https://lore.kernel.org/netdev/20250306211159.3697-2-przemyslaw.kitszel@intel.com
>---
> drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++-
> drivers/net/ethernet/intel/ice/ice_adapter.c | 43 ++++++++------------
> 2 files changed, 20 insertions(+), 29 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>index e233225848b3..ac15c0d2bc1a 100644
>--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>@@ -32,17 +32,19 @@ struct ice_port_list {
>  * @refcount: Reference count. struct ice_pf objects hold the references.
>  * @ctrl_pf: Control PF of the adapter
>  * @ports: Ports list
>+ * @device_serial_number: DSN cached for collision detection on 32bit systems
>  */
> struct ice_adapter {
> 	refcount_t refcount;
> 	/* For access to the GLTSYN_TIME register */
> 	spinlock_t ptp_gltsyn_time_lock;
> 
> 	struct ice_pf *ctrl_pf;
> 	struct ice_port_list ports;
>+	u64 device_serial_number;
> };
> 
>-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
>-void ice_adapter_put(const struct pci_dev *pdev);
>+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
>+void ice_adapter_put(struct pci_dev *pdev);
> 
> #endif /* _ICE_ADAPTER_H */
>diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
>index 01a08cfd0090..3df3fa6d5129 100644
>--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
>+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>@@ -1,7 +1,6 @@
> // SPDX-License-Identifier: GPL-2.0-only
> // SPDX-FileCopyrightText: Copyright Red Hat
> 
>-#include <linux/bitfield.h>
> #include <linux/cleanup.h>
> #include <linux/mutex.h>
> #include <linux/pci.h>
>@@ -14,29 +13,13 @@
> static DEFINE_XARRAY(ice_adapters);
> static DEFINE_MUTEX(ice_adapters_mutex);
> 
>-/* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
>-#define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
>-#define INDEX_FIELD_DEV    GENMASK(31, 16)
>-#define INDEX_FIELD_BUS    GENMASK(12, 5)
>-#define INDEX_FIELD_SLOT   GENMASK(4, 0)
>-
>-static unsigned long ice_adapter_index(const struct pci_dev *pdev)
>+static unsigned long ice_adapter_index(u64 dsn)
> {
>-	unsigned int domain = pci_domain_nr(pdev->bus);
>-
>-	WARN_ON(domain > FIELD_MAX(INDEX_FIELD_DOMAIN));
>-
>-	switch (pdev->device) {
>-	case ICE_DEV_ID_E825C_BACKPLANE:
>-	case ICE_DEV_ID_E825C_QSFP:
>-	case ICE_DEV_ID_E825C_SFP:
>-	case ICE_DEV_ID_E825C_SGMII:
>-		return FIELD_PREP(INDEX_FIELD_DEV, pdev->device);
>-	default:
>-		return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
>-		       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
>-		       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
>-	}
>+#if BITS_PER_LONG == 64
>+	return dsn;
>+#else
>+	return (u32)dsn ^ u32(dsn >> 32);
>+#endif
> }
> 
> static struct ice_adapter *ice_adapter_new(void)
>@@ -77,25 +60,29 @@ static void ice_adapter_free(struct ice_adapter *adapter)
>  * Return:  Pointer to ice_adapter on success.
>  *          ERR_PTR() on error. -ENOMEM is the only possible error.
>  */
>-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
> {
>-	unsigned long index = ice_adapter_index(pdev);
>+	u64 dsn = pci_get_dsn(pdev);
> 	struct ice_adapter *adapter;
>+	unsigned long index;
> 	int err;
> 
>+	index = ice_adapter_index(dsn);
> 	scoped_guard(mutex, &ice_adapters_mutex) {
> 		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
> 		if (err == -EBUSY) {
> 			adapter = xa_load(&ice_adapters, index);
> 			refcount_inc(&adapter->refcount);
>+			WARN_ON_ONCE(adapter->device_serial_number != dsn);

Warn and done? How unlikely is this? I mean, can this happen in real
world? If yes, that's a bug.


> 			return adapter;
> 		}
> 		if (err)
> 			return ERR_PTR(err);
> 
> 		adapter = ice_adapter_new();
> 		if (!adapter)
> 			return ERR_PTR(-ENOMEM);
>+		adapter->device_serial_number = dsn;
> 		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
> 	}
> 	return adapter;
>@@ -110,11 +97,13 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>  *
>  * Context: Process, may sleep.
>  */
>-void ice_adapter_put(const struct pci_dev *pdev)
>+void ice_adapter_put(struct pci_dev *pdev)
> {
>-	unsigned long index = ice_adapter_index(pdev);
>+	u64 dsn = pci_get_dsn(pdev);
> 	struct ice_adapter *adapter;
>+	unsigned long index;
> 
>+	index = ice_adapter_index(dsn);
> 	scoped_guard(mutex, &ice_adapters_mutex) {
> 		adapter = xa_load(&ice_adapters, index);
> 		if (WARN_ON(!adapter))
>-- 
>2.39.3
>

