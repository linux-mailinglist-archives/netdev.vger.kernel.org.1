Return-Path: <netdev+bounces-100757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102118FBE13
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B39A1C22B5F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D284E1C;
	Tue,  4 Jun 2024 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ODB8E7Op"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC88801
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536717; cv=fail; b=KCXSpWSyk7VRDAlukgYxs+KErWdFkPRPkdivZsBtdzDawQQ8rGY4DvF15rwEcK9167Kohd6DkW2d7GxavU2nk5W9Nz9bm7bWhJY9x+/vlxvXA2wjt8MZ+4sKaEBoX3f78qzbLUCwIRelHv4OEI4aICSljEthBx/vtiro0qpBIxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536717; c=relaxed/simple;
	bh=jIKuKzJvvkj5ThxFPxq6GDj3pQVzJoDuLtABKBv7a6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LEybO4OvSImXOWCU7/+Fe6xhtUwk5kHYanvAGp0wQnN05augBKsmEW5nrZNJrLqOvxAi977zGeyaXQzzW0HF8KEK2DrGY4CD206rQo/1VhZQOt3wBgtqE3hPBIrpf3a6gBmGi2ZcwQQ89J3bMROpTXG2lH1bHCAqmP6QVODzyUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ODB8E7Op; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfKv9X9/J1l+1fS+75MIJk+eCvv6fM3CFPJ/xZZwz9CnlagpfiDaZHLR2WrtlBdd9yHk7ZIdgdVPdXcg3k6f4xmUIBeDVJSWC3GH1ibSZ7HdWXI1QObOQzJ8yBA67jydr45ZhuGObpUgbG8BcaeCqo9xcnT8XYZSJ1BpOXeoKvnw+FPDDQ/AqUw1G/3rur+hTgUI4N4C5XqNw2HwkecEUuQL4X4wCSjtOXDxwwQziEt0H6LsB2y15aW61poOdx1PQJ8SU4tl16OKzUcJqjP7eZJ/d9pdxlnnCpHI8aZ3ChcKLiHcc/tv/cQJ0jGsGAOpLabr2w3S3dGtpv4jO2FDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Uc+xSsFDn80nHsLMl1wA/7SURKByaBMYZPeBOpEatg=;
 b=KOME3ZIqLeX10dkySDSkATKt/1W0INU9MRdKo1B+15S5OAVevXSoHXrX/FFqw7SJCbMnCVCt2ZE85TSHe9JXNm9ed5Jzvw8e/czKV7ebATDIcKsMNOivN+FXtGSJCJkMW52We7gYZaprs5LYi88081n5Glk4Yp1imzhS7vH7ir17XtrcI3oeH/KFGrTVlAFqK/oMQNLrwp8s9J6HKJ87twZu5fZa6zsqDW9ReCvGXugf0jEcmeC0H+X1Um4DskqtV/NEIET+N/CvwoAwDtd1y4tX8kg4zA0j0jsdc1lRbV2J9V0a2Ntk844DJS0pv/Dg1UNeiPjWkVfjRmW9yK/4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Uc+xSsFDn80nHsLMl1wA/7SURKByaBMYZPeBOpEatg=;
 b=ODB8E7Opwwu7c/58+osJDni2xJr9dGQb6BsASQPW8XYAJr858UOXyr7DvXK7/VPi6LArqpVXcEckSnJN8szsDVp41a8jbPyd2rEEO2PxvQpcbMNj1JQHbyYsZDLDxVNjwSQHbZRIKksM3IX7ac4ktgmC/tpF5vzr93MJdp8kB1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Tue, 4 Jun 2024 21:31:52 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:31:52 +0000
Date: Wed, 5 Jun 2024 00:31:49 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net] net/sched: taprio: always validate
 TCA_TAPRIO_ATTR_PRIOMAP
Message-ID: <20240604213149.wjiff3viqokkonmn@skbuf>
References: <20240604181511.769870-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604181511.769870-1-edumazet@google.com>
X-ClientProxiedBy: VI1P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::45) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd9205a-93b5-4ff0-3a71-08dc84ddbfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YyANaUcJYqr6rqrpSPcm+dZK6WnZwSej9o/H4lQ9f8VTqV9iu8sqhsUmzyPV?=
 =?us-ascii?Q?7lbYidAM2/t/gCifoHibFEDIfDYelmK8DiKFNdcPZfNx1sTW+AVtEOqYb0fV?=
 =?us-ascii?Q?KfZP7Fbpec1iv/GBAsZ7aeZdihnBDyHGe8ORLeeh43Ke1D2yfJBn26vAhuMj?=
 =?us-ascii?Q?6Teeh9iU81OLGWG5XLXwc7YSX4b0BpaJVDUTOWlKSs3+Cz/WzkDYFhIGK0OY?=
 =?us-ascii?Q?ZLOBdj5NS0rbXQM2u0472HixltauOSpy5uAcERdLGx99z0cerYhFWbPXwAPy?=
 =?us-ascii?Q?hEKdfF7NGi0aEeBaYw91268uX11HAnTsEgKZglDwLSAXhjhWPSesVybVt6Jo?=
 =?us-ascii?Q?FdZWU9bdKjVexkm11cuTvigW3+yHkfSelAkqAk3jRg8CqMsW+QnVuFp0JiwD?=
 =?us-ascii?Q?zj4mGr2OR2eCMiee0jZA92SjXfQhBpO/RLSyBLCiP7Rg6JbIrP17wV5dNgFd?=
 =?us-ascii?Q?0ORgr1kJF4xuYHfkJC/Q4f2p1QbNbU55WBmd1GCtf7n72hdapoLPHnIC0+Q1?=
 =?us-ascii?Q?i6AznYOT460m5A/ztBMGDLKnY0uqnhPZR0U+BPCHG+jpXgGI1FUrBH30Hpez?=
 =?us-ascii?Q?Xj9JGViZ9n8VbSuTnSD1qA67s6he96an0dyOSobtbF90J+sJE4b0z/3Q7afX?=
 =?us-ascii?Q?Iy2sUkSlX5IdFwNdCXQ+1+b3paLFXvWF0ofdTwQuHpk95ILlr+FjuiOIVIju?=
 =?us-ascii?Q?Xu5ODMbZeIfnhw1PFBdfjerI4FULEa/PzDaFfsOAs18RIzW4ur18avvifGt7?=
 =?us-ascii?Q?loS1DiiVJDDIegAGjYs9RnFhnsGmB+s/0iufD5sz8N68uDiRxN627DSxqYeu?=
 =?us-ascii?Q?684VfYVnb7jgddhqO6Dx+9Ie/iGKrARHSYoZITH3guJPRbA/loTDVNpEn7Ii?=
 =?us-ascii?Q?AKitdvZEv4NsiTrkxcXOCW1LJW6aYSHyGClKYARKQF9O2sHj6jCazkVzOSdT?=
 =?us-ascii?Q?88aKOLkj2WCyzqaPQENtSuvyJEeW2I5Xtki509GyadVZrv04Y1REdZ/JVrms?=
 =?us-ascii?Q?ixFflNGgIFL6TBnaRhVPk5KX3qOBhUolUXOVASQws9nkds/17xpWcFJcBX6p?=
 =?us-ascii?Q?mOGAGIqGLCnpgQOlJRpOwTvg7nss5rUvOXeK75tkSXBh/chnRl8JyYZw/hGu?=
 =?us-ascii?Q?10Qn6MMQPeq4x7BZcpzhaRKiz1yMDQF6HnuUTO2R4+7WUZzXIxstrbbAhVvr?=
 =?us-ascii?Q?wmgflGxyV5LqdTtc1tjSsn5XxVTzcM3+nj/vDj7WhZ2IIziszqy4pcowkIeC?=
 =?us-ascii?Q?haLTAsLBWXeGjOHZ0WXRS1TNVreQZNNqovqbO28k7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dGpw9jMtY/HqeoabboJQJwZik361PQy8prN1V+yzCjakFDBGpJMJoucv6VPO?=
 =?us-ascii?Q?VEnV7ITKgfnr9n1KlPxrPSzqnsZcpqxIBiaubPJKyYR1sYucDrYZthmS1URD?=
 =?us-ascii?Q?qcVmr8huz3Gi9dNAEYY8lPNcnYhYEel9jT/OudndjRggx8HkI8tPc+h/mjo/?=
 =?us-ascii?Q?xFdrcDLT7T0DVIgE4vRlEdo7EuddvOKOSw0AaiYBYu1sJviIkgVKhAB5q0TY?=
 =?us-ascii?Q?u/nsx6ZzlFZhQJcRZgoX6VrDna6UrxD697N14Y4/cTwWcTNIo4hxeI8gL6J0?=
 =?us-ascii?Q?I96BbXZfmZeXw71EMHojoxb4NQ0P4owAbTFfOWSFPib/htg5hP3fb1FeqdDZ?=
 =?us-ascii?Q?4LjIeObbsClepMqo+YpWkKQDEVj3bUd+XKpt6GSrxUClrsoCYjBdi5xFKPgs?=
 =?us-ascii?Q?TfjvOQuNUeKJePFXCunVqvV6cYYJ0v4ksoQmozUuf0VM++wJd6m/5iybG27/?=
 =?us-ascii?Q?5KS6MUk8GCBvSLazAfA2QOWDXeimPeXz9TJtTayu0jYBejYGKAnPQbh61K6b?=
 =?us-ascii?Q?p+KNyh9/HkteL6BoyVVnaJgpY4ZsIhCa3H1jGkX8VavThIl9Wik5MS3A11cY?=
 =?us-ascii?Q?xX5791SFr1cyrgbsyPARADHQkPwefJ6N5siSFWVKCr9QF/47fv4a0Cv9bCkS?=
 =?us-ascii?Q?Hy7iWkRNzh2FyMGWtKP51mm0hjK9vVPQw+Y0mrGcETqqsUb1mjMnlf2kHmO8?=
 =?us-ascii?Q?uLkS/hS8U5aSEOjBAHIPmw72SY1fV69coRB5kk8bdV1ooHCLzi1PqulQrPQv?=
 =?us-ascii?Q?oiwh85Bxnm9ntEq2ovZBZtx3+HY4sUoeZmlaK2MO8wOqaHQrpoDrBnMpDnWL?=
 =?us-ascii?Q?LLXGwoOHUEhIbFgjP4Rxb224snMCFeaKkZHBJNAJgQ2b8ZKU9i1Qwq19M21f?=
 =?us-ascii?Q?29YzKBhQqq4kseeN62v3N3rcNztmi1/Y64LKGhSAnYAOnM5QJcOW4iVsb2HT?=
 =?us-ascii?Q?wFBDO2u+aOA/eAE4noWvSFv36w2H+X2459o4pcZ7w3NPKZnhC+2kc2gTHhvP?=
 =?us-ascii?Q?WcOdJa4sKPPb6s8IQnAy+GNbIHev2dKpjDwxRvNB/IpUw8sMliuzCOlZbsxp?=
 =?us-ascii?Q?8J8CffKKx9tD9AUUQFXkgLMH8lPso9mLda7rojWZCqfw0lbJPY3dDeQrd39p?=
 =?us-ascii?Q?DbbaBSflQxAlv9b/j1fcJeg85v93UHmWj8pn99U7b/ozxlOwYfSRB2Ay6amW?=
 =?us-ascii?Q?PeWFBCB/OwD69ntgvLy8SkhE4Uqnn7+HTdO1rbe4/CbzbR9M1sZ/0h45LLbU?=
 =?us-ascii?Q?PwA4bqz+r1DhJxfGF/sp55Y6MKjCskJ3aYsttPfQMowwAEy6SCwa/SMc9Y3q?=
 =?us-ascii?Q?N62FE7TUXnkcn3HmANt0ZyDdLdLbu6DdEc9V3CrW4JjQNm/MEy0iCxmvcBXB?=
 =?us-ascii?Q?JS0Vn0cyabjDKZV16ec3jj7GvJgazAbsykOJdbmJl/DPmKkifCyGH16LsSLu?=
 =?us-ascii?Q?gQVs/djKVEOX1ySY+ULWvGZur2HcqqBChn9HORP0ZzrqCaxQfCLVP3NEUM1y?=
 =?us-ascii?Q?FlsTcyqmqDZ6Bg/ylk19FpWMMyGmIvD0gseeQdaBQB32/SaanpHvs9Fq+mGI?=
 =?us-ascii?Q?toKn0m5LZamtbmPx8ayUDccWyBAqVletLwGXwMLap3Hgi+R3YNA+be23zuBr?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd9205a-93b5-4ff0-3a71-08dc84ddbfe6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:31:52.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owleiWyS0554CVH+ZRukVZxEwl8lr2y5wkbR4TVYDqgWMd/bFd2ZiHT9YaPdER622VqBPnoMdMV8jARGQFw7+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979

On Tue, Jun 04, 2024 at 06:15:11PM +0000, Eric Dumazet wrote:
> If one TCA_TAPRIO_ATTR_PRIOMAP attribute has been provided,
> taprio_parse_mqprio_opt() must validate it, or userspace
> can inject arbitrary data to the kernel, the second time
> taprio_change() is called.
> 
> First call (with valid attributes) sets dev->num_tc
> to a non zero value.
> 
> Second call (with arbitrary mqprio attributes)
> returns early from taprio_parse_mqprio_opt()
> and bad things can happen.
> 
> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

