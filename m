Return-Path: <netdev+bounces-281136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBhOLjrI7WmengAAu9opvQ
	(envelope-from <netdev+bounces-281136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:09:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6C9469065
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A96AB3002928
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFAC2E06ED;
	Sun, 26 Apr 2026 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XSQkv70D"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F33175A98
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777190965; cv=fail; b=fidHgpf/is38HrMsOtSmbj7vaJ8baFv08rKFAAzGcf/uBrv2e7e3LuQSECcxf07BB+89pYutkzamE3d7jHVJJDJXApojXxpgH26tcfYNiNTUl2j1C8VCq33lw33kh3ZaBki9/f0lVasD7QC79OHeJ5618FfIXTXTPLzdbvKjo0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777190965; c=relaxed/simple;
	bh=4yaQCvXkJrnpoKECSQ4WBC+jki/LGLuH2J//M9tWlsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VmfLGunwZURISaW6lgJcJeAro8OMKQ5QGOKrPrfqf8EsazKjFiUwYlWkTETwZ417QQq/J4baoY3fWAAY+2nQ1iSZPCNhjmjqGwBLmMM2CyS1e8ON+3rjYZpC8zAhnW6XFgc5eg1CHuwDRg9Ms9eB40uVjn93YzXBrsaVx4jZbbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XSQkv70D; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+2nNSffQP2N9eT1AWcqjn5DyGRdsh/0TdEgInHmv/TduIzl9cJoaosHx2Hwa4QKn/FAcxEkx5X/NcshUz5UsVvmR2sykvnQTBlqLSij9i3SEB6VfgnDhU2J/k7Z6jDr8RtQ2NXziGqfAt6u6NtVljc7971mD20aoyQFUd5z8DUK27V181QaOrXtGE0Pk47XlDYN64E/vbwvmc14chqzNDnDjL2g8bYenxMiDw6djYUN5y5H0rDeFm5nas9F2RpbrP4jwb7+1tVObazSXD3I+FBpjIHcECaMYbo8aJhv5l7AZSPUUt5JHRahAggh6OfRr7VqM3P9wO8fJ5vO1NEYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0o+wuXTygjggFTlFO9rl4jXsLNLpxZ+FbWoqkpHujA=;
 b=bDExLx0Yi80V1AakvbNlewpKUMh+5YYclAjsjJEvcqx67jLW84D6ngFLfiZXVl6x3IL2SFloOnVmQr0E8ToXsyKrWXM+TNLZo8LGo95c0oL0m2etkCAOYx1I47uPCwL9kDM1LYWpBWhXz/AqPzBB7UnfVIFzSIl7WsS3s9dlLuNnb2jI0Forz+IIG1UvjuP1URMjZwvE3AecBIt6ETiouKDnd4PK+gb0yZopC8KDorZ8ODr2F2W4ORDzGWJkK+SjA8+hf3eSX9UUSW5DHqx/K2XAldaV5ZJobU0o0ZgYRI9c3h91bX8yzpB5NRy9q0d/K0XOaBxxtC0D6nSkshVZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0o+wuXTygjggFTlFO9rl4jXsLNLpxZ+FbWoqkpHujA=;
 b=XSQkv70DGMqrKu4OIZgaD8C3kksqMClJ4UG4eAlEkCiFpR4qZBxMPh9TXT0/wQ5JTmQDT36PWRp0aToulpV6gES0sAju//04VR7hpXXcHitP9MOBmnml/Re1YxGNCwavB3GxeiJAc0wrfrjN1NcPyqllcVLVfm1x5NsfB3SaYeMez/v2Hth1g71Zo3/s3VzN53B0YM0pLJaDS4Yhtq3sydLX78Rve9G95CLBjhwM8g0YPlNmrN+lPya0Jw5wjLTpnYsb18C/dSkug0WIsv5uE+gnusQOUseHkUwoVBSBo/7IiTvlCEuWlhlWB8sxvB+yZD9uPcdachBJ48bbmWLQYQ==
Received: from BY5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:180::14)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sun, 26 Apr
 2026 08:09:20 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:180:cafe::5e) by BY5PR13CA0001.outlook.office365.com
 (2603:10b6:a03:180::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Sun,
 26 Apr 2026 08:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sun, 26 Apr 2026 08:09:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 01:09:09 -0700
Received: from [10.221.197.34] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 01:09:07 -0700
Message-ID: <27e16a8a-c40b-4d18-b0ef-b0a29ddbfbe2@nvidia.com>
Date: Sun, 26 Apr 2026 11:09:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help with PCIe THP on ConnectX-7
To: <bmerry@gmail.com>
CC: <netdev@vger.kernel.org>, <yochai@nvidia.com>
References: <aejnzWR_szvAOxkK@brucemerry.org.za>
 <58a85178-c00f-4705-aa20-61e668bb9216@nvidia.com>
 <aepwZVpSFsN-Xegd@brucemerry.org.za>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <aepwZVpSFsN-Xegd@brucemerry.org.za>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: f40ad68b-de00-4bf1-8921-08dea36b1e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PdxOdWZ7I1mJdQ1th5cLvBK0/k+3s6nElb3G55P6yRRMufKTIjZMD3wcRX3Fl9tmENf9fBcSyY2uSV/snVuxIDSVfegG3QeII4MgBo6yYoyXU1FOoMgADfkhUkWGFZrWurL75Tujy4DKItsOoqsieaY5iHpSSpFNW1yRaX1a1xrPM8ODL85weB/AZFep7rA841yWDD2xGN/SHoSgX7UwKrpbzt5egAFAhGKRo3Nul5XygdW3BnxX0az6iwuoWblAua3FcWpkdbZK1WBwPn0zimy3k5zuerELTtRNUb3kGonvZB2FHbIo0IZE9NKDWhnsECCTW+3Q76sb44zdD/xNHpBqFtNOrXCO6tC+n1OynraTUJg0V6T9XwkJz1r+kvGyCNSSiIjlFI2Xxcr7BW8BSREYd6DcCHVNe2CddSjVC/aSX4Mzi7qsf0BCr8ykTK3/qGLl87/FCik9sSg0+ZWnqCyINuWs/qF0GYEhgCarFUUk7r9QoVGTW7oAKRjqJxkqOlwEIEnhV7tVXYmo7OA3MSFAEVPB/voI5ohqoJca6bd1dPRL9OC3wmNwJckPTuoSDt5Tu21fgmF4fwqUttIiJ4QmIw7ckH6nlqkn3ZPU6myaT40TdH619tcYepzUWWfx8Lgtfg6LUkB50w2T2nhu38fVKd0vw5mEC+W6TZL8smZPhredCMHC+Dk0BeRigyUOBNG7bEQUTK/y6ImogFiZ4BuLyD+tPrEEaMWO9V58flRirl7mZ0S4pibHZ2Irvefb4BvX+dBqSPjFVpv4aSxxng==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j43MWBAp2HnyKYiBK4kb/XeFFOwzXl/dhTsaycM8s/NiSMkRMSiTMstfps2Mz8+wLMWCbKzC5UUfbr4eTw8MnheSOcj6sp7NTPSBpRaEZG0yupGavJLHzVzZMyr0/G/p2hvcuip25TIlE3yK7WhU/tqyhU6GoOTfN8smpDP4x9bapB30ZgIYfR+tVA8WCMoI62rLiClCppUxnNVbInuMgdavLJfGPWKlriXUqaI59b5ZwzY956Iuxl37kEIB/cUNn527gSsbei+yxZNOv/howUGZzpj5lJ2aXpbrzUfxzVjLshdoke5Rp4fPK+sXWdPKTcwd/H07g/l/JOkkQd7asBGgoCyS/NG72kzTdHNMT6jl8bl47rTiAqK34A9ptuIEsJVM/5DPdR4BaGauv1oUlMgcI1f5whjoBc3MrdyiTWtg4zmvRzJYfl+FAR9vmKqu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 08:09:20.0212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40ad68b-de00-4bf1-8921-08dea36b1e7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
X-Rspamd-Queue-Id: CC6C9469065
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-281136-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yishaih@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

On 23/04/2026 22:17, Bruce Merry wrote:
> On Thu, Apr 23, 2026 at 05:55:53PM +0300, Yishai Hadas wrote:
>> On 22/04/2026 18:22, Bruce Merry wrote:
>>> Hello
>>>
>>> I'm hoping someone from NVIDIA Networking can help with this; I wasn't
>>> sure of the best way to get in contact with the engineers working on
>>> mlx5 kernel code so thought I'd try here. I'm trying to write some
>>> (userspace) code using ibv_reg_mr_ex to register a memory region using
>>> TLP Processing Hints (THP) to improve performance on an Epyc Turin
> 
> ...
> 
>> It's supported only on CX8 for now.
> 
> Thanks. Does "for now" mean that you expect it to become available on
> CX7 in future, and if so, are you able to say anything about timelines?
> 

AFAIK there is a plan to support TPH on CX7 in the future (around the 
end of year).

It would be better to reach out to NVIDIA support about that.

Yishai

> Thanks
> Bruce


