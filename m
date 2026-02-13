Return-Path: <netdev+bounces-258550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB8nMwOWjmm8DAEAu9opvQ
	(envelope-from <netdev+bounces-258550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:09:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1686A132902
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACD173025C42
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072AB12FF69;
	Fri, 13 Feb 2026 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYeJI21y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190E26299
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952185; cv=none; b=tVn2u8BL2VlQkWY5BHhcC8FTosrueJLaqpqU4mZCSnT7E0NQr63XsEtstBv81v4Ka7ak4SCsw3zKK7QR03lcBYzewcWht5vpeOHjKmsJtEl7Lrg0Q/EwPBDwuSwiaZcyik5leUM9bpqYJJbSC9V2JuemHfkMTcaP626JlXn8n5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952185; c=relaxed/simple;
	bh=3Y7Q6Au/X2ZyR/wPpqJXyfm6utcskF47IufYsRLqZL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8zoRPLr0MUb4epacc3vyuJ37MqRYykW2R2+sYCRKC3g7ueAy9hxQw+qI8XdRfeUqQrSuVCZJsMs9M762Pe43u0NpyrUVEUXO4POwMVdajOfYlGpbneK95Cu0/QOCEZUGRQR0n/EAmUPpgYpK+CasMWuGdk+zORcUrjngfVEPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYeJI21y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770952184; x=1802488184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Y7Q6Au/X2ZyR/wPpqJXyfm6utcskF47IufYsRLqZL0=;
  b=GYeJI21yyI7mVsU7YfBzH8Rda3Yk1kPyrizbSwsgmyEzuF6qhs7k7g1s
   yF1a23BnqcdaXDBAx4qmkkwejLv4nSwd1y4tAjw+unDopT6KpG4ltza7/
   +bSEf7WBgI79soy4vp4nDW1bTIWXMiy4awkJBujzbvPkQGIitU8v0CnqP
   sBPM8lbH7UyER1Wm0x0zdNzJiOp31ebnN/enD7VMWYO10gduYAeNgE0K+
   iqKqtR5yEXCBLImjAcu/MR3WSkJ/9YYT4Add2Go4hFbylFsqOLynRuU2h
   Q6cB1aNzNgVl3t3Wrw87WSXLmRSDO6ncazTrEk6P0CXyQ2vTY6EZjJ0M3
   Q==;
X-CSE-ConnectionGUID: nAoUEX94TZS9GNWzm7kWZQ==
X-CSE-MsgGUID: CPRYMflwQH+5RRwkUWVQtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="74738759"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="74738759"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 19:09:43 -0800
X-CSE-ConnectionGUID: /j0lBH1YSICoiznS8hw5kw==
X-CSE-MsgGUID: b+eQ2ka0RQya3RN6mumxyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216969781"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa004.fm.intel.com with ESMTP; 12 Feb 2026 19:09:41 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH iwl-next v3] ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()
Date: Fri, 13 Feb 2026 04:09:40 +0100
Message-ID: <20260213030940.1809797-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258550-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1686A132902
X-Rspamd-Action: no action

ixgbe_host_interface_command() treats its buffer as a u32 array. The 
local buffer we pass in was a union of byte-sized fields, which gives 
it 1-byte alignment on the stack. On strict-align architectures this 
can cause unaligned 32-bit accesses.

Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte 
aligned, and pass the u32 member when calling
ixgbe_host_interface_command().

No functional change on x86; prevents unaligned accesses on 
architectures that enforce natural alignment.
 
Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2 -> v3 commit message line wraps
v1 -> v2 change title and concentrate on alignement issue
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


