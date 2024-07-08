Return-Path: <netdev+bounces-109713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B5929B1F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 05:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3683B20DB2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D2A6AAD;
	Mon,  8 Jul 2024 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="J/Cz0gDK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09EC3D76
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 03:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410167; cv=none; b=ev4axHwrrW3zncWdvMPvK3gow+1DZGXFXewK2H7iZZZPTmiY8RbdOKSBcMA7LzRrQNU84IcwrqI41D+uw81XJ8WBHxGjrFtSG3+iuPxwgwvDdbZonzFnwCWApz/iyBK7OtwXFaWC+j72mqoanQEKyQgUjwLZmZ8krOoOQ8z/0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410167; c=relaxed/simple;
	bh=XfbHPW/CBgjCNq5X5KSdoFex1tdY5vmRGeWBPUXpT6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gF1gh9QbgDtq6ree0D5GSMObfJZ+tY5TlZKyqQ4Np/tI0MgdlXq3GZXvh+3Iv68Xl55XJk4EtUYkPooBzf4X4GPjfc3cn6P6954vi40HtRVSOohD6zQAcvsIoFbRble8yCDfEO7+jVCfstzzk4HsY97PL+hAUNIUBBqJJQ78CX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=J/Cz0gDK; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 4683fVKl008132
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 8 Jul 2024 05:41:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1720410097; bh=3kRB52cUpyTOGMGkl165XS7lHtZZTm28uGPgb66G7uQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J/Cz0gDKwu02nQdYHXPHTFExkzizu/+hVX7kDgg7ZL/3fxUGijmlyCEj5TPkaOA9T
	 yRB1HcA1GjE8krGzvlSCGTBZcNvLXw21ilzom+bJjgQV7NRSHvJLm+bGKFsPvDPfPg
	 4wshODMhCUnPm7IoiP4twJQUgAFDp/xBt2kDXVZQ=
Message-ID: <c11f42c6-7d65-4292-840b-64f13740379c@ans.pl>
Date: Sun, 7 Jul 2024 20:41:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] net/mlx4: Add support for EEPROM high pages query for
 QSFP/QSFP+/QSFP28
To: Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
        Michal Kubecek <mkubecek@suse.cz>
Cc: Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tariqt@nvidia.com,
        Dan Merillat <git@dan.merillat.org>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl> <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
 <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable reading additional EEPROM information from high pages such as
thresholds and alarms on QSFP/QSFP+/QSFP28 modules.

The fix is similar to a708fb7b1f8dcc7a8ed949839958cd5d812dd939 but given
all the required logic already exists in mlx4_qsfp_eeprom_params_set()
only s/_LEN/MAX_LEN/ is needed.
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 619e1c3ef7f9..aca968b4dc15 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -2055,20 +2055,20 @@ static int mlx4_en_get_module_info(struct net_device *dev,
 	switch (data[0] /* identifier */) {
 	case MLX4_MODULE_ID_QSFP:
 		modinfo->type = ETH_MODULE_SFF_8436;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		break;
 	case MLX4_MODULE_ID_QSFP_PLUS:
 		if (data[1] >= 0x3) { /* revision id */
 			modinfo->type = ETH_MODULE_SFF_8636;
-			modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
 		} else {
 			modinfo->type = ETH_MODULE_SFF_8436;
-			modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
+			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
 		}
 		break;
 	case MLX4_MODULE_ID_QSFP28:
 		modinfo->type = ETH_MODULE_SFF_8636;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8636_LEN;
+		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
 		break;
 	case MLX4_MODULE_ID_SFP:
 		modinfo->type = ETH_MODULE_SFF_8472;
-- 
2.45.2


