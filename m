Return-Path: <netdev+bounces-16711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EEF74E7A3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2F5281239
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A451A171AC;
	Tue, 11 Jul 2023 07:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A793171A3
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA8DC433C7;
	Tue, 11 Jul 2023 07:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689059034;
	bh=TFhT3g6isM4b41GQrtlRchhnt/MSxszlhVx/64s5FAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SIdonnQOLdB5174647Y4Io8Bggofgk1maWjCIJdDg5PsAmy5AH+OhBGXH0X+zRhx8
	 0UUmdfAsgXWOFE/xsMApshPPPrT79LyMnH8INcRoJaehzdFexINm/fe+yy0dH7bBqi
	 DNdfWFqskKi9Wr9BSrDYMKg28yAKa3CpYS1AeXnyflypfxJXCuDiKvlQWklzgHWK7J
	 cCMNMpR1jDQ7AabO6V77Y6cQvoOmHgdo15v2sJM6UWq5vAdeJocL88B0AoKWKQVBdk
	 EEVkVNTbIrNq8CoCEUqh2NbZExxXbJVoml4tgvE9rhb6f5W8EOTPSTKWqsKxNVMvg1
	 YieQBDWwBPuVg==
Date: Tue, 11 Jul 2023 10:03:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Florian Kauer <florian.kauer@linutronix.de>, kurt@linutronix.de,
	vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net 3/6] igc: Handle already enabled taprio offload for
 basetime 0
Message-ID: <20230711070348.GE41919@unreal>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710163503.2821068-4-anthony.l.nguyen@intel.com>

On Mon, Jul 10, 2023 at 09:35:00AM -0700, Tony Nguyen wrote:
> From: Florian Kauer <florian.kauer@linutronix.de>
> 
> Since commit e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> it is possible to enable taprio offload with a basetime of 0.
> However, the check if taprio offload is already enabled (and thus -EALREADY
> should be returned for igc_save_qbv_schedule) still relied on
> adapter->base_time > 0.
> 
> This can be reproduced as follows:
> 
>     # TAPRIO offload (flags == 0x2) and base-time = 0
>     sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
> 	    num_tc 1 \
> 	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> 	    queues 1@0 \
> 	    base-time 0 \
> 	    sched-entry S 01 300000 \
> 	    flags 0x2
> 
>     # The second call should fail with "Error: Device failed to setup taprio offload."
>     # But that only happens if base-time was != 0
>     sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
> 	    num_tc 1 \
> 	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
> 	    queues 1@0 \
> 	    base-time 0 \
> 	    sched-entry S 01 300000 \
> 	    flags 0x2
> 
> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

