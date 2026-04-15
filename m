Return-Path: <netdev+bounces-278739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEWgNT1n32lSSgAAu9opvQ
	(envelope-from <netdev+bounces-278739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:23:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B04033AB
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 110D23030CBF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513873446AB;
	Wed, 15 Apr 2026 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbFqk5jQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652B329E6A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248635; cv=none; b=SiZGHqtkho+35nuCy3VCgP4awJcZBS6k1qGmJpbkcTDQf1Ez2LLmeVDwTZv8mKp3dbxiOgkZ6TcMXI/Riw8dmOWjl8SReYuYsuGlidTBVeOAHo6Mm83ZNJfe4JSKsBXquyZrlXaznQypIpIM3ZUKp7DX5CPrZjixC/VgYCjqZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248635; c=relaxed/simple;
	bh=RI7GZLwAPyKhQuIOqJMMLP8rUZ4YP6XPSWVDe77lQyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIHPZGoY+IJgB+vigWRzdE0poF4fYxbdIlUpbzCDNzG/fOq11OcWPkPX2vNfQ355EISbvT9jn2nAe1amf6m04isBTyqYM065u1DrM0fqyRal4Xy8KXI0NueQ0Yfjp1y7F2dFv/RWnKdiFNLzLLzTePmDuT97+m1CEhEm/Cdb8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbFqk5jQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776248633; x=1807784633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RI7GZLwAPyKhQuIOqJMMLP8rUZ4YP6XPSWVDe77lQyM=;
  b=KbFqk5jQWPwZwoQCPQmOg0aZ4O/VN4QjYUzsMFwRSY/Zj/RxLZlEpuvw
   9SI1vtobDzwriTtsiWVW1F40WcrIg+HPujfXUdM8ByG/MhPdUoOo803Vn
   /N9SW8SNUE2uldAcf2tiTaWaq4gI5HPodHgqoFmucwrfleYbYtVQvjxV9
   EKd4bSfE2dtHgRMEcfXeDMU4cc4Dxld27QUb1D0RT5oiT4RKPJPSkDAhk
   3aSnNdAwd87jJMqwCxDlyABe2ran8AL08p04Gkhg4zC4MbrG3SvngApxq
   358q6KVmMs8XFKwy43FY3SmC+Bp0NLf8JiDo577Y7/lxFVZCoMcXUDl/d
   Q==;
X-CSE-ConnectionGUID: w95UjW4NQIe4cSUKl5axqg==
X-CSE-MsgGUID: 9ZlmkPecRB6n41xIUye6DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76253154"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76253154"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:23:53 -0700
X-CSE-ConnectionGUID: 34/ajm2JRGOTrYgteCUN6g==
X-CSE-MsgGUID: 7zUJ4OEwQZys7s3FOThcKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227195533"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2026 03:23:51 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] i40e: set supported_extts_flags for rising edge
Date: Wed, 15 Apr 2026 12:25:05 +0200
Message-ID: <20260415102511.1560665-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278739-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 1A2B04033AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The i40e driver always supported only rising edge detection, so
advertise PTP_RISING_EDGE, and PTP_STRICT_FLAGS to ensure the
PTP core properly validates user requests.

Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 7d07c389bb23..c4525bfab09c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -1344,6 +1344,8 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
 	pf->ptp_caps.n_ext_ts = 2;
 	pf->ptp_caps.pps = 1;
 	pf->ptp_caps.n_per_out = 2;
+	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
+					     PTP_STRICT_FLAGS;
 
 	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
 					       pf->ptp_caps.n_pins);

base-commit: d4999456017dd09ff5f7a34e236c471560d8f8e4
-- 
2.43.0


