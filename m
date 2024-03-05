Return-Path: <netdev+bounces-77636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B287271A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D30028A24C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849E250FE;
	Tue,  5 Mar 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFJ9l5rS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545991B970
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665067; cv=none; b=HO2OL7oGIlidCh+JuuxZlUtmZQeHz/iqtX0LnaFi8k5B6GCqb6M96pa4g6OSgo8XaPNlFrg8+DnxwL0hWYd8iADJrypU9ZRSY4l9a7v3Y+ChOnPDMD+ZrY7yXVNuooUWm+MgmiaQOy48bvPqoFm3WZgvW3rLdp/tKLO89f0oLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665067; c=relaxed/simple;
	bh=uVxx4yocQ8EItWzbBxrhGnJ2xZPjWnnjGd+g2W17m0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGi6EXOChPpfYpTcZyTd9aDuAbJiARrLNL4pQ4zEIC8KZGql+8ENsqEGmnJXHTV0WdGJOWBLEoKh7XGBr8QodmLiokgKKv61/VcZiDML+p7xJXLQ78CHYakQDa6/HOcJVVl3S+Uc/th3TuJ1UTagx7ejsydSp/0/jMO7BgHM15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFJ9l5rS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665066; x=1741201066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uVxx4yocQ8EItWzbBxrhGnJ2xZPjWnnjGd+g2W17m0M=;
  b=oFJ9l5rStgSTsdPOhgpduqC3QXemUPKdW8etN6b6oemb+WheE7QZ0iEu
   sQdnUBqRYdeVpGzzfm2IFkiidlQuVOTmdu9syO29uLnFDVfWRMPxeI243
   Nzi287xlVw4igE95gZqEdmaobLcwAdCmENqmok40m/UB3wI4QdPH9Hm46
   58BTq+1KVeB3rNIZaj80qpU76OmLPcfGZc3yV5KCSGlGnRNDa5T4YcTed
   1TShHfcYCkaGyluVP57hMnJwvX+GDQURHz7NIY0u9Tseeb+dgv3eJQbeg
   /LkHTcTE8GnArGPByoJjVgNmYQwqROTZzKsA5KluPjpYh2TiYjWscFkt0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822194"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822194"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337207"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 3/8] net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()
Date: Tue,  5 Mar 2024 10:57:31 -0800
Message-ID: <20240305185737.3925349-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

The function ice_bridge_setlink() may encounter a NULL pointer dereference
if nlmsg_find_attr() returns NULL and br_spec is dereferenced subsequently
in nla_for_each_nested(). To address this issue, add a check to ensure that
br_spec is not NULL before proceeding with the nested attribute iteration.

Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 59c7e37f175f..df6a68ab747e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8013,6 +8013,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
-- 
2.41.0


