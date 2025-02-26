Return-Path: <netdev+bounces-169910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E113A466A2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19E7421B00
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AE21C9FE;
	Wed, 26 Feb 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PRuQxA0D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2019C553;
	Wed, 26 Feb 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585976; cv=fail; b=aEWaQKigZ2K7rVN1iWovxMxzzyUt45KsvyK6V/AZSG5DwL77fH3HZwIy02WhAVlxkO6+PBOfaMH9N/kzndJ/3EqWJX7o2K0iaNOA0Qe9jZ+uk1YQaNRStDybxGvIfxSPgQG8BWc4qew9/vllo5Px+txqr/oOdCVNHxiTHfZWF20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585976; c=relaxed/simple;
	bh=HFowLepM2TGRmQhUX5/0p80ctJOWspd5E60xk5U7ZTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hvgJ1pSUcf0MU3m8n13w3UTpMMb6rFyjPg5JH2QDJOfz93f+sofwcNTVxqMXXGIg+7UlD8H/oq3jj4+GGMg4vFMhk51TDH1JJmZyIUtQsmNJIaHScz13SvehDWMc9aV39iUlGAoSfzKkA9BzbU/vY79Fe4vLf9x1FfRBsCW5xqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PRuQxA0D; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS31WtkQNT0xqw9QY4ahz8C4JVdslLMrAkguIVatCqni8k6Eg02gCfmmiaAzrUFZq3zaImr6Xfm5HDc3tZ4ClzetZG23Nubmn/JeUtusCHMacWJGCWZtwh+10u4Hy1UGGEWZezawT0+tLZpjrIZo1Jsj2Z8kM6MKw4kAg4vAI9OnCfA2RFRF2L7q6D/ZkoK4eH0RjY68xfE9S1oU6LzMd4v/UHdh9ir8zvwWaDPss82Ey5d01ujZCSF39qGzbphekha5hTvR+QpFYl4i5cNRIolX9+LKHXwMmlakhm0I2fEPZm/YiMmsBJ0UZiuT0CBhL1N6sGiQFfgTpRnZHPLiYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GAv7KnsrTUkn0jHtFLhgqdTWfESGKdmqysIaPun+oE=;
 b=PphVgH1oB4XQHDMLw8Bsx2xjTQp9X5H4FGtACgPICBi4qYK2lhaD4BLKxshml1O4yXmr3N2fACTlSRzJ+Q4orKEm3hfI1CRm1REykou+xZjKjLAXJJWhMfm0vfO33xy8KUKGqPtM9k+2NMzCt8sPJsZrevJlDDMxWG/D9eTke7XGcbKgErsFWOpzUM7bn/d09r5teBZdVmmaPRaQEStxoBx04bY7EoLKZvTojSFILnvBnXRdjbcuR11vHDZYROsWOVcdCOtfwDQOU1htxg+RPmThf3wI1mBoM/cjqZJ3CkI0Fv+kKCRcw9UfEB3IV3spUWgvlbQdLtITlILtxF9r6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GAv7KnsrTUkn0jHtFLhgqdTWfESGKdmqysIaPun+oE=;
 b=PRuQxA0DdXUE+YmGvXto3qnLG7kDpmUbdTVardBIPrO1UEb0ddftWWEiCYokhYesf0V02li17HQODBJI9Fc9mavrSuQL4SkTGaS84nGXdG0dlnwhkFYQT73GnnztZ6GqB/ky4cBKmKWoy6RxTFx/hWLu1swgFAxyntX2qAcnrSi2pJpx73L+8iZ6S5DZlTmDv6KlgKyOrH/Ry1q6W1StOu76ltm+6Ouf0WBeXoC3qUWpVVFK5ZmEeyf6IYzkGcEIUHljmx5OoahECs3icraG1wuVpCCjF3M+wCAv3bQ4djoSkF3/C08Qt7ldysZkNQS8dT7kpVMaFEOWAgIlZnfniQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 16:06:10 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 16:06:10 +0000
Message-ID: <757869f5-7341-402e-b81e-fb6a8ce8d801@nvidia.com>
Date: Wed, 26 Feb 2025 16:06:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
 <203871c2-c673-4a98-a0a3-299d1cf71cf0@nvidia.com>
 <Z7YtWmkVl0rWFvQO@shell.armlinux.org.uk>
 <fd4af708-0c92-4295-9801-bf53db3a16cc@nvidia.com>
 <Z7ZF0dA4-jwU7O2E@shell.armlinux.org.uk>
 <31731125-ab8f-48d9-bd6f-431d49431957@nvidia.com>
 <Z77myuNCoe_la7e4@shell.armlinux.org.uk>
 <dd1f65bf-8579-4d32-9c9c-9815d25cc116@nvidia.com>
 <Z770LRrhPOjOsdrd@shell.armlinux.org.uk>
 <63f9d470-e4e4-4e06-a057-1e1ab0aca9d0@nvidia.com>
 <Z786jCGYDewTH7bN@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z786jCGYDewTH7bN@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::29) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a9622f-30a9-49a0-417a-08dd567f7c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3NhdUlJSDVGdTI3RThqbzMxYi9uZEtSYjF3eUJxSW9zRzllSHFQdHNmYjl6?=
 =?utf-8?B?V1FqMmtzcmpIeXRrVFN3Nm1LR21xYjF0UGl1RlYrV3FUcVdjdFZlVVBOci9j?=
 =?utf-8?B?cHQxdzltaG40VHZ5RnFOZlBUeVhFVDZ3R1lScmowK2hVc3hmTTN2cHhjNG8y?=
 =?utf-8?B?SkJCcUIzaVlzY1h5dEZETjZHSGR5eW9ETEVSaForNzQ0Mmp0anh4UytFZzhZ?=
 =?utf-8?B?Qzg4VGl4dVI1aGU3cmhrdnFLL2d3SUhLYVZQaUxYQk1QWnZ6aXIxYzVnVEF2?=
 =?utf-8?B?cThPVitycnc0V3VmS3ZtZjhDbXdaWDZCRkJrcnl2TDlOa2tTbmlLUEhGNk5C?=
 =?utf-8?B?aGU0bVhoY0RBWXhQRWltRmZlek1zMDlTWmNWZ3h6alNwOUVzbEVYU0ZjMlRM?=
 =?utf-8?B?NTZ1ZCt6Nm92UExNSWNlc2tmQ2UwelR6VGtIcHlFd2hibEpGeUl3NVUzQnZs?=
 =?utf-8?B?OHVvV3BmcFJpQUphK3lpekdjdFJpNFBqUVFYUFgzSng5eE5PdnROL1MxQ1Ns?=
 =?utf-8?B?d0M0RTh2eEpHR2gwUmc3KzhINW1lRW5ZS0xSazNjdDNMWjZET1pFQm5vc2l5?=
 =?utf-8?B?MUlLMnY1L0VZV245TFZaRG5Fek9aUkRMME1zWVdoVCtIWjAzNG1xamMzWWNl?=
 =?utf-8?B?UW15TkxvUFY3bmxRdWhqT0dHdTlqVGdUTytvR1J1WkZSOFRaQ3JJcDhUVGxa?=
 =?utf-8?B?cWplc1hLV2tjR3JQREpNY3NZWkRUVzVCZHdTRDRsd0pBU1hQckxweGVUODRu?=
 =?utf-8?B?aXp2c2ppbmovbytMVHlLL2R6NFhOZXAvOHdoUk9kYWM3ZCtlR2V0SkkzdTNK?=
 =?utf-8?B?WFZJamFFNU04VDdVMHJpQU9BbEV2SGd6WmVzVG1yRzNOZDZQWjdaUDVSdHkw?=
 =?utf-8?B?L0xjeHgzWDNmcVRsRU1iSzRWZlhqUUlPZktBbm00ejVMQ0p5SGR2T2IvRE9m?=
 =?utf-8?B?bFdxandUQ0lkbHdnd1E0QWZqMkpTRjIvYjFFVXp4SitFZk9XNXNSd2JRVFZo?=
 =?utf-8?B?ck1SVUtYVWQ3VHBGV0JLZUdOUHpUMVFVY1hSNDcrNStRT1NFU0dxY0VQQWFU?=
 =?utf-8?B?RnhlN3pIWkZMd2ZTUGZCUytSaTY1b2E5WU5CMUE5aXl2RE94Si94akx2QVZj?=
 =?utf-8?B?dTFHT1dMc29JeFhIeWordFpiYlZEbHRQNFhjUy96V0RtSzhpSW56dmNnVEJi?=
 =?utf-8?B?MHVhazRScmZybzhoVUJsZmNpNDBPQWlXU0YrYkxXUWVNNmk2RlMvZ2o2YXFh?=
 =?utf-8?B?bUVBZzc3WXo0R1RtdzNUaGM2Q3hUWFJqdklyZ29jOTM5dzVDdGFVZlluTW81?=
 =?utf-8?B?VmxvRzBEYzZuZXUxTUJmb25MTkxuWlhYTS8ycWd0VEhnOHUxWWVkazVDMC8x?=
 =?utf-8?B?UlJwNkZTWmNSK2pvcnMwNGxWVklidmVNT01va1NFMXR6dk5zUldyeDlWV0dM?=
 =?utf-8?B?N1pna2pPTDdoclBaNzFLVHU4V3FyT0Vyb0lTQXR1a1hOWXY1N2h4eTRINEM3?=
 =?utf-8?B?eXVodllSMWc3NitLWE53cUJLK1lUOC9BcFVwQllnTy9lSCtqclFjNlpHQkZE?=
 =?utf-8?B?N1ZNbjB4Ukdob2NydXo2RC9OR1BQUlN3WW90WGdGRUhRK0cyRzJKUkgzM29r?=
 =?utf-8?B?N09VTytHb0o0M3hOaTE2K3Z6c0JWNmc2SHUzcWhJcktFTlY0SmltWDRVMGtT?=
 =?utf-8?B?Zlg5TXoxOFN6eURNV3BIU3ZxQnA2dmRoSjhLaVFVWHRCN0NsbFpMZmZOamhq?=
 =?utf-8?B?Z04rblJDcTQyS3B3U2lxZFloL2syaGFFQTZqczVicy9PRFRsYnlKMzBGaWRn?=
 =?utf-8?B?eGY0Wkt6QTlRT3czYVErUkorQVl5TTVGdnVKOEMvdzZYL0JIRmZDdmlIaE9r?=
 =?utf-8?Q?K3iE++Og+Pw1F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFpsNXVLSGZnVVg3N3NCOVlpY1ZmNUw3M1hudW9meVhFeldENDdvN0gxaGlp?=
 =?utf-8?B?L0ZaWVE0RkY3Q3BiTGNvbFJoTjQvZnJmckxLM2NvR3k4WjJIV1hLMGUzT2tG?=
 =?utf-8?B?QzN4ZkpMRFlHRTdaTVZ2ZjBRUXFpMUZQVGdEbTEvWFRWcDNKbjFqUWpBbGYv?=
 =?utf-8?B?USsrc0k1dnNXb0p6Wmc1OTBHOC8vNGhwT1hYSzgzMXZHYXJVRXo1bXlLOWlz?=
 =?utf-8?B?VGsxRCtMaFdnVllmdHJmSHBkK1hrSG5peEsrNXN3cG9POUdoTlJJVll3aFhi?=
 =?utf-8?B?a2tlK0Mzb0FVUVl3eXVDalhXak5uSnYyWkFpeWxQYlQzbmx3Z2ZUVFNNNFRT?=
 =?utf-8?B?cjlEdVFEMm5kbUVkR3g1NWJhWVRJcEhVbTg4SWV5OHpaOTlOdXZlRzNIRDBo?=
 =?utf-8?B?SFRHV1ZSUlBrbVVTTitDN2VhQnA2Q2QremxKUGNiQjdTZkgrc0pGRlBwcGlK?=
 =?utf-8?B?NU5yVi9BUSs0VUZsdkFwbTRteksvR243YjJHMjhWMjZyZXJMNVZab2lPMWpO?=
 =?utf-8?B?dUpTQjF2MnI1bW1UTGRpSWU5ajdkQXg1amJwbWpOMENnRGVNczkxc3VSKzRC?=
 =?utf-8?B?djVJZk1kNnFRT2xJRTNrM3pWa3ZmOGJpTlVlTVhGREZSZEtDQjAvZmNmMjR5?=
 =?utf-8?B?MG8xdnZaYnBrUHpOcUlpeEc3S1QwRDcwN0YzQm1lTlRIR0hsZ3ZBeFMzRTAz?=
 =?utf-8?B?T2lZRzMrRDNvdlF1UTNIeGJhTVdWUUNXdUFra05ERHVXdUdlakRrVnNwYkhu?=
 =?utf-8?B?WFowRHBMQm1hc3Iwd1NZQVA5alNlNEFsd090dlRUek5nOVRjTzJkOUtxanVk?=
 =?utf-8?B?eXNYcnF5NmtCdUNOUHJZUlRXSXpDaG5ISEVhMVUxNnJOQTc5c1kvL2VISEc0?=
 =?utf-8?B?YlJES3NnNS9YNkprWUNHNWFFZ1Y5dGtYQThJVlBLcWQyM3BqSm9YTWtjTlBZ?=
 =?utf-8?B?NXRxN2llTk14dnpOWm55Z2FHeWJCTjB6aFVYaGc3M0lNd2FNOUcwazFsVG05?=
 =?utf-8?B?UmtHdFp3eEx1NW56MnF2cGVqUittZFkxWlNJaWh3VVVxbDRpdHplSXZOZ0w5?=
 =?utf-8?B?bVFFUE5USE5LKzl4bi9BNGtiRjF5bjJXeGtLaEkxVytKcy9PSXl0MHIrdTdH?=
 =?utf-8?B?S1ArMUNGTk5ZU3IxY3pVK0lVbzQ5MWNDbEFNK010T0VPZU1EditCMVRyWDJN?=
 =?utf-8?B?cHlnQmRjK1RsWE1yU0NYc2FCUkJTUEg3TGwzMkhoQ0puVE5hWHFWWXQ2eWJs?=
 =?utf-8?B?ak9NVU4wOUd2dXpzSVBrZnAyei9LUVpCQzNFYW1VUk5XUm5rNi8wOVhnTjlv?=
 =?utf-8?B?TDJPRUIwalY1SUxsUlFkSzZKeWIydjZEeEdxaTVsV3Y4aFVXYUtod0Q2b0FH?=
 =?utf-8?B?ZTZBYnlYa2FyeFdIZXhLY0VGY2oralgzVjd4OWF6YVVZbjJRSmFNallUc1lM?=
 =?utf-8?B?dHc5UUtGcVlJelBNNG5BZWg2UmduVTc2Ni9ZL3dtYWlNR0NRZXZqRlkwWFBJ?=
 =?utf-8?B?Q3IwU0s0NHJNWmtJTjVvT2NSTkZWWTZUZVlMcnBqK2EweUVGVmlRdlJQcGti?=
 =?utf-8?B?ZHZ3MllWeFpFdEVCUkJ6VXJseE03U0lidHArRlpoSXNvMTQwbEg5ZjFPOGc5?=
 =?utf-8?B?NkNDZ2o1bHdmVjUrYk5UYStwZllJY1dqdFAyWWlIVnp3WjllVElHYVN2NWVn?=
 =?utf-8?B?Wm8rSC9JTVdaUFNqcDNLYmRRVGwzd3J3TTJMbHUyUmNza054WjBOc3JrOTll?=
 =?utf-8?B?TDBQNGNrVFZpb09tMWtXa2F5MC9nQVlUamx5TmQ5cnhSOEpQU1h1alNDamRZ?=
 =?utf-8?B?Yzk4bkdPZDNvem5UTDk2aTh2TUdhTnE4RlYrdDg3anozZWpreG9xREEraVR6?=
 =?utf-8?B?cnQ5amRXOUh2YnorZHlQTWNLZ0NHdXkraXM5cjZoVDYrSU9LelFIUDJUYTli?=
 =?utf-8?B?bUs1U1pBaWRrOGJXNVdxNTJtcFZ3YmwwZ2VTS3pyZTJpSGZyQzRqQ1BIUU9D?=
 =?utf-8?B?cXY0VzFzbGxNd3MvcEwxSm1kVHMyaThXQmR6eHhlWko5b3FLV1VwSmltWUoz?=
 =?utf-8?B?MExWOG81Tm05R2d5eWZRZXhFcmxwalVYUkFlV21senFodGJjVGJiT3RQUmJp?=
 =?utf-8?B?KzZBZk1SQmNUVDUyRHkyOEJ2akdYSDlPUkhqeEJNamlNU0tMM3FmZ3dGc1V0?=
 =?utf-8?Q?Mx77LAx/++pOijXvdxuzE1ug8DXovTS86y+wajfA4gwN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a9622f-30a9-49a0-417a-08dd567f7c61
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:06:10.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eX6NoL6t6bUbYTL6n7Ee/c5gGnooPnGH4sIHJoVFJEp+m3H0yLegk1o+UW12gXLaFG4E0GwnUXpWgxPdUexOzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792


On 26/02/2025 16:00, Russell King (Oracle) wrote:
> On Wed, Feb 26, 2025 at 03:55:47PM +0000, Jon Hunter wrote:
>>
>> On 26/02/2025 10:59, Russell King (Oracle) wrote:
>>> On Wed, Feb 26, 2025 at 10:11:58AM +0000, Jon Hunter wrote:
>>>>
>>>> On 26/02/2025 10:02, Russell King (Oracle) wrote:
>>>>> On Tue, Feb 25, 2025 at 02:21:01PM +0000, Jon Hunter wrote:
>>>>>> Hi Russell,
>>>>>>
>>>>>> On 19/02/2025 20:57, Russell King (Oracle) wrote:
>>>>>>> So, let's try something (I haven't tested this, and its likely you
>>>>>>> will need to work it in to your other change.)
>>>>>>>
>>>>>>> Essentially, this disables the receive clock stop around the reset,
>>>>>>> something the stmmac driver has never done in the past.
>>>>>>>
>>>>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>>>> index 1cbea627b216..8e975863a2e3 100644
>>>>>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>>>>>> @@ -7926,6 +7926,8 @@ int stmmac_resume(struct device *dev)
>>>>>>>      	rtnl_lock();
>>>>>>>      	mutex_lock(&priv->lock);
>>>>>>> +	phy_eee_rx_clock_stop(priv->dev->phydev, false);
>>>>>>> +
>>>>>>>      	stmmac_reset_queues_param(priv);
>>>>>>>      	stmmac_free_tx_skbufs(priv);
>>>>>>> @@ -7937,6 +7939,9 @@ int stmmac_resume(struct device *dev)
>>>>>>>      	stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
>>>>>>> +	phy_eee_rx_clock_stop(priv->dev->phydev,
>>>>>>> +			      priv->phylink_config.eee_rx_clk_stop_enable);
>>>>>>> +
>>>>>>>      	stmmac_enable_all_queues(priv);
>>>>>>>      	stmmac_enable_all_dma_irq(priv);
>>>>>>
>>>>>>
>>>>>> Sorry for the delay, I have been testing various issues recently and needed
>>>>>> a bit more time to test this.
>>>>>>
>>>>>> It turns out that what I had proposed last week does not work. I believe
>>>>>> that with all the various debug/instrumentation I had added, I was again
>>>>>> getting lucky. So when I tested again this week on top of vanilla v6.14-rc2,
>>>>>> it did not work :-(
>>>>>>
>>>>>> However, what you are suggesting above, all by itself, is working. I have
>>>>>> tested this on top of vanilla v6.14-rc2 and v6.14-rc4 and it is working
>>>>>> reliably. I have also tested on some other boards that use the same stmmac
>>>>>> driver (but use the Aquantia PHY) and I have not seen any issues. So this
>>>>>> does fix the issue I am seeing.
>>>>>>
>>>>>> I know we are getting quite late in the rc for v6.14, but not sure if we
>>>>>> could add this as a fix?
>>>>>
>>>>> The patch above was something of a hack, bypassing the layering, so I
>>>>> would like to consider how this should be done properly.
>>>>>
>>>>> I'm still wondering whether the early call to phylink_resume() is
>>>>> symptomatic of this same issue, or whether there is a PHY that needs
>>>>> phy_start() to be called to output its clock even with link down that
>>>>> we don't know about.
>>>>>
>>>>> The phylink_resume() call is relevant to this because I'd like to put:
>>>>>
>>>>> 	phy_eee_rx_clock_stop(priv->dev->phydev,
>>>>> 			      priv->phylink_config.eee_rx_clk_stop_enable);
>>>>>
>>>>> in there to ensure that the PHY is correctly configured for clock-stop,
>>>>> but given stmmac's placement that wouldn't work.
>>>>>
>>>>> I'm then thinking of phylink_pre_resume() to disable the EEE clock-stop
>>>>> at the PHY.
>>>>>
>>>>> I think the only thing we could do is try solving this problem as per
>>>>> above and see what the fall-out from it is. I don't get the impression
>>>>> that stmmac users are particularly active at testing patches though, so
>>>>> it may take months to get breakage reports.
>>>>
>>>>
>>>> We can ask Furong to test as he seems to active and making changes, but
>>>> otherwise I am not sure how well it is being tested across various devices.
>>>> On the other hand, it feels like there are still lingering issues like this
>>>> with the driver and so I would hope this is moving in the right direction.
>>>>
>>>> Let me know if you have a patch you want me to test and I will run in on our
>>>> Tegra186, Tegra194 and Tegra234 devices that all use this.
>>>
>>> Do we think this needs to be a patch for the net tree or the net-next
>>> tree? I think we've established that it's been a long-standing bug,
>>> so maybe if we target net-next to give it more time to be tested?
>>>
>>
>> Yes I agree there is a long-standing issue here. What is unfortunate for
>> Linux v6.14 is that failure rate is much higher. However, I don't see what I
>> can really do about that. I can mark suspend as broken for Linux v6.14 for
>> this device and then hopefully we will get this resolved properly.
> 
> If we put the patches in net-next, it can have longer to be tested - it
> won't go straight into 6.14, but will wait until after net-next gets
> merged, and it'll then be backported to 6.14 stable trees.

Yes that would be great.

> I think the fix that I've outlined is too big and too risky to go
> straight into 6.14, but the smaller fix may be better, but would then
> need to be rewritten into the larger fix.

I think it is fine and better to get it fixed for the long term.

Thanks
Jon

-- 
nvpublic


