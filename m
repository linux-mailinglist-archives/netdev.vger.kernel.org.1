Return-Path: <netdev+bounces-151670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C899F0808
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52152829DC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D781B0103;
	Fri, 13 Dec 2024 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="trtr6bqV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B401B0F11;
	Fri, 13 Dec 2024 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082664; cv=fail; b=Y5eIyWZr0PSJrL0vHF7yDitzUx0PXCU6XzXdjMgX5yIFE7kd0iDl6gmQP4MSkn6kHDAYAARPjxUkS/EK4z0RN9/IIcnN9xC8WDfsX+jVAGw7mXhiM82egAHmge6AVK611WXmZNYVIvO2IGx7grez0bv2x4hgh68mml7tlzBcOGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082664; c=relaxed/simple;
	bh=vvslS5IAcbrkKssEmD/uLhmCDp6GbBJqh9bqMSl9Uxo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H7xX4CRrG8/VdjmrZamAtaGDkxp8Ug+HtK3xIXGzedYuOiT0o8Amg0BkwV6vxmYeq4S+T+uaVSBkI0S37FzlpoATHSAfDzKqfRevFtg/9jQI6cCy3alJzIiEXv9vUTVDi6FkVjNLq88rhOoo/io5o26ACls6XDikwm5wSThlLYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=trtr6bqV; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZa0WsjJUwkEO73pYCuQEA5PKqOcS7dngYmJgq2v1sAHcBcc4sueoMZe5IqClcN3ayQAu5ogKHUSUjbJBkdx/cnPmTpZTdAT2R7DycVu2p/bcLAv7g/FAbFaPyejpJCpDKqGtovswUaP6/n/5Nj1ebevrNmogxIjNhvM+pEUEyMMgukWIxj8PvieHjaA/DH+VZO6ZunL2+ChHfOKG5rcjA7HGFy40CR7z27FNjmoUZ36eia3iNGqWKy8oKfDBwpbbEihVgxs1P4pEE5BqxQaAqKAcdbOTX9UGN2rY+Ie2/rd3dHkcVgK6ijLm6kl+Fm7151o4ZStRiohdN3KZ4ghqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg74/+jwy9asOFS+rs7RJpFbqscpxslJbUw4QUTO1co=;
 b=g03n3Zd1/BcEqDJDwilUk4L0Cjj5w2mcn1SPgieh+Cxelcs4KuHpuaZTX3WpkTTLMGQjmbeI8k7Gqq/XvlMLt6KLmjjxfATDHyVA2ZB1zillil96etMK4l9G5kbdBppVBT+HRtLKMToSfkSGTsg+NEOorhdyOknL3KztC4NMjiOs9RX878UPaRksDWMS13p/LCbB9UGtePGi6zPXYAWi8jxXyfRcMb1SOOJvMFHK7u9JmAqTMUdf/C+M7cfz+SzO1QrjglHMyI4I75nXi1I2a2lH9bOqrDncFucxNFTqy5Suvd0TGBHuIJY5lyI+ENRkDVdihZ/teQhUopXCutybKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg74/+jwy9asOFS+rs7RJpFbqscpxslJbUw4QUTO1co=;
 b=trtr6bqVMEQBiKRYslmamNaqFZc7a6KtJNtEZNerkDaKKdUHKSLFgXxbrUU4qO0tQBcYnFKY6fxCeZ7oGSFEovoW9aatU7E8SQhGqgpIBYm6E5ddCVCA86V5CLmUZ4LkbThn8J3q3ZlTAszCpVy3VOYQeC5g7fGXT5cYa+Yb9Pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 09:37:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 09:37:40 +0000
Message-ID: <33368384-8ec4-fc3e-9e98-9864632eec6c@amd.com>
Date: Fri, 13 Dec 2024 09:37:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 17/28] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-18-alejandro.lucero-palau@amd.com>
 <20241212181203.GI73795@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212181203.GI73795@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0156.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d21fee9-6a24-47d1-96df-08dd1b59c99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmxkNk41VVZJT2pLTUswYUhLbkdBQ0MxLzJDNnJNc3Q2Y2twYzJYbWMyb0FG?=
 =?utf-8?B?ejN5TzV0U0hheHg2N3NpbE9SYXVjeXFKVC9jcnpWMzl2ZGFhaHRHZ1pzb1hp?=
 =?utf-8?B?UmtvYlB6N2IxWkN5T3ZLbG9pKzE2QmVkUzR4Q3FiUnZSNFBGTmxacHZDSDh2?=
 =?utf-8?B?Z2FPblR1QzRTT1NXVFhRMkovclJyc0dtdVF6MCszbGdURUoxSFVMa3lZaXdQ?=
 =?utf-8?B?QW15UzE3QjhmVWVFTUlXYmx2ckdsZlNPMmFMVzFYb2RVejJLM2piUWpkZFJu?=
 =?utf-8?B?a3JNbVpDc1hJVmxGVmxWWE5XMkw2Vno5K3NJVFlOMlZJZnBOUGNhVWNGY2hv?=
 =?utf-8?B?TGVHTUFRVUdEd1lHODQ2TlBaMDkxWjJyS0x5VnRyR1B0V1N0SjVKRTRIWVZy?=
 =?utf-8?B?RFo2b1dEMDg2bHJaaGk1bnNyZjFEL2hxUytsT3dhN2ZuL0tTTHVmOVdIRmd1?=
 =?utf-8?B?SXBSTHk4R1VaNTdOYjBsNTdKbktBb0YwVDJFMjZ0OGs0T1VPbHB3K3liSkU2?=
 =?utf-8?B?THhlSU5tekNuL2loTTVmSC85ZVBscDZQL1piQVpIeHFNSkZDdnNFTC9oKyta?=
 =?utf-8?B?VG1ldXlQZm53TkpoVHVqTGYvcVhPcHMrRk5HRWhRQktOVW42RTRWVmVYRGl1?=
 =?utf-8?B?dExseW1GY2lnN2JraWgxRUNXbVNzRkVXa2crcFp4eEd0SmVQVHljOUsremcz?=
 =?utf-8?B?WWhHVVUyTkNLNmswQ04zek9BeEgvdXhoSUpmNC9KMlBSTE9YdCtUSjl1N1BB?=
 =?utf-8?B?RnRIZk5NZlJ4OTNERVJXMkdXdWIxY1ZRdlV0ajNuYXIrVDErUnVxakRqcTZl?=
 =?utf-8?B?SGpXbUJkRlQrVlYrNHdLN1JOQzFTc1VCVWxVN3hFNzVWdS9LVzlBbUNoeXpn?=
 =?utf-8?B?T1BzZjlETXdkNVR4TUZ1dWsvdFhhMjBSbHpHSlBTeXZrQndLUVVNVzM4M2Fl?=
 =?utf-8?B?ZW1hdkp2TDVlYWxtTGlOVC9MVmRRL05KR2tJRGp4Z002V1BSUWVndlpFbVFX?=
 =?utf-8?B?SUR6am5MOG9YN0ZkQVNlNDZqL0JoZTJKK1VnbS9PWGtpb3dOMU1UNXdBT3hU?=
 =?utf-8?B?RS9XYTRVWWJPRTlaNVlHVDIrSVVqYmxmRXprRkYwWGlZejhaT2krc1hEa2Zn?=
 =?utf-8?B?Ti9YakRmeUtLSmhrYlMwWXRhZUFHUExyT1NLSm82UmlsUFhKN3c0blZKNkpO?=
 =?utf-8?B?bHo1dENIWXBtUWRxTUpadWxucWtBSXUwTTZhY3dXbWFmL0xaYU5xOUE0QW1i?=
 =?utf-8?B?NDNNd1c3YmtoT0dpM1Ywc0NvYmcrc25pdWxoTTRFdlQydHhVd0M2TXYxWGcz?=
 =?utf-8?B?Yi9rZm1kMTlNN2wxOWV5aEdReUZDWFJrTGFtOXUrTkhaYTUwWVFZQzBETzVU?=
 =?utf-8?B?a2xicjR4b04rc2VqeUxhV1cwNHpveTBjblMxdmtrQy80WjZTdlVnWUxDUGNw?=
 =?utf-8?B?U2hHYXJjekw0K1Y5V0J3ZHVhZS9yanRpdndWL0dYSWc1V0IrOGRNdzRlZndj?=
 =?utf-8?B?elhNZmJPcHBSMXBRZTBrSzcrUGUrNWxYOC9wSjdqYUNtcFJCRXo2MkNRNDJq?=
 =?utf-8?B?SVc1WHNDaDBQU1FOTHcwczVMTDdWL2MzZkQ3NU15ZW8wMkZZU3NlL3pucW8z?=
 =?utf-8?B?UlVNZDYvVUNFaWJWTTdtTWc0eHpySkpzeXpaaFRYdVE5L3VSNnQyZHFDZWJR?=
 =?utf-8?B?a1VFSXloNzRXZ3FUY1lyMklRWFA4TVVKMXdHM0JhZ2poR05xL3BIdy9xM1k1?=
 =?utf-8?B?eFFpR0sxemd5UkRPblRVb0Y5NFZ1RVovOFRrQ1hucVNLMVluamVTRUQvK01E?=
 =?utf-8?Q?yjIFSgqOCpHIes7Do8dokKkbXRpFBjAUodbOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXNiRi94bnNNL0cwaWVIR0xodTFKUElDbTRhdllGckpTMWh1SHpjMHUwenhX?=
 =?utf-8?B?c2Q2dGM0M2w5RnMwS0NqUG1xQW1EM2tJVWg0QVJkd1BvVVhTMHMva05SNGFZ?=
 =?utf-8?B?MlVEcEtzOU9xei8yTGNzbjdzSklQemF2a3dmdW01c2M4UzVKOXVSdFZ5SDR0?=
 =?utf-8?B?NmtYaE1Kd25Ea0trSlRCMlAwVzlFNWxtRXBOZ2JMbWZKMkE3dGdKRSs5bzZY?=
 =?utf-8?B?UGlNNVpNTDNlQXFJckl4QnAxRk5RakFLWit0Vys2TWZVUE1xUHRTRU9LamRI?=
 =?utf-8?B?N1ZpeE5DdVpqOEhxWElaZ1Z3R0NndW1yY2ZRZno4YkE4OE9SWmRFOEZzVjd3?=
 =?utf-8?B?TmpCaVkwaDc5TVRyWHF6SWxUQjhQRjZCcmx0MXB1dk1wOVYvQ0NsYlRna2JS?=
 =?utf-8?B?Q2gwMmJxVVdYb0E5eTBsZkJUT1BUOFJnVWU5ZzY5NVVubFhXOUtiQy9OMGNK?=
 =?utf-8?B?dXNXRER3dHlTRHpJS0dBRm1NZ0lLdkx3NTczOU9zQTdDbFJnTFdBOGdBeEJy?=
 =?utf-8?B?cGw0V2VoQ1JWQUVlS0RoZWtqSHNoWTlJRGJNTGxvSllHeUwxYmY5aHA3dC9W?=
 =?utf-8?B?WGZvdlN1azVaVVRrK1BnM200azVyTTVFNVc3cnJPY0pxUVI5S2dGUUR5WUh3?=
 =?utf-8?B?SU1TTDNtajNMeFJsVDhzamJvUmE3MXRPU0FzdWhUUFRoS0xUSmUxRm5GaTd2?=
 =?utf-8?B?MU5aS0ordUNxQXhEMGY1akxyZGs1cHVZZjBNaUhZNWl1eTRZbzJwWFQ0SjhP?=
 =?utf-8?B?cTZ2YWNmNnJkdGRYRkZHLzFTd29WQzJYNFVsOUdaNHJaYWpya2YrcUlMd05k?=
 =?utf-8?B?RnNVRnV2dHNGOEFwcFFwRzRsMmJoNWJUM2xxeWlNWXM2SWhTcExWa1RhUDg2?=
 =?utf-8?B?YW1pMW1Da1FjeTlLVWlXZmFxeGp5MG56alpQTFhXOElLMUYxQ0QxYWN4dXJy?=
 =?utf-8?B?NUpxRzVsWWFXUmdySU1QM0JqMmlGZXU2NU0rTlY3Uitqd09NU0FBa1hVeml5?=
 =?utf-8?B?clZIY091cmRERTg1bFZCMXJYWVhVek84WUdKdjB2U2VnclNzR2pCa29vNFRr?=
 =?utf-8?B?SXZUZ3JLd2E1d3JEaGdRdk05YTEwcmNxYWdtQjl5c3ZqelFKN2pNZXJOSGVX?=
 =?utf-8?B?cUh3QUUrQ1ZLbGY2ZEN6WVJ6eDlqMk8vTDI3OW0wbmU0YVI4QTZKSStUUURj?=
 =?utf-8?B?UUw2TEh6R2ZRZmVHdDhvYWZyUzY0Q1ZrOXBNYndtKzVHUXJ0L0oxdmlldTdZ?=
 =?utf-8?B?MHMvalRzdmNieHBDQ0Y4dGpRRXZsUElUN1MvbDZtL3BQS09uSXowS3JmNzJU?=
 =?utf-8?B?T0NyZWMrME5hUDVSb3E1NkJVaDJvR24vRyt1MzNZeElnSUJxVTNlUW5KS2pN?=
 =?utf-8?B?UDZJS2ZETU5aaUZCand2b2RkdjF2UzZFdGVVKzdKZmlnd3Z2NnB1dFhYdHpy?=
 =?utf-8?B?K0RTaVpCNFg0cG5FaktmMkxNNjlKVDFZMERNNTU3UVFuYUJocVp6VElEOVFB?=
 =?utf-8?B?TjlsekdRaFVTSnlVZTViMkV6VkwweUMySzJuUUJSeVBldDl6blNJMmRQZS81?=
 =?utf-8?B?Q2x2S2NFZ3Q2b2dXVUZwWnBCTEhxVFJUMUR3eFV5ZUdWRlFVLzg1N01OLzVB?=
 =?utf-8?B?VTdKbk85N1hvS3lsa2g5OWd2QzlmbUJPYm51TnQ2MmlxM1ZyOGt1WjlhTVpz?=
 =?utf-8?B?WDBYWGRNYnZNY1EwMm9nWm9zVWlodFVpZmh0c1Z0Rzh2eitWcEltYWpxREla?=
 =?utf-8?B?eHRIcHRJSGtkWG00b1pwR1BUUXE1eitoZTh4bkRuOWwyQ2loU0pNc1V6eG1t?=
 =?utf-8?B?MlV5SVNvSVA1QTE1QmUyTzQ2dGM4K1R3RkFSNnBTYjdyZ3JBZS9zRjNOUnQ3?=
 =?utf-8?B?bU1vQVBrUkxlUmE0QlFyeENnYWhTVU1QeFRFMC9zVWFPS2lveTVGei93OW5M?=
 =?utf-8?B?R3hLUExkVDU1S1Q5cWt2di9xTk5iTmVKRzYrWXN6SVhvcGxpa3hZWW91VDRW?=
 =?utf-8?B?b0QzTE1qVysyUjJPbjJvbTN4VkZQY1p0M0djSGp6WWlMR0pJZEwwLzdJdWRy?=
 =?utf-8?B?UWszYWhrWk5oVjg2SHVEa0N3c2hJK0p5R1V4UE1xcXVCSVdNa2htTWpYVHcx?=
 =?utf-8?Q?gtJT4LrVXy5n56BZY4aY4S+OP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d21fee9-6a24-47d1-96df-08dd1b59c99c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:37:40.7558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8seAWm4OMEn/xOVq125653spEOfBX5YyWAmuS9FO8mu3FSX0BDMBv2Afur61wOrAb9tUZR3A1GGTtwg4ecRECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476


On 12/12/24 18:12, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 06:54:18PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Given the HPA
>> capacity constraint, define an API, cxl_request_dpa(), that has the
>> flexibility to  map the minimum amount of memory the driver needs to
>> operate vs the total possible that can be mapped given HPA availability.
>>
>> Factor out the core of cxl_dpa_alloc, that does free space scanning,
>> into a cxl_dpa_freespace() helper, and use that to balance the capacity
>> available to map vs the @min and @max arguments to cxl_request_dpa.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/hdm.c | 154 +++++++++++++++++++++++++++++++++++------
>>   include/cxl/cxl.h      |   5 ++
>>   2 files changed, 138 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> ...
>
>> @@ -538,6 +557,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	if (cxled->cxld.id != port->hdm_end + 1)
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @endpoint: an endpoint port with available decoders
> nit: @cxlmd should be described here rather than @endpoint


Uhmm, confusing ... I saw this reported by the robot in v6, and I had 
updated it ... but obviously I lost the change during the different 
testing stages moving the patchset around.


I will fix it  ... again :-).


Thanks!


>
>> + * @is_ram: DPA operation mode (ram vs pmem)
>> + * @min: the minimum amount of capacity the call needs
>> + * @max: extra capacity to allocate after min is satisfied
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. So, the expectation is that @min is a driver known
>> + * value for how much capacity is needed, and @max is based the limit of
>> + * how much HPA space is available for a new region.
>> + *
>> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     bool is_ram,
>> +					     resource_size_t min,
>> +					     resource_size_t max)
> ...

