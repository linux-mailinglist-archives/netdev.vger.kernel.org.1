Return-Path: <netdev+bounces-43326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206F7D2605
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 23:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79622813D6
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FF134CB;
	Sun, 22 Oct 2023 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UxbDtzfo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29813AC0
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 21:00:26 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE85D114
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 14:00:24 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id ufYFqwcwpG6boufYdqoCCl; Sun, 22 Oct 2023 23:00:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698008423;
	bh=W0mHaNEAAUX2nTaO6oddXS59CQugHmEWhSnV8c4UJ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UxbDtzfouZDnBiHAY7DY4xX5Tf2OqORvmMe7We+8GBAdJ3IU/P+6Q9u7nxkUNbxU0
	 XiNAMfBiNWFs99Zczv0LH6m6oj5Kq6Iji3ALJUQyKjWMHTw4uio+/MYJnwA1bO/6+Q
	 RnhczO2O942rlK/5B1OzgsvX3uICfJg05m6jD92x7lueFfPc3fAxZH56OYqkkb/X86
	 Y9OzKhbYJVwu3OyF7lcYW1Bf9nx7kBvonzjkLokWtftsIqhRcJ8TDYt86/eUTZ1SBv
	 0NbQCcTyFss5/bkwM1kZ8lpoRy68YLlV7GfW2OL6UPSGvPg1MerPNx/VYUilpuRkFd
	 Hsq7qCbOo1Oqg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Oct 2023 23:00:23 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: dchickles@marvell.com,
	sburla@marvell.com,
	fmanlunas@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	veerasenareddy.burru@cavium.com
Cc: felix.manlunas@cavium.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net 1/2] liquidio: Fix an off by one in octeon_download_firmware()
Date: Sun, 22 Oct 2023 22:59:46 +0200
Message-Id: <30f085627802594da71bb0b5ca52213ab11301fc.1698007858.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to append the 'boottime' string to 'h->bootcmd', the final NULL
has to betaken into account when checking if there is enough space.

Fixes: 907aaa6babe1 ("liquidio: pass date and time info to NIC firmware")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/cavium/liquidio/octeon_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
index 67c3570f875f..bd6baf2872a5 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
@@ -899,13 +899,13 @@ int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
 	ret = snprintf(boottime, MAX_BOOTTIME_SIZE,
 		       " time_sec=%lld time_nsec=%ld",
 		       (s64)ts.tv_sec, ts.tv_nsec);
-	if ((sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd))) <
+	if ((sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd))) <=
 		ret) {
 		dev_err(&oct->pci_dev->dev, "Boot command buffer too small\n");
 		return -EINVAL;
 	}
 	strncat(h->bootcmd, boottime,
-		sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd)));
+		sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd)) - 1);
 
 	dev_info(&oct->pci_dev->dev, "Writing boot command: %s\n",
 		 h->bootcmd);
-- 
2.34.1


