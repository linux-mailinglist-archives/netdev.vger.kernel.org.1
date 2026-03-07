Return-Path: <netdev+bounces-265013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oSCvLCCHq2mFdwEAu9opvQ
	(envelope-from <netdev+bounces-265013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:02:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D92298E5
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11D683002936
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31A2E1746;
	Sat,  7 Mar 2026 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrK9yoD0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1773E47B
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848921; cv=none; b=JH/0WPkMzsnnKMAyvsY4JG/Sd8bJhShXDviAWmWOPwbdCFLYygcHkV/dpqK8Smy27CL+aTToe46v5TR3vKJevexnqrQb+oBwoBBhbTRZBHOa+wDTxL68Q3LHhsFUnZ5c5wfZ0SjO0JlMKfIteUpCXYtcQ9V+qzXenvcsZp2ZXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848921; c=relaxed/simple;
	bh=jq1XXb3w5dDHDIPGLpDnaXdLQU6hLD53Lqu7W/qctOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVelxWQgLN6acescyvo8PWqskLzWtfYyP48K8+G4gQAZrqDWVnyORUTKStP/ArTlIcsRFDe5oBt5eb6Jm9jcE7dxm2Qo+MyyUSORFEO2SiRtrYTbxohpIvYnxd8Xww4caPzZqZLwb5fFlGIgCuhNgEw1dQHQyV8I8fOeFcq5Ht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrK9yoD0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772848919; x=1804384919;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jq1XXb3w5dDHDIPGLpDnaXdLQU6hLD53Lqu7W/qctOE=;
  b=RrK9yoD007o4AY7Rgpovwz3nGcnAnkvrCEaE7eXzkppMB5y+oIcn3Lof
   0E+BlFEOqEwn1ZzTo7j9fnvmUWYNcd7X8qI83BDcXysI+ZB/vfjmpnO/k
   Za1XiiwyG0KYYlbm4K6KmjzmeS9hmLlQw7wCtFWZSI7tSXKYrhbtS4N//
   /JaMVbXJ+KYA0wJQp8tgRERgywjGEfO0xBnYwGpOwJyOgxq4J5Dzmv7cu
   BXmgYaxVbIY02dFhevpDhOCXy7mMlv2yk5nZrLkpow2oM4iyYPkV3aDUV
   5UW21ZJLgUmt1bpMg7vAzq9aRiDuJZNPO+snTC3V1Zn1rxOuEJ5lmXSjl
   A==;
X-CSE-ConnectionGUID: GpycDPzlSd+WfkanOA4mYA==
X-CSE-MsgGUID: X05hE9edReWwZevXSAo+LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="77839204"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="77839204"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 18:01:58 -0800
X-CSE-ConnectionGUID: GJOabdEYRmC0WpSeHeKghw==
X-CSE-MsgGUID: WPDC6zbAQAmqpcamPC/ELQ==
X-ExtLoop1: 1
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa003.fm.intel.com with ESMTP; 06 Mar 2026 18:01:58 -0800
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan][PATCH iwl-net] idpf: only assign num refillqs if allocation was successful
Date: Fri,  6 Mar 2026 18:12:47 -0800
Message-Id: <20260307021247.1259624-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A08D92298E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265013-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

As reported by AI review [1], if the refillqs allocation fails, refillqs
will be NULL but num_refillqs will be non-zero. The release function
will then dereference refillqs since it thinks the refillqs are present,
resulting in a NULL ptr dereference.

Only assign the num refillqs if the allocation was successful. This will
prevent the release function from entering the loop and accessing
refillqs.

[1] https://lore.kernel.org/netdev/20260227035625.2632753-1-kuba@kernel.org/

Fixes: 95af467d9a4e3 ("idpf: configure resources for RX queues")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 252259993022..f6b3b15364ff 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1860,13 +1860,13 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 			idpf_queue_assign(HSPLIT_EN, q, hs);
 			idpf_queue_assign(RSC_EN, q, rsc);
 
-			bufq_set->num_refillqs = num_rxq;
 			bufq_set->refillqs = kcalloc(num_rxq, swq_size,
 						     GFP_KERNEL);
 			if (!bufq_set->refillqs) {
 				err = -ENOMEM;
 				goto err_alloc;
 			}
+			bufq_set->num_refillqs = num_rxq;
 			for (unsigned int k = 0; k < bufq_set->num_refillqs; k++) {
 				struct idpf_sw_queue *refillq =
 					&bufq_set->refillqs[k];
-- 
2.39.2


