Return-Path: <netdev+bounces-260680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK5qDKE7nmkZUQQAu9opvQ
	(envelope-from <netdev+bounces-260680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:00:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C7418E3AD
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 156AA30151E0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1C363C46;
	Wed, 25 Feb 2026 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZhyxDFr"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4526322B96;
	Wed, 25 Feb 2026 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977622; cv=fail; b=DLxesdtE7ZOHgayxa6ILD1EJuoQ1P1Ffsg0tM4HOopHTLkhwMnQAmpbvnGCu8LnZQ9g0aH3yclSkjPm4frWB21HipyCBnkjlAnD6IxXD8TBmd1zN+HJJelOgvdpI6fzoPZJTFJVQ5fRlG6gURByKKWCHT/0HBNiHZeXBRSDwvjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977622; c=relaxed/simple;
	bh=cDN2cdmhOz8KTLEtApNSBOaZJwR8lc1Vhg6+bJxDdwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWh8DdEgvFmVnMA7rEGpGlvAjzJz4P7QE5RVXH1q4RHvL+hVbTRTW/XkIuZ8B/42L96fgXHhLHgW+O1JgUrw+x7cSJMtxKLkt3A8nGFSbbCYjIhSaW7IIOmC/JKL1VMcbTBwSHrvKyAQzv75TGhkrnDcHBoOadS4xtmPAKoSXoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZhyxDFr; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hs/tukHLO1fkIRi5cZdoOoMRW/HUbCKH2mV2EYZ3bh+Rdd+oK7Yy6Nxt01vDsO/LN0crGIOqatI3brEMAblEq0TwamPvqBo9+96wiwCnbFgH6dCloTofJaYAVcVvGmIoyWL/FtD5PWmR/AOYgdM5t+vr0iM3KO93iKLNrhrIcnv29TvJb+euAkRswG5YN0+mk8Tm25guYOyNBg0/aDNb3LURkpGbzh2UcNVXHWoIMUGqZTKtru36tUWLKJQIU5Ymmmtff2OdWlpzQpU9wwI/u2r925D6+Uvu9k7X2mET8w83ruOUMTeMQjmfSa2sJR5PAMlUPmnb1DbZAbx2zMwKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7n/jAmQe2s45FBifuAeWwcWj3Si2cW0GeTwfT77WSU=;
 b=vUTuBLTjaDqog8XtOHaERWMM09mQhEFjDTfGZl/cDDSkLfu3/BE8s0en/zs+n9cWhKSxfpcM4I7sKTV4iy0rlWdRGxOpkrPxxibGCtVhv8WpFqULZCC7zomTJYvgEFu+B0gSLQ/6gnBOiEqm0iB0sEM2eP7LX9l7nnaQdSsHBQVYnMRSg/ZNI21TTxt/7yDSNFsaMJxtI4K2WHasyKSfEGadtr6fSf0VEy9+iA+wHyip17THhvWrAoFp6GTz7oQsMVbF15wQ4sb0uXAHYUqESdOrCkLUqWTWPSbl5cfkrVNh8bPxpah+oxUP5PODKHu5kukBbZ/3QE4CF7zPQtrrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7n/jAmQe2s45FBifuAeWwcWj3Si2cW0GeTwfT77WSU=;
 b=kZhyxDFrXXdK3A6clmPoVKqQBnhh9Sxo6p2nQhr8yl3GPFkGa9YtKn1J+jtbn6IU/M+44lGeCBKPpyZhyoZlJ6xaG7y4ww7dnO3qXpG5W0kASfY7RRd078qEfHBfP9m9NtplEAK7yRDcBeN5A27tenNUUGmClY7QS24z/CTnfqdsnz57qHUuMoxnmUwB4MmQsM/thf7npdPajFcy94zIYutbX2QZgYbppOyh8sxlIpzm5F8udFF/fqpcNTGzACSzwZG1C3wrsXchsdXkBVtq9SscgzrXt7H6vgD/fHv7oA7XUJB1kddW3gNvNuRNwFjkuVFr473oe2PckO20TfBqOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 00:00:16 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:00:16 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH RESEND 3/3] ice: use bitmap_empty() in ice_vf_has_no_qs_ena
Date: Tue, 24 Feb 2026 19:00:05 -0500
Message-ID: <20260225000007.255837-4-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225000007.255837-1-ynorov@nvidia.com>
References: <20260225000007.255837-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:408:e4::26) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b75a10-ae11-4ba3-5936-08de7400db12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBWCMetrPNwKi5mK/kHdPE0GFIPI78aPGnOUqlueDrp0P3BWY9J4jH187vo6?=
 =?us-ascii?Q?F0K3NvRM+FPcx0K+8cjKZs+d1RkBi+hztbjzZdfOi0PWW6bsNk3h7Mxq8Zn0?=
 =?us-ascii?Q?y12IWhRsDq6S+tqkQZ6JqBPzj2bzQG21Ck0K0HI/79ui+ZzlDaAoqCjq+eH1?=
 =?us-ascii?Q?3ghSVAIi209xb229TPNKQMfKBZLqYqhUh9WJrByNVa7ddmhgHHW9gC4lbLn/?=
 =?us-ascii?Q?VApPW5533ZrVSU5/Uw8elaBgyd3B6b2Z58edIA2igXPMgBgV1U0BVCSCTBRt?=
 =?us-ascii?Q?Juw36cWnGwSB//keBmDaFS3+9XbNlqqq/0q/heltEwHqb6YTOOJ5I0V0KHN/?=
 =?us-ascii?Q?3wHrqgEIaF4603iJFvQfhRCyne1aaVxDhPERUnRceQvj/aHYwi8MXkWACgKY?=
 =?us-ascii?Q?zMRu56flz7p9QEE6vvhMjO0ZO9qjnY+Hysr3g+qwq202AZcJYyDPU2KmepAT?=
 =?us-ascii?Q?OxNbG7sbkeXv+Uv0rLuYX5AS4fPbjdm1CKZn6YQHGG+2FY3EqzWEkW7mt56Z?=
 =?us-ascii?Q?P09zhx/Zi59knYTUxZtkxxxwJ6ePBuU2f4ZENf/t8bc7rGu/CVGWTXaaSRIt?=
 =?us-ascii?Q?JputQ7zX0+/hxnphE/W08jvbpY+UJmvAzEZb9gSDdDGD0ADVGeQO+1b6zIdn?=
 =?us-ascii?Q?U8FqYcZtnph07qfRpm0ysd/ydBZ70AIpGtCMu/qmdVvCjxsL8oF6bF8N0J8F?=
 =?us-ascii?Q?M2rxVRcFJj7MLQdHCUf6coKFNsHF/myJwqTNE9w6IEryw245dLh3mRZ3aUEw?=
 =?us-ascii?Q?qe5xyYzlzH1vyZ+hI4arTGfajmN3Nqb8QcowOyvD5NpXz+rACbWEi8QJ+Vrk?=
 =?us-ascii?Q?9iSTg19fdl2tj4MP7OdFigBZdBVVIeVIgLsZ+lUbNvXbCHjONxBZndZ8IE0I?=
 =?us-ascii?Q?RDAJXUnSEWGZHHbQXqM2X6UeBtJipaacOs2HoB0VWtoQZbMCg57MSs9A+7Bk?=
 =?us-ascii?Q?T9Izk/0/TqCpWJPhg06unM605h+b6jqJb2zYJ/KZG+P6YYqqQB3y34gQBzgj?=
 =?us-ascii?Q?smEJa51xbwSjAp1A/YGUUqtXxAw+mZ98IbQE8t0AHS7sdBOTVt7sIVPV0XOt?=
 =?us-ascii?Q?i4mLY2sqyQKKvfwWmWwIfK5eyrXEiybejIgtFa++gIThOec4pG73Iryh9mWP?=
 =?us-ascii?Q?owzrFLOY0WapsKZGr9VAi35rzz3U6hZQHjzojHldwCqANPtP7tJtIdJgTM77?=
 =?us-ascii?Q?C7vQ4KTkSwJdZOO3CFf9lRcX4rhjpJdjjt4uZxdZh2S7QO9gf/DdBHTXGocP?=
 =?us-ascii?Q?91TghKVQ3DvqiP9B81ueerQRIFFw/RdJdM4FYxXjUs+6F1PXMIMIPGQPipXE?=
 =?us-ascii?Q?hRuGQdkwLoF/EcDCTeJoG7xG/o8OOeSxrF7gU/wTAA6f/ddKVwh7CUEgbwnj?=
 =?us-ascii?Q?mSdE27ftExc4xcCA36ktjsITQucQ4dAcK5ZjK8WubKmzcxbAGOgREMXwZd32?=
 =?us-ascii?Q?JApvFySXT1SAM2b9wQTCPe2HiDaFj1kT7s5ghGqTLr9bMv9kYjda96dUO4Pp?=
 =?us-ascii?Q?ktbqn7X0coT0lwx9YqAgH/1v5kRjl1cLyObv5uE5ZDoSxEwnwnL+cQw8hkqr?=
 =?us-ascii?Q?LlKS/udwH4rsSjZkeSXikY4CIJSSK0yAET1kjE/PPml19Q3+3pFbhD9HSehK?=
 =?us-ascii?Q?Rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IhkeTzRdAmzXVEihhPcDh6DdYqn7Zxw54SjlklB9QYG05G4ziP6YI80pGMK2?=
 =?us-ascii?Q?kdm4LKQGJUq65I1LSSRTLZjG43hJzMOz0cdbltHbZbYPjy+5+ILJBUlUQn8B?=
 =?us-ascii?Q?qImNeIe/lySGKbufmnm0ptdeFejBCYWBPIxkiNWwyG1rDoAp7CgmVLLwrUB2?=
 =?us-ascii?Q?xbPKeoo0KH90V6DnXV7t/9QJL0knJnoKeVOLp/7u+OUzkw9rSZORT+ULbuto?=
 =?us-ascii?Q?JVXKF/YEBqyoKcz+C+sC6CwIMyrxR+KDhziSlVUitX90TNZvs80G7G/WqK6u?=
 =?us-ascii?Q?CWPNV5lrUPeVC0QGqGeJvHuo5s6xUcVYEMF0VDQMy2HuDM/PnDkLuTzWQFPZ?=
 =?us-ascii?Q?wdcCSWsTfNld2bUb7BJjvLV6le/fs6DPpHXzRb3mQcYDtte0MmEBwDuumLwi?=
 =?us-ascii?Q?VEplyIAin6wmOw+rnkHHG8PvP1PPQvsw7LPEV//0VyeWOYSy+UTTN7PBwuZE?=
 =?us-ascii?Q?otfFkKG1/45kMjWViCuekGQYOtUAZZ1rviWLP4PnyXuncONXPZ6xynqfLAZP?=
 =?us-ascii?Q?gqlz0HHV19DRONwHfSoOugQDBIxvhSR8vXhVePljmrPrX7/Ga1/22ItAlIuI?=
 =?us-ascii?Q?x0cB0EMi0I0UGmno12c8JAhn5Jm8Od8Fy/VGrwj5yFmf6Dra41OKuB1a8cpQ?=
 =?us-ascii?Q?FMEGA8SEwcMBpOa22/LdojgKBpSYE9abEmBwSsikJdd0iduS4GwVDd5/2JNa?=
 =?us-ascii?Q?YFHzp1gNtRdfuMIZcwD2qQoHWNpEwxsDt/+GhvQ4jfi3sjuNDKYDwZPBgQ3E?=
 =?us-ascii?Q?GSmZqq5rHFbUA0oO2eKIaQxUD5LsTMyx62TtDJneT1yo4a6KT2pYtNoivIU4?=
 =?us-ascii?Q?20MyVdPZAM5cG6QyGLFS1vcT0cfLIO5YZtS7mIskSaV6ViSq7gVHGzYapWm3?=
 =?us-ascii?Q?Ad0G/jQlZNjjWzvqgAaNO4WPvV8DmItCcZZ6EcRX8m/yBiAM49G2wLxJdbLt?=
 =?us-ascii?Q?J6R3H9yYS9juTHcq2z1niEhMw7h03HH4t97bFFVhVYlNo5FcIWzCxwQt4xpQ?=
 =?us-ascii?Q?1hGZGV/86xg8UA/cwM39w36Tal0eK4m7TE6UjW0EaL3tIEIxqZDz2565+zm3?=
 =?us-ascii?Q?aTdzKqcA47xbVau4CdzePswHAHF80sMC5jt1fqSe3iJUV64hROVNjnyLfxvR?=
 =?us-ascii?Q?z0Rtce5sd5kW8fkjIaAQy463B0PmBK0nVGxGEJVMolOMiDRS+kNgHxsekFFI?=
 =?us-ascii?Q?goVT18dxG+wesbXDiIB9Pi2t8Ec9LPFJPnMaoyyUX/Y5qSgAJ2IIPHbZU7kT?=
 =?us-ascii?Q?p0eaJPpHzzZPSnj34e2oP0AnnXDptKNTioV7hf8whfe6/cjBkhTePjR21fmN?=
 =?us-ascii?Q?xmD9rIwZW1wFX5yMM5p47pwbgcT1oAyANGt+JaqykHQ9nxljV08hgX2N/hPL?=
 =?us-ascii?Q?Orpm84FYNbvFxlnDUWhnZK91YPPmwPdJAEb8Q1GeoAAFQ0isbE5J26M8B3Y0?=
 =?us-ascii?Q?ZV5aP5+kMQJm3Z4rmkHx/wy9NhwrbZJPwJYxPrCz8VchtGARSX1uKH76jWKz?=
 =?us-ascii?Q?xwUkkS/+N1bMYFxk/8Nfod+t0ONduAg/JJzg8r2LLuXyFqPhLyWdIRzP/A+L?=
 =?us-ascii?Q?Aue8fK8QtbagB2P1BiHWcDCvs/498jSOc3+uLqJxpnW7/ZaXa6n1Qxt/w7xu?=
 =?us-ascii?Q?ifhddiGmUghlokUa157cIoxFmOpyV2qC8UgGjWgqlCUu2EU7PCk9ChblOGID?=
 =?us-ascii?Q?Ybn3IlhppX8TkTMzalhdXJF0dy9t+u0xpLHJpPtlkoLUFmkyBx1NvT7OCDSg?=
 =?us-ascii?Q?owxpmM2Ba4NaNDCS7hiwz7H9uJzTH5O8yZnXs9f2nRCeAJ6Hs/Xh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b75a10-ae11-4ba3-5936-08de7400db12
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:00:15.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlFWKliZY8G15mibUhgRlztLX4Af75r5hnZs9E0phUqCntBBNKhLt7ilwgOZFhAqhRvuRiogYFM7ElnDGXW65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rasmusvillemoes.dk,linux-foundation.org,lists.osuosl.org,vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: B5C7418E3AD
X-Rspamd-Action: no action

bitmap_empty() is more verbose and efficient, as it stops traversing
{r,t}xq_ena as soon as the 1st set bit found.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c8bc952f05cd..772f6b07340d 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -1210,8 +1210,8 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
  */
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf)
 {
-	return (!bitmap_weight(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
-		!bitmap_weight(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF));
+	return bitmap_empty(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
+		bitmap_empty(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
 }
 
 /**
-- 
2.43.0


