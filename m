Return-Path: <netdev+bounces-303184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zgW9HbPGQ2oWhgoAu9opvQ
	(envelope-from <netdev+bounces-303184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:37:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6736E4ED0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:37:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=DmkXT9Ai;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303184-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303184-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F563159408
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5238236E;
	Tue, 30 Jun 2026 13:31:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7CF343881;
	Tue, 30 Jun 2026 13:31:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826277; cv=fail; b=sgg6qndNoF6mTUzyaN0Y09DjxNOA0T4pNNp5uTBADKT+mcRuig0bkIqUphipKtMTi44JJ5Wqd41ndPzjKt2ltqTvneKeDvpovM6Z1hPatXTZhBh6F286FZ4GvyJw4x0ANfrsZg15JezkqtSBwLHqlmUXVIf1yWb1UazV+mYhY9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826277; c=relaxed/simple;
	bh=0lmVeh4SJ7BGPeXP9Dy1BYwHsM326Isky2NEG3V9x5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJdhhPHG6iFzG0uZOOJcqdpHu74j5QZysAMUv4LU28MCHEQpbSXvPHG2/cGyVWr9JmDAM8umZhfHIJRGl2DHEn9NtuJTaKyMKxPXxyk9I3Ok6iwkO6sxUo3o5y5zvxRQUtSy8NZ658QAuPc6xtQdmhFhYeZxbATC9mQt+NHhCPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DmkXT9Ai; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0aTZcIWQGR9Fv7BN2pwUp+Q8e2cB3j0P6sH7hF9oooriB8quThNSdYd2oO9mpv+JYPs+CK/nFqNAa7NzBXM4I31DftlLvt/GYsgAXFtNZWn8dPc4XE/WhsyidqqWTG/eIwsbm2XVyu6i95x83pnY1cqTl/Cu/V2hyR3mme/gUP3xAUVKwCWi/Krl5j0aqf7pZorduzuLHAFQONZfQB269rMvdQN+1C5blSHujxvD+tnibWlLfY4z8PY4ay9UZ/so6mKwyEQxvQStJoCrSL5T1AipnWKyG67aOwa4f+lYtdTzQB0d/gD8V2rmmCaEJ1xdSBvuJ37GuCG8pCQyr6d5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNCW1PsqlgqnlApkK7hEfJnV1Ozsdbh1IaK4Aof6MB0=;
 b=NVyTyB0HEkXAzr597hZN8vJZuwm6bDa6iw1Fu2CjxeLxooHadjNsyKtestVq2utu2EzSV+UNlVRbJFglYWaLVZUzqwicGnYRjB6hrjwk3MB6t1r1ApjEqbFF+/6x7HAtYJsDPjVt0uNbtWnZAm++mxz64g8smwlxs5wh49R9zxvmbBkA7cYUGmmrd7aLta/+bVlR3BwEtY8vABkc92Px2AFaCVhV4+fYbeJMGRyNHGNc7nb8Zwh+7d+tPzntYHFliEkGmaIqQ5C4aiqSqAHjPXkPqgtulAMNCm+fSAN1p2zZ8ouEmEZLLfMq4o0kyBXqbtg4u3kcthvdm6uE0MLEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNCW1PsqlgqnlApkK7hEfJnV1Ozsdbh1IaK4Aof6MB0=;
 b=DmkXT9AiYnpRFbLEyb2HUm+xzZZLQRb0dfTLkR1XBW2xngW0BAwxzbt0GNSba8AlmOUsbxlLWWNtQKVS0G0x7cFRMugi/OXg0zH38GEYUK25/BB9A+1ldw+gn2hLtVSYI2GFjtuwoMSGgM2IYym45j3cjXAe/m+B6ppIW0bh+K2O7SgMg5bwYnpNeS6Qv/LWb0WH9PI5McMV2POcaQsqcwvtr81jH9B6D7zqx9f2tffOQ/VA3LUdsGu8gLiy+ele7+O+zcHT5ssPjdg6BiOaUIpBeqiFwsi5u97pmcwcfZl0pJa82F4HHtvWjLri0YBlK+pU9luOjTYHYo6f+VZYdA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB6955.namprd03.prod.outlook.com (2603:10b6:510:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:31:12 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:31:12 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: dinguyen@kernel.org,
	maxime.chevallier@bootlin.com
Cc: rmk+kernel@armlinux.org.uk,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property support
Date: Tue, 30 Jun 2026 06:31:08 -0700
Message-ID: <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c615170-a9c4-4686-7a0f-08ded6abda13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|55112099003|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	30QnC0j98IfkU+2CAdnc5uU1+04zzsBlbXpqyq1hRFHUIrWjQwPkJKLHqMdymhRREMc1GqQ9dwZWYNoR79gkcYEwbn/L96nvsf9N+K/yaRprGYAWSJO1ZR6M/T6Aivnp6nbfMRFiuFY+vKNKiCha2IGoa+BEkOLJl/2XgseAZQkx1Ym8tTPv8wTUhA88YcXoqUzSfhSDYDax10yB1QwpX/FYmfjPjRxANBnWe8rCi4DAg7JDup0QIxLYPOy85KYz/CqscTuPHAPxMdOGzhMpxo5Q7DPZE7T7WIjgAaLFUbS3KeuExlW7e09X4eRl23C8hv+TEpNejQVwQwJHJkSZB9UwudXLVFrDzc8fdaeZjUL+0fcLE9lBP6K2tXfUQ0puObqC2w/5AmA01NHHw9kk87YYBzDErmznxnHRO/iOxsOzyRAHU2TYGXFa4TCSbjikUUFY5emFcj4eN/gSD+kDD66ZuJSJ5AYarh1E9vA5C6sUgt86waYmx1hC9DqJ9TVdggErI+OkF8m4aqdWPTH4m6CB9hpeIDY+3KyZ/3vaFOCOsXWUQxqaf+aXMoyFWaexE2EFPDzRZXJYK99wXv1okkY2NSTfDXyPWLtah9tV1X84uwnUI/2+90fIEPPHXpUgFIVXVC5iP8jbWjGJaihRm1JASX+1VAGsuxnqWEQyzwA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(55112099003)(22082099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1aHlWMS1F/4TEQH7ol9+6pyyG9Uj8I3laUjJtDkYnWd+ura0fGF+h+T5rol?=
 =?us-ascii?Q?tnP8d3u+Rosp9HP4uGRq3OoHtkmLITXFgqTXmlhR5LCmGqjOvb4UItWl4s7q?=
 =?us-ascii?Q?H2wWamnxcGSX86WnaHyv1wPdKSs0kIpqbU+4gkAZEfXTb5AG5RkPLxWjPdUe?=
 =?us-ascii?Q?oNTtMjOFRTpYBX+nCTn+cBBL41A+brmUoAQo5onnjFbFQfgBjrI+G/r2Arj8?=
 =?us-ascii?Q?VojstMloGEUzGfqro80aLpfuSlA1OoUYsRikZwHLM0jaBIGYXZ6IqqVAaSmV?=
 =?us-ascii?Q?tAZAKE3QJNUx638/WGCVwOboA4PnzQvLabfrjM+XsDEwZJc2RuGYh10gOeSy?=
 =?us-ascii?Q?25KULyV+DkrqJdnaj1Q0bvd9PAT9zwjWMr763C0HcFewSL+KRCFCX34lqc0n?=
 =?us-ascii?Q?z63vGZIKBPQ00VRRC0bKimpq2H7+Dieok7a8f6WQO56gjmvpwWa4wBNJWXiA?=
 =?us-ascii?Q?iEsKBpXB+hjxleozHfKljDAs4QTyF7+jwaUWock3b04ddikLUHfKyPmL5Oxb?=
 =?us-ascii?Q?wcfDm/8P8Y2BNEkVj+M7eaKjJ4HGJOaiggURGwtDsxSQ1WcfdJ96qV8Sl23Y?=
 =?us-ascii?Q?jZBymAQD/LXVBjc4vjgOBFVVs5kqpH2heWppR+7Zpvqu9mvBlLGNuvS8OlIv?=
 =?us-ascii?Q?436PIJfvyZZJ8tRYoE6RrbpDsDms2SUdAdTEu1a13QbKF0Xv7WPRIHQrBDE3?=
 =?us-ascii?Q?nKei+LCSNfwWeyeZbjatp6GLKyC96oyoEcmfDWW2n2cWrwCpDrNOIl2MeUgn?=
 =?us-ascii?Q?b1xeWC6vJl+rbuZd6BOgL2viYNq15DnCRZYHCuBpGK/5MgUDyHzCLVCSKVhy?=
 =?us-ascii?Q?F6LBihTVXsDqB0frWZLv5GstLR1aRNOpONM5g7OURwsNdu+/2nCgB0tVmSgc?=
 =?us-ascii?Q?8xdQgVjGvYeg4eY+s/1czkhkmyN+xPeoSSFJAynn6tL9NUKVwFef0w5oRl1Q?=
 =?us-ascii?Q?KR7gfBXzeWpqwGHbqVYiHHNWJ0dfC9vKr1wkKWJPecYEc6gB53hfIDwm//fU?=
 =?us-ascii?Q?11WCmPp3n4cEF+41H/2idp1XHbMW/49p7Ws/aOCIdZ3RO4VlCYPgURrOywWx?=
 =?us-ascii?Q?lfQbsxBR5IIKCrJtVdtjZJ7zXMsTKRmcAqFk4sfyY7E492M/159U/KdpHGFF?=
 =?us-ascii?Q?w43RXYRQIpneq5faSejz7inbzNqnkISgQsXB9SwnXHAFIg6fAbgIy5pCXZQN?=
 =?us-ascii?Q?w3Mu85M4bsBesyMKqmCThjkWDZGJ0McSJe3AZhklN1K4S1/e2Iw8uEG/LKy1?=
 =?us-ascii?Q?KLkJ0OYLXBHWDJAjStnBnEyeqCcCAcVzURq/M28R0lsfSSN6ZQ6xrnm4bh3d?=
 =?us-ascii?Q?gmn7yKnHUP2uIhwp/6eEmznXZrGZM/c1oZRWBSlmXriWeMhYdf5C6mZhk9oP?=
 =?us-ascii?Q?iH0VsLO2MXPLa08oC4YEpB3mS9ClL4XbHRnsVcpZ1fKM4JLiN+LwyWAR7CNW?=
 =?us-ascii?Q?Ts+AdMLr5ZK/Tfw1Z/+pqzpc9uUcwuLuoD9XfApF4ox0j8uONw0RIcnNHP66?=
 =?us-ascii?Q?rAgi62/B3K2g0MejUeWTdIl2EIaQ20jpV1ELCUMG4mfHWJwcXigWr+B/Ey/d?=
 =?us-ascii?Q?TcnvwhIZgzny3xAwk4pikVsMFsnC3en0GBL5d9RQEjTck8N0F4Pp5lT7IYd7?=
 =?us-ascii?Q?RL9t6WuiBA0JuxjhLKZDc8cqxvisX7v/Gzn0ZUQjvqDQjsIacY5XCX7pBbsr?=
 =?us-ascii?Q?ejxmgAS0NRfjPhkVXCUXhMmspYYc3KnNR59KU4bn+5SWoCjbvshLP/OBd80G?=
 =?us-ascii?Q?gS785SqO0MQa31iwwc6opkD86E7ZnsBSs56T9wjR0GpgvfpT5gzOUE5thH9P?=
X-MS-Exchange-AntiSpam-MessageData-1: 9M/kLmfBpu021g==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c615170-a9c4-4686-7a0f-08ded6abda13
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:31:12.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZR/WKGQIxpFPLBcdAhZKVgLZVfm/me5CP1p8PtKWVfyWQVMWXFNvyKLxMzEy0EVN8M7IMlPpVC6+/IRD+OQD1kwiDVjyxHmGyCtc6N1TBtXuCAcZPsgKeKDetwJqEOU89YlBvcm33z1KFF7Zf+HrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6955
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303184-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B6736E4ED0

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

Russell King's commit de696c63c1dc ("net: stmmac: socfpga: convert to
use phy_interface") replaced mac_interface with phy_interface in
socfpga_get_plat_phymode(), noting that no upstream DTS files set the
"mac-mode" property, making the two values identical.

The Agilex5 SoCDK TSN Config2 board is an exception: its gmac1 TSN
port uses GMII internally in the MAC while the PHY-side interface is
RGMII, so mac-mode and phy-mode differ. Without restoring mac_interface
support, the MAC is configured with RGMII instead of GMII, causing
connectivity failures on this board.

Add socfpga_of_get_mac_mode() to read the optional "mac-mode" DT
property and store it in a new mac_interface field. When the property
is absent, mac_interface falls back to phy_interface, preserving
the existing behaviour for all other boards.

Fixes: de696c63c1dc ("net: stmmac: socfpga: convert to use phy_interface")
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d288..6a6837c4a414 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -69,12 +69,30 @@ struct socfpga_dwmac {
 	void __iomem *tse_pcs_base;
 	void __iomem *sgmii_adapter_base;
 	bool f2h_ptp_ref_clk;
+	phy_interface_t mac_interface;
 	const struct socfpga_dwmac_ops *ops;
 };
 
+static int socfpga_of_get_mac_mode(struct device_node *np)
+{
+	const char *pm;
+	int err, i;
+
+	err = of_property_read_string(np, "mac-mode", &pm);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < PHY_INTERFACE_MODE_MAX; i++) {
+		if (!strcasecmp(pm, phy_modes(i)))
+			return i;
+	}
+
+	return -ENODEV;
+}
+
 static phy_interface_t socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
 {
-	return dwmac->plat_dat->phy_interface;
+	return dwmac->mac_interface;
 }
 
 static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
@@ -650,6 +668,9 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
 
+	ret = socfpga_of_get_mac_mode(pdev->dev.of_node);
+	dwmac->mac_interface = ret < 0 ? plat_dat->phy_interface : ret;
+
 	ops->setup_plat_dat(dwmac);
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
-- 
2.43.7


