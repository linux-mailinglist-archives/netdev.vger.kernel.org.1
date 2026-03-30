Return-Path: <netdev+bounces-273256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBjYDkiaymmg+QUAu9opvQ
	(envelope-from <netdev+bounces-273256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:44:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B17735E17D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37BCF3051043
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEA371D0C;
	Mon, 30 Mar 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AzaADlpX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA304371896;
	Mon, 30 Mar 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884660; cv=fail; b=mrjIobCmRdohv6q3PQzJri8BY4sgiWNNk6YyMAk4dhUwQXLKZ/ni/SamrU3PluE2LcSHFDf0uvuNN8o5+NracaBsIZa3ekMQV2hGUwDNDxkb+NETIoUoyTiEQKj9pdg14by+rggTIXSRhlPm1sHk/AfWMu6F4z9oftQS+Ox0Nd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884660; c=relaxed/simple;
	bh=dpq6Kh8S0mv5H6JFaPIDPgOLdiI2iPgNDF8Sf8FQOb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J30m4MMdJitD8fusWYN8tTEKtdoEY5c1EYa4r/mgYi1uX8zPhCoK73Q0IrAcIS1PfOmhbydQoSpdqiZqKtt4yuXww7lm5xjV6PvM6h0s0uP0+9CGgYtsEiu37eVWUAP/9ge7cQU1T+8EtWCLu6q7YSJoSDnUQe8VxETQXxfz9so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AzaADlpX; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuP985bAZFKQ+0oaJxYaion4xTmhokLM8JPaX6/ZLhwTNpYnShR+j4znRvkDvhYZzQ9i4FKVYYt+dvFk+8NqBhdc9b40Qb8qkBHgX2zIvth34s0EE971G6qqpmpp5algAlNbiQQk5pLEJc199VJhICrP2U5A89P+jOSQ6DZLOPLjOu7+dYyovL/R6pSa7LNDi7ZPgDJ9/rSTA0o4JlmeeGbyzD2mLr6+7JC2knrYxS7KXrNgylWuTSGHfmZjOG739fv86K+SCivduxIEJDSpAKS0DaDuXiPC6Y0ZYysjHuok3q2CVn+1RdyhgKTwhwhlm3nlmRHZ1kcu0rPJJhLDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOkJ1OUCnJ9p3wRhlrh3+3UW+GOVlc8PEY7/k3Y2/8g=;
 b=j+K4Hi4aU61rH/NaZYrFKf36dYv3g3TIZxRZ/rNcIztaMvc+OcmtSp02w1yHGUoZfxOnuITTdrl3H4RGZjtKs3BnLCsnrtbbPh44fAo1sk6y/11F93Rt2U4aQipWMqcVAzrE6RtWqpjQgegfdN2pRqiK7exm7rKIuZwyuDSyPqu06lzn3Tl4KLd2AOxVi9rLGUNYmMUEqc8zXywwDuij6zdpKvvthbPcSF6u4/3BLpByF7vGfR93If67A7PvsXskYrEL5iVKhgGo+zT/s4wKJFFQGjhzj9mQybFDpY6EG16Z+NO9zD3OmlD3/dYUqVyJ/cTRSd7UnnPxtTLTfGg0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOkJ1OUCnJ9p3wRhlrh3+3UW+GOVlc8PEY7/k3Y2/8g=;
 b=AzaADlpXrIkeWYFDGd7FXHonJZZiZDWhEr+a5Y372+hv1YmhQ1lfc+FZD7tXotBx6ZFOJlohE3h/MrkVi3MxYEihwDbMJDK6zNzQdcNzEy0PO9yk3ZNuUQkSEYj4q0AEYqQxblTDH3NMgcNCcdfAORphISRLi/dCA3bjwh5obpoy954taPpseaO/UcVLvEb4L2CVBt14wtTlD2J922sbx85+hiMM+f5d2PRoCd4OHg8ME+XbJoolquEvj/DJE1huCta2csL8BI+2V/OWA5Jw8W/0R91pY37O4H0CeiJPpYZ+vVTFtcOeVjaKlLeHEaracLFWik0nbPqxbNWQOsPouw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:30:55 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:30:55 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v5 9/9] selftests: drivers: hw: add test for the ethtool standard counters
Date: Mon, 30 Mar 2026 18:29:33 +0300
Message-Id: <20260330152933.2195885-10-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::15) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 330f7c97-71e2-462b-4819-08de8e71557e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VPmza1gZSi5F6XO94eurxBE6WBd3ASejzZTYS4Bj7HQhPTgJyr/ZXPvbnH7kX7d6TcrK+Qxg7dgdeJQRYGdv3hzY/W3wL0Jy8G7+12tUXi4NSLMKH8bKYEQlkx6auUpnF4zqf3GDlDggF0aVVQis1+CpSiwi2yopGcxssCQmvNLTFIMbBHqkKbTuNeDn52GQ0OG9ZVgy+2Bvih2V2u+X/Vf8FVEEqNT007sC3pFM9dBBznCQyeBlt0DGeQhsct8TdaegyYbEJS3S3OfFjIwSeLHe+nNVsBQfhbe2yOTIszy8SY0VdSisgLX1izMctRISqldweq71mhhPdovdySTndt/WMTmLOy3gA5DGwUPv79ordZFvH2d1AiiediD9KkUDwAE46swr6BjARtuI4aUOdcJ515RWdtvUEvhXOOapPUjlxxWyw6nzhG8+ZAv5KTMYHDnEr7kCEVd4Npd7IPjUMzPFlvjqKHs2iptO+aEL93ayq1+EoApBfunBl2m8fQIxDKXtQFvGDAI4hhKDNsBsaVw38rCZEQOPowalXMLAeDKeKofvzvXQOszxiobrLHlUzzMJuOFm+wMu7SrmshzihowrKIu1s56tVIGgBbaYcIkHjYTZiiUY6b3LkPVtqNwnKTidadt+amKzAzoV6DpmlSaZd9oG4sWgrUtjNTgg3VnJ3sYz6VgZDD8ek0/eLwqBq9Y/5Da8J1nuMVF19s+oK7HokJQ7cg39MpwkmZUpNmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ERsIh66+rE5yWFdWWM5o6xI6Cz1Txy29AewhrFMTHwDaSwHfV37s59zKUNL7?=
 =?us-ascii?Q?cGpHMH7jtMaWofg+Ist5P5SQev0ZGAhM3TGrVEpIVI/TerYvayzghD+3YtG1?=
 =?us-ascii?Q?p0NVCWB6J2j/K+/Hg6hJATOUw+75q3DgsMie4rFc5Gh5CeIVzk+5pZNo3NBx?=
 =?us-ascii?Q?Z9WzExeRBIDk+uAhBp6fO2wk8kheSYsuFdAeZdgM8jEhPAv+ARqG1bKRsczd?=
 =?us-ascii?Q?2dwmHkKHlydbfzYdHUlc9XlwE1ljPHsTA8kYz/FEUEXyrWDQhCiuIa0a0X4a?=
 =?us-ascii?Q?KbcJvFZ2NT8C/XTH/Epr8IUDR9im8loXAUrWXi2FEJvionQkjyJHwV3urPH3?=
 =?us-ascii?Q?PRD6HCDZ8hhDjsLqFnPWcbNh0kx/BKiD2Irz01Xeq22MVHVcGit2d8b7S655?=
 =?us-ascii?Q?wf56a+9nS3AQN2aw2A1K8X16FnjuWVhgrz0xsW7KFlVyedQT/eLyNB7Pg2qq?=
 =?us-ascii?Q?0v7r8x0A2VnprF1d9pC5T603RhzLBow1kYh3mghg5SYYSEvmqHvHe/9Da0g7?=
 =?us-ascii?Q?Ehe5KQqm8c8yVSXRgfB2uTD+V+r6lVBRkL/IWzbHZ4FAZHVvZ0D1+njxqd9R?=
 =?us-ascii?Q?DTbPhqayum6Nb0LLi7/K+Mq8S6eatFM6YOBoM2Ip1nML5sPbbD/C/cR+2IFk?=
 =?us-ascii?Q?KRT4iMqx8V5Up2Zg3J7fBM4MHdOReAqhgUxZmw4QATL0bpUGRU9VDWqmy7+o?=
 =?us-ascii?Q?tz8+fgj8/KqKJdRbhmjer37TZJxTgcI6n+TMWBegwk6votbXhlvWwLyVOWu4?=
 =?us-ascii?Q?ydFXqqtpvw2YRg8w7/uMT9s3+Yr/oWEa6D5ngs/YnIre3ot5uG8Nt3Ag2vl0?=
 =?us-ascii?Q?UYbRTW500Z20GBzwI0jzQKojCk7fMS1kVm658XCPXcsJ6by5a829D88Go5Hj?=
 =?us-ascii?Q?ZUmIk72xK3UganCHeIfEmW2Rcm9qncTc3ZwJbUF+z+2MWXGyfku2zGCO3nCv?=
 =?us-ascii?Q?dZFMRg1b4jdObGXaaqQpHnH/ttdFarLvH9kQ612toNKDSALAHN+BTmHslbnB?=
 =?us-ascii?Q?DQqgqS2mgPCusYjTEFXCU21DIHlFFAMh6LAhiK+WMEJrwk9ecPNXqd/C1TsS?=
 =?us-ascii?Q?OONl1aKJrTAS7itOSU/iD3E0Ipy1KggSll8lEX0xE20b/hfvhlFgbfAPSOAT?=
 =?us-ascii?Q?OyXZMty5U7fxajreK6BrFuBTZRq+TvmMOqVz5zuUmmCTE2hKADhOMypGbifb?=
 =?us-ascii?Q?3/JJulV4I5DwAla/azqEHhK8JxNFi+ptCRK4RvMiP+EHgz3PLG4QTxYaSTHe?=
 =?us-ascii?Q?5NWrzkeV0V0XIEFAL1yaNNQHWlHrWuDqIDpJ9h7uPvg6jx+lfBSoqJVwCgW+?=
 =?us-ascii?Q?PWrJlZZcaFJRy54LKIK9BMcometuwmKFLeQ2hlO+45MJg6UubRTiacuFMRYQ?=
 =?us-ascii?Q?MpX7Tu9Bp/WGbeGyGLxIr7yW1wHAsCK9ZKRqKFV3H49h9NIk+2of1MbZf8Rd?=
 =?us-ascii?Q?2PBm3X74iPNuvUIMlIi8RZF42Tz1QRCe1FzD5yjwQnP0UbdV2FzzP7kf7hJo?=
 =?us-ascii?Q?BMdgMzbTJVKaxxro+iYClT4uhJBvE9Y7h4354nRwSFIxJsTrc3lhgGMVY1km?=
 =?us-ascii?Q?ZeEWl+FrpEb1yhY+MO3tRZ9KV4iseupoSgFgzBK1/Ih5ckb7CoJEBK4nEQYr?=
 =?us-ascii?Q?yBlMyPvlYf+7mBq/Yj3GQbM2A/fk14iyUAVPkjHZtERmlJ7sVisbNDDjOL7B?=
 =?us-ascii?Q?3yDOpIHQSUB0qG9LIdDBnD9a0vcmI8XF0WOpQdNlll/7QcXBUxalDqUpXMUL?=
 =?us-ascii?Q?QiXjp84S1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330f7c97-71e2-462b-4819-08de8e71557e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:30:55.1194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0KBL9OFMX7l7l56uxjlOoEUhUBC7F2X3jxmjlFaQfAezxMpYbPkCxmBa6TVfyqTsJdtvlF7gMS1CdW2WTQs9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273256-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ktap_helpers.sh:url,nvidia.com:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ethtool_std_stats.sh:url]
X-Rspamd-Queue-Id: 3B17735E17D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new selftest - ethtool_std_stats.sh - which validates the
eth-ctrl, eth-mac and pause standard statistics exported by an
interface. Collision related eth-mac counters as well as the error ones
will be checked against zero since that is the most likely correct
scenario.

The central part of this patch is the traffic_test() function which
gathers the 'before' counter values, sends a batch of traffic and then
interrogates again the same counters in order to determine if the delta
is on target. The function receives an array through which the caller
can request what counters to be interrogated and, for each of them, what
is their target delta value.

The output from this selftest looks as follows on a LX2160ARDB board:

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: ethtool_std_stats.sh
 # TAP version 13
 # 1..26
 # ok 1 ethtool_std_stats.eth-ctrl-MACControlFramesTransmitted
 # ok 2 ethtool_std_stats.eth-ctrl-MACControlFramesReceived
 # ok 3 ethtool_std_stats.eth-mac-FrameCheckSequenceErrors
 # ok 4 ethtool_std_stats.eth-mac-AlignmentErrors
 # ok 5 ethtool_std_stats.eth-mac-FramesLostDueToIntMACXmitError
 # ok 6 ethtool_std_stats.eth-mac-CarrierSenseErrors # SKIP
 # ok 7 ethtool_std_stats.eth-mac-FramesLostDueToIntMACRcvError
 # ok 8 ethtool_std_stats.eth-mac-InRangeLengthErrors # SKIP
 # ok 9 ethtool_std_stats.eth-mac-OutOfRangeLengthField # SKIP
 # ok 10 ethtool_std_stats.eth-mac-FrameTooLongErrors # SKIP
 # ok 11 ethtool_std_stats.eth-mac-FramesAbortedDueToXSColls # SKIP
 # ok 12 ethtool_std_stats.eth-mac-SingleCollisionFrames # SKIP
 # ok 13 ethtool_std_stats.eth-mac-MultipleCollisionFrames # SKIP
 # ok 14 ethtool_std_stats.eth-mac-FramesWithDeferredXmissions # SKIP
 # ok 15 ethtool_std_stats.eth-mac-LateCollisions # SKIP
 # ok 16 ethtool_std_stats.eth-mac-FramesWithExcessiveDeferral # SKIP
 # ok 17 ethtool_std_stats.eth-mac-BroadcastFramesXmittedOK
 # ok 18 ethtool_std_stats.eth-mac-OctetsTransmittedOK
 # ok 19 ethtool_std_stats.eth-mac-BroadcastFramesReceivedOK
 # ok 20 ethtool_std_stats.eth-mac-OctetsReceivedOK
 # ok 21 ethtool_std_stats.eth-mac-FramesTransmittedOK
 # ok 22 ethtool_std_stats.eth-mac-MulticastFramesXmittedOK
 # ok 23 ethtool_std_stats.eth-mac-FramesReceivedOK
 # ok 24 ethtool_std_stats.eth-mac-MulticastFramesReceivedOK
 # ok 25 ethtool_std_stats.pause-tx_pause_frames
 # ok 26 ethtool_std_stats.pause-rx_pause_frames
 # # 10 skipped test(s) detected.  Consider enabling relevant config options to improve coverage.
 # # Totals: pass:16 fail:0 xfail:0 xpass:0 skip:10 error:0
 ok 1 selftests: drivers/net/hw: ethtool_std_stats.sh

Please note that not all MACs are counting the software injected pause
frames as real Tx pause. For example, on a LS1028ARDB the selftest
output will reflect the fact that neither the ENETC MAC, nor the Felix
switch MAC are able to detect Tx pause frames injected by software.

 $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
 (...)
 # # software sent pause frames not detected
 # ok 25 ethtool_std_stats.pause-tx_pause_frames # XFAIL
 # ok 26 ethtool_std_stats.pause-rx_pause_frames

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Acked-by: Petr Machata <petrm@nvidia.com>
---
Changes in v5:
- none
Changes in v4:
- move to a the KTAP format output by using ktap_helpers.sh
- update commit message to reflect the current output
- use DRIVER_TEST_CONFORMANT
Changes in v3:
- none
Changes in v2:
- Use the new run_on helper
- No longer checking that each counter has a 1% tolerance against the
  target. The only upper limit is UINT32_MAX.
- Check that both the error counters and the collision related ones are
  zero since this is the most probable scenario (we don't expect errors
  with the traffic that we are sending).
- Removed any checks performed on the remot interface counters since
  that is being used only as a traffic generator.

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/ethtool_std_stats.sh       | 206 ++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 884cc77daeaa..deeca3f8d080 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS = \
 	ethtool_extended_state.sh \
 	ethtool_mm.sh \
 	ethtool_rmon.sh \
+	ethtool_std_stats.sh \
 	gro_hw.py \
 	hw_stats_l3.sh \
 	hw_stats_l3_gre.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
new file mode 100755
index 000000000000..c085d2a4c989
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_std_stats.sh
@@ -0,0 +1,206 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#shellcheck disable=SC2034 # SC does not see the global variables
+#shellcheck disable=SC2317,SC2329 # unused functions
+
+ALL_TESTS="
+	test_eth_ctrl_stats
+	test_eth_mac_stats
+	test_pause_stats
+"
+: "${DRIVER_TEST_CONFORMANT:=yes}"
+STABLE_MAC_ADDRS=yes
+NUM_NETIFS=2
+lib_dir=$(dirname "$0")
+# shellcheck source=./../../../net/forwarding/lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
+# shellcheck source=./../../../kselftest/ktap_helpers.sh
+source "$lib_dir"/../../../kselftest/ktap_helpers.sh
+
+UINT32_MAX=$((2**32 - 1))
+SUBTESTS=0
+TEST_NAME=$(basename "$0" .sh)
+
+traffic_test()
+{
+	local iface=$1; shift
+	local neigh=$1; shift
+	local num_tx=$1; shift
+	local pkt_format="$1"; shift
+	local -a counters=("$@")
+	local int grp cnt target exact_check
+	local before after delta
+	local num_rx=$((num_tx * 2))
+	local xfail_message
+	local src="aggregate"
+	local i
+
+	for i in "${!counters[@]}"; do
+		read -r int grp cnt target exact_check xfail_message \
+			<<< "${counters[$i]}"
+
+		before[i]=$(ethtool_std_stats_get "$int" "$grp" "$cnt" "$src")
+	done
+
+	# shellcheck disable=SC2086 # needs split options
+	run_on "$iface" "$MZ" "$iface" -q -c "$num_tx" $pkt_format
+
+	# shellcheck disable=SC2086 # needs split options
+	run_on "$neigh" "$MZ" "$neigh" -q -c "$num_rx" $pkt_format
+
+	for i in "${!counters[@]}"; do
+		read -r int grp cnt target exact_check xfail_message \
+			<<< "${counters[$i]}"
+
+		after[i]=$(ethtool_std_stats_get "$int" "$grp" "$cnt" "$src")
+		if [[ "${after[$i]}" == "null" ]]; then
+			ktap_test_skip "$TEST_NAME.$grp-$cnt"
+			continue;
+		fi
+
+		delta=$((after[i] - before[i]))
+
+		if [ "$exact_check" -ne 0 ]; then
+			[ "$delta" -eq "$target" ]
+		else
+			[ "$delta" -ge "$target" ] && \
+			[ "$delta" -le "$UINT32_MAX" ]
+		fi
+		err="$?"
+
+		if [[ $err != 0  ]] && [[ -n $xfail_message ]]; then
+			ktap_print_msg "$xfail_message"
+			ktap_test_xfail "$TEST_NAME.$grp-$cnt"
+			continue;
+		fi
+
+		if [[ $err != 0 ]]; then
+			ktap_print_msg "$grp-$cnt is not valid on $int (expected $target, got $delta)"
+			ktap_test_fail "$TEST_NAME.$grp-$cnt"
+		else
+			ktap_test_pass "$TEST_NAME.$grp-$cnt"
+		fi
+	done
+}
+
+test_eth_ctrl_stats()
+{
+	local pkt_format="-a own -b bcast 88:08 -p 64"
+	local num_pkts=1000
+	local -a counters
+
+	counters=("$h1 eth-ctrl MACControlFramesTransmitted $num_pkts 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-ctrl MACControlFramesReceived $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+}
+SUBTESTS=$((SUBTESTS + 2))
+
+test_eth_mac_stats()
+{
+	local pkt_size=100
+	local pkt_size_fcs=$((pkt_size + 4))
+	local bcast_pkt_format="-a own -b bcast -p $pkt_size"
+	local mcast_pkt_format="-a own -b 01:00:5E:00:00:01 -p $pkt_size"
+	local num_pkts=2000
+	local octets=$((pkt_size_fcs * num_pkts))
+	local -a counters error_cnt collision_cnt
+
+	# Error counters should be exactly zero
+	counters=("$h1 eth-mac FrameCheckSequenceErrors 0 1"
+		  "$h1 eth-mac AlignmentErrors 0 1"
+		  "$h1 eth-mac FramesLostDueToIntMACXmitError 0 1"
+		  "$h1 eth-mac CarrierSenseErrors 0 1"
+		  "$h1 eth-mac FramesLostDueToIntMACRcvError 0 1"
+		  "$h1 eth-mac InRangeLengthErrors 0 1"
+		  "$h1 eth-mac OutOfRangeLengthField 0 1"
+		  "$h1 eth-mac FrameTooLongErrors 0 1"
+		  "$h1 eth-mac FramesAbortedDueToXSColls 0 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	# Collision related counters should also be zero
+	counters=("$h1 eth-mac SingleCollisionFrames 0 1"
+		  "$h1 eth-mac MultipleCollisionFrames 0 1"
+		  "$h1 eth-mac FramesWithDeferredXmissions 0 1"
+		  "$h1 eth-mac LateCollisions 0 1"
+		  "$h1 eth-mac FramesWithExcessiveDeferral 0 1")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac BroadcastFramesXmittedOK $num_pkts 0"
+		  "$h1 eth-mac OctetsTransmittedOK $octets 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac BroadcastFramesReceivedOK $num_pkts 0"
+		  "$h1 eth-mac OctetsReceivedOK $octets 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$bcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac FramesTransmittedOK $num_pkts 0"
+		  "$h1 eth-mac MulticastFramesXmittedOK $num_pkts 0")
+	traffic_test "$h1" "$h2" "$num_pkts" "$mcast_pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 eth-mac FramesReceivedOK $num_pkts 0"
+		  "$h1 eth-mac MulticastFramesReceivedOK $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$mcast_pkt_format" \
+		"${counters[@]}"
+}
+SUBTESTS=$((SUBTESTS + 22))
+
+test_pause_stats()
+{
+	local pkt_format="-a own -b 01:80:c2:00:00:01 88:08:00:01:00:01"
+	local xfail_message="software sent pause frames not detected"
+	local num_pkts=2000
+	local -a counters
+	local int
+	local i
+
+	# Check that there is pause frame support
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		int="${NETIFS[p$i]}"
+		if ! run_on "$int" ethtool -I --json -a "$int" > /dev/null 2>&1; then
+			ktap_test_skip "$TEST_NAME.tx_pause_frames"
+			ktap_test_skip "$TEST_NAME.rx_pause_frames"
+			return
+		fi
+	done
+
+	counters=("$h1 pause tx_pause_frames $num_pkts 0 $xfail_message")
+	traffic_test "$h1" "$h2" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+
+	counters=("$h1 pause rx_pause_frames $num_pkts 0")
+	traffic_test "$h2" "$h1" "$num_pkts" "$pkt_format" \
+		"${counters[@]}"
+}
+SUBTESTS=$((SUBTESTS + 2))
+
+setup_prepare()
+{
+	local iface
+
+	h1=${NETIFS[p1]}
+	h2=${NETIFS[p2]}
+
+	h2_mac=$(mac_get "$h2")
+}
+
+ktap_print_header
+ktap_set_plan $SUBTESTS
+
+check_ethtool_counter_group_support
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+ktap_finished
-- 
2.25.1


