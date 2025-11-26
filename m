Return-Path: <netdev+bounces-241806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BEBC887B4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 558264E120D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B8207A0B;
	Wed, 26 Nov 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NCX3Rs60"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAF4C97;
	Wed, 26 Nov 2025 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143146; cv=fail; b=RA0gzD5PN2IKznM/S3XcmqO4shdWJSZ5R12YjpLGCg25BrmEaRuNy6l6/+F7PtF55l1WNEeKJa4S/oatcmPSEGnK0wZslEOKwzqxMjuNthhP5ZYHa3UNBZWT0WouaPOpGKHCPWJck4hzjeQ/Mbzif5OtlZRWAb3gQ8VFs+gak+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143146; c=relaxed/simple;
	bh=J4MO6uqlc3/pIg+RV3TAkzSowCmRduX694lbvb/ipPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6sX4wj9SaL027rDE4x/pjdxNcd/+pi3JfOUfdTUexUL/kAqoiPVLQNh37oTea730OWIFhWa/p0aCM8jz/uFuzdCwADvaHlZthYyGCE9cAk5O5zm3L5TDElk0TLlEBXln0w/YdTM+UCIomMaf/VDgsz1EMCDm/oDBpOpxXfZ+3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NCX3Rs60; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgvplVxo6+kdN6RJLXiREVNI5Ns0uvqgRADDi6lxXSY8T05lzjgplZiuEMlMYBZfe5XlgC03AkQgtH8Fd5QLV6gGdwvaeouivYUor5JO7KFtcq0Co6mZ0eg7k5/9ZAjy93Z4eYoqNeV8ApHoMlMoOpXo/+WMfhKWgTdNef90+bY6yv4IliufyB4ijl5zJo7qMDrv/IQ4YgfcteNdvmx5o77xfJTZeQp7T+oQ2Z9lEcR8pLCaJiLTRE8VA2Xn+pdPevd4+e9JGtJcbbeWDQNC/Gt/6saPPDbbBljuRWqCc5Dh6vp77po87rb8MjGSOCzTqGxFaMFBH3V2DlaejBdl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiQsVug1eYvU7fbDliTC9A4JrR7hFSSxDZzGSVBB9gM=;
 b=jtcZn6zPfMxHXwpF7WjLkolpLTNqWME5b2QhNfQ+rzyiMY4VdGl3eItf3q/Q4TYdd/Qt8yUe0JNl7fZuwXIIfnc97Olf4YOKz9y0sLWttym7VDnolPb3/3Ok8DPF8/ffXvYfmQ2d29Ds7tNIOI/uTBOowWihYmFEsH5tXS6CEZ/NsDw87MlMz/86X/c9LOIkXFxGj5O3mOygr7jVt+4Ocw9p+Er1ImJhj9iYJPx0tayErjR1hhZZDj942s9dTOkP0mNrScI82QPnlqsGcSJeM4ioklj8IRglO8t4qmANqsYX25OkQjxwkwH56lcAC5XzqDUpGqM/cOXQNhefoyaleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiQsVug1eYvU7fbDliTC9A4JrR7hFSSxDZzGSVBB9gM=;
 b=NCX3Rs60Ke8xn+QhfgklOXHJeziCUOeJR+5nJZHIkodCUixEE+GK+y8vArsLvUx1UmdqIT8InckJt27rBpthxBwfK94h1zcDp1zvZy/bzln2y+z8L9lxmMpwrb358Svx7MnpXukTALnp/2Gao7RJOdDVGHykM3e8Q8PDfwi1I6yz+FLDZKRmqDE7pCyDceTn0O3aBGWde5RNkZcRJwPvfZbBJeV5m2sb4YcPqzAZEJX6PGDMQE9jIziNa/1I+sCeMN26qBkuQ+7Ysh0ylLnz9kMTbpByrdmP3t8Wyi67kAzL+SbrcymTcbwL+0hcaWXmglebSSyjm2c8auGAnSavnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 07:45:42 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 07:45:42 +0000
Date: Wed, 26 Nov 2025 09:45:18 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] flow_dissector: save computed hash in
 __skb_get_hash_symmetric_net()
Message-ID: <aSawDrVIMM4eHlAw@shredder>
References: <20251125181930.1192165-1-jon@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125181930.1192165-1-jon@nutanix.com>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7deab9-1c70-46e8-dce3-08de2cbfca90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0zuf/pocsfHZPyql/iucG34YPLl5qsjqt02Eixb0mcwniPHRWWITZu0O8An?=
 =?us-ascii?Q?hVcm5sQwRqGpDa9Rbn7hhnjNo1plYF37ZHISri6XO/Ij48HjCDFUUrHC1Oon?=
 =?us-ascii?Q?HUA+ADaUoJvDDY4O54l7FOQS0li5slPZB4Uuc+y9R2GIzTaq+NN7p0d18GZF?=
 =?us-ascii?Q?lGGy9zLeBwfFnns2T+NCHK3XOLNLsqen1ZL7pdtWUtyTxtXHcGtXvmJ8Pc+y?=
 =?us-ascii?Q?gG2Kt/94qdUmVfPAnnrLM1XTVhCNybxpyiB1tU/MFx/yiRrSM2y8C6rsZU1M?=
 =?us-ascii?Q?ST9N3BCUuy8aTceV8YsBPZ0Qb8T+1U8sbrjXELPRqh+n5Ntz0Xw9NSmcRgNY?=
 =?us-ascii?Q?nk1weW+5dOJsK+JD7cgND03Q+cZZ1bPSGManQHr59Q+26vQZbgHc5ABOsVOz?=
 =?us-ascii?Q?tvfcwVMifwvnxnYsydzvx980oQ04SMSXR7DFb1e+ykb48T8iJvW2ECcwjkMC?=
 =?us-ascii?Q?SorAsT7vUwTXxmDqd+yflmaGjK6TW5RcKbO+vO+hxRZNfn0E2oHCVHgO1u0P?=
 =?us-ascii?Q?pQCtnRwCfKF/oZWeUdOwkjHjjull/QGX4u8AMmQlefXnzGltP0B13kFEVCRX?=
 =?us-ascii?Q?s/MNdzERM/KjGm7uKBCwXyKFnO8MPH0skU3PMawHwnpAa5F3Q2Do6i6sOZho?=
 =?us-ascii?Q?E7kpGOt/jNPonzd/a/42zxwApPFGEidSxiw8sxCKyckwsAMZx83NquY7wVOx?=
 =?us-ascii?Q?0tC3GVMSEIvsadvjUFkdnabKCpIIITiosGcOPVp65peBvupCzAVQWYItxN4F?=
 =?us-ascii?Q?3HmwylSsTxVOF0ceEhrRr0ElbD7C8VtVE06YT7l7tbQQULArYRuwgFsxb+7s?=
 =?us-ascii?Q?N2ZXZrwNNVzq36dji1PFLT11Ihcu1np3pVpnQbsW0rQpBXiT1IGanurmG78F?=
 =?us-ascii?Q?KorpQHRLkETmBbQWGp1h1PL77cdXVgBe7LoaIhayWx20xH+/29nVNm3iMuFS?=
 =?us-ascii?Q?mwTs+kZQrVbm746DZHiuNS/obQjRZC80C4+LhT78OfZuHwxVAOzDEhSZrVmk?=
 =?us-ascii?Q?1qy7TtNsy2e80YehPz8L1LVMgV5gdRawCchuAM0zos2JBYtl6pVm/sdbFfQz?=
 =?us-ascii?Q?S7MouyAVgvFnvf3iy0p1VKbVxmXNnyWudgWO7y9YVXzE7fWSU4mpAxt3/5Fj?=
 =?us-ascii?Q?yZAmWi1Qdq+ttUioK8IT4I9Q7OMrizIfS1mxcWpBFrAS699UznNV0FRC54W5?=
 =?us-ascii?Q?jbhP6/ht+gMLOL8Sm9ZV5405xeHYas2iaCz+VTkWHPa8nkB7sYAIfvFz36OD?=
 =?us-ascii?Q?dwphcUj/yhMyK6t5+iV3Ytn7pGdK2FimsXz1UpSRoiMoUOb+UaXgUdNXUL+N?=
 =?us-ascii?Q?9v5DAIl1ZFMoT22ZQcsPpA+2VwQaJMpwd7hWX3HunCefmeLvwiPcIXseedrC?=
 =?us-ascii?Q?6MvFG1okr5vAF8sH/4sIuFLB5Ax/BB/9KfuXR8ysdYc/vXTEaWw2vpgHCMsG?=
 =?us-ascii?Q?lO65r+/5HKGXmkU3UZcSVBae6wLdsLtv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmkCMOwqSDmkB0L9nXzh6+P6lZlKshU/0uPgRgVHl03o5coN4bjwFxLlCpiT?=
 =?us-ascii?Q?GiP15QFEzBW6FOl+9LDWBLnXqORJrHQ/CyPC3NXFMSv8vIg/dHlpD9ZKnfO9?=
 =?us-ascii?Q?JaM/FZd0wGSCskBazgFO9ZHMKI1qDRX8qbcBiYNkmfi2JZA9OeugPBE/eZaT?=
 =?us-ascii?Q?197IfCPCo5TRFm+eWnzf49emghLO7GCOCDJI7jBQSJbalRzv1r5uHiiDOTxa?=
 =?us-ascii?Q?rLocgdt3vp7iAPVknDJV0RTjXf/E+pgmq/oveJzJZhZBe7vTuuPINACdqoeh?=
 =?us-ascii?Q?TglJjkC8KgtRcHTikwilNWwG1TvpUIaNrwZ0whK99coGXrkDnZpuChhnW6s5?=
 =?us-ascii?Q?C64DzGBzLfhfrJVuv1nY5PbeCV+tJ3gq/+LquZrRzGAtdvVa1kuxEBke0s7I?=
 =?us-ascii?Q?B6pDBjl2StHofxSquX+x5EcoKVxWLD3EsTwPfDdLQ1kJJ/YO9scHFO+E7Z/0?=
 =?us-ascii?Q?ljF4JH2PhnxjLqyBVR4S7/DpRRCuphOYVVeNKwxb6w85G5IydHMpVLSndnul?=
 =?us-ascii?Q?xC5wCFtxq95Ek9tS54brGHvKkz6yC3o3hDUQZhFjjhKPej/mKC6vam06voJL?=
 =?us-ascii?Q?dP8n7iAT+CuDOInnqgYtC8lqIY5iBljhi0PEDqHUitEwNWiUC+KNJBEWoF7a?=
 =?us-ascii?Q?celX1jxRwTaa9XiV9CD7OdCCkH0a8p1wuQ7XYm5ORuhu2eSjMlTxPZ/XHP+E?=
 =?us-ascii?Q?2Z2Q/916lh5ud2PYthbZKfLfxlPGFjVaZGFORHyNt2JsKPEz3HQHTA2KUnOC?=
 =?us-ascii?Q?vT8zgBv/VhnBh8dHhmnv2WJnScAZp0TqhEMfjlT4bPLDRSlyJsG1yqRC8hHb?=
 =?us-ascii?Q?8oUaqtu7UyEtetNcg9cmWDU9EGCLPtqOf+IjPdhzN4kej8kmN6P4P2N4vmkS?=
 =?us-ascii?Q?VmzURqMnLD5xERtJcX/mYp4joqWXDStmWlQk76uO9ZPdh48CY/49HxxYYFxK?=
 =?us-ascii?Q?BzFy/FFPJKRO1qfZLtK62DOw5wFzaY13okHHiJexdgJv1eHZCSWvOcSxuloT?=
 =?us-ascii?Q?8D182IXGGBmFs1QkHO0BJ4oqgK+6W7Px7s/6b6Bsad7m+8tP7YqH9LxPE1XG?=
 =?us-ascii?Q?BGwuZWN7yczZ243b3WVTfhtS+08CMkZN+Cooi4flWSf9ozEtsfxGsM5zIUXU?=
 =?us-ascii?Q?e9rbBB9ymghLQjtPzr+28e406Lr4neguE6w16Yx9S0iELP1ti4zYnSUbGzc8?=
 =?us-ascii?Q?bNYvVEgtyY93GRPlkehbBEGIFwPV+LBj34h/XGczvCFYhR48F71YJgl0X52R?=
 =?us-ascii?Q?AJHoDvPOOIwHePcJYFMYpfICn0h5Fe4WETriLbEcVnu1XOCF1wtLnwBpTHGI?=
 =?us-ascii?Q?D7Ih4jqzykEtIM+L1/GsnBInsBAXj5VIhXjNtCsLbDiuMEEWlxrBV8JOHpkq?=
 =?us-ascii?Q?y+0szRYVc84RGmPSpxXJkQTEcREWCZSaHSrU1hmspcNRacdGSbEe9sDteIxL?=
 =?us-ascii?Q?fEKg2AALap9jhKkAHWS0w/YaNvLM90xBRrArArY6A2ILHQOkGD68LylPZWeo?=
 =?us-ascii?Q?mXVEz6nDpxKbuQotoeJ/aclyKH1miRQQq/KyeNz8ea7E0OSltzJXSsvLArqn?=
 =?us-ascii?Q?6fZjpFhoeJLVCyLjYImNVLpnKH5kQPBF6mwIAiUX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7deab9-1c70-46e8-dce3-08de2cbfca90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 07:45:41.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNyEk2ZulM+TYlodzysEXVMckUHx2KN/gp3wXgxW8F2nlKdUv5IryCxqwQ+dXZK6RPl82t5oU1Xhc5WMC8E3tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260

On Tue, Nov 25, 2025 at 11:19:27AM -0700, Jon Kohler wrote:
> tun.c changed from skb_get_hash() to __skb_get_hash_symmetric() on
> commit feec084a7cf4 ("tun: use symmetric hash"), which exposes an
> overhead for OVS datapath, where ovs_dp_process_packet() has to
> calculate the hash again because __skb_get_hash_symmetric() does not
> retain the hash that it calculates.

This seems to be intentional according to commit eb70db875671 ("packet:
Use symmetric hash for PACKET_FANOUT_HASH."): "This hash does not get
installed into and override the normal skb hash, so this change has no
effect whatsoever on the rest of the stack."

> 
> Save the computed hash in __skb_get_hash_symmetric_net() so that the
> calcuation work does not go to waste.
> 
> Fixes: feec084a7cf4 ("tun: use symmetric hash")
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  include/linux/skbuff.h    | 4 ++--
>  net/core/flow_dissector.c | 7 +++++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index ff90281ddf90..f58afa49a50e 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1568,9 +1568,9 @@ __skb_set_sw_hash(struct sk_buff *skb, __u32 hash, bool is_l4)
>  	__skb_set_hash(skb, hash, true, is_l4);
>  }
>  
> -u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb);
> +u32 __skb_get_hash_symmetric_net(const struct net *net, struct sk_buff *skb);
>  
> -static inline u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
> +static inline u32 __skb_get_hash_symmetric(struct sk_buff *skb)
>  {
>  	return __skb_get_hash_symmetric_net(NULL, skb);
>  }
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 1b61bb25ba0e..4a74dcc4799c 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1864,9 +1864,10 @@ EXPORT_SYMBOL(make_flow_keys_digest);
>  
>  static struct flow_dissector flow_keys_dissector_symmetric __read_mostly;
>  
> -u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *skb)
> +u32 __skb_get_hash_symmetric_net(const struct net *net, struct sk_buff *skb)
>  {
>  	struct flow_keys keys;
> +	u32 flow_hash;
>  
>  	__flow_hash_secret_init();
>  
> @@ -1874,7 +1875,9 @@ u32 __skb_get_hash_symmetric_net(const struct net *net, const struct sk_buff *sk
>  	__skb_flow_dissect(net, skb, &flow_keys_dissector_symmetric,
>  			   &keys, NULL, 0, 0, 0, 0);
>  
> -	return __flow_hash_from_keys(&keys, &hashrnd);
> +	flow_hash = __flow_hash_from_keys(&keys, &hashrnd);
> +	__skb_set_sw_hash(skb, flow_hash, flow_keys_have_l4(&keys));
> +	return flow_hash;
>  }
>  EXPORT_SYMBOL_GPL(__skb_get_hash_symmetric_net);
>  
> -- 
> 2.43.0
> 

