Return-Path: <netdev+bounces-111095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1796B92FD38
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE681F21461
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192F172BB2;
	Fri, 12 Jul 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gerPxFfY"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B31094E;
	Fri, 12 Jul 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797059; cv=fail; b=JRCbeBsn0QUQtL4GBZntxj1W3OuUUykBOUY5FmdtHidOs5osgQsL0/TXt7jlzFpNDipb9FDmAw3PvldH2tIIx3Mz1DsxDssl3PKgCxWHqVh+F388V+F08WLVV+GKOLfjeV7poQgynemXi+s+Xa4N7RuDFT3fv9WLHYgx9U1MfPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797059; c=relaxed/simple;
	bh=yiKq+00B/XzgTJ0k4PJk5y3gz1jD/oZnJKGUydXOtlI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ORElI+iY8hcaMPWw+7ehjQsQyNjex19Dk/QXbz+//rzwS1APLLsayuHOvaS0WnG8qiGtZ7H2MYK1rccsmVDiamX2c7nbMOhxI2ub5XoQh1txS6I8St0ZOCaDJsPMKfnR9T/QsTazcP9lKeGLSNic2KgJ9WZ4hTOdgmtbP8wUb9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gerPxFfY; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wc6ztpfCvpyXlI+3MYqOZ8EAAUwbokglF8VCV3pq/w48t5dCxaOLnuhQxN7zy68hPupubAEok003XKcrx+y2EvMURTLQSETJ4SrII284XVztz3SYI40oMNdInyVWNI1ByeW0Z+khi5uCZhqxruOKZi7ChD40uvl02SNPxlPivAOwNAus+O+m2tO4HNe77vDQSEeTnGgy/xB5ZEnE5IHa6Koti8bRT4ypQZuHloetNijWlmifVDwCkHcPNoQTle/dcj0zot1kWwEsFVLOaX/qGCIingG1n6wYxjFwK9z5To8JJUgtVoksnQF8Rau7yZAAhA3rQ69KrV6yWimpNks8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9JwuK3UINa45vbuP4WQZEeDZX53LUtt+rynSgtZTvs=;
 b=pPqMFN0l3KiIBSFq9TiltROgx+4HgEl63F/htWO79wb/z2HgFlPlPr7touzC4LZUFIFgoFuXz/PWeooQMj1paClP1yp12hlFlXPD/4WGpdaS/Wkc3oZBTDow1LLjBQ9xx7Sl7FQh6Yrylz1ovhtB0kJ5dE7e+waGmYTe6BDCkZjh3jW9jrPoKe9y6O4ZJa4l2ksXoNwlQUKHIWV42SYlvFlpo3aAYbvr3OqPf9bWrcfV6mbwkbPsSOjmZVMKgwHKzt6CiT5kTvJgH6Y3ZaRtqQg3ahi0N5DfKsTeNk9hHtI06sQ18wi/RRUUkvhiAOJcFlpGlY7Jzd9o9L+pGssh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9JwuK3UINa45vbuP4WQZEeDZX53LUtt+rynSgtZTvs=;
 b=gerPxFfY2SjiY7tDXYw1sayCsiHo0jY1yyIUqjgJOXZjVvC4xqyAWwDEcIqSsG12EwW/+QK3Tj329YuL6A67qxKkDlVU8teQrjWIfuqaMgf84qnadJVnzni9PAh0daqjlk5wxALLnKXrM8Zeq6KfP7n/WG5mrnEXmp3RclI7sYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by VI0PR02MB10730.eurprd02.prod.outlook.com (2603:10a6:800:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 15:10:51 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 15:10:51 +0000
Message-ID: <bc1ce748-7620-45b0-b1ad-17d77f6d6331@axis.com>
Date: Fri, 12 Jul 2024 17:10:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
To: Andrew Lunn <andrew@lunn.ch>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240708102716.1246571-1-kamilh@axis.com>
 <20240708102716.1246571-5-kamilh@axis.com>
 <885eec03-b4d0-4bd1-869f-c334bb22888c@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
In-Reply-To: <885eec03-b4d0-4bd1-869f-c334bb22888c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|VI0PR02MB10730:EE_
X-MS-Office365-Filtering-Correlation-Id: c772e7e3-438e-4876-656c-08dca284d125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBYN2lOdzBLQTIxanZnVElWV05oVEkwYXk1WWJZbS9nZHBhMWFxd1VBRWNz?=
 =?utf-8?B?MXdBQTBiYTV5WEpYTDVZNkwxMnpLa2YzTFdteTVxSEVJZUI4UUs3QkhIbGpa?=
 =?utf-8?B?SVMzSU5yMnBRc2xCdytIZHZ1azFOOG1NU0p0QWRpdmlIam5CREZzVXJ4ZHB4?=
 =?utf-8?B?ODVFdVR3WDJ0UFF2K0RLTGtTTDF0Nk1VM285Ni81MmVJZG4yNlVsOU1vbjhk?=
 =?utf-8?B?T1ErNmd5WEEzK0FpZUZZdktHYy9nN2c2bWZPbFZiYXRzamJnQXFCWGxhK0Rs?=
 =?utf-8?B?MFhHcGVmYWgyVy92eDZsS1lTQVRmdWRlMVlnOGFBdE5tbzA4NjlSTm9SLy9o?=
 =?utf-8?B?VnJiTGVnaGNEVHhtNHpOOE9uNXh6c0hoQ29uZUIxK251enBoQ3JhYWxmL2RO?=
 =?utf-8?B?T29CMmFpZy94WTVIS052Vk16T1hlL1phLzIwRi9TOWhIcko4MzdQc1kwNVdH?=
 =?utf-8?B?S2t6TW5nWXpwczhYSWNlZnh3cnk4dVI5Mms2TjI5d0JUemhOdlYvUnJDb2Fk?=
 =?utf-8?B?S3hxQm1PU2had0dTeGZqWWhLSy91UmFpVnNFV3R2S2EySE1meWZ5VE56MEps?=
 =?utf-8?B?NXdLZGxLcjRURWRySVpMdHkraElqRFZOZE5NYWRvOXRPVmRlQlRLeElYQ3VT?=
 =?utf-8?B?amtRcHoyemp5bC93WVFZbEZ1VnB1cExqdzFSQkRDYVZnYk9pZHhtNTdKL2N5?=
 =?utf-8?B?UXhUNjRLaTEwenVYdXZ1VVYxZnE4eitTQmNoejkyZ0RVRnN2YTJVNkpLNW1B?=
 =?utf-8?B?bjJMSlNWRFFnaEdhczAxNGpjZGZNcFloYVJjSTdJNVZwdnJrS1hlR1V3bHVk?=
 =?utf-8?B?TGlyK2VDbGtjUW5EdEVUdk45REI1bkJUcHNoRlRaSWk1R2k5YkhwSU1FZEdZ?=
 =?utf-8?B?T1FrL3VJWVJqcmNVWlYxRTdkdnNWNmJGU1plR2lYZllsS0FROUkrZmp4bFE4?=
 =?utf-8?B?VU42Uy9nckRzUlkxdFlueWFoN1JXek9ERE8vYzRtMEdjWmZoRzVIMEJKSkNw?=
 =?utf-8?B?b0xuRjQyWGJVc0krSDZTWlhMZEJGRWY5YVErMUpqLzBPelNKeTR5cGhwVWdw?=
 =?utf-8?B?eWdwRm5ldU5uMEJ1KzRZUHZhanllZlVzdi9pcFRFQmZ6OHFUWVlQS0xzSktS?=
 =?utf-8?B?WHc0eEZ1REgrZlZoVjhmcGNFVTNyR01BVWZ0QUE0c1M1SmhmZHhSR1l6bkQ0?=
 =?utf-8?B?b21UZWVVOENRc01SV1dMOHhRRkVrRmE3dVZhS3ZSaVZzZU5vclJYQzYwZkRL?=
 =?utf-8?B?OFVUMHozbUtPZUIzUnpSeUJLaG1TRWtMNG1QcWh2ZDJoTU0wdlBramowanQ4?=
 =?utf-8?B?WGRTcmRMeGw0c3Z6VVh5dS9HaWlUa3VKdjZveXMyQmpVQk9wWXlCTW1pMDlq?=
 =?utf-8?B?czJuNHA1U2xNanArVDFwL29qa20yQ1dNRUtEbFhCb2JsWTB6OHovVENyalAy?=
 =?utf-8?B?M0NmWGMyclE5czFaZXozQ2greml5eEFXQlRKc0tJN1hTLzJCL1pEamxJYzdP?=
 =?utf-8?B?b1dHMk1hOEUxdGVsNnpTZ0NEN1ZFa3NDdk8ySXFMMU5vYzRRcm1oZjRJcnB2?=
 =?utf-8?B?eFhJVzlWcFlvWkZpaWw4cDQ2eG9WVVZhaWlmY0xCc3AraGpTWW5sWUc5WSt5?=
 =?utf-8?B?NHBHODlWNVB0cDFIUFUrbjkrL2xNWE83Nnhkd3FOOWRMMWFHWE0rMnRhZFpa?=
 =?utf-8?B?U3lNWTFpKzhBVGtWSlBpbGJZVWVxODNGSWRzaGEybmN6dzc0NVdCQ3VJUGta?=
 =?utf-8?B?WlRhNGcrQVFNeStvcUVtVjNwQm1xSDU5bnhMUDd5NXRUUC94dU5SbXk5T1Y2?=
 =?utf-8?B?SmdpL05VQXNIUmNRVDdidz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0lRQzUvS2lCTUZyZExiWWVZZWhqNVFmN2thTzhIbnVoQjJoUUxDdkpJYnlT?=
 =?utf-8?B?VUQxUXcrV3ZtMWFvV3h3eHdjQlErOStmekFITThIZDBvUlFlL0JXSktGeE5D?=
 =?utf-8?B?UG5iOVpib21TSlhKNVpUem9qTzh2T0pvYXkwVnVXUTFxYzVsWUJvOC9XZ1Y3?=
 =?utf-8?B?eTB0WmlRT0dCMjBhRUh4SFNSMWZSL0NCMm5QUXR4TUZQU0prU2ZtYjREcy9n?=
 =?utf-8?B?TlBMZ0pkcHZZbnlUWDRIcEhUSHF0UFAxWm0raDlOODFqZ0xGT0MyYjd1a1A1?=
 =?utf-8?B?VUlaS0ZPd21aT05rdHAxVGtpeFM2ZStZdDk0Tkt4MlBUTGdybHRIOXl0b2Fi?=
 =?utf-8?B?OHBoOVJMNHNyQlQwY1M4dUlQMWhmcTJMSFJvYjZiN2Q3UXNWaHllMGhBMWll?=
 =?utf-8?B?VVNEZkxTdzREOEMzZ0ZjNTNTNHZIa0N2ZWtsMVFoK1kwWm1zM1RtYWNxcUM5?=
 =?utf-8?B?N2oyTmVZcFBlOFBNVGpMdWR3RjE5K1NQS0ZjRy9uVnh5citiYVNmNVhiOUFP?=
 =?utf-8?B?S3cwMFBxOW5YWm1taWxpaldEODNzeTJTTlBiSC9PVGQ0aG1vUXlrWm9SMC8w?=
 =?utf-8?B?SDZlVmVuR1R0K0pBY1VEMXZzbXdweEhaK2pab0M4ekZ6b3NFVkt0UmJmWnly?=
 =?utf-8?B?S0U2NTVXVjlDRjQzRFptcWJSLzNraWQrT24xVjhvTE1wbGRRcUFmSk5JcmY3?=
 =?utf-8?B?ZzI4cnVWdVpFcTY3bk5IVjJqTUNQYlFYbkc1MXZBM216ZmRvOCtqaGxqTDE1?=
 =?utf-8?B?ZnNtODdkbmlJd2NvbkRKTVYyMmNZc0VBUkp1MDRjZGNNRDhuL1hSazhmZ0pF?=
 =?utf-8?B?QnZTWGxXTTZsanJrSHVDNlFPcWp2TG5nQzZ5Q3hPZ1N4TFJDNzZzeEhsR3RB?=
 =?utf-8?B?Y25hbXBKdHcyS1ViQTZXUGxBYnpLQitKeE5NZElNcjBUUGF0dk4rQ05rTGp0?=
 =?utf-8?B?NGw5cC9VRE5MQkVQT3ZnN28wWGZUaG1zZlVJTWVsUkVoa2N4T2F3MjJLZjZG?=
 =?utf-8?B?TlRDMDBkcGFtSXZLYW1WL05VSkxrQlBiNmxCYlF0dzJrZ2FEcGk0THJhdW0y?=
 =?utf-8?B?Lzh6aHphNnhLT0xjSi94eHZveU00dlhTV1dOSzh2M1lLdVNlbWl1T3VMWkI5?=
 =?utf-8?B?Q1A5VXZVWW9wK2gwOEtVN0lmd1k1SldIL1BuTTUzeVNiVlpDS2phdnp1azFn?=
 =?utf-8?B?U3NGc2ZyZ0NSRFJDWVFZRDNISVo5TFRtTTlvQWpJa0VvamphT3VuL3dOSkpx?=
 =?utf-8?B?UW5QbjZOeDFtUU5WeFdwcjl3RDd5N2syc3UvY1BFbHdKazlOVkJTZVVPempQ?=
 =?utf-8?B?bWVNd2NwWG1LZTlUaE9YZUpxUFVZay9WcG50aXdRNklVSTE3NnJVYytvRzVl?=
 =?utf-8?B?NkpWaS9HbmFQbFFpb2hYUzBaSnVTM25vRGhtNjQ4cWRTL3J4ZUtwYm9kN0FB?=
 =?utf-8?B?dDB4Q3RJa1lGVVZIOTNvZnFsQzZsTEZ0MjlUK0lXSmc0ZTRtYjJvZWR3NDhW?=
 =?utf-8?B?bDN5eEI0V3N0UExieGpBMjdxWXczb1BiNEFEYzZYQjZjWkhwcWZQc2dKancx?=
 =?utf-8?B?K1hsbGp5TFlBTCttK3orejNQS0NaRnRqMlEzaUs2d3ZWQVN2Y21pSWV1QmtE?=
 =?utf-8?B?SHZPZVdJQnFuakU4cm53TTV2a0RaZFArb0xDNitSMXpMUDVjMDdiOERRVlFI?=
 =?utf-8?B?RlNVQkdOeFB1OER5VU1kMnhrN3lOL0VySXhyK2NwQjJxNzNpM3pWeTRONTRN?=
 =?utf-8?B?ZWVINkc5V3RaRzY5T1B2Y0NVL1RQSk1vM1hmajY0THFYcGErbkJPRi9oWENR?=
 =?utf-8?B?b2hyUGhtVDk4cGJkakd5ZkNhYTd3cTZBVDZGRzNaeGMxSDBUYXZOU1NxSmFS?=
 =?utf-8?B?SER3dnhmakgvTENFMDBWVjFWV0xPWHhkcTllaFRTMUs3ZGh1V3JsR2ZjdnFL?=
 =?utf-8?B?Sm53TGRsc2g1bHdTS1NIOXV3V1ladUNGZDJ4ZWJhU3ArcGVwQ0ZqdDYxQ3lH?=
 =?utf-8?B?OVFZakpzS3BPSk9pVkxWVUZsZ0pFMFVGQ3g4eEpoM3NVcGNCaUdmSjQvVVFs?=
 =?utf-8?B?RFpQZjA3cmJjejlFdklIT0hLOHR4cEk4NXg2YURsT0VqQTZHSklqc3NIRHZB?=
 =?utf-8?Q?bvrOZCdNIlIBR3XbuGnD0RQKo?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c772e7e3-438e-4876-656c-08dca284d125
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:10:50.9496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUNOo0elNj5nbtyMj24OQE5DlgBJPwgbocTbSpQAanbSioAMFpQmmHTJmxupfzMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10730


On 7/11/24 21:01, Andrew Lunn wrote:
>> +static int bcm5481x_get_brrmode(struct phy_device *phydev, u8 *data)
>>   {
>> -	int err, reg;
>> +	int reg;
>>   
>> -	/* Disable BroadR-Reach function. */
>>   	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
>> -	reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
>> -	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
>> -				reg);
>> -	if (err < 0)
> bcm_phy_read_exp() could fail. So you should keep the test. Also, the
> caller of this function does look at the return value.
True - it can at least return -EOPNOTSUPP from __mdiobus_read()
Trying to handle it.

This neglect can be found elsewhere such as bcm-phy-ptp.c  and eg. 
bcm54xx_config_init()

function. I feel that at least the latest one should be fixed but it 
would be unrelated to bcm54811,

so leaving it as-is for now.

>
>> +/**
>> + * bcm5481x_read_abilities - read PHY abilities from LRESR or Clause 22
>> + * (BMSR) registers, based on whether the PHY is in BroadR-Reach or IEEE mode
>> + * @phydev: target phy_device struct
>> + *
>> + * Description: Reads the PHY's abilities and populates
>> + * phydev->supported accordingly. The register to read the abilities from is
>> + * determined by current brr mode setting of the PHY.
>> + * Note that the LRE and IEEE sets of abilities are disjunct.
>> + *
>> + * Returns: 0 on success, < 0 on failure
>> + */
>> +static int bcm5481x_read_abilities(struct phy_device *phydev)
>> +{
>> +	int i, val, err;
>> +	u8 brr_mode;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
>> +		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
>> +
>> +	err = bcm5481x_get_brrmode(phydev, &brr_mode);
>> +static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
>> +{
>> +	int reg;
>> +	int err;
>> +	u16 val;
>> +
>> +	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
>> +
>> +	if (on)
>> +		reg |= BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
>> +	else
>> +		reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
>> +
>> +static int bcm54811_config_init(struct phy_device *phydev)
>> +{
>> +	struct device_node *np = phydev->mdio.dev.of_node;
>> +	bool brr = false;
>> +	int err, reg;
>> +
>>   	err = bcm54xx_config_init(phydev);
>>   
>>   	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
>> @@ -576,29 +687,80 @@ static int bcm54811_config_init(struct phy_device *phydev)
>>   			return err;
>>   	}
>>   
>> -	return err;
>> +	/* Configure BroadR-Reach function. */
>> +	brr = of_property_read_bool(np, "brr-mode");
>> +
>> +	/* With BCM54811, BroadR-Reach implies no autoneg */
>> +	if (brr)
>> +		phydev->autoneg = 0;
>> +
>> +	return bcm5481x_set_brrmode(phydev, brr);
>>   }
> The ordering seems a bit strange here.
>
> phy_probe() will call phydrv->get_features. At this point, the PHY is
> in whatever mode it resets to, or maybe what it is strapped
> to. phydev->supported could thus be set to standard IEEE modes,
> despite the board design is actually for BroadR-Reach.
>
> Sometime later, when the MAC is connected to the PHY config_init() is
> called. At that point, you poke around in DT and find how the PHY is
> connected to the cable. At that point, you set the PHY mode, and
> change phydev->supported to reflect reality.
>
> I really think that reading DT should be done much earlier, maybe in
> the driver probe function, or maybe get_features. get_features should
> always return the correct values from the board.

Also true. This is a remnant of original approach using phy-tunable 
rather than dt to select the mode.

I do not expect a hot swappable design to be possible to appear, so 
fixing the logic as suggested.

>
>> +static int bcm5481_config_aneg(struct phy_device *phydev)
>> +{
>> +	u8 brr_mode;
>> +	int ret;
>> +
>> +	ret = bcm5481x_get_brrmode(phydev, &brr_mode);
> Rather than read it from the hardware every single time, could you
> store the DT value in bcm54xx_phy_priv ?

Done. Now we rely on the DT setting and never read the PHY state. It is 
vulnerable to external manipulation

of MDIO registers and PHY reset as both hardware and software (bit 15 of 
register 0 in both

IEEE and LRE modes) reset switch to IEEE mode.

>
>> +/* Read LDS Link Partner Ability in BroadR-Reach mode */
>> +static int bcm_read_lpa(struct phy_device *phydev)
> This function seems to be missing an lds or lre prefix.
>
>> +static int bcm_read_status_fixed(struct phy_device *phydev)
> and here. Please make sure the naming is consistent. Anything which
> only accesses lre or lds registers should make that clear in its name.

I feel this requires renaming stuff like bcm_read_status_fixed to 
lre_read_status_fixed etc. in every location

only handling LRE stuff, same logic already applied to eg. lre_update_link.

>
>> +static int bcm54811_read_status(struct phy_device *phydev)
>> +{
>> +	u8 brr_mode;
>> +	int err;
>> +
>> +	err = bcm5481x_get_brrmode(phydev, &brr_mode);
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	if (brr_mode) {
>> +		/* Get the status in BroadRReach mode just like
>> +		 *   genphy_read_status does in normal mode
>> +		 */
>> +
>> +		int err, old_link = phydev->link;
>> +
>> +		/* Update the link, but return if there was an error */
>> +
>> +		err = lre_update_link(phydev);
>> +		if (err)
>> +			return err;
>> +
>> +		/* why bother the PHY if nothing can have changed */
>> +		if (phydev->autoneg ==
>> +		    AUTONEG_ENABLE && old_link && phydev->link)
>> +			return 0;
>> +
>> +		phydev->speed = SPEED_UNKNOWN;
>> +		phydev->duplex = DUPLEX_UNKNOWN;
>> +		phydev->pause = 0;
>> +		phydev->asym_pause = 0;
>> +
>> +		err = bcm_read_master_slave(phydev);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		/* Read LDS Link Partner Ability */
>> +		err = bcm_read_lpa(phydev);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		if (phydev->autoneg ==
>> +		    AUTONEG_ENABLE && phydev->autoneg_complete) {
>> +			phy_resolve_aneg_linkmode(phydev);
>> +		} else if (phydev->autoneg == AUTONEG_DISABLE) {
>> +			err = bcm_read_status_fixed(phydev);
>> +			if (err < 0)
>> +				return err;
>> +		}
> This would probably look better if you pulled this code out into a
> helper bcm54811_lre_read_status().
done

I've of course verified again that it works on the target device but 
unfortunately, I have no possibility

to test it on anything using BCM54811 in IEEE mode and with BCM54810 
which might be interesting for

someone using that PHY.


Kamil


>
>      Andrew
>
> ---
> pw-bot: cr

