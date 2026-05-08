Return-Path: <netdev+bounces-285638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJCYKHx2/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:37:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 360874F1F83
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF0CC3020D7E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59CE32AAD6;
	Fri,  8 May 2026 05:36:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9183AD24;
	Fri,  8 May 2026 05:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218613; cv=fail; b=Qr2FW/TbT+HPyrEDB2bsGrsy2hLI+UJPCfVwwT/KkVj9JdYdbU17vlFRczQh3kA7b0KPf1epNhqmNjWRBdAyAKrHCCYs/ojUPUeXEFeGra1ew/2oPhQeK67mfKC8zpFK8/Gw0MTuYyrlFxLcDrICzsGPIXVKmrXOVe685FV1pSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218613; c=relaxed/simple;
	bh=OkODJgt6bDgDHJGu+8LeDabK0toUhhZ3WnSRVP3WDy4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Efsmq5IlYfJvsNZ4W9UPsH3ARA++20RiUi6t19/oKuCgXepu8pu2xN9KcAr/4C96X04xBAK+ggi/gui+Hmem9h3C+4htBRne0W4ZX2SA0BjE14m0xXWBq4FTC1CIBtgOKF6dY92e1aV0jUg5x/Jow4fWkMsz+ksMIJeIfUYXP9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCFb8JpjKfeF+jJnPbTQVEbZtM2k2S2t8on6onn9uwEOGN+AtAvDzohAV36Tr/bF5HsCZbz6M/5uvwoj01Hs19GjF7nUG2fEfMEJXudc/AMbyp/o6noRv7EgvxwYCNAvv+03XSmudaZHiFm8F1vRk6iqQ/HYJR6OILzNP/jkF4ktmdpt4uCWZ2W2TDb2jpSteXghWNkvoO0DITASD9lExPuA2tgkNV4mh3mc9PRhYq+vJzSlCPJqKGG8wFxG5Mf+/eTDdR7wnXZD5/xSLt3P5UxdM2ySXeNxKidVTV5PnVrzngH0MvTOneJtcC7m001ht/OgXu4+giLtQu9sT9svtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r7SzFfloq++PBYg0a7Zvqzny7AO7fXmIqKjVH8uFrI=;
 b=LreCTethyJ2xCG6b/6z0yPDBWTaBScHoqA6JbRqPrRnRnPLDsDnnfe+Ihbc706zgvCUT4JpoFhfwOG//Ga/GWhh84H/2DIug1HilWV8O/Yx0ATO9qHENLjm/wKOe2uXmZAL+G8vIDHwADT4YFlBNn8Wd1CikPvVmZEG7fOaxsc/288WHzcz5zow3H/KO4+kYzpCmMl34MiSB+X3eYxx4ZAr/tbHgzU+8bicIQ2Y3RymunUEr8yhL1uwdFmFTDsXErRb74oFc/4rc/H2NEq8rDAw1zciUg87sT+7SL7JmvZAMekadut22HJSnPM17vOrtF5LRjOKZn1E47qDQHXh85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1236.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 05:36:41 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.20.9891.019; Fri, 8 May 2026 05:36:41 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 00/22] Add basic clocks and resets for JHB100 SoC
Date: Thu,  7 May 2026 22:36:10 -0700
Message-Id: <20260508053632.818548-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1236:EE_
X-MS-Office365-Filtering-Correlation-Id: 6844b117-e795-4755-1b54-08deacc3c7fa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nG7lBc89QOPOZXbzz5tfEyHKsAuUmqxcGvpWOd5qaSkrncKnDn6x+MkEbczlnBe0nZ70C1ar52D8JF5Z1UdTPNKj1ZZWOKR15SlVtM9AxlZ8qybVhEA+bnoGMpbGi7SpRw6t2errPTTnVx+YTCBcIo3W9cQnmQ02kYxoTalX5tVJmKXnyt0+OsX1R7O8AoBem54t8VKHNNLJZQFVqi5ZjDj9mVVqHpmZOWC13vQYZ8NN/KOQIzfg8Jo+b9o99aaE8rFU0SWb+8akT9qc4wt0iMS0/ZTiHwXZA1LTypeOdeBzqJr8c8DzVsjz6GvGF8YTja2iZIj1XYNND2YpN2ol4eWXkCxb6UX3gsjsF3/fhkOHMgV+5G/TQEfmHyGeh5ekhJunYyJ1AJ2rdRY/axl5ogP4kjiI+U/U2YpuRNjf/7OVOQwOkWiIqmoUkuNqnGOi4ozOGev9ZhjMYq69K3K7OIx3xSyk+/rdI6XbIFMnvf0qSpdjyrEi9lp+bZo21xRyliHYq/kZ4/jQigPqK8d+ivSFyFVck+ozMB2exJ9CjLmgy3RaWsAIQVV1P3HmMD0lTHw+eWo7uDqe1xofgsEHKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WI/Vzq3Q8nwsbHuXE0YrW2Xo79OhBO7hJKTYMpfOWQi5QlNiGV6CEUFLCxCd?=
 =?us-ascii?Q?NSKXB1ckZTxND6hnxOWSzjk3GTlkFo75v97nPEe0CCnjSf7KfY8srriGr3gH?=
 =?us-ascii?Q?eAp7mQolZw3A6JHAp66vWwKeT2kfuzFpcsVDDQ8LOpCuHxhVLkttACHZBN7e?=
 =?us-ascii?Q?GrWKnuymMMFD1WyIlsLQhC+8XIoji8/ynu4mDCr3DJH9P9jd/4fmUbj/lAkj?=
 =?us-ascii?Q?IO/QIy5To4/XtHEzpxslan1/w3CZQ/JfzPUEjhHxURZ/OnBQYCaRAQTyifEH?=
 =?us-ascii?Q?hhSpV+GokflPb2LfkCw5ms18qIijlRBnh7eY15BRQTyl+BUPme81r48qKT+1?=
 =?us-ascii?Q?liR82UDEomBkWfylnm/Fx0u5ZJv7nAt+z083IEm44LboVMgjfnXCeKPjr2RP?=
 =?us-ascii?Q?GuDddYFP2uVuCH0cW6uzVokdtKYEsTMa2xZ0X8ArCqTvOGz5X5Qt/P+AxuZ5?=
 =?us-ascii?Q?dqNBU9EGucpUIMpaLpfcvvSGFGsreHcJWysoNiZ86dOUAqHeDVznLYWdib3h?=
 =?us-ascii?Q?y8bAYIE+seWGySXL8yXOvfHQ3RYboh8pdjm6576qhK7vAuEO4O1nAjyUS6P7?=
 =?us-ascii?Q?TUW72Qin2CiwB7+Qapt6QubVu7CXsN2dDrA5Cib84WZtqZBvw1SwQRzrBlv6?=
 =?us-ascii?Q?GnjPw8L8QIdt0Bhr7zFOSiMqDXiJi4efObBTP2//iPhO2isMb/QDEZ9Ct+8/?=
 =?us-ascii?Q?kZoWVz3Itx+2tobzKUuYQk9+krlAHNJEuBaKJTKhpU+vuT1Lpxjt5kb9LHvR?=
 =?us-ascii?Q?D27lNGaZ9bOCKYeex6J4hd9oU6Mx2WLCxsJ0OfE5WrTbC8cvg2sJ7Pwee3bh?=
 =?us-ascii?Q?Jws10MuzJDYX8uuB+Cyn3czrKgh0hJdvWZHVGvoMPC6W+Vd45Kw80+D9/lov?=
 =?us-ascii?Q?bM63WGOC9c+zZLAMPr9sdRFNAw9WnEg2Jn1uc6qf4Tk6nJvZ6vv9+MFPGPFD?=
 =?us-ascii?Q?Aq90+FHKlD/SJzq0wRdvG0yAJceI2G2BLsAH41S3wl/rHD8m1d2XvL/VnlM/?=
 =?us-ascii?Q?ymXO/buNshijZU+a4S1gGwRSmjen046uQjYJD76WFXLhG7UPXLJiqsWfrg2s?=
 =?us-ascii?Q?7AU5ANU3FpRzh0384vGJtrKyCZMnNTjmo5KZoSHGD5rLj/0oQE10owwUAgJG?=
 =?us-ascii?Q?pPZAvOOZobfStTD+KsXOOJ0tFF298MZk6opr+S0fZ3fTApMsp7w77Z2zYuPv?=
 =?us-ascii?Q?rdK/5C1OB2qOa9dBbGjjLafFS4ndk0msgebpGCLGRbEiC2NptqwjC5xBjxGp?=
 =?us-ascii?Q?vDUGi6ztIecSl0kjMG2cF1rV/Lx/6YL3fnBMIIvLehfZBnpyJdxAKQyGv9OF?=
 =?us-ascii?Q?lBMbGc4W8aVRhNhQ2CrFGS0H4bQg8IykmVkVlqZs6HSs2xxGn6H+T8y5mbFU?=
 =?us-ascii?Q?r/GtgvTMYjDGpSJ5BeJ72tpwkCWM1be/RmSUZxpXSH0oHVQji2omKzqH0Cjk?=
 =?us-ascii?Q?Nn5WcO8EQYMxcTCDto1c/UACIFYWCtXkK8rVPcss73Lo02HO8FuK83ppqnAB?=
 =?us-ascii?Q?kVYC73rD15V+JKiwWaiFSEmgeGNmMmU6dwGuxSu4ar+ydjHSvbT2Y6A5CCrt?=
 =?us-ascii?Q?pVBg3FwxcqJnvG+6jmriBsyt75swlkNysCuwM7VgwAgZ4aSk3BPlWHTXKCU9?=
 =?us-ascii?Q?KO7Z9r2D6KsRTw3dWytaIfGVssa6rtjNVNW17dC0/hq5zvUbLASyuGxZsnaG?=
 =?us-ascii?Q?x0vIeeuhmx0fGTxcTLup7mEwKsxdbZuAoR9+xDbav7kaqBdGuR2UnIIKFxWb?=
 =?us-ascii?Q?0YL3AM4IAIFd7wl6BF89FhSxRWspKB69LnjVFW1DQDnZoDbaRZci?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6844b117-e795-4755-1b54-08deacc3c7fa
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:36:40.8467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQDSXZrUhrvfuzNxNtHMEfA+Gp3GQJLCxN8ckKYMkXeAFxBd9mNKPgW7PGVNdlXEJeQjgQVZmTn4z978VbMPye6+O0HcMnTWNYVcK/pldw0qN7pQ//1adLmis9TNW++7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1236
X-Rspamd-Queue-Id: 360874F1F83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285638-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.447];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The JHB100 SoC includes CRG (Clock and Reset Generator) for multiple
subsystems:

The JHB100 SoC is divided into multiple subsystems, and basically
each subsystem includes a CRG(Clock and Reset Generator):
 - sys0crg/sys1crg/sys2crg/
 - per0crg/per1crg/per2crg/per3crg/
 - voutcrg
 - vcecrg
 - gpu0crg/gpu1crg
 - cpucrg
 - usbcrg
 - host0crg/host1crg
 - pcierpcrg
 - husb0crg/husb1crg
 - husbcmncrg
 - husbd0crg/husbd1crg
 - npucrg

In the current series, we will only add the following CRG:
 - sys0crg/sys1crg/sys2crg/
 - per0crg/per1crg/per2crg/per3crg/

The remaining CRG will be implemented in future series.

This series depends on the series:
https://lore.kernel.org/all/20260506085937.754808-1-changhuang.liang@starfivetech.com/
and it has been tested on the StarFive JHB100 EVB-1.

changes since v1:

PATCH 5/7/9/11/13/15/17/19:
- Create contiguous reset binding IDs.
- Make the naming of some clocks more meaningful.

PATCH 6:
- Add a common helper function starfive_crg_probe().

PATCH 6/8/10/12/14/16/18/20:
- Use starfive_crg_probe() to register the CRG.

patch 21:
- Add reset_starfive_register_with_info() to support both
  contiguous and discontiguous reset IDs hardware designs.
- Create a mapping table for discontiguous reset hardware
  IDs.
- Make RESET_STARFIVE_JHB100 under COMPILE_TEST.

patch 22:
- Fix the fixed-clock node names.

Changhuang Liang (18):
  dt-bindings: clock: Add StarFive JHB100 System-0 clock and reset
    generator
  clk: starfive: Add JHB100 System-0 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 System-1 clock and reset
    generator
  clk: starfive: Add JHB100 System-1 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 System-2 clock and reset
    generator
  clk: starfive: Add JHB100 System-2 clock generator driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-0 clock and reset
    generator
  clk: starfive: Introduce inverter and divider
  clk: starfive: Expand the storage of clock parent index
  clk: starfive: Add StarFive JHB100 Peripheral-0 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-1 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-1 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-2 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-2 clock driver
  dt-bindings: clock: Add StarFive JHB100 Peripheral-3 clock and reset
    generator
  clk: starfive: Add StarFive JHB100 Peripheral-3 clock driver
  reset: starfive: Add StarFive JHB100 reset driver
  riscv: dts: starfive: jhb100: Add clocks and resets nodes

Sia Jee Heng (4):
  reset: starfive: Rename file name "jh71x0" to "common"
  reset: starfive: Convert the word "jh71x0" to "starfive"
  clk: starfive: Rename file name "jh71x0" to "common"
  clk: starfive: Convert the word "jh71x0" to "starfive"

 .../clock/starfive,jhb100-per0crg.yaml        |  70 ++
 .../clock/starfive,jhb100-per1crg.yaml        |  70 ++
 .../clock/starfive,jhb100-per2crg.yaml        |  76 +++
 .../clock/starfive,jhb100-per3crg.yaml        |  76 +++
 .../clock/starfive,jhb100-sys0crg.yaml        |  63 ++
 .../clock/starfive,jhb100-sys1crg.yaml        |  71 +++
 .../clock/starfive,jhb100-sys2crg.yaml        |  64 ++
 MAINTAINERS                                   |  13 +
 arch/riscv/boot/dts/starfive/jhb100.dtsi      | 198 +++++-
 drivers/clk/starfive/Kconfig                  |  67 +-
 drivers/clk/starfive/Makefile                 |  10 +-
 drivers/clk/starfive/clk-starfive-common.c    | 476 ++++++++++++++
 drivers/clk/starfive/clk-starfive-common.h    | 146 +++++
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 127 ++--
 drivers/clk/starfive/clk-starfive-jh7100.c    | 503 +++++++--------
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  62 +-
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  72 +--
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  94 +--
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 525 +++++++--------
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  74 +--
 drivers/clk/starfive/clk-starfive-jh7110.h    |   4 +-
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 339 ----------
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 127 ----
 .../clk/starfive/clk-starfive-jhb100-per0.c   | 603 ++++++++++++++++++
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 153 +++++
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 178 ++++++
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 136 ++++
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 149 +++++
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 105 +++
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 128 ++++
 drivers/reset/starfive/Kconfig                |  15 +-
 drivers/reset/starfive/Makefile               |   3 +-
 .../reset/starfive/reset-starfive-common.c    | 205 ++++++
 .../reset/starfive/reset-starfive-common.h    |  33 +
 .../reset/starfive/reset-starfive-jh7100.c    |   4 +-
 .../reset/starfive/reset-starfive-jh7110.c    |   8 +-
 .../reset/starfive/reset-starfive-jh71x0.c    | 134 ----
 .../reset/starfive/reset-starfive-jh71x0.h    |  14 -
 .../reset/starfive/reset-starfive-jhb100.c    | 300 +++++++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 542 ++++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 186 ++++++
 ...rfive-jh71x0.h => reset-starfive-common.h} |  10 +-
 42 files changed, 4871 insertions(+), 1362 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per2crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-per3crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys0crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys1crg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jhb100-sys2crg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-common.c
 create mode 100644 drivers/clk/starfive/clk-starfive-common.h
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per1.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per2.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-per3.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys0.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys1.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100-sys2.c
 create mode 100644 drivers/reset/starfive/reset-starfive-common.c
 create mode 100644 drivers/reset/starfive/reset-starfive-common.h
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h
 rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (50%)

--
2.25.1

