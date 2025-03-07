Return-Path: <netdev+bounces-172926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A043EA567FF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA56176F05
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2325219302;
	Fri,  7 Mar 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OdZc1+KR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8471215760
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351260; cv=none; b=HiCysucu1rAK7CAl4kj+LtFCOzELEnmbD2bOfX1g4v9AB+g7K8/uN8U6z+K2IFUo+3yAZa2VyPY//ATAhqqiOk6s/bdVuMZTPaVN1ifGQ6kYD6ixYfSSy19fXnALhSuygJ1xxq56cUDrcq0fXpl1vxjqIMHoOSTA7hPPLwj8YWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351260; c=relaxed/simple;
	bh=NcpmAgi35E0JPk6UZnx74O64R9Zxo1w/VBLWGOMDJ8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxm2+xZAtxTbuGlAu5WiqRt6IqlmYG7ioPAMTh2lkFAJLkbd60/JjcGM8MrYvsCsqcuLX+BhEqS4noc+jJec+Danm/S2gXqsEO6LOliswe445d/TSvC9pwLQ48FE9bJFyFauSrpSqJ70G93hgDzk2hAc4LUMrDSbCKjsptYbHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OdZc1+KR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so20237985e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 04:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741351257; x=1741956057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nGhCYAGI5WrAjMfSCPaH4vGX6SRUXUuK9j3IKrjRWY=;
        b=OdZc1+KRAAO+NgVUkAXWa5bxHlqVfuyZxtxP1vOuAIE/s4ES/CMYqRBVhnFqNlhzjO
         mZBhmT7G03g6BezZwvWxtQ59btdAvcFMOXE0IVKu2Yvq3gkgeG2KSh+uBxDkIKqujrtv
         7B3sTpwYyyB5I4S05v7Mz1lhsLZvI/M5FoEnJB2w8KKhddv9AWV84y3C6hIRSA/dsRXK
         ScZlRc3c6/sL7vut4VW02SiyriWkARCYk8jPIswLvIRrHSE8A5M5vhCD+/2k+PoZ7qB8
         MnOlztcJpaZkjru9vMhkJgHf6MgEeyYoqG1Z+1WFeDoBjJ0/iyTnS8EplsG5jLd1bp9v
         hgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741351257; x=1741956057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nGhCYAGI5WrAjMfSCPaH4vGX6SRUXUuK9j3IKrjRWY=;
        b=nKNacWQmUCCG11TenuEUh7AYsV7XPVS97F+0FjSzgcFRbS3Ao9lF3dAYFR0LnFJ7wo
         r9F8kFJ4GEVt+Mfc1Wxw1VzdC/BOHTWTtk+n3kcxxdLbLvehgZALR7OX1xGU37Y/ZpBe
         4ckFgUhEKcAuK9cnclVOkDTsyOHcB1t556HnAUupJBNiPhJhin/vm/JLQzCaw2EbTa9T
         FtAOZrNIquls8gKghFkGn+bwHWdcpGsuETyKhNl9ETIAB4L/UCfIpQIeqJ6oBdw1osDL
         f5plCfYP7ueG4j7y071zXB0gJnMqt2lzeGG1Dt7HE2TFqGrFTEoBxuMIp9ahDfHTGmii
         jtjg==
X-Forwarded-Encrypted: i=1; AJvYcCVNx6TsTDnPEZWSK2Xz42WZBiPgU8vvm9lIU54cM3PMEY2h+xzyJLnCM34gMinsAfWXTnaHT0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5MlSd7y3l6vNeRwiJp1oPnBpg4iK1EtnVqps0PLsjvmadRmw
	Yf1uifS+JcCqdrYzzsuMNgSHs9efhfJ2S+nIgxGdFFXwbx4q+OSzYvRg5+TNjPs=
X-Gm-Gg: ASbGncvWgfJbZjuolisWa7oDYQ2a6g/vAR3Bl1+W3WEVhzWLHQz4SA0rOPktkwHk4Pn
	EnHQeuyXFB3HTi6ulU7hygEY5FwWk/MVDRJyLiWUMFviVrkdIqJmnz0NSVLiz7Lkuh0Vq2CqqD5
	3sMNvn73tdiZxiM2EzNlIxyuq4T1G4xM1MAUZXOiB4eCmH7PDsJ1PPzj/yLnqlniGL3ApKBI6bV
	w1Xk8KtisAdZYH4LQ8WjdBkCk2dL6AfOKb3DaoVawvvh5n596GqLhgBW0OHLxlFvUUfJfldEf2i
	l4J8HX5x45wU0fbD7JIjk48fhHovYj43a6t42VwU2A4cAL/9o0jhCr7/m2qiNnUbGZuSWBc=
X-Google-Smtp-Source: AGHT+IHwy26XZuyfyXGzpCxnGPSO4xxd3jD+CcFND82dAITnC2g11Nui5sQcKS4dw6ZFLY1BkWDqXA==
X-Received: by 2002:a05:6000:1849:b0:391:158f:3d59 with SMTP id ffacd0b85a97d-39132d21141mr2984080f8f.15.1741351257010;
        Fri, 07 Mar 2025 04:40:57 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79cfsm5270772f8f.10.2025.03.07.04.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:40:56 -0800 (PST)
Date: Fri, 7 Mar 2025 13:40:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Karol Kolacinski <karol.kolacinski@intel.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapter
 index
Message-ID: <vt6wnwcje727xv4agzhkpe5ympcvhtgg7qbaq4hlvw42roji2r@3kwjm4togc7m>
References: <20250306211159.3697-2-przemyslaw.kitszel@intel.com>
 <28792ae2-bee7-48c9-af5d-2e1ba199558a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28792ae2-bee7-48c9-af5d-2e1ba199558a@intel.com>

Fri, Mar 07, 2025 at 12:53:05AM +0100, jacob.e.keller@intel.com wrote:
>
>
>On 3/6/2025 1:11 PM, Przemek Kitszel wrote:
>> Use Device Serial Number instead of PCI bus/device/function for
>> index of struct ice_adapter.
>> Functions on the same physical device should point to the very same
>> ice_adapter instance.
>> 
>> This is not only simplification, but also fixes things up when PF
>> is passed to VM (and thus has a random BDF).
>> 
>> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Suggested-by: Jiri Pirko <jiri@resnulli.us>
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>
>The only caution I have here is that we might run into issues with
>pre-production or poorly flashed boards which don't have DSN properly
>flashed. This shouldn't be an impact outside of early testing or
>mistakes by devs. I think there is a default ID which is almost all 0s
>we could check and log a warning to help prevent confusion in such a case?
>
>A couple systems I've seen have serial numbers like:
>
>  serial_number 00-00-00-00-00-00-00-00
>  serial_number 00-00-00-00-00-00-00-00
>
>or
>
>  serial_number 00-01-00-ff-ff-00-00-00
>  serial_number 00-01-00-ff-ff-00-00-00
>
>
>In practice I'm not sure how big a deal breaker this is. Properly
>initialized boards should have unique IDs, and if you update via
>devlink, or any of our standard update tools, it will maintain the ID
>across flash. However, during early development, boards were often
>flashed manually which could lead to such non-unique IDs.

Do we need a workaround for pre-production buggy hw now? Sounds a bit
weird tbh.


>
>> CC: Karol Kolacinski <karol.kolacinski@intel.com>
>> CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
>> CC: Michal Schmidt <mschmidt@redhat.com>
>> CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_adapter.h |  4 +--
>>  drivers/net/ethernet/intel/ice/ice_adapter.c | 29 +++-----------------
>>  2 files changed, 6 insertions(+), 27 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> index e233225848b3..1935163bd32f 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
>> @@ -42,7 +42,7 @@ struct ice_adapter {
>>  	struct ice_port_list ports;
>>  };
>>  
>> -struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
>> -void ice_adapter_put(const struct pci_dev *pdev);
>> +struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
>> +void ice_adapter_put(struct pci_dev *pdev);
>>  
>>  #endif /* _ICE_ADAPTER_H */
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> index 01a08cfd0090..b668339ed0ef 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
>> @@ -1,7 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  // SPDX-FileCopyrightText: Copyright Red Hat
>>  
>> -#include <linux/bitfield.h>
>>  #include <linux/cleanup.h>
>>  #include <linux/mutex.h>
>>  #include <linux/pci.h>
>> @@ -14,29 +13,9 @@
>>  static DEFINE_XARRAY(ice_adapters);
>>  static DEFINE_MUTEX(ice_adapters_mutex);
>>  
>> -/* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
>> -#define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
>> -#define INDEX_FIELD_DEV    GENMASK(31, 16)
>> -#define INDEX_FIELD_BUS    GENMASK(12, 5)
>> -#define INDEX_FIELD_SLOT   GENMASK(4, 0)
>> -
>> -static unsigned long ice_adapter_index(const struct pci_dev *pdev)
>> +static unsigned long ice_adapter_index(struct pci_dev *pdev)
>>  {
>> -	unsigned int domain = pci_domain_nr(pdev->bus);
>> -
>> -	WARN_ON(domain > FIELD_MAX(INDEX_FIELD_DOMAIN));
>> -
>> -	switch (pdev->device) {
>> -	case ICE_DEV_ID_E825C_BACKPLANE:
>> -	case ICE_DEV_ID_E825C_QSFP:
>> -	case ICE_DEV_ID_E825C_SFP:
>> -	case ICE_DEV_ID_E825C_SGMII:
>> -		return FIELD_PREP(INDEX_FIELD_DEV, pdev->device);
>> -	default:
>> -		return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
>> -		       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
>> -		       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
>> -	}
>> +	return (unsigned long)pci_get_dsn(pdev);
>
>Much simpler :D
>
>>  }
>>  
>>  static struct ice_adapter *ice_adapter_new(void)
>> @@ -77,7 +56,7 @@ static void ice_adapter_free(struct ice_adapter *adapter)
>>   * Return:  Pointer to ice_adapter on success.
>>   *          ERR_PTR() on error. -ENOMEM is the only possible error.
>>   */
>> -struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>> +struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
>>  {
>>  	unsigned long index = ice_adapter_index(pdev);
>>  	struct ice_adapter *adapter;
>> @@ -110,7 +89,7 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
>>   *
>>   * Context: Process, may sleep.
>>   */
>> -void ice_adapter_put(const struct pci_dev *pdev)
>> +void ice_adapter_put(struct pci_dev *pdev)
>>  {
>
>A bit of a shame that this needs to be non const now.. Could
>pci_get_dsn() be made const? Or does it do something which might modify
>the device somehow?

Would make sense to me to make it const.


>
>>  	unsigned long index = ice_adapter_index(pdev);
>>  	struct ice_adapter *adapter;
>

