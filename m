Return-Path: <netdev+bounces-172924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769FA567F5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491B5176FEC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26092192EF;
	Fri,  7 Mar 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E9EAOCFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420C14A4F9
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351161; cv=none; b=O+J1OYIYpBqXfF6IDmjVCegIL4AytOu1CENMpf6sjXdl845OOIFocH95R2NRd0661SOE5lR3sW2JdjX1RvYnv5cQ2/grUxsNPm4Dnnr8vklMoYI63cLsMo3VCd+114f/hcCihZIQ06EqTU1tYyWReY8x+hG1OsEjYUdJHT4ok0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351161; c=relaxed/simple;
	bh=uzpMeolekPd1ue0ce1ACSTRST7iSPBPs5Hao2bqtEfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW/UJ0/SVtZxtaUmuwEENy18Hiq2mk1ZePMNi1bblbAiIKriKxajmfELwjF1GQl0vev6QUHVBAw+GQ6H+9pX9tEidh21epmRGvjwHR3hOmnGjc/GyUBCsRuyqOV+gCNAhTyoF5oMuRAebhevCpFwfcyKxO46o0o/dFIE/ujINIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E9EAOCFk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f403edb4eso989566f8f.3
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741351157; x=1741955957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLxjmjLkVRGspcnvhP5Tie8EHIy+vTThaMLWJT47qSg=;
        b=E9EAOCFkxpocyvHp0AvMSbAq457qxTZBFRhg2E01MdDmLnEV/9k1GQLkiks77q64DF
         r0JK5tG0G0bqga06QbCmYTfXVW7YngBrRphBeGMIiX/cQdMtkIm6Yu8urHr0lWe1JFS2
         E7a60rztpUGptkeqCJa5l/lTXHGY041KJrRe1pdmktvpwI62uCe+QAJjJnLkKS91kCwP
         l3IBCewQr/CRvYrLfR3V2x7Nsoum6CWpMHD1socNvHlbbSrLgr+AB/Kdv62DXkCqtgRv
         DuFDi8TNTNUALlD7RO9hS9tLs/Vub61prSLD+EuZvgh8yTcv680M/9V5zYQo40VjbjVE
         fE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741351157; x=1741955957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLxjmjLkVRGspcnvhP5Tie8EHIy+vTThaMLWJT47qSg=;
        b=vE65cHtT/Gp2ypjEmW34Qiw9U4XvYmkDP/M1s3AploKERqnxLVL8FjTi6ocuXo7Q8R
         yrfmThB0hkVuYL73v6I4S/2ApP2zRixcMfGYPM2UlsJyIPqhz/OmdeiIYG/Pfg5JFw/m
         vVhKqYhprZlyHTF37QvYaFNUGNb0WBnWDyv6wsXBqYdUWDDt4niiwoNQtjK/sckdP1MJ
         /PlVztwqurBSVIDJdudgZps9dAK4Owk6nZIWrQej2Us2mC/KRzKVGQPHo/4kIveTCuj7
         2Dvzi3YbNOR0YhWIadFXqGTvoxqNMPwNFGk5Xs8GAUbfbUXo0DKsG11hJsUzFYoooVwB
         pz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmauFDcXyEX5SaZbGv1lfvFI++HAydG2FDMmfa3dujCvqK4y6iqV0ClDXDdEIuvZ6bk9Lg9Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSTFWydHarWLpRd9H8b7RO6JJ/woP2NeEPTgKf3lnVdD9sYZJ
	OaR4IypAlKLimS63lDkTsImHQ1FTVSmABpB2wCrgv8ZLjnJBzTVovzw3CMs5ICo=
X-Gm-Gg: ASbGncvdJtqtKI9DkkSLKUrpzZR8AbEpRHCXB1hIPnblGw/8hIE4I8CSY2r4w2LRcEH
	1i4oGWXJLF+yiDYqKede/hsXiXYt7vbiL7Fc49XEHfTIf/sr26oHPv7L6ePE+QWEyd+jKSjdpjG
	I6SHFgk+X4YyBVNnWYGVol10L3F3YK8x3taTfQL7zGwDrLlAAntA9orcRNbMiQr0bCfdORqjh/q
	9dt13DctvGuvWoOqAXYcUgB8dg7477RokAQrVQn9iJE5092HTaB7cRJGvdsGKMTf3vVPKdCXFZ3
	0NAhWEwfKglg/0XS4c0jIkQykvvGnaneJdw4FU/9v2X/kpOHnMAzmK5XWyM928Er/xONEXo=
X-Google-Smtp-Source: AGHT+IHR5/bjxcOF4ghKK6eX06+rvtgu0QOh/X6knPpArqGexZx3AqXE2S2EqJKr184Vp250Aioa1g==
X-Received: by 2002:a05:6000:1fa9:b0:391:31f2:b998 with SMTP id ffacd0b85a97d-39132d16fdcmr2109600f8f.6.1741351156730;
        Fri, 07 Mar 2025 04:39:16 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfa52sm5104218f8f.21.2025.03.07.04.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:39:16 -0800 (PST)
Date: Fri, 7 Mar 2025 13:39:10 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapter
 index
Message-ID: <pcmfqg3b5wg4cyzzjrpw23c6dwan62567vakbgnmto3khbwysk@dloxz3hqifdf>
References: <20250306211159.3697-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306211159.3697-2-przemyslaw.kitszel@intel.com>

Thu, Mar 06, 2025 at 10:11:46PM +0100, przemyslaw.kitszel@intel.com wrote:
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

From my perspective, this is a bug fix, makes sense to me to send to
-net tree.


>---
>CC: Karol Kolacinski <karol.kolacinski@intel.com>
>CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
>CC: Michal Schmidt <mschmidt@redhat.com>
>CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_adapter.h |  4 +--
> drivers/net/ethernet/intel/ice/ice_adapter.c | 29 +++-----------------
> 2 files changed, 6 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>index e233225848b3..1935163bd32f 100644
>--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>@@ -42,7 +42,7 @@ struct ice_adapter {
> 	struct ice_port_list ports;
> };
> 
>-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
>-void ice_adapter_put(const struct pci_dev *pdev);
>+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
>+void ice_adapter_put(struct pci_dev *pdev);
> 
> #endif /* _ICE_ADAPTER_H */
>diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
>index 01a08cfd0090..b668339ed0ef 100644
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
>@@ -14,29 +13,9 @@
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
>+static unsigned long ice_adapter_index(struct pci_dev *pdev)
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
>+	return (unsigned long)pci_get_dsn(pdev);

How do you ensure there is no xarray index collision then you
cut the number like this?


> }
> 
> static struct ice_adapter *ice_adapter_new(void)
>@@ -77,7 +56,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
>  * Return:  Pointer to ice_adapter on success.
>  *          ERR_PTR() on error. -ENOMEM is the only possible error.
>  */
>-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
> {
> 	unsigned long index = ice_adapter_index(pdev);
> 	struct ice_adapter *adapter;
>@@ -110,7 +89,7 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>  *
>  * Context: Process, may sleep.
>  */
>-void ice_adapter_put(const struct pci_dev *pdev)
>+void ice_adapter_put(struct pci_dev *pdev)
> {
> 	unsigned long index = ice_adapter_index(pdev);
> 	struct ice_adapter *adapter;
>-- 
>2.46.0
>

