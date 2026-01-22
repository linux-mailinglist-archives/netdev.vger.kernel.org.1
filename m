Return-Path: <netdev+bounces-252247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OO6CSfncWkONAAAu9opvQ
	(envelope-from <netdev+bounces-252247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:00:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E48AB63ADC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCAB35E532C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157738FF16;
	Thu, 22 Jan 2026 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eNIJaK4d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929DE3242A5
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071889; cv=none; b=e0MbN7JOnb66WpJrjWL2PcRvcUP9kbjhRptYTFFhVn5qLbTKG4y+q5EanIo0+0Cfhg2BOsGi6jdAZS6WHCYVltrLNtsvK6E68cZ5Q8l8HKHeOgNiv6xFtMdMeIQSLyoQlqDhFMZKNmLEs9OlupZzM2SsNikszFB7VxNNeQ45esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071889; c=relaxed/simple;
	bh=NmNlucIgKwK3+ale7vaInUF2bjHcFehAzVXgbuyDoSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1q+eEfpY7Dthw0aAyKgAxqcCeP0dKxDrt+uEy3ccmKgKWEXVHrlA+VJSjv+yh3ABzjg/JkYtT1+R3cyuqdq/PMgApEc2PpZS9cGx6ByxB/+jkYOJdUduSM8BZ2oK30n52Nnu6kamEU4BnWNTiV1dfberhcf5eiv6U43MTM7cIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eNIJaK4d; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769071888; x=1800607888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NmNlucIgKwK3+ale7vaInUF2bjHcFehAzVXgbuyDoSI=;
  b=eNIJaK4d/lWoX1S8iBhMmFxIhsYciXR+XZajG5+UED1XeCVp8bpMaiQS
   6LldODYqGFlRKQt2Tc84jZ4YWanV1FORKlDSQgiMf8CLEXqeSrzBC2/oN
   M2QYy6FoRe+7EL4cu5PMtz7OasFeF9/+RVPuTSY2Uq9jbgFvUMNI4YhZR
   c6XRKA0LKLNxfiph59SUyqpe9n80HTkk24f6ljeygECNyV3YjO9hhu4/a
   Yf3wVdfRy6cyCVPelgdIL7rwvdI5Ap9Emo7BcqOe1LKVOE8nSW4mF6GCr
   yIoK3l+4jSKc6kRPP5NRrVWUmWDrJyDAI6QlkJ/1HGRsxBuU/72QH+p6E
   Q==;
X-CSE-ConnectionGUID: mhPU1rg+Sf611up+4z7hJA==
X-CSE-MsgGUID: PNhIJ+BiRQS0eq0oBzozbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70224342"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="70224342"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 00:51:08 -0800
X-CSE-ConnectionGUID: foltntY4Sx6EY8TfgtzUzQ==
X-CSE-MsgGUID: wk0yBgu/TEiO+afE/IQcQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="205924946"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa010.jf.intel.com with ESMTP; 22 Jan 2026 00:51:03 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1] ixgbe: fix type punning in ixgbe_update_flash_X550
Date: Thu, 22 Jan 2026 09:51:02 +0100
Message-ID: <20260122085102.1117651-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252247-lists,netdev=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: E48AB63ADC
X-Rspamd-Action: no action

Add a u32 buffer array member to union ixgbe_hic_hdr2 and use it
directly instead of casting the union address to u32 pointer. This
avoids potential strict aliasing violations and makes the code more
explicit about the buffer usage.

The ixgbe_host_interface_command function expects a void* buffer, so
providing a proper u32 array member in the union is the correct
approach rather than relying on pointer casting. This eliminates the
type punning issue where we were casting the union pointer to u32*.

By using buffer.buf instead of &buffer, we pass the address of the
u32 array directly, which is semantically correct and avoids any
potential undefined behavior from strict aliasing rule violations.

Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 61f2ef6..eb5bf3b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2798,6 +2798,7 @@ struct ixgbe_hic_hdr2_rsp {
 };
 
 union ixgbe_hic_hdr2 {
+	u32 buf[1];
 	struct ixgbe_hic_hdr2_req req;
 	struct ixgbe_hic_hdr2_rsp rsp;
 };
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 76d2fa3..4a0ccbf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1228,7 +1228,7 @@ static int ixgbe_update_flash_X550(struct ixgbe_hw *hw)
 	buffer.req.buf_lenl = FW_SHADOW_RAM_DUMP_LEN;
 	buffer.req.checksum = FW_DEFAULT_CHECKSUM;
 
-	status = ixgbe_host_interface_command(hw, &buffer, sizeof(buffer),
+	status = ixgbe_host_interface_command(hw, buffer.buf, sizeof(buffer),
 					      IXGBE_HI_COMMAND_TIMEOUT, false);
 	return status;
 }
-- 
2.52.0


