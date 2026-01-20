Return-Path: <netdev+bounces-251634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEINE5MMcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:15:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E214D9D7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D5EE94E508
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAD33E8C66;
	Tue, 20 Jan 2026 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5UhT/Qc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4743AA185
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949094; cv=none; b=Ont4mAGu+U05g6rFaRsM+6q+cVRpYtzh0R0l1ZngFKDaiGINXLRufAVIzGSE8N0+xlC/8yqxd4QvMg9ZwjffDu97AY4EUfsmS1FLYlJoGR3UEk0MVxxGdoIOkKEPMWqoVS71+ZIcie89mDiyegB9CyKD3qEy83VYqZSUDPlhJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949094; c=relaxed/simple;
	bh=TsPt1eC92LwDiDmHiQWnyP/dRc7UUsYqFrlTHZ9iGO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szEYYNg9YPrbAM+DfXnEEK2m6MpWFdpJ+zcFUNZ+1OxAt/ntGQPqoG5Jf4+1xX73M9vGtXWdHBBtwC5ToF9zPZ6NI4h7vAhqTisLPISKnuUjV5YTpmrJ/ZAKwynSODoRzfcskKYhAXDCKuHQ+Zp2Btjy6+0pc4xSunPj5znn9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5UhT/Qc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768949089; x=1800485089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TsPt1eC92LwDiDmHiQWnyP/dRc7UUsYqFrlTHZ9iGO4=;
  b=Y5UhT/QcKOfhDMMnM34kFNZhH5Rt9FKfZsfRCGQTxGPrWynzpjjRvSxK
   ylfdcFBmcDV5+3Wu8zypF1fhNLGLuVwpNfBeICa9CYRmj1UQVQmq868YO
   nhZ+b3zBgDapVISkmFHmbziJVefDjRqzyHloLTrJuXoVlFObjLBxI5aPV
   KPmdsnD+AXCeLTnKZNHIRcaQwCVzFZiS7QiMS5ilzVPxDfBglAcDXnBas
   a8fWaw9gM4nWL6yyOw3iKsrn2vdZkG521R4G3md9s7xex++JLiBWSOdaH
   eMTzWq1xmzx4CgSRMrMurTMuMzU78nLBvjsNdSyJ0rwsnxI3rsoIhVZpM
   A==;
X-CSE-ConnectionGUID: oDOnvoVaRW23wb4oh+87Xg==
X-CSE-MsgGUID: ycuuCKQxSHuZv1bW5F6QzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81548799"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81548799"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:44:38 -0800
X-CSE-ConnectionGUID: VwuNVDBPQNykFWkgVGm5xg==
X-CSE-MsgGUID: x7+yY+X7QOqazWWL7jsIcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236920156"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 14:44:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/4] ice: add missing ice_deinit_hw() in devlink reinit path
Date: Tue, 20 Jan 2026 14:44:26 -0800
Message-ID: <20260120224430.410377-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
References: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mpg.de:email]
X-Rspamd-Queue-Id: 10E214D9D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

devlink-reload results in ice_init_hw failed error, and then removing
the ice driver causes a NULL pointer dereference.

[  +0.102213] ice 0000:ca:00.0: ice_init_hw failed: -16
...
[  +0.000001] Call Trace:
[  +0.000003]  <TASK>
[  +0.000006]  ice_unload+0x8f/0x100 [ice]
[  +0.000081]  ice_remove+0xba/0x300 [ice]

Commit 1390b8b3d2be ("ice: remove duplicate call to ice_deinit_hw() on
error paths") removed ice_deinit_hw() from ice_deinit_dev(). As a result
ice_devlink_reinit_down() no longer calls ice_deinit_hw(), but
ice_devlink_reinit_up() still calls ice_init_hw(). Since the control
queues are not uninitialized, ice_init_hw() fails with -EBUSY.

Add ice_deinit_hw() to ice_devlink_reinit_down() to correspond with
ice_init_hw() in ice_devlink_reinit_up().

Fixes: 1390b8b3d2be ("ice: remove duplicate call to ice_deinit_hw() on error paths")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index d88b7f3fd1f9..2ef39cc70c21 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -460,6 +460,7 @@ static void ice_devlink_reinit_down(struct ice_pf *pf)
 	ice_vsi_decfg(ice_get_main_vsi(pf));
 	rtnl_unlock();
 	ice_deinit_pf(pf);
+	ice_deinit_hw(&pf->hw);
 	ice_deinit_dev(pf);
 }
 
-- 
2.47.1


