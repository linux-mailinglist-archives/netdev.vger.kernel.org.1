Return-Path: <netdev+bounces-90498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36BE8AE435
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE51F23AB3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1927D3E6;
	Tue, 23 Apr 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bxEhfyBU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A167E58E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872176; cv=none; b=lBmT0WuLrjMvan7pgi1RDsxeSkA9jPKOD+LuLP87EHjcw6I6gGXDh18JmGFUnFjO/tB0j24MW2Cxo1u0+mSrYbE24uy2RhMPoBi/o45BtjDrocoyhyertiqaR2wlUK/T2rcdc8DvbJvxeqzZQeh5jQYnJ7pWdcFUdQSunPUb2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872176; c=relaxed/simple;
	bh=g4HxkbWRf/wFFb37gFeUn77ZFn6cGQgjBo4S2VI2b30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrD9FyhlmwcITlp4nOpE7FzSRzyIHByoy2LsH/VukY0Edio+EdshoUbccp9BPgusWOcD3lTfT5IAAdg9h2qwKCV6LacuEzythmhjtqBrdVLw2Y/QRHohdybR1WaJzdFyAoR52tobbN2jrHN9yKoD91Yl2tcQrk0BYG1HWbBIK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bxEhfyBU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34b3374ae22so1737712f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713872172; x=1714476972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g091F/VKooEbYguAt7Cvz6uTsihB1SGK2UMZc+jetYo=;
        b=bxEhfyBUitLUB5J2FeYjjnBHocT9Bm/QtLB4+M6FlOvNXufOQ5JAjuiZy/51AV7tLu
         5iKzyNVuUS9AtHj29Ky5N5U/xTg53IBc6/ET4yct+GGG4ERlHP/yufDLKaSVM83Pi/8R
         kXMtE65F9VcRLeQ6lEwIhRxFdP6FD9HbpKru2zdelBGd285J6zrUY3r2xKBJ39RfWLnR
         e3OxqVKBBIGj6uiQ3dcN0ayI4WEi3xx6luj75JHig+4aPsVqTAUvN5ULreMurGV28U0V
         T2CtXj50Ya/8eNfkUu9UJPbvl98k+Uhr7Jw2qP7MYtdG+WiCUlV0nOFOCcv5VJE1Weom
         Rvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872172; x=1714476972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g091F/VKooEbYguAt7Cvz6uTsihB1SGK2UMZc+jetYo=;
        b=r0SVXSjv374sA8LqhLOoFX0HDPEJtrXYV9uL8F5NQojBtf2D7lb+Ty+sjvd9urNVZP
         SS/9HWv2IVjpIUnRL49rla+nWjOJMYbPxAMuslol6f9yoczoIG6QgO9jSosXU8TzceFC
         5VWWy3iADnD+j/kkkVy/vT8pjEZD/Wk4GCJbw/9nZvjIFIxQW9/lkti4pHbVn9xEJd31
         3lIG2rA7FwS6aaVdqe1q2M9tSSI1ZyjVDFlV4q1cYu1TmUhqMC28H7pzgnKrNBrZcqw6
         7SamCDMMTHJOAnrGV5f94IFhbpvqWB0G1b2ciwSwfJ90SViO9DYXY7T1q9+GWDsyZP4U
         mAtA==
X-Forwarded-Encrypted: i=1; AJvYcCUnEya+aFQbQz2/MfjKGuGsWvkJdwP4nmA//SsGNs5NFTEQzJ/nVGm3JgJxjVqx7ddJfcmTdVNAEVew9c5UhSvj6edhqvwD
X-Gm-Message-State: AOJu0YziFopr6/SK5sPQresFjmK1bmbSCXer/yGGoRttYUastuQuA+Di
	cB2m0VduzQ+Pgwm5Oum8kCNydHuomxsuEhZol2tBi8kKPHD8gQySIjc/Gko+IIo=
X-Google-Smtp-Source: AGHT+IFQaenGmOBS3pMB8p8zemMT7GSGJ6twIy6fo2ad+My14WM1DJGYWP33egD6XuSokuhY3cRiDw==
X-Received: by 2002:a5d:494f:0:b0:34b:e68:dcf0 with SMTP id r15-20020a5d494f000000b0034b0e68dcf0mr4521063wrs.59.1713872172082;
        Tue, 23 Apr 2024 04:36:12 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id w25-20020a1709060a1900b00a4e40e48f8dsm6913337ejf.185.2024.04.23.04.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:36:11 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:36:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2] ice: Extend auxbus device naming
Message-ID: <ZiedKc5wE2-3LlaM@nanopsycho>
References: <20240423091459.72216-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423091459.72216-1-sergey.temerkhanov@intel.com>

Tue, Apr 23, 2024 at 11:14:59AM CEST, sergey.temerkhanov@intel.com wrote:
>Include segment/domain number in the device name to distinguish
>between PCI devices located on different root complexes in
>multi-segment configurations. Naming is changed from
>ptp_<bus>_<slot>_clk<clock>  to ptp_<domain>_<bus>_<slot>_clk<clock>

I don't understand why you need to encode pci properties of a parent
device into the auxiliary bus name. Could you please explain the
motivation? Why you need a bus instance per PF?

The rest of the auxbus registrators don't do this. Could you please
align? Just have one bus for ice driver and that's it.


>
>v1->v2
>Rebase on top of the latest changes
>
>Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_ptp.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>index 402436b72322..744b102f7636 100644
>--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>@@ -2993,8 +2993,9 @@ ice_ptp_auxbus_create_id_table(struct ice_pf *pf, const char *name)
> static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
> {
> 	struct auxiliary_driver *aux_driver;
>+	struct pci_dev *pdev = pf->pdev;
> 	struct ice_ptp *ptp;
>-	char busdev[8] = {};
>+	char busdev[16] = {};
> 	struct device *dev;
> 	char *name;
> 	int err;
>@@ -3005,8 +3006,10 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
> 	INIT_LIST_HEAD(&ptp->ports_owner.ports);
> 	mutex_init(&ptp->ports_owner.lock);
> 	if (ice_is_e810(&pf->hw))
>-		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
>-			PCI_SLOT(pf->pdev->devfn));
>+		snprintf(busdev, sizeof(busdev), "%u_%u_%u_",
>+			 pci_domain_nr(pdev->bus),
>+			 pdev->bus->number,
>+			 PCI_SLOT(pdev->devfn));
> 	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
> 			      ice_get_ptp_src_clock_index(&pf->hw));
> 	if (!name)
>@@ -3210,8 +3213,9 @@ static void ice_ptp_release_auxbus_device(struct device *dev)
> static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
> {
> 	struct auxiliary_device *aux_dev;
>+	struct pci_dev *pdev = pf->pdev;
> 	struct ice_ptp *ptp;
>-	char busdev[8] = {};
>+	char busdev[16] = {};
> 	struct device *dev;
> 	char *name;
> 	int err;
>@@ -3224,8 +3228,10 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
> 	aux_dev = &ptp->port.aux_dev;
> 
> 	if (ice_is_e810(&pf->hw))
>-		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
>-			PCI_SLOT(pf->pdev->devfn));
>+		snprintf(busdev, sizeof(busdev), "%u_%u_%u_",
>+			 pci_domain_nr(pdev->bus),
>+			 pdev->bus->number,
>+			 PCI_SLOT(pdev->devfn));
> 
> 	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
> 			      ice_get_ptp_src_clock_index(&pf->hw));
>-- 
>2.35.3
>
>

