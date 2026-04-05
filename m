Return-Path: <netdev+bounces-275486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Es9BMXL0mkhbAcAu9opvQ
	(envelope-from <netdev+bounces-275486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 22:53:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92E39FD0C
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C31C030157E2
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F740384256;
	Sun,  5 Apr 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0wOhF3T"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B4383C9D;
	Sun,  5 Apr 2026 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775422355; cv=fail; b=VqsyjN504z3dHiUsGrzTLn5/xpCrA4NQPUkOBLUrSyM7RWVKR1e/a0tZiNLmPDo5+B42PeuSez/UCjdJ0/CPKUzsABUmtcDhLzG6YI7yl9C0FCEK9MxBhu00PGIk6ug96fIG4TP5+1xgNVL7Ev/nam1sv7P5bxzvLDgwNoDXky4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775422355; c=relaxed/simple;
	bh=7Yt3e+diZQtSb1cDXt8ELj2SohIVkhnYuFZyJk4Tr7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2ptCzXi5ZK2D78J9ASqGalllh9+kjZh4ffpkyq2a5e9Vf9/d9cvRd1h15s+038caKYxMCHSdR3fE383J6ySC+fyPy1R83R5cyr78/dEAq0QGTtMzS6LEZbtXAvxruwNDLJAhomzsTl9QePNb6u8Dt5KbfE0/0HHth2BpDdqSR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0wOhF3T; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRqXLFODLH9hDYK7Ejo0hIrAvp4mrZ3m3TTX4/q2FbYsMdB5tBX8fR7hOxt9MGGD7WckcW5iZmEDeOXwiX+lFeRwKkJHlPUoAwKkkFqIVl/ZJmj+heGuvJIfAOG7FgzfYyvEmHQ7QhlCU6Lp/TVXPVvDiEkdmkmhy7EOX56NVaHpzR8Qh5pQODDqzHNPYRU94fVyYutnbZoCAG60qPZlOTLwQ69IeLYcYeiagVDUhilf2f5mqsSVoEMnkGWLv9Th+sp1xKENmdrfJ8Vm/uYaLNogaCPd9YBSUYzbDhoL40hktCy3dlLS7A1bY8ZAOE0iB50jvc5EG9cjQFZaYkQGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCzhZrB7vOl2KlscA9l2DPFieR/udLdl29V/diTqWsU=;
 b=otoexlz+KUzgNNXv15GleGTQNfCFWmKjXccMv8U+BHnEv7HAkIIfj9zzlTbVhwql4RWHW6zGraYfC1aXSY+Npsqra0Awm2YZtXgKzr3rv+ngkX2REQNFf+M54ogBUh31EBqJt5wQd2paI4ch+gbAKXIaOsy+1cuIJpDbpfz6On/hUCwIMBRGYBOr6CpNypX9ayZ1VXIFCDLyVRGrfruurH9/f22geIaKn8SUlpugR9meWMGt2nCk7E1m6JZaTH8VraM91yf8kvwdrCDW1G3297yR9w2EituDh59kRurRoDkT8R+MrAyhCOyTM2Xk76mMMk5nrbDh2Z4lCkIbV02O7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCzhZrB7vOl2KlscA9l2DPFieR/udLdl29V/diTqWsU=;
 b=a0wOhF3Tr4XH6vP4WhmBQvKa6poGy+9afr3V0XA9kdgEesBBmaj7YLrXLXrCxOENZbBODwGHyzDITjnBU8d+tD97rbrYP66dRrrygOycP7wFqByNkJgwjH21Q1JMaupLp+etBzxUI4yKn7cxiqirsg5hbaxD5Tr7tH8MZpcJiUg+oygUq8CBzOOysQNVUE3IpQ6Eb4hqRc8wnf4i/qiV98+++AXfgXUly1k1eIWZ8GPVVf7V2TFVRRZqcrk77xD+mLryhBvo4guIkI3PdxsrfQRYZRA579gY/k+nZAc6Qv2HMbpvqXO1Ve7k0WcUkoNuKv1e2MHdG//dmIOoC90nDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Sun, 5 Apr
 2026 20:52:29 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.020; Sun, 5 Apr 2026
 20:52:29 +0000
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
Subject: [PATCH net-next v4 2/3] docs: net: bridge: document stp_mode attribute
Date: Sun,  5 Apr 2026 13:52:23 -0700
Message-ID: <20260405205224.3163000-3-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405205224.3163000-1-aroulin@nvidia.com>
References: <20260405205224.3163000-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cd0917-0c2f-4875-7513-08de93554036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G1UUUkMhVyqebqBgrMCLZ2bcSfu6QcU4Oap3Ek2xnVLUOQQCjj0V/IK2e5awIjOo1s5wipkJbXMjTON4xBQ6CSra8GTL/D0nl0SDtaJylzngRvjNGMN30Wrj+NyrvtMqvh0iAqt5vjwJkrevcFe0gOYqF3cmhSZfetdw0DAM3n8/5QwlJOM5iOIYTfMFVqPMPiA6XHNgFIacS4t44qgiezYKNveiqvSELhukFGCtmNO32fFI35qt0rnYsWF5JtPueWsRlr0S1IY2AkcuCxJoy7oEJKXBvNzW8QLCiGYEPcOWoJd1mLvD84kbafJG685xbXLQod4ygDHDkwSBLF1dpUYMvkwVg27u7rzzPHJFkYIB8Jm4BXRhKRESAMEYYJW0sJF9NAWzSC5LViQkMs/6876yq59H36lJgPaI1ScgPcIu11hBvl6L9JtVurjsvxbCiNal5R7+MSbN7gZvNbabKK7y1nHfVdPrpPlpDT6oVXrPgRkr0FfjstsPYnfpUCqEWO/f6AJDeWRwrw81n+e86hWTRGW4YS77LoLriH+lsSlWOIvRhHt58xiVYteT47SyxWZ8Q7uGveYlt8H2TmdqLJxic9TOGDdNYaunjMDK8/BHQfYiV3jLxEbRiMdtPg9auWhZL0KHDg6C5YfziRnEVH+JGebpml4cSmwi+L2vTG72T8++iTJCPlrl3UUGaFj5088JZnH9Gp48WyyuWAp1MrHbaf5tc/Nrjy5NjCbpZY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GgTSIJV4rZ8S0Q80mTsu70FaCHC5QXOUjS3jqlPa+i11FfEtd+hQHAplx6P6?=
 =?us-ascii?Q?WWXgV5TTjhBN3q/vLbDb48fMFRYXtyh23zztb2B1Toud4rPJqt/bg+V9GV6j?=
 =?us-ascii?Q?05HmDeDGoskgjR0wG5sEjZXbytJh2rKleiRwnrp3i/k6Yfuu0sH+xPLHZwQ4?=
 =?us-ascii?Q?eJihGjtoshnKajKhjsCx0fH9iqyDSJPAl55k5pvYyafx4sNu7VbAoaJB0O/4?=
 =?us-ascii?Q?9Qwh8iVrxIhve9eEDXQwuNAMwHzMYK8R6aMH0rFTaIEFe8PlH+R6LtfHtGDT?=
 =?us-ascii?Q?PRPCV5SG5LmEfwxrPVyqjpvcV7cGQ2+D09/il0kO71ME6/h/0KNZWl4i+0yZ?=
 =?us-ascii?Q?RksgxQAxbyGL3N4tnkPd6psrfTymNY/XkDYgLpsb6NscOnoLVIvLcMgCVL0i?=
 =?us-ascii?Q?U7W8O8nkkjmELG3Nb7j0y0VCKnhkjbFbndY6XGgU3pGr/fBulfDBPQgQgR4y?=
 =?us-ascii?Q?I/lOo5bX2o9a/RFUm7DQ25y093zlsMZ//nchB3Fw7C2F2ZUp627jjr1j7LD0?=
 =?us-ascii?Q?fOlF3I03to/ATXNSQIJTkzO/9dfJfw2qBnR90QbuCpPGQ/9naaWF2L6Fmv1f?=
 =?us-ascii?Q?XYQUPHJjx7MPnhBbrNDhMezq6NhS9iWgQpFS+nKNwnfNaziA3YE+AOYEOshK?=
 =?us-ascii?Q?HbxvAiB4ISIIQuWWf5ij0g32Vgem1zzJ+Tj5MrGK76SQtoregPHAEzGOX3QC?=
 =?us-ascii?Q?ZM74qP0gWcMfsutgCw6R4a22pKRvE9Y5s74ydgVCJkNva+SShwjHc7cIvs6L?=
 =?us-ascii?Q?HCgCVffJ/U2Mug7wvN5W2cVUJ8pZt1Gpi5KyOynBvvsqgeSPXrkGtz45dozc?=
 =?us-ascii?Q?RSX51dSxpBWw2jLqKR5NRQMj5ZV/m2MQfCUWd+tYqdgYgRT4lNRIQIKlJVxo?=
 =?us-ascii?Q?eCV+rlrpYP9CzinN10A9K2QwlYfKz1gZ5d8BrU8INI2vz2ka6jXqvF4Blge/?=
 =?us-ascii?Q?ubki8xrf42fwsbPEVnxcVyTFPJnc/dmkriP9aaaBQoMKR+LjGad+41/yBHxH?=
 =?us-ascii?Q?vd2jndWk/BDibCaKxPv1bh0Mx7YqhDvpo41j4iGscT5n81VfPYIAl4swjZxn?=
 =?us-ascii?Q?X6f0E1aNgt32eVtuOGGit9qFDreUVdasnvIUQ7oyd95kR5s//DZwzpq9X3nV?=
 =?us-ascii?Q?BGHwzi4Jzjei1uaYM+6lFl2yXFk769BwT7XUAJlQlUy1YP1v9D7mpW/7s085?=
 =?us-ascii?Q?mmwItD5G7aiSLlMrDL6HFRMlNT9k6obreS+zeNZwdSk/VAX3ESmZrQZ4eQj7?=
 =?us-ascii?Q?8f9VuYerCS+kJhf0awmK+Hm9w+X9I8dP9RwBc//eCy1wRMlF6J0mqPX31bn9?=
 =?us-ascii?Q?Pt+mfMhuxlWdwmK8PDHnFN3sEu74HqX1LxdIgelaKd54zUBRJB3nFX54tzNk?=
 =?us-ascii?Q?/vh3uLg7/T+ghOxOgNu57lNTRx8mQB+ce9BWG2GwEOb67gy9N29UM+NI0myA?=
 =?us-ascii?Q?N9Fn15lbZ2ofKjzr5DtFjXvHNxQ53aFEpbdmRAOwNFjf7mSRjD7N5GvUG3IT?=
 =?us-ascii?Q?KZaHLvfcFUq89mWQva3acjjNvvaoVOVoQbbTEvh6+OGGtRdQg9x7Hoe+3HLY?=
 =?us-ascii?Q?3bzPM3br8XtQiGAPhMaUBO3Ka5Sr09/paDbZJIMRX2woDYflSWe2gxpxNQip?=
 =?us-ascii?Q?Z2tviLdVt1HLQvNdY5zX95A3lmXA2eRQHNIExfi4mfT9MytMDVG0Bm4UPCbA?=
 =?us-ascii?Q?H4BOid/osAOSdjG7rk5BZsJB56DnB1x8FSFEQU72rxlQUW4kgzFtLCf4MXca?=
 =?us-ascii?Q?m5aXax9p+A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cd0917-0c2f-4875-7513-08de93554036
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 20:52:29.2855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d/vDLPeMFkRYbU+YIQj9J21YBB65y+xTFjjFxMKJXFHTAmIYy4lKrdy0an950Hq9S+2AO+pqK4R/8au/b40AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275486-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7B92E39FD0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add documentation for the IFLA_BR_STP_MODE bridge attribute in the
"User space STP helper" section of the bridge documentation. Reference
the BR_STP_MODE_* values via kernel-doc and describe the use case for
network namespace environments.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
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


