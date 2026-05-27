Return-Path: <netdev+bounces-292136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCtIIvKaFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:19:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7A5E0591
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03E5E3028CA0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41263090CD;
	Wed, 27 May 2026 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBfv/RhW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90B280A56
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866326; cv=none; b=X2odwE2PFkwFmmiGA4qEbpuz9FVEYYyDqGCC/DRvpTQCDrOa8O8Og2DyALkEkJ8P6ZlN1uv6EKo24fBwf5x1ZvPMIPlJKC7oUVN0St4NnLtsRD5JT3grnMHrNRp3neQVuIlw/gg1pxxmfwnBxL4VE5SDk1QkrPFGzuiwgvsu17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866326; c=relaxed/simple;
	bh=DCJwLVpYE8Oxc/iSi+wYoHkqwCDP0eV6aMqtwc865HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOajmpXoU49Gil/oKsxI7T1CWyJLDd1NFAMd4oBaXC618kTErxxvlLlA3zxJ1dN2NtxJCiYnUqnw0gePj/Z0/ytEUQFbBbUdO4zmbMQKKNt3WFZ3uOuAHDZmxVid26NbhIcIdQYCvH1P6AodLyNp2nHz+GGALHe6iWbFCPQNiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBfv/RhW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779866325; x=1811402325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DCJwLVpYE8Oxc/iSi+wYoHkqwCDP0eV6aMqtwc865HA=;
  b=UBfv/RhWsuZIlEvys7nCRwILjg7SgS85LEHgEJ355cN9uj9BUvFN85u/
   FIp0/BZFZioMixCUGON594UzF+CrYB111veFq+swIz4oa1BJctjapayVn
   ZiWId8UWzWXbBnTYlZ7SGQo8Ox/gjKPC/UCV3GFNXindkrVECjvaIl9RC
   EksGIuPaoQHUmYal114L1RkyzJlYzDY5OFOEiXyxo7ZiSTPL1DyO3pFZM
   r50hO0B5iN7xMvxWUuEMKJnD+livXvS1vdzAZ1qXFTjjWS8uli35EvCE3
   gZekes8KsPwNEu21Nw7MeitAdBeULmgMe7qaQmfWyv6R+2fZMGGO6nJFn
   A==;
X-CSE-ConnectionGUID: /XlhmUYCR16y/1SNVFWkZQ==
X-CSE-MsgGUID: U5cr0jQwRuO2bALDRIMzUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91260980"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="91260980"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:18:44 -0700
X-CSE-ConnectionGUID: DgT+jlcZTZaHuwmRKTntaQ==
X-CSE-MsgGUID: hgnrgZYeQ1KoxJ5R7CrKOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241992124"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 27 May 2026 00:18:44 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net] ice: reject out-of-range ptype in ice_parser_profile_init
Date: Wed, 27 May 2026 09:18:41 +0200
Message-ID: <20260527071842.11478-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-292136-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 32F7A5E0591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

set_bit(rslt->ptype, prof->ptypes) operates on a DECLARE_BITMAP of
ICE_FLOW_PTYPE_MAX (1024) bits. Nothing prevents a malicious VF from
providing ptype >= 1024 through VIRTCHNL, resulting in a write past
the end of the bitmap and a kernel page fault.

Reproduced with a custom kernel module injecting a crafted
VIRTCHNL_OP_ADD_RSS_CFG on E810-C QSFP (8086:1592),
FW 4.91 0x800214af 1.3909.0, ICE COMMS DDP 1.3.53.0,
kernel 7.1.0-rc1.

crash_parser: ice_parser_profile_init @ ffffffffc0d61b60
crash_parser: setting ptype=0xffff (max valid=1023)
crash_parser: calling ice_parser_profile_init -- expect OOB crash!
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
Oops: Oops: 0002 [#1] SMP NOPTI
CPU: 56 UID: 0 PID: 165011 Comm: insmod Kdump: loaded Tainted: G S U OE 7.1.0-rc1 #1
Hardware name: Intel Corporation S2600BPB/S2600BPB
RIP: 0010:ice_parser_profile_init+0x2d/0x1d0 [ice]
Call Trace:
 <TASK>
 ? __pfx_ice_parser_profile_init+0x10/0x10 [ice]
 crash_init+0x127/0xff0 [crash_parser]
 do_one_initcall+0x45/0x310
 do_init_module+0x64/0x270
 init_module_from_file+0xcc/0xf0
 idempotent_init_module+0x17b/0x280
 __x64_sys_finit_module+0x6e/0xe0

Bail out early with -EINVAL when ptype is out of range.

Fixes: e312b3a1e209 ("ice: add API for parser profile initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_parser.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
index f8e6963..3ede4c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -2368,6 +2368,9 @@ int ice_parser_profile_init(struct ice_parser_result *rslt,
 	u16 proto_off = 0;
 	u16 off;
 
+	if (rslt->ptype >= ICE_FLOW_PTYPE_MAX)
+		return -EINVAL;
+
 	memset(prof, 0, sizeof(*prof));
 	set_bit(rslt->ptype, prof->ptypes);
 	if (blk == ICE_BLK_SW) {
-- 
2.52.0


