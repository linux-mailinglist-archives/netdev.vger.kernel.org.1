Return-Path: <netdev+bounces-165217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449FA30FF6
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C763A29BF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA2252911;
	Tue, 11 Feb 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fuFGpeQp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112542512E4;
	Tue, 11 Feb 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288326; cv=fail; b=A56NvwLJ1CnuKkv5k9ymQG0hQ4W42ejRrFOGJxbKZ0wV/x7YnhUF/LhamMFethfOkDpb+mYhPENcuDDS8MRKk8Mjy9BlWRHvqzKh8DEyi0Ao6ffQGS+TEIa+OyMNK92NEYI8XkQ9gNWgrISV5a630YvI3sDGH3LNOnY/lY9nWdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288326; c=relaxed/simple;
	bh=hJaY/nmz9XgpKkZp2PrNARMVNU7U5cQiqpaWq9MQkd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAf+kQmoRWfe1tVsF4rBopORlsBtpOHQmcjO1JRk17BZMHhq04ox5twuFIQpHrKZ3Dx6JSCBNCPDX37Wfp3mZyG9ol5pZX7B9Y8Kr99T7f7iQTPWyq+25J5ZKvm7w2jspymAWPdXCFYYNLj5iiz8/wsnNM3NYq8zvUv9w/BefhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fuFGpeQp; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BR06miccHcYfaMfqUh6xj9tiqfnbT91ceNvhbBZQoH8+LCjoLdDFD8OGc40KRCspuRNR0SAbuPIQxMpswNVAKwl04wMabWIxBjBXl0nG/Yx/OBXzh+LbDoqT7F9wUd+MtWn0VWuH9xjdHMkyvGGk6r7LWcUvgjgnQJAsvSvlb7NkI9jY+6ErWIRj6SHuN3aPorlQqJhmoIjPfUR5GwUBmEQiOYcmb3C/qz2ml3nyeCYemQi3lumA+1EEmhKwNE4jLQB4QFrCna/aS0Tn6SgSZyC2GGgM91/uDMzls0XCSRrXA6zaTNWAgmD86lAqlwN692fPZdvqz/X79/xon8a/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at+kIpaHDUJ+pyRlP7exAee9nVCWDHipFT3XsmUV2XA=;
 b=uMtf9KuLfsKsubKdAt0wlQ/JgBXIhra2Mv4SWDxh6SrgKI3/bSqDRx0rMz/yF2PLUeW1T+6nElg+f/R8ecnPmiKgpigxA87nCoEgN00MrH4L+2fNMhLdz42PsrpCyKpq0P+Cc92BJ6dKSThXE/q5aKPHewcWkByaC/RZxhIp1ceq2HjGL/1b+1AAWxvqJSvcTOu1UxPptUsJZBcEiM4oCMoWaR7AjfM55l6Sp5PIKqJcQi1myXLtc2SCrX8qb2/iaRqpp+a/oh8KxCBt0fQocPkVDjEcJNH1ubiYRCSGua/mcHTByDcaEvD20DgLW7of2nzz1H7l0AKuoTHBsJX0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at+kIpaHDUJ+pyRlP7exAee9nVCWDHipFT3XsmUV2XA=;
 b=fuFGpeQpaPO0Gda9pt7QiOnHBkTjGx1jfwJiSxENPaXCVDilahuWLJ9JPTpE71I6U/7sOBIKYNjAnrw9Sqt/fpe6kdXKdoWSv9hOMTH0LO4Sa3iGc8lBgYyY5p/PQg6FgyRQktiJOWMT/hG2Tp/7i1u+JTdVfctv7rpOJR55nG6kigsUNw5bNXXbjbeG+9OfYuluyHE0VGkjlaHfTpj32jiRvt4+PNVkSx8fcngAGP04L3jVbN/2RJHWvvm4KR4cLCFV5bsFdSDy3jrJZw2j+tT8NBr/vywW9yIVqnOaAScX0Pg3cZpM9YUf45vi6BEgyv6X5SPNkEomytBRcNPrLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 15:38:40 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Tue, 11 Feb 2025
 15:38:39 +0000
Message-ID: <f12c1f1e-3ae8-4cd8-b727-61c35b8ed9ce@nvidia.com>
Date: Tue, 11 Feb 2025 17:38:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ovs-dev] [PATCH net-next] net: Add options as a flexible array
 to struct ip_tunnel_info
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: dev@openvswitch.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Kees Cook <kees@kernel.org>, David Ahern <dsahern@kernel.org>,
 Yotam Gigi <yotam.gi@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Cong Wang <xiyou.wangcong@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <20250209101853.15828-1-gal@nvidia.com>
 <2ef88acc-d4d7-4309-8c14-73ac107d1d07@ovn.org>
 <fe814549-3bd4-4ef6-8e7d-9d21626766e1@nvidia.com>
 <acf28b0e-5d34-46e0-823f-8028e2fb8356@ovn.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <acf28b0e-5d34-46e0-823f-8028e2fb8356@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00002BC1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:12) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f2303b-eb53-4b1f-f8d2-08dd4ab22820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVhJMDNHNnZKcHViMzIzeTkvbkVyM1Q0b1VkUmI4SnRkYXBtODNCdU1rS2Vz?=
 =?utf-8?B?ZTM1eTdhR3QxYlZVanQ0QjUyVFdJYlN6SEhabEdkUlkveG9iV1BTNVREN0ti?=
 =?utf-8?B?d3U1WWFRSVM0ZE8yd1d4cFVBeXF4bTVsYWpJUnhvTUF2am5jVW1JUmpGS0xt?=
 =?utf-8?B?WHdad3pxd2d3WW9iMGtRTkxSZDFKUGtjejh2OGJPQ3dpcmZXRVo2ZFQ5dHRw?=
 =?utf-8?B?UUZpS3VSNWsrN1l1WExYSXRRUkZxdTRDRlkrTVJNd3FzMjNkREtHaGxacEZU?=
 =?utf-8?B?UEhpc0l2c2R5TUJQa0h3a0VlQlIwU3VkUlJtd3YzNkdtcHBKQWMzWXU3dURj?=
 =?utf-8?B?bURML1RJVmhJeFlWSUdZNTdoTUNQM3hya01WWUtId0lwOE9KbFgxZmVzUDl0?=
 =?utf-8?B?VnZKZkt6QXYyUGtFOHcxZVJsSk15dC9Tc09NVWxCN1dZdnYyckE3YlpNMkhy?=
 =?utf-8?B?ZGk5YnUxSTJYZHpmeG00VHdFK3N4em1mUkplaU8wa1dDVWF3dXpwZi82d3V0?=
 =?utf-8?B?S1liWUwzYVN6ZXIzaGdESGxSNkY0NEllYkVCWVk0Q3hRNm1kb3VzVjRhc1NV?=
 =?utf-8?B?dWxYVVlMZGp4aUMyZFhlSmN4Q29LU1hJaW1WTFlsTll2MjJiZnNXWW83ZDVx?=
 =?utf-8?B?aDkrSG1yaHdnYjlYQWNrYjZaMzZnT1VHTzlVWEdBdDVVVzJ2bXYyeXdCR0Vy?=
 =?utf-8?B?RUR4WFJvYVJESi9Qb2tVeFA3YzBEaWNOU3M4T1AyZTFMaHM1K3RRRkNIMzhL?=
 =?utf-8?B?ajNZMkkzWWtkQ3VGWDZPN1FPN2Y2TDhNazJtbTJPa2tKMVl3eTJFNTBYTHNX?=
 =?utf-8?B?Vmg2bU9nMEZWTGNaQ3I2NG84VnF6VkFCeEFqQXZSNHpSdXVTODRXTlIwMWht?=
 =?utf-8?B?SHYyZmNvOGtMWjNUTWllUmtxQVVXQmdVSm4xQndGZElBSjFvU3BxaFVVcVlo?=
 =?utf-8?B?dTNwNkR1VXJkK3JKTmxCYjJySUptWHNMc0toczEyb3ZqajRGdVlBZGo4ZUlS?=
 =?utf-8?B?Z0pjZTF5K2M0UFJGSlo3MnRyK1ZSRG1KMXY1VzFleUZPTkZ0TnhXd2l4YzhG?=
 =?utf-8?B?RlpXUG1qdThjc1hLMFBqOE9wbE5Gem9IZnd0UjcvMGtTVmE4QU4rdkF1YVBQ?=
 =?utf-8?B?dXh0b1FMTnZxYWRCLzkvcmNSUXF6c0JZYWdpczZ2MDV2aVI2bzFtVEFqNmpW?=
 =?utf-8?B?c3phUFhqR1FzWXlOOU0zZkx4dk1wUGhMREFQK3RpWkhKYkZ6M0hXM1ltV2lq?=
 =?utf-8?B?aUEzOHFCNGlVOUJ0VklaZXdMOXBtdGhmT2RwZGZ6QzRJNXNKWlpxbllPUHJv?=
 =?utf-8?B?K24wckVjbGl6Q29ZaXBKVDR4MEtRUWpyMWtEVGRLMWZPNDVFeWRIZ2dSR3hB?=
 =?utf-8?B?dWZPMVJTNDVhalg5ZGRSLy96K2g2OVVmQ3lQTENNU0Jxd1pTNEFTTnMvVmc3?=
 =?utf-8?B?K0Z3WlE5OUpTM2FVWlFia2luUE9vME1CMU1xUG4rZTh4UDAwbmsvLzBxcUdl?=
 =?utf-8?B?QXVlZEM0T01VZTBORjRQaUJNbG9vbVo1YUlzUXdwL0JnMmVKdVhsejNTd1lx?=
 =?utf-8?B?d3BENkRVNVFSOE8za1IwUTVmcUlaQlcxc0lDMjBBVXlXUzRzaW1QNEE2R21Z?=
 =?utf-8?B?ck1NRjhMdiszMVVjQmhYK015bWlnTUhOWVVoZkw1ZFdIbzM3QzJlUzlCeDRX?=
 =?utf-8?B?RGhrMUJydjVIejVmY1M1SEVnSFY5cmM0NG5aalk5NFEzdVZodHlvOEt2RmFi?=
 =?utf-8?B?bUIzZ0RVanpyVWp1ZzJidEk0ajNNN1RHYXlCVUJsZjlKc3lzcU1Vbk10aWRR?=
 =?utf-8?B?ZE5GUEkxODdOdWIwRUZ4ejVBUVl0RzNraGllb2RPdDRib2ZTcnRBVjNiZHVZ?=
 =?utf-8?Q?m4sfn2uq5JQOP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkYzcks2b0pGYXZCbG1RN3RibGZZMURTK1JhYkorSFVwZzZlaFYrWThyQkZh?=
 =?utf-8?B?amE3RDN0WlVXR05oQU1SbEpDRE9rMWVCNUVzTW55RzdXTlJHaldUNHh5T0Mw?=
 =?utf-8?B?MGJOQnp3RTNjdFdBbVNpVFhvWHNNTjdzbDBFMkJZVURGRnB2T1d1TWFXZkY0?=
 =?utf-8?B?WldkbVY4clIwRkIzdHcrSkVGTzN6QXphdWl1bjZ2WTE4aDY5Z2JzWENYK1Zj?=
 =?utf-8?B?c01JODFSdG9BNXF5OEphS2dabDVXcWVYNWRZejlKbWhLMmM5NlkrYWphWTJy?=
 =?utf-8?B?RkxudWF4MWhoeFREQTN1Ylp2alhSbDdNWWlrSjMwSFNKekZxdE0za1ZBUURD?=
 =?utf-8?B?NTE2MGFxS2ZPZ0ZLQUlSSVVQaE94cEJDN1dhV2hQN0d1L0FDaVk4N2I2R3B0?=
 =?utf-8?B?cnRnRmJuMFY3Ym1LZmhQTGlHSEMyRHZrNkhDWVAwdE1MbmNPMFQ5NE9rNDFR?=
 =?utf-8?B?ZlEwbzA4WStLZFVlTCsxUFRDL3JTYk00QU4vYUZoVkFFQ0dxL1I1bTI0bWQ5?=
 =?utf-8?B?bUwzVUtTZzRWczM0amdiTlZNT0p0cThOWHJGTzkyeTViRFk2TjdJSVp0blZz?=
 =?utf-8?B?dmF5YkQrRmVhK1BiaTZvbHVrRU11WTFnWk1tU1dSdzgwNnNMUXMvck5BMk5r?=
 =?utf-8?B?eHZPOXVGRnZncGtnOHRHRXk2VitCSzNqc1RhRkJTMmRsTUZPcEpWd2R5emgy?=
 =?utf-8?B?cXZIWVhLQ3luSnYxRWc0MnRUR1hFT1FHOFVhMzZZWHFVRXdIZUZ3Vnpiajh1?=
 =?utf-8?B?T3RYSVZMcW9PM3VJWXVUcjBkbXY1MGlnOUJkNWM2ZkFKTDQ5Mjd5L2xmRUkw?=
 =?utf-8?B?WGZlSW5VeXR4TU1QaWhnN2k3akZUQjJVbE9hVkJSa2tSOXgvRnhoY0RJdDlz?=
 =?utf-8?B?YWw5RksraDRDTUV1d1VxY1NzUTBNNkdacE9jdy9mWXFMeFRubStQai9rcXJF?=
 =?utf-8?B?NCs4c21ybkRLbVFLVGF2Z3Q3Zk13d1hYMFZ5L2RQdUMzTWNnaWFlcTlTUTAy?=
 =?utf-8?B?Z1JacWE5emx6WUYxMjBqdnZtd2MrNEdVM1VtMHpsVjhsalVDNzl0NWpWMWZ4?=
 =?utf-8?B?ZmZKclAwVzFCbGFJSFY0YXg3Zk9vNkd4MWw4eUFBSFBIaWVNUHFLYTlIZ1NJ?=
 =?utf-8?B?L1o4NTB4RkhaTkhPcjdsTFlFUEM3T3A5dS9zb3BYelJreENsYTJqZm9tVWV0?=
 =?utf-8?B?V2xxVm1FMVQwUFV5cFpaUlZxNGVxaVpwMlFXckg0bzJGYTVKTVBSZ0FuM2l6?=
 =?utf-8?B?VGI3OHBveU1KZldZcWliSlRiRkhMK1FnakpwVnNlN3FDMXBRVytpSzZPeHhr?=
 =?utf-8?B?ZG9BR0lZeE9uaGcxRWlaNzBpZ2x1L2VHbzdaMk83MXJQVDVVaUhXNEVTclhr?=
 =?utf-8?B?NmNGb1VybG5RRFo0eVgvOXNDbTFqYmdnWDE3dk12VFlBcTVha0xLYnkzWDJu?=
 =?utf-8?B?WUxPYmg1RCtsZ1laaWl0Wm5ZN2xvVVlkWnlYcTRVU2tZaFlJRk13Snk2dFFV?=
 =?utf-8?B?ZUJ3NU8xZXpuR1hEaXRRSGJGQTAwdzZyalpsalU4bDA3SlA3alk5eGdqMzNB?=
 =?utf-8?B?YnJUaFY3OXVuVDlBZlpyRnUrc25RUmQzc2pWNkxlQ2hIMEtMU05UbzkraVha?=
 =?utf-8?B?VzhxdXZnbHVOYWo3RXVpZXczb3BqcGJnSldONU12dlR1STljV25UalJhb3Zp?=
 =?utf-8?B?dWZuTTlTU09UYzkrT01XM3k5ajlVV2pqYkdybVR3UVljUGQ4MFNOcGRwcUdr?=
 =?utf-8?B?ZWtUQWl3UFdwZUdyTnozblBwbW8xQ2xJMi9vNlZLeEVSNGhQdEhWLzBZT3lH?=
 =?utf-8?B?aGtSY3pnR1JERmwzNXE1MmpJa20vSUtPU0puYXZud05kTFpqQ1JGZ0N6VlhK?=
 =?utf-8?B?d3FZRW01akJLQnRrK1NnY3JqUEdLRkdFaFZqYU9Kb29VTloxbjEwdFhBV2I3?=
 =?utf-8?B?M0dJR2RvU1grdFhLQ2xrVytVaHZJOUpMMnpwSzBmd2RNOU01VU90ZU1hekdp?=
 =?utf-8?B?YjVMbUs1RTcwenVEcTMrMUVNYWIxeVlEWG9ySXFuR21tOU9hbldLN2FPVHJ2?=
 =?utf-8?B?WU9xSS8yV1EzUTlYbXRBMFdtbEEwMHZYbjMrb1NPcnBLbEFrQW5NWmY2Skdv?=
 =?utf-8?Q?7mToLW3gh189mEnQ/kIGQITrE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f2303b-eb53-4b1f-f8d2-08dd4ab22820
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:38:39.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3f4e0od0XEIEyCl0BH65ms3+fZ5yPIheArp6AuDu7qcr9a/U9xcVfsOOTCHpOsP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

On 09/02/2025 22:16, Ilya Maximets wrote:
> Ideally we would have a proper union with all the potential option types
> instead of this hacky construct.  But if that's not the the way to go, then
> 8 bytes may indeed be the way, as it is the maximum guaranteed alignment
> for allocations and the current alignment of the structure.
> 
> But I'll leave this for others to weigh in.

Thank you Ilya.

Unless anyone has a better idea, I'm going to add an explicit alignment
to the options field, that would keep the struct layout as it was before
this patch.

