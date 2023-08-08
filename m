Return-Path: <netdev+bounces-25231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19524773661
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4D11C20DF1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3B659;
	Tue,  8 Aug 2023 02:13:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372537E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19CFC433C7;
	Tue,  8 Aug 2023 02:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691460821;
	bh=hIQVyIVKa1+wJpqh5robkngECkA8ABSIuJqROobHfJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=edC9yk2r/XOjRcTvRytMFoUIb23G/AG33ZeYVn3iv8oLaSuBKOhyN7oV/fyjKnhtX
	 owDadoai/wYzTQcQ1LqhkCWoZsRlkEE/JLozzIl4L/MKarVVmHQHgkga1cLZwYOzud
	 leyFXFALlM2bA31ixh/zx9BUN45St2r674GVej2DOLrkx2oAPLxaexox3ey98o9PPG
	 qsqL+9c9PUfD5sxsZe5rtuBu6XtMVAgBzlX1tZ/yilR/yTvFUpVcpwBOnZse//qtnD
	 ieG85Ky4CRT955VqEiEQsDX1RBF4MJKHUHKQyuE6/OS16yaBrq0ntMZdz096HgdVlb
	 B75Fqi/7IyikQ==
Date: Mon, 7 Aug 2023 19:13:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
 danymadden@us.ibm.com, tlfalcon@linux.ibm.com, bjking1@linux.ibm.com
Subject: Re: [PATCH net 5/5] ibmvnic: Ensure login failure recovery is safe
 from other resets
Message-ID: <20230807191339.709dc247@kernel.org>
In-Reply-To: <20230803202010.37149-5-nnac123@linux.ibm.com>
References: <20230803202010.37149-1-nnac123@linux.ibm.com>
	<20230803202010.37149-5-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Aug 2023 15:20:10 -0500 Nick Child wrote:
> +			do {
> +				reinit_init_done(adapter);
> +				/* Clear any failovers we got in the previous
> +				 * pass since we are re-initializing the CRQ
> +				 */
> +				adapter->failover_pending = false;
> +				release_crq_queue(adapter);
> +				/* If we don't sleep here then we risk an
> +				 * unnecessary failover event from the VIOS.
> +				 * This is a known VIOS issue caused by a vnic
> +				 * device freeing and registering a CRQ too
> +				 * quickly.
> +				 */
> +				msleep(1500);
> +				/* Avoid any resets, since we are currently
> +				 * resetting.
> +				 */
> +				spin_lock_irqsave(&adapter->rwi_lock, flags);
> +				flush_reset_queue(adapter);
> +				spin_unlock_irqrestore(&adapter->rwi_lock,
> +						       flags);
> +
> +				rc = init_crq_queue(adapter);
> +				if (rc) {
> +					netdev_err(netdev, "login recovery: init CRQ failed %d\n",
> +						   rc);
> +					return -EIO;
> +				}
>  
> -			rc = ibmvnic_reset_init(adapter, false);
> -			if (rc) {
> -				netdev_err(netdev, "login recovery: Reset init failed %d\n",
> -					   rc);
> -				return -EIO;
> -			}
> +				rc = ibmvnic_reset_init(adapter, false);
> +				if (rc)
> +					netdev_err(netdev, "login recovery: Reset init failed %d\n",
> +						   rc);
> +				/* IBMVNIC_CRQ_INIT will return EAGAIN if it
> +				 * fails, since ibmvnic_reset_init will free
> +				 * irq's in failure, we won't be able to receive
> +				 * new CRQs so we need to keep trying. probe()
> +				 * handles this similarly.
> +				 */
> +			} while (rc == -EAGAIN);

Isn't this potentially an infinite loop? Can we limit the max number of
iterations here or something already makes this loop safe?

