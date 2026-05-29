Return-Path: <netdev+bounces-293006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAbmIY42GWrzswgAu9opvQ
	(envelope-from <netdev+bounces-293006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:47:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063375FE1E8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33F03016270
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CE13A987B;
	Fri, 29 May 2026 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LQGfoe+F"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6039EF35;
	Fri, 29 May 2026 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037224; cv=fail; b=O2+INBLtaPpyQxh8pKkyXsplgEBGO3wmFqtGxDPI/a2P4KOqtUvcSmsTzFaIUDTTW2QXzbFumAMvbsERvH0IvqDdSILG7JQuY2XMi1IMq8IwVqbf5fHZdOez8KX6RLQYnjfGEG4SfyeDR+qNn7ank9KqerAPhP7dc1Gr2V87Ptk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037224; c=relaxed/simple;
	bh=FdhK1xmxaQwfA/LUFIv9O41OlF7qce6W3BunkfCzGFk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jn3+vogRuXgCyfVBhJFQpUSvorVsLyKTSfMAObFZn1UidwzUG4efHyVqOe9xRVOtc/+RmhAwP0cD9M09NFdMSOJWKVXj1AignfTvJqAGOQPgZzJdkUVJcKBJdw7dtuXpth8XxnyTAgnn+zjZUP5ZEg0yoVAT6ljNGr1Ub7hag00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LQGfoe+F; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueM2Vl6rjt1YixRLl9sAtCbJOKQ8ZMqyQb7kCAYlxHVr/1Z1/mfv4Cz5k3l80zE2ZxxgAPzAeq0qg5xCLVaNCkh+u8tXvYLSwpe8iJYtMme0WVMaLlYjTOHkeEKqksfHXvmSqegBX0sxcHRgOAoVmHX6+gufbqhWe5UJ2w9X5eh6kyNu/ijx6wjkDkXl9jry9UhQQVpXeSQSisXXywNLcW66uWqvep0K6nJMG8RSnAaTNTEL94FY2Mw3uVi1znM8UjZtW+2LW5POTBMfyyrpdcPppwyFUyAnDL0GY5SvYP/gG1FYOtAjpDygde5+sHirBmwb6Vr8ziwdj1MK9XmlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uIOdmH2gf4n0/FdjEI3JVnme1HnFWdBnkUzUk34F7o=;
 b=T4CW5kiURcurrOn8d9TJqc/CjyC0K3zaHSpaES2S4GvNmfMGFVkDQDJD2/uRL6GudZ3tAQGMHDT4RYJKgXH7na2YO2sTf2FmH2B4ANGv2W4wmWtdKBqqKnje9nfxUgePTWBiXGCU10FxHXdCPK8eJjj5MFgW6VJZ9vpzg4ux1fhCThva2pfVeTWpTyLxJrCEFHPpDArtftIHzc9DnnrpjZRAufkd2l9dnZRTLL80VPtGgIoevlSmS61Xl64fAppsEaD4VMxKilqwExJ0ZcOGRqphWDADTv6G/vp2RaWcYzunu9s5pzCYbZrkbH7yn/Ae8aPd/seUk0PMvFGO784EOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uIOdmH2gf4n0/FdjEI3JVnme1HnFWdBnkUzUk34F7o=;
 b=LQGfoe+Fjhg53Z0QWYoI+hx9/MbmFruj9EEONSoLZmasUPcjI8k5cLmll7Bd1buWGzfxsT3iLswoLRnYMrYT0sUEVEt4EwZWMOTQDe1lENLS8jzSVhqzKUS+E4D9+U2/+BEYAm9PDCETXSmCcc7d9JExmTwVhICrDpCGgWsELxM1h/8CXEr749NzdZvjms/cQFnhQmp7iftnZdhe78I7YNSP3t2kTuXpKpJU7YKDFAgh/Y9zPqOdE9n+ggE0lmCg8EgUI9KPFLbcI+FOQ5BEiOyIvQ1tv+xSnd2e6RQobha7JJZZj8ccTvB2Qsf5d3UeB1UVv8CFhOytIjIzLbWE5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB8200.namprd03.prod.outlook.com (2603:10b6:8:293::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:47:01 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:47:01 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: stmmac: Improve Tx timer arm logic further
Date: Thu, 28 May 2026 23:46:59 -0700
Message-ID: <20260529064659.32287-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DS0PR03MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: ab49e06a-a7fc-40e5-ba3d-08debd4e1626
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9v+2rYosFelVEvr8xa3umopqLUeXAuNwefYGcS9Goxdl2cHpk52DRqcosbKbgzFvfs0qDO8KVISg1GaN7g2PNuG/ku5RLzP/1bZ31+AeEEydB1oPbRiRus7TjjxNisBpLvtn7yL/ab7+BIsXP6omE9Jk5DFZFKCHWIdW569nE211nXbbVLsiAlqQdO0aCSTHadA/uPii06+agLyvFDU2ezPNr0p/V9FvWSf/AcT9u9GyPjQKfNN0xtmzFdTL/sm7qbeEx4+uY7lXlWXaFtQbwYsOuJZu6+wMdvmxbTFeAqPsh1bfb2MOmihQfE1tPCVEHb8B1Pr78LyaFfG3tfKXKPK8vgKzic/tUvY5wYRMz3oswte1XKf+gVJiYcXcQKV/9fWPaDYqkkdUwJEkVqSRxbw0emoVi89SD17v+25gEZtTKukTL9tXz4KmAYfr8BIT1mk3EorSGq2PaZG15y/q+fBbu6DRSeDG7BW6ZwfR9F7RnqxntPMYU9TpC7HS9tlNmxt2bISOEPbDI7BOebJqwLszYrhQRwzxeKfLz4Soo1JZuRskMQyeBySjVdUGX63r/K8UkopetzfofO1aQBUHewXf8gNXun1j8UGXY6BqVhZULSYohD40qO5pjrBgmxswceHF1KA6Tc+LZs+QYjt3AjKDMYP1AhgRkZVnhbajV/ZeGHFuUzCJMIx6mSwl2MOr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a0n/XF5LAIhxdTRiuaBSwBJanXkmnmRxg/iHl5H/0Po/4+RIISatR2+EcUrS?=
 =?us-ascii?Q?TSB1g+0FOqIpQkLmPYGRLSmBeCpiQdI97blDzQXDTnMufig7c8WQ37R3EAmM?=
 =?us-ascii?Q?XCcUtMGPxBn+6KwbEmIjd6SY2AIZkrj+DBqgQSCqaF1FmDtje3baEVg0B8/m?=
 =?us-ascii?Q?fIo+95t0WvHv086Al5P2s3vv7CXX9lny/ZuTJD7EyVSjnEI71futxh0o+jLr?=
 =?us-ascii?Q?lvA84eZZIW0vqAaphuOcOSoeAkKZFEuS2lbYo8hMoEjTI65NRO3f4/hYVgDh?=
 =?us-ascii?Q?QndG3A93Bk37GOSQg4IDL5+7+JrK2upeyZyNS3sdQ83Ul4HnM6OPnDZ/JWzV?=
 =?us-ascii?Q?cR5RiRLgRArs5VRLvg9YEufZa64ISmoe9tayo+8bfQ/YxrjVaUr6RvTPykxj?=
 =?us-ascii?Q?AKClYUy4Wn7nVDQnUJ0udiMI0F8TwW9xfULwNqBHVEe+vxi8GsuA+rYlMVLX?=
 =?us-ascii?Q?4OqBeoLvntkgS8wjO23XZKTx9IYumCyeW9n/unMzTWlDS+T/6dzj7PD0rFp2?=
 =?us-ascii?Q?+PogxGs/7Ohj++zji7V7VVmmCYsznHq2c0StxtwC+j4/vi63DsL9bAALVg8T?=
 =?us-ascii?Q?NeHLPVMJo8B7wk8LK3PC7CdrTdDgcQX+4cyl4+27Da4kaP0WF7Lhwxsif4MT?=
 =?us-ascii?Q?C6P9FviyRvi5YMN/khzLskwNzyEyNxLrjFJVMyzZMFGyU9i3E2g5YWkkg5Ia?=
 =?us-ascii?Q?16jo9vw1it9rRzM9a4kcio8nn4H0nDBO6ABwRxS4aup5GVJ1iVphThAc3tyO?=
 =?us-ascii?Q?GUUMzLfw3ojmUHV1NVKB4C6leXBiHg1sKxh3itvjisLVko3ctbkCuYOUn1Bn?=
 =?us-ascii?Q?gBZ9PDkBR1C7fE5d03jhvXT+n2LWckflwO9nKdpe6T6gjqIvqSWbPVeAKmol?=
 =?us-ascii?Q?IkTjIogXFYE/V5DZC7mGFcYR8D/+lrcEANljlAI7iFZ/VseVIlDvoARfukFa?=
 =?us-ascii?Q?XNpgoIycRi3JRO8dOC2buNAKSWyArhD/ZsVvqTwkKatQeE8YgAmDfGxy98BM?=
 =?us-ascii?Q?S3DLAE/lvBZFkAUwzbMefVtzmhY+nvl9c71RgKhZRj+wIqZcXPcY6cmZHVTX?=
 =?us-ascii?Q?RoLf9h/Hg9+QuzCcnZMZTWZ/+gU/R7NRXJI3bAZqp6ur/ub+hLvVG3Tr7bqn?=
 =?us-ascii?Q?HwcQb6zTQ+930Pm+hqxq4RpA5Wa9W3QyxX+5PhEo4I+z2O1jJzwV/B/vsfuW?=
 =?us-ascii?Q?hX1FLuu9KkAu2dWO1lPZf7aF31wVknd9owAMJr/ldNrIwd9HAHmNH61K+eSP?=
 =?us-ascii?Q?/edzNCf6aV08ODEWfcRlhDBXLj04dLj2VjKgfVJHo2P60c+oFLCRfww3hm4J?=
 =?us-ascii?Q?wfVXhB5CLEuEZg5gRuIN6jXFsMWALY/vB71ikd1jMBaIoDs+eNNrPTSJ0HOj?=
 =?us-ascii?Q?f9Sk3jXahpq/ujMXzFdoSZ1KgSbuOgqMcRvZ6zfghKE2ZQmNo13dT95MM024?=
 =?us-ascii?Q?Zsbiw+6Vuaql3O8G9kd690RI2lujNgZHJDC1hSaWDPN5RCD7HWo8Ub9TJA2b?=
 =?us-ascii?Q?xlRLKkhYXi06N00+7he8FA4YvNWhLUMB2+Sw8Y2PvppJ4m5VCAYHAYE/25mi?=
 =?us-ascii?Q?NPVQRYtObCkPCUtkhB+69Znj9e2zwI9H6SJA2NmTiowtGTmuWnUjST9xnJIm?=
 =?us-ascii?Q?ptwosCChJX3PGR6h2MHqzU2scaijYtrKwYH+1PQ4xs/8zWu+Vh7ZNnAa6u92?=
 =?us-ascii?Q?VagfJW3eaTpqTpvKZfD+O1AW3/d0XEWvJpMW2AWfQHLHkiMVhyXrNibgtS7f?=
 =?us-ascii?Q?fAjzXfSAspVOjnWhZo/fg0bLBKNTpoVr0xVSAU3MZln3D9qHiOM2pKj0BbQ2?=
X-MS-Exchange-AntiSpam-MessageData-1: 9RvWgty58n5psw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab49e06a-a7fc-40e5-ba3d-08debd4e1626
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:47:01.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdDJ/d8CS2zvjZWhKuLdWhwvaO/4KLFEl4o1a7uIg0QrEfMMGMXf71naMzzB13tPAd3gKtoufcaxOThB36M1QomGo384shrrKJSevMipEheh98FHaG9qNLb87Z8bTSJBHqMn5zlfe3zHHjB321RkXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8200
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,altera.com:email,altera.com:mid,altera.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 063375FE1E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Calling hrtimer_start() on an already-active txtimer is unnecessary
and expensive. Skip the restart if the timer is already active by
adding an hrtimer_active() check before hrtimer_start().

Previously, each packet reset the timer to tx_coal_timer in the future,
acting as a sliding window that delayed NAPI under burst traffic. With
this change, an already-active timer is left to fire sooner, scheduling
NAPI within tx_coal_timer of the first packet and freeing TX descriptors
earlier.

There is no race concern: hrtimer_start() is internally serialized and
safe to call on an active timer. In the event of a race between
hrtimer_active() and hrtimer_start(), the worst case is calling
hrtimer_start() on an already-active timer, which is identical to the
pre-patch behaviour.

Performance on Cyclone V with dwmac-socfpga (iperf3 -u -b 0 -l 64):
  Before: ~45200 pps
  After:  ~52300 pps (~15% improvement)

Additionally, ~10% improvement in UDP throughput observed on Agilex5,
with hrtimer CPU usage reduced from ~8% to ~0.6%.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
Changes in v3:
 - Corrected commit message to accurately describe timer behaviour change:
   timer now fires sooner under burst traffic, not "unchanged" (Andrew Lunn)
 - Added Reviewed-by from Jacob Keller

Changes in v2:
 - Expanded commit message to address race condition concern and clarify
   tx_coal_timer semantics (Andrew Lunn)
 - Added performance numbers to commit message (Andrew Lunn)
 - Added Agilex5 performance data with hrtimer CPU usage improvement
 - Added Tested-by and Reviewed-by from Maxime Chevallier
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions()

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..35da51c26248 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3341,12 +3341,14 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 	 * Try to cancel any timer if napi is scheduled, timer will be armed
 	 * again in the next scheduled napi.
 	 */
-	if (unlikely(!napi_is_scheduled(napi)))
-		hrtimer_start(&tx_q->txtimer,
-			      STMMAC_COAL_TIMER(tx_coal_timer),
-			      HRTIMER_MODE_REL);
-	else
+	if (unlikely(!napi_is_scheduled(napi))) {
+		if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
+			hrtimer_start(&tx_q->txtimer,
+				      STMMAC_COAL_TIMER(tx_coal_timer),
+				      HRTIMER_MODE_REL);
+	} else {
 		hrtimer_try_to_cancel(&tx_q->txtimer);
+	}
 }
 
 /**
-- 
2.43.7


