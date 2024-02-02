Return-Path: <netdev+bounces-68640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD98476D0
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C251628C86F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89171509AF;
	Fri,  2 Feb 2024 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7pBNoka"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EDE151452
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896585; cv=none; b=bDZAsyqB00ZKQwzX/Z5nFJIDLcGi4qK2UYKb5JyuM2QfkA852TryagLu9Gkc4D+K3Ho5t/gjbr/e9mgb+xwBoJT7fxXci+MvmL5GSN+vKz1i91zmZm0W5J7/tF/n1+7VCqRESBXePCX1+1CkNTpsNrODAH+tJOHR2fXhuoTjVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896585; c=relaxed/simple;
	bh=+5O2g97a6Zz2dmzsPNJ5pVCmRHGnumK0hpzwXIqsh34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzumH9XBDjBwGHbyVIeDajDnvbWNVYpdrLEr+04tf2BMTo6Dci9NzTm4dkONnpK0CHMWftg3M1CmJDn9VfWCwMgXvhMt7HvVAl0i+kS8fSeeBnePC7ehfNq3/XIMj/zhbWHAJefuoXqWN8uuCkwRCOPK6UQCsyDiLiFm6BErAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7pBNoka; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706896584; x=1738432584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5O2g97a6Zz2dmzsPNJ5pVCmRHGnumK0hpzwXIqsh34=;
  b=C7pBNokaptZ3YstZgRyReQv51kzOzA91gPcXg62Y2Lu62O82LNfWhgfJ
   Ig/yQMg4akrSto5JTAUnZJt7SjbGFaDRKDbcyAXYVAOMtg9dfD56s20KG
   t5qYC4cb7t/nAfrbkL9cgbfgxW47UPgBndRTSmaBItpS5qj4OknqBGDnr
   lTo+w7uAS3paofXe1I8F+C0vG9ulv/OiXvNgVmOpDQQZ0UCiB5YJKXV/z
   tTW/TCPRyx6hUjRzrYb5XQtwF+VKtteDixuMSaYA2xCiTK+pVipuY/ffU
   6+JAxFUwagCw4HPJ/uOIVaWdKhgD1cgBbqhLfe5HTwJmSTy4utPacOAx4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435347628"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="435347628"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:56:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="137842"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2024 09:56:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 4/4] ice: remove incorrect comment
Date: Fri,  2 Feb 2024 09:56:12 -0800
Message-ID: <20240202175613.3470818-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
References: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

A copy paste issue left a comment for this structure that has nothing
to do with FW alignment; remove the comment.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index c2bfba6b9ead..85aa31dd86b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -64,9 +64,6 @@ static const char * const ice_fwlog_level_string[] = {
 	"verbose",
 };
 
-/* the order in this array is important. it matches the ordering of the
- * values in the FW so the index is the same value as in ice_fwlog_level
- */
 static const char * const ice_fwlog_log_size[] = {
 	"128K",
 	"256K",
-- 
2.41.0


