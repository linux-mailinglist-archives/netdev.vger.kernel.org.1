Return-Path: <netdev+bounces-243223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33133C9BEAC
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 16:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E12244E0580
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 15:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134923D7EA;
	Tue,  2 Dec 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="A0vqs339"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F77DA66
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688609; cv=none; b=T7ot6l79uDPcI1P+BykVP0rgyDQPO2N4V1Y3W1tYLsj+5f4Spdk2PHRvO4MF6qNAagaQJbJgQJRv4OjTpX78X0RaeEbu/YjpL7ook2CcsF9QlReAcqQ3SAjSnZ72bsH1rIRynYBEwVx3NLenmFfOBbFxezaePNlq5aVWi0XjL1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688609; c=relaxed/simple;
	bh=2GWsfP0rjerzDQ82UTqLxgUM+UG+Xqp5hzQiMyR6sBw=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=uU9qYA8nSpd2j3Uukl4V+lVdv3GZ8FlMZwcHFKk/2Fpg3zEsEaRVmrYFzXFAZ9Soi/NT2dY2zI2KvwcBzLuddCIaxSYAYAEVjv0nCeJQGFHtdbo+AD98S8mOgQN5fZMYZ1G1wv9p+FePO3VLxU1c0WVt0xcdGA0Pr1lYzVK7ZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=A0vqs339; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=kWLmo7Y/aiyE+a5vjmu+zJKRCv3AfSvxF2lsRrJcTDI=; b=A
	0vqs339Lof8j8uZzIC1E4/R0/e/KcBz6k316AYhtuDUGIsohOIqiNjyF3l/97honKaxLYOlyKM9f8
	H9EEevEycYzkgAaXg0p+leUjDhSIhPYEwIHntQpdjaokIkyPCwi1tX+UEl5O2Wpvf8tRq1ZYwI1Sc
	8JTMw+pVMG2Fg3qlykxWTAY2inws/nE8o7KGBIDKKpJo7IbyW0lmmM2XY48i870t0WDF1j45c6ECF
	LeAPV/xQd477j6OEO4MCf78Zqw4zfB6obRTLXtD91WdlCIWgz+13G/5vRt+QIxALd5ZvpB4DO4rO9
	w44FEqBoVDZCXfp9yPB5Hh1H32SuNrG8g==;
Date: Tue, 02 Dec 2025 16:16:42 +0100 (CET)
Message-Id: <20251202.161642.99138760036999555.rene@exactco.de>
To: netdev@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Subject: [PATCH V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Wake-on-Lan does currently not work in DASH mode, e.g. the ASUS Pro WS
X570-ACE with RTL8168fp/RTL8117.

Fix by not returning early in rtl_prepare_power_down when dash_enabled.
While this fixes WoL, it still kills the OOB RTL8117 remote management
BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.

Fixes: 065c27c184d6 ("r8169: phy power ops")
Signed-off-by: René Rebe <rene@exactco.de>
---
V2; DASH WoL fix only
Tested on ASUS Pro WS X570-ACE with RTL8168fp/RTL8117 running T2/Linux.
---
 drivers/net/ethernet/realtek/r8169_main.c | 5 +----
 1 file changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 853aabedb128..e2f9b9027fe2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_enabled)
-		return;
-
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
 	    tp->mac_version == RTL_GIGA_MAC_VER_33)
 		rtl_ephy_write(tp, 0x19, 0xff64);
@@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl_disable_exit_l1(tp);
 	rtl_prepare_power_down(tp);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
 		rtl8168_driver_stop(tp);
 }
 
-- 
2.46.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

