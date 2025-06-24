Return-Path: <netdev+bounces-200600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B1AE63FC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FA71922516
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098328CF75;
	Tue, 24 Jun 2025 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WedRrToO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5566252287
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766283; cv=fail; b=MIaxwlSp4uyp6VmyUjctgeco1OCoCOXrqTMxQ3bKzOVzYX/e52Be+Hg0PvsxQW77WF5zjcRtAtyHgCRi3vbPRhVG2RqQBvE1QuAGg1pzAUs8f8EX+LYRQ6SJZNmYYe8yPeNuyTbAck7Yo8N1mUxFnUIYOaF/KTNRtBJUr7AL8w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766283; c=relaxed/simple;
	bh=4ygjLJmvlg1+bTYAIvg3LNZahfH96INlM9vS1oKQY5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=thADk6daCAkblfhPgg8DK672X6oaFbLJ17C+EpM3ydJGtFqxl1kQvk7zyuAp5jS2nrR9G4BDYQEuJgFs7fVIlZFuP4yNcVGPOiC9OashbWR4lmIBHiK3naiz/N5cv9Caii+ujFcyEfJaDBWwjziph5bErMMDY6g+swtqJMTCYLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WedRrToO; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkhQ9gM6dkM3/X60a+alZvUVutr338fNDtL7YrtKr0LgZAvgGLxfMIAfGniWTLvDZ7d+szg4smjw5QV+rqcb0zmECAS6DDYKWNhZrJai/pK97KRhmGhhGPH/b6Z6nAptBwtWPTq8uhUDoNvMTehfk5oG/H8hs7Bg4LES4rBHtli1RarAohUTaKF10rothlQKuIsSOj+C3QcuK3mkWcjtM738elZ5N8dqyazeufbELpxxpV9BKTg8g1ZVrQNTPHRRYdlG2jnBOmX1qSFg713wgC9+XOpeEdVWKlQVjsxm7S4KHV3gSjNLUMSmVTxnfcRl9ubQlVYGPTaHnkbS6Wz5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwWDsXvPSuJQRr0HRs2FS4051UtUVgOpwiBL6jJW4Fw=;
 b=FIwL2Yr1GEkkikydXhhIwSySXBLRM368yD/rxcCExAWpdgIax3MY5ILF3IzLvgSRbxTNDmHoO9YumkiUd1N+6NKmhasQxCqUER8uLnj/hJGS+3SywjTL99fmQC3qzPagwVyBP9SiuahUDnP6JFvEjND6c1wIYhMgYrcbm6xnPzO22DNTYnds0OpQSL3cUmTM1Lx9E8LbXBxEXYV89/ESuQwQiJoetbSAhDxDHgm3DB9Wgyz0zPZMkz5XUobgzVXodx+/4UgbPRwSoH3HMAnr7YPERXq8bSxSFTM5S5ld/Rl0fypPCROJsWKo6u0bwP49GJithPkJFE4AI9O/K30Elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwWDsXvPSuJQRr0HRs2FS4051UtUVgOpwiBL6jJW4Fw=;
 b=WedRrToOekrPivYJpTRF58ll5j/GpkVuIAMnu8g+ISmodOxuSsfRkjuB5U1P99NzrhaEl01xtP7bmRyBmJwq+/yMJTgaYVV55SHTffarxPmQfKVmuBTk/7ZA/yrWsXqRtLqP+ADX+EItwqauvoJdmdr9dwnPUqXuBx/24NcIcImQB5T6l9Z82vzxIf3qi3U5Fl7IOVBDv/JGDG7nUBmQZfSfEt95+d9+zy1/5AFEJKPzw4pEoagIcLBAfr2/yKRoh5k8k6DfotX4LVuAHYYzYU9ojoacFUImKnkEu6SNZV7c+E8FL7lECHzqaJUSM3NhxLr0AroaCL9TVGdiXZhQlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 24 Jun
 2025 11:57:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 11:57:59 +0000
Date: Tue, 24 Jun 2025 14:57:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
	bridge@lists.linux-foundation.org, entwicklung@pengutronix.de,
	razor@blackwall.org
Subject: Re: [PATCH iproute2-next v5 2/3] bridge: dump mcast querier per vlan
Message-ID: <aFqSvEl1fehLswe8@shredder>
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-3-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623093316.1215970-3-f.pfitzner@pengutronix.de>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7cac00-08ad-47cd-97d6-08ddb3165d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ptgl3JNdW7KHAhGUri6foslw++hZNBUEsdHEXmUAtIM5mAiEzG/+34a+bED8?=
 =?us-ascii?Q?nHRjUWbi7kmV0DTBEavWDDnr3QYCP0TaLJPxwuL6nLpdqauRVuNNX8xeOI30?=
 =?us-ascii?Q?+iCbFFtmZVWX2/+7cmfPIj0hM/m9wmcUiGYNICL+Cx/7eczzxA782BIYLsHj?=
 =?us-ascii?Q?GVxLsmLSeWMN4wEX+CO86QOrreNt3H3M9OMD13i6LbThErnUN4r4Nho4k4HA?=
 =?us-ascii?Q?YlXqj01blLXgLn/iEg3rPShmUoQ9EocmvpgkOyldD4tl85hDgIzX4ANVHwzb?=
 =?us-ascii?Q?chgOG/VWfSkMIxv/5rI3LsW4sC6zbQPdUgO0tunKzLUIt/BE3xXbaN4nPS3/?=
 =?us-ascii?Q?6C+Q+PKWIdMLnZezrvOB7aoLc76RWcEM3bR7t369UbB/+zQs/EmVwTgFPgun?=
 =?us-ascii?Q?K5xMBDOsJ/Bb9oQ1Aq2gpKXhrn50yuVwvEgFWecvSA/ks7KY/DW9ncPc5sZq?=
 =?us-ascii?Q?OTkfFmfabXbKZxADGXOCX53YeBQen+tbVb+oWGiS7jtHZhF54dcMlCCEpsl7?=
 =?us-ascii?Q?oE+7VK+1cAU8BjcKn+BNkFLhRo1+RyNSxVtqBWOFcBeKSnBPu4q4brk6gAbh?=
 =?us-ascii?Q?cTdG9i0Vz63t/dIJ1tuRbFC+u2flf4XTNBIjv4EZZN3z+Cse2ertKekBOyyE?=
 =?us-ascii?Q?edlQrYUrDqsXvPF62V0xMQbtrXfOh1264ffWHBxHydvXM4ixWcCVdKMaGE34?=
 =?us-ascii?Q?ga9M3gPDjNQb8aL0IkycxZR76uybTtd9LQSRi3yQ76kXzrV1gPo3TYixHC1f?=
 =?us-ascii?Q?/IqeiLncoRM27smHyFrMT9tY5cQ17PEDIZHXIEgKsl+QKI/omZM8D05CE4Jg?=
 =?us-ascii?Q?xPPmibXf3x/0ddtfEdvbGqnjJkEPB1TxPnjgHe5zPRc6H6DmCjndEQBomJOV?=
 =?us-ascii?Q?QftMHX4FsipxlRv/04cz9ZzqkQ+Zsh0+O3Np27vz08OKlZBiIDHb0POTxFCU?=
 =?us-ascii?Q?BqMgHVVNMsFtEHa1CdKpjp8nHEjxmKEBtWtv1F5nt52/EZd3f1D6OcX8sM3O?=
 =?us-ascii?Q?7NurTyRvi32nZDHB/c142rZ3Y+bK/jA8KmntocOm7yO5QSX6xui8bgaqMKlz?=
 =?us-ascii?Q?dkhnSK2vHBRTc3nUC+f393JQgMVAefpY9uuejtEyMSxnBTnWoKURTa0itPS/?=
 =?us-ascii?Q?gFehZeuCDclM+JrwXE0d8aOzfjAdVtcaqR/OpXlImv0EQXK+7lXjotyNBqDf?=
 =?us-ascii?Q?5LSN3GDtc1DUyzarPNLSmSH7PaN+Hg4uuCp5n0jUOSZRh+Zj+mEs94CeFIJ+?=
 =?us-ascii?Q?lLzp+P+U8iRbLU8zyHVNcgfqrmvKvxch6NKnH+gnH0AdAkXc8SwpA3mtufsl?=
 =?us-ascii?Q?F1S8H54h+fWP7UDVKwTleqhpTYCj49/ulAmSlZphT3sc0a1pDWROue3E1tqk?=
 =?us-ascii?Q?ubPil/J3wg3VANcYFjzf5ST9Vo4JtxOoqK8NRYuL4eqX+wqAORTekgxBbuBm?=
 =?us-ascii?Q?BIAMQ2ACaBw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KInf7OL9s1bE0NxN78y8jbPZA6rgBSZYaIucVVmIJL3+geBk2in9+HS5i/fu?=
 =?us-ascii?Q?+aGF/G3EF2Z1TCC9HEd862pzzGZtuH3FgPQQK5gJb/pB1L2dOzZfLGhJsLi/?=
 =?us-ascii?Q?uGbg5jh0AZTgmLdg002ILpOMJ63EeUHZoWdNkFOypg71OmuvAU9jZ3JAqJ+e?=
 =?us-ascii?Q?DgPN1jgD7rpgJhPOMW8MxKIhnWsCwvs+Hdzxidvvm7GHkEtkfFqnYAT8S4MP?=
 =?us-ascii?Q?pCTPplZvOXNtOPBU6BqavljcywgMo2GLMOmSGYuCAzMcQfGYf9J6iR2bQdud?=
 =?us-ascii?Q?qoCfCLLV5GbWw8d5oZYg4HfWgN/E0W8rwIHrmxbqvbsZKAK73Oo+YBOVk1OT?=
 =?us-ascii?Q?lKBBDp7qsIJQj6bT5O8HAsh3QGswp86gQG5UR0VkPMVW5uGJKH6RHRSKy270?=
 =?us-ascii?Q?Z51qZB4BmAbbEmnxnWakZBIZPLaTbBgkLgv084nnYf3XYgLS1gt1Rc9jIyar?=
 =?us-ascii?Q?DIs9iz2E/5GZn04MAQehleUIu5tTE2Bb0H0b3rtAcTCjxLuEfMiFxVpC9seR?=
 =?us-ascii?Q?CBSMBIXNBdQEtONnQZ7m0nTOHl2EFTIq9m67Y01hiJkvwxiyu+FaKX/rJq91?=
 =?us-ascii?Q?5r5AvmPnqOT+/UNyC3EXplWzMJypV0PRc6Rz99Nbd48J3u2PUUGaezBigfqQ?=
 =?us-ascii?Q?rJoSlHzsbJsJSpMe1olFPNq7TkN8umj3s3+j6rWjrtc6vmIYjN6GR2Qael7u?=
 =?us-ascii?Q?bMqQ8D7bjJepnaEVtdLs0jBRbNklx5uoMH4ahMEL/cMfoQ2+cABNeKPFldZ7?=
 =?us-ascii?Q?8JyAE4yJDLeaMywb8MUXD9D73K4S0l+2GNFmmFArQlZ3e49eNzOeLEuPfyzq?=
 =?us-ascii?Q?yYjcsfSoHBvXurgtN54JGyKSkaydaaqr1HDX6R//WM97c+he3GsFX8q4gfdf?=
 =?us-ascii?Q?98LMFo0Kltz01fpRshZ0AVG6Ag3QjTNeGg2GqaLrqgDaRkml+8VBFeX8Bdee?=
 =?us-ascii?Q?srdfb/RcsptvYukEeYrfSIHXZ1qxkIgfRoRS2CDIWBr9zz4u7W0n1Fj60r0Z?=
 =?us-ascii?Q?YLBO/8A9QsZfvRNp9El7eizaMVgK3qYJtxJIw0fxZu6eesAXoTTwYvN3N3Z1?=
 =?us-ascii?Q?abT/4STVCfFJ2XU0Y4fe7ZWbrxM+3PJ7bT0OvuxL+UB462ZIiwy+pt4MGgls?=
 =?us-ascii?Q?f0Rsr61EDOsURqTnIREcaerTMz6f9geNuBoV9so/1wr/hlnjIS9MrrHN714u?=
 =?us-ascii?Q?H6n4i8SZT7pz6YBHMcjml0mwx15ccYhlh0c0mB7WIQGBXDXr7piafvupQwyH?=
 =?us-ascii?Q?dGS4gRyIZWswKngxMe8toonBcJIlCz1F7wc58iAODoGiPxlWCU3d9y54z7Ep?=
 =?us-ascii?Q?5v9WMavjieXUDUvjHVpHW4qEXWr74HgeKiXpwgccPelyC1bDQs7ag4GA4gPK?=
 =?us-ascii?Q?tN5sQVKd3OFu7ac9QWtYrScFoRSyZjUfJVt6f9UUYiRzA77KLbMsJRoNPyGK?=
 =?us-ascii?Q?f1jNNLYERfH2UQTzVlyU9T5l+DkLc0WrnUBulNTaUGUpP8I0f7z7tE+Wcjdl?=
 =?us-ascii?Q?xhMQBF9yvjT05H4tsVtX2qUDxXgqDgMy5UhxR2VgprB+5hohyVI7lBLn8VN1?=
 =?us-ascii?Q?B2L/L0xy1yZWHlUXB4lo6mtiGrAk1/jFuXMZr1SH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7cac00-08ad-47cd-97d6-08ddb3165d3a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:57:59.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDrFxQyIM8B5LoB+UgRoKGF7hFsFWWo70sX7QwXu1JmSkmWrH8qHO4/+h6+nb9crnk2RKxC67bh5W5JRYL3Fcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

On Mon, Jun 23, 2025 at 11:33:18AM +0200, Fabian Pfitzner wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> The options for vlan filtering and vlan mcast snooping have to be enabled
> in order to see the output:
> 
> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

