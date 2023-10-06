Return-Path: <netdev+bounces-38540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE1F7BB5C5
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF01C20988
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DAC19BCA;
	Fri,  6 Oct 2023 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmuzmjcD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE71C3F
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C19C433C8;
	Fri,  6 Oct 2023 11:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696590088;
	bh=nVonVy/WQophZ3U7CcaAVnOtYQ96wjgbgkQhHearqSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmuzmjcDyZQIvQ6OhpaG7hUN/67fY0MtF52BQJLdzGOfH5jI+4C6PO2joeordrCUQ
	 nPO01lALhOzd5j6PVYuP13VKHqTq/GAv4EJ4IxYPOMHq786Za58Iok1qcccwyYUFa5
	 DZze31LZ/XsR30wth6ICdZCdphuvEIEIXAtCuuFVpY7hQSqVavGY/o+mmDr0nX075y
	 DVV0t0ceEf3FIguI9CvBFbyW9k+6l9XWnDRTYLH2WhOtkVoCCIwnLWc9lWaJoyq6Ht
	 xFlhmFUtUpMDGjClRaZS5xJz/fXVx2k8s3VNlak+qsRhN4H4EoBsK3SCUAe5aEauRZ
	 paleJIua8nDsg==
Date: Fri, 6 Oct 2023 13:01:23 +0200
From: Simon Horman <horms@kernel.org>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, tglx@linutronix.de,
	jstultz@google.com, chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com, ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com, alex.maftei@amd.com, davem@davemloft.net,
	rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v4 4/6] ptp: support event queue reader channel
 masks
Message-ID: <ZR/pA46huaSGgatd@kernel.org>
References: <cover.1696511486.git.reibax@gmail.com>
 <5525d56c5feff9b28c6caa93e03d8f198d7412ce.1696511486.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5525d56c5feff9b28c6caa93e03d8f198d7412ce.1696511486.git.reibax@gmail.com>

On Thu, Oct 05, 2023 at 03:53:14PM +0200, Xabier Marquiegui wrote:
> On systems with multiple timestamp event channels, some readers might
> want to receive only a subset of those channels.
> 
> This patch adds the necessary modifications to support timestamp event
> channel filtering, including two IOCTL operations:
> 
> - Clear all channels
> - Enable one channel
> 
> The mask modification operations will be applied exclusively on the
> event queue assigned to the file descriptor used on the IOCTL operation,
> so the typical procedure to have a reader receiving only a subset of the
> enabled channels would be:
> 
> - Open device file
> - ioctl: clear all channels
> - ioctl: enable one channel
> - start reading
> 
> Calling the enable one channel ioctl more than once will result in
> multiple enabled channels.
> 
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
> Suggested-by: Richard Cochran <richardcochran@gmail.com>
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> v4:
>   - split modifications in different patches for improved organization
>   - filter modifications exclusive to currently open instance for
>     simplicity and security
>   - expand mask to 2048 channels
>   - remove unnecessary tests
> v3: https://lore.kernel.org/netdev/20230928133544.3642650-4-reibax@gmail.com/
>   - filter application by object id, aided by process id
>   - friendlier testptp implementation of event queue channel filters
> v2: https://lore.kernel.org/netdev/20230912220217.2008895-3-reibax@gmail.com/
>   - fix testptp compilation error: unknown type name 'pid_t'
>   - rename mask variable for easier code traceability
>   - more detailed commit message with two examples
> v1: https://lore.kernel.org/netdev/20230906104754.1324412-4-reibax@gmail.com/
> ---
>  drivers/ptp/ptp_chardev.c      | 24 ++++++++++++++++++++++++
>  drivers/ptp/ptp_clock.c        | 12 ++++++++++--
>  drivers/ptp/ptp_private.h      |  3 +++
>  include/uapi/linux/ptp_clock.h |  2 ++
>  4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index abe94bb80cf6..dbbe551a044f 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -110,6 +110,10 @@ int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>  	if (!queue)
>  		return -EINVAL;
> +	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
> +	if (!queue->mask)

Hi Xabier,

queue appears to be leaked here.

As flagged by Smatch.

> +		return -EINVAL;
> +	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
>  	spin_lock_init(&queue->lock);
>  	list_add_tail(&queue->qlist, &ptp->tsevqs);
>  	pccontext->private_clkdata = queue;

