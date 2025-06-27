Return-Path: <netdev+bounces-201789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB4DAEB0FE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541B67ACAD9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25322F764;
	Fri, 27 Jun 2025 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="migJqXC9"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564B224AE0
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011888; cv=fail; b=ZHzqvDvD8IBPO6Xv9h3Bc3tKfFnPQJZMdIQHkKWRKKI97HmXIkEgGnX3BzN7fG6OQ0osTxdYLUcfk9u3h9/DAkAVvd2mjGAROo3ieAax6psYa865tyrOvWeTQR8XmGc+HlwQ+2KwlkMEJr/piP+N0eK8W6K4rxuqtDv/H58chTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011888; c=relaxed/simple;
	bh=70pZpgFv1mLy5U8/XaGe1kikUHKxRuNnIPUxWUvImFA=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=A0+bCjt7lViPcwoNAk4152NJKhuv5fAsLzE97kCvwrHG6bhsieReYFb9JXC/iE8Xhe5DH++07SxkwP42R6c8mKRzZQ06cS8rby65zI+ncq6DcuhY1kCTLiXrz5E/runCAQGjkUc2XjC3pRNE/37dhO+8WIlBhAw28ADHVVHXNIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=migJqXC9; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGgNDWwkyLmSYJy7kjdX954ybZWgk4bf5qFng+HbJPf4MFO7rg7TP8Y2+y3AR9/SMTqKN8WLudubor3k64JnmBZKH/p7loDp0nFHsuP7xygGkzcDe75xhwsdBf6X8YgGZz5raAJfxbDqMiwx31uYfHmDuqiPMRv1S82B//TaowYgmI4PZPEyRKub4sTeLdjzJupXGU4jpv72y6R2WCd+sdiB/MHaeOjnU458xHj927eJXvkRef6q8AVXmOw5Vmls2qVPg+lXm0lsTilFCzlDN8lV+8WZQhJS0STeEUgptsXBiiPFlA3EbzPWYmB/485rf7KGAi5I1c/OPiUxYVcrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4FGMNWhTJdpEvh8+v0arvMPnWw4yH+NMSL/+LcLNSA=;
 b=l+9tF8UiG/w50EgPHofP9BSumOeny/aYBwJi4sMrUBfipkfi1II4vhvMNaBPmhsR4mmBH7rqGlRBg1kf7GD3+xkQ0p5iW4fLSuQ0BuSvq2JFmg26LcGIfsE6WVENPR33lJ3Fzh7HjEDuBipZpybm/0LCcgTtw725wdY3k14h1VAo/ukXY33vbZx3E3rYcuQu4pwct87ysIvyqYAKheOZLSmtF4ejC4/WE1w3LIMSvEJQxWhM5/V6WwtuZAuscJW1TjNAuz19pXT41btzZe/hpvL8OPbGWCNgwsWZJr1880Go51Jz+YQxEmz9K+1yDXj9y+fNkHWSdGogmmHYWM+5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4FGMNWhTJdpEvh8+v0arvMPnWw4yH+NMSL/+LcLNSA=;
 b=migJqXC9OZWaTegBXY10MFUV8qX80dZ2CTZEJrJHrN6ovu0WQroJXMixvJY4u9ci537A8Mccl9egCGm9HymYNbqoxwgQ/6mSvwEVUS6Jk73i7P6Ffa8aE8y4fjOT04DeH6NZb8EEQ8LgWbbtmyLewMXXx59FQrxXj2mNWRR/yeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by PAVPR02MB9299.eurprd02.prod.outlook.com (2603:10a6:102:320::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 08:11:20 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 08:11:19 +0000
Message-ID: <6083482b-59e2-4734-96d3-37c5a7597e9f@axis.com>
Date: Fri, 27 Jun 2025 10:11:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: phy: bcm54811: Fix the PHY initialization
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <20250626115619.3659443-1-kamilh@axis.com>
 <20250626115619.3659443-4-kamilh@axis.com>
 <aF1FmEBzO1_-HOfD@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
Cc: netdev <netdev@vger.kernel.org>
In-Reply-To: <aF1FmEBzO1_-HOfD@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|PAVPR02MB9299:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad8cd7f-8235-4da6-fd88-08ddb5523299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHU0K2NDMkpiY3hXekNyell5L2ZHK1cvcWVSWlgyakYwdko0VHU5eHQzNllw?=
 =?utf-8?B?VnRYcVRDcURqc3M5YlNYUlBxbUc4QWcwZ0xjZVhPUXROM3pEbXBHQVg0NFNW?=
 =?utf-8?B?TGlxRVppbzVjdUF2S3NJa042WGxkUU81VC9pK1F0OU1HNzFEZ2hHSDA4a21V?=
 =?utf-8?B?cGN0bUUrOVg1RjJWL1JxQTBPVks2V2NlYmM1UTRpZGdsNWwxN0tmc1EyQ3gr?=
 =?utf-8?B?QzNmdHJuNzZMaWN5TjNxQWZFTDdRekUvUHc3ZFB5dytkV0RWbTBMek5NbXRv?=
 =?utf-8?B?RG5NTFZ1cFB6RERHclBEaDVEaG9BKzM2U0VGazd5aVcrY1czcVhiVjNVTngr?=
 =?utf-8?B?TTdpYkNTMlZwMEM2RGhXQXMxbXloQWpLekRzUlZIeDJYeWttdzI1blYvb2J4?=
 =?utf-8?B?OGJraUNidWxrZFRCRnJIUXlwM09IcnkvaCtVdFZqQlJCN1Y0Y1R3UUUwVUR2?=
 =?utf-8?B?ZHpkek0xUlNHSnp1R3MrSk9WanIybjIvVWpvS3VQUHR3bnJ5TmN6ZFhXaFlX?=
 =?utf-8?B?M2pacHlZTENXMkVBVlluZEN6eTlSOElsUkplWjhUR3c3TEVIN1ZmSDNsSEF1?=
 =?utf-8?B?UUFVYndBWGtNTTlVczIvT2tJZGFPZ1hjNVBWZmJQcmFZUjlMZDZ0dnJ2a1Bl?=
 =?utf-8?B?cXFrTzBZREpCRkNHVndjc0tTbXhYaXBSMEpHQ3ZQN25MZmZoUmJ3VDFmMEtQ?=
 =?utf-8?B?a1lmYmxkVStFL2FhSm9QVyt3bFRzbkRWZnhPdG82djFSL1I4VXhyTXF3Qk4r?=
 =?utf-8?B?MU5hc280bGt0c2FBSFFBT3BtOGp3d3VNcG9pMitVR2o1VmpnRE9aUVdyd3Fl?=
 =?utf-8?B?STVFbDluTWFsb0pWRTQxREJXSk5mdG85WlA1V3dXdnBsTFU1bitadXFwZ080?=
 =?utf-8?B?dmZ0MllXZ3R5RHQ2TzI3ZE9BeWtZb1QrMnpERnNqRTdaWlhSQkNIK21tNWYw?=
 =?utf-8?B?MlVEd3NzOEU4Z1hrV3kwZ0ZwcVF0c0lVUW03ZTVFVkEzMUJOa0haa1I2QVB2?=
 =?utf-8?B?SS9ZTmJyQUx5M0NLbG12cDZZeVVQU3dqeHFLZUdWVktoL1EwZk5SUitSZ05N?=
 =?utf-8?B?a3l5cFZmVEdTWGp3NUN0V3MxbDdGVnhaYW9vNDRHcTVRNC8xWUk0ZVlxMGxL?=
 =?utf-8?B?QXFpR0NDNlQvamYzcG5CZG8vNXgrUURla3JnTUIwL29CRFJuY015NFBkb1pu?=
 =?utf-8?B?QlVWRmFlejVrRlhXaEVaREFZbXdOd3JRV0pPcHJ4THp6ZnhGdy9vRXdDa2VV?=
 =?utf-8?B?QVhFY09BZWtXWE1rZC9kazV1UW5DVTNSZGozRThHbTRVV1JUK0lQTENNSi8v?=
 =?utf-8?B?bEduWDUwT01VY3RiQU9qUnVEUHVKMkpNaVRvQy9tcENVQlB4WjcxdnIwTExv?=
 =?utf-8?B?RFFhckdoTTFPOVo4OUxiVzkvZmVPb0JYcVY5WWE2Ylo5ejR5cEsyKzJtcmZU?=
 =?utf-8?B?R2t0d0tyQWcxUGJORHp5M2hOUGxnNWhKT0dUUmZmS2d5KzJBNFdINWpLcEkr?=
 =?utf-8?B?dURoRmZRdXh1bUpxUytmZHo2eXRySTRMVThRTStsc0lVTWMzdDdQTWVhQmVZ?=
 =?utf-8?B?bXVISWQyNUNTUTNtN3pSdGVveTY0djJNRDhoRnJPRW45YUsraERnZlZ0djRI?=
 =?utf-8?B?aFV3aTA1OXR3SGU4RHRubEkxa1JIQndCSll5RnNYMGZoOENkYWlvSEM1SW1n?=
 =?utf-8?B?TzJmRElkTmJhTWNhcCtPbXljMzR6aVV6VWRuWHRKYW8xblJ1OFVIemhhdVI0?=
 =?utf-8?B?NzVRNW9KcHdkVlo4TzBxN3Z0Znl6dE9GMVRQbnVqM2Q3ZlZuZUNuZEdYY3hZ?=
 =?utf-8?B?eHdnOXFkOTcvNTdZa0VEaU83NHFRT3dzYTJMRTQvYW9PNkRmQzIwVkpxQVFO?=
 =?utf-8?B?T1BxNUF5L01LTStBR2E2SjhHeTNXZHVwYm5nVmJFUG4wL0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWVmdGNGb0lqUlI1SG5IM0FoZ3FIYmVTYTlmMTNsTVM1YzArMkhOVFp0amts?=
 =?utf-8?B?djZyK1JsUjIvVWI4b2ZTVFBtR2daYU5Eczh2OW5YOWx3VHRKZGNLVG94YnlL?=
 =?utf-8?B?bjljZVhtekZoRGk1VXdSa29BSzNPRDk5N3cybEVnMFlvQk5EVzV4RVdCUVJN?=
 =?utf-8?B?eFFQQjhwdStTVGgxdlNETW5mc0NyUUlTWnBmZmEvL2pDRXZGMUFmeVIzTjla?=
 =?utf-8?B?REE3Y0F1V2t4MUhFM2R2T0s5NlVTVE5yeSt0MzNxMXBHeVl2TldsRTBmd2ZX?=
 =?utf-8?B?Z0dZRUx4eW9KMzFHRnZveTcwcVhmYkRFZjcxSTBmQWQwUUs2V0wwUi9ZSkNp?=
 =?utf-8?B?bitrNXg3aHRCTThsTUh4ZHRESENqcDdQd01lVDhnRkVFaWhkSm9lT2RmZThS?=
 =?utf-8?B?eGdoZ2lYUlN2M1RYdlc1RnNHOUJrazhiRTFJUnl3dkx2WHBXbVBXVEoyWnBW?=
 =?utf-8?B?MHhHQndUNjgzekwzZmdEeEJSdXJ0WUdKWVY0cUJNemhUYnZ1T0JnSGR2RFUv?=
 =?utf-8?B?bnZWcWxHWGUzVTRIaXVvL1plUnBXSFJNNCtxMzJxMG9WUFI5a3ExTG52L0Zj?=
 =?utf-8?B?SnJ6QmlCMjlWOVkyMU9kZmo1dU1hZ2NURjJhSFhJZ0ZGcXo3MkhwckhnZmJ6?=
 =?utf-8?B?QnJ1RmdMeERvRURPWlE3d01IdlJvcUMxTTgvNDRnT3pCbDNseUcxZ01LUm11?=
 =?utf-8?B?NWw5NlhFM2ZGUXlpUkI3TmREUEMrY1hLZTZuend1VlVHbCtMUWRmRTdyT2tO?=
 =?utf-8?B?ZC9NNG5CY3JNM3hVeWFVUTlQWHVNL0FuZFlTUlFnMEVTelRiZlJpV2lHN3Jm?=
 =?utf-8?B?M2YzbGd1WlQ4ckFDcEJ3NTY4amR5cmNadEVZKzZjZkZFM0xnaG5OMEZ5QzRQ?=
 =?utf-8?B?VDFqUVUxVjdlUXVJUnk1UEMwVlU2akJXYm1rYkZkNk43QzVtYk9HQkxramEx?=
 =?utf-8?B?T0RFdE9qeHM1aG5SZ3hXUmFNK2VRblFQZjd4bG9LaHQ3QmpscmJqS0QwRGhk?=
 =?utf-8?B?UmNjbDRxWE9Va0NOUk1zd2FWa3AzMUIvT21TRkVzVGEwZlpQRFNXMmpyZ3N0?=
 =?utf-8?B?UUh3SUJRQUlUNjdnVzlDVHNxZnVyWU1oSnFObTRKdFNjZVc4cTJTUFI1bFg2?=
 =?utf-8?B?d0VNRXIzYk1WQTFrcytCSFJSK1YrbFZGYlhDYzFCU0U4cUxZMmdQcTFvMEZr?=
 =?utf-8?B?QmlNV2t1VFJzNlZWM3dFUkE3YlRzK2NlaEgyQmpiWk1BSlZlSHQzTWwwZjRQ?=
 =?utf-8?B?NlNYbVBCVm9hWHdHQ0hlczNsZ1RTTlcxWEhubjUwYXRYei83aUZ6ekZ4U1F1?=
 =?utf-8?B?cGJrUDdjSjF0cnovaW1LbUlMY1d0U3N5ZFNaSHZHR3B4Ump2SmtaeGJCUUZY?=
 =?utf-8?B?QU4zcTFUSWU1aTZjaUpIczJNSWdwajRrVnFCckhGOXI3ajI0QjFVWk12YW1v?=
 =?utf-8?B?RUR3SGJKR2dxa2Jhb0JZdkdqTXg4YzR2OEg5UWJ2eFdHM2dJV0ZZOGVRQzda?=
 =?utf-8?B?SnVNcjd5SXYzYlRmYU1zY2FTZXlKajZqZmJGRmpIaHdJNGdnUDBWR1U4SVh6?=
 =?utf-8?B?ZFpDVWRvWlNqNGtLWEtVblJYSUhDQzBjL1hpdi9VazFiQVlLejZXNnZEMUJ4?=
 =?utf-8?B?QXJEbnZSREVIM0NkU1ZtRXBhUk1XcHZEMGFyUFp5VFBzU1lEU0pkOTFSbW5o?=
 =?utf-8?B?K2k5bzdGTHp0WmIxc0p1ZXoyNlpJMjJKUlFmTFpGRHRYYll0NUs4K0kvQWZ0?=
 =?utf-8?B?VitqdEw5amZLQTZlcDdGakFZTTJRVnlKby9BNzFLbDVuZ3ZTMUFHK3hiTW16?=
 =?utf-8?B?NmhWQnlKWHJaZ3Y4QTlxK0tzZHpmSFIvUFZlamNVRDVONkRYMXBxTXlRQnp1?=
 =?utf-8?B?Zm5oZ3U3eHdHVGN1eWZzT21HOW4rbXRqcC9MbVBjSEVoY21RN3EvZVVFYTNY?=
 =?utf-8?B?UHpITk56WDdON1N1d3RhREZ0TXZma3dYeHJPVll3SDBKSmlNNGJBZWlXRTQ3?=
 =?utf-8?B?MHJZWjMwMVV3dTJBK3lkSDFDOEFBeUEya2JEelFzQkl0QXRDTmsyREN1Mml3?=
 =?utf-8?B?bVBhbU9rNUk3UEJ1eXN0SXpydWpSaU5Ud3ZZVS84ZkF5RFo3d3RMMit3c0ZY?=
 =?utf-8?Q?VjWtkfXvS2tbmlky52vGI9+jR?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad8cd7f-8235-4da6-fd88-08ddb5523299
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 08:11:19.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoEzUvErJje2xNFm4Za+rNEKToZeCj7Ul9/tSvOejUpYaONqkb424yuIXJBs8pl0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9299



On 6/26/25 15:05, Russell King (Oracle) wrote:
> On Thu, Jun 26, 2025 at 01:56:19PM +0200, Kamil Horák - 2N wrote:
>> +		/* BCM54811 is not capable of LDS but the corresponding bit
>> +		 * in LRESR is set to 1 and marked "Ignore" in the datasheet.
>> +		 * So we must read the bcm54811 as unable to auto-negotiate
>> +		 * in BroadR-Reach mode.
>> +		 */
>> +		aneg = (BRCM_PHY_MODEL(phydev) != PHY_ID_BCM54811) ?
>> +			(val & LRESR_LDSABILITY) : 0;
> 
> Wouldn't:
> 
> 		if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54811)
> 			aneg = 0;
> 		else
> 			aneg = val & LRESR_LDSABILITY;
> 
> be more readable?
yes of course
changed
> 


