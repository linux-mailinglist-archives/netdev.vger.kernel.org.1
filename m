Return-Path: <netdev+bounces-122781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50819628A0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A501C20BA2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3BF1850A4;
	Wed, 28 Aug 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="c8kcyQH0"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3E16BE30;
	Wed, 28 Aug 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851737; cv=none; b=IPwsAhGSzR8qsFCIMcnAOpYCGchiQYpNljrqmDV6ks+ORven9Rz/gCxobVMhosvRj9uCu0qhZUsAluX5kJbPtXkCtWnt2a96YQxVh/riGoJz3fyc0y3IWvt1WDyzs0zw9QWoOYa/dQKCDm3jF3TbWv01V862Y8e4OPOBMgMuCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851737; c=relaxed/simple;
	bh=nv9P0I0ziGxkG0t9kR1RGOjjoLHoqRnw7ItUnlNg9EE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BhMIfUwZiOd0W43HhFXHR9rWzRgHrXYIZK0huNR+8mzit4zgWHf8OE7fOhNN3SbYhvhMb2xJgoNYuPeqi8oTOMyPeIL18Pnz0CdrQ2aP0CbJ55b5lblTsmNK0fL2P8iDhvHaysfn+/HghRx58ztGnLdKBL9F1UEZ/gRmGiQp4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=c8kcyQH0; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 62016100004;
	Wed, 28 Aug 2024 16:28:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1724851711; bh=gdf52+4K16QtdI7+VRo9GNJmZUemcY6slADrDQ4ikHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=c8kcyQH0pgOn0s5P9LmD9C2drpA1J7LwjQUtqaKHCzF2Mb8TMsIKi3jG4aYwTKKCN
	 S+z+yPTigy9j1q8et31qMsrpLrnoYhrFHo8g7xl+gGzugb52hjn8fjaDXXsiAw8Ilk
	 xEHWFlLYidIfQKPnEyRdawygk84UDj1fpeo/FvbIa81/CDvzVzSXoL/zhdC6Iq6Mdu
	 gsIhD9fBverlBMV7i1m3d1aQTAAjg5bC3MA7RH8jDOazAkL8Dj+eT+vPcYAXRMp4cc
	 714ZRWqkrTlXa/1xJ+ephnROwLDpFhfuYzS8J+Weq9AcoWY2GqCtbbPK8lgweiuONq
	 MvyYdNvYgPbgg==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed, 28 Aug 2024 16:27:19 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 16:26:27 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Vadym Kochan <vadym.kochan@plvision.eu>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Taras Chornyi
	<taras.chornyi@plvision.eu>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Oleksandr Mazur <oleksandr.mazur@plvision.eu>, Serhiy
 Boiko <serhiy.boiko@plvision.eu>, Volodymyr Mytnyk
	<volodymyr.mytnyk@plvision.eu>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] net: marvell: prestera: Remove unneeded check in prestera_port_create()
Date: Wed, 28 Aug 2024 16:26:06 +0300
Message-ID: <20240828132606.19878-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187387 [Aug 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/28 08:19:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/08/28 11:49:00 #26453044
X-KSMG-AntiVirus-Status: Clean, skipped

prestera_port_create() calls prestera_rxtx_port_init() and analyze its
return code. prestera_rxtx_port_init() always returns 0, so this check is
unneeded and should be removed.

Remove unneeded check to clean up the code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 63ae01954dfc..2d4f6d03b729 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -718,9 +718,7 @@ static int prestera_port_create(struct prestera_switch *sw, u32 id)
 		}
 	}
 
-	err = prestera_rxtx_port_init(port);
-	if (err)
-		goto err_port_init;
+	prestera_rxtx_port_init(port);
 
 	INIT_DELAYED_WORK(&port->cached_hw_stats.caching_dw,
 			  &prestera_port_stats_update);
-- 
2.30.2


