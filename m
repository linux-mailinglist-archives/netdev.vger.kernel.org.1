Return-Path: <netdev+bounces-127503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC86975980
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52348B20E28
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD321B2EC9;
	Wed, 11 Sep 2024 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AKNnasLn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35711B1D53;
	Wed, 11 Sep 2024 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076109; cv=fail; b=K0KHzXaOKTlcZLKvnJ/JKe+7F4r7GI/zpnTY1ZU9s++K0o8gjizzBpeJKfueBcrJeD5IQHSy7rLwsn6nCszHQ3hTkl2hyrK9aU4N6rCsHA5z6FvPw2cLRvySConakTN5Is6+y8XnDGPOyiGBYMr+HSkL4OOxkrJd8bf2KQtmv8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076109; c=relaxed/simple;
	bh=/vzZpR40htdJOGDF8dWs6lD+HwXJEnfNvoF+Ll+5ocA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qvtBslp+V8nUs9A8Zi7xYvBAFqPXXq7/nOczKwxOXTyxqpugEIFyPW7EV+eWSgB+BH7h7BaIuoCI0niT7aAxwEqtxupyrM7QItk7q62G4cF6Xb13iVDzDSr2hG+ymJn1raeyDOFgYQfAqB3wWH8U/oUE0+15eebt9vXIBTKZ1IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AKNnasLn; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiqaelve9GMkHaa1ODOiWTGOBI2pCakdNABjS4Q3BYiY87o7DyUDa/aqJs5zrVCdm8U18p4BVd8A/+LGkegNgKSb/GtD2lMJyqA3UNUNL8Ggb6rbgDzvRr1exAHaVg/CdqPkd6gB6Jda87u1xUnRX3k+hd8DqCTwt0cIa3hPm8lvrzb/VnSVH7zxJiekO73ES3kFz/BXjIb1oiDEalCsolLusry7o635eZ5rfhM+BauQ0pvQq9qbnrZt0jOYFU/CupdVEKBDPbkdGYMQSX9ZXtlx4DT3zM1RiPpqH9mJFyJF/FinvtXdM2qc/xgDcurC6RN54OtZDWifvlb4ZXMxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo0OAZNO2EfqsjImvl2J8kU3p++SYGOOkNP86ApPoiQ=;
 b=n6GXtatw3FFPMhBmpOyvRpmoHRDU/DOVNHCCOpMN8mEmT7o9ovg00ISmNADNVWhmXZXEaKE2iqqNIXOWQPPH7yp+gNjep4WM0IVkjdgpb+ahLEc8QsROsCg8wkE/jadsFoclbRv/FEQ42hUw545i7PYuu6fBeq+VJDUzhzhO6W7gTiSk7gIyGVR7y7PitEiQy2ovk/g9H/bmCrodL9Hd2dYvH7LAZ++HVMHu+XX+bogyAba1xO8hTsDBX/iUpXYyZLR6E00DDSChUw5a6V2gv0uOqHX/ik5SBnPmXAtBVOkXPTOCM4ng/mQ0izunNUT/VysSK6u8hJ5VFtgbnoEg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo0OAZNO2EfqsjImvl2J8kU3p++SYGOOkNP86ApPoiQ=;
 b=AKNnasLnO798uWW6llPx67l9/nBvb+ZBRYCyK/wyluyPlkoN65C1OSAKHHZvwIltlkUKYDvxe1ky/BlHgtpJJWWp3F6cnU9We/J1VoB6YfakRcQuTqI3812G/xS/deL7fgVpDBYU21csGPDMQaTk7SaVCu2g3BTcuX/uSLJSF8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 17:35:03 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 17:35:02 +0000
Message-ID: <1b386103-4c6a-43ea-821f-50a570996669@amd.com>
Date: Wed, 11 Sep 2024 10:34:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] bnxt_en: add support for
 tcp-data-split-thresh ethtool command
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, corbet@lwn.net, michael.chan@broadcom.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, hkallweit1@gmail.com,
 kory.maincent@bootlin.com, ahmed.zaki@intel.com, paul.greenwalt@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, aleksander.lobakin@intel.com
References: <20240911145555.318605-1-ap420073@gmail.com>
 <20240911145555.318605-5-ap420073@gmail.com>
 <4973cca2-9e58-42cd-8b28-98fe08bf95a2@amd.com>
 <CAMArcTUC7eKaUfsEWQyR=aH_OMOcKxN9w2pHvui35AXP_5_GUA@mail.gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <CAMArcTUC7eKaUfsEWQyR=aH_OMOcKxN9w2pHvui35AXP_5_GUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:930:cf::16) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc485b1-5c9a-4a58-6103-08dcd288113d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmZyVGp4TXVTR1BiVUd2YVZrQi9rRFJTYkZrVWFYand4alFXTGpBbmdKQ284?=
 =?utf-8?B?TDRlYlEwRnNpbFlJc0V5cUl2eTJwcGRIdkh0WUFPbDZHUXJNMk1Pd0JHbUlm?=
 =?utf-8?B?amJMVDJ4ZVEwS3d6UEJRWTV5cndWTUdiSlczNk5NaHVCWkMyU0N4RjZGbjYy?=
 =?utf-8?B?eGgwOEZsN2IwbzJHS0RFN2EvdCtUQUNkUnc1dnRvNlBLbHBZbjcrQkFYT0Vk?=
 =?utf-8?B?dkJQUWFMdDZWU0U1cGtuWFcydndzWEF4TDZER0YyTnRnWGVVbyt0VmhGc25F?=
 =?utf-8?B?SmpGQmttSG42c0YyM1FDN2J2QitvaUFUVjI1alV0VG5TZXAveXRIcjlmUHl4?=
 =?utf-8?B?QlZRUjRvcjdzbTFyMGRIZkdqclgxdlVoQ1NMMEd2VGZyamVhaEkyR1BUQWxv?=
 =?utf-8?B?ZStoamNXVlF5NHo5K3RiaHJTMGQ1a21FVzhBMkdUWHFxRHBhRWVVYlU1N2R2?=
 =?utf-8?B?anZERjdtaHp3Z2hjVHBFK0NnamNFelk3UWNTNlVtWHd0S05XVWwrU2lYWDJX?=
 =?utf-8?B?dmRmZzZOMjBEV0t0WWZreTQ1Yno5WVQwUjBaUWcvVWE2eGpmMGxreDdOU1k3?=
 =?utf-8?B?bFQvdnRic2ltR2JkSjBKT3RFL1hBcTM4djRCTHR3SkdzMGdWRDYvbDJmMWhI?=
 =?utf-8?B?TFdmZ0VHUjZ4NnloSXRMNXQ3VkZmbWZEby9oV1FuYU5QZmI1V3ZYNlEra0lI?=
 =?utf-8?B?anNwN3FzVWpacy9TNXMvL0hNWWp3dUIrVWVQM3JRelI5ZmVCV0M4K0FNb1Ev?=
 =?utf-8?B?UlFTQUpOeWtEc1psS0gzNDU0VjB3U2VZMUpjNWxxb3RZZ3JYUm9ubVRNR3U3?=
 =?utf-8?B?bENGTmtsM1BMeStyMEVTR3RhR0VlU3BoaDYrMVhMYWh1WlhJQ3l1TC9TYkN5?=
 =?utf-8?B?bTRtYmxxL1paVlNWMWYxdkhrYThBZEliRjJQV0xkdEUwdVFXemh2d1RjMzN4?=
 =?utf-8?B?QWowNW1nNmRjRFVRZTVVLzc5OXFtTXVjMVluU0RWU2Q1SXgreHJzTEFMcXJy?=
 =?utf-8?B?TEZ2NGpHQ21DRXBNM1VudXp5cWg5K01vRU9Wc0haMytGMFhid0RZR2hYUExE?=
 =?utf-8?B?ejkyZm5laTJjdUtvQ1BxYjhZcTE1RHJldDNwZEl3TzNiVXRWWHJVSnRUVnJv?=
 =?utf-8?B?bE1VUkxUTnJOQ2NWZTBmc1hXdi94Z3AwZ2tLL2pMRjI2Vis2UEtudjFmRUY4?=
 =?utf-8?B?bzhWWXJEWWwxcVBUalY5cW5jaDZFZHlVbGw3aEEvSUhRK1NwOFY1c0JqMWU1?=
 =?utf-8?B?dEhzRmxmeFpmdGI4cy9xVUhhOEZ4bVVwVzF5ZkRDWmUwOXF4Sll0K1pxYVZ1?=
 =?utf-8?B?SFFkQ2M4V1MzRzR1NmJYZXl3MEdaSzZPd0xDRDNlZmNOMis4MDg0bThVK1RU?=
 =?utf-8?B?dmU5OXFDTXNNL1crRGp6Q2dtVUlkNTd4RGg0RG5QWEpMem1UQmdjWi9ER0lx?=
 =?utf-8?B?ZzU5SGFBc0I1b2VjbWgvLzZ4MEs4aVZpUHk0cU1kcXQvMml3T1BTQzViem4w?=
 =?utf-8?B?LzlTNkRzTkxUNUdoeksxa0FKYWU4QTI2dU9GdWlkSGoyTVBCWGxqUUpkVUhD?=
 =?utf-8?B?THdkVzUvUUtkc25wYTVrdGZrUUpScWNOazVtN2FTK0JwK1dmMGVDSjlsTVVR?=
 =?utf-8?B?Snpvc3RucFFBRVNyME5FWlEyTjJ3U2Z6Mk5lMXdHZy9xa0FhNGcrQnJ1bGZu?=
 =?utf-8?B?RGIxRks4WHhMWnVtOW1SZDJwVlhjWVU3MTNST0NwNThuTU9hQVY1OGFKOFJj?=
 =?utf-8?B?VlhpaklSQlg5cHk5V25qRjQvdzJlQnZNd1JUTDJpV08wWkpyWnRVb1dQK296?=
 =?utf-8?B?eWM0eElrdjRoZURlREFLQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckd1TkhBQzJBOHBpRWhETC9UbUU1TGlDV2xVS0VEbjY5RTFkbml0ZVRsOXl5?=
 =?utf-8?B?UjJ3YmZERW5rdCtFa2tRMHd0VzIrMGJhRjBJY1JnL2FYWFRpUm5iWktZVXVt?=
 =?utf-8?B?RERUNGZZNGRYWlRrL0hKbWdvK1F2eG1NMzlWZUVITEUvbnlLU0RCQXFjdEha?=
 =?utf-8?B?eXYrb3hybFJMaHRqRXh3YjdUNTU0OVNqRXk4bzBKbk5iM2FmeDE0aUkwalho?=
 =?utf-8?B?NzFsOHRBZ2d0RHpQaEtOSXY1ZDJjZFh5cCtHSkIxeCtGNmx2TUtjQ1pxcFpt?=
 =?utf-8?B?VE5RejNsdXFmK2pCYXU4THhTYnVJRzZNVjJ1K0J3YUgxSU9HaWxOU2Z2U1RR?=
 =?utf-8?B?TGt4bEdlS2RIWXY4dEd0WWFUdDcraVNTMDR3N3JTaXJqR0daU1BxSnRKSzhR?=
 =?utf-8?B?ZGxqV3YrY2xUZXBTa1ozVzhZY0tzUnVhKzZsamJlQ2dQWXYzRnIxTVlZNDNr?=
 =?utf-8?B?Z1BGRG8vRC93VWZlaE5sRnh0cGtHeWZDSnNoUHF0UW42UkVmTk1zakJWVlBT?=
 =?utf-8?B?TDZxUGhVbUc0SWpxLzAyd2ZXQ0Q4UWdXYk9vclM1RDU3ZjZURnFYb2J5SmdH?=
 =?utf-8?B?VlJTalk2NmIrakhqckhyVTN4U0xrbGdoN21iYjdrS0gxRmhzVGpTbXJPQkVo?=
 =?utf-8?B?WTJ2UHJLQ2Z5ck1HQWMzVUZzcTZZNzc1Nkh1ZTUzeDM3S1ZqcHA5MU02OFBt?=
 =?utf-8?B?UWREc3lVRXRGNjJWM0ZBSXA2SzAxY2poRTdYaTQxYnF0QVBRdXM2cEYrcXQ3?=
 =?utf-8?B?K2xjR01CaW5EblhjaTRKdk1malBlVGxMcUVVWkxVekRvUGg3aDJNdi96THBw?=
 =?utf-8?B?dXFrS1hON25lNzBDd04vNEJTRXBBTEJSSjlHNDN3S0RhZExaYnNla0RidUh1?=
 =?utf-8?B?SEtNTXM4aVYwTkdGMXo2M1hqcnF6d1lWUDBLNEloWnlUaGpGOGN6ZUZ1T2dH?=
 =?utf-8?B?NWJPSTl3bnNKUmFibk42RU5HZyt5Umc2d3czTjU4MytmTHcxaFBBMTh6bVND?=
 =?utf-8?B?RTVnYlQ0VXlRRENYc1FseERUTVZWZGozMWpjaXNyMGZ2bUJGK2RKNzdYNnFs?=
 =?utf-8?B?Uk82bGFBZjFhKzNWL3hvSkN0d2lmYzRwd2VtLzJtRlJtOExudXVGUWhkczlN?=
 =?utf-8?B?QkN2eHZOYSs3emQrRlJuRjhJeGtnMzAxRE9jOEt2YklpVjhEMEZMeUhndFVR?=
 =?utf-8?B?V2xYWlNsY2ZIaVpBc0pTR2pGcUZCZWJla1FBUzhxZ2tGMmJPMm1OSmdlZmZI?=
 =?utf-8?B?bERybEtBV3JkbWNIVE9XTzhDcXZmYi8vdk0vV3FIbm1QdWtuMWliOVlYWTFa?=
 =?utf-8?B?V1daYndJMUQrR01tdk1PRVcvdFdwMVVOZDBCSFlEUzNGV3NTV29PUUZrZm82?=
 =?utf-8?B?YlRmQnJvUVRnQ0M0SG9XMTdhbE02dmpPVE11YWxSdWY1Q3lwc1puNi9oYnd5?=
 =?utf-8?B?emI4MXVDLzlpQlZUekdXUEFUMlhKNmtpdG9Zbk91MTR6TlhtTnRKZjIrOXNv?=
 =?utf-8?B?MGtHa3hyckhhWE9ZWlZjNnBCVlNQK2R6OFphak5sNmltVXFhSDVQUE1mNnY3?=
 =?utf-8?B?ZGUxTS9GRnFlMklYcGtMb0dFaWZWd3JQNmtjU0xQZVZLSGZ4cEhvMnlBRlJ5?=
 =?utf-8?B?NXlrT01FNmQvNE1MWjNMSmRBZjNsaWtxSnRMQTFydWFuK01tYW54YUNKK1ox?=
 =?utf-8?B?eHZQMktySm1jOEVTYmgrTHRFNDNRcEpmL2s4N1VFcFRwMThwSWF1akRhbXJJ?=
 =?utf-8?B?WThWVlRJZllaWTZqZ00zbjRaMHJjR25vRUpSZjc5Q2hxTmh0Z09yOWNxbVFJ?=
 =?utf-8?B?K2R5VEFEaFJCVXpaSktBSFgvMlYzYnE1bTNQR3pmdnYrQ3RyZWw2dGN4c2tU?=
 =?utf-8?B?eTVya3N0UjV4NDQrcEEweFIwUjBhamc5aTVRR1ZzMXdaTkJLQ3dXT0swcTVv?=
 =?utf-8?B?YlhGYmNzeGhCWDNQa1lTYjYrWXo5ZlFHM3JsMlNHd0pNMDFtVTVBcEllaFVE?=
 =?utf-8?B?MHNvUmEzTjRVdCtWcHdUd0QycWtIcmhqbWVMQUhKWFNCU0Q2U2JKTWdOVDhp?=
 =?utf-8?B?aGVvUU9iaTB2ZzVpcllocndscENUOU1BQllRaDdZVTRjV2pldUtKUWVtcktE?=
 =?utf-8?Q?Q+PFcLffIQVzNAdXq18UmnrpE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc485b1-5c9a-4a58-6103-08dcd288113d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 17:35:02.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sN2Pu8IbbGUs/d9aSMK1mLRl/MexWECpUFNJA6rMFYkEwRvsoHd0CCYtFwHS7yjn5H7n7qGkY2ZBKk/xJE5iMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577



On 9/11/2024 9:32 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Sep 12, 2024 at 12:52 AM Brett Creeley <bcreeley@amd.com> wrote:
> 
> Hi Brett,
> Thank you so much for your review!
> 
>>
>>
>>
>> On 9/11/2024 7:55 AM, Taehee Yoo wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> The bnxt_en driver has configured the hds_threshold value automatically
>>> when TPA is enabled based on the rx-copybreak default value.
>>> Now the tcp-data-split-thresh ethtool command is added, so it adds an
>>> implementation of tcp-data-split-thresh option.
>>>
>>> Configuration of the tcp-data-split-thresh is allowed only when
>>> the tcp-data-split is enabled. The default value of
>>> tcp-data-split-thresh is 256, which is the default value of rx-copybreak,
>>> which used to be the hds_thresh value.
>>>
>>>      # Example:
>>>      # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
>>>      # ethtool -g enp14s0f0np0
>>>      Ring parameters for enp14s0f0np0:
>>>      Pre-set maximums:
>>>      ...
>>>      Current hardware settings:
>>>      ...
>>>      TCP data split:         on
>>>      TCP data split thresh:  256
>>>
>>> It enables tcp-data-split and sets tcp-data-split-thresh value to 256.
>>>
>>>      # ethtool -G enp14s0f0np0 tcp-data-split off
>>>      # ethtool -g enp14s0f0np0
>>>      Ring parameters for enp14s0f0np0:
>>>      Pre-set maximums:
>>>      ...
>>>      Current hardware settings:
>>>      ...
>>>      TCP data split:         off
>>>      TCP data split thresh:  n/a
>>>
>>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>>> ---
>>>
>>> v2:
>>>    - Patch added.
>>>
>>>    drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
>>>    drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
>>>    drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 9 +++++++++
>>>    3 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> index f046478dfd2a..872b15842b11 100644
>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>>> @@ -4455,6 +4455,7 @@ static void bnxt_init_ring_params(struct bnxt *bp)
>>>    {
>>>           bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
>>>           bp->flags |= BNXT_FLAG_HDS;
>>> +       bp->hds_threshold = BNXT_DEFAULT_RX_COPYBREAK;
>>>    }
>>>
>>>    /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
>>> @@ -6429,7 +6430,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>>>                                             VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
>>>                   req->enables |=
>>>                           cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
>>> -               req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
>>> +               req->hds_threshold = cpu_to_le16(bp->hds_threshold);
>>>           }
>>>           req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
>>>           return hwrm_req_send(bp, req);
>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>>> index 35601c71dfe9..48f390519c35 100644
>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
>>> @@ -2311,6 +2311,8 @@ struct bnxt {
>>>           int                     rx_agg_nr_pages;
>>>           int                     rx_nr_rings;
>>>           int                     rsscos_nr_ctxs;
>>> +#define BNXT_HDS_THRESHOLD_MAX 256
>>> +       u16                     hds_threshold;
>>>
>>>           u32                     tx_ring_size;
>>>           u32                     tx_ring_mask;
>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
>>> index ab64d7f94796..5b1f3047bf84 100644
>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
>>> @@ -839,6 +839,8 @@ static void bnxt_get_ringparam(struct net_device *dev,
>>>           else
>>>                   kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
>>>
>>> +       kernel_ering->tcp_data_split_thresh = bp->hds_threshold;
>>> +
>>>           ering->tx_max_pending = BNXT_MAX_TX_DESC_CNT;
>>>
>>>           ering->rx_pending = bp->rx_ring_size;
>>> @@ -864,6 +866,12 @@ static int bnxt_set_ringparam(struct net_device *dev,
>>>                   return -EINVAL;
>>>           }
>>>
>>> +       if (kernel_ering->tcp_data_split_thresh > BNXT_HDS_THRESHOLD_MAX) {
>>> +               NL_SET_ERR_MSG_MOD(extack,
>>> +                                  "tcp-data-split-thresh size too big");
>>
>> Should you print the BNXT_HDS_THRESHOLD_MAX value here so the user knows
>> the max size?
> 
> Okay, I will print BNXT_HDS_THRESHOLD_MAX value with extack message.
> 
>>
>> Actually, does it make more sense for ethtool get_ringparam to query the
>> max threshold size from the driver and reject this in the core so all
>> drivers don't have to have this same kind of check?
> 
> Ah, I didn't consider this.
> You mean that like ETHTOOL_A_RINGS_RX_MAX, right?
> So, we can check precise information in userspace without error.
> 
> We can check tcp-data-split-threshold-max information like below.
> ethtool -g enp13s0f0np0
> Ring parameters for enp13s0f0np0:
> Pre-set maximums:
> RX: 2047
> RX Mini: n/a
> RX Jumbo: 8191
> TX: 2047
> TX push buff len: n/a
> TCP data split thresh: 256 <-- here
> Current hardware settings:
> RX: 511
> RX Mini: n/a
> RX Jumbo: 2044
> TX: 511
> RX Buf Len: n/a
> CQE Size: n/a
> TX Push: off
> RX Push: off
> TX push buff len: n/a
> TCP data split: on
> TCP data split thresh: 0
> 
> I agree with this suggestion.
> So, I will try to add ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH_MAX
> option in the ethtool core unless there is no objection.

Yeah, I think this makes the most sense so all/any vendor drivers 
implementing tcp-data-split-thresh don't have to worry about checking 
against their max in their set_ringparam callback, they just have to set 
their max in the get_ringparam callback.

You mentioned ETHTOOL_A_RINGS_RX_MAX, which there are already examples 
of this in the kernel and other similar ring parameter max values.

Thanks,

Brett

> 
>>
>> Thanks,
>>
>> Brett
>>
>>> +               return -EINVAL;
>>> +       }
>>> +
>>>           if (netif_running(dev))
>>>                   bnxt_close_nic(bp, false, false);
>>>
>>> @@ -871,6 +879,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
>>>           case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
>>>           case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
>>>                   bp->flags |= BNXT_FLAG_HDS;
>>> +               bp->hds_threshold = (u16)kernel_ering->tcp_data_split_thresh;
>>>                   break;
>>>           case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
>>>                   bp->flags &= ~BNXT_FLAG_HDS;
>>> --
>>> 2.34.1
>>>
>>>
> 
> Thanks a lot!
> Taehee Yoo

