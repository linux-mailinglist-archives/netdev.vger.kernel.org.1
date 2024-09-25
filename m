Return-Path: <netdev+bounces-129847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9EA986785
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3996B233AE
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E114A4F0;
	Wed, 25 Sep 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uutJ+4zK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92D14A0BC
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295620; cv=none; b=G7GLEzee3cgxBNjXLi8hQ5fU2TgqIDmQrA/1rF306i4yWfVMGNBZSB5YqJb7HbKFA/TMLJQzSbwgYa8W/LbgiKxw0SOIs1vnYJa0alfpGuxf5ivVl01NEAAnGK9xexY7tEObJGfZY2+xD6Q8G7libbBUjyQEtx0APcFP/RSM70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295620; c=relaxed/simple;
	bh=CefgCdjM7a3qSpg7kE6psuz7c5Kcep0bN8QmOjPzfsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKxvg/9O5disTrJQQHtc+iyeNinsp7i+CarePzzXNBZp6tOgMHfBDTtB9fyA3EVmIyXF9Jsn2U2hhObvLTWp4xAS7OTCHWYr5kEttJ7o/h4tzF9VhwpRAuxAzEG7LEi4Y44Z51jz4WuzOm0kAEOc1wyn09Du2XyN03ST7cRmoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uutJ+4zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2D9C4CEC9;
	Wed, 25 Sep 2024 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295620;
	bh=CefgCdjM7a3qSpg7kE6psuz7c5Kcep0bN8QmOjPzfsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uutJ+4zKCp76bbxPjCQV+u0T7cx0G4lwyBk1iImhoMXC/cMNbLEa2JuyaSsCRfN90
	 DhbkXMYRRiRzwg6oZmtobyHmnXvVXV8kPydz+3QBB2Dup0pJ7iPH+JnlVqBPC4iaVo
	 /zfgotMvfWILURy9cnUBUbQXRN+TLQNczgcvtVVd5gpM9huPtPddIK110aP0mAplhJ
	 JgDu9T/Lhvlw8t9G4d00SqBEGpgDPs2FiXnW75JghmvVdS7EC9v546ksHVqO0UJShP
	 +PVuiDu9JbhsX90NqfSeTGL6ZeJIPnPk1GEBmtLblgUAL4jo86WwZfC2Q2IoqbFjVL
	 /Nac/iuk+Jvsw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net 2/8] net/mlx5: Added cond_resched() to crdump collection
Date: Wed, 25 Sep 2024 13:20:07 -0700
Message-ID: <20240925202013.45374-3-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925202013.45374-1-saeed@kernel.org>
References: <20240925202013.45374-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohamed Khalfella <mkhalfella@purestorage.com>

Collecting crdump involves reading vsc registers from pci config space
of mlx device, which can take long time to complete. This might result
in starving other threads waiting to run on the cpu.

Numbers I got from testing ConnectX-5 Ex MCX516A-CDAT in the lab:

- mlx5_vsc_gw_read_block_fast() was called with length = 1310716.
- mlx5_vsc_gw_read_fast() reads 4 bytes at a time. It was not used to
  read the entire 1310716 bytes. It was called 53813 times because
  there are jumps in read_addr.
- On average mlx5_vsc_gw_read_fast() took 35284.4ns.
- In total mlx5_vsc_wait_on_flag() called vsc_read() 54707 times.
  The average time for each call was 17548.3ns. In some instances
  vsc_read() was called more than one time when the flag was not set.
  As expected the thread released the cpu after 16 iterations in
  mlx5_vsc_wait_on_flag().
- Total time to read crdump was 35284.4ns * 53813 ~= 1.898s.

It was seen in the field that crdump can take more than 5 seconds to
complete. During that time mlx5_vsc_wait_on_flag() did not release the
cpu because it did not complete 16 iterations. It is believed that pci
config reads were slow. Adding cond_resched() every 128 register read
improves the situation. In the common case the, crdump takes ~1.8989s,
the thread yields the cpu every ~4.51ms. If crdump takes ~5s, the thread
yields the cpu every ~18.0ms.

Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support")
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index d0b595ba6110..432c98f2626d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -24,6 +24,11 @@
 	pci_write_config_dword((dev)->pdev, (dev)->vsc_addr + (offset), (val))
 #define VSC_MAX_RETRIES 2048
 
+/* Reading VSC registers can take relatively long time.
+ * Yield the cpu every 128 registers read.
+ */
+#define VSC_GW_READ_BLOCK_COUNT 128
+
 enum {
 	VSC_CTRL_OFFSET = 0x4,
 	VSC_COUNTER_OFFSET = 0x8,
@@ -273,6 +278,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 {
 	unsigned int next_read_addr = 0;
 	unsigned int read_addr = 0;
+	unsigned int count = 0;
 
 	while (read_addr < length) {
 		if (mlx5_vsc_gw_read_fast(dev, read_addr, &next_read_addr,
@@ -280,6 +286,10 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 			return read_addr;
 
 		read_addr = next_read_addr;
+		if (++count == VSC_GW_READ_BLOCK_COUNT) {
+			cond_resched();
+			count = 0;
+		}
 	}
 	return length;
 }
-- 
2.46.1


