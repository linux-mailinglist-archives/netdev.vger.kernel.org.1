Return-Path: <netdev+bounces-288728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKlJEKawCWqElQQAu9opvQ
	(envelope-from <netdev+bounces-288728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:12:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C23560E44
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51CDA300694D
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B25A35DA69;
	Sun, 17 May 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jj+P09Yd"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4291A682B
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779019938; cv=fail; b=ZnEk3qwFv73IGMcSos+gfsIt0CsiAH34KSVxFfOhOguoLbK/zZX516JHZKVgO2wo+AR07dj7EcSKjUrTbhRsh802lEjcYVAt+xnov8gWzfCSzRIKmpCNMD8E0cGhVuF6Ir18k0cQqhcHIZ6MwA3Ws3kcMDY97vqV5AAC5bo1l6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779019938; c=relaxed/simple;
	bh=KPSYGG8UnUzou1ZJu4pwc49y1mzvq3hjTxdaleUuMiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D27tanPPYkuVNB5frrZ7g384XJNRsK/3WIJBmcYrE1M5B57gSkYt38JAXyg+J/BKiEOw88OWMWQYvc18gGoQKfgFjO2UWwa/lv+oPrK0CzvISSTxUTsYKKqVFaYle6Hz5jRPokStAHg/bh/cy3cyb7Fy9ZCIlpzr3SisoBjf+fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jj+P09Yd; arc=fail smtp.client-ip=52.101.56.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er7M0UNKYKRZenroZgopnAYnsM0ou8obdiefNbpshfCli+ilICP0cf9BdFdwCITiIdYXcwhDpu2l31Km6MMlhmi8v4cuICv9Tq6FVUAohdEz4k1EvEZ169bIxMOxcCEq9sJidB9v6h91URtgtyEqd+582QtyelJmRKRurPy4tDRpEefh7jeEigKQREV4QreOSGSCd2E34iVEax1BT9eyUzytNc0jWUqeBLgrHr3+a6dgqen0LoNAxkx8pJLG8BN2Hcg1uiB9Te5ob9uhcKfFND6dKS97dd3ByTBxAtN+G2HUK4wtyIeak0kGu68MzavfTb2B4SkenqQEWzDSDMYuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eoqj0cggd4yH2OHyU3oT4MiHfYwl9voiaKN1nEjW6RQ=;
 b=eGi7lOhay1yyLOa6jH46bt4jH0DOvvKy84+bSo23Y3hU5GtWXAkwzdRsE1zL4YJgEVzXkuo/Dl6IY0N9pnRt88b97IMJieZEGYPZzGno3B8qzCw+ANjBpRn3+/dCgCOwTNnOVPeEumnZUuKIuA+htSjeU9QcroFZxDWYYdSU2jExi1VYfh3rmQ/35hS7A87G7Bbdqq1PRZHrshPwC55jGg8N9CgxGymTAaV4FyT3dHMbuBi3Q9rvQG8OumLdqqJJdzL6Om2HuBtmLU1Zryd8elw9L+nxPQc19Ja/0uAc69eN+NxzmFvtxhUQLNL+/uekMdhYqQkXCAUs6wx/7fluHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoqj0cggd4yH2OHyU3oT4MiHfYwl9voiaKN1nEjW6RQ=;
 b=Jj+P09Yd4gP4tItDScKtW5yCURENQOntOgN/uXZYIbAbcse+yGs0JecFRnhRZNLI43wug8ox+4yxVT86MDyN+bXtVEyhZiJXYWoBvH6MWJUlxN3fLTf5kD0Rgg2pbw/VGb4TLIfmfFpP1a7PcvpLmBFXePmu/Sojw/M7fV5rWoi9PwEMBpYU5T8x/nAWdXv2MgvalAoHH3YEgO50cBhQeuZxrb38zM6tgcQ+RpaLMGDjH2hrDOmWdRIclT3eeTFtOcr71FO3bwqmzEJyx3hu/1/tNUeNZz1ITThkw9+QchXEzyCsxWKRSyKZ4hehIv2wBhcd7OiNBqGutNxquxNAaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 12:12:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0025.020; Sun, 17 May 2026
 12:12:14 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	dsahern@kernel.org,
	yongwang@nvidia.com,
	aroulin@nvidia.com,
	petrm@nvidia.com,
	tglx@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] selftests: bridge_vlan_mcast: Test toggling of multicast snooping
Date: Sun, 17 May 2026 15:11:22 +0300
Message-ID: <20260517121122.188333-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517121122.188333-1-idosch@nvidia.com>
References: <20260517121122.188333-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: fcaca7e1-ef6e-4ccf-a2f3-08deb40d87ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	8t9o2McsWa143sMFYelXEYfRLvXWEE8uc/LAdbBdu6erVRc5eJSK+dO4zyNWHkC6+ra/8xBGr+6VkbFnjIs1R1jVT54ZC+OWE+p0sYyyGIFfnmELV8hRqQ6ReNMNuu8ku9nbMBcQ94xzt7Rv3BnSoDeNiknQKZbh84JzFMAtgW8wGdEupVtfOxQt75ACUCAX6LeQdHtKPw3v419Hdd2oToMPAsnHCGrWMF91m2Yi9kl+7+0U4Urm/0YOCZE/y7jOR/m//sXnrbx8xxVSZbbssnyCcNweF9KDfxaqmJq7BF9tuDrmrjgaRW/TIQnHphklKMprcsVxtu5jKqhqOy5JE/R/QgaZ0c2rO+F3ZFeoI5oIw0RZjtEUE0CdOsZ8rdE2bZHne8mN12B9zIiOZgGuSJFK78oH9oWitSoyV5wezdLeC5dUaCudJLuVrEvS2L4mCypcM6Mh1jQ7oFHOgoZvxM4o4zjJajodocG3GjiUv0pE+dKrrWmMlXbbvS3sDj9Ik7KPC6LdZT6kGkvcbyNXom4UdmrYr1UQWKby3YrStQtAgDNLWFu+9GQugP1ConsWYqaR8JeHFzUfrSs1qmb7V9MYMhyHzn20Y3+L6nZUia+BjVmKocc3v6bj8VmmZPQf5yfjHAnhnvV6YM3MqUvKd1bi5N5wuJmO5U56cZ0Y1n8H17jVWbO9Cc9tmvbm+r75
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bVhexOCN/l05+SHizsHbKN01zTg/8wHmklgGY8n4WbHZ2lQK9ABGT7siSC2p?=
 =?us-ascii?Q?K+C/GDnTFmTxzfXMHQF94QF8pZRCYdJ1QOcKCnqf20AbBTDoyUa3WQPqnNhd?=
 =?us-ascii?Q?zGLaA6lEB2lnXv43yw3R3KxzR+9rXPtSdjjxzqNoKKV1NTTZE1SYrynPdxz7?=
 =?us-ascii?Q?SBWHCim23e8XmY1QnyXFsezYMV3YD5i4T1Z4DJVDtQ8rLutdMQqAbHV18MLc?=
 =?us-ascii?Q?vncDXoQYWJydtF2I0pRKHjqC6qZ3yGpkcOm7UOwmtseM21zRgGI+NtxfJ/Y7?=
 =?us-ascii?Q?Rb0+e9chdH/AQdZD3ZndQrq3p3NfGErSHJqSC1e6m+kddvgqrI++IoqsJLbm?=
 =?us-ascii?Q?E/+XaRv27s5d+HVYsRhdd9kaCuNz/SV4U4yYtGfLNxo4lgvcqLGkJS00FABT?=
 =?us-ascii?Q?nrxKFohr9fG31D3458tjCan4RFahCNiHcS3dFTJCixz65RNYI2K0fiVeNvKH?=
 =?us-ascii?Q?VKyevYgqCTA86LE3DjX8LLn463Btw9q98T+pgL6rtCqPSY7KkOKiNbZ4n2oI?=
 =?us-ascii?Q?uLdF899kTtypLyXuguyn/9iglxZ8MVmyOmQE3Jo+JV6A67iXwPgZJbPsrsg8?=
 =?us-ascii?Q?1N/f6ZKn0GAeH0qphTE7MUPHuYt9uDgLyP36ywAb0nB5Tu5hU5ArdBPq+tfD?=
 =?us-ascii?Q?O41kCf5IEK5ietZjWJnc3FysyBmPUkDvyLbPGDFLmJV2ZleQH+1/O4tBAHUY?=
 =?us-ascii?Q?YH19HxZgMwSEDeWHPZiBNBVbRuvbH6A/toEyBekvHRBboKGdI2CBQRlrMc9v?=
 =?us-ascii?Q?x0UzWyDwHE2ar2Ss+h6R30SrJzaNpoRcRpO8YioDzYSi/4+QZ2jm+9o1Euhs?=
 =?us-ascii?Q?m4MhFYkDR48jYXpGKA5zN+FAzYHCu5ePl7YLYTehfFzg7CG3Y/BOpkqnmbg6?=
 =?us-ascii?Q?ZNBBYlCtiHIQ/I/uWlqLmf+1swTfrFJsXx26h+GFX+s+QB0g5hsBkQKliOI7?=
 =?us-ascii?Q?IWvqWGDU/lZKWkOhl5QXPTe3mbmre8w4V2An4kXD7ZBWDk9s2WXGKsHaOXMl?=
 =?us-ascii?Q?iw+9B6H1RQdXekQ3+Zmum32E0m83K3GNXhojh0m6HpYAGoFDqSfg4IROFgiw?=
 =?us-ascii?Q?03Lw9E/K3Ts3h/qv5G1GkNiOxRdfw+dvVZvEBVCn8oVimaYBKFNxhGEU6WoR?=
 =?us-ascii?Q?oL1JiyCZV67f8oFbBDD9XSA6p/lkGMkWcQm6S/1886wHhQMJHT2jCIMTNsQm?=
 =?us-ascii?Q?8bvlIkddyMQCRSYR9usXs2QcieWIr7zarvsDjHsAp7gA+Zg+1UtuGiwN/0Ow?=
 =?us-ascii?Q?gxKe+yPPnfQIH/Wi5fMpguBbd9VqjJOvUkFrIddBR2n0wi2UkEUMPJEUy3ZE?=
 =?us-ascii?Q?zlCzXrMCJhBjCKIdSDARfreOUkghVZEmU4VGz/dMsayWgFQG1Av0WUGGWXp6?=
 =?us-ascii?Q?cUfoYElzJbEfwI8cppWU9HsP+5/uNhbGBoUJdj5ZyJlReEknO9LCc00yusA9?=
 =?us-ascii?Q?OU8F1+F1Rmqn4ETRsnD+1viTJdx8m9mOfSiVysXBHzSceousGPD3VPHAt45p?=
 =?us-ascii?Q?n+N1GQHUYC/XmD5NQ/P/PuLUmh17O1ZS1+bGwoEPmaqYeTBx7SmzqwmQoSK/?=
 =?us-ascii?Q?3nNjGvNbykMc/HnRoJ0pyVbN36AwLgK9KlFhK8d3ljnGBY4Tos9wWDYOqBBl?=
 =?us-ascii?Q?/biApF9RDj+z89sNdC6x+Oi5cF9YVfjhc2C6whuWCgzTkuz8+VfbB+HtDwP5?=
 =?us-ascii?Q?2EEEAvRPqQl5LXE4z7po9XweeubOaZy+Yrt3cwJ80AfHAxY9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaca7e1-ef6e-4ccf-a2f3-08deb40d87ac
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 12:12:13.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F28b5hhg9FApCbr+hIignVwiZwD+Oa9oW4N6RSi5rnedxazm7NIJf/jas9RMoTCgz3qzqbX2SEfZURHgOuHpkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
X-Rspamd-Queue-Id: A0C23560E44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288728-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Test toggling of multicast snooping when per-VLAN multicast snooping is
enabled. The test always passes, but without "bridge: mcast: Fix
possible use-after-free when removing a bridge port" it results in a
splat.

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/forwarding/bridge_vlan_mcast.sh       | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index e8031f68200a..ebdb4c790a5d 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -4,7 +4,7 @@
 ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
 	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test \
 	   vlmc_querier_intvl_test vlmc_query_intvl_test vlmc_query_response_intvl_test \
-	   vlmc_router_port_test vlmc_filtering_test"
+	   vlmc_router_port_test vlmc_filtering_test vlmc_mcast_toggle_test"
 NUM_NETIFS=4
 CHECK_TC="yes"
 TEST_GROUP="239.10.10.10"
@@ -537,6 +537,34 @@ vlmc_filtering_test()
 	log_test "Disable multicast vlan snooping when vlan filtering is disabled"
 }
 
+vlmc_mcast_toggle_test()
+{
+	RET=0
+
+	ip link add name br1-mcast up type bridge mcast_snooping 1 mcast_querier 1 vlan_filtering 1
+	ip link add name dummy1-mcast up master br1-mcast type dummy
+
+	# Enabling per-VLAN multicast snooping should disable the per-port
+	# multicast context on "dummy1-mcast".
+	ip link set dev br1-mcast type bridge mcast_vlan_snooping 1
+
+	# Toggling multicast snooping on the bridge should not affect the
+	# per-port multicast context on "dummy1-mcast" given that per-VLAN
+	# multicast snooping is enabled.
+	ip link set dev br1-mcast type bridge mcast_snooping 0
+	ip link set dev br1-mcast type bridge mcast_snooping 1
+
+	# If both the per-port and per-{port, VLAN} multicast contexts are
+	# enabled on "dummy1-mcast", removing it from the bridge will result
+	# in a splat.
+	ip link set dev dummy1-mcast nomaster
+
+	log_test "Toggling mcast snooping with per-VLAN mcast snooping enabled"
+
+	ip link del dev dummy1-mcast
+	ip link del dev br1-mcast
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.54.0


