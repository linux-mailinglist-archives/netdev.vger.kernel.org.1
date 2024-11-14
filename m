Return-Path: <netdev+bounces-144953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7699C8DBF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1048D2827A6
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074B5674D;
	Thu, 14 Nov 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Z8xk3EnQ"
X-Original-To: netdev@vger.kernel.org
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08782C859
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597654; cv=none; b=HOER9Tr+fhhPscxErU+wMm98a2npJMipa4Ei8lEJJw/nySx9qkLhkRx+KQ+zGRbViaMwrfJ9kxsGLHk/HVSQ+pR9m3RbpnJJ26VvofS2ZYFx+ADxUpwK8LNznQSttHhp/CHQDNZ5JUjfAawXoyhCN0x1RjHLEpMcXXyA71k7TF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597654; c=relaxed/simple;
	bh=T8X0tteJqvOkjCwzSMEy6f9G7n+dGsc4UfKXLkpa7EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZ8eO5Uto/Cgv+X23JdcPKkXMUJ9E2RywXTNKq2LUzcc5JADoN4OspPNXsFM9g10M6eb9pRO5xDTPz7Ep77Ih9EM3ySvYfOhY41HK/pEl3o+DINllU5RoYYH6pM2T+6lxAG5rGjldhDg8rYMO52Xxmcdrg1u4Ds7waP5zCMSa9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Z8xk3EnQ; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id E0CC461463
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 18:20:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:1115:0:640:1385:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id E1ACE6090A;
	Thu, 14 Nov 2024 18:20:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WKO97meOcW20-6XYc2amC;
	Thu, 14 Nov 2024 18:20:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731597634; bh=6yIL159saDdCAINaitdeXuHZlMRTjuEymX5gOvZJiFc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Z8xk3EnQX+e9cpmU/HwSKBA4wzEBClsQUjKZiRfDPvCcTEb+aC3KAHDRRtFYe4UOd
	 uCIS/RY/yQ+XZUaUYqKVVEHZrpilYL+OtubVCJrYtoe1Y8LiHs0ZFCk2B4/gCkpWJD
	 8bhs/fbKuPNx5ynicUyXzGwuYju3t9xRUGVzFpvw=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] rocker: fix link status detection in rocker_carrier_init()
Date: Thu, 14 Nov 2024 18:19:46 +0300
Message-ID: <20241114151946.519047-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since '1 << rocker_port->pport' may be undefined for port >= 32,
cast the left operand to 'unsigned long long' like it's done in
'rocker_port_set_enable()' above. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/ethernet/rocker/rocker_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 84fa911c78db..fe0bf1d3217a 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2502,7 +2502,7 @@ static void rocker_carrier_init(const struct rocker_port *rocker_port)
 	u64 link_status = rocker_read64(rocker, PORT_PHYS_LINK_STATUS);
 	bool link_up;
 
-	link_up = link_status & (1 << rocker_port->pport);
+	link_up = link_status & (1ULL << rocker_port->pport);
 	if (link_up)
 		netif_carrier_on(rocker_port->dev);
 	else
-- 
2.47.0


