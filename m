Return-Path: <netdev+bounces-104538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF890D1C6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27421C24089
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F571A38D8;
	Tue, 18 Jun 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c58MSbyi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA221A38D3
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716420; cv=none; b=iaDfEarQapuVTFi/JWhZwrNTStfYWZS6myGrJlnnvpiaUzu5F6N7s4B9w+0Kny0agmRz1KFkxBQ3MJkp2gZzZXpYzcg6YLCRF1rbZAL30c43zKsJdyyIM0InTTyIgqC1XMFL1MDKJFQi9qfbfwP02T1Z+gskbfPHrte/Pp2shts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716420; c=relaxed/simple;
	bh=mO2QGWWZEQkeF17glX5EMNafQm8uj79+05PgpCNDOL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvytWaNN9YVuCS1Hq4ZxIeoKXANwRfRDKSVIYMyBlxfV1Bx7Zi9WKfGm3Nz4CvstEYgjrg8Bd4MyPjQaZKQvViME5s3q8Mq5hkno8Lg9vlqwQjUhyhsdrnSvcQs8CeAuSfkVaSvQy57y/XV9Kg7RdBc/T+WuSnL9kSsOniEtnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c58MSbyi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718716420; x=1750252420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mO2QGWWZEQkeF17glX5EMNafQm8uj79+05PgpCNDOL4=;
  b=c58MSbyi1H+owsZd2lXDndoFaq/bjv2+ru79pK0CrUkUmeT9iLzC1buY
   XrdSNWtCPqI9DglaLQMXBFe5jYRfJp+85Fmduyu8KMpM7yGaCdFaFQgzi
   Q3RzM1M2EwDUincgZ3VwIZTLH4LtnxJAl30tDA0ltN32E+d+FbwtYEHst
   kDVBJtUW9X7BHNvzfsaSct6oJ7s0ezCmPqMRnhC2tQ2Y/zgpN+4OqSYKv
   PWWNrxOrnXnaty7vr5Yss5/vLKcTQuQlHH20AUwRj+V7Cykw1kL8qrN0m
   OuhJA4gKVJfQ5BSqiJD0ZxY3QXsvtSoojdGfWwA08SkYcLoR32ev0v9/h
   w==;
X-CSE-ConnectionGUID: lgu77CnJSFCKrrLJ6pj3Og==
X-CSE-MsgGUID: Ph3G4JznRSmb3lgg41RZjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15560442"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15560442"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:13:39 -0700
X-CSE-ConnectionGUID: nScKp50jQVCzeM+HeARI3g==
X-CSE-MsgGUID: BsM4mVaVRSugUI/E2qX6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46668338"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2024 06:13:37 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC PATCH iwl-next v1 4/4] ice: Drop auxbus use for PTP to finalize ice_adapter move
Date: Tue, 18 Jun 2024 15:12:08 +0200
Message-ID: <20240618131208.6971-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618131208.6971-1-sergey.temerkhanov@intel.com>
References: <20240618131208.6971-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Drop unused auxbus/auxdev support from the PTP code due to
move to the ice_adapter.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 265 -----------------------
 1 file changed, 265 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index acabd84d6d52..6f1fd11f9249 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2880,189 +2880,6 @@ static void ice_ptp_cleanup_pf(struct ice_pf *pf)
 		mutex_unlock(&pf->adapter->ports.lock);
 	}
 }
-/**
- * ice_ptp_aux_dev_to_aux_pf - Get auxiliary PF handle for the auxiliary device
- * @aux_dev: auxiliary device to get the auxiliary PF for
- */
-static struct ice_pf *
-ice_ptp_aux_dev_to_aux_pf(struct auxiliary_device *aux_dev)
-{
-	struct ice_ptp_port *aux_port;
-	struct ice_ptp *aux_ptp;
-
-	aux_port = container_of(aux_dev, struct ice_ptp_port, aux_dev);
-	aux_ptp = container_of(aux_port, struct ice_ptp, port);
-
-	return container_of(aux_ptp, struct ice_pf, ptp);
-}
-
-/**
- * ice_ptp_aux_dev_to_owner_pf - Get PF handle for the auxiliary device
- * @aux_dev: auxiliary device to get the PF for
- */
-static struct ice_pf *
-ice_ptp_aux_dev_to_owner_pf(struct auxiliary_device *aux_dev)
-{
-	struct ice_ptp_port_owner *ports_owner;
-	struct auxiliary_driver *aux_drv;
-	struct ice_ptp *owner_ptp;
-
-	if (!aux_dev->dev.driver)
-		return NULL;
-
-	aux_drv = to_auxiliary_drv(aux_dev->dev.driver);
-	ports_owner = container_of(aux_drv, struct ice_ptp_port_owner,
-				   aux_driver);
-	owner_ptp = container_of(ports_owner, struct ice_ptp, ports_owner);
-	return container_of(owner_ptp, struct ice_pf, ptp);
-}
-
-/**
- * ice_ptp_auxbus_probe - Probe auxiliary devices
- * @aux_dev: PF's auxiliary device
- * @id: Auxiliary device ID
- */
-static int ice_ptp_auxbus_probe(struct auxiliary_device *aux_dev,
-				const struct auxiliary_device_id *id)
-{
-	struct ice_pf *owner_pf = ice_ptp_aux_dev_to_owner_pf(aux_dev);
-	struct ice_pf *aux_pf = ice_ptp_aux_dev_to_aux_pf(aux_dev);
-
-	if (WARN_ON(!owner_pf))
-		return -ENODEV;
-
-	INIT_LIST_HEAD(&aux_pf->ptp.port.list_member);
-	mutex_lock(&owner_pf->ptp.ports_owner.lock);
-	list_add(&aux_pf->ptp.port.list_member,
-		 &owner_pf->ptp.ports_owner.ports);
-	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
-
-	return 0;
-}
-
-/**
- * ice_ptp_auxbus_remove - Remove auxiliary devices from the bus
- * @aux_dev: PF's auxiliary device
- */
-static void ice_ptp_auxbus_remove(struct auxiliary_device *aux_dev)
-{
-	struct ice_pf *owner_pf = ice_ptp_aux_dev_to_owner_pf(aux_dev);
-	struct ice_pf *aux_pf = ice_ptp_aux_dev_to_aux_pf(aux_dev);
-
-	mutex_lock(&owner_pf->ptp.ports_owner.lock);
-	list_del(&aux_pf->ptp.port.list_member);
-	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
-}
-
-/**
- * ice_ptp_auxbus_shutdown
- * @aux_dev: PF's auxiliary device
- */
-static void ice_ptp_auxbus_shutdown(struct auxiliary_device *aux_dev)
-{
-	/* Doing nothing here, but handle to auxbus driver must be satisfied */
-}
-
-/**
- * ice_ptp_auxbus_suspend
- * @aux_dev: PF's auxiliary device
- * @state: power management state indicator
- */
-static int
-ice_ptp_auxbus_suspend(struct auxiliary_device *aux_dev, pm_message_t state)
-{
-	/* Doing nothing here, but handle to auxbus driver must be satisfied */
-	return 0;
-}
-
-/**
- * ice_ptp_auxbus_resume
- * @aux_dev: PF's auxiliary device
- */
-static int ice_ptp_auxbus_resume(struct auxiliary_device *aux_dev)
-{
-	/* Doing nothing here, but handle to auxbus driver must be satisfied */
-	return 0;
-}
-
-/**
- * ice_ptp_auxbus_create_id_table - Create auxiliary device ID table
- * @pf: Board private structure
- * @name: auxiliary bus driver name
- */
-static struct auxiliary_device_id *
-ice_ptp_auxbus_create_id_table(struct ice_pf *pf, const char *name)
-{
-	struct auxiliary_device_id *ids;
-
-	/* Second id left empty to terminate the array */
-	ids = devm_kcalloc(ice_pf_to_dev(pf), 2,
-			   sizeof(struct auxiliary_device_id), GFP_KERNEL);
-	if (!ids)
-		return NULL;
-
-	snprintf(ids[0].name, sizeof(ids[0].name), "ice.%s", name);
-
-	return ids;
-}
-
-/**
- * ice_ptp_register_auxbus_driver - Register PTP auxiliary bus driver
- * @pf: Board private structure
- */
-static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
-{
-	struct auxiliary_driver *aux_driver;
-	struct ice_ptp *ptp;
-	struct device *dev;
-	char *name;
-	int err;
-
-	ptp = &pf->ptp;
-	dev = ice_pf_to_dev(pf);
-	aux_driver = &ptp->ports_owner.aux_driver;
-	INIT_LIST_HEAD(&ptp->ports_owner.ports);
-	mutex_init(&ptp->ports_owner.lock);
-	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
-			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
-			      ice_get_ptp_src_clock_index(&pf->hw));
-	if (!name)
-		return -ENOMEM;
-
-	aux_driver->name = name;
-	aux_driver->shutdown = ice_ptp_auxbus_shutdown;
-	aux_driver->suspend = ice_ptp_auxbus_suspend;
-	aux_driver->remove = ice_ptp_auxbus_remove;
-	aux_driver->resume = ice_ptp_auxbus_resume;
-	aux_driver->probe = ice_ptp_auxbus_probe;
-	aux_driver->id_table = ice_ptp_auxbus_create_id_table(pf, name);
-	if (!aux_driver->id_table)
-		return -ENOMEM;
-
-	err = auxiliary_driver_register(aux_driver);
-	if (err) {
-		devm_kfree(dev, aux_driver->id_table);
-		dev_err(dev, "Failed registering aux_driver, name <%s>\n",
-			name);
-	}
-
-	return err;
-}
-
-/**
- * ice_ptp_unregister_auxbus_driver - Unregister PTP auxiliary bus driver
- * @pf: Board private structure
- */
-static void ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
-{
-	struct auxiliary_driver *aux_driver = &pf->ptp.ports_owner.aux_driver;
-
-	auxiliary_driver_unregister(aux_driver);
-	devm_kfree(ice_pf_to_dev(pf), aux_driver->id_table);
-
-	mutex_destroy(&pf->ptp.ports_owner.lock);
-}
-
 /**
  * ice_ptp_clock_index - Get the PTP clock index for this device
  * @pf: Board private structure
@@ -3137,15 +2954,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	if (err)
 		goto err_clk;
 
-	err = ice_ptp_register_auxbus_driver(pf);
-	if (err) {
-		dev_err(ice_pf_to_dev(pf), "Failed to register PTP auxbus driver");
-		goto err_aux;
-	}
-
 	return 0;
-err_aux:
-	ptp_clock_unregister(pf->ptp.clock);
 err_clk:
 	pf->ptp.clock = NULL;
 err_exit:
@@ -3208,76 +3017,6 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 	}
 }
 
-/**
- * ice_ptp_release_auxbus_device
- * @dev: device that utilizes the auxbus
- */
-static void ice_ptp_release_auxbus_device(struct device *dev)
-{
-	/* Doing nothing here, but handle to auxbux device must be satisfied */
-}
-
-/**
- * ice_ptp_create_auxbus_device - Create PTP auxiliary bus device
- * @pf: Board private structure
- */
-static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
-{
-	struct auxiliary_device *aux_dev;
-	struct ice_ptp *ptp;
-	struct device *dev;
-	char *name;
-	int err;
-	u32 id;
-
-	ptp = &pf->ptp;
-	id = ptp->port.port_num;
-	dev = ice_pf_to_dev(pf);
-
-	aux_dev = &ptp->port.aux_dev;
-
-	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
-			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
-			      ice_get_ptp_src_clock_index(&pf->hw));
-	if (!name)
-		return -ENOMEM;
-
-	aux_dev->name = name;
-	aux_dev->id = id;
-	aux_dev->dev.release = ice_ptp_release_auxbus_device;
-	aux_dev->dev.parent = dev;
-
-	err = auxiliary_device_init(aux_dev);
-	if (err)
-		goto aux_err;
-
-	err = auxiliary_device_add(aux_dev);
-	if (err) {
-		auxiliary_device_uninit(aux_dev);
-		goto aux_err;
-	}
-
-	return 0;
-aux_err:
-	dev_err(dev, "Failed to create PTP auxiliary bus device <%s>\n", name);
-	devm_kfree(dev, name);
-	return err;
-}
-
-/**
- * ice_ptp_remove_auxbus_device - Remove PTP auxiliary bus device
- * @pf: Board private structure
- */
-static void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
-{
-	struct auxiliary_device *aux_dev = &pf->ptp.port.aux_dev;
-
-	auxiliary_device_delete(aux_dev);
-	auxiliary_device_uninit(aux_dev);
-
-	memset(aux_dev, 0, sizeof(*aux_dev));
-}
-
 /**
  * ice_ptp_init_tx_interrupt_mode - Initialize device Tx interrupt mode
  * @pf: Board private structure
@@ -3359,10 +3098,6 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
 
-	err = ice_ptp_create_auxbus_device(pf);
-	if (err)
-		goto err;
-
 	ptp->state = ICE_PTP_READY;
 
 	err = ice_ptp_init_work(pf, ptp);
-- 
2.43.0


