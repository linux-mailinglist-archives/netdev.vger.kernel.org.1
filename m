Return-Path: <netdev+bounces-236718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78918C3F611
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 11:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D293A5AA5
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B52FFDF2;
	Fri,  7 Nov 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYLLuF3F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D482AD22;
	Fri,  7 Nov 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510633; cv=none; b=pPE08DHcaKTSMzv0Q1B9gW6vknIKVOWhkUulQi/I5PWmG2Wc8t2As239QY11+0ISk9mdhRpFD52PZpOZwGK5dLZ8O1k41+MggxjgkPscOoJI2ejYKtepdJi94zHk9cZhMiQioa9WLbGptT9Hse5jsu/lOhs7x74DO3RovPDW+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510633; c=relaxed/simple;
	bh=+hJogo2dkd8m91uRqbkg5Gd4jOsDSmCD2rToG/IWvyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMX+3T0S6CGZCzrw7YmsXXvWrxR58vUuFlr2ztNiutBoudR9YfgCkbOcePWaXymZRpnALwKwBkZXOkxsArKNhF4h5UvSQcXjC6vWd/N1saM+IIbQCJ8p89iMM4PhlsaztaeQSUQiUeWnMVTUa29IDidu9fEISuSDVgC/NnYNdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYLLuF3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2554EC4CEF8;
	Fri,  7 Nov 2025 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762510633;
	bh=+hJogo2dkd8m91uRqbkg5Gd4jOsDSmCD2rToG/IWvyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYLLuF3F3b4GHtYWGWmgiCTxM7c+DNYHsRg/CoB8a42Ozi2nURMMuNtrP5hNt3Es6
	 cN1Ax3+5vC4CE5g8PcypvGYOYHx1uJjn5VscTaQuTtYNmWH86DOZZ8w2u6GsLVjbHd
	 +cMcEAkOqvieimeznyCHICoVtou/JO1l9AgXhuB9Vud8jQBnT9vFMTX44TucQSt1gC
	 Y4Ty0IceUH3BUbLD9yj8y+HjrmXUqUFUITH/aDh2q1ivtNP3GoXirEjMmd+h4n2N7M
	 Q+p1GIIu4etJHnYvs5tXwmVMv7FCvLPosWB1FIoCfDtaoqDGbY9li6dN37EnbDJddk
	 NB8Z2cqdmYj4g==
Date: Fri, 7 Nov 2025 10:17:09 +0000
From: Simon Horman <horms@kernel.org>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] net/handshake: Fix memory leak in tls_handshake_accept()
Message-ID: <aQ3HJRwkz6j512o7@horms.kernel.org>
References: <20251106144511.3859535-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106144511.3859535-1-zilin@seu.edu.cn>

On Thu, Nov 06, 2025 at 02:45:11PM +0000, Zilin Guan wrote:
> In tls_handshake_accept(), a netlink message is allocated using
> genlmsg_new(). In the error handling path, genlmsg_cancel() is called
> to cancel the message construction, but the message itself is not freed.
> This leads to a memory leak.
> 
> Fix this by calling nlmsg_free() in the error path after genlmsg_cancel()
> to release the allocated memory.
> 
> Fixes: 2fd5532044a89 ("net/handshake: Add a kernel API for requesting a TLSv1.3 handshake")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  net/handshake/tlshd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index 081093dfd553..8f9532a15f43 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -259,6 +259,7 @@ static int tls_handshake_accept(struct handshake_req *req,
>  
>  out_cancel:
>  	genlmsg_cancel(msg, hdr);

Hi Zilin Guan,

I don't think genlmsg_cancel() is necessary if msg is freed on the next line.
If so, I suggest removing it, and renaming out_cancel accordingly.

> +	nlmsg_free(msg);
>  out:
>  	return ret;
>  }
> -- 
> 2.34.1
> 

