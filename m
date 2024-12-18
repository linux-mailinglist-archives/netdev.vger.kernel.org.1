Return-Path: <netdev+bounces-152844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983BA9F5FB3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4E16DB24
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC616DECB;
	Wed, 18 Dec 2024 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="du1aUdSG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C645005;
	Wed, 18 Dec 2024 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508482; cv=fail; b=a9Xc9MphDLOoy4dxTS4HZduYzd1VpArIA56E1xZBLFWY2cLPstC9GXc4G3tGxFJiTstSFGlmY6ydEWY0zmXRSv3Wxt8SVfvM0PlIlV4NCb1cDU656cAp+93Vcyg/UwxvtAFtaUDS2xFfM0+IsIxGUVfOhKeFRpEPHfELqUGld0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508482; c=relaxed/simple;
	bh=bMNebzEt2JgsPyGnTD0D7Oysr9bFp5qOEQiwLxfE7A8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DZkIOl91/rrjPsbRf5qUGpBza2WTWi5e2qrfZ/WOcmusLqDL3FWLzyHUsZN0oetsnkZYMt4srW990aH1Ype0wNZgl2J5daoDlF/aSyh084GC7q1q8eb+O2t381n5L3bTe+P3tBTuwbp9AyYyUzCNhcSonkRPFvoqxSce57H+t8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=du1aUdSG; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPcisS7+U0r0AjTrZMTEA+rHOGzBlPR7cITDCqiaa56kjyKW/+BO5QAPng0UzcMSippZ/TPrefIiHB1FnlSrA43hSujFtEz4nUzTuI7rhnCN4YupjOJonyyA/gtTZxI2E7WwohyVN+iNNJtLIr/pOAdFqP0WYymoT9dXj542HDQcCd05Jf8Ohe9B/fuuD568XXh9o8FfGvg9f8orwPTpsVZg+p+l5j6jIpz0fmZEDumtwVWbNpSyhp68bsFQ8vuldefkDjUHHivyEbYglXtbYxk60R0ooOWJWtx37MFFdEB2+wwTdegyq/OQfy4deygp+yrbkSRbG84uyfPaf9P4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQRX1qXKLeuOE9ICd8AThoQRcBA4wx8UuCU47Z8NWY4=;
 b=jzSgeV2jwUKyo4VB+k9zQkG5qA+qNmU9bni0Yi0dvDlo249HDvFMqp3zC8/CEMUFVHgqqanU05xJiVxoovkvofU5hPabGwo5T1cuWhuFhM+J70g80grZoPMEa4iRrk5QmfkCIJcUiRcAdkQWAMTJAf/Qr+46CZNLQbINARjW1bAC/GE/ycOU3ZzPNLrey/K4HOn2AldWdjd8RJCa0XWuM1MZZ0rU/3TnGW3RKtpD4DxxwNNte2oF32sVkMXLlLHdFSo2c4hdSPtslJAUBTrWECAee+tdVoSxfcLqrzXcq4WyxpTX0jqugHFZ9WfRoAAQ6+484n6e4bnw30M4Ev+lVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQRX1qXKLeuOE9ICd8AThoQRcBA4wx8UuCU47Z8NWY4=;
 b=du1aUdSGesNHPKlJ8jgfdN40AhAt+6PqfWL8oDftlUKl0QgozwHLS4/6RnyQ/oLNRkuWjaZR7BItZ04FHQhNwBTftqs5Tvh7mqpzZ9A5i5DSimYYb24MSSCzr9giz9dyA3B4fFoUoifrx3/kSAbPwfOFZng/nV+aK7r/TdFDOj7Sm68UsVwdAuIC4vXEWV8Jg9qPkASjKLcDQh2lFjqnw0QRtWVQUq1HLVR7oeU90wnA/fc0bcUMqlqmh4m/m7frgrHz4xAK4efdXY510Z7K6iEQc6NQ29MyhDedujUgYO1owk+2cfXV7RF2uawkjA/o/hCdpyc1i1skjdFVu8eRFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 07:54:36 +0000
Received: from IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41]) by IA1PR12MB7496.namprd12.prod.outlook.com
 ([fe80::8a53:2522:9d01:ec41%4]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 07:54:35 +0000
Message-ID: <7590f546-4021-4602-9252-0d525de35b52@nvidia.com>
Date: Wed, 18 Dec 2024 09:54:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] percpu: Cast percpu pointer in PERCPU_PTR() via
 unsigned long
To: Uros Bizjak <ubizjak@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241021080856.48746-1-ubizjak@gmail.com>
 <20241021080856.48746-3-ubizjak@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241021080856.48746-3-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To IA1PR12MB7496.namprd12.prod.outlook.com
 (2603:10b6:208:418::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7496:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: b93821d8-a089-4dfc-5fb9-08dd1f3936b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXgxdGlPUmFzVXA0WEl1VEdOSEoxakJRb2xKMjlEK0h3TUtkaGlGV0dCMnZx?=
 =?utf-8?B?dmR4Zk4xeEF2eFk0dTVaTmdzMWgvWFAvZG83T042eWtZZnVYM1JadUlGYUpx?=
 =?utf-8?B?Y2FBQWUyREI0R0JVdTZuUXBnRlc1WW1kSTJNZTN5TzNHT3kvdVFnci9zQXBo?=
 =?utf-8?B?eWcvbC9IbURwbkRzYVFEMU9UaDZXenhQRUdMUjQ3QkEvWWEzSEUrVTJ6aTl2?=
 =?utf-8?B?d29SMXRRbVNOMWw2OVNJVzFzMEV5LzZoVkZTbjc1d3lZQmdsT1RjVXNSV0Vi?=
 =?utf-8?B?Sk42akhsV0hDa1Z3WVZGNjZkRlJIRTRZRGZJYnVOV0lQMGV4WkdKekVqdytZ?=
 =?utf-8?B?MVFvczNOSXptWC8wMVl5cndlWjRob0FLaThMelB1TVVPRnNBMWZtRjdpT2Uy?=
 =?utf-8?B?RHlZQk9VWEgrS2dNM29WNE5HRTB3TFh4azhzOHVISEJPUTZmUzZjazF4NzBI?=
 =?utf-8?B?UWliRS9QYmF4VEJaWTh0NnZya2FOOWU2WGhxT2dUaFM5RFg0eVlMZ1U5dEN0?=
 =?utf-8?B?MkRLQkUxYTUza29XZTBWOUFjdlZuRytxNUQ4NnVKbDhNQU9SRUhjcEw0UVV0?=
 =?utf-8?B?WUdMa3BmN3dHcEhRMGVqUlczWGZvM1B2V2Nub1B5dGpFSUhyUVhCVnl5cHJZ?=
 =?utf-8?B?T1lNaVd3V2ZYSzVZUVRnTFB4dUdNb001TmpsckUyeE9peU9tdzAxN05KTDUr?=
 =?utf-8?B?YjVQNWFkN1BDK2NoTVU2dUlDN2tvYVlEZGY0c09GVkhEenN0TEh2QWxnVTdu?=
 =?utf-8?B?MEpMdGxNZ0RxU3NVY2NIYU9KZjlLdkJtRzMvRWR1TVNxbmE4SmdnVGM0d1Np?=
 =?utf-8?B?WHB1Q3llUWU3c1BGb2paN1pFSWhkWUIyRjN0Zk1PQnpyTE1XcHJKNy90cTV3?=
 =?utf-8?B?UkszbTBUNzhyRXNwM0UrNlpON2lBZ1Q1ZlREUnhQTW5QdFFoOG52aXp0OUwy?=
 =?utf-8?B?ck9SdW9NT1RyQUtSbXhlNlY3dDJYZXpFajNma3cxaGNkWkE3TUFSdERMSEZz?=
 =?utf-8?B?NDJuNUFPZjYycEczTlIrQno4cU1DSW5reDYyVzIzdXl5TnZDeEZ2OFpsWkdB?=
 =?utf-8?B?RnV4bmdwTGEvSXNTMW5mQUxjNGpaZlZxcllXb1A0UlN2ZWcvWm40UGZ4T1li?=
 =?utf-8?B?eDM1bnFtRml4M2diN3hvYkdybDRuM20rNnM1WEFuS0FVcUkwYWpLZkdVSUxz?=
 =?utf-8?B?OEQxekhVTVg3Z1gwUTJhVGpUT1Z6TTJ6K3YwZmJKbG14ejBNUWZnanRmMTZ1?=
 =?utf-8?B?S0ZGWSttVlNtZUFlVWZvS0V0b2VudnNMTEFNUXM5UE4weXAxL0ZVSitqMHdL?=
 =?utf-8?B?UmViY1VLQTd0c2YyWW5Oc2IrandmRElEazU2aCtyYU5KYmhYQ3JEWVhtMDJR?=
 =?utf-8?B?L2Mvd01PZXFlUC83SFhvNStlMVJmeHFaWnF5LzBNeTJ0NmNsZTlqZ0xPSUxD?=
 =?utf-8?B?KzBFVFlpVW1Ya3VRK2YwSzBNTCt4QVlhTjZTTkxLc29hY2Z2V2hYOVNsR0tX?=
 =?utf-8?B?NUpKRmlCUmRYakJZMzR5cWNLTDNLb2xIb00rNjJIMEo5VnVQVXFyY254L2lz?=
 =?utf-8?B?UXZ3Nm4veFkvaGIzbWtDVkk5NDVwbXB2YnI4VmRTUm8zZW9rcWQvaWc5N1lK?=
 =?utf-8?B?RWo2NWxlakJnRFdaQVlUU0h2VXFPTlVMaFdmV2ZxSDlSL3RaVENOSUIzOUpC?=
 =?utf-8?B?WUVyK2M3ZzdLV2hFc2g5TGx2amoxdFU0Skgxc1ZXaGZlQnIrenMwbUpuMkUw?=
 =?utf-8?B?emtVSGVSVUVRUm1yZHBUWnd0YUJzdStwcTVnRGpCcVNtNFBuMmRxdjhHVlFj?=
 =?utf-8?B?Sm42eVZUZUdOd3VBeS9hTEprMW9ISkMrNENpS3JKWmVOamtNVktsQ3VxY0Zk?=
 =?utf-8?Q?m8hKIdYjruNkq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7496.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U20vYlBpeDZQeHBMMmVOTTFrR1BuTUNiYnJkaGxzSXFJY3ZWcDV2S004VCtn?=
 =?utf-8?B?KzRGVklmV054aWpWODVEWWFqektYRUtsUkFldG01eDd5YXJzL0o5cThlajUy?=
 =?utf-8?B?bjhaUktnRm5DeHRWbklkSlJPeVJsZTFBemtxVG0vWE9tSGh6NXpYTmRBOXNW?=
 =?utf-8?B?TENsc3FMbWtMdVpkbWdpTFV2dGJ3RkFpbjlHbXZKUGg2UW9xK20yNTRRSGdW?=
 =?utf-8?B?TmJZdXQ0dS93VGxDa3llYWcyU0l6Zzg0NDh4M1hXSk5nYUZCUzFxb1dQM3Yv?=
 =?utf-8?B?L1RaR05lUHJvYy9ITFUwaDQvenV6a2xWR21hWDUxKzdxWXFiTzBKRXllODdp?=
 =?utf-8?B?K2tBUFhML2xnOUJ6ekszd3BFeWs5R3dCVWEvR0xaNkFGeVNwY1Z1VmlSL2tN?=
 =?utf-8?B?ckZENG9xM2FMOUNkck9ETWRoTU41Y3pvanZzTzNIcTRRWUg2OFJjZWxHL0V4?=
 =?utf-8?B?ZGtOODZXM0lwYXFnYklMN0VZREZqa1dhalNsbk5LempiYk1ZdHFiMmZDT1Jq?=
 =?utf-8?B?dUJVNDZnaEhuRUhSRUN0ZUVmb0tDQ2tab2RxdWVRalo3RUc3OVIzVExWWkNr?=
 =?utf-8?B?VFMwTjJiOGQ3bGJSQ2hLVm9jSHRLRkRaUzVKa0d6cGZtdUVxdS8zY2psUFdN?=
 =?utf-8?B?c0RjY0hSckRVRVp0SHdrZnpMdGpOdWNEYmJzV3h0UFM3QUliUk1oOHE4YWU2?=
 =?utf-8?B?OU1pNzdRWHRHQk4xTXBNazdyejZocjRMbzZuc3cwTGlPa0FZbFlpMkxLbnFn?=
 =?utf-8?B?RE9ja3ZTSDhYQWFvT3d2eXhZeUdOSzdlQlhZTWF6dUNFWkhTUTV2VUYyRzdw?=
 =?utf-8?B?dWxjdU9hRHArYzdEeUxXTmc5TGdTY0Z2QXp2dHBQKy85QW9yTGROdk4zaHBV?=
 =?utf-8?B?bW5aZzZBb0F5TEVFZFJ0ZGpRQWVoTUdPSnFRZTdwaC9FN2ZGdE44YmRzb2NG?=
 =?utf-8?B?aGpDT2ltWUhxYStKSmlFbHRBczBDRE5oTkxRM0FSd0MySFFtcHg1ZFdOTlNU?=
 =?utf-8?B?bjAyNFdOeFFicThPbnZ1YWtpOVplRFdHQkRwZk8rd3dieHl6OGZzbkRmWlpp?=
 =?utf-8?B?eTM0OUxJdnNncDkzVXNEdldPLzRPenJqbmt6VDI2MW1PQ21oU29oMnRMd2Qw?=
 =?utf-8?B?bCtvaS95U2VaYTRFWFJNUGx4dllud1hOZ1IvU1hXT1RETTZPWHFHdjgyRTkr?=
 =?utf-8?B?TTlmbXFYOWtjbVNOYkZ0RCsrVGozY2lybnI5ejY2MkV5TGxPTmQxcERsQVlm?=
 =?utf-8?B?S01ta2RXcUwrS1k5OU16VmNyZ2dUYjFjaTllNHRyZEpkT3FVMFJBVzVGZlJO?=
 =?utf-8?B?OE1Yem9kUmxrdGpnTFR1UHozSGNqVCsxc0s5VzZXcTZlT2tubTc1UUNaOCtj?=
 =?utf-8?B?bm9ROHlORXhjQjlmT2xZSFNPWlljc3p0VTlHZW12V0pybTRyTWZrWU13TUJE?=
 =?utf-8?B?ZXEzQ1R0RktGUmNQZlhlUGhha0YzR01KNHR1SkJydHErTWwvRllYVDNBQWwy?=
 =?utf-8?B?SnpCVmVHLzFsK2NrVXFFT1pCUXVWSDNDTDk2WGg0SU50S0MvZVhybmdVMDND?=
 =?utf-8?B?ZVVLdWtwZGVtY05WUklSd0hvdG54Zk92UnhUWUo4Z1VLZ1N6eDNVWkhFLzBB?=
 =?utf-8?B?RWF5SVY5QXJqVTlUQkFnS2Irb2c1SXJtdFIrUE1iRlZPblQ0OGphaXdEdzhU?=
 =?utf-8?B?bWkya0tqbTNMem5CVWZCR3FjN0xIQkFSL1k2TU5FZ0pXV2JDTVdzSWFnT1RJ?=
 =?utf-8?B?WnJ1dFl1S3lwd2YvS1RKY2YxMC90S08xeUFMc25JMEpRNnR4cU5XRE5HWUFm?=
 =?utf-8?B?SndFQkxEc3g5ZXB5MnlnbTBnUVYxMGVPallENk1hU2dnSnhCS2pjTHU4YlBr?=
 =?utf-8?B?bm9FMVNGWm50TUoxZTJxSllEZGRISUcwbWNCRHViZHh3eG9XbE5uWTZHSHVu?=
 =?utf-8?B?OEpUTHJVKy9OMERsYjZvWDYyZHY5NnBJa2g2R2Q0Szd5WnJrOHlISVRtcGFX?=
 =?utf-8?B?aGtoSkRKR0tIbTFSN3NCaDdGWmRjNy80RUY1aUZmRXdEUGFXZExEQlY5dSta?=
 =?utf-8?B?UW1pZWg4T20yOExIeUFPMHcxTVF1dTl6SzRHV0JtcHpLckxyT252ZkQ2aGJ5?=
 =?utf-8?Q?KG5hASR8EpxdFVsziK9gHKKgE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93821d8-a089-4dfc-5fb9-08dd1f3936b2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 07:54:35.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI7Bd7Tcuz0PWY+njopquCVfLU6KSqhrkWRYJhG64844rAcr9hxzk+pVKrFImjM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743

On 21/10/2024 11:07, Uros Bizjak wrote:
> Cast pointer from percpu address space to generic (kernel) address
> space in PERCPU_PTR() macro via unsigned long intermediate cast [1].
> This intermediate cast is also required to avoid build failure
> when GCC's strict named address space checks for x86 targets [2]
> are enabled.
> 
> Found by GCC's named address space checks.
> 
> [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name
> [2] https://gcc.gnu.org/onlinedocs/gcc/Named-Address-Spaces.html#x86-Named-Address-Spaces
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/percpu-defs.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index e1cf7982424f..35842d1e3879 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -221,7 +221,10 @@ do {									\
>  } while (0)
>  
>  #define PERCPU_PTR(__p)							\
> -	(typeof(*(__p)) __force __kernel *)(__p);
> +({									\
> +	unsigned long __pcpu_ptr = (__force unsigned long)(__p);	\
> +	(typeof(*(__p)) __force __kernel *)(__pcpu_ptr);		\
> +})
>  
>  #ifdef CONFIG_SMP
>  

Hello Uros,

We've encountered a kernel panic on boot [1] bisected to this patch.
I believe the patch is fine and the issue is caused by a compiler bug.
The panic reproduces when compiling the kernel with gcc 11.3.1, but does
not reproduce with latest gcc/clang.

I have a patch that workarounds the issue by ditching the intermediate
variable and does the casting in a single line. Will that be enough to
solve the sparse/build issues?
Do you have anything else in mind?

Thanks

[1]

 [   46.055628] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN
 [   46.057809] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 [   46.059429] CPU: 0 UID: 0 PID: 547 Comm: iptables Not tainted 6.13.0-rc1_external_tested-master #1
 [   46.061243] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [   46.063453] RIP: 0010:nf_ct_netns_do_get+0x139/0x540
 [   46.064513] Code: 03 00 00 48 81 c4 88 00 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4d 8d 75 08 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 27 03 00 00 41 8b 45 08 83 c0
 [   46.068081] RSP: 0018:ffff888116df75e8 EFLAGS: 00010207
 [   46.069186] RAX: dffffc0000000000 RBX: 1ffff11022dbeebe RCX: ffffffff839a2382
 [   46.070662] RDX: 0000000000000003 RSI: 0000000000000008 RDI: ffff88842ec46d10
 [   46.072086] RBP: 0000000000000002 R08: 0000000000000000 R09: fffffbfff0b0860c
 [   46.073513] R10: ffff888116df75e8 R11: 0000000000000001 R12: ffffffff879d6a80
 [   46.075021] R13: 0000000000000016 R14: 000000000000001e R15: ffff888116df7908
 [   46.076447] FS:  00007fba01646740(0000) GS:ffff88842ec00000(0000) knlGS:0000000000000000
 [   46.078159] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [   46.079353] CR2: 000055bd901800d8 CR3: 00000001205f0003 CR4: 0000000000172eb0
 [   46.080772] Call Trace:
 [   46.081417]  <TASK>
 [   46.082014]  ? die_addr+0x3d/0xa0
 [   46.082855]  ? exc_general_protection+0x144/0x220
 [   46.083893]  ? asm_exc_general_protection+0x22/0x30
 [   46.084934]  ? __mutex_lock+0x2c2/0x1d70
 [   46.085859]  ? nf_ct_netns_do_get+0x139/0x540
 [   46.086858]  ? nf_ct_netns_do_get+0xb5/0x540
 [   46.087812]  ? net_generic+0x1f0/0x1f0
 [   46.088663]  ? __create_object+0x5e/0x80
 [   46.089559]  xt_check_target+0x1f0/0x930
 [   46.090520]  ? textify_hooks.constprop.0+0x110/0x110
 [   46.091581]  ? pcpu_alloc_noprof+0x7cd/0xcf0
 [   46.092535]  ? xt_find_target+0x148/0x1e0
 [   46.093434]  find_check_entry.constprop.0+0x6c0/0x920
 [   46.094582]  ? get_info+0x380/0x380
 [   46.095408]  ? __virt_addr_valid+0x1df/0x3b0
 [   46.096363]  ? kasan_quarantine_put+0xe3/0x200
 [   46.097341]  ? kfree+0x13e/0x3d0
 [   46.098171]  ? translate_table+0xaf5/0x1750
 [   46.099114]  translate_table+0xbd8/0x1750
 [   46.100021]  ? ipt_unregister_table_exit+0x30/0x30
 [   46.101047]  ? __might_fault+0xbb/0x170
 [   46.101937]  do_ipt_set_ctl+0x408/0x1340
 [   46.102856]  ? nf_sockopt_find.constprop.0+0x17b/0x1f0
 [   46.103943]  ? lock_downgrade+0x680/0x680
 [   46.104849]  ? lockdep_hardirqs_on_prepare+0x284/0x400
 [   46.105973]  ? ipt_register_table+0x440/0x440
 [   46.106978]  ? bit_wait_timeout+0x160/0x160
 [   46.107916]  nf_setsockopt+0x6f/0xd0
 [   46.108745]  raw_setsockopt+0x7e/0x200
 [   46.109608]  ? raw_bind+0x590/0x590
 [   46.110462]  ? do_user_addr_fault+0x812/0xd20
 [   46.111425]  do_sock_setsockopt+0x1e2/0x3f0
 [   46.112360]  ? move_addr_to_user+0x90/0x90
 [   46.113279]  ? lock_downgrade+0x680/0x680
 [   46.114225]  __sys_setsockopt+0x9e/0x100
 [   46.115420]  __x64_sys_setsockopt+0xb9/0x150
 [   46.116413]  ? do_syscall_64+0x33/0x140
 [   46.117296]  do_syscall_64+0x6d/0x140
 [   46.118194]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [   46.119289] RIP: 0033:0x7fba015134ce
 [   46.120129] Code: 0f 1f 40 00 48 8b 15 59 69 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b1 0f 1f 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 21
 [   46.123951] RSP: 002b:00007ffd9de6f388 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
 [   46.125530] RAX: ffffffffffffffda RBX: 000055bd9017f490 RCX: 00007fba015134ce
 [   46.127088] RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000004
 [   46.128503] RBP: 0000000000000500 R08: 0000000000000560 R09: 0000000000000052
 [   46.129920] R10: 000055bd901800e0 R11: 0000000000000246 R12: 000055bd90180140
 [   46.131445] R13: 000055bd901800e0 R14: 000055bd9017f498 R15: 000055bd9017ff10
 [   46.133422]  </TASK>
 [   46.134351] Modules linked in: xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay zram zsmalloc mlx4_ib mlx4_en mlx4_core rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi fuse ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_core
 [   46.140665] ---[ end trace 0000000000000000 ]---

