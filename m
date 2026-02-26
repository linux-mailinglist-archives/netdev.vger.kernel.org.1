Return-Path: <netdev+bounces-261220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EqfDOr+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:06:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFAA1A241B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E20B530D4BD3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E396D392C28;
	Thu, 26 Feb 2026 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ezh+JnDq"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52B392809;
	Thu, 26 Feb 2026 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092920; cv=fail; b=ff1qGehs71ZYjUUTB/q1tDHtHoig9oJXhW5vQCMDPRsn+rYB9UglYtcOSMoeOgs574W2EFM2rTj2WGcRcaD0WkzGa3hXHEx/B6UccI5PJ1QLtCedC07J1y7cySW0UqZMSc/76qdBaQbicNJq3eTxjvbgYbJeG/bLqA4KhWnhB5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092920; c=relaxed/simple;
	bh=8yjI7JlIBnrQbk/DMHLxlOabsd0eh9zCD/b8bOJQb+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iu5IG3i53HxFCYT0B7NJ4dj4FzxmPiYUrJ1l9ISGiWBi0QQK5xXEed8rsjy8lcvYVYFRDKhj4s3nebwQC95cxazh67FjfKDoK+u5BTTUAwNCP/z5zgAByAGUL52m8/WCBoZWT+IuD2Qizjoy8J4O6/thxKlFqtdAQL9ReQ5v+z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ezh+JnDq; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xszs64kSNzJE57nFpcQrYBwEqtY2jI5OOyFVZZCqiiNwN0pGE/mIFXCG86wA1kUBlbUTPgopbXrMpr4DuVV4FNIWsZcpZ9zs4Fc4Fdal2uLk3fRncp3dkI65O/p61OOwyvT3iQd04A68vVuls2bY4EPBiktXwCvUDXzwfMJ1CNlujW8yHBwrs4Z1ctavJ6vPIpCqgUs6bxvpJCbKmIO2PyUHOdGsuDSaTDoSVuTvKp8KqhkfGo7BqXKFmF4OaXHT/47V6W0hZBXLuAyFOlIpXXeirUAdlZy5ibT2aWDlvHF69cYk2uJu+2ycxMGS/RGv74IXYJVl9cebG7naTo67+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXSq0aK9SQw1ArXFGoLZtoKEgjo4Tp5hsCznc2J0ras=;
 b=ykE1aidEKgg7Qqz5WRQENLqJwCBgC6+2WDFTsnSvfx+OgajhILY0ENqrrJJIqHlEM5B5CpuE4XEaR6ThDVP3AgnVPuS1fb5dIlNxacbqZ0rl9hB6ikQeeR0VyciOMD+R6stvkFDZWySMcOEINNjxmVJm1VOc5id7bpnxZtK0fgKYCc/u6cgy0RttbJoygwX+b0Jox1Fy9VPwSU5bCujdfHU7EottGODBkBnLxz+eWuUQXJT9ZObrzU08qVJKTymE89vZRAb6q9HTzeRiKSnSHMqajZwVp/6/aXH8GmXezvTiWu9rx1sdGOafMXpD6Omom5Aig8LFokJTe3O48clELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXSq0aK9SQw1ArXFGoLZtoKEgjo4Tp5hsCznc2J0ras=;
 b=Ezh+JnDq99PPsoj6hHcygdqjY3n67DsWa7HbOw51PeoMIENyO3oMnaLKMJwQlssYflUan8gER9j+kHAqL9yRm7buYy+5ccBwmkkO/aA/Xzd4JwSTs2RAp4uiMaxJ+/6UUl/x0WmGKrkS0wIQUv9uolLugcUUxEVRv2Yq7Aqss6tDP4IP6ePgSB2yjhFYmjGs6EczsUapuiTxpmmNIsYrKbvCngVRiXohc51gwVFg8VsioyRDqfpp/GVvUddEP6cqw1ZGAX/bzIVZaSCu85evT47lBXw45DWWnBMoxNCrByTuoPK1OC1TaeG8f+lONNJnKr3f2w/eBFVflXaMc8SPzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 08:01:56 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:01:56 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@gmail.com,
	petrm@nvidia.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH bpf-next 8/9] bpf: fib_lookup: Allow output lookups for IPv6 link-local addresses
Date: Thu, 26 Feb 2026 10:00:02 +0200
Message-ID: <20260226080003.524935-9-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226080003.524935-1-idosch@nvidia.com>
References: <20260226080003.524935-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 766d5c58-b239-41bf-a663-08de750d4f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	TY41ZSCq9va4/S+kPhR57qKY04MQ3YlCpU4orAOCT1wFW3tvOjT4XVon6TSLM01O2gNjadkODEwnac0AFx79TKekC7wed6ahB7VkGGjC6OnoyE/KkP4vGj2ohu0TI6gt9beoBdj8OX3WCJ0yg1xVFZ8+bv3bUmM6netZjpb+xtlRInWlic6HuiBPStjjjCX8s58w00XN73/NQJbyIpYVNhu06fNfmMuWulPVyqMwNCzH48GnrETr9XQl70SW/qxiBoDzGJkNBSFA44zOIgm3CO/EyyIs2PfyMtBqH3gAaImuP8yqmLyxC7+C1hh5SuvDpi2MytqdWUp1eRh3mNVajIr3OZowXI5TMSZ8fGKgAr/VSOnKlCo20v1WMuhJ9+nJFC3D+mk/q7bMQ5GBYMMkeMU43x7AD1/GjX72A/dccouRD3u1ceSlUAByAjW9coySzIZwAojEmMTDqNRGTV6WTfFAQ+YG8EM71DzJ8Z5WGO3LDB5OTvDCAHJ/qRQllEYpd/MOM1fTUs9JrqSTctYf1ox1eFM8JAjRUJGu/3m8cWhLNjf5T4SjR9RIY7AU2rCM1P4Mw9v5bRgg0j11jlQnW0Mz7xzvQRnDZpsuoqbftXrFUgLEYAdIeJydixerkj9AMd/7q4aKLEh+o+GxOFunrHe3SK5bA82zEcuTWyv9wRjKr1dfC/L5ZjhaXHHzk42nuP15bWaMX/YjqOzHfIROY+tmBJqG1jVLdlC/mSz2CNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XkMQ8v2Phy7d/kW/plgbNEGKgTnq3mZuRA/Xu9byL2rAcdasLcjnOiNJhyAo?=
 =?us-ascii?Q?X4CQ4b/xk6oP4/qXm3pk0OIq419bjIrZLjFj82OCPUVobSntLjjFn1UcwPxR?=
 =?us-ascii?Q?YtqT29JiZcPNaBsB3L3qYzG2sbIehnHwl/3YPbZj6vKgtjsCXT6npUQIVhwQ?=
 =?us-ascii?Q?lc4g8yEQtcYSLJybp89XUq/gysmGAmgnSNsAvPBvSxIe5z3LiWWEZ95Vr08J?=
 =?us-ascii?Q?pU1YnrP5ZEab0d/DpT8Zy/4kp0JX6nfv+mC2zo1crgIX2WEfus7HgkPDf224?=
 =?us-ascii?Q?omvOR1mVeHJoQL80J61GG84JJNUxRBwnN/Wdy6W9QXBKHDOGVAmggDgox02b?=
 =?us-ascii?Q?rnBgggi5ulq6SyXko+SFF1O8Bg+xMtp5+afiWdjFd7PGEAgNVkmoERkFT6Hi?=
 =?us-ascii?Q?1p/htMTpX5o0tvai0aMiwBWTjxRoFoL0F8ryDUDJfKxPOsf6eC8vlZJDQaYV?=
 =?us-ascii?Q?tPu9zZyUJvo5iin/gGphsRvQpP4Ao+Bh8/Gc3GPkqlTzW0dDV6iRIN7+ncxE?=
 =?us-ascii?Q?P7AiAJWYSIWpfPsR6Me0Xf1XbDnPf2P1vw5+TzF3fwPp2BAExhCXSpgDC5zY?=
 =?us-ascii?Q?Su9zNWr5Tnz3imr6jVUTSfcavXXlLCd5AOZ4pynUvB83kvB83WgRPT5Khxcs?=
 =?us-ascii?Q?wCp6cY6i72WfYztOvtJuYdh9PBUI769b/wWMp7v3CMfyvuCydsLVwocKVPDL?=
 =?us-ascii?Q?Q2741KoJVbL4TI+kB26iG+8HcH6H+ZS29MFV0OPeTArGnHdHiBkYaStPaTGb?=
 =?us-ascii?Q?nyr+N9Og/v8U/wudcrTQPTIN/pe7+1NTR9hlop6B7eyCDXGt/iFBwgg0hGRC?=
 =?us-ascii?Q?q+H5A6YVCZSrXOaty4tzoG9jocIPiDzUfuFzCxuH24es+oq31vW9J039r2yK?=
 =?us-ascii?Q?jxlyiTrGFO47BoXmdaIua/rui7cjhVFhH1oJ5IG/9QDMnQ17ymlyIoiOLCyX?=
 =?us-ascii?Q?nAEObvK8JNBnMmRsin48LjBJhMzRQBjX58QnZ8Rnp06wRPSN6dpAuXwir0L5?=
 =?us-ascii?Q?WxEzf3gL4mtBjTGSuW4YTI3GyNnyb/sFEujw+lz+cMFIplgWL+/GinMefwVq?=
 =?us-ascii?Q?/7ZFpIungya29RDcX1dZhdYQNngE9S+0PCMmAOkezpSYJbJXgHoJd7e+c1fQ?=
 =?us-ascii?Q?u6tBXGReeK1UfvLs/DLtjBsmEbcObTb6CB9NJodhyG5uJ3hxWjsyO+bK7Oep?=
 =?us-ascii?Q?1BImwAp1LnuFy7NiYiLYCzTDq0C+uJWW82YWY/sQvjgwVjOyRzHp1MAf5seo?=
 =?us-ascii?Q?Ah3Uw4pWBBR4LuGoKIiXm3iecKL1GPme5ZIhpUm8FWFlNYtsRC4hm6TFpmtY?=
 =?us-ascii?Q?0q8JsdQyb/28t+mhNN6f6YAPGj/FvVCeD+KLWw7ziNFUzsQFk6bfaLmkyGPW?=
 =?us-ascii?Q?sEg3+QkPVP3XARTIM/SF8t/kn8c29Ehhh5Lhz01Sqn961mTSUfWPiJNFzpc1?=
 =?us-ascii?Q?zsWApw5dPUk5ubpWrWrAg/6aCs/JJV3Qyx9Pjk8N3mMkCpEibgW9J+ngfjBW?=
 =?us-ascii?Q?BIy3a0UnyVcIz1Ljr4MCsGq5WpbsWdQ9HqbXvtXmXE6zLq+U8BX1N7z4jbRa?=
 =?us-ascii?Q?3z4A9ECC5Qtl1VLEwGCgoMGGM16wF5AikQO3N3XcLkDcKLq+61dukXpewPuW?=
 =?us-ascii?Q?T70Q58KCx4YaJuwN2pkyXE7C5blKl7fv3r5aGU1DEILlvuO6gPFEbpXklYQV?=
 =?us-ascii?Q?VZz0ruifWvQeLRX7/9n9zlSSSkN4S4WY8QiG9rVLfbRAyWnVNpqm6xT/xCgW?=
 =?us-ascii?Q?Lwga7lmukA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766d5c58-b239-41bf-a663-08de750d4f79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:01:56.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YA0t3mG9uVg0WnK2MZETz86eEgOogU89svt0oShql7O8SNs1ebepfvgK9SJOtI69lnYFgIRoYb2gs3RbSbCFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,nvidia.com,iogearbox.net,linux.dev,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261220-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 9BFAA1A241B
X-Rspamd-Action: no action

Currently, the bpf_fib_lookup() helper returns an error when IPv6
link-local addresses are used. This is the correct behavior from input
perspective as such packets should not be forwarded, but the helper can
also be used to perform a lookup from output perspective (i.e., with
BPF_FIB_LOOKUP_OUTPUT). In this case, passing IPv6 link-local addresses
should be allowed and one legitimate use case is having the helper
resolve the destination MAC for such packets.

Therefore, relax the limitation and allow IPv6 link-local addresses when
the BPF_FIB_LOOKUP_OUTPUT flag is used.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/filter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e92552b139b1..8f0d2aeffc3d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6241,8 +6241,15 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	u32 mtu = 0;
 
 	/* link local addresses are never forwarded */
-	if (rt6_need_strict(dst) || rt6_need_strict(src))
-		return BPF_FIB_LKUP_RET_NOT_FWDED;
+	if (rt6_need_strict(dst) || rt6_need_strict(src)) {
+		int rej_type = IPV6_ADDR_MULTICAST | IPV6_ADDR_LOOPBACK;
+
+		if (!(flags & BPF_FIB_LOOKUP_OUTPUT))
+			return BPF_FIB_LKUP_RET_NOT_FWDED;
+		if ((ipv6_addr_type(dst) & rej_type) ||
+		    (ipv6_addr_type(src) & rej_type))
+			return BPF_FIB_LKUP_RET_NOT_FWDED;
+	}
 
 	dev = dev_get_by_index_rcu(net, params->ifindex);
 	if (unlikely(!dev))
-- 
2.53.0


