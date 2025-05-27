Return-Path: <netdev+bounces-193745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E4AC5AC6
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1764A213A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283852882CE;
	Tue, 27 May 2025 19:33:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D494028A416
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374434; cv=none; b=BF6LIV7TridgGyHTkFcrJFxpdHsxCyk2bLDRPl0nem2huUMFLCpAw61rQUtEb2YXpOH3qCMQdLFWZj0+wDiCPb3nGLLc+CxxfwZvqOTZxwoMhBAF8/hB4g9Wq8SNPB7iB+0PKk+wtTqzHkvAlDcrV+92u3PGZB0eq35RMqxr3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374434; c=relaxed/simple;
	bh=tgF2570zw5h+ocW0gtCk0NIZVkzaTrB+6ITFfSpsTB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNSYz0tpE8k2unzAM4SkgtLB/W4lhiPZip3B31AIDbIeP4dsVJt9PGfpZ1h9QFlu+nyouzbQR7gZKos2g3wlkT/rvLFG0yQB9fw7VAKyQCRSgPIyorxAlpIGT+wZlURCbcasGakU0Pf4dM9cNiDmJgBKW0vTY2H95ma9mq5EJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan2 ([IPv6:2a02:1810:ac12:ed80:9962:836e:244b:c4d7])
	by michel.telenet-ops.be with cmsmtp
	id uKZi2E0030Y7Yez06KZiuR; Tue, 27 May 2025 21:33:44 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan2 with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uK03S-00000003oIx-1lM3;
	Tue, 27 May 2025 21:33:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uK03S-00000003Wgy-1J7v;
	Tue, 27 May 2025 21:33:42 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Fan Gong <gongfan1@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net] hinic3: Remove printed message during module init
Date: Tue, 27 May 2025 21:33:41 +0200
Message-ID: <5310dac0b3ab4bd16dd8fb761566f12e73b38cab.1748357352.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

No driver should spam the kernel log when merely being loaded.

Fixes: 17fcb3dc12bbee8e ("hinic3: module initialization and tx/rx logic")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 093aa6d775ff70da..497f2a36f35dcdde 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -324,8 +324,6 @@ static __init int hinic3_nic_lld_init(void)
 {
 	int err;
 
-	pr_info("%s: %s\n", HINIC3_NIC_DRV_NAME, HINIC3_NIC_DRV_DESC);
-
 	err = hinic3_lld_init();
 	if (err)
 		return err;
-- 
2.43.0


