Return-Path: <netdev+bounces-53853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0330B804F9A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1992E1C20BB2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D74B5B3;
	Tue,  5 Dec 2023 09:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA544A0;
	Tue,  5 Dec 2023 01:58:53 -0800 (PST)
X-UUID: 9e0e00b194d04b3db395bf7e6e040e34-20231205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:aef0a0c6-7cde-48a6-ad98-77de04a783a8,IP:5,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-35
X-CID-INFO: VERSION:1.1.33,REQID:aef0a0c6-7cde-48a6-ad98-77de04a783a8,IP:5,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-35
X-CID-META: VersionHash:364b77b,CLOUDID:d75dd660-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:231205175850BNX1BCP2,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 9e0e00b194d04b3db395bf7e6e040e34-20231205
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1910631065; Tue, 05 Dec 2023 17:58:47 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jeffrey.t.kirsher@intel.com,
	shannon.nelson@amd.com
Cc: kunwu.chan@hotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v4 iwl-next] i40e: Use correct buffer size in i40e_dbg_command_read
Date: Tue,  5 Dec 2023 17:58:44 +0800
Message-Id: <20231205095844.2532859-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of "i40e_dbg_command_buf" is 256, the size of "name"
depends on "IFNAMSIZ", plus a null character and format size,
the total size is more than 256.

Improve readability and maintainability by replacing a hardcoded string
allocation and formatting by the use of the kasprintf() helper.

Fixes: 02e9c290814c ("i40e: debugfs interface")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: Simon Horman <horms@kernel.org>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v2
   - Update the size calculation with IFNAMSIZ and sizeof(i40e_dbg_command_buf)
v3
   - Use kasprintf to improve readability and maintainability
v4
   - Fix memory leak in error path
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 88240571721a..78a7200211b2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -72,29 +72,31 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
 {
 	struct i40e_pf *pf = filp->private_data;
 	int bytes_not_copied;
-	int buf_size = 256;
 	char *buf;
 	int len;
 
 	/* don't allow partial reads */
 	if (*ppos != 0)
 		return 0;
-	if (count < buf_size)
-		return -ENOSPC;
 
-	buf = kzalloc(buf_size, GFP_KERNEL);
+	buf = kasprintf(GFP_KERNEL, "%s: %s\n",
+			pf->vsi[pf->lan_vsi]->netdev->name,
+			i40e_dbg_command_buf);
 	if (!buf)
 		return -ENOSPC;
 
-	len = snprintf(buf, buf_size, "%s: %s\n",
-		       pf->vsi[pf->lan_vsi]->netdev->name,
-		       i40e_dbg_command_buf);
+	len = strlen(buf) + 1;
+	if (count < len)
+		bytes_not_copied = -ENOSPC;
+	else if (copy_to_user(buffer, buf, len))
+		bytes_not_copied = -EFAULT;
+	else
+		bytes_not_copied = 0;
 
-	bytes_not_copied = copy_to_user(buffer, buf, len);
 	kfree(buf);
 
 	if (bytes_not_copied)
-		return -EFAULT;
+		return bytes_not_copied;
 
 	*ppos = len;
 	return len;
-- 
2.34.1


