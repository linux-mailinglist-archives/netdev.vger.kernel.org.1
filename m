Return-Path: <netdev+bounces-180216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5AFA80AE1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB58A46A6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A327781A;
	Tue,  8 Apr 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhlnSiWP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835826E178;
	Tue,  8 Apr 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116512; cv=none; b=b5pkRkF+sBuAQaNKqC2cd1Lhf32ZQ+fP5+R8GoDSViO5zk41p1hlW42hcAo5jzL4CRo6Kz0djEnFxnNSHafQVucuXCOoa1cI9OSH+uBLjVy2v9oqHdV4pKlyzYIGhtHee55177d4tyKFRErPHHs9nNzseNr9gZgkL/pjbrhHzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116512; c=relaxed/simple;
	bh=zFiAG/U3+wZ83wfPMHEdhI8caLlxVdJcAyBkqGn8sjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXqWlvOaDXbbJPFKLnM4F0zVzkqS+K9W58MJjija3iRHy8b2zJssQPGrkIH8j1DALw/nCLGf7yeycwWi28JvAgpvPVBj4lyWnwJAtKwnhPS0Vtexno7MEkABE5/k+QN82ANZKrsDYRLkU5lLUnWib9oT2T4l+U6YpMeoVaJZTHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhlnSiWP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744116511; x=1775652511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zFiAG/U3+wZ83wfPMHEdhI8caLlxVdJcAyBkqGn8sjc=;
  b=mhlnSiWPi9K4lQCB6rfyUm9skh9d8UfTempV0mWBXfSVkRXQfzlXs4Hl
   J9zDRUnkveQERFrAaahyuqKgE3x8pH3QY7mbMneDqA5JNdwaMOS+YBMfq
   jwkvbNcYqNivsMEczw3XEme04YnUPLv6P0lMXNRqVZ7h3lXwn1KIjGEQ7
   0zsR/88icrW4Zzzmychfrs4z14dhKm82P43gPdFDrO+/TB8QK2BBb7RNQ
   X3ZqOqOnRaChgr2OaLwaZxIaGTOA1ivw40Wx/YVoV59CZvJ1D1OKkyS43
   FSPgsaPQ55BbMgnmRF3qTyN8ssGJrvdHvNBIVvVq99a+/LhcfCYz2kOj8
   A==;
X-CSE-ConnectionGUID: u1Id/8fsR/GdK7RZeKbd+A==
X-CSE-MsgGUID: /fgKj46oS8qUs+I0p2JeFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56184833"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="56184833"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 05:48:31 -0700
X-CSE-ConnectionGUID: DDEQkvBpThKCIgPmQEMIUg==
X-CSE-MsgGUID: yXrpilqDRjaJZELGWmi6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133130645"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Apr 2025 05:48:24 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BE58634316;
	Tue,  8 Apr 2025 13:48:21 +0100 (IST)
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
	Mustafa Ismail <mustafa.ismail@intel.com>,
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
	Wenjun Wu <wenjun1.wu@intel.com>,
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
Subject: [PATCH iwl-next 02/14] virtchnl: introduce control plane version fields
Date: Tue,  8 Apr 2025 14:47:48 +0200
Message-ID: <20250408124816.11584-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250408124816.11584-1-larysa.zaremba@intel.com>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
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
index 63deb120359c..0f31d65823f2 100644
--- a/include/linux/intel/virtchnl2.h
+++ b/include/linux/intel/virtchnl2.h
@@ -467,7 +467,8 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_version_info);
  *			    sent per transmit packet without needing to be
  *			    linearized.
  * @pad: Padding.
- * @reserved: Reserved.
+ * @cp_ver_major: Control Plane major version number.
+ * @cp_ver_minor: Control Plane minor version number.
  * @device_type: See enum virtchl2_device_type.
  * @min_sso_packet_len: Min packet length supported by device for single
  *			segment offload.
@@ -516,7 +517,8 @@ struct virtchnl2_get_capabilities {
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


