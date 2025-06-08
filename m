Return-Path: <netdev+bounces-195557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EC8AD1294
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2773AA946
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50D22B585;
	Sun,  8 Jun 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PHgx42HZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA4201266
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749392643; cv=fail; b=evS4P+sEvCEtvchRDhOeJMlYrWeqHE7p47Nbxm5tjUgowztw+t5Sb2VsbOH1yHE4vBhNxrd+2I6Pj+jRoPRyHdugNxiJVW7Ih43LYdizxsAR0QgCdMIH4vk0CmYyi1BB30GJtRRFdDXWo+QzHJn2qfzL7yF8cL1pUkHkdr7nt7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749392643; c=relaxed/simple;
	bh=itPDVThEgtOPa4WYR0KTIp6fHdvx9QblDUfcWTaDAfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RuhVg54DenrKqcnRCDvuJvVmrGOSCDCqanUQ2vrCl3ZxCnhxbM0S9e6gf3+jH0WCzV5nZdkfevVXIdoCAWzseKhphLr4Zj4ae1zmi03Xo9PsctWL5CiZ4Sopn41n0YaHAjVcjvrxuXEbJcVbiBRf7RBCkkotAQj0Dy7drw2dvZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PHgx42HZ; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRTJ9Kwe41OQaEv9YuQTSxmblP/jq6773s07/9+fzunTGw23rsQLRZb7DoF6QihZy19fqwpF2PTqWX0BuZc6ijq3I+gk97SxfChLxyusk09+GvNQaoDl8XWSlPdXpM1X4DB7rqEyrPt2VYDCcmmoa3e7FWmBG9jJurjeNvxP0dEvy93/hhbsuJphkkOYRUGitVBbKauAJ4h4MRmN1mBupR7Ejegzxy3VZ5tdmkkSXgwuNoY12tXqAqXM6jBRtrS6+D5OHPdbH5oella/Pij2DBchlfYK2/qSTmkA2ahIlqI2ReAH7UBUv85Dmtla3wiGDDAZEVPibGunM+O64C0tXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm+cjiK+m7J2tMF4A8N18jVXPcnLKt6CqEwHo6aEFY0=;
 b=n+QA7XOYokXhEvL5xxLemapF5Geb6Cfm1Un85VYE/AdVFO3Kq8k8V0DchVcChWABhzIeHD9tigCy0MEgcwXI/O33dLFMHx2N/5WLPHwrlkv2zsHm2b3s9uXKE3UoR9lE9sHcLgk0FAaQ5nr3aq60jNIdKvRBPQMIo3vl4qYwHIcDzeKf0JqJd+a5/eS06QAod3uEiCblofLX2cr3GgiPyMWJLKR2B98asmYBaHRqlo+Sg6F9/llxKV0IET2dRsMYTk9j2SFVbEELPTOSBrx4kAwanc0cRTmpJxC9ZizOIsZv8vRdvWf0n0E0vkSBKPJkLRqwz3ANRqxQK4hWIjCTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm+cjiK+m7J2tMF4A8N18jVXPcnLKt6CqEwHo6aEFY0=;
 b=PHgx42HZL6FBN1bACu1XlXGxD1QEim/QyrMjDB0P489s1Q2ltHI3+s2r9r3b/pNR8/IqlftZT09Hco35zYuAeaPbyocjUM8EJYZZwjeoGDnc0jSrlXTuxJ72D147BZhFvkOYciKZ3SGCSz1IJdLTG5hWgzvDr3zFEcPJ7RDaPiNZ3s1+vrcJEu/famDd8XJi4y3zKnyzvzn7OiXX6fv5VjmKiMkBewioHtqQMSnzSjyJdR4pLP6abCVUJMRg11/SQWSD0DMsMmG3KTNckpWLwIJVAReyHrPHFLbNhD2LuxbI89F0znS+EWxXvpyFkM+2L8vHRj8dC2cDAmIHiOV6Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Sun, 8 Jun
 2025 14:23:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Sun, 8 Jun 2025
 14:23:58 +0000
Date: Sun, 8 Jun 2025 17:23:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next 1/4] ip: ipstats: Iterate all xstats
 attributes
Message-ID: <aEWc81vmd3kr57XP@shredder>
References: <cover.1749220201.git.petrm@nvidia.com>
 <fc317232104be45d52cc2827e90f01a0676441c1.1749220201.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc317232104be45d52cc2827e90f01a0676441c1.1749220201.git.petrm@nvidia.com>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cf4295-814f-49e6-2334-08dda6981b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J51JYFFH0T5nbi6+tl5uvphZg/PaxLfc8iVKG8jD2gVJ5Slxcu9W9GBO1XEn?=
 =?us-ascii?Q?rFKEkOmTUm22hUDa3Y1Cn5wVHfSJ0N3Tzxnzwp79TOKZvN9J3D0+/1n83KJL?=
 =?us-ascii?Q?/kDKrel9mrWstKMyBNzw8fagF0R6Y0iM9IiXwhu3Rz1z7SoAboUEmItcoD1A?=
 =?us-ascii?Q?RJOsKCxzXaYEdV5CQNO6yAXV3rIwjQ4Wjd3Dm2M9U9j3+OxDnHq6OrdSHsGn?=
 =?us-ascii?Q?9WNAvI6HBRhHZQkeioM/Ll2OvxamvyfsNF/ue/RQz4iR5jbg1LgWe/RZtPGg?=
 =?us-ascii?Q?MKNnHboU9CSqaOMg9FRFSYofVWN2X1NOloaFysPrNxKZOGyImVCaOpgoLowB?=
 =?us-ascii?Q?EIi3wT7MJ7EqUw0azHIG742Mp/UTS59kOcLjdFZe5f3+90N2aVSviTX9Z/c8?=
 =?us-ascii?Q?kd8myvqbuvnx3fwfcj/bumI7Nihco4tre6yXP2GZllsIvxb0JqDEXecaiYsl?=
 =?us-ascii?Q?JAO0uMH16mD4defE/sMY0y9HWCw3M4AhOXgpAhVNohWqbRV9mnYX+wcS1A2b?=
 =?us-ascii?Q?HmvYOf5uWDTqfLdkJv/KYCer43Hp/85sPsy4QgXTbEfcR/B5pDm638uF8R4f?=
 =?us-ascii?Q?kqc6cWXXeFKyOiZl9DR1wpHRi3itXv9L1YgBolaRYT3maOUBbST9+15daBV/?=
 =?us-ascii?Q?ava2j81ZVhKndUzNZO1PCznsf3OFLp0aG+iNbYP44ZGx2HP86ZDrHq6pzKr0?=
 =?us-ascii?Q?vYkBgKBIoxlIUWDw7MsOVcWMOxLRAAEE5DsGfaNd67/zOBtlvVXdvhgImzuv?=
 =?us-ascii?Q?D3DW4usPYd1URkrIh2bFXGdav8FoSycE0NZcpPCHTDEZf+IjH+L6d7rPqn8v?=
 =?us-ascii?Q?KNArhvUmuMuYBBE9J+wffV9llC4L+1DPtjcUgjUGJHwWs1p3gA25nI30YrWl?=
 =?us-ascii?Q?AIedJR250TDp+jr+IzRkMVUZhpoHg0c8x/JBg7QXcWKdLmVNJoyv+XWFwl8f?=
 =?us-ascii?Q?2wdfhnEMStJHi4g5o2ELZnAvZ7R+9RUEAZJF0xX/OFdsOIDaxeTHLQh4w7QR?=
 =?us-ascii?Q?HMW8l0bARDLd+ttA2xKUA1FCxtR6MIXgOf/eZFx1Sy8HrmksNn5QVpU3CgPk?=
 =?us-ascii?Q?t+r+lonAjoGA7dnxqDpVyFkejyn6wpiRoM+6RYShnUh3KYnsGeLz36pYLwJ8?=
 =?us-ascii?Q?pNnImrxwfgCsh9p+f6QznmHvqfn+Ax2kbOYvCNYAfsazIPBs00vizAKtenGW?=
 =?us-ascii?Q?52FJuwY6dNaXJdP7HkeuQxQjafgfN0y34m/9nIY2baqvjcLPEXye36b257d1?=
 =?us-ascii?Q?kmPwAzCxsjbqpXdcH8xtb2D4HI7qB3VeO8IbZF+gnCm2WNeqnGnKv3gy4Dhv?=
 =?us-ascii?Q?bCQk6RxMLevN8S4cQFD/8d29CqF0h/bE34nqRGCGqJp0wiwEV56b200Gzbo6?=
 =?us-ascii?Q?IhhZ0SmhznL3uH581ZxH+OE4C3H4t38u6yfhIm4rqE5mIN3g10O+g/41hgnd?=
 =?us-ascii?Q?8CqjV9za7pc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pZd1JGnOULsWTymlMXG12ruFIu1fYIXXD2HA07MhKUipxZS9in7nzIhCotU4?=
 =?us-ascii?Q?0kFaepw1KNjr/KyoA4QYXLtjtoJJOwtLygUA7TpknMOswAuUNmDt9vKVgT15?=
 =?us-ascii?Q?fJ83uwy62nkpWUSrT4NFTZkWYrr9hRL87lnLhH90FZFM6BU3S2aM5zkdVH7q?=
 =?us-ascii?Q?LuqbcTEMFW2wYmwn2BU2FKk86Ha+8hfLY7aeefG5NqP8gckd8HTKiHkf8wHv?=
 =?us-ascii?Q?Up1ebuqPIzp9CCBiSXWnU3oWSqyYO1k3akxz4lY0i1J7iGeGjjFLsAqispKd?=
 =?us-ascii?Q?WEtNRWDMnswuG0p/XujCewa21kbZVaAVlMooY2N8NQyrm+u/ghaNX3oI0SnI?=
 =?us-ascii?Q?Gh/2GEOe6i/LwdrxKvPY/Wk/xosnZbtrYvgyv6AVLv2D43VJrvwCBKGyRv0S?=
 =?us-ascii?Q?3uMOBxtO7LQtH18T0YfrxOK71n9YyvfLlkRQucxQlwZGzKUAds9rLFcJZHnm?=
 =?us-ascii?Q?lXcNReik9Z12V66WOeV/MQRhDIocA4F7rnCVNF5Wwv+sMI0Gp//ChizyKbii?=
 =?us-ascii?Q?wOl31d7lhpnXSjuwCCJHc4BaOJ+spNGjW8NaDIYhHDaQmvszxbYn0biZi39s?=
 =?us-ascii?Q?XGIoiXWS8CLJJKVkoQIl1NeI3EwGfJ166xTzhLV5K7gDoroCSYvPPo39ByX7?=
 =?us-ascii?Q?ji64nHELPoNkNNY49H1sYRLhkOmJZS7jJqa1tewY+zwJeUUw5p+WgYUVIL2Y?=
 =?us-ascii?Q?yuNfeeEFlYQeAmwiecDOqgB2/1u3qcztPIHwJl5JjXtSBLCM6la47hZ/WBHe?=
 =?us-ascii?Q?WaQEkHnlRFYxTdpsjEabw8hLsxGik7+4+FL06J2LQGT4ENdJsJxH10OvSd9a?=
 =?us-ascii?Q?3AK6MjWXjqH6AsBnES3I+k3r8cT5aTLM2IUlLM4d4EjZ0nuqRCeJRYN71gr4?=
 =?us-ascii?Q?EcMbm0HxbGMi6o4L3E4R3/NyzFg3Fdoz6sRYfsjEha++cPPm6RUCJckm7K/a?=
 =?us-ascii?Q?pMrIYlxHauzEPbWewCt4fZqA0EYY9kwKIZcGzHGmEX9ej5CcaA+NidxkTLTu?=
 =?us-ascii?Q?sc7ZM4yzQ1qTJzv7JKCUU8IO17jOreYAB6nG4fhIr52QBfixWZ8jf/s+gHfl?=
 =?us-ascii?Q?X7H7kJfdDpaFw7a4TIVf2ZBnZMHAIatty9BftpPMc979aQVT7x3Uwvx21KH8?=
 =?us-ascii?Q?v8q9joeWmMBrkKskpuExAHvZxNk2tOJfekl1aVLngnMbaUhcKCXTf/DUOeBA?=
 =?us-ascii?Q?7oYihaIOd//kb+WNWPSornpfW8Dh/OuS4b3c4HT3qCK10yMPcCNpK3IHcyRt?=
 =?us-ascii?Q?31dDoZclNb5dBtj9FnJyTSHvPP1wXq1ifuyPNwQyRja7lcCcaSZVU7X8zDdW?=
 =?us-ascii?Q?5Z8p5aYbBF8DE/4OyNH1SxYbEP82cFcynkdqXwPACc9z5VCOiwZ3QdjQgr5c?=
 =?us-ascii?Q?jDjdI+MqxTnfjLiz8JbPDCrRuuu4Hx+N3ZMhsSpPGg4mEXu6zCeSQaGzCNP9?=
 =?us-ascii?Q?Q+aUSDeJkg027b6lHM88cFNRm+k+azVdGN0AkUgiHitwpd9rEVpxdj4sAR7k?=
 =?us-ascii?Q?ikMbYB5vr7Ho0vaGOA0i0xQUy9Vplnr4oT4g5r6yh5QXBa7DwGwOXw6hK6qt?=
 =?us-ascii?Q?FC55lFpYJyaZ0XR3BQQXBhqdkZFc/CJN2brQUHYJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cf4295-814f-49e6-2334-08dda6981b47
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 14:23:58.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ek/h7JeV1STPawrBboSb6Vx5TmjOoQGBOx7ktjViUfvv+Oos8eLdSyDYjRjVC8HXCnLa4xgSUdAVyrBZTvmWjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

On Fri, Jun 06, 2025 at 05:04:50PM +0200, Petr Machata wrote:
> @@ -600,15 +601,14 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
>  	if (at == NULL)
>  		return err;
>  
> -	tb = alloca(sizeof(*tb) * (xdesc->inner_max + 1));
> -	err = parse_rtattr_nested(tb, xdesc->inner_max, at);
> -	if (err != 0)
> -		return err;
> -
> -	if (tb[xdesc->inner_at] != NULL) {
> -		print_nl();
> -		xdesc->show_cb(tb[xdesc->inner_at]);
> +	rem = RTA_PAYLOAD(at);
> +	for (i = RTA_DATA(at); RTA_OK(i, rem); i = RTA_NEXT(i, rem)) {

Use rtattr_for_each_nested() ?

> +		if (i->rta_type == xdesc->inner_at) {
> +			print_nl();
> +			xdesc->show_cb(i);
> +		}
>  	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.49.0
> 

