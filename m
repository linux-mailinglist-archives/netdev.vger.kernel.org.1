Return-Path: <netdev+bounces-25120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74534773033
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BCD281520
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A50174E8;
	Mon,  7 Aug 2023 20:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ECD16408
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:15:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224B10CF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691439349; x=1722975349;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Vt4Qfaa6/LO5EQHmyPtrZ7+2bGw4JAom6Dz75fQ561s=;
  b=UNVKvp+/9pv9hqcwCX506+s7pUY/r0Up1TxHSYtmB3gSJSdG6BkMzmQI
   ATGN6h97RNd4FSUGFyOQuRa+i8ZZ4XE9rn98P1KhemCDNSZAwHX3Ymd7P
   9+VDuNKM6ZbKbDJ+KxuDHmwaDla9dQyhfXocOhayeOl03ge7DAkaB5tqd
   uQjr4YyThq4rm+3qN+TVRX04vY4vx1j7lAUslln3wlIWXbNze2csoYCXq
   dgraUV0FyX8RWgTrgEyqmCrrpUh4bP7sPuA618yX6QA6Sj90pbZvLu/c8
   y08PFOT2YwwRTLUuaj6N/8ma1v789muRtB6V/keI/JeNl8pWmQG+DyU89
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434487483"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434487483"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="724643839"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="724643839"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.67])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 13:15:45 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2 1/2] tc/taprio: don't print netlink attributes
 which weren't reported by the kernel
In-Reply-To: <20230807160827.4087483-1-vladimir.oltean@nxp.com>
References: <20230807160827.4087483-1-vladimir.oltean@nxp.com>
Date: Mon, 07 Aug 2023 13:15:45 -0700
Message-ID: <87r0oea9se.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> When an admin schedule is pending and hasn't yet become operational, the
> kernel will report only the parameters of the admin schedule in a nested
> TCA_TAPRIO_ATTR_ADMIN_SCHED attribute.
>
> However, we default to printing zeroes even for the parameters of the
> operational base time, when that doesn't exist.
>
> Link: https://lore.kernel.org/netdev/87il9w0xx7.fsf@intel.com/
> Fixes: 0dd16449356f ("tc: Add support for configuring the taprio scheduler")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  tc/q_taprio.c | 91 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 53 insertions(+), 38 deletions(-)
>
> diff --git a/tc/q_taprio.c b/tc/q_taprio.c
> index 913197f68caa..795c013c1c2a 100644
> --- a/tc/q_taprio.c
> +++ b/tc/q_taprio.c
> @@ -416,14 +416,11 @@ static int taprio_parse_opt(struct qdisc_util *qu, int argc,
>  	return 0;
>  }
>  
> -static int print_sched_list(FILE *f, struct rtattr *list)
> +static void print_sched_list(FILE *f, struct rtattr *list)
>  {
> -	struct rtattr *item;
> +	struct rtattr *item, *nla;
>  	int rem;
>  
> -	if (list == NULL)
> -		return 0;
> -
>  	rem = RTA_PAYLOAD(list);
>  
>  	open_json_array(PRINT_JSON, "schedule");
> @@ -432,60 +429,78 @@ static int print_sched_list(FILE *f, struct rtattr *list)
>  
>  	for (item = RTA_DATA(list); RTA_OK(item, rem); item = RTA_NEXT(item, rem)) {
>  		struct rtattr *tb[TCA_TAPRIO_SCHED_ENTRY_MAX + 1];
> -		__u32 index = 0, gatemask = 0, interval = 0;
> -		__u8 command = 0;
> +		__u32 index, gatemask, interval;
> +		__u8 command;

nitpick, optional: as you are already opening blocks for each of the
fields, you could move these declarations there. (same comment for the
next patch)

For the series:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

