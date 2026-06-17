Return-Path: <netdev+bounces-300049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nh/FM/8/Mmr8xQUAu9opvQ
	(envelope-from <netdev+bounces-300049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:34:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42834696E01
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:34:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=qbMgmZg1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300049-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300049-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42D58301CC0F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503393AFD01;
	Wed, 17 Jun 2026 06:34:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB34368D42
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:34:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678076; cv=fail; b=VQlbu7sc9vhUXZzjM9Kem7T5GkBXCoRomvsuUlXTtF9eFK2hG/zGXuszrJsmaKKiWqsbnilVJuG1lVb9okw1scLCnnjYgeZxGFjyPR+tXxgr7P7w/oYKgAYj2Pj/Z+KnfeUyEG9o2NKDefU71T//2mcsEz86wQZ934xvKg5QQFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678076; c=relaxed/simple;
	bh=jAHDZzDuuRj6KJ73vh42VViX6bQYQ8v1SzLo7KO0rXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a4wryUUsLNfJnd6kx7McacTVjYu29hPRTNB+ca0Q6OPZ7JNaEuPSXmoFFNPuwxlvQFlBbfn9JGSkquzFrkzHgWJtt+kTiea3nNNuQYMjaCGkVsl+oXYbkWo9OSJzK31h1FVFf4rhgMYOXTgI9zUpHRXDYuoiWodDOSuOik5Yc3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qbMgmZg1; arc=fail smtp.client-ip=40.107.208.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLS2WIkNj3K4lkRg0xIBG2OBSVZPT7oqZ4fMr9G7AcChDbcbVaa/b1CSjGDOkQOu2n/7hswsgf6hMOlHSEXwyA6FJJXdgApMZCQP7uAewNEQfyoc13aPnuxuR1AC5Xth/N4sgs0lbvBFpMekn3mOZILEuL/gV7/tCEBxwZYGQfzLHarKCOPHfVo4h5w3Kdt7gvB4XnA1EGkDYhLvgSHkqFmZ73iqTPdRA4TOt6OtCPHO1+xYgdOfJ3dS+u2PP1ZTxIFXeYL3qo8rreKnd2HIb35mX+Bvol6uu/nPZc/mVh3/aeJggF/f53jtdgrE+N85Nh6stubJOZwazU55t0zxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3rz6uGFSy1D9LJj3XUdhCoRav8pXwBZS+nxMrEoNyg=;
 b=LaD1x6OAd/beG4VjvI4LXVwfsHkGqx5k/8PJhV+lKeccMRUC/VLVSD9IUXKEEaChP/s8qJzBjqNf2Ci6Z95eOlQKF3x0cy4U2eFi6qrBfOLuKyo5rApZ/zJYyzqT+EqdVVCd3nSem+XYXoy4bhlYlRl1LzG+TB2STd5gCX+q2x2QIhvY5qF/QXfrK9/0otxU8yn1N5CYL0VrrX1VobwsXzGXpT09sUiObSbVNZX7TS2COmROP7DMwZnNsTe/5ewlldL+kARco2oHSPXUSK14iYwlu/EoZhjM01QFdsVJjwPU1F416FXsWtrPJ0koUbmOrrg0sWbPW+toW6wMrjao/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3rz6uGFSy1D9LJj3XUdhCoRav8pXwBZS+nxMrEoNyg=;
 b=qbMgmZg143KitVtZaraYY1Dh0v+Z5kRSZG5LNArhbyI8HwvQahqaKRzokvWgFfrn5zaCwrdnOFeVdX1+GWQiUyj7YocE4fClwE2nbsPNh4T+iF+kG9lDpa1hQJ0P0tJaJpOUVtZDqWkBy8vAJKYRW4bYz0jRpYb0HQpwTwjMhAp+zGnbBtLOQTz/iYx1DdEQwr6Q9x2jD+bC0eu7JHjIq/N1aHvG3rlsw01zJsmSiMUiBIJNGF7LS+E5YYCXbY/Im5IBQK6wbwCR455PX6YdKU59QTpliJctFT2g6fFMAZo7HxB8Be7x1euCBNgnHrlDTpXZnTKfXUh5qxLABz9PEQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 06:34:31 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 06:34:31 +0000
Date: Wed, 17 Jun 2026 09:34:21 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] gre: fix ERSPAN o_flags race/corruption in xmit
 and fill_info
Message-ID: <20260617063421.GA948096@shredder>
References: <20260615140333.3161072-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615140333.3161072-1-edumazet@google.com>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: d00d207d-2465-496c-2560-08decc3a7cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	QhnKz8/VWlWEpQOpPQyilVhOQIBB4gkv8ECM8cH5zaTndwSX4JfQuGpComof4svlSfVyW31GsdNKDqjZYU5FYAjP3/GSS7dbHKM+vIK4qZAo1D6hvoU7OK0rYXite3psUonmB/gVwohX0qBpzfsX5wvN6VsbaI1nYtUxSDWTQpA4QNU/PUrJ/+58dIKG7yKJju1QhgvTNva3S+5Zi9KfZUEdWnnhMBd4AjOoUZ4StNmr9UiX68TcrOCXxmMcxsS1+Pej5QYqepqcYT1cL8wXABdB+3VYFo4ForfMaNJHcpKbexgB2FpdFXd7AtXT1+1E6XdGN+0ojYckZSKtlSYV6LZdcGWuLZNt/RUDjpckvwTbD/1I8FG2xz4tTScOXIrkzCTfnRXGFXNis4A/6qSgFAatspMC5Xoy46XPKdkOs6ankw3fVwkdUiqfGSawCEcs1gQHsLq05fQKLpHS9TM8kmFsiU+QWUoHMaQUKCu9S/9zDTu0JnBYuVXk+/h6jEPgU8IEBxP7rKYLlAGFy9LgVxpQJtuTS11L/zGAsR5stq8xDKF2QFTK2sYZx9wlezQ0NV3ssOW/xLexDdyHacUaz+PsbXI1wK+1MXHq9uX7s1N973cB9wtCdXoDdtPF2QfVMjxdQd+1tSEMN3bpmm1TfS6Wm7CH7AgTY/aov+Clc5HRjmPyM1/WXV4caVv2M3qt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eT2DY5nk1h9LNGRNkyAyWn/EavlKrsj9MbNZ6/r+rSB8s9nwlTHqXgilHDob?=
 =?us-ascii?Q?6VPKh5+LM/0CuAGexD/z3LAtsCxBnLvivu4zJ/P8FugZA2ASK8hHYv2GspQI?=
 =?us-ascii?Q?5R/I5+Z7jIBrOnrEei2VfmAiLjLnMgntUkKkw6sRGG3zheryFZw1Rr+TJyt5?=
 =?us-ascii?Q?SOrIKT08DOWnd9hJ6elCOl2ZKwi3IJy8GT28VoeUaU4QcXg8ul2maUVSuOja?=
 =?us-ascii?Q?edol2sXjGRfW7vxc4naD/RbCEwOEIliHixIzgH6nwTkS3oSbwvdO3HkNp/qF?=
 =?us-ascii?Q?bjtI6niKpx6+vLK8qSawzF2rR/dhgrr9q+HQ/rOwbVXzm8sB1dO5/A0233yK?=
 =?us-ascii?Q?QdSbbj0OOOmNFtgXAONy3OcLOvEcsK+g6oDe5Ebuzs0wwe8xFF9a3Nh6+1SC?=
 =?us-ascii?Q?Fj1ZvXtGzUysDvykDg6TibPOJmd/SBr170CFO88zUkf+E4c1GupV0XBVZT9R?=
 =?us-ascii?Q?xWOft/oOvnQeq/igvlo8vqprBfXLBjfGNdr+1yQFsZ3YjvUpFYH5hIU/rlAW?=
 =?us-ascii?Q?2FuuzXlaimQ/aoQSV4+grB1BPqBi6tQp80KbJh8PfFdnypmBeFgLK5f4Hwmu?=
 =?us-ascii?Q?zTWgTyPuCI9ZUGeVXePfL0nMZYlOUvnHLb8g+guIqSbiX3Zqt0hJrsfPpq9D?=
 =?us-ascii?Q?ybG+2PGZ48xSGhm+Gip1v3IAIGd1F561G4KPS+2DrrMDVrljxR3fo8MqHFxI?=
 =?us-ascii?Q?I8e+pbXir5qSOsIgxESICbqJcq/FAnYpInV8ZhhJnnYHCsuv/b2cvEDwnSuO?=
 =?us-ascii?Q?5337ghArjHdVwUThkLarPzNprvkwFwCPKYI0OG0lgqdA9YD5Twe1OGoZrRx7?=
 =?us-ascii?Q?SPokRPmMPhzkdt8nMBfnbhXDaICxOq6DgtLa9wNWCCnnGsDaixiQKejiLjef?=
 =?us-ascii?Q?FlLXM+2S8u657Ac/11EBqtZVRi/TUzGVwzyw7toAyUvD0HiHb8uupRWhvFT5?=
 =?us-ascii?Q?DIKep+rxfqVqic327OPQ1th5rN+LxMO0SheB5s66ozKJz/GJWCyuV8vK/rph?=
 =?us-ascii?Q?YjhHfI6ICeOjMsSoSNhfdfvxSw05QpXq4o8W19yLP/uxpAPIF0nov5aGqT5Z?=
 =?us-ascii?Q?K8pex4opyMDU427483kWvbQHjcvSJMnCgR8lcXW18acM8mt8kdtDEDLqRrjO?=
 =?us-ascii?Q?Ce2CHZb9hrkQUo1wR0O8Bll73EBxwCFEk0jLzIyFBzNR9InSyPz2GNiWimgL?=
 =?us-ascii?Q?ppuUZvo+e9+tAwkAhDXlJSujuIuEDmwQ5kwwmwAii4S5S7hro9iGjDNFoGFi?=
 =?us-ascii?Q?U0QdNU3BQ6XmNyijgwKExhy/aRGF6wELHgyRMinfDls57CTALA9PyqaDuGFY?=
 =?us-ascii?Q?Ef4esaCPixDQ6h5WYDl/TIDGcAT2QBWzkXb2VuVg4ngWS7GGDdpnSHS5uMNP?=
 =?us-ascii?Q?c1TkGvlUHCm80U8ncdblm8w+fv1zcHE8k5vU+nuSH5aZWQBggYGUO8sxT9lO?=
 =?us-ascii?Q?TkGufPCmAEFlzPqVNfvFCDXyuchagGz8M2xTtxnpP3sxHDpJT3vlqGD+SyQP?=
 =?us-ascii?Q?vLQHF/w3NKwVo2khwhrik3d/XLlq3z7+jBOR4pjeEQnvmBoUWw6roqi46bAe?=
 =?us-ascii?Q?qP+1SsBOYLKNykwgf0BP4GkGwXh9/E8dN/q0olr9zxl0zvsXriXGlbMeIaOd?=
 =?us-ascii?Q?j9LL7E9MStbdqMxkWSNdWucX9jXC6I67Pl+gUq/AYZh9A3AOOxtSqrR3+V8i?=
 =?us-ascii?Q?Qz1EZU2OJFSxA0jCFOQVJTCkwTU0QHE3nIa3tuor7bVxeBvs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00d207d-2465-496c-2560-08decc3a7cd8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:34:31.0670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OM1JsaZI6R4hpjq1zn1uS0ssttQFcs2Yq0dJVs8yFM9gXhI4e69RY3eXHdQ1q+LD5ydum0H179kxC3qHN5gUhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-300049-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42834696E01

On Mon, Jun 15, 2026 at 02:03:33PM +0000, Eric Dumazet wrote:
> @@ -692,7 +689,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>  					      tunnel->parms.o_flags)))
>  		goto free_skb;
>  
> -	__gre_xmit(skb, dev, tnl_params, skb->protocol);
> +	__gre_xmit(skb, dev, tnl_params, skb->protocol, tunnel->parms.o_flags);
>  	return NETDEV_TX_OK;
>  
>  free_skb:
> @@ -705,6 +702,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
>  			       struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
> +	IP_TUNNEL_DECLARE_FLAGS(flags);
>  	bool truncate = false;
>  	__be16 proto;
>  
> @@ -728,10 +726,12 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
>  		truncate = true;
>  	}
>  
> +	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
> +
>  	/* Push ERSPAN header */
>  	if (tunnel->erspan_ver == 0) {
>  		proto = htons(ETH_P_ERSPAN);
> -		__clear_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags);
> +		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
>  	} else if (tunnel->erspan_ver == 1) {
>  		erspan_build_header(skb, ntohl(tunnel->parms.o_key),
>  				    tunnel->index,
> @@ -746,8 +746,8 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
>  		goto free_skb;
>  	}
>  
> -	__clear_bit(IP_TUNNEL_KEY_BIT, tunnel->parms.o_flags);
> -	__gre_xmit(skb, dev, &tunnel->parms.iph, proto);
> +	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
> +	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
>  	return NETDEV_TX_OK;
>  
>  free_skb:
> @@ -776,7 +776,7 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
>  	if (skb_cow_head(skb, dev->needed_headroom))
>  		goto free_skb;
>  
> -	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB));
> +	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB), tunnel->parms.o_flags);

Eric, did you see the feedback from Sashiko [1]?

WDYT about aligning ipgre and gretap with erspan and passing a copy of
the output flags to __gre_xmit() instead of passing
'tunnel->parms.o_flags' directly?

The mismatch between the output flags and the tunnel header length is a
different issue (pre-existing).

[1] https://sashiko.dev/#/patchset/20260615140333.3161072-1-edumazet%40google.com

>  	return NETDEV_TX_OK;
>  
>  free_skb:

