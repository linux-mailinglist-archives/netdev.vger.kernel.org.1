Return-Path: <netdev+bounces-112057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE23C934C0D
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F11F21420
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B20812D1FA;
	Thu, 18 Jul 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TC4rILgf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1B1386A7
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300081; cv=none; b=XHegCjmjxMGADcIfPJ4Ox9EQOQCj9c7d5DmrxV8faWGH9OV0FNAxYA33sl9b1fMKRf/p6SM9hGC4GMYRcz+xJGcR/b849UbNQz7lW+NDw8JjJPzIvRs9U0fOQxM9HnOAQqP+BVfdOVZjG2UWQrUyieoBl5rjsPyUaZj8rsqlPmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300081; c=relaxed/simple;
	bh=aBqmcsE9YgyoBQvVjDaepi2ZtDF6aG7E3BgGQq3HDeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuLIQXPlWAXtxWQMNttN3aLq5fYdE4POY8Y5N0UKsro3+HWuTmc6orUw0hsCQaIAdPj4UM17QEo3HyVcXh34g8E+Bs2U7WO4yGwOAVchDSrUi2X0lDhkZQuEVs7XctzNlien4IlnYaHMQDTAyD1hawxgpbDhTlaztPzue9iW3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TC4rILgf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721300079; x=1752836079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBqmcsE9YgyoBQvVjDaepi2ZtDF6aG7E3BgGQq3HDeI=;
  b=TC4rILgfog/XRMjGFuNQ8K0uOY5R6a3nYhLKqKsoEINEUDQ32gd/jGYg
   pfRAjYTxupMvFdGBSMzhQYR+neDBB/ooORjwDEzjUZfPD2xF0kKQYGZso
   oKZ56a2Ilu6s77H8qIWl4lN7ZEbY9nkOSraf92O7hB+fqdixX7l/FQKAw
   S+0DcX5/0U+KtTtSWj5ovHgnZwVYIVRh9dxvcnzGoJA0+/8QcmiCfO+Jc
   nHZYpY4laY/ROku5nnMNRSo5OkVRv8mYJLW86g9DwSYIaRXSEt2jvIhmM
   u0HVkGxN60nJMbKCzhWgEo3HxlI4oAWK2WXtvgJIBw0TcTyaLZxdxKakw
   w==;
X-CSE-ConnectionGUID: PasRWCniQo2St0F8kzoEHQ==
X-CSE-MsgGUID: ult043tYRTy1CXpAsjUBYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18987505"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18987505"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 03:54:39 -0700
X-CSE-ConnectionGUID: 5jcq00hwSMWkgHzCzsscow==
X-CSE-MsgGUID: HiC0RPXWS8qgm6KhHDTr4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50774628"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa009.jf.intel.com with ESMTP; 18 Jul 2024 03:54:37 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v4 5/5] ice: Drop auxbus use for PTP to finalize ice_adapter move
Date: Thu, 18 Jul 2024 12:52:53 +0200
Message-ID: <20240718105253.72997-6-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
References: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
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

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 252 -----------------------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  21 --
 2 files changed, 273 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 48bc29182cb8..89a8513534f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3011,188 +3011,6 @@ static void ice_ptp_cleanup_pf(struct ice_pf *pf)
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
-	INIT_LIST_HEAD(&aux_pf->ptp.port.list_node);
-	mutex_lock(&owner_pf->ptp.ports_owner.lock);
-	list_add(&aux_pf->ptp.port.list_node,
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
-	list_del(&aux_pf->ptp.port.list_node);
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
-static int __always_unused ice_ptp_register_auxbus_driver(struct ice_pf *pf)
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
-static void __always_unused ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
-{
-	struct auxiliary_driver *aux_driver = &pf->ptp.ports_owner.aux_driver;
-
-	auxiliary_driver_unregister(aux_driver);
-	devm_kfree(ice_pf_to_dev(pf), aux_driver->id_table);
-
-	mutex_destroy(&pf->ptp.ports_owner.lock);
-}
 
 /**
  * ice_ptp_clock_index - Get the PTP clock index for this device
@@ -3331,76 +3149,6 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
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
-static __always_unused int ice_ptp_create_auxbus_device(struct ice_pf *pf)
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
-static __always_unused void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
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
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 9e3ddc83a8f4..aaf1ba79aa2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -140,7 +140,6 @@ struct ice_ptp_tx {
  *
  * @list_node: list member structure
  * @tx: Tx timestamp tracking for this port
- * @aux_dev: auxiliary device associated with this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
  * @ps_lock: mutex used to protect the overall PTP PHY start procedure
  * @link_up: indicates whether the link is up
@@ -150,7 +149,6 @@ struct ice_ptp_tx {
 struct ice_ptp_port {
 	struct list_head list_node;
 	struct ice_ptp_tx tx;
-	struct auxiliary_device aux_dev;
 	struct kthread_delayed_work ov_work;
 	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
 	bool link_up;
@@ -164,23 +162,6 @@ enum ice_ptp_tx_interrupt {
 	ICE_PTP_TX_INTERRUPT_ALL,
 };
 
-/**
- * struct ice_ptp_port_owner - data used to handle the PTP clock owner info
- *
- * This structure contains data necessary for the PTP clock owner to correctly
- * handle the timestamping feature for all attached ports.
- *
- * @aux_driver: the structure carring the auxiliary driver information
- * @ports: list of porst handled by this port owner
- * @lock: protect access to ports list
- */
-
-struct ice_ptp_port_owner {
-	struct auxiliary_driver aux_driver;
-	struct list_head ports;
-	struct mutex lock;
-};
-
 #define GLTSYN_TGT_H_IDX_MAX		4
 
 enum ice_ptp_state {
@@ -245,7 +226,6 @@ struct ice_ptp_pin_desc {
  * @state: current state of PTP state machine
  * @tx_interrupt_mode: the TX interrupt mode for the PTP clock
  * @port: data for the PHY port initialization procedure
- * @ports_owner: data for the auxiliary driver owner
  * @work: delayed work function for periodic tasks
  * @cached_phc_time: a cached copy of the PHC time for timestamp extension
  * @cached_phc_jiffies: jiffies when cached_phc_time was last updated
@@ -270,7 +250,6 @@ struct ice_ptp {
 	enum ice_ptp_state state;
 	enum ice_ptp_tx_interrupt tx_interrupt_mode;
 	struct ice_ptp_port port;
-	struct ice_ptp_port_owner ports_owner;
 	struct kthread_delayed_work work;
 	u64 cached_phc_time;
 	unsigned long cached_phc_jiffies;
-- 
2.43.0


