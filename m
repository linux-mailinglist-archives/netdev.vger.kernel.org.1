Return-Path: <netdev+bounces-251064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D11D3A8AE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03C9930263D3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE7B253950;
	Mon, 19 Jan 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LJvrFQ/9"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2732572D;
	Mon, 19 Jan 2026 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825246; cv=fail; b=P6xj7czduvTiA6aIQdT7vx4jtBsoij0aAUoHOFLMZKVA2LpxMOW7XafkJ9R6jgqyasQE8leMiCG7lLDzhwNVmOeZ40FpA0wuHlhT8yAHmMg847xYj5lCAgfPCA87210lruyLl1JQEUrT9DEpakuQLzZGmsSc365t2zcd/WCvD0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825246; c=relaxed/simple;
	bh=f752+lldwHFx4IBdMAT/CGr1f19NBqa/arLwl8LG3l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRHv70TsMYnXMGDtY2hIvELcVghYOff5dBl3zM9nOvYzq7D8RQkBAQksIpaeUPM/dBRdau4HGQOMWNEavUqaIYiVqeYdih5eftoL4Ooipc3kYKWiMR3ZpH/g8HaNRO4irQEggjNg5fcNjt4lxcXjnrqKjp/TnCKYr67VMncpzwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LJvrFQ/9; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCxZqbOdjQbW3Ee0gAoH4/M200vOm2AhRr0E5h24uvCZ91omi4zJCfvVAsZKadIq1VnH1A8NhSpxo5utmDTI+2tIGQQBlNl/cDiSRQBfy4Lujeqg3qD3UvaIROw8E37LUP4/5tNuYmSRZHxRpr5RDX/fjdX/xlyV7U92T5CS96Z6kN3CIt5CWl10WjuKlx99mBhUsUwaqSo3lJcPEisH1ZN+kqkEPWEuyRCU84IXxqimjLBiHB4EKy1ziFqR3hAx2ofUIY6DBFJJV847deQwNgvwXZqHyjKrMZ8FZbrS3/rPPXhK3TsZFWeHxP5gntdRuukxF+gOG9hXnCFGYrNYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MUnuiCqXo2VKjJUqmcWUoc7LlCgZislxZ9Lu/Ksgjs=;
 b=CbKmuX+or7FAYT1zr06QlPl/PtFYZFgV/h0mf6/jdvP3+JcBHcnscs18uqo/mm8UBlZ2Gg+hCNFCIWWi//z0Q0NVYVC9UdIR/CPY4z8BA45rylnj3U2fu7knDxlckvaOKWU9j3llf/45N/jrzSoaI0p0iwEco3Gk1EWEfpxFeMKXPTGRZVFA9EBT0Vzs7nL7VTsZSeqb10n+RJR5syjn2zWiDvmANP0GBCk49oh86bGjHGM/M4LRrV2mpj3ht2HfSpaocLjWHlRjgdeTetsV593VTclTkMSgYZjiI97AI+BAM8jW0r7S2R1P5EOcJMFY3HLZ0qI11VOkZy6chJDQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MUnuiCqXo2VKjJUqmcWUoc7LlCgZislxZ9Lu/Ksgjs=;
 b=LJvrFQ/9EDu2yuj/5i8TRp2gl6rkJ/zmRLdmPjOA4mnzEOqVLVsdWOxlxXyjUhhiPT9nZkvxvEADrPiH3iH1qI/kxllNUKxsv8J6fjFIOvOC/P0gagoylAywYuawKPx9JBpMvOG/zzVZdJR6r/gqAapqM0REtbAKz2tNm25lqfNJh27cTgNBjDqbhEmM4B29dAtOHWBHTfP3X8D5iVMY8k9ZDQ7NImdC5HuPBVyZM+xMycUTJykkPow6JehJR9N4L0xV1Sy/enKVBy8jjo/SKG3BT+CpdHa3rfTUzoNLXrDYfr+yV4BCeSaDBrbeG4qKZ8RSe18r6tOgti30/EpSTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:20:08 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:20:08 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 4/4] net: dsa: sja1105: re-merge sja1105_set_port_speed() and sja1105_set_port_config()
Date: Mon, 19 Jan 2026 14:19:54 +0200
Message-Id: <20260119121954.1624535-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
References: <20260119121954.1624535-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0171.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::8) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf9ee9b-5c16-4a38-0eae-08de575515c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GwbkTNq1DhJ6Kf5F7FrICNvkOIGsGzZ4pmLQP248CNt0hhKJC+dTI2qLH8cl?=
 =?us-ascii?Q?HnPJSQzxG60pAXv3xCfQAWlSBQPnRvHhHoTDniOP7/gjV0yx5W1bmpTKs2I3?=
 =?us-ascii?Q?Xb9wnuIlPTtqnDkfwzObZnZ3zj1h1C2umGYdDeXdH9JhC+tP+IAr+7o8/coX?=
 =?us-ascii?Q?ZeB2GfOlVDY150V7SP7w5N6AexO59QEWj/6cPFC+DyrBJYTIEykC9xd8tfNj?=
 =?us-ascii?Q?4N+DDJTffux+cPvYiUIl7zXclZkE4TlAq/ASx5qJAfT2l0tNhAuhw41HaV3V?=
 =?us-ascii?Q?yb7VEA6beXFn637HF8JJX8ezXCqeRLgkYFS5LfzQf2kGeQ5rFz42Vl2nX65K?=
 =?us-ascii?Q?DxXIh3Gkpr//Yb+n8DRFLC/At8/mhCRMDRTPy8Uw5dMYTkSKRsHzlGgw6O/X?=
 =?us-ascii?Q?OXAdm60yP9DuMiKgjkVK6k6RCbwhnFHQzQoLxRt98/MONulTBJImpGZsPD8K?=
 =?us-ascii?Q?wHYQsQHGIZbkR0cIWfiaWogPpyj8mttVPipcAWuFxtQ1Idu/gk494pB7JM1B?=
 =?us-ascii?Q?KPUaUjGXOmhfOjhJ/h1p2flL6TWKOrYE1EvPFTQIHMps0t0YxkxXpxDSczMl?=
 =?us-ascii?Q?VVg5OerEuqpt3yTbUCL0Ir6uK2NLe/MYnU+TAuTIeiSLfyZaW35cEzz7C1xF?=
 =?us-ascii?Q?nF/n5UgIPljxT88DDEuQFZe9wxMjmMQjbLLfRMCbYB/+j7d57s1WqiSf5FKi?=
 =?us-ascii?Q?VPGSSTNcS1Zp+xTq0Qs5CV/Q1at5BI94che8ynZvFfN33/VaKgwgia6pAsRp?=
 =?us-ascii?Q?MHY6IbYSewpiSfoijQEenzdewVjQUZJfU24JS3iCyeeiODzTSqguGY7ctWsm?=
 =?us-ascii?Q?f6N6L6aRkcTo7VmqSrPGCUaHHJ29voT70X8JE5KwBW5hH7hTYvo7beNsa6aY?=
 =?us-ascii?Q?tH1DOdSO1gQu1p95bklMjf/MqPvSJ5EXHQaBBU3JnzpqxTIArwiORkGDpadD?=
 =?us-ascii?Q?Fv7buRjWYpmDQfL6Hafcmu6rXAdFK+sCXmIRXL/u9gVtZlwm5OeSN/dGfpYG?=
 =?us-ascii?Q?0SZtVkssQLe0KszwmI5x1ZZva6UJy9uYpL2PzYULJyc1Q1UWlyIHCBV9brrB?=
 =?us-ascii?Q?LTkkyM+5YQN+alhdasWOyRgXJYJZXBYzAE3lUuOWlYiuiLqcVv0QbhBMqC9o?=
 =?us-ascii?Q?arDXp0hBuc3wOEsCMMLvVRj1lnymUOP5ouIci9c45iVjsTeX+Aa2Q3aThSUZ?=
 =?us-ascii?Q?wRpig5GM0+BpG4HWlQMISAOOG0/oYyJpBo/TmSAeYDaL34tnK7/wSX7TmKKN?=
 =?us-ascii?Q?dJjE1Hqc0YVkrSj6GQyD+1S7KFmxl0avXgvN84ZWOeRw4L5/z0WOxxdXO3OJ?=
 =?us-ascii?Q?viQMPRhqrca+M72EV9Vmm8dXqHGFtbfLgAYQW9I+j/T3CH0SFcTK9YjBsKqd?=
 =?us-ascii?Q?dFPzJKurRSUuIx0gwXi2HIUM66diSG4/LgGfqIViZpmmEiIyl4V9Ixj6zupX?=
 =?us-ascii?Q?xnAm0EIbiq43eSdB+LkdaBfVBf4yYoQDoDnA15k4e9MksWXKUa1px8coyfz3?=
 =?us-ascii?Q?6n4lpqEU3A7/7KqqR/k/nDziH+A/UJI5Jg4IwGjIKghMek6F7hqab3f705nz?=
 =?us-ascii?Q?Grc5VqT6fy9A3accYAo6hE9BfQZbOSVMk3aaWqZgTBu67qeFpG4Br5vGyywM?=
 =?us-ascii?Q?3hf37XV/VgX9hU7yicsSDbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fyfRHr1eVG1WqDDxl9LqnJAv85T4YgKRx6lIf40vb+S4Jg9Q6Wb9O/dSrptc?=
 =?us-ascii?Q?6sEf2GD1n0DHCWQdTfc70wZirvwEBQXClPgIrpBVZy98Gx9BuA84TE7xmgjc?=
 =?us-ascii?Q?Xcnqc3eTQBYamfJPgCOCyiqvsN955OLRNVjh/L8LyaZQ7f9R+Rh08qTISuxL?=
 =?us-ascii?Q?JI6wa2ipJrnyin40CiRRZQNYvs/wh/wT5T2nncoIC7i85mydFtwB86VB1qbt?=
 =?us-ascii?Q?akGjveo8uoGNuRnhmiHYkb6oQq6MTN40r5NsSR9TYTipYP1a4OdsaPehm00+?=
 =?us-ascii?Q?0exXYGXVaLFGplZThFPnNZTW8oOzV63VOkGQcJ1M5rJOvRPSkJ1peg1PNjye?=
 =?us-ascii?Q?sGmPDQEGcVac2t7PIUbiWxhatxonK44Qw5JrV+XUh8FnrakiDn9H83wd+Mte?=
 =?us-ascii?Q?t0LYsgbxLyEss4mwDd+3Fjaa05JTkfrvAnTOpaZr4mJtNUfxYpUKY7lVwtRa?=
 =?us-ascii?Q?y+M6vhLVxOKHb2CyeQmn9E1VeSTf4URVrdcK1CIB0eADwola0RyFvOO86WYf?=
 =?us-ascii?Q?PImPl637BVToj7Z4RAkbkbvW9JUiNVn+tbJ3ApnA3d7SDMY8eakcyjENSIMt?=
 =?us-ascii?Q?X9h94T8S2M+CIFptXwQ06sjVLRFtBGxnH1Pd3EK/FTyp7s8WnI2mLNmfF1Tm?=
 =?us-ascii?Q?LqKEVwd0fOLPTMxanTFb+DJGC+ws9Kyf0Vt6he0mocA4Nh4K70e/0Xo1e2p9?=
 =?us-ascii?Q?LBf/lm7oHqcGVhaDRNeGog1WjYgRf4oggGxm5eXGkKzxZUM8gO9p3Bc7MoxT?=
 =?us-ascii?Q?IL6lqzzhmDuAa/Af5lydLQgz8rCvP2aAGlP6tIDMmeRu9/ySzJf9o+trXE4G?=
 =?us-ascii?Q?EFMAiebG6cKEeoQKOGWZ0mT04uOv+uYNuofgj/sUD0Xzl4+LuiszYttJ6D5q?=
 =?us-ascii?Q?YKjXYAmbiSUIx0nvnIB7vjTDDXOHo5eJ4eFRXv4Syn4jODjVHFhESsFenEFG?=
 =?us-ascii?Q?OtsqPWuSRXLYzLELo+QMAk1LxzsjHu7L5k2YAQvS3JD3O6VF7nT1kd3DqH2I?=
 =?us-ascii?Q?yNTkru+elk7n+KyIU6zJZgZZ1NmULa0gaulVOYsyiQbbjNj2KlXXA48CnTE4?=
 =?us-ascii?Q?TK0xR1BkzqggpjZ38z8sXtlagU7C08eCVBBCNRBi+TEKH3AD1SYKD6EIXHFn?=
 =?us-ascii?Q?37E3RcgJIUJLCGO51QdJmne9SePGxqfrQ4qAzkCmqxAGXPUZslbsIkKTnoOX?=
 =?us-ascii?Q?GIiHc2yBdq0wlFk2GvljXJ+ZjmMW54QpIcf3DaPRFzw7IM1UNHwINAa6YVHd?=
 =?us-ascii?Q?5z+QCCAJSgmiYuEbjSuOsqdXez0D/6vGj8ldHFQbVeV3BmnWmWZvcL+gvSdK?=
 =?us-ascii?Q?B8zjJ68jy0n7I647tZTlv3W9AghsGuh0Iv+djlwIXXgV5zJ/npA8OWOzkLAF?=
 =?us-ascii?Q?lBhrIQao6avZKYENRbqzfzQQ4l9DG2z0c2KHSHcptVacboVCcH0mv0+SyuHb?=
 =?us-ascii?Q?NqYEpA9b8H5CTHg/dGSOP/vJIrZf5Iow0m56/tAL5/JoQ4A8hkwxTutsERgA?=
 =?us-ascii?Q?hqceo2fTmYKV2+KX7BO77kAIHaawladhlH5YklXY+lyLqJgNPW6+VBQDVCsH?=
 =?us-ascii?Q?6CPgphzYJQ0KDV9RIzhOVicIvecHyiBkeuiKZ//0UHzuXKInws8ZGCpxAe2d?=
 =?us-ascii?Q?CGJaEduJhNZOlCopsQM1whc9DnuQQ5hClUBAfktOXztax8apq0IYCrPmX7v8?=
 =?us-ascii?Q?8K1m2aVNisQC+iPgWmYffbaXM+wT6arJHb3m31vkMGEa2KFv2wssjCU3v12C?=
 =?us-ascii?Q?Dz0fAclF1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf9ee9b-5c16-4a38-0eae-08de575515c5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:20:08.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g6ISLTsHizJpnFiPvPBfF0ha+Ay+g49v09jGQCOrUoZpBKRkugssRafNEh8OnvglXRAjqNAIlM3V4fy/ldsqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

Commit a18891b55703 ("net: dsa: sja1105: simplify static configuration
reload") split sja1105_mac_link_up() -> sja1105_adjust_port_config()
into two separate:

- sja1105_set_port_speed()
- sja1105_set_port_config()

in order to pick up the second sja1105_set_port_config() and reuse it
for the sja1105_static_config_reload() procedure which involves saving
and restoring MAC and PCS settings.

Now that these settings are restored by phylink itself, the driver no
longer needs to call its own sja1105_set_port_config(), and the
splitting is unnatural. Merge the functions back, which is to say that
the only supported internal code path is to submit the MAC Configuration
Table entry to hardware after phylink has dictated what we should set it
to.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 3936d63f0645..2a4a0fe20dae 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1260,7 +1260,9 @@ static int sja1105_set_port_speed(struct sja1105_private *priv, int port,
 				  int speed_mbps)
 {
 	struct sja1105_mac_config_entry *mac;
+	struct device *dev = priv->ds->dev;
 	u64 speed;
+	int rc;
 
 	/* On P/Q/R/S, one can read from the device via the MAC reconfiguration
 	 * tables. On E/T, MAC reconfig tables are not readable, only writable.
@@ -1305,26 +1307,6 @@ static int sja1105_set_port_speed(struct sja1105_private *priv, int port,
 	 */
 	mac[port].speed = speed;
 
-	return 0;
-}
-
-/* Write the MAC Configuration Table entry and, if necessary, the CGU settings,
- * after a link speedchange for this port.
- */
-static int sja1105_set_port_config(struct sja1105_private *priv, int port)
-{
-	struct sja1105_mac_config_entry *mac;
-	struct device *dev = priv->ds->dev;
-	int rc;
-
-	/* On P/Q/R/S, one can read from the device via the MAC reconfiguration
-	 * tables. On E/T, MAC reconfig tables are not readable, only writable.
-	 * We have to *know* what the MAC looks like.  For the sake of keeping
-	 * the code common, we'll use the static configuration tables as a
-	 * reasonable approximation for both E/T and P/Q/R/S.
-	 */
-	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
-
 	/* Write to the dynamic reconfiguration tables */
 	rc = sja1105_dynamic_config_write(priv, BLK_IDX_MAC_CONFIG, port,
 					  &mac[port], true);
@@ -1380,9 +1362,7 @@ static void sja1105_mac_link_up(struct phylink_config *config,
 	struct sja1105_private *priv = dp->ds->priv;
 	int port = dp->index;
 
-	if (!sja1105_set_port_speed(priv, port, speed))
-		sja1105_set_port_config(priv, port);
-
+	sja1105_set_port_speed(priv, port, speed);
 	sja1105_inhibit_tx(priv, BIT(port), false);
 }
 
-- 
2.34.1


