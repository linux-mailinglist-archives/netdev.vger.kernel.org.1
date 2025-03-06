Return-Path: <netdev+bounces-172433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECDCA5499A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED4F1885989
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F9221F07;
	Thu,  6 Mar 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OHCTsWgp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CB2206AF;
	Thu,  6 Mar 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260665; cv=fail; b=t7KncrzXthFiS4IYhtukrvLUabNfWYWy5gJqw5f7l5u+86JtrJ11bcKKLM+D6nxzzVUcGcNLMZ2W0nKIm38Vdbnn9f2luvIDD+PkH2QIlNcWa/bCYUgdk27jyF5K9sfdScqcJcX3RSV+q8iV2YJqwjMHxQz76hSoIv2kkxQO4V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260665; c=relaxed/simple;
	bh=CXXA/yemXFjdZRueluYGMU1xWXJdV7REwhghOVXIUnI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p1skH0EIo8STkMtFMIW4NU9ejgoaxtdErQHlFQNHSKB9btTQXuhWsgSMTmWaTHuZfKjW5zD54Q3rBAwiSuLgskDe+xP6L5OlGUgG3lnN/kxNhWRTomcZg5e73oQUMRAj1f+y1VBbMinGKIhB55Y/4R/xaQeoQp6c18uvxyxL7uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OHCTsWgp; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syYs9vNnH2M/U3ijoImakRQ+skd0YfL+CfxaQ6EBNDNsyfS/lH1UeqWX6d23ysW/ebMd6lRx4Pn0CdK3dC2UnoC86B5fE/1O9Hin0J+WLINwwqkrQNDCyedrSNm5ST5/ycjvW1E0/VGDIH1e5q5pWaav2yEEpizL0/Sklhhxm4FZCLY8/8bspIm0m+9bx+0qLqfusnBUg0sxTVqEg9JxQFaQtb6RQJXk2mVLvw79k+LJ9KxC+bvWgyinqZ/Q0h7IPZL0xVfhy54pWMFKoWbJqAi73mOpYgRdnBhJv1ipGeQXr29TJEOT2K0a/IeMpccgMQjCK+gowTwG8rA+U95I8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hl5iS6eOs+7nCIqGUHYgqSGfWd6yqE4neebcee/8p4=;
 b=bXgdS1OGs5WGtwHTQ9Aw6aifcHrJyWdzpgNRjmQLyOQjo+SA644wO2BSeAPKq2WL1Q0G4Aoe8He6I68g8o8qA44RgmeqLp/vCOdZYazbFR3SBnSHQdCQ1oFM8iax0dNGAF9IIXncFkB6eZokdxsNUa0ca8ay9rUTigUWzDMy7JI6Ukj14Oq2iTB8dwnx89i5vNsusCHX2iL0YVBS9OHzBakUQ+p+00qVbDQ5hNBngtma+fsdzMVqJ1VbJ+xe4ZJkVlMaxVxJjLxB/4SXJ3E0dM45jxGQSiE+jVEutdiL477vRggzWznJliSNV+UyEg9iR/U7i3+BulO7R2Dq6L4Zxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hl5iS6eOs+7nCIqGUHYgqSGfWd6yqE4neebcee/8p4=;
 b=OHCTsWgpK+pa+XetZS/0tim3Yj6tBBHj6nRI/0SpynDw9R9O0C7OmJYAUzAhAZevfQqGKfybUY3ASOAD2HzCkzXVe46dE7abnZqEp7LfG+Pn5zOP9niIK9upUelr5BhdtMHMnPdrm2+r2JG84D5eMyDeWD/se0HCzCpe9ylWwrxhrkSl4RMPRrltQwpSBzCxYCWzczsW4y8xwMh9L+OQlgZbDyetmvBFI9OGxK3wLpvDXXgRExdB+Q/SgGzii3kYK1KjTofMThStZ4252zO1YinlYokq+GcCSIrJDCC85hkT8Ziyz8ybJm3xIu+0AdyXdJr8neJQ43kcycJ88Dbw6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 11:30:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 11:30:58 +0000
Message-ID: <f783cf9c-9f79-4680-a6e9-d078abbd96ec@nvidia.com>
Date: Thu, 6 Mar 2025 11:30:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] net: stmmac: fix resume failures due to RX clock
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Thierry Reding <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0377.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::22) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 494b445d-242d-4f4e-2845-08dd5ca25da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzJGWDB3clFsWndjSDFZeWpDcTh2aVZmd2lzSmJVWUZpamFEckZ3NFVQN2NX?=
 =?utf-8?B?dzY3TEJHVTFZa3FjZjlMdHBKZEF6VWZUMlB1Z0RkTUg3bytNNjc0SVhGdmhT?=
 =?utf-8?B?QlJ5MkZoRjNBemJPSVJOZElraDJFUll0MytOZ1NmcU5UaUhrUXJlVGVzQndk?=
 =?utf-8?B?K3pCb2RFTFpFRFRIOGJycVhsLzJTOUhMbGlHSEVhSzFrS2loMDFxTkZ6WEVE?=
 =?utf-8?B?Vm45ZDRibW0yRjRWcW1kc1lxYlF6NjFjSWQ4YWNCQlNBbm9Ka0I4OGFoNDJv?=
 =?utf-8?B?RmVqQnRCL2xYc3hHQm9WUzB0R2ZUNm9oSUZpOFNwTzF1YXNKTU03V295RzN3?=
 =?utf-8?B?T2tOcTFOWllSQXByRTRRZEVBQUg3cWxtYkZLMmNyWTRPZjVNeHVvUGlGdEFz?=
 =?utf-8?B?MTJnVEtjTFNwcnIxMGQrUGl6WTQwQWpITGpKOXpqZ0JycUdSaU9LRy9vS1ov?=
 =?utf-8?B?SFplYkxVK3Q1RDRMamtoR2x5ZlRBWkU2REFZcGVyRmJrVEp2WFJiRXF6MnNR?=
 =?utf-8?B?TzlPa1VhcjA3SEd1Vk90NFpKNlB2Y1l3WGhiUitvdElKUG1FWWxxcUtiem9r?=
 =?utf-8?B?cnRLVGhOMERCY0FWMVByUkJvS2tvM0tMS0YxU2doNVQvNWJqVmtKVWY5N0ZW?=
 =?utf-8?B?bk42WjhJLzcrM0djMGQzVjB5THF2ZWVRZENMZTJXTXlDTkRyKzJ2ODB1Z3p0?=
 =?utf-8?B?VTJCZ2NjVnpDMDdyWlpDcWQrMnFaMWRaWWI2d0Q2UEExQ2NKNzlwMjVvZENX?=
 =?utf-8?B?aitqb0lMQnFtUW9HU2xpKytSa2hkT2luZENHVHdlZkFISDNLOWxyVm82SjM5?=
 =?utf-8?B?WDBBTEx1UVFKQXJzckFuNVo5RmFIdEZZenIxK3R2UTBLRm13NFg4MHVFWW9Z?=
 =?utf-8?B?aHZka1BSd2dmYWI0Qmw4V1NiOTJlNUR6N3JlK2l6NVB5Z0Fva01jRnhYMkFn?=
 =?utf-8?B?UmpGOHJiNTBpSmhPT0RNVkZNUmJ4ZnkxQnRidktadnYyblVjM1Q2ZGpsNmpY?=
 =?utf-8?B?bm5uZUpoNjBtZHBHV001VWQxSmVMcTlzYXo0VDN5TmM4STlKRXJ2anV4U3k5?=
 =?utf-8?B?T3U2bC9GY2pCTVBDejYxWEg4TDVieVNTd1pFdm4vZTBrVkNTUmhZVnVMcDlM?=
 =?utf-8?B?NTBHK1Bpa1NHRldIV1NLT3lWMFVTK2lQRTNyMmlDVEtLbkVlbVpDSTJ6VU1G?=
 =?utf-8?B?SmFPQ1czYXowMUNpcVFmbFpsdU1Fd2U5VVAwYUMyaHUrakRNbTdvem9BbStn?=
 =?utf-8?B?enZxbnp3ZFQ0RGwyRCtpZEVSUFRsdEN3ZHV2VWJrVnpkZmc2TEZKcVhHNGE3?=
 =?utf-8?B?c0ZQbmFCUEVkWWpsaWQwS1BjRW9YL0ZTbFNIamN5VDJ6S0tvemt4dkhESmgy?=
 =?utf-8?B?YTcxdUpsU1NUZ1BZdGJFWWM1ejFBM2RRcUpQdG1TQWh2ZU1rWVpZSWdwY3pz?=
 =?utf-8?B?c25jMytpQmtMVDNrVWl0NTNGV2dJRy9QNWRrU01vTDRndHA5TEp4bWxlMlhl?=
 =?utf-8?B?SlhFSWk0cXlGbyt6RWJTZlQzSDBJdlI2VzJ0UWs4RnBDOUwxWXMvaW1uTzlD?=
 =?utf-8?B?Z2JQZXYyWUVIVnNUZjhaSVlUbHowVEJRTWJwclc4RFQxRkQwQ1hxcEMvWTB1?=
 =?utf-8?B?czdESUduWlFCODdkZlpTbjFTL0JkeGFKSXNheWI2MmFxZUJJM3NhN0xRdjd1?=
 =?utf-8?B?VzhvQ1JUcTQxcEh0OEhiRTlOdnJ0RjZ6ZXNrWnV3emk3UFp3Z2VMZ0JxVGJj?=
 =?utf-8?B?Ri92Q0ZUTjhnZGEzM2FWQlcrejgwMFRZaldPQ2ttdDRnTEN5dWlIdlV0Ym9Q?=
 =?utf-8?B?bFFCb3FPY0ZBbUFGV0FPRkYyWVNwc01PeWxobWhGWmcreGZ5RmxmbXRaa1lq?=
 =?utf-8?Q?Y4LBltASFudyx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG1lN2pVYXFYQ1RQellJNmVGcXpZT254a2hQYjlGaW1DaDczb1JTVXRBQ3NL?=
 =?utf-8?B?cjFxa1NSZmpoWFZWdWRaNG90TmppdkUyRVpDK3Aram9TdmFTVjZlUU9Qc3hV?=
 =?utf-8?B?emhmSDkzVGJXUEZSdUVMVzJTbXNuMi95MG8wcDlnRUVVVWhyL3pUdW1QclBt?=
 =?utf-8?B?MmNQczdZUlI2a2JxaS9BTVQ5OHQxakgvZzAzelhKS1BGOTl6aEM4c0ZpWDIv?=
 =?utf-8?B?cm5CZGZNOGxKREs3T3RnMGdpbTBydXY5SVVaQXpoMW40U1NYZUI4TWE5MUhk?=
 =?utf-8?B?QnpVaDdYNFd4V3pmVFJzRVNROXZ3L3dUZ2k3UFZRTTdQUEJhVVZNNEh4TjZ0?=
 =?utf-8?B?NXpBSzBrdkIzU29yenUva1Q5b0JCejRkUTI1RG8xTDdvcU1LYmNrOFdxZGFi?=
 =?utf-8?B?ZjZjbmx5a2NObzlWRkhid3dFQXNqNVBVR2NzdzFTNmxzNml3MUxBdnkyNjBQ?=
 =?utf-8?B?U2FqR1psdVZsZjVLdHdPclowcFJnb0Vtb1F6V2FBaHlqQmkyR05VTE5EWkNj?=
 =?utf-8?B?ZG5hSXNUajdYdmJUN1JtQzk1VllDNkxmSTBjN1dOV2FVenVmcTB2WmhId09s?=
 =?utf-8?B?VmpnWGNUR3luWmlXalRKbmovMGxwSzdhTmhlM2JvTytlQ0NIMTVFZVplUVYv?=
 =?utf-8?B?b1FaZmxmTXE0cWt0WmdGakhYNDdNdFI3OGNicFV6VVVtbmdiUGZBZ3pjenJo?=
 =?utf-8?B?cm80NzdKWXFPdmZKN0VIcUMzbEE5c0txZUhOY0t0NEN5ZkMyRmtTQ0s2R3RK?=
 =?utf-8?B?cmRqZFUyQUluRndaZUhHaTN5Q29hRTJNb2UrL1ErdVlTaE53NHcwY0pjNU5w?=
 =?utf-8?B?OUp0WE52cGl4MTh2SCtibXp5azJ3V21UY2VBK0ZvUVg4MXhrV2l6Zm5oNThL?=
 =?utf-8?B?T1ZjVm9PbzZMZTl0Nld6QmtWamlCMW1QVTcyQjBzY1U0d2liSnBraS9NNmd4?=
 =?utf-8?B?SHI5Y0ttR1pDbHpxOVlZbEFySDBrZlk5Q1ArcVRmdU5odXJNVk5Nd0ZFUmRW?=
 =?utf-8?B?SXlvdmFBUXlDVlBnZDhWQTNBYmxnanhvQXU1dGxjR3NGY2xmcUVLNTRJcWlQ?=
 =?utf-8?B?VE8vUzZCY1FjcG9GVjJqY0FRMFh3Snoyd292QWtZL2xqcjFURzV1TWxhditZ?=
 =?utf-8?B?MHZ4N3BSUml0bnZTQmpRckNOTUx0dkZFN3cxeEkxWFFmR2JBczFPL3krTXpL?=
 =?utf-8?B?WGZtNHdsbWY4Qml6VUUzRWFROG93dk01aldzMEcwTjNvb254bGFHUmFQTXpW?=
 =?utf-8?B?WjdmNTJlQmFZNjFMNTRJOEtsdUxocDNaTFNQZHVxUnpDVUE3K3BiZmgvamUv?=
 =?utf-8?B?U1E5aUZjZ21OT1RuM1Y5dHdoYURKQjQ4TmEzOGVtbVMwWWJHSzM1OWU4MFpa?=
 =?utf-8?B?eElPd1ZIRWFwTSs1RUtURXp4WG56THMvYkpmZUwxd2tITDRpdnZUUFVTbzJR?=
 =?utf-8?B?RER3dUtTMTRHbVNYanhkTWdvNXR3MzhPaVJjTW5zOXFUN2lVOHBJdFdwWHJW?=
 =?utf-8?B?NTZTMjNpdFBlOXlLWkNEbmI0ZGhTbWxjN2VOV1luZFAyMkUyRWRsNXZnRnB2?=
 =?utf-8?B?YnU3VVFLYXVVTi9yai81ay90MEQyUnpxOGtMbjV3c1BTNGJxdmFJMjZiVmRm?=
 =?utf-8?B?QnBxNnpZOXhmVmxCdDY1SXNyeXhKVkVtcUE4cWZlRDZETm1YSEdpdWVwYUxL?=
 =?utf-8?B?OVlkZzFRdDhrSk8ydFlGZlRmSDZIekx6QTZsdkZNbGppTlArN1JKN1dJa2s4?=
 =?utf-8?B?Um1udUQ4bDdhb1ROb2s1c0ZUaWNGUDVYMFhNb0R1dmRGSG9FWTNNbmJtNmp5?=
 =?utf-8?B?K20xVUxmUFdZSHNaK1lNcHp5bVV1aFJWN21pTDBLRVhvYmg2bFZJVTZBRW0r?=
 =?utf-8?B?eTU1QWJQYWF0blh5Y1VZN1BaaFR2SVZvbURpQ3FUNXBmMW5OV0dJaUhTSVYx?=
 =?utf-8?B?eWZPdkdUZGd2ZjFLejAwcUoxYlJXOGRyWjlFNnJpaWNSMnVRVTNPS2xTV2di?=
 =?utf-8?B?Znp1NTlZeUJyd0VXM0pQUVVwQm5aV2t6L2JRdC82S0ZHSCtSVXdxamEvWVhU?=
 =?utf-8?B?UGhwSmxIYjcvQ095WTB1T3lHU3RKcUl0cEo2OXhIVmNSQ0syQ2xvN3ZSeUx3?=
 =?utf-8?Q?aZPjX/YL3h1CYo9KDtfH8WbM9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494b445d-242d-4f4e-2845-08dd5ca25da9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:30:58.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVFjr93KUWYWLQQuxttU74MZhnhvIE9+XaasMORL8qSqIzrMqUTI4JBHv6ZF9TAsL7jqfoFuMkJ9PTOYINwZ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571

Hi Russell,

On 27/02/2025 14:37, Russell King (Oracle) wrote:
> Hi,
> 
> This series is likely dependent on the "net: stmmac: cleanup transmit
> clock setting" series which was submitted earlier today.

I tested this series without the above on top of mainline and I still 
saw some issues with suspend. However, when testing this on top of -next 
(which has the referenced series) it works like a charm. So yes it does 
appear to be dependent indeed.

I have tested this on Tegra186, Tegra194 and Tegra234 with -next and all 
are working fine. So with that feel free to add my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


