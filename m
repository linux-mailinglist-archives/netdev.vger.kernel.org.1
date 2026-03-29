Return-Path: <netdev+bounces-272847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOSiFrOVyGm3ngUAu9opvQ
	(envelope-from <netdev+bounces-272847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:00:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF6435080D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 05:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 224FA3025F62
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF19F271A9A;
	Sun, 29 Mar 2026 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ri6zEgks"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587926B973;
	Sun, 29 Mar 2026 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774753153; cv=fail; b=tvUPE5jDLA2trP0zivnme7s4vRCnnfFazgUEG3L4OJ3E7bQDyFchjiOyDFiupl3u8ha+RJrHf6QxkKNgDCLHXSGz0+noVk9pJEq+mJcdDh6HJLhUDCRuF+rsav69LBtjIRUbZIM02kLzG39VwUnvVwxlI8dmgqR3dGIw5JVaNAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774753153; c=relaxed/simple;
	bh=5jCkHkfSjmkcxCScj0qC0OeI0UhHSFU2V935Ptpi2hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiecU/ofS6EuGx6zzqeiGU11BUEJ8yBhAi3Auwd8cd7NAZltdN3uuvw+eri1wKJGVHQeb5+Nfo4RrLvWYYNcROf4M3bpltQ7yKRIFfL6HF9dndnWkiKOUj8JQKNz4kYVFy7Q3FF+ieKL5oX0piApVO0DSbNiNxWsqy9xgpVcbgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ri6zEgks; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E06khBxXDzcYpSIGEUaiqWhZX+edq+EGzexaal1SL0je5m7nSjHwoIMRZMemfht8rwDBezO0+f36PJRCttVOJm+RnymcNsI4bud/+Urye/ogl6p60T5OoU/AvGkBIkhEiY2s3QYKzhHnediX6RzgbadxzCwsnYEFT0MgnBdQ190UCUhcHSM66O3hvf0kIuvh3QmHd85cqRFh2nTIn5NJRfBY0vcRkJ8lKD5KuWEJ3AnlSTYHxgKSw/4bzv3ICV2BGDAd1/WWBjA2xqdMr6RUEksdbzxPNIGJiS+naqeZ6bSDYhh+IChjoCebXZcY1KXsFb3StpdP0hpo+j+E/LVs4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWhkJlaLx+gijcnZVU3Eudd72WmH6c0h+KLOfObRjtE=;
 b=KM9AlOO/BCuGWeiPm81w7NqnsXRUgDDGzuXRsnTXt7fLC/PdbyKZbVnTZ7Q/JmE8Seltm7ibB2euUAO14BZstLz0bVDG9zeqyOvqDJFtn96vTkY/Ka1xFKjVoTUMd3PPO00OJPC12BSULP9o9CbAZTlllLH2AUGUjyK3FG1elYZGxZR+h/dyORlBT7UaQHptUxZMFsRw/t4OiVaXifUutGsFb9vN5Q/7E3AMGVwqReQ/woAKD/ww3GgzMpLh8OhHbshDlxEAGQXIQcByk/AYVGHotTctFWYB68wAkISS8JOUZ6tGzA8+J9tHgVzPQbd0axElKnwYHaqalKQpL1tx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWhkJlaLx+gijcnZVU3Eudd72WmH6c0h+KLOfObRjtE=;
 b=ri6zEgksC0k9Oeiu7ANbg7aKLjKhM6Y8NjauL2oneYS6H0OkUfQdvGkd/QMwvge0l3eqkKxOULlVWwcnWX6L/UIJqeZh6xxcYeKS7FddnemG0VFFJNiuSQ5G/2fPEBE9fSKq/hlFAlqKWzUa5HZm+iaQCHMFDvyD7VDgAoAw83X8KOrgJWifSVgctQ3kjJvDJS8PKSHN2Icwy2+DyOfg4tpghQs2WMOzXSFJu0qjdjzZM5lsiTi15JxCF69a7Qdw+Fa0INTyaBLyjMkVS1PJF/zxIbc288y723JQFOk4MQXbvBVhySBDBxmTOmBPhDDmkGl/h6mpZgsAjqlDx5zRnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.14; Sun, 29 Mar 2026 02:59:05 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Sun, 29 Mar 2026
 02:59:05 +0000
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
Subject: [PATCH net-next v2 3/3] selftests: net: add bridge STP mode selection test
Date: Sat, 28 Mar 2026 19:58:58 -0700
Message-ID: <20260329025858.330620-4-aroulin@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329025858.330620-1-aroulin@nvidia.com>
References: <20260329025858.330620-1-aroulin@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 855946a0-f7af-478a-f13f-08de8d3f2370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|18092099006|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kbTTAGlN4+15OAqe7wWwZGIQAA/+7rn7PfaDbY8xFyABbGOp9XKd1sO0mDrp8f1i03ANqMbZX3VphtZMk+9KOAisXaJhsiJmTPNHQ9b31Sw9lJr0F+mFU0O9dXQeM/f7sowOYAc1lfD0dzFMSB8MKzbXz2BNSvhkLnFYLbINlNd3k4EIV7fBf8MpSD9NM2220uvnwpKG8KPxkVukMHLRfaA0uh++42Xbrid07YdJtLRzbFELspM138KycafrhisYK874PGgzKGQpZRS2krPClR7UsD3QRFnupDuDCn6HC4V/bUprduedZlujTuo6oLA2XndMdN5zTADWOakWa6gYAVcLyy0bq2iX9GDlN6umfyWtcdtU8m6rRDL698JEthOgR5blZUJQ7ifbmrfuSw/uEvYwZfPEI3czIzySpm5nMp+Gmo458CXX/E5/Hn0dJD93Cx0kT832yI5ji4nISYDafFt57qhraTNLvBCNYfmeddqxiw80ZZJaJv54Fh0Jx9x22OpwDntx1PqPRVrKuWKjnXPrrtlouLEwTB0Rm2GQalCbc5sUVAH1ADBIhjz9zAlrq8uMYHZAYBaqZfRnjoLbarG0AqJkqPJAxP8BEKX8S/K7E+I36CsYFM3TwCaa0IO0Hok+EYFk4Qz9VJ5kCV3GIx7fn5Zl4GIFCaz2q8pYMD5MNllRg3ozDeEuEcVl40HmIJs6liJsf+B0dPcI02sGGqOR04RWJHnymhaMx3SgUDI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(18092099006)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BIpkVkz53UuJ/OZCkGYiO/AbtQfR1B4YDc18F5R3x5PTkgHKSQQna5bDcfhl?=
 =?us-ascii?Q?dtRney3XR7CADP46D2et3x2/PllJ++Ju56UooP1yhafWgKjt1lxoUDQ8yjRt?=
 =?us-ascii?Q?VYSmlinI1OgXKwdnNedQSD2KzWSf7NBtkXRAri2alEJjaMXCNE+IYO2TPpcb?=
 =?us-ascii?Q?KYJsHKNfGVpHM5z9DZ2E1k2BoXCzK//Jb3vzLZIXFNjftXee4vRUUa+alSr4?=
 =?us-ascii?Q?Z0it79QCPOcutoNMR2hbCr1oKIkP8CwO/2DBuROMBiJrX25Ny8YMQD1FNhuZ?=
 =?us-ascii?Q?YM2xBE+GEVF3h4Zs1IyRK40jbjq6ict5sgIkq83ys5+/m1t93s1Zi1LmmspX?=
 =?us-ascii?Q?8Tqwfs1D0NGuc2Zj/ECSAYbjo39Jb0mGQZo3OcxdOl3AX6fhNqQdz/6gG9BN?=
 =?us-ascii?Q?xy0/cLkbcg9ksQ+heuHyMrYGHo6qryZ584csiKJJPHkFgYy2Zuc9jBC82a4P?=
 =?us-ascii?Q?Qad0YVb9L7DkOnLprqv/9AD84TqsmpDE55Vev53av1agZvelaqFPSJ/p7+xU?=
 =?us-ascii?Q?8AhH4yE/3v0g8b+Wn4sq/iBbnAeItOvS0TMO+bMHnYezMKSd387FaEvUJ3kT?=
 =?us-ascii?Q?q19QcRgqg6RTc7puI1ElRl+Tsb2mEn4DB05tDwzVGabIZFzKBW95F9SDgK2b?=
 =?us-ascii?Q?GkWpemlrPcLu2SqyK6drGJ0lxlS29q8bdOHpAwIBaaxaitm7sZlQ/pppiUEH?=
 =?us-ascii?Q?zn9oJrNtKDkGdPKz9ghGg8CB7qLOhGsGpC2sHRwaJzImRWYKcLyVcoZq+NaX?=
 =?us-ascii?Q?GQxbBb9h9o7g4iOZFwtvsWK673Vx7eJ7IuYXvOr5jynTriimWcCBSBsiTE3R?=
 =?us-ascii?Q?bR2+4oKs4wBUf7iMi8mXgekc/3XeLGjJyFWWYJ0yUODb5sPADev2VGI/dRQl?=
 =?us-ascii?Q?6Q+K11IBuPtITJw99zN908DrhlHWNXKKQUPmYtx0v6T4mmpW0uCjKg4yKWUv?=
 =?us-ascii?Q?i0IduUBR31smH6ZL8Q2Xt9YkT2O2CBfWASslivSi/+OPtvdUpd2bPbX+gPZY?=
 =?us-ascii?Q?XemV8XwxF6B4qGjEh3yOgY5e2hvN9zFa6bNrKJb0VS14CFJvlmmDkWXJGVqq?=
 =?us-ascii?Q?0GTLtuWrjd42c5cevZ9fnfR8V1ThVSgXQbHNNBje2FaFRAQzEPT6ng700iGb?=
 =?us-ascii?Q?XFIFPi6MJ4E5wx+xkGSuubIIKF0N77Hb8WIPx5f1n8Ho1J0LhHzm4yxkSKGg?=
 =?us-ascii?Q?W1fWXqwduvMNbgo4pVZAU2txX3txIYmRthfcvo1qxLBAkahGtginwj8jbNL0?=
 =?us-ascii?Q?WDkuUYPgrLJ/ib+tXKK3MBt6tLq13JE9he1kYL3rokki4bp8PWdtIvSeXyKr?=
 =?us-ascii?Q?oXydp0LAbqsMrv9JdmpZXyZe7ChN/YJ8Bto3ncnozmg8yWnh8Nxu6O0qUXSk?=
 =?us-ascii?Q?jAq6M0lIYs9IyEpBIE6OUF6RJjdSjNmMP843nk3Emr/5u0LSw7d/4lDJcE5m?=
 =?us-ascii?Q?/sBhlru3XVBrYMbcQeFgkclxuyfR6Lx0ebkvMg0MuuDAULV4xRz8n6xtQYQa?=
 =?us-ascii?Q?+F0BZO1YKhoXD9D3wkWbs4Y85zm16DGSQSLLmjDU0eScEiaa9D7JG+rie0WO?=
 =?us-ascii?Q?YaGjpD+IWwmDlqzeor3jIaBxyPl2fj/NzFvrBxssCmq0Zd3zcy22l882/FPK?=
 =?us-ascii?Q?TXM91aAeNvQZfPWV0JDe2PV5P+Oyy2XmQTe6DBot9HhPR6yilZbHk76GxlIh?=
 =?us-ascii?Q?Z0Xgfa73dHWCJKtBn9f5RvikobaXBX1N3a2qWT+zBhLafabZbRYje5V5KTIC?=
 =?us-ascii?Q?eFvd2ni2jg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855946a0-f7af-478a-f13f-08de8d3f2370
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 02:59:05.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0RSsq9/AN1p8avZ5axJn06BOX50vBbPGwP6tUPPy/NfP2nNldWnXxZrrjo4e9Ghh1CdKKkWn873bcg4POaMQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
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
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272847-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: DFF6435080D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest for the IFLA_BR_STP_MODE bridge attribute that verifies:

1. stp_mode defaults to auto on new bridges
2. stp_mode can be toggled between user, kernel, and auto
3. Changing stp_mode while STP is active is rejected with -EBUSY
4. Re-setting the same stp_mode while STP is active succeeds
5. stp_mode user in a network namespace yields userspace STP (stp_state=2)
6. stp_mode kernel forces kernel STP (stp_state=1)
7. stp_mode auto in a netns preserves traditional fallback to kernel STP
8. stp_mode and stp_state can be set atomically in a single message
9. stp_mode persists across STP disable/enable cycles

Test 5 is the key use case: it demonstrates that userspace STP can now
be enabled in non-init network namespaces by setting stp_mode to user
before enabling STP.

Test 8 verifies the atomic usage pattern where both attributes are set
in a single netlink message, which is supported because br_changelink()
processes IFLA_BR_STP_MODE before IFLA_BR_STP_STATE.

The test gracefully skips if the installed iproute2 does not support
the stp_mode attribute.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
---

Notes:
    v2:
      * Fix shellcheck CI: add SC2329 suppression.
      * Add idempotent stp_mode test.

 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/bridge_stp_mode.sh  | 281 ++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100755 tools/testing/selftests/net/bridge_stp_mode.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6bced3ed798b0..053c7b83c76dd 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS := \
 	big_tcp.sh \
 	bind_bhash.sh \
 	bpf_offload.py \
+	bridge_stp_mode.sh \
 	bridge_vlan_dump.sh \
 	broadcast_ether_dst.sh \
 	broadcast_pmtu.sh \
diff --git a/tools/testing/selftests/net/bridge_stp_mode.sh b/tools/testing/selftests/net/bridge_stp_mode.sh
new file mode 100755
index 0000000000000..5737a10f002f0
--- /dev/null
+++ b/tools/testing/selftests/net/bridge_stp_mode.sh
@@ -0,0 +1,281 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# shellcheck disable=SC2034,SC2154,SC2317,SC2329
+#
+# Test for bridge STP mode selection (IFLA_BR_STP_MODE).
+#
+# Verifies that:
+# - stp_mode defaults to auto on new bridges
+# - stp_mode can be toggled between user, kernel, and auto
+# - stp_mode change is rejected while STP is active (-EBUSY)
+# - stp_mode user in a netns yields userspace STP (stp_state=2)
+# - stp_mode kernel forces kernel STP (stp_state=1)
+# - stp_mode auto preserves traditional fallback to kernel STP
+# - stp_mode and stp_state can be set atomically in one message
+# - stp_mode persists across STP disable/enable cycles
+
+source lib.sh
+
+require_command jq
+
+ALL_TESTS="
+	test_default_auto
+	test_set_modes
+	test_reject_change_while_stp_active
+	test_idempotent_mode_while_stp_active
+	test_user_mode_in_netns
+	test_kernel_mode
+	test_auto_mode
+	test_atomic_mode_and_state
+	test_mode_persistence
+"
+
+bridge_info_get()
+{
+	ip -n "$NS1" -d -j link show "$1" | \
+		jq -r ".[0].linkinfo.info_data.$2"
+}
+
+check_stp_mode()
+{
+	local br=$1; shift
+	local expected=$1; shift
+	local msg=$1; shift
+	local val
+
+	val=$(bridge_info_get "$br" stp_mode)
+	[ "$val" = "$expected" ]
+	check_err $? "$msg: expected $expected, got $val"
+}
+
+check_stp_state()
+{
+	local br=$1; shift
+	local expected=$1; shift
+	local msg=$1; shift
+	local val
+
+	val=$(bridge_info_get "$br" stp_state)
+	[ "$val" = "$expected" ]
+	check_err $? "$msg: expected $expected, got $val"
+}
+
+# Create a bridge in NS1, bring it up, and defer its deletion.
+bridge_create()
+{
+	ip -n "$NS1" link add "$1" type bridge
+	ip -n "$NS1" link set "$1" up
+	defer ip -n "$NS1" link del "$1"
+}
+
+setup_prepare()
+{
+	setup_ns NS1
+}
+
+cleanup()
+{
+	defer_scopes_cleanup
+	cleanup_all_ns
+}
+
+# Check that stp_mode defaults to auto when creating a bridge.
+test_default_auto()
+{
+	RET=0
+
+	ip -n "$NS1" link add br-test type bridge
+	defer ip -n "$NS1" link del br-test
+
+	check_stp_mode br-test auto "stp_mode default"
+
+	log_test "stp_mode defaults to auto"
+}
+
+# Test setting stp_mode to user, kernel, and back to auto.
+test_set_modes()
+{
+	RET=0
+
+	ip -n "$NS1" link add br-test type bridge
+	defer ip -n "$NS1" link del br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user
+	check_err $? "Failed to set stp_mode to user"
+	check_stp_mode br-test user "after set user"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode kernel
+	check_err $? "Failed to set stp_mode to kernel"
+	check_stp_mode br-test kernel "after set kernel"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode auto
+	check_err $? "Failed to set stp_mode to auto"
+	check_stp_mode br-test auto "after set auto"
+
+	log_test "stp_mode set user/kernel/auto"
+}
+
+# Verify that stp_mode cannot be changed while STP is active.
+test_reject_change_while_stp_active()
+{
+	RET=0
+
+	bridge_create br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode kernel
+	check_err $? "Failed to set stp_mode to kernel"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP"
+
+	# Changing stp_mode while STP is active should fail.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode auto 2>/dev/null
+	check_fail $? "Changing stp_mode should fail while STP is active"
+
+	check_stp_mode br-test kernel "mode unchanged after rejected change"
+
+	# Disable STP, then change should succeed.
+	ip -n "$NS1" link set dev br-test type bridge stp_state 0
+	check_err $? "Failed to disable STP"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode auto
+	check_err $? "Changing stp_mode should succeed after STP is disabled"
+
+	log_test "reject stp_mode change while STP is active"
+}
+
+# Verify that re-setting the same stp_mode while STP is active succeeds.
+test_idempotent_mode_while_stp_active()
+{
+	RET=0
+
+	bridge_create br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user stp_state 1
+	check_err $? "Failed to enable STP with user mode"
+
+	# Re-setting the same mode while STP is active should succeed.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user
+	check_err $? "Idempotent stp_mode set should succeed while STP is active"
+
+	check_stp_state br-test 2 "stp_state after idempotent set"
+
+	log_test "idempotent stp_mode set while STP is active"
+}
+
+# Test that stp_mode user in a non-init netns yields userspace STP
+# (stp_state == 2). This is the key use case: userspace STP without
+# needing /sbin/bridge-stp or being in init_net.
+test_user_mode_in_netns()
+{
+	RET=0
+
+	bridge_create br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user
+	check_err $? "Failed to set stp_mode to user"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP"
+
+	check_stp_state br-test 2 "stp_state with user mode"
+
+	log_test "stp_mode user in netns yields userspace STP"
+}
+
+# Test that stp_mode kernel forces kernel STP (stp_state == 1)
+# regardless of whether /sbin/bridge-stp exists.
+test_kernel_mode()
+{
+	RET=0
+
+	bridge_create br-test
+
+	ip -n "$NS1" link set dev br-test type bridge stp_mode kernel
+	check_err $? "Failed to set stp_mode to kernel"
+
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP"
+
+	check_stp_state br-test 1 "stp_state with kernel mode"
+
+	log_test "stp_mode kernel forces kernel STP"
+}
+
+# Test that stp_mode auto preserves traditional behavior: in a netns
+# (non-init_net), bridge-stp is not called and STP falls back to
+# kernel mode (stp_state == 1).
+test_auto_mode()
+{
+	RET=0
+
+	bridge_create br-test
+
+	# Auto mode is the default; enable STP in a netns.
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP"
+
+	# In a netns with auto mode, bridge-stp is skipped (init_net only),
+	# so STP should fall back to kernel mode (stp_state == 1).
+	check_stp_state br-test 1 "stp_state with auto mode in netns"
+
+	log_test "stp_mode auto preserves traditional behavior"
+}
+
+# Test that stp_mode and stp_state can be set in a single netlink
+# message. This is the intended atomic usage pattern.
+test_atomic_mode_and_state()
+{
+	RET=0
+
+	bridge_create br-test
+
+	# Set both stp_mode and stp_state in one command.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user stp_state 1
+	check_err $? "Failed to set stp_mode user and stp_state 1 atomically"
+
+	check_stp_state br-test 2 "stp_state after atomic set"
+
+	log_test "atomic stp_mode user + stp_state 1 in single message"
+}
+
+# Test that stp_mode persists across STP disable/enable cycles.
+test_mode_persistence()
+{
+	RET=0
+
+	bridge_create br-test
+
+	# Set user mode and enable STP.
+	ip -n "$NS1" link set dev br-test type bridge stp_mode user
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to enable STP with user mode"
+
+	# Disable STP.
+	ip -n "$NS1" link set dev br-test type bridge stp_state 0
+	check_err $? "Failed to disable STP"
+
+	# Verify mode is still user.
+	check_stp_mode br-test user "stp_mode after STP disable"
+
+	# Re-enable STP -- should use user mode again.
+	ip -n "$NS1" link set dev br-test type bridge stp_state 1
+	check_err $? "Failed to re-enable STP"
+
+	check_stp_state br-test 2 "stp_state after re-enable"
+
+	log_test "stp_mode persists across STP disable/enable cycles"
+}
+
+# Check iproute2 support before setting up resources.
+if ! ip link add type bridge help 2>&1 | grep -q "stp_mode"; then
+	echo "SKIP: iproute2 too old, missing stp_mode support"
+	exit "$ksft_skip"
+fi
+
+trap cleanup EXIT
+
+setup_prepare
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.43.0


