Return-Path: <netdev+bounces-222407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC1B541D6
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6FC1C25D0E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC38726F2A8;
	Fri, 12 Sep 2025 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="e9pk50ac"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8081C4A10;
	Fri, 12 Sep 2025 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757653475; cv=fail; b=hYwYAsIMzwytwYN1k/BVKlpiWWLDBKa6Ed2IDNyOqaV7FLEnVWKlobIduDgCd6RevV/zvuD1zQ358jVXXcbI7/tqP1L07Dh09k8OlM4IiwrTO0K3F08dps7E3N400ZHVhy7ZU6zRkWU04ySLvKKJdsQb91Z9feR59o+tg3U8W10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757653475; c=relaxed/simple;
	bh=NMvXa9WGE0pLM1LUZBzVVsNHuZ5GhpFT9U6l0KRfalQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EcemHuxJ5ddWwBW5ECTe0/TTYFS8NE8btaN4XH776K1J66jCFr4FxEzGh9PtujW1lZm1p4hnRFOMvyAtN9GFGpTIcoRtAvB+k7t/cqC9s87h+hVlSWlaTcg9IGFIeTlQFmUbSzQCYDp0s/noTIlX6qT0eHBNFoKNtVuiGidAhKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=e9pk50ac; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5D7Qavj2ifXj+OpVETd7ZcfJthb5eWcIAjdqUGkf42mAKbAXihd8dxKeHWiM7o7rDxsXPWHdBBKZZWUFCZsc1o8Px5b+iyDViC2d2h0/maEfzfiYKWFAbD9S71VHZWOYWwlIavA+V1ATY1Gen+vTa4ihrNSBaZRqtlbw1EhRHNRJD/SloYQDEEsX9aSI1sZnz6FBDfD+G2ONIoOchYPTZK1i1TkOl6lRe7RNTQNxb5xFKn7PewuS++dgG9UaQgKBuOiyypiIqDvorVusTFfj7E9CYKiH+YcyaEz1lQrTxCNOpdcd7EwbB4/ebWeCDjt2NoQj7fUNJ5soLVPkWI4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDxJuMfU/BINQFDX80bc12/HBcIjXv4VuqY/yXO+Rms=;
 b=ex0wIwqUWqi/XRH3OjvgDhjygHMzknVuigN6IJ8MSBrrxHIPeSYS5GTV3Avv2+o3b4roiXw6vIMRo1DCO2JCazUIBfKT24BQcN/M5DpLcX77PeJ0z3XpHXQIUL4kB3tw5zdxkX8+ifxm2fjoq5SjLHxzrvE2+TQ1Uc9njdLz8iB6gxVDFMILXuJEYQEzUOEwJsGu3CvN4Et9f1398KhOfmzkSZnHTPiBe7XXTTX+F5sO3igBRPD9K8yxos3aNW/yLGR8oe/TQWzYaSJCic6jvyvyBd1cH+F4po19dqKM9yNb67bRzOAMgCV6NDb54WxOapQ15oyNiTJb7MBUeJH1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDxJuMfU/BINQFDX80bc12/HBcIjXv4VuqY/yXO+Rms=;
 b=e9pk50achxR3auF7rhIbLbvgeySFefRDXy70tfN26yPD3OUgOTItvQJVTpqaUngg5fEzXn6OSC7blB8FNK6rhWPXs2X7UO+fTVbdHOg6/Iiqp5oM861PGimfC8YvuiVkcSXvVxLF8Qf/VQf0is/mmBMPUp8kin29ynWHF/ZMrgiYZKouOeQGYVtpjMhle4a57dueq1+Zui/2jBiyp28BP8RhgYp7vyiXQZoPTS2UCgllSB9JzKFfgjjA56nn0LmtqRxg2bUdfnzm4nLOog0d2/pwYf12eSU35m1gwZ4LY24mlwCVBD0jt4GGuhYpTOpnBxEKWFi+a61AlfHqBPp9kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BY5PR03MB5127.namprd03.prod.outlook.com (2603:10b6:a03:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 05:04:31 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9094.017; Fri, 12 Sep 2025
 05:04:31 +0000
Message-ID: <bb5f6f98-75aa-44df-a70a-0f25b1efa4a3@altera.com>
Date: Fri, 12 Sep 2025 10:34:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: stmmac: est: Fix GCL bounds checks
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com>
 <20250911-qbv-fixes-v1-1-e81e9597cf1f@altera.com>
 <aMKxc6AuEiWplhcV@shell.armlinux.org.uk>
 <2d00df77-870d-426c-a823-3a9f53d9eb30@altera.com>
 <20250911170159.383edcc6@kernel.org>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20250911170159.383edcc6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::11) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BY5PR03MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: e54c1ad4-486d-44d3-c62f-08ddf1b9db8f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWtrNSsyU1p6U1NvcC9mSW45bEJDdVJEUGtSVmlweHlkdFQ2ZHRDUGNzMUl1?=
 =?utf-8?B?bUt4S1dsYk9oZkdxd0xFTWwyRGpibXVGSG9hWWRYY2M0NWZPOXJFWEdWYy9x?=
 =?utf-8?B?WFh5bjNKZFhKUFBhWXFpbE0za0tJb2duZ3BYNzdmeWZDU3dmRjA1enYwcUVu?=
 =?utf-8?B?a3RlbitBRjhkYiszNFg0S3BQcklqdFJKUnUrU1cwWUdIVHlUbE0zWDhSVENR?=
 =?utf-8?B?dk5lZ1hobkU2NDM4Y05zRGpzbDBKak9YdU8zckV0WDF5Nkl5RjJrT3VpMVdF?=
 =?utf-8?B?OStIWno5SFozOWx1QUsxNC80QzYyeHdBQ3N3OWpNcVIxLzVoRERZcjEzZGtv?=
 =?utf-8?B?UzNJSnpLNFBzOHZmV0hmN001L3JQdVdZdTdOUWtMd0hsZ3JPSWZYOGtacDFv?=
 =?utf-8?B?ZlBuYXdwVVRYdnpFN2VCWWpuL2hNM2poRStjQ3N5ZFBKUjBCdUdxaFduUnhC?=
 =?utf-8?B?SlpzeENiVm9NOXpNMnVvVitwRGJFeHZrUmlUaW0rUTZwcjY3MGVsN1Nqdk05?=
 =?utf-8?B?TmFLOVdmU3J1SlovZk1qQTRoWWswbXNRblRjMHJNL3UwaEtmcnZwRXVJMzFt?=
 =?utf-8?B?K0hGWGNqcmtSNFl0d0hOR3Ywa1hubit6LzJDVHhoa29HemZjSkhxQThnem8r?=
 =?utf-8?B?T3NNalJpSEdaQWtDbk5UcmQ5UjBUcndPd3E4aEJTRHFYSjNsdnN5NnFqMGpm?=
 =?utf-8?B?WG4vb3huSmJzV042bnRtVG1RbU5iWDRpZFRIUEQ2VzlYSGVuclB6OGRnbDE5?=
 =?utf-8?B?aE9kOG9QZWFmZjRhTlRnT0E5eUxnbTJaVk9tb3BYcjVNNDhuZE0rWWUrSWZF?=
 =?utf-8?B?VTNwUU90T2JuNTY4RTVQVHZZbi92MHY5aGxVdDl2bTBvRHJseXNqSHI2TEdv?=
 =?utf-8?B?SFYwRmYxd3p1czRuTG1PTlZpaFIreHlrMHpqV3VBVnRlaHZBbk9ONTNwTXdv?=
 =?utf-8?B?T2VhRnhQNWdyMlFlcS9naVZNVFhhd01QUUNVZUZLemNJVFJuT3FyMXByNlFE?=
 =?utf-8?B?S2MzUUpDMWovUFVEeDhOL1VlcTJKOENjaU85bDFiMWFrSklodXpWaGluckZC?=
 =?utf-8?B?ekxhbUswdnVuZnl0YzBuVDQ0Ulp1akJnNXZyRmhiRUZxK0ZITWpQc1M0em9x?=
 =?utf-8?B?S1NqUGpjNUF1S290NVhVVE1ZdjJpVmEzVGZpemxJRkNIaHdWblNUWVJyRVBt?=
 =?utf-8?B?NG9MblBtUWhhaXFiOG5XbnV0Y1hsUHI1OEFFN3lzcytOS2JwSEt1Rlc2RjJV?=
 =?utf-8?B?cXRPTDEra25rc0JqM3NNNzhIdmZpVk0yNW51NUNYTWYyamY0V0xnZVIyZU1M?=
 =?utf-8?B?c0NNM3lNWmJxeTB2REluNkE3N2NlQU5tOXlBMnFBUGlKdTA1SFhmamxkY0hB?=
 =?utf-8?B?b09melVwbDdEVVZCVWNQVGo2cjEwUHFKWXNsUGEwRWlPZEd6ZHhkd09qa1ov?=
 =?utf-8?B?MU5aVmxCT092UldGOFBZNUhYVEFmWEEyUytEMmRzai9GUS9XaStuZlhLNG9B?=
 =?utf-8?B?eVZMTXNUSjJ3UmFPUTh2T0JsK3djTmQyUEY1UVd3NVNjbHkxMGZURzA0RVN5?=
 =?utf-8?B?dlhnakdzYkt3cFBHNGJ2TkZITmZaSVdTMVk1aUpwRTExK1pzSUg0QlB6MW1H?=
 =?utf-8?B?TUpFeGJ6NzJueUJEL3NRS2JMcm53UkZmNEdrWnNRT2lVdmRMTndWMlloT3d6?=
 =?utf-8?B?VHowUVlXbnc2cUJ4Q0Y5QTVMc0h4UklWZnd3SnJMbm90eGEzd1F1dWpaRmdD?=
 =?utf-8?B?aTRYZHpReHlTOGNNTWdYR3NzTGpHQ1hLcUZiS2hjRHNueDJxZUEram5BVlZ6?=
 =?utf-8?B?VlI3STNteHZxalgwL290Sit6Q3JaWHhuTDVscTRvdjFCSlV1K0s4dUthZExV?=
 =?utf-8?B?MDdIRHZ2V0tFckZCaTlIditwWHhPMWFMWlFGamc2elNtbXRPMVhUbDB1Q3Jq?=
 =?utf-8?Q?iYx7W6296x8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXZ3MFpzMTNvN1VwcTk5dGpqY0hmQTMzc3pXcVZSZFd4MmRzQVhiOXQ1YlVL?=
 =?utf-8?B?WFlCQlpCakc1ZmYyWGFwOWJoNytmTy9XaVo3dzBjVllMdDZGK3J4L0lYNGxm?=
 =?utf-8?B?YnN5STB4QVB6WWI1aEIvNTRmaGFLQTNNaDBuVURUTDU4UU9aY2pDTE43RnJV?=
 =?utf-8?B?TWJDMVd0SW1CMUtOZGE3dVVpalozS1MwMXBub2g1eFAzN1VGWEdjZE1uam9Q?=
 =?utf-8?B?Uy91L1BZSzdldVRMTVByVkJxNlJxSkt0a01zMnpIVjZvWTdtUllUYTViSHA2?=
 =?utf-8?B?YWVLeCtmQ3I3eC8xSFdzTGxSWmw2MmtsckFPdEtiMWhPMkgzUWVhVUhMQVVm?=
 =?utf-8?B?dHdrOEFFL3AzdVczRGgwb3h5MlF3Rk51aGpmakpVbU9yLy93RE14QjlGV0FP?=
 =?utf-8?B?ME00cDVMMk9HQjRrc0l6RjFLT0hiTzk0UU9La1VNTEdyR0xBTE5KL09Zb0ZR?=
 =?utf-8?B?ZWlwZWhVb3kvVFYzN3FjWlorU0pnd2ZOQURvTHpxRVJuQzVCM242Mzg0SDFw?=
 =?utf-8?B?WFowclQ4RVpibmxvZHdxdHlXbUhSV2R6S2oycTJYMHpHY29meTVrVktKc3JB?=
 =?utf-8?B?TmJCUUVhZ2l0Vk5tU2hFdVFwWEwrYWIrL2oxYkdXNlZHbktwUk5wT0hJU0pX?=
 =?utf-8?B?VlF6MTBHK3FVM1VLbmdocXgwNnhLWDdZbmVINXpiMmR5c3VXay94VFpBUmov?=
 =?utf-8?B?dUVSaHlONGpkaXF4bjY3THA1dGtmU0JrczhYTXVzWUJtV2M5a1NxYUU2bjMz?=
 =?utf-8?B?OHVxd3FCNmFGNDkydDZXd0FGNnNHQzFxaEJaM2JUQTRZalpwRkx1dzlPMzh6?=
 =?utf-8?B?cm0vYlBLOElETm9xUURKdVNXL2M3UkQvYmFIV3pjVUh1a1Z5WUlCemYvSkta?=
 =?utf-8?B?U2tXYzQ3TkR4NW00RnIyVWZZMlBwaXJ1SEU1YTFnYWlEZ2Y2MGU5Sk40Vksx?=
 =?utf-8?B?Sk01ZUZoejkrcHZyTTlCVW5zM1BxWjRCU3J3Nm9iN2s4dC9rZ2xzd0xZemVz?=
 =?utf-8?B?cndHaEdJN0hIMWZTQ3dlLzZ4bnFObkd3MzdvVnlqL3lqMyt1bnBtZUhGbDRn?=
 =?utf-8?B?VGI5M1diYUdHWU5PMmExbUF4NkRvdmNQK0JFdUJrb2UzU0UvcXBJWUJLcFlP?=
 =?utf-8?B?RTJWNDZKanVCVXJQSWlJZUJHb1UrYjVzUXExUVAxSTNLMVhFSFlDdzlkdC9Z?=
 =?utf-8?B?ZXVoeUV0cHdZOHV0YWZWKzRRRDVrdTdzUEtmVVpveG5DSGx5djJyamtjUEhk?=
 =?utf-8?B?bWVtMmx5dCtadkdwNGFNczluWk5MWlE5Ti9pN1BWRS9MY0lCQmJKQWRGL2RX?=
 =?utf-8?B?UnlBSkVqOWRNaWE1UThHSTIzR2tQZzFGNmVGZkYra2J0YlhCM1o0M0hsNmRu?=
 =?utf-8?B?Vjk2SWpEVXVGSk1DZGxmbFNIVWFoQkJqU3R1cjFEbkdxY005ZzloRFZrMnJY?=
 =?utf-8?B?cWU4N2cwVC94UWt1VmRsUkZMaktFU3B4MjRxcGxqNmZwSGZ2U1FnL29JZ25C?=
 =?utf-8?B?SHB3WlRKM1R4cjZwYWx4WnVyYlhnRDZXcGJ5UHI2RmNoZXRyTE52TFNpc200?=
 =?utf-8?B?OFZRS0J6SmxaRVREbEYzSzhWdjBSdmxHbk5wUHJyWDlZT3hyUmp2U0toeG9r?=
 =?utf-8?B?MWJpYXF0Q052UUJkS0lEdnMramJsU1FzNVBsNE1CQkVFY1pVczZwb0tYZ29Q?=
 =?utf-8?B?NmNCdE1vdVJUOGhmQnJ3R1BUbWREWXBOMGxWRmJFLzJZdmJtRFVkV1h2bXlP?=
 =?utf-8?B?bjV0d0Z0WEJ4a1BEdnllODgyNTFCUFRtazNnc2JqcC9iMTMrR1QzVmZBc2lB?=
 =?utf-8?B?UVdjVEJwbFl1QlJPSzUrWjJiUVp1QVllVXZCbmordVM5TTRyNG1OWTc3Z2JW?=
 =?utf-8?B?bHMyanlCTkIwamNiVFY0cHd0MnRuY2FvZURqdXdRbVUwQ0dFOWxyL0pPVjI5?=
 =?utf-8?B?QkZTSE42aC9MZ0t1UElwYnlDUXFJNUsyVnRqVEFNdU5QeGxKNUIxS3YySjl3?=
 =?utf-8?B?MHJSS25DajRoQklwTER4L1JzWlIzaEJoNktBUWJZdFU1S3F4a2tXY0hub3k0?=
 =?utf-8?B?eVlLbEhJK1I3bThMdWVNMGc4c0J0SlhnWFRXVmVNWGEzTGVrdko3OGRoNnNs?=
 =?utf-8?B?bTU0VndXaFFYSHZjSlJRRU5KcWdFV1o2VTlVY1crWHEvS25UL1labEwxMEIy?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54c1ad4-486d-44d3-c62f-08ddf1b9db8f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:04:31.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7O+JR80ze9fOsDnqOG9Az2N9kOVdIun4dnlnnpbEZ1MVQVN8wWPL8sM2nk6RWM+H3bPaig1tlEShvscsOSaxrj4v2gr8WnjwzFYwO4Ov4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5127

Hi Jakub,

Thanks for reviewing the patch.

On 9/12/2025 5:31 AM, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 18:12:16 +0530 G Thomas, Rohan wrote:
>> On 9/11/2025 4:54 PM, Russell King (Oracle) wrote:
>>> On Thu, Sep 11, 2025 at 04:22:59PM +0800, Rohan G Thomas via B4 Relay wrote:
>>>> @@ -1012,7 +1012,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>>>>    		s64 delta_ns = qopt->entries[i].interval;
>>>>    		u32 gates = qopt->entries[i].gate_mask;
>>>>    
>>>> -		if (delta_ns > GENMASK(wid, 0))
>>>> +		if (delta_ns >= BIT(wid))
>>>
>>> While I agree this makes it look better, you don't change the version
>>> below, which makes the code inconsistent. I also don't see anything
>>> wrong with the original comparison.
>>
>> Just to clarify the intent behind this change:
>> For example, if wid = 3, then GENMASK(3, 0) = 0b1111 = 15. But the
>> maximum supported gate interval in this case is actually 7, since only 3
>> bits are available to represent the value. So in the patch, the
>> condition delta_ns >= BIT(wid) effectively checks if delta_ns is 8 or
>> more, which correctly returns an error for values that exceed the 3-bit
>> limit.
> 
> Comparison to BIT() looks rather odd, I think it's better to correct
> the GENMASK() bound?

Sure I'll update the condition to use GENMASK(wid - 1, 0) in the next
version. That should make the logic consistent with the checks below.

Best Regards,
Rohan

