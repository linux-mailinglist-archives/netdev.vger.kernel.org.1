Return-Path: <netdev+bounces-31356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B3978D49A
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 11:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0021C20ACC
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 09:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27F1FB3;
	Wed, 30 Aug 2023 09:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBA1877
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 09:38:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EC9137
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693388323; x=1724924323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u1N+bgT8zMGDdEpJbmX55bZ4gv1X62VDamNUa/1OLfE=;
  b=CKAdVtdf0yGWYyeU4lfdI3LMCkDO/xA7Loc2n9s1dD8kBF6cFFqVLRTn
   5i3iD6+s5mmGnKT7oHaFAItU5P4GXWxvWF36zksB2PJGkwfortVJrHk0p
   Sq4XuGzr1BaUI5qu7/yYTl0w2QfpsldlRr3nVVwQD4a1HzKMdOCvUAwiT
   4ULLP1kJaBY4X/Uxlble6GvsuwAXZMlHpjp/HI3RgP9H4E29g54lRBfEC
   NrXQ9Qr5XM3RPJMkiDvuVnCf6O3lwEL0FLvgJw3hiJ68BtKOe386po/C9
   PzJ5qbXlEop6jzT6adqKn3fEmvni3CsnQREzp1fedHLH1v0Ivt/PsmHWG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355102468"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="355102468"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 02:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715834498"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="715834498"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 02:38:41 -0700
Date: Wed, 30 Aug 2023 11:38:14 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH -next] ptp: ptp_ines: Use list_for_each_entry() helper
Message-ID: <ZO8OBiCRLrK7OZL2@localhost.localdomain>
References: <20230830090816.529438-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830090816.529438-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 05:08:16PM +0800, Jinjie Ruan wrote:
> Convert list_for_each() to list_for_each_entry() so that the this
> list_head pointer and list_entry() call are no longer needed, which
> can reduce a few lines of code. No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/ptp/ptp_ines.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
> index ed215b458183..c74f2dbbe3a2 100644
> --- a/drivers/ptp/ptp_ines.c
> +++ b/drivers/ptp/ptp_ines.c
> @@ -237,11 +237,9 @@ static struct ines_port *ines_find_port(struct device_node *node, u32 index)
>  {
>  	struct ines_port *port = NULL;
>  	struct ines_clock *clock;
> -	struct list_head *this;
>  
>  	mutex_lock(&ines_clocks_lock);
> -	list_for_each(this, &ines_clocks) {
> -		clock = list_entry(this, struct ines_clock, list);
> +	list_for_each_entry(clock, &ines_clocks, list) {
>  		if (clock->node == node) {
>  			port = &clock->port[index];
>  			break;
> -- 
> 2.34.1
> 

Nice
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

