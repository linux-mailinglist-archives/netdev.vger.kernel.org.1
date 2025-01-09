Return-Path: <netdev+bounces-156568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1DBA07095
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203F51662F8
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448A214A6A;
	Thu,  9 Jan 2025 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+uZIDNk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973F1F4E32;
	Thu,  9 Jan 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413235; cv=fail; b=u/RIGbfobNq7a6yJrLUxn1vT/QfS/Y9f4EAENVKAHqJ6BG5UKSSdnnsW8FpKrlF2mOBUkgtp5nr2XZhIILkRWIlWy0dAATctDe2fGaizr0yU2QC4ds9pExHMII2rY7qKm3Ahh4B/6aDK20ekIxKTmrVjg4qVzLg4iIdyFwAqLHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413235; c=relaxed/simple;
	bh=Q8aAFtMy1m9b7ZYKqVJOrqT2QLAJo5YpIADsWeHQMp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oWnU/fxkX1AzzWwYwyli2/qy5/jbDksxpHIzRbuePEhPh/996ijr9+fHqC2Rd3EtaTLaWtvRStB0Wo26YzDhFul1w0xZ4nysQiEaQdDeHEF99eKZzCzimfBXjWbcvkyiOb2dwFS6bgQnfBXDlj4I/wblTOv3fVN2EiwDlckBXJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+uZIDNk; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5BymDnOLqBgFOvC1BZv/TpkU+AEpZubmYOOW20XVimGjITVE8737kIpN0ycJnJO7UmL6nihNVwkE7VwEbLkGp/HMQ9dD4JS7HvOj/qAdIniXQpFumAIaMALgKPyGX5/bU0+waWy+3Kk2LXFuiQbfwfM2Rkrb94+SMhLISTc3IZWifWSzfoiTsrpSaORfGF/wVvqveMphAMr4MHCMiS4+ZM6Tn7EZQTTPS06JZmseLCWFqMsJsVR7BcSTH0vIi0C+Q6QjlBP2dASp0rmsNydBVh6GpKZj/5wH0/UJ+fPRwGOfUaXxN4r/DimZIjUgKxviGnsZi7E83/lx2hDBJRGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3PVme52DjPmLyStzuzR38CRzJBbNq26wDrcGxT4Hjw=;
 b=jkNYsA2HrFNkl2qGeG7BBDNlMQZ0arTA2DXsaSWKIJKf3CpppENt6lbNccl+fRaRf+BgALO4cpRPAQHCUN6YjrcJcg6ZUmQx6JXebOTiF42OD5kFNeTNsru9oeXfjMV9oANG/n64bOPSAqm2CWwbo5rukkUvZaL9zRP3b8sea2Zg1p91qqCI4nQUQJ2ZVR3hebNje599YHTkX3Rj9+NxmGsPQ86qCEOvufvJQ0cvC8SMVqHku4I/35PhuR2mFGiFTe91XQcUo49+E40M6LTr1TrS2GLQd05AGQa3X18eCrExiYjrfpCJSgY2XddPSZ3rf/G/dEqmQtjUCks/0dTBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3PVme52DjPmLyStzuzR38CRzJBbNq26wDrcGxT4Hjw=;
 b=G+uZIDNkzFpY63hmkmDztJEgfj49gFCVclNU3GxkfhJPCsy2kkXCfOxCANJLTOqmN0hih5JU1FKoKnZULyAtK7PfBNuLruf1wsuw0HrKZ75VvO0FiLATQWSERypTeFPaGcM/NPx3jOLyI75IehPbt1g6MnW/ZIMP+67NjnJjkTMTAzqyxYfJO0cKgHQ1SbcJGNPpQ+/fvTmDm5XQZxUZdZcFGMedSwlmHufjXnhf1tKtg2akpSrxvIIlKy6kMYRh4/0wQS+7UFk/IR/3mvD2MBr8HJL9oQH/BGTnQUFo44PI0rpndmOdIJuPLDvjhKGptPbhP519+DrXTGdxd+BMLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 09:00:31 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 09:00:31 +0000
Message-ID: <35791134-6c58-4cc4-a6ab-2965dce9cd4b@nvidia.com>
Date: Thu, 9 Jan 2025 11:00:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Silence false field-spanning write warning
 in ip_tunnel_info_opts_set() memcpy
To: Kees Cook <kees@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-hardening@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20250107165509.3008505-1-gal@nvidia.com>
 <53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0014.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::15) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: ec569730-7e1b-4b65-1e9d-08dd308c11e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak1veUtLU3NZa0VuWmhGbFE2MmY3bjY0RDg0alRUQjIyWENtdWw3V3dUb2Z0?=
 =?utf-8?B?aWh0VFp6OUdMNlRZTmJqamFHeGtvV2dxblhtcVUxR2tIamQrWWZyWkRhdURT?=
 =?utf-8?B?VWFpUHYrSTU3aDV1MTBtRXQ3cDFDbnRmZC9YUFg2TXJCYjU5bXYrajFHaU1M?=
 =?utf-8?B?OFJBSzhrd3A0OXBpa1E2THFML3NEN2lOVjZuaXdYZUUycGp1K0g1Zk5LR2Ji?=
 =?utf-8?B?M1Q2UjA1WUhDTUgvLzJ5TlJWZS9iand6eTVQMU03R3dlaC9LckppN2J4OUYw?=
 =?utf-8?B?UDhhRUMrbVdIR3hkOWRuNDBpMlJnaVA5UFN3MjhSU1FHMGVQNHJmVGxDVGs4?=
 =?utf-8?B?VE14dVQwNjNvYTVTaDZCTFlQNGNlaDRjSDNxV0NDaUdEMk9KRHdabzNud2FS?=
 =?utf-8?B?MVBLRDd3WW1KNEh6Q0xsMnFhUnJXWVhYVmlPOHFOKzdKUUlRVFFGTUtiTW1N?=
 =?utf-8?B?aHNhYThTdGpUbForZFg3Vm1naFV1cEE2QXF5Vkpibkl5TDF2NlRRKy9zZmdl?=
 =?utf-8?B?aE8zbTQ2ZHJOdU5pRXRNSXBNRXNicm5UcnVBVjU2M0pJMXpaVlVoNTlQRVZo?=
 =?utf-8?B?ZmtRQUdwZEgxaDEzVW1IeTlnOHVtM05scUxEZ0VLUHdkVEx2eE51RkI2ZG0v?=
 =?utf-8?B?bURlMnl1UUJmUURmQ2hFblBMelc1V1VaVWtXazZvYzhSRXNSL1prWGRzZlhV?=
 =?utf-8?B?Sk9Nald6VUkvZ055dEdLdHY4d2s1ZkNMWHZiMFdvK0RvTG5JUW93MzdMa2tS?=
 =?utf-8?B?Wmw2dzMxNXRKc25IZFZ3cGQzSjhvM243WlU0K1JueDhIelpuR3Bnd0plb3RV?=
 =?utf-8?B?QVpsWFB4dzRJYjVvM3NzV0QrSk5rTlJ1UDcxWEFtZmwxaUZhUVA2ZjVhS3lH?=
 =?utf-8?B?a25QNlpNbU8zcktUTWlMTTJlc29wWmliWVRldXFmc0JCOEI5UjVqSkdvaFha?=
 =?utf-8?B?SGxLeENlbDFmcmRuTG4wUmpkbUI2UDRjQjZUdWNkeGRMeWNIY1QyNyswZTJQ?=
 =?utf-8?B?elNqbk1DRG5QUVFjZzlLMHpoVFNZNXQ3T0N1MmtrQWJDOXF6N0l4eTlXSXZh?=
 =?utf-8?B?YmpiNjBIVGJIY2pBYkFCVDl2ZWM3RVA3OW10SmdsSDFHRjBoQ1N2WU1zc2M2?=
 =?utf-8?B?MFJzQXFpQkxHSEhqSC9zSlZvaE1pRk1JREg2cUZkaUNhdit6QVRFb0orM1Ju?=
 =?utf-8?B?c3VoOXlLVmRWUmVKODRMS3ZZZzltSStoR2Jlc3Nwdm16ei90ZFVNbER1bFFK?=
 =?utf-8?B?NXJMVnlEaWI3ZEFZTDQyMWduSEpFeWFGS1pzL0MwUGNMdVd0WXR3U2dlVVNK?=
 =?utf-8?B?WEtFV2EvU1pRN2JydUhqb01NVG5UMzJaZkxJeU1PUk1YRHVvOFJGQTFHL3BJ?=
 =?utf-8?B?T0RXUTVKb0JaMzRRYVROTFBSVVAwTWxrMStjbCtPa05KOW1pTXRsL2xZcVJL?=
 =?utf-8?B?RjYzR2ZXRzFlNG5SMGIwU21CRUM0aFNwVHl1dTVJZnFvcXF3dkEzZWlRNTBS?=
 =?utf-8?B?UlZ2L1k1SnVNOFN1MFVpb2tJK2w1WnlIQkthSmRmT3pTbHVacTBEc1MvZnJE?=
 =?utf-8?B?cHd4aGs4Z0NrMzJ0dVpJWkE5V0FEaUdRUnIvek5LN29raGQ5cys2NDBmMDgv?=
 =?utf-8?B?VVBMZDh4SnhMbklXSTJLTWU2a1dTUzBuVlZRUHNVWmdzMVU5bW9BVjF5U29u?=
 =?utf-8?B?NkdVOFpVMDdyQjJkbnpDaUIwbEhCQ0t3d2pwbVI5ekUvUSt5R2U0cGU1aWYz?=
 =?utf-8?B?ejZVZDJPcThJZWExKy80aUI1Q0ptUFk2aS95TjQrdlM1emZHVDhuRytRUmtp?=
 =?utf-8?B?aXdNYVlaVUN4WkxhNTZ2dWFGY1ltQXdKSzhZU3BnK0J6ck5UemFOQUsyMXNX?=
 =?utf-8?Q?xJ9Dc1lrt0iiO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjIvM01mLzhpK0p6QnVJUWptcU03WStmOTg0eUlOQlpJWGoxOEpycXcwZjA5?=
 =?utf-8?B?MjFyb3V6Umluc0xDZE1mcmhBcFdIcXZaNmpmWHp0ZzIySTFyOE5jTXVseVFB?=
 =?utf-8?B?dnJScFlLY0pmRDJocnN3dW03L3VQWEtGVExHV1I2R0RzUyt4aUxDaDk5cXdi?=
 =?utf-8?B?VE5GLzl6cm1GS1UrS1lkYjUzV1JtOTJ4Zm5ZdlM2cklrSUV5Tlo2UGVtMmVt?=
 =?utf-8?B?WE9OUlFRdTNJZ21MaUxEZHFhOHJXWGNtUmY3b1VCMUdHN0ticVhQcFZvOFNm?=
 =?utf-8?B?Z2pYeFlyVlZrMzFZUm1UdDBRNEpoMTE0NFowNVFibGNBZDBETk03R2JBSWRx?=
 =?utf-8?B?NWw2aCtGMVdDZGI2SCtBS1Rxd1VYcDJGTytVZHdrYnBEYThzMm16WUlpVnBQ?=
 =?utf-8?B?T0pvRUxTaWtFTHQ2aTI5eTJERW5FamFleFBVUGRxdloraHF3THF5UkxtRDRp?=
 =?utf-8?B?YmQrMk1sUHlueDMxNnhVWURheEUwWEJwek1NaW94UllNeFFrczlpZUZPVFp2?=
 =?utf-8?B?TTNJZzlYaTFRZUNyMmRRVmd4ODhaN2NteTdHdExDRExNMlpDNFRHaDZtdFA2?=
 =?utf-8?B?ZFBjMHM4MjYzOEdRaEZHbG5pZVhpNldEVlJaOVd6SWsvZmdrMGc4M0J2QzB5?=
 =?utf-8?B?bGppSFpLd0JTYUFaT2JpWTRGMlhXbnUwQ1h5V3J5cGdDd1Nrd2g1c1ZXa3F4?=
 =?utf-8?B?WkNGL0dnTXVrRHlRVThzUW5kYVNDR2ptS3FvZy9iRU96YXM4VTlrNHJUeTNQ?=
 =?utf-8?B?bU5QNVZiMDloOXU0WHlNd2FsRUd4Z3hpVUg5Q0Zlb0pYVDFqNjBML1NVMThS?=
 =?utf-8?B?SjR3cjBtT25HSGtFQU9MZUtseGVWWXdWbkQwcFlydHE2SnYwZ3pXN1FOclhE?=
 =?utf-8?B?MFE4eU9TY3RYMkZPKzNJQ01tNTVQRExnaTNRc0RMeHVYWFA0b1BTM3JwTFVJ?=
 =?utf-8?B?UE1uSTZUM3hPUlRNREFYNmQxeUpvOFliZmk4aTV3ODNVbzZuSk1JUTExdXg5?=
 =?utf-8?B?VnhRZTlFM1ROSVNtUkdqRmM5bE5lS3hRek5zTmFaV2FMVjRsaEdqeXFwRjRu?=
 =?utf-8?B?VnltLy9jbkFGZGppWWwyUzY5MjJ1MWFVTUQrYW41ZmxUc1lWRnJXS0hRUk43?=
 =?utf-8?B?R0cyaXdNRGhWSlFEejNxMnZSOEt5cGU2OEIzNmlPUDZSdkp6K0JzMnpmUC9S?=
 =?utf-8?B?T0ptY3RXeE1HbGFtM3kvaVpVRE50dHNFNGtGUzJ6V0xKeXhtS3d6M0RnZXJx?=
 =?utf-8?B?YzV6bFpiamxKZDVUZ1NRSnBFVlpSd0ZkcCszNWZteUhmOXZOVk5ReVV0bWpo?=
 =?utf-8?B?bXdGWjh2T0tkbk9UU1lOcUt1Y3pmb0d0RDZSREpKSU9QRDlJblMxcytFT3o2?=
 =?utf-8?B?ZC81T3lKTjFJUGM5Z241dFJ6emdIYVNPb1p5MkFJT3Q3Q0VTUTJDcWFWRW9G?=
 =?utf-8?B?akRRSncycGsrRk9waTdSSDY0VmxPaDl6NlltcGttVk9kc1dyYzRDMTZjc2wv?=
 =?utf-8?B?cXVaUWVaM2hMTmRjRmtUYnYvTFBITDlFNmtMckZqSEF2cW55UkZZbzdGaUl0?=
 =?utf-8?B?ZVdOVnNaaTJZRGZsMjRHRThvT1FXVDBWT0szZyt0bTRqTkhnaDVXa210YkJH?=
 =?utf-8?B?TXdDSEFqYnp4SWJwU1prSm9ab3dIRTNoS3B5RmVIWWxYaFc5OVltZFBBcjJX?=
 =?utf-8?B?bCttRHNBVVkxaUF5Vi9PMldEbkFwbGJTZkZNeGc1eUpsSGJBaDNmRjEzNkVw?=
 =?utf-8?B?K3RzYmluSDRiZFJrR1NIMytxRHdtb3ZhOEMzaFhLMzJnUG9HSDNDdU9obzRx?=
 =?utf-8?B?QTZCL0VJMWZKTFl2emhFNGtmaFUrUGsyaWZDd1hmNGZDR1M3QjBNczNEUFNs?=
 =?utf-8?B?ejcvVEJnTjRCTUJVR05HZkx0NEs3Rjg1Q3VaeTFrV1FUT0JOM3hESlBNOEdT?=
 =?utf-8?B?aXVWUnI2K2JVVHZWTDdvNFQ3OFFVMGFSMTVYMFlwbFNodms3dmdLTnNrUWxK?=
 =?utf-8?B?THdHOTNGS0pPcDd6Q0swYTE1bkRCOEd0S2tIREd6U0NYTFptNWY1TCtuanF2?=
 =?utf-8?B?TU9teWkzdHl0QVNWOXlCTjlBRlY5NDFsajhGUnlRaERaWG5kNlZxdXNxWXlx?=
 =?utf-8?Q?TzeCOCrf+2lq8AwGoVrQSqeI3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec569730-7e1b-4b65-1e9d-08dd308c11e5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 09:00:31.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZCnKeIEgl80/IUkBLQ06eOm8TrniJgdzesvid6FDmlI0Owm+cArdivK8OCWjAFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171

On 08/01/2025 1:28, Kees Cook wrote:
>> This resolves the following warning:
>>  memcpy: detected field-spanning write (size 8) of single field "_Generic(info, const struct ip_tunnel_info * : ((const void *)((info) + 1)), struct ip_tunnel_info * : ((void *)((info) + 1)) )" at include/net/ip_tunnels.h:662 (size 0)
> 
> Then you can drop this macro and just use: info->options
> 
> Looks like you'd need to do it for all the types in struct metadata_dst, but at least you could stop hiding it from the compiler. :)

Can you please explain the "do it for all the types in struct
metadata_dst" part?
AFAICT, struct ip_tunnel_info is the only one that's extendable, I don't
think others need to be modified.

