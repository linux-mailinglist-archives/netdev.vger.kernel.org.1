Return-Path: <netdev+bounces-277432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCAhCScD2WnolAgAu9opvQ
	(envelope-from <netdev+bounces-277432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:03:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C23D86DC
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 16:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18302301E015
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E293CB2FE;
	Fri, 10 Apr 2026 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0vJraMf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E463CB2E9;
	Fri, 10 Apr 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775829797; cv=none; b=LMx8Q6Khs6vMX4vf5XFUFbAtWIMrHDhiIvGmnoMC0d0d+GdD+qAB8lkSbES4/jEPLWbcZUCS64MlWfI4TYJsEMIo63l/cdnfXlfkrLhHt3EB7Dqe99SXkS+Xd5zHO3drhwYmB4cfQRD9oYZKYiNO7F/6VBA7MaJEV1sn6oWhedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775829797; c=relaxed/simple;
	bh=sJxBevO3T4OJZAXvEkwAIL9WQSp8xmDTqSOUnlFdAqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7D8qvISPIoDFdfs2y9RsEXALasIBwj1dFdUov/biMDLqJxkNbkYvxTTIGijpPiVW87TZNcBFk2FHrD6E3DlzvxtCK9HPdMCSO6b3u1csyMmEj8zlNZOX90RX8c5Q/UxnvprgHLHkj5PgEr+1FVLVtO0vhviVHxswx+g1Q+hdsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0vJraMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC82BC19421;
	Fri, 10 Apr 2026 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775829796;
	bh=sJxBevO3T4OJZAXvEkwAIL9WQSp8xmDTqSOUnlFdAqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0vJraMfzIcY+p9Rp0gATVLDpBMmAae0dUH3nvgFsIgjfjd8AWzrCI1INLWvUBsKJ
	 wUQqKjwKF/ZPIlj8dPkIZGoLsQYtD0I6awV0y6k054bWHjDg/gVKeaPV+UPsk+KHx9
	 iOiRLtovN72QhZ6spqeE1NtLSHvcMCB4DBphGlzJhTepPbDpa5b9V7za7BrH9P2hAL
	 gFjLz2iKXnI3JUH3MHaPslw/cURpLf8JzJSLRscTqV7IZVIL22FRoLHvr8LnKHOVp5
	 eNZlVgvgkoH0UoR6cjOIWU7FiWC0y8ORbfDkCM9Dm4lgZ+2spiAVu5PQoXlDNZ8165
	 WZw3qV7gEr98A==
Date: Fri, 10 Apr 2026 15:03:12 +0100
From: Simon Horman <horms@kernel.org>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com
Subject: Re: [PATCH net] atm: mpoa: fix mpc->dev refcount across mpoad restart
Message-ID: <20260410140312.GW469338@kernel.org>
References: <177555091252.59118.13093904987038690781@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177555091252.59118.13093904987038690781@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277432-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,5ec223ccb83b24ef982f];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B29C23D86DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 02:20:12PM +0545, Shuvam Pandey wrote:
> atm: mpoa: fix mpc->dev refcount across mpoad restart
> 
> mpoad_close() drops the reference held in mpc->dev with dev_put(), but
> the mpoa_client stays alive and keeps the same device pointer.
> 
> A later mpoad attach reuses the existing mpoa_client without
> reacquiring that reference, so the next close can hit the netdevice
> refcount warning. Keep the LEC device reference with the mpoa_client
> until the device unregisters or the client is torn down.

Hi Shuvam,

Including the stack trace would be useful, IMHO.

> 
> Reported-by: syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com
> Link: https://groups.google.com/g/syzkaller-bugs/c/qhZ5MJfLBOE/m/UnotmgRdAQAJ

A fixes tag should go here, indicating the commit which introduced
the bug - typically the commit where it first manifested.

> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>  net/atm/mpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index ce8e9780373b..1e9b9c633e8b 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -886,7 +886,6 @@ static void mpoad_close(struct atm_vcc *vcc)
>  		struct lec_priv *priv = netdev_priv(mpc->dev);
>  		priv->lane2_ops->associate_indicator = NULL;
>  		stop_mpc(mpc);
> -		dev_put(mpc->dev);
>  	}
>  
>  	mpc->in_ops->destroy_cache(mpc);

I'm not really familiar with the object life cycle here.

But it strikes me that the purpose of dev_put() in a close callback
is to indicate the device no longer needs to be held for the connection
being closed. And, if so, I wonder if the problem here is that
there is no corresponding dev_hold() in the (unimplemented) open callback.
(I am assuming there is a 1:1 symmetry between open and close.)

> @@ -1508,6 +1507,8 @@ static void __exit atm_mpoa_cleanup(void)
>  			priv = netdev_priv(mpc->dev);
>  			if (priv->lane2_ops != NULL)
>  				priv->lane2_ops->associate_indicator = NULL;
> +			dev_put(mpc->dev);
> +			mpc->dev = NULL;
>  		}
>  		ddprintk("about to clear caches\n");
>  		mpc->in_ops->destroy_cache(mpc);

AI generated review flags that atm_mpoa_cleanup() already calls
unregister_netdevice_notifier() which will trigger the
NETDEV_UNREGISTER handler in mpoa_event_listener() which already calls
dev_put.

This seems to duplicate that. Which I expect is undesirable.

