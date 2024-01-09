Return-Path: <netdev+bounces-62739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7538E828E4D
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 21:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D379DB219FD
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538B3D559;
	Tue,  9 Jan 2024 20:00:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from authsmtp.register.it (authsmtp01.register.it [81.88.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2B3B782
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventsense.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventsense.it
Received: from krn.. ([138.197.190.30])
	by cmsmtp with ESMTPSA
	id NI3PrbEZDI6zQNI3UrWDYw; Tue, 09 Jan 2024 20:46:33 +0100
X-Rid: andrea.fois@eventsense.it@138.197.190.30
From: Andrea Fois <andrea.fois@eventsense.it>
To: 
Cc: andrea.fois@eventsense.it,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	George Shuklin <george.shuklin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tg3: add new module param to force device power down on reboot
Date: Tue,  9 Jan 2024 19:45:51 +0000
Message-Id: <20240109194551.17666-1-andrea.fois@eventsense.it>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPQXaKfWonfFB+huClQ/fRPZupeMxuV2ZGs2JvtZNp6KWdzBy33NZVJ5hWxdsJ0tjVWKiZk64ih5pAuh7HWzC536Jepm3XfweVct7qH53x+FUCMfRxLs
 CuzwR4jkEzE/ew5VpS9clVLigiJOPjNt3FINZMABfH8P70Ak60f138aQX1KtZhnJsAlUts/2A8cHh6VCtuA+aRZVu/fSObtdzN12rjtiVwLSdTiMtFF80pUt
 Th0ZWC4F/G98kYRyLzRP0+qxFAYfRwuVkIh/SRdmHfTuas2hNzyeU/Ps2jcKVIWnYfL/yPGuwsPdIIgUlKBa+YhoE05zLltwoDkogR+wmfVPaDLshljeWVGg
 nz5BaZ+5wDL6E13ZoHouCt/C7ZckrWE2VXRFJUI6aQ4JcnHnrQX2eNe50aPfgvqOaERd+LyeFXk8R6R193K8Iw26BVDXgiOBPwwo0Poxk0PvzxSZfhovrZ6X
 CizoNs56EXflwoE3

The bug #1917471 was fixed in commit 2ca1c94ce0b6 ("tg3: Disable tg3
device on system reboot to avoid triggering AER") but was reintroduced
by commit 9fc3bc764334 ("tg3: power down device only on
SYSTEM_POWER_OFF").

The problem described in #1917471 is still consistently replicable on
reboots on Dell Servers (i.e. R750xs with BCM5720 LOM), causing NMIs
(i.e. NMI received for unknown reason 38 on cpu 0) after 9fc3bc764334
was committed.

The problem is detected also by the Lifecycle controller and logged as
a PCI Bus Error for the device.

As the problems addressed by 2ca1c94ce0b6 and by 9fc3bc764334 requires
opposite strategies, a new module param "force_pwr_down_on_reboot"
<bool> is introduced to fix both scenarios:

	force_pwr_down_on_reboot = 0/N/n = disable, keep the current
									   behavior, don't force dev
									   power down on reboot

	force_pwr_down_on_reboot = 1/Y/y = enable, revert to the
									   behavior of 2ca1c94ce0b6,
									   force dev power down on reboot

Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
Signed-off-by: Andrea Fois <andrea.fois@eventsense.it>
---
 drivers/net/ethernet/broadcom/tg3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index f52830dfb26a..287786357c9b 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -233,6 +233,12 @@ static int tg3_debug = -1;	/* -1 == use TG3_DEF_MSG_ENABLE as value */
 module_param(tg3_debug, int, 0);
 MODULE_PARM_DESC(tg3_debug, "Tigon3 bitmapped debugging message enable value");
 
+static bool force_pwr_down_on_reboot;	/* false == Don't force the power down of
+					 * the device during reboot, only on SYSTEM_POWER_OFF
+					 */
+module_param(force_pwr_down_on_reboot, bool, 0x644);
+MODULE_PARM_DESC(force_pwr_down_on_reboot, "Tigon3 force power down of the device on reboot enable value");
+
 #define TG3_DRV_DATA_FLAG_10_100_ONLY	0x0001
 #define TG3_DRV_DATA_FLAG_5705_10_100	0x0002
 
@@ -18197,7 +18203,7 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	if (system_state == SYSTEM_POWER_OFF)
+	if (system_state == SYSTEM_POWER_OFF || force_pwr_down_on_reboot)
 		tg3_power_down(tp);
 
 	rtnl_unlock();
-- 
2.40.1


