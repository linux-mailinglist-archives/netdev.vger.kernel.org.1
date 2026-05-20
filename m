Return-Path: <netdev+bounces-289777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN+uI/JYDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:47:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E9588556
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5242D301111C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF73382DE;
	Wed, 20 May 2026 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="idFIZIcs"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1BF326D51;
	Wed, 20 May 2026 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259318; cv=fail; b=k9XPa3KuosmpkP7Ceuuhp5iL/wIzn+SqpheIeJ3Cl4jxuHtOCJx2MO9UbRuckLsUxqnOb2eE3pBJQUd9vVYOsLR5gCRnveRzLxENQ57TJ/9ABuQF1Fkl7tOlmdIi6PUUjX6bHuyKY62WJtcsCP7LJx2OPjRs2A1v1j7xSsP1u9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259318; c=relaxed/simple;
	bh=+2b88hBPuIWR3UKqa2MVKjOTfuacTYdnCUZdVMlrC0I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IAP7KcYO0cn1d9nAFCpdKCQxcc9jCjf/r3i8PoxC3QEE+2Kv4ckF0XJSwSRIZALU5umV6282laLUuLaepcZpmenJZbnSCu08yFTH2N2PWiVCI7mdI4jCTkg33QFQZuRq13abmfiFh3xTKxNk8vnS9L9jNKCtJkZTUx4km/McGQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=idFIZIcs; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPXvJtr1mPEWjxfkQhfqt1tZi45Expl2GI9idK1y9smu+ThsK4VFzFBVKGbdoW6sWPlnQnyIExgW8YDHjk0XlI/uPtW2h3UTSLSudsau+d8MseN9fs9KMZe9HSL/DK4qEUdp8l753ZWTbGeX9w6wyZuBp5CLyZt6+nIvEIv4VscSRSgR6F1T8MkvpUx5nKI+lzIfAMXLKmbj9X7z58796aBktXaRmhHuwzwm25ubGR8GvO1OfIr4wGz4oulf1EG+4BtuhBtdXzFYloidWpQCZ9AA0N9k40yMlyCxBwjBveNVY17m/R0sdR0TqhQxiZJLIR6mDfz53FEPsXh+VKv0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOvuVohbOTv6Ieauy0sxw4Ii4SlKxHG3ngGK9cPabQc=;
 b=IoTF7iThYnllrd+2UQW4yuFaF22agkpth2EzBwEORyLO8zBDkPvS8CLjWCocJ0M1/4NB6Ps/r8GouLriGgqgD8VzaPrZQ0MaBgnDEvbnUVf81Y0e6gJ6dg4bxyj07Vn/dNQNrfcwahMwnEomC/HENrj3r1pSN4RM4EYRDx48qF7l2Jmka3RatQLFxXKVU7hnW4ZSkyygB60S8IieQDCfEncHomvenM3n4qI5Q+TjTCr1F15Zd+1fWoX4B2to+vKnKyioY6i88rG7TOgCptNsUGxJ7k4rDma4TDnnkz5XRoblPo5xiEiZnQSWhL7Op5h1TC1hI4WyjH3VH/CltYmm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOvuVohbOTv6Ieauy0sxw4Ii4SlKxHG3ngGK9cPabQc=;
 b=idFIZIcsJrScEHcrFGMA4cRSZ6/zFLfKamTwS69iPvJhZOKskxHx0Kh8Lpa8qcO2q0twffOYz+GjfLCakwhvNytNT3SHoDdfdvdTpT+wbL89Lmzkyqax2Jq7srsFz50JV3oRus3MU8MNQ/kU1dizaZnubRKrGhzkZVV86zom0w00BVkPUOpksvM45vbaA5reDgKDghmFxJIB1yxLpnYTzS1xu60GvuoGLC7Ua/sBUgEF7BItjVoaMo1r+/nYq1UQ5NB88hfnu6V3s+gaSFsHPpHpF2tBt5g7BJwHnxCQSdelARpkjeByKNuG8HOM+NjSmH80O3J1EJYhIV+yuuRR4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:41:53 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:41:53 +0000
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
Subject: [PATCH v3 net 0/9] net: enetc: SR-IOV robustness and security fixes
Date: Wed, 20 May 2026 14:44:12 +0800
Message-Id: <20260520064421.91569-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f068b03-7aba-4dfb-059f-08deb63ae0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	U5k/q4TPVU1ezAsAhf9sxn6RVrbudYk1IfBU0VjxuYbBzXdpc8BkewEBS1BiUJylrs/Sp+BWl9592k65vdj5f/DrFLTUOzaFhF/lT5H1tXg3wWXp5qMHi65Uq+b4sQ6BWH8Mqw8/3VzTStguFBtq5PG/L+zYbjuMA5dXaXjqrYZRhYC/Wck7lBafTHcfiZpwnquJK52v7tNIBw8mbcc9t7Cp65OTusZDl/ZcaR6mYMQmUkoDlAtd+0hondQ9DG97TmEWh79uAYnydTa2YmE79ilIkX8+mXef03V/O7peOLDh9D8c3nj+uesUrgyUeMkeH68pgTkoL2fh4UWOOBcghLsEibcqTR6sgWRxO3yEdhXw9b8STfwzXgiZY/FkTrbYkytqCtwoP4pQ0E2vmqR9Q2IcQsGzK2i79V/68fciH0fiRs1cUj1+H2uu0trodUw83Pd+nhdAtamdap2eLjG36tDiwbA+7ZtCoCZdnBwcgRlhvSjs+U4ywENyiTxEykO4jbeAJ2RWyh2YP0aleuCpPwOCYW0MCaL9QRAAkH0CmDO1Uv6Cqeo+RUpNI1aRGUMu9d7mvbOXXmVYbuzzVcFtTpxFNEgpHI/G+0mHlwoZnPbuNI9qT5jF9tuAe23cc4juGzK1BllYdeNcLbgAV+QF4pbU4izgyxvB49f0z9yhE1VyTIQBRCFyDN+BjGq5PI6adxGoRSRz3S/KO8TWbw0xrLUT0BYzuK37DeR9FRRBY+m6FPOoBytGyWxy2gJJ2sPT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?muJv0sMMEvjQBBXjTzb4k4EO0pcFYG+bl6ch7zOHPusxuuFa4IdSKJC8egOd?=
 =?us-ascii?Q?UKHpuINcaWSNeA40AYA88z+djScHd/k3Qlf2zeQEv6Jrs3InScmdXpfiU68T?=
 =?us-ascii?Q?Ip/2ahtSQ7yaWCbiSCin4ToXCD0j9741XjeRMnkTGCATuoL+CTTTtrTdE27e?=
 =?us-ascii?Q?tlK6ljgT3CQIy0pX/1O5/fedSKyvowMYXbDi79I8PyxZupADMCWcPYlDi0/m?=
 =?us-ascii?Q?j4gLt1uGXyxh62LhNU9zaLS0VyxosI1dJsShSdPKoLQYxDAmO8oOoLuS5c6+?=
 =?us-ascii?Q?cihvsJhzjCW558EcBxVCpxVeWw5uSK0t7GYm06Az6X0C3wsSU9R47Y0VKrt9?=
 =?us-ascii?Q?HX2BQrh8YCg5snFniwP9f5qCo5UG/d/uuYuHA51ShcxSFeVY8LrFvJjRQTuF?=
 =?us-ascii?Q?l+nTQHgyFs70St9TzBHq4q462wx6O/am5Roz/c+3Lihz00dwJQcYrJdkL1nz?=
 =?us-ascii?Q?5VM8CTVrpkxm7wGcudJkMcH1Go2glmyr5bACYV3zEGe8WZKlpIDMsMzwsCPC?=
 =?us-ascii?Q?CtDw5zqKI/2EqxG9oYk/2HQkBz301XVmmxgfHIMGscFCoU6N8p5IN5A6ZGoj?=
 =?us-ascii?Q?UCzQHydZK1MEYhmqM/cyo0ZRW5TW2EJc8lSj4mqa97GEdkEhhTG6lwvV7BR8?=
 =?us-ascii?Q?z1Gv0LUpVHZXlgkzATwyhLpD8BW9Ieqa5ZxCzlAMnwMFOhJmDSZ/neBSJ/O0?=
 =?us-ascii?Q?G+BAvlRtP5SyOweS9PCPjbzCikhu3VcOwrsQqu+5tAFYjitZwUP8H0Dgzw85?=
 =?us-ascii?Q?PSkKG3widJ8D3fpTeZGPA7TqaxlWU6d2Fxy0Cfk2tr8hVKcQIOic8mrv6pY6?=
 =?us-ascii?Q?PJCN8fhHd+7iP0qxW6mJ20VL2wMvrp3/BFacK+F453OITTQo7b92ssYk/rTa?=
 =?us-ascii?Q?0qF8v1IwfIMG9oygmGnjYfN/2I0USSNGP0LtVFkIc4/ZiYndvkdLaMW0fDdA?=
 =?us-ascii?Q?+na9G3n4xEOEnfw55ju/9Ev8BXF79nNXtWNZ0j+4IQxC7YpZSAdhZp6CLyCh?=
 =?us-ascii?Q?QVCAjbjm1T6b03Iw80eRJSgZK7eorENVo4htbkHZXFZU6cR9r3u4DeeX+2mS?=
 =?us-ascii?Q?onqtoUqDRrSCqHE3ms9M4nifmuhf2NMNZthd6or816d6pupF3wdJE658ZAXO?=
 =?us-ascii?Q?BNK06OXeESouRWuizooFuT+x8Z4bWQzKJJl5lvjMddQNuMKSCOpwJgpHusYl?=
 =?us-ascii?Q?kq8pkbT4yaTnwe8vHXQTmFLB5WalRHfEHfOA5jgWQ5tJTHhUb17QJG7fvv8c?=
 =?us-ascii?Q?oxpS2m6Gr7n0S8jDcwAsODsoOpW2WGiQ2M5Tr+JX32RVDh8t9yF3Ye4TTtdB?=
 =?us-ascii?Q?DS3x5KVBZJ4uNfwaCTgGanFyGIrEceoAK4gNKlzdIgsDLjL387CQAomtjZOM?=
 =?us-ascii?Q?UGKVvNCsQwg8zA8szVU01xwx4KiWStX3rHvieGFxZ1qycyVgF0fhZFB365dK?=
 =?us-ascii?Q?99VkU8Hzj18EHZ3boP8aJ1UE8kJ/H4B05jw3sOVp3mBZtRGWGx68c95d0O0P?=
 =?us-ascii?Q?v+/CzCQXp2u0pROf+mTFLIjBnw81dbrND0uRteaKS68iYXaKbXRvIYd2TNyM?=
 =?us-ascii?Q?w/S+tcvddJWDFT+UXtQuULIJfkJqU1bY/7fhVtbuzKvqaEbtKv5lPcmRmGRI?=
 =?us-ascii?Q?u5et1dDz6VMauZfeYysA4vtqkHgNl96s6KrLS9TqMzN9SV37GN6bN3LoXqyJ?=
 =?us-ascii?Q?wIcj55s2xBx+9RK8qLfewSIZVGm2gVhgw3a/T6lvgFbALzbe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f068b03-7aba-4dfb-059f-08deb63ae0a2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:41:53.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ny9uROYu8KtymeZdbdcRJ9cyxLhsUGQjY4AuV/3jGEh7TtKUzMJUbj5d4JoKGdw8cRoyUy1S5TTJAOIx5O3Jlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289777-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: 053E9588556
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series addresses a number of robustness, security, and
correctness issues in the ENETC driver's SR-IOV subsystem, focusing
primarily on the VF-to-PF mailbox communication path.

The series can be grouped into the following categories:

1. DoS and security fixes:
   - Prevent an unbounded loop DoS in the VF-to-PF message handler,
     which could be triggered by a malicious or misbehaving VF.
   - Fix a TOCTOU (Time-of-Check-Time-of-Use) race and add proper
     validation of VF MAC addresses to prevent spoofing or invalid
     configuration from being applied.

2. Race condition fixes:
   - Fix a race condition in VF MAC address configuration that could
     lead to inconsistent state between the VF request and PF
     application.
   - Fix a race condition during SR-IOV teardown that could cause
     VF->PF mailbox operations to time out, resulting in unnecessary
     errors during shutdown.

3. Memory safety fixes:
   - Fix a DMA write to freed memory in enetc_msg_free_mbx(), which
     could cause silent memory corruption or system instability.

4. Error handling and initialization fixes:
   - Fix missing error code propagation when pf->vf_state allocation
     fails, ensuring callers receive a proper errno instead of
     succeeding silently.
   - Fix incorrect mailbox message status values returned to VFs,
     which could cause VFs to misinterpret PF responses.
   - Fix initialization order to prevent the use of uninitialized
     resources during driver probe, which could cause undefined
     behavior on certain configurations.

5. Diagnostics improvement:
   - Add rate limiting to VF mailbox error messages to prevent log
     flooding in the presence of a misbehaving VF.

These fixes improve the overall stability and security of the ENETC
SR-IOV implementation, particularly in multi-tenant environments where
VFs may be assigned to untrusted guests.

---
v3:
1. Improve the implementation of patch 7, such as add new macros
   ENETC_PSIMR_MASK and ENETC_PSIMR_BIT, ENETC_PSIIER is enabled based
   on the number of active VSIs, mr_status is derived from ENETC_PSIIDR
   and ENETC_PSIMSGRR and so on. Also update the subject and commit
   message.
2. Update the commit message of patch 8, add description of the change
   in enetc_msg_psi_free().
3. Collect the Reviewed-by tags.
v2 link: https://lore.kernel.org/imx/20260518030535.1057228-1-wei.fang@nxp.com/
v2:
1. Copy the message content from DMA memory to local memory
2. Patch 3 and 5 in v1 are merged into patch 8 in v2
3. Add more fix patches, such as patch 1, 2, 6 and 7
v1 link: https://lore.kernel.org/imx/20260513103021.2190593-1-wei.fang@nxp.com/
---

Wei Fang (9):
  net: enetc: fix incorrect mailbox message status returned to VFs
  net: enetc: fix missing error code when pf->vf_state allocation fails
  net: enetc: add ratelimiting to VF mailbox error messages
  net: enetc: fix TOCTOU race and validate VF MAC address
  net: enetc: fix race condition in VF MAC address configuration
  net: enetc: fix DMA write to freed memory in enetc_msg_free_mbx()
  net: enetc: fix unbounded loop and interrupt handling in VF-to-PF
    messaging
  net: enetc: fix init and teardown order to prevent use of unsafe
    resources
  net: enetc: avoid VF->PF mailbox timeout during SR-IOV teardown

 .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 ++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 106 ++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  75 +++++++++----
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   1 +
 4 files changed, 127 insertions(+), 70 deletions(-)

-- 
2.34.1


