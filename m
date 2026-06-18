Return-Path: <netdev+bounces-300526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C383DKtFNGoPTgYAu9opvQ
	(envelope-from <netdev+bounces-300526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:23:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DE06A2562
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:23:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=B0HYO1WF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300526-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300526-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4721F300DE2A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D402DC76C;
	Thu, 18 Jun 2026 19:23:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200A24E4A1
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 19:23:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810600; cv=none; b=HRdBksUL/+0eq9Z/zLiLT9QSpAlsKlO81z5j4v9ZP458xW+0nInd+Mo1olIJzOtkR4x7UGtBpfz2ZJvc7WUt91YJ1m2UUSe4f/ucBB8ZG2I6lkjJYY9oL+bgd209rw6vDfWCuIeF8joTr/yTOeYOFono5+aX/us6yAvZLO21wC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810600; c=relaxed/simple;
	bh=yapDqlQRJ9ZB+JbdsgpGx4YyzPxiAey0/KwVVRn924g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ssi1FWy2GeNRML7LC4NPtKaaovJfpxpUIde45HvmhKhE/r3lSsuugMts84ny2ibNT5B5FTF1sAmYdGM7hcglD7S3Ck3iWLsJDmz3SCRMiVgR7Rp5yyCzBYK2UMr8zhK/A5ct+nrDLQfoms+G9cBOwGUA+G6oodHAnWBf71fWOV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0HYO1WF; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781810599; x=1813346599;
  h=from:to:cc:subject:date:message-id;
  bh=yapDqlQRJ9ZB+JbdsgpGx4YyzPxiAey0/KwVVRn924g=;
  b=B0HYO1WFYeYlax0A9u9YhAL0Him++HICumFR9yhF/OsUqiD8+eA3f+fU
   GMLtjz6JdU3aITeGnEv4BKyewzoMlqmJSL5aTOflp4N+ShhVtRcvdxnav
   QmS8/VusGovvpOMQlJMr8kfufT32V578kwGcp18B4cHExY8veFNqNnEkh
   82Mr++IhA8YaHJKr70xluvtMRc4JkaItEhtOs/S8Cy2NHyC4WgTu6cmtB
   jVheimdVkL0lP/OfjO+KGhZZSodiWBvpNglwTbjRYt73Ur/G0JMlTTqJq
   wb3er4uJbXjyOEa9MnXQ+2eIOVaYiLiIo2cugRqYz3lwgP956GKi6iyCn
   w==;
X-CSE-ConnectionGUID: CBV+WmPWSCiKiDKP/ACpIw==
X-CSE-MsgGUID: 6YXP9V78RIuv6HS2mNkN5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86505719"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="86505719"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 12:23:18 -0700
X-CSE-ConnectionGUID: FVhhM8NcSvGX2HU96GXQ8g==
X-CSE-MsgGUID: XVgSdvjZRHC7GrD+ZJ4K2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="278629701"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa002.jf.intel.com with ESMTP; 18 Jun 2026 12:23:18 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	madhu.chittim@intel.com
Subject: [PATCH iwl-net] idpf: fix max_vport related crash on allocation error during init
Date: Thu, 18 Jun 2026 12:23:25 -0700
Message-Id: <20260618192325.8694-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:madhu.chittim@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82DE06A2562

Set adapter->max_vports only after successful allocation of vports, netdevs
and  vport_config buffers. This fixes possible crashes on reset or rmmod,
following failed allocation on init

[  305.981402] idpf 0000:83:00.0: enabling device (0100 -> 0102)
[  305.994464] idpf 0000:83:00.0: Device HW Reset initiated
[  320.416872] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  320.416918] #PF: supervisor read access in kernel mode
[  320.416942] #PF: error_code(0x0000) - not-present page
[  320.416963] PGD 2099657067 P4D 0
[  320.416983] Oops: Oops: 0000 [#1] SMP NOPTI
...
[  320.417093] RIP: 0010:idpf_remove+0x118/0x200 [idpf]
[  320.417130] Code: 8b bb 98 09 00 00 e8 17 0f 5b e5 48 8b bb e8 08 00 00 e8 0b 0f 5b e5 66 83 bb 28 06 00 00 00 48 8b bb 20 06 00 00 74 49 31 ed <48> 8b 04 ef 48 85 c0 74 2f 48 8b 78 20 e8 66 58 91 e5 48 8b 83 20
[  320.417183] RSP: 0018:ff7322212903fdb8 EFLAGS: 00010246
[  320.417205] RAX: 0000000000000000 RBX: ff4463de40300000 RCX: ff7322212903fd4c
[  320.417228] RDX: 0000000000000001 RSI: ffffffffa7f7d100 RDI: 0000000000000000
[  320.417250] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[  320.417272] R10: 0000000000000001 R11: ff4463de3a638f58 R12: ff4463be89ac7000
[  320.417294] R13: ff4463be89ac7198 R14: ff4463be94fc7198 R15: ffffffffc0f10f20
[  320.417317] FS:  00007f963c0e6740(0000) GS:ff4463fdd65d8000(0000) knlGS:0000000000000000
[  320.417342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  320.417362] CR2: 0000000000000000 CR3: 00000020ba674002 CR4: 0000000000773ef0
[  320.417385] PKRU: 55555554
[  320.417398] Call Trace:
[  320.417412]  <TASK>
[  320.417429]  pci_device_remove+0x42/0xb0
[  320.417459]  device_release_driver_internal+0x1a9/0x210
[  320.417492]  driver_detach+0x4b/0x90
[  320.417516]  bus_remove_driver+0x70/0x100
[  320.417539]  pci_unregister_driver+0x2e/0xb0
[  320.417564]  __do_sys_delete_module.constprop.0+0x190/0x2f0
[  320.417592]  ? kmem_cache_free+0x31e/0x550
[  320.417619]  ? lockdep_hardirqs_on_prepare+0xde/0x190
[  320.417644]  ? do_syscall_64+0x38/0x6b0
[  320.417665]  do_syscall_64+0xc8/0x6b0
[  320.417683]  ? clear_bhb_loop+0x30/0x80
[  320.417706]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  320.417727] RIP: 0033:0x7f963bb30beb

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index be66f9b2e101..dc5ad784f456 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3555,7 +3555,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 
 	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
 	num_max_vports = idpf_get_max_vports(adapter);
-	adapter->max_vports = num_max_vports;
 	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);
 	if (!adapter->vports)
 		return -ENOMEM;
@@ -3576,6 +3575,12 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		goto err_netdev_alloc;
 	}
 
+	/* Set max_vports only after vports, netdevs and vport_config buffers
+	 * are allocated to make sure max_vport bound loops don't end up
+	 * crashing, following allocation errors on init.
+	 */
+	adapter->max_vports = num_max_vports;
+
 	/* Start the mailbox task before requesting vectors. This will ensure
 	 * vector information response from mailbox is handled
 	 */
-- 
2.37.3


