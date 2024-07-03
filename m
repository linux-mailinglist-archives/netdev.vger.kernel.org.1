Return-Path: <netdev+bounces-109040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3BD9269A4
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FAC1F24CCE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA1187560;
	Wed,  3 Jul 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="oLxJbbiw"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448B4964E;
	Wed,  3 Jul 2024 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038895; cv=none; b=s9/zRfuGCy/8x6m0+w0VpOCqgm2abjPlX7YMnV2zSYcgubISpH+HTpKQfTLJ6gR4qd7PFrBoZXPnLAKcZBL/yZECHjOVLhKGbIlipnSdk7Y2oXCb2ilGmO7MVfQ+LzINUHALOkTYWXkRYfF7LstJOBPuN9jT/OE48R5nbssM0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038895; c=relaxed/simple;
	bh=Zz/epqt5ZRh8ui97t65GrBhekOF+Qb7LbgbykpbYtdk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iyvl9dSv3fL08VUyuKJQHyiDFX4D3dUFyEXVT5RLn8f09pQL6QHQHf6XmiIo2aZK7RHnYIXo+TZOUK6I1HwuwnOX4PIfuKIeLluUDm+qohz5GpLGVURSw30o6ACk/8kq5NHOBQaN4IB2VPkumhDfVv3KxgMIZt1qNTtCtJJTuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=oLxJbbiw; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id D097F100004;
	Wed,  3 Jul 2024 23:34:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720038870; bh=+w5nLEKphcLgW6rn0LDohsYxcRdzToxepNB2cUqDYdY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=oLxJbbiwUyUJp9W+ibOTqjN5D3p1y4+h5MFGapmdzoEtwEE7svaRLTf2SpLf478Rg
	 19bhKEVo9ZMZkJnxBd2TAqtV7WGzbQLdYHYiP4FYMm2U8oO3CeoAPAwgMvXkz44QpE
	 lpPqxpVrRkPtXXOCprls/BpNGOukTafD+cpHTrf6a5L4Js3Ln3naP8dop9BGA47Cpu
	 0xCnOaGfb/VjdcfvTgeTWWJgQbPL4ngbkjNOKSF1P2n2v3WVbk3GUhlABRNVCcpynE
	 2YVN2bOaDSo/fdmxdOJh3WnkXGIFcWv2G+QvQV6Zk6DxerWsCLBCcMpqui9MHhXnJU
	 GuXHJKopS92Tg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Wed,  3 Jul 2024 23:33:23 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 23:33:02 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Jiri Pirko <jiri@resnulli.us>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v2] mlxsw: core_linecards: Fix double memory deallocation in case of invalid INI file
Date: Wed, 3 Jul 2024 23:32:51 +0300
Message-ID: <20240703203251.8871-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 186316 [Jul 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/03 19:52:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/03 17:02:00 #25823003
X-KSMG-AntiVirus-Status: Clean, skipped

In case of invalid INI file mlxsw_linecard_types_init() deallocates memory
but doesn't reset pointer to NULL and returns 0. In case of any error
occurred after mlxsw_linecard_types_init() call, mlxsw_linecards_init()
calls mlxsw_linecard_types_fini() which performs memory deallocation again.

Add pointer reset to NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b217127e5e4e ("mlxsw: core_linecards: Add line card objects and implement provisioning")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
v2:
  - fix few typos in comment as suggested by Przemek and Ido
  - add Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
    (https://lore.kernel.org/all/c631fc5e-1cc6-467a-963a-69ef03c20f40@intel.com/)
  - add Reviewed-by: Ido Schimmel <idosch@nvidia.com>
    (https://lore.kernel.org/all/ZoWJzqaRJKjtTlNO@shredder.mtl.com/)
v1: https://lore.kernel.org/all/20240702103352.15315-1-amishin@t-argos.ru/

 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c b/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
index 025e0db983fe..b032d5a4b3b8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_linecards.c
@@ -1484,6 +1484,7 @@ static int mlxsw_linecard_types_init(struct mlxsw_core *mlxsw_core,
 	vfree(types_info->data);
 err_data_alloc:
 	kfree(types_info);
+	linecards->types_info = NULL;
 	return err;
 }
 
-- 
2.30.2


