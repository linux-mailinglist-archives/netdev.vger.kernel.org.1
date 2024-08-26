Return-Path: <netdev+bounces-122073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1BC95FD64
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03B4280E25
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8A319FA8E;
	Mon, 26 Aug 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwDUPlbE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14419E83D
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712423; cv=none; b=uQyM+/J3bXy1pxY5WIEWQy6PhPZe3U8ly8nO5813n0ZfhA/iAYWxe3H6ieGM9cWeyV5qa2dGt4fcpLRcMdQWhQvNwsYQmQTrhlkWjCHCWGhJf2jTpNoaxj4d2c59As2KRYHrTxt9sPxTkD63Po64sG+SVN5eppvgkPMsEAME+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712423; c=relaxed/simple;
	bh=QUSLhYk5v9sv95iPsj5HrQ5GbfrAF4nrmcERAvOieWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L86XMFXPbCw6FKVsdjjJGVrZLjVRbubPyZ2eM5KHnOeyqIMTjY6w0q/5m6qBWdhpFsdZqBUoLhswAZ1cYEp5c+YrPWDUTZs2FdOfvJ7QB39/5gZEpDH8YH1oEuxhCHDhbONfTrk38nNNXGZU3RsMAf67UFIZkkXwWb1PvKVGnN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwDUPlbE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712420; x=1756248420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QUSLhYk5v9sv95iPsj5HrQ5GbfrAF4nrmcERAvOieWk=;
  b=MwDUPlbEeitii2+MwfYZDkE7FdPyoLxh4IyD2UJxUU2xQku7rCGZNB49
   zo9M86vTvopHxdnhAx3CNGs9LMGOacHGfsmUFYpJz5Ej5LX08AFRS17id
   wzDli45ZieuGjBdt2QP13okWDCIu1OIDdwwu7we/RHv93ldyois98Hb1N
   hLRUyZb9JoAOJT/R8v4x7mwqwWfKoi/6K2FgjA+E5HR6GUdfFJtYqv6fZ
   /XbJ4lOXyrivrVZK1rv/bUVH1eGS6oYnXqSCbkVHUjJlSv+q0vJbnk9H4
   DeLYYN1pCDYl/4yNrPrX0KZRoSeq4U1cb1hjN0wD9OYZ0DeCWYxft414S
   w==;
X-CSE-ConnectionGUID: oO1esGNWR02hLVrFlElx9A==
X-CSE-MsgGUID: 1PCs1EnYQxaa5KWAc8pH2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23030944"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23030944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:47:00 -0700
X-CSE-ConnectionGUID: EanLegwKQziSWIZZK8Ihrg==
X-CSE-MsgGUID: J9EXL1BYRoy8PiSuepbzyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62822454"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 26 Aug 2024 15:46:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/8][pull request] Intel Wired LAN Driver Updates 2024-08-26 (ice)
Date: Mon, 26 Aug 2024 15:46:40 -0700
Message-ID: <20240826224655.133847-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Jake implements and uses rd32_poll_timeout to replace a jiffies loop for
calling ice_sq_done. The rd32_poll_timeout() function is designed to allow
simplifying other places in the driver where we need to read a register
until it matches a known value.

Jake, Bruce, and Przemek update ice_debug_cq() to be more robust, and more
useful for tracing control queue messages sent and received by the device
driver.

Jake rewords several commands in the ice_control.c file which previously
referred to the "Admin queue" when they were actually generic functions
usable on any control queue.

Jake removes the unused and unnecessary cmd_buf array allocation for send
queues. This logic originally was going to be useful if we ever implemented
asynchronous completion of transmit messages. This support is unlikely to
materialize, so the overhead of allocating a command buffer is unnecessary.

Sergey improves the log messages when the ice driver reports that the NVM
version on the device is not supported by the driver. Now, these messages
include both the discovered NVM version and the requested/expected NVM
version.

Aleksandr Mishin corrects overallocation of memory related to adding
scheduler nodes.

The following are changes since commit 18aaa82bd36ae3d4eaa3f1d1d8cf643e39f151cd:
  net: netlink: Remove the dump_cb_mutex field from struct netlink_sock
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Aleksandr Mishin (1):
  ice: Adjust over allocation of memory in ice_sched_add_root_node() and
    ice_sched_add_node()

Bruce Allan (1):
  ice: do not clutter debug logs with unused data

Jacob Keller (4):
  ice: implement and use rd32_poll_timeout for ice_sq_done timeout
  ice: improve debug print for control queue messages
  ice: reword comments referring to control queues
  ice: remove unnecessary control queue cmd_buf arrays

Przemek Kitszel (1):
  ice: stop intermixing AQ commands/responses debug dumps

Sergey Temerkhanov (1):
  ice: Report NVM version numbers on mismatch during load

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_controlq.c | 178 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_controlq.h |   5 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |  28 ++-
 drivers/net/ethernet/intel/ice/ice_sched.c    |   6 +-
 5 files changed, 119 insertions(+), 102 deletions(-)

-- 
2.42.0


