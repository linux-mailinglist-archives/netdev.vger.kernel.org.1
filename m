Return-Path: <netdev+bounces-47874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B87EBBA1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B142811B6
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 03:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB764F;
	Wed, 15 Nov 2023 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F3647
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:15:04 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46434A7;
	Tue, 14 Nov 2023 19:15:03 -0800 (PST)
X-UUID: ed5a0a20a55e490aa9171fb72141b083-20231115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2cfcccbc-ff1f-499a-af7d-84216c47cfff,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:20
X-CID-INFO: VERSION:1.1.32,REQID:2cfcccbc-ff1f-499a-af7d-84216c47cfff,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:20
X-CID-META: VersionHash:5f78ec9,CLOUDID:98c3a972-1bd3-4f48-b671-ada88705968c,B
	ulkID:2311151114581JDKGIG5,BulkQuantity:0,Recheck:0,SF:19|44|66|24|17|102,
	TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ed5a0a20a55e490aa9171fb72141b083-20231115
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1282692015; Wed, 15 Nov 2023 11:14:55 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: horms@kernel.org
Cc: anthony.l.nguyen@intel.com,
	chentao@kylinos.cn,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jeffrey.t.kirsher@intel.com,
	jesse.brandeburg@intel.com,
	kuba@kernel.org,
	kunwu.chan@hotmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shannon.nelson@amd.com
Subject: [PATCH iwl-next] i40e: Use correct buffer size
Date: Wed, 15 Nov 2023 11:14:44 +0800
Message-Id: <20231115031444.33381-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113093112.GL705326@kernel.org>
References: <20231113093112.GL705326@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of "i40e_dbg_command_buf" is 256, the size of "name"
depends on "IFNAMSIZ", plus a null character and format size,
the total size is more than 256, fix it.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 999c9708def5..e3b939c67cfe 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -72,7 +72,7 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
 {
 	struct i40e_pf *pf = filp->private_data;
 	int bytes_not_copied;
-	int buf_size = 256;
+	int buf_size = IFNAMSIZ + sizeof(i40e_dbg_command_buf) + 4;
 	char *buf;
 	int len;
 
-- 
2.34.1


