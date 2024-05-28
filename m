Return-Path: <netdev+bounces-98492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2C8D1993
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F581C212B2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2E516C855;
	Tue, 28 May 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrCD78aQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159316C84D
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896021; cv=none; b=VvCWc0x0ACGnqytGFmmZ/yPjPdy6hmr8W5R45aseIraA7+JBsyz5InmHscZGRNjpNIo67OF3NOGO3fXuk3vpZTZGdlDw2uB2LAjpEAiTUpYvypbJ62lTCkynrnDd3yQf+nJ8/1QWyG8xJdNa5Ide3FeHvYip0FK1Cwm7Te7lsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896021; c=relaxed/simple;
	bh=a5ZJ1SDsKcwp9J3O62TL8m1PLvWtbiqE23bpFQKE9gA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JSP37kHGENCW84Qv1ZNsziqBgzgklk/F1xKph+imiPs8oJ2UkXu0GUZactgJ9lCXppVMd3/MD/GLpsCJeoojrxeA5InMJ0pzPYWH4KYI3YD4Jiqj4GxQxrBN1ohnzPa+edjJSG8tqZMm0UrQb5BtMYPjoudfxEHYPOanxXxb1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrCD78aQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716896019; x=1748432019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a5ZJ1SDsKcwp9J3O62TL8m1PLvWtbiqE23bpFQKE9gA=;
  b=GrCD78aQvl7FeOdctXPWIj1ShXskEqpKkXaKXS8sfhpakE41ukmCWXYB
   YhM4o6+YRNKAMXgNqz+5JLWMekQudgv25BQR2sKj9vLcGGLmAXGTHa0LC
   jOV85p5YXGRA6s68V5q7gGlrUtB4TRKZpVNTTJi0wyaUrb79A0/cUjlEK
   33lWGVkhkJu9m4UNZcHbayVluwj8P+y+0N/TdCXtAtHArPCtZup25j3MX
   9KbtG0X7Al+HruOhs1PCTjHAeU6GKQF7l9n0w81GyXdCsM8rfJsKJF1uT
   v/FyK1X7BUvczQd+jlULHTrKBLAE3fkp3ui0GCnPi8nhFcufNnFkW2Y5K
   w==;
X-CSE-ConnectionGUID: VOibxFUvTCOWPC61aantag==
X-CSE-MsgGUID: 3Z+mL+YTRbCMnmj7JSS3LQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30757226"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="30757226"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 04:33:38 -0700
X-CSE-ConnectionGUID: A9TDnCHjTNeoma7w79t1ag==
X-CSE-MsgGUID: lACdl+K6QxCC8lpW5qW3jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35126577"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 04:33:36 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 10B761241A;
	Tue, 28 May 2024 12:33:35 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v6 00/12] Add support for Rx timestamping for both ice and iavf drivers.
Date: Tue, 28 May 2024 07:22:49 -0400
Message-Id: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially, during VF creation it registers the PTP clock in
the system and negotiates with PF it's capabilities. In the
meantime the PF enables the Flexible Descriptor for VF.
Only this type of descriptor allows to receive Rx timestamps.

Enabling virtual clock would be possible, though it would probably
perform poorly due to the lack of direct time access.

Enable timestamping should be done using SIOCSHWTSTAMP ioctl,
e.g.
hwstamp_ctl -i $VF -r 14

In order to report the timestamps to userspace, the VF extends
timestamp to 40b.

To support this feature the flexible descriptors and PTP part
in iavf driver have been introduced.

---
v6:
- reordered tags
- added RB tags where applicable
- removed redundant instructions in ifs - patch 4 and patch 5
- changed teardown to LIFO, adapter->ptp.initialized = false
  moved to the top of function - patch 6
- changed cpu-endianess for testing - patch 9
- aligned to libeth changes - patch 9

v5:
- fixed all new issues generated by this series in kernel-doc
https://lore.kernel.org/netdev/20240418052500.50678-1-mateusz.polchlopek@intel.com/

v4:
- fixed duplicated argument in iavf_virtchnl.c reported by coccicheck
https://lore.kernel.org/netdev/20240410121706.6223-1-mateusz.polchlopek@intel.com/

v3:
- added RB in commit 6
- removed inline keyword in commit 9
- fixed sparse issues in commit 9 and commit 10
- used GENMASK_ULL when possible in commit 9
https://lore.kernel.org/netdev/20240403131927.87021-1-mateusz.polchlopek@intel.com/

v2:
- fixed warning related to wrong specifier to dev_err_once in
  commit 7
- fixed warnings related to unused variables in commit 9
https://lore.kernel.org/netdev/20240327132543.15923-1-mateusz.polchlopek@intel.com/

v1:
- initial series
https://lore.kernel.org/netdev/20240326115116.10040-1-mateusz.polchlopek@intel.com/
---

Jacob Keller (10):
  virtchnl: add support for enabling PTP on iAVF
  virtchnl: add enumeration for the rxdid format
  iavf: add support for negotiating flexible RXDID format
  iavf: negotiate PTP capabilities
  iavf: add initial framework for registering PTP clock
  iavf: add support for indirect access to PHC time
  iavf: periodically cache PHC time
  iavf: refactor iavf_clean_rx_irq to support legacy and flex
    descriptors
  iavf: handle SIOCSHWTSTAMP and SIOCGHWTSTAMP
  iavf: add support for Rx timestamps to hotpath

Mateusz Polchlopek (1):
  iavf: Implement checking DD desc field

Simei Su (1):
  ice: support Rx timestamp on flex descriptor

 drivers/net/ethernet/intel/iavf/Makefile      |   3 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  33 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 247 +++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 548 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  46 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 425 +++++++++++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  26 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 148 +++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 238 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  86 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   2 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 include/linux/avf/virtchnl.h                  | 127 +++-
 17 files changed, 1787 insertions(+), 159 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h

-- 
2.38.1


