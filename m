Return-Path: <netdev+bounces-292783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP/CMbF+GGrbkQgAu9opvQ
	(envelope-from <netdev+bounces-292783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:43:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 445205F5CFA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66A523021D2A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BC1406290;
	Thu, 28 May 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NHxGFaaQ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8303FE363;
	Thu, 28 May 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989707; cv=fail; b=rTn0i7UijoP4MSF4PLnIM89Y2ptuy52VeiWaJuOgZN+u/+X8QgGlHJFXHL7I8tPfpXF8XgWO+Hfss5RGa9ieDt6n+iMyAO4872wS904QDg5Womi5iPis/GTGtIVjpzVIdy1moH7trSAZsy4AOG+jze3CpSPeYFZg8iWrtg7SxKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989707; c=relaxed/simple;
	bh=EhuY9nQFn6pJ/wxKaEPpzr2fFLGY4PxcaYtV8g74Ag8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pit+EaIg5NMGzArGuWF6IP9uTdegYnPZq5cgkeYil09YE3K6qDy/perS6yMyll4HLlNEdh9hH3N1HmzkU6+D609M9gwv06Iu72yAUsD4GYaPG5CEQ19htjz+5wO99uyeP5JxgZygj8LTHjO9o1HrYBHhrKhDWA9hbd3/PfQuPoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NHxGFaaQ; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J88PWUryIF0Yl+kKuQncFtVI5CZhPzvA9JnXNk1eMX7GZ3/zlm0p97ndj1JWYMEcSI8VTUumlRNErRYXaDniXsAJHqSU4JqyA0wtx/SwlxcK3FbiQkrF4ohhx8TrXYWZjgBcs5brSGVMelu4HE3vkLVV3xHTlkKTCgtNG3ChAQe6wJVnVr29gwNUaYn6QIb218bLKS/3tNsiwGnvVvUKAU8EYdK9bHGxJb2t0y4BZLjP80xmLwxeAO93nHs+wnlArmc5AXlAC7ew6PATr2VVKDGLcCLPWMgmAArMTThJzI2wZvn+YCttyQjAfrD0uwQukCmlF5u9kjTxDTQJ7j7TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50Q0JuKYPSbkusfBzbG2URj4rqcKOkRjp+ul1tIddmg=;
 b=teReMGHCOHXLkonDVC9i9ArmfJSnkD+fFOX3hDkIrAKi2mib0JY0IUV/V0j5nKNlUYj8aD1vjJ6ZnckfYoedISArTyVOKSHR71qxNYQs5cO4bG4fxMdz2Ze7u78VZvdWOoVxzpRczcyNDMkDBk/LPCy/VSgFqcYyYSNXHphP96m07gMVonCUPsUl14AsritdU4rBvm7bLFnbxnouPD3nzoxWQBCjCBtfbDwymM9rh4N5wrjL7YGDs9nUkfpvUOQMjkCW2fa2/gL770QG9B08Pqz9to7xFBftQBi3jlfW6TRNYWjl6//BoW4EZ5A9eT9aiRZHistfRFoGRwYMmh0Cmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50Q0JuKYPSbkusfBzbG2URj4rqcKOkRjp+ul1tIddmg=;
 b=NHxGFaaQ7h1QOIpdJh7eP/1iFjSvonnCF7OFPWpKFOl/CH9qen+l42nxAwMZJ8ep7B/KgCIWCMkQpNwUJCQEP9zBJ7fXkcf3dPHhqdD7/Bp5Jig6gUqQMtNkweYwA+/GU96Xty8OZDRFmMdlyEE8Nh9k4kTlHeEa2g0em9h8E+5tw7As9cbGSiNeqDkr5ub9WtR5CgtuxW3xwapw2ZiD3ZEnZ3Q3vPiIFfKRUjQkyR3oa5XnElsttG3PNhfMWItToasygXgku8zEvvZfYVPgh2fb+N8wEZdQKDbXsBdoNANjsyI3/EpbLVkPY55idnhpp+4EJgOO7bxkT8/wKmqYQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DU0PR04MB9657.eurprd04.prod.outlook.com
 (2603:10a6:10:31c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 17:35:02 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 17:35:02 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] dpaa2-switch: various improvements
Date: Thu, 28 May 2026 20:34:47 +0300
Message-Id: <20260528173452.1953102-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DU0PR04MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fd6a93-3c81-4661-4d6b-08debcdf7290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	XYy8IWUliIkPRg1fkqXCSMbmkaogR0G91VQQfPEo2sU8oS4XDojdPB3e7B3xvPxLQw2X1hlPAWVMqVGjsD1eMFWzbmqmMz5LhuvYryXQIJ02CLoazqN2Xw+DICZmqXgNeUcKQ40LvGT+URWxH0mN9BCoKipXUK6vTxWQ3W5eIz4FPQgYRPIWiCJZCVyhGXc0nzYfwgkYN2wF2V7m1rmR+3jWIyX0cthFkrYG195JUBkrFVPrgkS03DvIRAh2y+szon/YbHkbqQv9Lo2xg2yqQB5/AkdTLto0AqvJXuDM+X7Y85hgvDReEuCSk8yb0avfqWNhCEHu19hvQC/9YLVtMPjMS4ai3jjgeQLBREAsySJbr5MAxVARJX3/O8ct+HwmXzdHH/KBIiCObOwb7yUVUSh6tzBRjmnWObn6DwmfLOgX1cW+LR9v/3bBXbqW6MFof17SWaf71wKycckWIBHKFLi3yhsoYpoTnQWOi/9G8WDclxRV/iop1LDcuv8rbtDqeKoGr8WQyJWPIIw+hT2rgSmorC7tPniDJviZ0IYt2fmrHdYP59oozDhso9ndppQo8H6qIbAgtguJFrVWYM0TWtMcx77CZJuHNfhp46XcjO2yHn9bfjNRkM0931PL4NHhbIljxCBnS8yYus10G2Y4FA/PBCdQlzLwzenxl13k72dg8yTsN3iM3SpoCz1ZuFn0QA6218C+Ly60pGLLujg4sg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YThMe3iJeasXPhC8eWclNSzVpup6++plbhiiqGcfdc+Bb9N0UG/kxZD1OUQ7?=
 =?us-ascii?Q?GvFrCOsZgN67uu1vnJt0xnrZQfoAK5Fz0lE01Jb7kNY2wYwPf4eApSZRERBW?=
 =?us-ascii?Q?HWEmmapYrtwYizBlbISvcUQfbyzsmXzpJ55ci8GUfaU9SvefeTy9veKVN2y2?=
 =?us-ascii?Q?/DFWSX1Q+o9xIi5Vq+fsAIETISfsjUQc5mjHtAORproC8SHiraf9UuQvuLy2?=
 =?us-ascii?Q?OtN/eUDPytMIkzOqc2AronFw5YHGqzjI1wIFVGCtKG/vaBL+ZA4X8/TnyUzm?=
 =?us-ascii?Q?oRS2MONiYizlbNxGRy0Mi0FDS6+nJVWlZY2Yfcm2nfJMthrmdQXEwQuYOoSt?=
 =?us-ascii?Q?4/HMpAgp1p3KWPZyRuVQF47bTegTJ0WwkWwfY5ND0EV9G5Z1ius/zfU+sa6I?=
 =?us-ascii?Q?zVe4Jb8ZltmowddZf1VjbUvHuYyGU6WX2ezrpEQcMUYY66cV4N2CyL9RLfmY?=
 =?us-ascii?Q?OZcmKK+HuSSZqOmmOgwQ+IFN4109o3a5zW65v7xhUzflxbvGoOt8v2qiaMcT?=
 =?us-ascii?Q?6+rvssGau5b4TSorugHM6zXoWhsIgJfR+cv9iZNSieAAkoMC/ejROJq8a8Vi?=
 =?us-ascii?Q?uJP18G71qUV1/AM0gT8PF4dE1tG4soG4FfX/3c7vtUo4nl4eg7/XGIjqbyqT?=
 =?us-ascii?Q?FbZteHDC+60+f58aqdsR3N/o8ND5fxk+ggJbZeUFuCYMrCCgyJuabvX5TW1q?=
 =?us-ascii?Q?0BmfyPFh4S4OVlF6BbI+XBBYCIHWBe+DHZZYcZMal60EM4JUVw+TvlU5UHNA?=
 =?us-ascii?Q?o7SLIt7OxIDPE9OF1qW++9z8frVtwOsbchSfpVgO5cRfftQEzsBw30kVujFL?=
 =?us-ascii?Q?Dp+T6xqKqgAyKa06JYiTD7UuLJQgV5KhwWJBsnb+8FJpy/vVWf6X22IzQblN?=
 =?us-ascii?Q?heRwjg5QlGnvzZQIS9mzhG3ZRSR25sbrZ7YXyTNdyDQ1vC6ucyQt/cGKxeEv?=
 =?us-ascii?Q?7FiwuqAKMkxx3sV7nN3+W4Ct/r6j+TpPFts1J+rrWOlg2M85vDnUKMtZIRA2?=
 =?us-ascii?Q?TS35yUb/3HLwhqe7FFymGfnlztTeXQPqgKx+g63+ZBmp/l7KFuyMetkOyJes?=
 =?us-ascii?Q?hPRLOtRWtcRxpoDa2xz6d2RJG2dQR5cPj1/cRc/8Hd3ghiZmnHJzRoZ77Au4?=
 =?us-ascii?Q?ipfvpNeC0reLQiPerk+rxbs+3gXZDUyNUQISlCYXVycyD9emiZPEMBJ4+Mf7?=
 =?us-ascii?Q?Sozd20E0Oq9tKQ1rKop6cT2Zh5Bwvu5rfr7hMWHGcGMXjbpl+wxYcgQE32oS?=
 =?us-ascii?Q?bZENKMqyXqFUj6zcuYqF6qg35ZXtKCqYy2Xl0MHuTJOd8Dsj0kcxNT8AHVVR?=
 =?us-ascii?Q?Oz9qAX/7mqH/m8beISxvJC1Pk0CWwlk86PuH1aY1QtnmnLfCKmQyiWJJdDUH?=
 =?us-ascii?Q?UYFjVDLjDOkja7mJml39a8DkJFHnQSP5OnbCZxnT5VQYcgvuGLQOH6O6ccJ3?=
 =?us-ascii?Q?i2FdcBEPzhHoCw1ulqB3YBshLq8+MW/W1xM5AFkVGTD5lD/cOpl6Qf6P/O/z?=
 =?us-ascii?Q?BucVhQFHd5nG18M++Wy5ihHjDwulb8dr9SOna+9omGpsHJ0/BAU+BmB379ud?=
 =?us-ascii?Q?E/KLZ4JvFidVTSSJ7epfwWPCOzuZ6hbLp7og/+zMRKzY4kraf1SfVtUkvxkq?=
 =?us-ascii?Q?8d+FMovahCQ3Le5qItuf4+UcGra/AJlaHDft8gXZYxKGOb/j67uNhZ9f5AGx?=
 =?us-ascii?Q?8/o83cwJzALrRpLrnGz/nArBb/slu1v/bRr6IwztfCC4UkM8UkwOKs8apWYA?=
 =?us-ascii?Q?vrG7SVxqAw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fd6a93-3c81-4661-4d6b-08debcdf7290
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 17:35:01.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZ1GkTYCVHJWfXcUNEnUaSjbAcTLjcvXE+LGGwe70Fm1TKeNVa0JbCpcqtok4KCSQu+Rysyzm8yI5KH8oT10fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9657
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-292783-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: 445205F5CFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set is a comprised of improvements and fixes for
long-standing bugs which were only caught by sashiko while reviewing the
LAG support patches for the dpaa2-switch:
https://lore.kernel.org/all/20260512131554.952971-1-ioana.ciornei@nxp.com/

In order to not just add to the already big set, I am submitting these
before any v3 of the LAG support patches.

The individual patches tackle FDB and VLAN management in the
dpaa2-switch driver as well as removal of some duplicated code. The
error path of the dpaa2_switch_rx() is also improved.

Ioana Ciornei (5):
  dpaa2-switch: rework FDB management on the bridge leave path
  dpaa2-switch: fix the error path in dpaa2_switch_rx()
  dpaa2-switch: remove duplicated check for the maximum number of VLANs
  dpaa2-switch: support VLAN flag changes on existing VIDs
  dpaa2-switch: fix handling of NAPI on the remove path

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 179 ++++++++++--------
 1 file changed, 104 insertions(+), 75 deletions(-)

-- 
2.25.1


