Return-Path: <netdev+bounces-211818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF202B1BCB5
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E991675C9
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681426CE06;
	Tue,  5 Aug 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8MHZPuI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371E262FE5
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433315; cv=none; b=YmUBu+GSExow2O9ESrZKHTMtOTY4GDKKvFjeQMOm36YnQ5PD1YmG5DvIL6RLsrXL+B1lb7az1VSQ1pptEBxrO9ZneqqjGldpEE0e+vZvIFOAhLiqoSoLICSVH8S0rMdO7+bViiH/ssKTDnE1fPg6WIgODgjgPwNVAYJUk/ZTdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433315; c=relaxed/simple;
	bh=DsM3zyRtFgwWopGIKcHe2tyoSJlkQm24G/donvEIiV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHI25cHmxmWxkx5bYCAoi8D+n0ACxUvfoRkEI2gjFVLmsMVZmc+TPs0zfke7R3smr1TmmM7seSNGyc/mA4LiaLJMAAvPO26Qh2JJj3U2YUD0X4BIrHQHs8MZ2HkTb1XztG1e08k6yAlke74vwJfXdipoSPxH1fewzhHgR95Y4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8MHZPuI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754433314; x=1785969314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsM3zyRtFgwWopGIKcHe2tyoSJlkQm24G/donvEIiV8=;
  b=b8MHZPuI0kt+UBSQ4W3xyDPGOH4z1aiRsqml7qmC7rk9VboGw70aGZ4C
   aUTwQ6nhCEz4OF9zxH1XtUzHpmS2BUyw/cf3h9z+4Xf5E+5LAMrcQKkLJ
   OgCA5M/SbQUeYcNYP80+usoc9GGH5LL4bRgA0lFYKLlM0a1/uQt4S5y7y
   iJaQTMLBFcKI0VFwIHE3RCiShcSCgnDwXNbfWaI2hKdAwnt8Nsv45zthc
   wu8q5n8zsRW2alrEiKgJYxF/GvmBeR1ItDDeaQqertEhVM5hZPdrwJ/5I
   maJS8tItp6zWLwMyBPE5FA9q21KR6JxrsFNYpMZUEh3BSiAwYt4q2W94M
   g==;
X-CSE-ConnectionGUID: wXbKiXdTQlC32uiK+3I7ZA==
X-CSE-MsgGUID: ndPhDHDkRNa7qAyOMGp25w==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56658113"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56658113"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 15:35:13 -0700
X-CSE-ConnectionGUID: o2b8Oww6Rd6CIJN07I52IA==
X-CSE-MsgGUID: uTaCAC9vQS+mBF/SjL6tTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164515365"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 05 Aug 2025 15:33:55 -0700
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
	jiri@resnulli.us,
	horms@kernel.org,
	David.Kaplan@amd.com,
	dhowells@redhat.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2 1/2] devlink: let driver opt out of automatic phys_port_name generation
Date: Tue,  5 Aug 2025 15:33:41 -0700
Message-ID: <20250805223346.3293091-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/devlink.h | 5 ++++-
 net/devlink/port.c    | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 93640a29427c..4458b46407ee 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -78,6 +78,8 @@ struct devlink_port_pci_sf_attrs {
  * @flavour: flavour of the port
  * @split: indicates if this is split port
  * @splittable: indicates if the port can be split.
+ * @no_phys_port_name: skip automatic phys_port_name generation; for compatibility only,
+ * 		       newly added driver/port instance should never set this.
  * @lanes: maximum number of lanes the port supports. 0 value is not passed to netlink.
  * @switch_id: if the port is part of switch, this is buffer with ID, otherwise this is NULL
  * @phys: physical port attributes
@@ -87,7 +89,8 @@ struct devlink_port_pci_sf_attrs {
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
index 939081a0e615..44f808e65006 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1522,6 +1522,9 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
 	if (!devlink_port->attrs_set)
 		return -EOPNOTSUPP;
 
+	if (devlink_port->attrs.no_phys_port_name)
+		return 0;
+
 	switch (attrs->flavour) {
 	case DEVLINK_PORT_FLAVOUR_PHYSICAL:
 		if (devlink_port->linecard)
-- 
2.47.1


