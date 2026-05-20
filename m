Return-Path: <netdev+bounces-289785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CIJDyhaDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:52:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46C58871D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4827C30A3486
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D234D93B;
	Wed, 20 May 2026 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KW8vR1IW"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597F3446AB;
	Wed, 20 May 2026 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259354; cv=fail; b=PDnj55dxrcvvIK60GLKn7JO5qQc6D5YgLEJlh6IfGbgMd/EiMcBaot7qu2q+EaGQTUeGYfj3NzikqB/i0icVyvEvAtHJ/9Oix3cMI2FfnvrGEjzTbsD+L/KeiBC+mQ0o3KSwSpOaeqNDEo5ireIlyfMrItCgGhIuLZ1dfcSSEiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259354; c=relaxed/simple;
	bh=Q1I5WcZnrE0bi1VUWTUmYU6AfSnviwG59Qn+/TLJlAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIGb+O0OH3iW+4w5CeHj5141p/qq9LtbLyv/XE7jZWuF4TBZYXGyBKdPGvQWu4l51ijtpYHfDgqhdM7oZywIXd8SUhHk6RJdPr3iWqJo28qpKmWWQfBjVnll3i6LrSdkrNtCZ0ped+l8GwXEEGRq908CMe8YcDm6GPfwhW+euw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KW8vR1IW; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDU+iNEpiIJqGQ13o6aap7Ue7ZW5F9s4UV9Gjecug8OfRowW+pIhDMfniUs2fWr0V5gB2rlYW2jFd/r/cIgUz3FozbeUxgwvvdjYutjy945vdo9p/2rubXp6Q2uuq++hZInR98FNc3qUUy1fUODffWOpvXj8EByclZvUv4L0cBGQxte+MOVKTMbqGnOskXj81dS03JVsbNGL8GgjmqPWyMyM9ylR+ghVoqjwHX0BWLWFYd24ZI3tGYL5Td50ydpVeBv1vY6AxtA7ESt4pztL7uuHyf01btIbDZcaDoPrLPi+2iIcSk6QQeC+7ftXI2QHx2WMiy0/54nlvs87bUFVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytHGcylKvwYDxF2iTkoyMLEgyOOGA4NIIqw+syDRC4U=;
 b=ieTxRdVrmaFCgPvkpUgL1jBtyPT0puxs5OzTzLDOmTdNiw1blH2TZx1KLpLl0O1+NEEo1R/GmRYY/ZbH71wBnBOe4NsBxRKHd3WnbZ9RyBU35xdj5BVGXJQue2+X0jG9b1ksDGbGh00F5uDTnfRxolkIVdzexr1CmcFEONtrNC7Kkhlg3NwQGjggXEa4ToZZkv8yuJEvrZ/peGoiBPC1TXnednL+idxo4ylNmvHoVgOyFvzuptRZPvURjB+4IvqT/xHZb9LH9Ed02IcdbHhPFkPiadGpcx7Zt0ZiUJGPJNJkczQhIi6oLRE8CLrhb/fFwxwnvdoPIMOY9q63SguwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytHGcylKvwYDxF2iTkoyMLEgyOOGA4NIIqw+syDRC4U=;
 b=KW8vR1IWsqacm6YYNXk11aPywMHgonvlPTAqL/JZyZf+1ALSQMYkazdCVdv9Nq10Kq+VP/l//+SE8AOhEbJEyjPl9w3rXErTbL+dPSMPUNsoNYmIVQDUfMJRMqsw0ZFffmpMjPEz6hp2P6yOiTCpxXGcslfZiDSz6oucliXv19PU0IHb1Lj9l/wUhbtso5pTKtoDMlf/NA5zIDUeVoFMsLiyx7ldEYLxWA4cw54v63IDjKOBSJEvhFBYgfFblQm6/quIuO2pdJDrnosTct3LEUDkJDN5UtGvuwWzFB/Xr+t4gHbiZ35l6L6oTVMJ2DRDlRTo8Wf0mYIS7vMUkcDwiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by DB9PR04MB11659.eurprd04.prod.outlook.com (2603:10a6:10:607::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:42:30 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:42:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v3 net 7/9] net: enetc: fix unbounded loop and interrupt handling in VF-to-PF messaging
Date: Wed, 20 May 2026 14:44:19 +0800
Message-Id: <20260520064421.91569-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
References: <20260520064421.91569-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|DB9PR04MB11659:EE_
X-MS-Office365-Filtering-Correlation-Id: b39e119d-190e-4605-4954-08deb63af6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7KmWY150tvNRoPCt/qi3Rjw/HwARtrdN3m/3mz65JU5U3B2XNPnir1x5r7/agu4bMxhwB+ltWks38yoam64Xc1qJ85CWPARpgOXbTkqBTpd2LiNjtokuvSSPl0Ruq1XqKYb85NiRAs3zwEI+IAabzEMjGjUlxmiJ2SPwozoh3lVxhyHHo7SfexvWa0+m372qu0YQ5JwC+jfzOUBlP/M0I8Nb8okjcwoE4IgY6We+Mei41u9951RXiO2XdwvPEAQiojyeqj7AvbPAoVH4aot8FzD0twy0WKacM5Qi5FqMARvg1qqEK66gHXQF4KY4DUR9zie6SM3X2GTVonfuaweryfBGc3dcOZAxpqC3axHL5t/Eoh1gv4C6uj21r1cI3A99IN3eDfiKTjy5ZJ2/3fdIQ7rjU02UsD2NOl+ejIXMobtacD9gmG/VwzXRkF+b0iouGCdXQb+MMWly/dvxFTJfXCB8mDu1WSwXOCl4sdctfnddS06u9AQZ3179vTXMPK9NctosVZaH4YKNnMz12YDsKMegAVBjLkNbHe5h8Tt63Qvkh//ZXeQaYTNyri6js4gi1iJLzB3O19bi6k6WMCZijlrd/wD71KL9y+mpWwMxKkQTsKi9Z2XrEEENx8VmIH0ALR3cCkkAsBoQ9zfUUSpCDOY0tiaeoJClmEGdbc3tNDCx+IFirGfhICUbumdIy/Io+oWDvA3ARA5rO6bhztmNl/uZOl4iaMfvDylRBtXNBKlhEQvhcqcldYGU8TYra3mU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D89fF9l9thNo1dnbWghdH5WUoNPgwb0zOxeo7mRUZpQo2HKJfBXyhT2WHmX9?=
 =?us-ascii?Q?PjYGAbiH+PIzYtfrUXTXki2fpH34GniKSaxwzMyFcsGAg9bmjd1LCPas/p2A?=
 =?us-ascii?Q?bYGc5e06BBdWwOdgqn2PFyahXP5NSfB5NLUiA5w4qjv+XPRwN1Q7KOvokWnV?=
 =?us-ascii?Q?/BY2tMu/iebN1j2SVpMpwVSvzM4ku3337K0GX40PTE8Z8/E40we8JVBDOnwI?=
 =?us-ascii?Q?x3b7GYjeGZoVMG6WnmODAdMSUdtX6XlsPTbm2vGj/3BoNiqDqEsDZ+ti/zVk?=
 =?us-ascii?Q?O9WNC1V/0ZR/pXZ6LGkVt47QFMYbygK9aEMLdKfoixBSMbl4JXSRJqXO9ot7?=
 =?us-ascii?Q?t8QIemKZMy5i9VgErbK2rOGh3PMbx+ul3yHZV/LLbZQMtcrFOw6gPo0Mlz5D?=
 =?us-ascii?Q?4Pgm+qS3MeRaC+7KahllVnqycSWj3pDQqDPg/zOguSpAsPcxA/JiMEf/6PmE?=
 =?us-ascii?Q?rtRC1AdWx4HIEryWq+Ns2PgcIauYZqNqotEO/bqErNQ/eI1TlPdmE6hpOTOE?=
 =?us-ascii?Q?ovEdTQageVYQzAaFzPHNSQ1OW2g6aeR/Hx94vHIB8Gx94fa+G0yM5lwfPPpk?=
 =?us-ascii?Q?YuyUHTQShUHj8yqpudWhlMiXk1OoXl4+ZP/6RIwu4e2Pqwmjco5D/gRRhGg+?=
 =?us-ascii?Q?+D8wzVMRMtZwA1Iyff9inUBFMQMJ7fRyxuS/aNkfDrnqZxsr1dAxN319lWWF?=
 =?us-ascii?Q?Jd5x+frbj9OaYSS/bO3g5ilkF2PLXVsXahkkecvHRqhUjBL6hFlnE18cs/D0?=
 =?us-ascii?Q?+4sH3h3xQPQ59z/e9ZtK3EF7m8vQc7yzeVPztsV+FWhcNbnrSnoVFKQXd7th?=
 =?us-ascii?Q?1Lc15q0icg1PLw25iQftkEJ4saGOfV+1Pl0UF3CZopD03LsWk4O8+loIxchz?=
 =?us-ascii?Q?FCJuQxfH8WYDeZW1b6eDVTHQ8nXK2rGQjh4rW8YHiugbSERTkNA6ZV8rgeP8?=
 =?us-ascii?Q?NAotPUnI3RBzGHjsL6sIJoU5ku5FU4yZy+uxUqlcQF2+nTycWB7kZI/MiEqR?=
 =?us-ascii?Q?fjTDeXoE9zBb6E6Zl915LIRSKDuoTW2AFTj+zDFDZIVEBgZsa2GDmH/Y8SUi?=
 =?us-ascii?Q?OYBsDL27ZWSeLTrjE/PJsREdkVkoV5HQzkwlOFm7qLVgVjQX8QGLDI03S8iU?=
 =?us-ascii?Q?s9dTMnD7xDsqSB/pscaf+aseoXjip1ggohSgpGYlWc6SOdpw5p9lzyatKkC9?=
 =?us-ascii?Q?70OAmjJTf7VAFSqvjVqXymMBZHJZ7Hg6mS/mWFj7bu3yN8fFVLuNW5dkNIuT?=
 =?us-ascii?Q?7vo0B2DnJCSaTT10NPworZtt9kWC3ADL9Dquuo8bjqnNBXMSScILnbHlfVqU?=
 =?us-ascii?Q?Q4Pa4nj9x+H0V3GLjr0E9PLP4etu2wXMt6f/03BsrzCIFhV6MVWtWmU7ugcD?=
 =?us-ascii?Q?QrH286JrC85uc8/CjsQEO01fvNjQQ8147ZhBM0x4ejA/4SvsK7KzxDsb4LV6?=
 =?us-ascii?Q?9AwQkFSHah12y7IYbEzvdEYCbNT+d1kdWUf3F44B4RiYi0w6JyMNLiuNwkb6?=
 =?us-ascii?Q?mwm/I6tzQ5T9i45/9JEeFzpy5vQt6s5Cd/F6bvcLed+ziw6ai/NWzAGCUwT0?=
 =?us-ascii?Q?zFfTrTjRHPahcy4XcoLPo3SLeK8B+/CHXf+ZKtNATZDTxpcJO3Iv1TKpDCm0?=
 =?us-ascii?Q?Sml/eV2RXvbY0RvyhinME3M/fGeUisvxkmo93+oqSdYO3ST7/V0Qoo6lJ9Zc?=
 =?us-ascii?Q?Zg5WBNa5CnL0iVUx3a52sRBm1Rm3BOWtGg8pJSk+0mzxy64DkydV8tUDREvY?=
 =?us-ascii?Q?a9/Io94zDA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39e119d-190e-4605-4954-08deb63af6b7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:42:29.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGCmI9/aPLEGkTH91AgfSxI9XLgAw5CrahBe6fuILJ3Fe39eOEEi5QrSia3JuBpLiKSkqEJMSsMrZAu9aWDgyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11659
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289785-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: CA46C58871D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The enetc_msg_task() function has several issues that need to be addressed:

1. Unbounded loop causing potential DoS:

enetc_msg_task() processes VF-to-PF mailbox messages in an unbounded
for(;;) loop that keeps polling ENETC_PSIMSGRR until no MR bits are set.
A malicious guest VM can exploit this by continuously sending messages at
a high rate - immediately sending a new message as soon as the PF
acknowledges the previous one. Since the worker thread never yields or
enforces a processing budget, the mr_mask check frequently evaluates to
non-zero, causing the PF to spin indefinitely and starving other tasks.

Fix this by replacing the unbounded loop with a single snapshot read at
task entry. The task processes only the VFs whose MR bits were set at
that point, then re-enables message interrupts before returning. This
bounds work per invocation to at most num_vfs iterations. No messages are
lost because the message interrupt is disabled in enetc_msg_psi_msix()
before scheduling enetc_msg_task(), so any new messages arriving during
processing will trigger a fresh interrupt once re-enabled, scheduling
another task invocation.

2. Write order of ENETC_PSIIDR and ENETC_PSIMSGRR:

Both ENETC_PSIIDR and ENETC_PSIMSGRR contain MR bits indicating messages
have been received from VSIs, but only ENETC_PSIIDR trigger the CPU
interrupt. Previously, ENETC_PSIMSGRR was written before ENETC_PSIIDR.
Writing ENETC_PSIMSGRR returns the message code to the VSI in its upper
16 bits, signaling to the VF that message processing is complete and it
may send the next message. If the VF sends a new message before
ENETC_PSIIDR is written, the subsequent w1c write to ENETC_PSIIDR would
inadvertently clear the MR bit set by the new message, causing the
interrupt to be lost and the new message to go unprocessed.

Therefore, write ENETC_PSIIDR first to clear the interrupt source, then
write ENETC_PSIMSGRR to acknowledge the message to the VSI.

3. Check both ENETC_PSIMSGRR and ENETC_PSIIDR for mr_status:

The write order change above introduces a potential race: if a VF sends
a new message in the window between the ENETC_PSIIDR w1c and the
ENETC_PSIMSGRR w1c, the ENETC_PSIMSGRR MR bit for the new message may
not be set. If mr_status was derived solely from ENETC_PSIMSGRR, this
message would never be detected despite ENETC_PSIIDR retaining its MR
bit, leading to an unacknowledged interrupt storm.

Fix this by computing mr_status as the union of both ENETC_PSIMSGRR and
ENETC_PSIIDR MR bits, ensuring all pending messages are detected
regardless of which register reflects the new message state.

Additionally, rename the per-register MR macros (ENETC_PSI*_MR_MASK,
ENETC_PSI*_MR) to register-agnostic names (ENETC_PSIMR_MASK,
ENETC_PSIMR_BIT) since the MR bit layout is shared across ENETC_PSIMSGRR,
ENETC_PSIIER, and ENETC_PSIIDR. Make the mask macro dynamic based on
the actual number of active VFs rather than hardcoded.

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 15 ++++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 65 +++++++++++--------
 2 files changed, 49 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 662e4fbafb74..e58cc81d199d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -56,11 +56,21 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 }
 
 #define ENETC_PSIMSGRR	0x204
-#define ENETC_PSIMSGRR_MR_MASK	GENMASK(2, 1)
-#define ENETC_PSIMSGRR_MR(n) BIT((n) + 1) /* n = VSI index */
 #define ENETC_PSIVMSGRCVAR0(n)	(0x210 + (n) * 0x8) /* n = VSI index */
 #define ENETC_PSIVMSGRCVAR1(n)	(0x214 + (n) * 0x8)
 
+/* Message received mask, n is the active number of VSIs.
+ * It is available for ENETC_PSIMSGRR, ENETC_PSIIER, and
+ * ENETC_PSIIDR registers.
+ */
+#define ENETC_PSIMR_MASK(n)	\
+	({ typeof(n) _n = (n); (_n) ? GENMASK((_n), 1) : 0; })
+
+/* Message received bit, n is VSI index. It is available for
+ * ENETC_PSIMSGRR, ENETC_PSIIER, and ENETC_PSIIDR registers.
+ */
+#define ENETC_PSIMR_BIT(n)	BIT((n) + 1)
+
 #define ENETC_VSIMSGSR	0x204	/* RO */
 #define ENETC_VSIMSGSR_MB	BIT(0)
 #define ENETC_VSIMSGSR_MS	BIT(1)
@@ -94,7 +104,6 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SICAPR1	0x904
 
 #define ENETC_PSIIER	0xa00
-#define ENETC_PSIIER_MR_MASK	GENMASK(2, 1)
 #define ENETC_PSIIDR	0xa08
 #define ENETC_SITXIDR	0xa18
 #define ENETC_SIRXIDR	0xa28
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index b4d7457097e6..3136e8321e4d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -3,18 +3,25 @@
 
 #include "enetc_pf.h"
 
-static void enetc_msg_disable_mr_int(struct enetc_hw *hw)
+static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
-	u32 psiier = enetc_rd(hw, ENETC_PSIIER);
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 psiier;
+
+	psiier = enetc_rd(hw, ENETC_PSIIER) & ~ENETC_PSIMR_MASK(pf->num_vfs);
+
 	/* disable MR int source(s) */
-	enetc_wr(hw, ENETC_PSIIER, psiier & ~ENETC_PSIIER_MR_MASK);
+	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
 
-static void enetc_msg_enable_mr_int(struct enetc_hw *hw)
+static void enetc_msg_enable_mr_int(struct enetc_pf *pf)
 {
-	u32 psiier = enetc_rd(hw, ENETC_PSIIER);
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 psiier;
 
-	enetc_wr(hw, ENETC_PSIIER, psiier | ENETC_PSIIER_MR_MASK);
+	psiier = enetc_rd(hw, ENETC_PSIIER) | ENETC_PSIMR_MASK(pf->num_vfs);
+
+	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
 
 static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
@@ -22,7 +29,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_si *si = (struct enetc_si *)data;
 	struct enetc_pf *pf = enetc_si_priv(si);
 
-	enetc_msg_disable_mr_int(&si->hw);
+	enetc_msg_disable_mr_int(pf);
 	schedule_work(&pf->msg_task);
 
 	return IRQ_HANDLED;
@@ -31,33 +38,35 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_pf *pf = container_of(work, struct enetc_pf, msg_task);
+	u32 mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
-	unsigned long mr_mask;
+	u32 mr_status;
 	int i;
 
-	for (;;) {
-		mr_mask = enetc_rd(hw, ENETC_PSIMSGRR) & ENETC_PSIMSGRR_MR_MASK;
-		if (!mr_mask) {
-			/* re-arm MR interrupts, w1c the IDR reg */
-			enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIIER_MR_MASK);
-			enetc_msg_enable_mr_int(hw);
-			return;
-		}
+	mr_status = (enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask) |
+		    (enetc_rd(hw, ENETC_PSIIDR) & mr_mask);
+	if (!mr_status)
+		goto out;
+
+	for (i = 0; i < pf->num_vfs; i++) {
+		u32 psimsgrr;
+		u16 msg_code;
 
-		for (i = 0; i < pf->num_vfs; i++) {
-			u32 psimsgrr;
-			u16 msg_code;
+		if (!(ENETC_PSIMR_BIT(i) & mr_status))
+			continue;
 
-			if (!(ENETC_PSIMSGRR_MR(i) & mr_mask))
-				continue;
+		enetc_msg_handle_rxmsg(pf, i, &msg_code);
 
-			enetc_msg_handle_rxmsg(pf, i, &msg_code);
+		/* w1c to clear the corresponding VF MR bit */
+		enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(i));
 
-			psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
-			psimsgrr |= ENETC_PSIMSGRR_MR(i); /* w1c */
-			enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
-		}
+		psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
+		psimsgrr |= ENETC_PSIMR_BIT(i); /* w1c */
+		enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
 	}
+
+out:
+	enetc_msg_enable_mr_int(pf);
 }
 
 /* Init */
@@ -133,7 +142,7 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
 	}
 
 	/* enable MR interrupts */
-	enetc_msg_enable_mr_int(&si->hw);
+	enetc_msg_enable_mr_int(pf);
 
 	return 0;
 
@@ -154,7 +163,7 @@ void enetc_msg_psi_free(struct enetc_pf *pf)
 	cancel_work_sync(&pf->msg_task);
 
 	/* disable MR interrupts */
-	enetc_msg_disable_mr_int(&si->hw);
+	enetc_msg_disable_mr_int(pf);
 
 	for (i = 0; i < pf->num_vfs; i++)
 		enetc_msg_free_mbx(si, i);
-- 
2.34.1


