Return-Path: <netdev+bounces-261739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DcdIc5GoWkirwQAu9opvQ
	(envelope-from <netdev+bounces-261739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:25:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 125911B3D79
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B653016257
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D1346FC8;
	Fri, 27 Feb 2026 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PKSPTjrG"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazhn15010016.outbound.protection.outlook.com [52.102.139.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340B3290C7;
	Fri, 27 Feb 2026 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.139.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177078; cv=fail; b=A/Iei52xpS2po5gVcgAn3gb0l/8wEui57NbZ+8uyYRTGhGi3kCRYa4O5N1V7MGhiNtx4dBfOysV6zndHzr38BwBtdOgU1wlpO+siHWp+tdW9o3HLsepDC147+Xk91AIjQH9QnJhnphXEuDpjTlG2ERXfom1HMZQME88/fuxvVJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177078; c=relaxed/simple;
	bh=9EW7RqYu/0AQ6wPV57Gw35W6nroHYLQgqJ1LEPMV58s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CKeB/luymA9ZcTUEm6eBpSNjKARIy5ZR/vP8Yz/FTQzCGXV6n1d4efwXsTMoyexDK0+l68TnHShl4PBqyYyg2ovoyJVxcoPYws9ZNiHG/jTq7OwURc4v3wfEBXYZk/fxpZksXc1snyjuy1yPNmoOGKq8WAZwQCeJWUaIPnZeSBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PKSPTjrG; arc=fail smtp.client-ip=52.102.139.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU8nJGu8CXPhM7mbsxpEDh2/KF9MLJyRZZ3685z6piHzw6mURT7DVyxPo01myMPFJbfDg+GzQHRIG8JJTsEHJ+uSI2E8mMqsxtsvXQ31Vaf5TijXx0Hw0SIBWmbV7YZ6wF7CmxmnBbs3aW0SbH04m0FbDZHaCgNqkEsXvB29HRQfdE2F/zbE1skadOXm5T0rKCey/KIaOyaLSgV07CJF+LZlJPXwqBIadDdmYv5WTzzYU4fiWv7CV5TQCTjFWWLNqqcGkFIKTfwMMHqGP9hNL7nnr4MVhJtWJ9fOKOEpR3QLGcfL7K/0PCnfuIFa89OY8WQjMUSoBWfL3wx48n1Seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Jg1FBEsQYbyWNXT2QFPN7RLoxMNWwuMr/ieuETCYCA=;
 b=vrED2X1wA/GwTD0sgc9Dw0LjiBP6M8yMK18+BDN7BDo8RTMkTI3MhdB7INojBY0E7vCckf1K+U8GwaDYibCCnyxllU5XgkTi+9KHpoU0DRX3/uiypNRmfs+/P8Jn7zfwE2OxiUmBrJs8Zf4JEHLh7R+XxHNoW7k+irgj+ggw2UPnrP4Kq1P5fSd30yOqVQrub065d3M9vFau4bE/uwNlYyb1FbLMVgrEuOseR5X7PUycNly3n6Hbj3sDNuowgq4GhLq499FhD3tG7HGpvcDYfF2ZTaPSeIe/lDpT9xKIX8KxRHS7ZvG+GnRXA2aoSlCDLo/IN/4ia9qw2+UfuC4smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Jg1FBEsQYbyWNXT2QFPN7RLoxMNWwuMr/ieuETCYCA=;
 b=PKSPTjrGU1VRopoFB7uvVbEmCKFaIGhAYEb7TG6L67K6x8En9Sqw+KiTZSCJP6HdqEA6jg1ObDomAYRqqZKdE7zgosd2Pji6N6jRAzhw9ejFmYITebAQ1MDKjehQ1/76EEsLuG8EWvrSUysiNlLspaRTfkLOjsUEDie/4fQ7UtA=
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by SN7PR10MB6451.namprd10.prod.outlook.com (2603:10b6:806:2a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 07:24:35 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::72) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 07:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 07:24:34 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 01:24:34 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 01:24:34 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 01:24:34 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61R7OTaF3324743;
	Fri, 27 Feb 2026 01:24:31 -0600
Message-ID: <1cc7fb44-c08c-4f62-ba88-20434b4954aa@ti.com>
Date: Fri, 27 Feb 2026 12:54:28 +0530
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
 <ef2d207a-dd51-4db0-a909-955d5a38e1f7@ti.com>
 <76067a68-62b2-4e45-9bf4-6765be61b7f7@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <76067a68-62b2-4e45-9bf4-6765be61b7f7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SN7PR10MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: f4867c0b-a109-40b4-3028-08de75d141ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|34020700016|12100799066;
X-Microsoft-Antispam-Message-Info:
	Uiw+WSdJKEETyfe+VNRZuHeROnZAN4xVUDZRLQd68hrbp78JBkGMkOb3nLMLGhsC5/HjPxYMy24d8SJIGtbdFQtE4544AORFamGugyVMc8UjSLzctcKHDZhNpvDhwZDioEx5D5qV5tYpm0oFxoUzCgTvWtvFZrLZZuURzwGyMQmJT0W4KlX4ui1EykANxUKFGMGv5Sya2FkgnAxablKvgdWQ+IIRB7zPz8wyRYnrwytUT+1qOgVCBv9r5p4a6F2aaaO31Bl7Uq1mdEEPQDm9Ms6gpTXTBPFJCtEGjc42y4XGsu7jr9Kr3LxXFRbZWn34AoILeTiNfVLIYuRz9cjOTwmH8Sn+FpvnZMSGgTZL63XUgPqKXT9rJKuZ5HzL7T/IWwQTEYInHcpaOFhXQjvks89e5JJcEwctNfNfeg9ONXBXnaRUz85oRmy37PIQXFfqvPDqKPTFXmbgm15kZm3e4FUhG8OoZgLqLG1EpbMw0CyZ6YSx0Tf9OBAIvwHXThRkS70YPRptZVimtuUVXzoc4ynCRr98NPVEzOOBEVcTQgReSxytTRZuF7Vsoem+s8A9P5ilsqXBu1t+r2hTUfnjauWMZnwY2HQ7WhIhW4LJSkOi5nCRSHVaBrGO73Z5rYTk06VuygM47QIMRBi6W9kIkdPHIx8QnIVF848Fo38kxuJhxWmGC8ubMRQTqyb5LNDrLJZYSZ5B/wSM9Yvu287irOb6wa+ZaROpSHFhceg4Tg0ljUoYKBg8KPJNz6vaW/IlfzFVza3mFPhHht1jw2zuQPAQnko8WsXe28ISvBvNSLw=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(34020700016)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XKuyQou2q7qHiVaDkHCSjpt02Ak3kmViGiC+M+qlHLDNKkwAEyshx8UpacdpAgxTkSejZi48ltKnNGSc65Js6+y89rkwE+FXUtbHQO/twpjhGShrpD+VIodRQFDLpukcemf9DSE1mQBNz1GKXaE144gKjGNz+cJ+ia/XqtoJYExOrS6OpPQMILnB7cU9NmTWXuRs2ODGXECxdhTdf2EYG65O/VpyY7XKhi9EA/7N9r3iQ2EDzKET5AzMoL7EgoeqnvEaKMadASm+KKDwCDLQCDm9uzRTwwzVCDDYu5WFs6b8jCCXHVanXOTNp9wWq3fu6ddRiyk7WAoVFerbYXWOmgYPSCn0SZR+/uYPy6qvjmfwFwCi2hClnY1LJ8VLg/27SKRldmqJs6gcW+HaUwtEM+nPEwo03pZWrcBipHfym2+2DWDzkdhy18IsmC+DBCee
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 07:24:34.6963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4867c0b-a109-40b4-3028-08de75d141ee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6451
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,vger.kernel.org,lunn.ch,gmail.com,ti.com];
	TAGGED_FROM(0.00)[bounces-261739-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 125911B3D79
X-Rspamd-Action: no action



On 2/27/26 12:51, Krzysztof Kozlowski wrote:
> On 27/02/2026 08:15, Meghana Malladi wrote:
>>
>>
>> On 2/27/26 12:12, Krzysztof Kozlowski wrote:
>>> On 26/02/2026 19:54, Meghana Malladi wrote:
>>>> Enable DP83TG720 PHY driver as a module to support TI's DP83TG720
>>>> 1000BASE-T1 Automotive Ethernet PHY. This is required for the
>>>> DP83TG720-IND-SPE-EVM daughter card used with AM642 EVM ICSSG0
>>>> interface.
>>>
>>> Grepping for DP83TG720 or IND-SPE-EVM gives me no results. Are you sure
>>> this is the board supported upstream?
>>>
>>
>> Yes, this series adds support adds support for the board:
>> https://lore.kernel.org/all/20231212054144.87527-1-o.rempel@pengutronix.de/
> 
> I still wonder why there is no DTS for this.
> 

I posted DTS patch separately for this: 
https://lore.kernel.org/all/20260226115454.1730618-1-m-malladi@ti.com/

Does it make more sense to post them together as a series ?

> Best regards,
> Krzysztof


