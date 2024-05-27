Return-Path: <netdev+bounces-98180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF678CFF3B
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA2AB21B2E
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894115D5CA;
	Mon, 27 May 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mGHUGHuK"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189913AD28
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810203; cv=fail; b=Sm47oajg41kdaxhxjVv8JJzQtjm7XRr4q/FsviFttCY6OQuN+qwk0gWw1Kmun+O2nQiidqFxBBNYBMe72kkKZMckMI/9LbzW+//L6jUKVtmLr6+c7PdipjtvyjlVjLbPiqyJUHxVJCDivGCID3sPSH7zBR19+fAcdN0F95WTnUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810203; c=relaxed/simple;
	bh=2MXdNPv5/JX9dBcLufJCNywHLIZ1ALgkN7QUDgmBMt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TjIm3FqZmy+X8JquGHy4mnQrOEnsF316S6GYpy3Ueh3jCS8SlDonQjak688A708aMLgArCZfseUMQ2OJF2F8Sszsb+yG1ZrNo/m6WvmczpKRGQ4Y8IWJxzGCkQ69299MqasDCkkDafMV1xIl44YJmZdqSyAH8W8KH3WePm7MB98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mGHUGHuK; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ptu6D0hZ5gdSG1vxOur0Cp0NnxHBaFaYzelIPaK7GJ6BEIGcwgU6AjB8OWKEHXtuxWUhFjWa3C3XzWxGuG4xP4/U3HV+YLd2p8E8nVyQolVv58w+rvuxpaWWh4M+SsT1EEd3Fob510tRyREsPqkAJxDmoB7eTx1sAYEOv/qvKp0CQasmr1EXAyik5ugLbwgjL05CaL5HYo8/ZlA9tZBNTSCt+0K7C7ZMAAGCf5aLvGWx2SaQOl2gYMo8vbfIcCmxdjSVaqWVJA/T6TQtCdCCsV6pADsBeX8LOE5M+NyuIYZa/FFv+0YsIDE/BQU2RD+eQB0Svo29oL/Auc5wCshZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3yFNv+hmMWfDDHN8TQlP+NjRka52PYEN6NmhpVZR9A=;
 b=Jn9mMCx1bYTLTvqQyrRqECt2j6VWr//rOtz5QoBsnZSFVkOYmphmffO7LNZE8LbELirq8Iy86Lc+0KkBQpmTZQ9yvEfmzqB82UQrBt/E4NKpMmv9RE3qlgEdoE8G5L93BrOHFas9CmV+Q6O6Hsw6eun4xHSqLGanOtVm5jJQCzLRxJPssMcZVDuq9MBIE5IpM2zbnhMIdaeeUG8OW1zBwkbYmBO4hfgxi135Ej3pLKKUX5h2lqMTW0a6rQCS1oyJvqludJ+0dzHqarAMrzz657tbYnrBF8XDdbIQfgqtuTz1SV5pxZuC8c8zonC3xZRZaRaP7bpevtQcgkl9T/0ozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3yFNv+hmMWfDDHN8TQlP+NjRka52PYEN6NmhpVZR9A=;
 b=mGHUGHuKccJGVqNFN/SSXTTGWTBIoLZ0qay99F9NJyCHmpC0q4aN/rnGvN0oBSikTcnrmhP8cbIl9nYJJAo0k5IWSlu8MuXvBiOPVEAfWSJzSWFdw7lzl1kgQWtnA60Xqpog20Gkt1J9XEtUI2dyEfG+vQHWuAsD91GCSgMEuts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AM8PR04MB7395.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 11:43:18 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 11:43:18 +0000
Date: Mon, 27 May 2024 14:43:14 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net] net/sched: taprio: fix duration_to_length()
Message-ID: <20240527114314.jqqw7sqwayjsgoby@skbuf>
References: <20240523134549.160106-1-edumazet@google.com>
 <20240524153948.57ueybbqeyb33lxj@skbuf>
 <CANn89iKwinmr=XnsA=N0NiGJhMvZKXuehPmViniMFo7PQeePWQ@mail.gmail.com>
 <CANn89iKtp6S1guEb75nswR=baG4KN11s9m+HQZQ+v_ig3tOUfg@mail.gmail.com>
 <20240524160718.mak4p7jan2t5qfoz@skbuf>
 <CANn89iKiox74T-ytObEoajCMR+cVHfYbGvSJOGObKTBpHxauvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKiox74T-ytObEoajCMR+cVHfYbGvSJOGObKTBpHxauvA@mail.gmail.com>
X-ClientProxiedBy: VI1PR02CA0074.eurprd02.prod.outlook.com
 (2603:10a6:802:14::45) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AM8PR04MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: e634506c-4005-4a4c-44c7-08dc7e4233eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2RHVWMzc1kzWm5MTGYzeEpnS2xIV0IrVnBPOCthYjYyQnRVUFVGenU1OS8x?=
 =?utf-8?B?WlY5ZmVZZU1RcmZQU0RjQ2dCb1hydWMwcXFiL1dhNVN6NzRTL2kxRUthVStm?=
 =?utf-8?B?VXJVa1U4QTdmS1NkK0dENXcxTlcwUHNDcmVGKzMreTNRRXVRb2s5WkwyN2lG?=
 =?utf-8?B?cHdrQWoraFR1YjRwODRaTythYkFnV0I4VTJtbHN2SURneTVMeWtOejBZR1Fr?=
 =?utf-8?B?NndRdmk0V0dndHZHVW1BNUdwMUlPcU54VHJwRE03NVN3YWhEN3BZcHNreHVP?=
 =?utf-8?B?ZmxJZ0ttb2RCNElkN0xFQzF5WHVmVno2dUdMOTI2N0V4U01mZFRsRE5FSlBT?=
 =?utf-8?B?RTdiT2oremF3cmEzc2orM1h5bVVQRVFiS0FzK3ViejVBVjF6TUlGWlcxTlZ4?=
 =?utf-8?B?SkI4cFpHMENDdi9CQWJGNWNyUUVQUTFmNFRCOURZUUFKanBzOTRBbncrVGRL?=
 =?utf-8?B?bGlSUGJGcEpGMzNGcEFnZmZQbG91Q0hoTWFHbytnSnN2TkNWZTkwSnZVcEp0?=
 =?utf-8?B?VEZjR0ppdlQ5SXBZcjQvdk5ISkJ5a3BFandCUW9rM05xNTY3NmptZmxBa3p0?=
 =?utf-8?B?MmI3VTNrN2NGelBhbVNEejB3c3NyMGNJNkd3N0VhSlJMbzIrSjUrTWp2cjFz?=
 =?utf-8?B?RS9iWGdEUklWQXpPWSthbXc1OWEwczhUZTFqQVE2MUw1RlgvSnVWU1RUVlRW?=
 =?utf-8?B?ZnJRV09GRSs2S2t5Y2dOMHpUOFNCUFlqRjhuWEpxa0ViZStZRFBSMWRDNGFp?=
 =?utf-8?B?aThTYlJaWDYzdDFSOXpCNGZWaHVSRE93c1ZpbUh1bkMzL2xZaCtBczZnSzE1?=
 =?utf-8?B?U0g1SFVvMzdwZjJ1Z2dTU0J4bkhsajVMZ1dOVnZRUlFaREFvY3lyQ0lYeFdt?=
 =?utf-8?B?SUZuQnROTmhhellJKzJFdi9UblVYWWtjTTcxZzBiazdlSGtWSFUvdytjUWRH?=
 =?utf-8?B?VVZkMVIzUGFKdUJpckVJeXAzN0ZwNGQ2Ynd1WkJIeno3bUIrMGdtY0pnTU5w?=
 =?utf-8?B?S2FXYjV2dXRKeERLVVZYRkVVUHozUWM3MDMzMU9MbXZzSWZscklRMmNUeGpI?=
 =?utf-8?B?VUFaWnBYTTFoalAyWlpPNWlqczFwNmVyc3B0TGtRZ1VZczJOY0xJeGdRTXBt?=
 =?utf-8?B?NHAxaWhwejJqc1dEN3ZTNThWRndBS251c1VlNG9TZzVkcmFReTF6UkJBV3NP?=
 =?utf-8?B?cW1HV0U3Y3pRTTRvYWJtRGkyU1FlYmFXMTFKcWN0RE9scDdxTmg4bXFVc1Jp?=
 =?utf-8?B?MXpERXNMcUVwY0pYS3VySHFZOFUwcktOZ0FzSFliZDc4SkEwOGtUejBhQkp4?=
 =?utf-8?B?dGFXM1NYZm5JajcvK2xJQXQxVXpSTGU5d2c2YjN4QWUzVWtQb3hUak41TTBN?=
 =?utf-8?B?ZlYySllVVHhJanROV0drb0NnU3FERmNCWjN4UmppS1E4QkR1R2xRR0dONHN1?=
 =?utf-8?B?amlJelpISUNrdE9Qa0dyVVIxZlB6Ykhpck8yTXg3OWs3VVBBV3VWNUJsTkJ6?=
 =?utf-8?B?VUtJbU1WRld6aG9mY2tJeUpJVFh4bi91UmtuR0xvUHROYWwrNjk3MkFlNEU4?=
 =?utf-8?B?WkZvOStqdDd0WTFCdnBSSHBzRTV5dXRZeVhaNVYzVzV4OEE5dHZtT1VRT1M2?=
 =?utf-8?B?QTJmbFNYeEZqYzVZOUtoN0c5VS9pUGo0K0w5VmFqMWlZQXg2V2VWK3Y3YWJN?=
 =?utf-8?B?cGcrWVkrcHB1Q3dRYkpRVVRES2NjajhFOEZoUStTeHRpWnRSVTdNTXVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVpwZ2REWVQ2ZlVrQzZPTElZWkJxRGNOSWR1SXZaNkphUVFkVW5zTmNLaG0x?=
 =?utf-8?B?cWdCT2V6MzkxMWt1eEVSeUM4L2xnVStkWXA2TDQxa0g2ZmtHOWttS1BTdlo1?=
 =?utf-8?B?MHpRNEpEakxCQVBYd210aXMvL2VFY1g1OW9PSkh3M3djMjZZVmtZQkdhQWtn?=
 =?utf-8?B?aTRqbW15b2xNNGxBWFhoMXJVTUFDK3N2M0kvNkp3aytYb0pIUjJzWTh2L21C?=
 =?utf-8?B?M0QySjA5Z3d5WUVTZFo5ODIwU05tekZlbWM5a3hrTzZTSUdHUWplK2wxcm43?=
 =?utf-8?B?N0h4aXdRa1UrY25oQnBncUwydnNJTjdYMFN3dE9MQjZJNForUVR4RzlpNXlH?=
 =?utf-8?B?NDdVeDVtN1lVVDZxOFJLUnNHWlF4VVJCcUY1TGdrZUVvb2VWVEYyOVhxUExp?=
 =?utf-8?B?MEZLQUxqM01mWGljQk1ZeENWRmhmeWg1MUFnb1dEcHNhLzM4ai82Nnkvd1pu?=
 =?utf-8?B?OWVENTlKdGpqeGJjVUwxVDdxTmdmKzNtRTJmYkhxK3FGVnFNdkthM21jNnF6?=
 =?utf-8?B?TDMyVWIrUVpsZG9zVDhKRnFFWVBpL0tiRkZrbENRdkgvOUFFZk1peEpTNXd0?=
 =?utf-8?B?d0hQeHh5K1YxS0l0SlNYZFBEL2VvTWRIVklMbkF4KzZmRWM2SE5vUkJuSGtT?=
 =?utf-8?B?OElTTlp0cHhMZE9nQUp5U2FkOXJHNXROZWVZL215NE51ZjFacm9LNWl0M3Z3?=
 =?utf-8?B?VU9sRm0xOWpxUUg3K0x3eGNUTlg3ZjljSFhRbWRPaEcvUlpPenV0dkkvVHJi?=
 =?utf-8?B?djhNeElyNGtYYUZ0Y3FBMjhrU09PS2REVTRiVExuTDVxeE15dVVYbVkyS0d6?=
 =?utf-8?B?T3JaaHN5YUV3cWlwemJsY1Q0QlBvSThZMzZtclJ3TlJBdUhIUUZ3S1UwUmR5?=
 =?utf-8?B?eWZLcGtkUEwrdGMvbjJyQUtQanBhdGh6Z3k0Y2NLMG82LzdPVHpDY0JVSkhy?=
 =?utf-8?B?MGN2eHhBZ3pidXNvVmJUTFFJT1lZZ1dhNFRTRGFvWE1mbjc1U0NlaUhpL29o?=
 =?utf-8?B?Vk5LYjArbDBkdHBYTTNxZDFNOHZ0cXVWdzdONk1ndFE5dlNvYjROTWRraHJZ?=
 =?utf-8?B?dEZVblZLT25vcjAwbzYxUEEzUHdnZEwxM3BiUEhjSnVSblhDcWpyRkdoVmh6?=
 =?utf-8?B?aDd2di9BdHdZNjZKK2U5L0NrSDRrSEtMQkVtMFZkblQ1ZFRZcjdMSE53YytV?=
 =?utf-8?B?R1Nmc0FJYnJray9CaXRsK3FJZDVtQ1lTcFdaYm93MUdtTXpJWFczSTh4MVp6?=
 =?utf-8?B?L3NEUWNyK2JIZ3VReWoxdEV5RCsvaDB2STRrSDkvdE1BMExtUS9ZMURBY2pO?=
 =?utf-8?B?amNkeTBGWFRydXQzcGZneGJaSkxyWndLUEN1b3lFbFErd0dCekdJWkxPTUxW?=
 =?utf-8?B?TFZsTldjYkVqQ0ZxM1BOWGJvbGVqTWdtMXdxcEdYcUhFSUROckEraGNoY3RK?=
 =?utf-8?B?R0lLemF5RGwvSlhTd1FETWZLTXJIdHVBcm9LWmVPMko0VHcxekJtVlozaTFE?=
 =?utf-8?B?d0xVVy9sNEc1NlhRQUtPQzZyL3QzMmNjM0RoS3I5SkpCZm1RdHJ4UE1IT09I?=
 =?utf-8?B?Q3JBd1Vybng0T2FLVkxWVGdLUFRQZ1VuRE5BKzYzRlVjNzJYZ0lQVXVxSnQz?=
 =?utf-8?B?V2lEWlNhb2hrWjI3aFh6TlZTeGN2YW5zMlY5d2laT2VjUmxGRk05N1hWckFx?=
 =?utf-8?B?cnIrWU9BUTNkY2ZQOVBLdjhpbExMOWsxNUNtVzZEUndpU3cvMlIzaVNsd1k3?=
 =?utf-8?B?U0NjVGVVQXFJQ1hQZUlNM29FeVJSTjZkSFJRWExjSTlBeFdoQ1FvWjN3TnNo?=
 =?utf-8?B?MVRKUlJpSmFlVitoc3N1ZWtzNFFpYWpXRGhHdUZFRzBCNlhDRjV0RU9URkFQ?=
 =?utf-8?B?cTE5VVc0YnNEU2ErY2tYS05GWThYWldlLzhjcXZaM0xTNlpRZHBnREREWE9G?=
 =?utf-8?B?ME1xcjN6ZldQdFFrL1J4S2FlQUs4Nlpjcmljam9CTTlxeDBFaERwbGgxclp5?=
 =?utf-8?B?bFdiY01USDJtMzZYQXduNnArNitmMFVEa29qVEFvUVNtNnhabW9sUWduUU9n?=
 =?utf-8?B?UXZFakVUWlpPTGIwTnBnUElsMUpVak1VRkxlTmlMaW5MNElBaFpNOVgvOEtO?=
 =?utf-8?B?VWV0UnIwQlo1RitodXR2NEgwSjF1OHNwYXQyVTM0WE9LZDEzbzdHSy9EcldN?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e634506c-4005-4a4c-44c7-08dc7e4233eb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 11:43:18.5182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ql+4HPDrF94O1uQwAmyi0s7aC5ECs4H5mPsDg1DzBsqFWvHitaKJ1x7w7D6u+vUe5c6zEvkavk3da8kHYcXaJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7395

On Mon, May 27, 2024 at 10:07:31AM +0200, Eric Dumazet wrote:
> On Fri, May 24, 2024 at 6:07 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >
> > On Fri, May 24, 2024 at 05:52:17PM +0200, Eric Dumazet wrote:
> > > On Fri, May 24, 2024 at 5:50 PM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > On Fri, May 24, 2024 at 5:39 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > > > >
> > > > > On Thu, May 23, 2024 at 01:45:49PM +0000, Eric Dumazet wrote:
> > > > > > duration_to_length() is incorrectly using div_u64()
> > > > > > instead of div64_u64().
> > > > > > ---
> > > > > >  net/sched/sch_taprio.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > > > > > index 1ab17e8a72605385280fad9b7f656a6771236acc..827fb81fc63a098304bad198fadd4aed55d1fec4 100644
> > > > > > --- a/net/sched/sch_taprio.c
> > > > > > +++ b/net/sched/sch_taprio.c
> > > > > > @@ -256,7 +256,8 @@ static int length_to_duration(struct taprio_sched *q, int len)
> > > > > >
> > > > > >  static int duration_to_length(struct taprio_sched *q, u64 duration)
> > > > > >  {
> > > > > > -     return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
> > > > > > +     return div64_u64(duration * PSEC_PER_NSEC,
> > > > > > +                      atomic64_read(&q->picos_per_byte));
> > > > > >  }
> > > > >
> > > > > There's a netdev_dbg() in taprio_set_picos_per_byte(). Could you turn
> > > > > that on? I'm curious what was the q->picos_per_byte value that triggered
> > > > > the 64-bit division fault. There are a few weird things about
> > > > > q->picos_per_byte's representation and use as an atomic64_t (s64) type.
> > > >
> > > >
> > > > No repro yet.
> > > >
> > > > Anything with 32 low order bits cleared would trigger a divide by 0.
> > > >
> > > > (1ULL << 32) picoseconds is only 4.294 ms
> > >
> > > BTW, just a reminder, div_u64() is a divide by a 32bit value...
> > >
> > > static inline u64 div_u64(u64 dividend, u32 divisor)
> > > ...
> >
> > The thing is that I don't see how q->picos_per_byte could take any sane
> > value of either 0 or a multiple of 2^32. Its formula is "(USEC_PER_SEC * 8) / speed"
> > where "speed" is the link speed: 10, 100, 1000 etc. The special cases
> > of speed=0 and speed=SPEED_UNKNOWN are handled by falling back to SPEED_10
> > in the picos_per_byte calculation.
> >
> > For q->picos_per_byte to be larger than 2^32, "speed" would have to be
> > smaller than 8000000 / U32_MAX (0.001862645).
> >
> > For q->picos_per_byte to be exactly 0, "speed" would have to be larger
> > than 8000000. But the largest defined speed in include/uapi/linux/ethtool.h
> > is precisely SPEED_800000, leading to an expected q->picos_per_byte of 1.
> 
> This suggests q->picos_per_byte should be a mere u32, and that
> taprio_set_picos_per_byte()
> should make sure to not set  0 in q->picos_per_byte

This is what I was hinting at, indeed. But we're getting farther away
from the problem, which is the fact that syzbot _was_ able to trigger a
division by zero somehow, when zero was not a valid value that I can see.

> Presumably some devices must get a speed bigger than SPEED_800000
> 
> team driver could do that, according to team_ethtool_get_link_ksettings()

I misspoke in the earlier email. SPEED_800000 is still 1 order of
magnitude lower than the maximum representable speed (picos_per_byte
should be 10 for it, not 1). So, we should still be good.

> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 1ab17e8a72605385280fad9b7f656a6771236acc..71087a53630362863cc6c5e462b29dbef8cd5d74
> 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -89,9 +89,9 @@ struct taprio_sched {
>         bool offloaded;
>         bool detected_mqprio;
>         bool broken_mqprio;
> -       atomic64_t picos_per_byte; /* Using picoseconds because for 10Gbps+
> -                                   * speeds it's sub-nanoseconds per byte
> -                                   */
> +       atomic_t picos_per_byte; /* Using picoseconds because for 10Gbps+
> +                                 * speeds it's sub-nanoseconds per byte
> +                                 */
> 
>         /* Protects the update side of the RCU protected current_entry */
>         spinlock_t current_entry_lock;
> @@ -251,12 +251,12 @@ static ktime_t get_interval_end_time(struct
> sched_gate_list *sched,
> 
>  static int length_to_duration(struct taprio_sched *q, int len)
>  {
> -       return div_u64(len * atomic64_read(&q->picos_per_byte), PSEC_PER_NSEC);
> +       return div_u64((u64)len * atomic_read(&q->picos_per_byte),
> PSEC_PER_NSEC);
>  }
> 
>  static int duration_to_length(struct taprio_sched *q, u64 duration)
>  {
> -       return div_u64(duration * PSEC_PER_NSEC,
> atomic64_read(&q->picos_per_byte));
> +       return div_u64(duration * PSEC_PER_NSEC,
> atomic_read(&q->picos_per_byte));
>  }
> 
>  /* Sets sched->max_sdu[] and sched->max_frm_len[] to the minimum between the
> @@ -666,8 +666,8 @@ static void taprio_set_budgets(struct taprio_sched *q,
>                 if (entry->gate_duration[tc] == sched->cycle_time)
>                         budget = INT_MAX;
>                 else
> -                       budget =
> div64_u64((u64)entry->gate_duration[tc] * PSEC_PER_NSEC,
> -                                          atomic64_read(&q->picos_per_byte));
> +                       budget = div_u64((u64)entry->gate_duration[tc]
> * PSEC_PER_NSEC,
> +                                        atomic_read(&q->picos_per_byte));
> 
>                 atomic_set(&entry->budget[tc], budget);
>         }
> @@ -1291,7 +1291,7 @@ static void taprio_set_picos_per_byte(struct
> net_device *dev,
>  {
>         struct ethtool_link_ksettings ecmd;
>         int speed = SPEED_10;
> -       int picos_per_byte;
> +       u32 picos_per_byte;
>         int err;
> 
>         err = __ethtool_get_link_ksettings(dev, &ecmd);
> @@ -1303,11 +1303,11 @@ static void taprio_set_picos_per_byte(struct
> net_device *dev,
> 
>  skip:
>         picos_per_byte = (USEC_PER_SEC * 8) / speed;
> -
> -       atomic64_set(&q->picos_per_byte, picos_per_byte);
> -       netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld,
> linkspeed: %d\n",
> -                  dev->name, (long long)atomic64_read(&q->picos_per_byte),
> -                  ecmd.base.speed);
> +       if (!picos_per_byte)
> +               picos_per_byte = 1U;
> +       atomic_set(&q->picos_per_byte, picos_per_byte);
> +       netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %u,
> linkspeed: %d\n",
> +                  dev->name, picos_per_byte, ecmd.base.speed);
>  }

I would be cautious about making this change not having certainty what
was the picos_per_byte value (and associated speed) that triggered the fault.
I'm hoping we're not masking some larger issue about how the speed is
retrieved or processed.

