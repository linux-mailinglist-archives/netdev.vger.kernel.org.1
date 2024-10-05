Return-Path: <netdev+bounces-132394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB66991813
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C89B20E33
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2515697B;
	Sat,  5 Oct 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="N1rw0wA/"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011034.outbound.protection.outlook.com [52.103.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C241156C5E;
	Sat,  5 Oct 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144282; cv=fail; b=Qvsr1jvAG1JgEWxts91dJjx/4RegXr3UFyRqXwPxp6BNls7NiihyUejAKktGxDfl3Zj4qzJpc3Y2CeSAgzBa0mvSFeNo9RfWApyUmWiH7cZHjyX4qXwWrwg5vA7rn4Bp7jgn36MmSCxlQK7AOWgs9oZ52tGp6z+V5J4Bzz2FOQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144282; c=relaxed/simple;
	bh=AlkkQn4AelrY/yMU8+YivaFf7M7nPs5/rrRM8jmueaQ=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=mAOdeRXQU9Tw0KRQcTGEMVtaPXMkgGBANmNz5scqfatybEYdxffFo1+KjRcxDJGSky3kyFd/Q9jm4FN9CjG/00a0pfrKjV+cCp46ZEOkcQ8bxY55tt5+LbPn9iJhDpHL/He4TG/MdruoX5vrPCYggUWQsRZBuYpsBQFByW7bEvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=N1rw0wA/; arc=fail smtp.client-ip=52.103.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGD8oJD2b3yHBtL/gB5zGvbCKv1I0IKUzCmM6XSCwJJl86mKxZdrSHTQGsZyTkMo+67T4832aE8OvxYajYA6CcWk8q6TqpR24aG3oZCRKXkVqTlqLwpaWYdfoKSlU99PbJxR2vcEcP0kCNmsj75saquf8iAdT6kpA+9JIz8xC68UU8z5M2hHZ9/yiqg4eJMWS2L6NtyKZbAb0NajZfUSXujgLoL4WptYMZAIgFqFg5yFBBo/UJxJN2tXtO+ApN0pxY8XXboKTvzi3jO6CBXJNkCqTTvNKlNP7eCj03u2BddWujwU6kk3bRGz/65rTJV+ZLpDq0dgjcTC7Y1hjtFLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWfV/MOhnjHIvkCWN7Ss6xMp2bu3feAq5MJA2toOm/Q=;
 b=SP3zXbQXv1HqPMPnRC322DTyvtqFkG/3RSPJcVuygbCXg2FnfvuGg6eq1Fa+gbkLtYgOnSLR/2V85PoaP/ldsgjYqh/fufRWXyJhY7yRbPEBS+grKzwurZde9JKFMdHtXXpMEJr+W2XsruaqKmJVGY03SXemhDRrbQw1YzLl2dTZuNObchhHkD6FPSsidHeibZaRTNCC85rVnE8n+fOpLRsrtfNLa0QYv6jERBLeX8SMvvpw+PkCME5yVmq3IrWOTIcuHO7Ih/dTVhk708TFPqH/Ouxjnl+lQbFKp3dbyNnb7lh4B/WydOcQtxYNicdtZm1h6TDOTbjXoq/fKHJ0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWfV/MOhnjHIvkCWN7Ss6xMp2bu3feAq5MJA2toOm/Q=;
 b=N1rw0wA//iXMhG6qis4Ys2TfeSM2qnKKeXAAhUfBSyMEHwFa3V6Iycw3Hw+ycQ6QuMQkU4nuYEU8L0UVDQOfbNYwWNa2qyJlJ8wDb1IHRVB5EaWdSnmQ6xGOm9Dkc97owKKFnGJ1ZKR2TOOe3TCxUGAPuV4n5FNmqKReJtIWfwLMIJRxf8EmDfE8Xx/FIEafQCrG5q6mAdOPDMlASSWX51bKynR7YdsCHqxTn+7Ai8tg5hTWVx4683nHHe3508eT32XvMtzMPVBfR4jlUehSkMU0gqmQA3kCmNXCHWjzWT2Mz7N+uNCJyOyBX/1fepaanCnb8Uhjg+uwIIsb19w6NQ==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYCPR01MB10809.jpnprd01.prod.outlook.com (2603:1096:400:296::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 16:04:36 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 16:04:36 +0000
Message-ID:
 <TYCPR01MB843714CF627B46DFA06E471B98732@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sun, 6 Oct 2024 00:04:29 +0800
User-Agent: Mozilla Thunderbird
From: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1] net: sfp: change quirks for Alcatel Lucent G-010S-P
To: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wiagn233@outlook.com
Content-Language: en-US
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::17) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <aa3e8858-65bf-4faa-b117-8fd14742d30f@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYCPR01MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: f2419238-3e7b-4c8c-b78b-08dce557689c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|5072599009|8060799006|19110799003|461199028|5062599005|6090799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	jB1mYSO/a+yjj5rrpVJwGKA20b0GMKO+39eFa2Qi2tdgunx7EvQJgezJI2nmeeoa8XyY5Vy5X/Di7Inwd/Z9r96tGlYP3xi5Tc7OcaBH0FqRreBH58FjY8gHghlrOp9P5g6hsmX457++IkJJeR4xh2mVSXHOrvi/rk7UhiyiHACCscH0wKYmiKeOaLQYalaUB/tMZ2nqbJ3cKvK4TWXjSZU58kNH1wg2a9wDngELS+kJLWF+KHLgegnnMEfm1NL0j4dGmkndvgxnJmQmfR3eoZwpC+T+CnPsO+BGx80r50o1LubUbtppRq8UNMWNrVkq8V41RFK4lnUB+IuSkN8egCYklv7ZbyaW02q0qRRYkV8KmmiHUMi0yrONH5xFn3WFWqYrYZzsayp9jZqFOh107KrLtfg9KyaiLBdaTycZKjFzK4YqE6eKKG6R5oTTSuymnp8IzVtbt8lMdrqUG0onR/jsKd5rxgUJkPZ9aUaTKuX+ZXB4Rnb+g2AQ/KqhaTsgLgmZ5Mi825teKrplv3ekHrXyTI+1l6y49fsOHl7HF+fapAKlap8JFjGCamKaE84NBMDhOaWWqwO9WPx9FNbd5B7aqoDkMFesOC88Lcswd1ByGySCKzN9S5ngnjW6Y7D3j3CdvucDYREMpSGOzFmzW7eRRp+Q8mdCqZD7TGoAfW+Bff8+Mjmjl9ad2IfSSRrBrS4JlexfxZQsmDrIiGEGL8sZfBmtVgJp+DQ/s5ZvKE1VcziU/2wGYCFu8dMrQqfpHBehmftvv/Y7c4iO93ZXuqJpHZ/PXMgWAznu1yMOaLHn09ygq/ZCRPxDUGJqLwjn9gXQ5G1Z20CEzX6qYjJjXw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFFkbk5FVW1GMks1VmZSN2IxZ2VNSGJOTmk0b1JKZVZvNlVGM3pGM0I1cG11?=
 =?utf-8?B?YnB4MVF6aEFWZi9OZDA2VjJ1dlM1RGJ0SDhQZVc1MkNEUmdjWW5TUmwzNGRI?=
 =?utf-8?B?T1U0QmRQL0xpZ3BKQXlwajFMd01XRFhhMFpRNzZab1BvbTVCelQraGUxZGVx?=
 =?utf-8?B?WTFPZ1cyUEJnZ0RKbG9PajQ1WmQxc2VHNFZ2d25SaldxS0ZiT0FrZ0Rybkpw?=
 =?utf-8?B?QktnQ05HOFdnWmlpbFBxTkEzbld1cDdOaTFIdlNBamN5NU9hUTg3MDRsREl6?=
 =?utf-8?B?MDFkS2hJNVlrc3pXRXBKcXVlcUZTSnNUNng1cVdhdmtSRTVOY2xSTEpYSzdv?=
 =?utf-8?B?QXpaZUNPYTBzTjJvODR6ZzNSdlIrWE9wazZXbngzZjhjZUtjRERINEZFZFBh?=
 =?utf-8?B?eWtaVDFUM2E1WVd2WnJoMXJ4ZURwcjJDRlIzdGRuVzUxZWhQQTkwZVlMMmtr?=
 =?utf-8?B?c3hnVUNJZ3FDcmFETlNPcExVMWFBWkRKaG1Na0xvTGZmVEhZaGxTSFpyRWQ0?=
 =?utf-8?B?TCt1R0pHREVFTjVHTzVHalh3aWxIbkxtNlRwWDZGWjNpYS9RUkVmVm1rWkVZ?=
 =?utf-8?B?Y2NMekorSW5iRzdhWnpLRkd5VDdNejE3UWZTT2NWWWFoVGczTDQwU1pUWW9O?=
 =?utf-8?B?Q3UwTXB5SVdkRDBqNzl0V0xGMmFoeTBhSHRGT1VOZ0xQS3kzVTRyTjY4VjVL?=
 =?utf-8?B?eERtNXVFUlplK2FJWGlSMUo4OWRWMUpQZE1WM0MrbGdoWTNSZWhDajZPd3VP?=
 =?utf-8?B?V3pLckxnM2w5d0pJREwyNGdnVXlaSmdFSFdlVFpXNnZLbUI1UmpVRW15ZEFu?=
 =?utf-8?B?T24rd094OHhhM1hJb0FRUVczOUdudUJTWnRVMVBEQTN4cS93dzZFeGdUaW5i?=
 =?utf-8?B?VEQ3WVRpNnZLQ2doeFE0UUo0cTkvdzZ1SjhzTzF1dGlQSnZ5S2RMNi9mT3dn?=
 =?utf-8?B?YzhTaUxYSHQvV1JwY0VkRWF6eEs0NnBCS0NzemJZYVQxcXp5MW9hVS9SV2lJ?=
 =?utf-8?B?M1BPRHlSNFp5am9UTHFGZUlkK3VzdG81Q2xFUmZIY0ZySHJxZ2xoUVRsc0JI?=
 =?utf-8?B?OWRSZ0t3aEtIdEVJamdCVHhwS09HM2V1Q1VyV3RrVE0zTjNRMGQ2bU8vV01s?=
 =?utf-8?B?ZVcraXhVcG9VVzNjUWc1VHhNOFZmZGlOQnNFYWcybURKTlVCUUhvWVBjYkVy?=
 =?utf-8?B?eXdKRXU0WFBiWWplSHNmU2kwNldhNlpPcjlFN1QxWDYxbEtucHZTdGNLdjdY?=
 =?utf-8?B?WW05TFVrdkYrT1JwcFdGcHQ3emIxU0JqbkdHdHVVdDZVS2NhRjdPbDFBUnVk?=
 =?utf-8?B?bXBEYVF6T09iSkhLOUdsS2VVaEdnRUp3eXJ4YThJR25mTFBpdWdqeklsbnVq?=
 =?utf-8?B?bU5Ld3BGZ2RhREpzeVc1OTJwY25GalBRcGpUbCtZeGVrN2JlbEpPZy9aakZw?=
 =?utf-8?B?OHczQjh2eFYvNmpMN2o2dU5sVXVjZ1c2ZjJaVHM1RVIzV3VkbWFYL1I2Y3Q0?=
 =?utf-8?B?cmtwVTBIUGdhZVlNSXl5VWZvaE1oTmFGeDVXeVlxeVVnUS93bnlqcjV2SERI?=
 =?utf-8?B?a2JkSHZ4dnRaUmVVNWZWaUc4Q0cxTnQ5SGtoQ2J1OGQ4QXdhRUZlelcxZHNr?=
 =?utf-8?Q?U36882N9LFfGHjzMSWJj3tKXtb8kgBa4PDWcXq9zHxxM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2419238-3e7b-4c8c-b78b-08dce557689c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 16:04:36.1645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10809

Seems Alcatel Lucent G-010S-P also have the same problem that it uses
TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
   drivers/net/phy/sfp.c | 3 ++-
   1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a5684ef5884bd..dcec92625cf65 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -466,7 +466,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
   static const struct sfp_quirk sfp_quirks[] = {
          // Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
          // report 2500MBd NRZ in their EEPROM
-       SFP_QUIRK_M("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex),
+       SFP_QUIRK("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex,
+                 sfp_fixup_ignore_tx_fault),

          // Alcatel Lucent G-010S-A can operate at 2500base-X, but report 3.2GBd
          // NRZ in their EEPROM
--
2.34.1


