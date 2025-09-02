Return-Path: <netdev+bounces-219014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8877EB3F63C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1173AAE75
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2F2E62C4;
	Tue,  2 Sep 2025 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ec6K/cHQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FD2E1F02;
	Tue,  2 Sep 2025 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797124; cv=fail; b=rPUmxKrvq5j/9GlMAmN0cvTOqbHq90dRaagfUqiHmiqBsS5eI9a+zYU5Kpt0RpYQV3eQb5xXA1EMM0a91jeu+VYtDcPYfMqDTorRdm9gyGSMYcWTCCP1IRJ1qm9ukTQiAqTZoIOU8GQDK7N4WKwGhut4Qu9aRpBcUMVQpmGf9C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797124; c=relaxed/simple;
	bh=0YgfwiBm//JkJAw0znR1TjjZTxc6lhQK2L+Acs1Q6/o=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lWRgpXrzJfAIdfilp99X3LFqTcdRBeDc8Pg58OprS7JSr2jltlWter58UY0/ejXGRQlc2wlJRbwkxIdLHXhxOvrSEwT+AL/4zOyZySOfsEygJ0we7hFa7zjCIysRSfACw8tb+mQ/8dFG7nEEGfeEvfEzo2B9k7TIc3/W5oHXn3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ec6K/cHQ; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuCDOv334xnEpI2oT0iuwIsE0N5GNjF+wAh3X1tb2Moq3bmVl3qneA30kdL6bj8RLVNOgzw9JMnOxhxbZWqX4mhtcGi9TMw+5KN9I5sLGaODwLNcsG+DpJlxsmBGJLEuCrETQyzjoHsE0mIxPCM7wmcu0M2XzPt4PtM51Pi4EVelocl4c+qemsgSfdiG71pfzfP4nftMTEAGD600VOJM0k3zyRi84qx681JCqgQneRpEnzgSz2Et+6uf1gAJ+/21TvYC+befFadc7ImxOle53UGbhPO06zXXfnW+m9aUP+UcBdT2Qj/69kvSAMPstZDq7LYv4N7BLGrNZTy7tlpONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxn5wZUzKO/8Re/uqlZxyV/JN54sDTQ6MMPXKGx4mxE=;
 b=i92Pd9IO/dIxND+Q3OxNan5GzYV9i9oi20HTDfqEY8Uqfn7AadEjp0ZBk19jLfuKBoajghlnp0ebj91qYfZojyNO913dGbH/m87ymPoFytxYZPl7GM95wJwa38wWE91GzznFsV461W4t4DMcfaUEF0v3xmv5L4piOyqdjTwHUvJTPfgN3pDAxfwxiQPl2n80OLEAYQtnkLeCev0RRBqrw11aVPLvAZepkEelkqzzgZRVx0VO9geucXrOLlTWUwxM/lvEGlD5J9Ebp3aAkGW8LHhtXoA4ERKeM1NFFJyDT/+RQrqESzKq3yoVRVD8qMwcet3KzhNKQjLBEpAr2trALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxn5wZUzKO/8Re/uqlZxyV/JN54sDTQ6MMPXKGx4mxE=;
 b=ec6K/cHQ4YKfaxM4jX/zjRak9R+PwqKDaMjY7p1tGxmVccqeooRrVbbZywZvc5OhJGSLT2m+y6MFF60AagwHCS2hxbcJliiAwY5BuqeoEb7qRswbMpzvybNmauoW3raQUZ4bJHbbC2FNtblVnnF36K5WwIFMOTS0oDgzIUzrONE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:11:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:11:59 +0000
Message-ID: <3887fb34-a844-4769-b0d2-ffb7b6cd4585@amd.com>
Date: Tue, 2 Sep 2025 08:11:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 12/22] sfc: get endpoint decoder
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-13-alejandro.lucero-palau@amd.com>
 <6887a5956dc2d_1196810015@dwillia2-mobl4.notmuch>
 <836d06d6-a36f-4ba3-b7c9-ba8687ba2190@amd.com>
In-Reply-To: <836d06d6-a36f-4ba3-b7c9-ba8687ba2190@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 66573ab7-7d0e-47f8-6cea-08dde9f00212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3RwRHNsTmZYOEFWWUx2RXgwL1oycVduay9Ud1FUdFVHYm5MTjdkQk56bU56?=
 =?utf-8?B?V1NROGsrcVBndU51SExyNm5NeGxubXB3a2Z0a0E4WGo3WWlqbkVtNlZVdGpk?=
 =?utf-8?B?YkFUVyt5MDd0a0t4K3dMV0F1UzRJUmRmRXluZnFFUXRwb0x2TVgvZ0txRDlY?=
 =?utf-8?B?enQwVkdGUGtYSXREanA1bXJzTlU1WEVxb3dyNExKQTl4UEdCRDlOYXhNZE5M?=
 =?utf-8?B?ZFIyRTNaYVNnMWQwQ0p4dUJRU0x3NlFrNEhwaGdiSzJlQkVBdjR4UVB6Z2ZX?=
 =?utf-8?B?alJyTTE5WXNtMGtXWWJLMklIOWFzSi9RUmVoL0xLWGJlak91RTRlK3ozQTZi?=
 =?utf-8?B?empyNDJ6eHpBWllqS2dQS1IyeXB6VE84NnB6NCsxM0V0S3AzTy9PSXhldGJv?=
 =?utf-8?B?NGdVSG9xNVJnUEFMaVZmMWpJWWZ5aHlrMzE5ZytwOFc4OXJhN0ZrRy9ZRXUx?=
 =?utf-8?B?bTFndFVPc0dyelEyczBiZ25QM0Z4MnpwdUpSQzgvV0VmSXZKQ3lZT2M0YmVY?=
 =?utf-8?B?NlRyUjFwN1IrSFhLTURDN3gyYnlodmRITndrc3ZNTk1pbFd0VTlmaU01dlFS?=
 =?utf-8?B?dEpMM3BXMG13YnNmY0d3S0dOWjJ5RkVPOWxKcWRRN1Z6SVl0Z0xxSkZQZXR6?=
 =?utf-8?B?aWJIVDhKUVZhcmcrdStHc2JHOFptRTkrY2Q0WWVac0dPR3NMbzM0bkpYTmRN?=
 =?utf-8?B?MGtsYTJ3YXNXVGxEcmQ4QWVlYVprUEhiNmlkRXdyNyt1YkRsWVBMTnBJRXlM?=
 =?utf-8?B?MExUUWYrK0NURytxSTZ4T3pLalQ1MEtXcWxxVnpFemZHOEN2U0ZpTStYZ0Fq?=
 =?utf-8?B?blc5QnR5c1BON0twYUdnMkVXeE4vcE41SWhiejZOQVdpT3FDT3R4Sm8rT3FX?=
 =?utf-8?B?c0Q4aytQb1l0NTJMY215RE9iSjVWOEpQWDZkNXdkWllWamFJYlNwaHgyMjRZ?=
 =?utf-8?B?cG5nYWNsQ1dQa0dpSHRSaHgxYkRqNUJMTGZHZEdnR0pNSEtyUDJ0eUgxQ1Bl?=
 =?utf-8?B?UzdzMm9mS0Vac2VvVnFxdzR1Qmo5N0R2c2ZZTG5sNHNId1JUOTJhSlNzRzE0?=
 =?utf-8?B?MUNrbnROL3JqSzQxUXZnL3VySzI4MHhEMzk3SEMvSUptK1gzbU5pb2pCNzBG?=
 =?utf-8?B?UEdPdCtQbCtMbHV0UDdXdkRkZ3N0bkptVUt4akkvM3RJWmw5ZXBrUDNEWWhn?=
 =?utf-8?B?MmVPa2ZCeGRiVW5uZU5NUmh4L3l4alpqT1JXWkpoeFRyWjg3cnRxWlpBRzVZ?=
 =?utf-8?B?aVRTMTMyblVHTDNJNHY3MU5pOTU2ajBEMjNZamNBSVdIb3hoOFBwQTltMHZY?=
 =?utf-8?B?d0M4S2xJcDNTb0NwYi8vRTdHSzQwb2E3aHdrZ05zZGEvNmU3YXJVN014STRX?=
 =?utf-8?B?TjJtNU0wZDYwckFpV0NFNXp6U1BPajJXU0dYRExjT0dmS3BINWdseUo3MEZs?=
 =?utf-8?B?V1RBMzJaRUl0NmhtSzB5TDFrT1JYdVBiZ0FNUHpPUzczRFNVUWxYNjBCcnc2?=
 =?utf-8?B?NFR6cm1WemtKelVEeUlLME14Y1VPQW1uWUM5dkRSVXR1cmNadkNMR05yRTBW?=
 =?utf-8?B?SXFrVFBoUnlGcjgvV2hlSnpKN3hnZ0YyUWZNZ0xTUkcrT0hzRkRkeWZUNFJO?=
 =?utf-8?B?eWd5OTkyMW83VlFPczdzUTl4cUdVcEtZSE9yYm1EWVEzZE1nN0xHd2s4VjJv?=
 =?utf-8?B?WGtHMkh5YnJKSnpvQ2luRG44Qyt0enJLSEtBY21xZVM2TFc5NjRCVmxtTS9F?=
 =?utf-8?B?MDduOXl4eXl3SjRJRzVIOTZEMG54WlJveklXeW13R1NwWU5YVXFhV0FrUmxk?=
 =?utf-8?B?WGNjSnRVRytjWlVsTnRycUVUMmNjMlRoYWg1dEptd3BsWDlQTEtxZjFQQzVn?=
 =?utf-8?B?bERZdVpaRTYrQnVGMEJCNWJlVkgwbHRqMlhSM21KV2srblc5N05jMFFqd0k2?=
 =?utf-8?B?eHp1SFZYcDVnemFqUDdDeXFtdnVhdktwWGhFelNTL2poT0xGMTZ0dTBvYlhP?=
 =?utf-8?B?QWhrcEZuaTRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWQ2WjNMMlIyRjNZYmVPQXU2K0NSUXRXS0FucmE0VUtMZThQN2RGWUtuOHBt?=
 =?utf-8?B?bEloaTNhdGNRaHozUThCOGszTU5IZ21KakppbkpUVnlydHNHVXR2Rk1NUmYr?=
 =?utf-8?B?T2JwdVU3L0hkMVowVXRUMzlhKy93RkVJeWdrLzFmTHVVeUFESmEzNHp1YTVZ?=
 =?utf-8?B?eU52ZUppZFBJbzNyRm1lZnE2VkVkUWprUEhqTURsWUhKOWRzNzhHMURuZEFG?=
 =?utf-8?B?YXRkQk1nVXNrb0xsMjdsUWpqd1BEWkJuOXJZV1M0SmpMTjZ3WVV0eE9ma0tv?=
 =?utf-8?B?bHlYUXl4cnZDNjNRWmJOcjlFY0lrMnFreTA4UG9yZXMydUNFY2Q4ejM3VWFv?=
 =?utf-8?B?NDRmVWNVRlBMK3Y0VUgzZnNCek5BZjY3cEhzVURDd1J1VmhPamlMdkdLengz?=
 =?utf-8?B?QVJjVjErQjZpeXRSUDJPVzFjYVdxenNhQXNEOENXMXRHWGhTdVl0VlZOd01M?=
 =?utf-8?B?MFRIYmxyUURFOFlGRU1jdGgrNHA2elhoQ0ZDNGFUQ3UyMGFDaHNJYU1SV29X?=
 =?utf-8?B?VmxEWGtDWDdaU3h6STQ1eldyd1FIallKQnI3SmhZSTJtYjZBekxzTjAyNUdy?=
 =?utf-8?B?bU8yV21Ib2NIUTdXMXlDRkpYVFJpUHM4VVNKNWxUaEFXeTJHaHNibXJ3aUps?=
 =?utf-8?B?d0U4NndQdHNPOHJkUnV4bTMvcFFSVlFuSHFpYnZZT0FVOEdVVFdkWWs0SVBG?=
 =?utf-8?B?LzVpT2F0dTI0QkxaM3h1aXpoNnplRG5UR0JxRzRCY1RMS3lKWlVUWXdTYmg0?=
 =?utf-8?B?ZWNtcE9mYXUvZFMzU04xc09HWUphdUlXeUszZWp6RnhIZ2djUmI3ZUJuaVI2?=
 =?utf-8?B?K213c2pVM01uQ1VxY3dWbEF5U0kwSkVDSXVPckk3VDJVbCtYb0ZlTmJmdXV6?=
 =?utf-8?B?S0VKdDNMd0ZKaDR3ZnBqaXcwRzZDbmxMQXh5V2pEcUFtRWFZTzRzQWxzbnVi?=
 =?utf-8?B?dnE2S2Z3cVJ0d1ZlS3V1UGZ5VkEvbWZ5ODRiZmw5WjIyLzNDcFNkSUhVT1NN?=
 =?utf-8?B?UC9zd25uY2FYOVZkSXR3enpDQmc3Yk4wYmVubGY5b2NXb1ZONzN3OXJQa25u?=
 =?utf-8?B?akd1aUVKcmUrMHBLM0dyOXBEbUZVRmtyL1VlRlh3QTVOZmwwa0txVW8yUFdL?=
 =?utf-8?B?T2pHU1loTFBMVTJQa1VGN2JtbDJRNTk3OElDOTFyZ3lvNFppUWtiOFo4YXEx?=
 =?utf-8?B?UW9lQnJiVUwrQXg4RkRBUElYOStta3ZvSlFMS3p2QU1jUmZlRnRDdDNEWnZS?=
 =?utf-8?B?TW1xbjlLRmg3cVN6R1YzZ3krM0Q1bERDdGxORjZpZDFDaEZTcGNmSXNERnZt?=
 =?utf-8?B?YlFrekZoRTlITHhWRDg2bXJnUzFMa0djdUViYzBBaS91MlFkVFBSMit5UnZU?=
 =?utf-8?B?M1BDK0cvUFdPbGJnL0NiaXBhaUxIKzZWRko4Q0FXRDg1SGhUV3F1QlRidE13?=
 =?utf-8?B?dnV4WlRqVjIwZUQ5d3FpL3NOQndVNGlIZWl2YllzM01mTEVzemJINWdyUWJ3?=
 =?utf-8?B?MkQzcVFsSFpYc09IUUZCZnI5VVgxYXViZjlSMnpGdk1GY3c3a0VuRDNkeklx?=
 =?utf-8?B?WlRvRnVuKzB0VmZpWVpCSW9SdVcwd0JJdkFpL2g4c3BQSGlDSlRyYWRBMlFn?=
 =?utf-8?B?cE9nYnlsTGNCZElxZ00rSGJCYldLWlFkUFVnbXdhcnh4OGk3VUEvVm80dmVU?=
 =?utf-8?B?cy9xQ1dLd0lMcXpXcERVK1Z1MHhyeHFiK1AwY21yUyt0QXhJM2dmc0R0Zk96?=
 =?utf-8?B?Y3crZXppN242ZW9kVVlVVkhSRmpBdDhpcjArS2ZYL2hxWldJL3U4cUZreGdM?=
 =?utf-8?B?OW44bDg2RFhEdUx0RThPNmc5SWpWbExtQkFDYlNhbWRLc21uYkw1cUVsUGdu?=
 =?utf-8?B?d1M5VSsrMUVrT0VPd3lUcXoyZGJyM0NyVVFxdGliZDQ0UkU4Lzd2ZzdjS1lr?=
 =?utf-8?B?aUtCQ2dBQm9QNW8zZUNCdTlkVGo0am5aaGxrZWwxZ3lYNCtIUWg0a1IxSzFO?=
 =?utf-8?B?YUNnRy94ajlFaUpqYzFueDMyVFp2OVhjU0dhQ0k0a25NbDMzMjFDMDdzZHRW?=
 =?utf-8?B?RjBMUGhnWmozZzRWZk16Mm9BTUhDWW1vbkRmYWR0czdwdnEzZUx2S2hHS090?=
 =?utf-8?Q?X+RLYZcwYh0jbQ3GZ6iOYIyq6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66573ab7-7d0e-47f8-6cea-08dde9f00212
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:11:59.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjCjql3TjWBkgOKuppMlQNa5I+6S5DEUfJ+Y+9q2Yd3GyPutWAaGKdLv/NxFywj1c4n2Fg+6PbEeFkh/uSyD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082

Hi all,


I just want to refresh this discussion below. There were not replies to 
my comment, and I would like to have people's comments since I consider 
this the main obstacle before sending v18.


Thanks


On 8/11/25 15:24, Alejandro Lucero Palau wrote:
>
> On 7/28/25 17:30, dan.j.williams@intel.com wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Use cxl api for getting DPA (Device Physical Address) to use through an
>>> endpoint decoder.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>   drivers/net/ethernet/sfc/Kconfig   |  1 +
>>>   drivers/net/ethernet/sfc/efx_cxl.c | 32 
>>> +++++++++++++++++++++++++++++-
>>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/sfc/Kconfig 
>>> b/drivers/net/ethernet/sfc/Kconfig
>>> index 979f2801e2a8..e959d9b4f4ce 100644
>>> --- a/drivers/net/ethernet/sfc/Kconfig
>>> +++ b/drivers/net/ethernet/sfc/Kconfig
>>> @@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
>>>   config SFC_CXL
>>>       bool "Solarflare SFC9100-family CXL support"
>>>       depends on SFC && CXL_BUS >= SFC
>>> +    depends on CXL_REGION
>>>       default SFC
>>>       help
>>>         This enables SFC CXL support if the kernel is configuring 
>>> CXL for
>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c 
>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>> index e2d52ed49535..c0adfd99cc78 100644
>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>> @@ -22,6 +22,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>   {
>>>       struct efx_nic *efx = &probe_data->efx;
>>>       struct pci_dev *pci_dev = efx->pci_dev;
>>> +    resource_size_t max_size;
>>>       struct efx_cxl *cxl;
>>>       u16 dvsec;
>>>       int rc;
>>> @@ -86,13 +87,42 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>           return PTR_ERR(cxl->cxlmd);
>>>       }
>>>   +    cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
>>> +    if (IS_ERR(cxl->endpoint))
>>> +        return PTR_ERR(cxl->endpoint);
>> Between Terry's set, the soft reserve set, and now this, it is become
>> clearer that the cxl_core needs a centralized solution to the questions
>> of:
>>
>> - Does the platform have CXL and if so might a device ever successfully
>>    complete cxl_mem_probe() for a cxl_memdev that it registered?
>>
>> - When can a driver assume that no cxl_port topology is going to arrive?
>>    I.e. when to give up on probe deferral.
>
>
> Hi Dan,
>
> I think your concern is valid, but I think we are mixing things up, or 
> maybe it is just me getting confused, so let me to explain myself.
>
> We have different situations to be aware of:
>
>
> 1) CXL topology not there or nor properly configured yet.
>
> 2) accelerator relying on pcie instead of CXL.io
>
> 3) potential removal of cxl_mem, cxl_acpi or cxl_port
>
> 4) cxl initialization failing due to dynamic modules dependencies
>
> 5) CXL errors
>
>
> I think your patches in the cxl-probe-order branch will hopefully fix 
> the last situation.
>
> About 2, and as I have commented in another patch review in this 
> series, it is possible to check and to preclude further cxl 
> initialization. This is the last concern you have raised, and it is 
> valid but your proposal in those patches are not, in my understanding, 
> addressing it, but they are still useful for 4.
>
> About 3, the only way to be protected is partially during 
> initialization with cxl_acquire, and afer initialization with that 
> callback you do not like introduced in patch 18. I think we agreed 
> those modules should not be allowed to be removed and it requires work 
> in the cxl core for support that as a follow-up work.
>
> Regarding 5, I think Terry's patchset introduces the proper handling 
> for this, or at least some initial work which will surely require 
> adjustments.
>
> Then we have the first situation which I admit is the most confusing 
> (at least to me). If we can solve the problem of the proper 
> initialization based on the probe() calls for those cxl devices to 
> work with, the any other explanation for specifically dealing with 
> this situation requires further explanation and, I guess, documentation.
>
> AFAIK, the BIOS will perform a good bunch of CXL initialization (BTW, 
> I think we should discuss this as well at some point for having same 
> expectations about what and how things are done, and also when) then 
> the kernel CXL initialization will perform its own bunch based on what 
> the BIOS is given. That implies CXL Root ports, downstream/upstream 
> cxl ports to be register, switches, ... . If I am not wrong, that 
> depends on subsys_initcall level, and therefore earlier than any 
> accelerator driver initialization. Am I right assuming once those 
> modules are done the kernel cxl topology/infrastructure is ready to 
> deal with an accelerator initializing its cxl functionality? If not, 
> what is the problem or problems? Is this due to longer than expected 
> hardware initialization by the kernel? if so, could not be leave to 
> the BIOS somehow? is this due to some asynchronous initialization 
> impossible to avoid or be certain of? If so, can we document it?
>
> I understand with CXL could/will come complex topologies where maybe 
> initialization by a single host is not possible without synchronizing 
> with other hosts or CXL infrastructure. Is this what is all this about?
>
>> It is also clear that a class of CXL accelerator drivers would be
>> served by a simple shared routine to autocreate a region.
>>
>> I am going to take a stab at refactoring the current classmem case into
>> a scheme that resolves automatic region assembly at
>> devm_cxl_add_memdev() time in a way that can be reused to solve this
>> automatic region creation problem.
>>
>
> Not sure I follow you here. But in any case, do you consider that is 
> necessary for this initial Type2 support?
>

