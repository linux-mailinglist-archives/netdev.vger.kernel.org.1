Return-Path: <netdev+bounces-31357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128D78D4B3
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA91C20AB9
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098731FB5;
	Wed, 30 Aug 2023 09:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01571C08
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 09:42:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29AE1A1
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693388561; x=1724924561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHNsnXd2ni11wOfRpjp6dm3piElNn3JvTAHms/Tsf6Q=;
  b=fqhJ+sEr+DYFUbV43lj2DIo7F3Mr6eDNwpBUYFZKgRkRBTPZPy8P9B+P
   zBNupgwA07R6ij+qZWJAkXSq7SmZ5ixDeb+xObS5qFOFHJPznV7YdP/fk
   8bCyKthocuIamr0/tucJKDJu6X4xIhlNluT5TYxn+KwytnpLfYm0or+rT
   AmxBc3M4GRMjKhFBQv2mfsoUhlvi7S6yPV0bi52kAO3TixiRyBxqc3odK
   i3o2R4clKC3gQbLtybx8rB5IGHVWahIB2gJDpOnyJs1aIyqxPJUai3XQ+
   Nr6YH7RzkRnBYYdqR4f2/EjJBFgSPOyNv/iWVG91Hzfb6wk42QIu81hqU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="441960265"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="441960265"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 02:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="742168552"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="742168552"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 02:42:39 -0700
Date: Wed, 30 Aug 2023 11:42:30 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, benjamin.tissoires@redhat.com,
	Karsten Keil <isdn@linux-pingi.de>
Subject: Re: [PATCH -next] isdn: capi, Use list_for_each_entry() helper
Message-ID: <ZO8PBojBX7trfVnU@localhost.localdomain>
References: <20230830090529.529209-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830090529.529209-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 05:05:28PM +0800, Jinjie Ruan wrote:
> Convert list_for_each() to list_for_each_entry() so that the l
> list_head pointer and list_entry() call are no longer needed, which
> can reduce a few lines of code. No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/isdn/capi/capi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
> index 2f3789515445..6664eb3dc35c 100644
> --- a/drivers/isdn/capi/capi.c
> +++ b/drivers/isdn/capi/capi.c
> @@ -1326,11 +1326,9 @@ static inline void capinc_tty_exit(void) { }
>  static int __maybe_unused capi20_proc_show(struct seq_file *m, void *v)
>  {
>  	struct capidev *cdev;
> -	struct list_head *l;
>  
>  	mutex_lock(&capidev_list_lock);
> -	list_for_each(l, &capidev_list) {
> -		cdev = list_entry(l, struct capidev, list);
> +	list_for_each_entry(cdev, &capidev_list, list) {
>  		seq_printf(m, "0 %d %lu %lu %lu %lu\n",
>  			   cdev->ap.applid,
>  			   cdev->ap.nrecvctlpkt,
> -- 
> 2.34.1

Probably { } aren't needed now.
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

