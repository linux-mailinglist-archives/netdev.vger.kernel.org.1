Return-Path: <netdev+bounces-226966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D5BA67DA
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 06:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADB4178BFC
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 04:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5182882D0;
	Sun, 28 Sep 2025 04:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bi+YoCx1"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BC258ED6
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759034376; cv=fail; b=fh05vjpPlauxadnKfMn1TgH9Y7+JSSa2JfLriJ45kXkh9KlCDCqMzZjdpPCqWWPmkdNwFa6fOyFw9lqEd/h0jAUQWvyjaDTCpVK959HC7t7t/YrOoWy+6gWr3JmiHlKg3i2bh97kk7e/dj1unuj+MnJqaQ9gELzr0+jxDtr3kNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759034376; c=relaxed/simple;
	bh=y+phbzRhHwNl1CBsaEkksAMhoKa7MVeoHX+s987xPBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bl563xbwHa18JT2z2rC7jJ48NOs1lbA15ozlCkjzivo/B72nqlqbIeh6vcVjY9lIBLDp+lJqJo58YVhbPw1ZSzXw3gBuChLG16RYIuDAc/HSR8DhDY4aKnjPk5xvLmaX6vtHQ4spz/jzw+oUJ7PS1EjS1q6O5EvsGRXu2Pi43mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bi+YoCx1; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABzhCkDEWwdi9Pq5CnASUSioPu8sovyVVuG8fW9jc6K+F+x7boXlhN1HPbYLxnm8OUDu3E6awZeTot/GFrH1j13zfoe+dLl24avO1bhN14GzsqwsLN+8xIq9umZAT3NiHOxgWqNzNeWqy0xUxqO5+1jtEIuPczgyzbZC8a1JJ8QYGZoK6H6+qR57t5bCTV80CHg29lQL8/gj2vOn8PnrEw/eAYLDaOwsBrdL0UNvUtjV8UUp4or+35zlTnBdyeoUw9UI6MLA4nB1ld6CAN+1ZK0FGR7TszaHFHmi8zV6GbqvzcQLDJrfDC+zbbXE5AOncjomLS4QAtttS/uU92dgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYhB0CYAtpPB0CLoUEXPWQ+kmzqIcbHQsIf+OjD6JGA=;
 b=k7ldn6YjyAgVTQKSHIMUSZID1FNI54DF2+pq0Gpnd8aAap/S21RK1K4EjOW09n0nWvDR3unGhpi78sgWXLYfmNYOSysdxFpLdIvrzSkp8vi1MusKgAxGCtJlMk0f/IXE+VPb8th6wAwoB+yGFLayDUapTRHbfAoyCwuagV2dJvB71MjtHSeCVWRWc/dXjeax8+KDl722mUc+/kdShOvAg3IRsKZfyiFIaSzAtml0qB4H9Z3SZ0yNIu3UNutfBq+o9UTJlIk787agzIKxvAIlBBRWiYj0JGXk4wqedE0Odq5BM8/VtKtd7un/txextNJz0Qg3DVMqqquZQfZxYGEkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYhB0CYAtpPB0CLoUEXPWQ+kmzqIcbHQsIf+OjD6JGA=;
 b=Bi+YoCx15eymydzUW1xuFFBAwJ5BYZzfZLmq5yT4RnF5SEjqrx7rBnn1p25aMfPg5W7PbRMd0PYmS0bAeTVHLp8q14P0OSZUgBJGOWUFbRm1eboz2w4rBNT937aIstRHwXp6q2rhqp41hCEvOZPN7u/sFWggUo69vUHOeJSlrKHLlfO//5wkpZtiN01l9lkUOf+UeBt0sk6JsZ7YXDGzYhKS3wpwl6vYaeDvRl3jEcrIEDVweyeEztm8iEtvG6Gli+EqTcTwUsJo7zGrRacmDK8Pga37ybI1U4YuvwCA6EeV5ZeDx2w1jYtx1ZNia2D9g86ib1qB+xxhyjJnDjwSXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sun, 28 Sep
 2025 04:39:31 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%4]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 04:39:31 +0000
Message-ID: <4532bc48-ca59-4f04-a3f4-a66d4be4ac1b@nvidia.com>
Date: Sat, 27 Sep 2025 23:39:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 11/11] virtio_net: Add get ethtool flow rules
 ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-12-danielj@nvidia.com>
 <20250925164053-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925164053-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:6e::10) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: d178efc6-7455-42a5-62a8-08ddfe490437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0kxb1ZSV0xzblZxdi9QbjBxcEZ2RmhGOGdrU3UwYUpqb1VvaEZVREtXZjVk?=
 =?utf-8?B?NnkrUlgxdDh3MzNPcGFGVXZFa2kvZDlNK0FOajZJN2RTcm4vS0lEK2NOaWk5?=
 =?utf-8?B?aVE2cS92eTBvTW42aUx4U1MybDdTWFlXQUUwQ2prckgvOVZHa1lHbTd6bXF5?=
 =?utf-8?B?Tmt3cks5UnNIc2M1akdTWEpBZVlTemQxeWNqV3NPU1RMWktqVlRSSlRuQlBU?=
 =?utf-8?B?SDdsTzFPSmprNCthYmttUFlQa1VhbGx6MXBUZTU5UzU1akF2MnZYVk9rN2Ni?=
 =?utf-8?B?bkJFbjRkVi8yZDZTZ2RrYjgva0dKeHIxcVBDRVRXK2ZISWFUM3FYNnZBcHZl?=
 =?utf-8?B?dHhScE03RWtxM1laSDREMVNiQm12NUI4TEUyU1h5c0NqeEJVNUUwTkRNUSsv?=
 =?utf-8?B?Ynd1Z2JqUTV6Y3o4VFZqRUQxSVp3OEk4Sk9tUGdidlo5QTRhSXU2Q3A1Z2k5?=
 =?utf-8?B?NWNGYXpocUM2TTcvaWV6RmVJM25aN0xHb0JzdTI0NjFULzVaeG9WMURSNEZv?=
 =?utf-8?B?M1czYjZBcElCOFZqMnlqMHY3c3hFajhCUmhYM2ZxUmhXbVNVVzBUMlJ4dzJJ?=
 =?utf-8?B?bm45ZDBqcXd2TnFTSVFzbmV3SHNxV01DL0I1ZzZTZTNOZkxxNzRJbkk3V2M0?=
 =?utf-8?B?OEd5WHBYaitjcm9tQkcreERqVVJueWpNWExKM2JrZWVkNHBqQUJDbkx2Vk02?=
 =?utf-8?B?Mm92L2xlSXpaWWV2clVyY0dKd1VSeDZRYkRybmhGS2dHeWYxY1JDRmVEeFlI?=
 =?utf-8?B?WGUyeW1yaEphRGRseEdzVG5uWmdsTVpEakhJUTBUb3ZTTllwZnpJZUZWN1Mw?=
 =?utf-8?B?Wmk4ZHpIT0x0djhTRllicEV4WCs2MHdPRURlWXRGdUxEck5aRmFld0djSXRS?=
 =?utf-8?B?VHVQamt4U1VydDJPRFJaTEpqVk9TODFQdnpCUnU4RXUvNnNmZ2FPT0NXZXN4?=
 =?utf-8?B?emMxZVdDNENrcTBsVTloR2RaNmpxMVhhTDZLOHhSUi9WNndiV1VyS2NQWktC?=
 =?utf-8?B?d256NlpWZkdIdXpzWXpLNXRYZk42WlRjcm5EUUwvYjg0WjJZM01hZlhwQzhI?=
 =?utf-8?B?Z0NBWStsQy9TOXFkYlA4RFJlWWFEQWYwT2FXNnhIdVJvKzhTcUdPb2J2TUdZ?=
 =?utf-8?B?OVdyRnlyODlPMkNnRkhiMzBjRmR1eFFHcWRqeUNIY2lUWHNsOUwxYnYvWldN?=
 =?utf-8?B?NElWUFV4ZGdRK2l4NFlxeXRXUHVEbXRTSVlQcWdXRzluNGxLamFQL1IrLzJY?=
 =?utf-8?B?YTVBK2FDT0JYdXFFNjZ5K2hXVjJLL0V2OFlpMENISzJrSkF4VU14U0dNK01T?=
 =?utf-8?B?VlROSmFCZU1wSG1MbmRxNjVScmtUZjFZbFNyeVVoSGdnNGdIczlGWm5oWDZP?=
 =?utf-8?B?VTIxR0pmMGRaRy93WHFWU0IxSlh2c0h4UW5uYkRUZWlZUjE5YUR1MGRCclJR?=
 =?utf-8?B?Z3pUd3VsM01nZnRoejIxWFMvMVluYXB3OHFudktBZmhMNml1RUdQeG41Uzdz?=
 =?utf-8?B?U2tvZGxLdEoxQTgzc3RDSjFENGxIVnpNczJhUXh3djZXakpjaWIvdExDOS9i?=
 =?utf-8?B?ZE80YlhYb0FLSGN1QUUxYU1NeGs4WTlGeUlPYSswZE5YWjlFR0RGTXBMaXh4?=
 =?utf-8?B?QnQxb2pKMmY3OTVCNU5CS0c0K2ptQzhzWFZ0S3dqNkMxdWR5bFozS2ZBMGFB?=
 =?utf-8?B?Z1V1YS9vRWJldkE5UCtLQ1hNWFNQK3RRbjJ1dTZBWjNYR3ltZ1BsRXh6YzNk?=
 =?utf-8?B?YWVVWlY5Z3RFd0ExODRUNTdnc2hPTllaV3BLVThvRCtqalRqc0FSTFlqci9M?=
 =?utf-8?B?Ym9TQXE3NkNET25xblNEV2Rtc1lQK0dhK2UrRDlBVk5xYTB4amVDeVYyR09x?=
 =?utf-8?B?QnJMeXBaQ25OMExPWDE1TEFiOVdTVUNEbjZObDViSDRXd1l5SEtTckhqWk4v?=
 =?utf-8?Q?NvbnctYfWBzBZ8t4n/61tm6DfpuNJADX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlBNRkRVZ3hYZmI0ZVFUNnlqMEVGYi9zNUFHZENFZWVPZ3FmVldtcUdwYjJW?=
 =?utf-8?B?dzdmOW0vT3ZPbXAvMTdqbllkSTZmaVBMcFFQbTlIRUxiNHJFVFpyZW5Ub25i?=
 =?utf-8?B?U1B6UnFZaXZxd0Zzd095dFhDakQ1aFRBVjBySFo2NWZ1V1lOQnl4STB3S0Ry?=
 =?utf-8?B?a05zblJKUklYMk04VEVLaGtVZHA5TkJDZGlTWUVOWHJNMW1IVmRTWHd3dGht?=
 =?utf-8?B?RVNTckN5YXMxWW1rK3g4aDFQL3pHcG50aVR5RGRNSE1DTVo1NFhvTmRHOTBR?=
 =?utf-8?B?V0hocFgxMFd6OWErNVZid1FFQzJkekJzS1ZVcG0zZEVWb0JjWm02RDhXTEZP?=
 =?utf-8?B?UytWYkw4TzhQYnp5eUxHbEZyalZrY2s2NVBOOHF3a3F3Z2JSSTRpcmxVMzhV?=
 =?utf-8?B?YVloVGZVeWdBVVVyTndkbW9DUnNYYUNsVUoxSFhhYmkvUVlOblRwSzZGWU9n?=
 =?utf-8?B?Y3pBRXB2a2Y1Y2w0R1Vwb0c0SVpsU3M0ZlF0L2g4RDMxdDEzYmFyTkF0YjZJ?=
 =?utf-8?B?ZDVmN2labmhDTWhISklaSENTd1ZwTlZFK3cxMFFZK0d1d3JXOFI4RmxuTnFr?=
 =?utf-8?B?NEM1L0Q2bGtWYmJ0LzJrV24wcUl1K3VNbjBPaVRXVjMvNzJRWkFSOFNGVm8v?=
 =?utf-8?B?bWlNL1lQRk9TVGthRDIzWHdEaDdSc2c0SW9pL1JDOTk0S2gyVWRibU4wdUNO?=
 =?utf-8?B?NTBLc3RHR0pCZzRZMWI2UDNVM01LSWtjTTlGbElQS29JVXA5djFwK1pPYzhi?=
 =?utf-8?B?cWh6bmlXVjFLd2o3Ylc1WkNoTTQ1dHp3YTcvTzFGQkg2MlpRNWRWSFFpbDEv?=
 =?utf-8?B?UkVBRm9Nekw2ckZzZFB3OGpkRmJseFF0MnI5ZVBRNi8yV3VnNEw5M0FDRXdG?=
 =?utf-8?B?YlgrVnYybjA3Qk1OZmFSNmtzSEFOWllSbXEvUS9HRU12WnZnalpickt0OGNh?=
 =?utf-8?B?TmVjSTRDZExDLzZGT2MrZ1RyY2dmNk8vTk9TMm1PTUhsVXdtYytuSXExbTR5?=
 =?utf-8?B?bDhOd0lJNHl2bDRnbWxBcVZFOEUzZ2J3YWI4OWpkeW83YUNKZlhqNjFqSnJ0?=
 =?utf-8?B?S092SjJGTVdVR1RiMlpwUWNsRkdGeld2MnVqM3JwSzE2dndLVTl2bFovTEt2?=
 =?utf-8?B?bmJYZzJ5a0hpU1dLVml5dnAvaFdMUThDTjYrNVcyQWlpVS9lU1VHcy9VRk9o?=
 =?utf-8?B?SFplcklOcEZmV0pIYmJCaEhObjUzdUdGNWNpU0FxaUlPMVNUdm04TWFTRzJC?=
 =?utf-8?B?V20rNUlONFZPVDU2Q0w1YmVOQ2RQL3F1aGM4aHNZa1dMWVRLM2hnTEt1UXFV?=
 =?utf-8?B?RXl6b2tBMFBUTGV4NjJyV2JXQUN2SEFBbTY2RStXVXFrZVJJU1k4Rm9ZL3JI?=
 =?utf-8?B?L3NPc3JSNGEvV3JnbGlEOVNZb1BjdTh1NlN5MlQrSkNjMmhYWGdjTURpZXdm?=
 =?utf-8?B?cWt1UjJ5SHAyOEFlNHNlTEhMVG8ycHR6anBUYU5RMVloVGxuRFVYY2grOVJT?=
 =?utf-8?B?L1dlc1ZEbDd6UnFyaDVaZTFlblRNYjZCRGV0citIV0tMYzhDVk1sTTNZY0Zw?=
 =?utf-8?B?WCtrMUxMTjFVSmR5U3VIdmYxN1JicDBrdnVSbFQ3c21DZlhhb1IzR1BBNVE2?=
 =?utf-8?B?VlJmUmlxRkhnaC9heHF0bktldTJvOXJndTA1UGZmcmF6TWZlTjVDV1BUamxH?=
 =?utf-8?B?OTFEcVZLSEZQMnYvZ00ySUdCdEtacU1YT05TRnNMNnJ0QTRzUTdPTitOTWZG?=
 =?utf-8?B?TEJyVU1QbTRCYTRQM1BJYXFlbzRoMHdEdzBpdGZvVlNVdElHQWVGajJJL2sx?=
 =?utf-8?B?aEhuWWJFQTBvVkhrckFVaU01dEFFeG1wTjlLNkZhdUtMNEd4Z0FxdWhNS0N4?=
 =?utf-8?B?WjQvMjhiNmQzcm9HaXN1WjhYTFI5bml0aW5LZ2FrL2RQMlBmVEN5ekJuRWRy?=
 =?utf-8?B?RGY4NjlkbmdwNEtTbnd6QjlRUmVpYjBCcDB2OUk0UVdMbERXZzUzZVFDTmhq?=
 =?utf-8?B?YnZrTFdFNXpud0xrYXV3aTZJMkljTmNkNUxuNTVoakY4OEswbUZDU05YaEo2?=
 =?utf-8?B?WUxSSEl2K096Y0RoZC9kNWZISkNYNFhBSVh1TERjK0xkRFVpbHFxdGRFNEFH?=
 =?utf-8?Q?13pzKUxkasbpdNAHCvudnkQqC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d178efc6-7455-42a5-62a8-08ddfe490437
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 04:39:31.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mK57eUyHKrRgq8se2db7n9shbex1hyviQQo7zBMXcjTgY7zQ3wZidhb9KPzCkoppOv+rNlLYQMD8KzHnAzAAbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454

On 9/25/25 3:44 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 23, 2025 at 09:19:20AM -0500, Daniel Jurgens wrote:
>> - Get total number of rules. There's no user interface for this. It is

>> +int virtnet_ethtool_get_flow_count(struct virtnet_ff *ff,
>> +				   struct ethtool_rxnfc *info)
>> +{
>> +	if (!ff->ff_supported)
>> +		return -EOPNOTSUPP;
>> +
>> +	info->rule_cnt = ff->ethtool.num_rules;
>> +	info->data = le32_to_cpu(ff->ff_caps->rules_limit) | RX_CLS_LOC_SPECIAL;
> 
> hmm. what if rules_limit has the high bit set?
> or matches any of
> #define RX_CLS_LOC_ANY          0xffffffff
> #define RX_CLS_LOC_FIRST        0xfffffffe
> #define RX_CLS_LOC_LAST         0xfffffffd
> by chance?
> 

FIRST, LAST, and ANY are only used in the insert rule flows (in the
userspace tool, not the kernel).

SPECIAL is used get flow count to advertise the capability that we
support ANY on insert.

Since we do support ANY on insert there's no harm if rules limit has the
high bit set.

As a practical matter I can't imagine a rules within 3 orders of
magnitude of 2B.

If you'd like I can mask off that bit setting the caps, but I don't
think it's needed.



