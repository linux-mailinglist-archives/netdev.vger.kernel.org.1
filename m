Return-Path: <netdev+bounces-179463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51431A7CE33
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDEE3B212E
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C981F94A;
	Sun,  6 Apr 2025 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="naPGfR8w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8DBA930
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743947125; cv=fail; b=NiYgVtjslJUdukUcM7DUx0eSKbZe2LvCXSNagMLC8PgUyzYdUnRwMODd+hszxpdi98jDPWWltTbmzBVqrBWPG8HweKPg2fHE9emgXxN/0dkW9VhLsLi4+j4vCsJzzbn55YFL2K34bzQMUvtBhO7GNnfIquZwfZtL+0eW4GRGOzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743947125; c=relaxed/simple;
	bh=pR6cNx/nJ4eNl9Ubc+NQwBQFb3NfsbxHb1ND2EVfXDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CvH2wB1PerpRQdzzpsYWztT4NCGE2Uu1fUL16bxD/Ce2f3YyjhixSlJ4DG03sovyo/1hv4FKPVwibkRMyTYKKhU+MItf5uzeBoSH117oEXQi0vC4ewqJI2KJVPacyfgs1AgdilVLF82ak6c//Q7tt71sZVMeQLQ/SKU/vBcg7PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=naPGfR8w; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEo88pvucIXh/UlUngkBt8bH11ktjNNHSI8x/XcgCjg3sxanTb7wk4bgVRFjGI8r/qpWieVwg2wDe29D+ygvh2DVtSTuTbLpM9kPORa8hcSXCW5nBDnEc+lvYOPU5ARIZXReIgchjfeaVsdJgC6PM5CYIoeAK4VTXpf1A1iFp0T4zMb8O0lm6QQPf31aP8gP3o71fpz81nWAaP/WfhM6eLN5dJ3MxoaV/supnEjMo3DtizNcCtUOqQXpqnpc4nW2PjXWds1X7y/Qlk4zdyCectQsxphkDPFAQkNU5KTBTASCQpDyyNMse9dozFOAwbRDcJyYYWqdpIpapk5rucePMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4QlJzn1RkZ207y7ccy7wU8oNTGO+OSguDGfFQomXvk=;
 b=ytPWO0pcth0lIEL6yd02pMoOxMyh/iHXSjfBmF3xiISfT9JWcBB7n3R3gAOW+zutf+cZCVELjlV/BNwgnpG6nH6Fwxaeht0ulNP5S40GtM/28WajOkidP5wZsj6cmFSSqSXBaWXniArTrJqBfliv9p9Xhaw2OdEIIrx6tEjdrNk7OZokyBU+CSYEdHCndAbZqqqF/nxUK/8qtnbrkZOGDnhf8FaPGzWh3QpFSG8m9L4F8SwdKhjN3Z/jLtf2WwHTz6O4QAHFK9QkYG8BnjprEHkTmSRKn/ntehV5sMlVM+IfH4wC1uNUxrZSZ3bWn5XTHVKghS7Z6Y/9jpEFmYjkUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4QlJzn1RkZ207y7ccy7wU8oNTGO+OSguDGfFQomXvk=;
 b=naPGfR8wx0nQam0jU8200IQlBierMp9jOmn+sZ2coVXvEHYUr2jo8gLiGuj3uExPow5MLY0su+f5N9yeiT5jXUs0F96PZ2MbtoR4vIlBrAGEt7ltRTOp8NKNUYiv6Xu94fvXo7UFTq3IUKFtO6RpVOK7ldFYsfbeJfURhqoKVg2k5FsBSqEdQtxWhDaelPSUa9RZz/BwBEkM0iVpYEaFu2Cl0STqbzcfvy2N6JyY71+TCgxf6WxEmiiDVcy21CDzG+iSxVkj5VDsgxBfMqpXY8C07thuE5rFsI7gM2l9pO9AXAzKaQubobKWE66vHSmbveLQPv/fAw5uTXkCbPbHhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Sun, 6 Apr
 2025 13:45:21 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8606.029; Sun, 6 Apr 2025
 13:45:20 +0000
Date: Sun, 6 Apr 2025 16:45:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	gnault@redhat.com, stfomichev@gmail.com
Subject: Re: [PATCH net 1/2] ipv6: Start path selection from the first nexthop
Message-ID: <Z_KFZ5cm7tOaBvw0@shredder>
References: <20250402114224.293392-1-idosch@nvidia.com>
 <20250402114224.293392-2-idosch@nvidia.com>
 <67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67efef607bc41_1ddca82948c@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: FR4P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b32cd8b-f5b9-4178-a297-08dd75114609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pd9ugXq1AY5ou39TjK2b4OzxSWELAz0LqWE9zWAbPuyUVAGawISV0+oNcUUS?=
 =?us-ascii?Q?+8a7mwHi06Io5u+OSmx1zXTNIHG4Zn4qO+SaZhWKbq0xZf299j2QooN+y9l1?=
 =?us-ascii?Q?Oh4sNd1o/IP/HK8OnCZQ/k+oRtUdOZ3xbWJXGGQcIC2oF07QAICceKJ2+xT3?=
 =?us-ascii?Q?fKnJBD9EQ4tjS8555nZoHPMwNc/2zeboHh+Ha11VtRd5KPhJ8kOpfUeiOH4z?=
 =?us-ascii?Q?JIG3bkyAL97ZG0imfIw8v3KfTvN88R0n9JHjrT9MRXX1Sv12/Xh092EBKzuj?=
 =?us-ascii?Q?FpNMfN2TRxVl0GxmlP/szEuzqw2f2LH2eXnvMm9wQ5zlB1W0jbOfD1J9hJsH?=
 =?us-ascii?Q?XlN84HHusP032ZY3iXOewK0d3PKNmlt+2LAGOYX7iEkJt5E+CcdIza7AraXL?=
 =?us-ascii?Q?jzrJii2aGHIfto96kytOkfBW+fjADam3EO7UaMZalx6DzbommEMHxmKdIhBt?=
 =?us-ascii?Q?mEMz+jAej6amwuvrevqmm5gSISrWV+o0M4wpncHBBYYRieQXWyHeRVZ3cDKP?=
 =?us-ascii?Q?Sy+652rxApWN0pAcO2Yvw6Qb68xBd6Zk6ec2/ePB03yuZsxSR6t57Bu0m0z7?=
 =?us-ascii?Q?nRB7Ez3wwBoxWGumvfyRPNTzuyt6c3IlVZD49GF7PVwK4aZ5truCr4Dp40fl?=
 =?us-ascii?Q?3etmvjccyCbugceKsMyjcqU7CKeNtMheXE8jbkmHOxy7JuWjW92hs+9CYAbG?=
 =?us-ascii?Q?D8nve0aeW38j/yRccFm4YgJUj5pD/XoKTaTbHz1z6Rd4rcKymrlsmj7tKQHv?=
 =?us-ascii?Q?/IdHkIU1pPf8j2JQmf68lViSuUj+ZINn4b37lBy7iQUSOPcETA1lNASKId+3?=
 =?us-ascii?Q?rYsw9vqDxmPsPv7EZyNQKz4Kndg1TDx5AMr2WeLsn3UhE3OjVGfHJrrwPf8B?=
 =?us-ascii?Q?7VvsZHLKot7HoOZ0BR03Ho1dPh9bR1NVuzvt8ZPA4SGsyLbIlZK6d6wy1WD1?=
 =?us-ascii?Q?fDlG69jj1FklZ95gnDyDSzF5rlLeKNtSQnxn+8FZiDQijES4pI92SqKNvDl6?=
 =?us-ascii?Q?E6NCCyeam7ukHlnNOaAK1auh0i7+Jfe8Wusrk7uZqoqWCCbRzO3Y3CcyDchZ?=
 =?us-ascii?Q?ct40KywhTtJs6g7QMAr0rkXYkh5EIU/ibvHFw9Eqax9dndFirEHrGlQz4tNZ?=
 =?us-ascii?Q?n059IiO+kPdef+o60tWeUdfDDoi9aODyyaDry70D/jtlU9q8LaRYsW3MtznS?=
 =?us-ascii?Q?K8ahj0P591kFPJi93rt4Rum/gg7j+N7gT5WSPbtsPV3UF3ic18aFwera8XjN?=
 =?us-ascii?Q?U5fsIdh9OXrnQrDSkqRhu3ZsvNTDa4GNxFXI7Ja33Nkfr2Awqo2azPU2MMAI?=
 =?us-ascii?Q?DNv69VY25WzFeWxHITHETgUhiUf+d1yIrVUck2Ygdo8UIVN0De964Y4+buh/?=
 =?us-ascii?Q?v/Sv8mTH++jdKvajlTSMDwoEC8xF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?welqQELfInSd0BFrF+rjVOOHtVE+0ihPUewrfhUbh76ffu0LwkKqHcM4Pd24?=
 =?us-ascii?Q?gm2DIQYTeWmmrWZingnkKTnO6Ks1KKpSnk4cwfkk9RY/7UfIFM/Qzre1FeOS?=
 =?us-ascii?Q?t0I8lEkdoTYevfyfSeqqPwBIpqML+KIiJhJCQybbLUT/VOfTC8QZ5QzYA8fU?=
 =?us-ascii?Q?IA1a6tGizBCFCI+Uejho9vR+Ux2vIlXiu3tPv+v9yQf27iv/DxPwqlUcEYwL?=
 =?us-ascii?Q?LoSrXGc+PwSXlyfrgHKVFArUWzETsx8WmCZHbumUYpArOc2BPRodmNJp4JSH?=
 =?us-ascii?Q?BqknbibzqulBbKLFNsuxG7tPZSeMB3PK+CVMyGaKgLX064zV2oTRGUPpUB3O?=
 =?us-ascii?Q?Od9pE/FWxCXP4A+N+tpbl5YeOWKo5uqN/TEsDbPFLDypre2PWFxiGz4ayj+9?=
 =?us-ascii?Q?AQxImVT7YBOT5BMucFMk27Lf32NIbWI4GX0JlAXHryLbeVK5d6zbBjP7SvLq?=
 =?us-ascii?Q?VoulvwOCcM3geyo2bM0A/Bm4LwT/GtnROD44j5Nw9TnT6fs3hbFm7lkvQ1CB?=
 =?us-ascii?Q?0w4wJr5CVfCjQpI6yryLH/AH+ZQykd8S7os16/wClwrtM8tlE70UStz4LblO?=
 =?us-ascii?Q?/AcmSA2DZ94aB8O3mkVeDDCV1PxVE0s3/SUF+YYVJ0kEATj5E7aeH86yTdjW?=
 =?us-ascii?Q?oRLunIDOMl7OBw3/eNWwqQFTB3DW1cvf/vEY4VLdAq0l1k/DfbFcHF4mvgRQ?=
 =?us-ascii?Q?Td7bNs4OQWaMbD+axmcm8JkOctZIExBkWZFlrNVKJlakIWLbEqsFkxTitXQA?=
 =?us-ascii?Q?7cAGKG1FjpamSvjrEYEw3o6aq8chOzsX649M5lmqDu5qVtRGpUta2vP2kgIi?=
 =?us-ascii?Q?1T3YUfv5gsDWznJCrNsV7ftKctAfu2AyMcwbbd3eBCjy6oHPCEWP9L/buwek?=
 =?us-ascii?Q?uZd7xFe3to8XQVco4ABTEbmwkbFUyVv3Qp7cI+XcAgCTtNNZWn9A5++ZDBad?=
 =?us-ascii?Q?1BsCZkBB2uVfaMFFISAevKuwj0WslpwwMIiC7RwU4IWu0k5b1rKRo7sndD3D?=
 =?us-ascii?Q?kytZITKGwD0ZsjXx9sxaNGKsi5XpxvoBvyKvggXmvs62VJnRmw2tta13qruB?=
 =?us-ascii?Q?Ba3/BWIieZ0AZZz48glF7VrSQiFRxyC3ssnTbCONKlcAzMihAq2axwvMN3F5?=
 =?us-ascii?Q?iev1TguukPLsfDcHFqCm9YahVnb2MOsPVoAYYbxAlm3ze+lbbk+PibFr/vLk?=
 =?us-ascii?Q?wdVej1SFD93kYcz+XSsbvyezlQTGYqniYvHfws+Vaxad2GLozM/0cHiVY7r0?=
 =?us-ascii?Q?G3CldQ7rMH+j7odYPtSPVv78hHxzIcsRHx/40UWjZxtXhXBL8Pq79QHfTIeL?=
 =?us-ascii?Q?Rcku9iAdC5MsLxbxByVDwGQdXoO4DkqpoXkEaPdOtk+tbsjaxv2NIa8CIqS8?=
 =?us-ascii?Q?4x62emJbYHIg2XdCnJN6KRWYu18vDLdtEoZYFZRI7dh+mPgAhud9cLMVRgdx?=
 =?us-ascii?Q?tRpEA4MLKRhLQtyig0Vo5bLM0iMB5AEwY82hQjavilmXx70GYckfkZSQw83s?=
 =?us-ascii?Q?XfPJOFGn/ovlNy+Gxb7wMOMylPzPoFR2hI+olvzymb1vpLoaXYk3Vyck8Avu?=
 =?us-ascii?Q?GZke6yKLsjNdsfUEPVv72L0mTcf6wcS0AClpRkX8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b32cd8b-f5b9-4178-a297-08dd75114609
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2025 13:45:20.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQkdkfXUXgvmF5hoKOlzcub/Uc6ZWydd3smXS366cf17IvhNswdjUmzvJUa7chMdq/WvdyRqUkcu0tzUVQRGtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534

Hi Willem,

Thanks for taking a look

On Fri, Apr 04, 2025 at 10:40:32AM -0400, Willem de Bruijn wrote:
> Ido Schimmel wrote:
> > Cited commit transitioned IPv6 path selection to use hash-threshold
> > instead of modulo-N. With hash-threshold, each nexthop is assigned a
> > region boundary in the multipath hash function's output space and a
> > nexthop is chosen if the calculated hash is smaller than the nexthop's
> > region boundary.
> > 
> > Hash-threshold does not work correctly if path selection does not start
> > with the first nexthop. For example, if fib6_select_path() is always
> > passed the last nexthop in the group, then it will always be chosen
> > because its region boundary covers the entire hash function's output
> > space.
> > 
> > Fix this by starting the selection process from the first nexthop and do
> > not consider nexthops for which rt6_score_route() provided a negative
> > score.
> > 
> > Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
> > Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
> > Closes: https://lore.kernel.org/netdev/Z9RIyKZDNoka53EO@mini-arch/
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  net/ipv6/route.c | 38 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index c3406a0d45bd..864f0002034b 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -412,11 +412,35 @@ static bool rt6_check_expired(const struct rt6_info *rt)
> >  	return false;
> >  }
> >  
> > +static struct fib6_info *
> > +rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
> > +{
> > +	struct fib6_info *iter;
> > +	struct fib6_node *fn;
> > +
> > +	fn = rcu_dereference(rt->fib6_node);
> > +	if (!fn)
> > +		goto out;
> > +	iter = rcu_dereference(fn->leaf);
> > +	if (!iter)
> > +		goto out;
> > +
> > +	while (iter) {
> > +		if (iter->fib6_metric == rt->fib6_metric &&
> > +		    rt6_qualify_for_ecmp(iter))
> > +			return iter;
> > +		iter = rcu_dereference(iter->fib6_next);
> > +	}
> > +
> > +out:
> > +	return NULL;
> > +}
> 
> The rcu counterpart to rt6_multipath_first_sibling, which is used when
> computing the ranges in rt6_multipath_rebalance.

Right

> 
> > +
> >  void fib6_select_path(const struct net *net, struct fib6_result *res,
> >  		      struct flowi6 *fl6, int oif, bool have_oif_match,
> >  		      const struct sk_buff *skb, int strict)
> >  {
> > -	struct fib6_info *match = res->f6i;
> > +	struct fib6_info *first, *match = res->f6i;
> >  	struct fib6_info *sibling;
> >  
> >  	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
> > @@ -440,10 +464,18 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
> >  		return;
> >  	}
> >  
> > -	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
> > +	first = rt6_multipath_first_sibling_rcu(match);
> > +	if (!first)
> >  		goto out;
> >  
> > -	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
> > +	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
> > +	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
> > +			    strict) >= 0) {
> 
> Does this fix address two issues in one patch: start from the first
> sibling, and check validity of the sibling?

The loop below will only choose a nexthop ('match = sibling') if its
score is not negative. The purpose of the check here is to do the same
for the first nexthop. That is, only choose a nexthop when calculated
hash is smaller than the nexthop's region boundary and the nexthop has a
non negative score.

This was not done before for 'match' because the caller already chose
'match' based on its score.

> The behavior on negative score for the first_sibling appears
> different from that on subsequent siblings in the for_each below:
> in that case the loop breaks, while for the first it skips?
> 
>                 if (fl6->mp_hash > nh_upper_bound)
>                         continue;
>                 if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
>                         break;
>                 match = sibling;
>                 break;
> 
> Am I reading that correct and is that intentional?

Hmm, I see. I think it makes sense to have the same behavior for all
nexthops. That is, if nexthop fits in terms of hash but has a negative
score, then fallback to 'match'. How about the following diff?

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ab12b816ab94..210b84cecc24 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -470,10 +470,10 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
                goto out;
 
        hash = fl6->mp_hash;
-       if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
-           rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
-                           strict) >= 0) {
-               match = first;
+       if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound)) {
+               if (rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
+                                   strict) >= 0)
+                       match = first;
                goto out;
        }

