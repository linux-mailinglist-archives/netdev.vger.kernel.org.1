Return-Path: <netdev+bounces-120146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392195870C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C38B282C92
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3218DF9B;
	Tue, 20 Aug 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wrlf7E9Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94E28FC;
	Tue, 20 Aug 2024 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157222; cv=fail; b=AeTfBPWuOxr5GP6XaexqIz4IP3TGvnoCzdbHF0tqUkVSswKPw+5+39/gFYaXWiiuz7/mQ9Acmy7/py9UOlAZ2lyylKDl8L6e1snRL60R2NLDNsrqtaQItwQoA/gjChS1dc076NBb3wFlcy3aIjvl0a6PW04LFZGs2+OZ6K4ZriY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157222; c=relaxed/simple;
	bh=49yfkp6ZOdhP48GFzVBKpFy7k4axh0Pd9+KynJO6aUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DMIe2W0vJutUrSdxo43lobN9UwA0d7zBjGUoPqbn5KKNHWc4hFHdXxw4sohVMSJckAf6dAtKf6ZebokRQlI+ytmhkKPl/iLVyOuxbtLADyw2eOhnA/cxUnJvUaio5/73PF8AVxRqy4gQETogHWiQksEzLZc2o8SCWbEAu8ZIQs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wrlf7E9Z; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZT6hU6kquj0xiWhYztSi/e2dvvbfukyyhUqcsnd3OyjwN6nm0hrnOhZ3EpZT/DLIBQgJwg8qQzSTWpeTOrHDN5tWR+4L1rsFKzRh/peOPGMahd7AaTSNGuHied68A0Rz9ix2B+in4Us99Fi8IY87DGjkVylFnzhdeHSH2Doum55rsQcMmtXsHgKvZvER96osXEFeOfRtE9sj1+sriHqQ+gmz94UgQz1a5jSnXVVntbjHTaWycoHoALr0ilMRnlYtQXHzvrpEfFMVLpy5DumsCdVKWzRG92QWkr+p/6fpUSNNWUxtUyLYbnczswyDCpMRfGUS9cRTsp2TWl0bL8Z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTmwRm4ejkd/w8RlHPESCvraKAsPhEWCHaV6vw0G7Ck=;
 b=mF8AAsOKHVu0TmKxKZQGV+UTyKuMfEq/4hZMAQ+mZe15y6pbE2PzNeVsLVKfSDNkJ8jw+22dApQUixfjEKDFzm7ESC2uMk6OQVrFKJXAtOBo3eiXxcliK+sSAgmBxEc/gjvWw7wwN1XkhQnOYJmKDuEAcfCcNIscmJHkoC1ao8JMUnJ7HjZ+eNqBweGbBdvX2VOt7W54TOfKhorVQQktZCuk/j/6lkqObq4WomgDgn+nNexgL7SP7YX2FSu78EjrMqM5/ZpntX8UIkhUjQqp2fYWEpuzJGMqLgz2NE0DdfJW+bWmBNYQvmltxgqNfMuJ2qny0jS5kVTnjQjYOfVoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTmwRm4ejkd/w8RlHPESCvraKAsPhEWCHaV6vw0G7Ck=;
 b=Wrlf7E9ZGYc81T7cI3UySfGVrFcny4BIN8wdlIZz7RTdSSppoie21J+SobdYsP0R+mZfJV7y/5VpzfpvZ1u8PwWogGBIiyrOdPpcHh1IfKZLHd1T388PhYBt5ZJ8Q5ZHzJwVSsxbVA9Yv89pKOEAh20YR1rxg0lW+63fx4J4n7aiPbs07NFd52g6MdK8VcvspRN618DnxOZBoV/PU3A+mgp8znROKY8NWBI/FNFgiDEZ3eyZH/mS3BEnCn4N+oyE6eJ9FwU+cIb30mW8DuggTNg4pJVG27s+TZaoc286T3e4LpVDVbXApIyiUYEAtm1FuHVuTpgdpiFlhM4p9CCKiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 12:33:36 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 12:33:36 +0000
Date: Tue, 20 Aug 2024 15:33:24 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com,
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 08/10] net: vxlan: add drop reasons support to
 vxlan_xmit_one()
Message-ID: <ZsSNFMyN-MivgkKU@shredder.mtl.com>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-9-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124302.982711-9-dongml2@chinatelecom.cn>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 39100336-ba19-4b71-9c7e-08dcc114501a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHxeJkh1m+Sn2f/ELBkjhTs3iKzK4xf8UujAQTg9wvkPPm0sPEewjcm/1Fui?=
 =?us-ascii?Q?1PrPf5jalTlzYKTGeBrpa/eMhTve8CmAu6i4x6FQs1V2Is9oporMXX1SQrf7?=
 =?us-ascii?Q?Ar8tBllnaNRFw2ubl7OrWI9FMEYQm8aW2JT3UVH2iZJlJc4auoohRcvg9Ups?=
 =?us-ascii?Q?67Ba0ZBb/NTQBzQKXrPJWy6bqlzc59UOlFL8ZVOOKSXp67Sz5EjrspUgXX3O?=
 =?us-ascii?Q?A0rjnBnhzR9IuCRAtvL+FUv0P0AAu1LpR0NHd3BVMm6aLrXG8cVNbEK7tnza?=
 =?us-ascii?Q?st2hLQ3l1+UcbMIeh95faLRc8qOFRUY64+4IQ1dMXQo590c/uYn1L/Akeh5J?=
 =?us-ascii?Q?/eZOKn5y630kL72b1CkEKbbXSWXi5YwCmwKc1E57CyOyyjadbq/vSxbiQn3t?=
 =?us-ascii?Q?5oEA5yl7KKxiCYQwFBFLjIItYUIjtSHF//xUmjQzd1joxE5qfy6IOidR6Wmh?=
 =?us-ascii?Q?ktb4S15TeX8yUpraGJSaiMOkqVDFcqoaw3VJgl+x9LB7B5+EzUhp7P0EF8JK?=
 =?us-ascii?Q?vl+oOJR3KsvuSl9GjfSa8iqqEjlk9+Zmsn9eVvzVO0SrsVN+RlkTnesaPba6?=
 =?us-ascii?Q?uGgLQdAnvBHskDr4ZSfNLfZQsNM+z3gVQRT3OrcWVk+2pnA04edsgXUonAev?=
 =?us-ascii?Q?aQBRU1UBHiN5bqzRkEdTKGJ/UYOeyL8NRQxFZ49r+4IV4raIVZol9QIHky9Z?=
 =?us-ascii?Q?8dziE9A81dACJl546ex+YQOuBX77wo2XzwFR+ERAWg2SYFgN+CWHyRtmLkMJ?=
 =?us-ascii?Q?Q4/zZHaGXgOiHKOX/DgiHQFN/7VzP4oECYZpGUVdlbjsslZBwIAx27CazDaj?=
 =?us-ascii?Q?ZkaVLr+fEWX5iaZFu/fsfTPZArMxit17ctaK72GR7iRAXwqmB/cg8O0Gb+GT?=
 =?us-ascii?Q?uo37VveHu14tBBR2uKIwmUEmXM2KSB6jVmdXicLUrGnq/JpjqTvdIP6Cmfcb?=
 =?us-ascii?Q?kck5CQq7dCKIhqWObgi9+/Gvgr2vuh/JUTbP+7fakNtBtk3+6mEz4dMxUGHj?=
 =?us-ascii?Q?CIIQdUzZ9Rmy0y31RpssOzRATSxCFy67zbjF4dfwQF4DkykzaHnRcJBi6hiA?=
 =?us-ascii?Q?+FzLElh2lImYY3IPr5ImFcbeGhy3WwW27enf4IkBL8CG8FOFSOQuioj7urG4?=
 =?us-ascii?Q?jhvSjatEXyigQOWBuNDUCaXg6Z42g2EMH5vWVnRt3T31v8x64owQei/kbT6N?=
 =?us-ascii?Q?cQSx970ct9SbnFil8d7wIec53sUAOQb4BGuTnu9rSP5yi10DhyGZZgoz/ZKm?=
 =?us-ascii?Q?gVgt6OVKqX9B1cPqXJ1kw4SMDSpI3Y8kOpzVLQRQrzfrMJr8mgyYZDQwL90v?=
 =?us-ascii?Q?cIWY7cAf0jZp1hRNlltb6Y04MQKdHleKRti/1S8UCDfg3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYP4mIGAHoFYS1fu8gQLuPaIpGjXB7ACgb/TOJd+hlRO3XPPZQJJzvgYTUeu?=
 =?us-ascii?Q?Hm54N/ydGkCnL12zJdU2Nt0efW9PazbDjQPuf0Uxsz/a65MbDXdeG9pzhTZj?=
 =?us-ascii?Q?axRE8xPNJ40ssu4RXEPcgJ/zQAx2DLngOsFNgfoUOIWsN0cTmaFEyAiZyUjZ?=
 =?us-ascii?Q?mgWC1Oqk2MR8QeDFyGAWvTWOwSvzFev04YQHdgCxrDzZP5/ozuMCYuNwPXIR?=
 =?us-ascii?Q?koQeesz1fl9zTz7Sqwmm9UROKR/XULgrfN4IYCyLcF1+0aHF6ty/Er/6frRL?=
 =?us-ascii?Q?PGEoCwuju9E4dBfg9XA/7B/RIBFmlV724Z7b8cJZ4/e82JxH46EVVGlvmH2G?=
 =?us-ascii?Q?9gGZWtIve5iwob0HKfA0gOB50FD7KGa5zd4odXVDM11WTQHVVem1lsysyYFa?=
 =?us-ascii?Q?OMlzCG11nAKp5Q5oOvsh67CON74soNMGWeMijZ01fgi4QPz4jXAzs7KHdbOW?=
 =?us-ascii?Q?/Yf8zgW8xXQ7v/UIhFsNyjZap+EtZwaR3S3UMGBbwPx11VFBn4zPEG5Pjseh?=
 =?us-ascii?Q?h6q4mVOHx8UIYrki/6ZD30BfSu38VjakEIxw0IUl69AZ93PbEKUfGq5X7rDz?=
 =?us-ascii?Q?m8qUAs9dEFGMH5sIWQP3SkCWttD7zOC+X5eaAoj9uaK+wn+F/6Jk8de636A0?=
 =?us-ascii?Q?7nmWb9XMrf20xWlJdY+binnEezv5MYlSDxies8zzUY2VLSInb1qYizL5gTp3?=
 =?us-ascii?Q?Wf1b+WdJUQM/PMod1RBuUS2jumfBezCvLFQrc6VQL012fWFcdaJF7vblz1S5?=
 =?us-ascii?Q?t/kJeENI71noIXY8psBT7wUDBFzM2tImXTbda5BwYn7No6SyuIboXODkfx8D?=
 =?us-ascii?Q?RHI3rQCboi4LMz8mZ9vQaYuhVFtX7fUGBIfWM+dp7g7pfm+ghL3eFVwaxGLi?=
 =?us-ascii?Q?e9XQV5PrOqEBMrb0zGwKsSUwHFdMsDy78n8hK99XoEVvNtekQ/oKmArthp4L?=
 =?us-ascii?Q?1tvkB/MQNVV26Twc1e5xqKb6CT+p/w1ysWVPu1z4cV/vEJSn36khBnz5z3E1?=
 =?us-ascii?Q?QO912Ukskin8CQDsitzVIWphpGzNlNZzcuj+z7QL7NS9gqQcqJTVU6bSQF/l?=
 =?us-ascii?Q?UPbb+1KO8FQ4ykekLVg2M4bH3CrBDnRgW6gZWSThrEMhakY67CjRahcHM0FH?=
 =?us-ascii?Q?Vt1zPKXxbdBF4g1/THx3Rc1wXfzxfoTDeb3NqzNtfHqbT92qFnpsHG6Co28j?=
 =?us-ascii?Q?80yeF09bjj4CRHJK72LnjJJZrel8PS25Kj8dMMmaa887VzQqQNiLdSUs0fw4?=
 =?us-ascii?Q?yWwwibaECICNuwUfwILnz0Q4kJWfpdgVJKpd7Sep2odSORC+EWzU84WGOSna?=
 =?us-ascii?Q?PHx1smlLuWBMAYpsgcHgB8b/IzKrEEPs3VT57+4Kf6zmzr4HnCT12wen6aJI?=
 =?us-ascii?Q?8MQPbdxhYVIRauQtaGLI5sLksUft4YM3cT8UTwUzQoLCx2oa9mCo8E3dBZYk?=
 =?us-ascii?Q?FV7xFL9xeW6k2RLDG4jkoc3+MYyA6ziNoEPCfXA3aFeSHXzzOcn0VUjKZ+FR?=
 =?us-ascii?Q?w8bUBr4HwjDIn7jsaLmR9PlIvgIPWlJIeOAECj/vLdWzCnBtViT3OVZiCihL?=
 =?us-ascii?Q?3AlOWYIvVd3KWRevA4ADTpRrSUetDglU0IshdPOf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39100336-ba19-4b71-9c7e-08dcc114501a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:33:36.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xJ1N1FQQeB3hRCW/U1/ZS31YoL8MTFosCjIIEcIoOhK3YEQWvT6PgVCzMtrT3BFA2D0z+rDVeSMMhvdNVI0bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

On Thu, Aug 15, 2024 at 08:43:00PM +0800, Menglong Dong wrote:
> diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> index da30cb4a9ed9..542f391b1273 100644
> --- a/drivers/net/vxlan/drop.h
> +++ b/drivers/net/vxlan/drop.h
> @@ -14,6 +14,7 @@
>  	R(VXLAN_DROP_MAC)			\
>  	R(VXLAN_DROP_TXINFO)			\
>  	R(VXLAN_DROP_REMOTE)			\
> +	R(VXLAN_DROP_REMOTE_IP)			\
>  	/* deliberate comment for trailing \ */
>  
>  enum vxlan_drop_reason {
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 22e2bf532ac3..c1bae120727f 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2375,6 +2375,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
>  	bool no_eth_encap;
>  	__be32 vni = 0;
> +	SKB_DR(reason);
>  
>  	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
>  	if (!skb_vlan_inet_prepare(skb, no_eth_encap))
> @@ -2396,6 +2397,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
>  						   default_vni, true);
>  				return;
>  			}
> +			reason = (u32)VXLAN_DROP_REMOTE_IP;

This looks quite obscure to me. I didn't know you can add 0.0.0.0 as
remote and I'm not sure what is the use case. Personally I wouldn't
bother with this reason.

>  			goto drop;
>  		}

