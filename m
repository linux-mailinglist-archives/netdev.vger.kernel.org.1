Return-Path: <netdev+bounces-126851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E92F972AD7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22C51C213E1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1129717DFEF;
	Tue, 10 Sep 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AZvIA+MG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745A17D8BF;
	Tue, 10 Sep 2024 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953539; cv=fail; b=YCKSMihlgNHoUtBx5gZmW4+mgvOHifCWdUoB3Yz6P+A3jEobxDZIzA1NIivQN4O36uVCYpgi7rGAPtmM+KAQ9yDOTGs2Vz9rsUw6Z10uYNMuI2IhaFoOfs0aw3CPdmWkrU1s4jFFE9YbmE0lzHNB3SD0cG1e9kwgSGBjIeFPsts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953539; c=relaxed/simple;
	bh=al0l+wvA7oddpTy85a9D4KoW1cVrWAe07bYcUbApcTw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=epKFTK+gO4jGWFDsRRWWdAqTzyp7T/dmkG0S5cZfSWM/9Ed05yUBFcNaUw7odPpPJDiLA5CXRLuTKccnEGzVypGeiPp2iW0GlJ3ZPiW2TbHmEnw+c9d7Slou4NA5HUUfNFsLgpcVDsfWCIAzhNG/ZBRt/1PQS1p6UbsTypjxOSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AZvIA+MG; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVK0iqLSbS2Bu1ZW7+syeu+nbm/6MXnrXthkq1vuxLFG8tNGZQMD/jGcH9SlrKlLRtjKPwSOdnCuk2+5x8w8wmhCwXDKMu7gqugYwBXoueMs5ecPgFTalVeg2F7MkpjuLf9J4zzdkYP5dgTmb7PgA/H2FeM5sY5lHAfw1vCbvG1gXpno3OrNwayZoNYONwylBS19qUy2xoD0orhcDlBjAtbTVmKsA7DnIc+pCc0GlUV0owE4Sn4y7Iazh2JN/lJHYIjSUleElVa9+3gffIAjp4N4gA79IdXXMrwJ9n/RYTUJH4geSTf+qWwxWj9uYP0uPHkYetCcm9dl4DoN2pmFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4v9JajwNPgrGk5t5H95Le4f9mM263ADLIkBbqk8zhw=;
 b=eLMWB0Fb0IwVVse4QjTR5QDS8SdqMm957LoTi8Gh0wuPMrC0oiYdcUTXJ/Qn4zcZ6frwA9Nf1ki2prEvg9lY6JwKSBHHF4D3RhBDJOdMlBih7dJQ40sNU0iWWOBGbBjLddu2cxJkz51Vz86GPPo1JfxLCJPtv4tW0F2eHsxBVMwNtzugDYJ7hJ1QpKKlz3yuZdWzKQReWcdeipfDkR9h8ZFoYyyhor82Cb2KZnT2Z2BQzFg6UXTkv9CEmst4CAdbnImIZ3V5ot+hZNV3FpF+tlGLYQsNGq79pL7D3G9qnBQ/Mm7DMgLYxy2pAkfuUcf64dqb800XCSwHTdnfzv+HsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4v9JajwNPgrGk5t5H95Le4f9mM263ADLIkBbqk8zhw=;
 b=AZvIA+MGWp0LlMR5hImDa1ilZ6YlMt6R2HE4XI7LvMdScE2LP/dttHOX88KovsMR9Z7JlGEnCByI4HXmy6EmIdCInmlNi2jQVtfkhZNXrpEoDl+qYfROOpDMiHvZYIxeZw+ZER9lap0RMUioUMNVGgEwn2OQZgJtjror7PBqN3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 07:32:11 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 07:32:11 +0000
Message-ID: <d47976e6-caa0-93b9-a42c-507d2f34401b@amd.com>
Date: Tue, 10 Sep 2024 08:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 03/20] cxl/pci: add check for validating capabilities
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-4-alejandro.lucero-palau@amd.com>
 <937b2409-c34c-4540-9bb8-3142d719a881@intel.com>
 <c5c67507-941f-4112-a6b5-822c126be388@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <c5c67507-941f-4112-a6b5-822c126be388@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0672.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: c092c4b6-e7e2-4eb2-932c-08dcd16aaf28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUI5WDdXSk1aL2Ntb2QrdDh0T1VOelp6dm50ZVhUM0JpMmdMTjVmUW8zUUoy?=
 =?utf-8?B?bERXNExFYmZNbGkxYXJCbDZ4TGw0TzdyV2hyY2RiMW03UUswSit2TTR4U0E4?=
 =?utf-8?B?MjYycjBvcERUWmlIN05PeTBtMGdzNmx1aTRTaTY1Q1ZnTWsrYUh4M0Y1ZkR4?=
 =?utf-8?B?bFBYOEVqcHFyc1VNYklZazZnd3J4RWtqVmdYVGlqbURzblVnVnE4OGMzeUxt?=
 =?utf-8?B?OGlFdzJoemFlVURHZ0RrWEQvQ0U4SDFJWm56Q3E1dUdtdjZLbHBVdWtjZjU5?=
 =?utf-8?B?bnU2RTNQSUxPSWpjdnBCVUpxUVZ3a3hDOFdka1FJRkRXYTgxakRRRDkxOFJh?=
 =?utf-8?B?WDNBTy9tV3ArWHRMK1dFWnJiRnYySDZGbkFiNC9xc0hGU3g0OHFkZlhUaytP?=
 =?utf-8?B?VDBraVpDQ1V0VllIbVR3bmpUM3hCckVrdEtRYVBES3Mya0xhQ3huK2g5cVda?=
 =?utf-8?B?eW9KeXpnQU5scGw2ckdENkZnUXZ6VGNuazllY0hFNGZhUldQOEtLOGFuMWhj?=
 =?utf-8?B?SG9vVXFwOXdBWEFPM2ZCZVNBNnVnK3pJZmlJM1Jlc2l0eUZlMS9oQmp6dE1n?=
 =?utf-8?B?K0xOdVA3VzRPOVlZd2EyOHUyOW9TdUpidzhzNkFKS3Q1d3RMRUtiZ3RXdDVz?=
 =?utf-8?B?T1c5akRkNVNLN2liV2tWTnpUVnRESURZU0M0TDAraytEMmUvSTUyYmxXcG13?=
 =?utf-8?B?ZURld0NIR3N4eU1mUzFaWkFvWTE4Z3ZyeFozOHcyakFScnhUSTk2NUhSVUtO?=
 =?utf-8?B?aDNMejczY3BiTFFNUCtDMk5GS0twbUhRbTZsa0oyK1RZZFV4elZZL3JBRTVR?=
 =?utf-8?B?S3FaMU1sUElENTRjU1lwWjZ2Y3RYSFNZZHBxZFhrVWx3anJSYjR5SWVnU2xF?=
 =?utf-8?B?czRCcDJXczZ3b2dNNDZiQ2VJWmNIcm5HNTJ3NkgyMjdrdTNTdnFXV1Y0b2NR?=
 =?utf-8?B?TWN0ekpzVVdSem04YXdkeFgvK2kwNU5USjRrYTMwaklJblgxeno4dGZ3ZElI?=
 =?utf-8?B?TUludlVBMW9xckxjcytMaWRRL0VVME5nRVhMQmdGVnpINHZ1U2MzSW9LUlZy?=
 =?utf-8?B?akxsVjVPMndaa1pFUVRpVHVsd0oyRERmdDgvVnZVd2k5WTZJVnJXd0QzWGhL?=
 =?utf-8?B?RytvMmxWOGlBRjRySVZyNVN1dms5cHlrRkRZMHltZjAwSVRKbUQrOFdKV0Ry?=
 =?utf-8?B?MEk0ckZ5a2xwbkVBWFF3ZDVndVJmQk02ejNlZnFzZDcyQlhuYnBrSERxRFp5?=
 =?utf-8?B?eWIyZitLU2JYeC9OdDVLbWpkZndhNGdVSGhiblZXNGQ2VmJqcG5CZnlJWHJM?=
 =?utf-8?B?Ym1Nb1l2MUVIRzVCSE1xQXJDSVdSaStoM1BvK0cwK3g2aFhib0h5N25yQ3B4?=
 =?utf-8?B?dllyVVRRNDRRUUw0ZmVhVmpyYkhqVGIwSXMycGlpVmp3a3phZmRPbm1aN2NP?=
 =?utf-8?B?YTFJT1JhZDdOZTFpN1FkRThSeHpTakRrUFhTV0psRGhtUTlFTWxiKzV2MXdO?=
 =?utf-8?B?QVF6WnVpOXFyd2lTSSs0MmRmQTREUVQyNk9lSitiTFU1UjZNVXlEbHNhRWhZ?=
 =?utf-8?B?MTNoTDVRa1RwWG9pUGtHdGdneGtiRXdiUXpYc09PSDNZSnZSdVVrR2dmeFBJ?=
 =?utf-8?B?bTBGNVp0ZHVEa0xvZGU3VldrNW5NYkNvZ0JER2htUDg1U2grOWdXckZUN0pi?=
 =?utf-8?B?cmJSTXJJaW1vbkJ5bEtZMWJLZ1BZQTl1OUZxOUkvQWRYdTFsVjBndGpPZkhq?=
 =?utf-8?B?bUw1KzZJWGtNaHYzaDFNOFJvMkJnM2F5cmFMRnh6V09naWJNR0hmOHNRc2Vw?=
 =?utf-8?B?UVNDNjdiNTFGZEFPK2swaXlCQ2dqZFE2RUxCV25jMWNWMzFGZnI1TjMzOXZi?=
 =?utf-8?Q?0FXEqjFcI93zS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklSUTR4Q3VWN2NQUTY5TGd1bmdiai96UGtaNGxhSDBMaHFUM2lwRGc1NXBl?=
 =?utf-8?B?ZXdWZzg1VTNmK0xnWlVjVE1odFd0c2s0cXRBWjlweDFEdWJIRUZ4UnRKR244?=
 =?utf-8?B?VmFUMzdhRWtCNWtaMnVNQzJVS1Y2VHVKSUFjeVNIYStaT0VaSFM0VFk0bGJP?=
 =?utf-8?B?UU95REdQaUlxU1BsbGROQnBUaUE4ZXdYS3p2a01DSENtdm1ncElhaUdsaHVT?=
 =?utf-8?B?N3FsbnF4VUxHa1U2Vk5JcEI2QzhKY0RvVk40cHh4VkNIZ3Rmc2ZzNGdaTk5Y?=
 =?utf-8?B?QWNrQ0ZWeS8veFhPM0dzV2lzZnNBbkE5RDViWjFYQmZoaGhIU1RLUktBNkN3?=
 =?utf-8?B?QlMxZ0xuRlY5eS9vWHM5WUozMDZnWnVkalRXMnQyVStEVjF0UWdsMEU0SUJ1?=
 =?utf-8?B?MUw1NGpLeklndzFoaTJFRGtqTTkxZEJ5bjhVYXhlaXZQeXAveE1sc1JaNjl4?=
 =?utf-8?B?aHJmaE14eE16T3FjajhZSzZ0YlBvQ0tuTk0xK000bm9qRk00bVN3ZzBFbDA1?=
 =?utf-8?B?ZkZpTms0V1FtZlVCVnZyRGN2U1hOYWM1cUNjQTl4cDVvOE1HUFJjT2lrZnVs?=
 =?utf-8?B?eEdBTFJFM2k4REp3L3VFTFBUcGRuZjc3NlBXdXIxK2t6czNOL3NUcENMMDUw?=
 =?utf-8?B?TGpkcDdJZUlxamZIZXFjTG04a3BxUXRVT0I2UG9YOUF5ZTk3ckExYlJNcGdt?=
 =?utf-8?B?MUxNRXJna2dvTUNIdW5hYWdCeVl2cjFYNXlCVytoZ01Jd1IrRzExUXpSbTRy?=
 =?utf-8?B?RDBpV0FGeTVNQ2JTK0NkbFh4cHI4UVZqdDFSdHdCcTcxNldQUEVQbnpCWXQ5?=
 =?utf-8?B?Q2I0bHJ2TFY5KzI2UjBSeVZwcWN2bzlVcWdmMnN0OGJXQmFlaW10QmJNQ2w5?=
 =?utf-8?B?Y2ZuV2VlSWdMWkZtcW9LUmRZMnBIS0JEeGhrTlFuOFRQOVRTRW5yZFZEbHJq?=
 =?utf-8?B?TUpqOGVGN3Y0c05ZaW1xOTNDVUs4TVlma0lSTnBoaVl0MDNQZFFocGdmZTZm?=
 =?utf-8?B?UExwMVFJbnVNUXN2VEJKRkZqcDRzMnRVVEJDTUVPYTRDN2x3elB5eTdLY3hJ?=
 =?utf-8?B?R05IejlGSDVySzNYMXp6MVNIZk85YnJaalFGK0UweWlTRlhPSXlaeGh4Nk5o?=
 =?utf-8?B?YUhXa3oyczFyMXRwYmtRa09aS00wOFVlNitJL3NvbjcvRng0UE1XY003K3A2?=
 =?utf-8?B?Y1BDaFRCL2hMaHM1WHQ1QTFXSkZvS1lqL2NnUE9LS2dNK2w3L2JHTkdrRTBW?=
 =?utf-8?B?czlhYXBTNUdndDlwUWhzVklSOHNESXdIdlY4QXI4cW1YS1lKd01ZZFNVZEI1?=
 =?utf-8?B?alRaZ0VsNWljYnBKRkVFQytmUzcxN3NmUUtBcEFHd0ZjR3lPUG5UMFRFaG1a?=
 =?utf-8?B?UHUrdkFJQWRXZGdhZ3VRZzRiQVB3Nzd0SnlqNUNscXdoenM5N0U2R2FoZG1o?=
 =?utf-8?B?L3FreXdLSHZsVml5dzdCb3JjbUNrbTlOM3h5aTQweDZ5MTdoU1plS2oybUZJ?=
 =?utf-8?B?RkxlZnNOejhOZ21zclVEU2lVN0JySExjbDRnWUNoYURiRm9XdWhmemsvMjJI?=
 =?utf-8?B?bml3d3FpZkRnUnNSanRBME1KdHcwR294SkY2ODN1WDZNYitwRUdpcmxRc2E3?=
 =?utf-8?B?VDNDM3gwZlJoZnN2Z3lIQjIzODdraDZwZkJVTDl0d3QzRCtTcldiWlZ5QnFt?=
 =?utf-8?B?US9XQTIwendnaGxqR28ySkRRaUVzN0ZjblAvbm1KV01ONjR4L3A0bGphbTY1?=
 =?utf-8?B?SzdrYTNaYVF6K2NEeVNwUC9SYlFibllqQ0d5NEtqc0phUDEzVXVFL2NaeHRp?=
 =?utf-8?B?TUNKb2JJV0I2dVpGN29sODZmV1J5bHhBUnIyM1FSd3JGTWtEd0V0NFVobUxp?=
 =?utf-8?B?L2x4eUtoUE1ZTEtqME9MTWRnblNobzF1ZU51NzljNjdkd1lJTWM0eEZmck1K?=
 =?utf-8?B?WE9YckZVWGdLL2o0UUw1bFZvZDkreitKR2I2K1hINjloTTFjTVhMMDB1L05I?=
 =?utf-8?B?NkRYV0IraVg0cHlRUC80ZWdJYVpmT0RNaWEvODl4NlZNRC90RnFId01SVHAv?=
 =?utf-8?B?K0xMOEFuTVUyeHNKMjAvbFBvSm4vRHJyOGJzL2NBZkk4bWdDV2dBeTlwMUhH?=
 =?utf-8?Q?ZqhL5Jg+UROAQfaX9pjsJf3iE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c092c4b6-e7e2-4eb2-932c-08dcd16aaf28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:32:11.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXndO4jtGm68inFnHc1pj/rA9iK+WSlvsru782KrsUoX47tk8E1RuWSeK/FDlfdP1IS63NYEEQ1lXa6Nx8uXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411


On 9/10/24 07:24, Li, Ming4 wrote:
> On 9/10/2024 11:26 AM, Li, Ming4 wrote:
>> On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> During CXL device initialization supported capabilities by the device
>>> are discovered. Type3 and Type2 devices have different mandatory
>>> capabilities and a Type2 expects a specific set including optional
>>> capabilities.
>>>
>>> Add a function for checking expected capabilities against those found
>>> during initialization.
>>>
>>> Rely on this function for validating capabilities instead of when CXL
>>> regs are probed.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/pci.c  | 17 +++++++++++++++++
>>>   drivers/cxl/core/regs.c |  9 ---------
>>>   drivers/cxl/pci.c       | 12 ++++++++++++
>>>   include/linux/cxl/cxl.h |  2 ++
>>>   4 files changed, 31 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index 3d6564dbda57..57370d9beb32 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -7,6 +7,7 @@
>>>   #include <linux/pci.h>
>>>   #include <linux/pci-doe.h>
>>>   #include <linux/aer.h>
>>> +#include <linux/cxl/cxl.h>
>>>   #include <linux/cxl/pci.h>
>>>   #include <cxlpci.h>
>>>   #include <cxlmem.h>
>>> @@ -1077,3 +1078,19 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>>   				     __cxl_endpoint_decoder_reset_detected);
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>>> +
>>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>> +			u32 *current_caps)
>>> +{
>>> +	if (current_caps)
>>> +		*current_caps = cxlds->capabilities;
>>> +
>>> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08x vs expected caps 0x%08x\n",
>>> +		cxlds->capabilities, expected_caps);
>>> +
>>> +	if ((cxlds->capabilities & expected_caps) != expected_caps)
>>> +		return false;
>>> +
>>> +	return true;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, CXL);
>> Why has to use this 'u32 *current_caps' as a parameter? if user wants to know the capabilities of a device, they can get it from cxlds->capabilities directly.
>>
> Sorry, I missed something implemented in PATCH #1, seems like you can not access struct cxl_dev_state from efx driver side. right?


Yes. The idea is to avoid that for facilitating changes to those updated 
structs. Initially, during the RFC review, it was said let's enforce 
because accel drivers should not be trusted, but I think the main 
concern is maintenance.


>
>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>> index 8b8abcadcb93..35f6dc97be6e 100644
>>> --- a/drivers/cxl/core/regs.c
>>> +++ b/drivers/cxl/core/regs.c
>>> @@ -443,15 +443,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, u32 *caps)
>>>   	case CXL_REGLOC_RBI_MEMDEV:
>>>   		dev_map = &map->device_map;
>>>   		cxl_probe_device_regs(host, base, dev_map, caps);
>>> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>>> -		    !dev_map->memdev.valid) {
>>> -			dev_err(host, "registers not found: %s%s%s\n",
>>> -				!dev_map->status.valid ? "status " : "",
>>> -				!dev_map->mbox.valid ? "mbox " : "",
>>> -				!dev_map->memdev.valid ? "memdev " : "");
>>> -			return -ENXIO;
>>> -		}
>>> -
>>>   		dev_dbg(host, "Probing device registers...\n");
>>>   		break;
>>>   	default:
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 58f325019886..bec660357eec 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -796,6 +796,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>   	struct cxl_register_map map;
>>>   	struct cxl_memdev *cxlmd;
>>>   	int i, rc, pmu_count;
>>> +	u32 expected, found;
>>>   	bool irq_avail;
>>>   	u16 dvsec;
>>>   
>>> @@ -852,6 +853,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>   	if (rc)
>>>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>>   
>>> +	/* These are the mandatory capabilities for a Type3 device */
>>> +	expected = BIT(CXL_DEV_CAP_HDM) | BIT(CXL_DEV_CAP_DEV_STATUS) |
>>> +		   BIT(CXL_DEV_CAP_MAILBOX_PRIMARY) | BIT(CXL_DEV_CAP_MEMDEV);
>>> +
>>> +	if (!cxl_pci_check_caps(cxlds, expected, &found)) {
>>> +		dev_err(&pdev->dev,
>>> +			"Expected capabilities not matching with found capabilities: (%08x - %08x)\n",
>>> +			expected, found);
>>> +		return -ENXIO;
>>> +	}
>>> +
>> Same as above, the capabilities already are cached in cxlds->capabilities. seems like that the 'found' can be removed and using cxlds->capabilities directly here.
>>
>>
>>>   	rc = cxl_await_media_ready(cxlds);
>>>   	if (rc == 0)
>>>   		cxlds->media_ready = true;
>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>> index 930b1b9c1d6a..4a57bf60403d 100644
>>> --- a/include/linux/cxl/cxl.h
>>> +++ b/include/linux/cxl/cxl.h
>>> @@ -48,4 +48,6 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>>   void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>>   int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>>   		     enum cxl_resource);
>>> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>>> +			u32 *current_caps);
>>>   #endif
>>

