Return-Path: <netdev+bounces-81276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5F9886C97
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 14:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16961C2114D
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B3A446B6;
	Fri, 22 Mar 2024 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2s/kC8s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DC3B2AD
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112963; cv=none; b=GRepzcQfS3NVKC1a9GJKgsY3rQPlqRqTNrNfM9Azc06CZ0luY0C0YChhoWCEaLqGgSWCqXmdhrN8n9dJvdCJIdagYCERQ4lnQZ8G6Qa6xqEmToQ7b4vXnkW6YodQSqUyk+HS2nK6NyN3/acENbi5nr5nm4ODBc6rlHNd7AGGSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112963; c=relaxed/simple;
	bh=lSFgrfIG14QdtpDlr1nh6gwDIDmJROxlu+q2g6emlHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baQWTIud1RiSGg/aLSWFyBRNkNifoGql/syzj/jRRfI3RF+rOr8Z2xCs9LOWGzxr1cpo/448Ktf2rXg0hKd0my/7YbO5kDT7pIrIWBDTJeu1BEPyckoE6WLbeRB+bQUSzpY1FCOEvGseo0r3UN/m9c/FXaZP//3qpwbaxm/Kb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2s/kC8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBC8C433C7;
	Fri, 22 Mar 2024 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711112962;
	bh=lSFgrfIG14QdtpDlr1nh6gwDIDmJROxlu+q2g6emlHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2s/kC8sEJS4254w2QuudVcNv0HwuQYqZTbZdq61NBGddvNNfmKTxDlI5G+x7BJ6d
	 VmwOyVu9Ngevmm7CCrkuZpwp71/6AJi+PzPwJ+hc3BezaIcsPXnuyNIY9DAYGPIDoa
	 2I64OnwdSESMS+RweR46K9AVhDFOQ0AxsvZ3Sr4t0fYeR982tejF86fHfs4i8OSR0b
	 sZL+Ltbutmz05M76zz1042IJm/CB0NdxuOZOFSCqkXsTjwFcdD7OlUJAgcK/GL5/rb
	 E8asMg8rxbyaeVb2IfY98ltMdheOkpZou8WRTPz9qlq5QgFM8kn5un8jj+ttEFXplk
	 3nRGyYoULd8+Q==
Date: Fri, 22 Mar 2024 13:09:20 +0000
From: Simon Horman <horms@kernel.org>
To: John Fraker <jfraker@google.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] gve: Add counter adminq_get_ptype_map_cnt to stats
 report
Message-ID: <20240322130920.GF372561@kernel.org>
References: <20240321222020.31032-1-jfraker@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321222020.31032-1-jfraker@google.com>

On Thu, Mar 21, 2024 at 03:20:20PM -0700, John Fraker wrote:
> This counter counts the number of times get_ptype_map is executed on the
> admin queue, and was previously missing from the stats report.
> 
> Fixes: c4b87ac87635 ("gve: Add support for DQO RX PTYPE map")
> Signed-off-by: John Fraker <jfraker@google.com>

Hi John,

I'm fine with this patch but it feels more like an enhancement
for net-next than a fix for net.

If so, please drop the Fixes tag and repost next week after
net-next has reopened.

> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index 9aebfb843..dbe05402d 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -73,7 +73,7 @@ static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
>  	"adminq_create_tx_queue_cnt", "adminq_create_rx_queue_cnt",
>  	"adminq_destroy_tx_queue_cnt", "adminq_destroy_rx_queue_cnt",
>  	"adminq_dcfg_device_resources_cnt", "adminq_set_driver_parameter_cnt",
> -	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt"
> +	"adminq_report_stats_cnt", "adminq_report_link_speed_cnt", "adminq_get_ptype_map_cnt"

If you do repost, please consider reformatting this so the lines
remain no longer than 80 characters.

>  };
>  
>  static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
> @@ -428,6 +428,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
>  	data[i++] = priv->adminq_set_driver_parameter_cnt;
>  	data[i++] = priv->adminq_report_stats_cnt;
>  	data[i++] = priv->adminq_report_link_speed_cnt;
> +	data[i++] = priv->adminq_get_ptype_map_cnt;
>  }
>  
>  static void gve_get_channels(struct net_device *netdev,
> -- 
> 2.44.0.291.gc1ea87d7ee-goog
> 
> 

