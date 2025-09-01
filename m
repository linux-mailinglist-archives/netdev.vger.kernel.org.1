Return-Path: <netdev+bounces-218589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC328B3D649
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 03:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3BD3B4FF1
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C192A1F03C5;
	Mon,  1 Sep 2025 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NOACS6TD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38571E9B3F
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756689835; cv=none; b=D/t2fQCtfhgf3YjAMeu3Xv/iAQ66kojQLvTLvNSmQSo6WKOYg6oh+49g5U3pdQt4f3hLj6UO+P+h9aIyGPHonJ6eR81HTWCk5B+L/EV/4+e3/K4pPlSDbmjQnl4NV2SRNTZPRtp9v4T4ubXUcm1Wi8Mjj2oY7Z1Zy47RY7oeVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756689835; c=relaxed/simple;
	bh=weCT8aGZr6VfC/zQulbfYuqvV1F3GKi8plNNNe8aaz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwLyc4p3yIBTBJr6yR+0J7g2JX8sT3Lpi5ozlhcEqLTtoA3+jwXRPRR6ANyAFLGoXcm8E21/VBF5P+zS1fPGkG+PT74COkZryZsTLhX8sQFoWeJjRO1xBmT81yC4UmBNLFHCzaTzsJjRe+ilYBlSfYJ3txY/7hYbg0NpT//Dzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NOACS6TD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kpyJv2COLMHrC79rsPZnnTP9iwEgwrbaBdguJiAroG4=; b=NOACS6TDOLbBJAcAc1qPcia1i0
	pg1QpgvVG5R56UwDy/BR43apww/mSan6kkkfpaBboxzevMyK8bU0Jji5aOd3VlnA50rHFR+8ue7iS
	1AxRJfhWtaOSr+pFmD8JzcMSOrqCzRURRtMy8tCgIhI57DH045t2j34YJXNh6GqxlJfM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ustGi-006iDX-JG; Mon, 01 Sep 2025 03:23:36 +0200
Date: Mon, 1 Sep 2025 03:23:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: jiri@nvidia.com, stanislaw.gruszka@linux.intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] genetlink: fix genl_bind() invoking bind() after
 -EPERM
Message-ID: <7bb4e094-fa20-42d6-89d5-c25cc0584309@lunn.ch>
References: <20250831190315.1280502-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831190315.1280502-1-alok.a.tiwari@oracle.com>

On Sun, Aug 31, 2025 at 12:03:13PM -0700, Alok Tiwari wrote:
> Per family bind/unbind callbacks were introduced to allow families
> to track multicast group consumer presence, e.g. to start or stop
> producing events depending on listeners.
> 
> However, in genl_bind() the bind() callback was invoked even if
> capability checks failed and ret was set to -EPERM. This means that
> callbacks could run on behalf of unauthorized callers while the
> syscall still returned failure to user space.
> 
> Fix this by only invoking bind() if (!ret && family->bind)
> i.e. after permission checks have succeeded.

Firstly, i don't know this code at all. I've no idea what it should
do....

> 
> Fixes: 3de21a8990d3 ("genetlink: Add per family bind/unbind callbacks")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  net/netlink/genetlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 104732d34543..3b51fbd068ac 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1836,7 +1836,7 @@ static int genl_bind(struct net *net, int group)
>  		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
>  			ret = -EPERM;
>  
> -		if (family->bind)
> +		if (!ret && family->bind)
>  			family->bind(i);

I agree, this fixes the issue you point out. But i think it would be
more robust if after each EPERM there was a continue.

Also, i don't understand how this ret value is used. It looks like the
bind() op could be called a number of times, and yet genl_bind()
returns -EPERM?

Also, struct genl_family defines bind() as returning an int. It does
not say so, but i assume the return value is 0 on success, negative
error code on failure. Should we be throwing this return value away?
Should genl_bind() return an error code if the bind failed?

And if genl_bind() does return an error, should it first cleanup and
unbind any which were successful bound?

As i said, i don't know this code, so all i can do is ask questions in
the hope somebody does know what is supposed to happen here.

       Andrew

