Return-Path: <netdev+bounces-39880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA877C4A93
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5F7282513
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF720E0;
	Wed, 11 Oct 2023 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wT4buVgU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1F1798A
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E06C433C7;
	Wed, 11 Oct 2023 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697005823;
	bh=cOfTkY43H2nW587bRbrhIWOL7GLGr7wMPsVn9tjAmW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wT4buVgUFRsybw4xiRLI0LgTqeVc7oFuas3/Y5EtgAlXJfXTG2Bn/LrQ4zN5W+gyo
	 93GacY0ieRvY5wmyPmzX0Lf4ly56RkkjmEm5q0aOccBGmvYUIdIV7cg/rdiww5exmR
	 tqMdWp9VVKmvolYBfYeWBF2CWiKZ/I1GP1vp07c0=
Date: Wed, 11 Oct 2023 08:30:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove extra unlock for the mutex
Message-ID: <2023101136-irritate-shrine-cde6@gregkh>
References: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>

On Wed, Oct 11, 2023 at 04:16:30AM +0530, Abhinav Singh wrote:
> There is a double unlock on mutex. This can cause undefined behaviour.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index aeebe8816689..f11fe8c727a4 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -597,7 +597,6 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
>  	}
>  	if (head2_lock_acquired)
>  		spin_unlock(&head2->lock);
> -	spin_unlock_bh(&head->lock);

How was this tested?

And where is the now-needed unlock of the head->lock?

How was this change found?

And your subject line needs a lot of work...

thanks,

greg k-h

