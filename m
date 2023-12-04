Return-Path: <netdev+bounces-53387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC455802C0B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15671C20748
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD09447;
	Mon,  4 Dec 2023 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nog7iae6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACE8F49
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 07:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4FBC433C7;
	Mon,  4 Dec 2023 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701674978;
	bh=lx62nJVG4/6em/8jt1aqDoujqgICoMUEYiBiTLEn73Y=;
	h=From:To:Cc:Subject:Date:From;
	b=nog7iae6jWPOzuuLLHIjTtIIR1wUlPeXTtYx6JU36WNc+KBRZQgguWN1dbv5+T5lg
	 Fjzn1RrFvEy7EE7bzcRCdl9yA+A2Mwb0649qdILXy/q5ukZNEZvO2esnJk4EP/S2OB
	 nSWitwqna1qDusCKomMCS0OMAJM4TJq56buV0RbnzZ3hnMDlni73NNqP7xUSGHTXq8
	 mxE5yVi8INWw6LEC1w4/1kTE/SmR0c+f+dTzj0hMPtKcusfc7oGngdziM8El5jV8jH
	 uzLOtNVVO1umCVcp+pzj/ZIju5PdRuD2HERFscymZylWn22jeuPHpieIlDbwQUFOTf
	 TyE5aygJE8Dww==
From: Arnd Bergmann <arnd@kernel.org>
To: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jijie Shao <shaojijie@huawei.com>,
	Hao Chen <chenhao418@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: hns3: reduce stack usage in hclge_dbg_dump_tm_pri()
Date: Mon,  4 Dec 2023 08:29:26 +0100
Message-Id: <20231204072932.1077878-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This function exceeds the stack frame warning limit:

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c: In function 'hclge_dbg_dump_tm_pri':
drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:1039:1: error: the frame size of 1408 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Use dynamic allocation for the largest stack object instead. It
would be nice to rewrite this file to completely avoid the extra
buffer and just use the one that was already allocated by debugfs,
but that is a much larger change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c   | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index ff3f8f424ad9..9b5d46fdfd6c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -981,7 +981,7 @@ static const struct hclge_dbg_item tm_pri_items[] = {
 
 static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
 {
-	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
+	char *data_str;
 	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
 	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
 	char content[HCLGE_DBG_TM_INFO_LEN];
@@ -991,9 +991,13 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
 	ret = hclge_tm_get_pri_num(hdev, &pri_num);
 	if (ret)
 		return ret;
+	data_str = kcalloc(ARRAY_SIZE(tm_pri_items), HCLGE_DBG_DATA_STR_LEN,
+			   GFP_KERNEL);
+	if (!data_str)
+		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(tm_pri_items); i++)
-		result[i] = &data_str[i][0];
+		result[i] = &data_str[i * HCLGE_DBG_DATA_STR_LEN];
 
 	hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
 			       NULL, ARRAY_SIZE(tm_pri_items));
@@ -1035,6 +1039,7 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
 		pos += scnprintf(buf + pos, len - pos, "%s", content);
 	}
 
+	kfree(data_str);
 	return 0;
 }
 
-- 
2.39.2


