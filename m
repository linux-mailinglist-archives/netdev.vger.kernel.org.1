Return-Path: <netdev+bounces-227484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5997BB0ABA
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07D21C2B9F
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 14:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A89303C86;
	Wed,  1 Oct 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZq9m0kS"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780BF303A22
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328141; cv=fail; b=CJKcGPsfniSGL2HKTKrNIdGXBQj2QgGbYJj7keIuN2ULyx3fL35uKic/EBTJLXYFoU/i+gWUVcugDY6L2NrOIJsNQIjVP/Des8+vePVBl/3+HxdQrMUuOwvasROBgrB0j1whWesYaVbfr9LDlwGSmG8xFn8v0n1q8YBroa9yqIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328141; c=relaxed/simple;
	bh=saVlpNw+swU1i/9dFqSwOuN01yXRLbkPA9gubkQaAM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+qx4H0mHb4Ih75cf2Tu+vSUqD+ohLQdR16di5SCB4JDBuUlfLIUlHs1Y3AIG1Ms4feCSInrb+qzA+uWGCsRjtJZ1MTXXJYvmMhemwey9hLoi3KISNfmswo1EnXJx6SAoB8wSAccoHF9T1mgrqHCkfK7K1jVmTwtMWFYo33VFiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZq9m0kS; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEavE1xux7XpWSldzKNcH/LjdxQDp9jTZl1Fc9g5jjl4UkuSsz8vbBA7TTQDEg/c1OloQFDueQRQAgV6KzN0M+fgpQ4UKPAracMLlnYzh4Ja3bEBSfmn+XCcILuYwCWabu3Jjj28juxLoXLAAZjaGMPe7NQMVpUsZY1m1f9/JM/pkfRtdwEpj14VlLJagMr1Vm0ShRh9BTuem0vcsHjm4m5IMmc4WpLXCy4Lz8O7MlHaVZMVK/5UyMffIwsLomcixxnSrIBNCG3g0dfgsrg4zhRJTrk3wa6NhxUaHvrVryzJQneUngmRdr/SlHU1wBN4Y/tsSTWkp3griQBKU3g4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vzvYAxhm0WOVtOsciE1Lhf7DJYESQpz+TJKlJVZt1U=;
 b=hWvkXXRC5BqfEWfl6l/eLgDaBNqWCDL56ZzH+NZyzUJgQgd8dtM1SFodnl+n7QBKmiSjtZxdr/TAkrKF/KoT92R6Oj+qKt2uKjtZtVSBz9XN4qEVEuQzg8A9aNydP48gQg/vPhXwlyTZ2ehnjzgSXRljHHRmeeoTuFDK6sp6w2zKjozVWxnc/44TWyxtxsssSxKvZaPpGBHsy7Y5G+qQAnhCCrTqVA1F4cpxQ35elxluzi1N3HJ/nh07L1meR0d+AxcVAlOECe/HPkdcMfqlemifGfJ6bWopJ/s8HU01dvF2wabeLNN0Kk3S08pviqPLkRTo5pUMEziT2s8/+p22Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vzvYAxhm0WOVtOsciE1Lhf7DJYESQpz+TJKlJVZt1U=;
 b=OZq9m0kSg3pPOsznqA60whxYduUNcE1NZmMKAIu+JbTWYRtjyo2mZed9JE8O7yRST1ZYoypW2wO5YVb5ZT3zKOA28ofF60mwCOBa/bBou34S71zXlxU0laB4SNcw5b9Jjg/lUQBrX4kYtjwFs/W1vTizQbd9fiPWqzpN173mUnoyClsqdGzr9Nhbu4wTSIxETvk3FlLhNGFec08MG/CCKKvo4ZrJzjpB+VeJP1+vdU5K0HXooeJVvOgqImhX8PmdCTbOviWW6dVhjPJu4pGPqgsAJmH+2KxaLFrEbYr3Vq6G1oVg0v+dYzqLbeZUAQ2EsySRN0JmHApMQHG5U0vobg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 14:15:33 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 14:15:33 +0000
Message-ID: <363e9a64-730b-4af1-97c0-014324aa45a2@nvidia.com>
Date: Wed, 1 Oct 2025 09:15:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/11] virtio_net: Implement IPv4 ethtool flow
 rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
 pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
 shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-9-danielj@nvidia.com>
 <20250925164807-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20250925164807-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::26) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d0d87a-8fbb-428c-8ab5-08de00f4fc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWx2VmpTNjNWRXV6TXRVODBRU3VJM01ESG1XZ0trQUVqWkxpek13MFVaT1pi?=
 =?utf-8?B?M1NVbjROUmw2YWVLcnQ0YUZ2Z1o1ZVYxTi9NVE9MQmN3S0hTa1p1aGZUalFB?=
 =?utf-8?B?U0Z5R21YVGhjQXYvWFdOZG5HdXNXZmEwUjhpZEZMVWh5YW5MUW9xWjR0MGlS?=
 =?utf-8?B?d0JDaHB4R1RnUGt1MmV2Q0o5Zy9JdStMMHgzOEw1S1c3L1VOUXFxWmdPZE43?=
 =?utf-8?B?Q3JEU1cyY1BBTVlPeXIyOStkK0U4WW1DbUM1ZnkwdFhTcFEyL20xdjlPRDJY?=
 =?utf-8?B?MS9sMnhhVkRPK0ZxWi83TEpaaFA2SDI1RURSMjJmVC82RlRZWDZDMEVpSzhx?=
 =?utf-8?B?dVV5N2tQSlFEZXB6b3BZdC9OcU1zdjh3Q1liK0NISlRSSzI0ekRZdDFNRVBB?=
 =?utf-8?B?OHVRWDAyMEpVQS9uU05FYi9iMkNOdk1kQmEwaGxmYWZxbTFkQWFHc2pJc3RZ?=
 =?utf-8?B?NFdXRy82M1VoTlZkeWd5Uk85SnRYaDlYcytRNklycHZwSkhucUNVdUUrbEFL?=
 =?utf-8?B?R2FVMkoyWndBbHRLeGNkbWZWQ0pSQUZvQXpMZTJ3RzRHaWo5d3g1ZzViYmpu?=
 =?utf-8?B?dXlobjBMZW5Vb01XdzN6OERGdDBEQk1pSEFEa1Q3dHJYdXNFc2tMb1NoSzFx?=
 =?utf-8?B?bmx4RkNuNzVISTNXV1RpUmE0bFIyV2t1dldkRkZrZjR1TWFZSTVVMnZqejF3?=
 =?utf-8?B?MGpsSm0vVm1JSy9IS3B1OFpRc3BEWjlPS3R3N1hQZ0J4Z3AyOGo3emVROXF1?=
 =?utf-8?B?eHJNOEs4UUpnSjVpQjJ1YWltZlU0SjYzbHIwZis2Q29qYWMxZ1BualpJNUh5?=
 =?utf-8?B?SithZStXUENMUTVyT2dqcDM0WWYwbFZWbWh5K0pjemxncndNb3N0eXU4V2pK?=
 =?utf-8?B?amxUZzlNeVpmRzY5V29ZMWM0YVhseHMyZVUyRmVyY3JjR0RQWlJDMitwQ2dz?=
 =?utf-8?B?ekVmbmtJTnBjUGUvRXd3bTBJRzNiZG9DRDB6TytaemJyb3Z1SUtGTGIzSU1Y?=
 =?utf-8?B?b3ZCM1VyTHlUNjNMU2c4MjU1UDFpU1cwUk9JTjNaeXZwVjN5ZlhqUXdiOXJZ?=
 =?utf-8?B?NGhSK1dJc2xWYzdjZkpLdGgwTFlmTHJmajhxY0x2UkZvWFIvOWh2RGFtTWRn?=
 =?utf-8?B?SHV4SFo0UUQ0bmlnSGkzc3ozZWZ1NmFLQTRVOFZHREdJQTRldGNsT2EycnR3?=
 =?utf-8?B?ZHJFdkFFZUZsRThKdHZmTVBHNzI5c1dJMWloSXgvamxpQVV3c3F3VHI2ZzdS?=
 =?utf-8?B?Umc4UDVSeGl2Qjc2TDBrR2lxc3lBQzNDYUJWRzF0RVV2MzFFRzBBZUJXdkdN?=
 =?utf-8?B?a2tlc1F0c3FHdktIZDdJb1M1MlNLZzRrOGFMcHl6bEg2dVd2M1JkVjB0QUwv?=
 =?utf-8?B?QXJVK1RyQ3lIa1QvREhCOTU4dXloUDFKakNveFpOSWYrQ2R2TFVYUDJJTVU2?=
 =?utf-8?B?MXBZbncwR0tRd1FjOGlqbFBpckVKSG02RzdaWnp3eXRjZy9iY094NWxpZWh0?=
 =?utf-8?B?dTN6TmdaYU5NcmpyTTY0c2tLZlJEbzhZdi9UNFVLT3VPbGFHbWZUWkMvYXZw?=
 =?utf-8?B?b0dFY0RJd2gzVDFDN0pQTi9ZdU5Pb2pkSFRSWkZWMTAyZHA1ZlRKUStUcWw1?=
 =?utf-8?B?UURJbE85VHJlWGk5Rk9rYm1tMGdPdUxDQi9yQXgyVUhHd01uRVJzdDVFNW5v?=
 =?utf-8?B?RDVQMjBwbXhJRUszZ05ZVTQ4VDcrVTRhWmFyeWExcStKK0IzN05NYXl6YWxq?=
 =?utf-8?B?TlZZdHNYWk82V1NpUU5zMGY4Tk5OTWFkYVpOMUhqQW9vYjZCV1pRRTlTbnNj?=
 =?utf-8?B?U21WZVQ5UTd5bjhBUTQxTEIxV3NzcjB4Y1NITzMyVE40S2F3THZaZDJIakZo?=
 =?utf-8?B?Tm1HMk1XWVpCbUNaSldIYWcwTGg0S2tFcHhpc29DZ3VIdi9GK3V0N2p0YmlT?=
 =?utf-8?Q?PkHs3G6S4meLD2WzcdByj+n9+NJhs0EP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFlFbEpQV2M5NUsxL1RIM1pJejRpQVh0MkpXZG45VzUrSGMyZEJ5M3B4UUpw?=
 =?utf-8?B?c1FRMUFuZ2xZWG5QWWYzcFVnQ3lrektuenk1ekgxbzNuckx1Ly9BU095K0VS?=
 =?utf-8?B?V1N0LzZ0Sm8vRW0wWUgwTDR1KzFEOVRVcitTU1FaMlJ5NUZmRUJBa2tndk5I?=
 =?utf-8?B?V0dBVk5tUFl0RHhFdURIS09pQjcxOG5rcUlBNzl5cUhFRFpBL1hlV1RvNHpU?=
 =?utf-8?B?bmtIZllPbnFXeEY1VnBJSXNDZmVBUlJYUE82MDdQZ1Jra1hRTFdXZnU4UjNm?=
 =?utf-8?B?V1BIemZPM3piOHZiN3JsbGxOWHVQZWVDemk2WW9pY2pzNkNud3pSZTgyY3F5?=
 =?utf-8?B?TCtrcmJaRmgrV3hhSkIxL05TZmRrNEVTODJ4Q2t3ODlHeVpkRkhPMHZ1TnNO?=
 =?utf-8?B?TnV6UDlIZGNqUTNFTlc4VVFPc0dzVlFyNHhkNU9GZHdNRTBud0RIeFZJemlG?=
 =?utf-8?B?ZVFGNUptLzEzNzRTeDBMSHlyemFiajY0LzZab1MrUmJZVkRWdzFjV0RIWlRw?=
 =?utf-8?B?MDNoV0JuM2h4ekJFRWdzS1hVdjF2czU5SHBJRnZuTkYrOUhYcUpMT21VUkhJ?=
 =?utf-8?B?U0F4dU9DbjVhVUgramQ5RFN6WDk5bWNSZVlSOWJ0Z08wM3luQlh4Z2JvMzNu?=
 =?utf-8?B?NWNBQllmdDVGWkxaK2M2b2ZsZUFmd2xrKzVPa2l4RWljc1N2c0lMTkZENURP?=
 =?utf-8?B?WjlTcWJIL1JyRWZBeEQ4WmU2dmpCWnkrUm00Y01aQnp2cEMwMGNHd1NBRTBV?=
 =?utf-8?B?SkNERXJFb2draEY1S295WmRRRmVMd2kyRzV0dlR2bjVuQWZPa01JU3VVUXZC?=
 =?utf-8?B?azRwR3R0aDRQR1JrV240MzRPV1huVHRVN3hOcUNzZlg0TlFtUStjcDR4b0hB?=
 =?utf-8?B?OWVHZnJ6YkdjTjFFeDI4SW9NWE9hbDNlQ0ZDSktqd3g0LzZXd3FnTlJsc0l2?=
 =?utf-8?B?S2hYZktCcWx2Z2VCWVV2WVRsdm1NV2VheW5KODZyQloya2ZBcVlYUjlieVhH?=
 =?utf-8?B?dXlyZG5qQTFpSk4rQ1R4M3pvYUMxQThYVmJrUVFtRXhOYmpjVitseFNENzdR?=
 =?utf-8?B?RWJjYjZMZTJOWWpKcGtucjRaM3lGMWQ1dEZSVHJ0eDVhOU1jMFg2SnQ2elE3?=
 =?utf-8?B?ZUp2STgvNysyWkx5bDRjL1EvVmlJWVE1bjhKVWp1cFVmZW9tTWc3d1hjOC82?=
 =?utf-8?B?M25MUCtOOXBMQmFwV1I2ZVlpVnM0RHJEV00xeUFEWmloWlBpN1BSaXNSejV3?=
 =?utf-8?B?UWVMOWtVOVBXZXlubGRwcG5kVm1ONTVUV2F2U2dNSFhsZHFSRkFpVEJyekxj?=
 =?utf-8?B?eEF4RUltYWo0VmNzMDdwaGhoVXZHL2g3bXZkcEZCazZocHQ1MkJlQzAzMGZE?=
 =?utf-8?B?R3RMNGQzdlNuWDlITWVjcXhPMTBXMmN2M2xXMGVwWVRIS04vL3lRVmM4ZzU5?=
 =?utf-8?B?WXBaVUt3V3lOejNvM0JKaC81NCtZY3JoYjdrSm0wM1V0K0RmNWdqZmYvajRC?=
 =?utf-8?B?cUtWQk9IUlpqT3J5M1A4NURuMHJBQktxbHYrNklTbjZJVXdocnlFZFYxdHhL?=
 =?utf-8?B?MHM2Vm9kOHI2MEtaNEZDY242Zy9HeUhLT0RWVWpXaDBHa2VmWGVFWVh2SCtQ?=
 =?utf-8?B?Tk9GbzUzY3RRTXAwTThvNnd3Q3IzV1E3eFZKRXdqYjBQUzlBQ2xOQnBnelFT?=
 =?utf-8?B?S29hZkJtSzVrTnhuUFNQWUpRQzZHa0g3Z3Q0K0FzYUJFYTAzRDFPV2dVR3Za?=
 =?utf-8?B?ZTRpRldPa3hxUERSWXJCc0dLK1RLQVZXQnRMMHNqZjRtalJzOUhpUmxXbGp6?=
 =?utf-8?B?dy8vSFYwTXI0bFgyM1RlaDZyUzBSVWk4YUk1OHRYTnlxallack1oOW1qVnpq?=
 =?utf-8?B?b2M2N2FHU2RZMk1RZFVNQWlsZzlwa2NKV2hGVUVnU09JSFpudEFzM0dvaFp4?=
 =?utf-8?B?WUNGKzNHMkdkdkV5VWxXRHYyS3VxbWRpR2FoQ2NESTZndlllT0JnTkFrdjNw?=
 =?utf-8?B?Q1M3OHF6QzVTQ1N5eWN3anEwOGJMWnluMlBKMEk1YjVxLzIvV1VWbWdsTzU0?=
 =?utf-8?B?dGkwV1ZkZkRkWEhOTUkyQmNiKzZvVWtad1FuQnBsWThndzRrQmU3blVDSGVj?=
 =?utf-8?Q?jZoaHEIT4dUb/Yb9i6FE4hH4+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d0d87a-8fbb-428c-8ab5-08de00f4fc00
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 14:15:33.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKY/Iqh4xchUgy8bJFdIMh4jQZ92Yk7eWgPyUJR5HjH1Rdt7ddw/f/7Vm+kWHbWCthtaQuG8ZNzQYI+xXH5YVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

On 9/25/25 3:53 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 23, 2025 at 09:19:17AM -0500, Daniel Jurgens wrote:
>> Add support for IP_USER type rules from ethtool.

>> +static bool validate_ip4_mask(const struct virtnet_ff *ff,
>> +			      const struct virtio_net_ff_selector *sel,
>> +			      const struct virtio_net_ff_selector *sel_cap)
> 
> I'd prefer that all functions have virtnet prefix,
> avoid polluting the global namespace.
> 
How do static functions pollute the global namespace?


>>  
>> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
>> +		      const struct ethtool_rx_flow_spec *fs)

>> +	key->daddr = l3_val->ip4dst;
>> +
>> +	if (mask->protocol) {
>> +		mask->protocol = l3_mask->proto;
> 
> Is this right? You just checked mask->protocol and are
> now overriding it?
> 

Right, should be l3_mask->protocol. Our controller was setting based on
types so this wasn't exposed as a bug.



