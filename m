Return-Path: <netdev+bounces-196012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523ACAD31D2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498367AB46D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A0227932B;
	Tue, 10 Jun 2025 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/eAfWB0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04705286D6E;
	Tue, 10 Jun 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547282; cv=none; b=ndVDdtw+rX99GOOfLBEH9m2ELos5w6A3ULhmEPBF9nFZRnlLKY0xPEmaH9K71V1IZqhSeGorJPSWKc+HuFWz+vWxxUgj5OJYTd/gixi/0az3Ur0Fq1BtW9hGw6sQc/E9+hhqacjFGWyLiFFAonusp/UHrRgoGCBRjxhvdRpnd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547282; c=relaxed/simple;
	bh=9qX58byGaVE5TC80pB4FkJH3w0rPGDf+jM6tTKUJldY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RAXFRf60w0nhSgFCD0+Fd9EtOoxCAxWXM0vS39YU9qsOxPFywhCZLOzMcBKMVhn+bBYK2ut5TYYnluXXHixfuG7c6lAvgWMZOt05wMoV3REH82xkge1swct7FOAVjABi/87jk/T02gSHp6RAzLLakw6GOA1j1fdFUN6MTvdG1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/eAfWB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40538C4CEED;
	Tue, 10 Jun 2025 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749547279;
	bh=9qX58byGaVE5TC80pB4FkJH3w0rPGDf+jM6tTKUJldY=;
	h=From:To:Cc:Subject:Date:From;
	b=L/eAfWB0eiRAmbS3wXT2vU2KmwcsIhM1MuF1N4cZVUXDf72c6lIicvkPS0Rdh9bWW
	 S5VmGigbz8B9wEAte/xShaaTGzTGLtHD3y/ZAnbMoLjW25ysoduGgs6hSHIgJhV7G2
	 awJ9KcECj3l0tFASanyH1XFUoQ35IJsImFl7Zrf6YBq37E+FS85tkebGWdrRsE1WLZ
	 IHHNhgeZFWk32vNIO94muUvNmkPl63jhvsctg3SqSooAJCZjht5VKB0dHwXuf8xfwZ
	 qNx8+2GINV81n0BwFQRik3pZdiOuWqz0LgSGN9fHPeAd9t3VOFkiNiwh+wGVei/Swl
	 71OanMRRNiFXw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Hao Lan <lanhao@huawei.com>,
	Guangwei Zhang <zhangwangwei6@huawei.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] hns3: work around stack size warning
Date: Tue, 10 Jun 2025 11:21:08 +0200
Message-Id: <20250610092113.2639248-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The hns3 debugfs functions all use an extra on-stack buffer to store
temporary text output before copying that to the debugfs file.

In some configurations with clang, this can trigger the warning limit
for the total stack size:

 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c:788:12: error: stack frame size (1456) exceeds limit (1280) in 'hns3_dbg_tx_queue_info' [-Werror,-Wframe-larger-than]

The problem here is that both hns3_dbg_tx_spare_info() and
hns3_dbg_tx_queue_info() have a large on-stack buffer, and clang decides
to inline them into a single function.

Annotate hns3_dbg_tx_spare_info() as noinline_for_stack to force the
behavior that gcc has, regardless of the compiler.

Ideally all the functions in here would be changed to avoid on-stack
output buffers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4e5d8bc39a1b..97dc47eeb44c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -580,8 +580,9 @@ static const struct hns3_dbg_item tx_spare_info_items[] = {
 	{ "DMA", 17 },
 };
 
-static void hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
-				   int len, u32 ring_num, int *pos)
+static noinline_for_stack void
+hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
+			int len, u32 ring_num, int *pos)
 {
 	char data_str[ARRAY_SIZE(tx_spare_info_items)][HNS3_DBG_DATA_STR_LEN];
 	struct hns3_tx_spare *tx_spare = ring->tx_spare;
-- 
2.39.5


