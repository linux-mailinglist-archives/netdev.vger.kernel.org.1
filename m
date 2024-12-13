Return-Path: <netdev+bounces-151672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498B89F0850
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8072F188BD8A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF61AE01B;
	Fri, 13 Dec 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wxjugumv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E261AE005;
	Fri, 13 Dec 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083173; cv=fail; b=DXgz2LMJsPIhAeiSKUFy+YwfxBnMjaufL+Aea8kV+z609FDFctM1glgjeniFtSVUGWWVSo53ijwwq3E/ALcAdPVNgxv5qTHG64VR9x6W03eRefSht2YY3CtJiIiGiybHf5qfxPAeLJiYEhQDMHlT2s2vVvB5JLCe1jyJFDpCOxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083173; c=relaxed/simple;
	bh=He5TvtnDlXfrJ288PRmtp49DLYyIYUoPcqaslRgaxDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q18bPQjUjHFtERagJMzSIgkxBJnL3QTjweeeUScjvrMPNx0UFYM57fHiDpTQuMQea5Xy8qrAeCVlAzi7U5T9jQq/F784mWV2Wb34ORXo7a5sPSjngAKoi5r2LC0ez88yf+sBoSCsqoG9HaDe2DRe2Aiu3TJVfpypXfo9Z6sYOEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wxjugumv; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT4RJpQK0NsUXS0flj0/ea6NRQcwXfEQM0T5/2eaz4cD08OJN3CD9hj6U3xkdKYKGEoYn4B79Flwq+INzpldmoKjHuj8Yy+ZH6KyvsFphLf01ZbiZwA2z7fAnnyFfxIszSatCbL8PA6pmBkerJG6P9cgZ1LmnWjSzAt6wHe6ECfegW0DH97O61LrHNTzdyR7e7TTO8D8yhLD6Zhg/wZHK1TutO+Ihfa7AMCokZbLALDZZEe0OGSszNPWmxIs1CBk8+hvxkkEnJm7OJcgtFYbD4jiNUZUPQvOH1nbkPtSqPP1mfawv7juxlEhuXpJ4rekgYUPeL1r33D5vgHw1APBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOpQL7UIGZllFkio55jqY4IWrjt4Vlsprb/AS336HEQ=;
 b=qGdJ9jzZhbkYGcqWKeTda0Rg7XvywdT+wff3F8YTVLQTAJm/RgvtzuOHv7fL/ftcZYSeeDMa4Kbl2l9xmSQ2ENj/TmHu+0lE2bLtf/9ZaZYjcjqOAvM/B9oa2b9IDj0rb9qMwraFZjQgFsX8jdoKrKQYcJZAviFVg4UYa/yBWh9LWSt+9z+li/wbTPDAhf1hOuB6nSjnbMsbQLAOLfDR/XsB51XisGCSa2B3DdLnzUyPzY51VTtBBP7PJ5UyKNnbJnX+Oj20BZSNFg2jEud5089Ehll50A42NngKwOn8P1C6zbFZGUcTRdUob3bQE8soXYGh2ujMK1NlsvV9qfsFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOpQL7UIGZllFkio55jqY4IWrjt4Vlsprb/AS336HEQ=;
 b=wxjugumvegIDoofZars9aN0Tdpm9Pg4A+fTpM5GUtAJK6HABfJai/tbMxWQuug6jIl2TQZoB2+ommLGgLaRDWuUCg6RVpvS3jw/dOHwKTiAcwNw6Dxb1RKu1QgFSqcrl5GM+gpREvzPa8ijFPDBi3gORV00cQWbxMR6jQL6av8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 09:46:09 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 09:46:09 +0000
Message-ID: <bfaa3a15-84af-3384-6be4-bb883164d3ae@amd.com>
Date: Fri, 13 Dec 2024 09:46:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 23/28] sfc: create cxl region
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-24-alejandro.lucero-palau@amd.com>
 <20241212182933.GB2110@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241212182933.GB2110@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: d228b5c7-998a-43c9-a665-08dd1b5af88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW5hNUhUTGNZY0xNRWFrUFVOakR0WDVKS3pCczg4bTFpbzFBQkxMWHdLYUVR?=
 =?utf-8?B?bHRkWDJ0bWJyVFVJck5KK2hHdkI1M3lBd21kaldUN2JhZUZ1V1dJZU1NMy9h?=
 =?utf-8?B?Rmh0K0NqcVplM0N1UE16RnFxV0hGblNxdTdrbGRod254V1FRRTRFeWY5RjFF?=
 =?utf-8?B?TVYydWoveXFUY2RkeERmNnpkQzNLNUZZVHZscy9rTzdqbXp5KzZNRnhkVzdJ?=
 =?utf-8?B?L09RQktVbVovSTRoK09pb3pGSnRkamhFeXZvZEhtMWJ6R2JBckt1RVhrQ3M4?=
 =?utf-8?B?R1BCU0pjOU1Db0NuclhHQ0k5K1BoV1V4b0tTcVl3cG1COXRlbHpDOUJkOVJB?=
 =?utf-8?B?d0FncmNGNlpEcmRPUnRCL1A2VGJjNTc2WFF2QWxOV3hXR2JNRHA0V040UkdR?=
 =?utf-8?B?R1FiSjMrbWEvMTllYVA4K0lFd3Y4VExndjVDUENBdGdxNG9lWGkzL2N5V09y?=
 =?utf-8?B?RUd2ZjBETDZlVWxOd0hidUkwcHB1SmxsTmJudnlLcjg0MGNGNUppQ1hEN3l3?=
 =?utf-8?B?RlRkMUR3blh2NXRuRW9lazlhUUREWi9FbmtpN1psTysrV3BYZms1WGQrY1I0?=
 =?utf-8?B?U0cvbVlUL2Y1ZjF3dDNoTWVHVk1ucEJvamFkSVpLbjVWaDV6VXlvcGdKbE1m?=
 =?utf-8?B?TDBheWpqM0QxQURwY3Zjc0JSVUFFangrcytHL1lEL1hYWk5HZ0tQNm95RjIy?=
 =?utf-8?B?bFlUcUd2WTBYbWtBYktmUURyOG1FbkVITnRKb211eHY0Y0lYY1Q5UHRhZlc1?=
 =?utf-8?B?MVBjRTdFQkxLUnFPTm9zWnoxajUrcmtqZXdpd2VNOWI0QVZzSXN5SWdNcTk1?=
 =?utf-8?B?UEdzSHlnR0dWWEROMWJqUldnV2s5NUZacGNTTEt2NVh3UzRUWkI1dWc5c2ts?=
 =?utf-8?B?N1gxNDJPS2VXalBVb3RpaWkzWm9oV0hmOTRoQ1hBUTl0K25SWmMwNWZnOU5E?=
 =?utf-8?B?NmpNNmwrYmRIdm90aDRWOWF3Sk9McVNwOXM0MjNyeG9kMDJ4bFBmbjNsY0pS?=
 =?utf-8?B?UUZZNlRZODltMHpvOWVCRFF0ZVcwMzBnbjFyaEUwYjFkbDYxcDFnNGxMbmZp?=
 =?utf-8?B?cStnVlcyY3Vlai9pV1NzWTA3ajFIcDUzcDFWUHpQeE4zb2NLRFQxeHdVL1p0?=
 =?utf-8?B?TlM5RzBkTnNSYmRLbDJidGlKS1JqdnNzWU1KM2I1VmZCcEZLZzdXK2V0eWZ1?=
 =?utf-8?B?TFlsTU1pSmdGTkFzd3g2djBXR0RKYStZYk1kcU9IL0lXWWYwRU1RQUJLYTY3?=
 =?utf-8?B?eHM1MjNjNzJqZXY4NUdSNGpESHd4QXRMUWJCYkZmc3NvaHRIV2xzaEYvM3FV?=
 =?utf-8?B?RC8waVV1WWxMS1M4UmM5YUVXeEhYV2JKdnlEbFdPQ0kyK3JXOFVFR3BsZWNR?=
 =?utf-8?B?N2lEMDhiSDBUWG1QZnhHRGdsVU01YnBQZGpHbk1IWkdIb1VsOGJYNGRQcWpH?=
 =?utf-8?B?dFd4TENjd01XQkF6dVd6c2NpTzNNOVc2cGhCN0FXYWNmcnNSYVQxV0FyWlgv?=
 =?utf-8?B?MkVsdmkvdHBVWkY3VFRmYTc0ZlBDTk5YWU0vM0lrU2NITWdYc3NPR1pwODY0?=
 =?utf-8?B?TTJSdkxBVUsxUWxUREtRaEUwbHBZMmw0UUU5ZmZPKzl3Wk9FS0laYi9UVFN6?=
 =?utf-8?B?ZWl5MFV4N3E0SHJpWVAvaDA1MlllSVExYmdSUEQ0aldsQXJPYzFLVEF5NVk1?=
 =?utf-8?B?WURmUVpyalhhQjMxRCswVGN4TDNPaGNHNldUSVVyKzJXN3NpL1pVajJuU3Fm?=
 =?utf-8?B?Q3Q2OUlWOXQwT1NzYlVId2JEdDUwS3NjN3N2K2g4aUVoemlnZDdwbXZjUzdt?=
 =?utf-8?B?YUFJVlV1M0RvYnpVT3pjdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFxaERYcTBQa2cycmdhdUpxSUpYRXhlVG8reVYreXJSSkJDT3k3S2MzRStV?=
 =?utf-8?B?MHowazJqWU96bDJzb3EzbHUyNWg2Qmk2WXRmMDcrK1MxbWxzeW9ocWxvOXUr?=
 =?utf-8?B?SWg3Vi9aaGZZTXl2VHpYNWZVYko4aHFPVTBPekRHV2prbE5rL0JzMXRHK0JU?=
 =?utf-8?B?VzZBQnVaVWl0NHZ2UUFsMmhJaU9hZVN4ZFpqZ0FHWkNKOEFOM1FEYWhpbFNp?=
 =?utf-8?B?SnNHRHkwdHhTOThUSWI4UzlVMVdYYkNYRm1mWXpuT2c3NFQwR2E2a1UzcEIw?=
 =?utf-8?B?UzFwaHkzclAvbjF2UjFkdDJvTEk2anFTdmsyRTRPZkJMTjAvaSsrUjRGeFJT?=
 =?utf-8?B?TUdkOHkxdTJNb2tsdlZLaXBpSGE4UnptNUt3K24wY0hqUVRyVHh1dFZBNFpM?=
 =?utf-8?B?SEl6QmpobTBtenFoUmlMbmg3UXVVSExTSVBhcEJ5dktwNEFhcnpIREZPdEto?=
 =?utf-8?B?MFoxdXBDNWl5a09ycjczaFQweVpISFp3MDNFQkZVMDAzcm8vT09mTTJuRnhm?=
 =?utf-8?B?UlZUeHBCUXlSQlZkNU50Ty9yaU83QUdGcjI2MklmY1daWjJkbWV6c1RkTzA3?=
 =?utf-8?B?US9Qd2NkNUdWRUNoNTlWMzFHbTVMM29UVmcwK3FwUEY3Z2xiUCtvU29zS1dw?=
 =?utf-8?B?S0M4V1ErWWlFb0E3WmhlVjdwZ0xJLzBWampYM3BtWG11eVlPalJZL2ozUHJn?=
 =?utf-8?B?V29ZdG9pS2hnMElva21UbmRidTF0dmFQZVFkQVdmNkFXaWZ3dER6WllkMmdz?=
 =?utf-8?B?ZDVTQmtDazNhWWt3eXgxMjBZcUpsa3JJcUZSMW1GNEtaSHFFY1pYQUk4dHF3?=
 =?utf-8?B?V1RaWDIzTGFIalF1MTZMc2JOUCs5Y1IrSU9tN0FhUVZpcDI1SVRsV1BiSGxq?=
 =?utf-8?B?R1dkdkd1cjFTSENJc3NSQVplQWJRdk1vakRKNGlOeEJDTEJ6NnVac0k4VVdG?=
 =?utf-8?B?ZUlWdkEycVlDRWVITWRBd3JQZ3lzSVp5ZUxvWnhYTGRGQ3p1ejFaZk5hWTZx?=
 =?utf-8?B?Q2ljRE5ieHgrU2tFcFRRMDB6QjVTRUUzRC9keG5yNVNhVnBPQkZQajQrWnY0?=
 =?utf-8?B?Ukl1VDhYeU5hb3M4MTBMdUlrOGFTb2V3cWpqVUFPYVRWbmczNDN5Y1VLMUx0?=
 =?utf-8?B?Z1M0SFh6Nit2bjBDUXY4RStKTXZkNFRtNnlhUVZ1ZVorMnRTd1hwNUk0RXEr?=
 =?utf-8?B?UEVndTNxdU93OGJSbjZGK3RoaW02cHdiaGNxZXhUU3RkZGVRdWp3d1o0QzUv?=
 =?utf-8?B?dHJxbUZNeDVIVGZET1poRmNNMk1uVFAya0x2NFV6dDRRU0tRNWdsTWIxL0h5?=
 =?utf-8?B?emlQVGJWVnJmYmk4TTFyaVhKRnNhWVZvVjN4dXk2cjNZanpJS09HTlNsVWtV?=
 =?utf-8?B?dWFEVGVFaFIvV1AzUERKVHZIMEJnZkZKbnBML3I0MkdmQWdMVkU3akpZcUo1?=
 =?utf-8?B?WWthTmlqd3NLa2JjYmRaeVcxTVVSNDVMYlk5ZnhZc3N2c3R3YXYzZWR4RFhH?=
 =?utf-8?B?dW8zdXZ4VHFCT2FpcG94eUp6Q0lmTnNWcFpxbHQ5MUxOQVlxZ3BmVW9UTFE2?=
 =?utf-8?B?UGx3eWFWeGN0ZmNtTU5ON0FWMnFZdVNiUFJ5dGVYeldjTlR2NTRjVDUrQkJG?=
 =?utf-8?B?MVl5T0RhcmQ2MHB6ZWxueEZLVlZCTTJsWGZ5RDhhYmN6emRlNXJpOEZXR1hh?=
 =?utf-8?B?MTFhYXFqUjBCSzAvaGpBY3JqLzlWczZrb1E1SmNHcHhzbGRnTUR1SEJyaGQy?=
 =?utf-8?B?alViT3VVUUM3alFxSnhhQXBld2UxT0Q3a0hMQWFCR1RuOWt1R3FLMzJnaSt6?=
 =?utf-8?B?YTEwY3lZa2lQbStQUEhMT2h0U2g3VHh3OXZ0MkYvUG5DQ3lWRmV6UzhQVWxn?=
 =?utf-8?B?bEtQaFNkZWVDTkNqZjA0Yi9GRFAzMTBCSWxDNnZ1NE1oUzRJY1EvNWVCVmdk?=
 =?utf-8?B?amsvOXYyZjJvZ29JUUt5RHBoUmQrQW00UEZpT3U2SXF3V3VUUkhOS3JGNk8r?=
 =?utf-8?B?WFdXK1RPWnVGV2h3VXdvQUZXaUZBRkwzMzZSTkF1SFFMWTUxc1o2cXUwVFlM?=
 =?utf-8?B?N0h3TmlWNnNTUys4N252VEVvejdKQU1OU21oU2tjSFY2NmFTNDdzNmxUUlRW?=
 =?utf-8?Q?F7NJ4lO1i8PGvl1ie34rhnaEe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d228b5c7-998a-43c9-a665-08dd1b5af88f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:46:09.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM9Vbsucv8tPkcGkg1I4N/h0ptYTy/BAUB3QFaZSNT+L7voIasMY0TIIK6sPruDn5XlMMAkUQJIrldd+p9jaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972


On 12/12/24 18:29, Simon Horman wrote:
> On Mon, Dec 09, 2024 at 06:54:24PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for creating a region using the endpoint decoder related to
>> a DPA range.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 09827bb9e861..9b34795f7853 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err3;
>>   	}
>>   
>> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
>> +	if (!cxl->efx_region) {
>> +		pci_err(pci_dev, "CXL accel create region failed");
>> +		rc = PTR_ERR(cxl->efx_region);
>> +		goto err_region;
> Hi Alejandro,
>
> This is similar to my feedback on patch 18/28.
>
> Looking over the implementation of cxl_create_region it seems
> that it returns either a valid pointer or an error pointer, but
> not NULL. If so, I think the correct condition would be
> (completely untested):
>
> 	if (IS_ERR(cxl->efx_region)
>
> But if cxl->efx_region can be NULL then rc, the return value of this
> function, will be set to zero. Which doesn't seem correct given
> the error message above.


I'll fix it with the IS_ERR check which seems the proper thing to do here.


Thanks!


>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   
>> +err_region:
>> +	cxl_dpa_free(cxl->cxled);
>>   err3:
>>   	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>>   err2:
>> @@ -144,6 +153,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>>   	if (probe_data->cxl) {
>> +		cxl_accel_region_detach(probe_data->cxl->cxled);
>>   		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>>   		kfree(probe_data->cxl->cxlds);
>> -- 
>> 2.17.1
>>
>>

