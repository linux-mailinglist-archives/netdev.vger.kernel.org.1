Return-Path: <netdev+bounces-272844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULMlHauVyGm3ngUAu9opvQ
	(envelope-from <netdev+bounces-272844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 04:59:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F34350804
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 04:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A601C301327A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2942494F0;
	Sun, 29 Mar 2026 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bX4pXgof"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0F1DDC3F;
	Sun, 29 Mar 2026 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774753147; cv=fail; b=C4Vn+kJvsk0bfkCQ/CWfR534S9B5qeql1yg5M/R8v/K8XyFHsAD8yiX9Mdneo7zp1oJyMASKkofh+xVLEVO0SLV60Yfl1sUzAghzhn8AcgWIeasAvA8H4en+yJ7zxlb9AafK0Fc7/OjHzdUAWgZ3VGcyYOjMhebo7Ze78j1YCSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774753147; c=relaxed/simple;
	bh=OPzf4kmOeK7Y9EBsnB0iEHExN0u1cF4zypXbQjGLO7s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mqeZk6F8HxsfRUTZ9VkhrV7avdDsyaDy0ZRt9HVipG56boj/VA0pSR/ONcxT7l9d2VKXq2F6xMwl28NPXMFUmXPLmbbSG1pfqbAifB+LtVDSvtvq4W0HWwfzeM08F2XdTVdACHQRwulXHsBYfyPntEkow6ZxQxm3jJ6TeqQxmgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bX4pXgof; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ3PcNCKWcFZdiQPgSrMhLBkBfzE8frMibHojKsZ3XqbaBjURLMTlDcv7bTiAFAI2Rz0k6QrQjRPxusWN09EyCXPzw69oUuXwCRWjctm84HlbZaPMygVosLW6EKin38adTBUIXNT/HLJ6ie5FLtMdxnwAo4VrIYW9dtN9WlQjexdenvOT9oJWXn5ADdY3bDYNvSFrWzFe15SSyTOg08YKG36tcDpNjDd3xCqAfPVdya0v+C1vWiI5UMOzKSkbK35d/ca3u8iZlnuFahK0Wf0tuY7Pt9mOkAzPH42Y9uQSTnUFcnaot3cHdQISy+Iq7Lc7fAURc7Z/Hq17sqDRVp0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj5zI5g5IKZbHy2CdhBgPokIfhnOnlA6t4+An22EnnE=;
 b=or8ZkQPGtIGc9/bQw+cCJMp19uPIKsfQk9AunWrfwyTAnGmLLvi4O5YSNhddnOTMP7T8Nc/q5nIY4yOMIxBO9Rtm3esHZLZDX5WUqAtA2EQGI6sTjUepQ0m0+cbSCyV//wCMu6Aihhm3OOU9m4cfvtEG237pS0P57AijFSAgytS1OJQ7oAtixu0H3tffGSOOKumA3qBWkbF8fHhjmf7j5wb7TPDO1hXT3X0l1C/WbIlqYzYN7mb6zlfEAU6opsY7XqH3iGvYZqlhuFnIuydF9+aW4OLEUE3SaItGgGwVqncWirhLh1rademqK30x2e/Bi/fs6OYqxT4MHvH4/KptIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj5zI5g5IKZbHy2CdhBgPokIfhnOnlA6t4+An22EnnE=;
 b=bX4pXgofOEuCLbsRnSnvII//HeTdSI4sMnvQ00xt1d6wt+A/162rO/w/i+jjUASq+tysv5NIDqm+jub7u9fmdJwlRIwg1DHw9wF5EwYcSJzyL9gc23JHenYHhMaVhDzPTeLc627/Rd3sszAHQiiZk3vJ/b8/OYV5PMm0VKMJy2sxeBWzjEzwsiFRBby3T+PxBiHnuiRQw9DgKVcfssRbQnrJVQ06qdzxmGWl04/cjNaoAU8uoX4RhEJ6c0THPdIlw+2Ld/gjb9ynLwUue3gLYVI8OHEo2JPCx9RKU7Y1lJjdZcAx02kMFc1q89fEhfU6OCJODRRN+IuMGXofHhHi0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Sun, 29 Mar 2026 02:59:00 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Sun, 29 Mar 2026
 02:59:00 +0000
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
Subject: [PATCH net-next v2 0/3] net: bridge: add stp_mode attribute for STP mode selection
Date: Sat, 28 Mar 2026 19:58:55 -0700
Message-ID: <20260329025858.330620-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 93008a11-9403-4068-55c9-08de8d3f203f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	y+Sm3XfoKGzMkitEO95V9yezcyU0E5e15iDktWfojPA/sTLSMBMzDBhSuLO3ZFhNLYVXbdy3veyXkRw6jIXyH0ypKB+waSKsYhun0X2ac74ihDWtyQ5iSQhbzSyooJKzkOXHykNTYcNx8KvlEgJNowOaBGtaDurSMF58ZlInupZD51U6qyKJeBF5KF8XqFge7NRe06Kb4qsv1X8z0AfwEZHPaUNj/aRlqtZWB1OVuQFjXSmhryIXBF2FPOkicMxCo6QkwZhXyy3Pn2wBMwmYqo7Ny2A9pLcMKWp5PKXSCvhoRCh/tIVgVWNTYCqky413HBXQ6sVToY3rWRKlnzY9SL6Dv1+2RiRodxADCi5jdh6ijd9oaKwFRROV9eSNHV5nmJ4OvwJlNKfmwMZrGRTb5Cyea+aWG03z3wgs51xjluio6xWqOSQmAm5Fcn/QbGAfHoII+QfQxZ2K3xVFpqNcbTIQEc5ox6pkucol5Qq7EsnL6nhP5BLbj/8pHQEbwtukG6uUBhZmWBvdq8rluD5ft9s3VQMz6VDvrb0+7JqnSGurGGokOFqWbyYqvF/HonEZNog77fDo3MSrN0N62BQHmeuXbo4zQEYdyOZK38lcyrnUVtpFlwFmrWEK1ep2CO5hL8fk58ADbFH+xAulfCexat2voWie3Q7GNHFyPg+MpCTvEoe2VCXGTrS30zYOiFbNROHXsD94YtFpIr5lrKSLV5Dswxouh2Lm76BchgHI+WZaRutweUo+UzmfLxsTvk8H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cdg0yDL4s8fUTia/NPweyNZ3nPZrXbE0qj2VHdv5MEtsYFBsBcWo/YQ1AyJ7?=
 =?us-ascii?Q?+4CWybDz3fGknH+ww3COJl/yoTF3XAhfDN0bPJWy+lkgmo9wheHD4u5rijj5?=
 =?us-ascii?Q?7B5ORmpnptE6ivNVhPcPZPZDJn9Sk/6rvyV3qIxgC2C/IxvSTa5F1msy9mAt?=
 =?us-ascii?Q?5HHa2aSXzfLh7Zw7Wgv7EN1QvwxYCBp2aNPXi753Z9WzH6vGmxNsvTkAsAnN?=
 =?us-ascii?Q?9nFmJaYKu2fhmOkgv73I8z0XQ8K15z3df1uikgEIso/xMvP0/07gVXme2iWt?=
 =?us-ascii?Q?OsUb+VpOiqdF/6Z1pTIJo0XpP2LNhFlelrgCHE3PogQIFfrY67z2nxW6J9n2?=
 =?us-ascii?Q?BgzoPeWsfqDwH6DPMQSnFatb8nXvkLTAVFO1CGcTt0DoLxyI//elyN1V4RbI?=
 =?us-ascii?Q?gXOfgBgkkRFQNK62sQLPbqYB+ox9m8QJgmsduUsCgsiZLiGprjQ7YTFVo9cn?=
 =?us-ascii?Q?7gl5xs9hpZcxClZUOq1ziHXmitE1KcVENfFTsaXLkO8o1MxjsZSrhoKVTYF1?=
 =?us-ascii?Q?YhRknQOwIfIMmN3/43GE588T352WKMMTfl8/+lhe4gmZpDZBAQ/qTYjiAyTp?=
 =?us-ascii?Q?vvKUCSUBBIn6b7aEkBgBSOm2v8xq8jb1X720LPLwrIrb4beniDlCmDOCj4uB?=
 =?us-ascii?Q?RYOG3SGCx6MwvdAADkvX29ncNtjUF/iWJWdKMUGW45d3lauCrqqWQUcf7GnM?=
 =?us-ascii?Q?EhcflItdqo2KOwlHLRd9qxkcjuJfxD68Pl5/zq7ODlfwVqR4EqKXAqxcS9Tj?=
 =?us-ascii?Q?hIJNYBAbmdQKMc98FAuSgLZE2jefe/2U0LAOzjhwqb2ecGEyn3GyPsgtMSgJ?=
 =?us-ascii?Q?tJ5GurWCWNhVbQfZB6DS0rBjuvKiAURfWSHdZHGpFJHsT5fDqrDgaj2cCVsQ?=
 =?us-ascii?Q?AEbg4z7iaiTWxKquiBVhthRyAiCEX71hXw81oiOuBd8b8iChYg+OXRxb5rE+?=
 =?us-ascii?Q?InMVRfxFRPkQvssNxfIwLVaQ64mjYXxyjn6hsrNokkLL2PdBHCoaNYlDUrPP?=
 =?us-ascii?Q?vnhR/DU9GiR92HqyPqjR61rzbZQlJCZDVuX9FID0L8TUA4ACk54SX47Je4E6?=
 =?us-ascii?Q?7EsIysosRrfxRRfbqNWdkomjUPunKj9gwgxJ7OIOi6evCB+IA10K6Y+wqjZU?=
 =?us-ascii?Q?4KZFs5P+1yABTTyUWt0F/yblHkZagkqASzF6nHkHRQwPshZHD4q8BPtmOaOV?=
 =?us-ascii?Q?37qW2SwJQ/C9e0iSnuQr17k0ywPrCNBYVjGgLG15rCjRJIOczk0x5BS2AeBw?=
 =?us-ascii?Q?lPb2+vqB9B0alzwgco3gmAi9gzqD1lSruT6+dO+WbVXliqOCJC2UJuef/1cC?=
 =?us-ascii?Q?9V65M3lM4zprz4VWbz4y5TjaG1a0pmmlWCB2eOqCTn6+FnswMySJi7RpCPuc?=
 =?us-ascii?Q?56KAwgn+b4Law5wHq503rKEGwuDhjCBiIbc7oE9hZ5L8E3mGaX3lCRPjDY4r?=
 =?us-ascii?Q?p30dqHup6B8vm/HDSq0CgitYIlBsK24oZKo7W+ZDc8yIa2Xhf+O7YwvwJDhI?=
 =?us-ascii?Q?K5Qqq5OLx3QgJYEHxAxxlrozrHoKnJTqgm14jtjldktsAqzgfIQoaa8rvR/C?=
 =?us-ascii?Q?oldA7imp0a280H0Fz3BtNaAB0KJNFWtEhG6ZJQ2TM5MtW4wy4wzw3cri9IDd?=
 =?us-ascii?Q?90LNrK4so69+igIt8RdpBwEzEKMSKgSS3I2dNPF/YgJfRMTDY1X6EOYJbBpU?=
 =?us-ascii?Q?Uxyn0+n5mayblOcGGF3TESv2ZMJmqlOeV6aIJxMqWypBIuPwGKzBCMClBxju?=
 =?us-ascii?Q?R/fRqNLvGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93008a11-9403-4068-55c9-08de8d3f203f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 02:58:59.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIETa39rJhD+Otlshaq1zyOjzkR/lq2Hgv/MYaULBPrxb2Rl2ssNevAm3cCcnrwyKFjK/i7QEH88A9/73AnawQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272844-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20F34350804
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
addressing the security concerns discussed at [1]. Userspace is
responsible for ensuring an STP daemon manages the bridge, rather
than relying on the kernel to invoke /sbin/bridge-stp.

Patch 1 adds the kernel support. The mode can only be changed while
STP is disabled and is processed before IFLA_BR_STP_STATE in
br_changelink() so both can be set atomically in a single netlink
message.

Patch 2 adds documentation for the new attribute in the bridge docs.

Patch 3 adds a selftest with 9 test cases. The test requires iproute2
with IFLA_BR_STP_MODE support and can be run with virtme-ng:

  vng --run arch/x86/boot/bzImage --skip-modules \
      --overlay-rwdir /sbin --overlay-rwdir /tmp --overlay-rwdir /bin \
      --exec 'cp /path/to/iproute2-next/ip/ip /bin/ip && \
              cd tools/testing/selftests/net && \
              bash bridge_stp_mode.sh'

iproute2 support can be found here [2].

[1] https://lore.kernel.org/netdev/565B7F7D.80208@nod.at/
[2] https://github.com/aroulin/iproute2-next/tree/bridge-stp-mode

v2:
        Patch #1:
                * Add rt-link.yaml netlink spec update.
                * Allow idempotent stp_mode set while STP is active.
                * Move stp_mode next to root_port to fill a struct
                  hole.
                * Rephrase BR_STP_MODE_USER doc.
        Patch #3:
                * Fix shellcheck CI: add SC2329 suppression.
                * Add idempotent stp_mode test.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>

Andy Roulin (3):
  net: bridge: add stp_mode attribute for STP mode selection
  docs: net: bridge: document stp_mode attribute
  selftests: net: add bridge STP mode selection test

 Documentation/netlink/specs/rt-link.yaml      |  11 +
 Documentation/networking/bridge.rst           |  22 ++
 include/uapi/linux/if_link.h                  |  39 +++
 net/bridge/br_device.c                        |   1 +
 net/bridge/br_netlink.c                       |  18 +-
 net/bridge/br_private.h                       |   1 +
 net/bridge/br_stp_if.c                        |  17 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_stp_mode.sh  | 281 ++++++++++++++++++
 9 files changed, 383 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/bridge_stp_mode.sh

--
2.43.0


