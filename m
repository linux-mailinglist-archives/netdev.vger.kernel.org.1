Return-Path: <netdev+bounces-286530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFNJB9iVAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:39:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD950A385
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CBC93001006
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97C3CAE6E;
	Mon, 11 May 2026 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cAxkBw+b"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01C3C4554;
	Mon, 11 May 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488570; cv=fail; b=tqXpCUKMzEX3uoF7hMVm2aX8YK/s/YSRvQf1rgndDmWzPbTn48siGIYS4SHdm1dZxKq8a+kXQQq69agaVp09X2FP+TxM/cm6zHTotK8QJbdXw/pbjr+uE8P0rdSPQ6FjfKjFNi7X8ap0rAEfio0FxgGuI+r4Y+nwJDS6cUz98xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488570; c=relaxed/simple;
	bh=DdGG/c1YFwARafmOXamfrmuZBBlGmebSI2t0kP87ja8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U615NunxxFNVGloWDImDIIp4e2RqYFUbzpOdYcjru9uLQDIBfJyJl895ZcoeGyPvoosTQsDlTbRt7SGqZJ/ZuSsKxTgWXahVauJ7lKC8tkxzikO+OoUobkKaDj4PDU8ycW0X/3F9ZBYdngc3k11mqM0L1l5nu6mBe51aEib8Uw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cAxkBw+b; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhAcYKRwYdIwloRSPsuiPAxeN9bRbbg9ClQKKVU1fV+3OpiLjlUec1HeBb1ym+MU9xe23OfApbZ79bXOU55UEWEELo3lHvjgCoC1B1cRlT42I2Aq91IFhj7dOHOCSZEpUIETC+Vc1Hmzztx4X2AiTy+DwfZNBr0no+12QwBJVG9XV+9L7OU1j2wT1lGJ/WG01owZtbw0AJTzVIc5V1b3guV30eD4auPhCwrnL4tjb9qsxS4SFura9WLD0HsO6bbSiKACM6FWThjKt/kdVbY286BaoDqN+MQjY32BFQkZu6EpInb/0HOAdXsGjU66JDsKxRxYZ5mcTsFw6RrtgI+Fqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFCLutcLr6O4HE7Pg54bFTM3npU2KN0gtWR/y/26SEs=;
 b=AZ6M9whe8kdS33a3prtwdqV/Ln3wgPWe9oau/kfY58V4JpSIlH6C/3mSb5T4SOodKxfkzJ5aD1b4b950olp42mf2mLlM4ASurHP2yR98cYrA9ZAO3SXPgTM+/qOWS3p1GkMegQi94hnYyO9UfKJATJn5dUh5+njRrps5eKzuOFUHeTE2GV9UwoMWIWA3v3uhkFu+lkxa8c182wPvkZqWZ5vULjlcZ/3UNhx/Gcdbt8ZKQFm6Pp0204GimklTrH0DNR76E8yhufU9MClzOWuzshz6HsoODwKEAtuqYcFlxy1dSwpJuKQbQtRkWj/AasGIlt4KIAvrtgV5n3BRd0UAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFCLutcLr6O4HE7Pg54bFTM3npU2KN0gtWR/y/26SEs=;
 b=cAxkBw+bdiHO5lyYq8kgJXROIAviT+5j4RisxjunguKc2YFqp5NyJwkOOh98OlV58GaYTKNvQYii8WoonjqcdgQi5HFUe0Ue2yVSrHK2K14edMiG1Tjcl1PtFGikkc2/Yrpm4/YVyfPSZW6F1h8BkTiGP5D9zPkGydjgFt/p9Bgm6cSvqO1IU6CoGqaW3QVWa8v0Wr0zng9V4q40uOmzNkcmO2bCtSXvPVkssHJuIns7VakyScHRsZzz1vzdE1c6/+eWX37LB0PN8BOifG4XElF8OZ1cMqFKkQjVgA4O78fECrkCXirQVCw96PJkXRvsYFN+Jaxmd+s11PPmdFg3sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:35:29 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 15/15] net: enetc: generate MR interrupt mask based on the number of enabled VFs
Date: Mon, 11 May 2026 16:08:05 +0800
Message-Id: <20260511080805.2052495-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|AM9PR04MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f38ca1-99a0-4305-c623-08deaf38422b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	YMZgBhwFie20/+PnquDWKBncK0GWbTuCQYlZwGepAD4hGL64xUaP6qNhwt4Ws1sip//dcfCBWuteemEY7UWk83KqOeJ6+twMCEiyrm/5KiKGJnnEf35Ok3HvkzYxrDRlZVC7lYePNZdM8O9OsT8LGbruoH4SJKvjXtTYnwzJta8Y6M2RQuptKlAF/ZD9xtR9zJKxgKl5YnRAQNDtCHe1Fbn+i3abzzx68F6h53unUv7oObu8LRncHwzN/cGq7PdzPDSs1A770wQW8wfoKq791PQ0Lx2kaA10XYthDDj+1F/xKNqNqEqPCSvShPoOKdQEXihICwQ3VxobACjnWVM5mmf5+EjxwlCtZuZq4370jU7GN2dX6qZv71Iwxxa4cdVCbrsnQnAQPRSzBcCXNBS9BjFzBdBkbje5Q42VGFyE1ZCxfcceArCCJxRaR8L8tgeOwzRCRPadg65KlNxqHSWgaV3EJLH0Fotv1nAKnrecx+wZVRAclUWqi73fImUR0CWrVVuTI6vJV8x0Hzv71p5vpZ7ycaosIQTfJgS06T22EucmDWco1JgNSGpBtNNCfg1+/ok/l5MkDxPlYnD9yiMbhPg46+ak6uRy3LSU4BmqIwF8CcURiP/Xe4R4HqnnzmALMGA+gr4lLu8IaI+oR6rnk6nXatmITPNbS1YrB2v7FXI6oUXvFKjkGEVoEIHUB4zmfZiZxWlLYsFb2CTgTuEpgh5Va8ZGx80YJbT0wMh0OBW7jknPxL/1hQ7d16CmLwir
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hn3+RbqF8jdtnkBpQvXW5EQjomXva8ZbQe0oKIPwF9+Jdl64u6zFGA1Nyxw+?=
 =?us-ascii?Q?GZffPDmDsmt/vByh6cFBSQajSvtZGu3Vt4tGvDG5T7WVLqTbvpvYNfo8pm5D?=
 =?us-ascii?Q?YaLNI7CA+lwCoemCJjMfFmVs7JBLK7CQmKiht+A0C1th8xuSJ088uciIh2OV?=
 =?us-ascii?Q?0K2M7zDgbFqlv7UQa71eXcryXl/cuKsNcxc7rdKZvfuTUUrl5Mw5SWZliaQn?=
 =?us-ascii?Q?P/gkQS0p06jY+HAsHigE4PTJ3Uy9dVyjEjVYnFnExsXCHWk/bjsR6H+ZHwma?=
 =?us-ascii?Q?Ce1RbeURtXmI8V2cOHWKsZvJuFesIqjyDhCjpiKSWjBvjy8FxgXqpWSx+BOd?=
 =?us-ascii?Q?iXwqcYFHgJ3cs9yzsl4waOaN2WLZU5m0E7jTVHZv+jrr6aJkX2Bim1t45IN+?=
 =?us-ascii?Q?Dwe5GGpNB1vG/56GwHCGNv5DR5BwV16NlHGrVNE0mul0XknybifezIrYPmWJ?=
 =?us-ascii?Q?X2dp6v2VSkfC832hQ1JSzp7ri2VjqADHomybDGQD1xOUpz2CvlP2lieqElFG?=
 =?us-ascii?Q?QM1u+iP9j+z0ee3kwwFLncdCr6fSMTeAXrorJbrG6ixLTOTeKtR2yUbh4sPP?=
 =?us-ascii?Q?UIJc/YFhD6N8Mn0wLovGZAfdnEwsjMsTrfn5iJXWOZEUma7KZTITkujibziK?=
 =?us-ascii?Q?+u5aHJxfqeZ595tEct+6+JdDJAXzxMArjIIgWyXpf4fLp3BlAlWUpp3Mc4pQ?=
 =?us-ascii?Q?eFwZfj5JgZtM7oYwLw5o5t3mnNI+/pgwwjP82dJJXShqS4wGp46WJJWLFdG7?=
 =?us-ascii?Q?KOMsTIwfr8tQYmJFntYyK6CfNiBarPzwi3JkhHNWSDrxRAgyIQc4XJLh4Kno?=
 =?us-ascii?Q?7TXymO3ZlHhyrvPHa8bdv5ztakf9iLrzMPzLASs7p6n9qheyktL4nQT80xaO?=
 =?us-ascii?Q?aOAmfkcPgmbpImw7H4h8hl8W81cf34rhpJTzde1mW/8/hwS4kucahcbb2JLp?=
 =?us-ascii?Q?KdbrhfU5vuS5mBGrjlh/g61fZSO/vRKCFyRXjY5SJSING44cUzDUo4JMLDXU?=
 =?us-ascii?Q?bATAXg+2CJWJb4eWRztX+wmosEhWGxYrCyqvp1+YGkefXevz+/lb6NVItNM3?=
 =?us-ascii?Q?I5D/tV7cyHNrDPTlQ90DOgdej2l4VbVH9NKyje6l8WQxb8A0NkmxF5A3uXOv?=
 =?us-ascii?Q?ZJ8RidU7LbotT4vLsXB8lN2qiSN8AXJIjkRBTy2AwOBACbW7wVbcN/0uLTv6?=
 =?us-ascii?Q?GGv0yIelyzSE3U2wD6UJw1IIoToWDpMazqOA3m09ktU8w+DI05q9T/18+ehU?=
 =?us-ascii?Q?AlVAim45xDuLVh/J8x/SrxS26HCXcNEMU1X+XH0eXcaBc7bzulDkuVjIsiK+?=
 =?us-ascii?Q?/nULKy9ucHOfRXsM4Ven/F10N+UHrix+O8h+S/iV5AfxCeOSUsha32uIXq/Q?=
 =?us-ascii?Q?pRLv98+jn7S3MiJDVh4+Zfj4KvFcgxMgeoCdZb02zPO3JkQl16xlaDxIAbTF?=
 =?us-ascii?Q?P56zkMi7b7BUMzVMwTJEAvuMHmqJl5gdOCeUESN/y52JKzv0ZeJFB5z+/W1N?=
 =?us-ascii?Q?XFxTpGmFOpeJAfcz5TaT/hQ32jYESmNdqo3eeZHP1zARE9ttxeMfn6gc6eSR?=
 =?us-ascii?Q?Sez7YPmNeczuQmCHSVLGvhVBuBE2vQ9IlDm2hnjmSNAUT1q0NS4R0i9rdMJ1?=
 =?us-ascii?Q?4JPV/kbUhYKNMdcE9K3ox+3zPLaH6chsWZISDiQQ6/cXbOjkl6aE4mwZc39m?=
 =?us-ascii?Q?RHbG07WIJkhJpmc5/9ssw4LOfpVWu0oxDfaOz9KiAN65so0tBogQHyHTze+R?=
 =?us-ascii?Q?tRUhDUYSsA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f38ca1-99a0-4305-c623-08deaf38422b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:29.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uprQYRpG4dCHRnW2eedQ4GAfeR9jxxXTFY0gN/fgFitrthtObeKqzO+DfAM2KFwp31PMtBlLPKrQeRkb9H8olw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
X-Rspamd-Queue-Id: D9AD950A385
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286530-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The current message-receive (MR) interrupt logic relies on the fixed
ENETC_PSIIER_MR_MASK constant to determine which VF MR interrupt bits to
enable or disable. This is sufficient for ENETC v1, where the number of
supported VFs is limited and fixed. However, ENETC v4 devices may support
a different number of VFs across implementations, making a static mask
inadequate: it may fail to cover valid MR interrupt sources or enable
bits for non-existent VFs.

To accommodate hardware with varying VF counts, replace the fixed
ENETC_PSIIER_MR_MASK constant with a new parameterized macro named
PSIIER_MR_MASK(num_vf), which generates the appropriate mask based on
the number of enabled VFs. The macro uses GENMASK_U32(num_vf, 1) to
create a mask covering bits 1 through num_vf, where bit N corresponds
to VF (N-1). This preserves the existing behavior for ENETC v1 (2 VFs)
while also correctly handling devices with different VF counts such as
0, 1, 3, or more VFs as found in ENETC v4 implementations.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_hw.h  |  3 ++-
 drivers/net/ethernet/freescale/enetc/enetc_msg.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 94f53762cea8..77dd7913d199 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -94,7 +94,8 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SICAPR1	0x904
 
 #define ENETC_PSIIER	0xa00
-#define ENETC_PSIIER_MR_MASK	GENMASK(2, 1)
+#define  PSIIER_MR_MASK(num_vf)	GENMASK_U32((num_vf), 1)
+
 #define ENETC_PSIIDR	0xa08
 #define ENETC_SITXIDR	0xa18
 #define ENETC_SIRXIDR	0xa28
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 73e32c9b65a8..e9963ea154b0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -10,9 +10,9 @@ static void enetc_msg_set_mr_int(struct enetc_pf *pf, bool enable)
 
 	val = enetc_rd(hw, ENETC_PSIIER);
 	if (enable)
-		val |= ENETC_PSIIER_MR_MASK;
+		val |= PSIIER_MR_MASK(pf->num_vfs);
 	else
-		val &= ~ENETC_PSIIER_MR_MASK;
+		val &= ~PSIIER_MR_MASK(pf->num_vfs);
 
 	enetc_wr(hw, ENETC_PSIIER, val);
 }
@@ -162,15 +162,16 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_pf *pf = container_of(work, struct enetc_pf, msg_task);
+	u32 mr_mask = PSIIER_MR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
-	unsigned long mr_mask;
+	u32 mr_status;
 	int i;
 
 	for (;;) {
-		mr_mask = enetc_rd(hw, ENETC_PSIMSGRR) & ENETC_PSIMSGRR_MR_MASK;
-		if (!mr_mask) {
+		mr_status = enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask;
+		if (!mr_status) {
 			/* re-arm MR interrupts, w1c the IDR reg */
-			enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIIER_MR_MASK);
+			enetc_wr(hw, ENETC_PSIIDR, mr_mask);
 			enetc_msg_set_mr_int(pf, true);
 			return;
 		}
@@ -179,7 +180,7 @@ static void enetc_msg_task(struct work_struct *work)
 			union enetc_pf_msg pf_msg = {};
 			u32 psimsgrr;
 
-			if (!(ENETC_PSIMSGRR_MR(i) & mr_mask))
+			if (!(ENETC_PSIMSGRR_MR(i) & mr_status))
 				continue;
 
 			enetc_msg_handle_rxmsg(pf, i, &pf_msg);
-- 
2.34.1


