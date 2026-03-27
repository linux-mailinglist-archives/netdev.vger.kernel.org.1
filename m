Return-Path: <netdev+bounces-272410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GCYLaIzxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:37:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3224F340836
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2AF317C120
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F63C9EE7;
	Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ts6nx9xe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6053C6A25
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596657; cv=none; b=cFkIrtyprrc3v5WeuNPwC9DyCxc8UoIqkLkXQhF4pyTrLzHtScTq41ki/Pr+3fN80oHuKhR/T6gcMxeuZJRSZ0kEP5g1tlXZDgS5hvGdEPlL97SYisJS8Hodncy9LIIi3BlsyOo4ycLQorJMhaC1pqSG8wibAX6G8KYU/aN4kFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596657; c=relaxed/simple;
	bh=ki0l4dqtFjyaxid0mH51xS6ucoI4QPhIHBRummsYWnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkR7Hqvzg4rq0WzVFjm+TdgZLaRHzqng6bi8N3pYLoHihEhHh2oAYtXb4r/aKIpmNPog29ijxDExOFCfnZaRfrpq5IKcg7UVI2FtjqXSEB6QOAJcd+sdlWyADHFXlWa6S4HMQSbRZilTFSu7DfNXPlzIIDY15wiYkom7UKQFQUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ts6nx9xe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596649; x=1806132649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ki0l4dqtFjyaxid0mH51xS6ucoI4QPhIHBRummsYWnc=;
  b=Ts6nx9xeRmXRsTArgX7tfLlcliT9kEYrnmNGrpbBO/4naEMw70Mlvymy
   uhFgdLxCPHgKLj10NFFW8EaV3Ji27cl7uv9/fRmQs6GryHxkntzW7rTgC
   0fmiZ+sDUfhXSszOXZDvrfE2HRzHzX028OIiTXfoLUOIlztWHAEt7W8KE
   ZTJoVI5DOq+f/T8dkp1k8bREvNHdC7jQCChLGwx+lN2TrZLpXvSMb+qrk
   swJFaMSehHgw+J1l1+7JwDmwgWTX0ElFPmAkQ/H+tNhq6v+N3ErhyvRAv
   tPD95QTcx5omknLmcAsOgqU/2gEdjPv5XDhwDvzo6vuvh5FJqlZps/xMi
   w==;
X-CSE-ConnectionGUID: J0rcwO7jSxq4WxKBI7C31Q==
X-CSE-MsgGUID: lZCYwwFYQ7mGDEAS2KmAKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734287"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75734287"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:30:48 -0700
X-CSE-ConnectionGUID: fqc43ug9TaevUIPZzxbrag==
X-CSE-MsgGUID: y5p4STNPQKqDAxKNgsIYeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255740352"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:47 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ixgbe: increase SWFW semaphore timeout for X550 FW updates
Date: Fri, 27 Mar 2026 08:30:35 +0100
Message-ID: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272410-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 3224F340836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Soumen Karmakar <soumen.karmakar@intel.com>

According to FW documentation, the most time-consuming part of continuous
FW activity is Shadow RAM (SR) dump which takes up to 3.2 seconds.  For
X550 devices, the module-update FW command can take over 4.5 s.  Increase
the max Software/Firmware (SW/FW) semaphore wait time from the default
200 ms to 5 s for X550 to avoid spurious semaphore timeout failures
during FW update operations.

Signed-off-by: Soumen Karmakar <soumen.karmakar@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index e67e2fe..85047ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -577,6 +577,9 @@ int ixgbe_acquire_swfw_sync_X540(struct ixgbe_hw *hw, u32 mask)
 
 	swmask |= swi2c_mask;
 	fwmask |= swi2c_mask << 2;
+	if (hw->mac.type == ixgbe_mac_X550)
+		timeout = 1000;
+
 	for (i = 0; i < timeout; i++) {
 		/* SW NVM semaphore bit is used for access to all
 		 * SW_FW_SYNC bits (not just NVM)
-- 
2.52.0


