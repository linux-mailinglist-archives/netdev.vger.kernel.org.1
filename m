Return-Path: <netdev+bounces-138166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49319AC755
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593D21F2161E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A219E7ED;
	Wed, 23 Oct 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lXPtyx5i"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44315C13F;
	Wed, 23 Oct 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677959; cv=fail; b=e3u/AYZ0nZoSdllb3Pt6su+lCKidxDELkKEETb4Wztcl0LbU3NCFj52fX8yQpbcjbtKz1r8V6iWgp6yB1nCKPB9CLax00IktV38Igrwx52KpwpaTQAlTDbARd/n/PgJFaqzB/cNfLSIdTxMXtGbq5vgO/W20W4zZRbGTV17q8Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677959; c=relaxed/simple;
	bh=SS+PeeSjxl8/Jdrm7cFj8tlSidDGjapLkFc+M76v03w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K57ibnDx+fVCo/yrBVM4PdqBzlqQBmBZJPx+YOvr3jaLarRh+nEfkYGqtSsifUU4lKnvosQUVmjTs0iz2g8w1pnXpJwI0yWexz0rKvyuu0ALUdwaurMELEm2XZM5LHzt0DbIAzUqpAUp6hVAe5Dys0a6hDREsZeJSMng9e0Tgz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lXPtyx5i; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PirYmU2hzG20QeSvKvJm7v2GZsDt5VsXzE0mk/UI3a/YexAme+Fo1F3oaJt7RudEdVvUL1OGXcdv1ITh7LLhF2x/PhrBaJ9B1z+QF/5wQWEuwzOrs4n5dmaPVxitsI5iARltzFS6zfo3KAbbrTKB3ecbQBONKYpPxV7M/3K49fLmjMq3H9xQC5b5Kf/7BT1vrdXUpnPXGDg1+xH5UqNs+pweI5RfN6wOTp0yWwYA0TTNIrlqneOATgErvStEC1p9ZYNrWtpHbCkSYEbt5kccsKP3CqTAWkOLsVKCxQQY7Rup3NIvSGli+3H6NNn8S9fSuA9mjCizjycN899JwZWdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4WgMLc0O3K448sD4DjmFzS9yoez97cH+7M3bnceeBY=;
 b=k6KJeogIthLK5igsOBo2XrXAN8luyyiROuM2mCB9FdqZ6vz32jDIxw8Iw9CeAhycxZp9E6xKy8cXPbJNmHzvwhzom3O+1PtSbvEdN4egBQZLlUNLkaHM6Yc3rP5eHUeXwMG3aqHyZms2Hr8quzhVyMkaOfCj6J40XrkbCM2cMAd6xEJW9F2h7/2/Quh9Ss6lwq1ej7XVpMJi45xbYsZGNlNr6xrssN3Lxl0GG4yaVoAf4ox7IZxSRdkQkJXUF+nqOF+xK/Qj1gbWPMcJPRLs2ocHODwVXbbPlIqBOOlX9HOsxIMfDsLqvZw81DVOLc/0S9KssFi8oV2j6uz0Dct58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4WgMLc0O3K448sD4DjmFzS9yoez97cH+7M3bnceeBY=;
 b=lXPtyx5ivCUoiRfLucxt8sFCae4APXQ6TwEFMCu0g2v2iOhiXvQlW0mGTB7V1sRjgHASLROC2X7odcUqljNIwaKrBFJcC4K7V7FRB/Y2IkMjdYQN98vLIs4PV/2irgMH1zhgyBwRK0vZbPuZx20UmT3WCkiPOSBRFV9rV3aPYhIbIc/B8nP0ydL4+BXUwwoUrLATqvPsCZaSdK48GaNPtXA3G+8JiJzfB5UXBmdHo4fBEGc95CKSzPM1LNSthjQBwjm8LeV+4fH7muCBQjykEnPIpsz7xJ7Ehn/Rw+nO2MQepnXOCePsRZqMpWzkDdPeZhpawlNYXjk4YlqJApFIKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30; Wed, 23 Oct
 2024 10:05:54 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 10:05:54 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: sch_api: fix xa_insert() error path in tcf_block_get_ext()
Date: Wed, 23 Oct 2024 13:05:41 +0300
Message-ID: <20241023100541.974362-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:803:64::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 403605a1-f46b-4215-9dbf-08dcf34a4827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nHjRB+2esHOo3tOwMBCtzAaXblx2pC03n5PE0+lDRhros/Eqnxnv+CRCaosx?=
 =?us-ascii?Q?8DG7UyiOCMyYrr05c7ti6OPPJQyIZM2Us+G37LaMeJ7GV5rgnxAo1r6tvOUk?=
 =?us-ascii?Q?nQNCcKcUia+Wd18NTa5WCT/HfWdbsBdW/5DnbQVQWPjnghUpVRs0Cm7lkrdv?=
 =?us-ascii?Q?YrybbpZGuZzCy3Xv+j0Wr3qo+p5CUUT+I2OhmON/zdgO3XKdiICYlsojfVVY?=
 =?us-ascii?Q?f6A/Q8nES9q0XGJ7MKafZy+2gIN+uNA8xMNDqx1Lkx7HgYhVq3OZpvwaV8ck?=
 =?us-ascii?Q?PlzlPHQrfT3jDOlZodzYU3PFgEqipjXjEAAj9DtOwFUVYJObcPOkVrtF0g7G?=
 =?us-ascii?Q?pLKsBfnxZNjOredSSbYhiZfjCumplSHLOdZ1uVTyiqG4fkic4Eq9ggGfsR2B?=
 =?us-ascii?Q?SLkwTkJkm7rrC3zFfiaXT4Bt48M0CM0IQ3hWTlTTTo0Phc4QdQtxb2qlMwsj?=
 =?us-ascii?Q?Wzw78QJbwB7ihiuBkkT2MAW/Y7nO8kceQFBCy2LZv5Tptbog9EEWM2c3Etqh?=
 =?us-ascii?Q?WCDuqSaGkrQGmcUU6FB9P6KNO6yTmKbIUAWQ3HXZVEnpxfrt07M5a6WD5CMl?=
 =?us-ascii?Q?2htorEAfSJdZnr9ZPuIJSu0Ztm1mNqvE76FdiCG4/gJPRFagptsBd98qglht?=
 =?us-ascii?Q?0Cxk9jM8fGMNXBSdOHlP1hl7IOHe4qNW1xD9HXMfDRrOn9GnidkeMPTRmbYZ?=
 =?us-ascii?Q?gLc9D52ol9zfRI3x0yUI6iwnr0nAn0iA7YbyWEfA5WKv+FKqoA3CtCWQoEbO?=
 =?us-ascii?Q?HIqDkdcaXTrCGeItVGuaG9FrgClyEEhjk48k4FMLZIVbl2XyOCFia5xdJOTg?=
 =?us-ascii?Q?LfVXhNwDM1IcySYR422BLNe0Tfgg2s5QiyUM89D4DIgJy+qfmKR6qD9dvuOC?=
 =?us-ascii?Q?QQ+5AeUm1agei54yoAkOsFrAiCvmWZtG4tSLkTky7nrpJWpoBO0yrqSK/ai5?=
 =?us-ascii?Q?AVSiTvtdhp6TSiQAQEZdvv7CD46QJU5bFY9no2myaLBzlCb12z5KpE6woeYg?=
 =?us-ascii?Q?PR4OvnI5ZK0M91Jle/i0I1nCBTSbsPRXHXZ9yeKx8Gir+irXPSRbcPOSnRSO?=
 =?us-ascii?Q?jhZBX+kiGQrHOW9ytNrOgnMeSTdmpWd1TkE2PAIW+Jf4vwSPx2MSoic5A2Yd?=
 =?us-ascii?Q?1icc1jmkp42yRdOt3tA3hg/PnLYvS1lRsxDxMaY3zLoCg/7pB/1t6gbYWFPI?=
 =?us-ascii?Q?YTB4YPH1vGZh89KsF+ECAMIhFwtmax6l/guuDsb2la5QZ8zUzcXQJpkm7ZcX?=
 =?us-ascii?Q?2lHUkmB1hsL7hmZ5ZBdM/rUdSuCrud8dDYxlExoGZHenwAPiNDT2jSbYUFuy?=
 =?us-ascii?Q?5RE9vyqBS7oDAlSieGbWRDqproOOoV+xkNSb9w6alLCqlb8t/cg9RaNw/MjV?=
 =?us-ascii?Q?IuEJrjM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3W3SfuTehyLGzLfhK7HdpzcuAQ9+qfFdv2CcUIw0+23afWbHuQkrYsFvbdX?=
 =?us-ascii?Q?gJJ0ItrTS7uZeYMqfaHWzlhXXdk/nDDdGGIkJGCSy7/U1Eku7vyTHPAxxjkS?=
 =?us-ascii?Q?HExtnQlQ1aBAQYTQwa73eJxD091pcym/Rz9CU4dHhULAV2qM1ChRwNykQcOH?=
 =?us-ascii?Q?egi4qMc1lkNlabJ1bJoTrDd9ixiZVs/6QFnUsZ0HtPwGYfvJW0PHwfc9JSHW?=
 =?us-ascii?Q?doJD+H/zYQCBx3VVUVSvDRUvk0Irtgw+y0zWtIa+0yTfO0ilptUb+QIPCIsY?=
 =?us-ascii?Q?3jYHHVPwcDAxWm+5YwZgPsZExvnsRr9I/syHYV8K6ePfbt4vXncj+GPwaWye?=
 =?us-ascii?Q?KjLiDo+5yuQAECMWSULp9XmnIugiIjfCdkvMwRTzW4Gpgh6tgyKTC2Toik8v?=
 =?us-ascii?Q?Scm4+qgJudIHTo6LEhrJb2dlO2NHH5kwv2S2F4mw7hjbqQVHRrC6jcIjRmtf?=
 =?us-ascii?Q?p7prvm+X/6OGIvhwL01NdrKojR1lFxVmEah3XW0NHhII558Z4zVDYYNkPCSh?=
 =?us-ascii?Q?zh+h5qsYi2sP6m/6stBFk0CgY+r2KAWTIJ5C39hL1Z9Rf2gA/BX6ng6I1WZa?=
 =?us-ascii?Q?BXs89s0M+mbbnMU1ntbZVaXwmfhVy4O+PUpuZkhIuCXIGoO5Uf6iMw8A36BA?=
 =?us-ascii?Q?bZn8tHSFHD2E0Xm1VS5wu3nmJQ61QqAAH6b+z2M+J5+kN+Nmqo9S0eiHy38J?=
 =?us-ascii?Q?5Q2ToPVvVlYnlOs96huTGTRrDXx6t5AOsX4kHH1Fc5YQ40WFKh/+shPaqIVl?=
 =?us-ascii?Q?kz+P0sqPYxvL71ioLCegE9X/BS1iL7dijm0mtIgcpb4eAVGgu0EINconHKcU?=
 =?us-ascii?Q?JiK5p07u/gHIwwa5X6InFz6JL6kdMBuCKfDi40YYeziaSVSkZMpMJU7tFmqU?=
 =?us-ascii?Q?ApeXNeqycv9oHTv/LWumqS2TAt/8LR3blU2NvIfXvL1dF/TutBe+oM0rt+vP?=
 =?us-ascii?Q?I8WnC2gQnlc9f+9l1cJe8MDaNFsgnMcv8+jZA6YAFmBbLr2B6Htk3f5nFVsf?=
 =?us-ascii?Q?wwx21enJWMEvuu3ECCIi10Vq9xQFB3P+6nQ9bti2wak8lKJTXSayH0/gSQ1C?=
 =?us-ascii?Q?HCMXME7AkrtjCLCVipgcUC4p6ft0EjE5L7/vlO4cZ8sN9gNZkoUq0whTVKD2?=
 =?us-ascii?Q?9IyV3/m9Rd8+H8sYSCPifJwqHy0e1gWjrJ0heNMexDZxD2n4XU0EsH9ej45s?=
 =?us-ascii?Q?CckN62/BcNOOhgxgXIIy+KGou3pIiIP8LzvyZM7swEce72qEdNEers659jBD?=
 =?us-ascii?Q?QeA7kWCCoY+rIOuFnDO5KLMPqXUP3H17wTwaDpKhw518rr7F+VhxasKyMDDG?=
 =?us-ascii?Q?QSowoKfzphxTWYnDiG0M0XgZrGHmGslU/GDFCNv3AUn3cyXsnixDUfbYx/1b?=
 =?us-ascii?Q?517NIsXeUP2NNxQZp9U/x+9QcXyWD9ALuYR+ON38pVYbbDENGF4/NLBIfJXr?=
 =?us-ascii?Q?dBQuMRoIB4qgkTDed0EQG6cH+SOh8/sl884ESIc0WuMp/cWQRjng7b4hkRQq?=
 =?us-ascii?Q?/n34Gwg4x1in/1Q3dvJgUvzPchPcvpMhXi+ZvdJap8/0qL4VIorNmr6PrlUK?=
 =?us-ascii?Q?WjG5CL5W/dHnMmv8a8cQvNkxD9lPQogdSmHxbUCXjhD7cytObs6vAoJSpVo6?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403605a1-f46b-4215-9dbf-08dcf34a4827
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:05:54.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgBCkdUSXGgLB09kLM7/zhB+7K6Kg1sKSMdTHsqRM6dihUhFwSx9oS9xdpWhf5/RTyt0E+2PWRNiSH+v4jlDiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

This command:

$ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
Error: block dev insert failed: -EBUSY.

fails because user space requests the same block index to be set for
both ingress and egress.

[ side note, I don't think it even failed prior to commit 913b47d3424e
  ("net/sched: Introduce tc block netdev tracking infra"), because this
  is a command from an old set of notes of mine which used to work, but
  alas, I did not scientifically bisect this ]

The problem is not that it fails, but rather, that the second time
around, it fails differently (and irrecoverably):

$ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
Error: dsa_core: Flow block cb is busy.

[ another note: the extack is added by me for illustration purposes.
  the context of the problem is that clsact_init() obtains the same
  &q->ingress_block pointer as &q->egress_block, and since we call
  tcf_block_get_ext() on both of them, "dev" will be added to the
  block->ports xarray twice, thus failing the operation: once through
  the ingress block pointer, and once again through the egress block
  pointer. the problem itself is that when xa_insert() fails, we have
  emitted a FLOW_BLOCK_BIND command through ndo_setup_tc(), but the
  offload never sees a corresponding FLOW_BLOCK_UNBIND. ]

Even correcting the bad user input, we still cannot recover:

$ tc qdisc replace dev swp3 ingress_block 1 egress_block 2 clsact
Error: dsa_core: Flow block cb is busy.

Basically the only way to recover is to reboot the system, or unbind and
rebind the net device driver.

To fix the bug, we need to fill the correct error teardown path which
was missed during code movement, and call tcf_block_offload_unbind()
when xa_insert() fails.

[ last note, fundamentally I blame the label naming convention in
  tcf_block_get_ext() for the bug. The labels should be named after what
  they do, not after the error path that jumps to them. This way, it is
  obviously wrong that two labels pointing to the same code mean
  something is wrong, and checking the code correctness at the goto site
  is also easier ]

Fixes: 94e2557d086a ("net: sched: move block device tracking into tcf_block_get/put_ext()")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 7637f979d689..2a7d856cc334 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1518,6 +1518,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
 	return 0;
 
 err_dev_insert:
+	tcf_block_offload_unbind(block, q, ei);
 err_block_offload_bind:
 	tcf_chain0_head_change_cb_del(block, ei);
 err_chain0_head_change_cb_add:
-- 
2.43.0


