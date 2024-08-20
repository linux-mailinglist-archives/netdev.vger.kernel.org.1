Return-Path: <netdev+bounces-120134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0019586E0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91502B216E4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B718FC81;
	Tue, 20 Aug 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPKerGsr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4018C018;
	Tue, 20 Aug 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156833; cv=fail; b=CZI7AVF2P1BlRtGIZG1lVykuY0lU0g+vzgAxTnKVo+T3lCCopBi5Gqu+50jP6+qZAyLFqiav1UQtQ7ayOn2lmYXmJgf1E+mlRW7HXjYz9yL0f/ktz/Seo7jKQFdi9YZwxhJcpXjYh7em7OSBfbZWN1GiFaTdurSHapAAoHLJ3lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156833; c=relaxed/simple;
	bh=f/u8fh3z8FuHN0p8igDeX0KpYUyTJj8Ay72theWLpMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CyS1ie78tgQHxzlPVj6bXZzrhf1LdCkLeTXJ2T/bTiiSab/BAx70Xfi3Pa+G1Mdf3RXI33dCLEzjH1eDdWBqZ0JG1MpPhXaHvDWDcmc9zWk1SKslEzrKchOTwjRRKbuO+vc2nAsczaBJrcCZoRVnQmzc9DHQgakdKhFF+4DtD9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPKerGsr; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGdNR9l6KgNfRoI78GW8FbZ08ZrD3ZY+zNPZrvaHXTkqAQFwbbjmVsHov/eaLS2Htx+6bCmc9297jA+sOMDiewgukrakCoy3eS4L3iIZUfln7DOLX4M0/p5zS10Yx+5Tp4mSDM26wxfyv1mxlMTtAuw3OscJ0L5vpTyje7W7YWYVELwCFxqGp3kntHQtOx2dsrkk/yU+uqBfOa1hryw0eAn/MpCW6FonxQKOVLAhyoCr96ukcBBjBFWVfjQeYUNcKg9aJkp+MNWrzK8H7qQh09XZq5zwuNmA7m8H2XGBfaDdp/bEs4j2xzTZDDEDksQmnjQBT4E5YvIiyVXa3+iPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l+1+AQYHPTxp2MKhHBFa6Nlb16pOI1mD9bvUOC2QKM=;
 b=h/SFapy5keCZ3zfkOEVD5w98DavZi/pTbDVhhW24dSg6IVqM9CQWEC/1ypNVbjsW8qyqL5GA6usPcrSAMcs2Yal8kSj73OcnG6fcyb9BYN+cYatnNWmutscZSsoP1hntVqYWO9ClMl800vvztmons8Z+HbJDMTztqHeX9JybOszKXYpIguWdQtTGZTDUDA+BNDZfq+M3xgv2js07LvTdKiOB7v0FzYhevUQwq2SEpyVz80/18QtJgQVXU4RLCNR/4aiTg/HY9cYgnLe59BpVL2xpez4gWSdTEF6ApNjTFHlx9RIlmMGlAksdtVcXn04cGmpWuu4Hs9XCc834hq2sOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l+1+AQYHPTxp2MKhHBFa6Nlb16pOI1mD9bvUOC2QKM=;
 b=EPKerGsruY3EeM19hYirm2D7bSOud8Hwb1+wwKYCvDDNGOhOEdMStT3CyC++HnAc+dXRaxa8WtjqQq2qIlL4Tjmgk2X28CwcBtOUlfryl847sZ3DwkP1rCfmCep8XRd/T2T6H/nC4bI50RQWbQ5TLpsrMnyPQ0gRJYunuhS4NxlHi6Otsx305IwxuYvfPDR2u7ZvFWXTr2iiWUbv58BI/WmmYHpvl9lGvNZtOHO07/T5XsH6W+drcuntTxYWu/4AsOrMZaTn1EF6x27RnkfbVQ3tXc3pq2APd9YeICz0delEC3oSX1zV6pY4qrkBgEnBQNFh8ibsqt7k8S35Rofx8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 12:27:09 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 12:27:08 +0000
Date: Tue, 20 Aug 2024 15:26:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com,
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 06/10] net: vxlan: add skb drop reasons to
 vxlan_rcv()
Message-ID: <ZsSLj-fI5Hiy9aV-@shredder.mtl.com>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-7-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124302.982711-7-dongml2@chinatelecom.cn>
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: fc627ec6-9fe1-4ce5-ec36-08dcc11368cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gAv5mhRTOaTm0tE5oZ2s4U6fqRrxO7eNNeAoEhG3p9DRaL+YrftPTc238EhX?=
 =?us-ascii?Q?5a7zMTGh4TS6lZqoaTRAHx+ijLgyRgqC8dZQ1SfEKQK7sQzlECltzagN4ZSJ?=
 =?us-ascii?Q?hPlyt+niqpQAxj99hRhlu+0KbFQp+ViaLIBlfHrljX0hgyekAZVJPnzvHkgx?=
 =?us-ascii?Q?BaD07arNlvVBzUzvt8fu3rK70BXJWHu1DhYMD6tNJdSTSu4R/dEc9qC6Mcve?=
 =?us-ascii?Q?af7fV8l8lhcSGAVv6IxT7SHx+O37kYv43vDQflrtgRykNUMlnF11qpS4yZ4w?=
 =?us-ascii?Q?JQPxQFQa9aDchL1xIjdRLo4hEPGdF8N3yWTJh529TAn/h93naIpCz8KCpoWL?=
 =?us-ascii?Q?Lnk5bV6eHxbPtmPXKmAdptKtpwKibfBOosjNSjXMokPEwXdZYe8+AxafSQcE?=
 =?us-ascii?Q?tqXHD6wPc0tivHjLPCFMaqKdN7lnhgxTW2opRY6oV0aP2n0b5IoupNwoJ4OL?=
 =?us-ascii?Q?NQcPyWNvRerzSoCRx8NKEq+s12Ef99lw0z+ZDw5yPt2m2oz9+AeFnrPck/Kn?=
 =?us-ascii?Q?WQQmmnkbSosi8TtOE1WqzZznPwGgjjQ4QSePnp9cuSp7/k8WyuXcdFzTYOXg?=
 =?us-ascii?Q?xbuSes5wZQdC8Llif75Es49RPWEEV2ozNnyvlZoReY5FuiPxyOBj+S/77yMc?=
 =?us-ascii?Q?xG6pqi15m8526Y08kSi0maBOxz0ilQM5gNKwXS7raw5kkSfwLDn+Cd5CUoll?=
 =?us-ascii?Q?RM/SCf2xZKaTyJY/1gwV96UQhtA+N/th8iYY79u18ZIxTaRKVCh6hqo6rYtZ?=
 =?us-ascii?Q?GDOOANI/SeOXrseOPk2bBEs0qnG62M3lQuozonzwxFRH3CcDS4hQTeuuWiaG?=
 =?us-ascii?Q?MLyaXuLuAHq/T38WMX05zODhoHM0xdqk9623V//57hTjMe2UcwmJgnLXuh3T?=
 =?us-ascii?Q?ayUlhPdhr8dYcxnAeHKyyEyHrJLT20muHe2E7X12B0im4WrQ04PfVdkSQF8p?=
 =?us-ascii?Q?2VcbwEHZNqE/0jX0YIxGG1SLkbFZYNUXEvoBGjqu12Yrrxl2e7edXYWq50Ot?=
 =?us-ascii?Q?uLGypBjc6Rb0VXy5+eTWPxYAw1GpvpHlljjV3H4qzCIM1DqXM8BTFfkacd7y?=
 =?us-ascii?Q?lk4LbKC9Tsj3j/SstvEyZT91Vx1bMAykkxyoDxpS7tq0yxG7QWdp7zPyL9Rv?=
 =?us-ascii?Q?S7ir5rEJc9gME9FU1WGqz6MWVCvRHszFRKeNosvYUGqNOy+pLG8HCePbNZjH?=
 =?us-ascii?Q?xYx4k7ImsTp1xrnv8vqtYfkWL4qT/6EIk0WPzIxjdiCXKH0vcprEjliH7kNH?=
 =?us-ascii?Q?GthwS2POgspHVcKL/jFixqB7EbC2Y4qfWlGqdYeCJSUEJuvgg1Hd293x1tGM?=
 =?us-ascii?Q?HujGlCNS7hXKydwVtd70VJezEBOssfnkoVI8/dCL3uHJRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWBJtr+qBJ2uPVk5og8/lj0RgMAVRf/t1R11gozZHMeqo1H39T8R3tnnGXxJ?=
 =?us-ascii?Q?mnkCWEWPzMdzd8jaLzsOl4DX7vH/ddW60xaSNVpiphD1eJSP7Rsbz6QHDn0n?=
 =?us-ascii?Q?zEMS1TmrISXbOzrJk8i9aTc3swYI1aaT40eVP5/kCE72VzFydDsFa5xLB4Gg?=
 =?us-ascii?Q?uofLDUEbBHGAZ0CVLWbwi6zZbB2lMIR3lQb/e98JJH3/wjWGc4g5/4e567fV?=
 =?us-ascii?Q?9VZ9oI+jLnR/IeaLb8GluIc+EKs3k51VTP/0rULCq6lgMAv8nTy6C1wopi7A?=
 =?us-ascii?Q?9NWZqqa3H8l11mmhwl3KHnOA4eeUadBMJUIJl//FP9HdnaiBYWZ/Nhk1nNwr?=
 =?us-ascii?Q?jths5bOSakrIRdg+Tfv7pDRo392ddnll3llh7gr3cYB31ok8zVO58l936rMI?=
 =?us-ascii?Q?bbaKsG3Im/Qfjerrk8vePAiQRn5EMgI3/C7+mKT0Pg+2wdxqTGYo+z1bvIW1?=
 =?us-ascii?Q?ZCP7zEq289pT5I2C2fHulb7amrHMWy6BYcQnuaIvbhtF3TgkTUiClucDxE7a?=
 =?us-ascii?Q?iIWmDa0APgmtErJMOyM9xO9VAs/1nZ7jF3MfwLWFzup971T2vaqmL78Lz4Zz?=
 =?us-ascii?Q?WDstSw/Ga93hoBqvQ5wxgVuu/cYauN0ubL5HQtdVR1puuDZxKJiFmPbSRqYW?=
 =?us-ascii?Q?J7BUmpXBEFkXRJHE6WHTi4d0VgFbuDbtdzVk/KZCZecShc71nFNFegFleYaR?=
 =?us-ascii?Q?ppPuyErdIDJ9PQAlRNZLB7mhqrjL8uVdWdUAWiV3wvz6mZsoajsqM9b+Aqc8?=
 =?us-ascii?Q?vYr5kesJ5ppyKdZyUJgSfXLQXr2IdBBqWU8wMCTfDGvJSbGqZ3kguuIcAXby?=
 =?us-ascii?Q?hUSyBKJ60pkJybz8HQmFQmmTol17DZIGmxZUHPP40g1JS3frscd/85oPyO9i?=
 =?us-ascii?Q?oSLA23VD4f10SF+gL/h3IeUTDt1F9/kG4qVXhwXRpQAscm646/T9JXTsxDI7?=
 =?us-ascii?Q?NNJMNo/2qguW/WGiVMdZV34IyT7L6+xF3LnQzJrdgyG7cnmWyRxI9rFSvR25?=
 =?us-ascii?Q?DnrIQltj9HCeH90UmEGr0m0nBGKhZLUilwjrsX5DB0/Pl624qodWunAnD77I?=
 =?us-ascii?Q?S9ovKA8MU08ADriYxCN5L+gHG02ukvRHXoLp2uraccwgU0nle1JKtZVKTrNl?=
 =?us-ascii?Q?Uy2YyCZEH08jCi14M23Kc/uXk5678Ctkna8kx84j2asBMsFQNOQdvdIRwdQv?=
 =?us-ascii?Q?p8yJv7Fc8z9Ju26Ls77IvXDW5GMZ7PbRnaYD6sR0I/VOdZyPadM8Zu4EPn+v?=
 =?us-ascii?Q?jQ8Igvq4BkJo3fUDCplldc4+Ocr5x57E90haJ1PMlY9gdnPnue0fFKIFEr+V?=
 =?us-ascii?Q?H7pY4ZHCK4/HVOBLzYcwJ8eNEnpLFSvVzRQcp7PddFc35Q/Xmw7tnQLEamxW?=
 =?us-ascii?Q?wTtXlAs1ITbMrSz9fpX9As1ahSLLDG3SZTzWVETD7TCX5UuCoqqiemhG4sbm?=
 =?us-ascii?Q?nIXcrD64PBdzJ/4eA3yQVnsT4PvAn8riNqEAiFTgpqSI5bUapxDdSOrOVppF?=
 =?us-ascii?Q?F4ajZatNtNWwAS0WOWVgQQRelomrpWyH4duDr2Odfly/awvw/p2iAzIAUBbr?=
 =?us-ascii?Q?nqlOvyIaXYQ0xfcdnrixJuovM6oTRiiqiyRI8go6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc627ec6-9fe1-4ce5-ec36-08dcc11368cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:27:08.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLbvcxv1FJzFL2VwXSILNigwoMGVkt8kft3IWMNVmzopGN8fT4sRGpSJpSjET9QzZQA4ATH3/BWAwswMU3tRrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

On Thu, Aug 15, 2024 at 08:42:58PM +0800, Menglong Dong wrote:
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index e971c4785962..9a61f04bb95d 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1668,6 +1668,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
>  /* Callback from net/ipv4/udp.c to receive packets */
>  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  {
> +	enum skb_drop_reason reason = pskb_may_pull_reason(skb, VXLAN_HLEN);
>  	struct vxlan_vni_node *vninode = NULL;
>  	struct vxlan_dev *vxlan;
>  	struct vxlan_sock *vs;
> @@ -1681,7 +1682,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  	int nh;
>  
>  	/* Need UDP and VXLAN header to be present */
> -	if (!pskb_may_pull(skb, VXLAN_HLEN))
> +	if (reason != SKB_NOT_DROPPED_YET)
>  		goto drop;
>  
>  	unparsed = *vxlan_hdr(skb);
> @@ -1690,6 +1691,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
>  			   ntohl(vxlan_hdr(skb)->vx_flags),
>  			   ntohl(vxlan_hdr(skb)->vx_vni));
> +		reason = (u32)VXLAN_DROP_FLAGS;

I don't find "FLAGS" very descriptive. AFAICT the reason is used in
these two cases:

1. "I flag" is not set
2. The reserved fields are not zero

Maybe call it VXLAN_DROP_INVALID_HDR ?

And I agree with the comment about documenting these drop reasons like
in include/net/dropreason-core.h

>  		/* Return non vxlan pkt */
>  		goto drop;
>  	}
> @@ -1703,8 +1705,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
>  
>  	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
> -	if (!vxlan)
> +	if (!vxlan) {
> +		reason = (u32)VXLAN_DROP_VNI;

Same comment here. Maybe VXLAN_DROP_VNI_NOT_FOUND ?

>  		goto drop;
> +	}
>  
>  	/* For backwards compatibility, only allow reserved fields to be
>  	 * used by VXLAN extensions if explicitly requested.
> @@ -1717,12 +1721,16 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  	}
>  
>  	if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
> -				   !net_eq(vxlan->net, dev_net(vxlan->dev))))
> +				   !net_eq(vxlan->net, dev_net(vxlan->dev)))) {
> +		reason = SKB_DROP_REASON_NOMEM;
>  		goto drop;
> +	}
>  
> -	if (vs->flags & VXLAN_F_REMCSUM_RX)
> -		if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
> +	if (vs->flags & VXLAN_F_REMCSUM_RX) {
> +		reason = vxlan_remcsum(&unparsed, skb, vs->flags);
> +		if (unlikely(reason != SKB_NOT_DROPPED_YET))
>  			goto drop;
> +	}
>  
>  	if (vxlan_collect_metadata(vs)) {
>  		IP_TUNNEL_DECLARE_FLAGS(flags) = { };
> @@ -1732,8 +1740,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  		tun_dst = udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), flags,
>  					 key32_to_tunnel_id(vni), sizeof(*md));
>  
> -		if (!tun_dst)
> +		if (!tun_dst) {
> +			reason = SKB_DROP_REASON_NOMEM;
>  			goto drop;
> +		}
>  
>  		md = ip_tunnel_info_opts(&tun_dst->u.tun_info);
>  
> @@ -1757,12 +1767,15 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  		 * is more robust and provides a little more security in
>  		 * adding extensions to VXLAN.
>  		 */
> +		reason = (u32)VXLAN_DROP_FLAGS;
>  		goto drop;
>  	}
>  
>  	if (!raw_proto) {
> -		if (!vxlan_set_mac(vxlan, vs, skb, vni))
> +		if (!vxlan_set_mac(vxlan, vs, skb, vni)) {
> +			reason = (u32)VXLAN_DROP_MAC;

The function drops the packet for various reasons:

1. Source MAC is equal to the VXLAN device's MAC
2. Source MAC is invalid (all zeroes or multicast)
3. Trying to migrate a static entry or one pointing to a nexthop

They are all quite obscure so it might be fine to fold them under the
same reason, but I can't find a descriptive name.

If you split 1-2 to one reason and 3 to another, then they can become
VXLAN_DROP_INVALID_SMAC and VXLAN_DROP_ENTRY_EXISTS

>  			goto drop;
> +		}

