Return-Path: <netdev+bounces-244952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CC6CC3D5A
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9EDB3039FC7
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507EE3358D4;
	Tue, 16 Dec 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uz2U6eyQ"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C546337118
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897241; cv=fail; b=MNC40wnQDdBUvb/U9Uwx7F5VWLAH7KIzhT1N6VRkUSmFQbZ0cfbBVIyENt7nlubVDoaZ8748UG2Y5Wmkfcbxg/cj+//RMFM2D8qO7ICoTf5I5ybIOt2u41Wqlo56Rtbvh2ORrEAQAe5+i7RDM8CLaY93T7FIf1KHXIIoMTxfWcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897241; c=relaxed/simple;
	bh=m43Aw9vKz0X79v6HGHnrLvXX02tIugX8f6xh0bK5dSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lKN4aQSyQPZoQ9R385e32e4NP8fooE5bBNeeL1x+PgvxGXTdw7Ih03ztmcPzOT7wh4ie+bsDko1IuQD1UOitFYTYszOUyNPnvpa+ukfXzq7e7k9npjkjgfbt4doi6a8r/VaOeOWm4kbEmPkNFG7akgS0NROB5XNSOBSi3DgaNrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uz2U6eyQ; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qugA3aoi4WnFxyJ47IMOWyF7azMcdfM+u+GYHAeqgB/A0KjyMohnWdfrNO+ZrvuMKbYIuC7DNQlV0FxiCABca/z2d0OlXGlPDNi33BTdtv/n5+YIQiwQiXYFfLR6sUSy1njY/nBDVYsx7VleIdZM2ipKOFt97klC0E+GX8ptECqftLjoSJBzR59dn0JyrPFGYGnMTbtkE4M7aU7/vaTyJ/0/jrRMH68ngAIgwT420qL5JyP3yZf5xLH+bxXQ8vQZ9k3TdpBAT6IowFJfKhTdJftlB1b7FXCfRwxNR0/56NSevUi6coKaR+qki6lGAlqlG0iRAyDCmoeNFmD3nIApMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80sh2b7RmAb+bBgDRdfXNtQrGhHSLUUXFBbBCvfKazE=;
 b=bXjzcCkidkL0BI6+0I2r9b4zZAW5e9LYiaR9AQB9vT+jqWFl+kJ/E+l6VYcLyKqKMcaisIFxUUMyKWdNwqyyCwJTjxLm8If4NDHmqYapYKmA066DLyXajvX7KV+dPkGqURAwussRioeYLs0AX8d7kRIaWis769l+yOnCXGa+ONiQV8rOfU0VRoiYNid2sGiVK6JyonKghukzhPeFGbpjFJI2UkXEkZSRK77EZRtC5w5tr+1hfi6z1vowqFP+OTxsbayrwoHz6r/9PuB81UUwkLRyAbUlfEHzROnYp0GJiEXe9eSsR7Y+NdF0vgdna6PbAk7lsGChwD4xGEhtiqzktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80sh2b7RmAb+bBgDRdfXNtQrGhHSLUUXFBbBCvfKazE=;
 b=uz2U6eyQmlNwV9N6Hd2JCv+0xwQsu3B/OrRw40nZxtpaiU9M1fFFTQ2NrSy93U/3HFL+YMQQxfQQFCUVxxzwE4/UfyQNHHBbjRs5qqHpyw0w75zdEHQskIBsgAjnDYfZzr6Ph+J/GDHhIL9oIeUg3cPr3779i84T5zFcNb17SvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 15:00:31 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:00:30 +0000
Message-ID: <2a4e7ff2-8e75-43a3-99fa-20a525009347@amd.com>
Date: Tue, 16 Dec 2025 20:30:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: reset retries and mode on RX adapt failures
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
References: <20251215151728.311713-1-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20251215151728.311713-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::6) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f1ee2a-b385-4bf3-8d5b-08de3cb3d82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkMwV1NLbHM1dzlacmU5OWRUTmhTMEdtNGVRdlI0TDFXTmRNdFBYYXNxVXNB?=
 =?utf-8?B?N29LVERPMkNXUjdjWWhPaFA3SmY5LzVORXBRV09LWDVnOEs3alJIaXQ2TkVi?=
 =?utf-8?B?Q28vcDh3Mks3MVN4Z3BjWG9HU292emVrNmZvZkF3S2FFTEJPNGsvbTdlYkRl?=
 =?utf-8?B?QnZPZXVFRDJyNVRuTWFrME5YSG9WMG9CL1pZTXBHaHgvUVR3cTRqQ0NzZXlN?=
 =?utf-8?B?ZWlLdWd4M0tlT2lubWQ2YmFqUm80d0haS2h4WjJKSHNOUVN1aWxoL0VDZkU2?=
 =?utf-8?B?blFzTzFCRFN5UjRIN2pTYTRBbXAvbjNKQjI5dnJpRnRQdU5qQXExVUsrV3lD?=
 =?utf-8?B?bHVzNDFqRm16alRpYUhQSGU3aGhDam1sR0Jpbml6UTl4UnkvYmxoeTBycENM?=
 =?utf-8?B?ZGJ5UlFtUHRKL015YWJVVnlCS0Y2V3RMT0ZJOG5KSHNWOVYxVFpvbCs3bDB2?=
 =?utf-8?B?RFZBajBtQTJXajd2TWZEVlJzRXRSN2x5NFJXRStmSVMweW5jc2RraDFSdk8z?=
 =?utf-8?B?ZnBERkJmYzA1bXJ0QVZYeVFjbWJBQzlhQi9HSTE3WjlmWGRic002bTU4VFgw?=
 =?utf-8?B?cXo3cmN1akNlTEIvL0RRTmpTemFjYVZQT051SDJka3RiL3ZMQi9tTmlsODkw?=
 =?utf-8?B?STArUnhrZzhIM24wK3JyczN5bzM2TUw2MHdIY2FxbEdRckZzdGZuZXE1cmxN?=
 =?utf-8?B?WTZONFo3TC91WG1pQTBiTEt6MzFKRkFZeGVTRzZmNVU1eU1tNHd3TEJZWHRE?=
 =?utf-8?B?bjRvd21qWUpiZ0tIUTUwdHlmUFhkY3NBY1R0YVNXTzVSdG5QQ0RRWTl1TFpw?=
 =?utf-8?B?bnIrRTRQdTRrRzNMZVp0WmRvK1VuQjExSHV0Ryt5ZEtlQmRDZDRDTDdURk9B?=
 =?utf-8?B?NmJnbjd1V2NRK2FONWJyeGxHSDY4VXBtTDIzQ24wSm1IQXBNbnVHU1MxN0d5?=
 =?utf-8?B?ZDBtUGZlNHJET2xJY3FETHppYnhUTjR2eWMvbVExOHEvVUxmYm5DMGZZNjhU?=
 =?utf-8?B?SkVMa2JoUWhFeUZHOWhTMlhwTVRycW5vMlg4TXRRN0ZJdzB0Skp2SzFPalFH?=
 =?utf-8?B?ZzlSemlOa3pCWjQ0STY3b3N5SUpIQXlxNHZLZ3BtTGFqK2dRYTJHZUZ6d3B5?=
 =?utf-8?B?cnVnL2plMmsyeUxEUkRsRXRmSzNqaVJwVUhFM20rTlpsMWhhakZrNlh2MTFh?=
 =?utf-8?B?MGZYeTZDbW5aUmJ5bWpSNHZBcHIxNjVxcEFQOStjNUhCZHN5YXZiOWloSFg2?=
 =?utf-8?B?cTVMelZSdHNZZkN5aFRWZzEyMXNtK0RSVksxTnFmZGtmUG1aTHVMbkhvVG5D?=
 =?utf-8?B?TnpEeGRKeHZwcTZ1eEZhbHBLbDFYL21LZEdoaWMvTG9GT2lkMFlYWVVhbUx4?=
 =?utf-8?B?SGNvZUZSZHFUbXR3Zkk3T0ROS0dQODdEbUszODlxY1VKU25QY3NwbnRFcG1l?=
 =?utf-8?B?RWpyRHlDdDV2TGxsUHJGRzVMdUpibFhUWXdHQktweXoyOCtHamtrQnkvamJa?=
 =?utf-8?B?bWpKVWNYM243NWZ5bXY5d3NBeTQwVmtsS0JxOTJ0ODloRUtyVHZVRk5GUmVt?=
 =?utf-8?B?NWs5bkxPMURqMi9PVzZQNVV6azdzcUZRaU10VHV3NzhVcEV3bTlLdlZPSFJD?=
 =?utf-8?B?RUNLUHJJUWp1eGs3anc3RStLdnd4Z0EzUnpmd1RMSDAxbURiNko2d2VlT05t?=
 =?utf-8?B?SnhTeUs1KytmbVo3Z2ZuV253dkQvR3RGSm5HYUU5N1VSelVoQ0JZaFZVbmNu?=
 =?utf-8?B?M3pHSU5zaHhicXg1YmlNZEtYUzR3VlhiVkQrdHo2M0ZPdEMyc2huUVJlbEw0?=
 =?utf-8?B?Q0ZXSkJVSmJCVEU2eE9nN2Ztam9jcVRSNzdXbEQrN3dpTHdIalp4WG9kNFd5?=
 =?utf-8?B?bEpsRVptZDRaMVZMVWdlVFh5eS9rYnZMb1M1ZHRIT1M5THdiczdvNzcyRXNp?=
 =?utf-8?Q?QWcjY4lnlj2nbKb8Zkp2wHqj09TvZOrW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmNUMUYxWFdJWXhRVzdIQjdOaXhLOVNaM1M1SUI4T0RweHVOMjFTQnNVbUlL?=
 =?utf-8?B?RkluNExGS3F1M0ZHeGJpNjAveExhVVFGUjJNRnJFNVRyNHBjNUxMU2d5anZI?=
 =?utf-8?B?akhDM1NNa1ZWUWsrbnlBN3ZaVFlwa2xFaGlhdjZpTWprSXI1QVhlZ3pSODNR?=
 =?utf-8?B?SVJDUlVnRHA2Vys2T2lvNElIaVZNeE9DaldJbWRtT3pIL0JFZ0ZUZ0svWUJ1?=
 =?utf-8?B?UUE3L0JnNlRIK1BtVEluUXRZdTdHZStHeDZxWGhJSW1pemdlUnh1NWNMVklF?=
 =?utf-8?B?UllMWkorRVRxYVpUNUVJRXNIMmJ0NkxjMDVka0JPcTRQUkJnMGVPdEhFbEts?=
 =?utf-8?B?dkZYNTN4UWtWUjJBQWx4cksrQ2Q4U0kwN1dBcVgzd1pobXlCbEhSWWJXbEVJ?=
 =?utf-8?B?RS9CNTRmN1VLbzZCd0tXVlRYMi9GcUpHelpaUmtXU25GRzFiRlgwTEZoejhi?=
 =?utf-8?B?OUphNWhzU1ZuZWhKdldkU1V1eXJ1UGMvWFZnZlRTYTFuRlVvd08veXUxNGJX?=
 =?utf-8?B?aCtXbHhkNXZiRkZXYnJHWjI5akZvR0JoOW5VcGF3YzYwNjJ0WWs4MmhFbjlD?=
 =?utf-8?B?Ulp2aGNVclJtK3J6Ym5PM2Ztdm80bjg4WlFmTDYzRjk1RUhYZ1IrS3FoTGQw?=
 =?utf-8?B?SERYaFE4NGdLSWd3Qkx3SVdESGZkcU9MdW5Ua0RXZFd4ek81RVZyejYzYjRl?=
 =?utf-8?B?YlBJSGxta0NBczU4SnA4ZTc5SVB6cHNHUUtkeFI1b2VIUTdQSnl2SWpmWkY4?=
 =?utf-8?B?Q1h1NHVRZGIrbFYyL3QvdlUwM0cwYTg0aEVyL1ZtcGdka3drNVAveTYrTEZD?=
 =?utf-8?B?SGx6TVBZbmlZT3RIT083MUI1NkFpak1ZdnJ1VUl0b3VCak4vc1Zlc2JuTXBj?=
 =?utf-8?B?NEkxUkQyTGVMUTMzOVVLeXBSUUwwUU1FZkFMRTRDc2x5eHdjNy83N2xleW1C?=
 =?utf-8?B?bXBWNkQ4ZXRvU2J5RUU5T3JFTjVSZFdOVlZkbHU0VzJ5SXF5YzNGNXRhL1RK?=
 =?utf-8?B?anpDSml4dlh1eTkzQXlqYkovZUQzbkVQMFVNNDZaL3MvVzl4cS9ZQ0h6RVdn?=
 =?utf-8?B?MjhCaDdyS1lUVjZHeE1NdWZOTTIxaWpCa0p2SkhpOEpNMGJjYzF4OC8xUVhU?=
 =?utf-8?B?TmdXcUk4VWNhSzEweTBNRVJtU1J0T1dWSkJFNHZQSzBmUWhlSTdLcHhrZzhr?=
 =?utf-8?B?aDhLRUhVRHB3b05BZ1J4QitlaHh4SFR6Zk9ralpUQVRwY3pTSGdDUEZZd0R6?=
 =?utf-8?B?UTlxc1lDZ2htY041ZDhrOFBkR1dtdVpoTEhHeVg0UnhLNTMvNmRnS0NicHoy?=
 =?utf-8?B?dmdsTjJOZ1Q1dk9WOE11VDBzY2xIMDkvOEwvS284RTQzTndZRXh0eGFIamw5?=
 =?utf-8?B?RVk0SGgyb1V6WEtTcnRDQWU1d24vejlyUU5tMm43TktUVHEySjRWWUdXb0R3?=
 =?utf-8?B?TjZWN2QrT2hDTkVGbE83UVArT0ZSSUhMVHpvMHRyaENmZ1VhblpFNW1mengy?=
 =?utf-8?B?alJTZHh4V0ltalNpL3hqU2tvczFEYjNCaE1WZ1JDV3huNXp6WFluanZOM0Rz?=
 =?utf-8?B?b29WTEhhRktzMVJUNXBHQkhVSU9XQ3FXTy9LOFlsZ213OFdZcmZQY1M0MnQx?=
 =?utf-8?B?aWEreDgrMC9NMjRjdFcxQW9aL1N3YUhuUndXQ214SFY1b1ZVOUtzbWZ4L3R3?=
 =?utf-8?B?Z2lZV1R5M0w4YUZaQ3M0TjFnMG80d2d0bjcwNWlwd05GOEwyN0s4OVovbUpO?=
 =?utf-8?B?L3YwdGU0ZHBPSnJuanNRM1BxdmRwRGN2S3g2ZHl0T240QVovZjFlaFZzcmZs?=
 =?utf-8?B?N3QxZ0lLNXRSTXNzd3dPTTdLZ2s2aDJINHAzMi9iRkdjUVZTa1A3NDdQMlps?=
 =?utf-8?B?U2Q3MjNsd1VPMnhkOXM3dm5lZ1NjSUdHb3ZNa29KdHByZmNmTHlrU09CRll0?=
 =?utf-8?B?dlIvYTRpTXhpKzZ0Z2MxamFOVTFuU3ZHSndQV1Fqbzc1cnI4SVFMV2hydTd1?=
 =?utf-8?B?WDkvWmZhSEQ2SW14bmVqbERtVitkZEFOKzhKN0ZqQVRoUklSWmdSYWs4QS8x?=
 =?utf-8?B?M3BtZGxUVEdEejBqVWpCNjZ2dHBEVnlZRDVXYy9mZm5mSWk4RWlIcWxVWmgx?=
 =?utf-8?Q?AOZ3UUVtc3HRrhojnD1OrbWgB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f1ee2a-b385-4bf3-8d5b-08de3cb3d82d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:00:30.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvERMgSP9Mfla02YhW9MakF7CPTk1HOe4Qvi8xmM7fN/abm9/T5AbdT9GqDdZL25iusn1EPec93zi9veuSV8Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278



On 12/15/2025 20:47, Raju Rangoju wrote:
> During the stress tests, early RX adaptation handshakes can fail, such
> as missing the RX_ADAPT ACK or not receiving a coefficient update before
> block lock is established. Continuing to retry RX adaptation in this
> state is often ineffective if the current mode selection is not viable.
> 
> Resetting the RX adaptation retry counter when an RX_ADAPT request fails
> to receive ACK or a coefficient update prior to block lock, and clearing
> mode_set so the next bring-up performs a fresh mode selection rather
> than looping on a likely invalid configuration.
> 
> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam

> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index a68757e8fd22..c63ddb12237e 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> @@ -1928,6 +1928,7 @@ static void xgbe_set_rx_adap_mode(struct xgbe_prv_data *pdata,
>  {
>  	if (pdata->rx_adapt_retries++ >= MAX_RX_ADAPT_RETRIES) {
>  		pdata->rx_adapt_retries = 0;
> +		pdata->mode_set = false;
>  		return;
>  	}
>  
> @@ -1974,6 +1975,7 @@ static void xgbe_rx_adaptation(struct xgbe_prv_data *pdata)
>  		 */
>  		netif_dbg(pdata, link, pdata->netdev, "Block_lock done");
>  		pdata->rx_adapt_done = true;
> +		pdata->rx_adapt_retries = 0;
>  		pdata->mode_set = false;
>  		return;
>  	}


