Return-Path: <netdev+bounces-138241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE49ACADC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635F01C20F2D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812911BFE03;
	Wed, 23 Oct 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkghVTV8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B31BD004;
	Wed, 23 Oct 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689214; cv=none; b=gUajNyTh9a/BpAHjnpvApx862fbzy0EOelgEIUt0VpEKXK+SKiC8SkhyrjDic6j53Oq2BUZmh/v4JbIopgMqdG0CWFYySpvKxDTnPp75KhHt2+WiJBhKwvAJj7/2t63Vouhp+csnyZk9VGU+oKz2G/XOdee0zNhbzTxHpL2QsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689214; c=relaxed/simple;
	bh=unRzvrZVN7bDLtZgI9ZhS6/GXEaHrzbC4SBPnYwEXx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEu0rb39SKeZRqmhDkRY65PqDj4iT3GS7HcrWUcwsWg8bEuJoFyQr1DpcKO6GlzQXojavHuA0FJYSAmSzrk2/YlyjmcV1mj2m8QOeYqMoPzEvb3L+hH+c/4b/G22waeUWAuJHBoFd7a+LUEXvuoubIgTbj5UfdJv/+M3yvxMFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkghVTV8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729689213; x=1761225213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unRzvrZVN7bDLtZgI9ZhS6/GXEaHrzbC4SBPnYwEXx4=;
  b=bkghVTV8RakkAQdOTuWfGlQVD2GV1PW/P4suowYQRGJ485Jy0AYYBkqD
   NiBFfNjfe6+ClIw+eNPdAhcNbSpfKL2/avdl8Ui+Gvljnn+Svez2Enjw7
   gIgILqZSkDQgC6ghvq0nHWIUkION64jeritXntxlmN5XtlHK8U80U9lcx
   JRRSo+LfSl8pac1uzCKjLS1/uWKzQa+5RROBhvNpi/59DY//XTwJUY3gx
   OJBB2twP94MCrFViv5T5Y6qEXYG/XR8zItw1cGw4vs2NsIfnbAc+pUxZ+
   WV8JkQnWGz4Btig8+TUE+/sUTwSMlAelmag0ZpayL1z+1Ue5rpGLGsi+N
   Q==;
X-CSE-ConnectionGUID: RnD+v+yyT2a6wIN6Rzav0w==
X-CSE-MsgGUID: ZeFcjIg4SXithTpmSWaWaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46758583"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="46758583"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:13:32 -0700
X-CSE-ConnectionGUID: +HMFn9NdRLiv9YYZShutOg==
X-CSE-MsgGUID: fWg2WaUtSbuNLBo3+yFOgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84820121"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 06:13:29 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.71])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9883A2877D;
	Wed, 23 Oct 2024 14:13:26 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v2 4/7] devlink: region: snapshot IDs: consolidate error values
Date: Wed, 23 Oct 2024 15:09:04 +0200
Message-ID: <20241023131248.27192-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
References: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
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


