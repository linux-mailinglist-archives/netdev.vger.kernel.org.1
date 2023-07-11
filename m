Return-Path: <netdev+bounces-16713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46AE74E7AE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49161C20C89
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF97171B4;
	Tue, 11 Jul 2023 07:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603B168CE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444A4C433C7;
	Tue, 11 Jul 2023 07:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689059348;
	bh=2ltyhvEDkt3GQftVF4Dl9AUBYTZE4uZHgxZ6qJnCGTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rj+/J3c0LiCksiu6kXc8cie5xkB1G3WSxlfTgLGk4/rka4Jvk5ZZjqMpUG8//37Xq
	 QZ9AwIVzMc6frx9VAX6iLQXKg9jvfacrAiTpHz9Ck7LnT+reVVqlnDDCnLEAZIfF+M
	 cni92wxLtHTqURGleLR/pngGRx2wpuVT1OGXd3eQ2AVhLr8y0OUjASeBsjJIaTjUmK
	 R4zUmVfDoQ6k7DpUKZFLfGJYjw8gXyj64QLjXK6VsepViiIaSYrIPH4p0wDhdLX11F
	 xPdG7cuPN4MEGGGlzljBLw04Tt//kHtEFnDeuI0/b1Z6q3QIAhTe6aJ+uhBqWFhFWU
	 RK32nxHyT622A==
Date: Tue, 11 Jul 2023 10:09:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Florian Kauer <florian.kauer@linutronix.de>, kurt@linutronix.de,
	vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 5/6] igc: Fix launchtime before start of cycle
Message-ID: <20230711070902.GF41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710163503.2821068-6-anthony.l.nguyen@intel.com>

On Mon, Jul 10, 2023 at 09:35:02AM -0700, Tony Nguyen wrote:
> From: Florian Kauer <florian.kauer@linutronix.de>
> 
> It is possible (verified on a running system) that frames are processed
> by igc_tx_launchtime with a txtime before the start of the cycle
> (baset_est).
> 
> However, the result of txtime - baset_est is written into a u32,
> leading to a wrap around to a positive number. The following
> launchtime > 0 check will only branch to executing launchtime = 0
> if launchtime is already 0.
> 
> Fix it by using a s32 before checking launchtime > 0.
> 
> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 5d24930fed8f..4855caa3bae4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1016,7 +1016,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
>  	ktime_t base_time = adapter->base_time;
>  	ktime_t now = ktime_get_clocktai();
>  	ktime_t baset_est, end_of_cycle;
> -	u32 launchtime;
> +	s32 launchtime;

The rest of igc_tx_launchtime() function is very questionable,
as ktime_sub_ns() returns ktime_t which is s64.

  1049         launchtime = ktime_sub_ns(txtime, baset_est);
  1050         if (launchtime > 0)
  1051                 div_s64_rem(launchtime, cycle_time, &launchtime);
  1052         else
  1053                 launchtime = 0;
  1054
  1055         return cpu_to_le32(launchtime);


>  	s64 n;
>  
>  	n = div64_s64(ktime_sub_ns(now, base_time), cycle_time);
> -- 
> 2.38.1
> 
> 

