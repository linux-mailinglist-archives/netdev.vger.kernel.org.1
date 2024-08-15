Return-Path: <netdev+bounces-118722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C575952925
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F711F22455
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814691494C5;
	Thu, 15 Aug 2024 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mQgq7Vyy"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADD18D65F;
	Thu, 15 Aug 2024 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701936; cv=fail; b=RVO1ThbJHldUYyfv7UMj25DGmAG6rJ/MyutotET1QgEZS9HS5RosgA4o9nHkWZ2JAZHmjljuumCNkW2n/6cTX1jUOkJWIDvfQADHBDsY13aDrF27aBPhVBo0UXS6i2We56f9b56ZucegOgJnUsUB3nCzFr2XNh2HJPxif13Gi2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701936; c=relaxed/simple;
	bh=vcDhqfm/rOQsDY5OyeP4nXiP5IsCI8uUup45IplQKfU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NB3la32xSaXN2zkiXsTQFXg6BcOWaOV0eq18qCYcBDnsfo4qbt/IXe+kPHqx1CRR+nqOydyz9lGsFkebmH0VwKS3q4UBQIAPcjxTsKRhQb8378xLQt0KfdQIHNejVxHRDiAvRv0MXk31akK3jtVKVSWOWsrhGQyhvm85cP1dS1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mQgq7Vyy; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9Pjd8nTbx76lkN5UNWRGqulZW/JNNy2Ujg5P3RF0UJ0mS81GQf0TIjtCcxMsG4clMlNOQdR/02si6jxSBhV3NTCaU0XMykUP1nrG2q87wbFF1GCXU9p6dzIX5PIWjQemSlcS23XBOzp92plIWDqG7pB5kmnkCwEtS4uZWJuXE/76FKZ+x/beSwkLULiPmk5DrNJqo8AYLFlWqLPzsygv5OFlqv/hrEi57kfPEM0Qbe+pbKj90bhxN3uijCavSpsltjYlXQKj/lwUxIpritmiOqN18VFB0wVWle8PkCzBKrNWvtKdCTX5TtwXZQ2VGv9j4SQuhslvWJ3mot4fnjU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj7tqA9frRw89bPwdufj/3yHg0QxTgdhIl5O84P+n5c=;
 b=vfi11AknnyyAAKqcglpm2TQbnzinNgGvBaamoJBuOW9/pSmm7/EohjhBKBzbkwWfSPtBT6NsY75Xmq9c/UCH4mu5wELGaiWW0RHeRL7CVIPPC2EK08T6zHFaWfBvB3sST934VzKmmWpJW+ddWl/SQ5msO0gdC3hSR8ZIQWidmH4/kKh5zmo+RyOFciGmHBzoQAY7nukba2USCwAFIbgNn6mS6m25htZ0tSnWusnCztSP2dVCPWV9ucFsB7hLkGBO6A+slrJqq2Uyz7+yqKFMBYsfN1ACZ4T3wkfMqYmeThvs+wz7I2Bv1BZFOXsbc3UKKlOkgt4hFX+eb7SmSjkvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj7tqA9frRw89bPwdufj/3yHg0QxTgdhIl5O84P+n5c=;
 b=mQgq7VyyocgDyoyu2Z9yl72OlvXRoE0O+ytLgqk9bUSZBxlQVLzKDfJOXqnK9VYjB4B60HXRwn5Hn1NIKwERVGI3Ntpqo0G8chJXs/HUe3FgoX4l7JAIvuN+5zCBJxYo18ptN8rSba5rIBwJlRtC1X8AtIQKWW4vtzGooJmZPeiyGX2qLIuOLcDQNWv3LpyZd0TfZnzL0xjnT5ygSra1MHZekedgOb2Qxoe5QBh7H/5UT2xQt+L1I+o3gbcQs8Z0d6Pc+uxwWj1g/qer4IFehwe7iUGHox4Ex6AQoipVBVn/RlfEhcBGlMXr0YABNi1wMBy6GnHUlRYYC9Tne8glzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10805.eurprd04.prod.outlook.com (2603:10a6:800:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:05:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 06:05:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] add "nxp,reverse-mode" to instead of "nxp,rmii-refclk-in"
Date: Thu, 15 Aug 2024 13:51:23 +0800
Message-Id: <20240815055126.137437-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: fad435dd-61f6-4b50-91fc-08dcbcf04490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?81ywE6JR9+T7SexCOo0fmhiHoetNae92KFAsBFC9n0DJlVdxPLbaOccCLcmE?=
 =?us-ascii?Q?KOMp3fQYlEgt9+8unS2m4FvldBMizG2taT0GUbS0KH+OxWBpXJEkupv1eInP?=
 =?us-ascii?Q?9uStem8tk4IYJGeXYkXugYA7yEJnGETit6tkEHsROdmlVjQKjN3JW8jcILj7?=
 =?us-ascii?Q?+SCYCHurOHb+U0nOmciscKQz2khMlhYghg1ZMNKrSh+kgiebVAkXLh+/dmGl?=
 =?us-ascii?Q?8vVR48VagMnIudbwRsJKvPcl7Mx8W3eixSbZOoAnYUwSvrPkF9xbgFa7Hlk/?=
 =?us-ascii?Q?rK9o1o4/8LHi6tx3PkTHYmVGTkq2Ag8vA1BumGt8CljTPPDS9eO2jFy5+Vf8?=
 =?us-ascii?Q?/1TAP8CcAIe2F0IImSoFkJtcd1JPhbgD3gDRh28zxqI8Fze7WZuZ2wOEsrh9?=
 =?us-ascii?Q?RrBqJ4y8gcljyS/n/hrqC0iWjCvdGrzeKlxrBMc1WXhicqHCkR38lcKN7WT/?=
 =?us-ascii?Q?zQyQtKqRby4m16K+0+fyO6Ba6BbghPgdDz5Kaoa93PWTYudP2JU5fmnmafIG?=
 =?us-ascii?Q?OR0gnbBV0OruQugrLP0PfAdxA4jIEwQv3wVIC2SWlRJaB6lBiOZD/G+8WZc/?=
 =?us-ascii?Q?/wF0JqJgzazIcNU9T9sXck0QhP/bRytUeH4A1DIIZbzic+DxgLfACHEQZffM?=
 =?us-ascii?Q?fPxWACHlitH0Xk2/eCwJ/3zSgQWhWNxV/1VDNCf+tNAQVHE/PySfo1xgChnc?=
 =?us-ascii?Q?SkCmhC6PNZoidkTnI2xTqY91+YQpdD7xnTyPZEB63egobfHLs2Dza3kZnkFg?=
 =?us-ascii?Q?+DL/gkIuwqSryFne9ZiIWt8ne7dQuGsgSNvgy2dPCLvu3zV3HRkiGmsCgxPH?=
 =?us-ascii?Q?UgVh4KX6Fov0Wsm9EK+m9hWKtQ+00xRcuMfkg3jhSSaIjW0R9TsOtV963YeU?=
 =?us-ascii?Q?I+5068s+lhoh6J6VsBxCdySerCwRROeOu8DZ9OZATxlA+2Qh5EJkDyKdkp/6?=
 =?us-ascii?Q?U4P1AY6rXhq6cjsXdCQJ5o6TVR+eO1I+6pomlNO6QX6mFS/9v0eAkoD5KePr?=
 =?us-ascii?Q?ZrmkURcfc5TSRQnBTVHWGJ4RiiMrybPJUmo+/PAVV1qYuk7OnoTP8ezRhdo0?=
 =?us-ascii?Q?s8iT30VBeXa5UEmHRAk0HmqofARAmQcxZLCiNBE5g2s6knsOoSuSnP6x4I5T?=
 =?us-ascii?Q?TALw6I9rJmeeDjFQAbrJCFywQRe55AtezhyuOabborZmRIdebm/pDyUGOAbI?=
 =?us-ascii?Q?kjNKWi9cl2rZnPqVe/lwGebrVLN8AgaVvJLKFceHLW+nfSjV+b/vizrKfLzh?=
 =?us-ascii?Q?3oT/FQ+JjogQ50koOTUyXjM3tcKBJIz5Qq2ENuaXrcb5XGtT68w0X6I0kQ4p?=
 =?us-ascii?Q?GzGcbOD/QVl+j5wnRv5KMXTf3XRm4rRxBylWsdKFHQumG/Bh07QOgu3mao6/?=
 =?us-ascii?Q?qwVDA1LdeXeyXZQfiVIIrSCaM0mPfafDFjIV13PXUEAg4AktF0wP6J4tXM1C?=
 =?us-ascii?Q?hSdsZTXbGDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4hRdEGJpH4l9rGxdwjywJJzklzK0EkbbvJIShOiSPDTGo5y2gKIbPTh0DiSG?=
 =?us-ascii?Q?5TAsq7YHa4cbjlo0t/cTpx4bDreL1PEFKixCkfg77u5dwHoPFIwg6XBlEcp7?=
 =?us-ascii?Q?SPfXoFFv5sOHX728uNrTJAoMKR9JuR6XMgy3FZwFT8QeC1Uk1X6megTPnseO?=
 =?us-ascii?Q?REFCa/lfoIKQX+BiO8KllbUyjQCR2kKLPvTIpeQLPOvp7zo8ayP3orxgA9+X?=
 =?us-ascii?Q?JNUlJi2U0BNethjoQLzuBHCDa+PaF7+uUAQFfzrsgo3GoWddYsP6b6F5/IFL?=
 =?us-ascii?Q?D9eWlMI3Y1tnyNhhRnwGalp7zxssezDec1e5VH28ysC9cnbD9ND19mEAhvjH?=
 =?us-ascii?Q?vVH54ppR3e0KjrbLVt7cgPdQbcXG4ur7OMCkRwjyU1d4vF7EvxZXMkdA0LSp?=
 =?us-ascii?Q?1fOPvE63+yBEFWnLLaRsCCJoNFsYuXA8Fpps/rAwNzVr++TJYX+kPeSJWRrH?=
 =?us-ascii?Q?iA8CNQB4KtjF6fxD+jusJF0LZgHdzJpmzGznJUc2USlQJsFzwfFgmGOzDYu5?=
 =?us-ascii?Q?iGOS4mwmKk2w7Sp1r1R/A9ilHqj6IvyaMyuHAXMQdOC0lOVonUp8ZVrNhV5c?=
 =?us-ascii?Q?Y2Syk/XT2CEwliG3Zgp9YYK0+tzYIwcMc5BVph779IFspuMveUGk+AfYAE0G?=
 =?us-ascii?Q?KvQDqlwiKkSxULy18lUsi+GoPAJurW0xWFjoclXuSCbszzRoOj/LbE9JOQx3?=
 =?us-ascii?Q?f/a48GLNmhxvawAk24BxMRxFXlAOSsuQgz4Fw9Q4JLw8G3tjAbbIjE3Wfboc?=
 =?us-ascii?Q?E1acaXaPE+/Tk1XoHdR5Iqe5uXEsgecjzachEITYDWxnJMmUckitU73VQlV0?=
 =?us-ascii?Q?0FLzgORQUJQAEEj9oLNFdOQrEdGKav16cmDRq5GcBsd39Le32wcY/IImUzdp?=
 =?us-ascii?Q?9dqWgdP+a36x5NXGTNViQlDV2TiD2Def3vaN49HbWg8yTViKz100tcBFx1Mq?=
 =?us-ascii?Q?6LuckgEk3/0LceeyLJy4yZao7NTHbi2TOR1ktLq4gqGHCL6/p+WEJi5F4vr2?=
 =?us-ascii?Q?WHg/7vkbXozW7TRJmqeuUaY9rWKU2FBUn4KBu2RHDgPdyDjoreeNgmbKscqb?=
 =?us-ascii?Q?Ai5lizdZhjMHNlgtDsvRzqVBPnPvNbAXt6UsSC8o+IosI95KM+MdxNXY+fMO?=
 =?us-ascii?Q?Tc2KsIcUsnVpQLIsas6l1l0dzuiG54VLwORGrarT9dsLl1m59g3WkKph84j/?=
 =?us-ascii?Q?nQkUsZgFFx8VDDX8HeYi4q2MCDc9NPEiFw+LIa/uWxRyNbnST0ZDo0hafz1D?=
 =?us-ascii?Q?f8pWj4XLTgiENYztugdGmvr+DaiVIPhesNuXm9uTrUXqyexfJFQSGzCEujPg?=
 =?us-ascii?Q?9M7MrijJd85nIY1YpnivOeG3v4Mmoof0tj0I61gt4UIMV1HIKw/6B9p/LhiO?=
 =?us-ascii?Q?dxMEoTn+T89VWvdLWws5VPjTBJoZvJalDzUjKc5wSpKBIGPuz/Ni2r8Mv//a?=
 =?us-ascii?Q?owzc0pIpWwJe9POJU0iLivg6MDAQ387rraAmWlpgfjJXWRWuLyxxiJvjo7vc?=
 =?us-ascii?Q?BMtVUx46DOhujA8a3dmgp5He3LPIb1yoIyHF8IhnqprsVrthk+qcVUKBPSIa?=
 =?us-ascii?Q?Ehxc2ByZV3uP83FsN/wxfcLdBAzPPHtK8oMHFySa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad435dd-61f6-4b50-91fc-08dcbcf04490
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:05:31.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uu1FJjuY+00R2PAiuPaLSRS7JT9KHAzA0HrwkM5iGwc6KjK0NDFEhfDzyGaCOQdcIbqcyGOF334COzelpbeOvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10805

The TJA11xx PHYs support reverse mode so that TX_CLK and RX_CLK can
be set to input in revMII mode and REF_CLK can be set to output in
revRMII mode. Therefore, add the new property "nxp,reverse-mode" to
instead of the "nxp,rmii-refclk-in" property, which is more generic
and reasonable.

Wei Fang (3):
  dt-bindings: net: tja11xx: use reverse-mode to instead of
    rmii-refclk-in
  net: phy: tja11xx: replace "nxp,rmii-refclk-in" with
    "nxp,reverse-mode"
  net: phy: c45-tja11xx: add revRMII mode support

 .../devicetree/bindings/net/nxp,tja11xx.yaml  | 21 +++++---------
 drivers/net/phy/nxp-c45-tja11xx.c             | 29 +++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.h             |  1 +
 drivers/net/phy/nxp-tja11xx.c                 | 13 ++++-----
 4 files changed, 41 insertions(+), 23 deletions(-)

-- 
2.34.1


