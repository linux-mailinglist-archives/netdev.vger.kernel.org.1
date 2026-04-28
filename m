Return-Path: <netdev+bounces-281955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIB8CPTU8GkSZQEAu9opvQ
	(envelope-from <netdev+bounces-281955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791DE488161
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B1D1307E28E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9A39BFE6;
	Tue, 28 Apr 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwBtRYA/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328C3988F9
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390666; cv=none; b=UEQwpoxq4pFIkWcvummByFgANOAvVx4pkvhdQzKa01kGV6sIn64YZ82IyZAeTM50H/TCpxvxLOaCPx5iigPitNfTF3wiDYSJQo+ILkS/ZBcp+FRk1tPRpxsy9tZYS5X6rq8LKJ4W0duXEhx/RTLsPydAky8YUKahKX4J/L02vGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390666; c=relaxed/simple;
	bh=t2++hBy/s1UT2kTM5XR0hg3O4g/o2Nv9A7linrPucsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8yu02p8ZbFOPMQ7wgYKAQG4mOF06P200QOY8A4x0jO0a+UkmmZ28RiTazgQ6zdV2J8y18qagWH6kNhaQn1ZyMW/iP6J0aYmQd5P0y7HhxS6EmKCPu5M7swB06el2xmRJVPpAHZyW5jMkYfd+x6XO+jc7Sorj7iDFSRJiB9D5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwBtRYA/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777390665; x=1808926665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t2++hBy/s1UT2kTM5XR0hg3O4g/o2Nv9A7linrPucsk=;
  b=nwBtRYA/t/BKO5C6hnLjfWAw36h/NsaT+8+AaKg8+dKviEHlvIAJNowu
   AGDM7DQPLzFxF+LQrWqfN+nLdfZzhu7BA7nz1NhxvUvX55BDmS6wlyjKn
   vAt2OM6KgUOqIG0cKkX/LPNp9tiSbgeR27O0CR2qoPDvsSwyrqS834+9j
   0AGPYodJh3j54catg20YG1R0beNf5OYETZXM0M1xNanT/hOW7b76wt3k6
   Eq4nW0ximHgsK/ay4Ds6c/DZsfZrtvAYavBwD1lSzn8YoTQSgO1FdKTZ1
   2hc8d0GFMjjWwLcRCKSwHwv9lCItMH/bC+PXSfeetgNUSmgHFcPraDV9Z
   Q==;
X-CSE-ConnectionGUID: WIGQUoqpT5GoQV1nsItuAw==
X-CSE-MsgGUID: BtZIiQiHRSmryvKXum0OfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78415117"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78415117"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:37:43 -0700
X-CSE-ConnectionGUID: jsMKO3GZQLS7nDe2H4b2dg==
X-CSE-MsgGUID: ZUMuJShVSS2QzrRXMG7Ejw==
X-ExtLoop1: 1
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2026 08:37:41 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1DD1C312C1;
	Tue, 28 Apr 2026 16:37:40 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	paul.greenwalt@intel.com,
	jacob.e.keller@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 1/3] virtchnl: remove unused defines
Date: Tue, 28 Apr 2026 16:37:14 +0200
Message-ID: <20260428143716.9653-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428143716.9653-1-marcin.szycik@linux.intel.com>
References: <20260428143716.9653-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 791DE488161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281955-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Remove:
* VIRTCHNL_VF_CAP_RDMA
* VF_BASE_MODE_OFFLOADS

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/intel/virtchnl.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/intel/virtchnl.h b/include/linux/intel/virtchnl.h
index 511c8827c640..bb4737de37fe 100644
--- a/include/linux/intel/virtchnl.h
+++ b/include/linux/intel/virtchnl.h
@@ -250,7 +250,6 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
  */
 #define VIRTCHNL_VF_OFFLOAD_L2			BIT(0)
 #define VIRTCHNL_VF_OFFLOAD_RDMA		BIT(1)
-#define VIRTCHNL_VF_CAP_RDMA			VIRTCHNL_VF_OFFLOAD_RDMA
 #define VIRTCHNL_VF_OFFLOAD_RSS_AQ		BIT(3)
 #define VIRTCHNL_VF_OFFLOAD_RSS_REG		BIT(4)
 #define VIRTCHNL_VF_OFFLOAD_WB_ON_ITR		BIT(5)
@@ -275,10 +274,6 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_QOS			BIT(29)
 #define VIRTCHNL_VF_CAP_PTP			BIT(31)
 
-#define VF_BASE_MODE_OFFLOADS (VIRTCHNL_VF_OFFLOAD_L2 | \
-			       VIRTCHNL_VF_OFFLOAD_VLAN | \
-			       VIRTCHNL_VF_OFFLOAD_RSS_PF)
-
 struct virtchnl_vf_resource {
 	u16 num_vsis;
 	u16 num_queue_pairs;
-- 
2.49.0


