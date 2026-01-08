Return-Path: <netdev+bounces-247971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5227D013D1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 07:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B6F73014D96
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 06:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7355A275844;
	Thu,  8 Jan 2026 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="exAJBaTV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5313A0B10;
	Thu,  8 Jan 2026 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853443; cv=fail; b=LRuhaKaATqFy6kw86M/0zMYj4NV3UCYJrYPNzD+4cF/YOLunAPRmftCPg0dou/2LLkYw4LiBFoMBnUbT2VthjqKsaovgUl7CFH1SgRPZ0y4hYqcvCV2WPjuNay25yEY1Q0aoC3t3XgMI0VuCLaOv30tKDeIr1aPXbE3ZdX98gHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853443; c=relaxed/simple;
	bh=PymscyreWxsA0OQez3uBPuMnBOGYQVoW55JX5o6GV8I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VHSd/etSaYsBruU+JyyEa/vtKyDeoQnkR15NJZwCUJxjMh9QBp4+Z8MNwIMj0TpvdDKA75VPpdTfeiEmnZE5D625/VoUfKMTX+uX93BX4IMqCw4cWkJQPX/dAwVp4RFCZmovHno1+6BugMGJjW3lbAuDGC7QZvGzZiovyiO2gxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=exAJBaTV; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607M8Hq02825438;
	Wed, 7 Jan 2026 22:23:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KVW6DBx9Ww8AKgNexlgco7ob5TXJGi6mX+hUxPfR8Ao=; b=exAJBaTVzMnq
	KkVrQWnk+AEJGqGVFggUe0VVYq9vGaZlySspZPp8ZWhsKdjyXewimRc3t6Rq5o6v
	8PpdYIoGBsZxKz1t1na2rDa+u3b49wFGeDflnSqr8kO1JbEQ4qMbbHxmpFNyeFhn
	E0usC7hZw3dQDgJwdE2Cq4UGA+h3gEF8UJhxFxrZBv7Zxpv71VGYhU+JkOicSNAU
	GJM7lsaV3Tppo8Re1y0BaFAltEnopozNKCOQWEyOkchFFlWDchPVKcFSOFENpw0R
	JjH7d/oWGDxowmoF4hoi22GA/tC2pXjxynkfAUbmwTlyVxzNfRdur4jc2gxcQuGt
	6ddMoYu1Rg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bj012k303-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 22:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO6cUCsVxPBK+gMieNSn0Zkaje1Y2wiGAILmBxKr6TbvmNijjSRK9kPX2XRudFXx3txLtgMJkLpZVCpGpx8gR/TMOAEUC50CMd8EbY3lvZPSkfcGYsK343+X0l12gI/kKceTBzRpgpbW6m2NHBCda18V4ZdHc9/w5UWSN6595bfAcrmXJ3XsBICIIDjkEbnNpqDxBp1nb4w//wzocc5AXqJo9DLYUiK+61d15PQ6fH1Nx/LIK5yThRaY8lM/r/RAUhAf9gkm8zOe9q/2mCPtQCge2CQ+hzNy7GKU+mcKkpm/aOBiIFLpYaVnIo41U9c9EGm3hGKa+SWzqgoY3bwaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVW6DBx9Ww8AKgNexlgco7ob5TXJGi6mX+hUxPfR8Ao=;
 b=xs4YP5JR42vF2mCNc/CIbja5YXDqtTI7RgPkPaAQd8cCUgOy7n6Ik+gQq+Mj4vayx/mOBoifsJqq5op4A/VDiLgP2TXpj3cN0AE4t+aQrksQ4vmqacXdKEddTzbA5Qz7ctkJAqYTowVHvK4gTnZjUKMDpy13g0bIwOh9e6i2GsNxYyxUycQt7Qa6XbdnjvP+Z0YQaHOBclxQl8yNNSd2v76WfuAUAZdqi8Y9RAbzCKecd9qJGiy1DXqV3PfhbHd9R1kc7fZwsIFm45FNL/b5vTO/ayGeSmeMX9m+lIQgPioGEFOx3f3OqnCyt72wD9lYcxgBzjUQkFtjqbB1goST2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by PH0PR15MB4183.namprd15.prod.outlook.com (2603:10b6:510:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 06:23:42 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 06:23:42 +0000
Message-ID: <bba34d18-6b90-4454-ab61-6769342d9114@meta.com>
Date: Wed, 7 Jan 2026 22:23:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio_net: add page pool support for buffer
 allocation
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260106221924.123856-1-vishs@meta.com>
 <20260106221924.123856-2-vishs@meta.com>
 <CACGkMEsfvG5NHd0ShC3DoQEfGH8FeUXDD7FFdb64wK_CkbgQ=g@mail.gmail.com>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <CACGkMEsfvG5NHd0ShC3DoQEfGH8FeUXDD7FFdb64wK_CkbgQ=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:40::37) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|PH0PR15MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d46a7c7-d5e3-44e4-17d0-08de4e7e761b
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZFRzRFlyZmhQN3lkaFpvYVVNM3I3OThWQzBSbklFck5oc3N0RU9jRDdlT0RP?=
 =?utf-8?B?Q2I4dk1YNHF4TGJXK016aCtBUkFCSi9TbkhoTVlvQzFnRlBDQllJTVZZL2RW?=
 =?utf-8?B?VDhPM2NYQ2hJQTJ0N1FjM1F0R2s2TFlRY2tqUWtvS1FMdVBDL0tLOVdwK1pB?=
 =?utf-8?B?cjJtVFVuKzkxbjhmdGZpb2V5RGV1L3J4OU9KcGt3NEJHdGlsRFo1dnZFWE5X?=
 =?utf-8?B?Rjc1T2x6bEFRZVd1TUd1MUlyS1hXd2FEUEM3NTZ0WjlNV1d3SXVMbTNXMDdF?=
 =?utf-8?B?MDFyamErcXVmUmtGRmxaWXlwNjJaMXh1R1hVOUI2dnlHYjRjalRaZnhOWjdV?=
 =?utf-8?B?YklwejcvMEI5T1FkYTI1MEV1R2xDVno2NzJiSEJVbE55ZEpLRGFFMzI3TUlr?=
 =?utf-8?B?VlZDWVdScnpaV0lHa21qcEx2MTJETWVaUjhPZjF2aWJ6YnN6UjJHRjBFdVVj?=
 =?utf-8?B?WXkydTJWQnJFajhWMFRlcWFFQUt6ajU2dG5WWWp0WUNQa3lFOEZEMWdsRW1y?=
 =?utf-8?B?SitYUjJsSWZWMC94K0NIUmZMYnRSSUFZbFJmUDZPTWJMcEZodUV3WE1jWFIz?=
 =?utf-8?B?UytzVTZjMUlacjJJTVIxMWZ4a0JjeUVQTHJ6SnExdHN4UG9pZEVwM3dNdENB?=
 =?utf-8?B?aHRtZStDSlhtYjFyblV0bXN1YTZvd2F0YUNZeCtlRXFVVml3ZS9JUHMyajFk?=
 =?utf-8?B?WVloRWYwZGJBRks0SkR2V2tBd2YySC9Banh1VkxLUldIZEZURi9ibnZ5Mkc3?=
 =?utf-8?B?MTR1Z2hpMHpIMWNaYWFnUnFITjZhT3ZTSDhDNDFZVDZOK1p6S2dwbzFJaXpa?=
 =?utf-8?B?cjBpNHNJK0I0YnZHaFIyRjdpckhHY3hOS2srUk9XQTZYb25HUjNTUG9zcHgw?=
 =?utf-8?B?TkpNdTZhV2psaGkvRzZEYS9IUmFtSnE0N0RIVEE2a2x2VEFmR0FzRllwdUdj?=
 =?utf-8?B?VkxJUG1UeCtKcDhUMWZFSEVYd1JLa3RoUWl3OGkyRUNZTTI5S2pMWEpTUzJN?=
 =?utf-8?B?NEZiREZ6ZG95QVhPRXR6VnR2enhlOVZxcm5CWjRDVDF3UnVaQUxuMkVnTFhx?=
 =?utf-8?B?aXo0QUNDYU1UK3pYdlFZdmtpSnVlRkNxN2V3RFR0SnBMakRINWRuc29QR3Yw?=
 =?utf-8?B?Q2VmaGJDbDZkaU02bXZ6T3IrMTVRWjJ2SUNBTHR4dkVaZThoQmFDZkttcGth?=
 =?utf-8?B?dEtvMXVDTm9NVkgzNHpsNWM2OTF2dXJUdkZLZEZIaXNBbGVMQTdRUWRreU82?=
 =?utf-8?B?YTNZNGU3NTNrT1lTK09YbFFqcFRkK3lTd2RkcG1yWFZyUnVJenArWFFyZUpM?=
 =?utf-8?B?WCtncmgrQWhUbDR3dXlScWd6UW5zTy9LUDZVM1FhZS81OG9CZnpzaUMrSGx4?=
 =?utf-8?B?VjBMeWZkSUZZV2xFd29NMlpmakMydmx5aHlxUkpxcTJtSkR4b0lBQmEvYTNH?=
 =?utf-8?B?U3A3SWU2cm54c3dhZVF4V0hHT1BtOUZ4dUI2SGJzR0p3WU9yVjZ6NndORmVM?=
 =?utf-8?B?aHNDVlp5Z3ZHWWx3Q0ZUTDNxNjZzN2tjMmQxNEJsVlFDV2I2cUI2MlpsWHBZ?=
 =?utf-8?B?NGJ5Z2tBT0xkckkrY2R5WmJXNGlCVUF6QU5qUHFnbmNOK0J6NjBPN3I4Rm9t?=
 =?utf-8?B?aUpIY20zWGx4aDd2SUJsRWVaNlpLd2x5ZnpQRWZ1N0FyQ0FKRVRQQVVpSGRo?=
 =?utf-8?B?NkdDY0l5bTZ5NWU5eklCT1BOTnJHQjhlbU1GRGZPVGc5TE5vSXlBbzRBZWJO?=
 =?utf-8?B?bkpVdlRFRHJ3bjFkZG8rVFl1RExRNkdwSlF2K0Q4T0JselBZaTJVbWk3WUlY?=
 =?utf-8?B?QkZaK2lRNzdNdHB2VHUrS0NISGxvbm95R2hFamNEYzBMbDVqQXZOekRCZ05h?=
 =?utf-8?B?Q2VDdm9ucnRqYXNPdFJjUXBueEcwazdFRGRVcTRVRzV2Q0dueFdZcGFIaGRa?=
 =?utf-8?Q?mPSlpyWCa4ErzqfX20ASUpB3M4dhaa0e?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cWVmdzBSZlA0REpSc2M5dTl4bTR1OG9rSFc5OGdDWnZwREV6bTQ2a3UvNlBY?=
 =?utf-8?B?M3E5NnFia3NKeWU3YTFwY3lxa2JLWjNISTJXRElVSWlRcTdxaUV2QkJ1TFQ0?=
 =?utf-8?B?V2xnYVBZUUw2dDZWMDNtTEgwVG4vOGtXRFJlSlpweWprMFkvR2lrZG5zOXVk?=
 =?utf-8?B?VjRaTlB3UVBFU3BRckR4RlRjZmFGOGJidWFGNlVGY0JFaWhzZ1dPVUVIdzdp?=
 =?utf-8?B?dW5JUUplbG5CTVpFa0wwcGE2bkl0VWtZZFRxc0Z4blU0SlhCMXg4eFAvbnpt?=
 =?utf-8?B?VnBNUFN2TG1XbEw5RXVRR3R2V2JQOGdvZ0V6MWRUbVY4VE5mZ0wrN3JhcTV5?=
 =?utf-8?B?d0ZSWXoxZWpLWXVrcnZ3ZWh2bWJuNFRzNFJKU3JhN2U2WncrWWRDcE5ZdVQ1?=
 =?utf-8?B?dzl1UWI3QVpqUi85N2FsM280ckNkK0JXMnhyNDI4V01NWjdBL2FRZUlVMUNl?=
 =?utf-8?B?VkdZbXJQQlZqU2hWZS91VU1PYXhSYWtLQ09zU2srRGJOMjBwUXdzZnRjbHJF?=
 =?utf-8?B?TEVSNGJTNFZXa1VlOUx5OGYwNmt2NmUrcGp3OWFSR2NVVzdldXdjTEx1RHdO?=
 =?utf-8?B?b0R1d3IzYkJHOUcwNSt0c1l0SWpWM1o4MS9MbllaTXVCcytvWFVSYTFad0JH?=
 =?utf-8?B?TVNTdHE2YVM2cjU2cG04aUJFaUtTTGJ2aHRVT1JuRXFpdDU4MTc0M3FKR1Ft?=
 =?utf-8?B?MGZKWEMrMk9iQkVKeVRydEQ0TFpLR09Pb2xTbXliaklkUHVSUFV6MEhzaGVD?=
 =?utf-8?B?NjBKa3lJTWhETUJ0TUxMKzNRMzg5a3RhSjNmSzFYc2VySlB6d2ZoVUJkaExy?=
 =?utf-8?B?L0JzMU8rVHFvTXA1LzZrTkZzVnVPYWdZZmIxejVVOEJSY2thdC9OT1dXbVBk?=
 =?utf-8?B?NEl2SUtWUzhSRDVpSlhNZ2x6cldqcnBkaUJIWitrcE00T29kUlRzR0hlMmVl?=
 =?utf-8?B?RGFjTXRPQTRqOGlMK3BwdktwNEkyQnBCQXlweWVKUWlIZlNLRTFTTkRvWUgw?=
 =?utf-8?B?V3A5Smhhc2h3bSs2Mmxva2gybzFsb2orQURJanR6eHBZY1dmTnk0SzAwd3ZK?=
 =?utf-8?B?R2t2YTNzUzJjUE53MkF1R1N4aGRWNFdnMTVqVmRwSTNUMitSamxBalpZbWR4?=
 =?utf-8?B?Ty9GSjZncFZLYml5Y3VVUVpTdUVwTGEvYS9BQWZGcVZBbytvaCtuai90NHhR?=
 =?utf-8?B?SnRVaWgxYytZVS9HaVZSZkJRVWEzVEFUWTVSUUdTQ21mdFAzbUdMTmtDU0Er?=
 =?utf-8?B?QXJTNzVEVDdJVW10QjZ5OEQwUDd4c3B5TzJNdmkxLy9QTWdxcmFHcC9iSTM5?=
 =?utf-8?B?b2N0eWwrdlRmVk94NnRwcmpDQml3ZnY3eVFGVEpBL09lRHlPd1BBbEVYUURN?=
 =?utf-8?B?THRLYzIwU0pwQkppRHV0bnk4ZkRNZzJzZ3VHaDdkMXFWMUI5TW9Idk5yNi9V?=
 =?utf-8?B?VUdGaEk2eHNBb2xXYWpRTGEzRThnaHF2c1N3TTI2K1R4dnd2WWFGL2gveUtV?=
 =?utf-8?B?QVBxRGNHL2NXeTNSQ2I5UVdMdTlEaXpsbnY2L3Q4WDRiRXV5MmpEQVQ0c0p4?=
 =?utf-8?B?OHpRSXBjOFI5WStWZnNObGVXRG1mcHZIZlZoZk5sR2Y5aHg5SHZyblBUMlRT?=
 =?utf-8?B?eDVub0NjTnhabVE0YWE1RWJmU0V5ak96TmtDNll4NFhwYjlTblk1aTArT1k0?=
 =?utf-8?B?bTBzU2lwSGJNL2c2eklIUDZqa1lxbnNUOEVaUjBaMFRtQnlsNWNFY1I0VDU5?=
 =?utf-8?B?b0dJZk9sQkxSWkxTam9Ka0trbllCUWJncWZkMmZqcEtUTHdLUTNKVkRSUGF5?=
 =?utf-8?B?VExQQUtBSUdZSlRFTFd2ZDNBem41MG5MMHVsWHhCdXJvejBMa2orS0JXNi9B?=
 =?utf-8?B?emQ2dGMzYloyZVpWVFBNdkFjUERRbzBYVHlUZ1BrdWF1Z2xlaC81eDdnOEtZ?=
 =?utf-8?B?NzZ1NHk3dmUyMUxjNVF0N0FMTEczYXppRC94NHc2K2JHM3Qwc0g5aUZQSnBh?=
 =?utf-8?B?ajdGeURZMm5FMXVNZ3VuMy9JcWE1R0tVVkxCMkpPb2MyT1RtWVo3UnkwZ1lK?=
 =?utf-8?B?bzIxVXduUlBndTAyNWxITUFsL0JPRWNsS29peFdyUXArRlN5NXR6VzVObXJt?=
 =?utf-8?B?QzVURGdiSHdjclBUNXQyNnkxUjRLSnM4RmJkVmN4RURYbXBZM3ZmZWdORk1t?=
 =?utf-8?B?WW1NSmtOQ1JHL3lXWFJBa0U4azFScEloeW9Menhuc2JlN0xlU3dNZUNRcmxL?=
 =?utf-8?B?eEtDaVVPSld4ZUdOTnRWdXdYTXhpZGpkaFlBVEwzcHZMWmRWdXFyYmh2TCtD?=
 =?utf-8?B?dlpGSEJXQStwZDM0bHlIcjlBaXMxRkRib0oyWU5OOWtkMlZvakMwa2Z4b1Y0?=
 =?utf-8?Q?yLc1G3ALbalpbqrbsAknddtDxosMD52nGUadc?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d46a7c7-d5e3-44e4-17d0-08de4e7e761b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 06:23:42.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaV4fS3bG2Sbuyr/5JWvG8k4c+3WLSx+hGKv1jG4ocQL2hYDSQNZbmfhufixQvLD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4183
X-Proofpoint-GUID: S_AnPVhNiB3o1Vu0MCa_XPmudW0F3pwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0MCBTYWx0ZWRfX8QwEYHrhUNe8
 CuPGzDH+c6cEATEBuVHUO9RUjJITFbWxEJ+xuslbKDpDuIePHS9AWYRwDp+4xJpeC8YnvnrIupr
 ZmA8XcIDTWlgILM3Viu6JJgF9s9H5ntgLXBnEl+Hi3s7TdVl+xpCRQsZ2qvlPnoVizZnYhtRA/+
 zb+/vMWHk4VAvBTQYZxWVF1Q9GDOmw5Fh4soR62lBGEMn8vmgICsvhZmoFb9z2fZ9kQ7LPRGkQA
 u6oRvtseatVAEiGsBFVxyMOFibS09VYHqV/M31/gQW4dWLJvsrcWf979cOrQozkFzEayStQ86L3
 y9C0pLnvqF0EYWeFGeZ2xiDWLocMdDI5nAoC/ySukvhZ3dEqAQFLuebnyVl2QgeD89PJU4K91ac
 MDyKUffsEAFhBE7lQzdJYZo1qEhJbEXvfGsW7SmQJk1ZjNPyCRI5pQtW/HOfYNL7t6n6ObM/iKv
 8x7KCYqEUHyTbuHfc5A==
X-Authority-Analysis: v=2.4 cv=NbzrFmD4 c=1 sm=1 tr=0 ts=695f4d71 cx=c_pps
 a=j7tsCyGgeYHcZD8MHzM6Gw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8 a=tNSRbB-iok2JFjEo9hQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: S_AnPVhNiB3o1Vu0MCa_XPmudW0F3pwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01

On 1/7/26 7:16 PM, Jason Wang wrote:
> On Wed, Jan 7, 2026 at 6:19 AM Vishwanath Seshagiri <vishs@meta.com> wrote:
>>
>> Use page_pool for RX buffer allocation in mergeable and small buffer
>> modes. skb_mark_for_recycle() enables page reuse.
>>
>> Big packets mode is unchanged because it uses page->private for linked
>> list chaining of multiple pages per buffer, which conflicts with
>> page_pool's internal use of page->private.
>>
>> Page pools are created in ndo_open and destroyed in remove (not
>> ndo_close). This follows existing driver behavior where RX buffers
>> remain in the virtqueue across open/close cycles and are only freed
>> on device removal.
>>
>> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
>> sending control virtqueue commands while ndo_close is tearing down
>> device state. With MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() calls
>> page_pool_destroy() during close, and concurrent rx_mode_work can
>> cause virtqueue corruption. The check is after rtnl_lock() to
>> synchronize with ndo_close(), which sets the flag under the same lock.
>>
>> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
>> ---
>>   drivers/net/virtio_net.c | 246 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 205 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 22d894101c01..c36663525c17 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -26,6 +26,7 @@
>>   #include <net/netdev_rx_queue.h>
>>   #include <net/netdev_queues.h>
>>   #include <net/xdp_sock_drv.h>
>> +#include <net/page_pool/helpers.h>
>>
>>   static int napi_weight = NAPI_POLL_WEIGHT;
>>   module_param(napi_weight, int, 0444);
>> @@ -359,6 +360,8 @@ struct receive_queue {
>>          /* Page frag for packet buffer allocation. */
>>          struct page_frag alloc_frag;
>>
>> +       struct page_pool *page_pool;
>> +
>>          /* RX: fragments + linear part + virtio header */
>>          struct scatterlist sg[MAX_SKB_FRAGS + 2];
>>
>> @@ -524,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>>                                 struct virtnet_rq_stats *stats);
>>   static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>>                                   struct sk_buff *skb, u8 flags);
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +                                              struct sk_buff *head_skb,
>>                                                 struct sk_buff *curr_skb,
>>                                                 struct page *page, void *buf,
>>                                                 int len, int truesize);
>>   static void virtnet_xsk_completed(struct send_queue *sq, int num);
>> +static void free_unused_bufs(struct virtnet_info *vi);
>>
>>   enum virtnet_xmit_type {
>>          VIRTNET_XMIT_TYPE_SKB,
>> @@ -709,15 +714,24 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>>          return p;
>>   }
>>
>> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
>> +                            bool allow_direct)
>> +{
>> +       if (rq->page_pool)
>> +               page_pool_put_page(rq->page_pool, page, -1, allow_direct);
>> +       else
>> +               put_page(page);
>> +}
>> +
>>   static void virtnet_rq_free_buf(struct virtnet_info *vi,
>>                                  struct receive_queue *rq, void *buf)
>>   {
>>          if (vi->mergeable_rx_bufs)
>> -               put_page(virt_to_head_page(buf));
>> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>>          else if (vi->big_packets)
>>                  give_pages(rq, buf);
>>          else
>> -               put_page(virt_to_head_page(buf));
>> +               virtnet_put_page(rq, virt_to_head_page(buf), false);
>>   }
>>
>>   static void enable_delayed_refill(struct virtnet_info *vi)
>> @@ -894,9 +908,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                  if (unlikely(!skb))
>>                          return NULL;
>>
>> -               page = (struct page *)page->private;
>> -               if (page)
>> -                       give_pages(rq, page);
>> +               if (!rq->page_pool) {
>> +                       page = (struct page *)page->private;
>> +                       if (page)
>> +                               give_pages(rq, page);
>> +               }
>>                  goto ok;
>>          }
>>
>> @@ -931,7 +947,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                  skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>>                                  frag_size, truesize);
>>                  len -= frag_size;
>> -               page = (struct page *)page->private;
>> +               if (!rq->page_pool)
>> +                       page = (struct page *)page->private;
>> +               else
>> +                       page = NULL;
>>                  offset = 0;
>>          }
>>
>> @@ -942,7 +961,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>          hdr = skb_vnet_common_hdr(skb);
>>          memcpy(hdr, hdr_p, hdr_len);
>>          if (page_to_free)
>> -               put_page(page_to_free);
>> +               virtnet_put_page(rq, page_to_free, true);
>>
>>          return skb;
>>   }
>> @@ -982,15 +1001,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
>>   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>>   {
>>          struct virtnet_info *vi = rq->vq->vdev->priv;
>> -       void *buf;
>>
>>          BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>>
>> -       buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
>> -       if (buf)
>> -               virtnet_rq_unmap(rq, buf, *len);
>> -
>> -       return buf;
>> +       return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>>   }
>>
>>   static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>> @@ -1084,9 +1098,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>                  return;
>>          }
>>
>> -       if (!vi->big_packets || vi->mergeable_rx_bufs)
>> -               virtnet_rq_unmap(rq, buf, 0);
>> -
>>          virtnet_rq_free_buf(vi, rq, buf);
>>   }
>>
>> @@ -1352,7 +1363,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>>
>>                  truesize = len;
>>
>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +               curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>                                                      buf, len, truesize);
>>                  if (!curr_skb) {
>>                          put_page(page);
>> @@ -1788,7 +1799,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>>          return ret;
>>   }
>>
>> -static void put_xdp_frags(struct xdp_buff *xdp)
>> +static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq)
>>   {
>>          struct skb_shared_info *shinfo;
>>          struct page *xdp_page;
>> @@ -1798,7 +1809,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>>                  shinfo = xdp_get_shared_info_from_buff(xdp);
>>                  for (i = 0; i < shinfo->nr_frags; i++) {
>>                          xdp_page = skb_frag_page(&shinfo->frags[i]);
>> -                       put_page(xdp_page);
>> +                       virtnet_put_page(rq, xdp_page, true);
>>                  }
>>          }
>>   }
>> @@ -1914,7 +1925,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>                  off = buf - page_address(p);
>>
>>                  if (check_mergeable_len(dev, ctx, buflen)) {
>> -                       put_page(p);
>> +                       virtnet_put_page(rq, p, true);
>>                          goto err_buf;
>>                  }
>>
>> @@ -1922,14 +1933,14 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>>                   * is sending packet larger than the MTU.
>>                   */
>>                  if ((page_off + buflen + tailroom) > PAGE_SIZE) {
>> -                       put_page(p);
>> +                       virtnet_put_page(rq, p, true);
>>                          goto err_buf;
>>                  }
>>
>>                  memcpy(page_address(page) + page_off,
>>                         page_address(p) + off, buflen);
>>                  page_off += buflen;
>> -               put_page(p);
>> +               virtnet_put_page(rq, p, true);
>>          }
>>
>>          /* Headroom does not contribute to packet length */
>> @@ -1979,7 +1990,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>          unsigned int headroom = vi->hdr_len + header_offset;
>>          struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
>>          struct page *page = virt_to_head_page(buf);
>> -       struct page *xdp_page;
>> +       struct page *xdp_page = NULL;
>>          unsigned int buflen;
>>          struct xdp_buff xdp;
>>          struct sk_buff *skb;
>> @@ -2013,7 +2024,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>                          goto err_xdp;
>>
>>                  buf = page_address(xdp_page);
>> -               put_page(page);
>> +               virtnet_put_page(rq, page, true);
>>                  page = xdp_page;
>>          }
>>
>> @@ -2045,13 +2056,19 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>          if (metasize)
>>                  skb_metadata_set(skb, metasize);
>>
>> +       if (rq->page_pool && !xdp_page)
>> +               skb_mark_for_recycle(skb);
>> +
>>          return skb;
>>
>>   err_xdp:
>>          u64_stats_inc(&stats->xdp_drops);
>>   err:
>>          u64_stats_inc(&stats->drops);
>> -       put_page(page);
>> +       if (xdp_page)
>> +               put_page(page);
>> +       else
>> +               virtnet_put_page(rq, page, true);
>>   xdp_xmit:
>>          return NULL;
>>   }
>> @@ -2099,12 +2116,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
>>          }
>>
>>          skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
>> -       if (likely(skb))
>> +       if (likely(skb)) {
>> +               if (rq->page_pool)
>> +                       skb_mark_for_recycle(skb);
>>                  return skb;
>> +       }
>>
>>   err:
>>          u64_stats_inc(&stats->drops);
>> -       put_page(page);
>> +       virtnet_put_page(rq, page, true);
>>          return NULL;
>>   }
>>
>> @@ -2159,7 +2179,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>>                  }
>>                  u64_stats_add(&stats->bytes, len);
>>                  page = virt_to_head_page(buf);
>> -               put_page(page);
>> +               virtnet_put_page(rq, page, true);
>>          }
>>   }
>>
>> @@ -2270,7 +2290,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>                  offset = buf - page_address(page);
>>
>>                  if (check_mergeable_len(dev, ctx, len)) {
>> -                       put_page(page);
>> +                       virtnet_put_page(rq, page, true);
>>                          goto err;
>>                  }
>>
>> @@ -2289,7 +2309,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>>          return 0;
>>
>>   err:
>> -       put_xdp_frags(xdp);
>> +       put_xdp_frags(xdp, rq);
>>          return -EINVAL;
>>   }
>>
>> @@ -2364,7 +2384,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>
>>          *frame_sz = PAGE_SIZE;
>>
>> -       put_page(*page);
>> +       virtnet_put_page(rq, *page, true);
>>
>>          *page = xdp_page;
>>
>> @@ -2386,6 +2406,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>          struct page *page = virt_to_head_page(buf);
>>          int offset = buf - page_address(page);
>>          unsigned int xdp_frags_truesz = 0;
>> +       struct page *org_page = page;
>>          struct sk_buff *head_skb;
>>          unsigned int frame_sz;
>>          struct xdp_buff xdp;
>> @@ -2410,6 +2431,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>                  head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>>                  if (unlikely(!head_skb))
>>                          break;
>> +               if (rq->page_pool && page == org_page)
>> +                       skb_mark_for_recycle(head_skb);
>>                  return head_skb;
>>
>>          case XDP_TX:
>> @@ -2420,10 +2443,13 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>                  break;
>>          }
>>
>> -       put_xdp_frags(&xdp);
>> +       put_xdp_frags(&xdp, rq);
>>
>>   err_xdp:
>> -       put_page(page);
>> +       if (page != org_page)
>> +               put_page(page);
>> +       else
>> +               virtnet_put_page(rq, page, true);
>>          mergeable_buf_free(rq, num_buf, dev, stats);
>>
>>          u64_stats_inc(&stats->xdp_drops);
>> @@ -2431,7 +2457,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>>          return NULL;
>>   }
>>
>> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
>> +                                              struct sk_buff *head_skb,
>>                                                 struct sk_buff *curr_skb,
>>                                                 struct page *page, void *buf,
>>                                                 int len, int truesize)
>> @@ -2463,7 +2490,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>>
>>          offset = buf - page_address(page);
>>          if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
>> -               put_page(page);
>> +               virtnet_put_page(rq, page, true);
>>                  skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>>                                       len, truesize);
>>          } else {
>> @@ -2512,10 +2539,13 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>          }
>>
>>          head_skb = page_to_skb(vi, rq, page, offset, len, truesize, headroom);
>> +       if (unlikely(!head_skb))
>> +               goto err_skb;
>> +
>>          curr_skb = head_skb;
>>
>> -       if (unlikely(!curr_skb))
>> -               goto err_skb;
>> +       if (rq->page_pool)
>> +               skb_mark_for_recycle(head_skb);
>>          while (--num_buf) {
>>                  buf = virtnet_rq_get_buf(rq, &len, &ctx);
>>                  if (unlikely(!buf)) {
>> @@ -2534,7 +2564,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>                          goto err_skb;
>>
>>                  truesize = mergeable_ctx_to_truesize(ctx);
>> -               curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
>> +               curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>>                                                      buf, len, truesize);
>>                  if (!curr_skb)
>>                          goto err_skb;
>> @@ -2544,7 +2574,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>          return head_skb;
>>
>>   err_skb:
>> -       put_page(page);
>> +       virtnet_put_page(rq, page, true);
>>          mergeable_buf_free(rq, num_buf, dev, stats);
>>
>>   err_buf:
>> @@ -2683,6 +2713,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>   static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>                               gfp_t gfp)
>>   {
>> +       unsigned int offset;
>> +       struct page *page;
>>          char *buf;
>>          unsigned int xdp_headroom = virtnet_get_headroom(vi);
>>          void *ctx = (void *)(unsigned long)xdp_headroom;
>> @@ -2692,6 +2724,24 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>>          len = SKB_DATA_ALIGN(len) +
>>                SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>
>> +       if (rq->page_pool) {
> 
> I think it would be a burden if we maintain two different data paths.

I will move it to probe in v2.

> And what's more, I see this patch doesn't require DMA mapping for the
> page pool. This basically defeats the pre mapping logic introduced in
> 31f3cd4e5756b("virtio-net: rq submits premapped per-buffer"). Lastly,
> it seems we should make VIRTIO_NET select PAGE_POOL.

I intentionally used flags=0 and virtqueue_add_inbuf_ctx() to keep the
initial patch simple, following the pattern of xen-netfront which also
used flags=0 due to its custom DMA mechanism (grant tables).

My concern was that virtio has its own DMA abstraction
vdev->map->map_page() (used by VDUSE), and I wasn't sure if page_pool's
standard dma_map_page() would be compatible with all virtio backends.

To preserve the premapping optimization, I see two options:
1. Use PP_FLAG_DMA_MAP with virtqueue_dma_dev() as the DMA device. This
is simpler but uses the standard DMA API, which may not work corerctly
with VDUSE.
2. Integrate page_pool allocation with virtio's existing DMA infra -
allocate pages from page_pool, but DMA map using 
virtqueue_map_single_attrs(), then use virtqueue_add_inbuf_premapped().
This preserves the compatibility but requires tracking DMA mapping per
page.

Which would be better? Or, is there anything simpler that I'm missing?

Will add PAGE_POOL in kConfig for VIRTIO_NET in v2.

> 
>> +               page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
>> +               if (unlikely(!page))
>> +                       return -ENOMEM;
>> +
>> +               buf = page_address(page) + offset;
>> +               buf += VIRTNET_RX_PAD + xdp_headroom;
>> +
>> +               sg_init_table(rq->sg, 1);
>> +               sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_LEN);
>> +
>> +               err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> +               if (err < 0)
>> +                       page_pool_put_page(rq->page_pool,
>> +                                          virt_to_head_page(buf), -1, false);
>> +               return err;
>> +       }
>> +
>>          if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
>>                  return -ENOMEM;
>>
>> @@ -2786,6 +2836,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>          unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>>          unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
>>          unsigned int len, hole;
>> +       unsigned int offset;
>> +       struct page *page;
>>          void *ctx;
>>          char *buf;
>>          int err;
>> @@ -2796,6 +2848,39 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>>           */
>>          len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>>
>> +       if (rq->page_pool) {
>> +               page = page_pool_alloc_frag(rq->page_pool, &offset,
>> +                                           len + room, gfp);
>> +               if (unlikely(!page))
>> +                       return -ENOMEM;
>> +
>> +               buf = page_address(page) + offset;
>> +               buf += headroom; /* advance address leaving hole at front of pkt */
>> +
>> +               hole = PAGE_SIZE - (offset + len + room);
>> +               if (hole < len + room) {
>> +                       /* To avoid internal fragmentation, if there is very likely not
>> +                        * enough space for another buffer, add the remaining space to
>> +                        * the current buffer.
>> +                        * XDP core assumes that frame_size of xdp_buff and the length
>> +                        * of the frag are PAGE_SIZE, so we disable the hole mechanism.
>> +                        */
>> +                       if (!headroom)
>> +                               len += hole;
>> +               }
>> +
>> +               ctx = mergeable_len_to_ctx(len + room, headroom);
>> +
>> +               sg_init_table(rq->sg, 1);
>> +               sg_set_buf(&rq->sg[0], buf, len);
>> +
>> +               err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>> +               if (err < 0)
>> +                       page_pool_put_page(rq->page_pool,
>> +                                          virt_to_head_page(buf), -1, false);
>> +               return err;
>> +       }
>> +
>>          if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>>                  return -ENOMEM;
>>
>> @@ -3181,7 +3266,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>                  return err;
>>
>>          err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
>> -                                        MEM_TYPE_PAGE_SHARED, NULL);
>> +                                        vi->rq[qp_index].page_pool ?
>> +                                               MEM_TYPE_PAGE_POOL :
>> +                                               MEM_TYPE_PAGE_SHARED,
>> +                                        vi->rq[qp_index].page_pool);
>>          if (err < 0)
>>                  goto err_xdp_reg_mem_model;
>>
>> @@ -3221,11 +3309,77 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>                  vi->duplex = duplex;
>>   }
>>
>> +static int virtnet_create_page_pools(struct virtnet_info *vi)
>> +{
>> +       int i, err;
>> +
>> +       for (i = 0; i < vi->curr_queue_pairs; i++) {
>> +               struct receive_queue *rq = &vi->rq[i];
>> +               struct page_pool_params pp_params = { 0 };
>> +
>> +               if (rq->page_pool)
>> +                       continue;
>> +
>> +               if (rq->xsk_pool)
>> +                       continue;
>> +
>> +               if (!vi->mergeable_rx_bufs && vi->big_packets)
>> +                       continue;
>> +
>> +               pp_params.order = 0;
>> +               pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
>> +               pp_params.nid = dev_to_node(vi->vdev->dev.parent);
>> +               pp_params.dev = vi->vdev->dev.parent;
>> +               pp_params.netdev = vi->dev;
>> +               pp_params.napi = &rq->napi;
>> +               pp_params.flags = 0;
>> +
>> +               rq->page_pool = page_pool_create(&pp_params);
>> +               if (IS_ERR(rq->page_pool)) {
>> +                       err = PTR_ERR(rq->page_pool);
>> +                       rq->page_pool = NULL;
>> +                       goto err_cleanup;
>> +               }
>> +       }
>> +       return 0;
>> +
>> +err_cleanup:
>> +       while (--i >= 0) {
>> +               struct receive_queue *rq = &vi->rq[i];
>> +
>> +               if (rq->page_pool) {
>> +                       page_pool_destroy(rq->page_pool);
>> +                       rq->page_pool = NULL;
>> +               }
>> +       }
>> +       return err;
>> +}
>> +
>> +static void virtnet_destroy_page_pools(struct virtnet_info *vi)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < vi->max_queue_pairs; i++) {
>> +               struct receive_queue *rq = &vi->rq[i];
>> +
>> +               if (rq->page_pool) {
>> +                       page_pool_destroy(rq->page_pool);
>> +                       rq->page_pool = NULL;
>> +               }
>> +       }
>> +}
>> +
>>   static int virtnet_open(struct net_device *dev)
>>   {
>>          struct virtnet_info *vi = netdev_priv(dev);
>>          int i, err;
>>
>> +       err = virtnet_create_page_pools(vi);
> 
> Any reason those page pools were not created during the probe?

No good reason. I will add it in v2.

> 
>> +       if (err)
>> +               return err;
>> +
>> +       vi->rx_mode_work_enabled = true;
>> +
>>          enable_delayed_refill(vi);
>>
>>          for (i = 0; i < vi->max_queue_pairs; i++) {
>> @@ -3251,6 +3405,7 @@ static int virtnet_open(struct net_device *dev)
>>          return 0;
>>
>>   err_enable_qp:
>> +       vi->rx_mode_work_enabled = false;
>>          disable_delayed_refill(vi);
>>          cancel_delayed_work_sync(&vi->refill);
>>
>> @@ -3856,6 +4011,8 @@ static int virtnet_close(struct net_device *dev)
>>           */
>>          cancel_work_sync(&vi->config_work);
>>
>> +       vi->rx_mode_work_enabled = false;
>> +
>>          for (i = 0; i < vi->max_queue_pairs; i++) {
>>                  virtnet_disable_queue_pair(vi, i);
>>                  virtnet_cancel_dim(vi, &vi->rq[i].dim);
>> @@ -3892,6 +4049,11 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>>
>>          rtnl_lock();
>>
>> +       if (!vi->rx_mode_work_enabled) {
>> +               rtnl_unlock();
>> +               return;
>> +       }
>> +
>>          *promisc_allmulti = !!(dev->flags & IFF_PROMISC);
>>          sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>>
>> @@ -7193,6 +7355,8 @@ static void remove_vq_common(struct virtnet_info *vi)
>>
>>          free_receive_page_frags(vi);
>>
>> +       virtnet_destroy_page_pools(vi);
>> +
>>          virtnet_del_vqs(vi);
>>   }
>>
>> --
>> 2.47.3
>>
> 
> Thanks
> 


