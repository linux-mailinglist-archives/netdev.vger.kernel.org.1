Return-Path: <netdev+bounces-284254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPgkIaGn+WnF+gIAu9opvQ
	(envelope-from <netdev+bounces-284254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:17:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 310684C8898
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 996DD3011370
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58703E9580;
	Tue,  5 May 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nWQHIEJl"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650973D565E
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969053; cv=fail; b=ME3PB2fQHjK8I+EbgbcXJ0Ie3k+/kAKvF5YS3puVrKO+hDZXyB3UiaGlOpCana0lTLyT4H6qB57oP83vfRwXJlx13Beib5w6aUVuM/BQT8SykFE+qhqVOXqIpdFaBpPs9KFrNY4Lk/WI1qWf+fEdU/reqO2cOlU7p9N2Kr4YuoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969053; c=relaxed/simple;
	bh=GzQ3G79qYf3PSZGudooZQi8FcIYb5KQAN9ApGblrbi0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RoZvH3OnfnnoxF1v37B0+wNOUc99pgJb749SC8rAH0GOwAEH0N2mE3Y3af/0yzy/wL2UDLJ/247tIiQ/NZAdMIXWEmHNZfoOJP7+6FWSwD5oyVJrw7tPeHO+aW1U+tY9FHJM4c+zD55sEGGHwVltY7CSr+QIjHSPG4WOzaL7P78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nWQHIEJl; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZccVsMdGuB93jQ/1ZJdKtON3sBQ74USimHh9aXokc3h0nN32KrIwFVoLlxaWbrajWSrTPayibjEuxkYrL+8YvhAXhsqPIS9v/ZMVdzVzR+48Y+H9e6/mHy1s5Q9K+Hc8SnLB58TzTb8jtZXcu00b/y9K6vrLxigFGWt7AkoFgCuhk/eEGpAyWk+Q+MfdC2nsDxru8XhwMLGoKVxnvtAK1lm3a/7LeemiDg+Z5n8GkPpPBYLK5QrU+SzGHnwPXjBWXlT+4WVTng7yGljV+0O+cMzYGyPt4P35+B5MyJNWNNdC8Y0YfC/kt/fJpl/g9E3JqkPqJvmuy/QsVh2lT+rvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QAH1kZZVqCnpJd93GWB5//vRtcfgo0efAoXu6iY4fs=;
 b=a68vQSHkAv1X+RMNsCGNVzumOMMAUPEhjMWziCw7OHsahb6oRp8ntL0UF8BOjDWcPXKroEeeH8unXrwExx4flRTau5gMKzSc6mMDjgpWO64YScqYk1V1pXJ/KUQQTvXJX0ZDowcn1ZGGVCoWzv4XsUVpEP+bhSA04Hnx5TI8xz6dospGVi3rOMoNqsd47QX6HLMAqdPKCJHS5vcM1vkmPaSEM9whq8XU3eC6TvNpSN3FSpfeKxoicSs2cfqGhnG1F99gpOKtJD+WJBT2NAwttrDXVoT1P2cln3TcaPaoNIc5VLL5HLr2MrBAUm+JDHAlpGCZo5TrprSJrSd+JA17Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QAH1kZZVqCnpJd93GWB5//vRtcfgo0efAoXu6iY4fs=;
 b=nWQHIEJlK59sBBMCiSHWXI95lYgPQA88XTbPuxxFli2MzW8whBIOgnYXpQjWB+YmuN1aB2Ts8zWnV8MvGHpIHYYGWbXUbQJubL6fKqmELlap0fLS44uH31JRxQKUP+mgSwG+UXw33hps6IWiv5c7sQXtZKlT+EbhaIWLU78VYY3GTV+RMal4oMUNzxxwKZlEDaDrQQd5F2mrExDqAtotipmDqqyUyfyQPpD/yu/SOcmN7XLGs2vqhMXqEQROCCxXxVbJNEXXVc5Jwu8BdlgH8rG0HdZG6x/G6i6SZ8wweWE9e6l0zPHnlKU5mbSOlNwozqCSRVZMfNJ/T0LlyxqX/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:17:29 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:17:29 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 0/3] net: Fix protodown with macvlan
Date: Tue,  5 May 2026 11:16:52 +0300
Message-ID: <20260505081656.463158-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a16529-01e2-4415-3ede-08deaa7ebf09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rJsylbPE4P4gwyLO1uxA7/zt/uEGRBg2efhHwD/RhPs73QgTvIY4LYeE9usrZScl6FnvEd5nPBUPFeVYbqRrN3IcWPIG5+JZ0pg64GaT/OOr1UrJS7e1K66fZBBaT+1BUWPObgmDw3nwYUKigkxknwP8YRV+L8Ox6UqsBIIltjifryAM3JaRQquW/Y/vr/ZprBhYHfExmXZWKGD22+iVZzw3U8tPgcSo7BSs9f3dOe7lrAR333/uj58KkO5BujM6eQzAFM+UaOQ+/w7ybnLh33iRKjfOR8oVConBmV442C3J1P+1nWlKfbw9klCXX6kiks9W+MbCeTPc8d2gwftJHUFfmc3UY3qAvp+hBaJRmuiOE4ynuwd+asgusCn/B3rekpcpzzp4VQ+pTamVpfNDcj5taQpVeMrSb51vQtvSaHIXVZ+FsDJ/dI5lU4N40ccqQx3oSSUgdvAmLukrH+8Bvvr8EBKw7sAd74YKEW+wF3nEzn0dtfmRQOXhRWB6KJIpNkyOxSm2tM1je5ThFDYukHk72KBa6GwMEv0GngvgY6Zd6Vwlx53aZ1q2DZLW75a1LQiRwJJnUotR9njpn7NYoN2LB6hNSVy+alJN1jgyfjT1aND5j7gkZHUrkLpzuT7n6NmRtu/TXUe6OT56fnmlR4op6GQuGZSVmf5OLRKQr1brtK+Wmo15+nJ3C88Yg9iEPQzzmf30QFChIUlNG1aSCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MiT7Jr/ju+pNU96+jMUtWXRyLOx/Rtd17VdZzhsk6sruL+3eBWpMCEstFCci?=
 =?us-ascii?Q?VdhkmNMaE9EyAnBNktEpmVpH3Ze8yy21NOV0AsrYGH0873yLqLybKFkfhyZL?=
 =?us-ascii?Q?PZCY7VVhh3aw4ZtaV6QHJ7DkOuckAnAvmkYFKilO9c3XIU8xYA7JpUnmzN/D?=
 =?us-ascii?Q?dkQaAMHWgxIePDWKiCcjpd2/NT0WV/iulaJEa4LNyz1oTTzBgR3o7tVhpNzY?=
 =?us-ascii?Q?MkqJKH6uWS26+q5BpNYPqzBrdiKGcrgvAmrY1eUGqMkSfE1Sw99OCSFlUJyR?=
 =?us-ascii?Q?Ku/ABEGkNhsbfhuydxEOSPJoRip4VWPzRz8B9C2jPTQzTuij+F1CHYon9lJM?=
 =?us-ascii?Q?PChPBB2EliIdAz2XjPUfmS8q31FK0jDaqND27aGkmv8Byhe7htxsiJPcVixp?=
 =?us-ascii?Q?NQrLwfYoEy6KzMMS20K+yiTGa8OuGrw6EPMNLotpk/AhnvYekIQgJWfTY/1b?=
 =?us-ascii?Q?AFtlTHYqcQuESfaiftktT0NwtAAvqtw276XtHY5oKDHhyyeYoS5Ia4pNq+E7?=
 =?us-ascii?Q?iuTnIKyJNVCZLDxDxD26T2C2mjo36kjt7s68P2Ou7f0y/6E667pHe5oAEnJ1?=
 =?us-ascii?Q?jMlE9oYlef7XyB4lGbAoa3mEEmz+xIEfj10tKhxcz9HeFfpfRcGG3HmnjiDX?=
 =?us-ascii?Q?V73ihvb0vSklpIlULEqk4Z0VxM5agz7p4eqaXiyUHwAeSuh4vDn6ZXjBRFjc?=
 =?us-ascii?Q?qOt3XZ/ZalyGzeNXTFNctcpFXt67TxCmvCdTB7mVbasAtObrLqUdTskSuc4l?=
 =?us-ascii?Q?un/qChmmTCEgHoSPnl/ipRlfOiRbqE61nq6KjXrPf8ZSTtMAWKV9a4qOaKol?=
 =?us-ascii?Q?cxHivPt/x50RdYWtF9wmooTfTHaUbG43Iht7fnqPekLyED/fJXObZdL8ZL/m?=
 =?us-ascii?Q?7ryMzjRlL3WHCtIDID2FKuwF4Xtoa+KXrv5nNBKSVAURkDFxq+P+xJAkJlfl?=
 =?us-ascii?Q?mC8pSpgZqqde2il+WAB+Z1hu9fGb7KzzVbvfP0Mjfq5O53lx3zD2R/FxfXOQ?=
 =?us-ascii?Q?sQdWM24w7Xd3MNKd795DNUfMs7lmJrSfiGi/yau7DipGzGbjSiggwJw99uoJ?=
 =?us-ascii?Q?/mCVb1OrrfTJzjfFGoS9GBtnzKLpdw2/q+1WeUwkxOgcsz9LwMoJ/oKDue4c?=
 =?us-ascii?Q?KaX7MrnoZtn5vt0I3mfBVh13Uw2pWXqFqeu1/4pmHIe/cCJi5enwRAFvB7W6?=
 =?us-ascii?Q?z1L3AAag0paVhrrFd6pHnBRmGCYTuNfJ7hi49JCFMxOPyPD1u4lrg6q5ne6G?=
 =?us-ascii?Q?dnH0DjQpF+CF+sEnhv34IJ8ZdgR2SUI1qkfxGUHxwF+ZS3Smqp9nwzDPxqej?=
 =?us-ascii?Q?YwZ8yjy38cmx7fdsaTCVynfX9pF24ttbpBF5zxZRou2w99CPtww180SgiwKf?=
 =?us-ascii?Q?yOntkMFcbAGsd0RQfX3Xi/+Sr3uD9mYsi0pY8Kw1eSTtP3njQdEnNxSE7E1C?=
 =?us-ascii?Q?ocCoTzNAwqVmkY1m1rvEQj67FNqQ1CO5TFUSuCW1A73lt05XmOkwPWtBdKO1?=
 =?us-ascii?Q?LnT8D4Q+pbkvU8EHjRVMepQlgl7yLcS1Hp6awJCJ1TuCOEo+nUa/kmsQkU+f?=
 =?us-ascii?Q?nxvW3o4p3VYjOAu1S4FCuij4RqoPhT1kWlaQAk2BMZGO65vlEua5lFxovY1D?=
 =?us-ascii?Q?zoc/hGiN8MVMtP56MOliVmN8G2jbigoPqACkThxjTQ5fVWSN8KQJS1H7XCOj?=
 =?us-ascii?Q?Hsyk88wmz0/YcoiMXNZac0J8k8llnhw73VRE/BLtJpYjN6xC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a16529-01e2-4415-3ede-08deaa7ebf09
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:17:28.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nqy/P+bAsh+sboDq+j3XoNczjToVTMdqycGWaaoF7BfSDXmTizBMa8ulehChJVEzcOg72ejQL7oV/FmG7yqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
X-Rspamd-Queue-Id: 310684C8898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284254-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]

When protodown is enabled on a macvlan, two bugs cause the macvlan to
incorrectly report an UP operational state:

1. Toggling the lower device's carrier while protodown is enabled on the
macvlan causes the macvlan to inherit the UP operational state,
effectively bypassing the protodown mechanism.

2. Toggling protodown on and then off on the macvlan while the lower
device has no carrier causes the macvlan to report UP instead of
LOWERLAYERDOWN, since netif_change_proto_down() unconditionally turns
the carrier on.

Patch #1 solves the first problem by making
netif_stacked_transfer_operstate() return early when protodown is on.

Patch #2 solves the second problem by calling
netif_stacked_transfer_operstate() instead of netif_carrier_on() when
protodown is disabled on a net device that has a linked net device.

Patch #3 adds a selftest covering both bugs and the basic protodown
functionality.

Targeting at net-next since these are not regressions (i.e., never
worked).

Note that while these changes are in the core, they should only affect
macvlan as protodown is only supported by macvlan and vxlan and only the
former has a linked net device.

v2:
- Move protodown handling away from drivers to the core (Jakub).
- Add a new test case for vxlan.
v1: https://lore.kernel.org/netdev/20260429124624.835335-1-idosch@nvidia.com/

Ido Schimmel (3):
  net: Do not inherit operational state when protodown is on
  net: Do not unconditionally turn on carrier when turning off protodown
  selftests: net: Add protodown tests

 net/core/dev.c                           |  28 +++-
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/protodown.sh | 182 +++++++++++++++++++++++
 3 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/protodown.sh

-- 
2.54.0


