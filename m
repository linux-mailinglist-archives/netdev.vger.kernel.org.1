Return-Path: <netdev+bounces-199276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 398AAADF9BB
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3FB189EE3E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2028002C;
	Wed, 18 Jun 2025 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rGFjnRPO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E921465A5;
	Wed, 18 Jun 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289007; cv=fail; b=okSTHbs3hR5pWqFSrnXjrVz8kEY2NLDn/QTfw5jvDS7o0Wan1wi3zqtPaUX132x7w/Z9GzMObLIDLe6rty9QXYE81EIjOcfv7OYFXyRtAI+L9xPYlfHlLX3J725NSNJBEbH37ckw4phDb7RCLdX2jBNESPp34wCcZGykaDA9pM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289007; c=relaxed/simple;
	bh=u8T0pZ00ncLIhWmNFl2ls1okV8h/Z/ak5PHno9h+T/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=StyIJtl10b7Sihtt4X9EezkdTokSj8i/wIAfvOvPFl24eQbluh5KHk1GAJV4JwchRfMsbjmgoJ9YwPvh/e2IP2jEDevvtb1lXMw2/IX4GGWrE0wxO7cm/GsSuvfpLF3LS7KiiCIT7OcdIHe/5w0/GwD9fmSTprH9yFycbUFlG+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rGFjnRPO; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAsY2qoWV9OPO4PU7cxB0ws5VVKrHD3tO8J/qAbD2b+PB8IVpzJj+VRWmrYdm79qlv30wS/zYk5+HIaVhSsuFV7QfP2YgltU8EU5oVFIbOiQyyueNsb0Rcuvkwp+DF0Yrs1eiJtZg3YJaXNbI+ns9PhAHqSoe/ITsgCnWdYlxarlWWGzVxBhcT1AfVY55yaMYo/mtirCe6Sem1/BDn060XLBlMeVfhuzUg6lnsImLqqqGGZ8n6oQ7GkaB+qNQqDpE6Ni4RET0WOS/ELKn5UHpZdTpFiuk5KczDvyfvweMoEBjYOXQWHIkwRdZSMXuOIm1hV+615YhSGSNPvFgYwwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc5clnx5PsfnVmeGscKuETiLBgztRvLBejlShHRJXoA=;
 b=sXFWVlwTWwFcLiCbNzOE8FeOMS5IJyoBpdGzMnMUY+xQiowuroDhYtjEXwAvaCrmz0YeUf08wkGsnYih0ZlcL+rLUn4thBVJWtufi0FjqeDVNwN0FaW/Yu0gQhy649MPeO3uGamlDUwa0bCWQCUJnXxPErXfl3gchsSq33h014XumlpG+torFM+9tZfPH8FiXHbzTLfWLaeHwPOAGy/Xip2dmw6u0Df6xdDkhasA+5zGpXblV6Gh3Dvum892DhwYLOtiU2uCF8CZMQ/hP8S7iwxjs9qZv+GpvAIHUzTS7XkG4sVuaiEBqh+x2Q0wikt9tfRAnUH4jFVemEmOf8jmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc5clnx5PsfnVmeGscKuETiLBgztRvLBejlShHRJXoA=;
 b=rGFjnRPOWrdAI6kqauWHpUZGaZR/iguJuBYV1WAPgZCvfAS0oYpm/tN3ncY2Y1ngASUcDzj5GzdRAZOdifniK1KAAcQ58jPqO8cOw07l/Tq9tzgmH0+LsYCGqymCGv86QxvT3+4YB4FWsMWQOebDmN/sKuCI5ixSIS4BjCPg6+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Wed, 18 Jun
 2025 23:23:23 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 23:23:23 +0000
Message-ID: <21f5acb9-c011-478b-b1a2-601d748dc88f@amd.com>
Date: Wed, 18 Jun 2025 16:23:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Shannon Nelson from MAINTAINERS file
To: Shannon Nelson <shannon.nelson@amd.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: brett.creeley@amd.com
References: <20250616224437.56581-1-shannon.nelson@amd.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20250616224437.56581-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d3bc56-731c-4d26-ffc3-08ddaebf1e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWo4Smk3dW05WXFUenYzSVh4Yk8vYmFNdHNLZmpUOG5uYVhLMFArZXJmb2FH?=
 =?utf-8?B?cXpaSFR4WndWYWg5NHF3QlI0NGk5NWhkYjhMVGpCeDVvNnJtNjVxR2VSc2th?=
 =?utf-8?B?RmUyODhldkFnZ2JWVkFwZm9CeFZqaWFUNUZpYmF3YWZKNDdzR1M1c1E3bTd0?=
 =?utf-8?B?NDl1TEtUMEhYdDJvQmhEQkJqUi9rdXBlOEh1TmxHM05HUTRqbVF1L2l0UUN1?=
 =?utf-8?B?azVuYkRDSEZqYndJdFZnNXM3dVlZbU1YZTBVb01ReUhOV0tIYm50UHdCMm1Q?=
 =?utf-8?B?YnVxaGQrSEdYZ2t2ZWNmS01Db21GWWlxcDNwZmhDbGx1YW9KbzBrNDlsMmJu?=
 =?utf-8?B?dm55QlFRUmFQdHYwWE9rWmlHdjZxUVoxMCtUZ3lQbkxXVHFzSEdJeG9zR3Zl?=
 =?utf-8?B?enBzZGx1UjBJajVaRWRsQldkT3JnZW9YVEFuL0V4b1A4b3dFNnRSQk0ySzhH?=
 =?utf-8?B?MlFHMmFZaWdqa1dFcjhIWEczU2x1VFBPUHBhalRDVmR3SVFvdXFnV1MzYW1V?=
 =?utf-8?B?bnZUUHZ6T0c2VUFneEh0VDk2Y0kvVFY2MnI2MEhDb0Q4eGUydFR1KzFmWThU?=
 =?utf-8?B?alB5N0YyQlhmRXJjV2tmYk1GMGlWNTg4UEVmdWJ6YWhjSUhyYjhySWxxeC9C?=
 =?utf-8?B?azQyZWhpMXlteXkxR3pJOCszQnJVRWNPQXlINTV5a1V5UFc3ODNvVXI3RSs1?=
 =?utf-8?B?YUtoVllndWxSYVNxMlhkL01jWTV1cUkwVmFlV1lDRitTK1ZkcDFqVjFLMUNQ?=
 =?utf-8?B?V0UwVHVTQzVQdU9FQ3B3NXN4SmFGdlVPSUEyV3dJdkhIclNxRi8yN2Rmd0FC?=
 =?utf-8?B?dzRDY2RvS25ucVdGMThwWVlaeGVoWElVUDhDbVo4REluV1RseXYwcmRSdHpk?=
 =?utf-8?B?SExMUmN2bGRqODVqUjlKSXF5NTRIc29nYjJ2WDN3RklFK1VGb0dwbDRHa3N2?=
 =?utf-8?B?eG1XMHJnU3hoQkp1SEFXTXhFSmtPVTRZMEhRcmRlTFFFOSs1N2lJbTArbXQ0?=
 =?utf-8?B?ODdsT3QveGdCOUd0d3FMR1FIZnN3TVhoaE5IL3VEMHFhVWdzbkVBVURyc3JE?=
 =?utf-8?B?L0hUYmk4dGpYaWZZU1pyUzd4M2U5L1pEaVVqZGNZUXFoY2pKWnZNSkoveWRS?=
 =?utf-8?B?cWVQOVZNMytUUEhmTnl4ZmNsOFdHZkcrZ3BmNmtTUWNNZGxKQWxoU0liZU80?=
 =?utf-8?B?dWVtNktWakg2RllFSjZKLzJsYjQ5bkVUMDZKT3lGRHhWMDFOVVkvKzU5S1NR?=
 =?utf-8?B?TGljM1h3RzFHczVJSlZzTkM3TWZWOTkyL2E4YmcrL0IxTW95ckc3OUNOWExB?=
 =?utf-8?B?M0ZWQ2FyTjU0SElhRHpYbC9RVFhCNFU0SFlPeGE5UGUwdEx5RlNPVUh1OEtN?=
 =?utf-8?B?bHJMYXRrQjJtUVdNYk9XblZBencyNGNkMGs5cmN2WDQ2OFRWMVlRdS82RXlV?=
 =?utf-8?B?MG9HS1FQNVVaTElQdG1PUmowYy9YUUJkaVNGdEdpbWtEc01QQldndW1VYVNV?=
 =?utf-8?B?OGJ0c1Y5dXhvaXMwaW1ma1BLWHZhakJuakpXcER6clVrTkluR0o1TldIL1JI?=
 =?utf-8?B?QkIyR1k2N1huWjgwTnBMaGdVNzFKYktDTlRuMVZnbjh5VE1uVmtDWEdmRHdj?=
 =?utf-8?B?L2NLM0paV1UyMUNYRHlIdFdWWU43cWNuKzY3NzJxeUVVdWdXUStlR0YvWk9r?=
 =?utf-8?B?b2F2WFBmc2xNVGxqaklYQUl1QmpnZVIySWl4eFhzTUxsOFozSVlodFhnRVFC?=
 =?utf-8?B?emRDejRua2RITStuQmFac2R2VjNBRFZIemZ5Tm9CLyswdzhtbjBrNnIyLzBp?=
 =?utf-8?B?L0ZhSXZOeTFxYXJPYjJ5ci9FOEhxRnJDSUVuQVZibkxKRG5QeUdhZTltRGd4?=
 =?utf-8?B?WTRUOFgvVDV3a3ZuV2t4NGw1citGanhGYXpmSnVlTkNIeGkrSHhxdHBIOVVD?=
 =?utf-8?Q?s4wdntpQHmQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTB5c3QvTzhSUXZOU2pSQnk1OEFpRDVMTEtFNkdENmVVWmhXdUM5b0w1Y0xi?=
 =?utf-8?B?M3poVDU3ZEQwZmREclhxSnBya1UybDd5M2lFbGNKdlUwRXo5RWxlVFJYNDNQ?=
 =?utf-8?B?NGhiSFJLUVJFMitXc2RzT3BYMkRRNnhSbGdmaGpna1I4dnRXVU5aaGxZbGJR?=
 =?utf-8?B?MDJJZFBBK3J5NXlQNnp2YWI1WjNqQ1dkVmJybHFyQ1R5YVpNeDF6bnNVeFlU?=
 =?utf-8?B?cWhMN2tvQ3NteC9rZWJtUC8yb25NVWlxaTJjSnNoNFcxSjlaMXVwUGJXNnpm?=
 =?utf-8?B?Kzd2N2d1cUU3MEk0amxwWDI1anFWcTNuUjhqYXhCbjIrRWZwK01Gdnc0M2Jz?=
 =?utf-8?B?Q3g5dHBDMktLU1h2UFpwQmgxdkM5M0FkZitVWGJlVkhlRzYwdThLZW0yU2JZ?=
 =?utf-8?B?b1dTZmRxRWF5dCt5Z0pCdTBaMHIwdGZWZG9PenlQUWdmRUFhSFZUNTNYWXRW?=
 =?utf-8?B?SzBnQ04xaXBuelN6WnZTb1JKRU0zUHlkbkpieEhKQkZKekE3TEVtYmFaRzlV?=
 =?utf-8?B?aVgzL2VyNDkzZzRwdUZYRkJYRHA0YTBScEY1MnNteDk0dlVBRHdYV1p6cWF6?=
 =?utf-8?B?TmlTd2lvZVQ5a2ZreDZOZHA2MlZqbE9qK1RRNllSYmQ3YjQvSFlFQkE2M1lY?=
 =?utf-8?B?aEo4ZTlrRGtGbEhJWEtFOTNQYU5wN3hiaDQ2aFllL0NEWUI2VUZIU0hnTFlT?=
 =?utf-8?B?NVk0dVBWVkxlZm9sa1hZcFlNRW9WM2ttQ0FHRmJkOGZ1bG5BSXIxQ01TeDdn?=
 =?utf-8?B?b3FZaGhGTUZWRDYvUC9PU3BwM0N4REcxclVkQnNxK2Ivd05ycnd4MlRmRlhP?=
 =?utf-8?B?RXFPejZMc1ZybTRDUzFMb0pYbFNhNlhkOERxNmlvMVBudXdGRnQwY3BQV3V6?=
 =?utf-8?B?WkFjQWdPOUtOTnIvaW1pdmlnSEg5RVE0UDZoMzRkVW0xMEt2WStHb0JjTlZD?=
 =?utf-8?B?TDR6cFozYjhBMjloc3l0c2tNTWptTkFoSVpLNUtTS3cwMDJxbldWSE5XdDY4?=
 =?utf-8?B?WDBkQmxseUF4akNXbXp5a3puUHlzcU8wMUlsa3FxZlZhSjlhQjFnU3RyMlVz?=
 =?utf-8?B?UG16MFYzQ1h6WFNqMGRBU3NqOFB0cGF5b1hVOGhWWnRCc1NXWGRtQ3c4SmlV?=
 =?utf-8?B?NHNwaDlRZUNqK2lSdHZNSXlHMUdwcm9aMFo4NUZJU2pzdWlGdG04YThPc0Jn?=
 =?utf-8?B?UjJkOUIxU1VkakxrYStVNktnU0x6ZjhwUjIxWEU1aFFrMyttWlVPN1lnWEda?=
 =?utf-8?B?b1EzQU1ZT05Ia0VReExsWnlqY055b3FodENDK3haL2wzek5HejBRRUhrbzJy?=
 =?utf-8?B?Tlg0dCtPdmtlTVAwcnNPZTVSZ0s3dmNFbU52UnJqWTBxRTJCSysvbnk1OGZh?=
 =?utf-8?B?Lzk3Yy9zK0tYelU0NWVVSUdqQ3k4N2toNTFvVlA0VWVrOTZTdXNiVU5RU2NU?=
 =?utf-8?B?Qkp3UDBadFRySUw1bEhRMGl4UzdWSEtucVhmakQxei9YR1IvS2U3dCsvck55?=
 =?utf-8?B?YmdxamlBRDVJSWFYYmtQNC9ZRzNCTHovVVprMkVqVFIveHlnRElDcFVMY0lV?=
 =?utf-8?B?a1JiRTRrL0FFZVlpZkdkYlV3YTkvcFRUWmx1Q21ROGE0UVp6aFRvTWRRdEhT?=
 =?utf-8?B?MmpXcDcwajVzTGZJc2E1RHlJZnFLdWpuYUg1L1grcFpkeFpWQm56ZnAzaFVx?=
 =?utf-8?B?K1FraGRzVDZVNjVzZ3plbEFLdlBuanNyWjFkNm5xMVZLamp5QmdYbW1RZE1r?=
 =?utf-8?B?K1JYVE83bVk2WnI2eXE2QUQ1elJjVTh5WStqellqUTVjTWt4VTZPdUJQOVBj?=
 =?utf-8?B?VXhWSjI1LzNPOVJLbHlNYVFhQk8zZDhpdXRYVHZISndtTHpEalVwL2RjOVJr?=
 =?utf-8?B?R0VSK2pyK0RMelc2OVhWa3dZeDNNTm1BUHJzUFFiTTQ5LzhvMm9ZRGpRVGth?=
 =?utf-8?B?VFhNUVdDUUhKd0swaGZxVWtLTEpoRVZKUmVXLy9nMmZQWFZsc0NCeFlLL2lT?=
 =?utf-8?B?NE9yNFRDNklGU01Lelk0cWE1U2o3N1UrTjZxd3AzdENYc2Zhek8zeTM0Y1R3?=
 =?utf-8?B?ZVcyVWhkZk8xV1NrWmxlVGJHZ0FtTTBqeGxoQUZ3eGFwRzNkd1NXdkdJa1p2?=
 =?utf-8?Q?danL+K/syca5oaYMv4xgs65O9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d3bc56-731c-4d26-ffc3-08ddaebf1e6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 23:23:23.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79RzfkfIQ8qsvSWtT8eOtfq+xo5bLIgYR81ati+hT51IslmKwU7aSPdvbK674VM9WXn9Yh/VU0EyY/VwfpQhiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022

On 6/16/2025 3:44 PM, Shannon Nelson wrote:
> Brett Creeley is taking ownership of AMD/Pensando drivers while I wander
> off into the sunset with my retirement this month.  I'll still keep an
> eye out on a few topics for awhile, and maybe do some free-lance work in
> the future.
> 
> Meanwhile, thank you all for the fun and support and the many learning
> opportunities :-).
> 
> Special thanks go to DaveM for merging my first patch long ago, the big
> ionic patchset a few years ago, and my last patchset last week.

Shannon,

Congrats on a well earned/deserved milestone. I wish you all the best in 
wandering off into the sunset. Your guidance over the years has been 
invaluable and I hope to continue maintaining our drivers with a 
fraction of the patience and grace you have shown.

I know I already signed off, but I figured it makes sense to do it here 
as well...

Signed-off-by: Brett Creeley <brett.creeley@amd.com>

Thanks,

Brett
> 
> Cheers,
> sln
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>   MAINTAINERS | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 99fbde007792..437381aeaa71 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1157,7 +1157,6 @@ F:	arch/x86/include/asm/amd/node.h
>   F:	arch/x86/kernel/amd_node.c
>   
>   AMD PDS CORE DRIVER
> -M:	Shannon Nelson <shannon.nelson@amd.com>
>   M:	Brett Creeley <brett.creeley@amd.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
> @@ -9941,7 +9940,6 @@ F:	drivers/fwctl/mlx5/
>   
>   FWCTL PDS DRIVER
>   M:	Brett Creeley <brett.creeley@amd.com>
> -R:	Shannon Nelson <shannon.nelson@amd.com>
>   L:	linux-kernel@vger.kernel.org
>   S:	Maintained
>   F:	drivers/fwctl/pds/
> @@ -19377,7 +19375,7 @@ F:	crypto/pcrypt.c
>   F:	include/crypto/pcrypt.h
>   
>   PDS DSC VIRTIO DATA PATH ACCELERATOR
> -R:	Shannon Nelson <shannon.nelson@amd.com>
> +R:	Brett Creeley <brett.creeley@amd.com>
>   F:	drivers/vdpa/pds/
>   
>   PECI HARDWARE MONITORING DRIVERS
> @@ -19399,7 +19397,6 @@ F:	include/linux/peci-cpu.h
>   F:	include/linux/peci.h
>   
>   PENSANDO ETHERNET DRIVERS
> -M:	Shannon Nelson <shannon.nelson@amd.com>
>   M:	Brett Creeley <brett.creeley@amd.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained


