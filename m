Return-Path: <netdev+bounces-307653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kqZfEIAEV2pUEQEAu9opvQ
	(envelope-from <netdev+bounces-307653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C675A5FC
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:54:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307653-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307653-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 289DB300AD4F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 03:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4165E3AEF4A;
	Wed, 15 Jul 2026 03:54:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63862FFF9D;
	Wed, 15 Jul 2026 03:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087674; cv=none; b=mOXJmqYIv/ExDJvn/UvtYNlz+nCaRIP2WUKP6aYpc5OQuv5L7guzMOb69Cf5I31PjeghZWe/RsGFXr/HhewOvdFUhVYg0m1gIHdEhc47DjpyfR2mT1TUw5ra1Mv+U8zaLmHLrO/hjir/QHKrPilDdSKJOQ7KVmBBO8gfGDx6jPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087674; c=relaxed/simple;
	bh=Ap2bX1N52xsUYa/oDNVUeAu8kc3nrwHlEwvknFQwdQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LL4IGJJ1GHkMvoLJfx63PeXymApKC1+2pGv3PQxzdzNopy1hbWhPJhehE9ibhRs9jBzvO95bzAqgEDyEABLBUfmBT/ydKVvkatueAsBxixHjsMEIAOVe6O7ZzjSn8+qseM15+Z6Dx2L6pDl7k3lk0VpEGnEBI7embmRTlcvBYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h0MjZ2qmmzKHMWP;
	Wed, 15 Jul 2026 11:53:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2208040571;
	Wed, 15 Jul 2026 11:54:26 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3FHFwBFdqr2kdBQ--.13537S2;
	Wed, 15 Jul 2026 11:54:25 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] e1000e: Fix out-of-bounds MMIO access by validating BAR0 size
Date: Wed, 15 Jul 2026 03:58:50 +0000
Message-Id: <20260715035850.588070-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3FHFwBFdqr2kdBQ--.13537S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUtr1rZFWrGF4rKrWUXFb_yoWrCFWUpa
	y3Ga47Cr4rJr17X3W8Jr4UGFZ8Cayjyay5Cry2gwsY9FyUG348Jry7tFW3Gr4xZrWkJF9x
	tryUZ34Ikr4qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307653-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[pulehui@huaweicloud.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pulehui@huaweicloud.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huaweicloud.com:from_mime,huaweicloud.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C1C675A5FC

From: Pu Lehui <pulehui@huawei.com>

Syzkaller reported a kernel panic caused by an out-of-bounds MMIO
access in the e1000e driver.

[   82.868719][  T404] e1000e 0000:00:02.0: The NVM Checksum Is Not Valid
[   82.872328][  T404] Unable to handle kernel paging request at virtual address ffff80008894e090
[   83.085218][  T404] CPU: 2 UID: 0 PID: 404 Comm: bash Not tainted 7.2.0-rc2-g3f1f75536668 #1 PREEMPTLAZY
[   83.129013][  T404] pc : e1000_get_cfg_done_82571+0x70/0x158
[   83.140092][  T404] lr : e1000_get_cfg_done_82571+0x68/0x158
[   83.151196][  T404] sp : ffff80008ac37410
[   83.158922][  T404] x29: ffff80008ac37410 x28: ffff0000cd6a11b8 x27: ffff0000c58190d0
[   83.173919][  T404] x26: ffff0000cd6a11b8 x25: ffff0000cd6a0bc0 x24: ffff0000cd6a0000
[   83.189417][  T404] x23: 0000000000001010 x22: ffff0000cd6a11c0 x21: ffff0000cd6a11b8
[   83.205195][  T404] x20: 0000000000000064 x19: ffff80008894e090 x18: 0000000000000000
[   83.220545][  T404] x17: ffff800081c1a3f4 x16: ffff800081c19c10 x15: ffff800081e86510
[   83.235764][  T404] x14: 0000000000000001 x13: 0000000000000001 x12: ffff60001bc8a8b3
[   83.251301][  T404] x11: 1fffe0001bc8a8b2 x10: ffff60001bc8a8b2 x9 : ffff800081eae25c
[   83.266705][  T404] x8 : 00009fffe437574e x7 : ffff0000de454593 x6 : 0000000000000001
[   83.281919][  T404] x5 : ffff0000cf2b9640 x4 : 0000000000000000 x3 : dfff800000000000
[   83.297317][  T404] x2 : 0000000000000007 x1 : ffff0000cd6a11c0 x0 : 0000000000000000
[   83.312601][  T404] Call trace:
[   83.318662][  T404]  e1000_get_cfg_done_82571+0x70/0x158 (P)
[   83.329748][  T404]  e1000e_phy_hw_reset_generic+0x17c/0x1a8
[   83.341541][  T404]  e1000_probe+0xbd8/0x1988
[   83.350334][  T404]  local_pci_probe+0x84/0x130

Repetition steps:
1. Find PCI device which BAR0 size <= 4K. If it's:
   Device Addr: 0000:00:02.0   BAR0 SIZE: 4K
   Vendor/Device ID: 0x1af4 0x1004
2. Unbind the above PCI device
   echo '0000:00:02.0' > /sys/bus/pci/devices/0000:00:02.0/driver/unbind
3. Set the above device to e1000e new_id
   echo '1af4 1004' > /sys/bus/pci/drivers/e1000e/new_id

During e1000_probe(), the driver maps the device's BAR0 memory region.
If the device has a 4K BAR0, ioremap() maps only 4K of space. Later in
the probe process, when the NVM checksum validation fails, the driver
attempts to perform a hardware reset and falls back to the err_eeprom
cleanup path.

This cleanup path will trigger an OOB access kernel panic:
e1000_phy_hw_reset
  e1000e_phy_hw_reset_generic
    e1000_get_cfg_done_82571
      er32(EEMNGCTL)
        readl(hw->hw_addr + EEMNGCTL); <-- EEMNGCTL(0x1010) > 4K, OOB access

Fix this by ensuring the MMIO length (pci_resource_len(pdev, 0)) is at
least 64K (0x10000) before proceeding with ioremap(). The 64K minimum
safely covers the maximum register offset accessed by the e1000e driver.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 5 +++++
 drivers/net/ethernet/intel/e1000e/regs.h   | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..46e58e926f7b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7450,6 +7450,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mmio_len = pci_resource_len(pdev, 0);
 
 	err = -EIO;
+	if (mmio_len < E1000_MMIO_LEN_MIN) {
+		dev_err(&pdev->dev, "MMIO len is too small\n");
+		goto err_ioremap;
+	}
+
 	adapter->hw.hw_addr = ioremap(mmio_start, mmio_len);
 	if (!adapter->hw.hw_addr)
 		goto err_ioremap;
diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
index 6c0cd8cab3ef..b63adeea1563 100644
--- a/drivers/net/ethernet/intel/e1000e/regs.h
+++ b/drivers/net/ethernet/intel/e1000e/regs.h
@@ -242,4 +242,7 @@
 /* PHY registers */
 #define I82579_DFT_CTRL	PHY_REG(769, 20)
 
+/* Minimum MMIO (BAR0) len, the largest offset is lower than 64K */
+#define E1000_MMIO_LEN_MIN	0x10000
+
 #endif
-- 
2.34.1


