Return-Path: <netdev+bounces-165208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C69A30F46
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD24C3A132F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37524C693;
	Tue, 11 Feb 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xfg1kV7O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2F3D69
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286570; cv=fail; b=lDTchVkfgIlR8QEbjISRsV1YpG7Ol3fagnLXKj2HnR5Uab9Vf2gfkS+y4Xq46K3JuR56Sl6yr7IMbUM5lhfoc2REs/uHbyvEYrj9QalRKxveeWqqqzQOLaBvLrTM77igBu9e/kBIXmQ33qV4Y6kFR7AfnpY4t4Aj6kC68f5KYyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286570; c=relaxed/simple;
	bh=Hu5sMgv3UMkah8TOi3SPcC+v9GWp/HYsb93hsyj5xcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tTD1zMMz15F9CpVvmwxTXRpqdmfRX0QXH4fhNpS9TbBBC0DTtVVRBIGkrQZSZqr4EhXKck+9UPz5g2grYQCuOFuqeqpXkVvQ8Kpp/tvbJCeEUufOOeJweVDhoctnlOQI/3wki7hHHeKQ6dgnwiHaBDjzbMfJPwQ3J9GLvw4zy20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xfg1kV7O; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM1QTRRkS7GnrDmY+CaFLHqWIH3RwLsopVEUFMZfB5u/tHLa9JCUqEbXE8WwF9TF2cDahrmwzv1PaQkqTQRjo3jsRWvoznzwP1o3F6ZeFF+eIlShZkSFsTrCv1IQ011J++jy1YLBEUszhXnwsJuf4HxaT3cW6pQBAQRfFDVgZU/13wwSdnMj+4qYVSo5idOu+WV/x+pbNNc4Ljid8Q6/ZN5enLoO5oWFu7KBPw6MQ/U5dAT7Vn8o+lBL2ISRl/Hy06lScrH+33RO/stt49m6tyioEtXJefLg4ihB36Aiuhh/jqjwrMG7My+Vewrb/Eo9BkgFPLsQavcxFDnQF/Qq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AcwJ4tX7zWI7r57BV2QzXWD9sTmSbwZ+tfnkihGf8U=;
 b=r9Nw4pX4dcuZyB1bjEID2yui8kAZHPLP/TWqp/ypFn6O/1ZfDuxSFG4ZLVs8F4j0opbcuAqNIcROl4afm0HruCSGMk48uX4sZcgWbgtlF31sOt/oR2ct0XQbspBIZYUngb3IAoLm4EYeA+xR6mTGae18JY2reCGSCT36boIZoljJmSC5Xo51yT2hjUrOsJOn/c+oyf0+aM47/5/ehq6StLIyOJw3RuDIQ1dLzkN7s7idVBccNB6Nvh6Lc4jaEGcwo9ox3zGUPGYKOHdfYL954lYIAzjMIpcSm1BTUJCmNtEy/nW4t9zAberZET/6Nr4yIyMfan/HHVt11N+xbWYnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AcwJ4tX7zWI7r57BV2QzXWD9sTmSbwZ+tfnkihGf8U=;
 b=Xfg1kV7OOpU1L+OlY2R9oeF3tEkp6Ny8U8IE6qTYCdF8QKDpUmaZ2UX7RGYcZY0vjSw2JBT2Hbhj/oVP86oYPc9JU9BHdbnjunDzdQM/1Brc+Jw2Hdpcab+bQGxJgbnW3Ng2V+NeZYlzWWa0gkIjpOn+85rcZvAgHP3yanrBJIVGJPVF+shEz7omlK8adCIxwVGnmv4/VSGORVgI61XptrqtEl3mxToMMn03nr8PePcwiG+TugOrOv2/Sm86d8qkrXsU82Hwg3oX0WhYgc0JxD48dp6AE///vCK09nzTX10YS9mGVanenIZ5fkK/4bVhQLfyuJhzoa0uYJ4EmM00ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 15:09:24 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%4]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 15:09:24 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org
Subject: [PATCH net-next v2 2/3] ptp: Add file permission checks on PHCs
Date: Tue, 11 Feb 2025 17:09:12 +0200
Message-ID: <20250211150913.772545-3-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211150913.772545-1-wwasko@nvidia.com>
References: <20250211150913.772545-1-wwasko@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd1e215-1cf9-4e57-9323-08dd4aae1222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0JWOEhpbFo5VVpUYnJCNS8yZ3h6YmsxT2xlSlpxcmFBS1lQRlJMQ3dPWENj?=
 =?utf-8?B?a1puRDc1enhmcVdSc1BJK0NSWWlsbVZoWTNmL0VpaVFuNnNQSmtOUFhCWkRO?=
 =?utf-8?B?ZC9YS0w0LzZCc2QzekFNTEdFQlQ0b1ozc3pmbjRNT2NWRWdtVFBzeUkwREw4?=
 =?utf-8?B?WUJ5QVluTUh5c2V4Um5BZ0xPZm4zZnVZMXk1a3ZEODZwM0lTckVmbjQzRm1k?=
 =?utf-8?B?Vm4xMm9oS3FCZUQ4NW9DS1Jza2lITWI2Z29lZGNyNnJNR2NudlcxYWF5OXB5?=
 =?utf-8?B?MjZJQkJRVU56aGtKMmlVNzhnK3A3WFVtT0NkNVNqVUdiNlpxT1lBNFRuMjBq?=
 =?utf-8?B?NzFNWHcyQ2FROVlMUGhNbUcxekR0MmZiR29reW45ajNobUpqb09jSDk3Lzd4?=
 =?utf-8?B?QkJzbDRaeEVRV1FiRUFyRmEyekQxYThhT1BVUGtlbHdTQnBBTnBaVzhJRVBT?=
 =?utf-8?B?WjU5blArQy80RnZJa0QxNjBLNFZTRlZVbmZtQTRpSlFrU2htclE5T1cvVjY4?=
 =?utf-8?B?aDdBdWJzeGVkUzdTN3dicnN0eEN1UjhLSjZWeUFDOXFLY0ZDUHdYcE91MnZP?=
 =?utf-8?B?bkRjdnBLZlhxV0NqMGZBbVpveHFBWnRNckdPZmVhVk8wbzZzcTIwbnFKUHN2?=
 =?utf-8?B?N2JhUUg1V3pLM1pQWjdmM3d3bHB4dmJVV3lYckFvS0svTHB4WUdQN1ZDc242?=
 =?utf-8?B?UVBXc0hoWWlDR2grR25zT0NHR3I0NXJoakF0V2t3SlpKWDZmbnV3ZjBWMGQz?=
 =?utf-8?B?R1NsWGUyRE5FZGJOWFRRZjNtOGhBSk01VDYxSVJMay9WNjdBd1ZhMVhYYks2?=
 =?utf-8?B?cVUrSzdhN3htMkkwTzFtN2lBbjVIcGluWkJSUTN2cmxVSDBLZ3dvY3U3ZDJR?=
 =?utf-8?B?S2lMYkltSFB3ME9Od0pZbjROZmtGMlNtS2MrU0xuU2srcHhIanFiODNzRjMv?=
 =?utf-8?B?b2lRVzdCUDN2L2lwY0dkZjN1Ti85cHVMdVRsc1dlbURoL3htazRCU1daOWda?=
 =?utf-8?B?bDh2TEtNVE8rK2d6dlRmR0NKMk9YWkRyL0lrMEppMGJNcDdZMS9rV3I4MnRh?=
 =?utf-8?B?TDZCRDFmbmJzRlFPeUpXOEZTZUo4TFJQUEl0TWJURmxBcEtKdFVYYmRPeGxB?=
 =?utf-8?B?Tk90UmRpZUlScjR4QTF2UXdZVFh0cFJsaTJwYjJQZitiUkhNUlpORlJLcjNC?=
 =?utf-8?B?UnlJTDRYdTcyaWtQUlBTbHliUjh4M2RaMFlCY2JodTlOMi9oa3JONnZTUzZ3?=
 =?utf-8?B?M0xqT3h1UGk0OTRSalVHZnBKenNDcXg0SHpLQTlZUDRhbk1WcGdNejdMKzF0?=
 =?utf-8?B?YnE1aTFoT2IvRnk2M1ZsVGhrQUh0Zmd5YWl1VlNVbGh2RGlKNjdFYTEzeVN6?=
 =?utf-8?B?ODl2SytidGhaRVB3R0pxTHRtR1gvRkJERDZTTVdJNDhpNHRES1BRemZKNHNr?=
 =?utf-8?B?cnNRSFpVdDk5cUNuQkJNUHd3d0YxUEdEQ3NRRDBKblBjNVArQXNGaEdwWm5R?=
 =?utf-8?B?VWxkVzhGd0lhYzhYakhVWlBzU3RJM1N6T3FaWElMdEtMZzdtWUpUWHMydHdm?=
 =?utf-8?B?K0VCZStpSVdHN05XdWFDYjkxeVVSNitxVlhqRUpzZmFSQTVLeWdSU2dERWZS?=
 =?utf-8?B?NThUOWkxeXFJMnVJRnNBaUNPQUVISEM0Mmx4SFB5V1h4SHNLSXEraWpMbUI4?=
 =?utf-8?B?dXNZUnNuc3dDTmNQR2V0Q0tDUnJXR1lHVmlUNEVHekU0YWs2S0VGMDRTM1ps?=
 =?utf-8?B?azhOeHZyQ0JPWk1oMVVFclFZYXVzMVV6Rk9QZmc5MlNPMzBiNXQ5ejhxaXFa?=
 =?utf-8?B?VHJNTWNONEE4eDVJVS9pSTBHUWZHaFY2S1YvRnlXMEdjZzFPZ0NaYUFKSEhV?=
 =?utf-8?Q?hoJW6Ly8JgLd/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXdGOHNmenlxYkJzRTU4ZnhZSldDTzZqc3VsQnVIWjRtTmQyb0hydnYxZGk0?=
 =?utf-8?B?Qk5ZZ01BVnRJa25XQnRMaWx5Q0liMnlweW9lUTRLSFdHL1piWDJkd090VEVW?=
 =?utf-8?B?dEljNlBwZkRXTFBkamVPQ3JwYmRHTjNWWE9QUGZXL1FSVHB5NUt1dmdVRS9E?=
 =?utf-8?B?dnNvdEdyS29OemEwcEN3TjBjQnBIL1ExZmlRL01rdy9TVm1ncHRqYVRkazZG?=
 =?utf-8?B?VFhIejljY0x1OXhyMzNMLytKdHdRTTFTU0JUT0F3N3pJZHVvMzd6UXJHK0Jo?=
 =?utf-8?B?VmIyWW9sc05KbHIzcXpVN1pubW83czV0YzI3bVFMc3BkSTgxYUpzSlBVeE9k?=
 =?utf-8?B?a3BnWGd3L2YwU2FzNnRoOHB4ODdwcEFQVTlNNVBJY3k1QXVTQVN4aDNwTWlK?=
 =?utf-8?B?TGJKc2wxMzBxOUxONE1JU29EMzUxdDBveVV6V2FRcFpHTEtlMTE1d1I0MW9Q?=
 =?utf-8?B?aVRHNTBEVGpIQllMYUVvTHI4SE9OUWR4Y1BBK1JSNXVvYm1qNmNCc21aMzBr?=
 =?utf-8?B?aFBSb1BLZ1NpRkJDdTZVZUYrSTJod3h4V2pnL1NXWkZlcG9sZGdRZ3VaQklD?=
 =?utf-8?B?dCtkRmhuWEZ4V1FST0k0TDNwVktiYk4rR1BQbC8xMktVOW16SWhxcTBBcjFY?=
 =?utf-8?B?cXprTnByTmFjMjhFc1ljZTNxbUxxSXFIY0dlR3h6by8yMmVrbDBPdEtFMDhO?=
 =?utf-8?B?dG44YVFRSEVyVm1YcThKSHZCRUZ4Q2VvUFpVN3BqWlJHbDRhVzdPcnhLNXRP?=
 =?utf-8?B?bnhnRFpOSVFySGVPYVlWeEg1ZnA0NHZnRFdOSHdrbTNIYTJ3UzJEYTBBTDVk?=
 =?utf-8?B?MVNMOHFub0JVb0kvdDJjcGdUZ3N2R01kdCtDbWR6TTZKT29wTll2MkpkUk51?=
 =?utf-8?B?bFhiT0c0MXoydXhreVRIdUtvSGpGdlFEZUVMYWI4QXRiLzNCL2VpQ01ab01U?=
 =?utf-8?B?K3Z4T0VzOWgwWGc1MEhnRjZWZVBOMVRnSy81b1lCaW1PZWdGaG5RdUcxRGNX?=
 =?utf-8?B?SDMvbTRxdE1zcEd2VkpaR1VUN3hYSGNLWmpuZzM3VGtWOXpzMmp4dTM2YWhM?=
 =?utf-8?B?QUxtYWpVTHRsRUZJalg0T0VUUmdMRW91SDl2RE4yKzkrNEtURzdOMHlieWFL?=
 =?utf-8?B?LzZXRlVzeHZkdmdHZmtOZElnSkRnOXcxZ0hNNC9teGtlMUtiZVFhSUc3NXdk?=
 =?utf-8?B?RDhXKzFuRHZ2ZjE3N1psdmxUNFJwT09Zb2NpRGl6RlIwYkFRUWxhYlBqeWMx?=
 =?utf-8?B?dThnMG83Q0dsMVJLNmFsNTRYTzJiOUtvWUxiL3MwNFp6RnczbnE3RlRuMHlR?=
 =?utf-8?B?MzRuWWlJS2lmNXJSSlFCSXNGZmxHNFVPYnRKSHdRV05ROUdFNFhaQnN3RTRV?=
 =?utf-8?B?WG5hckdTL09SL0piQ29zdzlXRWNJNlZsbGtLNW5CREorVDM5Qm9TTnY2RnEx?=
 =?utf-8?B?d1lOUUV3UnZrVHZKbmpYVGtveDVmTzBKQWM5STlGbml2N09JOUgrUUhjM0w2?=
 =?utf-8?B?SW9uYXhMdkRJdGZlSzFTRy9oNkNPTldGQzEzcmI2aHFoMll6ZkRGZVpSMDNK?=
 =?utf-8?B?MXlqb1hPUmxaaGFXSjdaV2RoWXFlVllPbUxnbUxmNkR3MjBmSXlFd0x6OHJu?=
 =?utf-8?B?NHNmSlQyMFJqV2o0amZpQ3RzSDR4MTYzcDdML2dxTFFrT2tLcE94SmF4UHha?=
 =?utf-8?B?MTZSVHAvRkRyQURwZlVDb1cwRitkM2F4cFBMS1VFc3hhTUhrM0hEU3ZaQ0dp?=
 =?utf-8?B?OGd2UlhIVHV6bHNINTIzQm9vTEd1Y0Q5V0hVSmhUQzdCK3d0dllBU3ZSZUsx?=
 =?utf-8?B?M3JjL2xoU25ZZDNxMXRkN2EybG1zSW5ubDYwV0g4dGFXditJZTc1OS9ocDh5?=
 =?utf-8?B?RmlRV0Q4ZkRBT2p2T29oSnF4N3k2RXB6REFUU2d3d0Y5cER6c09SWldDRFJ3?=
 =?utf-8?B?MXVGV1ZEVDBCMlpscEhHY1pYVXdGRm90Z1k4dzFUS09RV0N6dm5jdTBUR3kr?=
 =?utf-8?B?dFg5MzBGUjRaYmRSQXBCUXJ0ZWFjcTlRNmM2elBJTjFSdkZwUy9mYURmQm9p?=
 =?utf-8?B?aFFtRFdpYkc2WHRTbWZWeVRRbk5IMDR0Q1BZNlVrRk1keCtuZE5jNmIyL280?=
 =?utf-8?Q?htNy+qWQzdXD4JE5L0U3qFwfL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd1e215-1cf9-4e57-9323-08dd4aae1222
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:09:24.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cFqswaNEWiV/4qy8FIurVwHjiwLClpoWUIN3AuTM4BGanEsfcAxZd2j//HZhGUm2raedIuo6UF1XiljTOZ6aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

Many devices implement highly accurate clocks, which the kernel manages
as PTP Hardware Clocks (PHCs). Userspace applications rely on these
clocks to timestamp events, trace workload execution, correlate
timescales across devices, and keep various clocks in sync.

The kernel’s current implementation of PTP clocks does not enforce file
permissions checks for most device operations except for POSIX clock
operations, where file mode is verified in the POSIX layer before
forwarding the call to the PTP subsystem. Consequently, it is common
practice to not give unprivileged userspace applications any access to
PTP clocks whatsoever by giving the PTP chardevs 600 permissions. An
example of users running into this limitation is documented in [1].

Add permission checks for functions that modify the state of a PTP
device. Continue enforcing permission checks for POSIX clock operations
(settime, adjtime) in the POSIX layer. One limitation remains: querying
the adjusted frequency of a PTP device (using adjtime() with an empty
modes field) is not supported for chardevs opened without WRITE
permissions, as the POSIX layer mandates WRITE access for any adjtime
operation.

[1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html

Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
---
 drivers/ptp/ptp_chardev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index bf6468c56419..4380e6ddb849 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -205,6 +205,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_EXTTS_REQUEST:
 	case PTP_EXTTS_REQUEST2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (copy_from_user(&req.extts, (void __user *)arg,
@@ -246,6 +250,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_PEROUT_REQUEST:
 	case PTP_PEROUT_REQUEST2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (copy_from_user(&req.perout, (void __user *)arg,
@@ -314,6 +322,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_ENABLE_PPS:
 	case PTP_ENABLE_PPS2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (!capable(CAP_SYS_TIME))
@@ -456,6 +468,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_PIN_SETFUNC:
 	case PTP_PIN_SETFUNC2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {
 			err = -EFAULT;
 			break;
-- 
2.39.3


