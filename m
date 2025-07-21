Return-Path: <netdev+bounces-208705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB46B0CCF2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115E83A3632
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 21:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92B24290E;
	Mon, 21 Jul 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="opGIM+Ci"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE322D785;
	Mon, 21 Jul 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753134847; cv=fail; b=ChM4HoF5UEiBzadtXbGTGDiqv2wDWK9idhykC468XPzZdhCQLJWB6syXRlLJQPN47fVIXYP+/3vnw9Cr6Qtc89usAQiMrhxrSnGh0MiQrxQhFNVKVH0J9w8QrFcBKYmbofpWnfWlOETtApv80ZJ4aPuh79tx37Tqt+2OeaQXPFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753134847; c=relaxed/simple;
	bh=IR3v4JkBNzPadit9aIphZuYfVQZxvt4qnqsYWwuRR/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0wcLT28MxkPcr44reKD7PA50LkYeN/YJMoa1drq6oMztk+4AaC+zU/si08YsSvEMHxem/OKunYfPBPYHpb7Mqb88dIwnvCVu+C2Cbqo78Iy/6QJrCVNbQGY0dUbTBufl/0CsTckwfu9159YpN/nNZWyk4O56b388E3EfwDwsto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=opGIM+Ci; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdN7ZQBGHm+q4ix6XWU+8l+j/8Am2Szu7M76wQTSO6JJGniH6EXie/e7+ju00qjZvKq1W/V534+6HQZc1rePCLgb1ujt2gF/GXrwRr2hFPlg5f/4hxer5UZlO1J/mkcRciOdbG5LxzHqfza+Im9N0fsd5o639NR2LEdZ8bJnOQf4RQSCTOPyK6E8rivuj3FEIDJv3zGsxDCtOjcz7OXruLYHxkzB4KvMzxanNfGxfXZDL/km5ay6ngTiA+TmpeiXBBRSKMmrNqgn/7DcXOTxaBV4vukX2SGID8rpIL8qIUWvppCO1IwYcE+niLeduY2TxCqT3S5sKMPC/ZObQQeCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+ssMNMSsqPucJJ11mC/fN5fTwJoxhJgqlf7iKLYi98=;
 b=XSYw2nKktxBSLLH4jXcr/Jxiqi+krIGm5tDTMkiaLp9HOdOFUPJS4/9/VJ6ji8j7m5TlyRi1qeHR1ybcz2F4QwQQWGDuKrg6ZfTmj4aQBZ98kPLYCVWruVmFRWmh+CSr0LeMhqvgb+oWtqmm3sbt+tr9kA/QWW3kpuzXsxl0dMMVMa/XUDkonRrGv8jgyuCWXzXiWxPCp8Gq4MtiemnmxKE9fRhzNF1GRNPa8ohoQSOCw74+vUsVAc53W8ouw0t2X1S5R2OnqaFAyd/fyF/lqGH8jwPWPZsD5rb87RXEnIfTzE66N37Gv+RprnFC9N017Go+RRuNHzAb2Mq/ffISMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+ssMNMSsqPucJJ11mC/fN5fTwJoxhJgqlf7iKLYi98=;
 b=opGIM+Ci2AdvflN6IYmb/QDJMTDcT0qCQrBX4+ALuyNWK9L8dKFV0QchuZvmVHRynT9exDaSwuKXAgeowZN240DKstIIq0kbfhDObTXRW1HDbRwPU3+XdEYwPxPLSk8ErJCjaArRrU8dilgJTLWzsZfOqPCk8CscRa270cet5Kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 21:54:02 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 21:54:02 +0000
Message-ID: <6a0c5728-64a4-497a-a200-a0571ebe38f1@amd.com>
Date: Mon, 21 Jul 2025 14:54:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
To: Dong Yibo <dong100@mucse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250721113238.18615-4-dong100@mucse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: ab59100d-a677-483b-7636-08ddc8a11ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHdIVTdKVkcycERJWkRmd3BVSDRNVVYxSGJOZVBFaHY0bkcyNWZmVGZNUmlF?=
 =?utf-8?B?czFvazN1WU45VGVVMi83Wmg1Z0t4OWtoenRDUzBBMUVBdEg2aUFDZS9GTi9B?=
 =?utf-8?B?aVZ4LzhVMTJsQk9kZ1RzZjJXb1MvL2I4Mkl1RFN0THFscVhTdjFFZUtDZ1VT?=
 =?utf-8?B?dmhQbi9sV0ZJOFA5M2NSUU93aVhIRWY1MjdGNk5mZ3FISnhVUE1TbFlyb3NE?=
 =?utf-8?B?WnRVN1o0cTJFMlhHRWFnZ2lwUkR6aml2ZVNlUGNodG4zQThKTnZjODdhV1Vh?=
 =?utf-8?B?TTRwWjdhZVRhcjRGcThtaWdrUER2eElPRjUyRkR5N2NOU2NMRjhhWkpxamJL?=
 =?utf-8?B?MzNRdCtlbFlqZVZuVVUzNGdWRWthWThURm95OTFvOFVOQmNLNTVxTGFibW1W?=
 =?utf-8?B?bldqeG1peTZEMURmbGJPUHRiK1NPMlJNVGdROUZCdzVhdWkzaUsxZTBLOVI2?=
 =?utf-8?B?bFNndnZpVTlXSVlRNHRHeEtxblA0ZENRTGdpSEpHdEhuMlIxd2l5aytUczVX?=
 =?utf-8?B?WTlRL2pUa1pDU3pjaGM1VWQwZDN3YXQ4R0hMSENPWkQya25xR2ZReFVyM0R0?=
 =?utf-8?B?bGo5MUZ0NnUrd2llOFVjSGZtbllwT2JFSW0xUFAzcGV5eFpNMHNYTTVvdVZS?=
 =?utf-8?B?MDFyTFYxV25EZk5HcXkvOHFaMjhTWE52TGthQ1JuLzlBbC9CZkZZb3RhcTB4?=
 =?utf-8?B?V3JXb2JtT1E5YkhRTEhja2duOWJtMmFTczV4bWk1czQ4NDlGQUt2UHo4eG1w?=
 =?utf-8?B?SnhMNU0ya1czUnEzaWtOd0hURzdSaFptUk1XTEFoT3BGcFZsZDdlWGdhQzVD?=
 =?utf-8?B?WEdUS2FiVDBYWkhwRFFWamgwSDczTjRodllRakFlN3FVNkEyVm9aNVJsNVFy?=
 =?utf-8?B?UytxRER4Y0IwYXhhK0ZjdUhValMrVDJ2Y3p4SGx5by9SZk05NVQ1dGgxYUM1?=
 =?utf-8?B?TEMvZzZNbDRsSnRrRkdsakVCdWV3cFIvS0RianpDSmRZUmNIM1M1VDhnaldt?=
 =?utf-8?B?RWVXOXNLNWRkUE5TakFVR3VMTTN4SDZuVCs1SUlkZ3JmdjdIVmtwQmJKcVJD?=
 =?utf-8?B?UDBKak01SXlEL0huTHc2TVBiQnlxWVZYaHBlSzh2T1luMTMvczNOY0pFRHIy?=
 =?utf-8?B?MHVLbUY0Z3Q2c1hGRjlrQTI0aHlzQzhCZ1RHakM1UzBQUEJZek16UCtpWjlK?=
 =?utf-8?B?elVvWDRrVXRaOFEwZGQvd25LSGUzSVhmbWRaMkdaZmdIejRNU3N3MTVJd1JG?=
 =?utf-8?B?MHJnV1h4TWFtb0tYK0psdW1vOXp1aTFlZnE4TUxsOGJzaS9mV2RidUF1M1dI?=
 =?utf-8?B?Tk1ZODNwcitHVTFjSXJpbkU3R0JOTTh4MGRBNmFMNkxtZHJXZzA1UHRIM2Fv?=
 =?utf-8?B?SXBTa3QrbXFxNmZUelhBR3c0d09qbFhVTlh4RVdjaDY2M3JlUHhNTDNDcGQ2?=
 =?utf-8?B?a1FMc3hYeW1mQTZod29vQ0pBT256dlYvVHJZUW1vVDhGZld0NFRjQnJzck50?=
 =?utf-8?B?WHVOL0VCWmVDeWJxSkE1QmN5UlI1TkVvMzBoWFhNejhaeTNxVkdEVDVRaWxP?=
 =?utf-8?B?emF0cDFJNzhoZExkaGRidFErODZpa3FGTGVtSkhrTktGUURwZU5VcHJuNkpm?=
 =?utf-8?B?cnpzVXpOMmdHOGo2a2oxVFgrc2lwemdBelRoWXVsOERHbXY1V1lxSk5nWjlP?=
 =?utf-8?B?V2lzVVVJNVZ1ZDZZa2pxd09ybzBBY1JoYk1FRExoMHZOZExUbzlubXJJNE9I?=
 =?utf-8?B?RFpmQVlkMjFJaDVmUXFXTWxPcXZxcHhjOGc0TUx6QkJKK003WVQxM3luTWFV?=
 =?utf-8?B?a2ZxVkVtZkR1Q3E1RkNVU2JMZUNoeGtpenlUaXBVWVYxOXJiM05SWjhZb29j?=
 =?utf-8?B?L1M5VlFwY3ZEMnk3MEIxdm1XU3VRSUNZc2dHTnJYcTlCbkxUZ1lwQ0NBUnZr?=
 =?utf-8?B?QkpuZUt4cmxtQXQ0akJhSTFxTmQ2M1V0OW9Td2w0bU9QbW1oT3VrS1laWDR1?=
 =?utf-8?B?eHBwMG1LSkNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3d2UjlzLzFPbjY3VDRoRmIwQ2Rrd1NyMGlKcWZwYUNiVHpvWmZFNUlRUzVX?=
 =?utf-8?B?Wm1ubVhXV0d6ZWJWcjZHZjV5akhNTStUYVpCd0ZqdE9SY25HVXJTaW5hblFO?=
 =?utf-8?B?cVhOSkdYWkVkU3RnZkFOK0VqYTZHRDRJMVdPQlBLV2JzeWRrTDFOakhxdk5L?=
 =?utf-8?B?NXVPYnFiZE8vb2g5ZHpCUVowWDZvd2JXaTJzM1p3OURzK2NzOUVpREdNTTN0?=
 =?utf-8?B?em5BM0J4ZmhVckFPbjNXYjZreGJZT2h3M0JjMDNLNlN5TjF1YnR1TWtzc2Ri?=
 =?utf-8?B?cGN5MzlIdUh4TkZRbytHSHlTR3RHblZkcGRETHBndFdQb0UxUDRTSk04MjMy?=
 =?utf-8?B?c3dudjFPclpLdEJENTFWblc1QThGZC8vV1JVM3lMdXpDTW1GODM3QWFzVmxY?=
 =?utf-8?B?LzhwcmZQT3AxdHRQYnh2WkZTVFU0VFo2VVlwZWJ1UDdYRFpvTkVIT0kydWRN?=
 =?utf-8?B?YzBlQ1gxT3MyQ0xocnVSdXczaCtQU2NyRCtlUUNveDQzakxKVytCNWtvZlRz?=
 =?utf-8?B?Ukc2dFh5WjV4bDF6SFFMVExkWGZNQllVdnNOY3FyRjI1MUVnUGNJLzc2NzJC?=
 =?utf-8?B?dU5oRHFNYnR5L2tnU3pwQVo3UTZQdEtveGxBMVB1U3hsSXdmeStucVZrazQx?=
 =?utf-8?B?NUlCN3BmQ2ZXSitQNDEwYjNobWRHajI5SzJhYVQ5MEljVGFJc3NiUDJNTFpV?=
 =?utf-8?B?ZGFwNWpXTUI3WUV3QVBEZ3hVRCszWkt1WXhSQ2h6bThZY05mZlNVdi9KZm96?=
 =?utf-8?B?S3RDM0l2TTF2K1plUEY4UFFNb0NQTzhXS2FjWlVTN1VSWjMzT0hQdXRTN0ZR?=
 =?utf-8?B?eEpnTFJwenFQdlMxVDdDVWVJTnUyNlFWeFBsbmlHdHh5Qi9oK0V4TVlxR2Q1?=
 =?utf-8?B?OWptMmRGM2liczNzL3JGRW4yY1k5L1BmbXZHcGVZR3p3L1JKU2pqUFBaNURG?=
 =?utf-8?B?NVY2VDJWQy9CY2JHVnc4WkpoQ3ArRStrQzJMVEJ3SCt0OUJKYVdhOHUxNmJH?=
 =?utf-8?B?WTdxd3NTYnUwKzhyc3IrYXNoS0Q2VFhSZGJpL3FCZDc5N01LaFp6N1ZSQVo0?=
 =?utf-8?B?MzYvNlRFUGtOZzlXMEdpdHVvdmdZY0RnVkdVQmVWSndYbU80OEhyRVFnVUpW?=
 =?utf-8?B?T05OWlF2b2NpY2VNQTM3R09PMUxyajNjeWlXc3JUM1k5VE1vK0U1WDZ4UjNQ?=
 =?utf-8?B?VVlHSWNOVTA0WGliT085QUx0dnRmVE41OGVxNEZoTGhXYTJTNDdYNWpFTGg5?=
 =?utf-8?B?aUpSQm54d0taWEkwcjEyUmVqbWN2SWZaWGZtd1o4QlFhZGNvRE04Q2syeTBK?=
 =?utf-8?B?bVNYbjB6RGxPS2ZueXQyZVg3WnRHcUdKSXdiRmdmS3k1ckppQ1dKc2FLeGRB?=
 =?utf-8?B?YkF5c3FZbkpVby9BN2lINEJSc1RmUXU0MjJHNEVnQlhyckRrTG9MelpGcGlP?=
 =?utf-8?B?aCt1ZTQvbVR2RnQzZG41eVhjcjhyMFlxSjg4WTNDQzNKSlgwK3ZoZEtQTEpw?=
 =?utf-8?B?cUZZTGR6MFJxRDNQN3Q4ZXhaNU44SzhqYXIvanZsNDBOeCtIQU94bU15UklQ?=
 =?utf-8?B?OWJVUERnNXpBUklTdDB2a1BVMlIrVFBsSjA5S2g2MERkdU5QMzdKWndtRzZ6?=
 =?utf-8?B?SENLSHE0anVzZXU3SHFKZ1B2K256ampkOTBFdmVtZUVWNDVmaXp6WERGcmo5?=
 =?utf-8?B?VzRzODdzbWlDbEl6dXpVTzBKeTdPRUxVNitpZFJWWnF1NDF0clN4NXBQVU56?=
 =?utf-8?B?clJwVkZtaVZ4UTBYTGlqYmdtV3lMN2dudmdsWHdaT243Sld0d0xhNk5XTzhi?=
 =?utf-8?B?MklRcWpoT3pWc0RKSEFnV3AyVS9KdzVFNzF6aHVhNXhpTEJzdy9zdExvUy84?=
 =?utf-8?B?TS9ETUdQMXFhSW4wc29NMlovd0VONVQ3aXhxOG9ESEppQThMT0JiY21BMnhO?=
 =?utf-8?B?RzJUdm5VYWFHK0NtdzAvZWtMUWNmZDI2aVBKRVNVTVNnNlpURTl3bDNRLytG?=
 =?utf-8?B?UHkyWWZudXNRM29XZXd6ZE1uaGt0SEw2L1JmTm9BUDErc3hkUkxOYjI3SFgw?=
 =?utf-8?B?c0RVeE03VVc1VHhObGhnN1lvME8zb1lhYmxQVHhlc1J1eWNrS1ljUkZqUUJU?=
 =?utf-8?Q?XGkuiFSXbPQf6VbH67x+h8PvZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab59100d-a677-483b-7636-08ddc8a11ac0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 21:54:02.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uA4oJnauq7M+Tf6BTeCxCFepmmF5b9JwXstsUo/xNVoZ+jjB/LVgtVoWCPMbsL7HoncS+5+NkxUSr/AepqFVUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830



On 7/21/2025 4:32 AM, Dong Yibo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Initialize basic mbx function.
> 
> Signed-off-by: Dong Yibo <dong100@mucse.com>
> ---
>   drivers/net/ethernet/mucse/rnpgbe/Makefile    |   5 +-
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  46 ++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   5 +-
>   drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   2 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   1 +
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 623 ++++++++++++++++++
>   .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  48 ++
>   7 files changed, 727 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
>   create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> index 42c359f459d9..41177103b50c 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> @@ -5,5 +5,6 @@
>   #
> 
>   obj-$(CONFIG_MGBE) += rnpgbe.o
> -rnpgbe-objs := rnpgbe_main.o\
> -              rnpgbe_chip.o
> +rnpgbe-objs := rnpgbe_main.o \
> +              rnpgbe_chip.o \
> +              rnpgbe_mbx.o
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 2ae836fc8951..46e2bb2fe71e 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> @@ -63,9 +63,51 @@ struct mucse_mac_info {
>          int clk_csr;
>   };
> 
> +struct mucse_hw;
> +
> +enum MBX_ID {
> +       MBX_VF0 = 0,
> +       MBX_VF1,
> +       MBX_VF2,
> +       MBX_VF3,
> +       MBX_VF4,
> +       MBX_VF5,
> +       MBX_VF6,
> +       MBX_VF7,
> +       MBX_CM3CPU,
> +       MBX_FW = MBX_CM3CPU,
> +       MBX_VFCNT
> +};
> +
> +struct mucse_mbx_operations {
> +       void (*init_params)(struct mucse_hw *hw);
> +       int (*read)(struct mucse_hw *hw, u32 *msg,
> +                   u16 size, enum MBX_ID id);
> +       int (*write)(struct mucse_hw *hw, u32 *msg,
> +                    u16 size, enum MBX_ID id);
> +       int (*read_posted)(struct mucse_hw *hw, u32 *msg,
> +                          u16 size, enum MBX_ID id);
> +       int (*write_posted)(struct mucse_hw *hw, u32 *msg,
> +                           u16 size, enum MBX_ID id);
> +       int (*check_for_msg)(struct mucse_hw *hw, enum MBX_ID id);
> +       int (*check_for_ack)(struct mucse_hw *hw, enum MBX_ID id);
> +       void (*configure)(struct mucse_hw *hw, int num_vec,
> +                         bool enable);
> +};
> +
> +struct mucse_mbx_stats {
> +       u32 msgs_tx;
> +       u32 msgs_rx;
> +       u32 acks;
> +       u32 reqs;
> +       u32 rsts;
> +};
> +
>   #define MAX_VF_NUM (8)
> 
>   struct mucse_mbx_info {
> +       struct mucse_mbx_operations ops;
> +       struct mucse_mbx_stats stats;
>          u32 timeout;
>          u32 usec_delay;
>          u32 v2p_mailbox;
> @@ -99,6 +141,8 @@ struct mucse_mbx_info {
>          int share_size;
>   };
> 
> +#include "rnpgbe_mbx.h"
> +
>   struct mucse_hw {
>          void *back;
>          u8 pfvfnum;
> @@ -110,6 +154,8 @@ struct mucse_hw {
>          u16 vendor_id;
>          u16 subsystem_device_id;
>          u16 subsystem_vendor_id;
> +       int max_vfs;
> +       int max_vfs_noari;
>          enum rnpgbe_hw_type hw_type;
>          struct mucse_dma_info dma;
>          struct mucse_eth_info eth;
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> index 38c094965db9..b0e5fda632f3 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> @@ -6,6 +6,7 @@
> 
>   #include "rnpgbe.h"
>   #include "rnpgbe_hw.h"
> +#include "rnpgbe_mbx.h"
> 
>   /**
>    * rnpgbe_get_invariants_n500 - setup for hw info
> @@ -67,7 +68,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
>          mbx->fw_pf_mbox_mask = 0x2e200;
>          mbx->fw_vf_share_ram = 0x2b000;
>          mbx->share_size = 512;
> -
> +       memcpy(&hw->mbx.ops, &mucse_mbx_ops_generic, sizeof(hw->mbx.ops));
>          /* setup net feature here */
>          hw->feature_flags |= M_NET_FEATURE_SG |
>                               M_NET_FEATURE_TX_CHECKSUM |
> @@ -83,6 +84,7 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
>                               M_NET_FEATURE_STAG_OFFLOAD;
>          /* start the default ahz, update later */
>          hw->usecstocount = 125;
> +       hw->max_vfs = 7;
>   }
> 
>   /**
> @@ -117,6 +119,7 @@ static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
>          /* update hw feature */
>          hw->feature_flags |= M_HW_FEATURE_EEE;
>          hw->usecstocount = 62;
> +       hw->max_vfs_noari = 7;
>   }
> 
>   const struct rnpgbe_info rnpgbe_n500_info = {
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index 2c7372a5e88d..ff7bd9b21550 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -14,6 +14,8 @@
>   #define RNPGBE_RING_BASE (0x1000)
>   #define RNPGBE_MAC_BASE (0x20000)
>   #define RNPGBE_ETH_BASE (0x10000)
> +
> +#define RNPGBE_DMA_DUMY (0x000c)
>   /* chip resourse */
>   #define RNPGBE_MAX_QUEUES (8)
>   /* multicast control table */
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 08f773199e9b..1e8360cae560 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -114,6 +114,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>          hw->hw_addr = hw_addr;
>          hw->dma.dma_version = dma_version;
>          ii->get_invariants(hw);
> +       hw->mbx.ops.init_params(hw);
> 
>          return 0;
> 
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> new file mode 100644
> index 000000000000..56ace3057fea
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> @@ -0,0 +1,623 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 - 2025 Mucse Corporation. */
> +
> +#include <linux/pci.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include "rnpgbe.h"
> +#include "rnpgbe_mbx.h"
> +#include "rnpgbe_hw.h"
> +
> +/**
> + * mucse_read_mbx - Reads a message from the mailbox
> + * @hw: Pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to read
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +                  enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +       /* limit read to size of mailbox */
> +       if (size > mbx->size)
> +               size = mbx->size;

This is just min(size, mbx->size). There's no need to open code min().

> +
> +       if (!mbx->ops.read)
> +               return -EIO;
> +
> +       return mbx->ops.read(hw, msg, size, mbx_id);
> +}
> +
> +/**
> + * mucse_write_mbx - Write a message to the mailbox
> + * @hw: Pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to write
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +                   enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +       if (size > mbx->size)
> +               return -EINVAL;
> +
> +       if (!mbx->ops.write)
> +               return -EIO;
> +
> +       return mbx->ops.write(hw, msg, size, mbx_id);
> +}
> +
> +/**
> + * mucse_mbx_get_req - Read req from reg
> + * @hw: Pointer to the HW structure
> + * @reg: Register to read
> + *
> + * @return: the req value
> + **/
> +static u16 mucse_mbx_get_req(struct mucse_hw *hw, int reg)
> +{
> +       /* force memory barrier */
> +       mb();
> +       return ioread32(hw->hw_addr + reg) & GENMASK(15, 0);
> +}
> +
> +/**
> + * mucse_mbx_get_ack - Read ack from reg
> + * @hw: Pointer to the HW structure
> + * @reg: Register to read
> + *
> + * @return: the ack value
> + **/
> +static u16 mucse_mbx_get_ack(struct mucse_hw *hw, int reg)
> +{
> +       /* force memory barrier */
> +       mb();
> +       return (mbx_rd32(hw, reg) >> 16);
> +}
> +
> +/**
> + * mucse_mbx_inc_pf_req - Increase req
> + * @hw: Pointer to the HW structure
> + * @mbx_id: Id of vf/fw to read
> + *
> + * mucse_mbx_inc_pf_req read pf_req from hw, then write
> + * new value back after increase
> + **/
> +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw,
> +                                enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       u32 reg, v;
> +       u16 req;
> +
> +       reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
> +                                  PF2VF_COUNTER(mbx, mbx_id);
> +       v = mbx_rd32(hw, reg);
> +       req = (v & GENMASK(15, 0));
> +       req++;
> +       v &= GENMASK(31, 16);
> +       v |= req;
> +       /* force before write to hw */
> +       mb();
> +       mbx_wr32(hw, reg, v);
> +       /* update stats */

Nit, but this comment is unnecessary. Same comment for all of the other 
identical comments. They are just repeating "what" you are doing.

> +       hw->mbx.stats.msgs_tx++;
> +}
> +
> +/**
> + * mucse_mbx_inc_pf_ack - Increase ack
> + * @hw: Pointer to the HW structure
> + * @mbx_id: Id of vf/fw to read
> + *
> + * mucse_mbx_inc_pf_ack read pf_ack from hw, then write
> + * new value back after increase
> + **/
> +static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw,
> +                                enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       u32 reg, v;
> +       u16 ack;
> +
> +       reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
> +                                  PF2VF_COUNTER(mbx, mbx_id);
> +       v = mbx_rd32(hw, reg);
> +       ack = (v >> 16) & GENMASK(15, 0);
> +       ack++;
> +       v &= GENMASK(15, 0);
> +       v |= (ack << 16);
> +       /* force before write to hw */
> +       mb();
> +       mbx_wr32(hw, reg, v);
> +       /* update stats */
> +       hw->mbx.stats.msgs_rx++;
> +}
> +
> +/**
> + * mucse_check_for_msg - Checks to see if vf/fw sent us mail
> + * @hw: Pointer to the HW structure
> + * @mbx_id: Id of vf/fw to check
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_check_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +       if (!mbx->ops.check_for_msg)
> +               return -EIO;
> +
> +       return mbx->ops.check_for_msg(hw, mbx_id);
> +}
> +
> +/**
> + * mucse_check_for_ack - Checks to see if vf/fw sent us ACK
> + * @hw: Pointer to the HW structure
> + * @mbx_id: Id of vf/fw to check
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +int mucse_check_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +       if (!mbx->ops.check_for_ack)
> +               return -EIO;
> +       return mbx->ops.check_for_ack(hw, mbx_id);
> +}
> +
> +/**
> + * mucse_poll_for_msg - Wait for message notification
> + * @hw: Pointer to the HW structure
> + * @mbx_id: Id of vf/fw to poll
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int mucse_poll_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       int countdown = mbx->timeout;
> +       int val;
> +
> +       if (!countdown || !mbx->ops.check_for_msg)
> +               return -EIO;
> +
> +       return read_poll_timeout(mbx->ops.check_for_msg,
> +                                val, val == 0, mbx->usec_delay,
> +                                countdown * mbx->usec_delay,
> +                                false, hw, mbx_id);
> +}
> +
> +/**
> + * mucse_poll_for_ack - Wait for message acknowledgment
> + * @hw: Pointer to the HW structure
> + * @mbx_id: Id of vf/fw to poll
> + *
> + * @return: 0 if it successfully received a message acknowledgment
> + **/
> +static int mucse_poll_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       int countdown = mbx->timeout;
> +       int val;
> +
> +       if (!countdown || !mbx->ops.check_for_ack)
> +               return -EIO;
> +
> +       return read_poll_timeout(mbx->ops.check_for_ack,
> +                                val, val == 0, mbx->usec_delay,
> +                                countdown * mbx->usec_delay,
> +                                false, hw, mbx_id);
> +}
> +
> +/**
> + * mucse_read_posted_mbx - Wait for message notification and receive message
> + * @hw: Pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to read
> + *
> + * @return: 0 if it successfully received a message notification and
> + * copied it into the receive buffer.
> + **/
> +static int mucse_read_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +                                enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       int ret_val;
> +
> +       if (!mbx->ops.read)
> +               return -EIO;
> +
> +       ret_val = mucse_poll_for_msg(hw, mbx_id);
> +
> +       /* if ack received read message, otherwise we timed out */
> +       if (!ret_val)
> +               ret_val = mbx->ops.read(hw, msg, size, mbx_id);
> +
> +       return ret_val;

IMO a more typical flow would be the following:

ret_val = mucse_poll_for_msg();
if (ret_val)
	return ret_val;

return mbx->ops.read();

> +}
> +
> +/**
> + * mucse_write_posted_mbx - Write a message to the mailbox, wait for ack
> + * @hw: Pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to write
> + *
> + * @return: 0 if it successfully copied message into the buffer and
> + * received an ack to that message within delay * timeout period
> + **/
> +static int mucse_write_posted_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +                                 enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       int ret_val;
> +
> +       /* exit if either we can't write or there isn't a defined timeout */
> +       if (!mbx->ops.write || !mbx->timeout)
> +               return -EIO;
> +
> +       /* send msg and hold buffer lock */
> +       ret_val = mbx->ops.write(hw, msg, size, mbx_id);
> +
> +       /* if msg sent wait until we receive an ack */
> +       if (!ret_val)
> +               ret_val = mucse_poll_for_ack(hw, mbx_id);
> +
> +       return ret_val;


IMO a more typical flow would be the following:

ret_val = mbx->ops.write();
if (ret_val)
	return ret_val;

return mucse_poll_for_ack();

> +}
> +
> +/**
> + * mucse_check_for_msg_pf - checks to see if the vf/fw has sent mail
> + * @hw: Pointer to the HW structure
> + * @mbx_id: Id of vf/fw to check
> + *
> + * @return: 0 if the vf/fw has set the Status bit or else
> + * -EIO
> + **/
> +static int mucse_check_for_msg_pf(struct mucse_hw *hw,
> +                                 enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       u16 hw_req_count = 0;
> +       int ret_val = -EIO;
> +
> +       if (mbx_id == MBX_FW) {
> +               hw_req_count = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
> +               /* reg in hw should avoid 0 check */

This comment explains "what" you are doing/preventing, but if the 
comment is necessary it should explain "why" it's being done.

> +               if (mbx->mbx_feature & MBX_FEATURE_NO_ZERO) {
> +                       if (hw_req_count != 0 &&
> +                           hw_req_count != hw->mbx.fw_req) {
> +                               ret_val = 0;
> +                               hw->mbx.stats.reqs++;
> +                       }
> +               } else {
> +                       if (hw_req_count != hw->mbx.fw_req) {
> +                               ret_val = 0;
> +                               hw->mbx.stats.reqs++;
> +                       }
> +               }
> +       } else {
> +               if (mucse_mbx_get_req(hw, VF2PF_COUNTER(mbx, mbx_id)) !=
> +                   hw->mbx.vf_req[mbx_id]) {
> +                       ret_val = 0;
> +                       hw->mbx.stats.reqs++;
> +               }
> +       }
> +
> +       return ret_val;

Nit, but ret_val isn't really needed in this function. You can just 
return 0 in all of the places where you set ret_val to 0. If you get 
here you can "return -EIO".

> +}
> +
> +/**
> + * mucse_check_for_ack_pf - checks to see if the VF has ACKed
> + * @hw: Pointer to the HW structure
> + * @mbx_id: Id of vf/fw to check
> + *
> + * @return: 0 if the vf/fw has set the Status bit or else
> + * -EIO
> + **/
> +static int mucse_check_for_ack_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       int ret_val = -EIO;
> +       u16 hw_fw_ack;
> +
> +       if (mbx_id == MBX_FW) {
> +               hw_fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
> +               if (hw_fw_ack != 0 &&
> +                   hw_fw_ack != hw->mbx.fw_ack) {
> +                       ret_val = 0;
> +                       hw->mbx.stats.acks++;
> +               }
> +       } else {
> +               if (mucse_mbx_get_ack(hw, VF2PF_COUNTER(mbx, mbx_id)) !=
> +                   hw->mbx.vf_ack[mbx_id]) {
> +                       ret_val = 0;
> +                       hw->mbx.stats.acks++;
> +               }
> +       }
> +
> +       return ret_val;

Ditto on ret_val being unnecessary.

> +}
> +
> +/**
> + * mucse_obtain_mbx_lock_pf - obtain mailbox lock
> + * @hw: pointer to the HW structure
> + * @mbx_id: Id of vf/fw to obtain
> + *
> + * This function maybe used in an irq handler.


Nit, s/maybe/may be/

> + *
> + * @return: 0 if we obtained the mailbox lock
> + **/
> +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       int try_cnt = 5000, ret;
> +       u32 reg;
> +
> +       reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> +                                  PF2VF_MBOX_CTRL(mbx, mbx_id);
> +       while (try_cnt-- > 0) {
> +               /* Take ownership of the buffer */
> +               mbx_wr32(hw, reg, MBOX_PF_HOLD);
> +               /* force write back before check */
> +               wmb();
> +               if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> +                       return 0;
> +               udelay(100);
> +       }
> +       return ret;

Just as Andrew said, this is uninitialized. I don't think ret is needed 
at all in this function.

Please think about whether local variables are needed or not in the rest 
of the patches.

In this case you return 0 right away on success and can return 
-ETIMEDOUT (or whatever is appropriate) on failure.

> +}
> +
> +/**
> + * mucse_write_mbx_pf - Places a message in the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to write
> + *
> + * This function maybe used in an irq handler.
> + *
> + * @return: 0 if it successfully copied message into the buffer
> + **/
> +static int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size,
> +                             enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       u32 data_reg, ctrl_reg;
> +       int ret_val = 0;
> +       u16 i;
> +
> +       data_reg = (mbx_id == MBX_FW) ? FW_PF_SHM_DATA(mbx) :
> +                                       PF_VF_SHM_DATA(mbx, mbx_id);
> +       ctrl_reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> +                                       PF2VF_MBOX_CTRL(mbx, mbx_id);
> +       if (size > MUCSE_VFMAILBOX_SIZE)
> +               return -EINVAL;
> +
> +       /* lock the mailbox to prevent pf/vf/fw race condition */
> +       ret_val = mucse_obtain_mbx_lock_pf(hw, mbx_id);
> +       if (ret_val)
> +               goto out_no_write;

Just return directly here. No need for a goto.

> +
> +       /* copy the caller specified message to the mailbox memory buffer */
> +       for (i = 0; i < size; i++)
> +               mbx_wr32(hw, data_reg + i * 4, msg[i]);
> +
> +       /* flush msg and acks as we are overwriting the message buffer */
> +       if (mbx_id == MBX_FW) {
> +               hw->mbx.fw_ack = mucse_mbx_get_ack(hw, FW2PF_COUNTER(mbx));
> +       } else {
> +               hw->mbx.vf_ack[mbx_id] =
> +                       mucse_mbx_get_ack(hw, VF2PF_COUNTER(mbx, mbx_id));
> +       }
> +       mucse_mbx_inc_pf_req(hw, mbx_id);
> +
> +       /* Interrupt VF/FW to tell it a message
> +        * has been sent and release buffer
> +        */
> +       if (mbx->mbx_feature & MBX_FEATURE_WRITE_DELAY)
> +               udelay(300);

This delay seems arbitrary. How do you know 300us is sufficient?

> +       mbx_wr32(hw, ctrl_reg, MBOX_CTRL_REQ);
> +
> +out_no_write:

This label isn't required, unless it's used in a future patch. If that's 
the case introduce it in the future patch.

> +       return ret_val;
> +}
> +
> +/**
> + * mucse_read_mbx_pf - Read a message from the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to read
> + *
> + * This function copies a message from the mailbox buffer to the caller's
> + * memory buffer.  The presumption is that the caller knows that there was
> + * a message due to a vf/fw request so no polling for message is needed.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int mucse_read_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size,
> +                            enum MBX_ID mbx_id)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       u32 data_reg, ctrl_reg;
> +       int ret_val;
> +       u32 i;
> +
> +       data_reg = (mbx_id == MBX_FW) ? FW_PF_SHM_DATA(mbx) :
> +                                       PF_VF_SHM_DATA(mbx, mbx_id);
> +       ctrl_reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> +                                       PF2VF_MBOX_CTRL(mbx, mbx_id);
> +
> +       if (size > MUCSE_VFMAILBOX_SIZE)
> +               return -EINVAL;
> +       /* lock the mailbox to prevent pf/vf race condition */
> +       ret_val = mucse_obtain_mbx_lock_pf(hw, mbx_id);
> +       if (ret_val)
> +               goto out_no_read;
> +
> +       /* we need this */

This comment doesn't seem useful at all. Why do you need this comment?

> +       mb();
> +       /* copy the message from the mailbox memory buffer */
> +       for (i = 0; i < size; i++)
> +               msg[i] = mbx_rd32(hw, data_reg + 4 * i);
> +       mbx_wr32(hw, data_reg, 0);
> +
> +       /* update req */
> +       if (mbx_id == MBX_FW) {
> +               hw->mbx.fw_req = mucse_mbx_get_req(hw, FW2PF_COUNTER(mbx));
> +       } else {
> +               hw->mbx.vf_req[mbx_id] =
> +                       mucse_mbx_get_req(hw, VF2PF_COUNTER(mbx, mbx_id));
> +       }
> +       /* Acknowledge receipt and release mailbox, then we're done */
> +       mucse_mbx_inc_pf_ack(hw, mbx_id);
> +       /* free ownership of the buffer */
> +       mbx_wr32(hw, ctrl_reg, 0);
> +
> +out_no_read:
> +       return ret_val;
> +}
> +
> +/**
> + * mucse_mbx_reset - reset mbx info, sync info from regs
> + * @hw: Pointer to the HW structure
> + *
> + * This function reset all mbx variables to default.
> + **/
> +static void mucse_mbx_reset(struct mucse_hw *hw)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       int idx, v;
> +
> +       for (idx = 0; idx < hw->max_vfs; idx++) {
> +               v = mbx_rd32(hw, VF2PF_COUNTER(mbx, idx));
> +               hw->mbx.vf_req[idx] = v & GENMASK(15, 0);
> +               hw->mbx.vf_ack[idx] = (v >> 16) & GENMASK(15, 0);
> +               mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
> +       }
> +       v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> +       hw->mbx.fw_req = v & GENMASK(15, 0);
> +       hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> +
> +       mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> +
> +       if (PF_VF_MBOX_MASK_LO(mbx))
> +               mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx), 0);
> +       if (PF_VF_MBOX_MASK_HI(mbx))
> +               mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx), 0);
> +
> +       mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> +}
> +
> +/**
> + * mucse_mbx_configure_pf - configure mbx to use nr_vec interrupt
> + * @hw: Pointer to the HW structure
> + * @nr_vec: Vector number for mbx
> + * @enable: TRUE for enable, FALSE for disable
> + *
> + * This function configure mbx to use interrupt nr_vec.
> + **/
> +static void mucse_mbx_configure_pf(struct mucse_hw *hw, int nr_vec,
> +                                  bool enable)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +       int idx = 0;

Nit, you don't need to initialize idx. It's always initialized before 
it's used.

> +       u32 v;
> +
> +       if (enable) {
> +               for (idx = 0; idx < hw->max_vfs; idx++) {
> +                       v = mbx_rd32(hw, VF2PF_COUNTER(mbx, idx));
> +                       hw->mbx.vf_req[idx] = v & GENMASK(15, 0);
> +                       hw->mbx.vf_ack[idx] = (v >> 16) & GENMASK(15, 0);
> +
> +                       mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
> +               }
> +               v = mbx_rd32(hw, FW2PF_COUNTER(mbx));
> +               hw->mbx.fw_req = v & GENMASK(15, 0);
> +               hw->mbx.fw_ack = (v >> 16) & GENMASK(15, 0);
> +               mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> +
> +               for (idx = 0; idx < hw->max_vfs; idx++) {
> +                       /* vf to pf req interrupt */
> +                       mbx_wr32(hw, VF2PF_MBOX_VEC(mbx, idx),
> +                                nr_vec);
> +               }
> +
> +               if (PF_VF_MBOX_MASK_LO(mbx))
> +                       mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx), 0);
> +               /* allow vf to vectors */
> +
> +               if (PF_VF_MBOX_MASK_HI(mbx))
> +                       mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx), 0);
> +               /* enable irq */
> +               /* bind fw mbx to irq */
> +               mbx_wr32(hw, FW2PF_MBOX_VEC(mbx), nr_vec);
> +               /* allow CM3FW to PF MBX IRQ */
> +               mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), GENMASK(31, 16));
> +       } else {
> +               if (PF_VF_MBOX_MASK_LO(mbx))
> +                       mbx_wr32(hw, PF_VF_MBOX_MASK_LO(mbx),
> +                                GENMASK(31, 0));
> +               /* disable irq */
> +               if (PF_VF_MBOX_MASK_HI(mbx))
> +                       mbx_wr32(hw, PF_VF_MBOX_MASK_HI(mbx),
> +                                GENMASK(31, 0));
> +
> +               /* disable CM3FW to PF MBX IRQ */
> +               mbx_wr32(hw, FW_PF_MBOX_MASK(mbx), 0xfffffffe);
> +
> +               /* reset vf->pf status/ctrl */
> +               for (idx = 0; idx < hw->max_vfs; idx++)
> +                       mbx_wr32(hw, PF2VF_MBOX_CTRL(mbx, idx), 0);
> +               /* reset pf->cm3 ctrl */
> +               mbx_wr32(hw, PF2FW_MBOX_CTRL(mbx), 0);
> +               /* used to sync link status */
> +               mbx_wr32(hw, RNPGBE_DMA_DUMY, 0);
> +       }
> +}
> +
> +/**
> + * mucse_init_mbx_params_pf - set initial values for pf mailbox
> + * @hw: pointer to the HW structure
> + *
> + * Initializes the hw->mbx struct to correct values for pf mailbox
> + */
> +static void mucse_init_mbx_params_pf(struct mucse_hw *hw)
> +{
> +       struct mucse_mbx_info *mbx = &hw->mbx;
> +
> +       mbx->usec_delay = 100;
> +       mbx->timeout = (4 * 1000 * 1000) / mbx->usec_delay;
> +       mbx->stats.msgs_tx = 0;
> +       mbx->stats.msgs_rx = 0;
> +       mbx->stats.reqs = 0;
> +       mbx->stats.acks = 0;
> +       mbx->stats.rsts = 0;
> +       mbx->size = MUCSE_VFMAILBOX_SIZE;
> +
> +       mutex_init(&mbx->lock);
> +       mucse_mbx_reset(hw);
> +}
> +
> +struct mucse_mbx_operations mucse_mbx_ops_generic = {
> +       .init_params = mucse_init_mbx_params_pf,
> +       .read = mucse_read_mbx_pf,
> +       .write = mucse_write_mbx_pf,
> +       .read_posted = mucse_read_posted_mbx,
> +       .write_posted = mucse_write_posted_mbx,
> +       .check_for_msg = mucse_check_for_msg_pf,
> +       .check_for_ack = mucse_check_for_ack_pf,
> +       .configure = mucse_mbx_configure_pf,
> +};
> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> new file mode 100644
> index 000000000000..0b4183e53e61
> --- /dev/null
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2020 - 2025 Mucse Corporation. */
> +
> +#ifndef _RNPGBE_MBX_H
> +#define _RNPGBE_MBX_H
> +
> +#include "rnpgbe.h"
> +
> +/* 14 words */
> +#define MUCSE_VFMAILBOX_SIZE 14

Instead of the comment and the name, wouldn't it make more sense to 
incorporate "words" into the define? Something like:

#define MUCSE_VFMAILBOX_WORDS 14


> +/* ================ PF <--> VF mailbox ================ */
> +#define SHARE_MEM_BYTES 64
> +static inline u32 PF_VF_SHM(struct mucse_mbx_info *mbx, int vf)
> +{
> +       return mbx->pf_vf_shm_base + mbx->mbx_mem_size * vf;
> +}
> +
> +#define PF2VF_COUNTER(mbx, vf) (PF_VF_SHM(mbx, vf) + 0)
> +#define VF2PF_COUNTER(mbx, vf) (PF_VF_SHM(mbx, vf) + 4)
> +#define PF_VF_SHM_DATA(mbx, vf) (PF_VF_SHM(mbx, vf) + 8)
> +#define VF2PF_MBOX_VEC(mbx, vf) ((mbx)->vf2pf_mbox_vec_base + 4 * (vf))
> +#define PF2VF_MBOX_CTRL(mbx, vf) ((mbx)->pf2vf_mbox_ctrl_base + 4 * (vf))
> +#define PF_VF_MBOX_MASK_LO(mbx) ((mbx)->pf_vf_mbox_mask_lo)
> +#define PF_VF_MBOX_MASK_HI(mbx) ((mbx)->pf_vf_mbox_mask_hi)
> +/* ================ PF <--> FW mailbox ================ */
> +#define FW_PF_SHM(mbx) ((mbx)->fw_pf_shm_base)
> +#define FW2PF_COUNTER(mbx) (FW_PF_SHM(mbx) + 0)
> +#define PF2FW_COUNTER(mbx) (FW_PF_SHM(mbx) + 4)
> +#define FW_PF_SHM_DATA(mbx) (FW_PF_SHM(mbx) + 8)
> +#define FW2PF_MBOX_VEC(mbx) ((mbx)->fw2pf_mbox_vec)
> +#define PF2FW_MBOX_CTRL(mbx) ((mbx)->pf2fw_mbox_ctrl)
> +#define FW_PF_MBOX_MASK(mbx) ((mbx)->fw_pf_mbox_mask)
> +#define MBOX_CTRL_REQ BIT(0) /* WO */
> +#define MBOX_PF_HOLD (BIT(3)) /* VF:RO, PF:WR */
> +#define MBOX_IRQ_EN 0
> +#define MBOX_IRQ_DISABLE 1
> +#define mbx_rd32(hw, reg) m_rd_reg((hw)->hw_addr + (reg))
> +#define mbx_wr32(hw, reg, val) m_wr_reg((hw)->hw_addr + (reg), (val))
> +
> +extern struct mucse_mbx_operations mucse_mbx_ops_generic;
> +
> +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +                  enum MBX_ID mbx_id);
> +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +                   enum MBX_ID mbx_id);
> +int mucse_check_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id);
> +int mucse_check_for_ack(struct mucse_hw *hw, enum MBX_ID mbx_id);
> +#endif /* _RNPGBE_MBX_H */
> --
> 2.25.1
> 
> 


