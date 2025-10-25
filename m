Return-Path: <netdev+bounces-232760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94639C08A7A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 05:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F2B402204
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 03:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF32571A5;
	Sat, 25 Oct 2025 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="T8pDU1Fw"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319582147F9;
	Sat, 25 Oct 2025 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363897; cv=none; b=W8aJfseyg7zox3gfCPa7ZM8X6Nz4AreKXzJzKMGkGt+sqaqpcWXgzr9OT6bRH+37Nm/ytE2jbMweEtWApTdk43oI6QFSgG3ulRTBPC9yH9nkSRBbKXb1H+XJIKqr6wYCpTDPzjD3fSWyBoVRGCNew/j30RcY3H0oyMtHzpD6Els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363897; c=relaxed/simple;
	bh=2bouS7hna0gClWKGkPD0t7YRPlEeO+s2XXR4RVd0lJU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hk+TvrWqxh7AmlY6eQ6jEEoHe2fRCFVbm3+qsicGaIrBTIDo8cAt93b3UAcFE9i3sRvaTbEe6qL4H7k0uHkhz7AsC3YoOgn6oeHYzbEM1D/DdLRR58xksvdNQUW5CT4n2Zy72rGk5/BBnc6iFZUEorQ+tYF1jjBBHQOy/hoej8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=T8pDU1Fw; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y7Rj9E2CdLAIkXLhpNINjdklw1IJhaMfMqQhc80+fB4=;
	b=T8pDU1FwYdR5RRmiX67izPdS9NVMhoZJZ6aWK1LfM5MzIj8S5CuiPMBmc2i9ZR/DOMT3Nbxhk
	5YJgBhgh9yAjjW2M5AopCT3bmqTSEMwnfr+9yydDdmRjjBbFR2d+m7djIcC/oqkV9dmjAkCaUu6
	d+HD5qU+HLdSL9J2eL7KHPM=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctlxk6vMWznTVF;
	Sat, 25 Oct 2025 11:44:10 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DF1C140278;
	Sat, 25 Oct 2025 11:44:50 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 25 Oct
 2025 11:44:49 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH -next] i40e: Replace sscanf() with kstrtoint() in i40e_dbg_netdev_ops_write()
Date: Sat, 25 Oct 2025 12:07:35 +0800
Message-ID: <20251025040735.558953-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Commit 9fcdb1c3c4ba ("i40e: remove read access to debugfs files")
introduced some checkpatch warnings like this:

  WARNING: Prefer kstrto<type> to single variable sscanf
  #240: FILE: drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1655:
  +               cnt = sscanf(&cmd_buf[11], "%i", &vsi_seid);

  WARNING: Prefer kstrto<type> to single variable sscanf
  #251: FILE: drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1676:
  +               cnt = sscanf(&cmd_buf[4], "%i", &vsi_seid);

  total: 0 errors, 2 warnings, 0 checks, 194 lines checked

Function kstrtoint() provides better error detection, overflow protection,
and consistent error handling than sscanf(). Replace sscanf() with
kstrtoint() in i40e_dbg_netdev_ops_write() to silence the checkpatch
warnings.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index c17b5d290f0a..2abd12b62509 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1604,7 +1604,7 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 	int bytes_not_copied;
 	struct i40e_vsi *vsi;
 	int vsi_seid;
-	int i, cnt;
+	int i, ret;
 
 	/* don't allow partial writes */
 	if (*ppos != 0)
@@ -1629,9 +1629,9 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 	if (strncmp(cmd_buf, "change_mtu", 10) == 0) {
 		int mtu;
 
-		cnt = sscanf(&cmd_buf[11], "%i %i",
+		ret = sscanf(&cmd_buf[11], "%i %i",
 			     &vsi_seid, &mtu);
-		if (cnt != 2) {
+		if (ret != 2) {
 			dev_info(&pf->pdev->dev, "change_mtu <vsi_seid> <mtu>\n");
 			goto netdev_ops_write_done;
 		}
@@ -1652,8 +1652,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 		}
 
 	} else if (strncmp(cmd_buf, "set_rx_mode", 11) == 0) {
-		cnt = sscanf(&cmd_buf[11], "%i", &vsi_seid);
-		if (cnt != 1) {
+		ret = kstrtoint(&cmd_buf[11], 0, &vsi_seid);
+		if (ret) {
 			dev_info(&pf->pdev->dev, "set_rx_mode <vsi_seid>\n");
 			goto netdev_ops_write_done;
 		}
@@ -1673,8 +1673,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 		}
 
 	} else if (strncmp(cmd_buf, "napi", 4) == 0) {
-		cnt = sscanf(&cmd_buf[4], "%i", &vsi_seid);
-		if (cnt != 1) {
+		ret = kstrtoint(&cmd_buf[4], 0, &vsi_seid);
+		if (ret) {
 			dev_info(&pf->pdev->dev, "napi <vsi_seid>\n");
 			goto netdev_ops_write_done;
 		}
-- 
2.34.1


