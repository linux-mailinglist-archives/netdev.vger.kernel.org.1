Return-Path: <netdev+bounces-282305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKXyBOXE8WkbkQEAu9opvQ
	(envelope-from <netdev+bounces-282305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:44:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F464914E5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F50E300A58D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6043B2FFD;
	Wed, 29 Apr 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mKbOcswb"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C015539A;
	Wed, 29 Apr 2026 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452254; cv=fail; b=ulp1j9v/Exr0xgIQHPuIQjhcf1FscZS9/4PM9lYCSR1I+fcX+ccJ8tZVBZBhfldzNSDiX7rZG+W8mjx6fGWyvfmfQTnCmaz5b2aFF/ifVMQGZCsSP4U0gZDvi4AKGOCvUy6V9ZzpAEE3ew2nC7RETUxh5TE6yd/t2Tem273B5hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452254; c=relaxed/simple;
	bh=4A0z0Sz1MeK1w+K3qvUCq52svzZtOrEDaFE94rPJj4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AFrE2edwbHbKdvM9nsRcRMTGiONYsSs3fC43k33Hi+UT6U/+fdeCjRnWLT+7G7y0kaAypF/osyKS1EQ1On53KL34Wa/Z+X5DUkrw0IJ6h2T4QpQcfiSzPzwxIDZ24RKH2KS+XQO4wHB0iAb6m9JR6ixKnsxhzV1RP+eNanCAKrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKbOcswb; arc=fail smtp.client-ip=52.101.53.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piG7+gt63EtS8B5FVAfJPqDTM86VzAQdDdHaFPouzCu2rcixkgIf5uGxGgNg+EHLJcSOcHHIRprRwRLcXzKHMgWirD93KeL6G3DO08ntYoNcipDRRXTci/QumBbmz4P4I9NzR84PoLp/qMkzA8oLS3p+6qkOxQ5ir4ikeNz6dKPqnrrm4+G9NAGb1DbOreGjI2VeMdVXZ82u5B58ud+Sf/DcWB0324iJ9WqTg/TrH2wHos1vOxolNIzI898iodyK+5Orp3jOGg/ndtWce+MMR5Q/iJi6tvBIukdr7OCZzYBIXlKf2LdRASswBniBBUR2v/kMA5ywP1Ewt424zfM4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ztXXsBDO+hJaxlIhUDFBtlOtn9HArUU/YFWsOkPZ+o=;
 b=grXSHpiC/IU3RUEDUJ09KPFHN2myhUYZFQ13ZMwlkQ9mnGQH6Pq9x+gwMo4DDltwaDDEPFFBEyxFLBkaMY/Qf0jJgsSNfIGK2LN7UsVFx5ycy/J2BzYiC6DU00i46Rjt4EzU79caCbmQE6FNTCQwRwMrGrhaSmCkSSpe2kK3pPwiEIgQYKFzyOJuiHdqTV3aUiYAiXOfNd2uIurkJH8pyv8Y9QJXlm5EH0zM/18nElk5Y5mxX75sKwQdEFsjNJtkca92v955Oba68qZ3kcv/PIeRb3uEOln589NWlQzZ0525qguZlntijSzqz3Pd24TehWyMe8+/5+Q73CkaQ5Zyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ztXXsBDO+hJaxlIhUDFBtlOtn9HArUU/YFWsOkPZ+o=;
 b=mKbOcswbLErqPMl2Ko3ic7ORXuLlzOY/svzv+Jeid73meBYUmLXkkugu1dtkDmTiuMkvugF9nO5ioxKIndIy7L7G3muASScVW8OfAwswAqQzRYQ1GOoUW/7C0UfPbzvxSvdg/hVOcgwDd6mSNWXCFci8dWgAdqFbqmm8ZvqJMDPCOgO4yb57QlUZkOwfZC4hiQcgf768BM9maB7YJT+BwbiAVSZnVGAfmbXvchzlE2tfe4s+0JWXu1DNC2qxBO5ymBZpilEWwdenvvVUJly5R20jF2Ks09X8YrkBl9U4WrFrWScpAq9Fx8GnPfLdiQ02dMndpgbAD6dOyzz9Yq14OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 08:44:01 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 08:44:01 +0000
Date: Wed, 29 Apr 2026 08:43:57 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Joe Damato <joe@dama.to>, Frederik Deweerdt <fdeweerdt@fastly.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/2] net: napi: Fix interrupts permanently
 disabled during busy poll
Message-ID: <36csl4lgsy3psknzdpssq4zc2zsy36negybhhvfhozthhnmfl4@c6y75w6udaiv>
References: <20260428175134.1197036-2-dtatulea@nvidia.com>
 <20260428175134.1197036-3-dtatulea@nvidia.com>
 <20260428173844.1354aabe@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428173844.1354aabe@kernel.org>
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c57eb6-a396-495e-fc51-08dea5cb7652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HHndR6SViYbvRQ+teWnZa9PHAH0p2EK6FKLxP3/oa0+e/kiD/rodz+vCNqbALBfpTV4jpdNT0YRoavBrpfHG0RwYW/3pQvM8buqtJvIO/K+vl6rgHoAfldZc3oq8Ul+l8MhZS7QfOBDXNyd9C4AZsMwAVN1+7BcT+f3/VipIJ6Q21XwBzkI+xZF1hYz/MlmWdS6KN3Z5V6mqqdMc1IPzGflUerXQSzaj1B5nUJoAcNLAeRj6KvsQOI01ult4Q4GTWcb+qMJflSfA7Suo3NgURSrMEu5H0ADR75nY0uzp+MVxqj/U/IMwyd00cFagiQJg3VI8Hih7jVGOwDovw89JXKw1A1ZZj/so6mq2TSKsdLN8TdfqGWR02wyu56sQnAGoWHxzW6sWL0J5IPUnHxx8di1uW2Euv9/pyWNVoMfeybr2GDCI4KwWxEEB65d6ykH/MXyH3Qqzp3U+S0H0RIMLrxFptxtrWO0uHYnkQNHcKkJFQkmXaDWr1O84WH73rA4NhWOzMvrHxLQj3GkvcM/cVC2DSpTv1L0LSC3m6Dfgt1aFAVUMAuxfcweCXScTT3oWML4Pfl5jIGkIHxFs/okfB1UeD7KRz8r7aXrL+O0BxJwkf/kSb2bG8Y30/zfkIMHfd2xQUFmPLZK96qD6UO+01VpaDAww7NC6yXu5XzbeWe82wrFF/kpP7j0kJPvBrlVLglssqwtxd7XGnUBiVs+XtOr2KzAYrNl8/XoYMy7YiTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vg0tNbfAJc0UPO39nKHdgdt+wtlUr4vd+eIEQ7huF9eRMMVHZcGnyc3ddBDa?=
 =?us-ascii?Q?8zSSM1tnLZ6hOlAw3LyGwIxHMFOyhG4LK9e8NNdWC7MPQnyaGt3Qu8/QT19/?=
 =?us-ascii?Q?vC4UUhjQ7ePTYaKkgT0nnTY0s5f6XbswphPqnknBQ4W5NCTC9jod8VmxeazB?=
 =?us-ascii?Q?qHM2jW1xFuaKqEZdh7r6S+iPiZrQLJW/18X6B5EgaE9LzAWTgFxTIiyf5xFy?=
 =?us-ascii?Q?h6tn/hq6EiLO60pqLpkGto4Apu4vFG8ofKTAtzUtxk1pz1nlcBe71TCVGKr3?=
 =?us-ascii?Q?ErTCa2AzZ0ZPET91+3C6r3yfiKVPMJOq9uorGRAtHfg//MmPNHPS2tM24Xyz?=
 =?us-ascii?Q?80Ja4G+3FtZEeV7HaeMfIgpKgIOaE6wiHVrQ/9wJAdLAmale3cF6Cz+G+PO4?=
 =?us-ascii?Q?Qw/nRWjrONmjEdD9+m6sXDtbMTa+CaNTptUVDgkHW93enWR0l7fCKZAH1fDe?=
 =?us-ascii?Q?EagQvTPiYgslA6wLMPv+tJNiRuKaVdwGZvSFclbgy63t8NQG83jyHKCPlvdk?=
 =?us-ascii?Q?rD3uoBnUO9roDhnwFZrzR3RZrt7T5ZIj9OtZzOdWg6uhQW+IBJ1rjCh2FJnz?=
 =?us-ascii?Q?RSVJPy4U/2JY3ELAtbBZsou+2z9ZB/KVGThey/KTlYh8+yUa1DCXDKfs8HSe?=
 =?us-ascii?Q?6zYP/EFxvQ5lUKOyIJdKws4fQZnuTieKBpcpgS9IbDLSzfdWJoI0qq6hP2O9?=
 =?us-ascii?Q?cw61srbl1BMoRUeSzak7xzz44moU7Ywu8McvpRoLCryI1pLioJPoi4IHqz4X?=
 =?us-ascii?Q?Hg71U/7vodunnHCXPnOQ8KeVJvUbdCb5LehJ5mcPr2J7yuCigOBwjY8hbumt?=
 =?us-ascii?Q?5sK99zPQGFDx2wpfdzPkm5kaA961FICLSVfS5F+SyBDJEBOgI06Ww+wSBv8U?=
 =?us-ascii?Q?rFYvfS3KdnvefelYgpt0f/tnTM2K0zp4chf6NJ0yeKsJoHAowRuTFizcVxZu?=
 =?us-ascii?Q?rc9LovIvJrpC8D4Wwv5vBahJkWiQQF0tuTcVxDtzL4Ftu4j7VXrS9J3yRui6?=
 =?us-ascii?Q?WJ/KmCK1UJ+yJPp7wVfJvMmLn7LieOsWBCrEjPyzD6PaYqUs0WbcUyFmjwBD?=
 =?us-ascii?Q?TvNdkol7y+pMvAJuyc1EOUSoLtxjcyy4PeRlg9nJJHMOWgMt+nhDP4QrP6fl?=
 =?us-ascii?Q?thMQaynOOffiiryJrcgcx5C+JKKoGevwQpD8Zp1K5ekgT5g8tQyHo6yXImtE?=
 =?us-ascii?Q?KYR+cdhn6cAUt2+M2ByzoPEYvio1hmIrYGSjaY2ud1r9X4RsC7+NtOGSrnkP?=
 =?us-ascii?Q?9PE3QpU/vS6XQuCs6neh/VDFzBCMKDiZR3kLJiY02dDhH5Wo5A/wEj1lGNlw?=
 =?us-ascii?Q?gd0JBVe1yBAHHLG4d0gpy5Y74V8aO/I931q5U/grPxYLJ7QqANGSUYUlR2Fl?=
 =?us-ascii?Q?zGCkzqjuRcVfDvYnq0Cd/UoY2G58y1CrWNc+cp85Z0scXBE2D+p5YaFFshgG?=
 =?us-ascii?Q?22Qcr2IQuf8tH/Br4rmNon+O1v6RpxI3OFDA4ROQmnjjxdzG3+yQOLLw1pjw?=
 =?us-ascii?Q?AiO00yB9q8S7ZBI/GvUdClyM1geI5E4TD2uGN3+fcJhwdZ2BSKbpN25BkM+H?=
 =?us-ascii?Q?CO6qHYMvWzy6hLWfzrMhRjJqfsY1NrdAlqjaelm3KIpx80YZKUBzvOw0a/53?=
 =?us-ascii?Q?+bcWbPqez+bzGWBd0Mtr4TW6Bel6aRG+mxGYgpLMSwK9G+NHl//LjiXzZXAo?=
 =?us-ascii?Q?GA4z/gE1yBaf0fXivVEZ3rVGPGqi2TeYNFrX0gVR4FllvTY81rP0gUFUdYeY?=
 =?us-ascii?Q?0pM38Tm2iA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c57eb6-a396-495e-fc51-08dea5cb7652
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:44:01.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqmMk8i2D31VEO7r69KL5/mPoF/YXH2UWeTLcwJbA3m+35dHLpf/dQE/p/WymPqSvdMGX+QuQPUodKk5Vjv1tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
X-Rspamd-Queue-Id: 09F464914E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282305-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]

On Tue, Apr 28, 2026 at 05:38:44PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 17:51:30 +0000 Dragos Tatulea wrote:
> > +	local_irq_save(flags);
> > +	hrtimer_start(&napi->timer, ns_to_ktime(timeout),
> > +		      HRTIMER_MODE_REL_PINNED);
> >  	clear_bit(NAPI_STATE_SCHED, &napi->state);
> > +	local_irq_restore(flags);
> 
> I don't think disabling IRQ is necessary?
> Isn't it legal to clear the bit first then schedule the timer?
> The timer does not own the napi instance.

Isn't the following scenario possible (but extremely unlikely)?

1. busy_poll_stop(): napi timer is schedueled.
2. Hard irq pre-empts busy_poll_stop() and takes an unusually long time.
4. napi timer triggers (also hard irq), napi_watchdog() skips schedule
   because NAPI_STATE_SCHED is set.
5. busy_poll_stop(): NAPI_STATE_SCHED gets cleared.

Thanks,
Dragos


