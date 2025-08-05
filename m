Return-Path: <netdev+bounces-211682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C4B1B233
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93FC16BE91
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F011B1401B;
	Tue,  5 Aug 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XuKqQO8C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCB1CF96;
	Tue,  5 Aug 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390742; cv=fail; b=Ux6fzG/8gD4ZFlFifynem4egwTmuNVUfp2eo/x8YPEzFdBjX51VetmOTXr5V6RcQ2+Y3/nbsONLaq91IJcph7perepGjej8N5tSjsZkS21CK27a+pQNgMUj1IVU6UL1Lb0pqZ/pTN3GMnFl2XxZHM/FeNE+PqZtIRSWlIlBvZHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390742; c=relaxed/simple;
	bh=bXfE7konHaULdfEmQq0SjAeW0lUpzP828KtAx1I1tTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ip7APjgREI1FEyiSDQZit1xV7h5+tlPFE7DHNw6CpDR0OETfa26W5eM7uh2iBtGmd1hEG9OreONNKiLgcfaYXAV4FycS7lvUeROvf7X4j3mF1wjGwjVqk/nHYsac0EM9RE6kyis0/4pQTpdtWU5X7sLKzxqqs9tXBvDulO76nnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XuKqQO8C; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWXIZn5B8LKwRY+qreb3PoOyrVpB23whHlGQfZIgxi6pqEjQu6DQx899SZU+Cg7XDxlkGjTu4K3irxcAqeGXrMJInIuSSoOmc2m6n0ih2oRzLsqgJZMw1d5Fnwn5S6Yi2vGOXYVMUyYjb+GGmC7N6IJ313c1omGzvFP8p/CIk+h8+QFpa4XGrRnuX3Bp9TXFb7hDH4pMWP1xI+kg+IderN5xPmCF3uMwHheyy6BimQ2fPNzUsnQCd7RhmCbhMNsujUdk7yS4Yd5O4OvmTxW9WFgw0Vl7pGvNG3z49rPeA2I2iDKxXUKhEWxZ9x4RoG/BAjvxowgUKCPXpzKaOy5DwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uk+SGgEBXyykC33qtcmKChGsNfA1gcyu9Pm+XdwmDU=;
 b=V2MxxWw3CWOz7j/UHQ7sFxXcac9jt9MdBeXFUk7jD5/z17aWUCaZ56GyY8DtGpj7V8guDrYbOrgA+CejV6gQdsv9faP8ybiIIJ1abaHpRnxjy2fYxcKRD26fHb1VRE5FndaaWXp468UVxGo/duk8hlsVq4plrGBp6l8Dqda1HkTcKiEjNAY/nj9eWrI4ISh+zb7zcfzbBIwCZR2o9RZ6M04h/KtojLV7oWCRNLWgEozub80+Z96+Rg8Ayl3Jopy3y8WDHQWcKwpIUYn/w6qcMk1/WzTU3ovALVD7//qp2mVDquf8gKyBwCZkwFhMQNe3hMV46jP4kS7zbpegN5T/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uk+SGgEBXyykC33qtcmKChGsNfA1gcyu9Pm+XdwmDU=;
 b=XuKqQO8CSlSTIwTKaxuRILsIj3KqugL7hT85G3BpEg4FCUN/Db87D4ztseDTk2y2J3f1+t7dmMjuFNQNQg0/CWtpQlNmbGoqdq0GW9Los9sdN8KCiNTvSwnRrBCrGErRD0qczl8k4PL7irc7/cy+cJU1sdKJffX/wMaxcmJfksk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Tue, 5 Aug
 2025 10:45:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8989.017; Tue, 5 Aug 2025
 10:45:37 +0000
Message-ID: <3a0f28e9-c329-4bbb-a0c4-19fde9755dbf@amd.com>
Date: Tue, 5 Aug 2025 11:45:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 01/22] cxl: Add type2 device basic support
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-2-alejandro.lucero-palau@amd.com>
 <6883fb4a46aff_134cc7100be@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6883fb4a46aff_134cc7100be@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0304.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 8059dc10-e5e0-4747-0534-08ddd40d3652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzBTKzhkQVQ2OStuT3daUVJKbVdZQTJGZ3hkN21lNUp6NmdJWUt4aGFxcllk?=
 =?utf-8?B?SDEvUDI4aDI2STFEMTFKQTZkdWt6WGZjYm90Tlkvb1l2ZkVoWmQyWlFhOG8r?=
 =?utf-8?B?M1NyUG1lelNIaGZWaTIrSHJ0ZElpNU50aWErU1VBSlY3Vy9LaVdvZmwwNVlE?=
 =?utf-8?B?TndqdVN6bEQ1ZE95ajV2aVBlb1pXZFZVM3Y1eTNYb0JDT3FUZ3dCLzNrcGQx?=
 =?utf-8?B?SU1RYXlCQ1F1eWpQdFVMM1JKTjNNSG5Oc256R0RNWHR1YkVQMDFPdXdQbDlV?=
 =?utf-8?B?R1R4Qk1hZ3NUNkFzRWIrWm5DSVNHWDAyNUNYT09taDAzOUJzZ3BSV1ZDWUZx?=
 =?utf-8?B?ZXVIaG03MS9lU001S1FBUmhmWDV3cGl4VFVnR1k1TWtzV0pUUVU5SzdFNE4w?=
 =?utf-8?B?a3F2Mmh0cGhKendLczJsN0RiV3liVlhGdlNVaU94Z2ZhZEljUkxFYWNvdHBR?=
 =?utf-8?B?UnAxNGUxL1JSdFd0VkJIUE1EYWlOeHVYRi9iR0RYWXJEWHcwYml0SjFkQldW?=
 =?utf-8?B?aytUTFQzaWhXYVp2SDdvNUQ2RmtibjN0T3JIOGFoNFM5cnV0Smt3d2NIdkIy?=
 =?utf-8?B?SXlkOGFSWFZ2dGtCdlJVZDFiSTFuQkkzUWxiMGMxQVZrUTBoakNCa0p0Wjgz?=
 =?utf-8?B?QThtalhxcEhoMmhMUUVnREl2eVRJZkZxaXlMdkZFU3BHOXdxQisrQ3k1UXAx?=
 =?utf-8?B?emhUTXBJOTFSek80SUM3SmVWQ0VYY1JMRGtsdTlOQUdReDJpcXZNRFNhcHBr?=
 =?utf-8?B?ZmFJaFZyNXRQNkNITXFkWkpSeldydG9xZ09scWVjOEExQko1Vm9pY3hWaW1h?=
 =?utf-8?B?ME9UUGE4emsvOXp6YVhib2IxVTljbExGZld0eG03UndtZ00zVlQ2dVVZSXBY?=
 =?utf-8?B?ZEpxNFZOQmxoT09SU2x0U0V6QWhFaDR1aG9PWkZBMm1ZNkxxWjRzcW9Zc2hE?=
 =?utf-8?B?MGVzY2J4blpnam9ZSXpIOFNOZVFOUjAweHg3QXZMbHp5UXB6Zm5QbCtOanJv?=
 =?utf-8?B?eDF0UGNycnlWbW1MMk9USlVvRWRXM3hjWjJtU282d2ZqT2dnNmVTVmVweWhD?=
 =?utf-8?B?MGNKTUc2MzI4OWFyV3drUUhkS1BBSFhrcVZ2S2FxTkY4bUhKZTVjMzF3Vi9U?=
 =?utf-8?B?RkxmcGVKT0wybHFOV0U3YVFtWWZPL0lONVF4RjNPeFgrbCtmVmxON0FaYjRj?=
 =?utf-8?B?WFQ1WFB4citITHhmM0tDZmZwc2l6REdldUZ4RW1BYXl5cXQ0SnQ4Q2RtTVFn?=
 =?utf-8?B?RWt6NVh2R3h3WlJJVmErOVEzdVFHTFBWaVlxYWZBbVdQeERrQ1o0STVRamtB?=
 =?utf-8?B?ZE9oSkYzaHUwWmswdmpZUDMyL05qQmQ2QWVUUjhpazd5LzBFSzFaSFd6ZUwz?=
 =?utf-8?B?YlhBdEdFTzRoc1JVVXdlUVIxbEJwOHVUYjg5Tk1JZmxQemxMejZGeVVIZ1l5?=
 =?utf-8?B?c245VitrRVdraVFSOFdVdWFjaUtRQjNSOEExWEY5Q1RiZFE5YUpiNXBYd1Ba?=
 =?utf-8?B?SnBYNlk2UlB6aW11YXJjbC9SNXAxeHRWM3pQVUorRmJLeExqTnBXZ0FqMFU4?=
 =?utf-8?B?L29HWHZMWnpSdk9VVWlkdlJsZC9WbTlXNlBBUXErTDA5RzltUkw0bndTTFBY?=
 =?utf-8?B?R3BPVC9OMkNUU2R0OUZoOUh2VTNXcVVvelVsd3NuM0hFdCt6d1QydzBkd0px?=
 =?utf-8?B?emd1RTluUzJyZzRQK0FqQ0VLeGxUc1dJcWszSkNWS0xjQjhRUktwNjB1T1Fi?=
 =?utf-8?B?WEFDOFBBS0NGcEVnQ1FVWDlWZmdNWTJvT2szZjJVZjA2ZG50TGRBUm13aEZB?=
 =?utf-8?B?cUVnSmJDU3pwTjNZbDBFMWlDd1RvSFFjSlhpcEFtUWlPNEFTNGtvTnpDam53?=
 =?utf-8?B?RnM0ckVzd1NhQkZVYW9NSzNWN0NsTDRvMVI0QW0rY2NyV2hhLzc4cmNMRGFJ?=
 =?utf-8?B?KzFnQzdMMVVwTmlpUWZKU25QZ01jbTl5Y1ZzZUZrYzJhUWQ3dXZ6TWl6UU9B?=
 =?utf-8?B?RW1KaHA4ZExBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUJMd3Y0bUZtK3ltY3JMVmRtNUdPM3NaRUlZb0Y4NFliWm1HUmhkYXNjOTVX?=
 =?utf-8?B?QnJTQTVsZzdNU21YanVFZ3RCU2tDODcrQVJaMlV4MGRNN1A4ZGV3TUZMbTg4?=
 =?utf-8?B?N1ZLeDd1S3RDa1hHempTUE9hYWVjVUR6Y3RzODlxK3grWi9QeC9Mbm5nTi9z?=
 =?utf-8?B?aU0vZGVxUFg5TitJVFVkVThvY01JVEQvL3VUQUdNaXh2aUUvQUVMRWdyRWZ0?=
 =?utf-8?B?K1dFN3Z0c2c3WlUzSzc2d3h4bE43ZVJwSTdUcEZaS3ZGenNZbFo3aEFQUm9i?=
 =?utf-8?B?dEFKZExVVmxEYzcvSW80V1RSWklQQTdjZGdsMUNrQ1ZqOHVlc1VyR3dIdVlD?=
 =?utf-8?B?ckw3VFF4VXU3c29ERjVuWUdxbzlIb04rbnFSWGhrTWVwUlVUdDBXK3dYcmFU?=
 =?utf-8?B?YnZPYWZ0VFBWZkRwdmhrNjBvMS9CY2tTeDJ1UTM0cTdzczBETmpUMEdYM0Rt?=
 =?utf-8?B?NVdTWUtzbDhvT1RNRDlvNEpUYTJzWGxOM1B1MGJGZEZRNGtHUHlGTUV5dTFU?=
 =?utf-8?B?VDFxN3JnUGlONHFseDFmaGx1blZTeU5yVUh1WHpTL2NiTGNzU0RYckVBQmEx?=
 =?utf-8?B?NWUxTi9ERXVVbGV3ZS9aQWFoMHpOUkFBVVhJMDE5ZDFHOW9tOVg2QWgzeFpn?=
 =?utf-8?B?QlRqOVhLNERnUDFsY2J2M3ZoZ3lFUE52NTFRUWtqQVk2ZWluYStVVmdQeG9u?=
 =?utf-8?B?Q01FQWNOQklOSWFEQmprcWJOdk1nVGQ1cFRITUJYckFVQ2dHSW85TUtxKzVG?=
 =?utf-8?B?NFZ2VS9ET2tJTjg5b1dURThsVS9uN3JueXc0SExMMFI4SDFXOWc5UzdyZWNw?=
 =?utf-8?B?MzB0WGVxUkRRV3ZiRHhJbmRER2xTV0Q5UmZIZXFzMm4zbGJWRkJmaGIxQzhI?=
 =?utf-8?B?REF2QWR4UVc3Vmo4WWFITi9ZeG9yRzNVMHVyOFh0U2JaNHhBWTR0MjZMOG4z?=
 =?utf-8?B?UFFyYVpsSkExZWdGV2tGNmdGSXd0dEVHaXhacS93VTdlWTAyalpjQVcyTG9q?=
 =?utf-8?B?QUpMajRPZERYM3YvN29JL1Axc00zQzA1elRad3JIZ1RCQmphWVRQZGJUZFJk?=
 =?utf-8?B?cktGNy9wL0dLWnUzaGFIMTNKVkI0bGcvK2JqNnVQTUNUdGMyZTB3MHB6T3lv?=
 =?utf-8?B?MlFrMXQ1U3BJeGFzRFF1UFA0dmtqVVlOVzZHVFRsdHc0R0J2L0RWNElxR0t4?=
 =?utf-8?B?UjhVS1NCSXg2T1JwaXFFRldncTNYN0VIdHNQL0VYUG9SWlFEb3FpMi9xRUR3?=
 =?utf-8?B?aERIUnM1dDVGNjlTTm9oZFd2U24yN1U0T2kxVmdlRFRncFE4WTNRK0RwRytt?=
 =?utf-8?B?aFZIVnE4dHNvY1AxWVJHamxpNzB3MXQwQ3Rib3FYZk5RdTNnYzJKbmxpQ0ZL?=
 =?utf-8?B?ai94WnA5UEkxcFlwTWZJemw2czUreHp2aWl6MFM1eDFzUitNNjlmRG1YdWRD?=
 =?utf-8?B?VnZDR1o1WlpUNVlLTCsxMWt1NjA2RVkyNVpybEJ4UXNwQmxvaGc3U1lodkZi?=
 =?utf-8?B?TW8yU2ROd0Jma1BMUnloM1lUVXY3QlYzamtnWmJVV3dTWkxrWFYzUkk1dkhk?=
 =?utf-8?B?Vm5TVXRWYm1CN3lUMVBkakJvOE1yaE1rYjBzTFhESFZYKzgvM2Q0UG5wb1Bn?=
 =?utf-8?B?cmFQaWdienAvL241dmxiTmw4eFVwb3FCcWwzN1lkczJCYi9MNlVEMlo3cWMx?=
 =?utf-8?B?NEcwa2FEeVpGY2xOY0lrYW82WGNHWTJvam53U0hqU1hOSzVuaExMV0htL2FC?=
 =?utf-8?B?SDJPZDhqend4aGM5aGFsNHg0TzQ1enltUjNaUVhkR01LOUZybDIwbjZjb3lS?=
 =?utf-8?B?VVRPTG5aaVg4azVQbGoxZXY5WGdOaXZDbWxhMXBNdG5IS2hZRDY2d1dCaUEr?=
 =?utf-8?B?QVBvZVRMd2p3blBzT1FBUUZNUnVVTVUvQmtOZmE5MXpScTVuUExxYTNtbEs4?=
 =?utf-8?B?S3dYamdsd0hucFRGMXJMRXlFSFhTY2phQ3ROS3lvR0RjM01xOHdHSWcwMGVL?=
 =?utf-8?B?OHVvMWFXRXNKazNqNXZCR2tOc250NzAwZXNaM3VaN1ZGOVB4UGpNcUtLMVIy?=
 =?utf-8?B?djljeWVaRjZZcERXd1BOd2ZQdStzcmwva1BoRWlyRXpvZUhLc0c1UE5FWEFC?=
 =?utf-8?Q?ZGD7/K4m8+QdZFi0MBylYxg7H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8059dc10-e5e0-4747-0534-08ddd40d3652
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:45:36.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnYjL6friVTMBKgBfFAQFiVpJjOYK6rw4lPsNUqPBhtpevtF4lzJt3ntLWs0ildpdXAXFa19AC5765gUkjYtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427


On 7/25/25 22:46, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Differentiate CXL memory expanders (type 3) from CXL device accelerators
>> (type 2) with a new function for initializing cxl_dev_state and a macro
>> for helping accel drivers to embed cxl_dev_state inside a private
>> struct.
>>
>> Move structs to include/cxl as the size of the accel driver private
>> struct embedding cxl_dev_state needs to know the size of this struct.
>>
>> Use same new initialization with the type3 pci driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> ---
>>   drivers/cxl/core/mbox.c      |  12 +-
>>   drivers/cxl/core/memdev.c    |  32 +++++
>>   drivers/cxl/core/pci.c       |   1 +
>>   drivers/cxl/core/regs.c      |   1 +
>>   drivers/cxl/cxl.h            |  97 +--------------
>>   drivers/cxl/cxlmem.h         |  85 +------------
>>   drivers/cxl/cxlpci.h         |  21 ----
>>   drivers/cxl/pci.c            |  17 +--
>>   include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>>   include/cxl/pci.h            |  23 ++++
>>   tools/testing/cxl/test/mem.c |   3 +-
>>   11 files changed, 303 insertions(+), 215 deletions(-)
>>   create mode 100644 include/cxl/cxl.h
>>   create mode 100644 include/cxl/pci.h
> Thanks for the updates.
>
> Now, I notice this drops some objects out of the existing documentation
> given some kdoc moves out of drivers/cxl/. The patch below fixes that
> up, but then uncovers some other Documentation build problems:
>
> $ make -j14 htmldocs SPHINXDIRS="driver-api/cxl/"
> make[3]: Nothing to be done for 'html'.
> Using alabaster theme
> source directory: driver-api/cxl
> ./include/cxl/cxl.h:24: warning: Enum value 'CXL_DEVTYPE_DEVMEM' not described in enum 'cxl_devtype'
> ./include/cxl/cxl.h:24: warning: Enum value 'CXL_DEVTYPE_CLASSMEM' not described in enum 'cxl_devtype'
> ./include/cxl/cxl.h:225: warning: expecting prototype for cxl_dev_state_create(). Prototype was for devm_cxl_dev_state_create() instead


OK.  I can fix those problems easily (bad punctuation). I can not see 
the one about the prototype, but maybe it is due to the base commit. 
BTW, which one should I use for next version and rebasing on Terry's 
patches?


Thanks


> Note, this file was renamed in v6.16 to theory-of-operation.rst,
> git-apply can usually figure that out.
>
> cxlpci.h is not currently referenced in the documentation build since it
> has not kdoc, so no need for a new include/cxl/pci.h entry, but
> something to look out for if a later patch adds some kdoc.
>
> -- 8< --
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index d732c42526df..ddaee57b80d0 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -344,6 +344,9 @@ CXL Core
>   .. kernel-doc:: drivers/cxl/cxl.h
>      :doc: cxl objects
>   
> +.. kernel-doc:: include/cxl/cxl.h
> +   :internal:
> +
>   .. kernel-doc:: drivers/cxl/cxl.h
>      :internal:

