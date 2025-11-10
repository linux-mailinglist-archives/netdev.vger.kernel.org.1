Return-Path: <netdev+bounces-237279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264ABC4852E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F5F188BF61
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9651C2BEC23;
	Mon, 10 Nov 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JiXNqWTS"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC712BE634
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795701; cv=fail; b=PnsOsROLcZ9mNTTd88p2980uXGY1YO91EGZSgKXHGO88xe8fESXAkvBZuOZtZg3JJKTZ625yiXvvckmNByRiLrqDkDUve4sI0txzIpWkf2Opk4LwL9vauV2qJaMLxjLGrofuAdg1SToX4m3onLX3EBFlZCPHUkFqrC/SBaK9sEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795701; c=relaxed/simple;
	bh=+kRNpRUHVTKEmz9qaI8pAzULpxSGVta3+4Dfspf93ek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qDCtsMWhGvguFTrohoKgqPx/hFMToe8mJzgDmypVxr3XIWyefpMmaldb/pqJCc4LBmLj057Vhl7piXK3qCI95j8PFEAuMs/wSgeOsCnvBriiZ96DZ48hiByvMf/Sxhw4XClhJiFAAdt0g2k59J+H+BULiTJKg4AFDwIoGTcuZPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JiXNqWTS; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsOzRB3df9OHbGArKkFdBh/MFQxnLgtsPgSxKvnF9lyFQQg0gJIs0AiBKgAW5TzwiPNDlfQVZiJOd4O1zDDSopV6v9zyEL62KrnQjFOPEDni1UsnOTR0uCMquBdcJunNiTXzZR7a9q+J+Y6liFUQ5nR1oed/c7hJhBsAtXQm6PsrVdQ8UWeYKO7dAQnJ+biMOQu3nw92GXL/rNjSD6LH8iAGzwMt3VCPMjM/alolHeuY+MSnZZOD9t8t5wqVj6QAe09zO/1jdlcgCBfUhhmkgFPGkGXOap929AT8RhTatKW8HjydWc5zQm9KZmglwQRcGkL45Z+R5ODXTWB37cv42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbcpLCjQgAxHEPWNZmAWFbtjWZS7y+khdM6qCSWEbzM=;
 b=cVhf3cTBSlMvth0izXMzWF8gKEgvsZLgxvR3r3M22PGSUG2GJosrl2EVqaqFUJy69l51bUKODAvdn4zCDESh+s7L8k0mVQOaRT5jRr7T8Ki199A9OPUBF1pfRX/U00QnXv7Lp3qAIHcgwE1y87SQO7BksH8y0B4l/GvcOQFeXahG/qnbypxG8sfj4RbhMEE8RWjQV/s028vqb5xPiSwG5OPnbJa3RK57mp95hwnnaPLqtcVOmF85CsXRtfJnqTxWSuF4QAS2Y/bVYZmc5OeLRfhngzg2RfnDpIrxwkA2xpACkyjdcP+xs3G+sBcT+mMV3qRXsEPsA3srjix3uCTOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbcpLCjQgAxHEPWNZmAWFbtjWZS7y+khdM6qCSWEbzM=;
 b=JiXNqWTSL9C3YlQAHHpbwdXMp6unJNAFjzseMRb1gfrZuaBeZwUw2R3jg0LeuDFm/VJxkw5AkikJuyxEL0irl9nutIK5L1Oj+Zh2cKZtbHTbEGpraIqalE8dgCyXDxBezZDrT7F0hnAVI4jkOu6PS72yxI0XkWOlnCXa87vg91w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 10 Nov
 2025 17:28:14 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:28:14 +0000
Message-ID: <78ea772b-bd14-4732-b685-c320ebcb5c55@amd.com>
Date: Mon, 10 Nov 2025 09:28:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ionic: add dma_wmb() before ringing TX
 doorbell
To: patchwork-bot+netdevbpf@kernel.org, mohammad heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org
References: <20251031155203.203031-1-mheib@redhat.com>
 <176221980675.2281445.11881424128057121869.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <176221980675.2281445.11881424128057121869.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:408:ea::8) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 929468e1-4e61-49a3-79a0-08de207e86eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck10bWdwRVRXL3FmR3RJM1BQOWs0a2lvcXVaTzZiWW1iaTJSNE9aa0c2NFhi?=
 =?utf-8?B?aDhrTEtUZ3NjRVRXdWRVTnRvM1NPdW5SQitkaWNVb3VLNTJHcjJJUVFMb0tL?=
 =?utf-8?B?NUR2UTJjSWtWVTQ2N1ZuWVFJYW9wRUR2YlZRRGpwYThHQTV4WHRlZUZXTlpM?=
 =?utf-8?B?aVZETHh3N3E3RlduaURvaVhibW56YkFnZFRJTU1yYm81cG9tK1hudnFhdFBC?=
 =?utf-8?B?NklUNjFNeHI4cVJpVlVlS2Z6a2JLREpkSm1JdDlVZkxLMEh2UXNKUUtidW41?=
 =?utf-8?B?N0FWTmQyNjM3NTJTS3FMaEtGWFlsdGxmQ0JjU215QmJaM3U0eW9SMU5PTU5w?=
 =?utf-8?B?UE9DWlVrQnhIWlBrNUY5Z0JCMk1lWjBhNTkzbXpWU1BrcmpLakZha1AxUVlq?=
 =?utf-8?B?WWE0eUxTcjBqc2MrZUtLdURSd1FZblZ5blBreXpyWHNqVmk4a3BxellZMktz?=
 =?utf-8?B?RGp2dWxxTXFoeXlOaGl3WWZsUzhUNGJIVkRPUXJBcjR4dERLaVdmMTRHQzZa?=
 =?utf-8?B?S0xtRmtzMXQzZ1lpSU5wTGxiTjBBWHVHVFhZVUthbnV6dmEzM2M1UHdTbUM2?=
 =?utf-8?B?L1RtN01IWUo0RnZxOEpkWW1LOHRxUXhBQ2FiNjU4bVlwSkVEVjkwMEZxaFNz?=
 =?utf-8?B?eUl5NkN0N3Z6cFZwR2VhUmhYWktWWFlOckNRZ2MwdUYvN3hvb0laQTlOVkVn?=
 =?utf-8?B?UDRwclgzTk5wamQ0V1h4REkvRUJ0NGJSdFNRdUJiSUNqWG9SMXFNNTRHZzlm?=
 =?utf-8?B?MnRUZUNRZldBWHhHT0VwTzVYaFI5bEVlQTZkbVU4b0xLTEJTalVBS1R3M2h1?=
 =?utf-8?B?OU81eVhuaTdxaU9WR2NuMWIwaVBhWm5uM216SUdGUmNXazFiaENaT2RFVmo5?=
 =?utf-8?B?QWllSmhSU21wYVl4RWxjYm9sVzZXOXNSNFpsczIrR2laNnRjMzlOZUFTTzNw?=
 =?utf-8?B?cUYwRUFDbHZXbXN0QzlCVjBUZXBYRXhzMFVRK1Nldkc0U1dFZ3RKa1NRV01U?=
 =?utf-8?B?cGNUWElIOTY0YXd1ZFZMb3JXYjdsQkNOalRhR1ppODNVQXRlRlY2cnVMWkd3?=
 =?utf-8?B?ekpSZnc4bWliWHNMenpQaTA0elErQm5uNDZRVmJ4M1RhdkJ6aVpvdk5JV1VY?=
 =?utf-8?B?WjZUalZYM1F6aHBBMy9NV3Q4eWs2WDJxUC8wUFEvYmpKeVJsUGNudk1BQmtY?=
 =?utf-8?B?VXFjNCsyd3htVWcrb2ljSjM0cWIzVHJid0ovQVYybHZsdVpPOW5mSWlOS1I4?=
 =?utf-8?B?ekJuSzlZd2FXYkFnRkdLSzFvRVNDeEFtWjc2dTN5cDVoYzRwcjNoYmNZRjRa?=
 =?utf-8?B?aUMzSHM5Z0tOb01abEh1ako3clZGVFJFb2FqdTlOS01QY1lxK0NDdnFROFdD?=
 =?utf-8?B?NkNFcVBPWTBIcm5KTlY5ckFIbUlBZytEWkdhZ3k5eDBKa1h0OUFmMXdXYlBl?=
 =?utf-8?B?cTBpaVRwMWxJRnRocFBqejVxbGRKRlRjU2p1N05odXFIQ21RbVY0N09rZ0gz?=
 =?utf-8?B?aGxMR0pHdzlTT2F6OW5UOUkxc1hEUUx1eFZ4bmNJbC95dVdmUUlzQjFwcjRt?=
 =?utf-8?B?TXlQNEZvSnlKYjFQaGh4R2tUYlh2K2dSL0lZK1BFa0s0SUQya0R2N0I3c3Av?=
 =?utf-8?B?aU9VcFkrbWFNWVZ5QXBDU3pvWHdYNkhCYmpsbzdPL05ueVJibEEveWZmOFYr?=
 =?utf-8?B?aUM2dzlmRGVvOTRDM0ViRjh2NjNFOENzYmNCWTA2dmNWRTJQa0U5eEJCOXhP?=
 =?utf-8?B?Sy9rc3VScDd0aitPSXBwUmx4amR0QnByYmxvV21ONXh3WktwSDVTa2owS3FC?=
 =?utf-8?B?VXA2YnJsZnZyNk9RVXR5VUVDM051WUNiK2orZ0dINWxHVkZGS2h2SGplbmxH?=
 =?utf-8?B?VXNSUkJZMjhTU3dSN1EzakF2a1VwRzhkLzBBK3ZJWmxWemdpVlY4YytlNmFw?=
 =?utf-8?B?aVJvR2ErdXBlU3pRVHkvRGtPb2ZyTksyaXFWWklqbGlwVXRvSmFwem94cWJs?=
 =?utf-8?B?U1FBWGxBc2t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjRlZFgvT001VytKMmFqM2MvWUp2dlEyNEFUbVhSRVFQbnR4Y2xDWmdZdTR4?=
 =?utf-8?B?UWEzUFFNdDk4WXpPWElGQTNBVjRONGJVZHpHVFNPTnhuL0VOejVsVlBoamIw?=
 =?utf-8?B?YnB6NHppZE9MRzhURmNLU1NZM2pFUyticDVuQVdSV1BJNWJueDlIMTMzbUUy?=
 =?utf-8?B?NzU5NGVDa1FXbTNXSzRzR2hKOEw1bCtPbU9oNDFETnJtN2RidHF2L1Nmc0wv?=
 =?utf-8?B?RFNmeVduRTJZOHFZd0g3U1JLS1VNMnhLT2t5NmJRRmhDb09JcnFwcXg5VkJS?=
 =?utf-8?B?ZzU1NUMvaSsxOUVKZ1AyUnFKdjZndlNlR0VSMmVsdHdXWCt0K1VuUmVFdWVs?=
 =?utf-8?B?Z2E2b1J3RXpOTjNRbUwxd2JLTDNTOVFRWlJhYytDeG9aczRRSzZobEtjNFFy?=
 =?utf-8?B?aHJsTktzbldncU9XZlhwU1A4WXIrTGVJdUpteWh1MkpHa0EvaUJxZWtCMGw3?=
 =?utf-8?B?a2I1R2JsYU1KZjJpVG0zVmp5aXowWEtuU2NFdkZkem9KV2JDcjZiN0tmN2xw?=
 =?utf-8?B?ME5hbmxiTmJKcVdwQk1DN3hEM3lQYmlHaEhSRkxaNUhSMTR6c2tERWJ5NHpX?=
 =?utf-8?B?clUxTVVRQkkzZExSVEJETmNsbVF2Rkx6RkFzRHNrSjFsK0R0a2ZLUkowSmZq?=
 =?utf-8?B?bC9NdFUxRmVGTStQVld4aXU5alNndjk5ZFVDZXpWRWVNWTVMM3BjU3JvU2tn?=
 =?utf-8?B?enBvRGNTalZFZmljcHhaais0dUxLYjJFejd6YW9XYm9IQkIvc3FFaXRzZEhp?=
 =?utf-8?B?SjFERUg2emN2Q1lNVXprOUdSc1h5ZTZBMTBzUE4zQWFrYUtOSEM0WDVzUkpJ?=
 =?utf-8?B?OU9VSkMxbjNHTGs4MlIxY3laT2N2bHNJNnJqYit1OEtaSTRiaHJIazlzbDdY?=
 =?utf-8?B?d01YaHV0eUJUUkZ2MjdSejRQcnByM3dUZGJSWDRYVFBucDF2aDdGQkVrSngr?=
 =?utf-8?B?MzZLOEJ6NVIwZitSQjhubnlZdklMVUZQVzFMVW9Dd0VhaU85bmpZZ0dYYWto?=
 =?utf-8?B?WDRRdGxOWmRZZlVJY01xdlo4V3pUb0hWMWpqYUxwOTIyTUdHcENVTFZ6S3dx?=
 =?utf-8?B?ZmhPdkpYcjZCczFEQ0tOY0d4Tk52a1VQamEweU5NbkQ5ZDB4c091cm9XOEw0?=
 =?utf-8?B?L01SQWRQQVlDVWNlS2pGRjhCdm9lZHd5Y1pDRjBVejlTb2lyTEZPMkZ3MXJQ?=
 =?utf-8?B?UmcwVkxlSDdLSHRXeks1NDU2dGR4Y2FDRkdwYTJZNmdVQmYrZm5tUnh1OE5n?=
 =?utf-8?B?Z1hYTHI5S3J6OXpjUmErZGZrUUdqU2xQVTdsZlJQcWY1bWF4T1pGdC9IaktV?=
 =?utf-8?B?MDNMMzVpVDF0Wlp5V1JvOCtFNjZxNCtNTnhIQ3ZmMHhpY2twUWhnTy9oU2ZE?=
 =?utf-8?B?MFNHeWkrSG1RWHNISXpZRThsNGFpMi9lRjRvYk1UaTExdnVjZENBNGp6Q2Za?=
 =?utf-8?B?dkpPVE5Ea2FERzM4WEQwQVdscm1odzZZbk9nbHBLODkwa2NramRRZ3JvbU5E?=
 =?utf-8?B?TkczY2RwTXVEZDVLV09HN0E1TDVFNDJhUitocms4aDBFeDBaa0h1UXo4MGh2?=
 =?utf-8?B?ZkJxK2RxOUZvNVU0RVUvb1czamhZTVBTblgrS3R0cENFU1hJMEkzMFplV3VQ?=
 =?utf-8?B?U3FrTUN1OE5zV2tLYWxxUGY0NUZTVEJVVWdHRjJPdjRKd1dJNnZBUE5tTG5J?=
 =?utf-8?B?MUlkcEVsdG9rOUllZEdzRFEwVHIrbmE4OTMzK2dJSWNVdmFnay90RkJxSGN3?=
 =?utf-8?B?OEZVcDRSVWMvaVpobWh4YTFDSDZzb3NLaUROK2d3eTJ0eFRGck55bTE5UlhT?=
 =?utf-8?B?MUx3VkgyUGNRQ04xS3hEV1U2eERXd3ZUZWtWWHB1Z1RCM1U5U0lqRFd2WSsz?=
 =?utf-8?B?azFmRmRRR0JoVk1PdjRVcjg1eVJLNzNwalNsYXBuQVgzUk01MXB4RzNLaUJt?=
 =?utf-8?B?UVErQXd1QmRRanlNMFg0RGFNVzNuaC9LL1Z3V0ZLREhnVlBEaXFjZFA2SEhO?=
 =?utf-8?B?b0dVeFpvRWhLMmtHN3N3WExDcmU1V2NJOVFyTkJ0RUEraUZncXUrNG9XR0RI?=
 =?utf-8?B?SVZlcUwrUnpvbmNoYkJwSUZwbnZvbnEvaUtXYS9tOHlmcSsreDhvaDYzZ2Rn?=
 =?utf-8?Q?/wVOhoeoc/6tdmyyNQ4U1cGDj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929468e1-4e61-49a3-79a0-08de207e86eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:28:14.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlmEJhPJ/q2wK1jMzVg4aagcV2Tl6ORVnuBK7tN1jJYVKmtKvGYRwSDbGw1vhWNY21SkfrBf/99hfVp1taJsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830



On 11/3/2025 5:30 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hello:
> 
> This series was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Fri, 31 Oct 2025 17:52:02 +0200 you wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> The TX path currently writes descriptors and then immediately writes to
>> the MMIO doorbell register to notify the NIC.  On weakly ordered
>> architectures, descriptor writes may still be pending in CPU or DMA
>> write buffers when the doorbell is issued, leading to the device
>> fetching stale or incomplete descriptors.

Apologies for the late response, but it's not clear to me why this is 
necessary.

In other vendors the "doorbell record" (dbr) is writing another location 
in system memory, not an mmio write. These cases do use a dma_wmb().

Why isn't the writeq() sufficient in our case? According to 
Documentation/memory-barriers.txt it seems like writeq() should be 
sufficient.

Thanks,

Brett
>>
>> [...]
> 
> Here is the summary with links:
>    - [net,1/2] net: ionic: add dma_wmb() before ringing TX doorbell
>      https://git.kernel.org/netdev/net/c/d261f5b09c28
>    - [net,2/2] net: ionic: map SKB after pseudo-header checksum prep
>      https://git.kernel.org/netdev/net/c/de0337d641bf
> 
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 

