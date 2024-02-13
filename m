Return-Path: <netdev+bounces-71202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D048529C8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7321F230CF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B317583;
	Tue, 13 Feb 2024 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgJgRLzi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142817577
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809010; cv=none; b=Vfm38hr7RFNZdTUl5byOvwHoC5djv86hEF96G3H2RkO0HtXst+cM7W6m64Q2Xt29GwRRXzseihIb1fZ2d0xIX3CH+lLjKEymtn+mo3J8YvbiEENg8jNhxgp4j1HNQeDxWrvX7nAjv0+HrjYEH9tIdhU942FKnbnIZGYXSw44Y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809010; c=relaxed/simple;
	bh=MqV78i8tz/1bAqq70F/Cp5mpwdsUYTuSGbwyKNlOpyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHVr4zd5nHxmbtL8sN4fsSx/S0YZoKa9ktbXBQg8CBrJjHA+tcEwlAsexF0CqXXjbAOhIt0E0NaKMiix3XHzgB8OZJktJ9O2s+D6O0/X/SdEZ47l5mufiMy6wqwHhRYCbpGJdRPKthPYI73W/LfW96iO0KECLbHPq01lD3SvOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgJgRLzi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809009; x=1739345009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MqV78i8tz/1bAqq70F/Cp5mpwdsUYTuSGbwyKNlOpyg=;
  b=lgJgRLziLc4HgMxIMpLIDagfwMLNRPXyIWED/rqHQkqF9AyX4/9knb+k
   RTr5fLdxyljvWf041i/fbH6AQKgasvj2IHC6hsnGL+QCJkzmcXhj/AOQ3
   OsvkpEQ0Vfjd8Ws/cykiS0+/zBpa6QVfK5pqgHj94ZBEYsqhMuPXJ//KE
   UoV4AzDYP7VVOcM0Eewz3wV3KcKeLBP4oFXih4RMXPLvzqXKMoN4y67Hw
   q7Ap8JU7TUV0HbGsgwtSurM934Y+iFa5jbeHrxwCNYBYy3ekK4HlBLFVw
   N/IZ96QX6DzMubUmbN2OUkpkRA//UIBZc4F6Z24txKW+5Eo7hmpvS8Weq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27247963"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27247963"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385297"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:25 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 07/15] ice: add auxiliary device sfnum attribute
Date: Tue, 13 Feb 2024 08:27:16 +0100
Message-ID: <20240213072724.77275-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Raczynski <piotr.raczynski@intel.com>

Add read only sysfs attribute for each auxiliary subfunction
device. This attribute is needed for orchestration layer
to distinguish SF devices from each other since there is no
native devlink mechanism to represent the connection between
devlink instance and the devlink port created for the port
representor.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index ab90db52a8fc..abee733710a5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -224,6 +224,36 @@ static void ice_sf_dev_release(struct device *device)
 	kfree(sf_dev);
 }
 
+static ssize_t
+sfnum_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct devlink_port_attrs *attrs;
+	struct auxiliary_device *adev;
+	struct ice_sf_dev *sf_dev;
+
+	adev = to_auxiliary_dev(dev);
+	sf_dev = ice_adev_to_sf_dev(adev);
+	attrs = &sf_dev->dyn_port->devlink_port.attrs;
+
+	return sysfs_emit(buf, "%u\n", attrs->pci_sf.sf);
+}
+
+static DEVICE_ATTR_RO(sfnum);
+
+static struct attribute *ice_sf_device_attrs[] = {
+	&dev_attr_sfnum.attr,
+	NULL,
+};
+
+static const struct attribute_group ice_sf_attr_group = {
+	.attrs = ice_sf_device_attrs,
+};
+
+static const struct attribute_group *ice_sf_attr_groups[2] = {
+	&ice_sf_attr_group,
+	NULL
+};
+
 /**
  * ice_sf_eth_activate - Activate Ethernet subfunction port
  * @dyn_port: the dynamic port instance for this subfunction
@@ -262,6 +292,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 	sf_dev->dyn_port = dyn_port;
 	sf_dev->adev.id = id;
 	sf_dev->adev.name = "sf";
+	sf_dev->adev.dev.groups = ice_sf_attr_groups;
 	sf_dev->adev.dev.release = ice_sf_dev_release;
 	sf_dev->adev.dev.parent = &pdev->dev;
 
-- 
2.42.0


