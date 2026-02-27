Return-Path: <netdev+bounces-261736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DUsGq9EoWkirwQAu9opvQ
	(envelope-from <netdev+bounces-261736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:15:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523B81B3B63
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0DB43018E08
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77229B8C7;
	Fri, 27 Feb 2026 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JWBZVzxN"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazhn15013047.outbound.protection.outlook.com [52.102.146.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF022FE11;
	Fri, 27 Feb 2026 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.146.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176551; cv=fail; b=pfXOT9JuH4/jPePjW+7FSFoxzTxL3OWjK8b+uavvbRgGUUwyZNRxZLn7KVmYPMV0Bo63jju7l81rODTnLJ/UDBex4k5Y5yOMl1KTRcgBp3uoXsOFeYwai6flAb5XZ6nqqo9gYTWYbyc/b17EyWb6VGgX55KYgGcXzijoizfaKJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176551; c=relaxed/simple;
	bh=ATD3RZhwOwWHXOrKX+9QbJLTkwZkedoy8+bxcjfnVhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jx+5Uk//xbFrq6Dyzybiwf+uE7p06WXuBWBIzHmfbg1v99fOt6lTHBsDT412OQEVwZ4pDezLraQDiFQATBAnA/5MzUAxNTIeK4lT1eHYAMv5BfOXGtzZfB7M9FKwRVrHtOhxcsvIg9gGzHn7Bri+HyZGmPFKEeFHIqRG/jz13hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JWBZVzxN; arc=fail smtp.client-ip=52.102.146.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9XXaiAxR56gg/7vbPvcLbctmvVhfLEvLtrQmHuDZh7zh5auAqRYzejE/0hmVqKNtu1KwSEfQyzmBbNEeCkbjTT4pjGV7tAcg9RzDx4e02/ChelnD3+Oe+Ltm9kneYGYzbdYLa/3iTMg+LBnHtbOJv/ecjxFkxCgAmTGM7Ni+70Mwe12TDMnIrHNXrcENhWTYWSRU0j3zJy1VHdq9ItcR3T5fN/r8sqec2fex3LdLOrchpxUzUN5t+Zds7WClU5J8Y3hqjDPaGzB72FS+syMh1JOQcFr+pUBVflimJhX7Fu/3Tzz9n8+jWIcOztuM+vIc6wVAoMApyTN7AigrgrMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg/MWvT6eGE7HIOirpV8DAZOe25f3+jZkOGNG8MrDVc=;
 b=Lml2Z5f/ppK2MbYpu9WKj2P52RZ/XGCquV/lZM/8fkFtmuVkjl1JNGLXr/g4/92TgzF4zD+DWC2bS63k+f+lz9/uFM+Q/YPFgaAY6Bg8md61yF9AEEqAxgF8rvfDGthvtj70iiKZniQNt50UjIXdsXJucIyfFErrLD7vuXkKMN3YAYljTd6UEQcyuuVfavB5HbWqjN6g6yhHg1gib2iLXQ51KRnD1bjvYvX7MPuucJKLi9RziSpiBwTkbH+betzaOnVXyt/FpJNQJubXNZ3wvSUI2rib0tN9Bg0+P6AppM+YF9w2ouYa1nC1G+EeVc9mSbzE4SuQA1XaDA0sT87h7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg/MWvT6eGE7HIOirpV8DAZOe25f3+jZkOGNG8MrDVc=;
 b=JWBZVzxNEkZuQtV+oIzqZXX0AOESuohua7EtRm2MJpXbWsgnh+sBEVj+KNSDA+U0xMInmNSZsLDsVpU2uF7xiVESrpgfQmfpMyPwQU3+mcEzxzfeltMlw6GEiW5FU0s5CT+2lj+XOrBljuAT+eMiIp1xN33kAxpsXL8frgv45EU=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Fri, 27 Feb
 2026 07:15:46 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a9) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Fri,
 27 Feb 2026 07:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 07:15:46 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 01:15:43 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 01:15:43 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 01:15:43 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61R7Feu03313304;
	Fri, 27 Feb 2026 01:15:41 -0600
Message-ID: <ef2d207a-dd51-4db0-a909-955d5a38e1f7@ti.com>
Date: Fri, 27 Feb 2026 12:45:39 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] arm64: defconfig: Enable DP83TG720 PHY driver
To: Krzysztof Kozlowski <krzk@kernel.org>, <nm@ti.com>
CC: <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>
References: <20260226185448.2167189-1-m-malladi@ti.com>
 <79e54fc3-9e61-44ff-9919-b1163bda81e5@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <79e54fc3-9e61-44ff-9919-b1163bda81e5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1031ef-6a3a-43a5-4951-08de75d00704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|34020700016|376014|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info:
	+Hsma0Q6HNlOyLtIfZEXdRuqCE03Olo9ExegLwgCo+qpjwWPt6oLZCq5oF7oa1KlHGo7BNobyCqXt+hL9cy7ggWIoLthUDcEVBjR691qVWcC+fk1IH33A4+Hxkch5Y9GLzGv+KqdLf0gtdqCmpI7VBe0NpM56YBMKGJMm/wxitU5hjT/giF0wMlqOAoBjCeiCHUaurjJmJJEGofzizCrTlQizQMnB40wboUDZOca7XLJpDXNu59eepCPssjLtAhJya24OzWAU3kz6ImwQdfUmQIjVABcEEUDKZyOk7Vf3mkg3U+/eT1+0mHT78+MSgsqwoCsbEkNLPCUS0S1iNoWQFP2/4N6wbKSF6dbvJMrW2yGVjMC4+4Gyk/2/vMzXZ7cVU8zH+q+h4X89CkyZlpYllRyyrOA+rS2PrlSVY2R/cla792PfLBAiKm3GTTm5lQUvDwYS6I4jy22Qz4nPFc67RHoOO1cmwSqc781NKEbP4lP+CBGYrcfskPrOmP2DYIsDyhQmRdTpGl9yZ+FyoRHUaO5yfFTEgDqtnYknnOUVMw0/yjxM2CUmkefb88FfVDvlIEDxGnBNus3iOhLaJjwEL5Kzu9hmx/TbxMNv7iuevLWUdSeS4ZsagSIMVadq3j8zHkLGrUNVNZwhE7TVv14ySyzX4l/LnPCBpInyu8huqbrPeR1oho8h+qmbsnvGAWaldRwswzDzJv55swuUvgYrBLXCtbeBOQobGPk1DXg9womF2KNz08AJZRUaQ6URe2dRDctghXZfuyi1nuAtv0ikeDoN4YouikmYARF7eVqdCQ=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(34020700016)(376014)(36860700013)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dbpJ7RIwUuSs8r24F5xpNrT4+dU9X9NwcU6i2EL/ZsfvPehm0c/ieEXN6NiAPRB8t8giZbvHjlMS3yNfSD/0+YYSlFn07V6qERpT2vknLeiLID1tRc98CeqoxoRojsGsvMGcKSILAqjPVqKZo35k31fsYorDz90um+yOZMH2IYMb5Ky75LF2XZN0t44Ac9+k/IW6ul2Et6Q6HGNPTl3sfU08uM+ws1F9h0hX+kVPbTgKvlymtGR3YrdMQ/6xKBjN7oaAOFq5wp11l1ktHrsJLMBZwByVpdH94JHBAh61NYK/art6glLHQ+M5Y7IhyDK2ewdbKEUhmMc1Brh4Lfhxtb38lkyundwiLTbQ5nMKCLMJS53obidoregD/xMVHlCw2t66XWxT4sIyofJdOLyizbk9v+IcNeU2RqJ5bXYFtZ4f7UdHVXpDFR64tXPmjmMP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 07:15:46.3248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1031ef-6a3a-43a5-4951-08de75d00704
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,vger.kernel.org,lunn.ch,gmail.com,ti.com];
	TAGGED_FROM(0.00)[bounces-261736-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 523B81B3B63
X-Rspamd-Action: no action



On 2/27/26 12:12, Krzysztof Kozlowski wrote:
> On 26/02/2026 19:54, Meghana Malladi wrote:
>> Enable DP83TG720 PHY driver as a module to support TI's DP83TG720
>> 1000BASE-T1 Automotive Ethernet PHY. This is required for the
>> DP83TG720-IND-SPE-EVM daughter card used with AM642 EVM ICSSG0
>> interface.
> 
> Grepping for DP83TG720 or IND-SPE-EVM gives me no results. Are you sure
> this is the board supported upstream?
> 

Yes, this series adds support adds support for the board: 
https://lore.kernel.org/all/20231212054144.87527-1-o.rempel@pengutronix.de/

>>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index b67d5b1fc45b..3b88df2ca5e1 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -420,6 +420,7 @@ CONFIG_REALTEK_PHY=y
>>   CONFIG_ROCKCHIP_PHY=y
>>   CONFIG_DP83867_PHY=y
>>   CONFIG_DP83869_PHY=m
>> +CONFIG_DP83TG720_PHY=m
>>   CONFIG_DP83TD510_PHY=y
>>   CONFIG_VITESSE_PHY=y
>>   CONFIG_XILINX_GMII2RGMII=m
>>
>> base-commit: 4916f2e2f3fc9aef289fcd07949301e5c29094c2
>> prerequisite-patch-id: d9e4c1f3ec36250ae7ce49b720614eef25f9ffd3
> 
> Why do you have dependencies in defconfig?
> 

You're right - the prerequisite-patch-id line shouldn't be in the 
defconfig patch. The defconfig change itself has no code dependencies; 
it simply enables an already-upstream PHY driver as a module. Will fix 
this in v2. Thanks.

> 
> Best regards,
> Krzysztof


