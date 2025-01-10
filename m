Return-Path: <netdev+bounces-157303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC935A09E44
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0383A1B79
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2FB20ADDA;
	Fri, 10 Jan 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dnqcs+X7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2821CA09;
	Fri, 10 Jan 2025 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549131; cv=fail; b=j6U689Rha3pBwd55yGHHLy+C0p15r8GAt2HLL3YpP/TXg5nTOZXGnXb5jmqzKYDTUFXia15OKqptHb/qJNGjMdZkJQsSqYmo2kGdv0W7/2PlX3tLLWvF7Pqvc2jBZSaB9YUp4xhPasLcArpVM+bLloCMPz179/98RjL785aTjDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549131; c=relaxed/simple;
	bh=6YZp8HfggvwUZVyHOp2pkYuEd+qMnHZcbmEad8ArDyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UxT1Ejc2HWWY7KRz5UnGcAO8VmEFY8hed/JURJ+ZZGROvmf3CDd4lPEKf1WfDo5xP12JUU+TFuYed7Uh0eGW0cpLKiv09+LTEDYPj2zvJHkkA/twYeKaQdCcojkq6U1Q691bA6o8jLuY4kQuATKJpna3bw1R5CGuPQDPF4hCgDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dnqcs+X7; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+qL+t2ZVhfu0joVJSiMVxbBh7VHR+GuPWIKJYHAJBTQ8q1PaG5zCHAbFP+smBFqRaPj8cKCpo4TjWdhX4ic1x9AeM4RCsvirvJS1lmHbqSH/Dj/It4CTcQTGMOHdLp20t1/o1H9R//5sDM04Hu8g9fT/S2V0Q7q9CTIyZp2HH/kDvfNQM23BgpuVHj5hrL1NZ0tv64ZTukqCxMkQKPKXiGMd9g7/CkNXsd6fg9qGOd1l0kE5iG3EoIzq88bq8GbmZaVzWK7WDo0vSy2j0VF3qwKzWgTPDHEa3DBiXisZP6df14yzwNL7XyKFK+93VLveNITJARsxKS2Q3pCFDLpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7osHENgkAAPh5s6NYKBilYtsKgXlos/InRw0UarwCw=;
 b=nT6rtihf6z5R6Sv+e+CY3+fS2GJzBmYhLKcbDOI7jTiNjhIiOyzeUqXzNXefbQfq7qmJdJDwWuZiN8iQbX5T12yeN8qhbNyFlVXjoLdGr8DQ8HtfmCdYGHlaFhUFg+Et8BK0CavtpAi8i+PWyzxuRZFz30ZYSUXC+vFBk8S37/JQLXIJeblPfhGzgYUaKSTswA+sh0t2tdqMdqG1sZqOLLQ9VAbRR5TRlmXQO317q8YXWP2EZd/cA7jJqZeBQr4k1WNF/5DHuRcSxgUmOYvxLtKAeRPruF3BTZGjFD+Mau0E4FJqBTAL5290jvZHohEdnB9zQo4j5T7aKPLUwZJdqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7osHENgkAAPh5s6NYKBilYtsKgXlos/InRw0UarwCw=;
 b=dnqcs+X70+ju7b+PVSbcQJG9xYZkuah+1mAqZqOMeo0qrY/rojsgQOmiJ7DSsf18o/y2ZLFWWL+WiL24fej/RmrD60VF8lpzDo+SwpKHQ5hdnc/uo6fsQe4MqtmBysRrk8sbiFWpmKX1fWROQ/l+bNTnEvTQQIBltBwJ7h5ORp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.13; Fri, 10 Jan 2025 22:45:28 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 22:45:27 +0000
Message-ID: <d949e437-a7ec-4125-8e49-06478c2c3088@amd.com>
Date: Fri, 10 Jan 2025 14:45:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: xilinx: axienet: Combine CR
 calculation
To: Sean Anderson <sean.anderson@linux.dev>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org
References: <20250110192616.2075055-1-sean.anderson@linux.dev>
 <20250110192616.2075055-4-sean.anderson@linux.dev>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250110192616.2075055-4-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:332::28) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA0PR12MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cabef3-6c9f-46ec-44df-08dd31c87a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnpOaFVjdnVPdEpsRGdMUDlWTjZaTWsvVjJqM09aQjVpWm5EZnhuOWFzWkhy?=
 =?utf-8?B?OXI0M3N3VjBHQzh0RStDeU00cWZxbXlQb0cxRWtRSm92UnlmQkhjYnlpV3VT?=
 =?utf-8?B?ZHpncHF5ZXFHcUlvRGxaZGp1WWllejZCd1VPZ3dKNjZvaFhFSlhtL2dBdGdU?=
 =?utf-8?B?WXI5Mk5FdWdjTnVsWG05RUtKTDZLSkxqVEtnWkRxQjkwN0dIQXdRb1hDYTIz?=
 =?utf-8?B?bWY5b0VYbDFMcmtFN2c0WFFoakROOHdZTlV4cHcrZXZsbCtvOWh3YkF6NnVp?=
 =?utf-8?B?SkIrVllySjBxbVdBQU9CVUZhY3gvZkJlb1dWa1dKdDZLRjFDSjdsNDVVVytq?=
 =?utf-8?B?RGxEQllQWjEyNE5FQ2xQNWY0UU9IV2I5T2l3eDlkclZqUDgzYk9TeXc3NVZz?=
 =?utf-8?B?azF2bUFNSHZwdDFKQ3pxMC9NY21FZDF2MEFMTVduSDVZSk14dlZtYUFWWGZV?=
 =?utf-8?B?U2tBbm53SkdvUEVxd05kUE05K0ZvZGpJZC9wUTFURmY5ajZGTlNpYWdjVlNk?=
 =?utf-8?B?NXFteXFNazVQaUQyZkRxazRVdDdwbzlTWTBGTU9yMTQ3cUNxeXZIakM4SXZT?=
 =?utf-8?B?cWNpdDZGZ1YzclpvdGRER0NzZzRUTE0yeHVYbmpibDZVS0JDTFVJWkRXZVFT?=
 =?utf-8?B?L3k0aEF6cG1iS0dJbXYxNkk2RFluSTlOaC9XbGNSc0p3Rjk1QkdoaitiNmN1?=
 =?utf-8?B?T0tveU9ITzJCc1hhcmxSY1Z2TE05V2lzaVZGZ04rM1Q4WXhZYjdLMDEzWjBT?=
 =?utf-8?B?dDhRWWZYd0FnL1JCZkgxQWQ3YWdZSnBIV3RrNDQvakpnaytBZ1lPNUFSaWJ5?=
 =?utf-8?B?c0w5a05EOXZJSjNDRFZCeklnQzVvOC8wOTA0ZHRuWmljOHNSbWF6NjRHNEZR?=
 =?utf-8?B?OXRFZ284T0NQTzdXNnRnSHRwWHZuRTliYllUeDZVblZVaHByQkJwbUJaOFhx?=
 =?utf-8?B?SzRlUHU3MnZQQURMeW5XRVEzdXlYVXl3Q0UxbXNKdUtBU09uUHk0cWZ2cElq?=
 =?utf-8?B?UXFjc1cyaDh6KzhNajFpZjQ2YTN4YlJmRUdQOXdOcks0eGNSZWlkSUhlQSsw?=
 =?utf-8?B?OVduV3BTYzdmR3p3TUZtYWlGS09QOEtrODVlSjVTRnM0c2wyQ0QwM2hoMW42?=
 =?utf-8?B?K1NYQUIzRVR5M2pMaUNWY1hHRVRodk5IaUpjeDRKN2JTRUNXYmRxM3I0VXJ1?=
 =?utf-8?B?TlBvZDZZaWxBdjdSRk14YzVYYVA5aUNEc3h5MkdvdUFBWDNHVlR5WnpOK1NJ?=
 =?utf-8?B?c3A4NDQweEQxenhsK2QwajlnQW9CQW1kaEdrRDRwTGpDRHFUOTU5b040cW02?=
 =?utf-8?B?Ty80Uys1S3JOcWUyd3REZ0piaDNJWGpia2hnRmdYc2dqbGs1SXBvVDFlM29Q?=
 =?utf-8?B?ZCtqTGp3UFYweldVTTJDNTVXMFlnT3lPdy9BMEhZVHlYUUtyNXdCWkVKZHpx?=
 =?utf-8?B?TVA4cy9KTk4ycDRscVRMUHZ0M00rVkxuNlNqZTdDUC9EN2hxcVFzUGt3dWxD?=
 =?utf-8?B?S2pHSGd3cWZhZWF3WEhTK0N4S1VVa2psNm9OcjQwdlFQa25CVUVDTXlrL2xV?=
 =?utf-8?B?Qmh4Y20xMTRWUVI3VUJPWFpUbDN2NFgrcXdqNVVLa2dmZjdYMXllYkwxNU0r?=
 =?utf-8?B?NWJIbHM5S2xiRGI5V2MvQy9XNVY0MmNOemxCb1ZnekxpV3BMVTZtejhVN3lQ?=
 =?utf-8?B?STFYS1Fyc2RwZzlnL2FzcXpGNjJWcUswZGFDL28zOVZNY01UeWFVbFNSSVFZ?=
 =?utf-8?B?aElKd09tMWlCTnVYV09nSHJ1MVRrVElkWjZERytDYXIyd3dMZ09LNXpFVnZL?=
 =?utf-8?B?cmFKWGVkQlpjZEVUUksxdWVKTDFwNEI2cHNvNnlKMGVjekZxQS94Ky9nb3Bn?=
 =?utf-8?Q?wS1sFJ4v7yvh2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXJUOXMxRFR6Y2MzbXpxenJjZjBuVk1pTTludURqc1ZleXhnNVZDWFE5OHow?=
 =?utf-8?B?aFlEZmszb0lJT2tHQWpuT3g5SitNTTQzTXdOSEN2aTNONlIwN3NIcjF3dW9O?=
 =?utf-8?B?dUdwQ29mQnBmTkVSbE9qZlF4aEhrcnNrb29SRmlBQmlTUHVHOU02ZDhZMW5Q?=
 =?utf-8?B?cVhHUDRoRG94SEowcDJhOHc5blFQL0ZCN0FkTVMrUExtelhmaHh1Ly9DL2xn?=
 =?utf-8?B?SU9DaEVlY2VjN2FXNUhuSnlLcFpoTGs2YzhZTTBrN29Jc1B0T3Z0ZWM3RXZn?=
 =?utf-8?B?R3hMaU1icEtMTlZvSkxwUnU5ZmY2RUEwYTNwcndGbWhLYlVZN1dnTjJvbXJ6?=
 =?utf-8?B?ZlAzNVMwWG91TlVYK2VSUkVxZG1RV2NFZjlaSTFCZGFtbTlVN1RGVmNxRTNs?=
 =?utf-8?B?d0MvbFc0NFhPellROFZzOVh6ZU01SDN5Lzg2Sk4rRm4rS0o0MTBGTXpsQTZj?=
 =?utf-8?B?WE9CZGc2NVZFZE52TVBNMW1pY1hsaU53ckw2akxZWC9BK1lZRFhNWjRMTFNu?=
 =?utf-8?B?ajltcTE4ODBSWi9ZUVVYVko4UUZzNE1xL016VDkybjRndXoxUkluY2xad2Jv?=
 =?utf-8?B?YlZ4a2JwSTFjSzFoMmdHZzBtNjFYbGpqTmZ1TDdzc1h4S0h3ZzBhaHFuMXJM?=
 =?utf-8?B?WExONWFpWGxjdzRBYjB5b0F5N2JDUVB0dlZhYjFVL3BOWWtFMzRLY2VnS2ow?=
 =?utf-8?B?TkdWUmdoZ0hXVnI0TDFlc0M2M1k3TGpPR0loWjhsaGx5aHFxNUVCYWF5aVlx?=
 =?utf-8?B?T24rNTlCK0pjSWRPNFVueitSQ09kMTRiVGsrb1VpTy9TYy9abHRJa0hldGpQ?=
 =?utf-8?B?S0Q2eXI1aTFiTmdtRHhubGdUOFU4ZzNuLzAzcm12Q1JXcmtRNi9mTU5MU3li?=
 =?utf-8?B?OUI5VFN2SjFYRXQzYjc3bW9FbDhJU3ZOaHRsZEZzSHVSSFdsZkpiNDhBakdo?=
 =?utf-8?B?WVJXb2JPN1Nxb29vS0oxa0NxeTg4VE9qZXNkbTBEYmtUSTdpTm1ZRUs1bm5L?=
 =?utf-8?B?Y2VtUS96TVF0MS8rRjBReTM3ajNZSEoxMWF5OXZFb2JuWEwwZDA1bUhGU080?=
 =?utf-8?B?R3pvK2ZiSkNoMFZTSnFJT2p2OU82U1laTWJaYVBIMERCUFQ0amVqVG9WdEZy?=
 =?utf-8?B?WUZtKzAraHhYUUc2U2ZtdEFkdm9mR0xrdXhXaDNQL3JGQXptTkk3ZWk5RGVz?=
 =?utf-8?B?bHZ2MVpmQllMUXE1RklOcEZ4bWJ2VjVLZkZtWkRWZ3UrZTFTTVZGMVh1R1R0?=
 =?utf-8?B?TUZTVHVCZERySEhJWDkwZjFYVGtsWUx4ZU44c1Zkb2JOajJQa1p0Smsxd1ZP?=
 =?utf-8?B?d3pWVE5wZEk3NnE2eDFCVVFzdWRnMGdSd0ptV3dQODNyN25Ycnk5WVR2L3Rn?=
 =?utf-8?B?VjR4Y09hUFJqL0FFSHkycVpoSWZlejUzUUN3M3hSR2xzdlgzTG1hUnhpWnd1?=
 =?utf-8?B?VWl0VnJ2OW5wREc4SmdYRm0zUUFRNGorUkVjR3dPUStUeGl3Ukk5cERkdjUr?=
 =?utf-8?B?MHBXVEV4bVY3SDNicTRPeS9VTTFJRlgrU3hhV0szajhsaTBCV05QZ1lNaWJZ?=
 =?utf-8?B?Z2VORGwvRnI5anBLSWh1dnVOKzl4Q3N0SThXVjBnazVrWklMa1FkV3FDMHAw?=
 =?utf-8?B?U1ZUYzRjOHhKOERac3JrUmN1TTZCZjQxQVJrdTRQVkZMdzdRNHYvaUV6RmFj?=
 =?utf-8?B?ZUJra1ZLRnY2R2hTc0lTb2o2VklEaGZMb0lxbGhhZldEN2dtejFtKzkxYTBs?=
 =?utf-8?B?YjVVYmFDekRjSDhIN0cyZkdZNVZZNkxjalk5WXFkcWlEN0dqVHhsSTMrOHZa?=
 =?utf-8?B?ejhORzJLNXpCelJ1TUxFT2FxVlAvYTQwRDZUSEVMcTFnMTd4azZjTGRvRUlm?=
 =?utf-8?B?ZHdtSVdCQWlFeFZ1ak9URzZrc0dsT05rNC9pOHVRZzk5WmxEWDBpS2FjOWZj?=
 =?utf-8?B?alMzcEY4T3cyam0xYUFHaW5wV2FSOEVtU29FNVh5V0tVc0RGNFNxbVJjdUZT?=
 =?utf-8?B?WUZmeG1rR1NCTFNnK01Icyt0WmR6QmNyZ0pQRGlZa09jYmNFdDlEOUxvWnNG?=
 =?utf-8?B?RWtvU0MwMmxpWWNoSDNWTEhVcFJpd0NaVjFsM2ZEcmxCT0kxei85QURjRGdH?=
 =?utf-8?Q?T+02oiPGzNfNcqsstEk8asEYK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cabef3-6c9f-46ec-44df-08dd31c87a93
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 22:45:27.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV1xWYwI4bV3g2/IFXcA2a7n8EO4GPDS6RusAN9zgaO3GBoXQm+F5sCvJ4QVqLvWI/TTs3/OXzKTuhg0ZXwUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477

On 1/10/2025 11:26 AM, Sean Anderson wrote:
> 
> Combine the common parts of the CR calculations for better code reuse.
> While we're at it, simplify the code a bit.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
> 
> Changes in v3:
> - Fix mismatched parameter name documentation for axienet_calc_cr
> - Integrate some cleanups originally included in
>    https://lore.kernel.org/netdev/20240909230908.1319982-1-sean.anderson@linux.dev/
> 
> Changes in v2:
> - Split off from runtime coalesce modification support
> 
>   drivers/net/ethernet/xilinx/xilinx_axienet.h  |  3 -
>   .../net/ethernet/xilinx/xilinx_axienet_main.c | 64 ++++++++++---------
>   2 files changed, 34 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> index a3f4f3e42587..8fd3b45ef6aa 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
> @@ -112,9 +112,6 @@
>   #define XAXIDMA_DELAY_MASK             0xFF000000 /* Delay timeout counter */
>   #define XAXIDMA_COALESCE_MASK          0x00FF0000 /* Coalesce counter */
> 
> -#define XAXIDMA_DELAY_SHIFT            24
> -#define XAXIDMA_COALESCE_SHIFT         16
> -
>   #define XAXIDMA_IRQ_IOC_MASK           0x00001000 /* Completion intr */
>   #define XAXIDMA_IRQ_DELAY_MASK         0x00002000 /* Delay interrupt */
>   #define XAXIDMA_IRQ_ERROR_MASK         0x00004000 /* Error interrupt */
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index ccc4a1620015..961c9c9e5e18 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -224,22 +224,40 @@ static void axienet_dma_bd_release(struct net_device *ndev)
>   }
> 
>   /**
> - * axienet_usec_to_timer - Calculate IRQ delay timer value
> - * @lp:                Pointer to the axienet_local structure
> - * @coalesce_usec: Microseconds to convert into timer value
> + * axienet_calc_cr() - Calculate control register value
> + * @lp: Device private data
> + * @count: Number of completions before an interrupt
> + * @usec: Microseconds after the last completion before an interrupt
> + *
> + * Calculate a control register value based on the coalescing settings. The
> + * run/stop bit is not set.
>    */
> -static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
> +static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
>   {
> -       u32 result;
> -       u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
> +       u32 cr;
> 
> -       if (lp->axi_clk)
> -               clk_rate = clk_get_rate(lp->axi_clk);
> +       cr = FIELD_PREP(XAXIDMA_COALESCE_MASK, count) | XAXIDMA_IRQ_IOC_MASK |
> +            XAXIDMA_IRQ_ERROR_MASK;
> +       /* Only set interrupt delay timer if not generating an interrupt on
> +        * the first packet. Otherwise leave at 0 to disable delay interrupt.
> +        */
> +       if (count > 1) {
> +               u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
> +               u32 timer;
> 
> -       /* 1 Timeout Interval = 125 * (clock period of SG clock) */
> -       result = DIV64_U64_ROUND_CLOSEST((u64)coalesce_usec * clk_rate,
> -                                        XAXIDMA_DELAY_SCALE);
> -       return min(result, FIELD_MAX(XAXIDMA_DELAY_MASK));
> +               if (lp->axi_clk)
> +                       clk_rate = clk_get_rate(lp->axi_clk);
> +
> +               /* 1 Timeout Interval = 125 * (clock period of SG clock) */
> +               timer = DIV64_U64_ROUND_CLOSEST((u64)usec * clk_rate,
> +                                               XAXIDMA_DELAY_SCALE);
> +
> +               timer = min(timer, FIELD_MAX(XAXIDMA_DELAY_MASK));
> +               cr |= FIELD_PREP(XAXIDMA_DELAY_MASK, timer) |
> +                     XAXIDMA_IRQ_DELAY_MASK;
> +       }
> +
> +       return cr;
>   }
> 
>   /**
> @@ -249,27 +267,13 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
>   static void axienet_dma_start(struct axienet_local *lp)
>   {
>          /* Start updating the Rx channel control register */
> -       lp->rx_dma_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
> -                       XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
> -       /* Only set interrupt delay timer if not generating an interrupt on
> -        * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
> -        */
> -       if (lp->coalesce_count_rx > 1)
> -               lp->rx_dma_cr |= (axienet_usec_to_timer(lp, lp->coalesce_usec_rx)
> -                                       << XAXIDMA_DELAY_SHIFT) |
> -                                XAXIDMA_IRQ_DELAY_MASK;
> +       lp->rx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
> +                                       lp->coalesce_usec_rx);
>          axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
> 
>          /* Start updating the Tx channel control register */
> -       lp->tx_dma_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
> -                       XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
> -       /* Only set interrupt delay timer if not generating an interrupt on
> -        * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
> -        */
> -       if (lp->coalesce_count_tx > 1)
> -               lp->tx_dma_cr |= (axienet_usec_to_timer(lp, lp->coalesce_usec_tx)
> -                                       << XAXIDMA_DELAY_SHIFT) |
> -                                XAXIDMA_IRQ_DELAY_MASK;
> +       lp->tx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
> +                                       lp->coalesce_usec_tx);
>          axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
> 
>          /* Populate the tail pointer and bring the Rx Axi DMA engine out of
> --
> 2.35.1.1320.gc452695387.dirty
> 


