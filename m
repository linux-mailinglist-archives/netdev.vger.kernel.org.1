Return-Path: <netdev+bounces-268744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ObTMl3FuWmcNQIAu9opvQ
	(envelope-from <netdev+bounces-268744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:19:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDB2B293C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 22:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E05D2304D835
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FEF3921CA;
	Tue, 17 Mar 2026 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZy0KAg7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E13914FA
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782362; cv=none; b=O6W4JGdp2JlecV0gXIgdIkEA04+WOkVI3i/fgeF2qVwbaoEfpzR4bWMil7DLhyIir6bPiJW+3QG6jauifs2hFz7R+7sPZ70NsNGI1mt8uRCMaAoDG8/i8dcTTa3pylr1wNh4KdcGEDxPMHbXnWyGV53c+FWIAUCH62AlvgpSOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782362; c=relaxed/simple;
	bh=mFDqRGWSul6IFi1QO9DcwIsjkZccBYLtZgN+oJkPCSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jl+oonKfu0JIoAHYnhPDRPUn2RrVh5VQ5hri8WeOa/4JzAs0GHKNHnc2KwVJYHYwT6zwS+yzeo0JqiRT94fdu1XlBf49LCcOg7jPTPnm2Um/63NRyYkSvDvgeWui+KYcrUJ/R00xWwVS/ihsN/y3jzHkQVxZPiDq/i/q32PKnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZy0KAg7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773782361; x=1805318361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mFDqRGWSul6IFi1QO9DcwIsjkZccBYLtZgN+oJkPCSc=;
  b=KZy0KAg7Ue2uGJ9xODIJQACohhGxs2OzlL7VxfEO5H8qygmb+E6FE8Ah
   WHocNdFJWBhTpIaR7onRcTQ8lJKfNXf4Hy+3beP/5Ob5A2fxKCn4+fs7a
   LvSBK4E9Bro7zIg/eVBP5mujv4V2L6sSoKo279AEZ9bNJaYkAm6+JmCWz
   Bjoql4TvBGWw6TiYrU16LJtlaaGdOD7vB1qd3UlngD0QkSwAA7cheDrxE
   eIUOZQrjobbg00TBmeq7rTMdARMPySyfFJ5SN2lWnF12Yya4QxOCK4/7s
   ErZamH/kM2V+4JH8K+Fw2rWflz22Qtbz8WdGhJ9nAj74wS/4EJvXL8W4A
   Q==;
X-CSE-ConnectionGUID: YWcj6bVvTpS03idxSb3ZjA==
X-CSE-MsgGUID: fLhuEkBQSBeQbvX8c2WKsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85524792"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85524792"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 14:19:14 -0700
X-CSE-ConnectionGUID: JownytaYR8Ot0xkgM8kD9w==
X-CSE-MsgGUID: V33f7NwDQn6iep6ZjeeQZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="219477598"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 17 Mar 2026 14:19:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/4] iavf: fix VLAN filter lost on add/delete race
Date: Tue, 17 Mar 2026 14:19:04 -0700
Message-ID: <20260317211906.115505-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260317211906.115505-1-anthony.l.nguyen@intel.com>
References: <20260317211906.115505-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268744-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75DDB2B293C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Petr Oros <poros@redhat.com>

When iavf_add_vlan() finds an existing filter in IAVF_VLAN_REMOVE
state, it transitions the filter to IAVF_VLAN_ACTIVE assuming the
pending delete can simply be cancelled. However, there is no guarantee
that iavf_del_vlans() has not already processed the delete AQ request
and removed the filter from the PF. In that case the filter remains in
the driver's list as IAVF_VLAN_ACTIVE but is no longer programmed on
the NIC. Since iavf_add_vlans() only picks up filters in
IAVF_VLAN_ADD state, the filter is never re-added, and spoof checking
drops all traffic for that VLAN.

  CPU0                       CPU1                     Workqueue
  ----                       ----                     ---------
  iavf_del_vlan(vlan 100)
    f->state = REMOVE
    schedule AQ_DEL_VLAN
                             iavf_add_vlan(vlan 100)
                               f->state = ACTIVE
                                                      iavf_del_vlans()
                                                        f is ACTIVE, skip
                                                      iavf_add_vlans()
                                                        f is ACTIVE, skip

  Filter is ACTIVE in driver but absent from NIC.

Transition to IAVF_VLAN_ADD instead and schedule
IAVF_FLAG_AQ_ADD_VLAN_FILTER so iavf_add_vlans() re-programs the
filter.  A duplicate add is idempotent on the PF.

Fixes: 0c0da0e95105 ("iavf: refactor VLAN filter states")
Signed-off-by: Petr Oros <poros@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7925ee152c76..dad001abc908 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -757,10 +757,13 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		adapter->num_vlan_filters++;
 		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	} else if (f->state == IAVF_VLAN_REMOVE) {
-		/* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
-		 * We can safely only change the state here.
+		/* Re-add the filter since we cannot tell whether the
+		 * pending delete has already been processed by the PF.
+		 * A duplicate add is harmless.
 		 */
-		f->state = IAVF_VLAN_ACTIVE;
+		f->state = IAVF_VLAN_ADD;
+		iavf_schedule_aq_request(adapter,
+					 IAVF_FLAG_AQ_ADD_VLAN_FILTER);
 	}
 
 clearout:
-- 
2.47.1


