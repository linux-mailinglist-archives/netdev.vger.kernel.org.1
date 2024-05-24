Return-Path: <netdev+bounces-97996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC98CE833
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 17:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F152816BD
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BF13CF6A;
	Fri, 24 May 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hTs24CbS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97D1E892
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565198; cv=fail; b=VH+SUXFvMO5WnKKF/fLF7YbOWJpuz6g8GC6ZohB3idtbIGrbLyG6VQJh0+onOUMEYIL9n0NqPaOaFAD7vtvLH+cSGxJmbSAP0/AgYAaZ8OmXUAv0pfvPVTmVCkmCxGpTdlf4Mb4h5ZlwYWC48I07HA6z/kjXZ19q65gJRVV1qZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565198; c=relaxed/simple;
	bh=O4aSZxQF6+2PiSb/v4+E6ooOw8hYqPRpOb/xXYShoLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kyhyT4/tPE64Dm6EdMkoa83V8CN1BmsnKGz7Z6ybaEOJE/NN6oayG7fpcACMWX4MyUBHcjWHJGa6FUtgRaXWtO37SuhGiSPx32seg+De0TiYrpkLx5Yah7KzEHZ55+I2Ka4AX0B2p2B8ooy7EAJmFFw2zRDrxeBsvobvrFTuV/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hTs24CbS; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj9GbHhK40TB3WaZi62W0epPvCaIA0sFeB4cwd+7Q9V2rvNZLr4bDj+GPNkie2r/4j27NReSKxVPNGLRHoqxOBlQuVPj51Q1fCanQMi1wjjVAgTi80iBARyeeBTLQ3GnP7fYpqXCI0TVOCr3pWpecfzdHXCB9aJjhnQvf4YV8ga5+sLpCdz3JGWoRjWjUxEzOxM1eTB5Zr3YQKARWTGBQFT5idbO8OziaTb5WikeA5qhfG5PwsItC6inZsY4WrcM6PzwIRbSeXmih9y5HKpawWhCbCLCNj8MoSILyHwG5OOypV3eFl+WEBEvQqmOyWP9sV41HNbwn/47sU19BBkKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaRR41c7oUhZdoljpp0S15+Cd/ofrbp0i6MZMPw+k0E=;
 b=HUv28OmDSjzVK4DbrRTes3HOLoK03x2CDQl3cd+DTdWyHXNspegoczcOqWTJppxTjlaZcvsNetXYlRppRUMd4apbdDYvI/vW+t84D2rqYOKENHvMN2PNnRHsJGLQEvjrCjWvmOSm3HtVazoZWv+/I+9ShR+zPWCzt6dAHkvlLO7bEL89pe4AdRAwwNDrx7OsJTVWs6kQqvdBdK7shLCljZ8Ptbg8fdolmbs2+7ubzAwLJsFORD9SMz2A6Thmla5Gio8h0RR7S3mD71+U6F+12vE0snkKvTTdKSoU1RQ3Xl33x0uvlQWFO493mLoSQ/BcbpEMIHevyot5gfooOYlXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaRR41c7oUhZdoljpp0S15+Cd/ofrbp0i6MZMPw+k0E=;
 b=hTs24CbSLvAxEHwvGRQZzSK4dlLbFIwET1LIUwdOQvM2KfoxG7b2Co5g89liEsPccbYbu1uI1ZiZTm67tgoBLRLjTPS3+1bkQBmtpKIl1dSBnu9WAxaFhoYZIKcYNfqS9jCikfh8YbzeBtojlwOTnZJXkXw/Vc7J3Tfl2P+rY9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 15:39:51 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::f581:5987:5622:e9d8]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::f581:5987:5622:e9d8%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 15:39:51 +0000
Date: Fri, 24 May 2024 18:39:48 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net] net/sched: taprio: fix duration_to_length()
Message-ID: <20240524153948.57ueybbqeyb33lxj@skbuf>
References: <20240523134549.160106-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523134549.160106-1-edumazet@google.com>
X-ClientProxiedBy: VI1PR0102CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::24) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5434f2-d7ee-40f0-42c0-08dc7c07c04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3IG/edtzeRU5Su10K3wcXTd9Y+hl3jFPONgQ4KfzLuMpooi26gyRs40/qF8?=
 =?us-ascii?Q?PC+EBRbDtzBj6hD2c7iA8dzJ0agHthxLbUNa6jUYdGlVaCul+fLGdO/BfcbG?=
 =?us-ascii?Q?X7vur7fFvk/85L0gKkRaDEJ2RpZwOvufhCd+BWtx/HTS+e5VshVTiXdFjetR?=
 =?us-ascii?Q?50ZftiJuz30F4EZgfbzyf/689V8j17EaKx72s/cIA9DK7INav9tttMH1a+c8?=
 =?us-ascii?Q?9SEq0kbsyqvGi7LaTk43PJVC5VS3913ovkXbjZiuvfzg8WZPz+nQPv9wr5z4?=
 =?us-ascii?Q?2KYmDpZwxXZfJR+KbODooa2VtAoi3hJGKMBunYu04CGowBXhDwEgcNngwCWv?=
 =?us-ascii?Q?DCqpSfY08s9ZikfVrHmvEmdV9y5fVR5aoNRUMfYeKoiLoni6quuYWF/AAZVP?=
 =?us-ascii?Q?Pbd9EFNOYS80SbCMt2GQCVbtvbRQF9Rpy9Ujn9LKofng/65nov3pGanyQtE1?=
 =?us-ascii?Q?Z4CGMaaOKQPEHW6YttL0OkG7/YBHMNbGSvV13+tBA5wXHnA0U6DJmdc4Mj6e?=
 =?us-ascii?Q?QSAgzOKko2qC/uoe5/sWr3j65JPWhS9RfyFQN8y10UXRs4zihldyFPD3AOs4?=
 =?us-ascii?Q?ie7bBPjZfG/ce+mKz4WjDGDmK8YKbeuhdOgyoZWMjInWOe3GfvRZpTh1RURB?=
 =?us-ascii?Q?3At79ryoDHI8fVHmkuGXIczBU5XCVfQvxehnZ/Ey+ogGkRMwzaBSkw5M3dyh?=
 =?us-ascii?Q?lmUYxM63AKjzzHreR86OYB3USFWGk2YDGce4FyyR3Fd5IvAKsPOo2nntmTZg?=
 =?us-ascii?Q?gDJV2CCs8JEtqOe1F7cI29QymPTKAF2UiRQcQ36stHH1BYhy/xAgKXbeGLPa?=
 =?us-ascii?Q?NVelDFbjFRZnAcufZFKFhaJkFr8KwNweXVaKIYlbBqkbjcpoUEdd7VtyXFY1?=
 =?us-ascii?Q?jOVOG/nByWfuyzCHBfQQ5F3iztxZ/Pt2xOmjCjSaeRpkb13kLUb6VEwEEDim?=
 =?us-ascii?Q?ayMYEaiau9IGQ62m0u05WpnMRTMXrxUrYrJaj/dpAr9fQEdAjLLISgixrXua?=
 =?us-ascii?Q?BOKekUYhbnW96ZEOjP9FPu9fJv/aSSTwd1bJih3o3J0m6h+hj4YGKcHM+umi?=
 =?us-ascii?Q?1YIyQm15bWzRWEK8VlAk73hgBJCSDLXFdBeObeTzmdhLPZG1/45MHCmZVVkJ?=
 =?us-ascii?Q?7zAvrpkS9ZuKI6ildAqb5rG8oUNSBv+Fu4zXFJWdmw9vhgSS7jJ/EAwDYGkq?=
 =?us-ascii?Q?EWoYCMoMAM2zbwlUlcoRV4S1Lqm8bC3RYNiH7pFcLHQ3Wg5htOD+KTWlutoA?=
 =?us-ascii?Q?YSgBzJm9feLMFzXO7wqzyLFgqL6Wh5S4HdF3W4uLVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3G1SfuIgp586gJpf2fXICJTGUF9rYKVQdqgDKwE/4DBSONE8tfnp96YqVDMn?=
 =?us-ascii?Q?yiLkO6NIUfFZu4Unueg0GGBcDr6wZyKZMh62F3HmUdGCAuuNbrHxw1aRYLfH?=
 =?us-ascii?Q?H6W8zRsqIwrMb00nvVwEyiKL8uin1hyrPfyWFzyWV3Y/1PgAM7kuP+cZyVP6?=
 =?us-ascii?Q?GwFYGqxGVivnzOYCXWlRdBsTtMlgEg6IvVjzLXRs/wgffeQEwzTPFrb3ogVk?=
 =?us-ascii?Q?uRJOpeqbUutfpI7Q4mfZeDs9aqXiyjSfGugJP7X2R3UREqdetKDRZBv6B3G+?=
 =?us-ascii?Q?o+i2agdXzcog+5+5Vq6YXxQNmyNHgnLt4jxCn6/0E0M6kxi+WLXkf1CBCu/+?=
 =?us-ascii?Q?KlbRfKf9BLm4oFf+zsivMUxJp2klsHyPMu4e0MPrdGpYtv7z+pBQ1Ar+KT/A?=
 =?us-ascii?Q?CX/o8Fl9iHBBdM3fTDDk5sDUz67jCTOZoI3saj5Sq3kSXz7lj1EJxMjyV83O?=
 =?us-ascii?Q?iVQHbccuC5217gd71DU++Xtza18rr0Xm9wBrw1CGyblku9yr+KA7US45aBDt?=
 =?us-ascii?Q?MBS8IPQPpr83WhiVF7Oyu86yvvBHnQx6vI1KVkqU7B0depwx2OFnZTph67xj?=
 =?us-ascii?Q?pjACnRB3ufvrZnswxGnmIFVKCiTBkRgDxnravQmDwmuEBB8M0pagOIDjE3l5?=
 =?us-ascii?Q?oZhbD2bWFer/TTdflF4Vg9YSdENzkCDmA867yv4KtOKh2aOYCvfLrFhUe46B?=
 =?us-ascii?Q?VQCwvPs7GCSCzNXaJ73NQ0zeo/Mjl0ePvlaaSMzwnhU+h5ZPXJtjS8W5J2Rx?=
 =?us-ascii?Q?aaPxH2/kHOJ+zXtHakCUitnP+kWaDr9E7+1j9ZiU7+6a44JTJubL3mjJ06lT?=
 =?us-ascii?Q?Rg2RA1s3/q++bNlvpBYHS8RIu5AcEHygP4UJc3V0AJySKoQRCXqJ272e1kBr?=
 =?us-ascii?Q?aZOcSwDiBzyga1GpGGYZfJ1aXjyDqJ9YBKomZ824iFGWytzUNjEyq4I3cjZ5?=
 =?us-ascii?Q?l4xLvVJt+oybEecAiNUs5nSxnx++sDwYimzeUbz1Fqk7WGs8G16OlIMXo1Cg?=
 =?us-ascii?Q?DShu04nPLsPD8O4UKffgFZ9tY19216lkvUl+dW4/CrIfB8+txMkX6OciVH6k?=
 =?us-ascii?Q?mvTcLCKgbGJOiUQqeUH9U2fO9KL2Ds0J4FKTjvSe3ma4KT2jXo9LQPrVOK/Q?=
 =?us-ascii?Q?43SCWRYRpzMkJqK0UgO25bcY5JjVOza5X6XO8yLBeqSiOe/0f4WUrq0dKTEk?=
 =?us-ascii?Q?ELijnneut+kh9fzJTGX/X1rk965p1ADb7P47VK0CLoEQ4gSF2vecgQDBOKaq?=
 =?us-ascii?Q?a6M8nv3+SKMSfr6WNhOELZCX4+LHigE26JaqG+BtmOqxPz/YnnEK78JsotJY?=
 =?us-ascii?Q?wiCk9ZaJu8eXdYqRneThjx0m5/T7dr2kKm8M32EbRfxt5447d+9fZt3Gh8rd?=
 =?us-ascii?Q?JJBKklPXFNbQyhcoSDsgElwtHAGTHpNvMZDdPlN6axvfCgzLjrEp33irh23h?=
 =?us-ascii?Q?kOqIPlEEnvlq59Lj+G9Qk9bPdbyWvCL0VOuQS9c+R6zQck0zI2mb+FbmPSom?=
 =?us-ascii?Q?R0aWvIvfsfWRI8P5AeHdgIdTPeb2tudlwUpKXlkREZhq3sVc3mzEK6ibWtFi?=
 =?us-ascii?Q?MmO4Fz6KdbC2WydnzxebJJpecNVjk5b3NV5vmjP3niAN3bxYfmL/oOpNPZWs?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5434f2-d7ee-40f0-42c0-08dc7c07c04e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 15:39:51.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4YiK1N3PnD42g56Nwbtuoxw65RIh7qQ1dXWAPYjvwfm/WpbGaZKERNoMiXnZZ88ECu2FMy8wdoAXD6aczTxjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253

On Thu, May 23, 2024 at 01:45:49PM +0000, Eric Dumazet wrote:
> duration_to_length() is incorrectly using div_u64()
> instead of div64_u64().
> ---
>  net/sched/sch_taprio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 1ab17e8a72605385280fad9b7f656a6771236acc..827fb81fc63a098304bad198fadd4aed55d1fec4 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -256,7 +256,8 @@ static int length_to_duration(struct taprio_sched *q, int len)
>  
>  static int duration_to_length(struct taprio_sched *q, u64 duration)
>  {
> -	return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
> +	return div64_u64(duration * PSEC_PER_NSEC,
> +			 atomic64_read(&q->picos_per_byte));
>  }

There's a netdev_dbg() in taprio_set_picos_per_byte(). Could you turn
that on? I'm curious what was the q->picos_per_byte value that triggered
the 64-bit division fault. There are a few weird things about
q->picos_per_byte's representation and use as an atomic64_t (s64) type.

