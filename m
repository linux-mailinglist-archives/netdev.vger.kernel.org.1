Return-Path: <netdev+bounces-237202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 852D8C475D0
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F066834A071
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC8314B96;
	Mon, 10 Nov 2025 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Jbqng5g"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C0314D2A;
	Mon, 10 Nov 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786451; cv=fail; b=Q2Dn8/RXKijJEIdWDBNq6Y7Kg8Ccsblz09gN4cvKpAllEWug7ZbgYDoAPZB64UH+72DKg/HgLxWNfDXNsImr3VGZqBptaXLhUW+GdwrnJAjMcC2VS36kFqGPeQpAcqfsfJEwT6B94xAk1cTJHWZs1R9Rj6sNn6FV28IMa70UEVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786451; c=relaxed/simple;
	bh=2HtSS5dtxdPncV/EFRCol7i6J2vl0zn0ov74Cf+aPmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jchz2R9McSfcrwQqtRFHq/c1Kt/kkmSg7byZDc2XAQ79M9KFuPwVdufPc3ysTagTRvHOz+e55JAgutN38loDeuUMIqrjhHiKS/NcLfCkCvk13+aejTRpHrK379flUMg82ruAyJn4t55KIvFujjs6XYlfzDwIbTLJ43lOrevhzPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Jbqng5g; arc=fail smtp.client-ip=40.93.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHX3UIaKCZtkAbhjpHsP2sTfRxmUeMhez3Xjg0b9aY5BmOKy6fge33/A0E3f64YkHbPMX86bFL7G72NW1yDlFQJbz9TIpKEjTCq0sxBN7pyUUnqYNRC7hsfs5nCMPNrSyJLzuCJELC/j0zlvlvyBNLYnU3NrPSlZNRE/RVmTiUUw6K4CQxsRkDoaWm9woT5bNYokQ9irAv3pzMLMBUllqY4wdQbpoXkYLeKeNhibcF+O0ZsjN0d9kS+2+A3qSZ4Dl4+ZGnxMn+hWmWcEEjVnVJBqzb5p5y0VeWyYyJG8N5CNh6tQQB/RjEIYfkNSYCCSW+Exmfy0dvetOrWnRpDRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXQWV26/nIcmYRuC0y/KNNGTW9mjg1mcHM6BNtR50nw=;
 b=y1dXATPSObetUqRuVAcrkGqWF9j2wL1yinp4kiRi21YFaSj/CYcWix1mpG0Zj0/bxGsWO8PIvHZYFad/ADxiSvX3zYJEV54lPy42p4Qc3avoxCtFZ1AS/Fety+NlQPabQSelH1D8cLjlOzHlvoF3Q/7o44oN7EUuQSEeIA1rgdXmRuGcmse+kru4c4z8+E0eEveYxM4Ru4W4vKFveDGvGv1XTcKFFZwoA45410NVwnh8gtSnrilZs3Hfx7HJeg9XWAZcmDDG0BCVi62nKrmIfQVyDHoMOnyk8oic8B5lLVMh2ExvdMBQS14HveMyMcgF3udpSZj9oN/5qxE6u9lURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXQWV26/nIcmYRuC0y/KNNGTW9mjg1mcHM6BNtR50nw=;
 b=5Jbqng5gq2WxLypOyLg43Z1P0+3/TDv6WSP4iqsXalK33Eyx7Gx4+VtDUbipHXCIF/RaIPqzuEAM6l+aHgB2SpugS9ONjIebP5JRoxdl8a2M8gQeSqw20c0AZJ+O2lWwRqvLJzPLGVMuAREk3tMmTVf6cPuNN4RpWtLNOay0lvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 14:54:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 14:54:04 +0000
Message-ID: <6ed6305f-e505-439a-8372-190fc10f4777@amd.com>
Date: Mon, 10 Nov 2025 14:54:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 22/22] sfc: support pio mapping based on cxl
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-23-alejandro.lucero-palau@amd.com>
 <20251007154845.00001afa@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251007154845.00001afa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb9808b-09af-480c-3f40-08de2068fe1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2dtaUNsSnViVnZRNFBINXNYaVpyVXIyWFozV01ZaW9seDVPT3RFU0I2MXhi?=
 =?utf-8?B?NVkveU5SSkV0b2h1UFZ3ZHZQQzU1U055TVU0MnB5Y1N0QXZTZDFzUGxSYXlR?=
 =?utf-8?B?VnVqcVprN0d1dnlXeWp2bXpRdjlJTGJ5a3dZYlBjWHlYQ1d5ckhuUWpOMWxO?=
 =?utf-8?B?SmdrQUl3bWJLL1dUYjlCT3FpekMraytnYW5IUmpyNUFjU2hDR3NaQjNFbXQx?=
 =?utf-8?B?bHF6NjNIcGI0SUZ1YUoyUXoyRnlvN1ZvQURLeFF3WHJ4WDA3eE9OS0doVFlX?=
 =?utf-8?B?c0FJd1JaOFRuRC96ZFptamxpakdxbFYxN2NMR3Q3U0gvVTlzQk5pZ1JGb3hh?=
 =?utf-8?B?MnUvUDljanp5VXFTSkZQR3FPeGtXSjVyemQzd0N1c1IxcGdPcVZnTU9XUldz?=
 =?utf-8?B?Q0F1d0NvaGlLcEwwc1dVV3VYMm5MVnlndTZ4RTZyMjZ6clRtRThMY1cyZVpG?=
 =?utf-8?B?RmlZWitUdG9sVURKYklJSHpCb1JsTXJ5QzdzQmIzLzZSSjNIOHZBeTJ0aFhy?=
 =?utf-8?B?RGkwM3VFRzFoc1JWYXJOTHp5OEJPQ0ZqT1RlY2xEbWp3QUt3QTJHR1VqRXZO?=
 =?utf-8?B?b0lYVDk4N0h5eWxnbCs2aVY2Qnc1S2ZNd3dnMFpPOEVieDhRVGk4SEdZTFU5?=
 =?utf-8?B?YU1XekQ0enl3SWRyalBKMjBiU1I0b2JYTDVNOTZHYkc2dlkxVHhWRmZSRjVK?=
 =?utf-8?B?NC9EREcvb2ljdStTQXZBbTFqZjIvYmduS0dGTDZKZDRUYW1vdEdtM1lSZ1lx?=
 =?utf-8?B?anNHN0JUK3JvOStWQm5YY2Fzd0Z4RFhMRGkrYkJOZzRYUisxZk1kM3dHOGcv?=
 =?utf-8?B?WWdlaW4rRnJPZFZpZE1iY2JobTNUWlJSTFlieTR1R0lYdWVkaElvQXoyWUFm?=
 =?utf-8?B?L1N4OVF6VGFGNUxzS05lYVl0TXAybmU1T3BWZmpjQUNZS0pzVE5XSllJNDRu?=
 =?utf-8?B?cllFR2hRMGgvMzdmSHJSYWN5TWlwamxzZ3BxdnlIUzZITFpiQ0NkZUZWN3Uv?=
 =?utf-8?B?Vlp4NVA2NzlmUDF6OGpLa0ZpMzJGazB5TjZKOFk4WVY5NVRyNVFIL2FjVDJ6?=
 =?utf-8?B?N2ZMK1J1ZDZ2dlAxK2hKdWpTU2hpaWJMUEwrSXJndWYxb0NDbnV3eStOTnpt?=
 =?utf-8?B?ekw1Vm11RUd2VSs3YXVYVkYrWGRXUEo4STlYdUlpL05Ed1lpVisrT0VZa0ph?=
 =?utf-8?B?OGZnOFREYm5CQ05qeWVQaTRsSHl0OXpqTmhJQi84L3EweE43bmVLSGFSYTZW?=
 =?utf-8?B?QkZ2ZTJoL1MzV3B5aFBQTE1NMDhZc1IxNG9lS3BSYlhlUTZYNHN0OEFiSktK?=
 =?utf-8?B?V1k4YUMrSm95UjltbDhGdjhjUCtER3RqU0Z1WDNDYTJqcHZMQ3NPU2k2UlRE?=
 =?utf-8?B?YzExNlhtNkVYYkNhcWFiY0E2Z0Eyand1aGVhRjRFU0syT1AweHJvSUlmdEgx?=
 =?utf-8?B?Y2xweWo5MkovUGJSeE9PdE9kR2YxKytIS1pQODQ5d0YxSzZWQjc0K29UUWhZ?=
 =?utf-8?B?eTY3U0s0YUJZT3RTa3lMTllFbEQxazBkdHJRdDBGVG5RMjh5OVZWc0Vka21W?=
 =?utf-8?B?UTlZZHBPT2F2c204YTE4bGpHNnRzOUF0bS9BdWxvYmh3c21qMWpHNVZUY1RL?=
 =?utf-8?B?bzVkMFFMSGtFUWJnTGhVRjZ0N1RCZHZSY3JVN2Rjb0FGSGVmaklXdkl6QWJL?=
 =?utf-8?B?aC8rM2d6cTN5Sk1vaGQ0aSsxWjNCeHRURVcxd1RhZjlDbWdvZDNRSytOVTBP?=
 =?utf-8?B?M1l4RXJTTmFzUzVrQnBJVjZ0RmpxV3Bacm1Id1lkc1o4aVpOUEZnN1JnMmZt?=
 =?utf-8?B?c2VET0l1b1FHSHNuZDc5Wkl4dllhZVJYemxEYVJhbW5yWm1HUEVKSzJnRHJs?=
 =?utf-8?B?b2k0UlBqL1ZIUnRZZ05LcktZOUFySmtlUGx3ZDVyN3FPVXJYNmZCc1h2bjJp?=
 =?utf-8?Q?QvRbsCQfZLX2NPx7v9WrZrF7xVfOQ/QX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVhleVgwc3FWY1g3RDNtRnBYUkx5OGxSUWVVMHNKMDUvSDI3ZFpVdng4Z3Rl?=
 =?utf-8?B?OHpkc3BwbmYwV0hxNTE5UVBLZkJrYTkyaEdWTGFKZFQ4MTRnUGc3TlFNbDg3?=
 =?utf-8?B?dXNPZDBpeXYxZW44MHZKTlR1aGlISGRaeUlGUjV5QlErejJCYWlDMHRySloz?=
 =?utf-8?B?OGs0TG5DRXdTcFZORTNvVUNmU3dUR1hZLytNY011bHorak9nVG9kRGtEaDIz?=
 =?utf-8?B?TUcrK2hWblFvSWFLOWlMa0VKVUNrdXZhdG1aWFVsZ1NHRWowOHBQRzJ0ZFFr?=
 =?utf-8?B?VWNpY3pUeHprMUZSUWtpVng4cU55SHBjZGd2VWFzRTA3cDRUaFFUUTl2bmpx?=
 =?utf-8?B?YzVuYWZmYkFEV1phZzN0WVNVbHIyZFBXU3J5RUJWenNpLzZ4QUdiNWsyQVNw?=
 =?utf-8?B?aXEyUURvcWgrZGdhMEhkUkNzMStqdHgwaXpjZWF0RG5zaEpBRC9NeTJSNGhP?=
 =?utf-8?B?Yi9SdHJWSDdJVDZ0QTVSV1V6dEVPcnJPOERCblRGRjBvYnVxbG1URmhaTUJI?=
 =?utf-8?B?Wm1SNG5rdnJDRURVRGhKdUg4cmZYVll6ckZhVVFncTlpek03ZXZFenRHMWcv?=
 =?utf-8?B?Z1h0ZnBoMitEWG5sN3R1aStkaFgyTjNXR3BCWlFGTDVJU3I3T0VNYy81S1Qy?=
 =?utf-8?B?c0tyUDhjR0JIbWgvVmtxOUo0WDlrMzZINDM4M2pZeG1sRjl1MHA0SDBNN1di?=
 =?utf-8?B?OCswbEIyaXBxZ01ZUnFmam5YMkplblZScXRtZWl6THN6aEI3d2VBQmxuNEhn?=
 =?utf-8?B?STIwbzVmWmJYQlRIS3A5WHFoejlZdWVDeFhHeUNmM1p2aUhjZFgrQUc3dzBy?=
 =?utf-8?B?Wkgrek5ubk90eWZvZDg0Tjc5cklvN0dQeG9YN0xFZnVFd3BmbENRZk9zRC9Q?=
 =?utf-8?B?eFJ4elJub2JpU2h3ZXIweVpLNDVpQlRSUENkVmxDR1l5dDZxRVpldTAzeFBo?=
 =?utf-8?B?b0FNU3k3cTJJOVJpWUVRK2V0cjNTS1FSNkdjRFl2QXNYRkFwc2pPd3Q4Skx3?=
 =?utf-8?B?RVlwQzc0L2twZnYzR085bDB5OVlNMENONXg1QTIyOWZMQWRwOUtjQ2RBNFlE?=
 =?utf-8?B?NDd0UDk3a1dkTkVoWEp2czhiMjFIV0RZN1ZFbjZ6RUtqZlFTMkp0QW81ckE3?=
 =?utf-8?B?Q1hrTHJ5QkV4SWExeHpvRDdDS3Q4QXZBQk5Zb2V5L3VmT2FiNS9JUThoQ3ZN?=
 =?utf-8?B?T0gzQmdtWC9WaGtBZDFoNzJRZDNDVWxEbHRQLzR6a2RYWk5hM1JNUmE0MkpV?=
 =?utf-8?B?TUNZZVN6SWhpa291SkhNdTM1MEdwVGdPbit5d0Zyc2RDWjBZeWFSTkRuRDZT?=
 =?utf-8?B?c2N6ZGMrWjd0VGFPTVRRdGVNN0NGdXY2Nk1ETm00Ujh3d2F5NjcwS3BORE9i?=
 =?utf-8?B?TVQ1V1RwemdpNjBrOTJnSkNHcnkzaVhBZDNRYzRHNkRhVDNKSWxJTHErTnNx?=
 =?utf-8?B?bit2VGpNbVBrOUUxV0FLREZLRmNNSCszRzBUT1FGWkQ4SnUwZEV5OGxpa2J2?=
 =?utf-8?B?b0NrL1VwMENreGgyWlBTaGFPRlQvNGhPQjBiSGptS3ZPMjR2R0dPZ3ZyS0NS?=
 =?utf-8?B?WkhpbzU1N2JSQUhReFpvd2ZwMmJQeE1MQmcrMEFXWEVRRlY3ZHVxS05NUUQr?=
 =?utf-8?B?ODgxa2t2eFVmSmZ3R3p4eC9ObXc0Y2FmMm1KRTgzRGp5b2Nqd2lwNmNrMUZ1?=
 =?utf-8?B?UU1YcjBtTjVXL1N0NmFzOE1hUDNPUEdaVUFNbCtMWDQrNllCMjJ3UVBETkpI?=
 =?utf-8?B?Ty9Ib2Y5c1lWUHdNY25ESm5yRkV6M3N6Q2pzRTU3Kzk0SzZrY2VEM20vT1pM?=
 =?utf-8?B?RllUeEVaRVlTL1hlSE9ZeWVOeWpLZ0RabGk0c2VtMFZoRmNVeTExRnpHdGJ1?=
 =?utf-8?B?bVNKSHlmcTdad3ozZ1dJN1VqU0NTSmU1Z0xUQkFRMVZOWW44bmE2eE5Tbksy?=
 =?utf-8?B?QkNHQ3VzZWNLTlZDbC92Y0NMYjNXSWtSZWs1YWtMbnFTMFM5UGJGeTVFUTAw?=
 =?utf-8?B?dHh0K1RpYkQxZmxLSXZJSytXZWFUNHBnZFE2bm83M2Vzam5oN09zRmFMakxM?=
 =?utf-8?B?Y0oveUh6VWNaYkdhdU9LWERVMU5kMXBmaG1yYzByRnpxSmFyL2V6OWNrTlJT?=
 =?utf-8?Q?gJ0fncThEZgwQvb0YpaRXChni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb9808b-09af-480c-3f40-08de2068fe1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 14:54:04.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHsFoR1AZwHgs2gGYzcB0UstQeT353Ud7Is9DyEyqpsQpXuo3owuGp9n+IlQA61Fcg6B1EQR+J976l/MHLY8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054


On 10/7/25 15:48, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:30 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A PIO buffer is a region of device memory to which the driver can write a
>> packet for TX, with the device handling the transmit doorbell without
>> requiring a DMA for getting the packet data, which helps reducing latency
>> in certain exchanges. With CXL mem protocol this latency can be lowered
>> further.
>>
>> With a device supporting CXL and successfully initialised, use the cxl
>> region to map the memory range and use this mapping for PIO buffers.
>>
>> Add the disabling of those CXL-based PIO buffers if the callback for
>> potential cxl endpoint removal by the CXL code happens.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> A few minor things inline.  The ifdef complexity in here is moderately
> nasty though.  Might be worth seeing if any of that can be moved
> to stubs or IS_ENABLED() checks.
>

I'm afraid that would imply main refactoring in main efx/sfc code and I 
prefer to avoid so. The sfc maintainer has the last word though.


>> diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
>> index 45e191686625..057d30090894 100644
>> --- a/drivers/net/ethernet/sfc/efx.h
>> +++ b/drivers/net/ethernet/sfc/efx.h
>> @@ -236,5 +236,4 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
>>   
>>   int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
>>   		       bool flush);
>> -
> stray change that you should clean out.


Oh, yes. I'll remove it.


>>   #endif /* EFX_EFX_H */
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 79fe99d83f9f..a84ce45398c1 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -11,6 +11,7 @@
>>   #include <cxl/pci.h>
>>   #include "net_driver.h"
>>   #include "efx_cxl.h"
>> +#include "efx.h"
>>   
>>   #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>>   
>> @@ -20,6 +21,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	resource_size_t max_size;
>>   	struct efx_cxl *cxl;
>> +	struct range range;
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -119,19 +121,40 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
>>   	if (IS_ERR(cxl->efx_region)) {
>>   		pci_err(pci_dev, "CXL accel create region failed");
>> -		cxl_put_root_decoder(cxl->cxlrd);
>> -		cxl_dpa_free(cxl->cxled);
>> -		return PTR_ERR(cxl->efx_region);
>> +		rc = PTR_ERR(cxl->efx_region);
>> +		goto err_dpa;
> It's a somewhat trivial thing but you could reduce churn by
> moving the err_dpa block introduction back to where this lot
> was first added.
>

The error path now has the minimum lines possible using the gotos when 
that saves at least one code line.

Thanks!



