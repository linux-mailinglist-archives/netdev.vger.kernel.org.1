Return-Path: <netdev+bounces-54062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69995805E1E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA6D281D80
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430BE67E70;
	Tue,  5 Dec 2023 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o7CeolH+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F7BA
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:52:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXFYOz66zruf/NNm7J/iuoyjI1gsAXzyFTe87PKfkDD5AqFxclO3TT17sO9pQ9eBa1ZKR3ojeijJOa3VFx70BdDGl9ecrXt3Ty+G74iPLC7cAfGaOijcEhbBTCgBa+OHFNbZ9LB4nwrKud522RAX14JP1yBEQ0S/DlPAAGypHRz2RY57Mmk2nTMccu1iAgf0HR7YKNdN0CRtGRpJvhIdW40iZI9stjp47qNGsLZ65eziu02nWkyp9q1tQPh15iFcyBiTKuYxJ5CrBdWgTmhMa7+Mg8QmB0/hd0xoADGTpZC6PwVE8/8bP4SaecI9twXUfKbPQaIvEonCYwaiUiV7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HvZxLvMNQG3fN21Au3HviOxhNv8xqjY14lXBjQRyjo=;
 b=XqkwwYvPhF9BToqT51LmuZQptMvnmmFoEYqu5a6CQh/1DV3i2xWYGaRcgcHCWSNJ9pqP5DSRW1t68EU9KAQYEd2qAErC1PdFycXNy+aKmxTixRuZQGZ4jkBUvikkGV4tRcPoZcQqTrDOmLwJEHKk/HqsMdL1QQFzyue352IlfxFRWu29ZHWVFnlnBrpqE80b4d1MibipfhfX5mee43Mp/2v66qOzRqPbceSIDSjMfNgy3wgBU2XU6zHqYalzWQ3tRy20eDwYQw+QLUt1v9PVTqrGxnEUpz76ybckPWCrW7ThovrrCkcwQDfaXeeGXDm7K9xI9ugXhGIoqEnCB6k1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HvZxLvMNQG3fN21Au3HviOxhNv8xqjY14lXBjQRyjo=;
 b=o7CeolH+SQaUgUKpCsdFG/eIqydgAH6d0Nk06CmbKbJPAWd6rPwfoPR0288/P9ugCDf0V/drd1IOfYza5TPidu4IOLfwV8kLTUaFeWoh7xYnNqV86DJN4K5mepL9WBy4UxHz1cEl4V4eWiKkxSL710QMHCk3HTjNAH0sqTro7KkGwZfmNbDPs+FCw8eJmbKuzIlEJU/8mRONhSBymOSmM6tz1Od+3zPq2B90cA2e2qLn7Kl5Q96EhBbXRxbgaz5RZrlFMd5aQuppkEAIe090/HDJqbjF2cnBhtys6DU56eeKMvGwgUwspC/4xSQRb81yV824A/iwDwm40LA1zQ8jdw==
Received: from CY5PR18CA0028.namprd18.prod.outlook.com (2603:10b6:930:5::33)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 18:52:05 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::f4) by CY5PR18CA0028.outlook.office365.com
 (2603:10b6:930:5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 18:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 18:52:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 10:51:43 -0800
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 10:51:39 -0800
References: <20231205153012.484687-1-pctammela@mojatatu.com>
 <20231205153012.484687-2-pctammela@mojatatu.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Vlad Buslov <vladbu@nvidia.com>
To: Pedro Tammela <pctammela@mojatatu.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_api: rely on rcu in
 tcf_idr_check_alloc
Date: Tue, 5 Dec 2023 20:34:03 +0200
In-Reply-To: <20231205153012.484687-2-pctammela@mojatatu.com>
Message-ID: <87jzpso53a.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 71281fcb-5d2f-4913-e701-08dbf5c34671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+pamllpCJRK1dJ7ImvASYQM7QIhDM3Q2zwHyV8Sq9tLNuYVnnMW6tdCxgBD9akP69Y1KS8NohZM8J7mXctbnil2UQfSVEyAAA0hNjV9HGJr9U9t2EDlyVrTcwfVDintmHaqKtpq05Q1164COGPAJCH3ZEgDqUTMTRM2py1QZ59ulTaDpHJIcg/X2wjIU8mRuxxvw+hB5ZTPT+iWZaYizMQ6uxvmezjeWOfhh4+ybhLzy7r4AV+lQUkoEJAUg4MzG+y/W3WaCsLBLimATzm6ft5+325frK9r+i6C6TkRrRvxUhRjDlas02i05QWME/tksT9YkCPzI9fIBWJS7eJcl7JaZGs9p0ZQvlnQmJG11Hb3ASATdVJ/u6eComyYxexAhMMdKoFRUkzTC06Op471Df9BnJPcOiYGEM89VhlchX5GtvofP9av6aud0vt/oMfsErKHogxeSf6o7TMCwseVzCnFKS2MRRwEbflTxihFNxSXn3RZj2Oiyf8mN8gGhLVLBdrlLjRNEzwwndLmhcqE3OaLspiLX2PE8fBo4q/CNTLeMjpoRiuQfE4moe861SdCsWnGcnQ+sKh7IZWYvVRxrounrTj1H/IjewvMU9CHcL8LOaKBP7FUSG3AA2Z0bLo8Hyskc6FaLl2er8mRdbOGqj8oBFGPwAONiXypXbNqGPU2Gqqdh5xDEjBPPSaBL9GQXSpiu6uvvaEi8fmCqe2xG1n1skcC/5YbFSI++gd+iuCf88QbLCHiPaXQTG2wic7WL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(4326008)(40460700003)(5660300002)(86362001)(2906002)(7416002)(8676002)(8936002)(41300700001)(36756003)(2616005)(426003)(356005)(40480700001)(82740400003)(6666004)(7636003)(83380400001)(16526019)(478600001)(336012)(26005)(7696005)(47076005)(36860700001)(316002)(54906003)(6916009)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:52:05.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71281fcb-5d2f-4913-e701-08dbf5c34671
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798

On Tue 05 Dec 2023 at 12:30, Pedro Tammela <pctammela@mojatatu.com> wrote:
> Instead of relying only on the idrinfo->lock mutex for
> bind/alloc logic, rely on a combination of rcu + mutex + atomics
> to better scale the case where multiple rtnl-less filters are
> binding to the same action object.
>
> Action binding happens when an action index is specified explicitly and
> an action exists which such index exists. Example:

Nit: the first sentence looks mangled, extra 'exists' word and probably
'which' should be 'with'.

>   tc actions add action drop index 1
>   tc filter add ... matchall action drop index 1
>   tc filter add ... matchall action drop index 1
>   tc filter add ... matchall action drop index 1
>   tc filter ls ...
>      filter protocol all pref 49150 matchall chain 0 filter protocol all pref 49150 matchall chain 0 handle 0x1
>      not_in_hw
>            action order 1: gact action drop
>             random type none pass val 0
>             index 1 ref 4 bind 3
>
>    filter protocol all pref 49151 matchall chain 0 filter protocol all pref 49151 matchall chain 0 handle 0x1
>      not_in_hw
>            action order 1: gact action drop
>             random type none pass val 0
>             index 1 ref 4 bind 3
>
>    filter protocol all pref 49152 matchall chain 0 filter protocol all pref 49152 matchall chain 0 handle 0x1
>      not_in_hw
>            action order 1: gact action drop
>             random type none pass val 0
>             index 1 ref 4 bind 3
>
> When no index is specified, as before, grab the mutex and allocate
> in the idr the next available id. In this version, as opposed to before,
> it's simplified to store the -EBUSY pointer instead of the previous
> alloc + replace combination.
>
> When an index is specified, rely on rcu to find if there's an object in
> such index. If there's none, fallback to the above, serializing on the
> mutex and reserving the specified id. If there's one, it can be an -EBUSY
> pointer, in which case we just try again until it's an action, or an action.
> Given the rcu guarantees, the action found could be dead and therefore
> we need to bump the refcount if it's not 0, handling the case it's
> in fact 0.
>
> As bind and the action refcount are already atomics, these increments can
> happen without the mutex protection while many tcf_idr_check_alloc race
> to bind to the same action instance.
>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  net/sched/act_api.c | 56 +++++++++++++++++++++++++++------------------
>  1 file changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index abec5c45b5a4..79a044d2ae02 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -824,43 +824,55 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>  	struct tcf_idrinfo *idrinfo = tn->idrinfo;
>  	struct tc_action *p;
>  	int ret;
> +	u32 max;
>  
> -again:
> -	mutex_lock(&idrinfo->lock);
>  	if (*index) {
> +again:
> +		rcu_read_lock();
>  		p = idr_find(&idrinfo->action_idr, *index);
> +
>  		if (IS_ERR(p)) {
>  			/* This means that another process allocated
>  			 * index but did not assign the pointer yet.
>  			 */
> -			mutex_unlock(&idrinfo->lock);
> +			rcu_read_unlock();
>  			goto again;
>  		}
>  
> -		if (p) {
> -			refcount_inc(&p->tcfa_refcnt);
> -			if (bind)
> -				atomic_inc(&p->tcfa_bindcnt);
> -			*a = p;
> -			ret = 1;
> -		} else {
> -			*a = NULL;
> -			ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
> -					    *index, GFP_KERNEL);
> -			if (!ret)
> -				idr_replace(&idrinfo->action_idr,
> -					    ERR_PTR(-EBUSY), *index);
> +		if (!p) {
> +			/* Empty slot, try to allocate it */
> +			max = *index;
> +			rcu_read_unlock();
> +			goto new;
> +		}
> +
> +		if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
> +			/* Action was deleted in parallel */
> +			rcu_read_unlock();
> +			return -ENOENT;

Current version doesn't return ENOENT since it is synchronous. You are
now introducing basically a change to UAPI since users of this function
(individual actions) are not prepared to retry on ENOENT and will
propagate the error up the call chain. I guess you need to try to create
a new action with specified index instead.

>  		}
> +
> +		if (bind)
> +			atomic_inc(&p->tcfa_bindcnt);
> +		*a = p;
> +
> +		rcu_read_unlock();
> +
> +		return 1;
>  	} else {
> +		/* Find a slot */
>  		*index = 1;
> -		*a = NULL;
> -		ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
> -				    UINT_MAX, GFP_KERNEL);
> -		if (!ret)
> -			idr_replace(&idrinfo->action_idr, ERR_PTR(-EBUSY),
> -				    *index);
> +		max = UINT_MAX;
>  	}
> +
> +new:
> +	*a = NULL;
> +
> +	mutex_lock(&idrinfo->lock);
> +	ret = idr_alloc_u32(&idrinfo->action_idr, ERR_PTR(-EBUSY), index, max,
> +			    GFP_KERNEL);

What if multiple concurrent tasks didn't find the action by index with
rcu and get here, synchronizing on the idrinfo->lock? It looks like
after the one who got the lock first successfully allocates the index
everyone else will fail (also propagating ENOSPACE to the user). I guess
you need some mechanism to account for such case and retry.

>  	mutex_unlock(&idrinfo->lock);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(tcf_idr_check_alloc);


