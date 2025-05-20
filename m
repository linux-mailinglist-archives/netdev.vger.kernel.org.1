Return-Path: <netdev+bounces-191735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A4ABD00E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D343BD083
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1325C826;
	Tue, 20 May 2025 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="xVFltCi1"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022112.outbound.protection.outlook.com [52.101.126.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF31F416A;
	Tue, 20 May 2025 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747724752; cv=fail; b=KTtAL/Noo2NdmFYKHMCcrfQGJbOGVqiAdocklfN9+5AZa0YRI/EkfS3JRJ3y4ipkQYJ1+Cd/j/V0jO/NsyALq9do/0ukPpRPeSP9PwanoK/7LX+9lz1X4MtMDgOPzVESKJB8xYeKlF/33Dp9TppC/ofj0kZvn/WzQ2YM6Tk0G6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747724752; c=relaxed/simple;
	bh=r4+6aUwZ+5ZHr1cVmpMyRfciA5kN8PTprLBVBg0XWKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e195U8XQmdUvitmmFJfBnd2ouDlETFhegRZOOEVWDyAO3PfVXYcTOfLJKNIWdZSNFe2+/IbNV10shspLUiMn4rLRcCMgEd4BsqdavFXe7yMRfCH+3Hu5ZucTH4tpQOz4K9RftW8E3zXXu6n2TZmbUyCq2dEh74BvJOSEl0gyN78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=xVFltCi1; arc=fail smtp.client-ip=52.101.126.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFcR/kRi8s9QmH7b/RvZKdPFWZLgsu8YbJrI9RYENeoBpvHWaMYjqhkd67QSTOoHSdxvTTaFB6EyO4Rrl5ULZDLyzMWD5U/WXbYuuxSvhNY3IspOEvmlv2cHzCWJrBYMvR2p0E1a4KBb4LDyfEHf/aP2yWTo2aS+4Qpf1QxvNYIib0UaswKVxhtfiRggEcJdVmu6Oeu43O2gqpZaqOUkzr7uXKIOfy7VHTxvcHmtJJ7aciphPAEVN314FxJDTLRll736Bi/HEbBeOeifXl6tBwGy33vaslROTImkEDh/4/ZZfzmC++l+AJ4Vd7+ZlNOjnT4K1uj+q0t5XXZz1eYj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmUouS4eryI2AeaEz8rINWBrFXAnXM/wV66IMcEQSR4=;
 b=sr3ne/iF3UOILz2Ja96ipCf+PPIq2Y2/tI2Jdlnv7wMRphbIqrBf/MbHmjCqICEPQaRAGhwxQvkNJ2g4CiiVHciS73FoOxtGFZ6ELWtSeP/t6YXUV6VMngL9CfB6xUG2NEVkr18aNo9P9nNZ/0+FhBJT6dS+fMy0wBIjUWMfIAWEcWLcAxUdihtFu5t5XyQbNBZNKnR6PiOAaKz3XhAL/dpi8B5BT0nQ3ZVl0iRJ0Sa2fm7/T2mR5BMtd9FvHx02wuWTLXLuPz3seWZkIJ1UCCt2BDGbdGNw3DWG4T7FTO0V5oBuXJY7pvKISr7Ud+1vKAfWquIf7t76bH2pC1rIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmUouS4eryI2AeaEz8rINWBrFXAnXM/wV66IMcEQSR4=;
 b=xVFltCi1WNPMGTBJlcU7NK+jLE+5NrGcshE/fa7A3HIV/C4R9vlEYLmfKJ1GNC0mvLISuZLbaJrZsqz9kWB4Rb/skX20qs7n1SiiBi7K536dygXkau/76pseV5m6W1ykRHppe144ROjj/74FXAyagFqoUuZInExZTPNO4fLWP3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SG2PR02MB5673.apcprd02.prod.outlook.com (2603:1096:4:1cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:05:45 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:05:45 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	corbet@lwn.net,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	horms@kernel.org,
	jinjian.song@fibocom.com,
	johannes@sipsolutions.net,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	matthias.bgg@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	liuqf@fibocom.com
Subject: Re: [net v1] net: wwan: t7xx: Fix napi rx poll issue
Date: Tue, 20 May 2025 15:05:34 +0800
Message-Id: <20250516084842.26c80cb5@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516084842.26c80cb5@kernel.org>
References: <20250515031743.246178-1-jinjian.song@fibocom.com> <20250515175251.58b5123f@kernel.org>
Precedence: bulk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0159.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::18) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SG2PR02MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 7714b799-1fe7-4e2c-1d6f-08dd976cbd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|4022899009|366016|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+oyX+2L+vBc8vdE9JwL0Bgu4qWePO3pG/D3YuP9FIe5Vpn+6PFVI+b/amMrR?=
 =?us-ascii?Q?Dm1bryOQc3TR+Q3fdcyiDEdB+WdWtKGafTfZ6sUoqe0vY4HsbXfnL18q7v55?=
 =?us-ascii?Q?TEhm5SqQMMyTcnwhb7a/cnwnLVGhXnYEHv5kpK7cojoiG4oVUtDi0owlWrCG?=
 =?us-ascii?Q?k0uSK/6sQTDE+rzvw5jOpQw/1gegglCCF7ECnze77mLZQ7via6tC9dpqS/fK?=
 =?us-ascii?Q?kMaxx0Ux56LE3VdHI1mGkcJNVc/xYDiWxk/i7AQiR+gKVvndrwhx34zOam4Q?=
 =?us-ascii?Q?IoqnwIFXKkc/pyZEb61c4snJ4X774Z6BzEfvrvEkIC/hlzFhXzA63+2cf0LY?=
 =?us-ascii?Q?OEUGAxwHj+lHt72zjGjjW8FzloOPZUvpx/SHkdllWnGFYBIDIS5MBr6Pj0gh?=
 =?us-ascii?Q?WRRRunKJjnPZg/wvkbrNWc2D0nD5mXIMiH6IqYw8hnCtGK5HDlrMOfHTPLmX?=
 =?us-ascii?Q?VZUdpyWscFKtLUGVEOLMavlrnacY++kACsjx1wusrP0y8BHB4m/1E9coZmWc?=
 =?us-ascii?Q?WPBBgyuQhjTpWzTA8NqQyuPcONBhkoGBt+0AoX3kIwZGs1GLc1vkCeYBhy49?=
 =?us-ascii?Q?iMPAGTJokRNnoPAUiy8PKX6d/hbHvvy+3D+EU7tHFunkrHP2lQU55o6SK7ar?=
 =?us-ascii?Q?IoQkP1DA4O/JTd5EEPs1OLNJu9hM5zjTnuKMaM5jrb0xzmBQ+8+30uhKrm9G?=
 =?us-ascii?Q?DYkyAqjDT4Is1ZQsBXfeStST78TRyH1KueTkkB5+Xi/rvqaBFkdqAm4y/WVd?=
 =?us-ascii?Q?HTW2UtaThCZsCjyUdGECSWEAKYlPS2mMh5xjycmnASeaPrVDKiFbJW+0antN?=
 =?us-ascii?Q?WiDKWyEAergRnl0y7pTu3wXqbg/S+IeHfATdqUB7jn3bOgVlATasjwcxQZXz?=
 =?us-ascii?Q?wIWwpQAyVgFmcfCdxM6a7oslyv11DFfN+fMa9nlah6qWiyHxCC8eJoFx5AYY?=
 =?us-ascii?Q?xC/lgN/54VpccxCoivjjeeb5u8pD5LwiU48HA8LVstz4S8noqRPtKfHWJp5C?=
 =?us-ascii?Q?6j4LIK+lCHQkd6G3WuYUONRaRX09Oa43DMQaZ5w1M/1Cx2pNb5zYueafGmY6?=
 =?us-ascii?Q?+Iro87g98kFsYgFcJ+9VsRq6ichQZQivDJ3GLIQj+gpwroIqteztRX4yycYt?=
 =?us-ascii?Q?N/6DCt14P+ha5L1PMJWD2oV0DXk5V5r7wqoO+pcW0IXqvjOUBTaK5JH53k4C?=
 =?us-ascii?Q?Hw5LGlahE0zgacsOv5G9ff9FTTpVDMhu1lN1dYRx1ug0Ur8rW37tDUC4Bg10?=
 =?us-ascii?Q?ZTt4dznNEYL/OfZ832X/Nt6Pz+q5wu83VKigUxuc8xHUinltP8i7VlQirpnP?=
 =?us-ascii?Q?q7PDmYErczWqRlvGW4/zVzAUOtiDQtGwBDi3WB7u9Dsy337IijMBn/wB+1nA?=
 =?us-ascii?Q?ltFS7NViBNCZxab7yxasFX9lg9eIyfzjHfesvVR+ueK+sbza4eg8quhSCfQ4?=
 =?us-ascii?Q?YJRsicq2cDDJpZpyM+2u5FmnLjkobV3WgZe+O6XWbyDW9ZYK0fMHZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(366016)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oC7thKeshSt8CSsSDO4dPBzhmkLQfhM28Akcu7BwdGqwjvSlw9Reb2zA5iz4?=
 =?us-ascii?Q?DRYBQiETg5DKRLkQbnUGBCPSs5BlIC608ZeduYdWAkpivZDJkSF1h6u5bZqI?=
 =?us-ascii?Q?oQfuaWilfXUYhWrf2GFaiNru9LtkGXIZK3y4NXtW1CBjDB+g0pq1EqEBrb06?=
 =?us-ascii?Q?8wX1r5bVTSV9W3NmZkui/6UgrjsbJK/MWzwIA2cPYEQi+9EE4Ri/Yaf0QsbA?=
 =?us-ascii?Q?CLNQavJKypuMsAahNSbLWOVertIryZNDj3sYfY4ERArkCvxbV7TYjB85r3Td?=
 =?us-ascii?Q?rdYpf4uom4LHVSYAMsMIvmVU7Q1lHcEqwRg7hF6sFNV2PIZxWgwNOUf5xeox?=
 =?us-ascii?Q?bEcYYo5/Niw+G0iFgtlW93D2Jc9V/d6tsQwD2Me1JHJ+/d/b/93HCpUlxEjp?=
 =?us-ascii?Q?c4wNp53OiGqxn3XB/jF4SWJAX8tu9Ik2Ocwqf0KU9rUrmOLXwldSgIKVmcPG?=
 =?us-ascii?Q?QivBPZUTR3Ul2UpbIloUEnh7jJ0OcUnCeu/kur/3MgvOBbCLpgUAR+OoeFxR?=
 =?us-ascii?Q?bgibzbMs3pnbIyfN8JsCVwXi5VfYp5/TXgBMv5DR/DPBgNkYzEca3jkZrWwT?=
 =?us-ascii?Q?j6EExsQ9oTFB6us/fulMaFY/yE5vPn6QHQc+ZubNfP5SzxsSuItwSUMFxeGv?=
 =?us-ascii?Q?pRLAd0Xnh7HnWKF7CPhfq+Les2PY7SwRnjYf9nVkrNJqOrA3HHLghAQ3ORjF?=
 =?us-ascii?Q?CEzsd1glsGDQaIHdsLVDMEvtg/Z9jl2KTjPLzh9/6d0m/h38J0Jzkg5i9YR5?=
 =?us-ascii?Q?5OxKsrxWqtqqLB+FRRUAH6Ew/pmdZrAEjmmfU3Jjq2X+WrffTt+POCU9fNpL?=
 =?us-ascii?Q?igxxBb+w2zwCJ9o7kGMWKbwxPeQY2qTGkQ5sZBIfRR16UE6hyO5pM06Gc35X?=
 =?us-ascii?Q?thJztXwyz+Ajs4T2AOUlKT/5IwL0OiyKOliM4/Y3dkPCCYrGCshJqDqRtYfc?=
 =?us-ascii?Q?PKuM+7EB74aMXT+w1Oa33F837h/3B9iex4qpuKKzgKojEUNsWTDD4GLADbVa?=
 =?us-ascii?Q?gtCLd+P3mTZE1+Tz0sMnj6b29TtUK9Q+9OBsvuizUxIHlwmKUReqyKM8g596?=
 =?us-ascii?Q?UrlzoENGR7c8tqmTV3/5sx15N93HvW7UkP5hM6SZfaUL4r7u9aUtwAwBgsDV?=
 =?us-ascii?Q?JCmMdv3dBr454a83GPqmPPZqX+qWvZ1cc1nmTriXHDiF73+RkEi8fHoh7QEK?=
 =?us-ascii?Q?316p4XDAUGl0h/esp9T1K4jKriSK3kXsU3xViE35uiLXpBPaKvy8dpR5VuJ2?=
 =?us-ascii?Q?HC/5XT0vumBaHKPrLqKj5Ce7WnnF8WHPDnd3sc5LxdCEgz7n2zh29q9z29I5?=
 =?us-ascii?Q?lPJMnpfEhfuSFUZpSQeZfMXS0A2WSfsEEC3cY9CrIEZBzCTSzmEkNNyBoBL0?=
 =?us-ascii?Q?GqB0552w+nlzDTlPwWqqDx+BlmpGi0YmlQ+4yRpQ/S/5+J4kuWlH/0AEGfCu?=
 =?us-ascii?Q?rC050VoXGdzUAdkVYBlDrCO33Od3NlOQk7n5JuUnbzaddAzqdd85rcdBh8wJ?=
 =?us-ascii?Q?wTh99kUs+ruo03cdo614iO/P+tHPBfSxi7r9f/tiRhxEQVULoKM7biMqIklN?=
 =?us-ascii?Q?SiPeFDc99UG48GhBJrhxtGBXWaZ+CJajt5AyTy6kN85pDbj3NCVcpEzSa0WY?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7714b799-1fe7-4e2c-1d6f-08dd976cbd5f
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:05:44.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79LZqJvmDLORSHM6ugnYlq7gDsBxCG+8L3cUfQYf7m9J/sHTdvgafJTalAOytSOPe/d3h9RbUatOFAxRm5huKVkL31ul+Q7TOZLL9/Lw1qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5673

>On Fri, 16 May 2025 15:30:38 +0800 Jinjian Song wrote:
>> It seems that a judgment is made every time ccmni_inst[x] is used in the driver,
>> and the synchronization on the 2 way might have been done when NAPI triggers
>> polling by napi_schedule and when WWAN trigger dellink. 
>
>Synchronization is about ensuring that the condition validating
>by the if() remains true for as long as necessary.
>You need to wrap the read with READ_ONCE() and write with WRITE_ONCE().
>The rest if fine because netdev unregister sync against NAPIs in flight.
>

Hi Jakub,
  I think I got your point.
  I can use the atomic_t usage in struct t7xx_ccmni to synchronization.
  
  static void t7xx_ccmni_wwan_dellink(...) {

  [...]

  if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
    return;

  unregister_netdevice(dev);

  //Add here use this variable(ccmnii->usage) to synchronization

  if (atomic_read(&ccmni->usage) == 0)
     ccmni == NULL;

  }

  How about this modify?

Thanks.

Jinjian,
Best Regards.

