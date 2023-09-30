Return-Path: <netdev+bounces-37188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790067B4203
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A00811C20956
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8725617996;
	Sat, 30 Sep 2023 16:14:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653523D8
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 16:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F11C433C8;
	Sat, 30 Sep 2023 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696090478;
	bh=MqO0aeyCzwGjYjLSV1SulI5oIkludvo2w2vvpfZBR5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHaXyUqb5u19NSeivZVuqsGLERwCFQVtvOSZ6WKeXWj8sZJ91a1IYj6qouew6kPjI
	 xic8ZhHrlWpBTQRI75wHUDuR0HCvOcw+RALr8TcWA0b4NYJ7B9hJEaecUMVc0zUzBo
	 xL9BwgWwTfzYsqBM7fiNNoFTpWIVmEpbD1ecY8PUIywsl6rYpabOdJjlCRxyHnDIMW
	 obFboj9ouQBWtT6atC//ZwtkNCNWFzxJ3C4pgUuuxUW+ThIsRz6QCvtyjgPbLBHBJQ
	 qXX1u3opw0VoTMXSqydg3hpaA9yRrVoLFDjMbbwPrOJe0G6RzF50c+G5k0PGSzb6YM
	 Z1f6WflMt+f8A==
Date: Sat, 30 Sep 2023 18:14:34 +0200
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jreuter@yaina.de, ralf@linux-mips.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <20230930161434.GC92317@kernel.org>
References: <20230926105732.10864-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926105732.10864-1-dg573847474@gmail.com>

On Tue, Sep 26, 2023 at 10:57:32AM +0000, Chengfeng Ye wrote:
> Timer interrupt ax25_ds_timeout() could introduce double locks on
> &ax25_list_lock.
> 
> ax25_ioctl()
> --> ax25_ctl_ioctl()
> --> ax25_dama_off()
> --> ax25_dev_dama_off()
> --> ax25_check_dama_slave()
> --> spin_lock(&ax25_list_lock)
> <timer interrupt>
>    --> ax25_ds_timeout()
>    --> spin_lock(&ax25_list_lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch use spin_lock_bh()
> on &ax25_list_lock inside ax25_check_dama_slave().
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Hi Chengfeng Ye,

thanks for your patch.

As a fix for Networking this should probably be targeted at the
'net' tree. Which should be denoted in the subject.

        Subject: [PATCH net] ...

And as a fix this patch should probably have a Fixes tag.
This ones seem appropriate to me, but I could be wrong.

Fixes: c070e51db5e2 ("ice: always add legacy 32byte RXDID in supported_rxdids")

I don't think it is necessary to repost just to address these issues,
but the Networking maintainers may think otherwise.

The code change itself looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/ax25/ax25_ds_subr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ax25/ax25_ds_subr.c b/net/ax25/ax25_ds_subr.c
> index f00e27df3c76..010b11303d32 100644
> --- a/net/ax25/ax25_ds_subr.c
> +++ b/net/ax25/ax25_ds_subr.c
> @@ -156,13 +156,13 @@ static int ax25_check_dama_slave(ax25_dev *ax25_dev)
>  	ax25_cb *ax25;
>  	int res = 0;
>  
> -	spin_lock(&ax25_list_lock);
> +	spin_lock_bh(&ax25_list_lock);
>  	ax25_for_each(ax25, &ax25_list)
>  		if (ax25->ax25_dev == ax25_dev && (ax25->condition & AX25_COND_DAMA_MODE) && ax25->state > AX25_STATE_1) {
>  			res = 1;
>  			break;
>  		}
> -	spin_unlock(&ax25_list_lock);
> +	spin_unlock_bh(&ax25_list_lock);
>  
>  	return res;
>  }
> -- 
> 2.17.1
> 
> 

