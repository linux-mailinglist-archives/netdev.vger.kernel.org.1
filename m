Return-Path: <netdev+bounces-155508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993F5A02922
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE0E7A1F2D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B7156669;
	Mon,  6 Jan 2025 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MNfqiJ5B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75569155389;
	Mon,  6 Jan 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176797; cv=fail; b=DZdM/quBRxXQYxHnm5D6g2Vkm8pBm1WQryDxbRBw7V7EdPpQPPe63oppMrQ53b4PYmNu0W61aBlgrILr+goYh5ENDkgc0k/fFcpQ/Kz7ph+7s8E8Zrsca2UtFpItrpaVLbAC8nbNh1jNcuWq38jgGNtBi70KuxMjpLClby2qWf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176797; c=relaxed/simple;
	bh=HDvOx7h/VYYT/dweSETmF3/paSddEAWCkiIF8Fardj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qn+fMLJG8oR4fgoJxm3++8Kb/8YAyw7dq6zHwHnO/xzZx/ytRSO0PLD4LJGPnf6g0MyzmZUGvsg6AqwD740SpgE6Htg4a+Sbkevy6YEWSHXSm/I7TX+jLStRU/RHvUYoSJgcEQ4ZIkHNnuT1mvk1zNe2I157i6fXtnJQZYMkThE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MNfqiJ5B; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LV7je2Vk7n7KinoGo8t+P8xBEP67yKg5V/ELDCfMOBT1uOyygVNey+/Af9jdNvaUJXCGchElGxsmjEnfx0hbPSbNW0x6SF4bJdIpSzSKqgAuoNh6ABYWsUSCDXMukQ7o9HE4D4ZYuZ/FDvMqkmWuvSpQBmffL0lj2CgU+Eg/jaCYB9VyewqZ5Wb89CdnSZdbkv6oD6KJh/93DqameLKWfy612WtWIboP7kS/BivjI2I4KL4CUsBRu81TItjU6FY+VkEFYXc8khlOOWlodHQ3bi3e9CE9rjhqKc7AVqdyV+85VI9TJuBwKUWqXhI4jD0IqahnCQduj3M+710ehbS2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw9/mYWZt/6ANyfyVUQlabJTp27jPYaHXFgBlyMcbJc=;
 b=jsfFLDBQxNWcjfrfewLmz8wcJfkzrXSy7bN+2mSIDYdVZkmNgTBf0eo3ctEzmwGNVu/U67jPiGLfIhXrS3Xe3+qEnLzC5j5zvvKq1muMIu6dM/A26YasY05axGsrNoucRiqi7jegVSlJYgaKDT5204XO308BsTAZy61HKztqbX+PUO3/KnL+3tXcM8UvccCBY8M8/xPQpeNxCr/UJCS1PVboMQZiiC47UsuRQtx1v2U/1jy8HViKWJBgODWHSBz3fpJB8vKb554ZJt17oFYJHPZVym5ASeh8El9SaTW3xRpLfLdRsT17AsozeVLMmJKpL7jc0OcILXT3FvwMQnbbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw9/mYWZt/6ANyfyVUQlabJTp27jPYaHXFgBlyMcbJc=;
 b=MNfqiJ5BjdGKhamaKk5tW0SsGcEf6Pbo7dJ/sjiM3N33nxEpw/fSRT5lQPlV7IBOrruPfTxMwRg2TDX9V/yvtPUxS1a+8tf3SQ6m6QGxNqUSjUkTSfgCDylV0M6zXRFIC7TsZV9uIfyxjW15DlmEDpWAmSWHDr1bJNq5MlDjERg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 15:19:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 15:19:47 +0000
Message-ID: <9d9f8f11-e008-634d-b125-dbf822b00c25@amd.com>
Date: Mon, 6 Jan 2025 15:19:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 06/27] cxl: add function for type2 cxl regs setup
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
References: <0fe103b3-76d5-47a0-900b-3769b9c59cee@stanley.mountain>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <0fe103b3-76d5-47a0-900b-3769b9c59cee@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0390.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fe6a41-2b05-4af0-f00d-08dd2e658e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnEyU2NZMmVuSHBQSTIvdXloRWhabDlJWXdSN3d5T3paZDdpaXhwcnhOOFJI?=
 =?utf-8?B?MVh6bHFJQ2VQUlZpM204LzBnZSs0cFRTWUJSU1RxbzlVZmZ6TU8yZGh6bWNK?=
 =?utf-8?B?RFZzU1grTWdLTkhwVU1jdlZxVzVlS2hqY3p2Z2d6MXdlVDZSbElhL0VaUXdC?=
 =?utf-8?B?S0hUU2pjSG1ic3h4Skc5VURYVzdwbnhRcXo1UnNOZXRxNWVsQnhPSkp4UHVw?=
 =?utf-8?B?bTFFUm42SkgzKzUwOFZXc2J3T1pwdWRpTy9PMDV2QkJ2Z1dIcnZqWFlPdEU4?=
 =?utf-8?B?NVhNdHVqUUIrbVhJRGw1WmZ3dkhpdUR6ZnQvc0xTSkN2YVRtY1hlbEZKNCtD?=
 =?utf-8?B?L3JNVW9YODVhRkZ4MDBHdDJjNzlPVVlSYy9TSlZsSSs4clFBYW5qMGl1QlpO?=
 =?utf-8?B?cW5ZL1pCWGQvU1BCMm0vSm96YkN5a05oZU9IcWRQdlFPU0dDZHFzZkNzSDNU?=
 =?utf-8?B?aURXcVh6dUFEUDVXYkF2UTRNeWNaVFZhUVU3UGtqNTg1WUJFaWcxRm5paFg4?=
 =?utf-8?B?azkzOFl1K3JkTSs5NzlEa3EvaS91N1VZQWdZQ08vK0p5MVlJY1RqQnlLVVFs?=
 =?utf-8?B?dE5Md2VyblIrUWc1bElWWEJKeXNMeFpyZHNlWlk3NW51NFRYekRlZEV2WXZ5?=
 =?utf-8?B?WnZYblZ1UVpMa3RzT2l6VXF3L0NVUlhoa0NGMEllTTNPbHlJWkJRZTZ3Zlcx?=
 =?utf-8?B?bkpDcUFrcmJ0UWR1djZObStIVkRMWmRhTXozaFJnbmxBaUZuc3JHVjdKYzh5?=
 =?utf-8?B?emFuUGlSQW9sYkhqeFlwNnVEUDNIWHZja2pYcTU0Sys3NzNWaHFQTUFsbUVK?=
 =?utf-8?B?ZFA5cjQ2bjdjMXdqclJkdGlIeThtbXlESU1RbHMxbXJhNTEyTWl5TXNhN2wz?=
 =?utf-8?B?eGROSVd6TEZ6S0tHVzNHdmE2NkM1TmFNdldqaEx5d3hQSmRJOFhkbWZiNkEr?=
 =?utf-8?B?eUFSV0RORXBjVWxVaDRZWHVmdjhTbTlKaDR5RjAzQkNzQksya2oxZDN0NU5H?=
 =?utf-8?B?TGhEUEp2SkQ0V1V4R0hDYm41R05qNDRCKzBRWnF3VUpLT2Q0c3lrUHc1ZnZi?=
 =?utf-8?B?RWdrWXgzeWNaM1NsK0YrWUpNNUlLTXBHZ0pBSHlLNUVzczVmalV3OEg5VFFC?=
 =?utf-8?B?V3d0UzZ5Qkl6MzE2QmQ5Rzl0VkNxSEZ1aFdPSnZwazdYL3FJcUcrWXpWV0tP?=
 =?utf-8?B?UGpDQnM5QTQ0VjFWTURGbjQ3OXNaNFMrTG5XdmdPNko1RGpaT25rdXRHc2Rt?=
 =?utf-8?B?UGlqemZlM1dqeENNZ0krdGE4WHREOTFjNnRzcjNUak5iTjVlMXhTSUhLUUQ5?=
 =?utf-8?B?UGt6ZkJnOEhsTXQ2bWNFZWZ6bllkcGhxMk1sWEtlNURSNlMySnNTMmpSb3k4?=
 =?utf-8?B?enJNNmZpMXpKYXBSYVRCVnZQY3B0UVcwK3dBbjQ4YzhCTFpMSUx6OWRiZnJK?=
 =?utf-8?B?Y0VINEFmNWZOeHhZSVgyYm1HV1lyNjBmc3RBNjVBOFk4Yy9vanR1Q0V0eS9U?=
 =?utf-8?B?YWZyWWNjazlCRG5WRmk4azlSY1pUMVVwNXl4UmZiRnc5ckoxbGE0Z2ZhM1g5?=
 =?utf-8?B?TFBqR3B6ZTBScHlTdzFwSHNXMGljSklOSXdoanI1eFRlLzNYYnlaZVZKRGU3?=
 =?utf-8?B?N2dXMHNWenRZV0tPZ2ltRTMwaEQ4bW9RcDR1bVhhdWZSWHZzM1lnMlRLbWw5?=
 =?utf-8?B?azduUlFOWm5JR2RndUg4NmRiOXdvL3RxZWdOL0RTNFc1QmY1anltK2Q0Ymk5?=
 =?utf-8?B?azBPYUcrcFRYQnc4RnR1aE9LN1NDVUtOcjkyelo2ZHBVUURoM2xPL0ZXWjA3?=
 =?utf-8?B?Z2gvalk4WUNpc0J0Zkk5OFF0SFRZZlZKY3gwOWpJOUdqUCtmbEF5c2M1bUVF?=
 =?utf-8?Q?i77ArDL0XuwgC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0VjUUhmMnZIVEU2N1lQcHA1dW5tcmZCaExBWXVNRkR0dk1WeG1QajNxTHhP?=
 =?utf-8?B?TFBJU1BROG9VLzJ0a2c5OVVOcUJpSkNuNmF4OEVXeHh6eHZKZnhDVDdSdFNz?=
 =?utf-8?B?YS9tdGN3elZxZ2NDd2MwYWVUMFpLaEtRTDN5Y2VtZ2hjTi9wYTZGbGtXV0hs?=
 =?utf-8?B?bTRFRFByUmd3eVNCSnpjUmh0eTRyNUsxNFRQSHZGTW9Hc2pVVHJrbkxHVm9Q?=
 =?utf-8?B?dkJ6RlkwQlZXemtRcWF3LzNqOHlTUEIvSVNpZGN2SG4vaU1ScmFmV3Iyd3FU?=
 =?utf-8?B?bDhUcjg5NEhkMEVqUEFTYjhpZG55Q1o4d29DWklhaEhwcGk0djNKTVZjM0Fp?=
 =?utf-8?B?R095a3crOWU1cjBYTmUrMDhFdHdLdFVwTDhpQlozUmQrWHFlMCtYMWVvWFZD?=
 =?utf-8?B?K2tyb0F3V2l4UENzM3ZjUm81aGVUWXRFUUdpa0VFYS9BU2dId0s3Z0NDSkZS?=
 =?utf-8?B?cG1lOUdZZFNzQmFUZ2Q5N1NqZGJHWTJWNFloQUx3bGlFWWxZUFlqVXVQbDBT?=
 =?utf-8?B?WUN1QkpkbWxxUG9EditXNmFGSllDU2lYbG9rS0lpQ1grTHBzZno3dTZ6MzJU?=
 =?utf-8?B?Vmo3T05QMjFRTTJwY3A0eVRtMHd2dWFobHN1T01ra1dVNUhOQTRRSmNQV2pu?=
 =?utf-8?B?WXdHZ2J6OHVyeFZjYUkzN1lQOWM1RVVneDZSUSt2dTJ0dHd6OGQ1elUrK0dl?=
 =?utf-8?B?UDhUNFZQZ2FvellNSkJvM1hEUjlZR2FTTWU0ZUN4NUgrUVZIbXNka1FDQ0hP?=
 =?utf-8?B?bWlGM3lIa0pTRkZMSHdkWW1ac0tiVTdSelcwNitqWkFvVHZJR1ZGL0lTRWFv?=
 =?utf-8?B?VlM2YjdUZnUxTlNRKzNFbGF1RGJySnFQWHhBQytseVRDVGR6RS9Wa05tbjhS?=
 =?utf-8?B?eXFZSHRwS2RJV2NTNFI1Q0Z3NFVNNFhuWTA0ZUlVU1Q1QjJWQi94U2h5QXNu?=
 =?utf-8?B?MmNhekZBblQ5MVJueURDN2NaWnA2Z0tMaHNQQnphbDRjK0QzSS84UnFrdXJv?=
 =?utf-8?B?US9ITGN0YWQ0SHpOZ0RpSjdhRk1Ha0k2a3lFMndRV2ROdUZBbnh4V25CelpL?=
 =?utf-8?B?b1J4bm1QL1ZjYkVsKzhVY1lzQ3FuT1JKS3JsaHdCUGtBNEJkdTRtcFhnbE1J?=
 =?utf-8?B?UXM0dFlnVnJEbDVtL3ZJUGczcEl0UTlGUTd1RCtLdW93Y0dNUXFBUkZMQ0dP?=
 =?utf-8?B?S24vb1psRUtPdVVyQTdRRDJDRm1MOTVzYlI5TEp0c2IzQnA3WVBjeGNXV3JL?=
 =?utf-8?B?YXBBblQ2L0dTYjdjTk1jVkZHa2dTTWdRMTVuR3lrYmFPdFpvWGloR2RocTBI?=
 =?utf-8?B?eVhqYkhLRTNKNmMvTjJBQkl1TldBUTA4NVpvajRqUzNoRW15U0JzU0svRlVM?=
 =?utf-8?B?T1pOZFRBNzA2RXNsY0RsRlJZUXNDcDMrTGVKZmVSVWpKeXA1bWhkWDd3alUx?=
 =?utf-8?B?UlhNeHdFdndqL0w2clpheWZSYW5SaTJOdjA0VHBTdzBZeVZaTlhiOFJpbnVv?=
 =?utf-8?B?bUtoQnowdHQ4YVBrZ3hYajVzOFJvZ05vYnprR1pkL1ZZMGh2SUM5Y3cyR1RS?=
 =?utf-8?B?WHRPbDlCSWVqM0cyZllyd2laRk82OTZaeHlZZVRaYjA3MnlaVTR0dnBkMzEv?=
 =?utf-8?B?cUFzR1Mvc0VIemZ1RDJQdStLR0dBYnFFamdwSC9pZWlEeExjKzZaVFNJSnBJ?=
 =?utf-8?B?djlMUXdaOTJ3bXcxMXZENllIYWU2YnY2T3hNMmdRVDBxK2RTbWVXOUFwYlNI?=
 =?utf-8?B?Q1h1M3oxUWpEVlYvMk55VzRUbE9EQTdYd2JGbU9CUUpzOVhYYnpBSHFnUHpx?=
 =?utf-8?B?R3BxMmpUWE5VUUFSbXBLWW9MY1ZiakNLbDQ4YmUvZC9tMUtMczdvZ0ZKeG1h?=
 =?utf-8?B?VmpNYzFEUHc1WDd0VWFnamRURWo2dGF1eVA1YXRScEVtOVBGWUpDTllZbjQv?=
 =?utf-8?B?R3p3R0paYmZqaUJRajB1R1pFQWgvTEpuRE91eGZxNkR4aUllWU9sN1dVa29v?=
 =?utf-8?B?Y3IwcFRCTXFsOG92YTJqU2pYQlNIbWVBanhKTFlJczhhSVcxOGVQRXBwY211?=
 =?utf-8?B?cFJDRHE5SjRGUUNpVko1anpOcjNxbTVmVWtpSzNwQ3I4dzZvbkxGQUVaNkdJ?=
 =?utf-8?Q?OUryW649N0yF58ozKdAvwy+aA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fe6a41-2b05-4af0-f00d-08dd2e658e1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 15:19:47.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2vYS3cH4P107w4K1SNHRbsMaozmNRanTe616q2syzDhs/9407nbHknrTBpei6xS7tpfDvnHzYF56ro/dwU4Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733


On 1/6/25 10:41, Dan Carpenter wrote:
> Hi,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20241217-001923
> base:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> patch link:    https://lore.kernel.org/r/20241216161042.42108-7-alejandro.lucero-palau%40amd.com
> patch subject: [PATCH v8 06/27] cxl: add function for type2 cxl regs setup
> config: arm64-randconfig-r072-20241225 (https://download.01.org/0day-ci/archive/20241227/202412270320.Aydp9B4U-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202412270320.Aydp9B4U-lkp@intel.com/
>
> smatch warnings:
> drivers/cxl/core/pci.c:1134 cxl_pci_accel_setup_regs() warn: missing error code? 'rc'
>
> vim +/rc +1134 drivers/cxl/core/pci.c
>
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1118  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1119  {
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1120  	int rc;
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1121
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1122  	rc = cxl_pci_setup_memdev_regs(pdev, cxlds);
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1123  	if (rc)
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1124  		return rc;
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1125
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1126  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1127  				&cxlds->reg_map, cxlds->capabilities);
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1128  	if (rc) {
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1129  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1130  		return rc;
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1131  	}
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1132
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1133  	if (!test_bit(CXL_CM_CAP_CAP_ID_RAS, cxlds->capabilities))
> cfbd1d00295bff Alejandro Lucero 2024-12-16 @1134  		return rc;
>
> This looks like it's supposed to be return -EPERM.


Not really. It is not an error if the device does not advertise it, and 
this return should be a return 0. It was pointed out by another review 
and it will be fixed in v10.

Thanks


> cfbd1d00295bff Alejandro Lucero 2024-12-16  1135
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1136  	rc = cxl_map_component_regs(&cxlds->reg_map,
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1137  				    &cxlds->regs.component,
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1138  				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1139  	if (rc)
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1140  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1141
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1142  	return rc;
> cfbd1d00295bff Alejandro Lucero 2024-12-16  1143  }
>

