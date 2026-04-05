Return-Path: <netdev+bounces-275485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOhgDqvL0mkhbAcAu9opvQ
	(envelope-from <netdev+bounces-275485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 22:52:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0939FCEF
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 22:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A8843006832
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E9E383C8C;
	Sun,  5 Apr 2026 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mn3Pf5f7"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046C382F1F;
	Sun,  5 Apr 2026 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775422353; cv=fail; b=fd6AmgL13TSTaO09FC1mMQtOrVlTfumSWIB93CBwM7PHAUoWwoPhuuq2sslGeBpcNbEOHC5WjudQxhrJFjOQ4/jdBEpjBbSDz9eqXmuCpJlahBWCSuLY4oq5w3DKEqLYNYlnE4cuvmHbtnPhxa8dotkXcSBvh70KsmgmahQR25o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775422353; c=relaxed/simple;
	bh=Fee1vMZvAuGQ+EfNLsUV4Ei4fYleIw/O+Z8Lu6riMLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9siIxnJ7oiLB/TyJffrAKUvm6Dq7/x39uLWa4XTJr8MVIV65TDJxCHkCJq3Bpr0bRNs4VMqM+34SitvmNN+2gFmjB0GgiLOWK8LjGZ+e828RAo2qzxman8cYim8HPAYLwvja5b2n8LzhK6AsVLpnNYv1V8oKaRnK7GAxM8+lyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mn3Pf5f7; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyHSrO5M3ogJ/N8tk+HVpwXw2h7vEdye7A1wSn73SVmUDO9/VvLWMkF1Y5W/9v+stbFrmfhIU+2h2/9xlVW3bDXuEwY5rl/OodpYtBVHLT3gMwqzcKsurB9BAEIIUgsktpoiBCU9MJaxPdKkuMBe2wJWRyb1UcRXMPh7UOSSt1OBxEvaLbkD0GXxoyRrTBkFd8YXU65gFpT2QAlkAhEhOzRDQXoPT/sP9T41LF0k0s3U7fgK5bqO+f0r9tqd+AQlhm9VRfpfMawNZWjEDSBt/F9S7flwIS1G6vPS/9rr3uAhwpdr3XQk8c7tJtCN1mibiMvJmMpnv3MCAZR2k/H/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0BRg1fv40I035l3aZzAKgIRnWsr3oWjMBhhxfomsr8=;
 b=PBBdWC+rtdJOKGv9TRr1iacZGlmKAGMCQy+mIc27VM47epZ9ZJDIjrTHs4MznLqhS9ZER5FJqvm0lTwuPqGtBkxL20sxdJCVpNb9/sZfm3NyAvx5HTjg+OjuPsgXcY/ssVB7HejAiUrydgYPRCkx4po5odeiQ/Vp7jjlH7E8dpqFj8R0XI0BI5RnMovCnQfy3DQ9EEK0uR4qVMsjv3mK9Ac+m3ApD4Ylu3rSXaeE+q8nFLwPxDMEedBJszdgeQyxHOoDjJI0EJM/wGUFoYfK5AMdvLIG8r6yH0SI3YprFPK19jxtQ5sSoL9Wtr32w6wBZZx2VOf1QAqMBmjlgotcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0BRg1fv40I035l3aZzAKgIRnWsr3oWjMBhhxfomsr8=;
 b=mn3Pf5f7fhtZAWfX/piSuCiWiiCanypzPmqNCpGEHULnlQhGAIUqKCg/ScJBE4cx0FFE1pJbHoFNIV8CPTKh6WU4gkWR1gQFOFhatbh8LrXAuoBU4rYiXO7EjNR3PqjQ4IV4ooFnqbwD10sNxQS14aDTSlK0u2B98gX8faz6QwFl0tmIKUtqj+tSEYYwI4L/KZj+16eTr/N9JDTRTktl59dJuw3hwM8y/sb77N19ZCv4Vk5IO3vQ+Xtzo86mkPLMOXAiGI3vlhoSUutALlJicbR4qDZiSaVC7cXpql8npUrdJencdntysBpXcZ6h13rHfCv561GIQlEcHBFv/Rjgug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 20:52:27 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.020; Sun, 5 Apr 2026
 20:52:27 +0000
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
	Andy Roulin <aroulin@nvidia.com>,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: [PATCH net-next v4 1/3] net: bridge: add stp_mode attribute for STP mode selection
Date: Sun,  5 Apr 2026 13:52:22 -0700
Message-ID: <20260405205224.3163000-2-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405205224.3163000-1-aroulin@nvidia.com>
References: <20260405205224.3163000-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 010714e4-4ad5-476c-1abc-08de93553f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	B7HhRPN8qQVNeiFvkRsSUsbnVZoLWl8P0a3fQPoz+pTKe67qeQlTOIYwB/G1Tlzo1bBfW1TQtzwu8l779uMLSJtUtrLcp7Z/CtmW2CCME2dtm9Vh5Gf5Qc8UDX2MDZmSKjFXpS9JY8RSS8IYBroylhmpbYE0mqvZRsaW2vbt8m6EHs0PdPBu9IYEeaOBCOOpHJJsLZ43sPrE8Ah/Ye4hmldz9cJCOHPVuqnNSYQDHbJUOXZpExOP2bFiOHosmX/+xIsoDQGxXcHwf8GCAENVgmMkIN8AbA+Xf+YniqnUTrOG0OyI+vVww2Im5ve4/4tWwFarolJxr07x4IGVouDZKUlj4hzKpKIoVrpbGvm8+UkAbVRf48UJozW5LXv2P4Gx9JOgrpONbG3QoMUdIQTBDp4eY5EC072OhyUjwUlMi0TO9qYmagKz/t+3OjYh49gcnTxUHLDkJytdET9Q88NtM5r7bbCPyZ+74FX0WjzcahU9Nu7+u+8xp2t7qFb8Adjb06UBcJylTo1btbUIzZLSX4jgyXRFXHOy2Uor8S+5oepflj4B7ez8iDMp/AUZbQ7dVVJaVODsm0nLUA8eWSUs4MRg7CjTugQ+2lmfnuMO1O+2cgI8yxmg2p7rAUrlH6T23p1lNC7r2dhnwccrmaJuR1Lxtw3AdnvEzBel3CrA80a4idiNPucIuL6aogNNnXcp969R3XfvvwplIYacdfvEXOAzrp5Nugnw1yRQe1nVez8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18092099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBohUg7C5KqCv2YFMRewJVlTY2DEz160sdJRDstpYEsWRA+gqsAl9Ad0/UGG?=
 =?us-ascii?Q?ZjbHuKnVcra8ACc07G9xxxuhvcsroVnCaGLXQx2zbR8OPgbXJgqKTmAFesLr?=
 =?us-ascii?Q?K3FLgsxUew9/VjZpGg9WDrNjP664bCDuU3fNhi+vG63fxr+tHGiwpwSVh2/S?=
 =?us-ascii?Q?21g6L0LYaQjHQClKJoX6OSwV0uzHC6KLF+gdECLzcVTzm7tOHun66UZDxU+G?=
 =?us-ascii?Q?6gbmT0dzCoP0qkONxaqR+K4nEiZQbH1OadId/wk0kMccob2ss/c1tQLMl2f5?=
 =?us-ascii?Q?8k6EwArnJkSjlA4eamKeF2B98cBYgxnHW2D1AN6zbKTO3r9H2upXiuDmcWsg?=
 =?us-ascii?Q?OyHwtfjn3FODQ8PPgZf/ohU2qDkE0mXFBdC8fwluRUoC0aXXN15j4ce3sUnn?=
 =?us-ascii?Q?mfazVUwWew1xQR9N5bU+hhV6871OJtrndPn62X0NXgzg80OLYBQhuieJ7uXm?=
 =?us-ascii?Q?8zgyi+aHswFmrie29N8XDhVxCLnnChwaPpQL665K1XNf9vFuUIyutWSQ0AIr?=
 =?us-ascii?Q?ziihy0nIxuWaeWHT/+KI5+5/IxRgWN8V3xrmZCAShK2s/Vizw9bVXS0O+6j4?=
 =?us-ascii?Q?+ir7M6CVk0eSpkA+kaL7kqbd0p6qSvG+CZEmYDw+pHWGq3VNm03CmZraW4Cy?=
 =?us-ascii?Q?DFdiN/wezP7XqdEDp0YKC/xrMTfmHk00syrF/o4ztb+7KYwljXFF4jegcgJ0?=
 =?us-ascii?Q?/wqvVzOE+pU1VwMYFCd90xjvKiyLpflw2dkU6Hm8YX/nHvOjPGCdBDSZ/KPR?=
 =?us-ascii?Q?67AI1doS9b/rS25km3xlrFxkSi/eWuTITd5Q2YQdWPVIe66LHW+zSdzIDMxi?=
 =?us-ascii?Q?Y94F5pHQmCqVBJo4osZEqK/zMiyHYWZMeR6kY4rJlM26RekYiQeBapwt+7bR?=
 =?us-ascii?Q?cfjuK+9XrYfTrAW16im62gxAdu2RgM5JIQh6VL/GmxpXNxjZMpYwXrlyBCrU?=
 =?us-ascii?Q?uzlmgO1J+C+NRL/vjymeAh8Q/V9ywOJNQZZ4YklXOKtnOKQBBW165oHXGXKB?=
 =?us-ascii?Q?Mo1D/YOaZ81l8wlygozZfeLDolvL0C4Ul7qKJhqd62PXeshf7aoNj5gd79qC?=
 =?us-ascii?Q?8phRLhCK98PRniKilEjRN/lLmwavBJV6JSP6QigHoa63wxewe9ShZQ7bM9l+?=
 =?us-ascii?Q?aZpTEHBxMv6erblZIsWIP3b+2Cj4cKOMKjvq3Ic7E6VN52SkEY7blkJD1V/q?=
 =?us-ascii?Q?MB0JHq7CQgYYhkSg+6W4Sq39Va6Mdys42TzVNsWGcaxV1uW08rKNZT09cJKO?=
 =?us-ascii?Q?5lajy1sibExl0sOZPNrYWmL3k7062nJPrFH8UKSU42W7lEFbsj5tMdsQkXRn?=
 =?us-ascii?Q?yL8qL9eGdDv9z/Z0l/AWOGWEHd/uphl6zSUr537SaFm4DjQb5yURvMmEoDws?=
 =?us-ascii?Q?rb+Ynah6jSHwOWk1g25N7uJA+qwrWqeDvWKa4VLrBaBhgukMxH2CAkqk0W68?=
 =?us-ascii?Q?b14FCy9IzcfHu6IuYQwzaDtSOVduIUz0Yh3KeINRIkTOryip8QghYRjjAtJD?=
 =?us-ascii?Q?WGVNOrdxREsIakYeMLim3RG9S6clsbQm/obKC9Pl1RAEFJeVQbLu3kX+y3jV?=
 =?us-ascii?Q?ihl/ovDqNcreNLdFI1cejTBAosM7ph9DMu0JykUoXseRrPmrhEwlPA/hDhT2?=
 =?us-ascii?Q?ciwJ0wGJArQtLgYJ4aYI1dYil7FK9DvfuisVK8Q9Hr5SKU1yBe+CXj1JCRmz?=
 =?us-ascii?Q?MvdiaW/Cakw9DouHpygibZPzH6Nnmzz2Zv7g79E6N5bHMfhr2zBZ9s3mynql?=
 =?us-ascii?Q?/W0S4Gl5Ew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010714e4-4ad5-476c-1abc-08de93553f5a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 20:52:27.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6hgpmYPgptso/d0g8aNCR8sQF39LFRJ6EycfHly0gSOoON7Ji3cvt/AvGqinKjM3ORG1VxZF9tj6kjm1mQpmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275485-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 38C0939FCEF
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
in a single netlink message. The mode can also be changed in the
same message that disables STP.

The stp_mode struct field is u8 since all possible values fit, while
NLA_U32 is used for the netlink attribute since it occupies the same
space in the netlink message as NLA_U8.

A new stp_helper_active boolean tracks whether the /sbin/bridge-stp
helper was invoked during br_stp_start(), so that br_stp_stop() only
calls the helper for stop when it was called for start. This avoids
calling the helper asymmetrically when stp_mode changes between
start and stop.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---

Notes:
    v2:
      * Add rt-link.yaml netlink spec update.
      * Allow idempotent stp_mode set while STP is active.
      * Move stp_mode next to root_port to fill a struct hole.
      * Rephrase BR_STP_MODE_USER doc.
    v3:
      * Name enum br_stp_mode for YNL codegen.
      * Add enum-name to rt-link.yaml spec.
    v4:
      * Use u8 for stp_mode struct field.
      * Add stp_helper_active bool to track whether the
        usermode helper was invoked during start.
      * Allow mode change when STP is being disabled in the
        same netlink message.

 Documentation/netlink/specs/rt-link.yaml | 12 ++++++++
 include/uapi/linux/if_link.h             | 39 ++++++++++++++++++++++++
 net/bridge/br_device.c                   |  1 +
 net/bridge/br_netlink.c                  | 24 ++++++++++++++-
 net/bridge/br_private.h                  |  2 ++
 net/bridge/br_stp_if.c                   | 19 +++++++-----
 6 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index df4b56beb8187..495836a569e8f 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -833,6 +833,14 @@ definitions:
     entries:
       - p2p
       - mp
+  -
+    name: br-stp-mode
+    type: enum
+    enum-name: br-stp-mode
+    entries:
+      - auto
+      - user
+      - kernel
 
 attribute-sets:
   -
@@ -1543,6 +1551,10 @@ attribute-sets:
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
index 83a96c56b8cad..f159be39a6e78 100644
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
+enum br_stp_mode {
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
index 0264730938f4b..6fd5386a1d646 100644
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
@@ -1306,6 +1309,23 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 			return err;
 	}
 
+	if (data[IFLA_BR_STP_MODE]) {
+		u32 mode = nla_get_u32(data[IFLA_BR_STP_MODE]);
+
+		if (mode != br->stp_mode) {
+			bool stp_off = br->stp_enabled == BR_NO_STP ||
+				       (data[IFLA_BR_STP_STATE] &&
+					!nla_get_u32(data[IFLA_BR_STP_STATE]));
+
+			if (!stp_off) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Can't change STP mode while STP is enabled");
+				return -EBUSY;
+			}
+		}
+		br->stp_mode = mode;
+	}
+
 	if (data[IFLA_BR_STP_STATE]) {
 		u32 stp_enabled = nla_get_u32(data[IFLA_BR_STP_STATE]);
 
@@ -1634,6 +1654,7 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_NF_CALL_ARPTABLES */
 #endif
 	       nla_total_size(sizeof(struct br_boolopt_multi)) + /* IFLA_BR_MULTI_BOOLOPT */
+	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_STP_MODE */
 	       0;
 }
 
@@ -1686,7 +1707,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
 	    nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
 			atomic_read(&br->fdb_n_learned)) ||
-	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
+	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned) ||
+	    nla_put_u32(skb, IFLA_BR_STP_MODE, br->stp_mode))
 		return -EMSGSIZE;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6dbca845e625d..361a9b84451ec 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -523,6 +523,8 @@ struct net_bridge {
 	unsigned char			topology_change;
 	unsigned char			topology_change_detected;
 	u16				root_port;
+	u8				stp_mode;
+	bool				stp_helper_active;
 	unsigned long			max_age;
 	unsigned long			hello_time;
 	unsigned long			forward_delay;
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index cc4b27ff1b088..28c1d3f7e22f6 100644
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
@@ -162,8 +164,9 @@ static void br_stp_start(struct net_bridge *br)
 	else if (br->bridge_forward_delay > BR_MAX_FORWARD_DELAY)
 		__br_set_forward_delay(br, BR_MAX_FORWARD_DELAY);
 
-	if (!err) {
+	if (br->stp_mode == BR_STP_MODE_USER || !err) {
 		br->stp_enabled = BR_USER_STP;
+		br->stp_helper_active = !err;
 		br_debug(br, "userspace STP started\n");
 	} else {
 		br->stp_enabled = BR_KERNEL_STP;
@@ -180,12 +183,14 @@ static void br_stp_start(struct net_bridge *br)
 
 static void br_stp_stop(struct net_bridge *br)
 {
-	int err;
-
 	if (br->stp_enabled == BR_USER_STP) {
-		err = br_stp_call_user(br, "stop");
-		if (err)
-			br_err(br, "failed to stop userspace STP (%d)\n", err);
+		if (br->stp_helper_active) {
+			int err = br_stp_call_user(br, "stop");
+
+			if (err)
+				br_err(br, "failed to stop userspace STP (%d)\n", err);
+			br->stp_helper_active = false;
+		}
 
 		/* To start timers on any ports left in blocking */
 		spin_lock_bh(&br->lock);
-- 
2.43.0


