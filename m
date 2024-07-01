Return-Path: <netdev+bounces-108108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AA191DDBD
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC75B2352B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251113D2A2;
	Mon,  1 Jul 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB7CP+HH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7C1F949
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832904; cv=none; b=NbXuRIYGGLC9THklgxCq6mEPENnvK4pJIgjnSgyDPuXvntPHeSkuuinmDVkK2/3CYXYH2ELHvD9C4OZHe3bt5NTxxxwczPu/Gzh1Tm08PJvm8dHH+RCc1UeRbp0KYfHux2ZaURPoZs7ZTTxVv5UrSYcZZze04L91ax/lHcQW0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832904; c=relaxed/simple;
	bh=wcsrJ5Bds/VPXom9wcJNqof36kg/8nRfkjOFlgfr1fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFT7RqH3D09PjFdSCDGIpd3qo48AuIDf9AcaYZXZPRTmNCk/M8dnBNhYHSayaff8As4w2eY5hLR0KopJ8DETw4s2sugwdcr53bbrVH/A6U9jK4ZzJ+Hf5S2gx8DG2GEoS8Q+qrbqRjDhFRUtKVGVwasYM3+Cj55HR2REvcM6HmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB7CP+HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749F9C4AF0E;
	Mon,  1 Jul 2024 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719832904;
	bh=wcsrJ5Bds/VPXom9wcJNqof36kg/8nRfkjOFlgfr1fU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TB7CP+HHbtIHH/dQveRzeD1QzzeNJSGX6ANXx/ZREajoyfjS2AGQIzCFhwhnoo8xE
	 +Ot+toaXU03Yx0Hwud1VtVb/2wfkLV+Civ2yyVf/krPZz9PjjtanFcWXUCdsDoAC2N
	 sjvWloJmGBHNoqnTGmqJFltz6o8wAETptEuUNGpcKA98PGtcLyDNRAQgrsnAE1tJBV
	 M1dJVfeVKJeFo/Smg1/vLVOwxeGTplKXA77AyCoSJ+QKil6qM3zwIzVma1mL5PkN4w
	 ldMKnSs3Rs4dvdkcfGBCFAUQAHgY4AvXW/xyca3QdfzEwL/yjjE7lQKc4h2Ed/IdzO
	 SBR+dPa4GH15w==
Date: Mon, 1 Jul 2024 12:21:39 +0100
From: Simon Horman <horms@kernel.org>
To: Rushil Gupta <rushilg@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, willemb@google.com, hramamurthy@google.com,
	Shailend Chand <shailend@google.com>,
	Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [PATCH] gve: Add retry logic for recoverable adminq errors
Message-ID: <20240701112139.GX17134@kernel.org>
References: <20240628185446.262191-1-rushilg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628185446.262191-1-rushilg@google.com>

On Fri, Jun 28, 2024 at 06:54:46PM +0000, Rushil Gupta wrote:
> From: Jeroen de Borst <jeroendb@google.com>
> 
> An adminq command is retried if it fails with an ETIME error code
> which translates to the deadline exceeded error for the device.
> The create and destroy adminq commands are now managed via a common
> method. This method keeps track of return codes for each queue and retries
> the commands for the queues that failed with ETIME.
> Other adminq commands that do not require queue level granularity are
> simply retried in gve_adminq_execute_cmd.
> 
> Signed-off-by: Rushil Gupta <rushilg@google.com>
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Reviewed-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Ziwei Xiao <ziweixiao@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 197 ++++++++++++-------
>  drivers/net/ethernet/google/gve/gve_adminq.h |   5 +
>  2 files changed, 129 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c

Hi Rushil,

Some minor feedback from my side.

...

> +static int gve_adminq_manage_queues(struct gve_priv *priv,
> +				    gve_adminq_queue_cmd *cmd,
> +				    u32 start_id, u32 num_queues)
> +{
> +	u32 cmd_idx, queue_idx, ret_code_idx;
> +	int queue_done = -1;
> +	int *queues_waiting;
> +	int retry_cnt = 0;
> +	int retry_needed;
> +	int *ret_codes;
> +	int *commands;
> +	int err;
> +	int ret;
> +
> +	queues_waiting = kvcalloc(num_queues, sizeof(int), GFP_KERNEL);
> +	if (!queues_waiting)
> +		return -ENOMEM;
> +	ret_codes = kvcalloc(num_queues, sizeof(int), GFP_KERNEL);
> +	if (!ret_codes) {
> +		err = -ENOMEM;
> +		goto free_with_queues_waiting;
> +	}
> +	commands = kvcalloc(num_queues, sizeof(int), GFP_KERNEL);
> +	if (!commands) {
> +		err = -ENOMEM;
> +		goto free_with_ret_codes;
> +	}
> +
> +	for (queue_idx = 0; queue_idx < num_queues; queue_idx++)
> +		queues_waiting[queue_idx] = start_id + queue_idx;
> +	do {
> +		retry_needed = 0;
> +		queue_idx = 0;
> +		while (queue_idx < num_queues) {
> +			cmd_idx = 0;
> +			while (queue_idx < num_queues) {
> +				if (queues_waiting[queue_idx] != queue_done) {
> +					err = cmd(priv, queues_waiting[queue_idx]);

It looks like this line, and some others in this patch, could trivially
be wrapped so they are no longer than 80 columns wide. As is still
preferred for networking code.

Flagged by checkpatch.pl --max-line-length=80

> +					if (err == -ENOMEM)
> +						break;
> +					if (err)
> +						goto free_with_commands;
> +					commands[cmd_idx++] = queue_idx;
> +				}
> +				queue_idx++;
> +			}
> +
> +			if (queue_idx < num_queues)
> +				dev_dbg(&priv->pdev->dev,
> +					"Issued %d of %d batched commands\n",
> +					queue_idx, num_queues);
> +
> +			err = gve_adminq_kick_and_wait(priv, cmd_idx, ret_codes);
> +			if (err)
> +				goto free_with_commands;
> +
> +			for (ret_code_idx = 0; ret_code_idx < cmd_idx; ret_code_idx++) {
> +				if (ret_codes[ret_code_idx] == 0) {
> +					queues_waiting[commands[ret_code_idx]] = queue_done;
> +				} else if (ret_codes[ret_code_idx] != -ETIME) {
> +					ret = ret_codes[ret_code_idx];
> +					goto free_with_commands;
> +				} else {
> +					retry_needed++;
> +				}
> +			}
> +
> +			if (retry_needed)
> +				dev_dbg(&priv->pdev->dev,
> +					"Issued %d batched commands, %d needed a retry\n",
> +					cmd_idx, retry_needed);
> +		}
> +	} while (retry_needed && ++retry_cnt < GVE_ADMINQ_RETRY_COUNT);
> +
> +	ret = retry_needed ? -ETIME : 0;
> +
> +free_with_commands:
> +	kvfree(commands);
> +	commands = NULL;
> +free_with_ret_codes:
> +	kvfree(ret_codes);
> +	ret_codes = NULL;
> +free_with_queues_waiting:
> +	kvfree(queues_waiting);
> +	queues_waiting = NULL;
> +	if (err)
> +		return err;

I'm unsure if this can occur in practice, because it seems to depend
on the do loop above running , but cmd() not being executed at all.
However, FWIIW, Smatch flags that err may be used uninitialised here.

> +	return ret;
> +}

...

