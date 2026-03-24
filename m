Return-Path: <netdev+bounces-271242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JpFMOLdwmkqnAQAu9opvQ
	(envelope-from <netdev+bounces-271242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:54:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7025D31B1E7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39C930A2BE4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5251407589;
	Tue, 24 Mar 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SgQKvBv6"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64991408256;
	Tue, 24 Mar 2026 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378192; cv=fail; b=VWSVMHQhdO+u0Ysm0ek7+fdDfKyJ1oKPjUPv0eGCsQmyadObIDgF0CdeGemGVeJ+fZflqfj3LBp7pPBIxx8UbJVwpffByrj/s42mXo21wK1aiNE+4jWH5WSExLVlCj5whIknj4AHMoxW3Taxt3dOY7Xxp02hBgF19+4sbJFI7IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378192; c=relaxed/simple;
	bh=zAK2QFN3n68EGo9jam/VO3yIrO1murwqtZQkeJVU+n4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sQZlGl3OjMXFoNJrxINItSfCGLpjlQfXJpfQGakpZ1zAiuLucMsLlLvr9CworVh0oCfGLO6FLYmZw2TayswN9G/xZbhUYDM3a8VPXgNTV0hRVaXUAqWXcqVGnlfUPu8W2kA0VFx0xAP+uemgAS5AZWgb1ka9fh386HwJFcCOHCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SgQKvBv6; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOd2jobfeTlz/dr/J4loRBX8VQQm4FNlFoZ9liAH85YviZDA1ASTfLbpzu7QH5jLsxnfC5Zy0ALS8dnyaQ5qXOIKv4pEXHpg14Q0F17XysV7ibQdnBhOsXdRHz4KqdFMJ1qjI5nOGeCdjez54iEZsk/ATeeyUN+6jICQc5inpThm4IVbU0ZdBJxtFyUX777JrpQ6A8JAFrPwo65JEzp5Jhaezro5sz2fuwmOyQGnzkAJonnf/WDKGI1Y78XSsm322iGik9moaVR5CT8NfhVqtDc3e0HW0qwpMAaMxNanTP5xm6HyjrypPR1fkXU93N95SJq3uBLVFQGGpu+AZdHAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNM04JGyJRwFjV7+ywrAbSsSVcqArJY3Hdhxdf2XJEc=;
 b=l2QDdk0AMRETHxutA3gLROf32KtJEXJ7IZAXNbHvUWavSSygAn/4XCTR/SjcG8VYQjlS+kgIvAIZUCp1189QwoBZn64fALBQHE7vttPwCJwS6VzoXdwwik8Kfd+Qla0+88BC1gztljcVRgw2gVGQb1kXqKkiXiOe2kJU7ThWoh1iR7ddJI8jhGfKXVM36+fsEmWb/kQm5PQCQY174NLfRORwVvEPYpT67K3bgGEjRmgrF24cJOa4nWHlRsVe0MhiSSqWwNbznzfJilcbVm1m8xMs7k9l9uRa4m/xYBD5DfqBi0Pc3wkxeS/N04m7mKkL8P4JTYA5WQw4RxRoI/IbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNM04JGyJRwFjV7+ywrAbSsSVcqArJY3Hdhxdf2XJEc=;
 b=SgQKvBv6COqN8BvNoOceJRr6bLPsKJ46I1AkYta1gnDtvGouN0d8zAEM5hGEWk39+0viehaycWYGabaptYhnGJb6JKBkWofBdrFVjndPtzE6fLuSMhO17XTnANhDhoKuWHNxgQ48Gqp8OlqlJl/J2dHojr0GWR2/aPjG8RwMZFNVJsjkEWCTX5frMAY1w/9fTPAGQViKlcilIsW8rfv6X4EEwfsyBg0zNW76zSHfab8jua24a11qoMvpKip1n8cKSSS2pFypj7SQ4iCbG9ZAZ+xnDm9GeW0yxLPie/SYq97J5qhLcRRNPtaHZNvWoyLZu0IYbMy1HSV9B6MLyHa5vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Tue, 24 Mar 2026 18:49:45 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:49:43 +0000
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
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net-next 0/3] net: bridge: add stp_mode attribute for STP mode selection
Date: Tue, 24 Mar 2026 11:49:39 -0700
Message-ID: <20260324184942.2828691-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::29) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: e87a55ae-99ac-4419-bff8-08de89d61ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+lKJ+jE+TkVqZydAd2aZ1CUqJiwDBVVDozzEXT9V3cBblIA9aQyAG8LvrEd4ez3O3iwBL+8xk07U4+RWx8929oQsikrMO8KV4Swgn/GvZRSIxFiD7ir4o/LnXbbNusfQRvipnU1mkarv7dyqeJN4aXtJxiqQDxbN9X3lAGsdDjG1ycVKfP/H4aBGUe4yzqDB3yd7Wk1THhF6SZbqpmeEpI+aEf2+8UmIPW/vb5cSPaRxXVO0QBXVM6ZzQAPouRspdYQJirKQGvWWGuCD16hHydOHKZS2JSjIjTrJhH5r1PnICU1d3k7Fg0MLv1mz6XGEYNY56wTxyHzTnVSXE0bMrRq8Hh8SuYF36BSbRPYQenpaS+A5VAsuSlzFITXYwkz1eciUx7LNtKGa/a0ZnO9yme//qi3G53Nmb7aQutxiMJtKUKnjU5UhALc9Zxd2rTG0KeQEs7ufpFkARVAPzH5qw6MKK0d17tsIyo62+qFQn8WjPoUc5e3pLoiS2w3QW8oaMxx9IyIO173LzX/FgwhwWrE76GCs1s1bGkLSLkezdMBjw/sCrWyRBU/Kj4l4iRtM7tO/PPivCAtX2HBUv8b5H4G5LLjJt9a9wXIBzS3GkvCbJfKvsr8DTZExXP0wLDb3f8Qt0IkYW6Ec+4Lf82eE4FcYxzRt2IURlKztrNa6KWt1tM39lB07xx4QwYcsvyZ5dqD98XeXFaIARxWi2u/NYNo2xwyMBIo3L2hzKXyFZ3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Amgz5vYNrYdqsc8hC3pcjjvI+QjHPW9rD90KyeBxMBBxqu963AOJXAkzDarS?=
 =?us-ascii?Q?gfvc4XEdo5DWdftbK9YoFW9d+Snp4CsXYzjrwx6sDzyDck3p2IOd+LWGPXEB?=
 =?us-ascii?Q?d9WqMu/1X5b4dbllb0ovSByAtuQiJTwvG5kb54jQc4hXBjDlDUfQ5Hg2XcFf?=
 =?us-ascii?Q?PQ/vOragZJYCDLYpUn8ReqwWH4bujKLxKBdWLqhMxXf19zk4OPVKtx7RWj5R?=
 =?us-ascii?Q?s9WBIKSG7eXz+nZHKFeU875wfv5JuhdIfIFAGuNQRhF7ESugdPEU2wHEA83a?=
 =?us-ascii?Q?VBTEaJF4kFNtIIXyhjhHwa+JtDKEBsv+SrdYLsc80uiVbvbaM1PDGx94tQpe?=
 =?us-ascii?Q?R0wHnilGDKmPpyGRxztR3axt/Njqs4i6Um/VVogbFXsv5nD2Ot+sczpZF5NQ?=
 =?us-ascii?Q?Rx/ZOTHRlxC0qqO9OMqHoYXH0FOKkyaKYyPCW98hvwqDCBro5fD40RLFX8kZ?=
 =?us-ascii?Q?1vmu3MGsMAqY6uxOhovmcGVyHn6LFlb83HTtmEORXsbal1UdqkxcyIq0lD2m?=
 =?us-ascii?Q?LoLkwLWkzgTOnLWphoHCHZW9DTptZCsK1/FSIlZuuJUPaf21K7C0blCO9qTE?=
 =?us-ascii?Q?a072mOWZdg5Ih7M5gOmxKp7oEQLTyWm2XgJO3q0eMPTumj5dunVmUwl/LeIi?=
 =?us-ascii?Q?fd//PoHjekJRaJnfBPMEyyVTpiBtxlpSA3lkxLdXkktP1SIlJqdD8IQ6mVPN?=
 =?us-ascii?Q?6edcGSgzPM4McaJ0sxrju+8QAqpzsUv5va9Wk22lWTjyM46BfktJYt2a97LF?=
 =?us-ascii?Q?xp5J/gBIU/3FsSOPvE3QipA5mEZfHpJEFD/ZeVFA/YuJy5hc6Uf0Vc73LILk?=
 =?us-ascii?Q?Mlq17hL1HSoj6j+GYWP90E0sChFmuEOZrvdNArabT8HOZ0aov5oonBl21XDx?=
 =?us-ascii?Q?5SYUY/VoMnAF/44yYCM4vfjjhHXtWU8FKzlnmrbdkpBVvKdTZU1BZBzOrdYF?=
 =?us-ascii?Q?E+Zx57n4yA6WfYQJUvFC2Yui4YYBvlSusN9bgwnc6ULk0MSRJzmgC73zphFr?=
 =?us-ascii?Q?HgO+hFSglvnBxsSCxZCyU4GkfDbc5qbKNbIzqzHtXZAZgxXbRlyKhs96N9oP?=
 =?us-ascii?Q?GciSy2yIFG6pGoypGlMgEmyLGnjyOp17/5doHwcpNLTykEz+5OtH02iNz24I?=
 =?us-ascii?Q?DaMpE1BkMqtxVv5D6hddKQQgt1WNUld0qXauQiI1MNx6XFOpxWNBiB7AV57Y?=
 =?us-ascii?Q?7N9JzAyxQlHcSVIjKfCeaf48KyZXEU0hHWPiFY62v8W7CC/TZaYXgoP0IGcZ?=
 =?us-ascii?Q?YMJfgbVRZYASZ26p3M6qkOFyc4RoSWbL600p74rV/FWtHVhpuNJdVW1wxduj?=
 =?us-ascii?Q?v/iLiBDhGr+rGtjQPkUk8GfDB3NMUJvv2j21yMRUmDA/JDgYNOlPQyOlg/RM?=
 =?us-ascii?Q?23qoCz0qO6Qg0KMXfniwkeI8YrYBXuY25uL51w0SnZlGlXD//nmv5GECsPk0?=
 =?us-ascii?Q?fQcQCpcpzU/6g5cNFSrTJbgrtUxtRVmmN3pIH/LdZWTRnYkWnPnTmcQ5yIqf?=
 =?us-ascii?Q?6+WhW8ao2wUrnjTG2FQ3Fykd0fTYt2R882v/z/DJQvK8ctSRMa2pVyGEvcqi?=
 =?us-ascii?Q?SBlCYanEv5ApYcCiKJDdiZzcyIxvTHNDca6O/3CEe+IUYgN8H9ATym/FskDo?=
 =?us-ascii?Q?vnIv7QDB6NRrOTY5NUI0UWyqRTSKhaSkdzN/8r4ld9ihWDivoRoxIS01cgO/?=
 =?us-ascii?Q?yKAb8Vstn4qd8FsFajDkPnfANJtOzdFgF0a8XZ8mgjRysmemtKlQEgfeDFJ/?=
 =?us-ascii?Q?F/44SDb40Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87a55ae-99ac-4419-bff8-08de89d61ceb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:49:43.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyY3bq89pw9fZxlEZc8fg5iNNu3hk18Wd+C+0J79Ki9aXAodTx9O8xSgJn3PdRihWEi5zAP9qsf3WA0IcTDxLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271242-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,bridge_stp_mode.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7025D31B1E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bridge-stp usermode helper is currently restricted to the initial
network namespace, preventing userspace STP daemons like mstpd from
operating on bridges in other namespaces. Since commit ff62198553e4
("bridge: Only call /sbin/bridge-stp for the initial network
namespace"), bridges in non-init namespaces silently fall back to
kernel STP with no way to request userspace STP.

This series adds a new IFLA_BR_STP_MODE bridge attribute that allows
explicit per-bridge control over STP mode selection. Three modes are
supported:

  - auto (default): existing behavior, try /sbin/bridge-stp in
    init_net, fall back to kernel STP otherwise
  - user: directly enable BR_USER_STP without invoking the helper,
    works in any network namespace
  - kernel: directly enable BR_KERNEL_STP without invoking the helper

The user and kernel modes bypass call_usermodehelper() entirely,
addressing the security concerns discussed at [1]. The caller is
responsible for managing the userspace STP daemon directly, rather
than relying on the kernel to invoke /sbin/bridge-stp.

Patch 1 adds the kernel support. The mode can only be changed while
STP is disabled and is processed before IFLA_BR_STP_STATE in
br_changelink() so both can be set atomically in a single netlink
message.

Patch 2 adds documentation for the new attribute in the bridge docs.

Patch 3 adds a selftest with 8 test cases. The test requires iproute2
with IFLA_BR_STP_MODE support and can be run with virtme-ng:

  vng --run arch/x86/boot/bzImage --skip-modules \
      --overlay-rwdir /sbin --overlay-rwdir /tmp --overlay-rwdir /bin \
      --exec 'cp /path/to/iproute2-next/ip/ip /bin/ip && \
              cd tools/testing/selftests/net && \
              bash bridge_stp_mode.sh'

iproute2 support can be found here [2].

[1] https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/
[2] https://github.com/aroulin/iproute2-next/tree/bridge-stp-mode

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>

Andy Roulin (3):
  net: bridge: add stp_mode attribute for STP mode selection
  docs: net: bridge: document stp_mode attribute
  selftests: net: add bridge STP mode selection test

 Documentation/networking/bridge.rst           |  22 ++
 include/uapi/linux/if_link.h                  |  40 +++
 net/bridge/br_device.c                        |   1 +
 net/bridge/br_netlink.c                       |  18 +-
 net/bridge/br_private.h                       |   1 +
 net/bridge/br_stp_if.c                        |  17 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_stp_mode.sh  | 261 ++++++++++++++++++
 8 files changed, 353 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_stp_mode.sh

--
2.43.0


