Return-Path: <netdev+bounces-100482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8628FADEE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADB81C24268
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA4142909;
	Tue,  4 Jun 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="ZIKIvBZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A5142E71;
	Tue,  4 Jun 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490900; cv=none; b=Xn8kIM3tuSYSnAV8tTwpXFV/MPlG0/ReEZthOATtK9ufhnM+FhW6qy0JeGrDb+dS0mz586efbZbMjhMJkNdjpesmlf7Ky0Xy+hoJMVE0aA0gnZhnq50waKWYIIerSjrY7dp9F2rxHRMxwqb8MC4mX4XgDR2udWPup0kPpHJXEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490900; c=relaxed/simple;
	bh=ObDTaMyPlg/EZhuVBdEekc70AuBXcehtfJBGseg+zr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EyodKtvbZ0gd/cDi2Cn0IT75JWG1dIBBT3x/V3+nIhWTr+joDgtPyXFQyL6kO/pnBh955oL+Jhp8p2PpIqJ2gUW5j1I6rRvfHhBZZcFgmL7lXwk4vBk37Lx1dVzPcgk8jprl1O2aMpuhik4F+BDvuGz1qjkCXr2gqPesL05KrbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=ZIKIvBZQ; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 72C62100002;
	Tue,  4 Jun 2024 11:26:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717489617; bh=96aA8g6YCTBuSRhoE/7DN9QszXndOKeFlN3aO62Y29g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZIKIvBZQsEo2y/eV6W7Lqkym6HpSHl5xXWZUNpzzpwB6x+tP8pYLUbRrut03ziRHC
	 lX/3BhVJu/s+OGY6JiPdvTp1K6eaSmhfLAtErdJbNxxnFEs4a+k8DC3AZFoOuTI4Ms
	 t5D3Jdl//wpAfUAH5eazqsom8RNICqyoUfoEETXBXm0b+aCnfE6OvaubvadyJIRB7g
	 bGDdmLJ4cuEez6GzkqLy300nK3TpjlVoTjkdxpkoGXDsR1h3YHRyD5GC7tzmGhUyrO
	 GkYAet0DpIASTbptIbjRbtvjxGQceEIdgjhVrUU+rkFGFsAk5oP+2bIy7O+gCzc1Ag
	 ba3QwWGJubuAw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  4 Jun 2024 11:25:47 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 11:25:17 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: M Chetan Kumar <m.chetan.kumar@intel.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Loic Poulain
	<loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes
 Berg <johannes@sipsolutions.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] net: wwan: iosm: Fix tainted pointer delete is case of region creation fail
Date: Tue, 4 Jun 2024 11:25:00 +0300
Message-ID: <20240604082500.20769-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 185698 [Jun 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/04 07:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/04 05:43:00 #25435061
X-KSMG-AntiVirus-Status: Clean, skipped

In case of region creation fail in ipc_devlink_create_region(), previously
created regions delete process starts from tainted pointer which actually
holds error code value.
Fix this bug by decreasing region index before delete.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4dcd183fbd67 ("net: wwan: iosm: devlink registration")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/wwan/iosm/iosm_ipc_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_devlink.c b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
index bef6819986e9..33d6342124bc 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_devlink.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
@@ -211,7 +211,7 @@ static int ipc_devlink_create_region(struct iosm_devlink *devlink)
 			rc = PTR_ERR(devlink->cd_regions[i]);
 			dev_err(devlink->dev, "Devlink region fail,err %d", rc);
 			/* Delete previously created regions */
-			for ( ; i >= 0; i--)
+			for (i--; i >= 0; i--)
 				devlink_region_destroy(devlink->cd_regions[i]);
 			goto region_create_fail;
 		}
-- 
2.30.2


