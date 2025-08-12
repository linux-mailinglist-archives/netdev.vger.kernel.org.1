Return-Path: <netdev+bounces-213095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8C2B23A3A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 22:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7D9562DC3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0EC2D47EE;
	Tue, 12 Aug 2025 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn8QI6iq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8D2C21E5
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031958; cv=none; b=GGUpbC266QzvWJHiFd/t/hOntQuvTkcB3l1emn6EZzu89g7QW8Fya4tolaDTaM9vmcq6SfAK7mLEFoS5BvpgsSjuA40ohW1hd/uuBB1BHRqm45N+oRefrNI5uBJXdx5tXJbNMfXR3WgP1qbL3xMaya9gop1oH1xaf4wC5R6atCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031958; c=relaxed/simple;
	bh=ApiCCmiRYPUEPYyrtJCRq087eQM91DvWevuGMIeMaaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgkbsGNAqIKbNx+z+wQBhMDSXyWj/OjR5kPgvF4gQUMdYHYFvs0ZvRKC57NFpJRhBIXkOQhhIpwOvd74FlxDQYItrWQHW+9gO1NZh4vkCrEOHBFvyt4xi+RHHPoSOB7HQN6hsvNp/DfP2EkiYu0FUUc3Pxd7QLVo6LMgYiFbcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn8QI6iq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755031957; x=1786567957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ApiCCmiRYPUEPYyrtJCRq087eQM91DvWevuGMIeMaaA=;
  b=bn8QI6iqJ5Hei1L1nyxYphmiz4g0EdSPcwRYizLvibJl/TSZEc4XeezL
   yjcwwG9NyEzZEu+zMwqeKV+maY3xOwGxSYEdzXP18V5CgC+Y/T6KUuXAg
   vgzNe0v36j06WOqZT1QjhkpdC7dX22qxJy5dwr1RHDa1RlmapFtxtVpuV
   NKWNfVRTPpq1WNMG0z4/ja3lzLi3wjHltm7fpcHacX1psly+xmCme3qXC
   TdPMmTgyuhh5WVAv0TSfKSnW5wn2ITD5mcfx8a2V3qXRIoJjPB+3hm6Lu
   INtwraJ2lqzMx+ec7xmTMTJH3fav/WWA1lTTfc2UkmuLWw/xN6VHSbsbG
   w==;
X-CSE-ConnectionGUID: 8ZwHf4MJRlux+sq40wipjA==
X-CSE-MsgGUID: Hrpv0p7MQxu78LTM63izjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68775083"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68775083"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 13:52:35 -0700
X-CSE-ConnectionGUID: Wk42hyC0SbW4VnmIPntYpg==
X-CSE-MsgGUID: dPiZioz/TYaxwfhXpKZqZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="203474835"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 12 Aug 2025 13:52:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com
Subject: [PATCH net v3 1/2] devlink: let driver opt out of automatic phys_port_name generation
Date: Tue, 12 Aug 2025 13:52:23 -0700
Message-ID: <20250812205226.1984369-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250812205226.1984369-1-anthony.l.nguyen@intel.com>
References: <20250812205226.1984369-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Currently when adding devlink port, phys_port_name is automatically
generated within devlink port initialization flow. As a result adding
devlink port support to driver may result in forced changes of interface
names, which breaks already existing network configs.

This is an expected behavior but in some scenarios it would not be
preferable to provide such limitation for legacy driver not being able to
keep 'pre-devlink' interface name.

Add flag no_phys_port_name to devlink_port_attrs struct which indicates
if devlink should not alter name of interface.

Suggested-by: Jiri Pirko <jiri@resnulli.us>
Link: https://lore.kernel.org/all/nbwrfnjhvrcduqzjl4a2jafnvvud6qsbxlvxaxilnryglf4j7r@btuqrimnfuly/
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/devlink.h | 6 +++++-
 net/devlink/port.c    | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 93640a29427c..b32c9ceeb81d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -78,6 +78,9 @@ struct devlink_port_pci_sf_attrs {
  * @flavour: flavour of the port
  * @split: indicates if this is split port
  * @splittable: indicates if the port can be split.
+ * @no_phys_port_name: skip automatic phys_port_name generation; for
+ *		       compatibility only, newly added driver/port instance
+ *		       should never set this.
  * @lanes: maximum number of lanes the port supports. 0 value is not passed to netlink.
  * @switch_id: if the port is part of switch, this is buffer with ID, otherwise this is NULL
  * @phys: physical port attributes
@@ -87,7 +90,8 @@ struct devlink_port_pci_sf_attrs {
  */
 struct devlink_port_attrs {
 	u8 split:1,
-	   splittable:1;
+	   splittable:1,
+	   no_phys_port_name:1;
 	u32 lanes;
 	enum devlink_port_flavour flavour;
 	struct netdev_phys_item_id switch_id;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 939081a0e615..cb8d4df61619 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1519,7 +1519,7 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
 	int n = 0;
 
-	if (!devlink_port->attrs_set)
+	if (!devlink_port->attrs_set || devlink_port->attrs.no_phys_port_name)
 		return -EOPNOTSUPP;
 
 	switch (attrs->flavour) {
-- 
2.47.1


