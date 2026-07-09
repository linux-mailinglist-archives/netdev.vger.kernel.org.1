Return-Path: <netdev+bounces-306305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HgxjGaHHT2odoQIAu9opvQ
	(envelope-from <netdev+bounces-306305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:09:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A37DA7334E5
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:09:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=l3MnGtDS;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306305-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306305-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA23430CDBA6
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD24192F4;
	Thu,  9 Jul 2026 15:59:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C636A375
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 15:59:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612781; cv=none; b=g9/tl0gcSlGnWKTCdaLXspVWkYDXwTcxlayx4P7d2PHmDCusjifX3YlY5lZGYKi9fILQC9w57ICpc9s/SR9kC12TQ5UMNCj7S92D/OIbhgK9aEJB3Upi27/cu9AG6tHllvosOiCo33izIzhtTq7zh/2VLztgIywCQYeENxK65HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612781; c=relaxed/simple;
	bh=bnDDy05kYz3XkFFSJ+rs21I3F6XQAlDJfnl4nBcLMQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XI/qhjIZ5x1+3pAyTwRLDTtgFuR9SiG0TxQqQM7PI+lIh4jnfFDthfGrwdD7wnTaq+asKQnvdUi603IL97nSiR94x9MpwLfn9MfGyZ9EjrsB9LIs6/+g4n/hQKLNUtTxyCspmSIRoSVR0VqIC6u1sgmZ12RI83+TosrfSaF1XTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3MnGtDS; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783612779; x=1815148779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bnDDy05kYz3XkFFSJ+rs21I3F6XQAlDJfnl4nBcLMQE=;
  b=l3MnGtDSIslkggtJhoYbNbamPeMYuPIncq8eStZSKshCCeEIT6vAT39i
   Yz40LNBb78SIt8lI0FWpVCPl4Lz8wqc+F/INI+8EjzJL6mWyNOXcoqbK0
   bht75rbvTFr5AYLh+JUg0pWC8x2blOk9wYzZrdFrZ0Z70aaH4pthp3+N4
   BRG1f8HwmozMH5qxYYPCY8ekTKLzi0W0I4RHWhhD4RJ7OJMbbe8SlVQbR
   oZtiLWRD2iImRL0Ee+mrqbFogP9fePRTlIp9vFW4UwunkTpACvYrofuvM
   5FWf/JVUJfdzSYg02nl2qJHfAUwCDipM0QSVZC7JUzXyBXgYVQDRT2bTT
   g==;
X-CSE-ConnectionGUID: kKR10I1YTce273I0Z7EPBw==
X-CSE-MsgGUID: Yz9jp4yrTaSJD6/qtGwybg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95671657"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95671657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 08:59:39 -0700
X-CSE-ConnectionGUID: aJOjZyFIRIS4eZj9684RzA==
X-CSE-MsgGUID: l/gfQvLHSou4XVQm3Ltjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="279019819"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2026 08:59:37 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 801AF312C4;
	Thu,  9 Jul 2026 16:59:36 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH iwl-next] ice: fix uninitialized response buffer in ice_acl_create_tbl()
Date: Thu,  9 Jul 2026 16:59:04 +0200
Message-ID: <20260709145904.164375-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306305-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:marcin.szycik@linux.intel.com,m:lkp@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A37DA7334E5

Buffer is uninitialized in error path. Move assignment before goto. This
buffer is only used for response, so its content doesn't matter.

Fixes: d80ee68614c3 ("ice: initialize ACL table")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607022231.FWjSU75X-lkp@intel.com
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
Tony, please squash this with the offending commit. It's not applied
yet, so hash is invalid, but I don't want to resend a ~5000 line
patchset just to move one line.
---
 drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
index a76762e3aa46..4ea08bd9784c 100644
--- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
+++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
@@ -354,14 +354,14 @@ int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params *params)
 		return -ENOMEM;
 	}
 
+	resp_buf = &tbl_alloc.buf.resp_buf;
+
 	tbl = kzalloc_obj(*tbl);
 	if (!tbl) {
 		err = -ENOMEM;
 		goto err_dealloc_tbl;
 	}
 
-	resp_buf = &tbl_alloc.buf.resp_buf;
-
 	/* Retrieve information of the allocated table */
 	tbl->id = alloc_id;
 	tbl->first_tcam = resp_buf->ops.table.first_tcam;
-- 
2.49.0


