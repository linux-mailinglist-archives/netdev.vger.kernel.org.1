Return-Path: <netdev+bounces-268018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEb1Nnh/t2kmRwEAu9opvQ
	(envelope-from <netdev+bounces-268018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:56:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F24F2947E1
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 04:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E41DD3006126
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC53322B7D;
	Mon, 16 Mar 2026 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qLOoGdkt"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022096.outbound.protection.outlook.com [40.93.195.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAFA17A309;
	Mon, 16 Mar 2026 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773633398; cv=fail; b=fZFSva4wpNcsNS5a36A2jA6S7Rbi96cdOICz/iNQAsNa30WSkcW8DSTjbNt7QsnGY0aZ5WCLtaHnXyGUMYxD089Uj/kps2/itS98LvBPgqNPbYhM6LrQcq0jSZp5BN//EJFZqxjbUkbdDbnx85kvjJfBT3e2HR/6ML/n84GiMSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773633398; c=relaxed/simple;
	bh=aQkdjWqOlillKAIicnEkKnouFEerVC78OvimMCyRVLM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aKIoqr2UHQRthEk2tdXOvHrJg+pqV0iZ06IxwY4R0oMamdZ4xYhROAX6pT1pCNYOAiDHtIgABBTtyzvzQpPc0qv2QO7XcRxYz8TVy5a6DsvMYinwwoXxBDBrJxo3MTjfPIRJ2MfoGAqISJPCSFIm1aFPhL9KmxJRTlu/1BqUVRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qLOoGdkt; arc=fail smtp.client-ip=40.93.195.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rP25NF/b3Jbc0TNXTuAZfSQr0aUeZeMXgjoZIeruLUjFnV6D9KqKge5P//QxldsGlHqe8+wAeqvEkoAN/WqEV2jlII9HujvrWXt9SI9Cnhp3xfPQwBQzTSeZCCWMKnQETVff2iSDvu+GwclKWZYsLfToENXk4pDWBI3URZtZL7u6vb2yprsh3wD83wcrYTDBlI1k2xbUicQ0o3VEtcrXKhOQPyErCIi/dT/ILFHW08uoxNF3/uNWWB+KsLWe1p/2M12zgZbYRjIjrET/9buAPKb0ZWZpTU1jyEZHRFjI5v3ugiHRtocFNiYxzl29x4tYaVr1TASaqBWoh0OhUbeGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyCuwKRLLSfrv0ZbvLxrDhjZ8lz03/S8ZPm4BX1PBIE=;
 b=xmVLDhS5IGN1YkFNpBvcIHqUEYjTsFBZcSQ9CdyqiQfWbfCQFHWcakwVt5tmxpRrLq8FEJ3+MPJZ2y4RlWIOQDrmisFW+uIbTuJZymWSAtZ19Huusy509CJ5i0Y7N+eo3FZt9JSeTdaLtByhNwuVd8sa4B+FaoC9YZ9tmtv+HUec3yCyp1XxBv05InjRiMJVD5iECkZD/M6sTbTACgSs/MojwHq5jUyuFPmt/y8kQjEEMKPOn/IXpXyCDxH1Kqs8r5kv5T/xcLtSJRTJY9D65gPYVL4j9OEvRIFef30SqDYsbk+B/GVZzHlTeEMxdkJrwgu9ffO7fBxoi/PkerqtbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyCuwKRLLSfrv0ZbvLxrDhjZ8lz03/S8ZPm4BX1PBIE=;
 b=qLOoGdktEHbEpItH61wcE17MI5aioGpL9bmDlFGKQ1FuZ47hQysS1ht5L9GS31be0qAKo0P2CBAEik/hkcMNzQSWm89cZO/4UlEPKzQcw6qi1AxETLzOXgWNYry/u0l57iJoFbVNMoXgtprbZo69X16TN+FlYf4jMfoZxj2tRQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA3PR01MB7942.prod.exchangelabs.com (2603:10b6:806:315::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.19; Mon, 16 Mar 2026 03:56:28 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 03:56:20 +0000
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
Subject: [net-next v33 0/1] MCTP Over PCC Transport
Date: Sun, 15 Mar 2026 23:56:24 -0400
Message-ID: <20260316035626.363698-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:930:cc::15) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA3PR01MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e998f8-83db-4759-c688-08de830ffb81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|52116014|376014|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	rN3R4scL9einE33p3eqcpLQ7h88v9q6I13lc9X8ZIevG+mRvTP6iSEnohOsfYm8RC1TpWtZocuuw6D/sFVGQfAbRRKhx55UTJ4KJd49KSbKAcaszSXtT/bKGwlEQ+41Y31wBNvvjjc1uZqZ907bw4kAmmgG5cx7phz2FTdNtm+JVDV68ZwxCclyQ/FOEhgkbXzw6QjmYrPjFJtg/YHTawqBiPUBJU2FyucPqaPeqHlfSz7r2leSDK/qnsauit2B0IG3ZLAZzXLsel1Z55C7OO865xeiyNVGabi8UXgQ1YCXtt64PmzPe/6mJgAUVpcyIC/+Nzjo77cLu3MAwvn/Pfvq51ik4oOZFjti1tVacxNOqyWNdK/MxlVNKgXDRRkmmUv3DS9QkIxDJOujbd6T63xSgu8AJZDc0qC+eI81d1xtW4WoNu/NIfBoJREdSyQjYp5c5/Gbn5ZMB7TWq/KmOHncI7BJPNBVdoZBhWUKFqrHQwFVDG/ATLhaosyo7JyzANAC5aQ1MZLv0pqQ+SQNrCRfIoUdEc3rxplNopF0RwRpdrrr9zSv2nAl3FGY9Lg2nhf/rlKaHv/eEsZsmq8IVFv9MTBtcTsVm+CSypnj8oKgqiGhw7UkJlcSGhJ2bjojdhSJ6Z2GP93YUQJTnbUkqP1hOkuPnV9VFVyPyUThTZp+YvQwqcGCHNHAl8G0CAlDWkMkEaQCk7dN1C1M+2FFwEslVJ6bOmjBVREkbDViuwSI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(52116014)(376014)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5q/M7PJdwfK7P821J35ihsZTTb0c1eO1Yo8lk9zBUAxpo75k55wUa5g7Wta?=
 =?us-ascii?Q?FWTV87Hmg2nNFD1UnPVyibnPiIQRsZTlFmgJsP7j7IzO4pub6YQ00jcyuLxg?=
 =?us-ascii?Q?RjFWEklGlzEQG4UQcymKD7sJ2hh541mxxkjC5jFT5XVC+O8PijL2jH8e2wNp?=
 =?us-ascii?Q?n/BquVGO2HXjxbzFbq7fkOrBrGhbyWRbQBVUdkXo3wYFQv3ViKDeCnKtLuu7?=
 =?us-ascii?Q?OHtQ2zMZo9tie2iXrxqqEVZiETmMwZYSGe5vQ4TCq74WHobjzYKVkKhX/xvB?=
 =?us-ascii?Q?1S66d0dHEh03dIMsz5nX0f8dmLEQW35VvVY4qPDGM2pTkbna4wVOlO3/040w?=
 =?us-ascii?Q?MDp0Q80NpbHk5DlRp+7xOySAnC3xKOWKrG/f/SdBJoLum2MwK8PTejcPIXUq?=
 =?us-ascii?Q?LfmRHdyNgR/qlr3J6y+9eh97v9T32G8do/qqZFgzuM9kn6M/pw442zsou/Oa?=
 =?us-ascii?Q?5I+og+ALjn4x1XuyWGHOp7zUM5LRToZgwjeHznrLS/4tnIj8uZ1pBB8A0Ml4?=
 =?us-ascii?Q?vMvJhFpbdVbvPsfqjnuPpxsRrGl7ow6+DhSietmI9Ii8sKEr+EwTzrkVprKn?=
 =?us-ascii?Q?LQjt8bdK2bT7JIkUnFAv2zgyHClJVJKszs618N/5xKOAqnL0SuzCi2fwcnrV?=
 =?us-ascii?Q?Qx2FGb1vmEC34n+ywHGYscoUl7YZUDRN/fhWtFyziQjJMnMyc8iA9Bd007E7?=
 =?us-ascii?Q?G1cqIM01bV20AVSV6SObrFxWbQxB4Fe4Ib1Do1UYw7nN/N2H7R3Pkv5bFHLs?=
 =?us-ascii?Q?JAzo92tnpJAcMq/z0v9+i8IKdc3GC8Xa7LwuFgSkQL4VNNIy7v1YW5iF2l52?=
 =?us-ascii?Q?9mAKDF02APACSc51PXQg8qMVdzQc8QohfePygEhBBH7cfh0rYSv/LXZQvij/?=
 =?us-ascii?Q?RpEOdT4DEkFRnwyVRTo6wboPe7FjKYfjPoBIr7tUz6qHq2xwENbAbs47zktq?=
 =?us-ascii?Q?AO56waA7Fj3bsrFpVAEYzwV+zT9RxrN6MHf0LgXfW6ojFFy6+4JjdOr0TX/o?=
 =?us-ascii?Q?0rtNd1YsVP5e39bK+qsexgJsIo8ePcIIDAzIrKYIJwDDr5VDmWb/4b2o83jf?=
 =?us-ascii?Q?Oy/usRt8Pe+9/UKWf787MrOBlcPGHrT4SVsKnvosDUdYWPMPd2m4VPDocu4L?=
 =?us-ascii?Q?jGLPvLX11djJUsYsXxf/yudbio/9uryfpoRl1xgqSTQMKCbVlg0VoEokHfXM?=
 =?us-ascii?Q?zQmBRAcZ2zKXcef6AWVXsDHUQux1dqO0UvlPIGv0TTsKEKkPSDqnkQcK3y5i?=
 =?us-ascii?Q?dk5Ro3bPv2mueDLyLxRyMppscNpCzmkFy7dqo8RlmbkUjnDK2U/XeXzsOo2n?=
 =?us-ascii?Q?rny0gJ62CEg/XBl94vDRyfZqDWpIfExO2TFnUn6onbzQORyejZP3mQfjjW/h?=
 =?us-ascii?Q?0smDlzGep4lC5LTdV9aUGH1nFTx7y15aj3foRSOeOEYDrHj7ep7KrIHGzEG8?=
 =?us-ascii?Q?pXlBwLVHvudYZbdH2WxEpTP0WBCH6rB1G5EdvK6FHlNWZ2a2QQCBKyrf3u6Y?=
 =?us-ascii?Q?rclhBOkDDVMiIhnl3VGKbVnwwunwcOyxS/msqNVXj7qWr6HJBA/+xqG40fJb?=
 =?us-ascii?Q?0oBB1EX07ZQZiJTNsjHlJD2AhOIuzxptnLXYEk+LeTGaY/W9Srv1AttaeZ40?=
 =?us-ascii?Q?vzUll3N4BhUNI2ZYUgrlZMDE66NVCTDHFMn+P2RBJh6NoPuwL9NTOo+q2Avg?=
 =?us-ascii?Q?lqqu4RckYpRsEPykWKE8B6yQ53D+AA7bkqdCfkrmv1qHRRArKzkUjSZbbtBv?=
 =?us-ascii?Q?VWGPoQtwFMnAwsaXGVE8kvfYUhmqVzrNjoyvnC+7k3nZHkKybFhq/a/ZenXO?=
X-MS-Exchange-AntiSpam-MessageData-1:
	gx1b/DBe+4+W3AvHwLSik8DB8E9Um1Ai6lIX0ksZAYW+0D03N4zDUcfr
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e998f8-83db-4759-c688-08de830ffb81
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 03:56:20.4735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czMGPzmsig9dgjOkjWXjK6BTmuOB7jyFsrNoBgOlikI47wmWdKFbh/Ap/zyUkQkfjHuusetthOxkeTwRiHqNozfhj7E6IsZ68HMKspJDbkurvJNiBaOLJfcTJNA2XSI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7942
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268018-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dmtf.org:url,uefi.org:url,os.amperecomputing.com:dkim,os.amperecomputing.com:mid]
X-Rspamd-Queue-Id: 7F24F2947E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch adds support for the
Management Component Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

I have included a cover letter to maintain continuity with the
previous set of patches that were submitted in series.

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
https://lore.kernel.org/lkml/20260303213649.237851-1-admiyo@os.amperecomputing.com/

Changes in V33:
-  Removed Helper functions in mailbox/pcc.c.
-  Used static helper function for writing to buffer
-  Inlined code to read from buffer
-  Corrected Copyright date
-  Moved networks stats to the end of prepare_tx
-  pull PCC header in MCTP sk_buff on error so not duplicated

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

Adam Young (1):
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 365 ++++++++++++++++++++++++++++++++++++
 4 files changed, 384 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


