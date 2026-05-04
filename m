Return-Path: <netdev+bounces-283962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMKbJmXM+Gma0wIAu9opvQ
	(envelope-from <netdev+bounces-283962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:42:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C72D4C18A2
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 449663002F73
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8076C3E0C4F;
	Mon,  4 May 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ro/FQjoy"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FF37C909;
	Mon,  4 May 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912926; cv=fail; b=nVdlDDaKHwSTuNi61r25TAz0u7wk2/YBBqTpykDGhSzVIOUiSNzNgGrPyHbeDEIhKwg1fOZDjYIgYQGt/IYPPvuLG76oVeLOSMtxaPnHJtw6XrI96e5Gh1gDPnFIYxe8CWZJ7jR5SjWskpmtoZN2YqlDFn75+5GgVZn6uUGwnR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912926; c=relaxed/simple;
	bh=3fwE9ZgKO6CGGOpUMktiKZijkNmFSZnmUhjgaiFnATE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z4/vcNpITEtGkBfX/4Ux7MI0oPl7VS5GjYM8H/lsevlh4gnRMa4dAlCF/Ei965Ay/X3RX59vuLI99FedtX1fGHXDUFAG0kPOX8d7e+1pM3TTupMzRemP0Ve1bovLi8DEViOGIr1326ZvgdZeEqr00OYDqOzuz+QO6ZaLSQQgEVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ro/FQjoy; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo1W72y4AkkPxTAORCeE/d0DJYD6Z7N88wmCYz697ZjfTupcz5H5pauX5T6iUwSKDpTzN9boCptdIRu9hONfg8lUgT0Bz3nmmFuSY8AqYGKkJ1DXTzL2Yy/FJZFzsbg0J+J9AiVfAq/VWW/wVEBhFlrxVCl1MHlEZnasTtIgJ9fCWv2jushbowBr1ulB0GkoW0nJOIn8OmqwayO6PKt3ST9JOFooI4vS/aubkFZOMobWx6ra30LzcbHbZ+fh2LMNSUhUo2W26TOjyxBAfTVMcEg+6xtYdZhk4EZThhC1g1kUCbtUQ84T54UkLXlYqa5ZA64fAi1U8H+EeHHa+RV1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTl7A/nsCIb7dOB9tjegsp+Jvuc0Bf1cFhyrXq+vK20=;
 b=VNFkmPvW9pohFa2lmm6tgRL26eEqZVFWz19pXvlDZA8sV4Q+ANuBSV5G8+m75HngwQ+EdatsguZtqmz9zVKH5uRgT/m3fhs5EVEdLM1Dh0F+gqS3RjgNuY4QvjYlVQCXXJqdJPwFgHhrb00n3qd8rLt/m8CQwPXNICBxMVzQRYdTbxmsFnarh0ja7ek92Q53uWjwwCH1jscXW3RO5j97SHrhVt7kHlAvk1vHTwSmcMJu9hWRSF5F6OlRqlLuIcrOitoHROJg2haELyur2Gvq+Dsb0ND6WpZD0tkxPjI+66IHSHyiJYlExOPiyTUVj29CIdx85FAQ9kNREojhmWKh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTl7A/nsCIb7dOB9tjegsp+Jvuc0Bf1cFhyrXq+vK20=;
 b=ro/FQjoyMGMng/r41S9zqybYQ/q3e6BRx6XIl9GMVkMKAjEYuccQ2KY861I4UKtA/LR9LCQ2QspZEnP8eA2FUIUTwlA0JYytAWhdeq9ejxrI6iQEr8AkxB+PHJkxC5HZ8iOKgNMGvJPC0sw5h3ucmTThpj8hSNb5iJe4Ccm+LY2EhorxC6jhsrQMU5/9Uhj8/FquxDePuR6bnkTeve9yBVgOTg0connGe38h+zTiwWA75Qb9lx4nPHXYkUs6j2ub+j0kbPFyg6Z+XASaCUatnW0eD1qf5UqKI3o1KqXXlqie8IepP8fs4qc6S4ofte4W1MBCn9Lktm+gDc3ANdSGvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:41:59 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 16:41:59 +0000
Date: Mon, 4 May 2026 19:41:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, dsahern@kernel.org
Subject: Re: [PATCH 2/2 net] selftests: fib_tests: add temporary IPv6 address
 renewal test
Message-ID: <20260504164149.GB385401@shredder>
References: <20260503221139.3742-3-fmancera@suse.de>
 <20260503221139.3742-4-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503221139.3742-4-fmancera@suse.de>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8c6121-096b-49f4-2b98-08dea9fc0fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9T21f88nd5VSSrW+AK+wxxf40KyCAVbj/j59hZ9HnOFVAazXzQm2YeedEw/5Jz/NCza5W53eqLvOUsNJVIo3Mt+tzE5bxm5UTuoHZdAUHswgsoILOh6XEcUsoS+y65X2KtT8IpbwirSKJArjwnWTOR0ixhPwaYSnOQLspC+dnB/LFZDegYbn7TWF1wPD7ikAND511dSU5qho9bne1WZlUoQrYGP/zn98ODnHn7AXm2ouX3l3HMfY057XJJGZTFg2OWplhn2Wkb2M9sniQ/O37P+lp+jhfvGBfrp3ZkNbjZ1QH7pht1VVNeX/HmWUq/9k0wyBTg/vC7LNb7tpP82fw4xMk/sT6lmW6Wd7EF7k2MX3GoECG+ZLp+WRUp7tfhMNEieOA85RCdKCOqxd+Vrd52x+Y9z5yqk1vRvBu9lFF1P1aVQ6qtfhCtpeMFsBPyGTtTg3cLZ84EW2s2iwJOFBLLVeIKUk9CrDnZYXm2IZcYrJLGJVQWURb35BiHFzUzwceZ7blziShRmjG349EaYty7/jHRUzgvugY4TlB0ARhCZyM5typMBWpKM0hh9wlHlQmkNYAXJwYG71HFl0wWlkRObEAwsgY9IANqEneEy+D0izQHg3M/QBAZLEkJaet9ECB8LViUAKbp2rabd3S+tr+wqoKTc0/OBBID1Ujon2gaxSoVth99cbGmoGWDMJrZdH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7FB1rwzJIVFeJU2dvqshHpiH9Qy5psNfCyWkfLqNraotWBzP7ovnFUtoYsA?=
 =?us-ascii?Q?OwFR8zyrsBpMN39h5pHunvzUqA+j9+DrQnbDjP9M+KONYkV5iGoEpFz+GMQO?=
 =?us-ascii?Q?ab29UqXjXpLpSpnIaERWsY7uX04/2QlYFmo2wCqTSfny8jDr0fQNzjEwCa+s?=
 =?us-ascii?Q?h/u7Jt/XpV7VAKfsLbwPP6baUKdTOQ6mc/+RfUB0mj4LUhcZXA4/hDo/qnUY?=
 =?us-ascii?Q?rwyvYTzX3fPzKrtmYwASovwJlPzqDNKPYdt2rWD6E6PNWdXNU36wd0B9yBG6?=
 =?us-ascii?Q?tym11iX7xQziqumaFIy89qK4CfO8L87mcenLz2ggAVCdnu0tGDbzBD8sCOTy?=
 =?us-ascii?Q?SN+V+wdsTXtNLSMStTWlnPrCK5u64vT1+QDJFS4EO0BeDy+8NHu0eE8CsG1g?=
 =?us-ascii?Q?MD4QQSRx0RlkT+3hb4mAqpclZdfNll4QdrnGzim4ppBXKTjWsdQDpHInqZts?=
 =?us-ascii?Q?G4Ee1dnTRDVv4V1XlM0TC/s58AufQCkyj7iBmklsmQoTyLID/6OIi1Dxk6yk?=
 =?us-ascii?Q?Pw1A6yeH1XZaJH6GNbL6Y0g3n4AiMDzWNRF+JCtk3XTg2sJadPkz8L8GM2ky?=
 =?us-ascii?Q?t4Edt7+IW+Z8OpFWLj48Pi+rS1iWPdrRCIAjpbbvBgRu3KQ9SYFwXsDjQIkq?=
 =?us-ascii?Q?t+xOwzMQCTSZAY7JkhTdRUHZoOHq1IWPhsYLn7VYFX92Ym/g8MdUcDcU6/ej?=
 =?us-ascii?Q?9BiTsFRy0W3gc8zsg0jS0dcxf275wUq5HZZp9F/buiXrJHIMRRlmeyXeon2H?=
 =?us-ascii?Q?412o/a8mvTiob9AG8pdB3wsTMKXVejYTIkKDmTzHlUUl6PqXRFqspofHCaM0?=
 =?us-ascii?Q?Xw+27XY3FrudReegi3brNAYd72Ae3yC0Tfu282ELTP45AOMR2Uav25je6/1B?=
 =?us-ascii?Q?06vfqYmhAipoqplh3xT5DDt9ctgAPWBOrdFOPIR/0ZLN89RdNLpfnCas2p+N?=
 =?us-ascii?Q?WnnXa2e84OpivajH4aB5tX8JeGrS+U1EXCt3b7getxXXXX35stwpJyAHuu+9?=
 =?us-ascii?Q?fZdiCQ5lDvYOLPAHdwjtASYKk0NUkxa8BfbtfmGwFoWj5FWgcE9YNGNDFkGc?=
 =?us-ascii?Q?IAKQoCqLUPGll6eTqh9bWtW3wbR8x9IaItD4nEMfsAugqoykhtGn+WOWi/ZL?=
 =?us-ascii?Q?LPdvrIl+pH9iSCsno6miymN7sxOI9IBbhWddTmYXOwTw27ovdwoFlvnhSePa?=
 =?us-ascii?Q?VncphVmdrpzycJ29ksoQ16PqgKaRCqMznlwBxsl0jL0hPFfnsk6SPhSV7P7k?=
 =?us-ascii?Q?+bYmGFJdeTUpEfSSUq6MkG7W2MSdgR0oF1RKZUpj7qbLyDrjJfFBvaksSMEb?=
 =?us-ascii?Q?RsSneGLweQ2gfCA9hhEl79IRgyTyQsMU9deqCcF6iF00MwG0v6ZKvLKdNwxn?=
 =?us-ascii?Q?EB/7h7VXnQtBgLXybEY7ZdteRjjqRNyYMZ/WQW5tj+MY5uxEtX7Ri8RaiXLF?=
 =?us-ascii?Q?CL09aES7j6SgJTeMvNOh7uwWJF46FKSGJiUxIjHoCd5nhZYpeLku0xKbZEMJ?=
 =?us-ascii?Q?V4ouMdMw99UAvDqO5trLnrTDIHXLb0a53Ez8lW2v1aBgEajBpLhfWsKQQMRO?=
 =?us-ascii?Q?WK4lX1NtlYaJrXJi1cmHDNTSQZoDQzNFOB8FZKTV0WZJhNRIOVtoCtD6RV5K?=
 =?us-ascii?Q?izyZZXOWxuIEFaXQ9xMtLslhKRv8VrbrLTLqCQTkiWMnrZA3Hy3NB1c6gI4T?=
 =?us-ascii?Q?QO9tSIFzDGA5ZGMEdZpIvRATWE9lpPBiqDCb2brBLqTwgmfG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8c6121-096b-49f4-2b98-08dea9fc0fab
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:41:59.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8VTmxr118HTXSNetcy/ncBvFRRE1KolRnCFXWqZ+t0y7V6alqs5Hggo47xsxPkdlXryK+KxzJcKerHLLG0P1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
X-Rspamd-Queue-Id: 8C72D4C18A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283962-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]

On Mon, May 04, 2026 at 12:11:41AM +0200, Fernando Fernandez Mancera wrote:
> Add a test to check that temporary IPv6 address is regenerated properly
> after the base prefix is deprecated and restored.
> 
> Fib6 temporary address renewal test
>     TEST: IPv6 temporary address cleanly deprecated and regenerated     [ OK ]

Thanks for the test, but I reverted the fix and it still passes :(

> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 55 +++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> index af64f93bb2e1..6a6e545cb40d 100755
> --- a/tools/testing/selftests/net/fib_tests.sh
> +++ b/tools/testing/selftests/net/fib_tests.sh
> @@ -12,7 +12,7 @@ TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
>         ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
>         ipv6_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test \
>         ipv4_mpath_list ipv6_mpath_list ipv4_mpath_balance ipv6_mpath_balance \
> -       ipv4_mpath_balance_preferred fib6_ra_to_static"
> +       ipv4_mpath_balance_preferred fib6_ra_to_static fib6_temp_addr_renewal"
>  
>  VERBOSE=0
>  PAUSE_ON_FAIL=no
> @@ -1611,6 +1611,58 @@ fib6_ra_to_static()
>  	cleanup &> /dev/null
>  }
>  
> +fib6_temp_addr_renewal() {
> +	setup
> +
> +	echo
> +	echo "Fib6 temporary address renewal test"
> +	set -e
> +
> +	# ra6 is required for the test. (ipv6toolkit)
> +	if [ ! -x "$(command -v ra6)" ]; then
> +	    echo "SKIP: ra6 not found."
> +	    set +e
> +	    cleanup &> /dev/null
> +	    return
> +	fi
> +
> +	# Create a pair of veth devices to send a RA message from one
> +	# device to another.
> +	$IP link add veth1 type veth peer name veth2
> +	$IP link set dev veth1 up
> +	$IP link set dev veth2 up
> +
> +	# Make veth1 ready to receive RA messages.
> +	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.accept_ra=2
> +	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.use_tempaddr=2
> +	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.temp_prefered_lft=15
> +	$NS_EXEC sysctl -wq net.ipv6.conf.veth1.max_desync_factor=0
> +
> +	# Send a RA message with a prefix from veth2.
> +	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#3600 -e
> +	sleep 2
> +
> +	# Deprecate it
> +	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#0 -e
> +	sleep 2
> +
> +	# Restore it
> +	$NS_EXEC ra6 -i veth2 -s fe80::1 -d ff02::1 -P 2001:12::/64\#LA\#3600\#3600 -e
> +
> +	ret=1
> +	for i in $(seq 1 25); do
> +		sleep 1
> +		num_dep="$($IP -6 addr | grep -c "temporary deprecated" || true)"
> +		num_tot="$($IP -6 addr | grep -c "temporary" || true)"
> +
> +		if [ "$num_dep" -eq 1 ] && [ "$num_tot" -ge 2 ]; then
> +			ret=0
> +			break
> +		fi
> +	done
> +	log_test "$ret" 0 "IPv6 temporary address cleanly deprecated and regenerated"

Missing:

set +e

cleanup &> /dev/null

Like in fib6_ra_to_static() and the skip path?

> +}
> +
>  # add route for a prefix, flushing any existing routes first
>  # expected to be the first step of a test
>  add_route()
> @@ -3002,6 +3054,7 @@ do
>  	ipv6_mpath_balance)		ipv6_mpath_balance_test;;
>  	ipv4_mpath_balance_preferred)	ipv4_mpath_balance_preferred_test;;
>  	fib6_ra_to_static)		fib6_ra_to_static;;
> +	fib6_temp_addr_renewal)		fib6_temp_addr_renewal;;
>  
>  	help) echo "Test names: $TESTS"; exit 0;;
>  	esac
> -- 
> 2.53.0
> 

