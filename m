Return-Path: <netdev+bounces-241557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F094C85CF4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16103B373E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2950E32827E;
	Tue, 25 Nov 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W5UyM4DM"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80118328266
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085189; cv=fail; b=Y07XpVboeEKEqLzyACeRRgQNDXM4TFSFZ6pwrhO3GYaECb1BXAJWJjdV0h8DwIxbFrkGJZ5hxWKdZOAqR18WI8aWhVp/vXfkZfakxgMCpMtxp++rRYqmxz8EEhssdgQRxguu2tDQk+GPMk/VMXPMjSVt5qZ6DE0jObkVQYIp/hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085189; c=relaxed/simple;
	bh=csg8UDIe6RYFGBQHF7b9xOIxByF7aIr0MMu7uqE9usw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qmKAqqF3qd8yCtFb7ZR/IEVaYfKxP5J22BeRCXNbtZSBAHqQ+17TaPjd4UUNx3fxlhuje+4Hmz8/ff+mP7mLu7uh4L2JFGXVcSstrJ18V9lPXvGPYbIWqfElwZWGJLqU3Fiw8il1o6dkP4tkdo0IyP2Bfytfptsq/x6c/gySE44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5UyM4DM; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZcFAcbCrWlaRIxqoxDnqQ6vm8h4v+1NZihfjBZOn3R6TZmbIltu2kHEkvcE8Yzxf9PCst2J1Z7j1gvi8gY7K9FqI3r2Qcghbo6CIC20ohji2lKNc/ziojUEyWR5Ec0UWJWZI+MssjWfZNFOSE8zzJJPZC9unSxiFbQvqQ1HYaz8FTfBGfubCRQ2iO3uVnxmpeZC2Omn6aeOcUfbCuIrF5eFSJcMfI+RcrjeVfTIx3XqH1SIBsmZkphpHLxFL9MQX+mz4FZpu5lYF+Qqow5HtKibmGjvbKPizM1x98dYUFFq71vFgzHTlaMLxiCipGLcgP0wdamz2a4TApD2E9SO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwysOpNyFXTaSrRMBlvd680tAI3TM+TDg9rkTkOGipg=;
 b=r2eRgcQi4wyz98Qv5W/4cFz6/+DSCyNOpL214Vs/xd8R7ciU+NjELDV0Dcxl32kcpbHWAFdHzE0ecUjy8cdEaJagYtVLMgpWUPKfYoMC3IxOHS0sdECZr3a/d22TfY3B49ztZdiq8JwXP6sYWSGk6Jo9D2b2EgLVr4e+csEHxxCojgTDK3tZD57pG8xUlaOHJ3m0PSNo0HGjGT3NY8yXJQud2Qz+Ckgpe2G63JCPo1PxhzwZC26Y6gYMJt3MiJnQWRGarONv5eZFQYXgaZvWsaiCaQjRTTl9+kLdnK6kFgm2eNwNPS6GEDkFdzaf7NSE6BRQVqWKegl+xR3DRPVRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwysOpNyFXTaSrRMBlvd680tAI3TM+TDg9rkTkOGipg=;
 b=W5UyM4DM23ho9F5LBklebi2mw0ch7VtQdw0pXOwpbl9RSXWpLRtVg1UkJnhjweRoihATu6tvr+2258Ub1gA+f+p504zq1MuU4jOAVhCLD2MmnoIfW/2HKJJuSr37MNMzkTLyU6fUwtWCh3RxH5IAMxw/cB0HMyLBdBRJUawc1/soxRhZTy++O5zJxST1b7LNyTa9MB5HAoRt5YDv4E/b3EAATvySicXkrsnhKjlix/Hy7819J7gBBLvSWcbrqfzUshuudFN1zKTmWjTu9GXIhxbj8CqbpJSyzYVndFnqbwQpm4/a1Fg+fGZzz7GG+LIIX1NQSvx7zeX5lFyRe1rzbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 15:39:38 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:39:38 +0000
Message-ID: <358cfaa7-718f-42ca-a769-4addb95fe1d3@nvidia.com>
Date: Tue, 25 Nov 2025 09:39:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-8-danielj@nvidia.com>
 <20251125092418-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251125092418-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a26e87-b607-497f-aacb-08de2c38d7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2gvOVhiejRydi9YMlBKSzBUNWkzRFJrZ0FiV0ZQRGZMck80THZkOXRMa3po?=
 =?utf-8?B?cnhlaklkbEdUNFBTcE9NTitkb1dIZ2g1eXYwMjliRFZreTQraDQrcWV3OUVL?=
 =?utf-8?B?UnlGR3NneDRqM3BlOXlTSzZNbGp5TytYZkZLdzBZekZmWGMwbjJScjRzZUR3?=
 =?utf-8?B?bWNFNVJmc1lmak5VdzJtWHQ1SUhuNkhCM2VYL0pEeVhJTDVkdGl2VmdFbjRs?=
 =?utf-8?B?VzR1aUtGQnVZNEZEbmlPZCtlbWNHYkdzZ2RES21yUE15SS9DTTNDSjh0cHht?=
 =?utf-8?B?aHJSVG5CVnhrWUw5RTdCV3ZZWW9valhxczN3eEFFZkhsMVpPUm9KRlYwMEhN?=
 =?utf-8?B?cnk2SjNjNnpFa3NoMkNRak54Rm9iL0hqZENRWFIyWUU2Wit4WE43b0IrUUZ5?=
 =?utf-8?B?R0hONHlqVUZRUjdaWnoyN1FMOGdLRWRqSi9lSFFIeXZDd3NCbW1Fa0xTb0N2?=
 =?utf-8?B?cnZEU3F4RGNJZXl1Z2ljU2lmQ0kzTkwxOHlyQm1CYjdBM2hLeFFNcFNBMzl4?=
 =?utf-8?B?ZTExbUpMbVVleVN1NldRa2Mwdm1PaVJzaUdhSEViNlBWNUkyRnN4TEdRbEo4?=
 =?utf-8?B?SHpPakxNM1NNdGhySjludDRENUZncjhMSjNHN25ZbUNlczNnQW12dUFkYnNy?=
 =?utf-8?B?cjFoNnQ4VnUxa29wT0Y1dDhKNEY5VGFDVDRnaFdaTnJMK0phTG53ay84OFkv?=
 =?utf-8?B?MDI3ZVRYNWV1T291ZVdiK3JncHo0Q2dXMFc3dEZWUW13VEhWMHBRUndhQUli?=
 =?utf-8?B?NEw1Y2N4QTR2SXBQWDJsNk9STEVMaTBYYjVRTUxZc0g1QTlncGRENTBxcFpN?=
 =?utf-8?B?OEZQekdyOThMSngvb3N0UXhXVSs0ZE9mOUJMenZudmNxdUhLejJONGpCWmNh?=
 =?utf-8?B?amsremJqQ0NTYUFwVDhLTDdwVS92L294ZjM5aWcwWnpWTW10c3p0UklWOFJo?=
 =?utf-8?B?M1dsZWFueVRzR2hBTmsvOEEzOThvWlBHVU53bnhhNEsrK1ZQeDhNcit6d2g0?=
 =?utf-8?B?Nmw4NVBqc1h4RzJYZmhzbHF5ejRuNEtpd1BXVERQMUkvR3QxYkJDMkdjUy8r?=
 =?utf-8?B?Z2RObDRqQ3J1SjVtbEJDY1RFVkliZTJHbkdRLzNabm1BdFRUYkxjVXNHNTQy?=
 =?utf-8?B?cDVhck1IZXdCNGE3UnFmbFQzZnZrQTEvbEw2NXptTkpJQ3c0Y21xRnByWkts?=
 =?utf-8?B?Y0YwelFzSlNDNkxGa2svY0RFNmpwbkNkQUJpaHdvVUF3ZGp4NS9vclZCU3A5?=
 =?utf-8?B?eXkxbVkrM2JFMGx0UXMrbklDRU9ZMjczZW1EWVNXRzFxVVcvZVlRVEloZ29W?=
 =?utf-8?B?TVRlWmR3TWZLS0hSeDVseHZVQk8zaXk0N2JmeGVyV3I1NFFiV3BjQzJSRkEx?=
 =?utf-8?B?dVBSdjdiKy83TkplTmtySk1lNVFKN0tsVnQ1VTNZWEVacDMyV0VFdm80UStB?=
 =?utf-8?B?UEJlL1lEMVZiSVF0dWh2Q1FWT3NRN0ozcmZZWkYvZmd2K2pSSEtVbjRwS0xn?=
 =?utf-8?B?Z21hNE4yMG44TW9hUmltWWM2NTdqM01aeTFZZDY1MjJEUUo5NnJpTkFoRHFS?=
 =?utf-8?B?aUVWN1Y4TVpYZUdOU01IRGtNZDZRaFZkWWNLUnFXc2xtck1jUEdxKzJjZldv?=
 =?utf-8?B?dEF4cGVRaENYSy9reUJTSEY3STd4NGVaV2ZkdFdYa0k4bzNZTHZZSE5JbWtF?=
 =?utf-8?B?K1RROUpiYno1dndqYkZ2MW1GMDlXYUJkdEE4S2hHMnlyQkp0ZWdKOW9SYm4v?=
 =?utf-8?B?Z3h0YnFyNmgvWXpGNWk3UlJZZ2hvL3gvWHlXekk1SjVBa2Y2b09FSmpjNlJY?=
 =?utf-8?B?NGFwSGNFdTR2U2xwTWVsTFdzUzdSandDYzZrdGpwWVBLQ0hzQ05hT2U1bTBh?=
 =?utf-8?B?aXhJZk96cDVycURuNmNsWHM4UGg4UEI2OVM5N080RXBRck55ZEl5YzZuTWhV?=
 =?utf-8?Q?XPgEgb2+CMUXCNMUbLMzrFLheOKcT5Qn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akxHcEZ4bTZEUklKNUdZSFlqZFNFUE5NQTFYeWI0a0pSd0lYR2txaVY2MkZa?=
 =?utf-8?B?SDVROXN5M0JncHRHOGJ1TERrTlp3NWIxQmZzYWNUWHpaTHBXUElPYk94SmtJ?=
 =?utf-8?B?b2lERnRobFkvYzZ2Nk93RUVLZ0h5MEtHdW5pdG52UFhZSzNoQ3BIWHgrL0FK?=
 =?utf-8?B?a3U1ekFCT0VaaUlzYlAxRTVrcHBiMjFLRUVNOSsvbWFiV1BZRU9lVnkvOXlw?=
 =?utf-8?B?QWJwWDUybVJzaG1iRGJ4akpJYzEwQlAwMUpxbHJxdWhjcURUd3FQM3NGdFFx?=
 =?utf-8?B?MDM1bWZQVWxSd1ZRTEZ1YzlMQURybjNiMHQ4cHBuVmNRSEx0RHIwYTRPbmFl?=
 =?utf-8?B?RDlLZDdrVTBzQXAwZ09RRDNhYlMxd2pyOEZ2TVI2ZmgwQ3V2aHRjcWJOUlJN?=
 =?utf-8?B?RlBkNU90cEYyVGNZaGc1SjBkUXhJRjVSY1JTV1ovOWtUM09HeGpYUmRaakY0?=
 =?utf-8?B?bGc2VEY3UzdKeXhCck5GaUNQNDlRd1hXb0JkSVVmSk8zUUNSaVRWakFjRlZC?=
 =?utf-8?B?TTJZWCt6bUE3aW02U3JSSWEzMjI5ei9aYzYwL3pNZVdOa0UyZGJsbTcwbFBN?=
 =?utf-8?B?VHdVNThsMlFZSUN4NlFicW9kT01NM05vb1FKajFTKzJyUDFmUWhNNUpSVEt5?=
 =?utf-8?B?Y0hTd1l4QjdhbTFLdWZqUCtjY1JSK29idjlyMkVjNHFFTG8zQkdVRUR5YVdn?=
 =?utf-8?B?ZnRPeU5QSmd6clEvZWhLcVZmU0M0Z2xQemZFMGRNbHhvYm4zWVdCMGJQSzE5?=
 =?utf-8?B?MFp4Q2pGaEpzQUR0dXF4UTJibHVqdGlwVG9jc0VVTHppM3h6U1dVZ1VDamFD?=
 =?utf-8?B?dWZwVHI0ckZjMCs4RXNzL1FzMStGSVZOQk41ckpYVnl4U2pUM3lXbXJmbzRh?=
 =?utf-8?B?aU1LUzlkZHBrNnN5V1VZN1JNTU5nR21FcEJhUGZENVE4aGNTU2NURjEyNEts?=
 =?utf-8?B?ZkZtKzlOUndkS0s4UmZJa2dSQ3Zrcko2SDlCYUloYVp2VGkyN2Z5WVJKOGVR?=
 =?utf-8?B?SEZUOHJXT1M4ajhLWmphZ3BTT2luZGczSm9NM3d2cjJ4T3M0Qm0vZGRGNUJF?=
 =?utf-8?B?QWdwYzdnK25SVSswSTQrODhzM3UrWkdJN3hOVzFnMUNzM0xrZTNQaWs0c3Rm?=
 =?utf-8?B?ZlR2dEFYWEZZTUdwT3dRMFVCSkpTZmJXMktNckEwRmxQelgwUTJWSXl6SUpr?=
 =?utf-8?B?ZWx2V1ViZnRWNVp3a0QxaXo2S1RzY3VhNG9pTjRqTHB4WkMwbW9hcVR5Y0dH?=
 =?utf-8?B?bjY1bDZ2WVF0OElRNEpYNlBZeFF2dFpMN09NYjc0ZHhGdHpQL3Rab1VZWkFv?=
 =?utf-8?B?SjI4Z1JKYmQ3dlhRVU9ZQlBXSkRXek5LSWtqeHRoZHJ5bVg1R2hMc21xZHBu?=
 =?utf-8?B?cDBGRVZrUmZreHVrK2x6bm5BZHV2VVRONDZ1SzluU3dUdmxyR2k3bFg3VlJ3?=
 =?utf-8?B?RjFFUWduMVlYcEUrK2Vva3Y2Z3NlR0VqZ0p6bm9CVVM1Q1FHVXlNWUJWSGFM?=
 =?utf-8?B?a0dZdVRpM3ZEYUZVKzN3anU5dGs5OUh0OEFZQVozMGdULzE2NVpFYnNjSExX?=
 =?utf-8?B?S0FUTXZXZjRmNzk1ZkFSLzUra3lMT1RCbzZPaEdWaG1lUk00eUpQVmVjVlNl?=
 =?utf-8?B?cmlUclo3OVZSUE1DTktvcTNSVGRQZWowMTFDbGtCOUtDdk5UUFRpcmc1MzJR?=
 =?utf-8?B?ZGMrWmtHOWxtbnc0Tm12ZkpOOFYvMnFOdGVCK0NqNHRTNDlvMUZFdldwUEx1?=
 =?utf-8?B?TEg0K3QzaHUwTXk2SHBwRjFrOU1XZUNQWDJqb3MrNVdiTk5heXJyR291dlgw?=
 =?utf-8?B?cjhuM2Z6dWZ3UVlMRkdMcjBWZjBKeGRxdE9rTXo5RmZyYWl2ZVk2c0MyaXBM?=
 =?utf-8?B?UmJvWkozejFjVVhqNW9Ja0czN2hwQXFwT0pIUFJkOHZnL3dTMkt3VlE1MklJ?=
 =?utf-8?B?c3d2aHZLTU45QzNHeVJoVitrOWNkY0UyWVB6OFAxMjEwTEQrQUs0Z0prOWhP?=
 =?utf-8?B?NUw2d1QyOU5xcWo2aUNCUGZQR2RHYzk4OUQwalRmNTJsYVNmNjZ1ZHVDTmgv?=
 =?utf-8?B?LzdZU0VNd1NmWG0rZENKZzRUeUY3aTRESkczT1hWWkRvVXVNZGR0UkpKK3p2?=
 =?utf-8?Q?ebAPHoceUn0BFcQGZddLu9zg9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a26e87-b607-497f-aacb-08de2c38d7bd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:39:38.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dw1meJedu94AWYHPwjuohk59G061NexhIqdARDOEZdBycL/IYPZEgvipMsNGMjDjlpH13JBL4JqsUbQwDHLldA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357

On 11/25/25 8:25 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 01:15:18PM -0600, Daniel Jurgens wrote:
>> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
>> +				       struct ethtool_rx_flow_spec *fs,
>> +				       u16 curr_queue_pairs)

>> +	err = build_and_insert(ff, eth_rule);
>> +	if (err)
>> +		goto err_xa;
> 
> 
> btw kind of inelegant that we change fs->location if build_and_insert fails.
> restore it?
> 

It's not needed based on the current implementation of ethtool, it won't
use the location field if the return is an error. Parav suggested I add
it during our internal review. Leave the input unchanged if we fail.

>> +	return err;
>> +
>> +err_xa:
>> +	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
>> +
>> +err_rule:
>> +	fs->location = RX_CLS_LOC_ANY;
>> +	kfree(eth_rule);
>> +
>> +	return err;
>> +}
> 


