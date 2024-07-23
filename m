Return-Path: <netdev+bounces-112590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64F93A1D8
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79535B2283B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF48153565;
	Tue, 23 Jul 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yx2WrW1v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A9152DED;
	Tue, 23 Jul 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742240; cv=fail; b=pgUKxV3T3O/wBAN0hGM/i0KAdBkyp4vnuzjnaHRj8mjQGgVmcsiIr5lGokm1J/L9KUyv1/Y8vki7/ZFXxXzgqjGlFLtNvJI+adOWYAKnCE2erQqXlNqLNHb3yFl5b6XXCRL/K5gK/CUUerz3xvnW5rq4Q70jo2J30uUq/nit58Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742240; c=relaxed/simple;
	bh=sypmGApwBWct34q8rSXQGMX7Z9mrNqS3lt5sg5rmD80=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uEKTzrwsAwWwvWXFG0oVQBDhbC/ecQPVP9PRspNkvxDYb4rOIq/NHEk9lAYxyBVZd6wubZHqOwcCIw9ASJbuAOX7mXqdp/NB+0D5GE2lmyalc27A41RtSnRw1IoALkuh9fewUHe0ywOEBGdIQf3BCjJtDeOKCbTOYnseXwKEPS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yx2WrW1v; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBZFTiNvcwijuwhf+mUfJNISvzb/OqZP4ugPk7JV4VUDpo4xKJf+hAeZOn2u0ig5az0J0B8gQOaX6xXdwzFVJ17lSLZyAec7yqC/yzPeLoJkmhWgtrbAz98HV8IaYoJxWecYX4DLBXycEf4EFeVAhIO04wVUz4H9SgYtV6zpun2bU0nakzBtDxJOCHnowHfW/a9eSCrUkAGp1rBx5r2Yf9mz5FG4WrS21VmPvvj+3KIsHBD4FO5sanTNX2Ll30rMfv2nFMMsuhf2XJtrLfEFmzUZR+iwXl351sgfHtfj3OaQ3PMZdNmlMiHCDR/CQ6ltSxporypL7zp+n7muokVucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b+a9QyXm8VPQdg3Q282L5MgszBJHCuRbTnv73j6YkQ=;
 b=BMjUeciATgJNwTJBMB8oIWOEzczoqxgdCbpeoNtvI0pBtiz6BFs8ohRcP5ZHWsVVXYMm4a4L61X/jQHCUcVWfZrFxE0V6xcTRSyPMVQkacEpTSQ7ZDp1U14BjytL7Rpv8KExXOiI0cOb3jLTaKe5f6iR+929nev+OWWZAkJTSXqrAu9bfBiBJMaQERfd00nh5/JI1Wm8AFVlK+QGmflllTHWKGp2V8kWtlXKjRhf7/tjCoiEljrFoxY+z6l1f8glc10DyKDUGoNreubWjQbT+yF2RpnzyTtT8qbowxoCNJe4o36lKx6cJC3BgQg5XTK9LYajpyJkpfQTU4eUuoj5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b+a9QyXm8VPQdg3Q282L5MgszBJHCuRbTnv73j6YkQ=;
 b=yx2WrW1vNyRwqbNzTr2TH726bS8+kFD8UkMdBy9n8EX/EppqXqv2u0chlNOp1OMKMNEX4U7wMbYm5pIqNf7QDCp2QW872yWdXeJSyTFiwmUWLmz+sHSksINA6/rjqGKucf4s3zBvuVDQMhET3f1oKKQyDHMGRT9AT6kFFS5ixX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 13:43:54 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Tue, 23 Jul 2024
 13:43:53 +0000
Message-ID: <7dbcdb5d-3734-8e32-afdc-72d898126a0c@amd.com>
Date: Tue, 23 Jul 2024 14:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
 <e3ea1b1a-8439-40c6-99bf-4151ecf4d04f@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <e3ea1b1a-8439-40c6-99bf-4151ecf4d04f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0241.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: c396c0dc-289b-46f6-fa11-08dcab1d7dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjNrYWV1NnU4VDJuaitRems4U0kvMWwxdzFhU2Q2dFhGQUdLVmgvQ3JuTmhn?=
 =?utf-8?B?bjZKMWpxbzB4azRRVmEzMDRJOVQ3bDNETFZLdGZMTlRQa1hBSExoQkZQRXpN?=
 =?utf-8?B?NzlacnRqWk1nQnNUVDR1V3VYVEZQRkVwZEFDZXFCM0ZzRlBERFIvUi82MzJh?=
 =?utf-8?B?Nnc2eTh0RGsxMmM1ZHJiWlBnWVUzRFdTSkpKaDlpK0tUQ3ZudVQ1K2tabVll?=
 =?utf-8?B?Mm05VzI0YkE0aUFteHdKM2pyajlOdVZZZnFEWGlDT05qVGpIZnZqVk1Ic2Vy?=
 =?utf-8?B?WnZFTVBqOTRoaDlCdE9LTzZ3cWNHaTc0ZDZKbWVUSCsvaTA4djN4TFRJNzRk?=
 =?utf-8?B?Y1luR0JpNEtaR2tpOFRIbUppWEZVOEd4K1RVbjIyNk5kSGdMS0k3akhDeEti?=
 =?utf-8?B?RXUvQVZ1UkorK3NnenFPajBoRWUzVTVRY2pnRkYvOUVwdGo1UUpvSVg4L3RL?=
 =?utf-8?B?NFhvVE1KUTFnd1YxblN2Y2VEZWM4VTJoR1RiSXoxNXYxcXFwUmZGcGZYNVoy?=
 =?utf-8?B?KzE3Ty9LQXV0RndSeURFSEJiSm9NdTZKaFFoaDZiRzZGWU1jcGovdFUzWGxH?=
 =?utf-8?B?c3N1eW43Z2FVNEg5czFQUlFwR2FMRE1LREVuWFJWSlNuZDNOMG01dnQrNTVo?=
 =?utf-8?B?Uk5NNEkyLzBLa1dmdUR2OENaUExRR1NVK05ESG81NUpwNFNqREZIdmdEV3k1?=
 =?utf-8?B?ZTRDcnNSdjl6WUxrVE54YlVpKzZ5WUxLS3c4Y2IyUFZPbXhTZXU1MUNkVWRa?=
 =?utf-8?B?RmNmdEpDcXZiTWwzTFIwMWFNeGtCS2RmVG5DWDBZWHBrUmUxT01PMC9WblB0?=
 =?utf-8?B?MUI5bzBjYzlxejlGUjYzdXQvTGxMOG0wRDFDUGFSaGd2L3hncnpuS0dlNDJu?=
 =?utf-8?B?aFY1WnNHTmJiL20yUFFCZ3F5SHpnZXlWWWdjVTgybzZ5d0FScGgwVGlVQmxT?=
 =?utf-8?B?citpOFlQWjMzcFZ1QmI5N3FwQU16T2pHS1ZvV0FnUjVjdzNGUFk0UVZtOElF?=
 =?utf-8?B?emZCWTBuOWR4T3pHNE01Q05sQS9JMmsyZ2NGY0hCQ1RvRUk5ek1WWU4zcVlK?=
 =?utf-8?B?UzdoMHNpUVo0ZGZTUFpsMHhDODRkMG5yaDhyckIrMEU3MXFWVW5uVzJWSnVH?=
 =?utf-8?B?U0xHbkNtQnhhcys5c3loMkhoL2Z4SGkvdU9DeTBKQjJTZWJpbFZEKzZ3ejZh?=
 =?utf-8?B?c2FUV2dRcjdzTnZGZE5QWE13Tng4dFhsNUcvNERuZ3BQZUhKY3gxanBINGl1?=
 =?utf-8?B?R0dNWEt0M0d0Nk5uVUNUYjlsTUpUbTBldTBtUUhMR3I0bmE5MVczcVRoVU5W?=
 =?utf-8?B?WXpQSnREVkRlMXhNelNBdHRvdW9tWnl6WnlYUmRTaVh0alRtdXNkTC93MDdo?=
 =?utf-8?B?ZkpacENOWXlsL05ucWR3eUlwSGVDcWY2Vlp6d3VuMitRUHc1QmRLeElpck1N?=
 =?utf-8?B?MnAzR2ZJbDBVWHJUUWxveVN0T1dESzIxUnIzZWFxSms2SlFLeStoTEIxVjg0?=
 =?utf-8?B?cmFiMWF2U2U5UXl2U1FWRWJDMFZybnBHUEJ2L09UN2Zsckh0K3p0cW5rR0to?=
 =?utf-8?B?dGlmYk9Hclp1QzJjdHk5cWkzVHZOMUFEeHhnSlYrRW54ZnVTUlBsOTZJNW1y?=
 =?utf-8?B?dnZobkZ3ZWQ5aHlCQldXcmlsY1F0d1BVREVjdlhKMUhYVHdSRWc1Y0d6SEJ3?=
 =?utf-8?B?TlpjUXVMSldsdW10RHB1cHBINHp6bjR1T21BdnFUZ3VmWnhUeGI1aTZJQng0?=
 =?utf-8?B?djVGbzRhKzJ0dndXUGVac0JMUDhYc1B4THNWZSttYmdXOHJlMXQvcmtoNEJp?=
 =?utf-8?B?ay9BMnFsMm1JRGZoeWpzdWphR09Bb3FzMWFGSmZLdE40RERMRGx1VkV4Vith?=
 =?utf-8?Q?KIfgrU3jb/Qa9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c01BMG9kdFhUVmdrUFlxMGN5bzFNd3FnMC90Z3FJTzltYmJQME9PbnlGNnZK?=
 =?utf-8?B?a243Zjh6RWFmSWF3dy9HVmpoZTFmc201ZC9TRGZqZEhZTzVoQlozZHFINDlv?=
 =?utf-8?B?V3JheUpoeUJRSjJvSU9KM045aUdWL0pLSGc5VU5iaXVRZFozZmUwR3VBTU01?=
 =?utf-8?B?dEh1NHMwOXBFV0FRdjZ5VFlGaFNqMm5nenU5WWQwZFFvdFFpZWw0UjJTcDgx?=
 =?utf-8?B?N3hocG45NDBCZnRINVdFQmIvUDhzZ3JuRmVGNjFiMHBXckZMMkJ3QUlySFVU?=
 =?utf-8?B?LzRFZE5QeHM4TmZiQkhMdGRiV3VyVmpUWDN0bFp1Y0lkVnJYM1A3ejcrNlQ2?=
 =?utf-8?B?bEhTUWUrWlBETmNrWlJ2eERZVHZ2M1JKdGl2dGgxTFJGdDV5bkt6TTVmOUxU?=
 =?utf-8?B?SzdWZnRKdWJNMllXcXJRWGVTdy91MkV2V0VkSlZhSzlEZGlTVVJtZHp2ZHNG?=
 =?utf-8?B?dkNWWHZNcWNrQWdSSXIwSzBnSTJHSFIzcnFMUTBLYkZZeXBJRW9ROEhYYXJk?=
 =?utf-8?B?d3BDbVgrQXQ5TVRHTkFlQUc2WFdVQVpqaWhVYkdTM0pLSldpUkdnSXRxcndG?=
 =?utf-8?B?TTNJeWZaU0ZtaSs0QkhlUkRldzFyN0tSc0NUM2REQ2JDQ0lvdmRXd3g2ZVpo?=
 =?utf-8?B?QVg1cks2TjAwbzQxWjBibEtoOGI1Mjl4bXY1N3NJelI1Zm1ITW5NU3N1VEw0?=
 =?utf-8?B?YVRkTzdQQXBZWU9hb2FIZ2hyYmZad2wyUXFGdEtlc3ZhaGR6b2hmRG9ubjAz?=
 =?utf-8?B?N2R1WGFIMWVYVURTYzFIYVMxSGNkMmdtTHRnVWFLcEhIejNyRm14MkkxQ2RO?=
 =?utf-8?B?U0M1UzlqZ3NERXVvMXdNU3MxeFlQM0pWd1dOeWpOWnp6aXZhamFmLzV5eFBO?=
 =?utf-8?B?OHVRWFkxWi9zM3MwYzd4c3NjanhxdCtLK2NrKzhMdzVocjRmYk1aQ2RqMnNT?=
 =?utf-8?B?SjRLVnBtcnh0dWxxTEV5QTIvckJtNGZneDd5QnVuNDBWR2x1NEJ1U1dlbUwz?=
 =?utf-8?B?TzNoWkxNRTAzc01QUTJiRnpiQnBldlFsRk9hdEVyWHBrRExRUDFXYmRiZXBh?=
 =?utf-8?B?T3IwMDZUVEZjMTZzaE9HajlrdmlnaXVua0dUbEppeXMwWTA5VjdFa2Q2RUM1?=
 =?utf-8?B?YVJoa3F6aEFJSXV6ZVBmeVNIUzZRekRlNWVqTWxsUytkYSs3cVh6TkFaeUIr?=
 =?utf-8?B?bUw4QXE2djIvRzdPOFUvbG9CQjJzTTR6RU1JYXdUOFBaMEgyYUpPU1AwaTRZ?=
 =?utf-8?B?Q2hhc1JXczduQ0xURUpuR2hYY0dPYjJhTlp2ZmJSZmxpaHZ3WjNDdlNuMFIz?=
 =?utf-8?B?L21lU2tKMjNyUFFyVytDNXk1ZVpMaVp5WmhMcnpnTjBkbXExMlRTRTRMaUo3?=
 =?utf-8?B?QzQ0TGREcUl2SGxTZjE3ZEQ3Z0cxendReWVPczMvRXRNaVNQSUFRTy96TCtG?=
 =?utf-8?B?TGR1ZkdHMTBvdGJwQVhkRVc3SE8rdDJZUzZUNTFuQStmb2dScDJMd3NlcVV3?=
 =?utf-8?B?WGI1VVFhSVRna0tXVkJ1ZXN4by9hOVViT0xUc0pmS0JhM3NxYi95aTVSb0Ey?=
 =?utf-8?B?TXdkZVdhbEdZVzhLMlNLQjFnNzh5aWxFMk5WdndqaVVXSllLL2dRWVQ5SW9v?=
 =?utf-8?B?aGlqOTlIcmpJTFhWcnpyZlp6V3B3WVVGQ0FzamlGaTArU0hNRGxJYmFpdDdU?=
 =?utf-8?B?RHRQTlhlL1ZZMTBSUktUTkNBejNacmErd2J2WC82M21EdXVPTm9neitRc2ZT?=
 =?utf-8?B?YVAxRnVEazFTMTRyNUwwVGhaK0RCR05MV2F2MTMvZHpSVndRcWhmZ3JGZ3Bm?=
 =?utf-8?B?WVU2b3VOaGxzWVV2dmFzSWVQT2NJMjUycjBmUXBxenhBTlBzR3E4eGMyMnlq?=
 =?utf-8?B?N0QyTVZyalZJdGtuNVRxUExvVzViU0lLTGRFeU1yZk5lLzFGL2g4TXFObjl6?=
 =?utf-8?B?L2ZCUEgvWWtiMlVSbFFmS3B1ZjhQdU9sZkdLSG1pNUJlWURJM1hKVTZTYlFU?=
 =?utf-8?B?TzlHUEsxNUVXRGJYV0ErK1Uva2wvd0Rta3A0MnhPV2lXZDBqYlpIVFVhMmFB?=
 =?utf-8?B?OGpWZXU0a0lBcFd1NEhhcWtJeWtQcVFkbzBIOUxkVk10TGYxZE54TENLenE2?=
 =?utf-8?Q?v6jGNkYRgsVYgn9PXNxXSx0qr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c396c0dc-289b-46f6-fa11-08dcab1d7dbd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 13:43:53.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNtgZyd0MBAurh4ax8LxgWiS7vxrWaVmnRqiau46TxUD+kwQ6QQdp/EVYNFXFu2VDrgwS+SH7/4WD9Wx5XR5jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975


On 7/19/24 20:01, Dave Jiang wrote:
>
>>   
>> -static int cxl_probe_regs(struct cxl_register_map *map)
>> +static int cxl_probe_regs(struct cxl_register_map *map, uint8_t caps)
>>   {
>>   	struct cxl_component_reg_map *comp_map;
>>   	struct cxl_device_reg_map *dev_map;
>> @@ -437,11 +437,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>>   	case CXL_REGLOC_RBI_MEMDEV:
>>   		dev_map = &map->device_map;
>>   		cxl_probe_device_regs(host, base, dev_map);
>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>> +		if (!dev_map->status.valid ||
>> +		    ((caps & CXL_DRIVER_CAP_MBOX) && !dev_map->mbox.valid) ||
>>   		    !dev_map->memdev.valid) {
>>   			dev_err(host, "registers not found: %s%s%s\n",
>>   				!dev_map->status.valid ? "status " : "",
>> -				!dev_map->mbox.valid ? "mbox " : "",
>> +				((caps & CXL_DRIVER_CAP_MBOX) && !dev_map->mbox.valid) ? "mbox " : "",
> According to the r3.1 8.2.8.2.1, the device status registers and the primary mailbox registers are both mandatory if regloc id=3 block is found. So if the type2 device does not implement a mailbox then it shouldn't be calling cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map) to begin with from the driver init right? If the type2 device defines a regblock with id=3 but without a mailbox, then isn't that a spec violation?
>
> DJ


Right. The code needs to support the possibility of a Type2 having a 
mailbox, and if it is not supported, the rest of the dvsec regs 
initialization needs to be performed. This is not what the code does 
now, so I'll fix this.


A wider explanation is, for the RFC I used a test driver based on QEMU 
emulating a Type2 which had a CXL Device Register Interface defined 
(03h) but not a CXL Device Capability with id 2 for the primary mailbox 
register, breaking the spec as you spotted.


Thanks.



