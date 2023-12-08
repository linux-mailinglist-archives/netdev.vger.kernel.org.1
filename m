Return-Path: <netdev+bounces-55157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E1809A25
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67B0281FF0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0F3D62;
	Fri,  8 Dec 2023 03:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CA610CA;
	Thu,  7 Dec 2023 19:20:14 -0800 (PST)
X-UUID: 521d0d6ba0f34a20a019334226efae8f-20231208
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c3f1ada0-0adb-401e-b9a5-352cbfef47bd,IP:5,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-35
X-CID-INFO: VERSION:1.1.33,REQID:c3f1ada0-0adb-401e-b9a5-352cbfef47bd,IP:5,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-35
X-CID-META: VersionHash:364b77b,CLOUDID:4d908b73-1bd3-4f48-b671-ada88705968c,B
	ulkID:231208112000PIRN4KGJ,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 521d0d6ba0f34a20a019334226efae8f-20231208
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1129089617; Fri, 08 Dec 2023 11:19:57 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jeffrey.t.kirsher@intel.com,
	shannon.nelson@amd.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kunwu Chan <kunwu.chan@hotmail.com>
Subject: [PATCH v5 iwl-next] i40e: Use correct buffer size in i40e_dbg_command_read
Date: Fri,  8 Dec 2023 11:19:50 +0800
Message-Id: <20231208031950.47410-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
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
Suggested-by: Simon Horman <horms@kernel.org>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
v2
   - Update the size calculation with IFNAMSIZ and sizeof(i40e_dbg_command_buf)
v3
   - Use kasprintf to improve readability and maintainability
v4
   - Fix memory leak in error path
v5
   - Change the order of labels
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
2.39.2


