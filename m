Return-Path: <netdev+bounces-277976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB2WDveh3GkEUgkAu9opvQ
	(envelope-from <netdev+bounces-277976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:57:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889323E89DB
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE6D3300574A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0CF399372;
	Mon, 13 Apr 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h6YBNbFm"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0AD396B69;
	Mon, 13 Apr 2026 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066664; cv=fail; b=TRR//dOQ+bPXhITgvofnNDNj1u6gWVw1PX15KzsliGQ4lSpYdWf9b/xfVl5x7iWP3Ad+U14R6HrgxIU26QjG0Jw+OYVB8zoUt4mKmAdZm8fG6Un2WQTEu9QgXKbsa+aOtLpjSIfnPddxRoCkh2CLe1ZK7rewicyj4Rk0eh6dyHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066664; c=relaxed/simple;
	bh=K/XfH6aC7BXGf6w7TL/IOyFRmRDEuPs8cYdDhJiWmaY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TZcSyJkqWSHf6MYP0xljdjz5MWZAE677OQxhromRtZivtITYW/Fa75yufHcH8b/005AKVbJEUUvzutsgyFx499vVdR3ldHBD36mNPfkxPcv7QclrKk3EvR+07SpVqMr2I9mdtAMA8ur52IC8A2wi8Akug+S3gQzIdzaOFYeI58g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h6YBNbFm; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyHfM0yAD0CWk8uiSSjnGpBWQ8om/NvC2PG35hX0Z0jujr391exTeZKA/zowByXKlmX5h2DuaFOLMQ3WBvB40qc/kxmbCmU8jdnQXtdvB8z0q11p+NbxI1xCCbC/qcQFIDBs5fmaUB00Ydkm98ILDnFZRYbATF+x9stTQKqUnbb6/o+DXXxQZnA1vWLReT8B7iFsOy2YSGUDOqYlEPK+BRb08euXXInfm5zij4B8ISpfZmdAb07yS2UXvGXjWfRQQVSd0NT1aceOrxKvqYNdbyD0rgai75ECwPBLXQsnAwY5PXDYb+YSL8UyGNMT518yx/99nc6HEAYKOFGU571jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do0AuH3dtvno41xfy3ln5li3TMODmlQ8+vENfvP3kfA=;
 b=wJBXp0D4CLFWmik2j9mMBUOSSJqy0EzGnO6ut3KbgjevdpaIKpw2L4ogLpveqM/N4tyjPtjslYDTuMfHuJKc241MKGcQu+nHFtuR5JykKfTMYszj5k3AkAWQ/Ey/FZOjiuZSyhKIzSiM+GWCTM1sg/HLRk0p3UiKkx1JRHuVzBtqIU8wR6BbybFdbNP2KDPURxTf6DQggxhHm3kt94QCc6mRfa0vUjmM9ojj/mdW10SOW0zoNtlufN0NfGtWpo+ehzB7QfP3XHLQoAo2sGoc7ylOIxMtpcwbNt2cPUYigFK649S+r0T5iNTd15+vO3CvIXac3CWb+2cTB1oTXN8ihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do0AuH3dtvno41xfy3ln5li3TMODmlQ8+vENfvP3kfA=;
 b=h6YBNbFmFbQukAwOS98NvZLeKU24Km5wm1Q0eZPOelqkxTS6y84RDOSxR66IhM1c9fz7LSrhZMP2jZyEYa6E+6mq3S9MkCOlZjKJ5QsrTul3Hh4nPRv6zOmu4ASt2MhPlQ1sKGY+zEXlWmHgUJTuw/s1goHl2vvH+0NbplGBW048UCyczylWq6NmdwNp5/6y/SmplwIw+751OV4B5l9sB1pkA+ZfD4UkB5x4kzNp1tX7VdVQNQtVshWzHjP1UtjZBUSzJJGqUofb4ajmonGIl01iw8usSMCzgQ2v3CLK3fgqXrf5hfAyF1pm5is99q25mcL/gBMWEB9N+5xDRbNlUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DBAPR04MB7463.eurprd04.prod.outlook.com (2603:10a6:10:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 13 Apr
 2026 07:50:57 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 07:50:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net 0/2] net: enetc: fix command BD ring issues
Date: Mon, 13 Apr 2026 15:52:48 +0800
Message-Id: <20260413075250.281653-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0236.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::10) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DBAPR04MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: df75c7d6-9c74-4d7a-9227-08de99316480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m/941PBn9R+mWkB6kVGIsWEvh1oH3ARmMcLfMyCH6+BhkciPjs59uODT63YsgrH05cPbuEcuuvN4iHRsiACmh8Z782qjB8wQB0kbF+CfYGpgvFnGWUsixys5t7LEZ2jofX7RJGDxQWmjEDvr6h1ps/jJWSF/+cJQszcSdnUGA7mGn61JNpPA9AuTAiUCHN2uyEho8j/KfLC1768V0d1iiTqTv03Y2j70DHkvLjxSjcnMTzh/HnqX8fR2lzvgldgWDzdbneE2GANYWym+8cmG45q7l8XHUqYex79KiBZbdAHfITC0z910JMQjsES4EcfTLt6355FckqPTE/P3vEQdaT8/LCWcwUxga96sZmlllOZX4aWildOQ6HTpJICb976paXRM+JCfWigSF4obXWSRW9SeATdDc1enRO5UVxZpWy6hLLzEMjH5OgsHwvNiiTBc5djIx6ivQmv31ZXOliBTTYF36zvlQUrr5dO+RsqoTgR42MkXKSPlA/aTyuoJoS7pNA/RAFihkdbHHK15sTYjTYiVHK55Qar8lnaM+mwXFa66CR6EO5JjoC9CXDHcxSP/3CSanEzYC8vnUHyrJXy+kllq8PZSkJ0j4/jZ6ycAEibQjvIdbJ4ZEkJ4Bv5/2PW02sCf0e9lCUeXyqJTSYNLQmxxEx8oUCoRJqrAibMhkSm6vqsQMi0DhseqP9UvlKuxatp+j2lYCmM1esSHf3haaQ9ZtepQiyBZu3iwyw5zHON0LuL2NOeL/3LRIbia3TnMHcukVXkxqpbF2ZTCDkvUYBh3CSXorTyf5j/bV7k4TEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8w3nTpunoS7HTeyFiLtgnUHWCXvNvHuxpklZC9sLuF7kpELd2AUwuPanirte?=
 =?us-ascii?Q?PwE1djZxXw5/WVaU8UZ2BRqUMYnKXydogOlgnCWXVqNUNLCpixA0wk7EEbos?=
 =?us-ascii?Q?hQa04VMfSC71Qy8pRDelq6CSms9MkhLSH93P3pdRHxvSENFaGDg8RFZvtV+f?=
 =?us-ascii?Q?+i8LSmHe5uFknhuUQWCVs2475ji18w0OqZhRjsJJ5vtmz4AkqB9fsAOHzcBY?=
 =?us-ascii?Q?bCXL/t3Xucej7Ofp+2rCsWBnuP86+EDHp3D+ZUFuymBfexdoE3oFIDYw7IHl?=
 =?us-ascii?Q?LOTiif/+LS6GWa4qoG+K2919pmHmWtUus1KYJVLq8ToMudTDrcKNzX9KFJvF?=
 =?us-ascii?Q?lgBQI217deNvWqsDY67fM6BrJ+KM6DA9aXlYC/oE3iNoSOf535lFgtebqQQg?=
 =?us-ascii?Q?oxj7V45yirKSLV+E0cxItN/mGNaOgFQCDMFqQznh8slK+r8CtMzCc+kWbY2H?=
 =?us-ascii?Q?13Xvmea1us6YY/akIkKZO+NCqwngrDe8AW4BTmDtBJllIYhjdj+UeCOT09Bb?=
 =?us-ascii?Q?cw9PDemaeXqV5u9SDUStXtb99OHKZf5/W3FXHcHKRGwM+orSjwAALoyJPu0E?=
 =?us-ascii?Q?yb9xLNKCdmpPcF7oFq5Ky1dGPMZMR2cKBdcvbK61K5gDdEpvfd5LUD/q07pV?=
 =?us-ascii?Q?42d/Kh7JXYA15y5q2yTuKZ95m1sOppHSOosMA4HdYqUt7NYtUcBB77XjVCWP?=
 =?us-ascii?Q?0YtOMPvkYowQpv08mF4CcFyRvOvo9E9D6QqEeGwzdvAT09FBvSvkOHQE6xBE?=
 =?us-ascii?Q?TR6BfI6G0wmArDait06e7H7DA0agfYriFQssaET6QEztMZ3T3McLk2ZVB3Em?=
 =?us-ascii?Q?7nH1kaFmVVNc1qM3/fK2WMYdk2xEO8CzByrh18tcIQZ4pv0TJjX1XPFyBb4z?=
 =?us-ascii?Q?J4H0MRK6Ozn825UQhck+ze/3MZyXMBOzZRccrXOBv8WEplsAG6pjgZ97QJ05?=
 =?us-ascii?Q?45wLC407l2i+VtuHRDljkqb2HknSZxr1VG9i+5kYXvzjZ5uXNpDGX8GwBDSa?=
 =?us-ascii?Q?UMElxclTOjLJiB25oAMfQqaHeuNO89lRJs8McHY4f0Xwl0gSOd2uKJ0vBvOH?=
 =?us-ascii?Q?meqCSQWfnyHgip1GX5VwpBvxrRePfBl9FzCvVGspQAHqWMxMOVnrE3gkVNht?=
 =?us-ascii?Q?Ovholib+lmqBx7vv3vsCEYZsHH4quHheWBfmHOVSfz28eNuMchXH7IBEEJnn?=
 =?us-ascii?Q?CCgDJlixzHWSB1ptZGQcgxYBtZzh8kRTI7Omb7Zrz3I60VrqGccevEg/k4Z7?=
 =?us-ascii?Q?gPX5j+Cz23voS+3b7TpPk03l5ng8rRTRFlhV/rIajlH9LJulVGK/1PEde08b?=
 =?us-ascii?Q?T9Wb7G3GACktQG0Tg4lMv74SpLpbNyWF0qt6XmhEHk1KRR8hz25PfURjARR8?=
 =?us-ascii?Q?dDVkyRK7eZpbTLmZfFZYKNYrIFWWlJ5kJWUDFhlpmU9MZq7YWPvJusX+ZpJ5?=
 =?us-ascii?Q?3P/56RCKIKQZA/KsUQI/q4NDKVjveND85gFIR1iRNcmjbsqSuEW6wdMUMcfc?=
 =?us-ascii?Q?3KVHYrkHu3jvjVxQvPts4necJG/PbqloeXFN9RLAKDzBAAmN4VKkphjhA/yu?=
 =?us-ascii?Q?y7tJe0iJ8AZDRWHDT/m+FzlttvnNFkVtn2midQzcxWRSpK0Y0W5XvBOZmS6E?=
 =?us-ascii?Q?ZEUjbAvYemj7kg1xP7w2eh2it3zfCW4F9p7CtkeBvx+VWG8W8DjRISk2bEFc?=
 =?us-ascii?Q?8Sjt7VtOAQF/MWOpLVfZsFLaIRapfxXlscpb9jqw+eR/+GOg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df75c7d6-9c74-4d7a-9227-08de99316480
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:50:55.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZdO0/TsskMJmCiB9UPb85cUPiwQyY1YgV2Euy9agGz1e+ocKgvCLz1OqhxYbZKG1iSACito1YAKXUPsAQmt6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7463
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
	TAGGED_FROM(0.00)[bounces-277976-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 889323E89DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the implementation of command BD ring has two issues, one is
that the driver may obtain wrong consumer index of the ring, because the
driver does not mask out the SBE bit of the CIR value, so a wrong index
will be obtained when a SBE error ouccrs. The other one is that the DMA
buffer may be used after free. If netc_xmit_ntmp_cmd() times out and
returns an error, the pending command is not explicitly aborted, while
ntmp_free_data_mem() unconditionally frees the DMA buffer. If the buffer
has already been reallocated elsewhere, this may lead to silent memory
corruption. Because the hardware eventually processes the pending command
and perform a DMA write of the response to the physical address of the
freed buffer. So this patch set is to fix these two issues.

Wei Fang (2):
  net: enetc: correct the command BD ring consumer index
  net: enetc: fix NTMP DMA use-after-free issue

 drivers/net/ethernet/freescale/enetc/ntmp.c   | 161 ++++++++++--------
 .../ethernet/freescale/enetc/ntmp_private.h   |   9 +-
 include/linux/fsl/ntmp.h                      |   9 +-
 3 files changed, 96 insertions(+), 83 deletions(-)

-- 
2.34.1


