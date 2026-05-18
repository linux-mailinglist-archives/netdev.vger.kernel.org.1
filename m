Return-Path: <netdev+bounces-289131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPGBKghGC2rgFAUAu9opvQ
	(envelope-from <netdev+bounces-289131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:02:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA9C5715E9
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 19:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37E6B3006B21
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23D148C3EB;
	Mon, 18 May 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aM9WJVb5"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94648B398;
	Mon, 18 May 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123427; cv=fail; b=IxJ6o2/LUWoym3WYkTcoUz3nN8KC9WkeSiLXOCYTXjmSnsJaKkI3jfdZ2+knflh68I/LGS+2utCA8f3k8elK92vL95GUz2QJW8vploQMxkvBDMI/SV6jlp3g8+DCnQhUtUnawKMl8ovpzdlS5FG6N8ibXkgmakotYo9q2kycmSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123427; c=relaxed/simple;
	bh=BiP+fYpifJs0nBgiTIuDmKQW4b3GkeXvR1AOMaE0VGE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fwcqn9GKcJcrBzDBie+v0u6054xpGAeF5JB0Ji0Zd9KzavZsHORpNUGl2TJO0QwJDQ/Dp4f8I0fDz1BhheutmsFL4TEhgrn8iSnG74qSev5Twxu9BmeCmcDnqobsq037Q/eFVFdoYRjYFBQuOcBIXYCNtmjI5G129yR1SeFG1uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aM9WJVb5; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZg6BBOlZMGgqlit1sfWobGQtE58RMxKpu9WmV7bcNv6GgKuWHuKMiNEaaZIKbZcFGUeOcuUEfj1+DGTljMgJbxxHtQRo5cySItdRhDhd11JkF/57SXZKzaAqKl8sI0kFlxRsUqtUFOPKFQOtjpgCcf2qRldol2kYtjLxZTAUO2tszCSvWGnQ3cGClrmY7l7Rf40VOQPu9YecvIwSH9nP969NvakrheEG73mVp4C8k5wPbt/5aejeNkuIKTgQoW/bnkmUnFJoKrDr7x4yJfiuU92Mm4KXcVIKoKCS6OYR9Gszqck9SNcajdqHxhBv8XCXEBoStxJ35pHRswro8ueHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzL2DJjGr8E70pdNNVunGsOAUrN3/rEktGYoaj8acjg=;
 b=aldDSTvoau836oLW5iFIWn+NCogNme2iz+dcX8vZQ+9tKXjhDYAEQ1tB4jGQGWSo0Kx4RqrbG0EcRiTaEg9kc5eg28TDqwTrIc9m3OPrWK2azy5OnMr7SvbsO9rsER8wSVlBxXCNhdgUTZZtF74I9ZgU5P4xPC9gPoCITl/sSfyT1Yuqde6WCOKQ0scWYEo8Pe35y878tilUzZOCk6YAOkcP4TtGLAD9hcb8abxMmJF1dcjRh9cQAqqSvy+CYD8v0aHy6k3iKBi4yLHhscQQct+Atp199r5tYBV4xopCiHeHq3qQ11XYVemXCSsjZ1zPrUKacFRYpQOf2LRfb7buhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzL2DJjGr8E70pdNNVunGsOAUrN3/rEktGYoaj8acjg=;
 b=aM9WJVb5Fs8ETxX6rqahK2WnlJks9Jv00s5pXn3edpg4HsfrsmkABR71WZf0FBLmOCwBrNQxs9fFcaD1tLJ/SI/Vl+akDLi2yJTok3gWVZWiqk4l9dobFwSwORl1KDuZW9sskEkvXOYiElBq/FAYAxJ7FCIDHis6W29JA3XqAdV4qU70D5m01BPqcpjIYnUdIz/VIADwf5aEQ6TsYfic8c/uWSl+Wl7c7Mkx10oB2WycXPKeObL2GE4QX846FjCVkLrJNPOD1Zuh6JvKV1fzj4RVgTuY4++JYzi8x5cXRoFNeL1IGRIIU7l7UQZuLDGcXXxgu3uTIuPIhzAMe1vN5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 16:57:03 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:57:03 +0000
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
Subject: [PATCH net-next 0/3] vxlan: vnifilter: fix VNI add/update notifications
Date: Mon, 18 May 2026 09:56:57 -0700
Message-ID: <20260518165700.1975478-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc67666-f9c3-49f1-8033-08deb4fe7bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	kzqZRNonkcewXAYvVXOwIxtxg8Ry6CRSbzeXxCP7BCw12WDMIEahidR5NDZ6dzq/dHH3fv7Lh0QbINLyaPNxmLwkdedv091sXDMhhYaDQgBqGF8n86ujyO8y9I2AxQe3FjHpB0wJJ9sMf6tg82LlzO7aTtjNmyhF2pLPzYHs/MJXUp8Iq5noNaUA6bL0e6pr82W5xRDBxQ0Ci2fylUcS4wbm0QoJRcERu3RV9C3X7mTxtBflPyyYMTjM3PfeTl1DM0nz4XopGWDPvQ26Nnqbm0St7kK9bY/tTeVn8nwADwpQWM2Gu4VrRwLfaCnswcYmzwufW8KRwLNqkHvPId5D137vKF8gszfNSUFt9H7txvrOWd32wPT+j373tON7IAf0OiLvBh6U9YnUb+AXDVtO6oSNf0Rc5W0NgS9YIOJV+70ifR7okhYAgSnTtfHXaW6OnK8U2lGECS6kbSELxqMWqnRPvuwqBRTXggPFszOyF/GnBXxC3Jgoqf+vqDD32HBSL5FF1ZLdrt/CCeM76eCQA5W94kOTAlyzVgU9xnOIMZFyd7OaqO7hk7SZa0de7bf3H4Jqm6IMXXPjVdq2nb9bTG41EUQR53zPKEb5PR1UdySvBZcdIXTp77Rc5NmCr3wLmNaMmo2iWqPjDt+k9Ioy9qftJLM0anVIcNSYvp/ysJ5ti2RnEvxurcBIT8AXOVeJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w7PGc28tEC5H1LhZwdHYQXvZdu8Z0IJBJfx7d7ErpEdF3/65vpBSaNOoAfFY?=
 =?us-ascii?Q?5tpm4yowabfInUJmiShiA4butRY9YBCaf/1qsuDrKzcchAzH4uk9TS76kn4Y?=
 =?us-ascii?Q?5WrKQQvOdq1dScjCYO5HrOTHlbtVt/TWCDDJlUvoY/u1yAqUt3VaXPHQYgzI?=
 =?us-ascii?Q?3GrLNmUO/lBmCPD+X9T+yez6j1JPoUiskyZe4N3M43MxizhrnJ4++s2bRpgh?=
 =?us-ascii?Q?J621JEgW3VjEfkdIsxFB4GQNdK9AqBBi9wAfhDdt4P0/Qwn5JT0V40xw/FL7?=
 =?us-ascii?Q?fGFzIdRn6DHGaA72AvDc9c/0Wri67xDKy5fOnGBPNh6N9B91/PSq57QB5qx5?=
 =?us-ascii?Q?FO4IibSo/iQh54us9q0uskXuEM0wnLIhoAGRkxTzgnA0Sejo/w8TOfVZWHJC?=
 =?us-ascii?Q?yJ0I9nDcATjWDVCsEpC+cJiGZK6oU/jw+iSTx76AsvUqmp6lGA2Aj+Kbp9ct?=
 =?us-ascii?Q?ijfW9WB5PNHrd96HE5Q+ZzQsJu4bQC2l3lxsl5XPTQgl/aAuGCOSN2nS88h/?=
 =?us-ascii?Q?nw+oTH5ImxQbuPRVOX0PtLBp8UkdZceK9R3gT4uJBz+P6uplQPUAazbfQuSZ?=
 =?us-ascii?Q?ZOPawlkmvZ9G6sWpeLS+deUXlqqwuzSipBtErw1CVk07i5G/WnlIGaHyq6zy?=
 =?us-ascii?Q?MF+7qAQ6LPfiqedET6BkLibk8aVMtSsquZUc1Z57duXitTLeL+RCmQItS8AD?=
 =?us-ascii?Q?U82eku71hNvOdIsortvNJzgCQlgCf5YvpVATXACpqW5R2XAc57ubCAt7vNWk?=
 =?us-ascii?Q?CNYyeBFqJb5+KqyWZd1cmR4QXQMgvn94Q4gm3Vq2L9fL0R++yHPggTjM6z+0?=
 =?us-ascii?Q?ocLqj1FOCIr6EjzcAd6PS3FKtTcHP22nTke6dhAohn7tmCq9LI4mhW+4w76L?=
 =?us-ascii?Q?KQE/LbzlOdXH/IGSzq1D8E38I5VPLSLQeWxwS/M3s92VUrOMoav4EMNi85um?=
 =?us-ascii?Q?WQnIaOOj0EuttoEKGHHL/WYEq5mw2U4YQQ5kVxM/Nrvcfm0NnJ6TkOm+B5Qc?=
 =?us-ascii?Q?dod80Lf5MwBniwTr59WX6QekI9DK1FdGRngJDZFYCu5+Z9vtov25Cv7fUzl/?=
 =?us-ascii?Q?/BjULXZxoUfbnnE+v3JUBCUVUUxaI/jztsFlBDT1IJhD4VSyGx7Q2RLjL1bO?=
 =?us-ascii?Q?NxKG+OlzIuzHxZ+fslM905yyXfwYc9El68ourwKplakcY1d7OukLAoE/8zei?=
 =?us-ascii?Q?e1p899SuVxwWtb/82WQrtI7jTZrvINcIRsBj1PGwHyvLcwKlWoH3uYuTclj5?=
 =?us-ascii?Q?OGosOz93g6CuRB/85yBAO3kk53qQFVTxTw+uN3q++D1/YF9ij+fB4jP5QDyd?=
 =?us-ascii?Q?nfJyHNDN5KiuOeH6duJrPt4khPizLVlXlcdLqhel4BrdqyG/Qwe9kdzyye5K?=
 =?us-ascii?Q?nzl+mVlop+qubMzYfvTgNn98kbP+7Wyw7zqwqjCr5fUtDEJhxRBT8DvsyZMg?=
 =?us-ascii?Q?9xmKXFpJ2F6rOeT26g0D9IaTPub4De3xMf5RK1mx3nGDQhjrgqfUo8HSN9ad?=
 =?us-ascii?Q?OZKHSHE4JePcRckfmnavLdefvh5PXlaKKAEJ5ZWO/2mcOiadcoYVjrmJO8jT?=
 =?us-ascii?Q?glGZU1S8jsUX5dHkDEa8+sdBhSCAqWKPsQqgm1H84uchJFWFOn1OSSnrHh4a?=
 =?us-ascii?Q?UTDa16AaWHFeLcSWB8nT4mu8rWXMaaftGhxR6Jvdn3K4/6aGFwOt0rGQ4QZN?=
 =?us-ascii?Q?3yZAalfpkhpDQd/17NQYNSBzHmmf41J2RPS4JMEKRnlnbkWZxk+sQ4sveVRe?=
 =?us-ascii?Q?z5/VNSlflw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc67666-f9c3-49f1-8033-08deb4fe7bfb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:57:03.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KN705ywJ+WOzPnm8cpX7OoHYvBFcl2g2rv5AgwTUPzEVf5jvfMuQY0imCbKMP6J0m2FXJUJi7Fv153vCg7Ah+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289131-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BCA9C5715E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a vxlan device has vnifilter enabled, userspace observers
(e.g., bridge monitor vni) miss VNI add events and see spurious
notifications on no-op VNI re-adds.

Patch 1 fixes the missing notification on VNI add: vxlan_vni_add()
guarded the notification on a 'changed' flag that vxlan_vni_update_group()
only sets when a multicast group or remote is supplied, so VNIs added
without a group (e.g., L3 VXLAN) were silently created.

Patch 2 fixes the spurious notification on VNI update: vxlan_vni_update()
tested 'if (changed)' against a bool pointer instead of dereferencing it,
so every re-add produced a notification regardless of whether anything
actually changed.

Patch 3 adds a selftest covering both bugs along with a few related
cases (add with remote, remote update, delete-nonexistent).

Andy Roulin (3):
  vxlan: vnifilter: send notification on VNI add
  vxlan: vnifilter: fix spurious notification on VNI update
  selftests: net: add vxlan vnifilter notification test

 drivers/net/vxlan/vxlan_vnifilter.c           |   5 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/test_vxlan_vnifilter_notify.sh        | 175 ++++++++++++++++++
 3 files changed, 178 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh

-- 
2.43.0


