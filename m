Return-Path: <netdev+bounces-126773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A389726A2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 03:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B731C223F4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420327640D;
	Tue, 10 Sep 2024 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q2ujRDDi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014F37165;
	Tue, 10 Sep 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725932057; cv=fail; b=sZD3X5/qOtZjDJgDDxLE/UBbrPrJA8Od/LSnMQyKzvuSGuEtIdCS0mpZDmhrGNyo22u4qhj6cHAe1iypOhLMoZKR8Im5nguOUZLWw07Z0q2WkGIu1o/wSyTmp0bWQ0W1iHugcO2/DK9bmVBXMB5uq3RDMkW/WWwYKZOP49+cSQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725932057; c=relaxed/simple;
	bh=TY63S/8qDMmdvotyP2Lb7dx2sFFKOoEwlkmYhTmz0J8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ss2FPPrtq9vN6FGNZ6u+P63KXiC0te1JD8KtD8hZoVP9OxiziuCwVZRg+qKTrv3tOhNrvzvm9bhR87XQXRUI/T8u0uV9UZsu5XwRsEpKfOL6lK9r3Yqk+/2qthpvT22y43GTEjZj5oO4zI94069CIpnN7xAxr6/qmABvG4KdDIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q2ujRDDi; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbBx7Zgru7iZT5OqIVFQ35NBgqDU1ta2WYZsTUc3NxT2EPtwEAgHRjO1ZC/+vWYkDQqax91u5mpBUta49Gc7EeMg0f7FWQvb8v9/OxTc3rPE6fzhzqbsuBGrb0uPi2cFceo+cTFlQAH2Xqgj8iVXpX/xIE8d/uICZ90pDA7GimlPQ8nyIrMCmfjeMuLOlBCMkDx7Cmtk2maPtoBRbbwlKk68ih0Y+JpAfa3B8BTZQP6ovvuEsVW7EC5eSVgrqzzfn/l/ykR2TW+cMJ3KNERpmTaa8hKkEvNBOYkx25aC2X7AzyGXAg+iZVtMtHtGtz2cSYWQbu3v99SXDPK2C6thcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hai7IRYNvAd6PPHKKlIFWCgwA1KxrXazA0BZImDOz2Y=;
 b=bUIufHngj8w1ykEcsRodxOBbBN/sNqBmM8sVnKq1/UOxLlHc5Bf5x5aaKUwcw6KPVPBVPth3eWFxw/eyk8qfnqNavlNWkw2J1aTc8ADbbUorEyGRKXAUHvXNQF4R0Vy63K4rkpEjCH5xPmUMWvUBMRl6eNAQwQlm7wF7bFKGGF8uILHspQIKq0rfRK+gcOPlov/BOHBV/9ZK2lgD7IAZ0gmavXBBpyoJn4Hg2FOk4WxTu50v7ldIZpWskdQ1kDfdxt6di1ozXMRtUATZo/SDyJdOzgT0D+AeqBTizem4Cfh7Ku2UdRZxHw1AA0RsrNGqAzvq1WvUfKqqpcKPmHCFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hai7IRYNvAd6PPHKKlIFWCgwA1KxrXazA0BZImDOz2Y=;
 b=Q2ujRDDi0gsmxmPLwsuEJ9vVDmpb7wMfK2mv+ntiP8SDMNO2xnigR6YB2Df8ZCbHxULKeWEYvhdagEBEshagJb8z5Oz5GxDdMiPvyiFJhKcRvNgU88eGqHahPN+Ma1XuBcKpft69QAi6MStqnZ02369Rp8r/IlvHKSYnMQ8A4iA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 10 Sep 2024 01:34:12 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 01:34:12 +0000
Message-ID: <d56ff939-cbcb-4455-b589-3a87b0ec57a4@amd.com>
Date: Mon, 9 Sep 2024 18:34:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 0/6] net: xilinx: axienet: Enable adaptive
 IRQ coalescing with DIM
Content-Language: en-US
To: Sean Anderson <sean.anderson@linux.dev>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20240909235208.1331065-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0240.namprd15.prod.outlook.com
 (2603:10b6:930:66::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd101f2-d6dc-4595-0fd2-08dcd138ac90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WW1IanRHaS9mQ1RiNVdjUHhBZFg0TW5MUWN6VkhEcnNwQUIyaDFQMU1nZHpR?=
 =?utf-8?B?aXlxdFMzZmR5ZDlSNVZSSGVsNzlhakZHRGE1TWY1TjdGZFFGanEwTHB1NFg3?=
 =?utf-8?B?em1Fb3pCVlhKMHF0VTlJa1g3QVpDSFRLQnpveVV5aURzZWFaNkxCblNZYVhI?=
 =?utf-8?B?LzZBWGFUdldWZi9OcU12TkpRUlB1SWJqYWhwQzNPcTY2cVd2QnFKZGRIOGFD?=
 =?utf-8?B?NENWb1JrS0FPUkVnUDNBc0VnUEtPYVVhR2NmMFNIUW9pTE9nSmU2NjM4c0VE?=
 =?utf-8?B?K3hCUjBmRUZ3R3VBNWw5a3ZDdFl2SzVRbzMwUlFLdVBBOFZMdWtuTUNYMG0v?=
 =?utf-8?B?Rk1DSWdtM1BncnUrT0d5a0dDd1NyakFCSnJ0RkpFOGx6UHNvMGJnb2tTYmxU?=
 =?utf-8?B?ZEZ1R29xL24rekRrL2NMa1BzT25xcDlZekFHWTlOSGVGVk52VzJZMHhoZTNI?=
 =?utf-8?B?YWthVkdpMlczUGllOTZUaVYrSUpsQjArY3F5NEE1U1ZRWnNNM1N2cnhqTENG?=
 =?utf-8?B?ZmYzZlZQbUF5MmNWczFlWEVNdzUxaW1kcG51Uk1xZVdxNEt3TkpEOUU5MGtk?=
 =?utf-8?B?YnVmWEx4Snc1L1drUkZKRUhWcEFzanBQb2hJdnVLUEtSdTJrenRVTzhxSHh6?=
 =?utf-8?B?aEtCNVlSSEc0VExLQ2VKU2dXVVNPWUI2WGQxZDlkNFE0THhMb1VYVkdJQmlT?=
 =?utf-8?B?S29zUXZoKzR6M2hnbG1RK0xTb0dGZ3hQd2F1STFzVWFSVmZ6UDE1NVpuQ3Zp?=
 =?utf-8?B?VHhjWndGbE5pMmh4UVBzd2RPR0pzaFR2ZXNUMGQyaFUyQTRJN3A2dWRDVEZr?=
 =?utf-8?B?bFJSV3pIMTdxVTVhbmhLRVBSUFNGSmFrcHBiUVVMYzB4MDZpVjc4djk5QzF1?=
 =?utf-8?B?ZTFHZkJLY1ZKV2EvQlgvbVMrQUUrVjhac2h2aEJXQ21na2l5UzFSdE02emVT?=
 =?utf-8?B?T0pOT3pTcGtBWTR3R0UzNXR5U0k5aHB0WlhHYU5GanNLcVYzckNlYU1JcWh1?=
 =?utf-8?B?UDF0Kzl4UGs3VUlqRHlIalpNdWFlTmo3YWQvRkE0eEpSVkgzRDdUaWhyZEJ5?=
 =?utf-8?B?Y1ZIYUFpTVIvNCtmSTZ5NHFnemgxRy9jcEo0Si90bE0wM0F5NWZQV01VYk5i?=
 =?utf-8?B?TDFtZ2FNeHJYT2YxQUNkNzg0bG9xV0ppVVZiZkQvT0hERkdveitXNjdKbmRV?=
 =?utf-8?B?M0p4RFM3NlhKT1BJR2tCWndzRHY0T0FyUlVraDF3eTZneUNscWdVYml2elA5?=
 =?utf-8?B?cWtvTkd0eVRubnFkbVhlMDFKcGVVQUFUQUNKaVVtaS9tSG9pd0hlK21MUjZo?=
 =?utf-8?B?bGtnWUxRSTdva1h3ZGlSK0djcFJrYUZCWExHM0ZUS1BZamxqVDhiYUZhWXNl?=
 =?utf-8?B?ckh1c1NUNGhqOVhiNjZZQlZSRkIzSm01QWlrbDFrZVNuUlNQVDl5cmxJcHlO?=
 =?utf-8?B?SmhxTnNwS0NSUnhLYW5CVURFOEVwdnh4ZisybE9IVTRJMC9xdndjMUxsODBP?=
 =?utf-8?B?RHBpMGJIZjlFcnl0SlhGdHg3cWM2cjlsbDVBWVRuVnA5bXV6ZU5nSHZMcFAw?=
 =?utf-8?B?Y05iWTBGUzlZSkt1c1JVaWwvZlJNUUF1SHo2cGJZQ25GWm05RUxaUGdTYlp2?=
 =?utf-8?B?cFhaaDhYRkJpZWdoQW40bXFoRzB6SVgxaVlraE56ZG8ydGNqYTNINGU1MVVE?=
 =?utf-8?B?ZnlScG8zcUpPbTJCL3RjSzdnVXR4aUMxSERNbWZzWE5rb1hJSVdMNTk1Nkp1?=
 =?utf-8?B?VjZvNitObUxnV2ErWEFxeERZZkZQTC9MOXl1eVVURGZNQW9sNEwzNTY4dnd6?=
 =?utf-8?Q?zjhunc5P2Wo9Hsf5JxU3HAVE5yQ3eGZjRHAYg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N011d0Y5QUZ0Ym5wMmRpSlNOMXFRNFo5dExWVDFMUWFlcUtHbnpvemhuSnNm?=
 =?utf-8?B?cnAwZXZkMFdPVFBQNi9ITWFTLzU1OTREdHViUzd3ajF1UnlGd05xZnVLMEZz?=
 =?utf-8?B?d0JnVE8vRnExeDR2Ri9CTlZidm43R0UyYklJNGlJNUExZmZPMHZidG1RV3Mw?=
 =?utf-8?B?NzVESWc2dzMzQnRnZjFwbnEwWEdmQnFjdlloWFRRZkdDblVETFFXUlVaelZX?=
 =?utf-8?B?Y1NpNHd2aEU3dlBNSG1LVXdwWi9YT2ROc0xabFJLSnBoSTl6NXo0ZlRHZFBN?=
 =?utf-8?B?UWlJNVdSd0VMZDBHaGJBNzZVb0E1Rkt0YS96aTc3a3ZVM2dNY1RidndIYVh3?=
 =?utf-8?B?ZXVjamN3VGJmSmVCbFpCZXM0aTFrbi92WTB3M3ZidnF0eEQ0NTNNZGsxVFd1?=
 =?utf-8?B?RXd2OWNSRUxKWHlvZDViQWtObks0Y1lYUFVQS1VIbkFQOFBvOVZGWFFCdm1h?=
 =?utf-8?B?VmtiV0xZUjh3bnU4REJER1RuUTJqdVhleW1CSU13N3NHSzdvTy9mek0wblJ0?=
 =?utf-8?B?ZHlNTHBMbU0yc21ETG1EN1JZc2dsVzdGa1NOaEh6MmR0NVJVZVgyWitRQWtv?=
 =?utf-8?B?ckpwMFVIZkFJRm9KYnRkdVFFc3dacm9JS09LOXFWRXByRDFzL3VwWlpnUjZG?=
 =?utf-8?B?MW5takxEL3ZNUCtZRG53cGpXZEVEa1dkbk9ZUmdQOGFreXFCeHRHN3V2YzBU?=
 =?utf-8?B?R0xEc0xlMEpTZlFaOFhwN1J1TUEwYU1zVE43dWVteVpDc2dFT0RSV3BmRVVX?=
 =?utf-8?B?UFNKelNDeFo0SEpZV0hMZSs1YXBrMzh0R0Z3VWQyczQ0Q2RKbTZzOHRBUXZp?=
 =?utf-8?B?T3VFdllXcXBITnlaTGdiUFh0UU9KNDRQcWgvU1dPZE9RS2pOaURPVndwQ2Z0?=
 =?utf-8?B?MWZUMVBtN2lDcDN4QlJkaEtiYkczVkY3eGNSV3BGTkdKNFNMTzdvWUwvZ21E?=
 =?utf-8?B?a1U1TTdYNHovazBRZ3pJU0lobElJRS9OVVhkMTlOb3ZlR3RrVVhSS1NkeitF?=
 =?utf-8?B?MVcySUxwSnBscW80RkUxYVRSRTVmSlgxbHcwcUM3Ump1K1JjK1NZTzJtRTFC?=
 =?utf-8?B?RmJ3NU9FYjJFSUw5Y2dib2FtNjBsT2poOU9vbzhSMW1oNEE0MjVCdUM3SkNX?=
 =?utf-8?B?cy9aZHp1a2k4dGZZM1EwTXA2TGdtaG9tM1ZGVnFnbHRGQ2hPYmtGbEJqcnZK?=
 =?utf-8?B?SXdHekRpUkNaWXQwa1VXN2Y1YXNUL0E2QzdsbHI2T0RDQ2d4ZnpTTEpLdExV?=
 =?utf-8?B?RlEvYWRBckpPbEZPL0FTaEFuUnlvMVk0MWdNYnB6TmZrZktsdVdFZGUrOXFp?=
 =?utf-8?B?aXlxbFVSNWFSaUtUYmpJOTdwUTZqcmNPd2daRjZrdTByYWFTU3dDdG84Uno2?=
 =?utf-8?B?OFptcklBUEQyYUEvOGFWajUyZHZQUEF6cTBwRzRCRE90ZHVOZndJU3VpSjdw?=
 =?utf-8?B?YWJ6Z0RMYThvaUhyaDlKTHdpVEtWVmM4Y0VBVFVueHpHSnlQekcwUlZ3T3F4?=
 =?utf-8?B?dC9NaUQ5aDBqTE5lZkdTQUo1MHBEMUQrcGFWeW4zZFk4Y0kyNVM4VnlKTDJ0?=
 =?utf-8?B?Z0RDWkl2Q21NU3NCOVlRVUo0eVRvdEFHKzlQSTVObHB3L2dpVFEyT3h5aTdU?=
 =?utf-8?B?SVdQM05yNEk3ZXNYNENweDdiM0lIT0tmMXY5M0YwbytidGEwb2YvLzh3cFZB?=
 =?utf-8?B?MzdVMDI3aVBQZXNtWWZ4UERaL0J6bUNhZ3lINEdyenQrYWdQU1IwZ1paanZy?=
 =?utf-8?B?SXIwNHdFRkE1MDE3WVR4T094WXh0amhJdGNSOXFxWUZZcjcrVXBzd05ObUZq?=
 =?utf-8?B?Mi84SGVkdUpTNEdnZlo0bGNoYWlDVElQT3ZXL0dMR24yYWZhVW1JSG9XODFz?=
 =?utf-8?B?cXZKSXBwYzZzSXdsT3NzdG1JMUU4ZVlCRGs2bFJ4bjZPODkwOTFRNkdVN0Zz?=
 =?utf-8?B?bWM3aHBYbWU5SzhSWHZjWlZ3K3AzUjVmOHBCMjJjVTh5YmpIOWJUMDY3UzFv?=
 =?utf-8?B?N2VqSmtaUTRGalR4bGNoSXhIUjQyWUtYeG9jdHl2emtTb3hkdG1XVm1FWTNB?=
 =?utf-8?B?OTFiK0owSzNwaS8rR2dPc2NSaG53MUUxeVZHbllXZUJpUitER3BTSEVaWHdx?=
 =?utf-8?Q?zZEpm/Yh8Y4rGt5Llo1SANKki?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd101f2-d6dc-4595-0fd2-08dcd138ac90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 01:34:12.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzaT1VvlTUft6o2BRD6nAB09NjkFax0bwNcqzup1nqX+c+uhKBBcE0PGRH+4LzPp7dybN8BL240s5Dfj54LAUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

On 9/9/2024 4:52 PM, Sean Anderson wrote:
> 
> To improve performance without sacrificing latency under low load,
> enable DIM. While I appreciate not having to write the library myself, I
> do think there are many unusual aspects to DIM, as detailed in the last
> patch.
> 
> This series depends on [1-2] and is therefore marked RFC. This series is
> otherwise ready to merge.
> 
> [1] https://lore.kernel.org/netdev/20240909230908.1319982-1-sean.anderson@linux.dev/
> [2] https://lore.kernel.org/netdev/20240909231904.1322387-1-sean.anderson@linux.dev/
> 
> Changes in v2:
> - Add some symbolic constants for IRQ delay timer
> - Report an error for bad coalesce settings
> - Don't use spin_lock_irqsave when we know the context
> - Split the CR calculation refactor from runtime coalesce settings
>    adjustment support for easier review.
> - Have axienet_update_coalesce_rx/tx take the cr value/mask instead of
>    calculating it with axienet_calc_cr. This will make it easier to add
>    partial updates in the next few commits.
> - Get coalesce parameters from driver state
> - Don't take the RTNL in axienet_rx_dim_work to avoid deadlock. Instead,
>    calculate a partial cr update that axienet_update_coalesce_rx can
>    perform under a spin lock.
> - Use READ/WRITE_ONCE when accessing/modifying rx_irqs
> 
> Sean Anderson (6):
>    net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
>    net: xilinx: axienet: Report an error for bad coalesce settings
>    net: xilinx: axienet: Combine CR calculation
>    net: xilinx: axienet: Support adjusting coalesce settings while
>      running
>    net: xilinx: axienet: Get coalesce parameters from driver state
>    net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
> 
>   drivers/net/ethernet/xilinx/Kconfig           |   1 +
>   drivers/net/ethernet/xilinx/xilinx_axienet.h  |  31 +-
>   .../net/ethernet/xilinx/xilinx_axienet_main.c | 320 ++++++++++++++----
>   3 files changed, 273 insertions(+), 79 deletions(-)
> 
> --
> 2.35.1.1320.gc452695387.dirty
> 
> 

Except for a couple of comment nits pointed out in 3/6 and 6/6, this set 
seems reasonable.

Reviewed by: Shannon Nelson <shannon.nelson@amd.com>



