Return-Path: <netdev+bounces-258304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id naTmDYOojGkvsAAAu9opvQ
	(envelope-from <netdev+bounces-258304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:04:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AEF125ED2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 339E63012EB2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A30E32B99C;
	Wed, 11 Feb 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IRqAvBCe"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366D3FEF;
	Wed, 11 Feb 2026 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825855; cv=fail; b=LXfznrjZtKD1aeK0CAMkNehMNwP4hTFc1Oz0nbzoAxxkGv6kDg5LZUNAOv9e9MznXMwf+ephIsexOhqBD1VTzwSQvtHVOWlA95lqloYS/kl7nfKlqQpCY6w8A1c5rRE5Tj6o9hBprCQzk3rQyheggJGZqSrQ4lHngW7tUidOzRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825855; c=relaxed/simple;
	bh=j74+XwvL6XJrXn8hgnKZH3JboVKeH5c+rdaL/NM/G+4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DzUfjwZyasD8xoyAGBXRdB4qDkytBqbt1gE6fpO3GN3feJzQ+SWaACGeuhoydzAFYLXWizlbhBBKZfmMS4kfPpCdb50skCMT/VudSz/5KbTwM5XJvOOc7O8+D3bDWmGbl2RBFQFBTM2nKJhLygHc9+a2CPkQUskJjTqeueug/nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IRqAvBCe; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiZ7SzWzw0SAXf8o7cjRf00Y4iCfHyCPL9wr6YZsMSDd3TWSWeUwWDGkJnG9Y0f8z45H0MjuY4BXZZzm7aL84bYUdSRGYYkom/TWvF/k6snyjeIQM1uKQtocZBEpUkiBnggf1k5OlytAlDRlhaoHjARSIzzvplwAIzkQSflQMOV7ib1GUBE+sAcjPimwkLogA9c7BMig1FLShAvWYJNVm1FImGH8Q+XFFm9dDE7gAhbLqX36i1+Qi7ljc9u1VlNRboSgsEI8P2DchWR2+pBm/UKQHFzBAmDsUC7W5KfHUvItUjhSYFE6uqC//qCzsGVnowCP2aMu493Il6l5jOBoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJZMR/Mykzy19ag+nKLob5QumL2Mdu2mTcLyKhC66NY=;
 b=iJXj4CxIVVkTUlr2ZRzDpyj9ctoRVT7RZU3qGn0HjQlNYx8S9bFqe1/N8jiy/q588d+RZnSsTWB8g7rvFJB8FBD1KFko+7YVM3kXZkbovOBAkddrmlpNKfgqBm5mClivwCZwbsk/e0Ov1vglgPqjVaWowzhd68PByPaRs6LsGt6xn0VJ4OTMAyrmtUgwxkJTZO0uyacMDSU+AU/63HCzytYcUocdctcYjSMP9fxqRyTk0qvT9in6KGbdtyXF1sqGUyEiV5mH8YuyEAxcbQJs8cleppfMEgFY6Mgz4vzJdhxRaXtIMqzsOk4D1Ro43WGfvp3KHQfdQIwFE0dpkzMjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJZMR/Mykzy19ag+nKLob5QumL2Mdu2mTcLyKhC66NY=;
 b=IRqAvBCeLLUn0BanFAQMavx1jXtxvvPWFluE0GwptCAaHyXqLAVDocIGXqvhuxJVEi0dO1jveulGvWU90ZE5GE9D9WNbArtaAAuGHcLQFQvo29qiYq1nCkY4Xp8VvO0bwqmakHePLiZpb3jwx1/ScNY4B801+vW5r2MznyA+N/y8wErao67mj1fBhI5LqtZJtEUfjR6a8tfDMJgryS8PfHH/OnTWo3Huw5tEoYjM6OlxhLSaCvoZNtd/cnLH22MezfZwDDwNji3nv8ptXTEmmGV169TiKcWq9UcRr8TDVS3xmCVzNDm9nY8RxZO/UqTJlbpExWdI5zLVTxac+szp8g==
Received: from PH8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:2cd::12)
 by IA4PR12MB9786.namprd12.prod.outlook.com (2603:10b6:208:5d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:04:10 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::69) by PH8PR07CA0020.outlook.office365.com
 (2603:10b6:510:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 16:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 16:04:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 08:03:43 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 08:03:38 -0800
References: <20260211022146.190948-1-yuehaibing@huawei.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Yue Haibing <yuehaibing@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] selftests: net: lib: Fix jq parsing error
Date: Wed, 11 Feb 2026 17:01:09 +0100
In-Reply-To: <20260211022146.190948-1-yuehaibing@huawei.com>
Message-ID: <87qzqr5ktl.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|IA4PR12MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a380b05-5cf4-4fc7-43b5-08de698731a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/ZA05NXzrxbWLYwv1KbI+7V1VElf/nMVYV43ZUPxjvdxhTrA4C/t5XE6fQc?=
 =?us-ascii?Q?XJHGBMSj7ikNsaRGjIEhSFDFC8ljP2ysqs/elMNSFvmEK0k3liMS5bDMS933?=
 =?us-ascii?Q?VdFwjeA+h0VHyi++KrC2K3HpNue+Gwb8EsVacckMiLCWhiv1ukKoVQ2zSXGj?=
 =?us-ascii?Q?eP+miXBU6GM8L4PRfU8Vh0h4nRxtG2pQcIf6UOtClbEIChzZhS7PMzwSqgn+?=
 =?us-ascii?Q?BlkuBguuV1K+cih2ixlKzjYssNv5/TNyvSM+aUys4RJzjVYpYds+EZ8PU+Ey?=
 =?us-ascii?Q?czntDE/1BGr4VkUbr71spgCkDBWPESJtYYI2JSU+99tHBfA+x8LlFuAKqmAy?=
 =?us-ascii?Q?zCbHFhPaTHTUCVeVaYG/LS1B3Zc44IXfkDLqEPcni65/ukAmxiuT0y1dQLHh?=
 =?us-ascii?Q?0S0ce/ewTmUyeVKJ/UK3HQ0pGhtxmeDWUiWVH50ofg6CDeVft2Bk2iQMrq/R?=
 =?us-ascii?Q?/WIj7Z8L7BjqsPh1uZSSuQ+uh3VrJfPylmVbpMkNonyAtv8FAcndiMvlNc+L?=
 =?us-ascii?Q?6MsXZtaDE00G30Ykm487zZisZlNIDrYMB76PFD/kBeKcN26zAQP5GlZlGCU4?=
 =?us-ascii?Q?uamNnLM5bqp977UQ4lQ/dahZih7ur1pEwGBKiOk+UOHT6FvP9jdNM9xFmBlt?=
 =?us-ascii?Q?HgKl8uWwJrkZMrFtyx45TrPM9X1bJpg4/xHUidVYVSNuugjZ34aGW3dvaFI3?=
 =?us-ascii?Q?hgJyg4AzYTcAOnbQlu6bV6isonmWNP1hiHQLPae0XnlH5RekdoFFKwgkcSI3?=
 =?us-ascii?Q?SQ7G8hRdsFq4IHLAPfg1DL0CNaf8ELP9mSHaOUyphr1DUV5pRKZDJsCPG8R8?=
 =?us-ascii?Q?VRGyWk9VR0ZdSPecLihrCElIwV37LXppi/zldHOhARNQouGWEbW8i1tTiX08?=
 =?us-ascii?Q?G3Xaxtuy5ulOcEvdhap9tAYZ1xGsprEh5jJxYUbFqfSAGt+J30Ew6E86wDgp?=
 =?us-ascii?Q?eqC/q1q2TWphafeAv/+COv/qA8G1PM6YzAxbpoDecqiAKR0GDu3/pAgxK3JY?=
 =?us-ascii?Q?D1+g4dfVjub5Vf3KLd/brmwgG1lJcK9dihNGHORFPmwxs2D2P+hN6p1xnMMj?=
 =?us-ascii?Q?WTux9H5IRBJFpmNUpoKJ73Pd3FPOhzggOH9f+gGV677AXmAL9jLgl9j+jcjH?=
 =?us-ascii?Q?xeSbnUYq+jovEn9DwivRTMBwEuWhwdh2gh0b7JFDhUNe7SavLobJ4f5Bn1be?=
 =?us-ascii?Q?6HGLtwqUp5yf9epvwwYnpRYSVJKrONcLEEvE09u7fFoaRfyQvAOeob+S0jKv?=
 =?us-ascii?Q?ycHbeW5uqMAT+o+6DucSYAFY48LTeZTK68zASTt18abPipmr5FBPXz/sVEgA?=
 =?us-ascii?Q?nicMbuaSUluuXu9akjmNy3FktKUM5CmvIs5BcKaFUEGSpWTMUMORXGz4Hgk8?=
 =?us-ascii?Q?EbbL/VJ4zIKFcoJCH4G44b0eQGXHrJh6WYlpJli7uRx8x03JD8+cT0it3jKr?=
 =?us-ascii?Q?cmrhGygT4v9QxatY4aHkq3PrggoJupQsj31GMEcLlmXfS76cUgTp9YP4eKTl?=
 =?us-ascii?Q?0d2AbZ71SmvwpJTCVvZ7y7qG1FOX4xatahsE0l1kzcuK1S3DNmWg153SElJs?=
 =?us-ascii?Q?dYM4YcxvpgD5NSQ0UfZQ3eBCQhQmI71XxbMW+yeg6W3RdN/pd8y+zKX9W76e?=
 =?us-ascii?Q?IsBpbiil+tdXzSOhBat6Evclj8VDHYipkO+++bNI0hBxvGWqq8bQsuOp5kXp?=
 =?us-ascii?Q?vBssdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/56bvoSb1m+tkDk+V8qdYKOhwcTLGgyzo+uR11kZXPlkuYtWPxuIWHJNLSUPwk2Qe1RU2gtYHNcRUj4/5HxtZGw3PeNhcyBeOF+Edcp1NzaLHKt8RLzDvlHcLg14JYMOQk6trNealhPOdbGNaBYJsplDvG3Uwj+j1d9HfXEtQtpoRbmnmwTXVv3i5oImTlypwUYgF24ctj3aj39yg1nUWDqiq4obUw9gbC54web+I2I8IFIk9XgnKmM23tWbXBw9SkETjNdcDmZl7mWjTkfG7meMSiQ3t7YntvQKcMDoUUwB5FMQ/MbB8F6LNCdhQiYaFcR1FohnpH2vdML/0qWRwVLEWEebChEiGms9gcIF04iuJ6Hmo+X6o2aqFER63KVHeVvvw+cCi+KR5Udt31J+47jXmzmZfr7C3vEP72vkL9TLyFU2TxcFFPdMbAyuIGL/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:04:10.5819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a380b05-5cf4-4fc7-43b5-08de698731a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9786
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258304-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A8AEF125ED2
X-Rspamd-Action: no action


Yue Haibing <yuehaibing@huawei.com> writes:

> The testcase failed as below:
> $./vlan_bridge_binding.sh
> ...
> + adf_ip_link_set_up d1
> + local name=d1
> + shift
> + ip_link_is_up d1
> + ip_link_has_flag d1 UP
> + local name=d1
> + shift
> + local flag=UP
> + shift
> ++ ip -j link show d1
> ++ jq --arg flag UP 'any(.[].flags.[]; . == $flag)'
> jq: error: syntax error, unexpected '[', expecting FORMAT or QQSTRING_START
>  (Unix shell quoting issues?) at <top-level>, line 1:
> any(.[].flags.[]; . == $flag)
> jq: 1 compile error
>
> Remove the extra dot (.) after flags array to fix this.
>
> Fixes: 4baa1d3a5080 ("selftests: net: lib: Add ip_link_has_flag()")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Interesting, both work for me on 1.7.1. What jq version do you use?

Nevertheless, I believe the fix is correct.

Reviewed-by: Petr Machata <petrm@nvidia.com>

> ---
>  tools/testing/selftests/net/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index 0ec131b339bc..b40694573f4c 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -577,7 +577,7 @@ ip_link_has_flag()
>  	local flag=$1; shift
>  
>  	local state=$(ip -j link show "$name" |
> -		      jq --arg flag "$flag" 'any(.[].flags.[]; . == $flag)')
> +		      jq --arg flag "$flag" 'any(.[].flags[]; . == $flag)')
>  	[[ $state == true ]]
>  }


