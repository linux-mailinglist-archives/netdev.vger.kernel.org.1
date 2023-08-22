Return-Path: <netdev+bounces-29540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57697783B04
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D65280FAB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260A79E1;
	Tue, 22 Aug 2023 07:34:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876979C8
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE48C433C8;
	Tue, 22 Aug 2023 07:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692689687;
	bh=oxQbiNHPPL5Ra9rcNS2rY4ojro1sEBcpxMVbL5Q2w5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+vUNjjby7BrJNsWV1vwN4Q9JN5bEBM+CJ16mxPL9z83MsZ/UBmfwIztnDCcXU9Bi
	 Fd5Zl/UWEGluTz0cGo6/hxkgOhwUGfbaYSYGwomMMxxrnayGkFVgalh7UrulA38KqZ
	 6rUImbES+7eRG9EEnGT5iESRkHmgiEoPpmig0FIZzLRXSr/n/kUfBy4SX9whhh9/2r
	 3k8pmbyfwLMizi1UpamR6q93mt4R+Yn1i+CombqoQJMhiEcfhcsSS5iHEuMzQyh6dd
	 lKLYJ6XH+X4jJ4L1jZxgP/k2mImbzzoJiSbHYCUz6afyrV1bHoZVnleikeb90V/mSU
	 qzfuALe3dI7DA==
Date: Tue, 22 Aug 2023 09:34:42 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Alessio Igor Bogani <alessio.bogani@elettra.eu>,
	richardcochran@gmail.com, leon@kernel.org, rrameshbabu@nvidia.com,
	Arpana Arland <arpanax.arland@intel.com>
Subject: Re: [PATCH net] igb: Avoid starting unnecessary workqueues
Message-ID: <20230822073442.GQ2711035@kernel.org>
References: <20230821171927.2203644-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821171927.2203644-1-anthony.l.nguyen@intel.com>

On Mon, Aug 21, 2023 at 10:19:27AM -0700, Tony Nguyen wrote:
> From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> 
> If ptp_clock_register() fails or CONFIG_PTP isn't enabled, avoid starting
> PTP related workqueues.
> 
> In this way we can fix this:
>  BUG: unable to handle page fault for address: ffffc9000440b6f8
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 100000067 P4D 100000067 PUD 1001e0067 PMD 107dc5067 PTE 0
>  Oops: 0000 [#1] PREEMPT SMP
>  [...]
>  Workqueue: events igb_ptp_overflow_check
>  RIP: 0010:igb_rd32+0x1f/0x60
>  [...]
>  Call Trace:
>   igb_ptp_read_82580+0x20/0x50
>   timecounter_read+0x15/0x60
>   igb_ptp_overflow_check+0x1a/0x50
>   process_one_work+0x1cb/0x3c0
>   worker_thread+0x53/0x3f0
>   ? rescuer_thread+0x370/0x370
>   kthread+0x142/0x160
>   ? kthread_associate_blkcg+0xc0/0xc0
>   ret_from_fork+0x1f/0x30
> 
> Fixes: 1f6e8178d685 ("igb: Prevent dropped Tx timestamps via work items and interrupts.")
> Fixes: d339b1331616 ("igb: add PTP Hardware Clock code")
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


