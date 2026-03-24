Return-Path: <netdev+bounces-271243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH9eIBHewmkqnAQAu9opvQ
	(envelope-from <netdev+bounces-271243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:55:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E1031B205
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14B8F30CA34A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AC040F8C4;
	Tue, 24 Mar 2026 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tXADJqMj"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3574407593;
	Tue, 24 Mar 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378194; cv=fail; b=P8LbvOH1CB/DtOkLgED8DoVRC9drpbC6aHL6/YdNZ3AHy9SYz4n+VgtFMGR6ZGYZ2kIJc8GCC17pROdyOw0bQfv8qQ0sky32iUUnG7yXhPTL5gA87ZvXktCF/aDb1l6MDtChfUkTZH9+/OSkKYGdA9/ZEI2SIGPYeeZm1Zuzq5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378194; c=relaxed/simple;
	bh=v+ocEoyVHuGLPqu+qAxkQDW892fcIZyVTWZTQtvq8Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRYPeEDPM2m1H/4l7drT8uWrDudEnCriaYldK+rVpmKk/A/YLR0wwUDZM287v6fPAxqMamV6p7kW6aN6+VES5sSPu2Mcq1tHfWRLdSuUQDNgL9cwsTG/7/xwPBoxxtSdBwqSUusKmwBt+FnQ/MQRp9h40Mus+kBVp7zNIAZqMrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tXADJqMj; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0Prr5KAE5rncM50+aejTUhbvgTIWsOd6xAq8RH8hHDr2+qa+Qkkpp/D7HUVcUJPO4rdN3p1WSxq3MDjbuKmFjCXAzpv5bt4ry11CCr1ThPt+n0MNGz4PGLHi3vKddx1DEWkgZkN4qvDt4flHz/2NwpM+rA7Xn9F2+KN9FBcNr+hwab9zwV9sqy2URdkpFfWMyrpymYlnInyC63xBR5xbfnu45ZJWoRh5C1d/So+piX5sj0vWEWX850avVCyElkSI6fe0UdE2Svn7eN8nsAbfVlxwVtLw+1lu3b9HFTGQ672nOosXiCBgLvsbaBdm6gESjDs9XRUh5Ujba6Rt2qOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bziRk3oAwbtzaxlygyg/dc4uD+31PiC3dcYC46IltA=;
 b=EImrWnkKsO62/N3LfqJLs8OKnOLY9eCiHe9wwh4kb0J2JYX52NVODiWHl1p5CVuuNGeKiqqFPBOrEVCEPNtC8/i4uCuwme5AL7EeUZSS1WacVH+0Ch3WsOdn7G4d0sUv+bHn33Cmc+mGAUE+qaFu7ReuiEs2pGU6RxmQbN/Aezc/WRnn0CUERXTVuV4YkeopE6aFrW3uw0nsLhAPKWsZ4j1IOiHsNU5HXrtIfZrw153c3yzNwNmF9qTfxRYoIDzzSxCM2cjyiqg6KbUQdRgP8f/J/7024eNTrvpNfO2ShAPhD5UC9MfQFW9Oqszxs+e1hft9Rk/7QxAlmlUwKWGrnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bziRk3oAwbtzaxlygyg/dc4uD+31PiC3dcYC46IltA=;
 b=tXADJqMj3S58oaSaTotmqMv/JuDtkEq76wF/XSk8w1bRmkS+L94AvykfJ2rnyoJorVYMxd3Q5I4YTQ7OT/M7RRXcB4Y1yobj9IXjUwGZu/Y3u0UqU8Op3/LnBWBel4ZLV+8etnHS1xOtIj1X2fhwrm/QCPM4+TbstL9dh8/PEkk1nlMdPhHWGw8zwPOHJzcByg5eJ3CQs5BQwycxnQS8xCsDajKeESUbVpg7cCytbADwWV7/SjwddDoObZ05f6GHH9dpUTuV9mREqLKK7UgDUH3xyiWKs4cGPLCqjspIjalGfPkFRwnM7bOjf1b56ktLj6PeZxKVjNN90B8kftVZXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Tue, 24 Mar 2026 18:49:47 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:49:46 +0000
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
Subject: [PATCH net-next 2/3] docs: net: bridge: document stp_mode attribute
Date: Tue, 24 Mar 2026 11:49:41 -0700
Message-ID: <20260324184942.2828691-3-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324184942.2828691-1-aroulin@nvidia.com>
References: <20260324184942.2828691-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1686104c-e468-4e37-484e-08de89d61ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vH6kLTTFHJ0DqXyX2s7LDnwj8wRDcOuE0kwLmFk9VeqYCN0JWyhyaTb8EVp65pev2UJ0T0BgMCH8qfmmHQO1fw2oMAvQRhk3G1bnVdqpYNB9vstEUpvFMWGa7V4B0B6iYkbaIfJssndJGzIAPGdvVmy40rUWpFUWMmeyP8odHd05JLX5Fv01Hw9n9t+mF0c/WuIS2TPD0EhO6jWoDOWX1My317C1BVGTsFkth/dTEF/BgiK1S8YjzvGN/X/+XaihwUqfdYFheh/GGwKx40EszQTo8m7nzcJxXPs3gAYHkAEwBvgMBfP9FRGkwEzzWp9MiNAmzr3RBPzPjlWL6rw3qhVg8H1clHV9wN19atiGJuRK13uZFAvOYNyWNRYZ6YZoM8L8wv1iyLM84e9hnxMcVCEiSSeDKARg54VvJHFIO/RNp3dZwMnqk04L/kARjH1SDKRlOpLYritSx53i7yk2gfdowdXEDrU6/mzA+GN0yQUixf6tY06ZdtBvJwBEQhgR891gu56gWXc81G5HgrEJ0kT3g8j43InZYlM7aSR8dcjBZwceY9DSNChsDtlbHZ6fyvVPf/L4WD7je9SiDRIKs3PmegK4MmQfMDf6mmm18t/vevzzGQJq9omYnET3Yo2c9r+n7p3HDKeEqNnRSDFkctFiqeyaB4B2AYVrkkICjzxyHqMQpqYO8p/lDX8S5AER5SBgzXkLWTOnwfyIIup3BFr0ZeGEBekBXoAj8MtQOtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7pUAE4XZvsXvwaUZRG3FDq1dEW5xsfJeEa/4Dm/XsMY6a8HF+nIUWmDN/7A9?=
 =?us-ascii?Q?tEq9tipAFvQACWYAgNEPc2Y026ysmndOYRtPlLGEA8WXixjvKcKz69BY6itr?=
 =?us-ascii?Q?HTuW2KDqtKzKLuk71R6LJ078NYSa54kxn7Ps5/T9ZAhbbWfGAW1oUhH5mUHC?=
 =?us-ascii?Q?RLL6tjgjTchUvWgT+P9wkWbDwqPl9xg0Su4tTQzgX7y11THRcgQ0GxPXj1KA?=
 =?us-ascii?Q?1RtyQrHrHatowta4XSuJcn9x+0I9lnclxr15Z52/AiXyWaVxOF0/jBfTEL8u?=
 =?us-ascii?Q?lIUul1uM7nTjMR5KKgbeIz67yJ4JSua/jqftnkTEu662DaZrX2VXQBFJK4p8?=
 =?us-ascii?Q?fIgjoZM62OwDzyk5pGL6pFo0v3AdYsjNnXdVi9PFkoARCCcGpZ9skDJSyj2Q?=
 =?us-ascii?Q?LfacK9KTXFXeOTm/JpU6swBrqDKNpFZX5SbMWhhMlZoH9sBtC/ELFjyH2mFu?=
 =?us-ascii?Q?g8fZwbfnT/O8ty1ws42Me6HEgbG8pDCPlDb5YeXTsuDZ9zoNU70ebjj3reP/?=
 =?us-ascii?Q?dXhJ3+FZwFdr6bjU3ZhFK6rk6cWa5FJ+WZcYK4HWWLf6Ym21TNwNcBh3v8yd?=
 =?us-ascii?Q?cm+qAT+Hmv2O5yT53lSoWoDO6hpRM7KeA1VJkwokaiLyFhYWE5Fuy7MLL5Dk?=
 =?us-ascii?Q?GWlMrKNmI7vxyo9brYMqiKFHyicArvvJJBObbM7gvuOmuYwy5mmCu7Fwb5xi?=
 =?us-ascii?Q?w0BydvrKqv3U5wMxk/8hWNAg3wxkeQEIHDgG+EEu6jLThEBgMAhsm5meeJUj?=
 =?us-ascii?Q?26Ab4yaqLiWMrKd5Vh/PNZzrrQkC1MMkVRqeA1GyrSILLtZ7rOA64Dkyk3/C?=
 =?us-ascii?Q?UCeziODYcsarMZkQGdEL+R8P7jMUgbDWkO5B8mf3p6rHuw1wWmwGbD41RNaL?=
 =?us-ascii?Q?hrU2ffA6jaUmUngwdycs93N+z4xG69KCQlr44BTwqR6smWyDxkvnF9NmjbII?=
 =?us-ascii?Q?jlm/O+3Tq69f0KN6P3mmwgJ5hMRpW0/ExonCjM5sdoG47Y9fwAWMO8D0plWV?=
 =?us-ascii?Q?kBHXVf+TDzTjOikE6SmzBT5+YGH07c5tAceIFLJymZMYwRjSdsiM/pHjCLDO?=
 =?us-ascii?Q?csTc5vd314D/sJBPLFla869MIXZXsbYXDNsA38G0bEk97MRBI22G1A74rDlp?=
 =?us-ascii?Q?jjebGgypZ98zqe2nuGTc7CoX0w42kQN7DDVkfOVoTr/3jiiyt6Fbh9hYDcY+?=
 =?us-ascii?Q?27I+w1NGUOKOA1H9uZZZoWrKbiJ7pD/zzfw6nudQoaaAmSuQ+mVxcNszSfwS?=
 =?us-ascii?Q?uQ7piabutCRwyWO5ZtQLIS3zm8tLQuDeCFW+EnboREtz2G3CLyK6amNCkz+Y?=
 =?us-ascii?Q?Z5ZGtiVDgdToxSw06609F/3MA1im9idyvKJQld/o4pGpOjVot3PUd/v2gOvO?=
 =?us-ascii?Q?8wrpQwZMh+er9frxdq26Zy23dI+qqRmABbjz6yc4eSpf0y5TR/YV7GSfXaX3?=
 =?us-ascii?Q?U1GCDFsaDZaH1R8CeQhvd5M/zPdumwX19NrXEuZdaRYFaN+ObUFfiEQgurJy?=
 =?us-ascii?Q?/oIfe5XeqiPxCH9rpP/dIcB+mg47nB4YLNAjzpws7lrLypKnJfF9lHfqEWs/?=
 =?us-ascii?Q?EYaRJM17JAu3LJkRCRDXy45oCHGKkyJtcWlWbzK3aXoA7Vz4eckJXL3b5lW1?=
 =?us-ascii?Q?Lf7X4WNu2G56AExUSgCUzQ6HibJaWQeaew3g/uFaboViWbVD6CizK91jLO6b?=
 =?us-ascii?Q?h/Ur5/WEZBNfItpv8CmvhShosm142rtquTE77EZE8QTV/A0arkWE9TYbfYDJ?=
 =?us-ascii?Q?WDd17xpxxA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1686104c-e468-4e37-484e-08de89d61ec3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:49:46.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhU8lJjyIKzAETuRlPFdvdFMBcWrOFKcfOw7dVr/JgtcAq7KBQd1Tj0fRuB4/6U93h53bPgG2FC/8VqqiNWNIQ==
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
	TAGGED_FROM(0.00)[bounces-271243-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9E1031B205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add documentation for the IFLA_BR_STP_MODE bridge attribute in the
"User space STP helper" section of the bridge documentation. Reference
the BR_STP_MODE_* values via kernel-doc and describe the use case for
network namespace environments.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---
 Documentation/networking/bridge.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index ef8b73e157b26..c1e6ea52c9e59 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -148,6 +148,28 @@ called by the kernel when STP is enabled/disabled on a bridge
 stp_state <0|1>``).  The kernel enables user_stp mode if that command returns
 0, or enables kernel_stp mode if that command returns any other value.
 
+STP mode selection
+------------------
+
+The ``IFLA_BR_STP_MODE`` bridge attribute allows explicit control over how
+STP operates when enabled, bypassing the ``/sbin/bridge-stp`` helper
+entirely for the ``user`` and ``kernel`` modes.
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: Bridge STP mode values
+
+The default mode is ``BR_STP_MODE_AUTO``, which preserves the traditional
+behavior of invoking the ``/sbin/bridge-stp`` helper. The ``user`` and
+``kernel`` modes are particularly useful in network namespace environments
+where the helper mechanism is not available, as ``call_usermodehelper()``
+is restricted to the initial network namespace.
+
+Example::
+
+  ip link set dev br0 type bridge stp_mode user stp_state 1
+
+The mode can only be changed while STP is disabled.
+
 VLAN
 ====
 
-- 
2.43.0


