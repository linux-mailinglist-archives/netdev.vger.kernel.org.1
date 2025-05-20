Return-Path: <netdev+bounces-191971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC8FABE0ED
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4181C1BA6836
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCB267F5C;
	Tue, 20 May 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kldIzCyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5F24A076;
	Tue, 20 May 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759425; cv=none; b=gNYUzSxkdyQoqk5/39cq4edK6wUMINO/O6D2gwycaotK4m4mNeQqe3CTdAeMKXZz9Zze3Eg06C+nq43cgngLL13mRM+o+A9MUcgZaVYogWNxlL2cCuj5+NUDW2QT1uOpKCNxifx9xQR0kbMrlPYEU2monqdFA82FCjk6TenE81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759425; c=relaxed/simple;
	bh=dhITEbXnPvgxwrrtbQCh7Ba4RjLia7RhjOjlcd3lwfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toe/W5ZV1KekLUAFm0cU75kYj42h0T9GYJarpGNmK/+NRqT6SbjqBbzv2mmSL8qUcm6nz6BRKDDu0A+FH7RRXeDJjhept7YJ/to7MvICcbeNo6vQwxsvNtHZup0dKKKE+68UQdiGQ1uS6bayWxQezL978Z23VMgkc2FsR+kzXyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kldIzCyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB30C4CEE9;
	Tue, 20 May 2025 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747759424;
	bh=dhITEbXnPvgxwrrtbQCh7Ba4RjLia7RhjOjlcd3lwfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kldIzCyb7uZjDGXJ8CfzKS0eVN6dKSfUk96ciPwwjqXIlRzMaXDTNByI8x6o7wPTt
	 b8S+wWB3uanSHVfjOOYB1hdCJu6OMf1TjqW7CPfiuBQXb+tus2P3BNxDrSreZXMduG
	 2/zZ5yInQ60GsbZK1DxtHahgsG41IiVX9frINxDi1o1I4aOu1Xy+wpOFE36Qm8aUhB
	 eCghZkKmEno+rTs3YdsWNA/qm43ZA+UFG54o9BX4K7Wsc/vSxHfybmNTzB7Bx62Vza
	 /PUrZiMwOEL5W0cGQJDki4R5tIUjiNgppTF9ud6Mjt++FPLeSILsoYQRbMLv62azjC
	 ULbcajpCd0FEw==
Date: Tue, 20 May 2025 17:43:39 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net] octeontx2-pf: QOS: Fix HTB queue deletion on reboot
Message-ID: <20250520164339.GC365796@horms.kernel.org>
References: <20250520073523.1095939-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520073523.1095939-1-hkelam@marvell.com>

On Tue, May 20, 2025 at 01:05:23PM +0530, Hariprasad Kelam wrote:
> During a system reboot, the interface receives TC_HTB_LEAF_DEL
> and TC_HTB_LEAF_DEL_LAST callbacks to delete its HTB queues.
> In the case of TC_HTB_LEAF_DEL_LAST, although the same send queue
> is reassigned to the parent, the current logic still attempts to update
> the real number of queues, leadning to below warnings
> 
>         New queues can't be registered after device unregistration.
>         WARNING: CPU: 0 PID: 6475 at net/core/net-sysfs.c:1714
>         netdev_queue_update_kobjects+0x1e4/0x200
> 
> Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> index 35acc07bd964..5765bac119f0 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
> @@ -1638,6 +1638,7 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
>  	if (!node->is_static)
>  		dwrr_del_node = true;
>  
> +	WRITE_ONCE(node->qid, OTX2_QOS_QID_INNER);

Hi Hariprasad,

Perhaps a comment is warranted regarding the line above.
It would probably be more valuable than the one on the line below.

>  	/* destroy the leaf node */
>  	otx2_qos_disable_sq(pfvf, qid);
>  	otx2_qos_destroy_node(pfvf, node);
> @@ -1682,9 +1683,6 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
>  	}
>  	kfree(new_cfg);
>  
> -	/* update tx_real_queues */
> -	otx2_qos_update_tx_netdev_queues(pfvf);
> -
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
> 

