Return-Path: <netdev+bounces-110376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BC992C257
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BE2B2D6A4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864818C19C;
	Tue,  9 Jul 2024 17:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029818C198;
	Tue,  9 Jul 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544853; cv=none; b=BhCrBRlj8YqHp/VqTRdRTUTHXN4YORfsRw0iMt4MFjgnk1pXAvkWW1MAg2wnxpbPR7r4VCzAKJ0KKLHw3P8qRC5xpN/kCRVZhM0naFkF481YECaZvxdRXyYxQ91Mkt/5CABz3YBwFmvNF83Q7Ubq+iUE1mAkVHAVVmuh3NDcZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544853; c=relaxed/simple;
	bh=wGUjfacfqZIc4tuQ1brrCye1gLHVU1GVgMpl3ErvS40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jS/cCs52c3QyqtjnDT11BAFephXlLIGHMS/Qe5dw27Hpal51QPJgeHv3JS6Iyuq/S0xqjoijOvOEhj+YdrsbvA7+MOkwq7hPJjq46808ma+TZCNrwz7Ce8vGKvE4mTVNfkgAr0PaiSwS/JPW9EQOnlIP37oubLxAuKuo5sKRKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=24526 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sRE6q-0000HJ-6P;
	Tue, 09 Jul 2024 19:54:33 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1sRE6q-00FmHT-2q;
	Tue, 09 Jul 2024 19:54:32 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Michael Chan <mchan@broadcom.com>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next v3] tg3: Remove residual error handling in tg3_suspend
Date: Tue,  9 Jul 2024 19:54:10 +0300
Message-Id: <20240709165410.11507-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

As of now, tg3_power_down_prepare always ends with success, but
the error handling code from former tg3_set_power_state call is still here.

This code became unreachable in commit c866b7eac073 ("tg3: Do not use
legacy PCI power management").

Remove (now unreachable) error handling code for simplification and change
tg3_power_down_prepare to a void function as its result is no more checked.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
Resubmitted tha patch as it was applied to wrong tree and then
reverted in commit 72076fc9fe60
v3:
  - Change commit message wording as
    Jakub Kicinski <kuba@kernel.org> requested
v2: https://lore.kernel.org/netdev/a6f3f931-17eb-4e53-9220-f81e7b311a8c@ancud.ru/
  - Change tg3_power_down_prepare() to a void function as
    Michael Chan <michael.chan@broadcom.com> suggested
v1: https://lore.kernel.org/netdev/4e7e11f8-03b5-4289-9475-d3b4e105d40a@ancud.ru/
 drivers/net/ethernet/broadcom/tg3.c | 30 ++++-------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 04964bbe08cf..bc36926a57cf 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -4019,7 +4019,7 @@ static int tg3_power_up(struct tg3 *tp)
 
 static int tg3_setup_phy(struct tg3 *, bool);
 
-static int tg3_power_down_prepare(struct tg3 *tp)
+static void tg3_power_down_prepare(struct tg3 *tp)
 {
 	u32 misc_host_ctrl;
 	bool device_should_wake, do_low_power;
@@ -4263,7 +4263,7 @@ static int tg3_power_down_prepare(struct tg3 *tp)
 
 	tg3_ape_driver_state_change(tp, RESET_KIND_SHUTDOWN);
 
-	return 0;
+	return;
 }
 
 static void tg3_power_down(struct tg3 *tp)
@@ -18090,7 +18090,6 @@ static int tg3_suspend(struct device *device)
 {
 	struct net_device *dev = dev_get_drvdata(device);
 	struct tg3 *tp = netdev_priv(dev);
-	int err = 0;
 
 	rtnl_lock();
 
@@ -18114,32 +18113,11 @@ static int tg3_suspend(struct device *device)
 	tg3_flag_clear(tp, INIT_COMPLETE);
 	tg3_full_unlock(tp);
 
-	err = tg3_power_down_prepare(tp);
-	if (err) {
-		int err2;
-
-		tg3_full_lock(tp, 0);
-
-		tg3_flag_set(tp, INIT_COMPLETE);
-		err2 = tg3_restart_hw(tp, true);
-		if (err2)
-			goto out;
-
-		tg3_timer_start(tp);
-
-		netif_device_attach(dev);
-		tg3_netif_start(tp);
-
-out:
-		tg3_full_unlock(tp);
-
-		if (!err2)
-			tg3_phy_start(tp);
-	}
+	tg3_power_down_prepare(tp);
 
 unlock:
 	rtnl_unlock();
-	return err;
+	return 0;
 }
 
 static int tg3_resume(struct device *device)
-- 
2.34.1


