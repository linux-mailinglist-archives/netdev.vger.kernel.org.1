Return-Path: <netdev+bounces-258292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPR5KLeNjGn5qwAAu9opvQ
	(envelope-from <netdev+bounces-258292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:09:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D530212513F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 606CC30125ED
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8D029E11B;
	Wed, 11 Feb 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eY5fTViD"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4825F98A;
	Wed, 11 Feb 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818996; cv=fail; b=H1V56hhEEsBbbNKYwY3H4PtW9H8au+dz5ogGXvIJv3OFGwIQsxQQzZz2AfW56IUdv5i26crrmO5RVmFuuTTnM5PjKfwOZq8WOqSsQoWQxkae774BGxvc1WQh0mCUzscPnES/CO4v8Q3wWj+z9V9oPm0A7/766+h3UVoI6VCGLcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818996; c=relaxed/simple;
	bh=n9d8z3/VjB4Usrp51YEtQzBvu38sKNn9Uz6DCFxRa/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WYvOTpTaMU4Pxai+N+tY79H3TYAjvVx5pnI6E+oGMA6sNoIaAwUFZ92mNwKompJa1vNbnSKtbmOUIYBexdzeYC5OZQFlcvt9ocXSCDz2pf7/t6x3yVwlnL3/GamBTHnP34dnZxYs27xb8pkY1ZTRjWn6ZzUAcgYdaiBhGlkySUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eY5fTViD; arc=fail smtp.client-ip=52.101.193.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVi6G4XxlylnQl6FLp/LfhFFbqWk0hJc/h8T6gp0OCJZjrE+V9eMEEet9gQDwWvS/xQvS92D6cR6o9KCG4fkEE2f/P/L43kNBynv4dgYvzuGxhOF3vGt+8Dalk9mO7u7ZfQvS2WTAE7FX68ye84/4R5U1trQC7i8souhKe3asZD92gVgRY8IhnulFUteEfNYcop31CnyAbK9B24rHVgrRFbERkAzVs3iBqGSXBlPZIasxIkIJzGuxbpXrP0ia93ohGC5s3azsM+8QboD7ubmc5cA4/u8OOpiMQ5799udFA4xPBjwFXGvLnnyTwALFuBiBx+yoa3AKphvfcCZtjRvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21tF+UBbXJ4wxPjB8k3wKD+t1nCIrRSOZDDBoiVTxNQ=;
 b=NV+X5q4kIn9pvncuduZA4DT8HYhvv77RhNPWOaq4EGW4Dt0gmoQ8VBbA6PGvzM4bV76JXCnPj2eDda/FxJ1wuxilosmhbMpjqxCkPKTCBoyIFFkhLKSv1uhcZBbORd57gQV8YguNgmrODPiBlHTn3NV5jHLv+6LWYBuHSRc15XyzxWOyxi+Ns/pZPf3HO7N+zwBcQCwjbWKNb34aAp+AoNpTDp+FeZrx5LPlmqyF0xMbzzeR7fmb+ur3eE2lV1E981cfxURfOtqBxYgKAsVUTw75exLBqVZ4qt4SxkYnWbK1CoBqElG8p5WVoHhBNU8zUchFigJQz7ns2QsYqy2kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21tF+UBbXJ4wxPjB8k3wKD+t1nCIrRSOZDDBoiVTxNQ=;
 b=eY5fTViD6ry3IA/G93rIs/VRtSFft+v92uu69b3kiPJ2htVyoR0cmBqDLtWs5mA8EwC5sQ697WxiA6Di7GIWwvqXVU4nw6qz7t/fB3vx6AOX7N9WW39o0lKMxTg8VP6T+NOoX+53vUh/S8qAPRs+4iyuP+988nZN1oMnx63u9XE=
Received: from DS7PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:3b8::13)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 14:09:51 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::2d) by DS7PR03CA0008.outlook.office365.com
 (2603:10b6:5:3b8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 14:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 14:09:51 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 08:09:50 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 08:09:50 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 08:09:50 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61BE9k7O1743920;
	Wed, 11 Feb 2026 08:09:47 -0600
Message-ID: <10b276df-a8b0-4330-90e6-f6950f4f16cf@ti.com>
Date: Wed, 11 Feb 2026 19:39:46 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced
 100Base-Tx mode
To: Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<hkallweit1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20260211131033.2525617-1-m-malladi@ti.com>
 <aYyDkaynWEm-WJdg@shell.armlinux.org.uk>
 <b500116b-afdc-4e5b-af4b-6c1e15116111@ti.com>
 <1e648f2c-9b21-4a0f-95a4-274a97acbbf7@lunn.ch>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <1e648f2c-9b21-4a0f-95a4-274a97acbbf7@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: c72a09b7-85f7-470d-aa04-08de69773920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTI4dmJ6MUhCMFVvYjY4b1IyQ2p1eWIxZ1hsQXBmdXo1bDJ5eDhPL2ZITCtN?=
 =?utf-8?B?NlJ4K0FLMlIwMnc0WXVmbU9mODhENnFlOFlPM0lzNWRuRHlZam5YK3lnMVhV?=
 =?utf-8?B?N1FHMnVhbThKMFlQWVNGbDlTTGRKVlkvbmxKUkVCMFoyaTMzQlBhNlZxV3NW?=
 =?utf-8?B?d0tGdGVvVU1DUnRqcnErNUJ5TmxOYnhBN0RXYzQ3b1JHVEkwRnRIeG1HNzdj?=
 =?utf-8?B?c1dUN21QcnFhbTFxK3AwYzNGeE5VQ3BVaUhRb2NQSzZ0OUdIYVFiZ2pYcnJz?=
 =?utf-8?B?UXlyS2xjZ0xzbTBJMjd2NTRDU2N1VmtkSmJUYWQ2SVVPb3FJQ3BEcVo3TVg0?=
 =?utf-8?B?NUR0MVE4SEE0bHVYWTA1VTZicmlnczBoRDYxeVFpaW10MUM3Y3lvRTBqY1ZJ?=
 =?utf-8?B?WWErQmIvT00zdXAxbWlQRjZkY3o3M2IrZVRrOXc3a1hoT3Jqa2xUdytKUmJS?=
 =?utf-8?B?ZFhFb0lkclh4TmZqOEREM3JQNVFIV3pSTGFyVWdqTUVxMG84cjQ5MUNsMldY?=
 =?utf-8?B?anpCeHdibzFiUWVpMk81c1lQUHFMTWQvQlVnLzRtbTZ1aGFnK01RZXB0ZWFZ?=
 =?utf-8?B?cEtEYThiZzFIWjl5cHB1K04vMXBxWFVwdUNHamRoMGt1VzZ4RmlDVnltYTlQ?=
 =?utf-8?B?M1hGSGZoNmpDYTNGK1NGWWlkZUVGSk12WnJ4YWs3UElmbmpmNk1Rc3Q2Nysz?=
 =?utf-8?B?UlJWT3JrRGZCemZ5R1ovRXRrV1pHUlpsdEJvS3NVUkNJT1M1RE5NM2MxYXVv?=
 =?utf-8?B?cDRTaWFwSVU0SDNvSHA5YXJXbVM0dnd1Nnc5QURWM2RvNGFNR1JPVnBmQUd6?=
 =?utf-8?B?SUN0SGY1RnNDYS9yK0pFMU5RQmMza2JXYUxscHgxWU5EeDNub002ejNKS0FL?=
 =?utf-8?B?UFVsTzJuMWRaVU4xTE1sMTYzTEVGUzU3RWYrQVFBbUw5V0I4SDQxRkk1Zzdy?=
 =?utf-8?B?c2JHbm5jNVdLOTM0Z1ozMnIyWld3Y2JUa2lwSjhvcERkdWcyY3BGc1R1QlRG?=
 =?utf-8?B?QXhZVm5qR1ZtN1dpSWVVU1dmbkE2bGZsSVdTcXBJdzJUTVBVWk5OTC9PVEZq?=
 =?utf-8?B?R0FmU0t1VFpIM0svWDRTczROcDB6MytJSVdJTDFQVjBWQzFmNE5PMzc3amlj?=
 =?utf-8?B?NExIMmZZZ1V4Yy9PZDRUcTdaYm9qYkFLdW9qUjV2MURnMmZYSGlwRlFINjN0?=
 =?utf-8?B?VjROSFZyS1JyakFsdzRWUXdMREpTc0ZyNGt3NXk4ZU0yZEVvU0tiMzIzaGJF?=
 =?utf-8?B?a0FxdTNNS2NNWGpOZUJEUjRTZ2dQeXZNZGhLS2pPQTBVR2pTeWZqMGM5cUtM?=
 =?utf-8?B?YjFZU1duejFqRFc5Z3VyLzhVZXdwdVBmRm9EUHZvb2RKcVBSRFFwbVZqU000?=
 =?utf-8?B?V2lHRTM0d21YTHByUTlkODdDZGU2dU9leHE4UW1pVWhraUZWdTdYb0JDQVpy?=
 =?utf-8?B?SG1UVUNyZ1RzVU4wLytpblNERmY5SjVXRTA0VFduRzdCWExQcUdCdDQyUmEz?=
 =?utf-8?B?em1sVklGSGZCZG5aUUEvcW5POHRJd3dNZkRvMEpraDFXSHozL080SW1kNmtE?=
 =?utf-8?B?UDN0dGROYlBkdkpGaTlBOGVJRERBak5TTDVTS2Jna2haNmJGYXdackxsd1BW?=
 =?utf-8?B?NDIzS3ZqR2RFTXFKbFdRTTJNTlVxNkRNbHhNSjI2U3FCamdxdlNGUUdEYUEz?=
 =?utf-8?B?TG1va2hjbVlCN2YxZzZtdDI5STVYSnlUZkd5U3liL0dWcEZtTjhnMW9xSU93?=
 =?utf-8?B?T0M2RXhybzNLS3g5eklrYW4vQzNYUHlESGo1bUVoZDI0Y0w5dVVlckt1SW1w?=
 =?utf-8?B?YlE2K21tb2sxellpZkhId05nL2FqTDB5NG0vcHNiMzg4NVRTNE1PNUtVRjhE?=
 =?utf-8?B?VDY5SXBucDhwaDV4ajYwbEthVklSOVZSbmxkT29RbkVYZGIrdWlPNDBwL1FD?=
 =?utf-8?B?SjZkcnRpNi9LVEtjU0Zxd0p1MTdKTEpoRERQTWtSQ2FaMzFyYlk3YnVqWGR6?=
 =?utf-8?B?bVZiNUk0cUZ5UGVadWcvN1A5UjI0eHlxNUhKQ3dESUhyOWk5NXErbWhZRWVn?=
 =?utf-8?B?THk1T3RJcDh0ZDZvWnlLOStISFhaZVhOUjVxN0NyVGZDMlk3ZHEvWnNQVVE4?=
 =?utf-8?B?bHBpWkFsWlpVb0hWa1VrMEtyMm04R0E3QTllK05CeVVYMlN2N0ZiMy91bUdn?=
 =?utf-8?Q?G9JOZDvCwExSZqVKJQTbfgg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kB6sp/2TvtYV6kY0RXBdnkMlEg74th+iaE++CjoVsGDdyZJBED4aB3QIFHLSAhowai7Bcw87m/0mcv4d4DwcAIUZqWndZhwaCUaZHQCpsgFHnb40hfP3UY60Lkz/09K5tapwukaELdK232nueU+ZIEQBbXnn2tl0/7r8G+StLCizMWFXNlnQpcPCU8yucA1sFSeg5Q/o9LU2Is9dknq9XMJY4xptdhOaje/AZ4yhTiQ9IHqYKUVNoy+eOId+hntbcN86TvQk5UVg1lyQH2494/BOBAXayyE19wFZpSxXGz7MgZU/fuMVcuIIBUS+3wyHaisZDSvxMtbPAjpdU89mKF/QiE9nAdfUekGlLASJ6JhjlPmf4qlJJ9uJlC89dplhSNGW3we7FjE4QuzpzSgVMpWpBCDw41dZfyiWo7sEpMD5jLG15uTy4rJ4gUEnnoaP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 14:09:51.2663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72a09b7-85f7-470d-aa04-08de69773920
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258292-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,redhat.com,kernel.org,google.com,davemloft.net,gmail.com,vger.kernel.org,ti.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,ti.com:url,ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D530212513F
X-Rspamd-Action: no action

Hi Andrew,

On 2/11/26 19:34, Andrew Lunn wrote:
> On Wed, Feb 11, 2026 at 07:23:12PM +0530, Meghana Malladi wrote:
>> Hi Russell,
>>
>> On 2/11/26 18:56, Russell King (Oracle) wrote:
>>> On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
>>>> When using DP83869 in force 100Base-Tx mode, the PHY is required
>>>> to have robust Auto-MDIX feature enabled from register 1Eh.
>>>> Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.
>>>>
>>>> [1]: https://www.ti.com/lit/ds/symlink/dp83869hm.pdf
>>>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>>>> ---
>>>>    drivers/net/phy/dp83869.c | 19 +++++++++++++++++++
>>>>    1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
>>>> index 1f381d7b13ff..70d759c45c6a 100644
>>>> --- a/drivers/net/phy/dp83869.c
>>>> +++ b/drivers/net/phy/dp83869.c
>>>> @@ -110,6 +110,7 @@
>>>>    /* CFG4 bits */
>>>>    #define DP83869_INT_OE	BIT(7)
>>>> +#define DP83869_CFG4_ENABLE_AUTO_MDIX_100FD	BIT(9)
>>>>    /* OP MODE */
>>>>    #define DP83869_OP_MODE_MII			BIT(5)
>>>> @@ -900,6 +901,23 @@ static int dp83869_phy_reset(struct phy_device *phydev)
>>>>    	return dp83869_config_init(phydev);
>>>>    }
>>>> +static void dp83869_link_change_notify(struct phy_device *phydev)
>>>> +{
>>>> +	int cfg4;
>>>> +
>>>> +	/* When using DP83869 in force 100Base-Tx mode, the PHY is required
>>>> +	 * to have robust Auto-MDIX feature enabled
>>>> +	 */
>>>> +	if (phydev->autoneg == AUTONEG_DISABLE &&
>>>> +	    phydev->speed == SPEED_100 &&
>>>> +	    phydev->duplex == DUPLEX_FULL) {
>>>> +		cfg4 = phy_read(phydev, DP83869_CFG4);
>>>> +		if (cfg4 >= 0) {
>>>> +			cfg4 |= DP83869_CFG4_ENABLE_AUTO_MDIX_100FD;
>>>> +			phy_write(phydev, DP83869_CFG4, cfg4);
>>>> +		}
>>>> +	}
>>>
>>> Shouldn't this kind of configuration be done via .config_aneg() ?
>>>
>>
>> AFAIK, in case of fixed mode, auto-neg might not be triggered all the time.
>> In the phy_ethtool_ksettings_set() function, auto-neg is initiated only if
>> the PHY hasn't started. PHY drivers are new to me, please do correct me if I
>> am wrong.
> 
> .config_aneg() is badly named, since it is also used for forced mode. Just check
> phydev->autoneg == AUTONEG_DISABLE.

Ok thanks, will fix this in v2 then.

> 
> 	Andrew


