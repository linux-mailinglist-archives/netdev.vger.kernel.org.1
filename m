Return-Path: <netdev+bounces-116282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6477949D11
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655A8B21FDD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622DA1DDEB;
	Wed,  7 Aug 2024 00:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jp14x/pj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6E18EBF
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991017; cv=none; b=Avjeh51m1E86IRl78QnqVNBRuX2CVXYueQCVDLsH+a+YRyw9mALlJm6niPOdvx6f+yvpTub8D3A091PcgCB2/ipnyBDkCxnmj6UhfUNfujk9o/rGMT4jbHvUS0CN8ILQirufofmPyzu0sFUnPQ8DXqTBosdZnNVsn8mXlDomrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991017; c=relaxed/simple;
	bh=YW8OJ6ncs4oJPqe5fuxKSZeeTTvjkAOWYEUbEfU4uus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=agDWu+8s9fDVb+VpcPoc8Lo+Y/TYeowalulzYv4ZwaCry4CYL7D8q/J4Sj9AhNTkfTa4fONOuEnjoMNjpKXl7tqjlnEAeQzC6q5ygaEsl5+i2B0w6hQKulNiBCfHGkBuSo069gURewziqM5WQToH+KhMz/6xmJZH0WzuvFMr9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jp14x/pj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722991016; x=1754527016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YW8OJ6ncs4oJPqe5fuxKSZeeTTvjkAOWYEUbEfU4uus=;
  b=Jp14x/pjsKgkblyT1v1awEnWy9jfrifuPXd1CP2aba7i6VjBIfcpExgv
   YeF4poXVhOHaxTIgRqBLcIW7OvTRhjP+k5NUUm/AlmPdkwlEkABSNqTeR
   569ipKXAls+POPy9SnadwgUHHpSGLRjFY5VfVO3j42/66Ky3EsF3Y9sZx
   slKEB/Z2xmlJPfrKHLac5fEy7GzrMJPRTrrny1u3fXw4ANZ/Db1+tvSQJ
   nnggHK5sWN6ggKwfJUf5JU/0N9dikpWC8VG+TGurl40q/aAS/HKv8iXoP
   PQoT7bl6qDvQbRJqp6Vg35G+6pbFsy+CIPsx2uBSsKn3szhigfKbcItNf
   g==;
X-CSE-ConnectionGUID: DTh/cH8mQFK1H5GhNmxPXQ==
X-CSE-MsgGUID: EieJNDOQROSuQP/4IdMg9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31669754"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31669754"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 17:36:56 -0700
X-CSE-ConnectionGUID: 60BPayseTmqA8079N55kOQ==
X-CSE-MsgGUID: iUVYMvXvTxiTRTw+KfZA7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61497014"
Received: from timelab-spr09.ch.intel.com (HELO timelab-spr09.sc.intel.com) ([143.182.136.138])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 17:36:54 -0700
From: christopher.s.hall@intel.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Christopher S M Hall <christopher.s.hall@intel.com>
Subject: [PATCH iwl-net v1 3/5] igc: Move ktime snapshot into PTM retry loop
Date: Tue,  6 Aug 2024 17:30:30 -0700
Message-Id: <20240807003032.10300-4-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807003032.10300-1-christopher.s.hall@intel.com>
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

Move ktime_get_snapshot() into the loop. If a retry does occur, a more
recent snapshot will result in a more accurate cross-timestamp.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 00cc80d8d164..fb885fcaa97c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1011,16 +1011,16 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 	int err, count = 100;
 	ktime_t t1, t2_curr;
 
-	/* Get a snapshot of system clocks to use as historic value. */
-	ktime_get_snapshot(&adapter->snapshot);
-
+	/* Doing this in a loop because in the event of a
+	 * badly timed (ha!) system clock adjustment, we may
+	 * get PTM errors from the PCI root, but these errors
+	 * are transitory. Repeating the process returns valid
+	 * data eventually.
+	 */
 	do {
-		/* Doing this in a loop because in the event of a
-		 * badly timed (ha!) system clock adjustment, we may
-		 * get PTM errors from the PCI root, but these errors
-		 * are transitory. Repeating the process returns valid
-		 * data eventually.
-		 */
+		/* Get a snapshot of system clocks to use as historic value. */
+		ktime_get_snapshot(&adapter->snapshot);
+
 		igc_ptm_trigger(hw);
 
 		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
-- 
2.34.1


