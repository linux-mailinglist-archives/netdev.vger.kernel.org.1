Return-Path: <netdev+bounces-282035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG3kH3b08GnUbQEAu9opvQ
	(envelope-from <netdev+bounces-282035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D798248A3ED
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79ABC3037980
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57244E05A;
	Tue, 28 Apr 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XZgNfEIA"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970BC33D4FA;
	Tue, 28 Apr 2026 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398721; cv=fail; b=T2BpedRKa6/9EmBVzeZEJ/7/lDuf3PATtvO3LY3WvPe3vBQBaPm61PDIjvIzGNKpiogoRVWNsAIDldMTinYEZIIDEnHhi6PRUxmD1pDoRtqAM6GEs4qI/R4m4+eQ1DF0kX7KpLTCQjziGRvuMD6bhbFeUSuY50VnGYKAhNbIm1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398721; c=relaxed/simple;
	bh=O/G87Enji2UqoqfWgo+JD0NkYNtZZ8q9AkrM22geCrA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LGea+rxRRjULaMzim4A9xnTzyO7aku7FOylK/fFqF5Iw+gIWWUaVt+FrOPr2jEIZtmZcn9HIYuhrx/JxxViO+oVonxmDUjDskAk4l8PAQEkqxstxNfFh5oPprsh9BwfXgd/VQY3POsQqJRcHdLfZPQuxQilpZS+Q1NEQsLWh1CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XZgNfEIA; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egWAn+0IFJNy9UuNJodkiaa/6MjPTVjzva9BTO1MgpXNBjB1xP2QjfroeWPq/6BLGTkp4gpD1OVj2V5vdOD3zEozDl2HM7GzyzV7wHzp4SL6LtHhwV9yFF0KhBMJsHdBlmjtjl0axjbk+365opmgQtzuM0jbecl4+h1dj1crzVbc/yxZBpY7oDOOJaQ6aBj4Lgfbb4KSBxiRGEz32kIwVDVRhy7Na4igWOsNBmyNFMzqFbRwSN7382nd/KTMtxNSkKyHMLPkukTr+UJS/pEdEnm+LJvneYFjalismO2aQ0k7/rhRrLMJepR8XOwsM0Bz8oRlRebmqnS0gEAno1A7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q60+A0867gDkmnWVuMUm6FddyWly9G3RhupCL8tKSOw=;
 b=d9pM5lBDHxGW19Muigp5CVhfOkslIz4ar8dbr2BusLQ7UYKFvD6NnVxTHgcBaDH7/1Ozdu+3ruwg/WMe0QmBWaJupMwocMwSmAcQ2NKHKpWeEnFYY8vgiRoiENHCkw8S8L/9ZaetiQ9dbUK9khcrNOzFqZHJxFcnv7QNml+5s5FXtGlX0RH5kD2GI9tv0WojXGgTwEIm0kC+IDQJKG9oFFgz8iGpklgHIPIfGt0vbl/pssNVDUDEe1vsHT0+nBEYcio3hGBna6rek3/CiXTCY3hqGJlUkQRyjiQHRV/hewK1hzeDeJsldhLnQyVc/OGxf5eRd9cvqcr5XTtIuJMwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q60+A0867gDkmnWVuMUm6FddyWly9G3RhupCL8tKSOw=;
 b=XZgNfEIAHzmbUNrD6b6TozNCuL3PaoNntc0wurQ6fFZpUi2lekDwIZhj3x4a62HfqIbMXVCsePesY4Wui1hfCaJfVvNuZjXnvg0PiR1nYcEvqhy53X7z0DDh09H6B0vu9uUtl4Q5FJaYUIa4OXNxuErOZIsnRlO7yRDaf7O9rRjeUNKgyzs7nkL90b53FV4mXTJEe7KJJ5UKa1rGxRAgiaR1VsO2knStOB8Eu9GGcSYyneuGqUgy7UARs+O0hvv1TR9JnJQ6Rlbr6jbVp187w0W3rvmuOUzlFdk1alOuTBBSw69nvgBSE7dmOt8+pqU64FLb6cJB29mqnYZBcpUrZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PHXPR12MB999232.namprd12.prod.outlook.com (2603:10b6:510:3cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 17:51:57 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 17:51:57 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	dtatulea@nvidia.com,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Joe Damato <joe@dama.to>,
	Frederik Deweerdt <fdeweerdt@fastly.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/2] net: napi: Fix timer arming during busy poll timeout
Date: Tue, 28 Apr 2026 17:51:29 +0000
Message-ID: <20260428175134.1197036-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PHXPR12MB999232:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d04949-c15c-4dad-a10c-08dea54ed78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Xr44zr7g/sAAqaFDj2bbBHU8wzw++66lxSDdP3h5Ceie8+fGBhh1bzp7d3EmBVZ3AeXQxIwRgAgWIDC2Kc7VVWvFcktf0vD7euaSfMgvzDFJ3lso4zpJ+W1bTtGDopVl2QZCtZy9yRF3//omhWD39LE3u3FVVicAGYcr/xGJbmXxYUx3dT1nOddoiwI0mbkt+FdAeJ7DPVd2f8avKOOq+Lvzvm0H8F0xPxqvVPbESlLk5FYsnW3S8m1ig4ejXNFf+aBVICpPBMx+ypMAeKT15e91/ef/i2w86ZK04UJFVJ1QTTGRuXh3EXTq6gU/5KQr9J4s9EN4HM/snH7u2k4P+GHq05l4V0rlMGxMP43riKcc6rDYqPgrgEZSwZBs0dw8TuxiL6WrNuuyPjAN35IqGXH1PAro4WEG1vfi/5INgcL37fVO/fP17SLv6TICB72LKyB0WCaMVWgDHDK+1FTcIqaYSDt0EHFtQw5hlsT9tPttY0zXgyM79AbUMjoj2IPBJsUbKnQOrj/woqDfuG8fjDIIEtPDEZuzhaRn7v5CMnYYyvVhws2MdBmmslqdNbCmL/CQLfm12rZDSnsMM2/B4lKqgC7KtXH9KTAwnvGmpSLm96rH3wElXtKELGHamXequ0zWfm8J0nJG68epBX3yRlyjL6oF+F2U1e+xl5W/ofTRRF8o9CEHvSxyjZ+6eFt0BT5FuaU28dHy9bDoDcQtYCcQA8IxXi/16WcEj2e1jmc56TiCqs6N9DMKaJ8FYNW5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+mAk14OichlDUNcbO26ULWGYKJ5AaCRFAx/QU4zdZ3GkEAChrbjeXGy9GZu?=
 =?us-ascii?Q?KUjDgVmsVHCDmd+v+oxKHT9yxI6MXvSDqTzFb9n5khy+sWoMhq+dhPDn0Irz?=
 =?us-ascii?Q?XATXxOmaY1lpe1okUjUe7MJc11ObluzPGB9wKqHq7uPfX5coUDdA4z1JJnoy?=
 =?us-ascii?Q?tEDAqKZb3cswiXPSH3xZt7j8oMhhBCNQB4/+qY59Un6pT0AE7DGYQTVpcRDI?=
 =?us-ascii?Q?w2TJ2mV22SbW9DYO7CeYSEGQK0zXXJ5gXB4TozSzDf8sWqB8vV+hZNA7Hijk?=
 =?us-ascii?Q?G/4aechnIcBNsJc44x6iBI1tvHByhHk2rZL43mKy4MCrMMXBn8ALgJy+d61y?=
 =?us-ascii?Q?rfIuNXtBfHFgq3EDiNeVDhs+onbcTR3HUZMaBTvALZ8UKj7jk73vJl9oQMHc?=
 =?us-ascii?Q?weraphepW8gKcw/C3i8b9M3m5pDcQd5WFPK4rwhOknivD4S1Yuzn0kTLDudB?=
 =?us-ascii?Q?H7ZSjnmOFvaZtUrsFw9S8rYBJA+UxxTBrMQ5WcCfkXjMU57Iv+yHeXE9k1vY?=
 =?us-ascii?Q?YAMZYs3MuACBt+NcfQ8njn1Nv+wuEpDU0lhzBz4XkCB+1yLTxSdr/aNMsi9n?=
 =?us-ascii?Q?dZogaL0vBdoMVnHtGm97/NY5ExgzMLpGXFs8pOTozOATuJ3cpu3FVtELfq7j?=
 =?us-ascii?Q?otlQ36F4XFjAdLxwRD2WlH5JoYYTceNSWTxW0XW841kBRE0znAHuv2KW1Pn9?=
 =?us-ascii?Q?66hoUR8CxLGBBstRHjOhXoTnkpOS0NMSWv42nF3fQ/oJizke/cg8+QRQLMDy?=
 =?us-ascii?Q?xC+hYnb+XTCETctr5ZdQS9yeCvS0Fk89tH5JkXZQPT6HqbEwdUgV5LH60LYO?=
 =?us-ascii?Q?Yfiep7uItMqv7ggeKYQcBWUHDyj1NLajK8C+BrfqBn0rCvVv6OW7mKAgBXRI?=
 =?us-ascii?Q?Fgx4w+PdzOshgsl6pbPzueCAfXMsmps3CMLffaNxpdMHcnQpJaIWwdyCbPHZ?=
 =?us-ascii?Q?6V7wUocTrRhqoBMCry3pfkWrjv7o1OBGTX/8fdAJLVROX2bPRdtqUNC7Hqpt?=
 =?us-ascii?Q?g2XbxP/DLwViDhQo1LmrTS07oYiGOJ2RspdpgYooDVW6AFPya7nIUBPmAnjl?=
 =?us-ascii?Q?BUNix/g6j/YuneGwxbpb7Ujj3dYTffX6c63b2CgSHbTqcv8FXJcWkFJ7HHrL?=
 =?us-ascii?Q?Tdb53UARhg/YhmbmAch2RTOikgRtugJlezCRnYFJL86gdw6hkpob6uqPG4iR?=
 =?us-ascii?Q?006wLw77478L+bennUX/oH2JPGbWCidiy5QuHME/ZxCZyY1nLJyA1Blo9BAw?=
 =?us-ascii?Q?XA+3kVuBLdgkuLBbgksa1pGqaHbQAXhQ3buCOahU07iKuUbqSBiWTrODmMrU?=
 =?us-ascii?Q?xdQAdlI/oZTb8lSEzJ7pK6bVD3kfdVmKjMbAVQgy7PQE8DyjfntY8xFVYnLO?=
 =?us-ascii?Q?F3KFn3D3wLGG6r6NfdcGkUtihtyxc/zh3orgNt73Fi9seCpI/hMXF3rxgd+A?=
 =?us-ascii?Q?Jah18ZTBgWdLiaWRkCgnkiltV09iVrUqYNC9+xGTOlX+DuGZ3xQTBG+jchjx?=
 =?us-ascii?Q?qJwg4latGS+F8GT+EV8PLJIyD34Ucn6srimcjzlfPBB9BbJJIEUh4yWFTAJ7?=
 =?us-ascii?Q?ZOi+4luBf5UU+CC50DK7L37bJgdsLLlphUgcm11zlDzv4qNLRkEPyVT7Pd/V?=
 =?us-ascii?Q?gnV59/P/Zb8fGunZt2UjiQNw3aeUHknzLPb3L3gzJv2g0QLILIe0mT206FCu?=
 =?us-ascii?Q?BmsKmEz5HLpU99+YePn/VaKA4YhvPKJpMbASCbKtlfK3P/albj0F1B5wuvaL?=
 =?us-ascii?Q?N2zC+j9ZTQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d04949-c15c-4dad-a10c-08dea54ed78e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 17:51:57.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSSkjLfYXnsK2i1nRln6KxzuO6KsSSZxCy6DUKgq2NhUvCR/niqq+U8X89V6QQsoLqFDfvXXXEgHLvO5slQ+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999232
X-Rspamd-Queue-Id: D798248A3ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282035-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]

Under certain conditions a queue can be left out with interrupts
disabled and with the napi re-scheduling timer permanently stopped.
This behaviour is triggered by the napi busy poll path when
gro-flush-timeout and defer-hard-irq are set.

The first patch is a fix and has a more detailed description of how
the issue can occur.

The second patch represents an improvement which needs additional
review (hence the RFC).

The strategy for the non-RFC version is to send the first patch
as a fix to net and then send the improvement to net-next because
of the behavioral change (skipping the poll).

Is this the right way to go or should the 2 patches be squashed into
a fix for net?

[1] https://lore.kernel.org/netdev/20241105210338.5364375d@kernel.org/

Dragos Tatulea (1):
  net: napi: Fix interrupts permanently disabled during busy poll

Martin Karsten (1):
  net: napi: Skip poll when arming GRO timer in busy poll

 net/core/dev.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

-- 
2.43.0


