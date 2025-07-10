Return-Path: <netdev+bounces-205761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2806B00099
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814503BCCCF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE7230D1E;
	Thu, 10 Jul 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ImCndSMS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE31E25F8
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147153; cv=fail; b=LK0WJ0xG1aufFcW5RInyz8Gv13ZF9U0g3m1A2Ogu6VzMQ5E6KPqcBI/rV91WrDs2L+Ib8YV4KufuTZI4UO+JKLhTGDfo/dAPPz1h/8e41iBkCG+CLxJt5dkIZvpwtsjt5bmXMDINByM3XLjc83E8lCJ9VeUSv8FbfGIBkBOy/H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147153; c=relaxed/simple;
	bh=ajJf3ZLJTPYFqSJ2/RJx9YAP25MWO431mCCbp6yQoKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JGIlC1YjYJVjUamNxiRnTxQM9od5xVE9PIMeos2vv/7dDhWwjixlkSo2Dxi4r4t+Y0v7xlPvNDG30++OzCmwdElN+YfmZEXJ9SAZSCr1q7+LIZ9Q0tjjQPnv2GU0enweR74QDpnvdkKhRWwWkUgVw2TJIbh/ASjbDERZ88M3ncY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ImCndSMS; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwvlTiMIg/HTH8gVTQyW+03oK6TE8WHc6ABj2WOEk9K2+1r8r/vakejhmpw6nB26yTW6S/vChFhyWfnBOaz9rScgvkRvV77YeShYeVAskBm5kBDj25Q76/atxqkQHF3vuOgdMEfOvcj/pLGMpYYAeypCf8tCM3V17zDeAToMr4Xwoen3kZK7wJLb2T9dFBDKBrB9toGMQoM72z/IZdcnQP00ioBKhCp2LIr/gBURIozXHLuepuTl6NvzxR74HgA92J9Rqz2wq5J5YThG+cf1d/qmlXzeomtegcRqjz25qtmz74YvncvJn5L6iED2mZUJntMhhChacjiTBTc1sDFfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGQYLzWu+5TkEc7ECYGNBmutalZfoW44y3Rpqmk0ssE=;
 b=RJ/Nqm7MI0dSihPm0bL2BUbvDiF0dper9SELnC6tqTHaKTNwFdjBVtJWjCGszMqXszsMXVEQRZUn64T94IDQRrrde58proydZjvZYkIMqe8pwASpRhvPzvyz90O9a/I7TylCzL4rO8VTKdCB5BTM1TjxqBnD5zdbebQx2RevWXFKGmstIHqijLE3CbVZEW87fsqZWPZKXepqnKT6ESHBmUAFMK1FeFFuz10PzUstO9kPxPKSHZ/t6xf1Gm5MH/oOCllxuZF+idGYogrI9SnfnU+PMDRlSMY8mni2SynGUPt/tj9vjE4VBuCZM2rrlDv5pt2xELImDDIsf+GSCZyu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGQYLzWu+5TkEc7ECYGNBmutalZfoW44y3Rpqmk0ssE=;
 b=ImCndSMSbcUgoL6vbB5pYK78/4QMixGSjPJ3irX5UJW+2hrvVXbVZvWc44+a+8aV/jaKTsz0G0MKfpfjPQMhNsluf6J5DNEvDPE0cvolqp3Yp0pyR4iWRrhvN4SHx/q1BuDv4VBIw9MhHdCg9ntUOTzG4taeJX99XHhrEdwD6q+P9vDzlK4cxMJgLSbKtoEZ+5rZTVf1Hc+FIvErn03WXUtTrDZhVBbS3c20oCugto/TladjlORqp6P9g2v4nmbPAAATWrxEzt/5T0SIa6FMjarVYLMNiRFaxOLbWEqEWCDK6gKQbjXovpXf3PJMofigkXLDN8lXUoUzwBBSrzp/5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 11:32:28 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 11:32:28 +0000
Date: Thu, 10 Jul 2025 14:32:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Aiden Yang <ling@moedove.com>,
	Gary Guo <gary@kernel.org>
Subject: Re: [PATCH net 1/2] gre: Fix IPv6 multicast route creation.
Message-ID: <aG-kvpukHVmTZqy9@shredder>
References: <cover.1752070620.git.gnault@redhat.com>
 <027a923dcb550ad115e6d93ee8bb7d310378bd01.1752070620.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027a923dcb550ad115e6d93ee8bb7d310378bd01.1752070620.git.gnault@redhat.com>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e27b8e-7458-4f88-0d91-08ddbfa57330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PqColw994tvevVdyFhjiZhDu7gQijNmYApq6Febd8a/L9XvEtZZ4YRc9L/xZ?=
 =?us-ascii?Q?cPfmla0hPpqHNTIuix05ttHaec5C+r5niE/O1nqcYhuSwsA2LFOiis54hKGH?=
 =?us-ascii?Q?+MJRjBWwSZcFE46b3WO40mapFu1bulNhQVGZKRMaUUIqH73H7bPTIZbFRvqu?=
 =?us-ascii?Q?eb5Bl9cBOoVxLrDf6TwGb6wY+kktLm/kamhSnB92ti/dEsC1k25a+7FIA7db?=
 =?us-ascii?Q?60aUnjQewmhCXD4KniLfzoxbUKDm1uvQR455a0IjrMLDF5cztNBE1KFF6BOY?=
 =?us-ascii?Q?Csj8IkMmYg3kddDjpAqIBM9+9TrI1I+CcCv+qSsIYJzNGdFalKA0hphCgxbx?=
 =?us-ascii?Q?42xwl23XphNmtxINaax5ThSYrwQeFJzIEuQ0py3MObCtAPzBBDwAsRv/XIeK?=
 =?us-ascii?Q?fBtzHOLFY1cApqbpwdbMQ/0ib7/Q4HTDnzhNHAWpxFnlEV6DjfPfz36h0r//?=
 =?us-ascii?Q?aT5wam98F+i/UbdGZU8h4xzQFodSm8gcVat4nGim59VpvtOGTOrK47FEY4os?=
 =?us-ascii?Q?psKv4BRPHOEuKKQLuuJVCtdfF29hdNswJ3XpDX58xW49PUyAPa2FXqIcwYdb?=
 =?us-ascii?Q?VTil9Xmzfm4AGV2I1HRo3w/Fz8LaE2e2o9kWA5uO+mCjUdYYyRciupSW54AJ?=
 =?us-ascii?Q?a9rcuL9KsI326QHscBEVoHE8C7w/U4VFqowHDCt7gFO8T8nynty4UJeWaO4y?=
 =?us-ascii?Q?u3tj3Z0CN6F1KGzZl/UtWaFYlr0o60Y5PcQzGFrBmLt5Vm8tbd9h4Qqda5i5?=
 =?us-ascii?Q?GjqGysM3ihI7JRLf8BPkofuLBGIJIMxBhO1cWE+XlnUvDcuggydbb5hYgOWd?=
 =?us-ascii?Q?fWo+Vrcwaw9sHDiiIi1TIjMZiGeeafUYF1VdGzYdIrPVj6FmLV8b32SVfTVt?=
 =?us-ascii?Q?6kYqh98BodN4px8t+u+MCPn+bAuAbjEZLR0uakgfCCXeIGJB9g+gqixl4L/7?=
 =?us-ascii?Q?qdGFZSUa3zAIwRjC/8v1VDckaTJazM7XVvRmUgeURc3HEjg4L+AIiXalz8Fq?=
 =?us-ascii?Q?uIS//98xcWkHzKpON9HnX7jw4Y7kFfzDTFdtdK3x3J2YCKX6vVl3h9x5S/rH?=
 =?us-ascii?Q?cEIPlaBkla1SVU7qvdqE9uX2V49LDz6aVH/DBntpB85m5w/pgQ8YcKHze+vp?=
 =?us-ascii?Q?53DszS/fNrx6ObXxP/5QDPW8f3gKi3K4NzCYZs6+H9d6sbeSS1AyXGYL1Wqp?=
 =?us-ascii?Q?uOcl1bbgRExWUBAo8B7M8K7Klwe8uqixmKEWO0sReJtN9xBZFO1x34gssTxs?=
 =?us-ascii?Q?vvDuUfC5wEuKaP5Sftc+8WldNHEtCcGkvFqsN+j2oVLJM/HQ6Hod+LeTOUQG?=
 =?us-ascii?Q?G2Rmmz05hoIb0ibzUiHhP0UIciIPPc8peoEPYFNr9PxroipbpSp1ghby7bJt?=
 =?us-ascii?Q?T9AtnMwdToWBxs4fjkNj2fezoUWdJ4oatXgyVjxuC33iYuPAHDith7WVM4sE?=
 =?us-ascii?Q?hy656LJDR0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?59HX/vkVo6jF2VbljbPuQ8SvHlveHSGmMTU7Q///I6eVCaPUbk2kniXBKsm1?=
 =?us-ascii?Q?2yL/2YV9BwEmOCMOaEW2eXucxV749dlVKl24KsT/vZcVOur5Jm/VXpDHMM8T?=
 =?us-ascii?Q?r5/3ELcV0n7/1hKoahKeoywSvWqxR/6Y34rVIftH9G198w6kycMIDMmyYO9i?=
 =?us-ascii?Q?ZkkoP+jqmeidYrKaj7ci1kCjR+5XQh6wgxefOGoX8DebEL3wpAIH/eRTsb9Y?=
 =?us-ascii?Q?8ZfYWRG6qrCeysa6qHCAQP5tzsVQxbcOPXhW6AzrGLZNjqW58FkPCxI53F2a?=
 =?us-ascii?Q?4zsVbbxbKKRHJg37Q67dMs4zvYCdiSI5pwsnyzHgQYHqUsS7oJtHywctZi1g?=
 =?us-ascii?Q?vW6enWmkG032zISEukQhjfOu4JncRFGP7KHkmmgelEchKfDwIneNkWNjC3tk?=
 =?us-ascii?Q?bAUiCjNhB+c9jr2EzMurbcPp0t5E+33bBdejYRgm1hiqG4mbCI78pJhL62bW?=
 =?us-ascii?Q?sJaKZSzeFs4tNam1EnZzr9SoGk0FA85XoYkMH1E/mgkBBxDLy6Q7kHE/NPnT?=
 =?us-ascii?Q?/NhY4kZ3FKIoKDGuDMdLFd2vtqINTf/xDzOX7eTXHsU7WfP6Bu/uuXyyfJ4F?=
 =?us-ascii?Q?UrD+heKYDtJqV4OYnpg9+tCFbl9nvP7Gocou0QeEBK00IEgsGG9aBwe06/uR?=
 =?us-ascii?Q?gIE3xkrOgP5s5Lv1p4kYvlKOFIAOVQ3E6ROThFeHuEvvkjaJQg6PVmk0rNVd?=
 =?us-ascii?Q?P7unOEpu046BLEaVUbt3BpOx1bwu+dCE3J8rYyg42wOxKrKg1a7mMn7UIlQW?=
 =?us-ascii?Q?ztj2lkMS+CEs+ns8sVrA3ewZomMUO9nqJF7NiJkJHaUJrJ6oV7b3D/NoGUi+?=
 =?us-ascii?Q?vEEffwR8ymo1aJUeUt1UMtT6mybX0qgIIDRgEbhxYUmcOxmDZHo+AdlnkM8N?=
 =?us-ascii?Q?lhxMvNs3IsXmYJNo4i5+w9LGQLsM7Fk5EYtay/SooOKNAaiEAiNgqXrWMqQ/?=
 =?us-ascii?Q?xu96Fb9IuKfmPyzIwlTNrK2f3wD3PM2ELh6AwZ41gkcacYeAbGWUNmh1JaAX?=
 =?us-ascii?Q?zTpIJF8KCjMr/757OFNMREAEBIWS32Xov6hNh2FRIWlsohRH+P+BdIbAhWAb?=
 =?us-ascii?Q?cKATbey8WpBS5d8KemcUP9rldCqMvbnVfZBQwfl5LKbHjybbIW6jghSDmFam?=
 =?us-ascii?Q?OBzhMtiOlMrPwRv8TCqk/ANnBXz4bfGEFF7Os2chq2+FkuKlhSnGsEZidaSw?=
 =?us-ascii?Q?JpkxYOy7vzp9hXIYy6B0ERUucrwWeUfUjY77p6nLIPGVbsptHMo2sQUHw2VY?=
 =?us-ascii?Q?IOnqOwz+HnHlfpzBeispEQ3Bq2pdbmiN1pEp4N96e4UqBzkkMgeoiRKj5pF1?=
 =?us-ascii?Q?EOcE/Mm1Q63TtaH9RENj4MQ4UnQ1V5OKhcj//2X6az9Uzp1LHgB/gLb+b8jR?=
 =?us-ascii?Q?H7M5sn0rCpkHFjBwZ3eIQsijW+qg0F1D2GdKK6XYqc18J3cwyUtoChn20Nc2?=
 =?us-ascii?Q?i7e7CeDF0CAuon0+fTPTAxL1OqhH3orjtdfHTcLobFDENn4TqpJhFCHk9dcd?=
 =?us-ascii?Q?MV30zG0F37Q7T5pcNgOk8bnlY8tgo0AyH0vPb6MrEVJjdSjy48uBd3ZZNxX8?=
 =?us-ascii?Q?3DRgWrP6Y76dMZSC0HPUyvSS2CpUUnpQxjQ5Mitv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e27b8e-7458-4f88-0d91-08ddbfa57330
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 11:32:28.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvVVKvD2Kx8skyw3SC78u7OB6PxLjF++fRswUuLXwgL8b76rwEpFFVGJM/ERTNxWo4PfNbS+oQs8eoOO5kSgog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

On Wed, Jul 09, 2025 at 04:30:10PM +0200, Guillaume Nault wrote:
> Use addrconf_add_dev() instead of ipv6_find_idev() in
> addrconf_gre_config() so that we don't just get the inet6_dev, but also
> install the default ff00::/8 multicast route.
> 
> Before commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
> generation."), the multicast route was created at the end of the
> function by addrconf_add_mroute(). But this code path is now only taken
> in one particular case (gre devices not bound to a local IP address and
> in EUI64 mode). For all other cases, the function exits early and
> addrconf_add_mroute() is not called anymore.
> 
> Using addrconf_add_dev() instead of ipv6_find_idev() in
> addrconf_gre_config(), fixes the problem as it will create the default
> multicast route for all gre devices. This also brings
> addrconf_gre_config() a bit closer to the normal netdevice IPv6
> configuration code (addrconf_dev_config()).
> 
> Fixes: 3e6a0243ff00 ("gre: Fix again IPv6 link-local address generation.")
> Reported-by: Aiden Yang <ling@moedove.com>
> Closes: https://lore.kernel.org/netdev/CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com/
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Tested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

