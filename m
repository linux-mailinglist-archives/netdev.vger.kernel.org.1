Return-Path: <netdev+bounces-63097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73F82B2F7
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C819C1C24730
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE932C6A;
	Thu, 11 Jan 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="e9PYNJE3"
X-Original-To: netdev@vger.kernel.org
Received: from forward203c.mail.yandex.net (forward203c.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4E29CE7
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by forward203c.mail.yandex.net (Yandex) with ESMTPS id C4D4763F9A
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:25:10 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3ca6:0:640:63d4:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTP id B983F60906;
	Thu, 11 Jan 2024 19:25:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1PmT2VKHcCg0-ZOuVrQGa;
	Thu, 11 Jan 2024 19:25:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1704990302; bh=Qj9y//W+rUAYoIYI3FkBVHx+UZ1/3+1TLrqvufHxTE4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=e9PYNJE3+TaF6e9MEofzej+uMKtk8AU0ADAaVmxfNJPuuAcyW1VoojaA3t1o4pXyK
	 ftgqPWdEvgoxItssKDxSPw0DvCXKfddYQwCioCITq3dP2eKj9RqDfEN0puZXL0MZqH
	 5FMLJkSp1fFQwxu1Rcaaq3UAvptNc6vcucdyuflw=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Derek Chickles <dchickles@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] net: liquidio: fix clang-specific W=1 build warnings
Date: Thu, 11 Jan 2024 19:24:29 +0300
Message-ID: <20240111162432.124014-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with clang-18 and W=1, I've noticed the following
warnings:

drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1493:16: warning: cast
from 'void (*)(struct octeon_device *, struct octeon_mbox_cmd *, void *)' to
'octeon_mbox_callback_t' (aka 'void (*)(void *, void *, void *)') converts to
incompatible function type [-Wcast-function-type-strict]
 1493 |         mbox_cmd.fn = (octeon_mbox_callback_t)cn23xx_get_vf_stats_callback;
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

and:

drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:432:16: warning: cast
from 'void (*)(struct octeon_device *, struct octeon_mbox_cmd *, void *)' to
'octeon_mbox_callback_t' (aka 'void (*)(void *, void *, void *)') converts to
incompatible function type [-Wcast-function-type-strict]
  432 |         mbox_cmd.fn = (octeon_mbox_callback_t)octeon_pfvf_hs_callback;
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix both of the above by adjusting 'octeon_mbox_callback_t' to match actual
callback definitions (at the cost of adding an extra forward declaration).

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 2 +-
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c | 2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_mailbox.h   | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 068ed52b66c9..b3c81a2e9d46 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1490,7 +1490,7 @@ int cn23xx_get_vf_stats(struct octeon_device *oct, int vfidx,
 	mbox_cmd.q_no = vfidx * oct->sriov_info.rings_per_vf;
 	mbox_cmd.recv_len = 0;
 	mbox_cmd.recv_status = 0;
-	mbox_cmd.fn = (octeon_mbox_callback_t)cn23xx_get_vf_stats_callback;
+	mbox_cmd.fn = cn23xx_get_vf_stats_callback;
 	ctx.stats = stats;
 	atomic_set(&ctx.status, 0);
 	mbox_cmd.fn_arg = (void *)&ctx;
diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
index dd5d80fee24f..d2fcb3da484e 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -429,7 +429,7 @@ int cn23xx_octeon_pfvf_handshake(struct octeon_device *oct)
 	mbox_cmd.q_no = 0;
 	mbox_cmd.recv_len = 0;
 	mbox_cmd.recv_status = 0;
-	mbox_cmd.fn = (octeon_mbox_callback_t)octeon_pfvf_hs_callback;
+	mbox_cmd.fn = octeon_pfvf_hs_callback;
 	mbox_cmd.fn_arg = &status;
 
 	octeon_mbox_write(oct, &mbox_cmd);
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.h b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.h
index d92bd7e16477..9ac85d22c615 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.h
@@ -57,7 +57,10 @@ union octeon_mbox_message {
 	} s;
 };
 
-typedef void (*octeon_mbox_callback_t)(void *, void *, void *);
+struct octeon_mbox_cmd;
+
+typedef void (*octeon_mbox_callback_t)(struct octeon_device *,
+				       struct octeon_mbox_cmd *, void *);
 
 struct octeon_mbox_cmd {
 	union octeon_mbox_message msg;
-- 
2.43.0


