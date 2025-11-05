Return-Path: <netdev+bounces-235911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C1DC37002
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49E318C7089
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B5A3321CF;
	Wed,  5 Nov 2025 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hugiWPhj"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75F31A7FF
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362291; cv=fail; b=BKJLmcL1f/7CwGNKwjeGmCjCrFP5W+kfKbNjMzQAMjtjclkaTmNGNJT7y75w9SQgke1RqyaPyWWtJPpp+aL/iOHE9aFZKy+a1sE5zHNHNu+qxw5tugX6ltY0SolrThU5hXvargRZYeuPe00QdX4ej1xcVPf3iHenT7g/kGviAEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362291; c=relaxed/simple;
	bh=prmQj3s4MH0Xh1/45/2ln7IALJ6aYmkBLOCoeHXgmvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gY2dAa/hj/sWGWl14yK1y6xZLOI/hVt2gXw79ZgwpDTe8SxOovCtzgaJGoupEg8m5vJqAmburzoU5nBhv/lDgkg0yWkf9Jr5AvTwwPQqFdSgC2520U8oDzpIzUgTXatvcas2sh1WoHpxa2lRlv9y7OXBLjOHQ7bao+wmBkpfSxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hugiWPhj; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0uNGf4N6RT4SNKNZB/ubngZ8ylDQo8EdKY9u/KOjO3I/WfwzoazrygXTDbWtTE9WeO9Uqgc9EupV1hqxnTM+HgKMCad3t8mNGhBDm2IpFLJnYf7W1Oc6DGiC55FEkYbAyFJ4Lpt1EVlJI44B2/2r6n2VcobD/wD9t2IlrYC6IP3IL/jDoNy7j/JbAqy33cO2XfTbcNieb/gSc1bz+m9eR008TzXBYVKD2mykl+/dzQVoXUmHhwTvweDbkmA40l92qHQG3FVCcHAIOyPU+bQuyOWqXRuMjNPxmrj6bBmvFmybdheT2K0IYJteljie32L5q5fxVvMjDiYsZ6ijUPLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4VACKf8Zh0aFsTto5w/traDCzy5HU+QJ8fwRmb7vW8=;
 b=gtJLQ8DmYkqRhTtGlrwmmIe6jczIk25FpY0SHgyP9W9i9xNr9CJjqPa087MuGECUxTxMkAzlhgwW8Pv/JYorDA2M3qHMjHHMncEr9smGt79KmIK1gGpWznBuuyW2JJCd23EJhKeP5K1vIpFlMVHWlVGSzFNPfBBwFy4u78AT5dXF6dS5Y75F98Cte1CO/6cAkWPMjDXYJLJJwfKofBcL+I1Lg/yedfxhMCkHoduXPaVf/P9YZHevOX1yUDFKP1dKd5kjAcvJ/KnOq3XhHs/d2FP4RVzA5vPe4ArEew/z2RuNIu6bVgyX3wcGJzRZGI7EpQMp/8Woqx4tpsxgE84mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4VACKf8Zh0aFsTto5w/traDCzy5HU+QJ8fwRmb7vW8=;
 b=hugiWPhjmNcMp8FnvrvtGjl0iOfefnQju2eCTz9iRrM+iFKD8UXOAJagOhxj70hSN3gHGCOu0fIp+mKKMKYvYzAC5t7cu1nwIq4NQaPjffU85qTteezHZjcQlS8WXdbJmX82IhPcd1RN+Kzl73yTzMmaQTWcr5pd1zyhBgloTVZ5NCiTLYWCxAUZO/xDkhwUJFxck2d1mXMZ3iU5h8CRhPpmZZLFg6BUMc5MWJtwyNGZ1owjHm3i5aRNtay5ymfUEUOIdtGOE7Mr8ffspEqh/Elji5R0eUINI01qP0Gt1QrRYYlO+4lEdLdWFdPejlS4DlvpCnnrNB9LP+OcCI/rWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 17:04:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 17:04:45 +0000
Date: Wed, 5 Nov 2025 19:04:33 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, kuba@kernel.org,
	davem@davemloft.net, bridge@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net v2 2/2] net: bridge: fix MST static key usage
Message-ID: <aQuDobziTNYqOxB4@shredder>
References: <20251105111919.1499702-1-razor@blackwall.org>
 <20251105111919.1499702-3-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105111919.1499702-3-razor@blackwall.org>
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f376010-c10f-4062-41d9-08de1c8d6aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SgwWuptTnIw0jwl7NbG3HM0w38nvtSowXONjmEFS1B6+gOwjmkJc8ZFNAWG6?=
 =?us-ascii?Q?m59n6kZlv8lBpO6sZ6SY2BLGSO5zyYcNlzTWTrFAYecbtfeKvSPiUCfKIc3v?=
 =?us-ascii?Q?qWYtfQU4n2LL019eDqGTuAJ0LrhNzLdmGoDPY4QGFn4j7AD0gJJM0j/mYW/q?=
 =?us-ascii?Q?HNt6rePLCXYmgYqqhoORFGmszRcUBOZXPBZt9TgRtZxWKrIAlu0QmVhZSZD4?=
 =?us-ascii?Q?PycecXu9dYJN8XW5lMzBi1L5Kqy4/RcIINa2+8Thc0/GFjwCi/mAtQeH6avu?=
 =?us-ascii?Q?yVxXPQDqE7qB4wdLmQDR/GqUD6KwDgX9p9G1io2hSiZ9EuWraZv/jV9EgaO3?=
 =?us-ascii?Q?K0rDEuce4blXAX3fvV6i1ios66yGAffurf5+YBqx+EXPKqQJE+L/opQu4Xz5?=
 =?us-ascii?Q?xj6xgBXneyJZWeo2/lqoLDNtyX8zTLGalrvM/IMiKE9uGnL4Zh8oZATv3OzI?=
 =?us-ascii?Q?9FfWkdE5Gmg1VZ8dlJoLO2EnVCadoot1a8BVtQepjZ8M0WEjfuBMVEubeGIO?=
 =?us-ascii?Q?GAV1UKaQKI/T+QapNMtuPAijR2cBI2mTYgQaVo7DtIOwCpzAFKhdyeaRAsDh?=
 =?us-ascii?Q?CpKYiOEaCAZXydfs2CqgqXrCMjpT3elqxbRTXDWxaxGR9vOG8JfxVQ7CYN6g?=
 =?us-ascii?Q?1gR4BB3Ih7zbiYmeCfT10RT6OZCUFC/pj93+4LJ9xSYR6TphWohiVKLeFL6C?=
 =?us-ascii?Q?DV9WaRlAdWGx1X8r1OFcPAqfgluLRXrejgFM87E+kjGlwayJ6ELKdDpJDZt+?=
 =?us-ascii?Q?3YXbbfeeJLpfaMum/03WVcVqR1o67a+N/0ccRkB49gVKex4PbO1o+7j+BJrn?=
 =?us-ascii?Q?dr5SFRJT37IrMLCZDJiveQuENazzgXsatvGGhfGWxKsa/qclf2iPetuhFUL0?=
 =?us-ascii?Q?GmigH3ww/xGVC7TQvLilfg6LyU6mMcpny7fE4GbcfRwu5b80H/p4wa8x/4p3?=
 =?us-ascii?Q?Wp7yNN65d3Ks9sL9jbFQ1zjpgZkXVbQlBUAmVvckSJSPrAlDhWOFoakZoYM5?=
 =?us-ascii?Q?4hwVdXi5ih72mpYGN3W682sOV3Ekxb76ViOLVCUtGCfZb4mdg9bbaAJX2Ngv?=
 =?us-ascii?Q?Us9RhEv0Fz3nVSldpG4DrP7Wlf0kQDG7fcRWtB95TCndv2WTpkdHqdk/K6Co?=
 =?us-ascii?Q?5TEetFUDs01fFgWWxd2A22Uuezn81mGLnbk/TGr+3G7ZSeRkajxpYTPduc9K?=
 =?us-ascii?Q?eLzt0wwxikzKE7r0bB5jf+uMJXqZKa82SPHwBhcF3GwBTKNS63SD+0nGglR5?=
 =?us-ascii?Q?xUj710TLVhf9ng4wiseGY4eQVTfOGMZGdyLMhefCBp5eAtK+n16B0x1M8uPT?=
 =?us-ascii?Q?BUBBVlgAQM4NSFXzPeN8T5hPHDpSF1FLPW+HQLwB3o4jTEI2OiUafOSDi8Fc?=
 =?us-ascii?Q?1cEP6wlg2Srvr7CS/YgiUnMAv5ZColDnhGHdR5ZG9pSJ1lHsn3IViJ0hzBII?=
 =?us-ascii?Q?KRxvc/O7tmxcokNB3i7SEXdGCa0Rscfa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjdTC8nduga27wI+AWxjH7hCBVr/SMloPK4VUTZ+oSpddt5FAjGv4YDxyxzz?=
 =?us-ascii?Q?3hIAzxUulkXxvRY6ytC+eLt0VqIOVQiUv/fFG3nrcFtpXIR/PaqXjtBpXKdC?=
 =?us-ascii?Q?AItVBuHusy3xSUUY0z5bQ36E9JkAQL6ic8GJGI/MXm10H7gUtJjc/p6Os2hv?=
 =?us-ascii?Q?jY1JxbNWIHHGocci5AsZCtGVdiow1c9O/k4bYSmi+KD1NryqZcjvaY4WxhLw?=
 =?us-ascii?Q?rnYVkCHfdHqOKxgJq7ZqNcGWSuxiOr7sr11cFdrIU/qXtTbw2SgFhLkuqC/j?=
 =?us-ascii?Q?U4EFwkFX/B0odB9Vk56kvY5/iDwgs1wqtUR1QAQXCt46Dia24P2XwKIALwmv?=
 =?us-ascii?Q?7UFr9+aMFRTuIEzh2aazB65QdswRw68aB62GgEv6cliOH0IVJyZInpXRg8Zz?=
 =?us-ascii?Q?ij9GIZIEJknahPasG9jeCF2MtcZ6i+zOx08ow1TF0bqffE/OfLpu7mDOuRfU?=
 =?us-ascii?Q?FP0jKTz1RF6gv6tGzWPOBzjHYQhQ4aw+yjTnkRvQPO8It1+Ad+0UUJbVskiY?=
 =?us-ascii?Q?ZrQru8w+XxSm3V/NL/O3tXHbCRwpToMP55mStK3EwmubO8vD+VPxgNE+ufTt?=
 =?us-ascii?Q?Z7q87zs0bas8YcrLQBaFJghdyEhUn06kYIx1akQAtEuuvMBiLkpGJMpJkLCw?=
 =?us-ascii?Q?ntbkkeovQIopTowqzBdILtp3mWgrnd83P5/Qkd+B+p6TQBGGRu+tyDDEHqgB?=
 =?us-ascii?Q?R7+bJlLf0Eg+H7v74IKjtnER60ei4tlOLM0PPucctIeoS37rgEzwC6JCmwEB?=
 =?us-ascii?Q?zSgx55CFJ4cpsBdWkFB9zClqP3E8PDMacX16CYpulx3od5lTPfY81H2tVvxY?=
 =?us-ascii?Q?BhLDviR6HmtsM69+tMVTL7x+7EZdz8kTaCESRVfAvb1wRdJX1UWWt5y0qtmO?=
 =?us-ascii?Q?Fk8Xj0R4AyfSCeKoYdtVoJjbdhl/7Lob4qmz37YjCeO78yuXTR47FRzerZgJ?=
 =?us-ascii?Q?62RRU9mEQWX4Frx5CCXSinNQVpFs+b893GAJL9Tmrji8snGyZlks7dA0yfZ4?=
 =?us-ascii?Q?d6cf2aBYoPWKkrLla4Ey+24YuFshiSwPGRt48R93twq0a7mSD0Lkk7itHSyV?=
 =?us-ascii?Q?o7RsBDCQDTaAyxfBX+rMdm1E4LaQcykF9/ggocl8VbanGFyEAHefCoqozx+7?=
 =?us-ascii?Q?ZPRLGx9K9HcqSj0j6w470P6iQSl2RJYeVQh5IdTCzuJk16PBbDO5lryVg51a?=
 =?us-ascii?Q?PAtrFpkLdeXP07tKsoQV+RS+iGBZxgZ1+hbwwUYA8Q1bgegyBQ+66h3rMgj0?=
 =?us-ascii?Q?I6sK1MNDSM3eOrsKbuIu0IjuSZnKbKIG7wMdTFcZN/9Q5gjME5Ws6doMOPWx?=
 =?us-ascii?Q?qMMs/BgIyfbrYQEO5fpzZIdbt75FTy0orFrXbXcPjmlD2tNK/3CuNnO1MvQq?=
 =?us-ascii?Q?VWQenWf1E5gJT0NYgPgMk4Aj1XhZ9vazNQD9LNQWJIUvMlvjyn2pqPHF93XM?=
 =?us-ascii?Q?2lXDm91MHVafmMtjy0Ya0dL0tayZyC+PLZE2KdCFddnkbiD+yVMmUDYWdrTm?=
 =?us-ascii?Q?wYNJY+J9ne3copepwjzrZ84F+Oxjvj+CDP/OlGdsttAQbY2Qzvy/ElFRsRt4?=
 =?us-ascii?Q?F2IkBhTl/NWEfCa751gYYJXzXnE5/xwNkwElrA7I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f376010-c10f-4062-41d9-08de1c8d6aaa
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:04:44.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0eENphg7X5mpYfK6MCi9T58+5J1U138qNmfieuOR+bstUpdUc0in3XMM83tD6R+qiL4ONtPh2HTv7sn/fDqgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

On Wed, Nov 05, 2025 at 01:19:19PM +0200, Nikolay Aleksandrov wrote:
> As Ido pointed out, the static key usage in MST is buggy and should use
> inc/dec instead of enable/disable because we can have multiple bridges
> with MST enabled which means a single bridge can disable MST for all.
> Use static_branch_inc/dec to avoid that. When destroying a bridge decrement
> the key if MST was enabled.
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Closes: https://lore.kernel.org/netdev/20251104120313.1306566-1-razor@blackwall.org/T/#m6888d87658f94ed1725433940f4f4ebb00b5a68b
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

