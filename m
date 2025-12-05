Return-Path: <netdev+bounces-243754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC3CA76DC
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 12:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56A8139B6861
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E518314A70;
	Fri,  5 Dec 2025 08:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973197.qiye.163.com (mail-m1973197.qiye.163.com [220.197.31.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136792F5302;
	Fri,  5 Dec 2025 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922621; cv=none; b=hBVl9P4xqpiu3VpFUvKvVl2HxMVbEqkBSpcFwtKqW3MK2WZHoSWU4OzwDt4AAZY1/7VkdYAeTVqbuPAkxA/PLJEUyos+PKoOxcae92ea9TzVdS8M+jRkU+tO9S1Wpe5S2vjRHKEiP1GEfUEJ+KpmEHMRdv/DoRsAXdiBgelwcz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922621; c=relaxed/simple;
	bh=213aPg+MTy5ploHvvyPVKXza+VzYgfWgJGpPvO/9R0Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=m7xSHpom2PpaSM5cCZE0nnvVzTqSx9QUB+SAi9OFg15yvFAbecnQP6Zn2+K1roOVn+2FgurZDKEWeZ5X0ZAjWd/TYcOR9wXtHxSI0BLn7pmcvGsw2WGV3BUJn/ORuDIZOYxgzpHEboO07qKGn6SxdJI1bEGOt58fFCIeiUOnIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=220.197.31.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from localhost.localdomain (unknown [113.92.158.29])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c1de1557;
	Fri, 5 Dec 2025 16:16:43 +0800 (GMT+08:00)
From: Ding Hui <dinghui@sangfor.com.cn>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH net-next] ice: Fix incorrect timeout in ice_release_res()
Date: Fri,  5 Dec 2025 16:16:08 +0800
Message-Id: <20251205081609.23091-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Tid: 0a9aed95b78a09d9kunm4a185e11f1eeb1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkJCVklLH0kfQxkZSklKQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkhVQklVSk5DVUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The commit 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
ice_sq_done timeout") converted ICE_CTL_Q_SQ_CMD_TIMEOUT from jiffies
to microseconds.

But the ice_release_res() function was missed, and its logic still
treats ICE_CTL_Q_SQ_CMD_TIMEOUT as a jiffies value.

So correct the issue by usecs_to_jiffies().

Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for ice_sq_done timeout")
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 6fb0c1e8ae7c..5005c299deb1 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1885,7 +1885,7 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
 	/* there are some rare cases when trying to release the resource
 	 * results in an admin queue timeout, so handle them correctly
 	 */
-	timeout = jiffies + 10 * ICE_CTL_Q_SQ_CMD_TIMEOUT;
+	timeout = jiffies + 10 * usecs_to_jiffies(ICE_CTL_Q_SQ_CMD_TIMEOUT);
 	do {
 		status = ice_aq_release_res(hw, res, 0, NULL);
 		if (status != -EIO)
-- 
2.17.1


