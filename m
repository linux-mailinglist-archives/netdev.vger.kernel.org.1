Return-Path: <netdev+bounces-291186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ArLjEV8EE2qV6AYAu9opvQ
	(envelope-from <netdev+bounces-291186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 15:59:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C125C2A1C
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B29B63009012
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D13955F4;
	Sun, 24 May 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3glXIPk"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561622068D;
	Sun, 24 May 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779631194; cv=fail; b=Or8DPbl9kvOnXIrIVV6iTarzcVi1ZiGy/jjEBBNY6a8wrAv6EIyo6RwuIFQs/J655xrpqq4Me/lcZHTMRDJ5Nnht0+tr1wUy6lQl4tdOmEUi3d/Mo5hJJD0lAjucIRkN0f2rTXSfyTCsRSBtH3QvZcSbh3aEq9R9AvsotEt5HQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779631194; c=relaxed/simple;
	bh=s4pBLCsD/8DIc+fy0s2c6A4/j7u4+sybFuARbYirqCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p2hdJXcfuYgQqHfbxxjFWLfWVgT7Zhqr9hnanc4139qZ7uXRhTUu8TjSIdppqBHwYUMMOfQPRi0QkABXJwPYEeM8aptRsNBoKTMyCELwY+gzzKLNNsMDVT/S3/IeiUFI/VlhDgdxWLu9t0Bx3QN/d5lh0V8ZdbiyTn3Wmp461xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3glXIPk; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOpdfGNIDFxpmSiBIJCJMS9jxsjuwyU10YGEELnL8fMGQfIp3IbQv/rZg80GmqldPwQV1F/Dd84T6oDN03hUvQktXX4n6l1zN2FUGjDO6UnfKm5s3PoL1nnM+6A2qegz6blYF2UHm+RNUURjnUQ3dwbQSO1BOvkn3dW9INB9QgKHaLtIe5s/nLPO6JAVgreaBuywBDbBAsQgYOd7eV3iSkrw8RNlu9l3ZZ5NIY+Fvt7xaJHTOh15tBtwOOC14bnq3leiTQtmioUgcxoZwFCPhM6XXO3OTJV39FNuEY49V3uTWJpgiRtinJ5brN90s9dQoebsZxrDjN4GfL97SU0beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01fb5jjp1aHvJDY0hWKo21+Pv4f21sAknkI8B8lX83k=;
 b=Hvp+8wkHS19Um+H/y84bslH/Lt7Sdw1oGrxwkwqYOC2a5AYb08QlcKw7ORXVjL5DbjVvzZn5pMl5ET/NUSsSspVZSjhfr0zk3CsxJ0/MUbGreSYUGNEjXHGHWDB7wpAZ/P0PsFs4aw+TvrEMadEtMXkSBo3LhidlMs6MQtWl5Yq/quuwBftzCrdp4UoslAuMAFK7ewepyluvXKn+hryV6SsluCpbXLx7y6NxkWTy4aHK8VW45LBqEwA11uzGH95V+4zHve1yZWQ0C6GJipmy/J4O99cT627ceLpOL1zHROz0iF8MXLaMrUPmNUSFFFqzhKRcdW9u8xSflCEnY5Zsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01fb5jjp1aHvJDY0hWKo21+Pv4f21sAknkI8B8lX83k=;
 b=e3glXIPk2dZYdxh29p2CYOakvB+A19SqLHHdFczzlGv22RrtYBkPtz1+VIkgvQE9ctM8zhUu3/e2+UtC71TDR8pyxQp2dUOrBYu64uTHBRhekb3KPrW6zkYpUR/jChpmoNr9d7YqSy3p69XiHHTFzO/AyGiovJCE1ExOrlBBPOGfNJKgVadU/pcbNd9RdI8lkdWeEROBCG7uFe7AfGzrXpVl8X120IZL3vf9ZzfseG0dFPVlKc22gBqtPV5uEF5YHMY8VF1LtMbzCObQ9lCSTLo6Ne7m8iqGgekSoj0A8jiAVZP2XR+aOwwooX8ZIbfUQwPbCMwSidcxxcpagyiWBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 13:59:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 13:59:48 +0000
Date: Sun, 24 May 2026 16:59:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] ipv4: igmp: annotate data-races around
 im->users
Message-ID: <20260524135938.GA86099@shredder>
References: <20260522093906.39764-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522093906.39764-1-sigefriedhyy@gmail.com>
X-ClientProxiedBy: FR4P281CA0386.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7ed74e-b741-4edf-8c0a-08deb99cb7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CPyMtmRel23Rq6MNhsnpIO4STThbHWjTFKHzmg6PMz4EmK0Df1rrGkZTTFAEuqMmW+ScVTL2AO/2S0I9zTkHFMBagbGSjIaZNXJLUn/0JgI/3xTYtuVRrZqldDd7S4k1jsmy43fYmitQ56khfd+Jqvlfx/hSVsXRE4KQz1tuMaYtUnqACSUGZSEiJ8vCWiJ0/A3kHVj1yXQCTXUj6aE8K+JQD222OayJFoGHYxGEEnEzhAdTS+COrALbxfUtwZp8IT/+HYNqYerPrqhB4yhd3eC28mgTqocP+Jp1X4LttK5MOUhzRGQ8MaTl5xHdUwujLIu2Hyz6u5+29J1h4BHEDgZWt9iOAzIiynNefAUVbnaC/8FKqcuTJOotYXWnOW92pHlq8ZI9aGcSoyt9j4mWl0hW3YuBhoViks0gEGReETVdvGClc0aWV4etUM0hqdeHTWhdEhtIyGUBqY6YX4P4FDZQhMyA3pMge2a91Z1kNbFcVy96GanPgPEmwBsQR/fHg+VTJe0y7FjrCw+q8zwF5aWjh1cdPKww5IPA4f2ot54O541f2PKkv/PVFPMOS+rdgWB2SvmIwV9F+cYaHGhyJgqAS9m5nk3GP7gHXdCny2tiXkB0bB/BWmgcddAbXZisNyfY1bcTNfKDaLqgjg0IrKg3sx3Z9oIsbbKQJ5aqzlOKam68ya80ljzxM0wlaGsE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pGQk/5y241Orc52qhm48bk40CgWrg554OeyRDwaeyoIqvMa+wEl1h14+MdR5?=
 =?us-ascii?Q?FlnqYZHib1X8fXfsHCmWsAEfHGJEPze7kKgn1oRpD8W4Vt2awyzKkMgPa3v2?=
 =?us-ascii?Q?XVNjs9igkNrQM76I9zaLMjeBni/9SJjvJn5+nsZ4L4lzb/hx1ysUCnj5mMQO?=
 =?us-ascii?Q?9m06zlKse3jOdzgqOKC/tm5M75EK49kOOiIepXHWYEtNe7Gf0nmJ93HZUhWM?=
 =?us-ascii?Q?sWtVWdBSv7gbl2QhQsoeYyJDbgSpg4jGvYPINfmI2ApNbE/hhiOgvBb27j0X?=
 =?us-ascii?Q?cq3/lOnqk7jgvQPipANtz1cWeoWJGA5mFZtsOmalr6jWftiRSh7BFBFT0uyx?=
 =?us-ascii?Q?Vbi3TKi7+upcgkJZn42z5/u+6sLsmsDeQbC4wn3Ibp0Q9iWsVmWLnbHbDSoc?=
 =?us-ascii?Q?J5Vfzf6dHbe1ZHMANrgJ8mpEfi3GHaytv2KYRKQOKBFJhaf78POzgtX6HnPB?=
 =?us-ascii?Q?gRAbDQ1yYPThQDz6JRLOCFp5oEsgaaM4X5hf400SawNffhrBc/ue9PpeF9Bj?=
 =?us-ascii?Q?jiJUy7tZjqadYy5WtR6d9lsuMbGAJbsaFldqVFkimBs4ThsZCUXWhazYOSHy?=
 =?us-ascii?Q?eiapFmy0J/MyQMHTzf+dtu7thL5FN2bdodRN/W9q8JvONHN5mNgUeYOMUMZH?=
 =?us-ascii?Q?HQc58aDR8fI7/PfuUDt99LCA9ekqff0u/2sow2/WLx4rOrdiz6af/3/FzeUo?=
 =?us-ascii?Q?NHdxH5/s3EH2C6ZGwCggfXmCa+JHfT4UN9X4BqoWKc8xvz0nxq7zBqb1v5I4?=
 =?us-ascii?Q?kIE7d29+PGP60eS1jnCxSV2wJindFRqkgEQyQoy7VAULw9lH+rNJsLvUBHFT?=
 =?us-ascii?Q?qzq9v3qTIh4tw2wjxHKNCHJSFWthPid1FrcHz5+eKwV3dejVOKOOcIlmAAAF?=
 =?us-ascii?Q?ybBnEfemLYuYTu4p2jbqJBpxlsK3fRc5WaQ+o3neyatO8ytqDbhNaoWYY2wZ?=
 =?us-ascii?Q?98dchy4X92HWQN8JcXqOLnggOggGlxpDax+6ZN+YQ2u3uSQUH0s+qGbOgaxx?=
 =?us-ascii?Q?Aod7Cm1LoWsB+EdklwcLENyCR2m1IVh/Y0/Ag6FLcTR58qh0Sg5eYgq8rxcH?=
 =?us-ascii?Q?OnvJs/xRlvqft1YPXVFxUILrZkyPmhniEK69lj8Uj/BpmNPESlqqbvlR9Rdw?=
 =?us-ascii?Q?JWfV811I2jjotxZyQGeUp01XgSG8qt5UU0T8o89PP4iqpQI6nUJQO/aNWwoR?=
 =?us-ascii?Q?UrtDmQEg2wY2LJ853DmMeJ5kwu1ntOeYJlbjXfVQo50zEBxeZcbvGoAgdLij?=
 =?us-ascii?Q?yErC6lCrierkjVX0kbkjstTjIRZfCVEHjqAqVGpwEVuWz3nPNol3ndyHZEzu?=
 =?us-ascii?Q?vsuSvAsR06p1a8Oictp0ZQtnu/InVEmqPXerXFxON0wVvq8IpdsBW4sjoEih?=
 =?us-ascii?Q?8xUDRfHtSpj8YwNT0A4utVrleK0nRYITzn+cZfluGotKF/LJQsVewS8V7Kju?=
 =?us-ascii?Q?AJIUQy3yg7/pf0BzvFvJOhEiLecpnltewPvPzS/0plL/cvIqXrQOrzlKaLMo?=
 =?us-ascii?Q?K+/pByDqiOF26FzljDTp1iYOje5efq862SRgJT3UlS+tTK/N0kVJFRmrYjMl?=
 =?us-ascii?Q?6jIOyrpcv/8wUIgtgxN/fAR0/Sv/IQiLw5frdTmSBPkqhAts1CG8RDCY28b6?=
 =?us-ascii?Q?EkvYAY7YaWc+HZy/SH4k9MxQ694W8s2Npfap7DI4fpyMFlvVJ/46ar1UTgxP?=
 =?us-ascii?Q?8sJQQ2gSZel1lxZsTUvcNow8bcFDESOMUU+bxAIkf0exqm5N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7ed74e-b741-4edf-8c0a-08deb99cb7a6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 13:59:48.1574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIhrPhQMhQw1VWowpKt7uZzuYpdYGTECaCgLSpzaQVu0EGiQYeKZVwDu+cDA237f/NGOtT/ESkcuggLOja13tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291186-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A3C125C2A1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 06:39:06PM +0900, Yuyang Huang wrote:
> /proc/net/igmp walks IPv4 multicast memberships under RCU and
> prints im->users without holding RTNL, while multicast join and leave
> paths update the field while holding RTNL. Annotate this intentional
> lockless snapshot with READ_ONCE() and the matching writers with
> WRITE_ONCE().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
> Changes in v2:
>   - Added Fixes: tag
> 
>  net/ipv4/igmp.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 27d120183779..f2aca659b29c 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1541,7 +1541,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
>  	}
>  
>  	if  (im) {
> -		im->users++;
> +		WRITE_ONCE(im->users, im->users + 1);
>  		ip_mc_add_src(in_dev, &addr, mode, 0, NULL, 0);
>  		goto out;
>  	}
> @@ -1550,7 +1550,7 @@ static void ____ip_mc_inc_group(struct in_device *in_dev, __be32 addr,
>  	if (!im)
>  		goto out;
>  
> -	im->users = 1;
> +	WRITE_ONCE(im->users, 1);

This one isn't necessary since the object was just allocated and not yet
published

