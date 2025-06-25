Return-Path: <netdev+bounces-201183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36DBAE8576
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC82F1776F3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C29725C81F;
	Wed, 25 Jun 2025 14:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bL/643o0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE213D53B;
	Wed, 25 Jun 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860124; cv=fail; b=omof26U4kq/J9ND/Ty1pZ4tQtTWWzv0oFSbqVBilVXvz6vN5jALnuqtGMiQ7BulF9ggDNn8SQ0BukcEkHs0R4jroJRe2G7UtCbSoTjaL704Yny1K3tUwsb4rLMn5oIH8Ms5djuvRYtDdWxGPYTPyt8b/yubzLPvsFbaZAZkf6o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860124; c=relaxed/simple;
	bh=Tr5/P7B0lIl8fun41tDrKXSvKKlT5uFXUICmHKFtmzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VVp6vvmNq21pmOKRBHrn9asovCGg7skl/6pTbLfOCEtQPggAWwdOFNURpO21fkImuHAfCnksHTyFnXWWfu5sJ8x6ZC+JEohKwtFiHoNRzL3HevnOlVQ5cOa1qrGGFF7ZYQL0EynJlRTeT2IG2W53JrfyHqVtgWlZv/OdjbI2tvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bL/643o0; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixszgzd2YKWpo7Jcc7DeJQUaTLt177ClEmFdIINn1GocInWh2m0aPpDTDwHx/aSa2SXeOsS22YgQ+ctcCFIx7EbgVIhEvVxmxF9q5OCfY+nGFgaoAd8mCMI9K8gvINOzBpa6Iy8KJZEc8EOiH8q6jxF2lfOdDKa4lafmM9X3M7f3AzXsXPHL53lWqP9Ojt1cCr5szRKrG1kqGPpZBYNVBPo+vyTTE1B/++xC95aDGa01bGSsM9iGha5qPEgQXYaK6xD2eqRgba32G5rdjfmYf7H77XQ3oplJgiWHAK1CzCQWp+9kB4UgILqVVKm1WIyhtFsiS9WQc/I9FAUHQHcJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGwE3UJX9l2o1UsG/HHzknD7UCmzqFwwvcYvsRjFQEg=;
 b=VHHpWWhd8hP1+EJe3y3LbcJsDp821B0hIDbjyqDmRknRZLgvkqs40ZpwGaC3ngmYV5TG675pL5DUZLA6zvKmkoZz0ixD8VFm+35uB1c2Wp8e02tbKBFmAk/KQAnjFjJ72xkO0s2ZESUotL+9ThEkiEGf1C178ba0HPDaQf94Km6Dg+NYZC99A5XpCWwVp5n4A3J6Av0dOpb8SvCvIBfmd7xAvb2ztsCRcNhQmK3EGsHjLjL7bJYSg3U2Lc3VdH4w17JTUCBrGSnkNgCT2qudFXwzWoAtt/ylSazSgRf9URNmszRkcKB3Ow2Hck1DaNr+wUjgLMwQ9RR7Fs0Gmq33Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGwE3UJX9l2o1UsG/HHzknD7UCmzqFwwvcYvsRjFQEg=;
 b=bL/643o0gsObDqf0twmAsl6wy0YUNgRARBBxSM/O9m5AjG6k9gkq8EYXuU+EILC2lGf/d+FwYxMGrSaO0WWQ3jf0J+9Vbr/y7engHjlhlLws4QHOgZJQSktKJyYzIIXHq6iN6eHTHBXhbbctmoUJt0GFad9VpAtlVx0V+X7mCk844Str0dUjhDxkt/w6M+Afq0VdTOMOfpl+W7nK9ZT0V/nsgOVLenHviuvcxTrv075hBFV95Ei3oobMSHL+g7Nim/Jlh0TBLJ9vf24ViWTwFI2ItTJwpNqGT2xRUelFykXHaSxRTPf1xJhfE5liQJ57/c6w23FYmwja7IPzh2GSWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 14:01:57 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%2]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:01:56 +0000
Message-ID: <b54afc33-5863-4c8b-8d6d-24b4447631e1@nvidia.com>
Date: Wed, 25 Jun 2025 15:01:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Fix PTP ref clock for Tegra234
To: Andrew Lunn <andrew@lunn.ch>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org,
 Alexis Lothorrr <alexis.lothore@bootlin.com>
References: <20250612062032.293275-1-jonathanh@nvidia.com>
 <aEqyrWDPykceDM2x@a5393a930297>
 <85e27a26-b115-49aa-8e23-963bff11f3f6@lunn.ch>
 <e720596d-6fbb-40a4-9567-e8d05755cf6f@nvidia.com>
 <353f4fd1-5081-48f4-84fd-ff58f2ba1698@lunn.ch>
 <9544a718-1c1a-4c6b-96ae-d777400305a7@nvidia.com>
 <5a3e1026-740a-4829-bfd2-ce4c4525d2a0@lunn.ch>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5a3e1026-740a-4829-bfd2-ce4c4525d2a0@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To PH0PR12MB8773.namprd12.prod.outlook.com
 (2603:10b6:510:28d::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8773:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e85eb19-1935-4f64-460e-08ddb3f0d8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RW9HZ1c5NEVqbFVUdlBqWnpZdC8yUUErTVVKTU1KVFl5VTg2RzlrU2E1U1A5?=
 =?utf-8?B?WjdUVDRlekFLY0pYQ0NGYVBHaExQeC9SRzFVYS8rVEU4WlFhZjh6ZTE3anM0?=
 =?utf-8?B?ZDMrZ2VEaHZHNWo5TklXWE90eGpDZzBLRmFVZjA3QWVEWkcxQVB6OUZJWHIv?=
 =?utf-8?B?bHRNNVdDZWVZTTVKS2xXV0RvQVJHT1E5MlpYc1lHSVZPY2wwMXFKUnpVSDls?=
 =?utf-8?B?UEdCMmNCNERiSjdjTnRtWjRjdC8yL0dMQjJ3MkNPYVVseUF0NEVWVXFGOWVq?=
 =?utf-8?B?TDhMQXMwRnJCbXRwUGVnMi8veWpCS00xK1AvRDlRWUwra1ltYVhIU3MvQVFh?=
 =?utf-8?B?bWVlMS9yRDBTZlFTeW5QTVYzSjFZaDUrMmxqK3hVMXdwVEpTTmpJaVlKV3Fl?=
 =?utf-8?B?RzU2S0VyeXRHb1ZkOEl6WE53aE4rSFlkL0NYeCtGZlVpcUJpZ20vTzFaSlZG?=
 =?utf-8?B?S3hlM3dpRGRRcC9wNTh2Z0hDeUpJZ3U3QUxpajEyQ2tXeEdPaDE5NzFza3Fh?=
 =?utf-8?B?ank4WTVaVEVGOTJBM0gwc250dTlVWlRjYUxOb2JqZytYSHZlaXgxUHEvMXVZ?=
 =?utf-8?B?WVpWZzB2c0hKRFNvbW9kcForYUpOc29ZbjFtRHhQU1VXbC84M2xZVDdmKzc0?=
 =?utf-8?B?eXdQMXIreDluMlFGbmFnTURRZW9Gck1EMDNjbHV5RjFQbGxVVUJHbm4xVVp3?=
 =?utf-8?B?dS8yV29JTnVGUW9XVEF6T1hVNUxpS01xNzNkbnkwWlJCRVdJOGFNQ1B1OWNB?=
 =?utf-8?B?NXlUeGhjMFhnUnlHdk51ek5BUzBId0daRnlBNk5GYXZpdFRES25DOVVRdmtS?=
 =?utf-8?B?VFFnYU9Ub3g3Tmo1KzdpTGxtRlB4T3h0YnJPRmlCTnhNRG04cVYxYk13czdi?=
 =?utf-8?B?MFpCTXdzNFdscm9peUt5M2VMYncwZVdLOWNjZU9ZbW50UEdGUytIdXkra1RB?=
 =?utf-8?B?MjFNZXpIcEFxTnExa2JMVlZLZXQ2QWRoaGU5eEpnMTlYSlh6VlVmbU93V0Rn?=
 =?utf-8?B?bzJQVE5FT0d5MjdXOTZWVFE3Y2g4N2JOREtmTHlmWVBlbUMrNVpQc0ZYckNn?=
 =?utf-8?B?UVZNM0xTUzVjTndvVEFNMk5rcE5zNTVNOERXZkFYNVRXMW5pRGJWN0xkRzlX?=
 =?utf-8?B?eG1IV1l6ZCt0cFN3ZW56WXhUUFhhai9PaDlJWkNocGpRRTJ3OWI0WjgxTmJn?=
 =?utf-8?B?YkZYekNlZUh0YXA3WnM4cXFMZFFpMlM0WWtadXptdjJlbS9DbFNXdFJWRHRx?=
 =?utf-8?B?eWZxSnE2WFl1Y0xPcTFjaENtRkN6VU1UbTVCakZ3RUhQRmExUTdMeTc3djQ5?=
 =?utf-8?B?QVNPMzhmNDBidmRkaVJTKzczU25lV0RDNVV1Y2xDekpKdEdpZllhVlVGVTlZ?=
 =?utf-8?B?a21YUmswRDFzQzc0eHFFbVZpK3FDNGxRV1VqSzBOWmFoSHJhOWdWaUtFTG11?=
 =?utf-8?B?WTBHRnF5UWhKa254WDRjV0k1bUxvUEpZRjVpSGVqODN3TDBtNVAwVkQ0RFhm?=
 =?utf-8?B?K0ErZ3V1aUcvelFrZnNQMzg5bVJhL2xDY3owUVNRTXUvMUlUK3FSN3JVdWlH?=
 =?utf-8?B?eEtOY3pGdWRFaWRmLzJCUFlUNnJZdGtseGxydnZ2WGRMNGNXYVFIdC9zRk1q?=
 =?utf-8?B?NDhES0F3eHRTa0lleXRJd0pKSk5JdEJ3Z2xLTWQvaEY3NnZzbU93UXpLMjZ3?=
 =?utf-8?B?OGIyMm9ML1dZUHhsaU90aEV3bEdVN0F6TzZxZ0dLS3RqK1pESDNqR2txQTVj?=
 =?utf-8?B?enFpbW9lT1NWMWJkZloyT0JPL3ZhU2xFcmpwd2lKL08rNmphU3pvZ3pOM1E4?=
 =?utf-8?B?L2ZOS3o4aEdZOG1LV1Y2NFV0WStvcTVWM29iclFVeTluekppTzNjemszNGFp?=
 =?utf-8?B?YnNDWWFCd0pJSXArRTBESnFOai96V0Z1WUlodkxROGZFdnF1NXVaRGFESE82?=
 =?utf-8?Q?n3srRc4TDHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFN2cHFvaE9MbURJVDBDVGZVUUorb1MvVWZlWkNjemhJc2hnZFJzQk5oM283?=
 =?utf-8?B?cm1wRzgvWllFT2c5TWtGREJwWWpmR3g0WWFYVFNyOFJHTjllNURIRktOUGZC?=
 =?utf-8?B?VDQ5VjZ2c0FnVWZMV29KMFJmbVduT1hQNTJzVWJCZ0d4NWtlLzY3T3RFZWJU?=
 =?utf-8?B?SDI2bjR6NkNKMEpielZtOW8xQjlMUVhIeVMxT1VTdVgydXZKTFF3dlpWc1l6?=
 =?utf-8?B?RWZDakZlemFMblRGUHNMSFBteXlGMlp2a0VPOWdNUXIwaEtxd3NBUTBPOTFT?=
 =?utf-8?B?SVRDbzB3SmlsdFA4WWpTWlJWTWVCcjRqNmowVW55dkpVVFF5RmszUGpRblBq?=
 =?utf-8?B?MTBTQnZsQ0lhK2dKci82Sjd0Sy9DY29hMk8wcVh2Vk9vZTQ2MjN0Wk9mL1RK?=
 =?utf-8?B?N1ZINlZmelBkTzlDNW5hQXJvdktVTWQzWFNUSzdSZnRUNDJlbXQrU2ovNW1R?=
 =?utf-8?B?S3J3em55eisySjF1Zmp1cWMrbUk4QlAvVnVOT1RKOTBYelZuaUlibU50Uy9I?=
 =?utf-8?B?VUx5bFlOb3o5ZWZlL1NJRzdnTk1Gak5jZ01ZaEYxcER5a3MvUUdzYkk2TG9I?=
 =?utf-8?B?eUlLTEtZb0lnZ3ZXZXpTVFlJNTdrNFVlalRBQ0lkMDc3dmF5aXFzUmdCeFo0?=
 =?utf-8?B?NWsxOThLK280cDUvK1pmWnRTYUU0MWFVUDJPWEZhZHZoTW5HRGpCanMyWEJQ?=
 =?utf-8?B?Skh0NDEvZkRhTGx2blNwS3QvZ01WV2N6eUNXdjZvVHYwWXRnVWJhKzlRUjBm?=
 =?utf-8?B?QVZRaTdjSml0Vk9KUnQ0TkNFak9UQkc5eUdTRThiT0NNak44cjZoSGh5MEJt?=
 =?utf-8?B?a1lEWGQ4UWt4QXYzc0kwYTR0UXFNWk1xSUZvSm00QUVwWHpXaFNCTld0MlNw?=
 =?utf-8?B?bG43R3N3dk1QZXZiem1sNG5vNGdVbE9WRmY0K1BUUEFmeFZocC9JaVFNUW4z?=
 =?utf-8?B?Tjl6alV3Z1d2VHd0VHVNVGVHWnhhanFvT1p2SVdjZlMvclBndkRaNlA5cUFI?=
 =?utf-8?B?T1ZvSFdPWkJ5Nyt2NzhFV2dzSUI3dytpTGRqUXdIOEVvdEROTzhidGpjalVw?=
 =?utf-8?B?bENwUXZpVlVwQnBIYk4ySU8vVnIweG96MlpEK0FNQWFzZFROYnlXVlRCMm9r?=
 =?utf-8?B?bmdVVWtqaHBVcEViMWFBVnlSTzIvTDBiMkJMVngwVDJqMWhXcHY3cDNrM1Bu?=
 =?utf-8?B?Vi9UQ2kvcXMrd1lCUk1ud1ZrWWptOXA3SEhVMkhJSUNEZGwyWjUxOHVXMzZT?=
 =?utf-8?B?NklUS0g2RTdEdTd3bE1jZHBqc09sRk52TktPdjFBTlJmRXJFbVRVTDdDWTVn?=
 =?utf-8?B?U1BqVC8wdW1zL1FuSEpxNDJYYnlYK3o2TS9ENnJoQkFVMVBuS2FFWDhUeWxR?=
 =?utf-8?B?MjRNaGI3UkZ5ZUllVU1vUHY4NlJXWEppYnFZMXJxcUJsMUUxczdYRW94dVBo?=
 =?utf-8?B?MXArQ2x3djg0SHczelNnVXpRZjV0bHQwellFTTlPM054NzE1aG1sV2E3L01C?=
 =?utf-8?B?ZU51bU1uV1JEalF4akQ2UEEvUy9jRy9yYisvbUxDR2lQdmNDanZkSm9TNU1W?=
 =?utf-8?B?UjRrZ0ZSUGl1WHE5Snh6eWY0MmU1NDRBa1RuUkhZU0pyMmhzdUhVQXVtZHBs?=
 =?utf-8?B?M0t6R2gweDdtSmsvMjlWQVMrUmxLRmpFcHNzMHMyQWJSQ2tUaWJWRjduZ2Mx?=
 =?utf-8?B?WVhtN21QalhZNG5sM1B4bFVDdHN5SGhqSWdDUjdMMkNXR0FlR255NURDZ0kz?=
 =?utf-8?B?MzFYSGxPdjNIV1kzT2pwaU5weVN1cmlRNmI4eXZwNFQyK1VXRk9ZaytDZ3M3?=
 =?utf-8?B?aDdKZ3lxd1hpTnZuMW1nQWNsR1piVWRKUUF0eEozUDQwb1BIdTJvdnpoaTh4?=
 =?utf-8?B?eW1sZE51TWZBcGhITG0xa3UvR200VHJ6b3JUc0hZdlVYeW9QdmdBT1RTTjRF?=
 =?utf-8?B?T3lXalkxakV0c1pUY3R5MXJqUmx6dithc1J5aXBlOEg1ZDV5elBLclYrc3J3?=
 =?utf-8?B?bDJmVVEycFlUK1JGYUI2R3pXZTF1eTZ5amxyaHVNYTFNUmRxMjNUd25UN0Qx?=
 =?utf-8?B?bExGRTI2dEttZHg2T2JXNTlMKzdCVlVROUtheUFISE9ZSUlER055dTdicUJk?=
 =?utf-8?B?NUt1SnZ4M2Vqcmw5Wi81bW8ranpRSGVJWVd2OTN6SW5nbld0aERlMU5sZzl0?=
 =?utf-8?Q?k7jxk47vkS3MBgVqZbzx8VEDBCJITV7u3n+cUpr0niBo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e85eb19-1935-4f64-460e-08ddb3f0d8a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:01:56.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PbMxyAVj845aBhEfNXOmXmYN84zQQS5JS8syNngWQVOvFmROpkUh7+e1+IaoG727uLLMGfS0BBH7REK22WNQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819


On 13/06/2025 14:22, Andrew Lunn wrote:
>>> So you can definitively say, PTP does actually work? You have ptp4l
>>> running with older kernels and DT blob, and it has sync to a grand
>>> master?
>>
>> So no I can't say that and I have not done any testing with PTP to be clear.
>> However, the problem I see, is that because the driver defines the name as
>> 'ptp-ref', if we were to update both the device-tree and the driver now to
>> use the expected name 'ptp_ref', then and older device-tree will no longer
>> work with the new driver regardless of the PTP because the
>> devm_clk_bulk_get() in tegra_mgbe_probe() will fail.
>>
>> I guess we could check to see if 'ptp-ref' or 'ptp_ref' is present during
>> the tegra_mgbe_probe() and then update the mgbe_clks array as necessary.
> 
> Lets just consider for the moment, that it never worked.
> 
> If we change the device tree to the expected 'ptp_ref', some devices
> actually start working. None regress, because none ever worked. We can
> also get the DT change added to stable, so older devices start
> working. We keep the code nice and clean, no special case.
> 
> Now, lets consider the case some devices do actually work. How are
> they working? Must it be the fallback? The ptp-ref clock is actually
> turned on, and if the ptp-ref clock and the main clock tick at the
> same rate, ptp would work. I _guess_, if the main clock and the
> ptp-ref clock tick at different rates, you get something from the ptp
> hardware, but it probably does not get sync with a grand master, or if
> it does, the jitter is high etc. So in effect it is still broken.
> 
> Can somebody with the datasheet actually determine where ptp-ref clock
> comes from? Is it just a gated main clock? Is it from a pin?

Looking at the datasheet, this is a pin to the controller and sourced 
from an external clock.

> If it does actually work, can we cause a regression by renaming the
> clock in DT? I _guess_ so, if the DT also has the clock wrong. So it
> is a fixed-clock, and that fixed clock has the wrong frequency set. It
> is not used at the moment, so being wrong does not matter. But when we
> start using it, things break. Is this possible? I don't know, i've not
> looked at the DT.
> 
> Before we decide how to fix this, we need a proper understanding of
> what is actually broken/works.

AFAIK we have never tested PTP with this driver on this device. So the 
risk of breaking something is low for this device.

Jon

-- 
nvpublic


