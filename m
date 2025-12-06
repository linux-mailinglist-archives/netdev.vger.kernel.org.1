Return-Path: <netdev+bounces-243912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96836CAA8D1
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AE293067307
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D126E709;
	Sat,  6 Dec 2025 15:02:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com [220.197.32.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FFB4C81;
	Sat,  6 Dec 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765033350; cv=none; b=HpjH/b4TCKiXazIR5uwoAAJ+k8qu/esErMehuS3PbPHs0oz/RdKVLzRIEH+sdMtjevT0wUu3EZfw39jdJlPFPTFTX+lAHIRtTjShh/JnDLmLi2aveNKbrR3wedum5gL9Ht+iYGxjlzKYDnlTkxDAQsT72+m14cFWR0jRWmttWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765033350; c=relaxed/simple;
	bh=1CJ19Jg+woksabWb5XtLozeGdxdd9MQkH7jE9FAz8j8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Eqc5Jij481T1MetkKaPGSFF0OOMPqvoGTvlkLsf9YO6YusWeAH7v+zKi+hAPSCbZ+DlDM5Hgbl5Zhlyi6KeVwwHmPobr4VQiaFN8PPkV79KXkGjrXND4eOaWzBWJl5UBQT/z4ZG6RV4t4dc2CiaB63D8o4dWbena/Rbu3mFREV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=220.197.32.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from localhost.localdomain (unknown [113.92.158.29])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c3ac3254;
	Sat, 6 Dec 2025 21:46:33 +0800 (GMT+08:00)
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
Subject: [Patch net v2] ice: Fix incorrect timeout ice_release_res()
Date: Sat,  6 Dec 2025 21:46:09 +0800
Message-Id: <20251206134609.10565-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Tid: 0a9af3ea0cab09d9kunm9ddc210f18cfd28
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0MZVkJOGhlNTxlNH0IaH1YVFAkWGhdVEwETFh
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

Found by inspection of the DDP downloading process.
Compile and modprobe tested only.

Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for ice_sq_done timeout")
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
v1->v2: rebase to net branch and add commit log.

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 046bc9c65c51..785bf5cc1b25 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2251,7 +2251,7 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
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


