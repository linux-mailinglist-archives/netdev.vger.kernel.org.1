Return-Path: <netdev+bounces-150879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388E99EBEB0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFDE165D64
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D41EE7C0;
	Tue, 10 Dec 2024 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZX1KD8qr"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7080D1EE7BC;
	Tue, 10 Dec 2024 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871426; cv=none; b=sMzQ7RAGTi4CJXR3x//mB/Lnab1QzIIswh/MGht/fiD/FYZLZYy0g1A70lnjzRsIaDhNVzTBtj/JR2H/+V3nmoCY3QHlM+66w1IHDlVcSueQx09qCm7gjJP9+yDejKchQjP+FPIw/CJ4BV/Wm3RN417IKK5Yb0IWXUqlqbuBj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871426; c=relaxed/simple;
	bh=aDJYuHTVIPcfwds/5h9Cu2nSsFCBNJm7sgsqqhfWahk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLSLM0d/XFS736eejg0H3B/rt0pjR3JlRrYSBA0+v9wCfDnl4pZZzNHiyk3RNv7kJ4l//5yzaTdk8QKWW4EXJC9OAZXw52i6UIcyRlsjc8wF4m75dKOIg2Sf+9BL+et27ZZGK1K8Alnu0YXbw0b0kVSZRWdnG2PNm/aVk2L0AoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZX1KD8qr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 15E8320BCAD0;
	Tue, 10 Dec 2024 14:57:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15E8320BCAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733871425;
	bh=A/ylo3EEJIlKIUUvd/B8GlET2XFlCykqzZbK6fWAm6g=;
	h=From:To:Cc:Subject:Date:From;
	b=ZX1KD8qrlJqevrUSo5mkGQ6JDkfxl3hG4GDpPajbkj5ntWy+FCQIk8Lc4Z97l8GXS
	 dK3xhebQLyN3PhSH/QwK7GuW/qSdrLHoGfj4oMCp1X43HGApYNi8HP7eflvQeaD2Ae
	 VuVfPzCvCq/LP+vM6JqDHqUcTsMN9A9yzq12Uyn8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	James Hershaw <james.hershaw@corigine.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Mohammad Heib <mheib@redhat.com>,
	Fei Qin <fei.qin@corigine.com>,
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH net-next v3] nfp: Convert timeouts to secs_to_jiffies()
Date: Tue, 10 Dec 2024 22:56:53 +0000
Message-ID:  <20241210-converge-secs-to-jiffies-v3-20-59479891e658@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies(). As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
This patch is pulled out from v2 [1] of my series to convert users of
msecs_to_jiffies() that need seconds-denominated timeouts to the new
secs_to_jiffies() API in include/linux/jiffies.h to send with the
net-next prefix as suggested by Christophe Leroy.

It may be possible to use prefixes for some patches but not others with b4
(that I'm using to manage the series as a whole) but I didn't find such
in the help. v3 of the series addressing other review comments is here:
https://lore.kernel.org/r/20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com

[1]: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 98e098c09c03..abba165738a3 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2779,7 +2779,7 @@ static void nfp_net_netdev_init(struct nfp_net *nn)
 		break;
 	}
 
-	netdev->watchdog_timeo = msecs_to_jiffies(5 * 1000);
+	netdev->watchdog_timeo = secs_to_jiffies(5);
 
 	/* MTU range: 68 - hw-specific max */
 	netdev->min_mtu = ETH_MIN_MTU;
-- 
2.43.0


