Return-Path: <netdev+bounces-240088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B6C705D6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F6DD3641E6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570452FD67F;
	Wed, 19 Nov 2025 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sp0MWZPz"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42C2F7AC6
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571569; cv=fail; b=gZ6Uf6Fi+kAoWC9sMgSHIlHEsuYPYEpN/9QGk65gvFjCnTJOY2QMfBMJTjG81MfdHabAliKkGFQjB8OCA6Gdja6RoOIhhsYLgfg738ig99mNNtdyWeAAJFnbjK7e9IpSUcEZQFfdwI4SXPqPFIEvR6nrtz87aaM6ZRByLDC+BSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571569; c=relaxed/simple;
	bh=67Txfu3wNND5UudteBQwvUk5WrQb0TKTiYE3Km/cj2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UjybOyAY1qCBXwZL59OdSxieiH6k4zRaiZnLJ699HwWMv7cJ6h8C81/KBkdSsARvsVx16pTdGKjmpyitHQHhjIvoK1os/P4AmBonTAAT7ZBHVzfkd+1+9E8hMI7Y7sTgu9NYBRnKH2anVQqHDxtqq7s4gLTdBnm8YE0yyE1Nn6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sp0MWZPz; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBPPuVEFciUaymSer68w2FQO9Tf2f0GQrAMNnPERmWVHBFacY/mqT1a4q4oXzTecJZMy6qkVcPYIj3q6AKlWJ3kHPVnwy9Tc1geF/xsu+MAPASy+Mb/2toRCmhBGKn21F0TgO1IOdZFHmA22HJ/pY17fPMY8VGz72F0yrJ3HReMzaWc0JAF9MZFsaGou+YSZg12ZI8ly9Q2W+yZ1tMTJj6DJda7ycLNqSSROt+J4xx6kag3LvUke1LKAby3SKgeFBu6DSI1N83W2InqkG018BrADsmiPzcwgWK1RyOGW7LBJt1nGYTiH5OkdtmCRo86VztyooCFSRvaFGR2naD1g3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/tNlAb+t5WUpoZuwAuNL59hJlED7k51r6WZ+cgQqFg=;
 b=QBTKjyASLm4rO7L9cLEcvoiN6ey4m1aZr7skaxgRdEnp5tqspRJ0uGyUWAsjKS6ZfT/mw3wEOx5FN5gbjWeymoBsCpsumQZdQyuFb/puHMoYhl4UqvBq+N2V50H/PDqoIDVckIl+gHSHVfQ62FhoF5YsBOfCsMWycaZNrSOR9yDv96Z1lobvbFH9HtIOhAhkO4b/B3VIK/cW4FOdHAr5PYPt2kI/vmVMMX36KsDQ2Lfg2Msu43UNM++tnVhGDpftTZo1sns+wK+mlMVcJXe2hLUMLxOiPJi9/4vp6FPhH5OVx4ivS0jCvUW7W92nXM+2AlQXvRa8A/vbOZ1YX1FfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/tNlAb+t5WUpoZuwAuNL59hJlED7k51r6WZ+cgQqFg=;
 b=sp0MWZPzXhHW4rMhFyYFGaVNc3qJde6WVVXQr5/Y+35HQpK+hkmjCpPbMc+FBIztd8Mk83ESxnKoFNftLs2Wpo6DND9Ogfg7ufIp9AlRwFQuwDomjdxVPCpgI5OqysF+BtPlhVZSw0XLyFE+wmjIYbZRywuMkoArfeUKVEc3dLsoSC+vHilbtTiSMjjBEPBxxKxIOdegIeCHS5Sd/RuO0o+XFV5rPXbFSmUfgddmvVAV+AO4VbxCloUUtwKm5zcxf7gEi/SXPFyJ17LNOn1YKjeTZ0Rn87KwB0SNHpVp6KGnXGGebYtsk+EsTuCKc/4QhWguYx/qNZCBFjdSlL75ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:59:25 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:59:25 +0000
Message-ID: <6b812cc4-8e36-49d6-9a90-8295c0bfd67c@nvidia.com>
Date: Wed, 19 Nov 2025 10:59:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <20251119041745-mutt-send-email-mst@kernel.org>
 <103955ba-baa7-4b0b-8b9b-f3824ad54b4d@nvidia.com>
 <20251119115113-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119115113-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::12) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c973c10-0921-43d5-d5ef-08de278cfe45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnEzbXhaWlF3TzE3SzBnc1ByNHVpMTdDUjNJb1dBLzUvOTRSYTNYSTA4akQx?=
 =?utf-8?B?OHJRSTRnamlhb0VuVDUxTXFOSnJkTWFhTWNMSTNRVEp4YXV4azF2eTNJekxU?=
 =?utf-8?B?QVdOU2UySVBNMXlzLzlXVzk0RGRNek9hQy9ZWkJqaVVaT2Vzc3FsTFNiUThF?=
 =?utf-8?B?NGtLRTYwTUZ0L0pNYUR3RXE5SS9Wc0NzYzVBV281eFI1RkpOWUNlZFpHK1RR?=
 =?utf-8?B?WVZZbEFLM29MOU1Xc2xMRXZ4V2RtbXIvVmZnR2RqZE43eGx4SUxzTXFtVUVS?=
 =?utf-8?B?cXhHemZSOURaMkRjSWJDSGJ6cEZPc2JXMTc3VUk1ckVGbFkrV0ttWUYrZXhZ?=
 =?utf-8?B?dGVlQlVjamhycWJTMDBUYWdMMUlzMzl0c1R2M3NmZFlxdXdCL0YrU1VxQjds?=
 =?utf-8?B?TDQ1RUIrcUlZb0s4c0ZjZXpDY3E5VHZLL3N2cXVJUTlwSlVjUy9VWkUyWlNj?=
 =?utf-8?B?cGhkRSt1bXBhUFl1R21vTnZyTFBBYlN4K0w0MFR6U2pySGhiVnp0L2phUElr?=
 =?utf-8?B?QnVqNE9hWXJhUGovRWJoVVJMY2dFeDBJeWppTFVDL2NVVzJWQWd1eEdzazMv?=
 =?utf-8?B?cjlabGZtRmNXbm43T2NPNlRXc3VaWk0yZ3I5S3hJSnlRcmhTdkM2dmtRVU1s?=
 =?utf-8?B?NjV6SHY1WS9zcnZTU3p4K21OZ1IvMEtzQ3lUZC9KTHNVZXZrL1RnOGtNZ1hl?=
 =?utf-8?B?eVdYMkxLdkdTU2d1SzFaTTIwc3lTemRUY2hKd1pxSy9DanZoVTVOa01XUE1R?=
 =?utf-8?B?MDhQU1NweE9OVWsrZG9PZkFzOHdydW9MR0c5aUVReXJFdWNsWUtVN3RjSWc4?=
 =?utf-8?B?bDFDRnZuNWFwQitqN0dBYSt0UGVSL0RHNytYdkVBOFFxamdPYVU1ZUpkcDFQ?=
 =?utf-8?B?REtBNGo0RDQ5TVVrNDZ5dEc1TGZRa2hyNGdoTVpFSVBLaEpXZndDbWc0K0tk?=
 =?utf-8?B?UVBDaWZIMkx6TkRoZGk0K1NySTN4WHVJZUFQRHdsUCtDZFhFdWo2blhLR0xW?=
 =?utf-8?B?eTlMZGFiOG82cW5XMjJPTy93TWI4K3Rua1JzbHQwejJBeS84VERXMnp0cUdh?=
 =?utf-8?B?bFdoTFdaYzJzNEk1YzRRU3NMbHQwK3RCV3J4OGQ0d3dCSzJmVG1TQmZnMG9t?=
 =?utf-8?B?MjByS1dVdGpOekk4WFhCelFydmlNVFBqWDhxTFZtRWlDNXY0aWI4cUNlUnV4?=
 =?utf-8?B?bFNsajBwZVBoclg1bnJ4UG1tUDVjdnJVK29oWkFLQVNTZVJJNXd6eGU2cmdo?=
 =?utf-8?B?THNvd1ZaUzlLdkNjWk9ueHRVTy9VTkpSMW81VWVmdDMzV1dob3FteTh6MTJq?=
 =?utf-8?B?SGs4Zml0UEJOdXVMSm1INTQzaDJjZG9VSklrS0dpbnlWenc2UENTMVNpaG5j?=
 =?utf-8?B?dG1ocVhlSUZJcTF0ZVpxMjFVOStKOTVWdTlMc3k1a05HdFllL1o0VzU1NW90?=
 =?utf-8?B?UjdmSHNkSHFGSndVNjUxYkE3Q3FhSUhuSzN2S2Fya2RZWlptbC9CVTExOTBr?=
 =?utf-8?B?T215NDJ6TURrRjVwT1BMZGdtNzkweDdSNzVXU2V1VkpSdGc4d1JkUE85STFC?=
 =?utf-8?B?am1rK1ZoMWtNTDBIcWVNNWkyZXUvdEZ3ejdtcmFuQjBHcE5jQnVJODhsUG03?=
 =?utf-8?B?ZU5TN3hxL1F0bDRRRkVKNkNoV2hFY3p5VGtZV042SnZTb2M3cVhYR0ZSZGFC?=
 =?utf-8?B?MFhkNFFFZVprQlZBM1hvQnpUY3pBM2dJUENKOUJKTkk0VTFyZXRPMHFzTjF3?=
 =?utf-8?B?akozc29VTkJkNkJNdm5MT0JMVWFGYWw5UE5EZzN2N0RzNGFDTHIzTXRYa1I0?=
 =?utf-8?B?N0xSVEY4aTZQa3JRdnF2czFmcTQxUUxPMFhtR1BxbUI2ZFdlaGJzYzEvMXNH?=
 =?utf-8?B?eTFoNWdvei96ZG5oZHIxVklqMjFhUStZL0x6UzBKSDRsbitVbU1ZN3M0SnEz?=
 =?utf-8?Q?kv8cLcfIKZOMbFM4Fize2Feihv/PshF/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmJ5eGdYK3ZoRm5wcUEvYnAxbFM0UTNMVzZ2MzJEWTNLVlY4YkE2WXMwWHdk?=
 =?utf-8?B?Vkl6NU5KMXBYQ3o4aXJCUlcrQU9CbmZuY09tbXpheERtYmFUaGJiVFpjMXZm?=
 =?utf-8?B?QUIweGtUN29aWjc2OUFhbGJMNkJDbC84LzR0UmEzTDZIWkpxRUhLQ3VLWHFW?=
 =?utf-8?B?RE8wdjU2QWF5ZVByNlQ4MSt6bDROLzA3V2F0c0UwL1JjdWhCbVorMmxHZWIy?=
 =?utf-8?B?SXJCNlNvK1N6NjlobWhqMjRvR2VhclN6MVB1Sm5xdFRjVFAvSFFGTEVqUXp4?=
 =?utf-8?B?U1lWQ04zdlBCZ2k0WXI5UGdERDJUUUpXMGxlVlg2QXFPOGxBeGZPa2xWMlh2?=
 =?utf-8?B?c1hBdVZYRHZBSk1kd3dITlNScFFkK2ovZzdLOXYzL0dXR0dvMHJ3aVBsUk9O?=
 =?utf-8?B?OUFCWlpuUGZ0T3pKcllpd1J0ZEh3OTRJV2RPTUpMRnRrSWV6bDIwODYrbXk3?=
 =?utf-8?B?NVR2NkovYWI4OU0zTWQzczdNUEdiVmNjZ2JZeUR1MHd6a3daZ2FYRU80TzA3?=
 =?utf-8?B?dDliaDBSVG5ZTlYrUGZyeHJGYnlaNTRwR1RRa3VBUlBqSEtzcnJ3K2FHU3ZQ?=
 =?utf-8?B?ZDBSb29zRFFUeGxKZXRXaDVTWGlkdWtidWE4aTUzaG9nYjlVVjgzWjFJcUhQ?=
 =?utf-8?B?YmdLREdRK0xzODlzZ21rMXdaU2lKeU1NdWh2RmVudEdjSU8vTHYwRlpVMk8x?=
 =?utf-8?B?UEpTNnE0RjZ6ak5INVRmcWFZeFV3NTQvR2tvV25iSUpKOFA0SXdLUmhUL3M0?=
 =?utf-8?B?eFhZTzNFWGoxR0wwMG1qMkVSODVZY2pMb21ETWpJYVZya2tQYkhLUDBoMVA1?=
 =?utf-8?B?UGl4b0xJT2hNZ1dEM05YU1VyM0hpQnJDbHB0aFBXd3QxcWpZdlVXaE9neHNn?=
 =?utf-8?B?eENJNGFJeU9kNzF0aWZoc3U1V2pXci96L2Q2eFVvdjlidHNYZ25HNTZ5UG1m?=
 =?utf-8?B?UE53YjVRVDJtRHFRaFFrUXVaWGZiT2lPM1U4MlNIUDZldGJTTGVSK3lLQ0My?=
 =?utf-8?B?WER2UW9FWTNGblQvdnFNQkQ1Wm9yU0NhTWQxNitmNk4xYlVpRGdlekhEVkd0?=
 =?utf-8?B?WmgrRUlHR3J2Z21GVjJWRDhPYVhOYTREaExCaEpiWU15bHNza1JBWUZtSnRP?=
 =?utf-8?B?bjAzUzZnWlZQYldpc2Q5YS95bmlONGVnQTQvKzBzMHVPQkpJVFRLOUcrS3Z5?=
 =?utf-8?B?a2psYytCcnVFKzFBTEx5Q3BJbGdWRW9qR3FLd2pEOFBRRmdjbjRhWVp2MEhu?=
 =?utf-8?B?bTNnNGVUN2x4NEtDZ1V4cEtiaEJSMWtaTWhNbWFONXNTTDBvQ1NHdTNycFBw?=
 =?utf-8?B?N1ZMZHcxbEJQcmE0NWZ0SHJkN0FLNWQ2N0V5ekV3RjJUblhwUTF4OFVEdGdW?=
 =?utf-8?B?b2Z0SjRPaUR5MWF1TkRmTTlWL2JLOWxYL2hPUm9iNVgrNjF1ZENLdmxSV0JI?=
 =?utf-8?B?VzlnZXdpR2d4dGpDSXRMWnh6UWJkSzBWSlRNSExsM2lHVTdUbXZJRFFFbE1l?=
 =?utf-8?B?RHh2K1hsVU1VRVAvZ1R5UzhNM3l2MitPa2FMektHNC9NdGFZSEVOOWJBd1N0?=
 =?utf-8?B?cG9DQ3BESysrTTlENHFnWktvQ3dZS0VPeWZGR1ZYbDlkU25iTTE1emd0NXdh?=
 =?utf-8?B?TXovN3JQWjMyWkwxWHQ4UDhYRFZIRmZtK1ppYk81RUhlb1VjWk9uQVZwNU1J?=
 =?utf-8?B?Z21XSUZqMjEyRWJsSmpDVDdmVHlsNnRvNnVudGROK0I3ZWJFblgxWE44VC9G?=
 =?utf-8?B?M1YvNWFBZEQyY01SRXJ5RFh4NnEvbExwc2Q3ZExadDZCd2lZT1diUDFUWmpV?=
 =?utf-8?B?Rm1HV0VuWGFJV0tZTWoyZDEyemZxblFFOU9MQmZkcjlta3dDRmZNQnlpTk12?=
 =?utf-8?B?SG5ybEYyL0ZUbkdtQmNEU1RiY1hxZERDS2FWdnV4bDIwZXcxNm8wa2M0dW5m?=
 =?utf-8?B?N012SUljWERQUlVQZVk1WEpvY3NhNmk3VUJCbVJoTmc5ODNMeW1KY1NpaCtN?=
 =?utf-8?B?TjRyZWNjU25Jd0NIdWdlYWN1WG9uZ2VYZ0hJTEI3cHFiT3ovTTFwVmtXSlls?=
 =?utf-8?B?cTFFVDBoZTlEV1o4WjhDL0tXMFowSDE5UUtHYVlKcHJmMUluZ0JxYXZDU3V1?=
 =?utf-8?Q?ZTpS/Om4IuS7j5pw4T/2IK+Fe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c973c10-0921-43d5-d5ef-08de278cfe45
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:59:25.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r79BiUP0Yjsq1ANihXsYZRW7sMtSXp5fjZD/H/yFo+dly7VPABtszLqVz0YJB0xKUW44qev/9UuqE5y2HJTz1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

On 11/19/25 10:51 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 19, 2025 at 10:33:31AM -0600, Dan Jurgens wrote:
>> On 11/19/25 3:18 AM, Michael S. Tsirkin wrote:
>>> On Tue, Nov 18, 2025 at 04:31:09PM -0500, Michael S. Tsirkin wrote:
>>>>> +static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>>>>> +			     u8 *key,
>>>>> +			     const struct ethtool_rx_flow_spec *fs)
>>>>> +{
>>>>> +	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
>>>>> +	struct iphdr *v4_k = (struct iphdr *)key;
>>>>> +
>>>>> +	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
>>>>> +	selector->length = sizeof(struct iphdr);
>>>>> +
>>>>> +	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
>>>>> +	    fs->h_u.usr_ip4_spec.tos ||
>>>>> +	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
>>>>> +		return -EOPNOTSUPP;
>>>>
>>>> So include/uapi/linux/ethtool.h says:
>>>>
>>>>  * struct ethtool_usrip4_spec - general flow specification for IPv4
>>>>  * @ip4src: Source host
>>>>  * @ip4dst: Destination host
>>>>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>>>>  * @tos: Type-of-service
>>>>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
>>>>  * @proto: Transport protocol number; mask must be 0
>>>>
>>>> I guess this ETH_RX_NFC_IP4 check validates that userspace follows this
>>>> documentation? But then shouldn't you check the mask
>>>> as well? and mask for proto?
>>>>
>>>>
>>>>
>>>
>>> in fact, what if e.g. tos is 0 but mask is non-zero? should not
>>> this be rejected, too?
>>>
>>
>> Actually the tos check should be removed, there's no guidance it should
>> be 0, like the other fields. Our hardware doesn't support it, but this
>> will be caught in validate_classifier_selectors.
> 
> same question for l4_4_bytes then.
> 
I guess it's reasonable to assert that. An ip only rule would fail to
match if the mask were set.

