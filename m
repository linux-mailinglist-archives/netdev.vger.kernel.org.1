Return-Path: <netdev+bounces-112232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B99937880
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889A5B21CC1
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F935143881;
	Fri, 19 Jul 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iRcc0I28"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5913E3F6;
	Fri, 19 Jul 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395655; cv=fail; b=Szr3CwOhzbvDYqGfq5gSS3v2nvk1498D6gTee38kk88Uovbf/ysCcZlDfHVID47mM+yuZDrx/Yyb2hJStZBG9LlocqXYp5chudQ0LqkrAMeb49xsaQCrHUFJ5pt1G++U3mS8HzwF255SYcRcFud34PTDBEms+CyRyX2uaZvDcCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395655; c=relaxed/simple;
	bh=iU1vm13hOCIhN9UHCtXlVHEHt98Roo+trKqzPr+crsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FfEDnhEdkU1dm01uuExobB3dVI2qkG2xOqsEhfdo++tmZXiN0JqnB/i2YpGdnngaOt7eAdNIfCi3cKpwhfZNJZVOnaXwjfODci+DWA5Rvm1o4xb1VWrlu7c9BblUsldkwHQprMwF8c8mu7dUzaI8uWiF+IgDmDPP0zjZVtgMW44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iRcc0I28; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8oZfKPWPf8bLGFEOpBFLi602Z8TZP9aWHTv8XZq+D53mUe39rl8GmZwgx8o9bF/WPXOLIgplGAr1xEi1RKS/wXrMNlK+OKIlWzS489+UgsbLzWv1DRK2BI0ILRmr7RKvx2708D3ogxwb2pgCbIyO5P5gNc+Z6NHQzGZxHD8JjxpbQ0/4998MoXDcQxFw3XQwyIjodNF7dOy4Z0YqOLDsrHq8YZNUWd9pKL5LxW2uBnbwRbMJyzwsbs8wHtSecrNwCGzdRER8ZevApceS1wVbj5SeonGxjte5zH/lU5CvhbfmAvoO63Iz7iSNIt2Bs39h5Bkbgs9KSDRkyD0qsC7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/pUoQmP8YjxR68HeXP1HrWDx+O9anOlqv8fMUkEPV4=;
 b=indNZAvwnisxCjmrwfPw4H7DJ7mB42QfH2FAZdaA6ILIizCrcJOZIYodO6+TuJLS001JP2sBZZL/ByuFqNkhMA3VHileP0eBm7fi9PQ34neAfwa/RCJyjCKuC4x/2Y2NfWV86rXcVCJBb78Gy7i8/jx+phb+NAq0mqD1iKaIDe7zeTEUyqm6zRMVl3vL1FOyNOik9nZqvlXEAC2MRia8MO5DLiyk0LH9nI1bKgO+JnuJLN+CYrlVwdJmWTBYFF62K/BN/lHe2AjDb39o7nkAOG8UUeXMNC/R/0VxjAjmvf5KPilwQOGivfRD6VRl9rhLR/b9h/rr5/OJ4FkEntxc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/pUoQmP8YjxR68HeXP1HrWDx+O9anOlqv8fMUkEPV4=;
 b=iRcc0I2836HIbeoDwdUcTxhZm8GZPfKUPMgtofV4KU88DvVss583/znjbAQS37tkLpUgqirC+EegBtszgL5g0MZbabd150hNCNGxkcGB/ZDfP99iKulbzCjcP3mZXZMxEao/JNS/ZNjEbkQ1R0kqhctu+pwftlzOapdRPp7V72U/5+BABs3nIN1VWyV08/AP55/oY0cOQautylCvOn2mWV6BRPNx14XXvuPb8mvCuCrfef7aKFM5w1xnhnKrdafx04eGqXqhAXwUIDrs6VNE5ZFa0jo20tCxuG1BgLuwejrnHT1G9f8T+H9M9Z1J2HtBwKmqZZlyJ22b5zy6gWjX4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Fri, 19 Jul 2024 13:27:30 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 13:27:29 +0000
Message-ID: <bb949d68-3229-45b8-964c-54ccf812f6f8@nvidia.com>
Date: Fri, 19 Jul 2024 14:27:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Revanth Kumar Uppala <ruppala@nvidia.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
 <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d42b3b-963f-4447-e701-08dca7f689bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVBCNEQrWjRCeXI5ZVhOekdhc0lpNWk5RW5KUEI0T3FkRlJSNGRNd1VSWlBz?=
 =?utf-8?B?UjlvWmM5VFJ2Zk5GMFgyZFlEQVNjRVdyY1hHY3lLVHpPMGVtZmFmY0VnM2lK?=
 =?utf-8?B?MHJlek56bGR1V1pEYU1oMmRaNVN0U1owQ2VqSzZkMzVOTkdpTmZZMVR2OHFK?=
 =?utf-8?B?SWU1S0xzVHA2QlJ4SlM5WUpSNWJGN2VsQjRFb21ucDZkY0VvTlVmYkZxU2N6?=
 =?utf-8?B?cnJadzA1djdtTVhYVFdZdWRWWWFaSkliRWR5SjVWN0ZKK0cyV1VoZ1JqVi9K?=
 =?utf-8?B?RkpWaExqQlRvVEh2dUlsR0xCcm9leG5hT3NjUFZhZEJiM1hPVkRGQXdCU3hC?=
 =?utf-8?B?SHB5OHhYbmx5MmlMc1lDSnhUcUhXcmFxYXZ4djNWaTdEWnpxYVl6NWNOdXVG?=
 =?utf-8?B?MlFmUU0wZi9aYXN0bUFwSGliY3pTN3A3YWNReEtuVjJzY1pndUN2SDJWcUFi?=
 =?utf-8?B?ZVc5dFd4VW1tdTF1eUtYUjZzTUxjVnlKamlocnNGL3lmLzZ6dStVNnlCcUdU?=
 =?utf-8?B?N1VzVlgzdGR6QzducVFRWTRCMGhXMTRVMXRENUo5bDZSODgzWFlJT3NsSXAx?=
 =?utf-8?B?TFRhTHV1K21VT2dSNXdqSlNVeTVuVzQ3VE1pZyt2RWE4RmhlUU1NMVJ5REw3?=
 =?utf-8?B?bThMWkVkeUNZK1h2YlAxakZkS05LSWJadGtMVWxzM2tFbE00SFIxeDlFVmJy?=
 =?utf-8?B?Z2xYUmwwUE1kREx6YXY0dnhGVHhkSUo0a25selZpT0UzbHRXQkxOM2tBRldr?=
 =?utf-8?B?aVliRzFnc3VYS1p0REg0b3JIQUIrdG1nWlNoWml4Q21jMngzdHpYOGVwZnV0?=
 =?utf-8?B?bTJuWUN4bEUyRDdDKzdVMDl3bElkS2pFTXU4VmNRRElrOFJhcVlBeXpGUUd4?=
 =?utf-8?B?VEZRY3JUOTdGOGdTdzEvWHVKRkJ1WEkwYjUyMi9XZXBkOEJwNzRzZFpvTEJF?=
 =?utf-8?B?Z3BTK0hBY0I2MkZKeEFaVCszcERJa0JZR2xLTzFIc0N0ckpzME5zK0s4SjV3?=
 =?utf-8?B?dkpGd0dXR2FDdk85Ni9JcENuVkZFZkZ3cDlJYmd1aFdIcWdKNEl5d2M5dGds?=
 =?utf-8?B?UzNBaGZUeGlBT09tVFhiWEUrMnVCalN5cmRua3NiekJNTDAwMzNxaUtyRTRU?=
 =?utf-8?B?RElEV29WZHdTTDVSOVhJMFdROEJNcFB3ZkgrUURZNHFGNmlTRGdLTG5UckVy?=
 =?utf-8?B?VkxOaVpFaUFDQzhqS2RXYy9uQTBPOXNHOXZpMW1Ba2VJUGdEcG9xbTdkS3pH?=
 =?utf-8?B?REdBdXRlWHMyZFFzaU1uNFZWNkZOY0VBeVhRYytPc1dHNU55WFdZaENHLzlO?=
 =?utf-8?B?ZzRFaTd2Qm0wcHppYUxyWmhWUWwvQ2kvVTNOUmhnNDA4UlRIYThlMWlFMkJ6?=
 =?utf-8?B?V1RaK3V0UUdDWGJoWFBIcUxBR21COUR4TjBCQ3dFbUVselJuK3F1NWtpZS9K?=
 =?utf-8?B?Z2Y3N3RSVWVrUzNmN1gxbDRVcEtkcFZuT0RMbDkvQ0dYUllwRnhYUUlCVmtE?=
 =?utf-8?B?OWVRa0xUa3ZwR0lyZWhCK2xCRSt3Q2hPSDZJMnZ3ak9hYkdiUjBCKzZENGNm?=
 =?utf-8?B?dHNxdGJxaW1IWUswdjEzMWFNSkJaR1Fna2xUVllKK3pmQmx0RWh5VEJIYnZX?=
 =?utf-8?B?ZXE5Ry81Tml4akFHSWNvRG8xQ3ozU0NLL2NiZ3Y5QzFQZktpeXRMRW1ESXV6?=
 =?utf-8?B?dVoxOFZRYXIvWDJGNGl0MVNqcmRhMHN6VUx1M0kwTWNTcnVqcGZGaG9SME9Z?=
 =?utf-8?B?dHpKdDR1YzBLZDJmbm0vb2ZRMnNuWDFxeHVtTmgyVTljMzM3N3VudXlISlAy?=
 =?utf-8?B?YWo4ck1KMjV4SDc0RXlEdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXl3dGd3T0RDSDFwQnVpeGNoM3FPRmp2TmY1WjJWU3ZYMFZ0M2NaZnlBd0dD?=
 =?utf-8?B?MVR1Qld1dFc2U2Ixb3NUcFJwQWhObkRVdUJ2ZUdWWVo4blJvRUtJWDZ3b1I1?=
 =?utf-8?B?eXVEeGxuVTRYNzJnaUZnaDR0YWZFSit5a3FSN3dOYjhTaWp1TUcyaWxINi9q?=
 =?utf-8?B?emJrOU5pOWh2YzRFa3c5ZTY3VUdYZXNCejJSQWdZVjNiRW0yS05tbzBnK2Mz?=
 =?utf-8?B?ZE9QOXM1Q0JCdlFOTk10am13V1NoRkxCQTFrb3dQQWlOb1FZWklzbjhmemJO?=
 =?utf-8?B?dEZScmdSVEtjaXMvRXkzbEtrb3RYYWVnZmpPWTdOSnNHVDlrV2w4UHkrRXJp?=
 =?utf-8?B?OUZ1WTcwZFptMjBwaTk4OEpnS3RnOGRxalJBejNNaVFrdzJ5VVJWQkwrbTdV?=
 =?utf-8?B?NUJoMlFxam1uYXZQMzU3MzdMV3J5Wkd6UFViNkZxTnZVakNWdjFrYlowLzRT?=
 =?utf-8?B?MDZPOFVOZUErdmtoSFpoZXZ0a0FTN1BlelRySzRhWlE2TC9ZNENtVEpjd2tl?=
 =?utf-8?B?bzhVMHNQTHM1L2Y0U2dWQVYwRlhpZ1JLN2tiQ1dNRFNQTlJxb3BPZVhrVG9p?=
 =?utf-8?B?K25vempCdVp1bmdGZlpuSGl3b0JxUllkQzMvcFlLcDIvM0RrbExDYlg0ZFd1?=
 =?utf-8?B?NDA1S0JuRVF0Wmp5SEFLL0wrUVRMOTRpOWR5TktQbGN3cEttazZnRzZsQ1JM?=
 =?utf-8?B?aDJTQTBtMy8wUUp4citLWjNjMHhHL2ttcnZkWkhtcncrNXB5aWs3NkErV2Vt?=
 =?utf-8?B?MEozbWtKNUt5ZFRsdFY1MUVpem1Ed3pxWUVIZTRxNXpjNTdJSXdsZlZldURU?=
 =?utf-8?B?UkU0a1RheHBCaW9mT3RzYjhWaFg3UUF4NmkyQmVXTkVnZ3c0dmJQaS9Gc0ho?=
 =?utf-8?B?aVFxR244Y3gyaVNTL3NSLzBNQndyS2hDL0gxNDBQNEx3Q3dQT0Q3RzlSVFhT?=
 =?utf-8?B?MWhYbDBMSnlkZG5vLzlmZHFlS2hDQjc0My9yN1FaR1VSUWNDekQxMFNsOGxR?=
 =?utf-8?B?UGFQaUlIRFI5bkpUclBpYTBDTDNJWTAxTmVjOG5vWXR0SERlbjczYy9McVBH?=
 =?utf-8?B?aFpZN1lsZFNqSDlianRBeFo3WmFUSnlrNTYxSjJ6aHhITUsrei9GUXI5WlFG?=
 =?utf-8?B?cGI4L01SM09qWEkzV1NrWGs0Z3lyN0Q1aGlTNVZsV2FJYVBoY2kyeVN3SzNp?=
 =?utf-8?B?UzJGdkNUV2szZXExV0M4UUJWYXNZbHQ4azRYRFpnUm9pNE10cVJ5RXlVOC9r?=
 =?utf-8?B?YnN2c0ZjWVJ5MllwU0lteFZZeXcxdFNFM2NBZHV0Kzh6Tm5VSVJySlNmQXk0?=
 =?utf-8?B?L2t2RldRa3pFREp0K28rQTVmVGltRk1FVVFLVWczZlc5a3M0bzRJTjdtM2JR?=
 =?utf-8?B?ZEI5VTVqNFc5V0pTNCtxOHVLY2gxUzN4dFQ2K0JxTTdMYmtMaERLdDczZklP?=
 =?utf-8?B?bkRjRzlSdmZJb2tYWTlrUDYxSWhBK3I3UFhtNFhIam1OekNDM3NwM3JMelQz?=
 =?utf-8?B?K1BzQThPOE4walFqbUw4Y1lOL2pZM3FaMzlXZGI1MHJlcXpaNG9mRmdkRk84?=
 =?utf-8?B?L3VtKzRpZkI1NnNqVjBpZ1ZsWVFKS254SXVxUm1RdnRvSFFSMEFid1FFQW5C?=
 =?utf-8?B?NWd1VUc0ZUttYTYwelJvbThJSFY4YlFqQktkRUI4K2h5aGc3bzJ1bjdieVV1?=
 =?utf-8?B?S1VkVUJsZG9GR1ViZzJSOVNnT05RTm9nUWNQVW5jUG5hdXlwTjBLR0pvcFBH?=
 =?utf-8?B?Qkh1QStuRWxHekJLTGNOanRQMzBLQnhIM2JDakhGY1g3QnQ1RURNNXpTZ1g3?=
 =?utf-8?B?eTVaUGJqVkpQTjdMRTJqZmhrVHRRaThKL2NTQ05MdkNJblhjTmRPd3lxSVF4?=
 =?utf-8?B?UnJyMThBbDk0NGRkdTJoTStrTkNaY3RLYkdmRGI2L2F0SC84eit6MVMvMVlS?=
 =?utf-8?B?WmJFa3ZzdjZDNHJZN2lLekdqZHZTSFEvZ2JHbnVkMmhIdUw1L3FFMTNuODJy?=
 =?utf-8?B?VjNybnVZYUgrOWs3bzNWbFRueVlpU2MrOTUwa05OdHlQek1QMCt3Z0hybTh3?=
 =?utf-8?B?TzdtMTEyNUFxL0g0WlJueDh4ZHRxNnY2VllYU250eWRUT1pBaXZ2bGFlMyto?=
 =?utf-8?B?RU5Mc2dMQTJDTHFmVHBPelVabk9sd2Y5Y0FkanJsSlJ1Ri9FeGN0UmRZUkZa?=
 =?utf-8?B?SStzOEZFQ2l2Q3hEWithU251S0ZGSEhkVURKVVR0amZUdUJlUVJuRkRnOEZK?=
 =?utf-8?B?QWgzZDg0czVCWm05SkhFMzErVlZnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d42b3b-963f-4447-e701-08dca7f689bd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 13:27:29.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8F6wbHzpcTp2J05iaNVaC5w3s7Nuub2XijsrqPIJ1Lh1p5t1hWUqwNWVrmAxGIRN1q5mG+xXEFILMplZiD6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487

Hi Russell,

On 24/07/2023 12:57, Russell King (Oracle) wrote:
> On Mon, Jul 24, 2023 at 11:29:33AM +0000, Revanth Kumar Uppala wrote:
>>> -----Original Message-----
>>> From: Russell King <linux@armlinux.org.uk>
>>> Sent: Wednesday, June 28, 2023 7:04 PM
>>> To: Revanth Kumar Uppala <ruppala@nvidia.com>
>>> Cc: andrew@lunn.ch; hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
>>> tegra@vger.kernel.org
>>> Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system side
>>>
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Jun 28, 2023 at 06:13:25PM +0530, Revanth Kumar Uppala wrote:
>>>> +     /* Lane bring-up failures are seen during interface up, as interface
>>>> +      * speed settings are configured while the PHY is still initializing.
>>>> +      * To resolve this, poll until PHY system side interface gets ready
>>>> +      * and the interface speed settings are configured.
>>>> +      */
>>>> +     ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
>>> MDIO_PHYXS_VEND_IF_STATUS,
>>>> +                                     val, (val & MDIO_PHYXS_VEND_IF_STATUS_TX_READY),
>>>> +                                     20000, 2000000, false);
>>>
>>> What does this actually mean when the condition succeeds? Does it mean that
>>> the system interface is now fully configured (but may or may not have link)?
>> Yes, your understanding is correct.
>> It means that the system interface is now fully configured and has the link.
> 
> As you indicate that it also indicates that the system interface has
> link, then you leave me no option but to NAK this patch, sorry. The
> reason is:
> 
>>> ... If it doesn't succeed because the system
>>> interface doesn't have link, then that would be very bad, because _this_ function
>>> needs to return so the MAC side can then be configured to gain link with the PHY
>>> with the appropriate link parameters.
> 
> Essentially, if the PHY changes its host interface because the media
> side has changed, we *need* the read_status() function to succeed, tell
> us that the link is up, and what the parameters are for the media side
> link _and_ the host side interface.
> 
> At this point, if the PHY has changed its host-side interface, then the
> link with the host MAC will be _down_ because the MAC driver is not yet
> aware of the new parameters for the link. read_status() has to succeed
> and report the new parameters to the MAC so that the MAC (or phylink)
> can reconfigure the MAC and PCS for the PHY's new operating mode.
> 
> Sorry, but NAK.


Apologies for not following up before on this and now that is has been a 
year I am not sure if it is even appropriate to dig this up as opposed 
to starting a new thread completely.

However, I want to resume this conversation because we have found that 
this change does resolve a long-standing issue where we occasionally see 
our ethernet controller fail to get an IP address.

I understand that your objection to the above change is that (per 
Revanth's feedback) this change assumes interface has the link. However, 
looking at the aqr107_read_status() function where this change is made 
the function has the following ...

static int aqr107_read_status(struct phy_device *phydev)
{
         int val, ret;

         ret = aqr_read_status(phydev);
         if (ret)
                 return ret;

         if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
                 return 0;


So my understanding is that if we don't have the link, then the above 
test will return before we attempt to poll the TX ready status. If that 
is the case, then would the change being proposed be OK?

If you prefer we re-send and restart the discussion again, versus 
reviving a dead thread, that's fine and I will do just that.

Thanks
Jon

-- 
nvpublic

