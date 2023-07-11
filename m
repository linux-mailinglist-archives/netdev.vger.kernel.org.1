Return-Path: <netdev+bounces-16717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B8E74E7EF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900002814CE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F0171D7;
	Tue, 11 Jul 2023 07:26:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEF1643F
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5956EC433C8;
	Tue, 11 Jul 2023 07:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689060367;
	bh=7gagTghnHbdnS89ft0SRPtMAku+GMOo4ENlpz1jSnaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5D8O/k6Bv2j9KFP/x+I+2+38XTL83NpDNhCVx0vQIE3mGkCesQJn7itmiRafmHGf
	 kLdZBa0YUc5ct+Yras8ghAFIRFYwg3LGi+FUM5gWESTbBha0QeaRK01y7OPxoqxSfK
	 WOGMbDGr5hIjSIhA163abe6dBNc8nmeKXoDEE0EEAcXokMZTPBHyiIqKBXS7yghK6T
	 LSS77lIMXAbF7j0nKV7fzLjJS/Jey+NC8542G4E/IV0eabznx0eVKw4uivUHUKT5wn
	 ui39sNIxswdxahuME4wLO8DKg++S7VG9Qe++P6vib6MEsoF0Z/pvBljiFm2bjHdNq3
	 h+BiIXwlIavxg==
Date: Tue, 11 Jul 2023 10:26:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Message-ID: <20230711072603.GI41919@unreal>
References: <20230711013621.GE1926@templeofstupid.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711013621.GE1926@templeofstupid.com>

On Mon, Jul 10, 2023 at 06:36:21PM -0700, Krister Johansen wrote:
> The ENA adapters on our instances occasionally reset.  Once recently
> logged a UBSAN failure to console in the process:
> 
>   UBSAN: shift-out-of-bounds in build/linux/drivers/net/ethernet/amazon/ena/ena_com.c:540:13
>   shift exponent 32 is too large for 32-bit type 'unsigned int'
>   CPU: 28 PID: 70012 Comm: kworker/u72:2 Kdump: loaded not tainted 5.15.117
>   Hardware name: Amazon EC2 c5d.9xlarge/, BIOS 1.0 10/16/2017
>   Workqueue: ena ena_fw_reset_device [ena]
>   Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4a/0x63
>   dump_stack+0x10/0x16
>   ubsan_epilogue+0x9/0x36
>   __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
>   ? __const_udelay+0x43/0x50
>   ena_delay_exponential_backoff_us.cold+0x16/0x1e [ena]
>   wait_for_reset_state+0x54/0xa0 [ena]
>   ena_com_dev_reset+0xc8/0x110 [ena]
>   ena_down+0x3fe/0x480 [ena]
>   ena_destroy_device+0xeb/0xf0 [ena]
>   ena_fw_reset_device+0x30/0x50 [ena]
>   process_one_work+0x22b/0x3d0
>   worker_thread+0x4d/0x3f0
>   ? process_one_work+0x3d0/0x3d0
>   kthread+0x12a/0x150
>   ? set_kthread_struct+0x50/0x50
>   ret_from_fork+0x22/0x30
>   </TASK>
> 
> Apparently, the reset delays are getting so large they can trigger a
> UBSAN panic.
> 
> Looking at the code, the current timeout is capped at 5000us.  Using a
> base value of 100us, the current code will overflow after (1<<29).  Even
> at values before 32, this function wraps around, perhaps
> unintentionally.
> 
> Cap the value of the exponent used for this backoff at (1<<16) which is
> larger than currently necessary, but large enough to support bigger
> values in the future.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4bb7f4cf60e3 ("net: ena: reduce driver load time")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_com.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
> index 451c3a1b6255..633b321d7fdd 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> @@ -35,6 +35,8 @@
>  
>  #define ENA_REGS_ADMIN_INTR_MASK 1
>  
> +#define ENA_MAX_BACKOFF_DELAY_EXP 16U
> +
>  #define ENA_MIN_ADMIN_POLL_US 100
>  
>  #define ENA_MAX_ADMIN_POLL_US 5000
> @@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
>  
>  static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
>  {
> +	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

