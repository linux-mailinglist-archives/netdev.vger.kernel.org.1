Return-Path: <netdev+bounces-66926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EFD84183B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096331C22072
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9D62EB1A;
	Tue, 30 Jan 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WkX6JOOi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BE2D05B
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577647; cv=fail; b=YJ7aFcY8JNaZ0gI01obXQGFVxC4F4RE873ObBdmyqMn9F0AxJJyxt85UR0QkAM16JwUoF3hOQUwLkuwvTF7unWq/GI9/QRCrYvE7OI388AGeo5pK5UwKbvUiCkG+QhRgQzp/r2LgbNPNWwNNbA4gitzqu1d2pCds2ptfoyNftiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577647; c=relaxed/simple;
	bh=7ryFbQY5/2CKwNBfx1/G5356RdjwbnDSJXp+gz+7Mgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZUD6cw7IZkHUkjnxbci6SnN8ooRMPVr1qICbeXJda76YIs3RcKrou+VB4oy0CsxtQ7lYfAibVbz7OAmvQzSaJZnROLEiL4qjul1Diy3jagA6YwzEt53GvmAWgBEc8IatTH094sCyCBSq0lyL9DRgIM225JJWUjGBvBCgrO+uuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WkX6JOOi; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbxCTLkRVUasthT20OCt3np+hYvVnTCBlYBbpM4BYfcAnYnsF2hsitHkF54eurYvnOAurZNifPa5JukmqqF1RJP4QGaMcST0RrRkVabZ0S6+qretZTmUj85bLmNSx10zxrImTz+6I5j0UUSo/akDaSmfY+UhSh3Q5VOChJzBgjKSMj7ziQVHHRvT7SZUTGw1SvszLiH3q9qO4Sv5HvWHDNOlLCsMJbQKsKMZ7e6V6BwkdvKfiKZnRSpClbNZTn/x/IRNzcdk8Q4bcAiml7Q4yjvv5Fi/drQy9ANaLZfJlQIG72MHD8e0/6j6ArCYhA/+vc6G8hqj7paKkgm2vFoGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzPs0ad0iSzKa3HWfBXXfAbdexVDFWqf0cOSXF18sN4=;
 b=HTz8GrpzefcYN0+ITFp8h5is9khP+5MROHklAqjsO7rWtWQvki89lMsFgFXLFHFl7WSidfhHtBxN+TTkU5aU+om7iM3PslppYTy6/29Vhpn1YpjOWf8ug4QxXs/yvGs1Osmb0GEVgmbCU8vQMwlOPsR6ODv+EMXe4D0W9nWeHzFOcypJqTakYaId71sQYMNmZmuQk9tV6c/InGxje7qiVhZEBmq4Q1/OsAZeE1AE3bJLZJuVuippBIuyRn+bcMFn5NAdMgnbtIbZCtmUFPRjW8U9gWIx728R4SqFo2nmV1neE5GK6aB+BpPoDj/553ZNJ6PUdMbP4wElz4DiQH6a0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzPs0ad0iSzKa3HWfBXXfAbdexVDFWqf0cOSXF18sN4=;
 b=WkX6JOOinh71OCFZ0nqjKnD2ts27hic9bs3Pwym0ZXysOJPkymXvnvgsg0xFGuWdLds74SW1bY5RINHhh+9k8Hgxtwo9keCEfVMCftkHcYmTZfSKtynwra52p7WlPrwP8G7jVrHt9afByMbCVCTWIbmklXm0xIP79gHRH273srA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 01:20:42 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::1986:db42:e191:c1d5%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 01:20:42 +0000
Message-ID: <8ff8cd4e-294c-4b1f-8e83-c092132a2445@amd.com>
Date: Mon, 29 Jan 2024 17:20:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 00/11] ENA driver changes
Content-Language: en-US
To: darinzon@amazon.com, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
 <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>,
 "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>,
 "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir"
 <ofirt@amazon.com>, "Koler, Nati" <nkolder@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240129085531.15608-1-darinzon@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:303:85::28) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: d588a726-366c-41bd-0937-08dc2131ad7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RcsVfOSndCGbfcCRhlvuiOpV/i4ji7dwmTDqV/DLZ7Lq3Ow43Okpofrr2vWgEOUat/U2485YS3abwMu3bH7KD/qtTD6bNk16QG39avF14C0+INAnllLh9lqFNjGZBbMInuNnJYFVH9rtYOEkajkZ4sHaXrOBEKhytuiKKnYeYOZEY7KHDwsbVevuFVooJZzRO/bfMnDRgnbcfPUUA+8//bx0A1VlZSVl7yLK43VbXKaL4TDnjvahEGwtItQ7C8SCFPRN3DP+ohgqr8ntMMPRLJ9a6yj3VzIxb6J+v8/fENNUdeIxxzFuz3pgK4/O34K9v+MNdoeZMCzkbl1tmeh4mXCvJ5o5Z/PXaRS55M6zFDsPTZFwgePfDFvIdPrlER4Ba4uaFAjQ8ZlzHsD6v8jC46N8xvEuzg4T26a9lG4En0H7gs1rRigHIfKBt0/XWYIdSqFgQV5HCqnO9BsF5hs/ot1uZ1btyNmrJ1f1CBRUA69rJpydcps9CfaTV9tZN2t+CaiOgFfsKXeXdm1tqZAQ22NLHwTKfUpiN+5vaorQgrfcwRN8W7fb8PgR/R4jLyoffSMJyXocEPtQRnlWq1qSO41Yy/T1PKtghFJbn/DF4vlKEZIF8yUdutgivPp/n6jSXWufw25Nf0gqsjKnvofUXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(31686004)(6666004)(6506007)(6512007)(53546011)(83380400001)(36756003)(31696002)(86362001)(8936002)(8676002)(41300700001)(4326008)(5660300002)(38100700002)(66946007)(478600001)(316002)(110136005)(66476007)(54906003)(66556008)(7416002)(6486002)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWM1VHBjTXhZTGtnS3hQOVhVTE5ZV0FObTFsM0pkVzZobFphMFkxRVJKajdL?=
 =?utf-8?B?Ym85aUZyd2pFMW5kRDYzQmF4V2FLVEs1SnROMG02bjY0Ymw0UHJ1U1pwRC8y?=
 =?utf-8?B?TUxBS3M3ZmVQcGRTMWw5eHJtdkZ4MnEwRi9oR2dURFlzbVhVcS8wSlhvTGJV?=
 =?utf-8?B?QmRERTR4cHpnVjFycTVOR1Q2M2FHaWt5Q09Bc2lDZEk5c2VCZDJMQTkwQmU1?=
 =?utf-8?B?ZThaYytGSUhlUCtJT2c1SjcrTEJIc2w2TEd1Qm01YTZCTDVUc0ZOUURJZ1ov?=
 =?utf-8?B?ZmdoK1pqMU1aQkZraDN6VndhNS8vZDdBRVBhWVVnRmY3THNZWndyczlZZEJD?=
 =?utf-8?B?Z0JVVU94VzZmZU9FUkJiUDNXY3cydlJIZHIxY0czUTAxVUZNREE4cFhYN1o3?=
 =?utf-8?B?MTBKSjFlK1JnMmc2L09rTVJRQkw3em42WGxKREJXYXhZa1hjRHNLR1JmV0FP?=
 =?utf-8?B?dFl2bkJjSmhCR2F5cWgrb2NQZVlzV3BGYVE3bUJhYzNxdjZWOFMydmROVlRa?=
 =?utf-8?B?Z2hlUkNZc05HWktRSzhTZWI2SDVJa1VndUR5bmZtMVp1REtPam5yeTBwT2RT?=
 =?utf-8?B?RW5tMFJ6eTZkVlRCcWdwb1JFazFrNEo1Y0w5Q2kwUWNta3YwWGNHVnFpQkZs?=
 =?utf-8?B?TlNadjFFZlMvN004dHpLNVFqbzFMRnZRaHUxZUE5UnFLR25WNTRmalJJbDE2?=
 =?utf-8?B?U1h3dmJqVHhpZmhVd2NIckFxL3BzOVFBcmsrRkNTV3NiMFBWVjAzdHNrSWcr?=
 =?utf-8?B?QTBGc3IvOTZkK2FxVkozWDlmeGpxRitET3lYQVNrWlZkcnJBQnY3RXN0VXpr?=
 =?utf-8?B?N0ROejc4SVFuSWtjZmtBWlhiRUlWNktCZ0cwYmxrczZSRU1XMGNGMTFVTC90?=
 =?utf-8?B?cU5ocVZGSE54WmJpclk5L3NlV2VmeUpHNFRYc01YVktVQVhCQ3lZVW5EZTkv?=
 =?utf-8?B?VjlTRytXdVZlWThLTVQ5VGk5NDZQMFpreDA3LzF1RStMeFFGNSt4RmRKWjkv?=
 =?utf-8?B?Sm9pWDdsTW13cmxGTWgrTzdnNmdmdDA1dzNQSGczc2wyYXpjRHNMbmx6dW9S?=
 =?utf-8?B?OE11RGRLYVJaY2ExZDQwR1AvYnl4aTMrWm9Gd2ZHbEI0TFNwT0hvd3QwUGxF?=
 =?utf-8?B?OUxKblJHS28rYVRXTEpBZzhXc0t6SXcxbTAyT1hrWkREVVIvYURDMjlGV2s3?=
 =?utf-8?B?S1h4OElVLzFhcGNENlRObVVmaFhqa1FTN20xTGREaEpla3J6N0RZSGtLaVFo?=
 =?utf-8?B?MitGQk14dW9JZ3FEUkk4eXJZeXkvQTNFYWgrcTIwOC95clpjV2VBeit2Ym9G?=
 =?utf-8?B?SU1pRDlzWkZwaG1VYWxDMUVRK2s2eW15ak9ZMTNlQzgxbkorQVdLNDVCWE1a?=
 =?utf-8?B?VWpSZTZBaG90RTF3TlorUGQyTnVLcnllY0NJR0FSd2ZDZnVPT3kyWWVIN2Rl?=
 =?utf-8?B?R3d1eC9tVlk2aE1ZWjVWcjY5OTRIdldlR3lPWmttZ01sckxld3M4aGs5cmZ0?=
 =?utf-8?B?SnpmWEVVMkRPZkdjR2ozOGd4cG1QVjV3c243UFNNSjFtdGE5RlJUTzBtZTla?=
 =?utf-8?B?L1VkdHBsUWJBYUtsUnVEcExRd2NHZDJpd2t6aldzOFM5R3ZzcGlQbzJWSEx1?=
 =?utf-8?B?eXFJRXZJUm9yK05STFBoYW8yeHdtUXpzZm5WMDBxL2NoTVZhSmcvaDJMeFRE?=
 =?utf-8?B?TEhybFdTRVhpV3Q2cHVGMExMdG14MUNJd3hJYVJLcThRNDJvZStyMUJ0bnIv?=
 =?utf-8?B?UFU4ZTFGYWZxNVZWY1hpeTBLMzJmdTBkd3gxVWI2ejJ1dThSSWhKc1ZiNXdq?=
 =?utf-8?B?L01wUzVvQVBxR2laTk1pU09TdnRYVXRDbDhoT1ZVbXNoSlhueFFVbU53WFdi?=
 =?utf-8?B?d2EzeE1FRFNvb3RoTWRSbHErN0FqYWpSUzNjbUl4WERnYVh0MDZYMVFOR1Uy?=
 =?utf-8?B?TnpiYkIxdXJvcFZDWC9hTXluVjYyS2xadjVwOVpvSTZtUzdhRDA3L3l0T044?=
 =?utf-8?B?K0hiTkxrWDRkK2dCdHdCbWxVUXBESm5maXNMVWpPNE1Mdlg0bkNOT080cEV0?=
 =?utf-8?B?YzVhZlJxN3hBM3IwQnIrWXc0ZURtV29JLzUzazdGbXliSGN2OXNxSnZPYlFk?=
 =?utf-8?Q?Pe+Bl8YiveB8jYMNPYz6sFN6g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d588a726-366c-41bd-0937-08dc2131ad7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:20:42.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75xJ3OuoJH+e66r5G8wnEbE1ZJZ1ufb8Vh+aWQ4Cz7cUVQUXKpZiGLgkNPd68xxJR8P5SKDQOhbj3D2t8f5Jug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761

On 1/29/2024 12:55 AM, darinzon@amazon.com wrote:
> 
> From: David Arinzon <darinzon@amazon.com>
> 
> This patchset contains a set of minor and cosmetic
> changes to the ENA driver.

A couple of nits noted, but otherwise looks reasonable.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> 
> David Arinzon (11):
>    net: ena: Remove an unused field
>    net: ena: Add more documentation for RX copybreak
>    net: ena: Minor cosmetic changes
>    net: ena: Enable DIM by default
>    net: ena: Remove CQ tail pointer update
>    net: ena: Change error print during ena_device_init()
>    net: ena: Add more information on TX timeouts
>    net: ena: Relocate skb_tx_timestamp() to improve time stamping
>      accuracy
>    net: ena: Change default print level for netif_ prints
>    net: ena: handle ena_calc_io_queue_size() possible errors
>    net: ena: Reduce lines with longer column width boundary
> 
>   .../device_drivers/ethernet/amazon/ena.rst    |   6 +
>   drivers/net/ethernet/amazon/ena/ena_com.c     | 323 ++++++------------
>   drivers/net/ethernet/amazon/ena/ena_com.h     |   6 +-
>   drivers/net/ethernet/amazon/ena/ena_eth_com.c |  49 ++-
>   drivers/net/ethernet/amazon/ena/ena_eth_com.h |  39 +--
>   drivers/net/ethernet/amazon/ena/ena_netdev.c  | 161 ++++++---
>   .../net/ethernet/amazon/ena/ena_regs_defs.h   |   1 +
>   drivers/net/ethernet/amazon/ena/ena_xdp.c     |   1 -
>   8 files changed, 258 insertions(+), 328 deletions(-)
> 
> --
> 2.40.1
> 
> 

