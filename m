Return-Path: <netdev+bounces-37281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F87B4851
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AE916282216
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689011802E;
	Sun,  1 Oct 2023 15:12:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D505247
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 15:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C857C433C8;
	Sun,  1 Oct 2023 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696173126;
	bh=B+V4Re6gHExhh6CZBWJPVbyky21mvna8dqRi1wHAURg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVRKZKxeDaMuEnKN3c6urXg7JyHLBbPWMOuazbJaugKvo65i30iF7xGRiLy8hFgmC
	 ocniB6Bx1Od9u+ExhB4O0vorACw5Yh5Einv2WGHHwK2uBn3kF4CbEhiFeNpqGQD7y1
	 xuVhkp/J7dRNGjUHH4XdYtcsXHO79PdBzme++483ksB5dU1rUPyicNAFEWAPMgbbOH
	 aTeZnxfd964F7Vow+D3AHDqfNXTO2p4BZCFMse/oN1tql2L+QSxOf3i3FZ24DALT5u
	 wrkXm8yBIitNCLcq+Lla4xku2u8iXxQ8RvFWHoQGhoVIqDZC9p+c7cMRtgdBQWDiPe
	 dHY51MALiLP4w==
Date: Sun, 1 Oct 2023 17:12:02 +0200
From: Simon Horman <horms@kernel.org>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 3/3] ptp: support event queue reader channel
 masks
Message-ID: <20231001151202.GQ92317@kernel.org>
References: <20230928133544.3642650-1-reibax@gmail.com>
 <20230928133544.3642650-4-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928133544.3642650-4-reibax@gmail.com>

On Thu, Sep 28, 2023 at 03:35:44PM +0200, Xabier Marquiegui wrote:
> Implement ioctl to support filtering of external timestamp event queue
> channels per reader based on the process PID accessing the timestamp
> queue.
> 
> Can be tested using testptp test binary. Use lsof to figure out readers
> of the DUT. LSB of the timestamp channel mask is channel 0.
> 
> eg: To view all current users of the device:
> ```
>  # testptp -F  /dev/ptp0 
> (USER PID)     TSEVQ FILTER ID:MASK
> (3234)              1:0x00000001
> (3692)              2:0xFFFFFFFF
> (3792)              3:0xFFFFFFFF
> (8713)              4:0xFFFFFFFF
> ```
> 
> eg: To allow ID 1 to access only ts channel 0:
> ```
>  # testptp -F 1,0x1
> ```
> 
> eg: To allow ID 1 to access any channel:
> ```
>  # testptp -F 1,0xFFFFFFFF
> ```
> 
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
> Suggested-by: Richard Cochran <richardcochran@gmail.com>

Hi Xabier,

please find some more feedback from Smatch inline.

...

> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c

...

> @@ -169,19 +170,28 @@ long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
>  {
>  	struct ptp_clock *ptp =
>  		container_of(pcuser->clk, struct ptp_clock, clock);
> +	struct ptp_tsfilter tsfilter_set, *tsfilter_get = NULL;
>  	struct ptp_sys_offset_extended *extoff = NULL;
>  	struct ptp_sys_offset_precise precise_offset;
>  	struct system_device_crosststamp xtstamp;
>  	struct ptp_clock_info *ops = ptp->info;
>  	struct ptp_sys_offset *sysoff = NULL;
> +	struct timestamp_event_queue *tsevq;
>  	struct ptp_system_timestamp sts;
>  	struct ptp_clock_request req;
>  	struct ptp_clock_caps caps;
>  	struct ptp_clock_time *pct;
> +	int lsize, enable, err = 0;
>  	unsigned int i, pin_index;
>  	struct ptp_pin_desc pd;
>  	struct timespec64 ts;
> -	int enable, err = 0;
> +
> +	tsevq = pcuser->private_clkdata;
> +
> +	if (tsevq->close_req) {
> +		err = -EPIPE;
> +		return err;
> +	}

Here tseqv is dereferenced unconditionally...

>  
>  	switch (cmd) {
>  
> @@ -481,6 +491,79 @@ long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
>  		mutex_unlock(&ptp->pincfg_mux);
>  		break;
>  
> +	case PTP_FILTERCOUNT_REQUEST:
> +		/* Calculate amount of device users */
> +		if (tsevq) {

... but here it is assumed that tseqv might be NULL.

As flagged by Smatch.

> +			lsize = list_count_nodes(&tsevq->qlist);
> +			if (copy_to_user((void __user *)arg, &lsize,
> +					 sizeof(lsize)))
> +				err = -EFAULT;
> +		}
> +		break;
> +	case PTP_FILTERTS_GET_REQUEST:
> +		/* Read operation */
> +		/* Read amount of entries expected */
> +		if (copy_from_user(&tsfilter_set, (void __user *)arg,
> +				   sizeof(tsfilter_set))) {
> +			err = -EFAULT;
> +			break;
> +		}
> +		if (tsfilter_set.ndevusers <= 0) {
> +			err = -EINVAL;
> +			break;
> +		}
> +		/* Allocate the necessary memory space to dump the requested filter
> +		 * list
> +		 */
> +		tsfilter_get = kzalloc(tsfilter_set.ndevusers *
> +					       sizeof(struct ptp_tsfilter),
> +				       GFP_KERNEL);
> +		if (!tsfilter_get) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +		if (!tsevq) {

Ditto.

> +			err = -EFAULT;
> +			break;
> +		}
> +		/* Set the whole region to 0 in case the current list is shorter than
> +		 * anticipated
> +		 */
> +		memset(tsfilter_get, 0,
> +		       tsfilter_set.ndevusers * sizeof(struct ptp_tsfilter));
> +		i = 0;
> +		/* Format data */
> +		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
> +			tsfilter_get[i].reader_rpid = tsevq->reader_pid;
> +			tsfilter_get[i].reader_oid = tsevq->oid;
> +			tsfilter_get[i].mask = tsevq->mask;
> +			i++;
> +			/* Current list is longer than anticipated */
> +			if (i >= tsfilter_set.ndevusers)
> +				break;
> +		}
> +		/* Dump data */
> +		if (copy_to_user((void __user *)arg, tsfilter_get,
> +				 tsfilter_set.ndevusers *
> +					 sizeof(struct ptp_tsfilter)))
> +			err = -EFAULT;
> +		break;
> +
> +	case PTP_FILTERTS_SET_REQUEST:
> +		/* Write Operation */
> +		if (copy_from_user(&tsfilter_set, (void __user *)arg,
> +				   sizeof(tsfilter_set))) {
> +			err = -EFAULT;
> +			break;
> +		}
> +		if (tsevq) {

Ditto.

> +			list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
> +				if (tsevq->oid == tsfilter_set.reader_oid)
> +					tsevq->mask = tsfilter_set.mask;
> +			}
> +		}
> +		break;
> +
>  	default:
>  		err = -ENOTTY;
>  		break;

...

