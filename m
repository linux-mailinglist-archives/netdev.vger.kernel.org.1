Return-Path: <netdev+bounces-43327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0077D2607
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 23:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2352814AA
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912F13AD4;
	Sun, 22 Oct 2023 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FiMJ67yb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856CF13AC3
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 21:00:30 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58445FB
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 14:00:28 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id ufYFqwcwpG6boufYhqoCDQ; Sun, 22 Oct 2023 23:00:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698008427;
	bh=5hCOY5dOqdwNpSOWKR6WdA1L7vg708cH5c+HUNqRzWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FiMJ67ybukLxN+2kR7KwWOqtEO6OdNB043ggY48x5x1mdydJdVBNqlQUaVo2DDFhV
	 LBKJNenKjyJlYWt/1Dyu1PZHMGaM3WUH/IIDcDucMwijLro+Xf/LfrOiKbOW89zdTh
	 P7rYnqlmK7eXETkuNCnVq1uhzyfXR/eifYd9dHpc7Hp33Ush5Hp5XJRme2DbuYBlqd
	 JOQwQN57XdOLc1GxYKZPHCenj2dJ93sPppTgSp+ypJcyHE5paASoMoJrGi9GWMTDgH
	 reJX18UNv7l6CYwmH7jVdiLyblpXaCW3kr4hW+0B3SA6gRXukmbzFOSt2yKCI7h3E0
	 0LXbvv1FOlMXg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Oct 2023 23:00:27 +0200
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
Subject: [PATCH net 2/2] liquidio: Simplify octeon_download_firmware()
Date: Sun, 22 Oct 2023 22:59:47 +0200
Message-Id: <0278c7dfbc23f78a2d85060369132782f8466090.1698007858.git.christophe.jaillet@wanadoo.fr>
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

In order to remove the usage of strncat(), write directly at the rigth
place in the 'h->bootcmd' array and check if the output is truncated.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The goal is to potentially remove the strncat() function from the kernel.
Their are only few users and most of them use it wrongly.

This patch is compile tested only.
---
 .../net/ethernet/cavium/liquidio/octeon_console.c   | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
index bd6baf2872a5..f1f0d7a0309a 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
@@ -802,19 +802,17 @@ static int octeon_console_read(struct octeon_device *oct, u32 console_num,
 }
 
 #define FBUF_SIZE	(4 * 1024 * 1024)
-#define MAX_BOOTTIME_SIZE    80
 
 int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
 			     size_t size)
 {
 	struct octeon_firmware_file_header *h;
-	char boottime[MAX_BOOTTIME_SIZE];
 	struct timespec64 ts;
 	u32 crc32_result;
+	u32 i, rem, used;
 	u64 load_addr;
 	u32 image_len;
 	int ret = 0;
-	u32 i, rem;
 
 	if (size < sizeof(struct octeon_firmware_file_header)) {
 		dev_err(&oct->pci_dev->dev, "Firmware file too small (%d < %d).\n",
@@ -896,16 +894,15 @@ int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
 	 * Octeon always uses UTC time. so timezone information is not sent.
 	 */
 	ktime_get_real_ts64(&ts);
-	ret = snprintf(boottime, MAX_BOOTTIME_SIZE,
+
+	used = strnlen(h->bootcmd, sizeof(h->bootcmd));
+	ret = snprintf(h->bootcmd + used, sizeof(h->bootcmd) - used,
 		       " time_sec=%lld time_nsec=%ld",
 		       (s64)ts.tv_sec, ts.tv_nsec);
-	if ((sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd))) <=
-		ret) {
+	if (ret >= sizeof(h->bootcmd) - used) {
 		dev_err(&oct->pci_dev->dev, "Boot command buffer too small\n");
 		return -EINVAL;
 	}
-	strncat(h->bootcmd, boottime,
-		sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd)) - 1);
 
 	dev_info(&oct->pci_dev->dev, "Writing boot command: %s\n",
 		 h->bootcmd);
-- 
2.34.1


