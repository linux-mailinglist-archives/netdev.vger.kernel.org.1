Return-Path: <netdev+bounces-134495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD6999D61
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046C1B223DA
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E3019F121;
	Fri, 11 Oct 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjifS32W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D5635
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630227; cv=none; b=oA1tjFuWLr86AWgRRi9swqbKnLB1wPJ2iReea5V2c/Brp6/7dPQBrtSrldgYmrXD8EUuWiLtg3gmQl7Veab/8+oPPscc44jsG3VbHrYunXC6qosqdUc/FB7GUSmt9j5LgbaQCfV2QKAExJZYKgl/eVLoFOfNJXKpCwJUdUM8ByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630227; c=relaxed/simple;
	bh=gIwZN5qhCoc1qKjbX/TX6+2K2sh+0F1AM3i5JM3TVNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6aDQGsQ+65vjBYpAdOOO2Cmy2RXqJjEkpyueFnmq14kRszFEFO3zKoC5Un9Z7amSd7QQk7tq+sYgI4a5HrOihAcyZYtyZihfLzgvORd9Ffu2VaFL9vsee9Y69IG61NX49ffNxDkUElPrUbW8zaxyttrIqsfi/zjdYGftXnZ0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjifS32W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728630226; x=1760166226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gIwZN5qhCoc1qKjbX/TX6+2K2sh+0F1AM3i5JM3TVNw=;
  b=DjifS32Ws2pNNznVbYJeEjIq85L0lPkF/jcquYBpljF5TURWMQNg4vWu
   0co0C4wbiFvpT0tknuW19Z/jDnR0F6pUEghMVFlVTJHrcDzbD07gJeMcJ
   Uk2mvzHWI5t32uneZ0cZm0iQXysv9i81tOrzuzQYWYInFD3Nnszkf1ZeT
   jFxcUOgE5qsR+WLXytCj7PLhJ6eJeBboZrBRUpJxRaaCcFc/lQWWAmHVv
   3dMrApSexKdVB+hO/2mp5bowLEKtjS+UdVoskxbMijEcFA86lkApvgVRe
   m5aHHbiCGcBO/gO6/CcwkgR2A2PMtO/o3jwQhOOBqXozJO1GMgaO1kbN5
   g==;
X-CSE-ConnectionGUID: MHrt19onTJqe1WLS1J/88g==
X-CSE-MsgGUID: p1RU2/wbSfaDh9FOtMhNyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27913403"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27913403"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 00:03:46 -0700
X-CSE-ConnectionGUID: S1xeL+sEQxiAhYSsb1H1mQ==
X-CSE-MsgGUID: MmuDoe7ySnSd4sXEK3Xgyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="100157742"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa002.fm.intel.com with ESMTP; 11 Oct 2024 00:03:30 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	marcin.szycik@intel.com
Subject: [iwl-next v1] ice: add recipe priority check in search
Date: Fri, 11 Oct 2024 09:03:28 +0200
Message-ID: <20241011070328.45874-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new recipe should be added even if exactly the same recipe already
exists with different priority.

Example use case is when the rule is being added from TC tool context.
It should has the highest priority, but if the recipe already exists
the rule will inherit it priority. It can lead to the situation when
the rule added from TC tool has lower priority than expected.

The solution is to check the recipe priority when trying to find
existing one.

Previous recipe is still useful. Example:
RID 8 -> priority 4
RID 10 -> priority 7

The difference is only in priority rest is let's say eth + mac +
direction.

Adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI
After that IP + MAC_B + RX on RID 10 (from TC tool), forward to PF0

Both will work.

In case of adding ARP + MAC_A + RX on RID 8, forward to VF0_VSI
ARP + MAC_A + RX on RID 10, forward to PF0.

Only second one will match, but this is expected.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 79d91e95358c..6a4a11fa5f14 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -4784,7 +4784,8 @@ ice_find_recp(struct ice_hw *hw, struct ice_prot_lkup_ext *lkup_exts,
 			 */
 			if (found && recp[i].tun_type == rinfo->tun_type &&
 			    recp[i].need_pass_l2 == rinfo->need_pass_l2 &&
-			    recp[i].allow_pass_l2 == rinfo->allow_pass_l2)
+			    recp[i].allow_pass_l2 == rinfo->allow_pass_l2 &&
+			    recp[i].priority == rinfo->priority)
 				return i; /* Return the recipe ID */
 		}
 	}
-- 
2.42.0


