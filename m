Return-Path: <netdev+bounces-16265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0574C5BA
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 17:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E728B1C209A6
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C8C8E0;
	Sun,  9 Jul 2023 15:14:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE23101C5
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 15:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D4FC433CB;
	Sun,  9 Jul 2023 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915685;
	bh=l3M82zQLezOgHHDn40Ur4WQe2kOsh1xSxkS/hv7wQ5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUDsxxKGwB8LOZZkkYA9GZ8aW/9KflqQ7sjVtd20goaE5dxHNshLIruk5FXKZJR2+
	 n3cRjsLfCN6b4WbsRIdEw+B8QfhuQ1O8rXsYdDB2dd+2R+nFeKn90Dv7oVkwcYnUT3
	 yX/2sgUg1pgV6E1dZumhvinHCtPJ+iMrCz0RIeKK6PyexVK95BLCTOW8eTMFx3D+C3
	 FDDoasaKTX2+jwVzyJssQhN8gll86RGHVl71Wjyt2dgZhUekd3/KBT/47zHzmvsyNX
	 fqrZnuK7jS/lFCKFBZr3Ku8PIx7j9SO2TOvLn4MEZH8VskgJSSicRpdmPsU1Bvc3DL
	 Aykvdx8k86SIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hao Chen <chenhao418@huawei.com>,
	kernel test robot <lkp@intel.com>,
	Hao Lan <lanhao@huawei.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	guoren@kernel.org,
	huangguangbin2@huawei.com,
	netdev@vger.kernel.org,
	linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 22/22] net: hns3: fix strncpy() not using dest-buf length as length issue
Date: Sun,  9 Jul 2023 11:13:56 -0400
Message-Id: <20230709151356.513279-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit

From: Hao Chen <chenhao418@huawei.com>

[ Upstream commit 1cf3d5567f273a8746d1bade00633a93204f80f0 ]

Now, strncpy() in hns3_dbg_fill_content() use src-length as copy-length,
it may result in dest-buf overflow.

This patch is to fix intel compile warning for csky-linux-gcc (GCC) 12.1.0
compiler.

The warning reports as below:

hclge_debugfs.c:92:25: warning: 'strncpy' specified bound depends on
the length of the source argument [-Wstringop-truncation]

strncpy(pos, items[i].name, strlen(items[i].name));

hclge_debugfs.c:90:25: warning: 'strncpy' output truncated before
terminating nul copying as many bytes from a string as its length
[-Wstringop-truncation]

strncpy(pos, result[i], strlen(result[i]));

strncpy() use src-length as copy-length, it may result in
dest-buf overflow.

So,this patch add some values check to avoid this issue.

Signed-off-by: Hao Chen <chenhao418@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202207170606.7WtHs9yS-lkp@intel.com/T/
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 31 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 29 ++++++++++++++---
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index bcccd82a2620f..f6ededec5a4fa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -435,19 +435,36 @@ static void hns3_dbg_fill_content(char *content, u16 len,
 				  const struct hns3_dbg_item *items,
 				  const char **result, u16 size)
 {
+#define HNS3_DBG_LINE_END_LEN	2
 	char *pos = content;
+	u16 item_len;
 	u16 i;
 
+	if (!len) {
+		return;
+	} else if (len <= HNS3_DBG_LINE_END_LEN) {
+		*pos++ = '\0';
+		return;
+	}
+
 	memset(content, ' ', len);
-	for (i = 0; i < size; i++) {
-		if (result)
-			strncpy(pos, result[i], strlen(result[i]));
-		else
-			strncpy(pos, items[i].name, strlen(items[i].name));
+	len -= HNS3_DBG_LINE_END_LEN;
 
-		pos += strlen(items[i].name) + items[i].interval;
+	for (i = 0; i < size; i++) {
+		item_len = strlen(items[i].name) + items[i].interval;
+		if (len < item_len)
+			break;
+
+		if (result) {
+			if (item_len < strlen(result[i]))
+				break;
+			strscpy(pos, result[i], strlen(result[i]));
+		} else {
+			strscpy(pos, items[i].name, strlen(items[i].name));
+		}
+		pos += item_len;
+		len -= item_len;
 	}
-
 	*pos++ = '\n';
 	*pos++ = '\0';
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index a0b46e7d863eb..233c132dc513e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -88,16 +88,35 @@ static void hclge_dbg_fill_content(char *content, u16 len,
 				   const struct hclge_dbg_item *items,
 				   const char **result, u16 size)
 {
+#define HCLGE_DBG_LINE_END_LEN	2
 	char *pos = content;
+	u16 item_len;
 	u16 i;
 
+	if (!len) {
+		return;
+	} else if (len <= HCLGE_DBG_LINE_END_LEN) {
+		*pos++ = '\0';
+		return;
+	}
+
 	memset(content, ' ', len);
+	len -= HCLGE_DBG_LINE_END_LEN;
+
 	for (i = 0; i < size; i++) {
-		if (result)
-			strncpy(pos, result[i], strlen(result[i]));
-		else
-			strncpy(pos, items[i].name, strlen(items[i].name));
-		pos += strlen(items[i].name) + items[i].interval;
+		item_len = strlen(items[i].name) + items[i].interval;
+		if (len < item_len)
+			break;
+
+		if (result) {
+			if (item_len < strlen(result[i]))
+				break;
+			strscpy(pos, result[i], strlen(result[i]));
+		} else {
+			strscpy(pos, items[i].name, strlen(items[i].name));
+		}
+		pos += item_len;
+		len -= item_len;
 	}
 	*pos++ = '\n';
 	*pos++ = '\0';
-- 
2.39.2


