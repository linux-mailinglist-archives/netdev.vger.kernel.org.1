Return-Path: <netdev+bounces-272845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP+yBtaVyGm3ngUAu9opvQ
	(envelope-from <netdev+bounces-272845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:00:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0776350823
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB0E2303C00F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ADB2475E3;
	Sun, 29 Mar 2026 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bzqfhuOK"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466524A044;
	Sun, 29 Mar 2026 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774753149; cv=fail; b=DI93i9KPZ+zQ+7N2qo/K5tl3SA6OgZEp+jxOx7M9sruw9YlpbCL6uqWNJT4oFo0XJ/pT4pzC5CAJYZ89GxW8NG1hdnTWJ+QSQx4NzBXkyo7dmY94Gw7c8O/74quFThpSjGjXBHVoVZOHeB44c7E9SlxYUNCy1Av14rBI6B94beI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774753149; c=relaxed/simple;
	bh=tp+xedz4Yx0ORCT9Mgzs5gB5SojEALe+6+Drl3SfIHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbVmrseAGifWDZGICjgIepUyOp+ZhIQs2hf5EP4I+BsOfnXiPmC7W6aXFniiH/+FyNcfwQDRyrTkzv3EfcE1hwvHlT4/uyamJzbrfXQZbM3i9TsgyXW3tlLWIFRY+4cNJt7lQ1EWtm8O1MafOP/zpIoEwxB+ZADFTShkVVcOm9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bzqfhuOK; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJ3nPO3uJW36IbIXAmNFRof6aihUWjSYgmw1FykfQ6OF2dMA6NGbpLNCB291f4yUOLVm4DtQpnQ+BQTfAX/OkIUksalZt2Q3ity0bIEDa59OAjgVA1jfecGqctlfWqqhft41D2g1PCB0QUJSN9yzjxgMZXg8MFyW0BjFJbC0QQqJYgHRm7HVdodqm5APHb9fNmEw1s+RlTXtJBNX037WG3nArR73pdBBz9Lwgy2NO+nd3A8W1rKvIL/05ZOfJoIcPN3tq1tCpCfp5U+o8qSoj2nkXGAjLsww0de8cNffSo9NwYQfW8i643H5/1kiRu4ZjezeaMDqhiitAxfTVzNBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udzHLhr11JgpFqc/3kGdZwU1RXx5f/CRkHsE1F7vdwM=;
 b=fq2HASAm86eYbBqBP8IL0TKE6fVMT1rqXmU5V58Ec3IfwARihmDk3je9JE2474uje7AlYfzamcZyPUGHD0Ckvi1oRw6r/kXRRD3DdQiBfQESjF9uLvS38p5JuIswSPxlJxv1bvAxRMuhQty93LAtloNMdd0kGMGAxQaHuwgKUWQj5A4aZgG741uMYhUDM0gXH0uEmip+ebYYIIubrzXuvvsDQtcnNI4zCvRjMc4HUy+fPnn8EDdklsvP09Fe89sct1vEZRo9W0cVHdTWZAs2Nta6kIVsFvQajKSlC+wwSfANGConQB189HwvUztwkY0+/8C0r97PPWYr/sTaQ3GsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udzHLhr11JgpFqc/3kGdZwU1RXx5f/CRkHsE1F7vdwM=;
 b=bzqfhuOKiLHWG+suTYkFUEmZfwBGz/sDJoxVOcb+qgtjVu+eydozjVjyQ+2U2bXOosVlZ+BjBkWAKkmgNK4P/QliAyLKXhEZxIzMutzbsS9X1OayuAr/tziZwF2juQ97ryyvUIX64ZpzFOBWFQrZ3q0JESrbJHwcw3cMP/im7rIeUw+d69r+mjuC6tHpFvINA0rCdPx48sGeyii/tDzFRonF2FnelDzhQ+5EBN8W5zYCJQccfC6t8AvbnK0Q7+6b1Dh2M2fFQqBQJeK0AvOfn26gSfYPoKx3Gk0+k7wyWKhk9czCwg9OxvADCV4onW9myL+ZERKP1rvfzmZ5gjV6qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Sun, 29 Mar 2026 02:59:01 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Sun, 29 Mar 2026
 02:59:01 +0000
From: Andy Roulin <aroulin@nvidia.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next v2 1/3] net: bridge: add stp_mode attribute for STP mode selection
Date: Sat, 28 Mar 2026 19:58:56 -0700
Message-ID: <20260329025858.330620-2-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329025858.330620-1-aroulin@nvidia.com>
References: <20260329025858.330620-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0209.namprd05.prod.outlook.com
 (2603:10b6:a03:330::34) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: d009dc45-dea9-4678-aee9-08de8d3f2139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|18092099006|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h2622Df8ZkskotuAv2Mf9K3voEtraSD+IppxoP9WwFR5EjYZ/PiD4Ips6PZ4sBzMUF38nHJOJtYvgynb/+kqzGn09uxgk1G0hgWKV0Y/B2ppAOyYuDbHYeLNngVkOnJIh2tuzqsGvQYeeXbEu79rR8WV7BPcdRE6FgmVYrwifBypoztNxKM4BNecWuujoJTjzTvr4Ab5Bw1rWS79L17+zvW6ci4URjITsFZv438o6DnPNEpDjZ4A+n2fxe2Amg74exJadHSiMxrZAUTfh9GNgptXjpXl/GRrSvpFyqep54XonhHCb8kIPndPe7tIPdFa693NAwuxAqzzpo8GWHabvvKSTzQ4fxNZAw1DN0Yq4TFrm6ns4rJqbDbQOFKiplrAehdbWyOiLSrQdBCM2+qAMo2E6qN+m6vRllK5T/jfDqk7VrF8ykESatS5b+fYo+7S9bNU2CBnMpqnAg02tvTc3zca9iehwVV5BmzRzoym4+vMfKF/ySXIfdVVFEhtbmnFmFGOd7rfzfoC2AcIVbuLf3JabnC0DYDN2nw2sQMRUTvfNQD0V92FitAbIFt5nc1E9JoDHjjReYHq7CZrnQ4dBbegIfsBdD7oqnCTEjAEISzchfl4RNxS9kZYn/LpNUWr7c3+HYQF6bEdfb0tUYxOoX+vrnDN56xIsvTLl3DwhX17XDAw1HVs2zhc4aevrjf/hlpEjSDeyvpNje9kCWYk8Nl0EfvQAzIJuOTADyPSauc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(18092099006)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pmAVzYjv4aqwkio1Upp6OYrlNeXBGzZuImzK7qcZ7YIxt9iCiq60e/w1K/+u?=
 =?us-ascii?Q?GgEvH8UeazCLopc9Xm35RHgHb8aNr6jWweT3uiNP4UPcLxUhfQ8bDNaTa5nC?=
 =?us-ascii?Q?5N08gwi0FwCc+4Rc2ILA73cyQN3GWKs26gm3e/xzuyDGnZrROH4pdkiHCJQz?=
 =?us-ascii?Q?B4isBVsSLcas9pyCzuNvKI5UmP9Ms4jPNdoW0VG1QkJRY6zGO0Zfizl2v/Ue?=
 =?us-ascii?Q?9vSekZ84Bz5/cpBGj9OvmTc7mMqoqViw0ba8OAB+lIoki0oBxCBYpUY9+rON?=
 =?us-ascii?Q?o4A4lElByilqsT6ayWIfvGhAM4RIIQMvUQ6klHABFJlYPdixfdb9ybY4HvG0?=
 =?us-ascii?Q?9Fcl3UuKBVABK9RM6lO57HAa9JKFmr0vLv5fuQUP8+ogEk4dmPDZEgTpuVLI?=
 =?us-ascii?Q?nnlS2VXdRpGK6y50teg3rfonIwrXEAXfHKuUJjK+lMv2MUmqc6sq9lKMcFKr?=
 =?us-ascii?Q?Wzk/IUineKLA4UaFwT6m0ZZWJBfT70bt6EsgZVuZnLSbkujY6WruBlEVs0Tj?=
 =?us-ascii?Q?KJrZJuzjYIpvGWN+oEDJxPXnglkvmN1ZnrUY35HgwByvuM4mVxx6YaaGNQir?=
 =?us-ascii?Q?UKZcjjxilPGRJlenMLrdFk29j6YDAtaBf15hzHk5JbcgVdihTopv9s7IQox8?=
 =?us-ascii?Q?KyWn1JtpPAW3GVtQ6/b9uAnnTot6OqXO2sWzQNg+ANg2KSLHJ1M5X/YYh8zi?=
 =?us-ascii?Q?0zhbXCRGLD96CXbF1DVSAEdiZsh6rmX8AkyFBrdDwT3tRdbVjbD147/saMH3?=
 =?us-ascii?Q?dAWY0Ns+VK/kHpCnyMCvnW6JmkTjQDaHF9m5+uxqNbYScLaLM15KtL9jWfrw?=
 =?us-ascii?Q?42K8/Bf6JbvyISK1HrmbI5LWQTd50p/aL4Q1Vbvr/HQLi8qLpvnYE7iypLQM?=
 =?us-ascii?Q?F72lLWtBl3ks4Do0ySn7z/cw1Mp9fm7/EukF6/+c0goo/mOPRsQhjMvOfMda?=
 =?us-ascii?Q?VOpYGsqwm3UTNQvqtk+TwpEXY3n26enmhr3+7I18m5fYKoT4eVHGyhXg3FIW?=
 =?us-ascii?Q?CEDbgarhcrQG/JIkhL6Fj+yqWu+EjoHtK5xilWO43R8gOkXCOGlzqBChwtiE?=
 =?us-ascii?Q?i2405VBP20qLi8fZntRrRsxYqt5/wDRD1AigAvAvozY0pVgXgF76MGTAi196?=
 =?us-ascii?Q?1ffFzuX1idgl0wvfsmVtm0h3jEJDgZMhUslmkEITRTSfnhl6Su4CkQs5Mkwh?=
 =?us-ascii?Q?YC2IxoV9DeOJ7VjDpx8mHJ3zTr9kuGyN0Cx72vbqqcJEKWiBg1VokYzWDoed?=
 =?us-ascii?Q?QJp4Ma5LBuIuKJUo2g/hpOpis537+9C732bHixC2owIMSS6p4ANUU8IBecI9?=
 =?us-ascii?Q?kOg3yuSQVBugYKyHXY2UOGYwiJWMSMYmrQV4yXxVriWmQl2PjojFsTh2poFB?=
 =?us-ascii?Q?tPe2bJ5t4KhViHDBrw6ZnxxsrnDYEplxk49AKJ1QjNfFB5/Qus4KHC5eJABS?=
 =?us-ascii?Q?qSVVB7HcYL3bYe6AIDR5i4StdhWJOAzwYr7VsszmK2HPmXnqZ35RuVYz7XpC?=
 =?us-ascii?Q?htoB4AAQkqIVpjn2LF1FT/qAjljKRDFbfgodTRmQ12mRIPpKvvTiqBivRdnW?=
 =?us-ascii?Q?D1JlysWBpev6Zu/Kwe5R5zVFlDwzb5bZQbFgN8DxBe7WBFFnn8hWo2DLimBK?=
 =?us-ascii?Q?v54uFqiBsk+iNRs96Zw23gNm4CUJ/MLdbBdgmDM8/b68EbIjt+iu251QULPu?=
 =?us-ascii?Q?hOxF3Rf/xmnEobylIJwo4B/zBHrwCxgIIdHhU+iMyiZHRRdMS0gWXf8PBJiC?=
 =?us-ascii?Q?X9PHTUL7EA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d009dc45-dea9-4678-aee9-08de8d3f2139
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 02:59:01.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0frpmGUBoO+kLrSx8vQ94GnwKBRR/d2SkwEgjpEtYelRArNDr+vYalSMoKj5N+wovNKSjlkfgHyqkVFHRGTROg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272845-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A0776350823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bridge-stp usermode helper is currently restricted to the initial
network namespace, preventing userspace STP daemons (e.g. mstpd) from
operating on bridges in other network namespaces. Since commit
ff62198553e4 ("bridge: Only call /sbin/bridge-stp for the initial
network namespace"), bridges in non-init namespaces silently fall
back to kernel STP with no way to use userspace STP.

Add a new bridge attribute IFLA_BR_STP_MODE that allows explicit
per-bridge control over STP mode selection:

  BR_STP_MODE_AUTO (default) - Existing behavior: invoke the
    /sbin/bridge-stp helper in init_net only; fall back to kernel STP
    if it fails or in non-init namespaces.

  BR_STP_MODE_USER - Directly enable userspace STP (BR_USER_STP)
    without invoking the helper. Works in any network namespace.
    Userspace is responsible for ensuring an STP daemon manages the
    bridge.

  BR_STP_MODE_KERNEL - Directly enable kernel STP (BR_KERNEL_STP)
    without invoking the helper.

The mode can only be changed while STP is disabled, or set to the
same value (-EBUSY otherwise). IFLA_BR_STP_MODE is processed before
IFLA_BR_STP_STATE in br_changelink(), so both can be set atomically
in a single netlink message.

This eliminates the need for call_usermodehelper() in user/kernel
modes, addressing the security concerns discussed in the thread at
https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/ and providing
a cleaner alternative to extending the helper into namespaces.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---

Notes:
    v2:
      * Add rt-link.yaml netlink spec update.
      * Allow idempotent stp_mode set while STP is active.
      * Move stp_mode next to root_port to fill a struct hole.
      * Rephrase BR_STP_MODE_USER doc.

 Documentation/netlink/specs/rt-link.yaml | 11 +++++++
 include/uapi/linux/if_link.h             | 39 ++++++++++++++++++++++++
 net/bridge/br_device.c                   |  1 +
 net/bridge/br_netlink.c                  | 18 ++++++++++-
 net/bridge/br_private.h                  |  1 +
 net/bridge/br_stp_if.c                   | 17 ++++++-----
 6 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index df4b56beb8187..15fb3b1cd51da 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -833,6 +833,13 @@ definitions:
     entries:
       - p2p
       - mp
+  -
+    name: br-stp-mode
+    type: enum
+    entries:
+      - auto
+      - user
+      - kernel
 
 attribute-sets:
   -
@@ -1543,6 +1550,10 @@ attribute-sets:
       -
         name: fdb-max-learned
         type: u32
+      -
+        name: stp-mode
+        type: u32
+        enum: br-stp-mode
   -
     name: linkinfo-brport-attrs
     name-prefix: ifla-brport-
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 83a96c56b8cad..58727fbf81e56 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -744,6 +744,11 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_FDB_MAX_LEARNED
  *   Set the number of max dynamically learned FDB entries for the current
  *   bridge.
+ *
+ * @IFLA_BR_STP_MODE
+ *   Set the STP mode for the bridge, which controls how the bridge
+ *   selects between userspace and kernel STP. The valid values are
+ *   documented below in the ``BR_STP_MODE_*`` constants.
  */
 enum {
 	IFLA_BR_UNSPEC,
@@ -796,11 +801,45 @@ enum {
 	IFLA_BR_MCAST_QUERIER_STATE,
 	IFLA_BR_FDB_N_LEARNED,
 	IFLA_BR_FDB_MAX_LEARNED,
+	IFLA_BR_STP_MODE,
 	__IFLA_BR_MAX,
 };
 
 #define IFLA_BR_MAX	(__IFLA_BR_MAX - 1)
 
+/**
+ * DOC: Bridge STP mode values
+ *
+ * @BR_STP_MODE_AUTO
+ *   Default. The kernel invokes the ``/sbin/bridge-stp`` helper to hand
+ *   the bridge to a userspace STP daemon (e.g. mstpd). Only attempted in
+ *   the initial network namespace; in other namespaces this falls back to
+ *   kernel STP.
+ *
+ * @BR_STP_MODE_USER
+ *   Directly enable userspace STP (``BR_USER_STP``) without invoking the
+ *   ``/sbin/bridge-stp`` helper. Works in any network namespace.
+ *   Userspace is responsible for ensuring an STP daemon manages the
+ *   bridge.
+ *
+ * @BR_STP_MODE_KERNEL
+ *   Directly enable kernel STP (``BR_KERNEL_STP``) without invoking the
+ *   helper.
+ *
+ * The mode controls how the bridge selects between userspace and kernel
+ * STP when STP is enabled via ``IFLA_BR_STP_STATE``. It can only be
+ * changed while STP is disabled (``IFLA_BR_STP_STATE`` == 0), returns
+ * ``-EBUSY`` otherwise. The default value is ``BR_STP_MODE_AUTO``.
+ */
+enum {
+	BR_STP_MODE_AUTO,
+	BR_STP_MODE_USER,
+	BR_STP_MODE_KERNEL,
+	__BR_STP_MODE_MAX
+};
+
+#define BR_STP_MODE_MAX (__BR_STP_MODE_MAX - 1)
+
 struct ifla_bridge_id {
 	__u8	prio[2];
 	__u8	addr[6]; /* ETH_ALEN */
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index f7502e62dd357..a35ceae0a6f2c 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -518,6 +518,7 @@ void br_dev_setup(struct net_device *dev)
 	ether_addr_copy(br->group_addr, eth_stp_addr);
 
 	br->stp_enabled = BR_NO_STP;
+	br->stp_mode = BR_STP_MODE_AUTO;
 	br->group_fwd_mask = BR_GROUPFWD_DEFAULT;
 	br->group_fwd_mask_required = BR_GROUPFWD_DEFAULT;
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 0264730938f4b..f5b462a040b92 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1270,6 +1270,9 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
 	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_REJECT },
 	[IFLA_BR_FDB_MAX_LEARNED] = { .type = NLA_U32 },
+	[IFLA_BR_STP_MODE] = NLA_POLICY_RANGE(NLA_U32,
+					      BR_STP_MODE_AUTO,
+					      BR_STP_MODE_MAX),
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -1306,6 +1309,17 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BR_STP_MODE]) {
+		u32 mode = nla_get_u32(data[IFLA_BR_STP_MODE]);
+
+		if (br->stp_enabled != BR_NO_STP && mode != br->stp_mode) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Can't change STP mode while STP is enabled");
+			return -EBUSY;
+		}
+		br->stp_mode = mode;
+	}
+
 	if (data[IFLA_BR_STP_STATE]) {
 		u32 stp_enabled = nla_get_u32(data[IFLA_BR_STP_STATE]);
 
@@ -1634,6 +1648,7 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_NF_CALL_ARPTABLES */
 #endif
 	       nla_total_size(sizeof(struct br_boolopt_multi)) + /* IFLA_BR_MULTI_BOOLOPT */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_STP_MODE */
 	       0;
 }
 
@@ -1686,7 +1701,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
 	    nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
 			atomic_read(&br->fdb_n_learned)) ||
-	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
+	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned) ||
+	    nla_put_u32(skb, IFLA_BR_STP_MODE, br->stp_mode))
 		return -EMSGSIZE;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6dbca845e625d..03e9f20181175 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -523,6 +523,7 @@ struct net_bridge {
 	unsigned char			topology_change;
 	unsigned char			topology_change_detected;
 	u16				root_port;
+	u32				stp_mode;
 	unsigned long			max_age;
 	unsigned long			hello_time;
 	unsigned long			forward_delay;
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index cc4b27ff1b088..fa2271c5d84fe 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -149,7 +149,9 @@ static void br_stp_start(struct net_bridge *br)
 {
 	int err = -ENOENT;
 
-	if (net_eq(dev_net(br->dev), &init_net))
+	/* AUTO mode: try bridge-stp helper in init_net only */
+	if (br->stp_mode == BR_STP_MODE_AUTO &&
+	    net_eq(dev_net(br->dev), &init_net))
 		err = br_stp_call_user(br, "start");
 
 	if (err && err != -ENOENT)
@@ -162,7 +164,7 @@ static void br_stp_start(struct net_bridge *br)
 	else if (br->bridge_forward_delay > BR_MAX_FORWARD_DELAY)
 		__br_set_forward_delay(br, BR_MAX_FORWARD_DELAY);
 
-	if (!err) {
+	if (br->stp_mode == BR_STP_MODE_USER || !err) {
 		br->stp_enabled = BR_USER_STP;
 		br_debug(br, "userspace STP started\n");
 	} else {
@@ -180,12 +182,13 @@ static void br_stp_start(struct net_bridge *br)
 
 static void br_stp_stop(struct net_bridge *br)
 {
-	int err;
-
 	if (br->stp_enabled == BR_USER_STP) {
-		err = br_stp_call_user(br, "stop");
-		if (err)
-			br_err(br, "failed to stop userspace STP (%d)\n", err);
+		if (br->stp_mode == BR_STP_MODE_AUTO) {
+			int err = br_stp_call_user(br, "stop");
+
+			if (err)
+				br_err(br, "failed to stop userspace STP (%d)\n", err);
+		}
 
 		/* To start timers on any ports left in blocking */
 		spin_lock_bh(&br->lock);
-- 
2.43.0


