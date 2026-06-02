Return-Path: <netdev+bounces-294350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X1B2EkgmH2qeiAAAu9opvQ
	(envelope-from <netdev+bounces-294350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:51:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D383F631375
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:51:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MwPCvEWs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294350-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294350-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13646302A403
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC0D39A7F6;
	Tue,  2 Jun 2026 18:51:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC639A4D8;
	Tue,  2 Jun 2026 18:51:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426307; cv=fail; b=B0WMLlzLtyJQZpKQK6U2owdZkO6QJ+jH8SLtWZO9/UN2Zcb0BxxjYSBANhns/QfqJ9IyeFtlLOztx5QlJKudzAo5fFc0YKjiEVO9o1InJ7GrUBkK6d+t+O/npqY/Llrg5ysIBpfT/z+tbU16nvpkdTycq2pY9YjOQ340/AymXcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426307; c=relaxed/simple;
	bh=2Y4rJvmSQmw8yEaMPDEzlkz9NUOfh4+IdMRBfrID2ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0gf8OjMKsgpyfFDsH4THuZZogdww64hzu9BiolJMSKpnsIJXAKtb/8sYW4hnPkB7UZIXVs0X73pGVeWPzhWhcPHpqPzptcnrDtOiUQiLX0dj9G5aDHCwD0jt0dT4BN+eIfBOtdu+EJG9nMOXSyWcXicjvQGglJi+kEnE6Bxbuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwPCvEWs; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knp16vAIyL35lIwIPkYd29jOrPz/oiqh5QXb41P5kUuM9Z364OTKV0pDxzHYEDKOM0QwpNIaiDttZPxEQtbtrZEHv4m5SPBEBl2QmDabhv5TVmLDUgT1c8K5oqh8uM43M/qTdggQJhvTe2RVCpbheabaV44QquqQUgUCLKu1NaRY9Mw8fllccPz21pOP6mOWmd6J0U99pKTI7PjRK0/sOH3ch7hfLZ4ExvMkPvQ7C5X6I6Qcl1BP5OPtAcw6GhLLDlb4NDmlxR5/ayNxT9nWcaHL99q7FPDSdWvfSHz2wYeSSL+VrRcQ9qXO7pi6Ysdhj8A6xS+sklDCOeyCw9FJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpAz+56ujJr1nkH75lH6xuGFfjdzgVAMGhqzMIDdAi0=;
 b=NQ0j2w8GrX2tRAyrFgDG69imAQXQ2oTsC3w6+JD6jRq1jiVVP4JPW6/BWuwYr3u0TvPoExNb82fW/wLKW6ah8k8QjnaefZXT2oJ/tFIPAvzt1Es6YzNXSdXpLxkIn0OyXYrA8V8pQTL9/zIO2nxGZNbnSrWdMoyYjXiis0uHtp1RisVfgKD1enpv2CRRgi08TJLbWbpeD6Vs5h87aAtucyZIHjnjryP0TooNdpVMbZudl/4a3ISfCeJIlFkp9U0dvlT0YPNZQqHdYOdq42afMgP4hEvP33aBP7nrW7fSqgDS8aaU4rRiz93yMbbjZcp0Es6qwP+marWvBkJj1j6sKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpAz+56ujJr1nkH75lH6xuGFfjdzgVAMGhqzMIDdAi0=;
 b=MwPCvEWsHCRQVBu05OM9P52gyunr0nfA7ZFs3t3rTnUVe+wh6e8qsCnj7ahVaINnFiEmgt6WT4beH1tbkl5l55wNUNcOUa4oRx5T+0NneRm2FEsH8c2Xt6g7rcbAPRYNmSq+YD2jV8qzklNxfevP6zZBzfIar8O1mcoZHP9Xq2+Iiyn770s9ZHNSXsABZXJVH2U5KWUGNqcNCl1dfGdTGTnAnqR1C/UkDxy1/f00sH3fx71s0V/X6d9KXhnTFMk+tvMo3/swajfh1UclJI54ZNBln28jQZ5Bq/gey9TbVD2FTOAYvW7XsrfYRGXlmcKXNd3k6+OjHc31xj0HACaqmg==
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 18:51:41 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 18:51:41 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Roopa Prabhu <roopa@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Chirag Shah <chirag@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/3] vxlan: vnifilter: send notification on VNI add
Date: Tue,  2 Jun 2026 11:51:36 -0700
Message-ID: <20260602185138.253265-2-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602185138.253265-1-aroulin@nvidia.com>
References: <20260602185138.253265-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::36) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 176d1abc-cf96-40c8-1a6a-08dec0d7fbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	N1BejFPVhw8GVF+/UMpjIVf1sreYCUakNChBoz/gxiIx2RbBZss24amA3ue759qtoPY9xFaYR0ElLRfyLi9b/+ZGAT8e0I17l3O1S38xg7irlk89UTULmQYehKihAwe9o7ukeFFvDWf+W73nhmTnQyh9+14kgyfBlW3jvxOrbzo85paYnZPXNmZbaUGz0Vl65IV6Z12GLkO4wIO7y78KYWK2wSHzWoI2G9LbXgakOKovL9eV8r9g+YL6uywpUmWqAEzQi+eUFBQilreRnGPI2gRWCMUGh27f1xYpy3JgqH2l3YVsiEWCBNwEL0OF9Vd9/nmOpgNywyl5/dJZ2Keq037IKwYXvw2Ja9AwePUV1FBdVeQoooV9hUSmrzgsoG9BSVLwmdYT7RIpAoBaQZaT2mvP8+k6pcfzCLxQxoXNueN9nPeMtRXwo2BhjbdsKq75ILsFuk9UjeoxbbmzkMuGkPXdwcIjxLUK1i7gKTacP82tKlJ/hZteieYqHnkcDDVfkI+nuvVuZINBXo6TMFWGB4SeMk6OYf5HJcsDkN436Dk0BD2l9NSAAX2pb26K5fd0QHB1OpQYO2R5fg63DTDHBvjh55Il2YAp46AW9aOdtoFHzzO8hXVNb6eVvnmAn9Cf9+E49SLY3VN6WgPH6+22qYh+LtDpneXoleyUgP2YEIZSksU6uIlGetv913GUlsSD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cM1MpJ3ik5t4BHo4vSHsjBqEiJwtOoeuE7OjyxI9syDQ/18ZMfDKSn8Nutot?=
 =?us-ascii?Q?DtwKSHXjZv5jatHwp8a9afSlQUydOhPG10gfHdvlUyf74DDGNH/WTsxBUpCG?=
 =?us-ascii?Q?ttgKJj3m3rLTSalYI5RjYKdDnFunqtbkXCDnLO+ka7DQZjwYjyAnVKKthFhR?=
 =?us-ascii?Q?xk2YRqyUR1rXNIgsu1+mZXdyBjNTwg9jM92D7xnrLVTO1tnrp0Xkhyl7BrUn?=
 =?us-ascii?Q?gmfvoLAunwLJVr/cNB8DH3OXQvUeclYjUXezXayxeZSvfQlTf7XwBFHdBG5R?=
 =?us-ascii?Q?VtzjGyzAj4L4a9ilHkZJCY4V2zYREB+PDxzxUqGfw1EAIXtNCFm/NLs+ceX8?=
 =?us-ascii?Q?3uAvAGIb3zmgAWCKy34krTuUSWOzHSmN6VxQvK4izVVciu8bU191qLqPWQC2?=
 =?us-ascii?Q?31uHGSswVPJi5a6Rh704zLhTEdJ6dPO5i8tOXsQzkDVc3I3wP7Rk/VswdQBX?=
 =?us-ascii?Q?mc/rvn9xs9ou6zlroCF2OsFVhwrYgDmfynNoyuoALZP/GKN7xaLWMY0r2LTv?=
 =?us-ascii?Q?BAdZ4Aygn8YCIhfkhYLNLTWzyfB1AmBSo3olJ40GHmMA2vvGmG5CqtXU0iz+?=
 =?us-ascii?Q?u/UC6/MARnku3OU2ETGqkMkE4dyy0yYogku2RfitM+RPR1UcEeUW/WM2NmJP?=
 =?us-ascii?Q?R9yivHQNbSUXYAwWNHVmYR2kOyH2kxeNTYgzt6NtrlBUz9m9ELk8gv7SymMD?=
 =?us-ascii?Q?ztzkQ+g+cB3WcF6bPxkqn9nYE/Qa/DyQx04y5YaHbTw4nRlfbYl7YQiCoDVN?=
 =?us-ascii?Q?x534jfitonshH00MVw2C+1wyhAzZ2bWHMVLb5/feHe0oy2aregLPQmY79HxI?=
 =?us-ascii?Q?M1PHU8RgrHGXqlvB+DGbh0yLTvnu64Pg5jUx6agr7zlmk6IIra7yXOe1GpW7?=
 =?us-ascii?Q?6IK7+Bd9iPG7Ihignw7RK8pNSTz/h271/xtUvMQNGXosvRje5wP/DL/Vjlad?=
 =?us-ascii?Q?nGYc7jXlgoz9B7E5QJLBI9eo7bz7HBguxQTiL85YyCj9b5cHYE1ZBDcwI5d3?=
 =?us-ascii?Q?H0UEjHuezVQ4+EISizSoOKAgSB3Stml9NfPLPBtMZGR9FtNSTk0vHxDgmwQx?=
 =?us-ascii?Q?pkol/JA+BlXnK2883zRoJcK5Juf7IZLyS32qnxnqIYUWhsylyaIegdIXx/EL?=
 =?us-ascii?Q?cNcU+1fZ7A/myWo3a7fW++k++hzTZyDNl37Kw2HhXt58AsmD4ci1TXehxlsB?=
 =?us-ascii?Q?axW62AKYvKzWwA3HMPHJb4fu81yrLppg7AOMNe9wAP9WRiAmcHCcPY77z28o?=
 =?us-ascii?Q?+y0Tl2VARm/BFfiNQs1VdO/qt0SGB0W6myzxvDqkNNGmev9R51ZACxLAR75u?=
 =?us-ascii?Q?XK/pJ5JgwCkM013twkZj8muoYeHccR5kh6Gt+2HGzrtAMje2YyiD25Os9jJV?=
 =?us-ascii?Q?s8R7HljhwhsRNxaOMtP5VGWEGmnoD36ns1yJOtEYQ92c8HdRNH961DXNzYEC?=
 =?us-ascii?Q?P5m/DtbR/7ZE15i5w1+8/cD5viVpdWal5IdKwBskh2lLKqOKN6au8IOktZ4N?=
 =?us-ascii?Q?VKvF24pWTQEzuv0m4h3c8g2gfiIXERde0hHLT8/qwY9cjQbXfF2nvJ2bwyhi?=
 =?us-ascii?Q?R2qWIvMNhXN6xwl/ay9UI7kn+xgQjwfJPi0CEsloVuihQ+3pc2JtfAYAqGyL?=
 =?us-ascii?Q?AdpcfuGI5ZXWwla0Kpi9uUfSOj5mHqtedHWfyIaxU0bMxMBD5Y6WglOma+gL?=
 =?us-ascii?Q?V9fOQNg2HJtliq/gZ5YDD/50km3w/pHlF/YMY0JPko1k1/jWmD7QDKkikqkq?=
 =?us-ascii?Q?kSkxz2H7pw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176d1abc-cf96-40c8-1a6a-08dec0d7fbc0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 18:51:40.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Zr1Hh8v7CXnnas34gm/a0SOL015/0iL4By2IgH8sU5ESePYsdQDEsrbyqv1nZVNIGwwd4fYENIgh3UAG7TK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-294350-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:roopa@nvidia.com,m:petrm@nvidia.com,m:idosch@nvidia.com,m:chirag@nvidia.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D383F631375

When a new VNI is added to a vxlan device with vnifilter enabled,
no RTM_NEWTUNNEL notification is sent to userspace. This means
'bridge monitor vni' never shows VNI add events, even though
VNI delete events are reported correctly.

The bug is in vxlan_vni_add(), where the notification is guarded by
'if (changed)'. The 'changed' flag is set by vxlan_vni_update_group()
only when the multicast group or remote IP is modified, but for a
new VNI added without a group (e.g. in L3 VxLAN interface scenarios),
the function returns early without setting changed=true. Since this
is a new VNI, the notification should be sent unconditionally.

The notification is not guarded by the return value of
vxlan_vni_update_group() because, at this point, the VNI has already
been inserted into the hash table and list with no rollback on error.
The VNI will be visible in 'bridge vni show' regardless, so userspace
should be informed. This is consistent with vxlan_vni_del() which also
notifies unconditionally.

The 'if (changed)' guard remains correct in vxlan_vni_update(), which
handles the case where a VNI already exists and is being re-added --
there, we only want to notify if the group/remote actually changed.

Reproducer:

 # ip link add vxlan100 type vxlan dstport 4789 local 10.0.0.1 \
      nolearning external vnifilter
 # ip link set vxlan100 up
 # bridge monitor vni &
 # bridge vni add vni 1000 dev vxlan100    # no notification
 # bridge vni delete vni 1000 dev vxlan100 # notification received

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: Chirag Shah <chirag@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/net/vxlan/vxlan_vnifilter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 2042369379ffc..f2a202d468928 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -759,8 +759,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 	err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
 				     extack);
 
-	if (changed)
-		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
+	vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
 
 	return err;
 }
-- 
2.43.0


