Return-Path: <netdev+bounces-303136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 35ivAnSvQ2pYfAoAu9opvQ
	(envelope-from <netdev+bounces-303136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:58:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD036E3E7B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:58:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=GPjt22m6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303136-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9FFA3075432
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C67F409615;
	Tue, 30 Jun 2026 11:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA3408617;
	Tue, 30 Jun 2026 11:56:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820594; cv=fail; b=IM/iI3hJrCQL4iYaT58jNIU5Gr1w9jjKhXvi8R0pedfpZUmTCl5zX1DEcHuJojEhNhKkF8cqnUur0L+AcrSs8/TRGN6gWoVO+ePQYZnQrb4SsP/rGkBAxBjVfkJ4u2sW/lrvJMXEpdE1B5teHRkM5stB9MLTyU2mUWYf6RF5P+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820594; c=relaxed/simple;
	bh=+4yol1rh02CzC8V5s8NwIRiT+vWQnQMmPgCpJwimOjo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lvWBh7cT81phbiDda03AjNd7+SbVtABy+cHnJdelfjqI0i1ReWmJxqYu7Y6vPtOz5/8EuAPVrHdtv57SYPR/G/7Ain1CDiL1+w4yaVKjpvBB22W/KcNtHY/XH1TWAmK+ccnqJsZwXJMemWGnk8gdliNO6liFzDVbX4o8hNMuwA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GPjt22m6; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1ffWw5WC7qoHIWMkkrBXIt74cCQHiB0nTcMMfOJrXt+5Ggf9eoL7fDcrLSW7vphxWEDpvPmlKa8ojx80DTgs+GGHCpePSU405cFn0+iRNXOk/9AVzZy/c1Y6MldO6JLKP82SQZ78wD3JoFsIofs4iA/3YNfKXYaTQ7zjq5nmEGI2G0fSOXsu7ZcrjQJF/r27jB4kotgFm+W+LpqhLZXN2b/9aukdQSyMZqDLYxzy81dnaFVhI7Cs+jkNLYIq73XrSS9m0Tr2Jge1bCcuSKHLh8LhvSblewEYqeBGXCvmyi5EkCmqpCz29Njxs+UTTfBTxRKSGjlEWcbQaQYL2xPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hYB7yA8RpTvdbuW0obSHGKU8LebNS+LMT7nAF6kC6g=;
 b=scXNY/ao2eSSknThsrOkI+5pSqlUt3mdSekvLr08fzE8zPcubNe3LzOziN9qQFwBkZDKNrsgnMldmQXdaeVFQVMAfxwyB9PToMYzTzI/0j7Kgqun9FS9R42yAmOEdTktG5BdzwMBonr3Q2nczNgKDUkVdKhD2oREstZmwiHaXJxuMV+dreYL2aVz/6I5g91IJZt5CW1ve+UJfFuzBTV/46gRhPJH0ERg80ZR6IR+myBqD9XQ9rECKeHSj9ep6L0mZjeMMj2jBEB0aRUchka1BV9IpbPPUEq26mmnLbDmHGLKR5fB9MyxrzdtaKGOhQyq1kTOn+i/PTYMcOzSUaOcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hYB7yA8RpTvdbuW0obSHGKU8LebNS+LMT7nAF6kC6g=;
 b=GPjt22m6pz15bAW8Btl54urZbT5uYyZ3Io3GGjY+22TkksM41nK96Uk3eXghTAYLufvFr+EoR7KIav6KuSUb/d3gEH4AG8tc3Px7wmEQx2ZFXhMvlkriXoJ3EffbCd2IPr+Vlr5DDs/lJx3FMsLsAR2YSkWF7tove7ZLIqmU80hDWzliSuvfEtPYp67sSruPVAa/6JW6Zq4kxqiLv0SOdO1wul9J6zo/FwH65JFzZ+SayrWPHvhKOqRvFgSwE1c4UjBXpOoceKthONPg2rIk+5y0dZj/JdWSHMWTVCuqPspnGKYjCe0hoAco44bVCoEq7O1HTI4TxjQD/fxHqgYRow==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BY5PR03MB4919.namprd03.prod.outlook.com (2603:10b6:a03:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:56:25 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:56:24 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] net: stmmac: L3/L4 filter bug fixes
Date: Tue, 30 Jun 2026 04:56:19 -0700
Message-ID: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BY5PR03MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 501424a5-a3f0-495e-0f88-08ded69e9c10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|55112099003|56012099006|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	X/NJHXGxlW0S9soPPo1KeLuelvMD3Pb5FqNOiLgdMSlo/zUY5aiktxIS0S/OXI/xngaqmrrs/oHQhtYn9XfFn4372YcrWHHFkjnkDs+Lt0gN2oWk9M+hbRWhyQ5IVejOiLAw/LgU+/UXPsEecP/7mGhpy54arlUcaFF2Qihs9w+Zdn0wTY02tbWak+P/LLV7Bn8EhX9WSZD4YB5ntAzO3meGubGCKCArompSga42EbzicxooN8LEpOBIH82ephevCqsmy0x7RHECtG6ZbiKsABWZR9TNW9U1iHj4flduI5WC3K4fPM2IRMbS6n/uJQ9ezMf0I5e2uLThiPd6l9G0lxC15E9tUizYb8mkvgne9insQq1ZtxqGVUj0xywxBkXkkPViNf3VeJiu7UsDG+5boG6vrK0V9MlXwO3O7WdvSNj3d0gaGlTAXxQHNLndVuJlBuSLDNpHL738lXdlJZZjVwCMzwFlU1M+slw9xBp06bNPplA7nZNT8+OSMSh1JFZVx9LpvTWpp3Tlni8tiyHhhqjB2AVmTlGevw0454WuUYSI3Fkn3PaP0KIOHCmt4/1wybNsnm996ZZnH9Ss4ARfsUfuFl+TlkEQVbn/CvDjnqvLs4s6Jy2PnYa11f7Ooe4a0kJ+lykqmyZ7aTbi6HrdenO1fwfBmahYN6DuALPTrx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(55112099003)(56012099006)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iYli8k2uY26mNCiA45uQo0cw9sufFlLByBv5P7vv7NIVFkqzQhlo56DOjfyX?=
 =?us-ascii?Q?R4JPqLsSXEt9eCksY2DL+UI2Rs1VPWAQBmzGbMwa2my9XEvvNAhaPVXMn338?=
 =?us-ascii?Q?zO0g8f1ZIX8aP9Nr0oyU18KTB8lTDfydejv/msBZmiu1b5h83fY60UJ+Q2ol?=
 =?us-ascii?Q?hU/3jcnSibfUZG8v4JuC6CsYIBkXJFQskfA9eNIMialwJQz8A8lcsNiZ+n+n?=
 =?us-ascii?Q?IDwfvPEouwMgG3pHyBzoP1F9zvMZ9P2weuynh9jlktDnmgltWb+2qesrhrak?=
 =?us-ascii?Q?h/EYX3sWbcT8I/4d7fZ4vlbMR4aJmtqbh38GY+XIG0EN7sE07AwwsC8+XI69?=
 =?us-ascii?Q?nuF8q+uRInd4Wzg87u359604LmnjH12QW3f6mynFtOeQMbTbQ+SwkVxAlO37?=
 =?us-ascii?Q?1qC1rUI/wohdMN6B6nBc3O0v9kGm9dTW7Piu1xz6trVGnnlxvZ4vz1/ITh5T?=
 =?us-ascii?Q?UpV0E5JC7Pz5BPZUw7IzVlvA4kTngXINq4o46qrQDeawgX/FVn9fei5eLhe2?=
 =?us-ascii?Q?K5iXUBRsjbPvqqlfcjLuZsVAf6B0H2LSmp7vBzz6oztGD5GRToqdlvX5ir3X?=
 =?us-ascii?Q?NbhUqB0focKNuv42B+B+qTNfuXLN0o/wddQ4ZZC+6PjwdptX8wIRxGA9wzib?=
 =?us-ascii?Q?eJWhAxI3ONBkSFVqtXooC2PsUtY2ay/34pyfH3iicoOVgj2TzOPKMihceK0K?=
 =?us-ascii?Q?KfbviZrJDIzZbgyzN70+Rd5W+/T5ZPIJ3b3P95WeNOeiJePgGdBMMSV7+l7Y?=
 =?us-ascii?Q?VFSC5YjrQPDH93veziz7KSSm30avTYjC2d3v3JkBh2gXdzXN+R8Hh88QzsVj?=
 =?us-ascii?Q?3n1YyFltZqqA4yxVyChbysJLAkcSg2HUOQIYgZxgPmqegLqri6kF/U+wopjo?=
 =?us-ascii?Q?nr74tc/Ix0mGOgJasFghNfcq/ble7k1J9OCmVamOiQS93n1qsAKM+tJNgIUH?=
 =?us-ascii?Q?pNs30gr4hRC7bEPd8wRZA+CWJFfULiulGSZj4l3RNPp/NYAtXwwvEGNtpRe0?=
 =?us-ascii?Q?sP3798xHwLfBT8d9iRdkeNsaG20K4Vzk/SPKL9MTXZEHAKjwqetlT+NCJFHF?=
 =?us-ascii?Q?TIdQxUinwq33JCE3QGxU1+si5rF0IIv/HS2+ybWNXeZ/NfAQSJvccbSKqAMp?=
 =?us-ascii?Q?yUlsqa5mOZgC2hnT+thY9dd/5t47F2CtodWNKXvVw/9/Qt6pIuLdK9/9bGMO?=
 =?us-ascii?Q?kZ0YvoaFNd1G3BmusMHq1QT86Wh0dZ80vUl86gfM/0mhlHy5fV6yJvXBGHeU?=
 =?us-ascii?Q?ZcE1SHkcqNWgmXZHCSyJgxSrw0azpoo7rY+6Y7xAoZq/202SZRLW+97+q/Ed?=
 =?us-ascii?Q?KVfAc37fd8LBbwIfKvW4I2oH0CS3zd9SFmJtelDC00vpBxJw7aiz1pYHmqTz?=
 =?us-ascii?Q?3Mku011IGphc4b04ydsyDga0f5MKGixDiutrYY7JC3kqMbbX4kwtSblmSomE?=
 =?us-ascii?Q?9TXk0tBerCItv5H1hvan0L+9/vPAKqJO7jD3e+zGB2WSXlUBG6WQ0nl6nFLX?=
 =?us-ascii?Q?RB/iBBJCHQtdVWmFIr8/ORppLXWIfndmVRNiySZROrA2BifibzJFi5aurqeB?=
 =?us-ascii?Q?aQmjXd2RtJApdwl7hlUXGMJtdHhyE+lHdkno9gpzcKm/K8EH5wlaqdMGieME?=
 =?us-ascii?Q?RqXi8zj5d6fufgTVDMQ+V2xI8LQZ/bZk43Hu/BCOdNXpy8V5iUH0G568+bg3?=
 =?us-ascii?Q?N75bjwLgdI1X5ROBnqCtLONGfuqLzXJvVrIAU2St3ejs3ViLvhiaXfVUcucU?=
 =?us-ascii?Q?QE5XJ+Nt04wc9pACRmx6oaWg5pM5oOVKBI3C+S0j9hNXzOE+L92c7BfvDtXL?=
X-MS-Exchange-AntiSpam-MessageData-1: fPCj7T0hSe43kg==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501424a5-a3f0-495e-0f88-08ded69e9c10
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:56:24.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNm2a6FPNcVfZoqqgsrCk+1Fi7qRGwWvYaiSqcudDMcS8DuKp6fIulH9C2a/j54j6Gu/9rsSVN7P2o4Ox7ZT0cNYUK1nlwBF+DEhcrdlo2q/VfHL6/HD5TrztT6fnXLEDVJSbQ4KEIN2xQW3gQKlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4919
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303136-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BD036E3E7B

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

This series fixes three bugs in the stmmac L3/L4 TC flower filter
implementation for the XGMAC2 core. All three patches target net.

The L3/L4 filter match count statistics patch (originally patch 4/4)
has been split out and will be sent separately against net-next per
Andrew Lunn's review of v1.

Patch 1 fixes a register corruption bug in the L4 filter port configuration.
The XGMAC_L4_ADDR register holds both source and destination port match
values in a single register. The original code overwrites the entire register
when setting either field, silently erasing the other. This is fixed by
using a read-modify-write sequence.

Patch 2 fixes the basic flow match parser to properly reject unsupported
offload requests with -EOPNOTSUPP instead of silently accepting them.
Unsupported cases include partial protocol masks, non-IPv4 network proto,
and non-TCP/UDP transport proto. Extack messages are now included so users
know exactly which part of the match is unsupported. The -EOPNOTSUPP is
also now returned directly instead of using break, which was silently
discarding the error on FLOW_CLS_REPLACE operations.

Patch 3 fixes a stale action bug on filter deletion. When a filter entry
with a drop action is deleted, the action field was not reset, causing
it to persist and potentially affect subsequent filter configurations.

All three patches fix the original L3/L4 filter implementation introduced in
425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower").

Changes in v3:
- Patch 2: add extack messages to each -EOPNOTSUPP return (Jakub Kicinski)
- Patch 2: return -EOPNOTSUPP directly instead of break to avoid silently
  reporting success on unsupported FLOW_CLS_REPLACE (Sashiko review)

Changes in v2:
- Split patch 4/4 (ethtool stats) out to net-next per Andrew Lunn's review

Nazim Amirul (3):
  net: stmmac: xgmac: fix l4 filter port overwrite on register update
  net: stmmac: fix l3l4 filter rejecting unsupported offload requests
  net: stmmac: reset residual action in L3L4 filters on delete

 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 35 +++++++++++++++++++
 2 files changed, 49 insertions(+), 12 deletions(-)

-- 
2.43.7


