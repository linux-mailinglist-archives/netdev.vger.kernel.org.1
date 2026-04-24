Return-Path: <netdev+bounces-280963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKCwIzYo62muJAAAu9opvQ
	(envelope-from <netdev+bounces-280963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:22:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC17445B5DF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4245130120C9
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF231691C;
	Fri, 24 Apr 2026 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlXR83Rb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C11A683D;
	Fri, 24 Apr 2026 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018931; cv=none; b=SqWQS2fpNHqnPlrMSlPpZrPQdapdFAkHS6h0ebHYFm+nieEtrEwJ/NLO0Zb/bLmKdPsfdOrjgYBF3Ps5LG6Qk8OdNeRex0Ea8nARz/+I37h4H6Yoa43U5j+G8uKWg5K8WBjjcpN2dOG9vAkyvTpxx1KVL+h8OFF4Kb3HrrEnek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018931; c=relaxed/simple;
	bh=BP1jtlFzuy/jbBYrDe/iU+3cgpfGhVIi+xBQHeCU6P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vA4faMhn7Q4h4W/YlnCitKF6KuzgGo50q5lCLnR+v0ZsPJdhJ0gbMK8e7K2Bg65lTdWrpl0VkpXrZTaztf974vxWFc1Le/GIksfxMtbNcjTrUYhopfAMXWTBbpFSqi9O6Mdp5XxDvOLcSF0JE+3zcVhx5B4AMmvU1UZMjtNjHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlXR83Rb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777018930; x=1808554930;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BP1jtlFzuy/jbBYrDe/iU+3cgpfGhVIi+xBQHeCU6P8=;
  b=nlXR83RbSm+2Fru0p4HzcpVuAYqTE2Uqz7sFMTOmXd2OU9eTNEwVmKaB
   qzPKHGxEKRom1+vPmqqk68EJFIQ04adUfqyPu1dWSUrZvmSjEmunpkRTs
   jv25pr2GuICwdwKMOIV3luBZ1190yYWO6Yuc0Orpyf5Us8r65sRYEOKf4
   eEhQO+vMZaambCt6hqNg5LclUUI0vqllPAELaC35n1W6TCG1oj7q5kb5w
   Ulh1zLlDK/iSkKu9aZYQ1oGolVWqIYOf3Tk+g16pS9CTX8KoZvj2WaK+I
   KKTOHRrb0zuOJ9zVN3dlpDmjjh55Jq4dRfsji8yL/AFkI+RD6iu+0h9xu
   w==;
X-CSE-ConnectionGUID: 30q9tRLfSjW8C7f8XvGDkg==
X-CSE-MsgGUID: e6te3ISYRoG0oVRdWkxHYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89379234"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="89379234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:22:09 -0700
X-CSE-ConnectionGUID: KA9DsLuUT36JWraU6AZaMQ==
X-CSE-MsgGUID: /vhcOBMyRaiY/wX48777yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="228330450"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by fmviesa006.fm.intel.com with ESMTP; 24 Apr 2026 01:22:05 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chwee.lin.choong@intel.com,
	vladimir.oltean@nxp.com,
	vinicius.gomes@intel.com
Cc: faizal.abdul.rahim@linux.intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	khai.wen.tan@intel.com,
	hong.aun.looi@intel.com,
	faizal.abdul.rahim@intel.com,
	KhaiWenTan <khai.wen.tan@linux.intel.com>
Subject: [PATCH iwl-net 1/1] igc: skip RX timestamp header for frame preemption verification
Date: Fri, 24 Apr 2026 15:59:07 +0800
Message-ID: <20260424075907.310456-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC17445B5DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280963-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]

When RX hardware timestamping is enabled, a 16-byte inline timestamp header
is added to the start of the packet buffer, causing FPE handshake
verification to fail.

Because an incorrect packet buffer is passed to igc_fpe_handle_mpacket(),
the mem_is_zero() check inspects the timestamp metadata instead of the
actual mPacket payload. As a result, valid Verify/Response mPackets can be
missed when inline RX timestamps are present.

Pass pktbuf + pkt_offset to igc_fpe_handle_mpacket() so it inspects the
actual mPacket payload instead of the timestamp header.

Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
Co-developed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8ac16808023c..c470d2354ce8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2649,7 +2649,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		}
 
 		if (igc_fpe_is_pmac_enabled(adapter) &&
-		    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf)) {
+		    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_offset)) {
 			/* Advance the ring next-to-clean */
 			igc_is_non_eop(rx_ring, rx_desc);
 			cleaned_count++;
-- 
2.43.0


