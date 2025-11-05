Return-Path: <netdev+bounces-235748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F9AC34868
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D7404EBB1A
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B062D77E2;
	Wed,  5 Nov 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TxEhNlSh"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0182D6E4F
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332260; cv=fail; b=HQzBiVtOT2tfdgdODbqx9JovyQYOH+V0e6MTgZMKU+yfDjRE5mDtduFO/FfQtBIwmv+hx7lAuv2YnADBkHLGGNUIZxwl4ZpiO2Zmp/shhSgBUqiS+9xTjVdma7yyhA4O8m/G5VIyl9/MFySnkaAKP5coZckAk/YNmJW2Yo4fe60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332260; c=relaxed/simple;
	bh=GNcw9/F8mgX8ReLiUw4jedq8wryTaHO52ZtgFwc3jH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P6e7hF04238VEgupVonQwS1iYuaskAFh5PbIo1HCTRdm6NF5cP3wgmA2NFQCLw+/exSeClrTp/26L2LWnAiSqSrskSyC8JbnOLQVhjs7wPuFl1AeFn+Du4LxYIHOsj6eWErDSX2JzKEa5q1SxlO3HjdQDKdKwBr0MqYq8YrG7jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TxEhNlSh; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0sXMOKM1VPegtCXJzkbIe81lHlyMKSA8VzJEIntwtTT2qbvdHoJZ+g+SknlBwek6V5YX+Fvp1/eCG++R2KtfinEpfUKJXSRpMaYCaII+6Rmz/rg2xMO1dl2Dyge/XUTqbLv1PmMXeWXFTA7hr2jHqiYm0SjeWp4v8JMuIqML5a0Z6azA9FD6vPM089cvKF7MqhgstuJx4v6mFUbk5uQG1Ad+jnwiwrGkeod8qmy5/uVJW8H4SZO2tjM+J+TZ/o2py8P5T8fPIGNrbg08LP6VWiB8/d7YWCsfTw403fc83XKMD60Rl26hlo2o/Xma1ATMOiJk+pFgYYpd4FZaghTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE9ugL7b1jhwb2iLMm4HQLInhRULStom/drBlp1XOzY=;
 b=BTOMe+a4Mj6+NfE1cUeIESmej6w0i1I7LzWFP8alo/oHuPuuLcjokzaJ3M+3cqAiKSmuS6heN/rfTV4mEE/UBhWuh+bF2GkvNIwyRd7LaGONjQhRpVuhv/iqF5VYXS5wpS++CDU8JhQWbIs0hIuiJAmsuFWzIfSt7KVEZUlbeO+rrSt+QCvXVvd9rvLa3pFjJo0XWeIDAFb4GZNINdObbeZjBMJMTTSbqEepZMzq/vGwY9B53x8tm6X1sQk1ieia7pB23vX1HtVDVAiaMIdVqh514W+lns8aUTLXHkM5nQPMAbpIeDAo2NMEsLZyqMV/N7QGHNeCDp8RrXpDL+fUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE9ugL7b1jhwb2iLMm4HQLInhRULStom/drBlp1XOzY=;
 b=TxEhNlSh2j31xsW9cfOTqeNgeDw7zwaiZEXrfiU6mkjHGSmTnN1aq+YVmIUTytqjPvqoyfLuXEpLRpoZ70fyT6cXpcXN1IQZIqnNEMAhoIYZZsyUY1tKYIkVT9Kt9NIIaraKfVFqySQa51No6XdjKnldUvYY2YpcSXtgk6V/rK48OvSdqU1pLGNZP/PPXIbdA9KuYzzF5H8bBBRkX6jIO0xtwK6wlEm87MaC17h5qkoDsmARZAHffyoHZ/zKjdamlbJ/yWHofuAJ9IlR/+5FVo/fJjVBXwmJzFXsW/oEr/BAbDFSeG6eZQ+ceScbYhjJsXaPnVPcYwaSdr1cFcIu4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 5 Nov
 2025 08:44:15 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 08:44:15 +0000
Date: Wed, 5 Nov 2025 10:44:03 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, kuba@kernel.org,
	davem@davemloft.net, bridge@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org,
	syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] net: bridge: fix use-after-free due to MST port
 state bypass
Message-ID: <aQsOUyVTGCD4Tpkb@shredder>
References: <20251104120313.1306566-1-razor@blackwall.org>
 <20251104120313.1306566-2-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104120313.1306566-2-razor@blackwall.org>
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 8356e43c-79a4-445f-64f6-08de1c47801f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1J6Z1qnY3QpI63XaWNWNwrEzlAP5afataztw8P6O+fm2mwMnq3EtFg0OecI?=
 =?us-ascii?Q?+2aRMU8F53xnyBBWAXv3npdZxlJuK53TrhukofNqO4B/MCTdqCw6QI0cQwbz?=
 =?us-ascii?Q?C+MtGvGmZEWxA7ObPbWW1jtDAEWDJJeQpcnk4kBvUec6TjTaIrSq0JyybuZA?=
 =?us-ascii?Q?nm9eqC/1VENMdk6D7xkGGfNnI6oKZcSI4ogCV09PiN4n9IXp3KHSBSC4hcFN?=
 =?us-ascii?Q?SBQdUUFGZt0MfsQ3HPxyCKjJ6KdgGXTlmdmpObJ5Y2IRGVbSWQGenF1Ld4J1?=
 =?us-ascii?Q?GZF4KSuw+eNTx55mCORxAM3dS1e5K0gymdEUCrJNPmUXzHL6BGFZB5uDBPnV?=
 =?us-ascii?Q?eFtmKeak7Bc+MWSm44g9hg2YdXGxrHhJs4vFJeY12eWychvWQxxasL5bZ8yC?=
 =?us-ascii?Q?IqsFNVYPvjNRGj2rSc+wHTWYDOhl7nfx5iTL1sJhH30iR8jPkYKB4QKUx0CW?=
 =?us-ascii?Q?DBSROwg9gub7jrCvXiC1p9EdRyU5yJNdt8H0b+GdGns32USdII//j3BdfrDF?=
 =?us-ascii?Q?A/QkEORCd0TXqnIWD1XfZS27hcHjexyIWsShL2HmtJRWWQVdYfvwHlk06oUp?=
 =?us-ascii?Q?taqQbItdvzJEcTXpJBceCHHYzoWSlH/bZxgHo57pCHpxZxPSYX2ud9FNHxLg?=
 =?us-ascii?Q?fjg0zkI58KaDKjqkttFKwsTZU1/h8T+7uMdL2BoBCfHCe4aqnRVoXEFcbJR/?=
 =?us-ascii?Q?UQjzQE/Sl2WKbYv1v6QiHppnRcsvrK7qZASCoVosqAc3d5uA7VdG3THsgr1Z?=
 =?us-ascii?Q?j7FP1GoEknHa8zy2NrSkLbCWatllplvG3uQaAnKnMjAcPGDkK2hSds0XEKju?=
 =?us-ascii?Q?p56r/Jd6OnFjYBftA6SJ5Rc/HYATokb7HFzXrcTjJDT+4uPKEskRTNziNZ3E?=
 =?us-ascii?Q?pZGHVyU3+DuZeElg6PKo+xFSeAMHz8n8ax+IgMEB2xbAAFjKrk8eTyh/JR8U?=
 =?us-ascii?Q?HYrIlPDUbPt0p9hamgdu3pN23If/o35tuoTnLAbtAJTmq7UMemaURoxgmnXF?=
 =?us-ascii?Q?hSN9gOLXx2GqhKOswSKDjklBrh0+LkYbZkdjl7WQQ3o138n0nHkKQCgm4AlS?=
 =?us-ascii?Q?XsPMDN8drInknKhY4BYuqA5VPwib9vIuVSUCK2qI9kqV+JRxrJA4DAL72x+J?=
 =?us-ascii?Q?j1BmpFOhimuW+Rp9DhRuMDN1MyuvLdxsSb9LMhtFPwN6oBynCmfU3WDfSIzE?=
 =?us-ascii?Q?MTT+3Rs8BA1DHAvtCMSPP8za21uiEIINZ8OqHdWR38kbtW9E5Q7RQBh+k15A?=
 =?us-ascii?Q?L5AWT1WjIWyslJFK6rGEVERBEPBE6dBUdAsCqbNSs5IdyzEnR/30QufUCFo1?=
 =?us-ascii?Q?EaYWUQDhrkrhvZ8EKWKPxVgVrkll0AcNKfcEE6mk6mzLd8X/IpxsG5U6eD3N?=
 =?us-ascii?Q?Ii3rKXpJx27SdqmNtemq6M+JT/lI1uRuIaPUXVdsu6iz0jP6vfb+kJqHazMf?=
 =?us-ascii?Q?X1zpvPjCypcncIu0mb8e13aHfBQ2uH1K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?60zOK+hcXeEYSf9wS3BcNT0yjQi/lidP8IBnNwwgHi4W6sWNYPm+ap/o4xp8?=
 =?us-ascii?Q?ctZkaJSljy6HjZBDQTRSm2mrLiv0tg5GPgrR0xLsOxl/1t22gIfKmkDi9C0N?=
 =?us-ascii?Q?DFQO8cCFVxzd/WmkZdbYeQMgtafJHujfQU/hIr7GyaARKCjtcIFviX0rPOpy?=
 =?us-ascii?Q?KJBQ8JO1AM9Q18bUaHMmDsQm7A52rN6SCQ+G0Whq0heEMX1c7B3ZhwImyv58?=
 =?us-ascii?Q?DdIlGuWcf3HTM3ap8EpGxbWkMbYxOqdZWBleBqZrI7dNQJzVO9Giuic2xpjf?=
 =?us-ascii?Q?TDBj5wHgxCJUti/i9yMb1oP7J3PFYuhULquAR3aomPcATNR9VtA/fszR/zfP?=
 =?us-ascii?Q?sHV+thE1gmWB8WaaHaRKNfGW48oEfNN4e/uwUK3Va6fb/dS5LBgkwL166THO?=
 =?us-ascii?Q?FYBcAs90l6Yxj87HcmAilDFBnsGf46To24J5U/x2hoLtwZHiwHD7qlqCPcSd?=
 =?us-ascii?Q?FnnD+yCOkTTVHmJJKO2f4Q4GdX6o/WBti3sFZ1U8/azObvya245QgU0g39bU?=
 =?us-ascii?Q?migPAXv5z5UBUyhM11qhfISec8yJFoty90bLKGN/tFpNO0APqBj9IlSX3lVL?=
 =?us-ascii?Q?0Nr3SiDkzkXwqZE2Q3CcKUrpmrWjfU5zs/TqfqXyyxMMfG3StcQF7gMzpjgz?=
 =?us-ascii?Q?qzX8dWIXbXCC2nAgIcQ5RY4mPnPvuLPIs6k0XjyL9w46HG90vXnU6Fb74zUj?=
 =?us-ascii?Q?iv+u3iduZrd+84+xu2J1TGHshcertkm0gTdKqsmReHt2hL5sDvyYtybUvjzE?=
 =?us-ascii?Q?BK73S65fcxiMFmWWcDYnSCiHtJw2MjNeKcbTYLO7Sio+SCK8IkUtAK0okrrQ?=
 =?us-ascii?Q?OYiwgBRFvPHZHgdb2EcMhGGm+MwnAn0Q2nGZSzP3w9nWXuydLBVBCFf1mYlW?=
 =?us-ascii?Q?yIVA67/bvML6KBTVJa37x3nOHcY8QFQUNTgBjcMTyCiJwiYmEcC+SmnKASSa?=
 =?us-ascii?Q?c72bXZu5+T7FZ4+tsn00zOC4w72BG4h62SoH1ULYvK/dHu+2nA0K5zP3zkM0?=
 =?us-ascii?Q?+nu94PX0JwDAZR1mP3EzMMdjAQKdAy5Vv0vp1nV1JN0m/AIwRPoZiX594ycH?=
 =?us-ascii?Q?OLwKG711bWtzIyBtEv3oQTFsnPFSFh5eFt5JlhkRDBFBhJ3/UAX05/KJqjLr?=
 =?us-ascii?Q?1c13FxMS80snR3iEMuMKFAoPgTUC/iTJaN5q3eAoWt4LlQSAOIiXol+NcM2f?=
 =?us-ascii?Q?0MsFitrw/Jj6xvcLKd0xySIwW6FKiadMwX7nJiRVHg7LyFHLZ/MTyIEiKtz0?=
 =?us-ascii?Q?q1WFGyS15YmYehwOJlMiKff/b9WTt3jQF93g8cFYsNerBWEyw3SbY6jzA8w3?=
 =?us-ascii?Q?d9M+0PieKBOGkQTPMul/hv3ykENwEKzX+pQnrYHw88SCqG0IZqPgYh8V9J9L?=
 =?us-ascii?Q?liGo+Yszyjn26k0jEn36aPuwiZMMcIhqWbZ4E4cAQhdO8xlk8L5y8do2LX16?=
 =?us-ascii?Q?MTjGTpxB2WbBoayHNy81WM0XCiQNy5Wgtnj0MsLJ5q2GCYU/Bia81mhUr65W?=
 =?us-ascii?Q?vQzzlUMho/C3xc6z3v+aujsrkVpv5227ujZf4KdzVWR33qsITKJqjeaJs0Er?=
 =?us-ascii?Q?+1aqON0bm7NSrNmE5l2KYzj5aq6XbgZJsNlWGNVs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8356e43c-79a4-445f-64f6-08de1c47801f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:44:15.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sc4B/AEcHjkXwghL73fNXd9NpeQBuobUQyN4QmJGgczzABK+RtmODAD08eaGez0amJN8JkvQ6DZYuZbsxKhkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708

On Tue, Nov 04, 2025 at 02:03:12PM +0200, Nikolay Aleksandrov wrote:
> syzbot reported[1] a use-after-free when deleting an expired fdb. It is
> due to a race condition between learning still happening and a port being
> deleted, after all its fdbs have been flushed. The port's state has been
> toggled to disabled so no learning should happen at that time, but if we
> have MST enabled, it will bypass the port's state, that together with VLAN
> filtering disabled can lead to fdb learning at a time when it shouldn't
> happen while the port is being deleted. VLAN filtering must be disabled
> because we flush the port VLANs when it's being deleted which will stop
> learning. This fix avoids adding more checks in the fast-path and instead
> toggles the MST static branch when changing VLAN filtering which
> effectively disables MST when VLAN filtering gets disabled, and re-enables
> it when VLAN filtering is enabled && MST is enabled as well.
> 
> [1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be

Nice analysis!

> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> Initially I did look into moving the rx handler
> registration/unregistration but that is much more difficult and
> error-prone. This solution seems like the cleanest approach that doesn't
> affect the fast-path.
> 
>  net/bridge/br_mst.c     | 18 +++++++++++++-----
>  net/bridge/br_private.h |  5 +++++
>  net/bridge/br_vlan.c    |  1 +
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 3f24b4ee49c2..4abf8551290f 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -194,6 +194,18 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
>  		v->state = v->port->state;
>  }
>  
> +void br_mst_static_branch_toggle(struct net_bridge *br)
> +{
> +	/* enable the branch only if both VLAN filtering and MST are enabled
> +	 * otherwise port state bypass can lead to learning race conditions
> +	 */
> +	if (br_opt_get(br, BROPT_VLAN_ENABLED) &&
> +	    br_opt_get(br, BROPT_MST_ENABLED))
> +		static_branch_enable(&br_mst_used);
> +	else
> +		static_branch_disable(&br_mst_used);

I believe the current code is buggy and these
static_branch_{enable,disable}() should be converted to
static_branch_{inc,dec}(). The static key is global and MST can be
enabled / disabled on multiple bridges, which makes this fix
problematic.

Can we instead clear BR_LEARNING from a port that is being deleted?

> +}
> +
>  int br_mst_set_enabled(struct net_bridge *br, bool on,
>  		       struct netlink_ext_ack *extack)
>  {
> @@ -224,11 +236,7 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
>  	if (err && err != -EOPNOTSUPP)
>  		return err;
>  
> -	if (on)
> -		static_branch_enable(&br_mst_used);
> -	else
> -		static_branch_disable(&br_mst_used);
> -
> +	br_mst_static_branch_toggle(br);
>  	br_opt_toggle(br, BROPT_MST_ENABLED, on);
>  	return 0;
>  }
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 16be5d250402..052bea4b3c06 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1952,6 +1952,7 @@ int br_mst_fill_info(struct sk_buff *skb,
>  		     const struct net_bridge_vlan_group *vg);
>  int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
>  		   struct netlink_ext_ack *extack);
> +void br_mst_static_branch_toggle(struct net_bridge *br);
>  #else
>  static inline bool br_mst_is_enabled(struct net_bridge *br)
>  {
> @@ -1987,6 +1988,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline void br_mst_static_branch_toggle(struct net_bridge *br)
> +{
> +}
>  #endif
>  
>  struct nf_br_ops {
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index ce72b837ff8e..636d11f932eb 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -911,6 +911,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val,
>  	br_manage_promisc(br);
>  	recalculate_group_addr(br);
>  	br_recalculate_fwd_mask(br);
> +	br_mst_static_branch_toggle(br);
>  	if (!val && br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
>  		br_info(br, "vlan filtering disabled, automatically disabling multicast vlan snooping\n");
>  		br_multicast_toggle_vlan_snooping(br, false, NULL);
> -- 
> 2.51.0
> 

