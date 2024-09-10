Return-Path: <netdev+bounces-126771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010997269D
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 03:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE2D285B41
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2554204B;
	Tue, 10 Sep 2024 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TfUIVb+B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612737165;
	Tue, 10 Sep 2024 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725931949; cv=fail; b=R4XiXpT46D3RtjXb/u4ed7WwnTpFDjS8+TNXGAww1lMhpO7pzw01sDbotq2/8QKBBqMC27yNfPIiJYwJontif+It5umiHZLqslCfv9yVKnZ8FbvEKNDkTMrmOjJFI+aYMHQzcYyt96L8ypK7ATJAfu0a1LN24kUjv0vMLDE7EQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725931949; c=relaxed/simple;
	bh=Vv2jDaWEUhIzPqKoI81CyQ9iwpgLkqwggKqiTAtuNrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e189woo/gWlJKoiazGdwySD1uOQ2WwbgBU1gps3hMLCH3zxUC4YCeb6emDug1Qx5iLajKohLalj+t3sMOK6reO+X27gUAZzybBNjLCrPyaYi6K5v8Mhq9OenSUeHiUe3/0wZIKxpmi2WiCg3PDY+P0e7Qt5NQODeKx32vuxRvK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TfUIVb+B; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+3/3P2Rx0iKXaHR7uma4j2imZcWd2Xq0jiVoSHWZuFOicwfQ2mwUWThpLM7qyhleDZdayggGjXziQPXLYg+ntNLVer7bbyD2Je6y1AjC9ic0bMAHdZBOznHmGf6WxhiBxTCyD0gigxxaCFmNKYXAFDVYtDN2qd0VY4DJpJBtpvI/BgRTY96myUCEJiveJiTWSfiNIa0aSsaRSkOxVGqEH/jKWQKMe1AksS+Qr+qWn1E3sZVQfSoNh+G/yOs1zcbSqWgcz6DUBqyMQgRQ0pJA1lPyRiRN/hkB8tm7O7jgM6CaBJ12D7e8IiA7iXHV1KFYrMrj/Oix9xAP6Z7ce4Czw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIC49C6T+Coc1tuQOqiUQ0zwHk0pzeErEdLCgBqrxsk=;
 b=dbSXCYGXklGdAIq4NJusAEb0tktONPN/yC2NRpOHEoEisbMIUGlH6aNd96M8h99D0xZ0F29khku/t61RvVZVWRgKNgW8h5i6tLuspgT9ZYdSYlhczL7U+wc6QtoWOEn3GlZi2VSCyjFKOtqUM+sES5UIR41/NHrg//1J61fy4OUAbyHmmakFUOjTTkQmZVy+7SrGnB+MEzHRmdZyIaJr2FyNLS18x8yGxJwFo5gFTZQmnjPCf0mv9dJris1uUs82wq4h6OiVjR/8UZxaLrPXsnvVWM8KSsnAiVtQzfNWz8ffrmFA86sHNqt8FKab3h6pa5G03HXzwI0GdYv32BqcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIC49C6T+Coc1tuQOqiUQ0zwHk0pzeErEdLCgBqrxsk=;
 b=TfUIVb+Bo67gMnAj5B2oSuv4Cm+8XzBsJqVPEnZf5tSxaT0Tzo09gPt8snJ9/Uo1QiUmDuHOTDk3Y1QA2TwMP4p0WUS0pH92hk5HYHs/Iq2wGCg/jKuJweHglXWuaWdF+Iip/fl91vUTRwOV4d6cMq7AJkgn6Sw9fGo1+kjq1to=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 10 Sep 2024 01:32:24 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 01:32:24 +0000
Message-ID: <491180c3-680d-41cf-a799-d1099542882c@amd.com>
Date: Mon, 9 Sep 2024 18:32:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 3/6] net: xilinx: axienet: Combine CR
 calculation
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
 <20240909235208.1331065-4-sean.anderson@linux.dev>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240909235208.1331065-4-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 59427ccb-74f9-49d5-a8d7-08dcd1386c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm5QRlpPSWVqeFV6SXVSSzFMRmwrd3VuZTNYWHdZOHJBM3NsZ3NCV0pUMjVq?=
 =?utf-8?B?cU5rdkxJVU9xZ1dzblNrUzlQRHkxVnRqWitXK3pOczRuQWdRYzVGeDFOZXlt?=
 =?utf-8?B?eUE3bFc2OWpyQ0kybWU0N1FhVS9SZGlYS21SeDNjKzJaQ2hCT010VGVXQWpV?=
 =?utf-8?B?OWNVb2hhYlBZcHcxL1crKzJ4THhzQms5M0IyNU9obFVYeHRwYXVUVVRlMndo?=
 =?utf-8?B?NWhYMStQVFFTSUloLy9ldnlXQWNicU1KMW1JZXdNQUhGbWl1ZXR5Y1hGMVl2?=
 =?utf-8?B?MSthMWtYOTJPTGt3UnFWaUR0S3EyL1BKT0JVM2JoVlhKYnFZV0VjVkR3SW1h?=
 =?utf-8?B?MDVZTkE4Z2JRZzkraVdkcUpiNUVqMW9VV3AyVUt4d2toMTVzMDhrNldIcnVG?=
 =?utf-8?B?NkZ5ZG1NRzQwT2FZYi8wZmkyQUNtMnZIaXNNZ2owOU5FZXE1TU9VdTNON0xI?=
 =?utf-8?B?dllQZ2tvTFIwMGFJZ29lZHR5ejhzdjZJYkpSR3RzZUhjT1Q2R3VURGQzbEM0?=
 =?utf-8?B?VXV4anNwS2tVakZ4Tm1NK0FQYTNDcllpYW5ib1hZZnRiSFpoczd5Z2U4SUdj?=
 =?utf-8?B?OHJsOUtTN1ZuSlo0RW1nYTZOOU5kWXZ6TW82V1FlNmllM1llcmRBZEtxTjEy?=
 =?utf-8?B?NEJXRE9XcTBmZXNpNnBqUU5kdWdrd3F4elp6akRKZEtpZFJadEpybkNHcHdE?=
 =?utf-8?B?TVZrbFFvejBSMElDZ2pWUk5MTEpncXFUSTN6MjhTempQSnlqbE1ybThmZHF2?=
 =?utf-8?B?UHl3YlVqOTIrL0hOS2pqMDhGREw4UVpKQ0J4OUVJTll2NmlNb05jWCtmWnlQ?=
 =?utf-8?B?Mis0SWJPcG5JQzEySXg4TmNYRy9kSGMvL1NuMmx6N0RQTU41RmE1bU9SZkdq?=
 =?utf-8?B?cmdvc05sM0MvL1ZVdGRIVlc3RXlIeWhkZW1rYmlFYlAzdUtXZ0Y3d08wbWdr?=
 =?utf-8?B?YWpRUjFXVlA0aC9RTmZlUWNNdEFOUmgvZHl4NUxIMnNQME9pOFJmdlRLZ0ZS?=
 =?utf-8?B?TEpOcmR3R2IyQWpRbXUwTG43dUg2cE5OU1c5cHBYc0NHb2VpWXlUMUYwRzhs?=
 =?utf-8?B?NGR0ZkZ5VmROcWxrMUFPRllqQVhBNkVubVVMeWszZUc3Q0pFQnJyc3E5Y0dR?=
 =?utf-8?B?dzRjWE9OSi9LWEFPQW9oNlZDRnhqR3YvUVBxTS82dUozMFIyWFBTN0VEczgr?=
 =?utf-8?B?RHVObWMxMHdIaDhBK3lZTklDU3FDakU3R213WXZjQWMzRllLVGRoamZWSmdM?=
 =?utf-8?B?TlZrWGcxZTc4UDVGL3N6dzd3Y0xqZjQzb3lQMktTQTBMOHlVMmM3Wk01UUN1?=
 =?utf-8?B?RG8wLy8zdXVvYjBNdEFCd2trMmtLQVNEZHhKM0wzUDc5VE41V3R4MGEvTFE5?=
 =?utf-8?B?M2haMjEvcURGT1BHWDZWNWJUWEhyc0Y3engwa1RxTDRHUW1haHFXWVhjcjQy?=
 =?utf-8?B?YkFzU2l4REZMK0RJeFFTRHZ3S1FRQ0VQVDh6Z0dNSXFmSWlBbkM2MkVpUmxu?=
 =?utf-8?B?WWlTL0czVHBLNFdDTG5EalExOFNPaWtic3U1NFhOYzJOV1RTQ2t2Mk5IcWJI?=
 =?utf-8?B?aGxEb1VUQWNhLy9DRGFJVDhIbCtWZkw1eStzdjZRYnEwbEhBdzMwT04yV1R1?=
 =?utf-8?B?OG5LMG9KOVE2NmZDcEFQUEw0ekZiYnB4bzlYdjVUdW1OV0ZXaVVndVk1eGhk?=
 =?utf-8?B?UkpYdm9rajNPNGJQM0VnK3A3RFpRam02RCs4ZXh3TURxMFNPRnl1MDhMMFdt?=
 =?utf-8?B?UlArUE0wbjM1a2w2cEJ1cEJOek1SdGVzNy9SdldtZDJBMHpWb2tQS0doY2ZS?=
 =?utf-8?B?ZjRkUjVTUGEzVWs4MlJ2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlFZWHhCaTRPRlRtS0ZQWFhMZzNNOTRKdVB0cHJnbDhvYzhUNWVJRGFXTk1J?=
 =?utf-8?B?b2pGcU81WkVncnNxVDdvVjRRQ3B2RHFUSE91Tjd2YjZvTlFEcUZYLzRSSGJQ?=
 =?utf-8?B?ZU5YTEU0MTlQM0lGajJkR3VCL0VrNWVmTVc2Zy81S2JLak81WnFSS1VjcUty?=
 =?utf-8?B?L3JQcGVlODJjbm02UUVJdERBSzV4NmNsWnJKNkF2aExqR3F5QXFkWk10QzNY?=
 =?utf-8?B?NnFmcHE2SGZMY0N2K1piRXhuWEwwR1p1eDM2VTZtRE1OWW1heFJzTFd5SGRF?=
 =?utf-8?B?YWxoWXM2ODR5OEhrM1pGZ0NIVUg5SGJldERJSnYybmwxLy9RQXloRGRpTWRW?=
 =?utf-8?B?amRIN0E5MkYwaW5SK1hNaG9OT0h0em5jU0RzODk4aEZwRFlBRVd0OVlqRm5C?=
 =?utf-8?B?ak0vWlRvWnc3L1lyWlBzSkVUUXlCbDBnNjIwL0lnTDNuRGkyWFZOd3M4a3hX?=
 =?utf-8?B?MTBKWEk0K3lvR0hpSkt0MnE2Y3R6Nnp2dXRLd3pLaWxXVnExYmFURWd4anFV?=
 =?utf-8?B?Y09jUWNkd3duM1VaZ0s4V1FLMG1xcGZqbDRMeUVHZldxUUJUSE1FSXZGUXRP?=
 =?utf-8?B?YytPTWUyRGpwUUpjc3hHNlM5ZzdIM0pkc3lJR0J2U3V1Um9QWmhqeGpOMFRY?=
 =?utf-8?B?K015RWhqMFpxWEF6TS9jekNpaHQ0QnFuMnZTV3FIY1doUUdMcERsbXZtSkVN?=
 =?utf-8?B?Nk9kVHo5UUFLbURwUWpYS2M5Y05hbXg2TlR3ZCtnZklpNzMzZ3lBanltL2di?=
 =?utf-8?B?bjlDOUNJdk00SGVLbWZidnMyYXB3Q28vR3l3amgrRWY1NTZmZGc0WmhNcVhD?=
 =?utf-8?B?V29FNTJhN1ROTkhaZUQ3dXVBMWJoazhOaDExdy8wUkFsaXZVR3NlVjYvdE9t?=
 =?utf-8?B?T3JId1k4T2I5WWQzMWFqM1lQV1N2Smg3OU5ndExwU2VqSjNVYTNiNVUzNDAw?=
 =?utf-8?B?eTFocHdDZnhtd3RBR2RFRi9VbVhXSTgyYmlZU3Y2ODVIcEd2YU1qdHBPSGZm?=
 =?utf-8?B?VUdQdWRWSi9JK0VONjliVm5xNG9YTFI5NFJkZExwbFBEMEJ6YWdtRDE3VkZu?=
 =?utf-8?B?eFIwUmpIdVRNWjV6MVU4a0pQZ1JsN3pZRlBybHc3eWJOTXcwZ2hyd0lNYnI3?=
 =?utf-8?B?M2xmemxkSWJwMnNxSnkxcmx6UVdmNGw4a1pZbUowazU4VEI1Yit1cDY1d09H?=
 =?utf-8?B?THNRUFF6enp4dXdGNFpxcXY1WkJ5ci9BclQ0YnNTcEl6eUNQMFNiOXlGL2pl?=
 =?utf-8?B?OGs5cUlwS2oyV1QwZml2d3c3ZlRQVnovWmZjVDUyTTROeGNZbXVuYzBOZjFk?=
 =?utf-8?B?SnN2Z2grLzVEaFloNjY1R1h2b1lsdXdPOHNiZk40NmN3RU5pcnNiM2RNcnBV?=
 =?utf-8?B?TDh5cWIzYXlCOUpaWkdKVE1LNmtXUXJnUU9xQmVESkM4eFI3MDYrU2ZJOCt4?=
 =?utf-8?B?Nit1ZVJVWUM3bE9xQjJ2TnhLQ0trOW5HNmdzREJNclk0YXVHMUlldHU3OG8w?=
 =?utf-8?B?ZFdsb3lNZlRDUXZHRkhXQ3dkazlkazVFcXFJRXppWnlqcWxtR1hRNGpqSmtB?=
 =?utf-8?B?ZlUyTVJRbGlTSUQ3RHJ3N2o5cXNaZlkzVEs1dUtaNEFjazUvVTM5aWVWYnVO?=
 =?utf-8?B?VmJjZmhOQWJQOVQ0K0lMOEhDYm5ncm9hN1BxTFpqckpPZFBVaG1Rbm42VlN4?=
 =?utf-8?B?bTBMUnN4WUNTSmhxeTRlakZHelJWTGxyMHJkVGpIeDhPclhQQVE0MG8wbHJt?=
 =?utf-8?B?cEVDREl5TWg0ZngrZTRWRGU4UEx0MDRISWsyb1ZCeitFeFBxazVoK1pVQjN0?=
 =?utf-8?B?NFFUNUVRKzdVMGNkT1MyeWxrS2lXWVROTGtZQXcrazdERW1RTnZHZVkwU0tE?=
 =?utf-8?B?Uk5iYUJLR3NJYmF6dk5WWlVMZmpkTktJRGdMU1pXOFJMdlpRc1YzTWNZVEY5?=
 =?utf-8?B?WXZvNlIzUHdaekhmeitjTGswTjBCNzNYa2hLek1qWVM5S25WM1FQQis4M0h3?=
 =?utf-8?B?a2tyZDViZlM3dVR3bGg3Qy8vTFBhSzBaMHc2OGd4SWNBRjJTZXNFeHNBc3Ix?=
 =?utf-8?B?dE5QNFk0d0E2a2NVN0dSeEJjeS9GQkppMXBBOUdtMklzWXAvRkppUitSakY4?=
 =?utf-8?Q?ZCMqUflZ17C9ZTnj5Sw3GU/jY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59427ccb-74f9-49d5-a8d7-08dcd1386c1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 01:32:24.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l97DTRNRraDn+rC9s+LUL3HIW3WcdqfAUL+AFv8xp2KD3MHZh3+O3T4mrjw+Uzc3zRMiDniDX4euT/SRs3DNLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

On 9/9/2024 4:52 PM, Sean Anderson wrote:
> 
> Combine the common parts of the CR calculations for better code reuse.
> While we're at it, simplify the code a bit.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Split off from runtime coalesce modification support
> 
>   drivers/net/ethernet/xilinx/xilinx_axienet.h  |  2 -
>   .../net/ethernet/xilinx/xilinx_axienet_main.c | 69 ++++++++++---------
>   2 files changed, 35 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index 5c0a21ef96a4..c43ce8f7590c 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -112,8 +112,6 @@
>   #define XAXIDMA_DELAY_MASK             ((u32)0xFF000000) /* Delay timeout counter */
>   #define XAXIDMA_COALESCE_MASK          ((u32)0x00FF0000) /* Coalesce counter */
> 
> -#define XAXIDMA_DELAY_SHIFT            24
> -
>   #define XAXIDMA_IRQ_IOC_MASK           0x00001000 /* Completion intr */
>   #define XAXIDMA_IRQ_DELAY_MASK         0x00002000 /* Delay interrupt */
>   #define XAXIDMA_IRQ_ERROR_MASK         0x00004000 /* Error interrupt */
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index bc987f7ca1ea..bff94d378b9f 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -224,22 +224,41 @@ static void axienet_dma_bd_release(struct net_device *ndev)
>   }
> 
>   /**
> - * axienet_usec_to_timer - Calculate IRQ delay timer value
> - * @lp:                Pointer to the axienet_local structure
> - * @coalesce_usec: Microseconds to convert into timer value
> + * axienet_calc_cr() - Calculate control register value
> + * @lp: Device private data
> + * @coalesce_count: Number of completions before an interrupt
> + * @coalesce_usec: Microseconds after the last completion before an interrupt

nit: The comments should match the actual parameter names
sln

> + *
> + * Calculate a control register value based on the coalescing settings. The
> + * run/stop bit is not set.
>    */
> -static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
> +static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
>   {
> -       u32 result;
> -       u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
> +       u32 cr;
> 
> -       if (lp->axi_clk)
> -               clk_rate = clk_get_rate(lp->axi_clk);
> +       count = min(count, FIELD_MAX(XAXIDMA_COALESCE_MASK));
> +       cr = FIELD_PREP(XAXIDMA_COALESCE_MASK, count) | XAXIDMA_IRQ_IOC_MASK |
> +            XAXIDMA_IRQ_ERROR_MASK;
> +       /* Only set interrupt delay timer if not generating an interrupt on
> +        * the first packet. Otherwise leave at 0 to disable delay interrupt.
> +        */
> +       if (count > 1) {
> +               u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
> +               u32 timer;
> 
> -       /* 1 Timeout Interval = 125 * (clock period of SG clock) */
> -       result = DIV64_U64_ROUND_CLOSEST((u64)coalesce_usec * clk_rate,
> -                                        XAXIDMA_DELAY_SCALE);
> -       return min(result, FIELD_MAX(XAXIDMA_DELAY_MASK));
> +               if (lp->axi_clk)
> +                       clk_rate = clk_get_rate(lp->axi_clk);
> +
> +               /* 1 Timeout Interval = 125 * (clock period of SG clock) */
> +               timer = DIV64_U64_ROUND_CLOSEST((u64)usec * clk_rate,
> +                                               XAXIDMA_DELAY_SCALE);
> +
> +               timer = min(timer, FIELD_MAX(XAXIDMA_DELAY_MASK));
> +               cr |= FIELD_PREP(XAXIDMA_DELAY_MASK, timer) |
> +                     XAXIDMA_IRQ_DELAY_MASK;
> +       }
> +
> +       return cr;
>   }
> 
>   /**
> @@ -249,31 +268,13 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
>   static void axienet_dma_start(struct axienet_local *lp)
>   {
>          /* Start updating the Rx channel control register */
> -       lp->rx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
> -                                  min(lp->coalesce_count_rx,
> -                                      FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
> -                       XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
> -       /* Only set interrupt delay timer if not generating an interrupt on
> -        * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
> -        */
> -       if (lp->coalesce_count_rx > 1)
> -               lp->rx_dma_cr |= (axienet_usec_to_timer(lp, lp->coalesce_usec_rx)
> -                                       << XAXIDMA_DELAY_SHIFT) |
> -                                XAXIDMA_IRQ_DELAY_MASK;
> +       lp->rx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
> +                                       lp->coalesce_usec_rx);
>          axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
> 
>          /* Start updating the Tx channel control register */
> -       lp->tx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
> -                                  min(lp->coalesce_count_tx,
> -                                      FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
> -                       XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
> -       /* Only set interrupt delay timer if not generating an interrupt on
> -        * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
> -        */
> -       if (lp->coalesce_count_tx > 1)
> -               lp->tx_dma_cr |= (axienet_usec_to_timer(lp, lp->coalesce_usec_tx)
> -                                       << XAXIDMA_DELAY_SHIFT) |
> -                                XAXIDMA_IRQ_DELAY_MASK;
> +       lp->tx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
> +                                       lp->coalesce_usec_tx);
>          axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
> 
>          /* Populate the tail pointer and bring the Rx Axi DMA engine out of
> --
> 2.35.1.1320.gc452695387.dirty
> 
> 

