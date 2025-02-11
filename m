Return-Path: <netdev+bounces-165298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D0A31815
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AAB188B392
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC8268FD1;
	Tue, 11 Feb 2025 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0XNwxog"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FF26771F
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310237; cv=none; b=l0xc4qiehUQdlaXGcUSmVRPLzKWGS17zGZLe+tCWwF8tXyVq8urQOVvK7Fj6RqzgHYaZQun27KG5KNH7BywOec6JNJZwpGLtNI4dXYQcslI/mIp7G1ZDB+SGMOAztYv98OLJkKlegn1Q3r2jElokjCTY2ZWiiQOpPwc2YKJ8cNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310237; c=relaxed/simple;
	bh=y4RwuGwz9BcGpNkOBfK3U3ajwbJ39wD71zctil4z4p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuPzaWOcoa5vv9Kb7GXbRwzsSX/7rhio7lsJKjF2lKdQwUURc6PZDS1wHdKsNC4iTqYHbRtnIJlql7u0tJ97YZGG3DSJs/MBXQYgCZLYJv8SBrTyourNRoXd2+RClaMq1WVG516ZLkUvGNBVEn98ZmtjrOfyLudTTMfU9OokrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0XNwxog; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739310235; x=1770846235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y4RwuGwz9BcGpNkOBfK3U3ajwbJ39wD71zctil4z4p0=;
  b=T0XNwxogFqKveAKoQi2QFBx8ikWH69snpDMf+HiCw/QlgkLgdwE1BrPT
   QF+HjG59zBrsnS91BoADhsl87JKaB80oDHJBOqzOHueSf9db84Dqo7B1A
   cEpFK8ABNa8BUiwlo0wSdyfsZ/9StJ7rSDjPvIjE7ns7JVKoIaDOdZIlW
   5vhTzICL9CPmCn4py8kwm+cY45m1OjFkfv9argcTRtK2+oFRi0cFBvGUL
   3tsYLKGESdOCbPccvCbPqGkLa6OzfJCzfEFlcaNOA+KREnCYeAvYCtkY0
   3NF7Pj5D9O0ek1uOyzmKWYCU5doJasxKLdLn71ezWh+DxMVkZNJqSEQ9O
   g==;
X-CSE-ConnectionGUID: TVtH2MzpSgKWghdVHzFakA==
X-CSE-MsgGUID: GdTA/vC9QI6shoTfD7q6cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39185237"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39185237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:43:49 -0800
X-CSE-ConnectionGUID: sSySMl6YQbCnCEthHtnO6w==
X-CSE-MsgGUID: Q9GxTBRkQAuiD3WJE//+Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143478674"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 13:43:49 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 3/6] idpf: call set_real_num_queues in idpf_open
Date: Tue, 11 Feb 2025 13:43:34 -0800
Message-ID: <20250211214343.4092496-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
References: <20250211214343.4092496-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

On initial driver load, alloc_etherdev_mqs is called with whatever max
queue values are provided by the control plane. However, if the driver
is loaded on a system where num_online_cpus() returns less than the max
queues, the netdev will think there are more queues than are actually
available. Only num_online_cpus() will be allocated, but
skb_get_queue_mapping(skb) could possibly return an index beyond the
range of allocated queues. Consequently, the packet is silently dropped
and it appears as if TX is broken.

Set the real number of queues during open so the netdev knows how many
queues will be allocated.

Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index b4fbb99bfad2..a3d6b8f198a8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2159,8 +2159,13 @@ static int idpf_open(struct net_device *netdev)
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
+	err = idpf_set_real_num_queues(vport);
+	if (err)
+		goto unlock;
+
 	err = idpf_vport_open(vport);
 
+unlock:
 	idpf_vport_ctrl_unlock(netdev);
 
 	return err;
-- 
2.47.1


