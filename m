Return-Path: <netdev+bounces-232614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9611C0743D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6061B81E54
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA0527E1D7;
	Fri, 24 Oct 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EWx+919H"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BCD274FD0
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322876; cv=fail; b=FLd43j8AQZZXmMBxBkKEmsGcvaDtqhwIjntqtTknfZKbMugolIG1GHCRTD0/zC7+YLvPfS/Ldev/Qi4DUiTFmOTxo9iFUwncEYR2vT2YlkDPIgQ3paQ5wH4JpwnoRY0CqMDA0pDAUG2AvW0HG97HEqs9VoGDgPII7ahWYGRYOuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322876; c=relaxed/simple;
	bh=GGUuJMd7a+n9lgGYbWhCYnGliTQDjjElhzsD4BtgEOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tm2v81AO+JvC/9XvnV4JMNfbjdrPCdWijaTC/vUOXisSJAs7XikaPo78kNTOWPXT2LrNDURoHVqWNxtefhAUpnMQAvudxs4mVCacecNQor6vZpa7+TVsOn9teXZoqOlRJhG0dd6cr0De+NI1PaJFAOnRPIXDSyLATL523U+y09w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EWx+919H; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLhHE0knLSM1Z2FOCT7nYWH00IcAQOWTRwJjsgMIc0fl4wE/bzt1pY2oHB146vyyoaRmej5Ta9XH4alybwfDE1W8DqjcSNxT95HlfFNTI1cgyS2wFTG571mFWG9ih+NaNwJdL0OBJ7SBx2fcREJoRyIv7qGYH4rfSgJ8J2jtKN/OmUd6Kwx3/IAVcrNMwHqtdgSYzczp4NHDmCqaBnFDBF7ZKYfXdQob6bzVls5xXUDCNtryJ2wM9HVZV84tTFAkjvE3QLhKm3VidIbNxLU9vpFXTPTOtC8FLP8tkNAB784EVfy4/2qDeLDYv9Ju8WbAPtxaX7AiAK5IquUdzd9/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkb20eZGcvZadWbA0VSV91mogmLJ+eQUTao1h6hZGR8=;
 b=KbN9JkbgDmlwHB1Z7+gBXD6pENHAM/4u0H1sdacJ5YKb1+hYJSf1kn9J869UFDGk5XJGWCxIt4am7J9vcxIcKIHYu6kBrYGpCge1kK0GTCUV9tVHcfCRUte0TMi8KlcaMdoho/5hZr97dKT3c5zNmjDVc8RDT6DEORUXtACl3YUNthQO9eZ6xKk5vUOld3a6HM5o/YiGU1lbyfu0dcRU4tOU/Pu2IZ0Catk+Q6CtDEARpNCFfnbbTLlrxLoJwcSm26WVLCzKrBX13WjLM1rmrwmVu1TRvZEZNfQ1LiLCd5DVM1/pqGmkPAAyAeGwtpqaV5isUht37+t2MMjm1Bwgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkb20eZGcvZadWbA0VSV91mogmLJ+eQUTao1h6hZGR8=;
 b=EWx+919HFvD0cbYtgvWhOEYxy1WtSXFOMfn8E8XAAlbZpTdcoBV6IAmkK4xZQRfvCcQUOzg6ums0RdkdSrgrRAYYUvCjfc3t4BGBTRAGgIYtlahz4D0snKvHUTQhtMP1qSys3xbMbU5FyjDQO0JkSkeWBu9uFbJ1ZnGQsutPAll5HckbAFAMOXmxc8VEfCrpZ24tEscgngBY7+bfkO57rvOB5VIZbv101GRjrn6OlUKhyzqs+FbiOeQxjdVakDl040xmURFf7ih2w/dvNHoVWChUMXo0dACSoWVgTNTFy66VNwDv+2sP3iLXpF3kMiTnQQhVZJzPhXuynA4b663EbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:21:07 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:21:07 +0000
Date: Fri, 24 Oct 2025 16:20:32 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/3] tcp: fix too slow tcp_rcvbuf_grow() action
Message-ID: <6khewwumc5l47xjnamcqabrltnl7yr2qvb22zrqmmoq2vwn7yv@epxcgnflmkbt>
References: <20251024075027.3178786-1-edumazet@google.com>
 <20251024075027.3178786-4-edumazet@google.com>
 <1a43cc72-126a-41d3-8af9-b1a3a303386a@nvidia.com>
 <CANn89iK0qqpt_aLhf+HN8V_Kvwt6sEFVbAiJhpe9_F+H+SUDNQ@mail.gmail.com>
 <CANn89iLzZxHhu=p+wq=ZH7qa1GbBDXPnY3XO7192MEbySyyD=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLzZxHhu=p+wq=ZH7qa1GbBDXPnY3XO7192MEbySyyD=g@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3c1564-db86-4a68-8f69-08de131955f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDI2ZDdJaFNGZi9TUjhtcTRMZ2J1YXdrZkxkdVkvUmRTd3RXUEdwQVZGMExH?=
 =?utf-8?B?VzlEcEh3bHl4bUQ3alVqY0F0cmZ2ZjA0cWN1ZEwyMmhySVYycEhEVkt6Wjc0?=
 =?utf-8?B?alZseUpBbjJBVTNYcEZFTzJ6VjBZL0N1NHZSY2VsWlk3OVZkT3h6QTMvelNZ?=
 =?utf-8?B?VElpa3FpZ0ZIeHlORkZOS0ExcDJWeGgrNTZ1b01zTzZ6RU1vTTlBYmNHL254?=
 =?utf-8?B?N3BCWXl6N1JGc2t3YkFhTVJOT1pQWEhhSHlBY3RtZTFUK1ZLQmhTeHRkQy92?=
 =?utf-8?B?L2k4L3JPZEN1QVFKYUR4TXIxYjY1MGdySHhJK21FQnFaOEZZd0hrSnBucXd6?=
 =?utf-8?B?R1dxc0l2UGk0Qk92MzB6YTZCN1E3VUJMVzhtRFJuclNjVFN5cG9aRFBrYkdR?=
 =?utf-8?B?MndPZ0ZnS2VabDF0dTJVcElmaU0yYlFCREJwMEIrNFBVMWtMemFtY2gwTlpm?=
 =?utf-8?B?OGZWNURxZVhJd3RUcWlBMkQ1djBZZkNBdUxtck91TGViUWg3N2FFb1RKOXo0?=
 =?utf-8?B?Zjd5V2RsL1FvdTRhaER0UFFWRmU3Z3pNRzlBYmxpNUNXZnlqTENwTkU2TkFi?=
 =?utf-8?B?MjZKV0FrQU9VWThlVERGSGxyempIQUNRVUE3NG9jck95RHRUUktabE5aNmpx?=
 =?utf-8?B?dXFXTHU3ZEZvczR4cGcyUnA2N1doMW5MSnl2NWRyUG5BSElPQmlZVStLZ0lJ?=
 =?utf-8?B?c2FoR1NFalRDYjFSUmc1ekZyWmdJNkZXYmFYdndmZU1xNkVQU3lRS2licWRw?=
 =?utf-8?B?S0k4Y0x4MmV4OUpLM2NXSW9wdzJzbW5NY05td1NUa1BuMEtaUHZDRnlyYkJm?=
 =?utf-8?B?OUV0bUNsbzJUbzlVYXo3bkhsZVUvKzVwVURjR0xVdmxRSUIrWUVla016djFl?=
 =?utf-8?B?RmFRS0RZd0p1UFRDSmVmY1hCM2dKRzhJU21PSE8zT0w2VG96SU5tZ1g4aHU4?=
 =?utf-8?B?VEZZQm9vTzVPdFRQZXkwVkhLV0dQZWIrUUVpQm1mU21TQ2ZwOWxCWVByaGkz?=
 =?utf-8?B?NHVQbjV0WGVLOEgrcE9hSlhZcWVXc1NhVzBzNUVVd21HdU9qbHNGWFVjUE5y?=
 =?utf-8?B?RytQcWloV2NhKzVmdENaZ2JSdXZHRGJTM1UrRVJzeHg3d2xZMnJnSE43NGVq?=
 =?utf-8?B?K2xXamxvMXk2TVF4VVh5S1BheURmaTUrbG0ySmx5TWxYOTNSbmhyOGJ6YjUy?=
 =?utf-8?B?cnBtREFLb0toVFVzTm1jaXE2RzZ5ald2NjZYNHJWdjlYWDhXYWdvQm9qLzJK?=
 =?utf-8?B?VlVncUJ2WkJmeW50TmtqVmRpeGdrb0t3SzZSVEIrL05sdWVJSlN6ZUhwUlE3?=
 =?utf-8?B?V01MN2ZGKzFsSUh0dWRNcml5VmZnRk5VQ1pyR0l6VjhWT3pHdUlXNCtjV25R?=
 =?utf-8?B?V3R3d2hoNXFwaUZ3Ym00MGw3MWtZYVVrcFdNOEJPcG5yak5KOEZ0WXNhaVNy?=
 =?utf-8?B?Y3liTFdsSVMyZDkvMkpvSHFWaHZGUXJFSHk0UERaYVpMS3pSc2VDN3AzbDlt?=
 =?utf-8?B?OU5ianFDUkFzWkVVa1psbFBBeEZtcm91dWtJRjhJRWRmUFhyUGxhbXVmdUxO?=
 =?utf-8?B?dzM0NHduWU44SFBKakdBdDA3MUlJNE9VNEhCV2J5N2dJeXVVS1FEdG10K0dS?=
 =?utf-8?B?RUlveFVWYThwQ1hFeGQvV3JCT0NGT3NJS2FHbEZneWU5YjhxWjlzVUZEUVVF?=
 =?utf-8?B?TGlBQ3hwL2c4ZUM1SGFOOHZsS0pGdzAzNkRqWjh3UXBybE1IR1ZhUEQ2MHkx?=
 =?utf-8?B?VG9lMnNxVnJRRWJBT0tkTWFIaUFjSHRhenM4d2lOU0xIMUFFakEwc2Q0WDUx?=
 =?utf-8?B?d3plbW8yVDJsR0Z5d2Y2Y09Ba3Q5R0x0eSt3UUVUVGpsclk3Ykx1akUrelQ3?=
 =?utf-8?B?ZWdZKzlKRFZHbi9NaTVGQUlaK0w1YmdKZmtDcWp1elZ2eG43UHRnTjNrcm5P?=
 =?utf-8?Q?XwU1IDvhK0CwhdYh1IHmke6g4WEgiQFI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1N6WVVBSVNKbFhDNC84WFU5NWpwdFRPUVBFTU12bDdDQWY4cUYwVHBZVG5l?=
 =?utf-8?B?MzdrcXZLOVpGaUdxa0VhNDkybUlkNlhGUkxzZCtvTGtYck1XK0dZY0FOZC9D?=
 =?utf-8?B?U3VNQVRYRVhpQzdRU1lGVER5dS9nMWQyWDVTR3BaN0dIZjhoZGhWeEE2TWN0?=
 =?utf-8?B?M3RxZk0wY01kb1lIU0tVMXEycExza3JwSTBCREczQi9SOGEzbkNZZkhJeTVF?=
 =?utf-8?B?ZmQrVk9BWGpXMHF3aGtGNjI2bVN5Tmx2QmZxVkRqdHR2MGRabkJONHovdU9r?=
 =?utf-8?B?NTZ2R1U4aDRHUE1STThGS1ZHcHNNa2Q5TENPdWZTYk1TVjZwZjFveFY1KytJ?=
 =?utf-8?B?ZWF4MnlQQmUwNmthMXZya0VHUitSUkgwZmxBcUVhcFdndmZjYW0za25aaGo1?=
 =?utf-8?B?RC9BRW9VSjFhRWNBUGVabVdFeFZCeVlpUUIrVzNtaURoYTh5RUpEb1N5bE1S?=
 =?utf-8?B?dnJYZktsdTA4ZDZQS1QzN052NXBvOXBlUUhsTHdLelNMdmxOOFJ0V282cHBy?=
 =?utf-8?B?VzB4ZzlpQ0tBcWVaVUpaZlpXRE5rUUlKbG54TEJlWnpoMUxYNXFNSjRoWVhI?=
 =?utf-8?B?OTc0NFE5QlJWc25sM2RDa2RzblI4V0tGS1JleXRMS0NhR1dlZFFRd2dLT29F?=
 =?utf-8?B?cmlySHdESnhzYTM0R2IxVlpYaVI5Q1ZtZXJrekw0YVlaa01MdCtQUDhiRHEv?=
 =?utf-8?B?ZmZGWXRSNU8xTHhiWHFxWlNvYVpnOFNZUVFqT0dJa0ZjY01zR2F2R1d1WTBO?=
 =?utf-8?B?RzByTytIRnJqZ3krS1FGUjFLckJGZUtTUkZCQ0d3d21YamlORUJtQzVvYXlQ?=
 =?utf-8?B?Z3FvZ0h3ZnNWdDNzY3k1NGFIT3NZdkV5RnBuK2JkeEdSRlc1MmJ2WXdmdkFN?=
 =?utf-8?B?anVkc3VXVk55VXZ6cGlDWnNCQ2xjczUxUVo5RS9renhZT2ZaNmpRVExsUHUx?=
 =?utf-8?B?ZTJpZ1NPWGJKd3pRMDVnK3hOZzhxZ0ttaVg0d2hBWjF4QVZjb0dBaDNJWG4w?=
 =?utf-8?B?WUpYN1lNSGlwN2tkR1NweTRXeU5xajhtcjRBWHJ6SzR5NzdDSnhJUkxTRjl0?=
 =?utf-8?B?M3BFRFNDUnZxN2Q1ZW1UV1JyMFg5aFA5U2JwNHBteSsvQWlsbkJqNnR3dkM1?=
 =?utf-8?B?NEpidGJ6WnNhQjFZVlpvR3ZxNk5tcDEvN3BPZC9pVEtEUFNLZ0NJcCtsMTgy?=
 =?utf-8?B?THUySzBSbHVreTRYY2dUZFgwWEJIT1Q1YUhwMlArZTc4d3Roa3IwS2lEMlBl?=
 =?utf-8?B?R0JLWDRUQ0JtOG54VlhQQitJdFZ5NmdXWmJBQ3JTM2srY3lCbnB1YTNwOUQ3?=
 =?utf-8?B?cVlsaTF4VDdkRlJxVmZRcFZ4b09RWmdtMFlyWFIxQnE5UjBjb25hR3NjYTNv?=
 =?utf-8?B?dlVacHBxV3I3bU11dUdHRGhqeXJGVlFCNFgrM2tCRGdTZWFnK2FnMjQ0eity?=
 =?utf-8?B?QUw1OERqaXhzNWI5NDFZdjdYS0pjMjFiVXpzS0xFUGFSVzZzSmxabVlCbTNq?=
 =?utf-8?B?OElXS21FTzJWbXRpRW43eEV2OVo2U3RDaGIzaEEveXlEQVczYzRVUm9uTnoz?=
 =?utf-8?B?SFhaeFVSWUJRRnR2eWkzNVlGOUhYZnd1SGVuaDd5YjNnd3lZdlBKUW9CcHlT?=
 =?utf-8?B?aUpWRzFiUCtMWjRMZ2JUTmh2Y3pOTm5LUkx2Rlo5QTY3SXk3alFIWkdzYmJK?=
 =?utf-8?B?MGo4TDlmUUhqQitLdk9EWmNDWE5Mb24wcnFlc2E1OXVleDlsYTM5U3VmVkF0?=
 =?utf-8?B?c2QrZE1oVG01Skl4OEhhL1hucTZ3b3VjR0VkMVJ5TEdad0NzT2hCTFA2b1hi?=
 =?utf-8?B?emRickhEWk9rWkpOQnNIa21nSlZWVWptMmx0TnVQK2lBaG9IOTRZbDQ3a0Ns?=
 =?utf-8?B?bWRqQ3BrSjA5MTZrc0d5dmxqbVdOajhWbXhKTWhFTmJlT2ZDNDdFbERjMGlh?=
 =?utf-8?B?YnA5SDZXeW5pOVFWQm44cWFyN05YMkgwSHMrK2Q3amFBOWdMOW9Xd3l2QTcv?=
 =?utf-8?B?K2tMM29zbnFOWEVYeVlzdkEySHBPUUNDam1zTkRFUlVtMEkyeEM1NjkrRWxY?=
 =?utf-8?B?UVBWQTRlMVc5UkhSc3k5ei9OdzBzaWI4ZnJ6QXFuWDg2UGNKN1ZCbGRFR2ht?=
 =?utf-8?Q?SxE9JF0WdbfDZqCH4lqEt/Zya?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3c1564-db86-4a68-8f69-08de131955f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:21:07.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nVHrdErIUaemNvUxTm2M9fCh6EZ5TU4mC3no5HJeRUVuIoa2xLYSuE5j0kFoZtTBEnHlMvyFsm/BuVF6bvF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

On Fri, Oct 24, 2025 at 08:42:21AM -0700, Eric Dumazet wrote:
> On Fri, Oct 24, 2025 at 8:25 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Oct 24, 2025 at 8:13 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > >
> > > On 24.10.25 09:50, Eric Dumazet wrote:
> > > > While the blamed commits apparently avoided an overshoot,
> > > > they also limited how fast a sender can increase BDP at each RTT.
> > > >
> > > > This is not exactly a revert, we do not add the 16 * tp->advmss
> > > > cushion we had, and we are keeping the out_of_order_queue
> > > > contribution.
> > > >
> > > > Do the same in mptcp_rcvbuf_grow().
> > > >
> > > > Tested:
> > > >
> > > > emulated 50ms rtt (tcp_stream --tcp-tx-delay 50000), cubic 20 second flow.
> > > > net.ipv4.tcp_rmem set to "4096 131072 67000000"
> > > >
> > > > perf record -a -e tcp:tcp_rcvbuf_grow sleep 20
> > > > perf script
> > > >
> > > > Before:
> > > >
> > > > We can see we fail to roughly double RWIN at each RTT.
> > > > Sender is RWIN limited while CWND is ramping up (before getting tcp_wmem limited)
> > > >
> > > > tcp_stream 33793 [010]  825.717525: tcp:tcp_rcvbuf_grow: time=100869 rtt_us=50428 copied=49152 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=103970 window_clamp=112128 rcv_wnd=106496
> > > > tcp_stream 33793 [010]  825.768966: tcp:tcp_rcvbuf_grow: time=51447 rtt_us=50362 copied=86016 inq=0 space=49152 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=107474 window_clamp=112128 rcv_wnd=106496
> > > > tcp_stream 33793 [010]  825.821539: tcp:tcp_rcvbuf_grow: time=52577 rtt_us=50243 copied=114688 inq=0 space=86016 ooo=0 scaling_ratio=219 rcvbuf=201096 rcv_ssthresh=167377 window_clamp=172031 rcv_wnd=167936
> > > > tcp_stream 33793 [010]  825.871781: tcp:tcp_rcvbuf_grow: time=50248 rtt_us=50237 copied=167936 inq=0 space=114688 ooo=0 scaling_ratio=219 rcvbuf=268129 rcv_ssthresh=224722 window_clamp=229375 rcv_wnd=225280
> > > > tcp_stream 33793 [010]  825.922475: tcp:tcp_rcvbuf_grow: time=50698 rtt_us=50183 copied=241664 inq=0 space=167936 ooo=0 scaling_ratio=219 rcvbuf=392617 rcv_ssthresh=331217 window_clamp=335871 rcv_wnd=323584
> > > > tcp_stream 33793 [010]  825.973326: tcp:tcp_rcvbuf_grow: time=50855 rtt_us=50213 copied=339968 inq=0 space=241664 ooo=0 scaling_ratio=219 rcvbuf=564986 rcv_ssthresh=478674 window_clamp=483327 rcv_wnd=462848
> > > > tcp_stream 33793 [010]  826.023970: tcp:tcp_rcvbuf_grow: time=50647 rtt_us=50248 copied=491520 inq=0 space=339968 ooo=0 scaling_ratio=219 rcvbuf=794811 rcv_ssthresh=671778 window_clamp=679935 rcv_wnd=651264
> > > > tcp_stream 33793 [010]  826.074612: tcp:tcp_rcvbuf_grow: time=50648 rtt_us=50227 copied=700416 inq=0 space=491520 ooo=0 scaling_ratio=219 rcvbuf=1149124 rcv_ssthresh=974881 window_clamp=983039 rcv_wnd=942080
> > > > tcp_stream 33793 [010]  826.125452: tcp:tcp_rcvbuf_grow: time=50845 rtt_us=50225 copied=987136 inq=8192 space=700416 ooo=0 scaling_ratio=219 rcvbuf=1637502 rcv_ssthresh=1392674 window_clamp=1400831 rcv_wnd=1339392
> > > > tcp_stream 33793 [010]  826.175698: tcp:tcp_rcvbuf_grow: time=50250 rtt_us=50198 copied=1347584 inq=0 space=978944 ooo=0 scaling_ratio=219 rcvbuf=2288672 rcv_ssthresh=1949729 window_clamp=1957887 rcv_wnd=1945600
> > > > tcp_stream 33793 [010]  826.225947: tcp:tcp_rcvbuf_grow: time=50252 rtt_us=50240 copied=1945600 inq=0 space=1347584 ooo=0 scaling_ratio=219 rcvbuf=3150516 rcv_ssthresh=2687010 window_clamp=2695167 rcv_wnd=2691072
> > > > tcp_stream 33793 [010]  826.276175: tcp:tcp_rcvbuf_grow: time=50233 rtt_us=50224 copied=2691072 inq=0 space=1945600 ooo=0 scaling_ratio=219 rcvbuf=4548617 rcv_ssthresh=3883041 window_clamp=3891199 rcv_wnd=3887104
> > > > tcp_stream 33793 [010]  826.326403: tcp:tcp_rcvbuf_grow: time=50233 rtt_us=50229 copied=3887104 inq=0 space=2691072 ooo=0 scaling_ratio=219 rcvbuf=6291456 rcv_ssthresh=5370482 window_clamp=5382144 rcv_wnd=5373952
> > > > tcp_stream 33793 [010]  826.376723: tcp:tcp_rcvbuf_grow: time=50323 rtt_us=50218 copied=5373952 inq=0 space=3887104 ooo=0 scaling_ratio=219 rcvbuf=9087658 rcv_ssthresh=7755537 window_clamp=7774207 rcv_wnd=7757824
> > > > tcp_stream 33793 [010]  826.426991: tcp:tcp_rcvbuf_grow: time=50274 rtt_us=50196 copied=7757824 inq=180224 space=5373952 ooo=0 scaling_ratio=219 rcvbuf=12563759 rcv_ssthresh=10729233 window_clamp=10747903 rcv_wnd=10575872
> > > > tcp_stream 33793 [010]  826.477229: tcp:tcp_rcvbuf_grow: time=50241 rtt_us=50078 copied=10731520 inq=180224 space=7577600 ooo=0 scaling_ratio=219 rcvbuf=17715667 rcv_ssthresh=15136529 window_clamp=15155199 rcv_wnd=14983168
> > > > tcp_stream 33793 [010]  826.527482: tcp:tcp_rcvbuf_grow: time=50258 rtt_us=50153 copied=15138816 inq=360448 space=10551296 ooo=0 scaling_ratio=219 rcvbuf=24667870 rcv_ssthresh=21073410 window_clamp=21102591 rcv_wnd=20766720
> > > > tcp_stream 33793 [010]  826.577712: tcp:tcp_rcvbuf_grow: time=50234 rtt_us=50228 copied=21073920 inq=0 space=14778368 ooo=0 scaling_ratio=219 rcvbuf=34550339 rcv_ssthresh=29517041 window_clamp=29556735 rcv_wnd=29519872
> > > > tcp_stream 33793 [010]  826.627982: tcp:tcp_rcvbuf_grow: time=50275 rtt_us=50220 copied=29519872 inq=540672 space=21073920 ooo=0 scaling_ratio=219 rcvbuf=49268707 rcv_ssthresh=42090625 window_clamp=42147839 rcv_wnd=41627648
> > > > tcp_stream 33793 [010]  826.678274: tcp:tcp_rcvbuf_grow: time=50296 rtt_us=50185 copied=42053632 inq=761856 space=28979200 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57238168 window_clamp=57316406 rcv_wnd=56606720
> > > > tcp_stream 33793 [010]  826.728627: tcp:tcp_rcvbuf_grow: time=50357 rtt_us=50128 copied=43913216 inq=851968 space=41291776 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56524800
> > > > tcp_stream 33793 [010]  827.131364: tcp:tcp_rcvbuf_grow: time=50239 rtt_us=50127 copied=43843584 inq=655360 space=43061248 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56696832
> > > > tcp_stream 33793 [010]  827.181613: tcp:tcp_rcvbuf_grow: time=50254 rtt_us=50115 copied=43843584 inq=524288 space=43188224 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56807424
> > > > tcp_stream 33793 [010]  828.339635: tcp:tcp_rcvbuf_grow: time=50283 rtt_us=50110 copied=43843584 inq=458752 space=43319296 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56864768
> > > > tcp_stream 33793 [010]  828.440350: tcp:tcp_rcvbuf_grow: time=50404 rtt_us=50099 copied=43843584 inq=393216 space=43384832 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=56922112
> > > > tcp_stream 33793 [010]  829.195106: tcp:tcp_rcvbuf_grow: time=50154 rtt_us=50077 copied=43843584 inq=196608 space=43450368 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57290728 window_clamp=57316406 rcv_wnd=57090048
> > > >
> > > > After:
> > > >
> > > > It takes few steps to increase RWIN. Sender is no longer RWIN limited.
> > > >
> > > > tcp_stream 50826 [010]  935.634212: tcp:tcp_rcvbuf_grow: time=100788 rtt_us=50315 copied=49152 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=103970 window_clamp=112128 rcv_wnd=106496
> > > > tcp_stream 50826 [010]  935.685642: tcp:tcp_rcvbuf_grow: time=51437 rtt_us=50361 copied=86016 inq=0 space=49152 ooo=0 scaling_ratio=219 rcvbuf=160875 rcv_ssthresh=132969 window_clamp=137623 rcv_wnd=131072
> > > > tcp_stream 50826 [010]  935.738299: tcp:tcp_rcvbuf_grow: time=52660 rtt_us=50256 copied=139264 inq=0 space=86016 ooo=0 scaling_ratio=219 rcvbuf=502741 rcv_ssthresh=411497 window_clamp=430079 rcv_wnd=413696
> > > > tcp_stream 50826 [010]  935.788544: tcp:tcp_rcvbuf_grow: time=50249 rtt_us=50233 copied=307200 inq=0 space=139264 ooo=0 scaling_ratio=219 rcvbuf=728690 rcv_ssthresh=618717 window_clamp=623371 rcv_wnd=618496
> > > > tcp_stream 50826 [010]  935.838796: tcp:tcp_rcvbuf_grow: time=50258 rtt_us=50202 copied=618496 inq=0 space=307200 ooo=0 scaling_ratio=219 rcvbuf=2450338 rcv_ssthresh=1855709 window_clamp=2096187 rcv_wnd=1859584
> > > > tcp_stream 50826 [010]  935.889140: tcp:tcp_rcvbuf_grow: time=50347 rtt_us=50166 copied=1261568 inq=0 space=618496 ooo=0 scaling_ratio=219 rcvbuf=4376503 rcv_ssthresh=3725291 window_clamp=3743961 rcv_wnd=3706880
> > > > tcp_stream 50826 [010]  935.939435: tcp:tcp_rcvbuf_grow: time=50300 rtt_us=50185 copied=2478080 inq=24576 space=1261568 ooo=0 scaling_ratio=219 rcvbuf=9082648 rcv_ssthresh=7733731 window_clamp=7769921 rcv_wnd=7692288
> > > > tcp_stream 50826 [010]  935.989681: tcp:tcp_rcvbuf_grow: time=50251 rtt_us=50221 copied=4915200 inq=114688 space=2453504 ooo=0 scaling_ratio=219 rcvbuf=16574936 rcv_ssthresh=14108110 window_clamp=14179339 rcv_wnd=14024704
> > > > tcp_stream 50826 [010]  936.039967: tcp:tcp_rcvbuf_grow: time=50289 rtt_us=50279 copied=9830400 inq=114688 space=4800512 ooo=0 scaling_ratio=219 rcvbuf=32695050 rcv_ssthresh=27896187 window_clamp=27969593 rcv_wnd=27815936
> > > > tcp_stream 50826 [010]  936.090172: tcp:tcp_rcvbuf_grow: time=50211 rtt_us=50200 copied=19841024 inq=114688 space=9715712 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57245176 window_clamp=57316406 rcv_wnd=57163776
> > > > tcp_stream 50826 [010]  936.140430: tcp:tcp_rcvbuf_grow: time=50262 rtt_us=50197 copied=39501824 inq=114688 space=19726336 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57245176 window_clamp=57316406 rcv_wnd=57163776
> > > > tcp_stream 50826 [010]  936.190527: tcp:tcp_rcvbuf_grow: time=50101 rtt_us=50071 copied=43655168 inq=262144 space=39387136 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57032704
> > > > tcp_stream 50826 [010]  936.240719: tcp:tcp_rcvbuf_grow: time=50197 rtt_us=50057 copied=43843584 inq=262144 space=43393024 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57032704
> > > > tcp_stream 50826 [010]  936.341271: tcp:tcp_rcvbuf_grow: time=50297 rtt_us=50123 copied=43843584 inq=131072 space=43581440 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57147392
> > > > tcp_stream 50826 [010]  936.642503: tcp:tcp_rcvbuf_grow: time=50131 rtt_us=50084 copied=43843584 inq=0 space=43712512 ooo=0 scaling_ratio=219 rcvbuf=67000000 rcv_ssthresh=57259192 window_clamp=57316406 rcv_wnd=57262080
> > > >
> > > > Fixes: 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> > > > Fixes: e118cdc34dd1 ("mptcp: rcvbuf auto-tuning improvement")
> > > > Reported-by: Neal Cardwell <ncardwell@google.com>
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > ---
> > > >  net/ipv4/tcp_input.c | 8 +++++++-
> > > >  net/mptcp/protocol.c | 7 +++++++
> > > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > index c8cfd700990f28a8bc64e4353a2c78a82bb6bcb2..f004072654a4c50da14b9dafc46133feb71f12cd 100644
> > > > --- a/net/ipv4/tcp_input.c
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -896,6 +896,7 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
> > > >       const struct net *net = sock_net(sk);
> > > >       struct tcp_sock *tp = tcp_sk(sk);
> > > >       u32 rcvwin, rcvbuf, cap, oldval;
> > > > +     u64 grow;
> > > >
> > > >       oldval = tp->rcvq_space.space;
> > > >       tp->rcvq_space.space = newval;
> > > > @@ -904,9 +905,14 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
> > > >           (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
> > > >               return;
> > > >
> > > > -     /* slow start: allow the sender to double its rate. */
> > > > +     /* DRS is always one RTT late. */
> > > >       rcvwin = newval << 1;
> > > >
> > > > +     /* slow start: allow the sender to double its rate. */
> > > > +     grow = (u64)rcvwin * (newval - oldval);
> > > > +     do_div(grow, oldval);
> > > > +     rcvwin += grow << 1;
> > > > +
> > > >       if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
> > > >               rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
> > > >
> > > Hi Eric,
> > >
> > > When applying this series I see a regression in a simple 25G iperf test:
> > > retransmissions are seen due to packet drops (out of buffer) on the
> > > server side.
> > >
> > > The test:
> > > - server: iperf3 -s -A 5
> > > - client: iperf3 -c 1.1.1.1 -B 25G
> > > - Configuration:
> > >   - Server has a single queue with affinity set on CPU 5.
> > >   - Ring size: 1K (4K ring size seems ok)
> > >   - MTU: 1500
> > >   - Client uses TSO, server uses SW GRO.
> > >
> > > Before series (includes first patch):
> > > <...>-2192  [005]   162.451893: tcp_rcvbuf_grow: time=1622 rtt_us=1596 copied=76781 inq=30408 space=14480 ooo=0 scaling_ratio=188 rcvbuf=131072 rcv_ssthresh=91990 window_clamp=96256 rcv_wnd=66560
> > > <...>-2192  [005]   162.451998: tcp_rcvbuf_grow: time=106 rtt_us=105 copied=158720 inq=0 space=46373 ooo=0 scaling_ratio=188 rcvbuf=131072 rcv_ssthresh=91990 window_clamp=96256 rcv_wnd=92160
> > > <...>-2192  [005]   162.453254: tcp_rcvbuf_grow: time=142 rtt_us=44 copied=292496 inq=91512 space=158720 ooo=0 scaling_ratio=188 rcvbuf=432258 rcv_ssthresh=270533 window_clamp=317439 rcv_wnd=253952
> > > <...>-2192  [005]   162.454446: tcp_rcvbuf_grow: time=113 rtt_us=44 copied=343176 inq=127424 space=200984 ooo=0 scaling_ratio=188 rcvbuf=547360 rcv_ssthresh=349656 window_clamp=401967 rcv_wnd=345088
> > > <...>-2192  [005]   162.455726: tcp_rcvbuf_grow: time=52 rtt_us=44 copied=264464 inq=40544 space=215752 ooo=0 scaling_ratio=188 rcvbuf=587579 rcv_ssthresh=391036 window_clamp=431503 rcv_wnd=194560
> > > <...>-2192  [005]   162.456444: tcp_rcvbuf_grow: time=37 rtt_us=36 copied=322560 inq=0 space=223920 ooo=0 scaling_ratio=188 rcvbuf=609824 rcv_ssthresh=391036 window_clamp=447839 rcv_wnd=323584
> > > <...>-2192  [005]   162.456865: tcp_rcvbuf_grow: time=40 rtt_us=36 copied=421840 inq=73848 space=322560 ooo=0 scaling_ratio=188 rcvbuf=878461 rcv_ssthresh=581105 window_clamp=645119 rcv_wnd=515072
> > > <...>-2192  [005]   162.457762: tcp_rcvbuf_grow: time=38 rtt_us=36 copied=430176 inq=65160 space=347992 ooo=0 scaling_ratio=188 rcvbuf=947722 rcv_ssthresh=631969 window_clamp=695983 rcv_wnd=467968
> > > <...>-2192  [005]   162.463191: tcp_rcvbuf_grow: time=35 rtt_us=34 copied=411336 inq=0 space=365016 ooo=0 scaling_ratio=188 rcvbuf=994086 rcv_ssthresh=666017 window_clamp=730031 rcv_wnd=354304
> > > <...>-2192  [005]   162.469069: tcp_rcvbuf_grow: time=38 rtt_us=34 copied=444520 inq=0 space=411336 ooo=0 scaling_ratio=188 rcvbuf=1120234 rcv_ssthresh=783379 window_clamp=822671 rcv_wnd=679936
> > >
> > > After series:
> > > <...>-2585  [005]  1061.768676: tcp_rcvbuf_grow: time=623 rtt_us=600 copied=72437 inq=28960 space=14480 ooo=0 scaling_ratio=188 rcvbuf=131072 rcv_ssthresh=81968 window_clamp=96256 rcv_wnd=82944
> 
> Looking again, it seems the initial rtt_us is much bigger than the
> rtt_us of 55 usec you have later (or 34 usec on previous samples)
> 
Right. It is bigger in both cases. Didn't realize that it is not
expected.

> DRS is fooled by the apparent explosion (more than traditional Slow
> Start) of the incoming traffic.
> 
> 1) Do you have a large initial cwnd ? (standard is IW10)
Nope:
09.390218 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [S], seq 2278471684, win 64240, options [mss 1460,sackOK,TS val 4277109415 ecr 0,nop,wscale 10], length 0                                                                                                                                                                                                                        
09.390224 IP 1.1.1.1.5201 > 1.1.1.2.45754: Flags [S.], seq 533508084, ack 2278471685, win 65160, options [mss 1460,sackOK,TS val 1442753584 ecr 4277109415,nop,wscale 10], length 0                                                                                                                                                                                               
09.390242 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [.], ack 1, win 63, options [nop,nop,TS val 4277109415 ecr 1442753584], length 0                                                                                                                                                                                                                                                 
09.390248 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [P.], seq 1:38, ack 1, win 63, options [nop,nop,TS val 4277109415 ecr 1442753584], length 37                                                                                                                                                                                                                                     
09.390250 IP 1.1.1.1.5201 > 1.1.1.2.45754: Flags [.], ack 38, win 64, options [nop,nop,TS val 1442753584 ecr 4277109415], length 0                                                                                                                                                                                                                                                
09.390722 IP 1.1.1.1.5201 > 1.1.1.2.45742: Flags [P.], seq 3:4, ack 171, win 64, options [nop,nop,TS val 1442753584 ecr 4277109415], length 1                                                                                                                                                                                                                                     
09.390727 IP 1.1.1.1.5201 > 1.1.1.2.45742: Flags [P.], seq 4:5, ack 171, win 64, options [nop,nop,TS val 1442753584 ecr 4277109415], length 1                                                                                                                                                                                                                                     
09.390746 IP 1.1.1.2.45742 > 1.1.1.1.5201: Flags [.], ack 5, win 63, options [nop,nop,TS val 4277109415 ecr 1442753584], length 0                                                                                                                                                                                                                                                 
09.390758 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [P.], seq 38:7278, ack 1, win 63, options [nop,nop,TS val 4277109415 ecr 1442753584], length 7240                                                                                                                                                                                                                                
09.390760 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [P.], seq 7278:14518, ack 1, win 63, options [nop,nop,TS val 4277109415 ecr 1442753584], length 7240                                                                                                                                                                                                                             
09.390763 IP 1.1.1.1.5201 > 1.1.1.2.45754: Flags [.], ack 7278, win 79, options [nop,nop,TS val 1442753584 ecr 4277109415], length 0                                                                                                                                                                                                                                              
09.390767 IP 1.1.1.1.5201 > 1.1.1.2.45754: Flags [.], ack 14518, win 81, options [nop,nop,TS val 1442753584 ecr 4277109415], length 0                                                                                                                                                                                                                                             
09.390787 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [P.], seq 14518:24654, ack 1, win 63, options [nop,nop,TS val 4277109416 ecr 1442753584], length 10136                                                                                                                                                                                                                           
09.390789 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [P.], seq 24654:39134, ack 1, win 63, options [nop,nop,TS val 4277109416 ecr 1442753584], length 14480                                                                                                                                                                                                                           
09.390791 IP 1.1.1.1.5201 > 1.1.1.2.45754: Flags [.], ack 24654, win 85, options [nop,nop,TS val 1442753584 ecr 4277109416], length 0                                                                                                                                                                                                                                             
09.390793 IP 1.1.1.1.5201 > 1.1.1.2.45754: Flags [.], ack 39134, win 71, options [nop,nop,TS val 1442753584 ecr 4277109416], length 0                                                                                                                                                                                                                                             
09.390795 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [P.], seq 39134:43478, ack 1, win 63, options [nop,nop,TS val 4277109416 ecr 1442753584], length 4344                                                                                                                                                                                                                            
09.390796 IP 1.1.1.1.5201 > 1.1.1.2.45754: Flags [.], ack 43478, win 67, options [nop,nop,TS val 1442753584 ecr 4277109416], length 0                                                                                                                                                                                                                                             
09.390803 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [P.], seq 43478:46374, ack 1, win 63, options [nop,nop,TS val 4277109416 ecr 1442753584], length 2896                                                                                                                                                                                                                            
09.390805 IP 1.1.1.1.5201 > 1.1.1.2.45754: Flags [.], ack 46374, win 65, options [nop,nop,TS val 1442753584 ecr 4277109416], length 0                                                                                                                                                                                                                                             
09.391880 IP 1.1.1.2.45754 > 1.1.1.1.5201: Flags [P.], seq 46374:76782, ack 1, win 63, options [nop,nop,TS val 4277109417 ecr 1442753584], length 30408
...

> 2) iperf3 does not seem to be able to read the queue fast enough. Is
> it reading 1000 bytes at a time ?
>
iperf3 is reading 128K bytes at a time.

> > > <...>-2585  [005]  1061.769859: tcp_rcvbuf_grow: time=89 rtt_us=55 copied=250560 inq=46336 space=43477 ooo=0 scaling_ratio=188 rcvbuf=592631 rcv_ssthresh=302062 window_clamp=435213 rcv_wnd=230400
> > > <...>-2585  [005]  1061.775618: tcp_rcvbuf_grow: time=56 rtt_us=55 copied=405296 inq=140016 space=204224 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=1927847 window_clamp=3428745 rcv_wnd=1928192
> > > <...>-2585  [005]  1061.777324: tcp_rcvbuf_grow: time=57 rtt_us=55 copied=450664 inq=131072 space=265280 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3106743 window_clamp=3428745 rcv_wnd=3006464
> > > <...>-2585  [005]  1061.783411: tcp_rcvbuf_grow: time=58 rtt_us=55 copied=521280 inq=41160 space=319592 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3364731 window_clamp=3428745 rcv_wnd=2086912
> > > <...>-2585  [005]  1061.790393: tcp_rcvbuf_grow: time=55 rtt_us=55 copied=524288 inq=0 space=480120 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3364731 window_clamp=3428745 rcv_wnd=2492416
> > > <...>-2585  [005]  1061.935387: tcp_rcvbuf_grow: time=55 rtt_us=55 copied=537824 inq=0 space=524288 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3364731 window_clamp=3428745 rcv_wnd=2258944
> > > <...>-2585  [005]  1062.977374: tcp_rcvbuf_grow: time=57 rtt_us=55 copied=545064 inq=0 space=537824 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3428745 window_clamp=3428745 rcv_wnd=2223104
> > > <...>-2585  [005]  1064.873376: tcp_rcvbuf_grow: time=57 rtt_us=55 copied=549408 inq=0 space=545064 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3428745 window_clamp=3428745 rcv_wnd=2509824
> > > <...>-2585  [005]  1065.984340: tcp_rcvbuf_grow: time=59 rtt_us=55 copied=574024 inq=0 space=549408 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3428745 window_clamp=3428745 rcv_wnd=2336768
> > > <...>-2585  [005]  1066.210718: tcp_rcvbuf_grow: time=410 rtt_us=55 copied=589448 inq=0 space=574024 ooo=0 scaling_ratio=188 rcvbuf=4668930 rcv_ssthresh=3428745 window_clamp=3428745 rcv_wnd=3364864
> > >
> > > Is this expected?
> >
> > Typical cubic reaction I would say, with pfifo_fast ?
> >
Yes.

> > I do not think that artificially slowing down senders by not growing
> > rwin fast enough is the right answer.
> >
> > If you have drops, that is because the sender is sending too fast or
> > with too large burts.
> >
> > Try using the fq packet scheduler and see if it helps.
Switched to fq on the sender but it didn't help. I suppose that in this
case having pfifo_fast on the receiver doesn't change much.

Thanks,
Dragos

