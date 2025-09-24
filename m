Return-Path: <netdev+bounces-226065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94480B9B8EC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6B43B531F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AE3313D72;
	Wed, 24 Sep 2025 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCwnx/sL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC142D6E60;
	Wed, 24 Sep 2025 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739496; cv=none; b=SRwjJExzyZYQfemEB7kbbRKMPLBv3axliJG+UVAoEXFIDVWBNYa1dPLssbfOL0b7eGLCeGkSgXfFKlqs8cwsAZ0F4JqgcsI35+8v+9+DqDJ677cA5WZnNr5loLu0O5xuvzaJe4xFhF/wm9VkKaKcQTMLEElLBgCVOUGD2k//8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739496; c=relaxed/simple;
	bh=s3dRdq6PwgkIrk5+XJTGO5HasYdONCC+41QAVNIIa+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6W7zrEVnOO+uKw9XXjkr02sIvylb0TSgaIp11pOLb22MyTOVLFYZr1KszK9GL88sY/SU2uQ3JutEAgrn1ocvMg/J7EGRN38mp+Azi2eectXr6qvYGar1wsO8nwE6agaUcqVzkjRmyomftfcg+/T6ojuYcJCGm+qb7fmRgETObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCwnx/sL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A7C4CEE7;
	Wed, 24 Sep 2025 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758739495;
	bh=s3dRdq6PwgkIrk5+XJTGO5HasYdONCC+41QAVNIIa+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCwnx/sLppLAlEsG2RZHdRFC7/llTJBhKjGnRmH3vGrJUJZXaydMBt55KiV5MxBrc
	 Vq9Y/ViYVDOd5bKoT6Gb+OODb96hSVVRgWN/O+D6IFZ66fqayXFXClus6RAdkkAGFQ
	 yYWarW74B4mJyZYuFAg6XBC1iusz6xzYCJoz3eDQ/+ZS16CHMG/HtUu6tVT82zYjLF
	 JPrBJT45JdbvGJJWn2sheXg59u2YWyTj26yXsOEI2+m8Xoppr6tIJe6yWTupHyCz4U
	 spEG4sykcrRsmaBsqEHpTm3js4CKysLrZnZ1284NQSNbXMhWmlx3NIbpmgNLSypGT/
	 AOAbDs8os+kCw==
Date: Wed, 24 Sep 2025 19:44:51 +0100
From: Simon Horman <horms@kernel.org>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, pwn9uin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
Subject: Re: [PATCH] Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
Message-ID: <20250924184451.GT836419@horms.kernel.org>
References: <20250923132427.74242-1-deepak.sharma.472935@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923132427.74242-1-deepak.sharma.472935@gmail.com>

On Tue, Sep 23, 2025 at 06:54:27PM +0530, Deepak Sharma wrote:
> Syzbot reported a warning at `add_timer`, which is called from the
> `atm_mpoa_mpoad_attach` function
> 
> The reason for this warning is that in the allocation failure by `alloc_mpc`,
> there is lack of proper cleanup. And in the event that ATMMPC_CTRL ioctl is
> called on to again, it will lead to the attempt of starting an already 
> started timer from the previous ioctl call
> 
> Do a `timer_delete` before returning from the `alloc_mpc` failure
> 
> Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
> ---
>  net/atm/mpc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index f6b447bba329..cd3295c3c480 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -814,7 +814,10 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
>  		dprintk("allocating new mpc for itf %d\n", arg);
>  		mpc = alloc_mpc();
>  		if (mpc == NULL)
> +		{

Sorry for not mentioning this in my previous email.

The preferred coding style is:

		if (mpc == NULL) {

> +			timer_delete(&mpc_timer);
>  			return -ENOMEM;
> +		}
>  		mpc->dev_num = arg;
>  		mpc->dev = find_lec_by_itfnum(arg);
>  					/* NULL if there was no lec */

-- 
pw-bot: changes-requested

