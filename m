Return-Path: <netdev+bounces-208423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24EB0B55E
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 13:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275263B4D72
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8161E9B12;
	Sun, 20 Jul 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MeMoo+SY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340D3FE5
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753009784; cv=fail; b=IDzt/5rBFdDJ9T16Js5akVEdt9I71HdbndWXbVyJic+qvchGpVDwXIB+qyZZcAY4+GPE4xupbqSD9x2TDfCdpXXvFNMtis9wktxmQLX9+WvjpM3bMxBzoKaQeCyoso7w9MegdWH94z7qD9tYZs8j+5bCICbdkRySZyVoiyuFFYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753009784; c=relaxed/simple;
	bh=I52hmqb/RSQVrfGAzgtNE7aoLqq1jkyAphN9YzD+gtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u3Wi9godo1bgG1Cw0CSd6yW2kSroc/2lyGy+vOa0OlpmC3nW/9Z6P2OmYF6SBYeOm+LYFz3ywr7ivwwqrZa5PPmYbWTaky4HQa1TOo/LQ3zhemTy/DPpIouM+CQsNG0hbU0TbWYWsBgIgIh8cANhM8/ac0eoJNRhfPmRLiazoME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MeMoo+SY; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eex6+cgIzkqg4Pq3RDB3VE2XUBipYebaBkuKXzqut8BDzowgOBpZZJ7cw4SX+Uvqtiw2ycLGpEfg4VXiNrBQkpCNumIatEkmJ4aVQp33U96rMg0rY+rPJCc6m4Xnl7Qe1mF77MyzvTM7G3Nv7r9U83c7BdeM6Eo6c8ZTEhmSrzA0xLhC7DDiGH0lsJvVYZMtR9z2Lhb06RCPVB+xM6yuP6AGeHjneUqudmoMHRTmEP3MANxxJZfGmq0awCkt87vo3XqCs1gui6ifYm3QCCS7+cSI5enF/0fslvFel2HG7W3vop69jKYiVBtn3zPa80f+GBf5/dAww7WoUyaZMFuchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rueiQtvZMxqzSBHFSWn2sEq33/9s35/S67/aqDYyuQ=;
 b=q1VtcNC6w1uLHo71O5gTWixBq8aR1EbSBTUL+1Gn8dLrgovVDSUNa66CE1DrBg5UJpPQPF+u0/ydeyrjhIQLT6MhzZxGhBMYWM1cztzuh0HkewIFmbPTjb7LKhvoHmq8lsVJDqDxUKSAdN3qUnaxLX40Vdyhe5eA5PcTb4rVk1NxEaH6ZdAmgMIzpKoc3GhIvbQrPUvrwgkx3ovBbml7KDaAd0Zb4NvH/D26R7CN2Sz94SWKT6urpuub3GHvFu+NCrYsvFOe+N3AgZixHugBTiQE9MfJH5pVxgIw6IRugFiNYcF6RJGiGF1Pv3CzAjUKJzDJDc7Rbnwrg6lfPzVcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rueiQtvZMxqzSBHFSWn2sEq33/9s35/S67/aqDYyuQ=;
 b=MeMoo+SYNhJgYMtBSY2BAwSXNbBBwnA+7h62ad18JpZCup2ZoGi4ZoRMQN78ufiSZpa6m7N6kLm4QJayKJa9nWnpytoJ2Zstl5lE78N1kIQV8oBZpjB9SWDJWioHpfmf0PAt4YmC/T37CDLfQkz0UqZP9dZgq7fddNVlshCI67uBNw39pKm/fT7LgJzROteXumwpsuN4YBPw/XMAOPvbcRu3VXLE4FawP1NCpGzuQ1YHifPGaQvUJIzmf4/JuaxdjNlXa5D+AzF9FK+abO41DFq+921nC33PPLSE79LIyAC0K7K7J6hceGcm2r6K38JSk54uZ06em/d5nWYwjTTDbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Sun, 20 Jul
 2025 11:09:39 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 11:09:39 +0000
Message-ID: <1562a5f3-21c4-4384-8118-916a6ce6d712@nvidia.com>
Date: Sun, 20 Jul 2025 14:09:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] ethtool: rejig the RSS notification
 machinery for more types
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 ecree.xilinx@gmail.com
References: <20250717234343.2328602-1-kuba@kernel.org>
 <20250717234343.2328602-3-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250717234343.2328602-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 572e0909-ced9-48ad-c904-08ddc77deb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVhZRnhVU3EvUWMvbThyYjM5Y29YNWhSWEpsa2t2MDBVZzJ0c1B4MmhJeFlG?=
 =?utf-8?B?NVgxSlJuQnFuV3JQaG85VU1KRHZnR0QxYzdRdCtKQ3ZPSjZKbndmaHhDNkRS?=
 =?utf-8?B?SVh4emFiSWJTZXN0ek1HQ055MlRPbVlOZllORnp1ZFNCcENQSHJac2pSN0dO?=
 =?utf-8?B?dnY5aUFpeUJxb1M0S2pRWWFaV2d6UXg1TTN4USt1NExQOVJOY3c3TGhqSVkz?=
 =?utf-8?B?M3FPTUo2anpzYXRXQXU0ZGlYc0wvMDYvZTNZYWg3R1RaQkJnUTRCWDlVUGxj?=
 =?utf-8?B?Z2RmN0lIUjJqOU9uKzlyS3VTWTNIampFbXR2SXNldHdhTTBYcXgzMUowaEEw?=
 =?utf-8?B?U2UveGg1TVlhS1lXZ042ZjNST1lGZFMxN3BkZ0FZT2dpeWE5K0dZN1U2ZFhI?=
 =?utf-8?B?QkthT3NtbW0vZHUxaS9CODFYMWRVcytzL09lcDNvbmR1WWllOTdCS3M2K0Jl?=
 =?utf-8?B?anhuaUYrZzN5Tmh6R3lvUnpxeGZab2lEMjc5VU4xemVDUG01YTFpaEpWbXpi?=
 =?utf-8?B?aXNzT0J0K3VHS215MUREUkRoQTZzNVFmR1ZLZEpxbWVJT0lSV25pbmRGMnk0?=
 =?utf-8?B?dXl5cXN5T016OS84MHAxNzl6eHoxMnNHSjUxemlNb0haa2phOUNKY1hEVlZO?=
 =?utf-8?B?Q25adVNNbHE0UmZ1Z2RQRzNpbGNmVEhxSHlWanptNGVuUXMraE5vM2I1Uk5Y?=
 =?utf-8?B?b3pxSHI0czF0TlR1ODdkKzRhRDlqM0loQ3NTaHVoaVlWTlloUkdNOXhaODh3?=
 =?utf-8?B?OTNhT1pVM25Gd3RUck9PWFVXTWp0MEkrWXAveUFkZXBzdm5WdlJ3elk3Z1Bh?=
 =?utf-8?B?VWVIaWlvZnFMOGJaQzE0OExYT2NlODVML3pkSUZXVlVSeGpqSXVpM3R1emZj?=
 =?utf-8?B?YkYwZTJDZzcvOHorSTJIcGZqeE9UTHJqSkJuZW90bGlsOVdRMzJsbDZQU3Z6?=
 =?utf-8?B?dy9Fd1F6V2o2ajJNWE5zTDN5VjhTTkROQUFVOTJKd2REbVBvWVBUbUd1V3Zk?=
 =?utf-8?B?a3UycHB6ZmI2UUlJN2ljUUFXRkd3eUR1YWhwaXhDSmJaY2R2L1VKYjB5bHVV?=
 =?utf-8?B?NnFwKy9GejBYWENWbVdDUStqU2FDOEQraUpwZlI4ZUFpanZiRXVTUDRJSkpS?=
 =?utf-8?B?eTFlVzN2YVZwUU53QlJ0NVUxL1ZCK2dVaUhNWHJVSHIvK1c3L3hRNHlvRmtG?=
 =?utf-8?B?QzRxcHY0cVVFRVRRZzdxaFY0STdrc21qU2lXd21YdzlwN1pxVmJFbDhVeEp6?=
 =?utf-8?B?Rll3ZEh1b0R4eWFiNXRSeG56N2MvV3RuSzFlQXg5dU1xUGhCeDRpaysvVTMx?=
 =?utf-8?B?bi9FeTZybVN1SEdIS1UzSmdHRFFMMlRoY01PSWRUNDBOL3ZieEZiN21XUFVT?=
 =?utf-8?B?R3JPVW5lT1A5dWNvdi9EdzIvRFFwWUhRV0ZlWUdrdTRZUmpJczlxYmdWZGoz?=
 =?utf-8?B?b0Z5bFJVWXkyaU84RWxpOW5FeHBvZkNwSTFDdlU2d2kxcEs5aWR1bGdDUnVi?=
 =?utf-8?B?NTI5SVJ4NkxTTUc5Snp2RE1laXZhMFptR09waHpKUGNDZVhQVlR0N25vRE5T?=
 =?utf-8?B?aUVnVGRQR1AzcVVTKzNaQTN1Uk00MFJmOEZ2YnI1RkpnWjJzVDlLRHh2TC9t?=
 =?utf-8?B?UVMyN285akl6Q25NOGo4TkUyYXRKZTJDa2ZLR2k2QzhsQm9RSndTQTN5dktp?=
 =?utf-8?B?VU9XbEIvWHFwSEkvOFd6LzdqOURqdVgxbnR2L3kxVGgvOUxtZUtJT0xwMmhj?=
 =?utf-8?B?di9CL0VUU3pSeFE1RkZqU2g0bENNeW5mZEM1YnhBVzVLYjduNHBBRTNhZ2dv?=
 =?utf-8?B?RmgvRmtmWVVHeXVWY0pHQUt1dkQyNWxwK2FYVWg5MXpBNXl6b1FFeEU1ZDRN?=
 =?utf-8?B?OXNqdHRyTUJsVFJBSk1YK0JLZ3NzTGZ6d0Y1dzh2V0NqU21kejBjSjBMaEtB?=
 =?utf-8?Q?psZiWwSrRbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnhQcWZwOHFKd0dVRFJEUjBsc1NGOVV5SVlPM2cyQTlFZ1hsZEFybk9sQ0ZC?=
 =?utf-8?B?NURNVDRQZTlqL3hOdFlpSk1NREJLZHFmVjdFT1ZKNGZ4ZXE3QUdvajBGOXpT?=
 =?utf-8?B?U3BiSlVIRk01enZVK2JoS0t0UWhWZUJURDM3RHZTMS83SkxiM2N6WEdEbXZB?=
 =?utf-8?B?cUJEdTBNQlpiQjEwNDVMb3BhQUhoUUMrOFR4dURzdnQ0d3MrbUFiaDh1NGFU?=
 =?utf-8?B?dHNIdjd3WGtpZUc5YXNxNmUyRTEwcUhhcmxKMUd5WHhLZDYwMmE0Q2VTekJn?=
 =?utf-8?B?dGJ6OE01TnU2U3NYZXJRZzZHUy9xUlY2eDFLbUYvb1BvRHVUSGM5NlZKOVdY?=
 =?utf-8?B?VEk2QnFUYVQrM1VBMThyb1FaSVB2TXhBUVBoMVE2WjduZXhoNnJORHNnalJ6?=
 =?utf-8?B?WGV0d1dEeVZYd0QrSHBYUnlSTnVyUFNZYzFSSmdyQXNPOVY0aUxUOCtFakJP?=
 =?utf-8?B?UTJEbGdhMXBTb3ZHUG1UYm51aGVnUHFrNFFucDNZM2QvRkhhdmdTOUM5T3VY?=
 =?utf-8?B?TmdyaEF2citPc0RkNmFQcm92a3NYbCtoVUF4amFrTnBtQUZJc3FOSXh1eHZL?=
 =?utf-8?B?ZVRmUVFpaUxXWEVaT0VuVWdWQTBKa3dSQ0Ewbk93Qzc2THBNWS9wZGFtNFBw?=
 =?utf-8?B?N25LZEFUVzRaNnRwTjJRd1JQUlRlaU85Mkw3SEFReUNTUDFRaTBPNm5ocGp1?=
 =?utf-8?B?ZEVQaHc4SE5aYUlUMHB4cFpZT0VpdkMxaFNwcUZNR3dHN0dYckthbkZTT2Fu?=
 =?utf-8?B?bERNeDFLM3F0cFBlaXgrek5HTzY0RU1tK1lpR1VhWDRjbHllWG11R0d6WW5L?=
 =?utf-8?B?V08rYmpZcytxRHdhNWZZUGUvV1dDdXhIWnNiSWxuTWlvbXVwTkJsT3IvVFB6?=
 =?utf-8?B?OTdjc2gva2NmQkdleVE0bWxlQ3lkWFFlQk53cUJGQ3YwVUZzQk5OSzFnTkhj?=
 =?utf-8?B?SW5HSjcxYmxBajg0dFVIM3hsUzdDN3dna3lvd3JudXBhWTBqMHE0NzhvMWdt?=
 =?utf-8?B?ZUZZWlNoS09sL1hRQzlnNTluaW9rMGtjUi9LOWVzbjhGZHNNa2hNWjlhY2dB?=
 =?utf-8?B?OC96UFJmUERlb0prdkJvblRTK0k3Vko5L2kvWWtSSkJPOHIzak1RMUMrdDRj?=
 =?utf-8?B?UnRhR3RHSmdWUlZ5TnhqUGNvUGk2OURTWHV6VFJMYkQ5c1YvZVFlVlI2QzFS?=
 =?utf-8?B?bDZjQ0VKdVVCN0UwczZCZGVjeG81Z0RrVmhRWnY1TSs5K0krWDg2QzlCL1k3?=
 =?utf-8?B?SXpLMlBUTU91bXpDOHJYY1E0d0JCVm1Yelp3WUxscW9PMzRSRTFJbVVpb3ZV?=
 =?utf-8?B?Zjc1R253bkJFcmswZ1g2MlI0NW9UaHpWVUtKR3pYUWRWY28wVE41SG5BcEFH?=
 =?utf-8?B?aDM5M1A2bkVJTkJNcnRoaVVrVEFodWMra1NtTnhXRi84QS8wN3R3YVl0clla?=
 =?utf-8?B?YzVKa24ydDY4a0xpeU1ia1Y3a2FsMWZDcDVLZHYrQVEwWnJ5eE5RdlhlSFVG?=
 =?utf-8?B?NElvQUpWc1cvUk0zd2l6NUVNajY3cVRwcHJ6WHQwL2xDTFlBRmlqV2hUSXZE?=
 =?utf-8?B?cVIwdU56QksrZnBzTTFpWXZ0SWVSQ0tET1BpQ1prUzBvenBVbkdTOVpyS0xa?=
 =?utf-8?B?K3dIbm9ub2JXWXRQcEl5bmVkV2ZBdW5lMHdSdURLOUZwUThXYUlHQzdTZGRp?=
 =?utf-8?B?KzY4L2xyUHp3NWhJVmtNOW5xanhsdnl1N3dwWkp2Y0k2eUNiYkRaMkJqcmF5?=
 =?utf-8?B?ODB4cXlqWDZZWXFLQVVyUHo4S1gvSjRBY1psTFF0L1lvdW1rSVhlaE90SThR?=
 =?utf-8?B?cWVsdTBpWFFxYzVsVndNcEZ5Smkvd2JwQkc5VDl5eHNLQkFRaVpsWWJjSHBS?=
 =?utf-8?B?N2h4QmgyRUdtN2l4eS9rcVhiSjN6cWcvZnRJMjBTQ0hvZGVCcXlGS2lwdmMr?=
 =?utf-8?B?WEl6b0xXVVlTbFQ3R0FQMU5TWWJsTFZSZk03OTdnNkU2bHJFOXY3WmhjRjhr?=
 =?utf-8?B?akZLUzdqVmVyZHlxOGFJb1djUE83REVuaUhIN3RFQ0NhSmpyTHRkTXlDR2xa?=
 =?utf-8?B?akx4bkxacFJBVWVPdFdVK29OU1pmNkxkS3JkL2NMM09RNFNGRGZLZFhtVXdk?=
 =?utf-8?Q?FYsnSYRM4SnJJ38ytUNKsPqbv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572e0909-ced9-48ad-c904-08ddc77deb3e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 11:09:39.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SClZI1T4ylFOu1Bif4EGAv8j4ualWoHldf8NpA48Kd/jWMzg87DUa6cBNRo/ZR+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037

On 18/07/2025 2:43, Jakub Kicinski wrote:
> In anticipation for CREATE and DELETE notifications - explicitly
> pass the notification type to ethtool_rss_notify(), when calling
> from the IOCTL code.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Gal Pressman <gal@nvidia.com>

