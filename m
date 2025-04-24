Return-Path: <netdev+bounces-185509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A880A9ABF2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CE092812A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EFE22D7AE;
	Thu, 24 Apr 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hA70XkHh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799422ACFA;
	Thu, 24 Apr 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494377; cv=none; b=CK6gOiwUXuELYAqKaYx2Xf/hP9ry4euaQMM3XmJSpIM7r6+9wtiA4Dgnh4VIO78evUjWbjNIutU5pzpp/B2BVirI48ZI6Pv7Wke+Po6/EJT7KYoirPqDTR6UlQH3q1kWWbq0++FSXava2eNtus6tL9D7q68NbBZk5kX9slf3Xwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494377; c=relaxed/simple;
	bh=+yw0+21GJfw/AyHHlGUOw6Yqnou/jCHKGvK5xx0JRxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MukhfDillt4qw0pBs7w1Nulg0u+I89DCBxP08LiKbZIELT3s+RCjLsj6RTACKreaSdFC8e+6z0jCr6iXwiKwLfT0jRGK4TLRn4x+1+09/31RB+DTTFprmL+G3mFmhiKI1OrEYWAWWj6o13Z5dHpIBE28e5ZEDMUPO6Pqo99mj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hA70XkHh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745494375; x=1777030375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+yw0+21GJfw/AyHHlGUOw6Yqnou/jCHKGvK5xx0JRxs=;
  b=hA70XkHhv9hIS+gS8RGou0uiBrU0LfqNSWhr3nKO3EyuAp2u4hIh1NJ+
   7JdLvw0hAR+EffOFnDJ82joS+7VX8ATjnnd41Xe3JJpjUq1RR6q8k31x7
   3lOT8TjZbcZTfDYz0dXyFJKnxzaK4OVyTfbZ7NjnmutGYWp2RSg87XVLc
   hMbd3n1mAZDrK62ae5hMF9kwjW1xuRmrB6pPb3U8yGDRyUKaldAz4rkCk
   kgsF0fKRewwU5BP7Hlzw+muNrTLuugtx6nEb4A1s24Np/UKI+5JI8iztP
   jf2HbfrckguKEaU68X71uxffVRLYjc0+hrji/JW9WjZo7U9H2fJBkaph5
   Q==;
X-CSE-ConnectionGUID: Fua5yCvFQdmqkstG8Hpx/Q==
X-CSE-MsgGUID: pa14OjLzTU+W8lccklyuSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57771167"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="57771167"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 04:32:55 -0700
X-CSE-ConnectionGUID: TgJixxFGTGSoqmMrtqn4mA==
X-CSE-MsgGUID: 8NnDoD27TmOUG1K5gYmN1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137389356"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 24 Apr 2025 04:32:49 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DDB3033EA3;
	Thu, 24 Apr 2025 12:32:46 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: [PATCH iwl-next v2 02/14] virtchnl: introduce control plane version fields
Date: Thu, 24 Apr 2025 13:32:25 +0200
Message-ID: <20250424113241.10061-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250424113241.10061-1-larysa.zaremba@intel.com>
References: <20250424113241.10061-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Raj <victor.raj@intel.com>

In the virtchnl header file, add the Control Plane software
version fields.

Signed-off-by: Victor Raj <victor.raj@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 include/linux/intel/virtchnl2.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/intel/virtchnl2.h b/include/linux/intel/virtchnl2.h
index 11b8f6f05799..34f4c73d8325 100644
--- a/include/linux/intel/virtchnl2.h
+++ b/include/linux/intel/virtchnl2.h
@@ -477,7 +477,8 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_version_info);
  *			    sent per transmit packet without needing to be
  *			    linearized.
  * @pad: Padding.
- * @reserved: Reserved.
+ * @cp_ver_major: Control Plane major version number.
+ * @cp_ver_minor: Control Plane minor version number.
  * @device_type: See enum virtchl2_device_type.
  * @min_sso_packet_len: Min packet length supported by device for single
  *			segment offload.
@@ -526,7 +527,8 @@ struct virtchnl2_get_capabilities {
 	__le16 max_tx_hdr_size;
 	u8 max_sg_bufs_per_tx_pkt;
 	u8 pad[3];
-	u8 reserved[4];
+	__le16 cp_ver_major;
+	__le16 cp_ver_minor;
 	__le32 device_type;
 	u8 min_sso_packet_len;
 	u8 max_hdr_buf_per_lso;
-- 
2.47.0


