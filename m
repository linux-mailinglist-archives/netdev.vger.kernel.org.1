Return-Path: <netdev+bounces-136944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7E9A3B5A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62EB1F282E9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDCA202F7C;
	Fri, 18 Oct 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xkd5T+Lj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60C202F67
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246838; cv=none; b=TbvQWYQhZ3ErM8/STMOmIY3UHeAwZs8GGqqs+ocB7I8yQ3J/nXfA5z6z3a7frHRq5/tOs0kWT9/EpIGe9hwMEIByjBvJ4B+oTdxJTQYAnj/hwXUQ9YIXu8Wg89rEcT+prCxDgyoZKen23N41UQtHvoQnEWHeOEN732+2wX6G+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246838; c=relaxed/simple;
	bh=ZW2EzSJRokQnLPyaY8mGK9xmsLMUL0YssPT38U8/Cas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtV9XLLjBVe5mWZm4pzUN1h8656BifJ9TJCqw7/88mCJhag1Us/ESjsfq2U2JPJ/fy9c1sLYnmPKWaI+HI1nDtyNzFmotMOCiTsf+MBXv9blEL8sZaXGLZLQ77esTMvITKTBP8J2iV8WC/0Z+4nj/HHD3iXR/B1wzHSnsylt+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xkd5T+Lj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246837; x=1760782837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZW2EzSJRokQnLPyaY8mGK9xmsLMUL0YssPT38U8/Cas=;
  b=Xkd5T+LjUDwEaTWPOgPxLnDQ1FTDe8TIEVurGVQRHwE1POX9PqRnnQl/
   WUbDC1GtP+FyGvYMnhLU5n5OKoX20fpRZBACK5ZjYPiPCdHK6RFgSKT3E
   UtmY4BDuyFeq+OrAl0dHjIlHk46t/RpcUpA7aUdBO4C8UlFN3kLhCHA4D
   IBY0TLH5Ec5SfFCGr1x2JeK9XhkTTQ0EQeEWrfb5x8qzjG1gFQHZ1yR8P
   q764/P3gLVdYE8b9erunWDf5xAFXZVb2sAhm+CM1Ve/g7Jy93l59KpekT
   C8ysjZi8qMs29zd/9OVRwRULvQ8iYlrzYmhKJ2DJIo+QMER3gN1rx1QZx
   Q==;
X-CSE-ConnectionGUID: sHRavfCqR8aZoaszyI524g==
X-CSE-MsgGUID: yBPO0b4JQeaaG2jlQ2bO8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39401227"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="39401227"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:20:37 -0700
X-CSE-ConnectionGUID: ZafXf2ETTeqAE4EfIP8CRA==
X-CSE-MsgGUID: chSulOJcQpmR9PUxGwbCDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78789315"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 03:20:35 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0259E28169;
	Fri, 18 Oct 2024 11:20:33 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH v1 4/7] devlink: region: snapshot IDs: consolidate error values
Date: Fri, 18 Oct 2024 12:18:33 +0200
Message-ID: <20241018102009.10124-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
References: <20241018102009.10124-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate error codes for too big message size.

Current code is written to return -EINVAL when tailroom in the skb msg
would be exhausted precisely when it's time to nest, and return -EMSGSIZE
in all other "not enough space" conditions.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 net/devlink/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/devlink/region.c b/net/devlink/region.c
index 0a75a2fbd4d7..63fb297f6d67 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -77,7 +77,7 @@ static int devlink_nl_region_snapshot_id_put(struct sk_buff *msg,
 
 	snap_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_REGION_SNAPSHOT);
 	if (!snap_attr)
-		return -EINVAL;
+		return -EMSGSIZE;
 
 	err = nla_put_u32(msg, DEVLINK_ATTR_REGION_SNAPSHOT_ID, snapshot->id);
 	if (err)
@@ -102,7 +102,7 @@ static int devlink_nl_region_snapshots_id_put(struct sk_buff *msg,
 	snapshots_attr = nla_nest_start_noflag(msg,
 					       DEVLINK_ATTR_REGION_SNAPSHOTS);
 	if (!snapshots_attr)
-		return -EINVAL;
+		return -EMSGSIZE;
 
 	list_for_each_entry(snapshot, &region->snapshot_list, list) {
 		err = devlink_nl_region_snapshot_id_put(msg, devlink, snapshot);
-- 
2.46.0


