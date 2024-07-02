Return-Path: <netdev+bounces-108413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF5923B8F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAE12855C9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C427158A3E;
	Tue,  2 Jul 2024 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="RgYiyb5G"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65977156F5D;
	Tue,  2 Jul 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916560; cv=none; b=YR/aBHY9HBtLtpHB0ryZmQAtF6dcBxvsabuadO2IkwAusOOomuG5+EIFxor/G5XQuqHjVokVhGWPWniwrSOsPl/c8Zh1J5JhfoN8VGb0TjrSVkW4vX1R+NgVnm+UaSdnAOvIBILwnOh8+DXVgd/H7q6YxtaeM59O1gUv5q54H74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916560; c=relaxed/simple;
	bh=Nu9SNRKlY5dcGjnfA90V2TuhQrrDN9sZftchFkZx3js=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cfHzX9GR5NKvgKnQubK6MLQGl41OFXK6uByqMYatdZZE8XfRT0QjhgM1nnY4Y6fs9kMfNNYc+OPaOAvDAWKsO4uB+/5+wtfQiIqSRi2EKlepablUTAZ9KJSLwnxEhv/V51teogj1XTBr9A0k1EQFRp565Hrpiw6v1TJk33226Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=RgYiyb5G; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id E49F8100004;
	Tue,  2 Jul 2024 13:35:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719916536; bh=xTXqeo22zGaunSUFiiPX6tZNCiEVm+Lap5W0eeokBtM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RgYiyb5Gn4xCRwGGY9ZGUATIE6VzMjOqwDLEYiohDdsh1D4G98N7qzf48oHpFywQp
	 ffLRgHmgkSo1OQPfzEZKou4VAW1bU7kcfTWR1dlbf5H/yCdqlOGQgGKZFSM0YD52zU
	 Vcb8hU1alixquwNeZTaAq3HwXBof7VqH4CYDv8R+SuvR8YxtTBLnb1JsPM98oXQEw+
	 uwlC+6KVqmwg6klkxoaxQ2GDZY49L9YhrUlXFdbyQF50YVdrminxXC5SIxYrJLgOKi
	 er99OCTKLMNsFJlzMElDrsuX9O34KzZihdHEIj+pAlOD/lurRsLdh4OsrghCLFMYjJ
	 YonoHz42pC3zQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  2 Jul 2024 13:34:26 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 13:34:06 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Jiri Pirko <jiri@resnulli.us>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] mlxsw: core_linecards: Fix double memory deallocation in case of invalid INI file
Date: Tue, 2 Jul 2024 13:33:52 +0300
Message-ID: <20240702103352.15315-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 186273 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/02 10:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/02 07:20:00 #25796017
X-KSMG-AntiVirus-Status: Clean, skipped

In case of invalid INI file mlxsw_linecard_types_init() deallocates memory
but doesn't reset pointer to NULL and returns 0. In case of any error
occured after mlxsw_linecard_types_init() call, mlxsw_linecards_init()
calls mlxsw_linecard_types_fini() which perform memory deallocation again.

Add pointer reset to NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b217127e5e4e ("mlxsw: core_linecards: Add line card objects and implement provisioning")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
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


