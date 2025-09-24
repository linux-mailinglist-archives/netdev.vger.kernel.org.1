Return-Path: <netdev+bounces-225782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7E2B983FB
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 06:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B19F4E01DF
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5D1E0DD9;
	Wed, 24 Sep 2025 04:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="NbC1nmAy"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671A13DDAE;
	Wed, 24 Sep 2025 04:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758689699; cv=fail; b=Itqf5wYcfwBiV/FnFFLdDs7SpTPkL7c4PG38QowCrYqV5thpiQ2GbhRDIVcFbFqRl63YMt9KU9knvaoaofwNcEF/CEQgVVI/3TkQmprVOiwTfJo0M2/4letgBZBnM32X+v2a/WbT+v8ecxJk8UglUDN/iuewB8Ofcixbc+Nq3qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758689699; c=relaxed/simple;
	bh=EPgjrIZ9Ql3NzA0wnd2dB6cIpee49VXgJMCPBEuE874=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AQvYVJPsYumh3PKJAXD1X2M3KE1AODL2zhRCDH5yh4D4ei2+WL0+tUfXVfg6WzEyo04jjiMtDU/m51LRQziTVFNHUfKNONSWbV63uK7MjnSd4+xntHhSHjTnCr27yM0apJ1ua8TYyBxadNsBhiH7z+3DaJr1CSfim28rQ4fTiOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NbC1nmAy; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQrNZ9skr4wEdVBJ0NFWYdo1Um5b2CZw/Bq8RhVA6XPIJZYlf6WFO1GoruYHT87loGgaOQqs30youUdjkky+/CAQW83o626VvbUwwAChgQc88NArpXqHLy3AX4IectZN5QwYBzlnhUpXBHYZT5oDhbUwX7chg7gmeiAI+4VTxEDTZ9D08bx/RyFQPDhF0dr1BmEbi797xDwKcLzZrz8iL/DDx7pXvFRa5u986k51s7DAuXtSnFCpLy6SEs60h9kz8Jupi4Kogglgwu6F2cjTQNT19lPBxdcyd8mCkWw94xQ4lE8/bJfJ9hIkR8MQSfavLen9LzPYra9evFRRTHrp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzMPHS3H4F1abbDV/x5pf32bpSCRLGiSJKtxdHXG1FQ=;
 b=Xtrv5/Q9nzNAj4Hvgq+2L11GHAyr3KAPheg6qSVBws0XDqFCszmdkkD/mo0wLpkklCLzkf6axL6j6Zq8S5baFjT2Be0pc6O0x1eb4sA9XkRlWwjj0VLpRQ/EjwPHJKjA9Km2vfsUDU3v3Ek46c7V3HuX6SCY7sGXsEowAYlEAT+8PAhG2RufsRib+n6vMpEyoUOrq4u+t3xAAGM3ilhqhwDg2thx09roqPM2mO3EQVJtVNQlehURyzKN0HKOdeYuP8Xpr19MBXBDFBwPDX4lO3/HaWExrpBJ+ikj6CuRIyhB+it/HRcSBkw04Yxfw6bex3r3P/qqHv/3xQ5jftcGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzMPHS3H4F1abbDV/x5pf32bpSCRLGiSJKtxdHXG1FQ=;
 b=NbC1nmAyyDprcz7oqif31rPZvmgCyUdzVTVZUb2rrgWT264QcL9aqRRInhU5jShC90+RPEqkJzkhtyjdsiRTsHUINaQQE+AgvVTMTHXZI9J/j5g8V0wlyk9KIf7EqQjCCt5B23WZlBpb9qMW4LHHoXDlzviB3kCBO695pGZUNWd8fpzNhyIpiRZ1sSBwazidmBYOpkDYuzHDMBH3JenIf+pqE9Hy+mcCQIEKXBKHROomhqo50SZ6WMn9L/clxuNZ/s6dNkY7hbwLeE+1PGNPWSXpfUFhNnq8atebLUYGfGECQop5Y+ZWuJ/+BtE/gXPL7bJ1Pg30KGm5Mo33RDm7Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by SJ0PR03MB5616.namprd03.prod.outlook.com (2603:10b6:a03:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 04:54:54 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 04:54:54 +0000
Message-ID: <a914f668-95b2-4e6d-bd04-01932fe0fe48@altera.com>
Date: Wed, 24 Sep 2025 10:24:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
To: Jakub Kicinski <kuba@kernel.org>,
 Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>
References: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
 <20250915-qbv-fixes-v2-2-ec90673bb7d4@altera.com>
 <20250917154920.7925a20d@kernel.org> <20250917155412.7b2af4f1@kernel.org>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <20250917155412.7b2af4f1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::9) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|SJ0PR03MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: f542630e-b502-4bb5-924b-08ddfb268094
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enhkQ2grNGRrZEE3OU0weVgvUkI3ZHJYaGVIbnp5K1lndjNKYzE3alhFdnc2?=
 =?utf-8?B?dVdYL2tvcklvdzFBK0FFMWFUOVZSMytCWkl5YXptQ2xtZ2ZJQ3NLOFgwOEVF?=
 =?utf-8?B?YjgxNlBVUU9GTjg5RXJBem4wcjhibjk2Nm9ka0tmb2g1c3FHbWxmSW9Ob1lQ?=
 =?utf-8?B?eFFxT1ZDYlkzcjFKK1FETHJsVWhwcGFueHBXVGkxRTZVY29IMkFLZllrUzF2?=
 =?utf-8?B?emN0T3JPdWJsREpleHVQeUJRMlBoQUJCemU5SXlkUHd1dm91TEQwSVF4L1Zq?=
 =?utf-8?B?cnR1NU96TGJJSmZCM3BXWERmQnBCZ2FJWEFWMHMzNmtoWTh0Ry9mSGJqUlZl?=
 =?utf-8?B?a2ZzUkdTa2JZN0dtWTNvenVCbG5kQUthRjVTem02WDhxWGRweHlVU1FCU0dN?=
 =?utf-8?B?Sm8zMUNqWVBzcnVSeVRVTVNvN0orQmNZQmQ0YVZsLzZsVTdrR0R2QVQ0WGh6?=
 =?utf-8?B?WkRxY21XYklnUU9nRkFQUHdQV1BBaXhjRy9sYUZZeTRvUEQyU2dPR09Nd0pG?=
 =?utf-8?B?ZGhNaHEwSlYvZHIrQ2h3ak40UVRkU2tMeldad1dRQmV6YVl4N0d5MTdaNEUz?=
 =?utf-8?B?VUdsU1VTeWFDbW1ud2xrVzkxOWtqQjRLNHBGeGVRRWZReGw1K3hEcGN1T3FG?=
 =?utf-8?B?UnRtUlJrWlRvdDkzQXRpcG8xakxQbWNSSERjTE5IMEVDck9ENFhHSlMvdDl3?=
 =?utf-8?B?ZGtkcThucFZERE5qUGc5bzlSVDdzU2Y4cTlGenlTdVd5cWs1bGN4cVU4Vk5j?=
 =?utf-8?B?WkJ5ejhMd2RkWWhsa20vbWdoZGNOUEtSdzVCeXFDUHVvOG1CbzBHL1IycnBD?=
 =?utf-8?B?Uk41bld6akQva1JRYnhMeTAvc1gzWHZwTjFNY1JBSjYwd1VGdE9DMit1cXF4?=
 =?utf-8?B?UDBYWXlHdW95K29ZV3lHVEtIN0NjK1V4OGJaSEVsWEQ2N1VPbm43QlVmV1lh?=
 =?utf-8?B?Z3N2YkJwdDZ4R1FWdVFOQUxWMjlCQlpPdFNvZnJ6VTQvMEZRT24zT1hhUW9Y?=
 =?utf-8?B?V2QxdmZ2OUVySUFtclUzUGxTeG1GZVBEdUk3WVJKK3M5UWdKOVhtQTFNcVB4?=
 =?utf-8?B?ZllqOGh5Q1V6T2U3NFh4eVEwQitTaXhlcE5JOVU2UDJ1eFA4RjBzTFowR0xw?=
 =?utf-8?B?Rmh6RVpBNUR4NktJamZqR2RuNzNHdzdvbEVnMTZGV2xJUTJCNDRnSFUxb2xz?=
 =?utf-8?B?eDM3UWlhN0lkZVNMdmdsbXhZckR1cXF3Mkx0dkRraFBYVmFoNHpqTVpLQnZH?=
 =?utf-8?B?d0RWejBWQkIySFptcGRmM3A3Y2JjSG5leG1SYjZtd0Z3dkJVNkFyN2VzZkp4?=
 =?utf-8?B?YTI1eGE1bnJIZ21sZitadTEzSWh4TWJjYUgwKytNeHhRQlZ2KzAwKzFiMUNm?=
 =?utf-8?B?RTUyaXFtSFVsblZjZW1XS0FxTGVUMzZVNHlSbmFvemQ0bjA3VzJRMk9MclZE?=
 =?utf-8?B?VC9DRjlCbmNyYi9QdFk2R1RZQzBtYmJHblBIcTd1MzVhWU0xWmszOTdiUE40?=
 =?utf-8?B?Nmw3aFJtZzB4VHFNTzNZTGVobGx0bFNFSFVRY1B4ZVlGMWU1UUgzOFVLZW1v?=
 =?utf-8?B?aHRIWEFBcXJkQzUyTEFlYTZNYkFDbnRYOWxpd1NjeG1DR0xYdEJhMk9IWHlG?=
 =?utf-8?B?cnVzWFBBOU8wc0RxZXpJdzlxSTFsMkdXUXpkS2tpOEl6YTcxZ3Y5amZGTnQ1?=
 =?utf-8?B?VkJlT0dTa01FcWduMWkwYTFmalNyRDRvWm5TWUczeWxneTgzKy9mUzNpb3RY?=
 =?utf-8?B?UFovOW5jREhsU1JHc1JtQzJKek1ZLzFSeXBPMG5peTNSNGhibUlZRmJvOWYy?=
 =?utf-8?B?Tm9XWUNVYkFycmlXNW1XUHhtMjRtMXJCVjZhNDYvSlc1dDJHUXQrU1liUVZt?=
 =?utf-8?B?NElOcVkxQmwxc1NlMEJxMmYrWUFMOGVueVhCc08vcHBmajhrbWtOUHBNN0lq?=
 =?utf-8?Q?55t/aG43nPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWpndDZ3am9udi80bVFxUjEvMTJETVpLKzQzdFcvazQ5SVNZZ2RhZGNlZEor?=
 =?utf-8?B?QkFmQnkwb1M3anRKbG5seC9RK3F0U1Q3V2x1NlAxZG1YS2JxWXlzb0dudldJ?=
 =?utf-8?B?S3hqTVVHTmhHMGRtQVU0dFZScVRZb2V1K3d3djJGOWh6RzFvaGdWVGhHbFMw?=
 =?utf-8?B?WU5YWEpIdlE5MmVpYkt1R3NhZndnaWRqNFFGc3lFdDlRcHlzMHh3QkhVV2tH?=
 =?utf-8?B?SXpsRnhIK0hQRERRUE45WFFXUFpQQWQzNlRja2d2YXp3M2d2c3U3STBmU3Vs?=
 =?utf-8?B?UzdhZ1lvc250VEk2U0w5c1dKb1FiT2JsdldFcldwaFVCTzNnMGN0eEhYc1I3?=
 =?utf-8?B?S0MvU25mMURLdkxHTXlaM2JnRlNYMlZaQVVaQXF3MEhGTjNrWGRXMGJJdFJB?=
 =?utf-8?B?OXk2RDYxbmlwR0V2bWtnRkdzQlhCMy9LbXpSOUFsdmgxRTFyM2JYVU5Pb200?=
 =?utf-8?B?bzloL2Y3QnJocmhNT3RQSTZJMGVlRFFiV1ZRWGorb3ZzMEhvNC9XUk5oRzhC?=
 =?utf-8?B?VmxsVlJzeEM4OWx2cmk0aDVJZkRmMEFsWWRqNDhEaXB6aFB1cFNJNkloWVFq?=
 =?utf-8?B?V3VQOHBxZTVHYlZLYUoyMVF5VnJQZ1Q5djhWTEYxNHI3anRXQ3VsRnRRZ1lX?=
 =?utf-8?B?cU55RjdyRVBLbkhGMzlVL2wya1NHSUs0OGZGVWJjT1piNTJtc3ZoOHM1Y3Uz?=
 =?utf-8?B?UlYrS3dBVFBzR1FNdGVDSXNic1FkYWNYd050eXJSUkRVVENDRFRpeURTWndU?=
 =?utf-8?B?bERrRktSOUxlMnczWUhvbTBZcWt1MWJQNUNGcGZOMXJmTFBNZU03VmlBdmxF?=
 =?utf-8?B?cERQellxZURUYkVWWVpmTHNPRzg0NS9RUlM4a01icUtNNCtZbUEzZjVaU1o2?=
 =?utf-8?B?dTVCZ3VKQTdwNzh1VlFVdldTT0M2ZVV3eklCejRaNXRHYzFJbzVUQUwxTEVJ?=
 =?utf-8?B?K0xuNW0vQWJDZXhQWTd5bTIyNzhjU2pHL1R6NmJrTllOL013Uzg4Um9vSDhw?=
 =?utf-8?B?c3JOUFhZbW16VHNzcm9OVmYxWFhDSUwzU0J6K250WHZxT1FOMHR4QVNVZHhY?=
 =?utf-8?B?RmZJSm85ZjBMRHZSZXQyZjg0SFVLd3EwMmFVeW1ucXZiRWZ1S3ZZWEhGM1M1?=
 =?utf-8?B?eEI4VGUxYUxzTC9Ib3ZEK0dWKzhKSkUra0JheWk1bTA3VmhpSmFzZjMydkk1?=
 =?utf-8?B?RGUxS0xNdkl1OEFlb0J0OWtIN29sU3BVeXdwNmZPNEFQeGIzZFlkR2RaREs1?=
 =?utf-8?B?QW1UbEd5djFtS0Q4b1VwbnNPWXQwOEZxMGN4QmIrZkY3dFJWbDdJOHJxcW9a?=
 =?utf-8?B?eXFrS2dDSGhwVGkyWjFRVm5xWitIUXpQajN0enlubWNaeDN4d29TcThBc2FX?=
 =?utf-8?B?cWMwQ0kwUDQ1OHlRWGkzampESC9majB0VEY3SnZOTWk1VXFleUtGaUVuZGZU?=
 =?utf-8?B?Q0x6dzNLRmxIOEpOOWJkT09pU3F5VU9XaGxIMzQrbU45aS9WcC94aWYrdW9D?=
 =?utf-8?B?SkhSK0xDeWU2dFI2QVptMHllNnFlTWRVS3ZUcTA1aUxFUVNKTktoMUFkeHRB?=
 =?utf-8?B?cFFmSE9aSVJwU1NPNzVWSml5a2l3R2dCMHFnS29VSXFIZ2ttV3dtY1VzSlhh?=
 =?utf-8?B?OVp1aDZtK0xiZEl4bjZ3VjFwcXFwc1FoenVQUFU5VG1FNWxsSDNaTEFsejI4?=
 =?utf-8?B?UjJmcVVhYkpKRi9GUTNvaXJPZm00WjFzS0ZNOUhUMFFJY3hTbzJ4aWNEWUZn?=
 =?utf-8?B?QTZsdEhFOVBMaGZQMUwvcm5mTXE4S0Q3cVVibjB5Ris2YnBndjlON0VZN2Iy?=
 =?utf-8?B?TEFMWE0zY0JlOXR3eksybjg5MDFSTlZLMlU4NmFJalF1WVh2Uk5Vb3RGMCsz?=
 =?utf-8?B?U3NiMWIycDNYS0tBU2s1TGFaWGJDaVlPNzZHMzNjOUZRSFJjalh4RlpaSk5G?=
 =?utf-8?B?MFRYQjNtTFF5OGZzT0RxbnZEajI0ZFJZRDd0aXI2WnZXQnM0MWtscXk2aDlZ?=
 =?utf-8?B?eFZBTnl6eUlMU0ZLcU44di9ERTJOeEVia25DdkpncElIVGE5cDdxR1ZRZFQy?=
 =?utf-8?B?THhscHFESFlYUXpjNC9BeEw1Ty90WW4yMU5aZ2cwSGpaRnYvRXlQNEN4WEkw?=
 =?utf-8?B?YjVycGxudm5qZ0ZWeUF1SmNMS2ZETUtCMGE0ZWdpYU5DQ3BiM0wyTnp4K1pT?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f542630e-b502-4bb5-924b-08ddfb268094
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 04:54:54.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8jwqYNj/9aErAvBFFHRqonLlXyfe0JYV0nxrWAUqtNNVGMI42Q4Uiu9FIOiMGtS0iMJYhijzVoDsM/TRaxXm9ZshAJby3vc1MuhGymZtEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5616

Hi Jakub,

On 9/18/2025 4:24 AM, Jakub Kicinski wrote:
>>> +	sdu_len = skb->len;
>>> +	if (has_vlan) {
>>> +		/* Add VLAN tag length to sdu length in case of txvlan offload */
>>> +		if (priv->dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>>> +			sdu_len += VLAN_HLEN;
>>> +		if (skb->vlan_proto == htons(ETH_P_8021AD) &&
>>> +		    priv->dev->features & NETIF_F_HW_VLAN_STAG_TX)
>>> +			sdu_len += VLAN_HLEN;
>>
>> Is the device adding the same VLAN tag twice if the proto is 8021AD?
>> It looks like it from the code, but how every strange..
>>
>> In any case, it doesn't look like the driver is doing anything with
>> the NETIF_F_HW_VLAN_* flags right? stmmac_vlan_insert() works purely
>> off of vlan proto. So I think we should do the same thing here?
> 
> I suppose the double tagging depends on the exact SKU but first check
> looks unnecessary. Maybe stmmac_vlan_insert() should return the number
> of vlans it decided to insert?
> 

I overlooked the behavior of stmmac_vlan_insert(). It seems the hardware
supports inserting only one VLAN tag at a time, with the default setting
being SVLAN for 802.1AD and CVLAN for 802.1Q. I'll update the patch to
simply add VLAN_HLEN when stmmac_vlan_insert() returns true. Please let
me know if you have any further concerns.

Best Regards,
Rohan

