Return-Path: <netdev+bounces-145648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A79D0456
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 15:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3321F217F6
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BA1D9586;
	Sun, 17 Nov 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DncnMgFZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34591D8DEE
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731854111; cv=fail; b=BAyQ58/2hSk5/wdRWMUJBh5gD4BXyeFpJXkgaAQJqSj2pWWnF4fphnemYYOfJl/U/43tgPwF2JxvrbIXle1RBa0kjp7DL7GMfHpxlDoCT2v6ABgUG6EzvoFps+xjW/zxnqjpJBu7p7OaLfDsM+hCWKoalnygQU92Pf7eOHWtIj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731854111; c=relaxed/simple;
	bh=vOwUszJUS4oGA124nc+uJhGFmN1CFiwnzQEUQtUCsCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LFZb9uxeEkppXmpkHJzk24/0AZ4/iZnFRdfrbKBCmX7XXXtPXDCTCNTKc+GMCL2yQU26d1Z9sDPv8408fw4BBRIzX7CipUIUQBg2AhxzU4+M/Z7gbUGrgfMfkL1FqvoaxdZbqRNHMSaxn54r5b9sxIOjAENuqJo+25Cj+Rutt48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DncnMgFZ; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDfmigNQYoC4SPSP84UZYNSTMHDHAKSx11sThPRmlgH1634JKmbg7DUwkzKz5X2eJE5VL1lmQF7/rbyakRXyfcVdoPIJTlJFHMkOWYBwdf8h0xqjGCio19vS3VaQtZxkOqdDDSbBLhzwjTRAxTAQc/r3TpgEwG9PJe4C2VmfLnDb8cCqGRtuS3zYIU69R2pBAdOoN8e6kgKsGWdDSLeX5cIAh8gRUWGycPSBaYF/XeRBwuTk+i/BCxTmcHrX8Iy6bu4M45NeEnrJHc+Ksijj8yyY60SF/Gjick7ZlPEwCsiMbJXr5zzl4Ir5NEYwGyjKUhruesO8qymkIBg9rIDVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kvfmd9SaP2odiMpuNU90/yxasLtdJIoIKGE293f74yY=;
 b=x/5Gf066Nb3wAdAqAyJmsW1BAoKCTeHlgF97wb7UeWoxumV5rcurNzsG1gZ3yYK4E39nnxW/AeHO6YyQIqJqLzSnI4FyB6fBfKIleDHKWbrZohDlp7p9o6HxOAToEuemPvt56M7ei/HVijNuxMLHy7y7xXaejz2FB2TbIN3DcnLl9D2eQ5W9GZv7t85LZL3SmNWpnpI0kcG9gaFEgXPq6l9VjQrvW1SoUeS/9SEspwNO+T2XaKnnDNqNnSCNAI95iKm3tWlNRRcotqcxI9VvV5lRXd41Ep4h4+DBrnYtt7x+xvNsDvIbzwBoebu4o8tlHBI4Z89upnS4tTzRFUbeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kvfmd9SaP2odiMpuNU90/yxasLtdJIoIKGE293f74yY=;
 b=DncnMgFZuHqwqB2Y4BEcUpCiCIHnP1Zl7qzsjC3rKwqZQFFclW+6i8/iKuU2p9PIfyV42AOBwLeCiqLYAmCGDV+ZqU+fusD/v98gszXtTBmzcNXhPIKnersqXHrYh9BWrBBp7dA3JSP1nV5SXUXPleyikevg7qBQrE+YQ6Uhp78PC2K4i76jZbs368bssgdM6NaDGqF3/4pctbeBhhID4AcxYkUW2ja2hXl8Dq5LD7ncSd8jZl0VNydx8x6K2998R3tA0rSZ2QbMtM3QfeW3XgB/5ZKnVRekDO/O6z5H5govobiQ87cLLjO4/quuE0CJ8EgF5XuPSn3JkaCdnbOvAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Sun, 17 Nov
 2024 14:35:06 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%3]) with mapi id 15.20.8158.021; Sun, 17 Nov 2024
 14:35:06 +0000
Message-ID: <54f2b846-ad73-41f9-9e65-7f3c004e4a6b@nvidia.com>
Date: Sun, 17 Nov 2024 16:34:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Cosmin Ratiu <cratiu@nvidia.com>
References: <20241114220937.719507-1-tariqt@nvidia.com>
 <20241114220937.719507-4-tariqt@nvidia.com>
 <6e5e26b7-9682-49e4-bc2e-7683967a8c78@redhat.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <6e5e26b7-9682-49e4-bc2e-7683967a8c78@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: e5056780-df0a-487b-614e-08dd071507c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFp6alpNT2xZWTZlUG0xTVBQdm5TaDZ0OVZOVU1mbDAzS1pnd3NxVHQ5RktQ?=
 =?utf-8?B?MUdOakdtWVFreXNUNU05QWpNN2dUbnkxTVNxc3grei9XT3p4LzlsVGloYnpK?=
 =?utf-8?B?TmhNOHE2ZFNZMVRxSkhwVGdCMHVjN0l2Ulg0bTlqVW5JYW1FSnRVdzBPMjgw?=
 =?utf-8?B?enhzVW9hemdUc1NxOEVPNFV2U1Z2ZjZsa3hxaDZVd0pyMmlCQ3g0aXBqRTF4?=
 =?utf-8?B?NEp5NFBZMEdTNFZ0VmNaTkdNdDN0aDFtM3QwcEwxWUhpcUo2b2pXMHhwWWFU?=
 =?utf-8?B?cVRJM1FjdjlhVGxSWUZPR1hqVUJBdldlV2xtRE5VcFNhcUdCMEpQcUtEUGFj?=
 =?utf-8?B?OEhYc1gwT2Z4QkJvblB6cmpkbkowb3psazF1akIwWFp0a3FCVWFGMlNBQXJX?=
 =?utf-8?B?bHJkUStiNHZ2dnBtMUZidHl4dExSYk81WHJtaU5vT3NXTEhlakhac1lWRkc0?=
 =?utf-8?B?WTZWMHhOV1k0dEc3WEUyM2tGc0ZoV212TjBQMkdFRFlYZDZJYmIyNHJlVHFm?=
 =?utf-8?B?WFFsVW0rZHlmS3JPbThRQmxHNUlwTzVvRWpGM09tSnkrZ3N5cDF5TXZ2enhh?=
 =?utf-8?B?T1ZqSFlPeXJYaFVDRm9UZEt4Qkt2cW1aMVh0bFhHTDJGbXpsZ1k1YXh0cmZw?=
 =?utf-8?B?TDVybnFXQ256Z0lyQ01oejVKcUVOZW93VmJzZ3grSVR0a1Awc3RVMFZCN1pP?=
 =?utf-8?B?VC9oT3ZwYzE1S2pjdWt4YjNPNEVZa3ZMY0Q4aHBWUitBcDE2bDVmNDVhZi9k?=
 =?utf-8?B?aW11Sit5QTBDWjFLWTBmUlBjQWQ0M2N5eW5YWGgwVC9sdyttQmN3U3E4Uy9j?=
 =?utf-8?B?RmRtZEk1OGJURGdLejlzejNzMFg0YjVCSWlJa3JaVXhTc0h0anNqd1QyeVNi?=
 =?utf-8?B?NUtwaWRMZldwcnZGd2U3N3NOWTY0MktvM2tMRG1pNDhVbWNGcWR4enhsMnc1?=
 =?utf-8?B?Q285N3gxeitqL3VZdFNFWWhhTE1kaU15bTdRY2NNZEhUYTM5a2ludm4rUk41?=
 =?utf-8?B?amM3Z1Zlb2VTMkVPOEhHWHZwVmlyeTB5UGUwSTBvaHVnUzhLSHRGNjFkL3JL?=
 =?utf-8?B?MEtiYll2SmFrOWdUWi9TSk9mak0wZGJzTDZwdXF4NkhmYWdLUGRUejJWVENs?=
 =?utf-8?B?dkNWYzNjZHUrMDdrc1RrZ0szMW44Rk52Y2lCUExUK1l5R1Nqb2FUWkRad3Nl?=
 =?utf-8?B?OGdOTUJjMmVkMlJ2VGUyZFFJVWxOb3VLMFVYdy8vdERuZE5QN3hiVC9qemo0?=
 =?utf-8?B?QXNFbVdzUWNJRnhqU1paWWNXQW5ZQWxFSmtDWlR6YjcvMEsvMW0xUDltNTFP?=
 =?utf-8?B?eTV3UVBJOHN6dmM1dE9nRFBzWTViRzJXbVhEVE9KZXFJcVFEekZhZ2t2d0ZK?=
 =?utf-8?B?WTFvMFVmMDl4dWVXZGdZWTVlOWFVV01RL0tPMDU3WGp0V3VSbENsczlFd1gr?=
 =?utf-8?B?eHlraGJGbnh0SGcycEE4RGJlMXRYaWhyYmhqdE5XbWtKeVdiUkZCYUFwejd0?=
 =?utf-8?B?NmRiRWVrY2FpdzR3OUFPZitud2NFeGxONHdmQVdac2NWR3RsbUJiVG00SE5W?=
 =?utf-8?B?dk5Mby9KT2Q0dGw5S2xjanIzTHF0OGt3YklLeEpSamJlMHREb3diUXFSUVpG?=
 =?utf-8?B?Y25UbisvamdLYVNaQWMzc0dFeXFuRFFvVFp1UWZKWHN5SUNFSVF2NFJXOXN2?=
 =?utf-8?B?c25XMjFXVEF1aHkxZHBjK2xvOHdNVHFnWFRTZ0JmZGRQTHNVcGYzOFNUQjVY?=
 =?utf-8?Q?WcVp94T7zrjAx7HJ0j1vBHS+AH6dtG+D5VLbVuo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym8yUGxOcXJhQzNOU3M5Vlc0SStuS0dGelVvdzEyTmsrV2I2YUR3NEZZUlVB?=
 =?utf-8?B?OTk2T1Z4MWVrbEhjWHIrZkRuNHpIdVJZNk5QMGNtSXpwNTUveU54MzM1cWdY?=
 =?utf-8?B?Vkd1Yi9qQXVFT3BhU0c2VHpFbE41RjdyVC93V2dMeUo0MlkvdU1MbVpOdWdx?=
 =?utf-8?B?eHNDcjc1aERrcmhLa3h2WHVVcTdQVEE0eG44eEpRcnUyVnZLZWxNdzNXTlhv?=
 =?utf-8?B?aHFKKy90dzhHM2h1Ulc2aFRSWW5EM2hKNHd4OEF2RkxWaTA2Y2pFWEtPQjhl?=
 =?utf-8?B?U3YwamVVd0x2cE81Y1JvUUlCS3dmbGRhbVBTa0VoNUpER2RaZU1hRzRyQzVP?=
 =?utf-8?B?a0pLMXBFRGJJQ3RkbTVQUm14SUFLRkRFNVdwd05jMjVpdTgrRmdmOGN0UWdP?=
 =?utf-8?B?aDRiWGpXbjQ0UGFleEg3aG1Ub0U5YXhEdDREdkpKMmQ0MVg5VVdmUmpSTmJj?=
 =?utf-8?B?UVcvbWhCbzcwbDlTQUh6UWxmaG5Ma1ViL2ZETmczZFF1NDMvdHQ5TVBPS3R3?=
 =?utf-8?B?R3hjcWswNyt3NjR3dS9BR0RBbjJuWVFneUlBS0pyRHhOVHVIRWt3Z295MHk4?=
 =?utf-8?B?VGJJQmJGNE5sSWpwVVJoc1BvN29YVmNKVDhXcFBuUmE1eHpoVWg3bm1KbzUz?=
 =?utf-8?B?RG1XOVVoVVFQcDFOVVVSNzBwRDMyVk9yVmNpc3Y0UTJQR2p0YVduWXdIZTA4?=
 =?utf-8?B?Nmd3SzRYa0dzUmJLVjNDYlFFckNCQXF3SjloaDRNMjV5bTgremRqc3VnSDlG?=
 =?utf-8?B?MDk5aWtZTkRFRzk3VkNLQ2VRZVhqM2IzcUJUYXZ1Wkc1dFVXTzlqdmlZTEVx?=
 =?utf-8?B?Nzl1QXpWTTIvR1ROeWVrSFBhWlNrcGhFOGRMNnBnUmhmeWFDSEYxUUhYakFz?=
 =?utf-8?B?RGk4bTFiQjQ3bHVoZFJZVStxM2FpN3I1NDhETFBSWFNTV0V0MnFUdjhBNitS?=
 =?utf-8?B?b0ZqeTFSV0liRjJwS3VTc29rc2FtejhTT2d1OTVuNW56Q0ZETCtTMUR1dVo2?=
 =?utf-8?B?WWNLWlBsYVcxZUFoM2JoMC8zK0NSWVZaaHVIcWxFRW1JZzRya0VzMHF2Y3Ni?=
 =?utf-8?B?OVlTbVRSYVBralNVYmphVzlwdDl3RndubjQ1MGpQcjRCU2hKTTF0QW1CK1VO?=
 =?utf-8?B?SjJML09yTWxaMi9qM0tSc2tNSXVPRWd5a3ZLZEtZcHNjV2lPWnhYWFprdmU2?=
 =?utf-8?B?bXZ0OEZJNVlFNm1WR1oxVU5WT1dRR0dLcDZHRDBhYzZ4L1ZLTTJnWjUvcTZO?=
 =?utf-8?B?aXBuVk5Dd0xGWHBRMkxsUi9wZ2JmdDhoOGNpNmlTbFkyMHgyRHlNakdNNDFN?=
 =?utf-8?B?WXExL0lKaW5ydlh2b1ZLMU1UWUFDNU03YWlwczhiUE5BRE1FeWt5U1ROWG1k?=
 =?utf-8?B?cDRWdmJXckxIOUYvTzQ4aVp4dmZHR0pKR2t6MHBRQW56NXZZMHVrTjFpMVRV?=
 =?utf-8?B?aGw0MnZpSW5yanU3LzNOMTlNSEZKTkNpTENPRGNJejRqR2ExRmVYbDZyNGE4?=
 =?utf-8?B?ZkVnTVQrYVhhRk8wMlZhcFgvNk5PKzF4NTRrTEtzdTQwRjVwWnVXNjdodDk0?=
 =?utf-8?B?dVVGbHJxM2srenc2T3I3UUtueXlJa1VsRGVRNGt4bGJWUW9RRzBJTGZpdXpE?=
 =?utf-8?B?UXVGbXpxQ1VOR2oxUkZHbDhmWkdlanBQZERvR3J4RzZSRDkxM2FZYUpKUlVB?=
 =?utf-8?B?NWZhY01zQWU4QlpjL01BUEFsaTI1OTZaWnJmRHdxTGo0MHIxZFUyZ3lsZ0xu?=
 =?utf-8?B?aVYySlFzZU0xdnVkNnJjU0tva2Z1TmRyV0YxQjM5WGlOdzl3eU1VVWRFNHBY?=
 =?utf-8?B?U0ZQZ2dCZmU2RWtYbUE3UVlHVUVsNmV3TU4zU1VhbVdFdm8wckt0bk9EdnJw?=
 =?utf-8?B?K0Q4eGRLVDlxQmFnTk1QamtCWHpqOFBwczVBU21xMEw4SS9sN1l6eHdUZ1R2?=
 =?utf-8?B?RXNzWXI2OTcveGEvclhEMmZoZjFjemtJUEtrOEUyMXRGWkJkcE1WdUFpWEFL?=
 =?utf-8?B?Mk9KWVk3NW5DVG9PUlExNWFMeWE2aVlLZFpGRmVEcm9meHRBU1haeDFOdkpv?=
 =?utf-8?B?MEhqeUl5K2gzdUppdHhYZEhkR3lxV1NaVjZvaW1HN2kvV2lXOWpNWnMxSVJv?=
 =?utf-8?Q?wsnQ9y+j4t1vCWA2+XU/FkUeY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5056780-df0a-487b-614e-08dd071507c3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 14:35:06.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZJngkI5zeN2bXpvhuhetfUntV9oPUhDdNeYYtQEosGXpU4s9j74s9JGDChLZaV0sNGX7HkGdA1Hm206ySQGDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742



On 15/11/2024 12:15, Paolo Abeni wrote:
> On 11/14/24 23:09, Tariq Toukan wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Introduce support for specifying bandwidth proportions between traffic
>> classes (TC) in the devlink-rate API. This new option allows users to
>> allocate bandwidth across multiple traffic classes in a single command.
>>
>> This feature provides a more granular control over traffic management,
>> especially for scenarios requiring Enhanced Transmission Selection.
>>
>> Users can now define a specific bandwidth share for each traffic class,
>> such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).
>>
>> Example:
>> DEV=pci/0000:08:00.0
>>
>> $ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
>>    tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0
>>
>> $ devlink port function rate set $DEV/vfs_group \
>>    tc-bw 0:20 1:0 2:0 3:0 4:0 5:10 6:60 7:0
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> I haven't dug into it, but this patch is apparently causing netdevsim
> self-tests failures:
> 
> https://netdev-3.bots.linux.dev/vmksft-netdevsim/results/860662/4-devlink-sh/stdout
> 
> Could you please have a look?
> 
> Thanks!
> 
> Paolo
>


Thanks for pointing this out. I’ve identified the issue and will address 
it in v3.



