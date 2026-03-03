Return-Path: <netdev+bounces-263425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIOpKYZUp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:37:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B91F7A00
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDFC730312DD
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96061481A9B;
	Tue,  3 Mar 2026 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="syTWrysg"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021121.outbound.protection.outlook.com [52.101.52.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C7425CFE;
	Tue,  3 Mar 2026 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573826; cv=fail; b=mz1QRFnwwUR7CgKFDBQv0MReFhnyl6nQrK2WgxHGEfhxX9Ql5TnhVDkPI16K1yQx/hqeaES3zQDXIf7B3gKj2a+Dn1/DauqIVpLjCYS9Ls+acrV6IoSQ6sC5TxHBlJ5z9v2ozlX5BsUT876F0YiHHE4Vu/sjIcfzLTMID0PhG+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573826; c=relaxed/simple;
	bh=OurqBGSq5N6uxgP0uyrjzGTIcAaJLeXwcZuw7zdsPPs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NcHmAYFzdZNEpVDI7fdf+LXSptsOOe30oJ6SPJwONpAxUDi1hjR9aRaZe0WK0zafB+TjjmIULHLQnBTboUTIr3as2Q6Zao5JRF1PJ22of+jiIJBbFqkIUVQNYlv91FJsdwJfhyJDo6rxHG5MJWQcK9tLfypiJhYZQpbLix+nXDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=syTWrysg; arc=fail smtp.client-ip=52.101.52.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXxo6l73cseovPhGTcWlZG/VebuFX2Q7K1FPcPLYnCUrO6v+tweYNntAY8bFmiDB8ddl+ISf4XxkZ2y1I9cRYpqDgqrYOyMWeY9vYP+gVn9QWCt7j08PPyGiCqTAc/3ILblmtBK5Cv6CpdwiObPhg64R6Bb5nDhu7/lrI7HHXL1dbZgYqw6hDHkgGg+vk4Rxzr8W2x5NZk7sD4oUKF4qEtAdJAoZ9iBtV75yUH4uBqcSmlxh2Y1Bp4O1SgOYQdz/7RDYddlWzEs4iIcFNUDAo3L7xgC7PBXc9TbSTj1+LmOM6Qa+Y7bIGjHUQsY0h8mCou2FZmRuLSwijXzYcFGq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H6+K4fHINi1L9CqA7IoptcFprS6tJUhamCJ2EekFy8=;
 b=GU5FjYAgUjZygRF4gkpdFL8JlYkYi3EEMwYTQ66ZH8xvBug0rzwbzFh8ADkII8nXWNsu2Fm+BuE7xL7NwkTgBYAL3cmfcm6hc3Si0Xsghb2HtjFl9ZLMW6LNJoncTkiU/X7QuUFBC+OhOYvDT0rCcOqK6P4cOcmMF3+1563x4PKmiyQ/EdmTk2U4Oqke1udTf1p9m0DeC4nsCM18oqHNAj8vg2JmRxc1xUhv6yVppaLOqrAOQtrWidZHW3hyuz9V5nNaUFrnIJxbTOkls5cJGjiX5ILyNJMO+dkxb0IWH5ny4V9ho5H383tW4L5tQ5uvXLWkJ9Cclu47QYOMkQDPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H6+K4fHINi1L9CqA7IoptcFprS6tJUhamCJ2EekFy8=;
 b=syTWrysgKF1eWZEJzAO4azBfEFJTSB31RWejugk9PG546oV8pVCGQIcNDs5MB5th5mIJDjfTMw6+fFg3wo9GuoVHMBb7uxgwlT1KJ23QHFU5qNxAJNOGn4puvryors/3FYmFifcck6EaOm00oB2EBrBY2T6Wdann0WgTXbh43LY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CO1PR01MB8916.prod.exchangelabs.com (2603:10b6:303:26f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 21:36:57 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 21:36:56 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [net-next v32 0/2] MCTP Over PCC Transport
Date: Tue,  3 Mar 2026 16:36:44 -0500
Message-ID: <20260303213649.237851-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:930:17::14) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CO1PR01MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d8158c-4945-43bd-cda0-08de796cfe13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|52116014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	y1rrlMrgJjm5IFipB7blAbuBUmOa6Ff8wtLz9f4bko+yMjvzUur8Hq2llrK3expXdpaerKIePQiabVrgNdL6OWC8q+gRJiAN8MUtXfCfQsVFsPy1lQ7owJpptFCmdZx2QV6h2IDACxzEtTygao5XGgsWDM7fE6MZ/y+wGuUKX6WKi4rUwkkRZwbMDeb3L78nJYr4KBzPHHMQHaybTlZbIFbOVGyJzYw49eo7Rr9g9MbN101u7Zhqj31kJulPehqsKZ/YpSLPoUxPCt6HXZoDlSWlZ0MUegA6pDxQfEvCqSfOnKmIkoEteajyPZ8Bd+L25jRLoiHc6FuzMUuw20gRU5t9jprVf/+i7SAaihGeHDGvlZp7Vcse8oqr4i/OKCMl/MphWX3+ObJXOqOWHrRB+BOnGoQHafRWTUqUa2lF81s6rYTPfNA/hobrVeVCJ14X24ZilflQGQ2531iUTOeZ5c8UEb5jJ1kQB1HxUo3u0pzjkSu3eriW5AMGvsWcFvDWo3d8RwYW+hV8crCpcLjD25t2kzhZBXVRVHaXwA5dupWQN3GhK4wfb3Ug3QoCZLtbjvO0kq5MdtHd4GCgHio8yjEDnpxC6vRQqz51On+x9Xw+wjpfEQfF5UipBih9yp+8zw+8+hmi8vm8Cd/pxwoprwF/Ze8YXChsplb5mAhF+mISLZuu0MRpgZmU99bI8FdfnWll4iTyDks/cjoc+VQbrqm9A4fEFrEAKkxqC+W7ndw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(52116014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YT+QrB/o/EyPm0750y/Q1hJ0WMV+rtA+YhsR+o41WudX8v5BpEjUulj0Gv/?=
 =?us-ascii?Q?mYpCTYG6EWKCue1shSpEpmMPFWNpFLh2amIc83DSOIhWSCBn6r4gMC8n1cNT?=
 =?us-ascii?Q?9Gr2wVQ65jfQ3OtR6B4wrk+dayAJMGvCXv7uTUTZGzfaAwSWDDw3SlqkWaEA?=
 =?us-ascii?Q?qDmXNCyFHi1JBL19S4NouzmoyEWDFQNfSFbPgHUMOfX343+fEEcRcmRlzxML?=
 =?us-ascii?Q?VroOG0SUbcImJ0FTuvJYQLm8XF1dDe3us2+dq0EsIueHz6IpT/LP7cNFZiCT?=
 =?us-ascii?Q?8MMCIs+D2f+MdfTqtt79ZqdD+fW+gCJfbiA4GWkHed9e+iy0eX3bqch8OOsm?=
 =?us-ascii?Q?6W/e2OscCVqF/aic/CavYLkNp4XUtr8KBiNRRF6eeV+I/X/+24ZmoU981sLp?=
 =?us-ascii?Q?cVWsNFce+GOP6Q5LacfV52NMOV433iJJjpq11DwEPPELEPQpLu50rkFc5MC/?=
 =?us-ascii?Q?4bgRC7AjEcNI2qXB0f6VKqsBwKGUj7QN5RpFkrDuD1rPsWoRqwGNpGVgVxKR?=
 =?us-ascii?Q?mjAJ+cLPkvM+csiIQACK3MRFMXhcXFyz3TMERumqAMrHEU82dDO+ce61T3xJ?=
 =?us-ascii?Q?yU8pUleKl/avK++g/Eb/Rj2j3nmiVVWbKGCEHSEaYrEPWyiMjOrS/rgaP7K1?=
 =?us-ascii?Q?Mu/FYORosGYLN88YRm03Uq00S9V3ub3yho0l9WEGQiiKjWrNTDyVxKGH7j9H?=
 =?us-ascii?Q?XmFjOmQlTJihg9X6IGo3W3qtOvAFmwmNDoUCyi4CvJ08KNcnyB/y73S0pNWa?=
 =?us-ascii?Q?T0sXovU2zeRgt6e/sOmnX2qtbgXPHfkWWXkMawc1xM4p4AnnXntzsiHbaz/E?=
 =?us-ascii?Q?AvLdoNYc+lS8wvMU1qjinLJfLg/XfziWDdOoFGCAmpydqlydj2opBfNHHNYU?=
 =?us-ascii?Q?p3oFacmiisjm51DVZmHSI8Rz/FCVFW67nzQu4sjXHpxzWEQ9maiU6RCGO5Dn?=
 =?us-ascii?Q?0DSfplpRKldcZxcW8ggozH7X8N6AC66q880Jlui14eOi2ai0zuiHpZ5SEzef?=
 =?us-ascii?Q?qxDWGmeUEjsm/G2VLpCN4khpyeyygNKEcG0IJsbFQbF7/1NKFeNVT6jo88PI?=
 =?us-ascii?Q?sWgfS2ouX208RIYu5x+55j3LlxzI7WG6QOvAS3AqVg+E36b/1FyubMWmMnVA?=
 =?us-ascii?Q?ugNgQDw7u7lvB2Y+MH96yzFLThV9qm4lmaP8Tyn8y3qSqD7gq3WEovXp9+zy?=
 =?us-ascii?Q?G2mLxwTH/5Hg1Fmki1IK1bGUv/6y1TSY0SPH7wLEiNANX+IE/r6mRniLd62a?=
 =?us-ascii?Q?oU81y/YDiufYu7d5TZ2/d6W95bQwFXLcAubQD3Ym49ZYFg7sHtXWefhBoN0B?=
 =?us-ascii?Q?dpZY9/yY7h/YmG6EuUP1J+/7EUp8236om4qdT2bOehw+e3q2WwwaOVQNwLZV?=
 =?us-ascii?Q?l6eI/TPb/RgDteF56Tn1fGtd8c0NRpIscm3t5cRAMpiPXLyWts2I75QWxRNb?=
 =?us-ascii?Q?ND41Lnk19CXwOhmv6BWnQCujYwvdmIR7K1oVyhbvbrHnEcWkhvJla6VvhzWR?=
 =?us-ascii?Q?LqVFt/mN7fxBxiJYYmq0+t31WNI9FzsAcCWhbWKU4XbXMPoqhjBF4qvpf6mS?=
 =?us-ascii?Q?zrwvk+26IWVxje9Qbh6yuLkz0EC5w8V/84P6470yCb1/qYPL1HPoqLqb9Vwt?=
 =?us-ascii?Q?Bx+YUaMrYEKcFDHH/wh1lMbhj+/WF1XXZwQUgeXu809pgfFx130YPkCoPPH+?=
 =?us-ascii?Q?rajzJJdjMPdllBsaMcDDDZJuPY0zy2a3nZjKE90b7nB53LsmoHAfmdDi0iDx?=
 =?us-ascii?Q?sSOtIR4qGwOc8dN2pc2RWq/0olNmrJrtvYvuMVCXBs2lIbR71OVKNIkdXIie?=
X-MS-Exchange-AntiSpam-MessageData-1:
	x9OhT5r9QctjIHGPBTir6CpwYMnohmx3DgWAF547fR1j04h/o2S15pEF
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d8158c-4945-43bd-cda0-08de796cfe13
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:36:56.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8pU8rLt1QIdTFWAO0VxiQhd9dVHz1yW25RL/9GMrvkEzF2DSHPsOWUYLkQB2iOcPIWxmmp4PlIaYe3FC1F2biJqafPJKh2XZ8p3hflj2h4uG3JFF0WnQJTBxW/wyhsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8916
X-Rspamd-Queue-Id: 096B91F7A00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263425-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series adds support for the
Management Component Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/\
DSP0292_1.0.0WIP50.pdf

MCTP defines a communication model intended to facilitate communication
between Management controllers and other management controllers, and
between Management controllers and management devices.

PCC is a mechanism for communication between components within the
Platform. It is a composed of shared memory regions, interrupt registers,
and status registers.

The MCTP over PCC driver makes use of two PCC channels. For sending
messages, it uses a Type 3 channel, and for receiving messages it uses
the paired Type 4 channel.  The device and corresponding channels are
specified via ACPI.

MCTP is a general purpose  protocol so it would  be impossible to
enumerate all the use cases, but some of the ones that are most topical
are attestation and RAS support.  There are a handful of protocols built
on top of MCTP, to include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session
establishment.

PLDM is more likely to be used for hardware support: temperature, voltage,
or fan sensor control.

At least two companies have devices that can make use of the mechanism.
One is Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of
the ACPI spec:
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has the
ability to ignore an MCTP link that they do not want to enable. This link
would be visible to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. Thus, if the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hard that does support
PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would thus also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

A Previous version of this patch series had a pre-requisite patch that
allows the PCC Mailbox to managed the PCC shared buffer.  That patch has
been reverted. Instead, the functionality was moved to helper functions
which are explicitly called by the MCTP driver.

Testing of the patch without hardware support can be done using a patched Qemu
and helper program.  The Qemu code can be pulled from
https://github.com/AmpereComputing/qemu-ampere-staging/tree/pcc
And the support code from
https://github.com/AmpereComputing/pccd

THe virtual machine can be run on ARM64 Hardware with the following command line:

../qemu/build/qemu-system-aarch64 \
        -machine virt \
        -enable-kvm \
        #additional parameters as you need for your machine

A running virtual machine with a Kernel with the applied patch can then be tested
using the mctp-client command line utility found here:
https://github.com/CodeConstruct/mctp/blob/main/src/mctp-client.c

To test run the following script:

EID=50
LINKID=2

modprobe -q mctp-pcc

PREFIX=mctppcc

LINK_STATUS=`mctp link | awk '/mctppcc/ {print $11}'`

if [ $LINK_STATUS = "down" ]
then
        mctp route add 50 via $PREFIX$LINKID
        mctp address add 15 dev $PREFIX$LINKID
        mctp link set $PREFIX$LINKID up
fi

test_mctp(){
	REQ_TYPE=$2
	REQ_DATA=$3
	TEST_NAME=$1
	EXPECTED_RESPONSE=$4

        # unccoment to debug
	echo mctp-client eid $EID type spdm data $REQ_DATA
	RESPONSE=$( mctp-client eid $EID type spdm data $REQ_DATA | tail -1 )

	if [ "$RESPONSE" = "$EXPECTED_RESPONSE" ]
	then
		echo -n ok
	else
		echo not ok
		echo EXPECT=:$EXPECTED_RESPONSE:
		echo ACTUAL=:$RESPONSE:
	fi
	echo  " - " $TEST_NAME
}

test_mctp "SPDM GET Version" "05" "0x10 0x84 0x00 0x00" "10 04 00 00 00 01 00 12"
test_mctp "SPDM GET CAPABILITES" "05" "0x12 0xe1 0x00 0x00 0x00 0x00 0x00 0x00 0xc6 0xf7 0x02 0x08 0x00 0x12 0x00 0x00 0x00 0x12 0x00 0x00"  "12 61 00 00 00 16 00 00 16 00 0E 00 C8 00 00 00 00 12 00 00"

Previous Version:
https://lore.kernel.org/lkml/20260224231055.393329-1-admiyo@os.amperecomputing.com/

Changed in V32:
- removed unused outbox variable in mctp_pcc_tx_done
- formatted mailbox/pcc.c kernel-docs IAW script

Changed in V31:
- Use predefined Header structure for pcc Extended buffers
- Rebased on top of changes for PCC to handle ACK interrupt and tx_complete
- Fixed formatting in mctp_pcc
- use netdev specific log function
- removed condition around dev_consume_skb_any(skb);
- initialized ndev->hard_header_len with sizeof PCC header
- removed spurious mctp_pcc_ndev = netdev_priv(ndev);
- Rebased on 6.19

Changed in V30:
- rebased on revert of mailbox/pcc.c code
- Explicit patch for dealing with PCC Type 3 ACK Interrupts
- PCC buffer management moved to helper functions
- PCC helper functions are explicitly called from Network Driver
- Removal of sk_buff queues
-

Changed in V29:
- Added a callback function for the mailbox API to allocate the rx_buffer
- The PCC mailbox to uses the Mailbox API callback instead of the PCC specific one
- The MCTP-PCC driver uses the Mailbox API callback instead of the PCC specific one
- Code review fixes for language in comments
- Removed PCC specific callback

Changes in V28:
- ndo open and ndo start create and free channels
- Max MTU is set in create
- Reverse XMass tree rules complied with
- Driver no longer has any auto-cleanup on registration functions
- Tested with KASAN

Changes in V27:
- Stop and restart packet Queues to deal with a full ring buffer
- drop the 'i' from the middle of the link name
- restore the allocation and freeing of the channel to the driver add/remove functions
  leaving only the queue draining in the ndo stop function

Changes in V26:
-  Remove the addition net-device spinlock and use the spinlock already present in skb lists
-  Use temporary variables to check for success finding the skb in the lists
-  Remove comment that is no longer relevant

Changes in V25:
- Use spin lock to control access to queues of sk_buffs
- removed unused constants
- added ndo_open and ndo_stop functions.  These two functions do
  channel creation and cleanup, to remove packets from the mailbox.
  They do queue cleanup as well.
- No longer cleans up the channel from the device.

Changes in V24:
- Removed endianess for PCC header values
- Kept Column width to under 80 chars
- Typo in commit message
- Prereqisite patch for PCC buffer management was merged late in 6.17.
  See "mailbox/pcc: support mailbox management of the shared buffer"

Changes in V23:
- Trigger for direct management of shared buffer based on flag in pcc channel
- Only initialize rx_alloc for inbox, not outbox.
- Read value for requested IRQ flag out of channel's current_req
- unqueue an sk_buff that failed to send
- Move error handling for skb resize error inline instead of goto

Changes in V22:
- Direct management of the shared buffer in the mailbox layer.
- Proper checking of command complete flag prior to writing to the buffer.

Changes in V21:
- Use existing constants PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY
- Check return code on call to send_data and drop packet if failed
- use sizeof(*mctp_pcc_header) etc,  instead of structs for resizing buffers
- simplify check for ares->type != PCC_DWORD_TYPE
- simply return result devm_add_action_or_reset
- reduce initializer for  mctp_pcc_lookup_context context = {};
- move initialization of mbox dev into mctp_pcc_initialize_mailbox
- minor spacing changes

Changes in V20:
- corrected typo in RFC version
- removed spurious space
- tx spin lock only controls access to shared memory buffer
- tx spin lock not eheld on error condition
- tx returns OK if skb can't be expanded

Changes in V19:
- Rebased on changes to PCC mailbox handling
- checks for cloned SKB prior to transmission
- converted doulbe slash comments to C comments

Changes in V18:
- Added Acked-By
- Fix minor spacing issue

Changes in V17:
- No new changes. Rebased on net-next post 6.13 release.

Changes in V16:
- do not duplicate cleanup after devm_add_action_or_reset calls

Changes in V15:
- corrected indentation formatting error
- Corrected TABS issue in MAINTAINER entry

Changes in V14:
- Do not attempt to unregister a netdev that is never registered
- Added MAINTAINER entry

Changes in V13:
- Explicitly Convert PCC header from little endian to machine native

Changes in V12:
- Explicitly use little endian conversion for PCC header signature
- Builds clean with make C=1

Changes in V11:
- Explicitly use little endian types for PCC header

Changes in V11:
- Switch Big Endian data types to machine local for PCC header
- use mctp specific function for registering netdev

Changes in V10:
- sync with net-next branch
- use dstats helper functions
- remove duplicate drop stat
- remove more double spaces

Changes in V9:
- Prerequisite patch for PCC mailbox has been merged
- Stats collection now use helper functions
- many double spaces reduced to single

Changes in V8:
- change 0 to NULL for pointer check of shmem
- add semi for static version of pcc_mbox_ioremap
- convert pcc_mbox_ioremap function to static inline when client code is not being built
- remove shmem comment from struct pcc_chan_info descriptor
- copy rx_dropped in mctp_pcc_net_stats
- removed trailing newline on error message
- removed double space in dev_dbg string
- use big endian for header members
- Fix use full spec ID in description
- Fix typo in file description
- Form the complete outbound message in the sk_buff

Changes in V7:
- Removed the Hardware address as specification is not published.
- Map the shared buffer in the mailbox and share the mapped region with the driver
- Use the sk_buff memory to prepare the message before copying to shared region

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper structure for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unnecessary null initialization from acpi_device_id

Changes in V5
- Removed Owner field from ACPI module declaration
- removed unused next field from struct mctp_pcc_ndev
- Corrected logic reading  RX ACK flag.
- Added comment for struct pcc_chan_info field shmem_base_addr
- check against current mtu instead of max mtu for packet length\
- removed unnecessary lookups of pnd->mdev.dev

Changes in V4
- Read flags out of shared buffer to trigger ACK for Type 4 RX
- Remove list of netdevs and cleanup from devices only
- tag PCCT protocol headers as little endian
- Remove unused constants

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header
- replaced custom modules init and cleanup with ACPI version

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.

Adam Young (2):
  mailbox: pcc: functions for reading and writing PCC extended data
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   5 +
 drivers/mailbox/pcc.c       |  86 ++++++++++
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 322 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |  22 +++
 6 files changed, 449 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c


base-commit: ed0abfe93fd135dac223e87a3c945017b1fa8bfc
prerequisite-patch-id: e856d915dc6ca2ab6872d48f49015cacc271e176
-- 
2.43.0


