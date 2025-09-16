Return-Path: <netdev+bounces-223593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C76B59A06
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F20B44E1C35
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79755341ADD;
	Tue, 16 Sep 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrxxq7Kk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A4341AD7;
	Tue, 16 Sep 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032918; cv=none; b=DRcDW/sb7DY9tLys4jGx7uG92NtkJLR3R0uRaMNmSHJSVWs3LCqdL6SCq3W8OyZuGzbOFI3Ti9L28iKvWgmpwirMW5igCpY/FdwYr0xEuqoRvf3utvsAbyK6K43eOReO7UYTROCFFnS/jggg3TH3cvNB4zyxO/50xZ0CnKya3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032918; c=relaxed/simple;
	bh=z2iwVZWwpi2k/XJPXGoIuUaBhtT0+iS7WhfhmpkrmV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTie0AA+4vJUSITGMgNhtThq+WJKSziyzr01clofT0ZYxGaEtyPeLJI3BzDA/F8Lt/AjBM88alRKHpKv+PQ2lbQa5nELjZwHAu3TsjrAyOz5i+MUsbax3vVkFBPB2tSApDBkhE8oqFUDINj1//SDCsQcLhSfIyBUQgcuRXWmUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lrxxq7Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C38C4CEEB;
	Tue, 16 Sep 2025 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758032918;
	bh=z2iwVZWwpi2k/XJPXGoIuUaBhtT0+iS7WhfhmpkrmV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lrxxq7KkVgeFMiArXcPYxSIbeH/ImLWFW76CqSviQPK3FHCnJZ8AzA7C3qWyzM9Vr
	 zzVCpuHi4EkXYbD/bhQOU9ySOYs8ekAmrfl3IJzo5vpcMwjMjDw5Af0lopuTNug+MN
	 XfYv6CMdocGVn4jHWPz39/M0YRPmjd6MbmzkqB24zjPWqbyyskZ8o1p1dzRuCPClnH
	 wyE5uTqV46VKJJ93V4zLgd51BOb6uY0MPzGAywjwkEzkK39E8l1lU++o0i0fzgIO2G
	 wdJfVIZocSDuVDpaSnw8zdl0xzyM2s41nRaotXXz5wgVz09N59DKzf5assXrI1XbO9
	 m5cdu4A0ABM8g==
Date: Tue, 16 Sep 2025 07:28:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Subject: Re: [PATCH v2 net] cnic: Fix use-after-free bugs in
 cnic_delete_task
Message-ID: <20250916072836.239631ef@kernel.org>
In-Reply-To: <20250916130818.13617-1-duoming@zju.edu.cn>
References: <20250916130818.13617-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 21:08:18 +0800 Duoming Zhou wrote:
> The original code uses cancel_delayed_work() in cnic_cm_stop_bnx2x_hw(),
> which does not guarantee that the delayed work item 'delete_task' has
> fully completed if it was already running. Additionally, the delayed work
> item is cyclic, the flush_workqueue() in cnic_cm_stop_bnx2x_hw() only
> blocks and waits for work items that were already queued to the
> workqueue prior to its invocation. Any work items submitted after
> flush_workqueue() is called are not included in the set of tasks that the
> flush operation awaits. This means that after the cyclic work items have
> finished executing, a delayed work item may still exist in the workqueue.
> This leads to use-after-free scenarios where the cnic_dev is deallocated
> by cnic_free_dev(), while delete_task remains active and attempt to
> dereference cnic_dev in cnic_delete_task().
> 
> A typical race condition is illustrated below:
> 
> CPU 0 (cleanup)              | CPU 1 (delayed work callback)
> cnic_netdev_event()          |
>   cnic_stop_hw()             | cnic_delete_task()
>     cnic_cm_stop_bnx2x_hw()  | ...
>       cancel_delayed_work()  | /* the queue_delayed_work()
>       flush_workqueue()      |    executes after flush_workqueue()*/
>                              | queue_delayed_work()
>   cnic_free_dev(dev)//free   | cnic_delete_task() //new instance
>                              |   dev = cp->dev; //use
> 
> Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
> that the cyclic delayed work item is properly canceled and any executing
> delayed work has finished before the cnic_dev is deallocated.

Once again, you must include how you discovered and tested the patch
in the commit message.

> Fixes: fdf24086f475 ("cnic: Defer iscsi connection cleanup")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - Make commit messages more clearer.
> 
>  drivers/net/ethernet/broadcom/cnic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
> index a9040c42d2ff..73dd7c25d89e 100644
> --- a/drivers/net/ethernet/broadcom/cnic.c
> +++ b/drivers/net/ethernet/broadcom/cnic.c
> @@ -4230,7 +4230,7 @@ static void cnic_cm_stop_bnx2x_hw(struct cnic_dev *dev)
>  
>  	cnic_bnx2x_delete_wait(dev, 0);
>  
> -	cancel_delayed_work(&cp->delete_task);
> +	cancel_delayed_work_sync(&cp->delete_task);
>  	flush_workqueue(cnic_wq);

You should delete the flush, it was supposed to prevent the issue
you're now resolving with the _sync().

>  	if (atomic_read(&cp->iscsi_conn) != 0)


