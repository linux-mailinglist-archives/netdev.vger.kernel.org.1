Return-Path: <netdev+bounces-182143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369FDA88037
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339F116A5F4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948EC1E522;
	Mon, 14 Apr 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ym/R0Z0T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920280B;
	Mon, 14 Apr 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632988; cv=fail; b=uEyf51MAgDG0v3OyjVRDGROcBfZkkLK8vXpiVF3rEsyDt0kcZEyE5AcU6j3ijwiUQM1ZXXa+evV9E/RoEWCIAgucoc17bMySKwNx9O1FUKJ7M+EUeL2wNHDHnkO0YtX9slLBZNag8XdRsxJ70si5Vmy5FrCwOWQ5dHBZJk5ck8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632988; c=relaxed/simple;
	bh=/FPt+bO7mkyaDrFWqEBNSSKvByVKU4jBa0cjhrvH3iQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IxO9kbpAZVutI+q50wTT1mA2q7w6lJYl6qxIxYOj8tvfbKENfwUKxR//FiBHPCvD1gJErMuzo6Qp1ebwfeMBZjkL5Br1axxgrvU2mdLoJkJGMiDt1z0qdJNBWNdm+09FXY9GnbillY+W+ZzHT7SlYhnk0hgcjx+nOekQTvJaHhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ym/R0Z0T; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZNHydYL8KK+LL0cZaNd+PsbCdNRlbJdhYti8iyMLtfjj9FpymgzPBVi/OO9THYJgEDTRxyUrHIOJTP4H94aguFtXW5JBUKYNcCcFpnPX/4mWgngBVVR0zCQZZvpmJ+Q5fw7YmRvh1ec9ZpSHXOxcELFjXJVPPLYyRTG4vstOQwgN/rJkqXm2ILaBQas2s2nlAqsr4/mOffIxV7/aNC3uOp4EdrCPN1RR+TXlsRsISqSDET1OjbPftS3cl9WUThPXaLQSG0ThzilUJaIhKCjZy6mvSJA+eFsU0tvmdY3uP9W0Jq9Y0Ez7+21yEsd3L6cm5T2W9SVsLradD559rwaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQRBcXkKCFAh0oIgCLJuwXs2tXwOMYtGsUWeYK5YAgg=;
 b=mpF7ewTQsc+DLhIHTxo2hlLmiad5xe0FpPW0NCjHA1RnrD2Lni0Zpxv2gf3oqCroWjXqBEiKNzQ5zpZbipSeulgTi7q2s7NUoG8dOECpnTmltAWTxT1OlihBZT2kxuwBgotQslF+RlC5kpGxT1uAzsJBxQPRJDtybwj3Nm53q6qkFbLaKbYQOdbWID4nOIkTkXE4hJZ68hX3iu76jarsy9I+JQmVpM2BsxR3OeFM2okBfbKoKOfPIrqGSnscX+3I+kJ/RoHEQe6klBUF0q0gjb7647C6jZuubXKf+OydJq7BRQ7Kdtkxdav2buSUUsnWLclOWl5Zik9mLAiGQRsG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQRBcXkKCFAh0oIgCLJuwXs2tXwOMYtGsUWeYK5YAgg=;
 b=Ym/R0Z0Tst8pkACZsij2GVmbocFf/gxgFAJ1v6ckZttZco0CNk0sQnN/qLarrIbSV4uogQ8Mm3b94/XrM6Mq7xWA4oZ8Tmd76MCjk95OS6kl92/BouQOwupUNSPbXSiWCOX0PwRf+bEzRSVDOPKVOmJ/EPQiaf0+T9IScQ0vqCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 12:16:24 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 12:16:23 +0000
Message-ID: <17513b72-35cb-48d7-87ff-fa9cc639d61d@amd.com>
Date: Mon, 14 Apr 2025 17:46:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] amd-xgbe: add support for new XPCS routines
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
 <20250408182001.4072954-4-Raju.Rangoju@amd.com>
 <Z_jsW6Y4n_NwhlnP@soc-5CG4396X81.clients.intel.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <Z_jsW6Y4n_NwhlnP@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0062.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::11) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DM6PR12MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1e5878-49fa-45cf-c755-08dd7b4e2c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUc4SlU1N2h2VVg5bnczbTBKQUZ6NVZiS01JYy9UWDIvdkNUOVJ1aCtlZkVM?=
 =?utf-8?B?dGFvNWEwaXV0VDZxV2NOd0FnWHZ3NnB1cCt1c0NKa1I0YVdyeHQwRDN0UXdj?=
 =?utf-8?B?ZHNodEl3K05YQ1AycVNUUE4raGExdGdYY294TlY1S1p0SFNZeHFENUFYS3Vi?=
 =?utf-8?B?UGcyNGJMZ093ckRHdTQ2V1VGSDd4QTEwWkRGMUo2Q21YVy9pMlY5ZGVCdkgv?=
 =?utf-8?B?MmFJcHpRYXpRVEc5d3R0MEJsU1JvOEJDUDlwZTkxMitYb291QktBSFJVbjVS?=
 =?utf-8?B?dTlSa2FCNEFaUkp6djJRM3hYMVRTVXZ6ZGh3OWNqTm0zaUt3QUpTVE1QNmk5?=
 =?utf-8?B?RUkwOVBMRDM1SlVXRkRQWXdQa1dTdjRoeDdsVmZyUzhCWW84UUhMeWhmZWZ2?=
 =?utf-8?B?YXI3TzB4VTNWbkVHVkoyRTBaY2piaWFKbEZiZ2F4QkZuc0g3bEp2UTIvSDFE?=
 =?utf-8?B?TFRWdit1cXlKSSt5ZjJ4clB0SnhyUGFEdE1VVENCN0MvUnVDcENKS0p4Y2sv?=
 =?utf-8?B?cS80OGxDbmRhRFRXU1h6YXFUL3hKY21WQ1c2UWR6Y1pPSFcrOTJRNDdIaURR?=
 =?utf-8?B?NnZzZDFnVzdPTDdVbjd0NXhseGN1QlV6WFBjdUZoOXgza2Q4M3B2dENhdUVt?=
 =?utf-8?B?QStDUmgwS2dmT1k2WE00R2tZaGZnbW5Ua1daaEJuZkhFdVVHQnlPK0ZQNDJt?=
 =?utf-8?B?ZGd5NmhuWVRNUXYvNXMwcFV5Q1hhQUNPck5yWGQ5ZExBRmh0aWg3SjRnekNi?=
 =?utf-8?B?L2tIMGF2RkIwNElsQnBWZHVyVXJ4cjlwd1ZwT3ByWlJEa3A2c0pQNVRrQ014?=
 =?utf-8?B?NzM1SVVUYWd2SzZxSnpobUxSTVBUTjdYb2VTcjM3SmxyS01GMW1udVRCazR3?=
 =?utf-8?B?RDhkQjdvUlZlMllJVlVoMlBmelZFZGs5elZuOU1IRDMxSTFsRmx5aUt0RzFP?=
 =?utf-8?B?eHZyVFNOazRLWXExZ00vbitJK3RiSC8rYU1wQllRbGJ5L0wwNVVqVUM5RXE5?=
 =?utf-8?B?QzJTRy9TVVJ0aXZ2QXhlT0g0Q2UwMjBrVXNyUTViMnloV25YRk02cUdMRHJa?=
 =?utf-8?B?Q0ZMK1plajlqRG8rUUJjbVA2VG5IVFNoRDJaZGt5bkxTQVJjRUpXYW5wWW01?=
 =?utf-8?B?KzErUFd2b0FQWVZIdUpkaFBVZzZOUlR4NzhDaEk5YUN1dFptVUlybjB6U1NG?=
 =?utf-8?B?dnhSVGdMd094Q3pTYUJ1TWErQ2dOTUl6dDZZQjhkYy9kaC84NEQzN2NoMXZw?=
 =?utf-8?B?WGVTMlNIVXlrTEw1YU9wcytBY09nR1hLMVlEVy9FWDZ2YWpuYXhHd1BnNHJF?=
 =?utf-8?B?eEdXbWNJUlk2RnpuUE1id1hPWjE4Y0Z1VlRMaFFPZ3RyMnVVeWx6VzFDakpa?=
 =?utf-8?B?cklabFk4TUZaTWRXWFVMOGlQczZKYk00YzNtV2ZuNS9oL084LzRSNTE1dkNJ?=
 =?utf-8?B?d3JUTzFVSytHamkyeDJQRUdkMHQvOFZqem9rU0VSS2RwR1poSk83NG5pVDlT?=
 =?utf-8?B?cGJwdUZBTlV3UXV6eUVyaUlsaUdVZkFJL1l3UWg5a0JzcURWRG1VZndnYzkv?=
 =?utf-8?B?bUZOSGVDbzFwRFR5cVhZb3ZwdmVCT3hjbzFwSGEwNlRhYU9FSGFuQkdveXB6?=
 =?utf-8?B?TXl0NTYyOFdTejlEZFFWbDNaUHdyMGFLR0Q2bU9nVE02WFdKN0J1Q0hBRGI4?=
 =?utf-8?B?Q2tncUhqa3lydVIyUHNoRzVSOWRzZHRldy9BdDFoVVF2N3d6WnIxSjhSbjYw?=
 =?utf-8?B?RGFWZk1jN2JQbUFrUkpVeWFoZzZlWm9jNWNQeGhDWU1IeERCSEdaa2ZNUUlo?=
 =?utf-8?B?dTRJZ2FYQjlqYmtVUStkNktWeHI0Q1NOVmp4bzhrbHJSS3hmM1FNY1REOFlx?=
 =?utf-8?B?NzVuV2Fuc1RYRytYN3hreHRlSDF1Yk81eVNJWHkzaVFYcUh1eEhweXpXNmIy?=
 =?utf-8?Q?OTB+AhOthsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk01bXhLREN2bHZwSGx2SmQ3K2hLcDY1NGtGblVMZ0c5QzNiZ0lVSWpKeVMv?=
 =?utf-8?B?MVJ3dmM3NVl1TE93NjlzTDRaUWNIenlKMjMzNVgycWx6OWRuZXI4MEU0NVI5?=
 =?utf-8?B?N3B1MUxuVlRWU2FVVWJwRnVOUnM0U2pHMExwOXY1TElxQy81SS8zYzFQMXNF?=
 =?utf-8?B?b2pUcHk2aTVSTy9RN1Ayc0IyT3Jna050alFaYkRVVThpTDlSdWk3aE9Pb3lS?=
 =?utf-8?B?RUxXalA3UzYvcGZNblVKekE0dWJ5OStZS25kRXNNaTd1ZUJtUEZ4YVlMSGxH?=
 =?utf-8?B?VmVaNGhQMHVkcXc4NllYcjVPdjRCcHlOZHZvK09qYTJ2U3F6ZmVWN3prbW1E?=
 =?utf-8?B?SThWYTdPUUJpN0h2VEowSEtJV3NsMmdrMllJbmVRd1BOc0t5RTdxaWc5NjNq?=
 =?utf-8?B?T2c0czd2d0ErK2ZlaWx1RTRLTnpibDY1cXZhSm92R3Yzc0NwNG9hWTVPVFNp?=
 =?utf-8?B?THVDbkRGQmVyTXUzVTlFcGRCWEhYK1VwM2h6akM0bklNWWhSNlY3RWtac0pT?=
 =?utf-8?B?YWpXSVZyUy8vWkxtVTdZK0QxTnBpTVI1TEJOWDhhQmYraHZrWGJhR2ptNEtX?=
 =?utf-8?B?RFpSaWNZS0dkWjJubnU0REtzQXdMbVp6RkRHREgreDJXZ0RURUd2MmwrZHBi?=
 =?utf-8?B?WWJyRXdXaFRNdkRuL1pTZmY3Y0dTRkhVNlBlREh0OGJBQU5VK1hDUE8zMWFM?=
 =?utf-8?B?ZDFDK2hGZ1puZUl4UkxPZU40RVhZSWJPbEZUYkpRd2FwTDRKdXc4aUIxSU5P?=
 =?utf-8?B?emxYRS9YbklSa0JhVGVZRldGUUZ2RjBwSGZBYVlFVU9jcnlQV2VTWFBDV2hJ?=
 =?utf-8?B?WHpQT2pzV01VdjVTdkszTDBRdndBWjQ0bmxVWEpkamU1VWJucDlhT3RWQVo0?=
 =?utf-8?B?Y3ZldFY2aHFJTDNIRk0vOGNWNi9tT29FQWd0WGR4eDZEd2dmQmprcXVnYUg0?=
 =?utf-8?B?MkFHTWtZODVHVzY3NnAyeXZUZ09QeWRFbmVBelBybVNqM1lwL2JUZlBDZzBQ?=
 =?utf-8?B?NWNaYVJZUjZWL0hxNVlkWERxNEVacjVCOEc0bWlzd3hUR1BwWS91OG54aFc5?=
 =?utf-8?B?NVljaHVoK1krTUtmM243UWZ3RkZPSkQ3dXRIWExrTzVjd1pTQnpzZ0RlRExu?=
 =?utf-8?B?T3ZyYTl3RE52eHl3YW55dXB1TUdtU2VIOFNQTFlxRFE0Zzhtei9aS0RINHR3?=
 =?utf-8?B?d3VYa2ZEUEk5VXNNNUdSUWJWK0ZlZDFnTFpPWHFrNjRLbUtmRVE3VzJyaHFR?=
 =?utf-8?B?bzg2Y1JSVnN2Q3NnWjlES1VQZko5c3JOZVQ0ZmR5L1czelVJTnFJRmVZaDRR?=
 =?utf-8?B?Z3VKejc1eTBob2NjNU02SEE4dFV5N1dkR0pqdzhReGJUMFVmS3ljaUwwQ2ZT?=
 =?utf-8?B?cDlUM3FnZFhqbHJFL3l2Um16Ri8rcFJubE1OSWpGOUdEV3Rpb1FtbkcxSCsy?=
 =?utf-8?B?eHpSWSthTForcjI2VW9GNFEwb3ZBWXdxWVJXd1BlbGg2ZnR2M2tJbVBsTyt5?=
 =?utf-8?B?Yi9IVFhvOXhMN1V6dlpoMEZkTThCbVhWemdEWmRRMVcrTW9iR1JRdklncGxy?=
 =?utf-8?B?Z3QvdDJ3d0hyV3VLYng1T29FdThIcTN0ZDdEa2ZWaHVieGxsZGhIV0V5TDVQ?=
 =?utf-8?B?REVRRmFGcFdZcmZ0UjV4QlhuZ1RvWjJBdEw3VzBmVXdUaXhDMTdWTGQvYnV2?=
 =?utf-8?B?TWNNYmptMnd5emZuT1lheDNvU0lmUjNxc1hCNks5OVY2b0NtQW5vdEJpdlRE?=
 =?utf-8?B?cXdnWTJpeFJuMkJUZjVVRXZaN2dRRG1jYlZFT1cyZFF6bmNuYXIxemI0SnNt?=
 =?utf-8?B?b0twL3lVaUUzWHZkQ25uNXdIWmp4bGZQd1ZMeHF6b3poa2QrcjcrK1hXc1d2?=
 =?utf-8?B?MmNmRDBFWUVFd0tpRXZXMkJVZGRpQXNFd250Yks3TzZTeXlaaHNRaUM4cGlY?=
 =?utf-8?B?b0k5M3AxK3N4a2ZrL2NlMEZoRGhXSEFSNEhCcGdHYUFCNm9HWVo3WGgvNXZu?=
 =?utf-8?B?eExjRTA5a1JxcWI1YjBtN2xXMVFMYTA1MElXQmZXYjFIWnI5YUFnQ0lZMVJZ?=
 =?utf-8?B?Q3RmUzRQdnNPY1I2TEdVRGdJckFJNWs2Rlp6TmkrTmM1bjlHbGZycE5DYTMv?=
 =?utf-8?Q?lDL8N9neHv6h7g4mulAIkofBK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1e5878-49fa-45cf-c755-08dd7b4e2c1b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:16:23.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDOuQe9DxMBiEi2hi4mrdTW/1Ba1oXwajEiP4Y5PbWXH63fPM+0+kHItHkfUWcnUd1qDUeZLY7oXhw53mBSW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435



On 4/11/2025 3:48 PM, Larysa Zaremba wrote:
> On Tue, Apr 08, 2025 at 11:49:59PM +0530, Raju Rangoju wrote:
>> Add the necessary support to enable Crater ethernet device. Since the
>> BAR1 address cannot be used to access the XPCS registers on Crater, use
>> the smn functions.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 79 ++++++++++++++++++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
>>   2 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index ae82dc3ac460..d75cf8df272f 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/bitrev.h>
>>   #include <linux/crc32.h>
>>   #include <linux/crc32poly.h>
>> +#include <linux/pci.h>
>>   
>>   #include "xgbe.h"
>>   #include "xgbe-common.h"
>> @@ -1066,6 +1067,78 @@ static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
>>   	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>>   }
>>   
>> +static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>> +				 int mmd_reg)
>> +{
>> +	unsigned int mmd_address, index, offset;
>> +	struct pci_dev *rdev;
>> +	unsigned long flags;
>> +	int mmd_data;
>> +
>> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> +	if (!rdev)
>> +		return 0;
> 
> Why do you operate on the root device's config space? Is this SoC-specific,
> like in ixgbe_x550em_a_has_mii()? If so, would be nice to have a comment or at
> least something in the commit message.

Yes. We have additional patches in development that follow this path, 
and I'll ensure that future patches include relevant comments to clarify 
this.

> 
>> +
>> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>> +
>> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>> +
>> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
>> +	pci_write_config_dword(rdev, 0x64, index);
>> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>> +	pci_read_config_dword(rdev, 0x64, &mmd_data);
>> +	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
>> +				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> +
>> +	pci_dev_put(rdev);
>> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>> +
>> +	return mmd_data;
>> +}
>> +
>> +static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>> +				   int mmd_reg, int mmd_data)
>> +{
>> +	unsigned int pci_mmd_data, hi_mask, lo_mask;
>> +	unsigned int mmd_address, index, offset;
>> +	struct pci_dev *rdev;
>> +	unsigned long flags;
>> +
>> +	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> +	if (!rdev)
>> +		return;
>> +
>> +	mmd_address = get_mmd_address(pdata, mmd_reg);
>> +
>> +	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>> +
>> +	spin_lock_irqsave(&pdata->xpcs_lock, flags);
>> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
>> +	pci_write_config_dword(rdev, 0x64, index);
>> +	pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>> +	pci_read_config_dword(rdev, 0x64, &pci_mmd_data);
>> +
>> +	if (offset % 4) {
>> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
>> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
>> +	} else {
>> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
>> +				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
>> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> +	}
>> +
>> +	pci_mmd_data = hi_mask | lo_mask;
>> +
>> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + pdata->xpcs_window_sel_reg));
>> +	pci_write_config_dword(rdev, 0x64, index);
>> +	pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
>> +	pci_write_config_dword(rdev, 0x64, pci_mmd_data);
>> +	pci_dev_put(rdev);
>> +
>> +	spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>> +}
>> +
>>   static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
>>   				 int mmd_reg)
>>   {
>> @@ -1160,6 +1233,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>>   	case XGBE_XPCS_ACCESS_V2:
>>   	default:
>>   		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
>> +
>> +	case XGBE_XPCS_ACCESS_V3:
>> +		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
>>   	}
>>   }
>>   
>> @@ -1173,6 +1249,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
>>   	case XGBE_XPCS_ACCESS_V2:
>>   	default:
>>   		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
>> +
>> +	case XGBE_XPCS_ACCESS_V3:
>> +		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
>>   	}
>>   }
>>   
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> index 2e9b3be44ff8..6c49bf19e537 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> @@ -242,6 +242,10 @@
>>   #define XGBE_RV_PCI_DEVICE_ID	0x15d0
>>   #define XGBE_YC_PCI_DEVICE_ID	0x14b5
>>   
>> + /* Generic low and high masks */
>> +#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
>> +#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
>> +
>>   struct xgbe_prv_data;
>>   
>>   struct xgbe_packet_data {
>> @@ -460,6 +464,7 @@ enum xgbe_speed {
>>   enum xgbe_xpcs_access {
>>   	XGBE_XPCS_ACCESS_V1 = 0,
>>   	XGBE_XPCS_ACCESS_V2,
>> +	XGBE_XPCS_ACCESS_V3,
>>   };
>>   
>>   enum xgbe_an_mode {
>> @@ -951,6 +956,7 @@ struct xgbe_prv_data {
>>   	struct device *dev;
>>   	struct platform_device *phy_platdev;
>>   	struct device *phy_dev;
>> +	unsigned int xphy_base;
>>   
>>   	/* Version related data */
>>   	struct xgbe_version_data *vdata;
>> -- 
>> 2.34.1
>>
>>


