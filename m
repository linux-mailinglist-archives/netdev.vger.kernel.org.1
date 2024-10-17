Return-Path: <netdev+bounces-136655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A729A2A1C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5904B2980E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24B51DFE17;
	Thu, 17 Oct 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ve8DJ0Qa"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6F1DFE09;
	Thu, 17 Oct 2024 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183972; cv=fail; b=FnofPzNSHmbVq7iVYJ+XxvwQCESv06ZWTjfWuH43qJUX7O3w9IJgolfH19MXRUiaiFfLyfco+MI5x3SjF3MF6dN10VNqHnYpyiJh1Tihz/FmJYV0OCgJd7gN5eFten4gDK/hU16PIezh4kGP1W+5pewIYXWXKkRQEkqCP4tHrDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183972; c=relaxed/simple;
	bh=8X/ng/ITkku5TuCag9lOPC01Pjy6+sBzmUo9OwDKPhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mN0bFkLm6UIawFezKPvxs+fGLIn+FDsLo8Wpa7SY0T/74xCJVfpsO1Wo+mMASyxt0yC5kjMT5/4jRSkVa0jw+xwA3ipYRvQFPmUugVYVrmo7biiP8BKJOm2apjT5mXwkPHGIx0dbQtQ7on+Mbm3UHKtyhugAzgGeGbgVoVoiCII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ve8DJ0Qa; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p492kbJOV3Y1JKAS1ApjUItyvhMWz5xl81O/RIcnv/4QZuOfhVtuRDpUcXLFALlXi8//uM3eKxFlgQpvkTUtJIZMs5lHu4+jOjZJg4cbZjIUNk5cyL1OzR9Qvm1+8bxCWHlk1Aj1weJO9IkjZT+AFA2uvx8Gbp/2z5C80tPVgsrrRN3+qLgFVfZPlOWI65ai5cTRf65Hupa16V5bVpoIDCtsX8T1SQJSwdKbDQ0dv21KskShrw8zbC+B8c7B8RP6/t+rxbxbB8rMP8PNIa+85zC7XxyjOJCzgTEdwZTMYx16xpAACaT2fHl57gyYnN7lfNBT7r3frnHm4x4NBKi1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjTGaZx7m/Ncoc+EIeo0xDgDS0nmB+x9+grt1iYqvJc=;
 b=loAkcdCLiTKCCObCuxz9Ij8V3YTL3lIMzCeCTHh2k41Z2nE3rSfItqxavNM3n/kbScZdqQabhNpWd5lEdRI6YhHJ6YBeAnOOHXYb+fOaxl9Sgyy/ekBHzPlVsU+5NjHdrIoAV0wvMwjOo1RHRIii7Cm9kp55pEoeY8FmF2stZhlJqcYVB3bZrPGMs2Cl1QFTc9Ys6i2V6hs3QasZDUuraV4RvbbS+IPenSglV+g8aSnptPU6k2/ZIVlfEiquFujRdKwbaTBUWpX0uiFJzsjrWYC9Dzj7VOLVSneJoLDgTC+oeGjiRwnYeuJv/ZDxT+ipdsaWS/pzuJNCb+qmv2Eiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjTGaZx7m/Ncoc+EIeo0xDgDS0nmB+x9+grt1iYqvJc=;
 b=Ve8DJ0Qa9ld9YFeK+r5YHUxEeh1DcUG28TGAqJlL2XK6/UA/ZY6DtuU21jzJVx7NNhHPKAP+7XaGIRon76+Ip/GK7JtcR4NMODNQlO/bSILuvAb2v9aWvUICqY73DEj3iyXI1krrwlFUD4MTKu2NI4Xbz6N+aF8d+j64hkNv2buTxKFHDN+kVqUXKUDXImQifg3YJgxhJ/haftAgWpk52VdFe+Gw2fe/yZGGetXoNfxgMqkg5NgVec4Mn5zasiv1FcpNd1eEl+pK/MmoRPclMl1Vw29CC4R37P0OufvnNAPkDPqOhq1LKjQWqzeVWPWUg/UgaqNH/2v9HefC5Mv3JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 16:52:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:52:42 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 1/6] net: sched: propagate "skip_sw" flag to offload for flower and matchall
Date: Thu, 17 Oct 2024 19:52:10 +0300
Message-ID: <20241017165215.3709000-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0259.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b51cba-900f-4ca2-1756-08dceecc1e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYjMGstpj59Nc+bc9YZ71pDydlsoYQvq1FtHrujZ7y5OsOvImN2T4N2ULZkw?=
 =?us-ascii?Q?s2digPbxS9Gz77me71JVDr/mpNdkKajix41bvrtM1xlGoYOlyHvwmZNQkiV/?=
 =?us-ascii?Q?Dl9H3mB629HsTSN/Aj9PuzuO+9s3rE8XJ8clF7frtWCDO7dQzH97y1wJrA9R?=
 =?us-ascii?Q?1LrCjHfSecFEBKSiHWbRfRvJuzHjk/yEv+CcFoj8FwmuQWDjFhnkGzXikXgW?=
 =?us-ascii?Q?XBLogGffQF26XyTLZndRABTNfSyrX50W709zs4Ih8gvEh/M1LAxy8lqI/Q+i?=
 =?us-ascii?Q?VbwR3R7kU5xoMu/j998BdYFaDRl8ME/nVZoFEUucK0q6HYyAP2tgJSXmg7iI?=
 =?us-ascii?Q?3CLJimwBRqA0hqOxis2nJ7GEwkPPo+nwcAUK6/IB9kxwy+KCpO1ohAHfo52j?=
 =?us-ascii?Q?llskaOnB7LZ/MXFPnhGCpb3LpIK7WRupmTfxYezkkhOs8BOeAcpPMt4TPHt8?=
 =?us-ascii?Q?JxT/MixuMtAoN5N10YBdjwd6tAH53OybFYIgi+e4htKCxJGmlIjMEvCbjIfv?=
 =?us-ascii?Q?f0KIxyEPziVbHkapepKSP3WNqhNxWS90pegelkBwI+dli4E/2Ioj+8+zu3OQ?=
 =?us-ascii?Q?Yf3Agn5QoN7yA/XH86Ihni7US2wVfcPrqx2DtR2jp+ygNTCzUyG+NdqFYzWg?=
 =?us-ascii?Q?ZdPe/QGJQg1+kKD6iMP4UUNOTWOQ6885zc+UqgTsF8xK28CykSlpx1A2H3IK?=
 =?us-ascii?Q?OZKu19aDbO9zgfIB9hLMGJvoWYBlssm6awgqTGZ62M1VM1JK4lXPH5y2iVWt?=
 =?us-ascii?Q?5orThV2ZT1DXBCbLqrbiQ/qvEmE3FubOruAz7yx1yOrEHXm4xXbPjeERXvxL?=
 =?us-ascii?Q?//HOiIFbmUoQRfFFoE6LcfaCrTuY0nJtNPU1gVCF5VV0FsDnZLtYFyg7oAeL?=
 =?us-ascii?Q?Cr3M8HgMP0fksokaVwfP352OXLhpnVQsoORCyBmcjNtM/I/8gZF1Xcm3+6rt?=
 =?us-ascii?Q?Zf4r/2qQsoqVBfb3UI05BMCg22A+l7vBkn/5gUFUMd5UGwPh+X2/vUWkL2zp?=
 =?us-ascii?Q?J5iwsAyw129sIS558bMbAiRGe2of/1HLXAk1mQFlwmnhlpccv9YoW7dPzZKW?=
 =?us-ascii?Q?/pVPQW2GzllaYpZHH1fj4ptnL02wOVPOl3z7ef2h+mBopo9tLWyrr1ScA48P?=
 =?us-ascii?Q?joH4BmH85agIIcf6IP9L+1G8JxrGDc+crAn7qzzOGX95fBqj2kZsa+mhUlqN?=
 =?us-ascii?Q?/vxZ1wDPKVbu+jAeBuTjAO//m+piaBxwlqKJz2TSah0xUY9QvWOTPp67oxOq?=
 =?us-ascii?Q?WPEcdHPrXUF/yBUBkPDhNHCHK14b7ksW5p77ixQa4q2DfXxCpRXU8KXaPv0V?=
 =?us-ascii?Q?7+pcu8PSrS/GaxZfBcUZjySdE4TDJpPBTJ1spU/tkJnHXNaQsb+RGc9+shr5?=
 =?us-ascii?Q?8WclV1OifYYDEvwVYLbaf+ksUqcV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDEeuu+whiBvgjXbY8Q6AcSxyRd6AnQTuhF9gDHCKWMZlBaw9cFjbgZC86Y+?=
 =?us-ascii?Q?5NuncixhVy6dPd7ZMa5+0WinM3vav+luOvjrloCyseYlo2/WHB1jJAcCUSbc?=
 =?us-ascii?Q?GRSbnqpCNB9G08ZXA8VgEoPt+KpAPosewjC34m0E+CS+oW4abXP9kwGmhiAj?=
 =?us-ascii?Q?Bo5bLQW8Ea+KBHBMKbsk0uvZ5yZ4V0Ke79BR8XZfsdxzBEmi7yTp2DGyNLdl?=
 =?us-ascii?Q?xYpiJ5VrCHFQSWrLNMFIHBCVSLe+IQSpeL5O1xq+V+mvc8LSHcq5d3U/Cn5A?=
 =?us-ascii?Q?MpOorv+x1Vm3CXZ0wCeAG+6ZRuG+nu86wuEfr2pL7FT156g059UXkSAX4F0z?=
 =?us-ascii?Q?L8DRnzNnZJjupWtyFVKYg6waVlf3n1qdXdbpySZ5MLXQnq0tj3BgPF86YksF?=
 =?us-ascii?Q?WXtCqKLCnP/cdDRmGYEPGlV0GyaXielw55g7BLz2xtwammqCvY/9zyzqKY8M?=
 =?us-ascii?Q?XtGyRE12ockRn9sk6YyeBVmIpOih7Q2whD0hRXlqiWYGZKe1HOMZQBSDkVkZ?=
 =?us-ascii?Q?jShcTvv1/gYOkaNvMiRP/Y6d+0z355mUztmNnC1t9SBoVg50rxjyZMu7WhM2?=
 =?us-ascii?Q?Mv5w3lNcJPJtvFcfTr85okc+/6RMxnydmSslQhYbKYCcLosHQGGf1mMbqWTu?=
 =?us-ascii?Q?rHoabuWq83WNqxlykAnOlYi1RV+I9owoMtOWSw05VYBZ8XDbavigOA6QtlR6?=
 =?us-ascii?Q?Yy2vkPNebPSJDWnGctcst3V8nji5m3TFNoy2/2xQPAK3RcW7g7TSzWfaVYla?=
 =?us-ascii?Q?27SVsgcNccUZ5tPqvy4VUB+JlSBME0SoNa3pg8yNsSpl4ZzJFabj+X8p4MWH?=
 =?us-ascii?Q?EvceEp+veV/noht8PB/IRzUO5gq/67NpCXS+0LLoOVyUoTsF+Dm/FEvtjdfm?=
 =?us-ascii?Q?lgfF6Ac14IOXAiHuPNtB0UyAxGSDaphmdlaxZF3zBVvwUQmacDO8/buTD5Bj?=
 =?us-ascii?Q?XOsPNnMcXfx5k/Ul3XzfCkjd47hVM5Zz8I+KPtO0d/2XGTQOsluuxZ6dEv+2?=
 =?us-ascii?Q?pD+vb2xqWjj59EOQkR3NMjqHsyWoMRCCAzWG36bh1O6SNMibgHMNm9Zpb80q?=
 =?us-ascii?Q?A+YPKOxeKdbQukBjtJUKq+phnufmPJ47r/MuOdK2fg48AkF/EqIv93ERBnTZ?=
 =?us-ascii?Q?NAyMYhJxF951h4ugXYqKX8UH+RW7B17W+4hO/33JBhLSxVMMRkaW3V3RabVH?=
 =?us-ascii?Q?Dt88pfbo2JL2Jh8qgoq14ILjei2wFAovhrMFTdaC2urzQsUjqZ4QI/DHwhKR?=
 =?us-ascii?Q?CAdgDES3wM/5QBlhRcarzY756Lgn9n0GHz5bpwKR8wwJHPfH2R70QTC8VWaW?=
 =?us-ascii?Q?mycEKcTi1qDXvYaMLnkCPeq0SrdQqbo64e+S4BY7QNZV0/MDzdt2PLxPETLn?=
 =?us-ascii?Q?MmlfvTtq3AB1s43XHV9J6xapeU7dB1D41bmv2FCNKU88p1zCRs6imkxaq/jd?=
 =?us-ascii?Q?0hsyUbn6+3uFPqfGK/i6iPIkOXQtk6aWZThLfSJ1wPaIO0oq28ULFGVpYBX6?=
 =?us-ascii?Q?SABbVxmfOYjpwXMzUeN5qcV5czBV9xFEc2OjvA+IezirY1VeKN5UWJfZxfTi?=
 =?us-ascii?Q?8zYSNgtgqAJUTEK9XnEOMrOll5TCPWiUmo9ZNC5JJ+Yf6sUmj8nKaoXYGNt1?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b51cba-900f-4ca2-1756-08dceecc1e09
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:52:42.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K30xbE9RevnM4427SBta+gzCmRSGOz+nudhk8hEqu/7/10PhTrGinnr0AKd2xTcuwYnEa6hy5GNgqrh7DjXphg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

Background: switchdev ports offload the Linux bridge, and most of the
packets they handle will never see the CPU. The ports between which
there exists no hardware data path are considered 'foreign' to switchdev.
These can either be normal physical NICs without switchdev offload, or
incompatible switchdev ports, or virtual interfaces like veth/dummy/etc.

In some cases, an offloaded filter can only do half the work, and the
rest must be handled by software. Redirecting/mirroring from the ingress
of a switchdev port towards a foreign interface is one example of
combined hardware/software data path. The most that the switchdev port
can do is to extract the matching packets from its offloaded data path
and send them to the CPU. From there on, the software filter runs
(a second time, after the first run in hardware) on the packet and
performs the mirred action.

It makes sense for switchdev drivers which allow this kind of "half
offloading" to sense the "skip_sw" flag of the filter/action pair, and
deny attempts from the user to install a filter that does not run in
software, because that simply won't work.

In fact, a mirred action on a switchdev port towards a dummy interface
appears to be a valid way of (selectively) monitoring offloaded traffic
that flows through it. IFF_PROMISC was also discussed years ago, but
(despite initial disagreement) there seems to be consensus that this
flag should not affect the destination taken by packets, but merely
whether or not the NIC discards packets with unknown MAC DA for local
processing.

Only the flower and matchall classifiers are of interest to me for
purely pragmatic reasons: these are offloaded by DSA currently.

[1] https://lore.kernel.org/netdev/20190830092637.7f83d162@ceranb/
[2] https://lore.kernel.org/netdev/20191002233750.13566-1-olteanv@gmail.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: rewrite commit message

 include/net/flow_offload.h | 1 +
 include/net/pkt_cls.h      | 1 +
 net/sched/cls_flower.c     | 1 +
 net/sched/cls_matchall.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 292cd8f4b762..a2f688dd0447 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -692,6 +692,7 @@ struct flow_cls_offload {
 	struct flow_cls_common_offload common;
 	enum flow_cls_command command;
 	bool use_act_stats;
+	bool skip_sw;
 	unsigned long cookie;
 	struct flow_rule *rule;
 	struct flow_stats stats;
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 4880b3a7aced..7b9f41f33c33 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -782,6 +782,7 @@ struct tc_cls_matchall_offload {
 	struct flow_rule *rule;
 	struct flow_stats stats;
 	bool use_act_stats;
+	bool skip_sw;
 	unsigned long cookie;
 };
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e280c27cb9f9..8f7c60805f85 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -480,6 +480,7 @@ static int fl_hw_replace_filter(struct tcf_proto *tp,
 	cls_flower.rule->match.mask = &f->mask->key;
 	cls_flower.rule->match.key = &f->mkey;
 	cls_flower.classid = f->res.classid;
+	cls_flower.skip_sw = skip_sw;
 
 	err = tc_setup_offload_action(&cls_flower.rule->action, &f->exts,
 				      cls_flower.common.extack);
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 9f1e62ca508d..9bd598f8a46c 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -98,6 +98,7 @@ static int mall_replace_hw_filter(struct tcf_proto *tp,
 	tc_cls_common_offload_init(&cls_mall.common, tp, head->flags, extack);
 	cls_mall.command = TC_CLSMATCHALL_REPLACE;
 	cls_mall.cookie = cookie;
+	cls_mall.skip_sw = skip_sw;
 
 	err = tc_setup_offload_action(&cls_mall.rule->action, &head->exts,
 				      cls_mall.common.extack);
-- 
2.43.0


