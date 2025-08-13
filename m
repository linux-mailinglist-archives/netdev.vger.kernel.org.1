Return-Path: <netdev+bounces-213282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89809B24572
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960E95A3BE6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201292D876C;
	Wed, 13 Aug 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAPsYjUy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872F2D6603;
	Wed, 13 Aug 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077232; cv=fail; b=MiOFieJIFX7qcWy6UevuWfohSQHJENAbz1q+AJVErr3mWU2WOPgF1ilrmCEmRsPytXSpYhW1I7zrqis1GaIbR1PSeyq3BdCmP4fPoeownKCSImFTbupehxOdqR4fu49DAmct03eZqm5a4+Riu138Uh1I4sI0uHKfjJkpRD0sMsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077232; c=relaxed/simple;
	bh=pv3kNb/arYw83aU4xldyx3Jb2QUTy5p3WQom8VqEddw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a8Tcr9YqkQVvKSsD5MQ6nKc6eMcOeko8GT+oAEwsYC8g8nV93X7+UBQ5bISI0Kt5M2UETctXBeapR9b39mOI1rQoNE34MEOdlsa62EFPHY3CV5GQpCJe1CL/eLQYO58NlK1eI4SX2TmAfhPUueaR0qMKyVkG+SCXRtVt1t1XT+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAPsYjUy; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOlxzgzlOWLHPaCDQkK5+sR6yRpUOZpc3Z/93YV/IKlHQkFhRCsFT95cxFbel2yJB+Gm+q1bZFeUBWqwDhIPTK9+elTEzs1/+BZHVO4KGly5DOTOKUuRHj9dI4UVh0f5EHQ2AInA8Co8Wv8Esn7pz+gTvoxDqLVXATk6eda/6/Qz5RPH9j1FAJn/lt5EiN9J7mGxF919K/z1Uq7hm7kUEm1LKBzjCCe2cW4ko2o2Mz6fzF5EG1DnLtpr9AYxioTYccWEBlkBM/ktb2Unuu+dscvpLv7zB/FWebsLi1/6C4yECX5WZa/WaREA0hjW6FG675Fs8/Zz2XLw2EwbHX3I4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70mjFwrnOYKrnyfWiBXBRl3bI1xbvH5dBgyfNkI4Tyw=;
 b=f1omI+pbRxMWADQNFVZJe2Z/PbQVKemlhljSbRkEuqL1gezpztPbMaJctNmIIbKWG3Vs8ZpWQ/0SZEtOejiGPPTvW4rrrtTPv4E8tQU5TsGXuBZJOEYTN9XdhX0qku/eAexDdHLaJ+/oOXFwDitMSUQeUlu+FeWzJKKR+eH7AleQOI63s3zjJHGXhxcrbLOOt04Wsw+E4ilV074A3TL8XIyUx3DuZhb5coYku0jVESfZcEEf3XyJ3xZca5cKDfoqoGX19cdITeL3l5lnFfWumZM92Clov7EQhjbOpQKGNiQsGdqXkMwpkWvzC/d43BeWj+/e3m2sfN2vQfFT1MMb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70mjFwrnOYKrnyfWiBXBRl3bI1xbvH5dBgyfNkI4Tyw=;
 b=iAPsYjUyIuQ/+I9vD0GN5Izu62ysxcxgf9zxWDOBhknyiJJkCRdLCBFR50dpkwvqdLAYtC3uP0jYEmcBzEV7Kaziou9ZPrMbnkjkHbt2/2wms9mO5wd98kVgnM9g5Bze4gYUUIJVu4mQyVeFmdZ4j62WuiKuJUk/6l/N+36KXrYn+p/OtaXuCtmlZBSzZW79ziYXL+feabh1A4ZWknFhq6iDiOcgovObZRHL1CTiq3C/9syT1Y1pp9DhLh0HEvtKeuow0SDt0Z/DcK/eRASbNO+13M5TOk0XL8/DZcUDYkf8n4TaO1hceI80OUT4Q7ixIPoidCnc3zlwAGvJoXfG6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:27:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:27:07 +0000
Date: Wed, 13 Aug 2025 12:26:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
	shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	martin.lau@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] net: vxlan: bind vxlan sockets to their
 local address if configured
Message-ID: <aJxaYt7aPxuU9iN6@shredder>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <20250812125155.3808-4-richardbgobert@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812125155.3808-4-richardbgobert@gmail.com>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f42988-660d-4174-b06d-08ddda4b9287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AMAbZC2shb5N+9Plf6ci5lY9p37DXOADBC8OsHdGOpFheI/2OFinkdA3saWq?=
 =?us-ascii?Q?2ofhX+r7c4h2wXzhgmIWqWeBwsoI09MTLlqnClz1V2j9AkJOJ6+2L3bjNYjK?=
 =?us-ascii?Q?bD+3XHsGXTvvXDpfbpfi6pVMs8XNe0rLcLjREBqEjT5I5u3lym/TpIS38vIn?=
 =?us-ascii?Q?bvDZq08X9aoa5hZy04fkUAj31PCi6yYjekVl8DclJ6t1NSKlAWajpGkps91v?=
 =?us-ascii?Q?Iq9R4WqQ359gcGVK42KTZ0+EhwNoMpnnKDHRj5W4pzE+BSP1ehIWPMFhVZha?=
 =?us-ascii?Q?ZpEh6/1PpT/jXiBdbZ4vovcE38w2kG+smP9wdZzltq60xxhl+9SEiS/6wpDP?=
 =?us-ascii?Q?kQbRj2No4W1deF5JRtSQItyFrGGu3DJUpE6+sYo5vhE0E/vi08O7ZAqhVquZ?=
 =?us-ascii?Q?zkXdNeiVt4jWrqXJ0PE1l5FR9L53Iv1XbqjX+5EJOodpnsrcNwVzpf0gmxA7?=
 =?us-ascii?Q?xnT/yZmI2Kg8rfSYsF3c+VRbboK4bt0HhrqyC7pH04tJ9uAnAp/WayiS6TpL?=
 =?us-ascii?Q?ULNWBWuEYM6tmficlULX+si2t0g4ZvWD47Ou6f7WcXneohwnu+202jVosUz+?=
 =?us-ascii?Q?kmKbObMSbn9ICmj5Nt5Xf+mD9fjNUu6dGR3ArR5zLydZTWn2X62aoJnJ4ZY/?=
 =?us-ascii?Q?QeGjsX7rkEmquRGN5xQBC9nNGM8bmtqdBhRGxdrX+8DUhHMBxWYh4JgvVT+f?=
 =?us-ascii?Q?etlk80bwom9qyfbKcA3FUVwsxOSYlHobQ7Wg8Xitk4b7ZqnhGv+uQSUrUSvf?=
 =?us-ascii?Q?HVgN9Y6GaPQwjBblbCc49LqLlxWLWIwzdVJM6VieYxKe70NoK6WK2CEeNOtH?=
 =?us-ascii?Q?TA9aSk+AccPofBBbsbMHob0RwJLoXP90JfSS7VGCD0MtrK9HHSSW/UCilm3v?=
 =?us-ascii?Q?qdPDNDr7Jdy12/VI9UFBYLLpx8RsVB+yOCOVQPzvjIdo+ZZHqIg5YjUg78FY?=
 =?us-ascii?Q?bdgHOytac5XgEC8+tSz401DmMGTPKacSOH5uwTOL5H2mjc4gwmFdfAr76Ppd?=
 =?us-ascii?Q?p3xfdQAhBWqzg8R5/gsQpee8YEtjlK5blkvKIBEn31axyYC665cExnnQRqCA?=
 =?us-ascii?Q?XVntX36cbYXSKONT+zzNLqqU6s9AsIKdrr4Z7vSb5jZIC92G2mIjelCJnRQb?=
 =?us-ascii?Q?+zCSCbx0SK/zZM2hunVEwhlSQ3OKiEd1Usd5Z2EhbIsaGorA3sN3qf5huSaN?=
 =?us-ascii?Q?Aspxax6Z0k5n/4VNuKFJmDpWSfSYOinflTuoXeW5SFGWszcfTMc1UoxkbUfD?=
 =?us-ascii?Q?hmBlzbAcONkSon1OHXvWGDC6th67PwxlE1hjnOEKQvEnFJ+ZKIwezfL9o8YK?=
 =?us-ascii?Q?8bFK/kSBok7GN+gGvkgL9tJtys6EQF/pX7u+xvzZoUayF9WnBm9Fno/f/kE6?=
 =?us-ascii?Q?VEcUieIXXOzG27sqWeymEThV4bo/gWHJQdT46eICvPMEYcFsXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FzBnH/wJkC7O+3TbJNux/7Ntnz7iT4EV8kuUFQufdqWw76dF+yy0JPHD6iBw?=
 =?us-ascii?Q?OUSlZWSTZifsr4Quw0ublT5TfFViPDqG/enmvTki24IIArRbms44HnfoD976?=
 =?us-ascii?Q?TSYDFS37l3DYGJkzSarv4jpqZSl5OgjvhgJEvS45fkP92y5fKE19BOLUzVaL?=
 =?us-ascii?Q?LwPxawyLnUBO7J/KB0HCFLvGIbxxis8uAyb2Wh6LNW+Bd+qAPPeqoIUo6ZOG?=
 =?us-ascii?Q?SJP9Zsd7ZADhduo0LN78405em3ce5/urWDCrh69PYuhMKXMME3LcpishwBjy?=
 =?us-ascii?Q?nSX95uGYIvaOyDV2tAcvpQJfogJ4fDkZwxuuq1x9kJbDmKS5XJZ1eNljb19q?=
 =?us-ascii?Q?QdRqjI3ukxXbE0wyJ3LYMXNqcMND/5tSmUGCuO+vXlLEI/l7vL4sJgLjz2TT?=
 =?us-ascii?Q?jR58HN7ikKdTwvOn6UpIbfagS0ymdLiInyMa0IF6/mQQWF7O473fub/bsyhm?=
 =?us-ascii?Q?D4RyXEPhuA+7Cb6tAnGHJw+zl8t2vCx8JzCQLfJiPr9mmEU+Q1GdcamVX1fi?=
 =?us-ascii?Q?Ih65UV6EgdjhYWMMFh3DqxYBIyUqsQwnt4DWMV6o6iSsg99HkN0w74mVzfEt?=
 =?us-ascii?Q?BVrtHeY+do07tzM0Zt6tUz5UWB9ee7A9B+CsJTvBMuBoxWmDE922okmTOdPF?=
 =?us-ascii?Q?EhnGINV7k46tnJEbQeKfcvHxcX7s6wSmBAb6pYF/ie+5mJmhiEDGdBbA7W8w?=
 =?us-ascii?Q?WL9GgFWyASmVDCIwxrbI6Y69BgZjXtfxuJ1Um0Gg3snou1FJzZ7EynZNZ43X?=
 =?us-ascii?Q?NMWlQQmPYx6Wdm3HaeoAobG3XdDuSDlGXnVCWKexwQI2S7IVh93jrg/s5Pqg?=
 =?us-ascii?Q?1at6s9H0ChSwP2LwkP5Jp6rDb43IR8atPWXLU9XVGiAa93n60wdbZgsrc+BY?=
 =?us-ascii?Q?ysPvW3D8TFSjdoeLnlt1IK9FCH2vKVNg8QFvkuBYGwtwnBqc12sNfAaXFSOc?=
 =?us-ascii?Q?IkiZPW3c2BNdhUyEgbpVtGnORYhsMVmOlX1A9MZCyEMsU0Z3mTfL1Vv7Ui6E?=
 =?us-ascii?Q?NpR/PtN8AXOfCmd0QlmLVzlSwi9RlkCURuaGH/Mht3ub5p1UIn5299qHwKsa?=
 =?us-ascii?Q?Vp7urAsuC+k6TCLOPK5nyCTX5m0b/3cWPVLMYlBqwjT0Q1+MwFj7eZ/ck6sV?=
 =?us-ascii?Q?eGwJ0fymzDJQd81qbeTtAa5za3ozPe+ihChFJoFkTyBiZpEoiW56UTjZ7yGH?=
 =?us-ascii?Q?Cib4n47Kk6YQi+h0/gIJ8ttSCb8drtIqve1nrVb5CleYyqft3EPncUaVn8K5?=
 =?us-ascii?Q?EirRW7P+lCMECqdo9/llVvvfd9RJeqD+/Trym8qKpmpZ2CzmcbA0jIaPrSz2?=
 =?us-ascii?Q?f7SxebnfhTqkOeR917qzK5P8gXdMGetuE7S29W9DnxgJsSTO53zU019vdaQD?=
 =?us-ascii?Q?I5JDQb1FvfRSeZOMPHkiqlM0XehXws6tiHyPZr13xPmBKORzMQK1yXHOFBVU?=
 =?us-ascii?Q?rGOX+hsFPcPb6wzeInbZmweM4ZTA/788p/RUKzva4GiV1lbjRMam6xOuC7xf?=
 =?us-ascii?Q?jo8hQ7n7kUPzM3+sUevVUsK/brfmGlt8suRQcOf5630wk/FuyyYMt+/HEqor?=
 =?us-ascii?Q?5MfIXeiRUh2l3NM4+OxcXTrWDlGVTFFIjP42fyKG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f42988-660d-4174-b06d-08ddda4b9287
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:27:07.3064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hV8MU2MI9s0G7XqqkCObyO/n/f9pTtbOgG5j0iARD8rN66LDZehuCa/nPdRv/baTdTyfoCIe+A+9riUt5O/9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

On Tue, Aug 12, 2025 at 02:51:53PM +0200, Richard Gobert wrote:
> Bind VXLAN sockets to the local addresses if the IFLA_VXLAN_LOCALBIND
> option is set. This is the new default.

Drop the last sentence?

> 
> Change vxlan_find_sock to search for the socket using the listening
> address.
> 
> This is implemented by copying the VXLAN local address to the udp_port_cfg
> passed to udp_sock_create. The freebind option is set because VXLAN
> interfaces may be UP before their outgoing interface is.
> 
> This fixes multiple VXLAN selftests that fail because of that race.

This sentence is no longer relevant as well.

> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 59 ++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 15fe9d83c724..12da9595436e 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -78,18 +78,34 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
>  }
>  
>  /* Find VXLAN socket based on network namespace, address family, UDP port,
> - * enabled unshareable flags and socket device binding (see l3mdev with
> - * non-default VRF).
> + * bound address, enabled unshareable flags and socket device binding
> + * (see l3mdev with non-default VRF).
>   */
>  static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
> -					  __be16 port, u32 flags, int ifindex)
> +					  __be16 port, u32 flags, int ifindex,
> +					  union vxlan_addr *saddr)
>  {
>  	struct vxlan_sock *vs;
>  
>  	flags &= VXLAN_F_RCV_FLAGS;
>  
>  	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
> -		if (inet_sk(vs->sock->sk)->inet_sport == port &&
> +		struct sock *sk = vs->sock->sk;
> +		struct inet_sock *inet = inet_sk(sk);

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

> +
> +		if (flags & VXLAN_F_LOCALBIND) {
> +			if (family == AF_INET &&
> +			    inet->inet_rcv_saddr != saddr->sin.sin_addr.s_addr)
> +				continue;
> +#if IS_ENABLED(CONFIG_IPV6)
> +			else if (family == AF_INET6 &&
> +				 ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
> +					       &saddr->sin6.sin6_addr) != 0)
> +				continue;
> +#endif
> +		}
> +
> +		if (inet->inet_sport == port &&
>  		    vxlan_get_sk_family(vs) == family &&
>  		    vs->flags == flags &&
>  		    vs->sock->sk->sk_bound_dev_if == ifindex)

