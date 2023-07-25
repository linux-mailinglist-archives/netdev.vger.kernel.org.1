Return-Path: <netdev+bounces-20994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E108E762192
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3411C20FAA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB025916;
	Tue, 25 Jul 2023 18:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0F21D52;
	Tue, 25 Jul 2023 18:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE996C433C7;
	Tue, 25 Jul 2023 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690310362;
	bh=/fLrYkomR7e++1jNKJRtYrKgRl1GFbBahIfCgp09/lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCi+AlD89Bn50K7yO0dcmAhMhTzUp0Wtq0/0fOx5dr2wWX/GygO7lS8Tf0iVnkCJK
	 9UYGSsn2OrmNj4PKYxLVSklO91voGLkZsc6mNW36nN77e5ItxIPAzTFF9nvaPz0EHs
	 qyI3ng4ubUQoliW+k6qnDB36j+1dsT3UzbwjeGAo=
Date: Tue, 25 Jul 2023 20:39:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang.tang@suse.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] mptcp: more accurate NL event generation
Message-ID: <2023072513-citizen-skyward-9530@gregkh>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
 <20230725-send-net-20230725-v1-2-6f60fe7137a9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-send-net-20230725-v1-2-6f60fe7137a9@kernel.org>

On Tue, Jul 25, 2023 at 11:34:56AM -0700, Mat Martineau wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Currently the mptcp code generate a "new listener" event even
> if the actual listen() syscall fails. Address the issue moving
> the event generation call under the successful branch.
> 
> Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> ---
>  net/mptcp/protocol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3613489eb6e3..3317d1cca156 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3723,10 +3723,9 @@ static int mptcp_listen(struct socket *sock, int backlog)
>  	if (!err) {
>  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>  		mptcp_copy_inaddrs(sk, ssock->sk);
> +		mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
>  	}
>  
> -	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
> -
>  unlock:
>  	release_sock(sk);
>  	return err;
> 
> -- 
> 2.41.0
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

