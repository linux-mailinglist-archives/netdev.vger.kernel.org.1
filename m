Return-Path: <netdev+bounces-274491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 13RONXpZzml2nAYAu9opvQ
	(envelope-from <netdev+bounces-274491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E3388A84
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B788130B97F6
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3723CF677;
	Thu,  2 Apr 2026 11:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FA3644BE;
	Thu,  2 Apr 2026 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129352; cv=fail; b=bKcs2xYihfu58MPNCXxnfgZGdHofGBcyDqDn6cCGhdeRy+6LPB91IeJr0tfOqvDbVc4/ADQkbCo6Z/SK9hOTmCXj34uc7E56rWxaXXIwaZLW6mCCd8KBTKBdYFkKDa7IhElXXkcrZmdlExZdC9CL38Rdv3CIjcAulIHUjP2XiLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129352; c=relaxed/simple;
	bh=F2w6AaEeDfM5qrGmBHrZMXm6E2vLlO5hX8jfna+hzyg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OaH85KpM6k+Yu6QbDqaveQJsVjTfmd6RhvAybUKjMYaP0RWOy4NP7/RexfsvYyV/TLz4Bg+MZkQyO39wTRnrtOEXn14Ai95ddjBHqDr2XUsqrttzjEU9Xz6oJk/iv372t12U9DbtJxCv7i0+sUrFMRqM3DT+jns9z0+oHRCb6+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoComGZrNUn3zGAFrPzJVZp9V3/p+1XLq3O0tXq2wCiXvUXziY4Q7O2vVES/bEkvQ7EYSAOWf5ivybml8hra58N6a2n0ywpTbhhMDsvIn2SCDeFnM0AQHvZ7+t5Cqa9Wcr2ueDS+KedG+zwkeUZf8iC7Dffvgz4vkxJjqoSPNlY8PVSopEuw8BpZpygwAFZzOlc8oTYXqjVJnO2YA2csOSH8kzzGxiWrtDfh/xcI4TRECT+N3uoq9OcG32mO1jKxassLq4juwEi/aYvuw+dBIllrxs5SzDgrqOeCdGJlVJdPUe87gj0N40HS0p0ITsJzBWYkS72KpPYu4EYhDQ6RYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJE1ABfb5cyrtTvicjaSy3p5OpjlzEMQsa6LXqul4q0=;
 b=n46TaQaXJDYxXRww3nTwai8Q3y99bWlQkciL1lJwRId5CKvE74tYtRbZZ/OURUr5nZdVLAQMkajX1KCMgACaj8hoWBVY7vKeTATKz7xA+EpG3vAt5/esHhqjkuuaqluf9TjKEVClAdOI9hQBGs+CK9yCiK/IZodWe3DuaD+PmBp+lOnusv7ReZyEYQLjuLgfXPJ2DhIETCqccw6uaLzH59xI0WrKPUk9Mh3bRLNUFZMRah6apz91e7aEKhKuokJb8TfkvBrpVG5whLE7nbaq90UBMBhFyYuAO956TuO7apqh5Gu6tjWCTTBNmvR+mIOTfG1rOBpcVBNfolrrVclIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::5) by ZQ0PR01MB0951.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 10:55:36 +0000
Received: from ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
 ([fe80::63d1:b688:cab7:50cb]) by
 ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn ([fe80::63d1:b688:cab7:50cb%7])
 with mapi id 15.20.9769.017; Thu, 2 Apr 2026 10:55:36 +0000
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
Subject: [PATCH v1 00/22] Add basic clocks and resets for JHB100 SoC
Date: Thu,  2 Apr 2026 03:55:01 -0700
Message-Id: <20260402105523.447523-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn (10.2.0.210)
 To ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn (10.2.3.165)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1208:EE_|ZQ0PR01MB0951:EE_
X-MS-Office365-Filtering-Correlation-Id: 506c8915-e4da-4a1d-20cc-08de90a65d5d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DQ6bZF2zXaYsEAGOU00bSw/N1EJtwuMdWoYmspFDc88X0MoiptUgHYc4smGnXzVz8uKafsiswHSjbfiECJbH4A+nLIqTEMERRb+wKOvEn/6Yo0yZqZPiIG0BWnMjNI7u8eGq45THTTz/dQRgSMtY9JCC+wJXu3mfuPzi2FUCyTRKSZ4Ta9z7LNDFR7JgCOO+urJO3eQnQJWEfyc1WIaxEdQFqrRe/fB1aDpALrrG0GAs2DTSRzFx6vkvfAwYtRGQSfokIJ9bdT6cQVhehEX2PFfK89NDZ1IMLoMjVXY2KcQL7r9DSXiIqhwjK89M0JGbboDlg9ekyAa/PULqsKzaS4hzyLyLAYf0A26VGf+FAacUb+YKNgKDqQwxN0zrvPcykn58wq86Q4JGvnrk8N6Qf4rMZeWHgPUhLPMQI4p78UnLL+W6uetj/OJ/8efggpKRkr4mV44ywwhEdCWCtHMVbViuvDCpaU4BjGo2hu2OHBPcIHEuJ0gMCb5aT7nDRIPSqJHUxe8sjRDl9FBp0SQvbiqGmqRddZ6rrYhv725bbFoGatKdfQ1Zscpgqan9dlkXMujsyhQ35jdufyeUxMEVFABvYDZ+kfVLntI+fB2NSck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ToFs8walwRCwV+ZhQQqt7fwBr6tVa/Zoyddyy92SW2FDNwRDFkwWDOGOWFk3?=
 =?us-ascii?Q?QRC2c3tZ6dzgmHGdvM6A+hCk7dpjOyO0EKzNuX6wfzxtycdRzKpGQIcxV9Rd?=
 =?us-ascii?Q?ebVe0WXJ90uoSv7oCjAABLTb5BG3ciGQ3dxJgbgWsEaKbX9YiBXOo1onhCZS?=
 =?us-ascii?Q?7zAVA27UzqFdj/VvAaW0y/07m+2P6XSjgzchaDCbb+3ucph06PlPIgOGR6pV?=
 =?us-ascii?Q?M1aklSnSTlF8NomNjsZ6IRlw2cWXqak09F2MxV5k29HMsgcorYdwpB4C4AMQ?=
 =?us-ascii?Q?DcE/uj9+v1/xOBcqe9TrJBZZSjbub318xdWcfDHwy2IbULsAZQYFMnjX3cmM?=
 =?us-ascii?Q?+3+At3LKhgj9xfKZhiZIeFhM9Q+lMGwa+3wBChbztNaWiOBtQYrbI9i5vUVL?=
 =?us-ascii?Q?WN4/7pSWg87ueXhTWP/iF0Foc0u9AUZU1zQogyCSAr9nKMxviKvMH2PXgRgH?=
 =?us-ascii?Q?rT6sWADNBt+wV0scd4upWRvdnrwp97vbgIp1T8ZKL/hvv9lqz4jsaU9w/VBO?=
 =?us-ascii?Q?k9EQP4nZcZM1Zand2LtZ63nv7H3WW0RxuWDlLgC+cm0JwPNslIY5YDwXJ8K+?=
 =?us-ascii?Q?pIp4OvDWpCoEaxucKh+PJH1UjXFDX27iihO/lOHOFCad9XQdWboHSpsidtgz?=
 =?us-ascii?Q?dZW/NuoKiu0edaJzj0kikljRZQ73izowNyQbpNPgk30J/9yoER1FwdWzIRJs?=
 =?us-ascii?Q?hRrz2baxjymqkX5ECCGEsBxxjyoMyJl5O6kyc1NVGVRm92XL3y4Wk/cyPDJO?=
 =?us-ascii?Q?4tN1bMV5nzLihR8zgDJ87t5q9um1r0HFrJ7XSfufmyTBgSGkzN8dPqD2Ap3x?=
 =?us-ascii?Q?qd2BlEX1rLSmH4RVHx3/p2Ep7ZHAC6XER7/D17qooZZ/qzkXCgKQ1VgjlRaX?=
 =?us-ascii?Q?OJQQXxpiNV2Jar2n1XES+KAgq9qXyuSKB7rBrwsTwZCjdDdoqRlRpXGltl8a?=
 =?us-ascii?Q?KEyW2TUoUtuOP3yS3vrtlcgJDMCGl10X21dwjZymq35Cq+LK4XJoXLASvQPR?=
 =?us-ascii?Q?rYHEozaFqpjvmR6mqSO2iam9Lw8u57Yx2JYommvp13RdtQ7kOwcfVF+QPQiN?=
 =?us-ascii?Q?10dhxsESSu5WiIDNBYWl0eqYLCfKdsvcN1xfqMcwDVU1cQFhJckNIQTsQIwA?=
 =?us-ascii?Q?BXLWvLFUIyYNNF3Pbxvldqh3gQQctuLZ6kmdbpu2Z9hOKbEDqLGXa2kwmDZD?=
 =?us-ascii?Q?yeTR4/4H8dkWHdUJP1J+VbIonynPVw3djximk5IUxwm9C/m/xFDCDMqe6yh5?=
 =?us-ascii?Q?i8fEMdrni6RqNcfMRimKefOv7CnhGizXdq7bVPMTk3eLmlSpE4S9DzFnk+RC?=
 =?us-ascii?Q?hwoMwr3aBsB9YjijfvADR4zq1zdTuN6BSwsEh/gzqDAZEEBFLD1xwlIa/dEG?=
 =?us-ascii?Q?4fFYW/cBpnjsDMPiWkJk7FCAj4lsF0EPXcASUD+vEfSdAUJYrI/XISg8GmZO?=
 =?us-ascii?Q?GaTmh/t7DYk+p0iKUSeW6/yJabToexVfmnpJBC/fXIbVxC2PjIh5ORqcgnq3?=
 =?us-ascii?Q?IAanMiwsBZZBIPm1UKWdV4fA/tkboVN08t+ngrOuWWmdSaccAbgwh2ojzM8s?=
 =?us-ascii?Q?nCEL0YPWUeU/dstiEyX1VEBBYnzh+jr6S9pFnMrAKmFfpFYnECASooonoOjv?=
 =?us-ascii?Q?npj+RmLq3JBnRJRlqRPBIuqQgiLcqsBtpJgey4U44bpN4j8qYwdBJdNX8rM6?=
 =?us-ascii?Q?AG2WFujDBMbPQnnq18tcAlt9OxkLNNVtxnbssC6g6xJNfSeNVhHA+hwg24kZ?=
 =?us-ascii?Q?Jg+NlaqpxYumIdwv1VCn1y+p73ZGmuiANqXxaV9RxzOecDPIc4rt?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506c8915-e4da-4a1d-20cc-08de90a65d5d
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1208.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:55:36.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBop3ISQ1pwy/ijTuc7ScRyAXuo0yeUJnBWjujd0Z3bWkj5afBolsSAq+ZKV3Sy8a7Urt9rOFDWtXx6hlIgpJFzIsTJMyldliUxaERbTAlzXljV4X5U+CXLy7ie8i8ao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0951
X-Spamd-Result: default: False [5.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-274491-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,pengutronix.de,esmil.dk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.061];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[changhuang.liang@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F7E3388A84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
https://lore.kernel.org/all/20260402084019.440708-1-changhuang.liang@starfivetech.com/
and it has been tested on the StarFive JHB100 EVB-1.

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
 .../clock/starfive,jhb100-per2crg.yaml        |  79 +++
 .../clock/starfive,jhb100-per3crg.yaml        |  78 +++
 .../clock/starfive,jhb100-sys0crg.yaml        |  63 ++
 .../clock/starfive,jhb100-sys1crg.yaml        |  71 ++
 .../clock/starfive,jhb100-sys2crg.yaml        |  64 ++
 MAINTAINERS                                   |  13 +
 arch/riscv/boot/dts/starfive/jhb100.dtsi      | 198 +++++-
 drivers/clk/starfive/Kconfig                  |  67 +-
 drivers/clk/starfive/Makefile                 |  10 +-
 drivers/clk/starfive/clk-starfive-common.c    | 351 ++++++++++
 drivers/clk/starfive/clk-starfive-common.h    | 135 ++++
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 127 ++--
 drivers/clk/starfive/clk-starfive-jh7100.c    | 503 +++++++-------
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  62 +-
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  72 +-
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  94 +--
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 525 +++++++-------
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  74 +-
 drivers/clk/starfive/clk-starfive-jh7110.h    |   4 +-
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 339 ---------
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 127 ----
 .../clk/starfive/clk-starfive-jhb100-per0.c   | 655 ++++++++++++++++++
 .../clk/starfive/clk-starfive-jhb100-per1.c   | 204 ++++++
 .../clk/starfive/clk-starfive-jhb100-per2.c   | 232 +++++++
 .../clk/starfive/clk-starfive-jhb100-per3.c   | 189 +++++
 .../clk/starfive/clk-starfive-jhb100-sys0.c   | 253 +++++++
 .../clk/starfive/clk-starfive-jhb100-sys1.c   | 157 +++++
 .../clk/starfive/clk-starfive-jhb100-sys2.c   | 178 +++++
 drivers/clk/starfive/clk-starfive-jhb100.h    |  11 +
 drivers/reset/starfive/Kconfig                |  15 +-
 drivers/reset/starfive/Makefile               |   3 +-
 ...rfive-jh71x0.c => reset-starfive-common.c} |  68 +-
 .../reset/starfive/reset-starfive-common.h    |  14 +
 .../reset/starfive/reset-starfive-jh7100.c    |   4 +-
 .../reset/starfive/reset-starfive-jh7110.c    |   8 +-
 .../reset/starfive/reset-starfive-jh71x0.h    |  14 -
 .../reset/starfive/reset-starfive-jhb100.c    | 121 ++++
 .../dt-bindings/clock/starfive,jhb100-crg.h   | 542 +++++++++++++++
 .../dt-bindings/reset/starfive,jhb100-crg.h   | 193 ++++++
 ...rfive-jh71x0.h => reset-starfive-common.h} |  10 +-
 42 files changed, 4805 insertions(+), 1262 deletions(-)
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
 create mode 100644 drivers/clk/starfive/clk-starfive-jhb100.h
 rename drivers/reset/starfive/{reset-starfive-jh71x0.c => reset-starfive-common.c} (55%)
 create mode 100644 drivers/reset/starfive/reset-starfive-common.h
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 drivers/reset/starfive/reset-starfive-jhb100.c
 create mode 100644 include/dt-bindings/clock/starfive,jhb100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jhb100-crg.h
 rename include/soc/starfive/{reset-starfive-jh71x0.h => reset-starfive-common.h} (50%)

--
2.25.1

