Return-Path: <netdev+bounces-125026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BBE96BA17
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF8E1C235E9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B371D0DEA;
	Wed,  4 Sep 2024 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgQxlwO2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC81482E1;
	Wed,  4 Sep 2024 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448601; cv=none; b=Ze/j95R+p9DaSxTLJLXqrBqibUn5PH/+yRFuJLUFnUYxAqCLtRLheekq36d718pl3C8FutqZ9aoB82Gf8K14FuYD9IjS/yi/MKAryt7jb/YsTGSUKOrCjj6ASd1NyO3UCODgQMWNbigRmkuUxPxIYeCAfPKdiTOf9MmVVe3isWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448601; c=relaxed/simple;
	bh=uhIlUbMJNjTgFjep49EvhHdpQ8989sm7EjJUkU9DvFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4M8JbrLBQF7s7eab3G1KE7bBcjgj/pRIgnI9XaCgBsUyglcsbvuT/GqxohUh3Bh0IhPQ/sDSWe89W90jPCxsbP4iES1dvEol6b6vaecALi2GeC3XfhD2hbQHVkt5a6XhY4LPtzc3Oq9EsggDNOx528RHXcj4KwCZkW4271QqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgQxlwO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C262C4CEC2;
	Wed,  4 Sep 2024 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448600;
	bh=uhIlUbMJNjTgFjep49EvhHdpQ8989sm7EjJUkU9DvFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgQxlwO2QoJv1j2odUgp99WShcNphdbaavmaLy8UBS3bEjQoVYAMhHtGxgCmKn03R
	 h381mTc1aAzDW6IK68k2/IDGPHX1v5piB7MSTvYdjVfBNnFZeHy5M5uyf9Tmi01egs
	 R5cWyO/QQLLx7nk1QAbGw5SfQvMkVXTHo4c6yl4mthdcGAIHinEwUrLYHcXLrCvWal
	 pl1OtCgxG7Rhb7tH4HjkeSmDyihryNvmm5ELaChIvkADwjX6dmVXhZVMr+R/3WsZah
	 MLoHRDtO7qhFiXmucaEDDA6A8n7ubynqA2H/IcXif3jzmQn3W44/bL1fK+8y+VWa9J
	 /pF1D7OfO2RQg==
Date: Wed, 4 Sep 2024 12:16:36 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 8/9] net: netconsole: split send_msg_fragmented
Message-ID: <20240904111636.GV4792@kernel.org>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-9-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140757.2802765-9-leitao@debian.org>

On Tue, Sep 03, 2024 at 07:07:51AM -0700, Breno Leitao wrote:
> Refactor the send_msg_fragmented() function by extracting the logic for
> sending the message body into a new function called
> send_fragmented_body().
> 
> Now, send_msg_fragmented() handles appending the release and header, and
> then delegates the task of sending the body to send_fragmented_body().

I think it would be good to expand a bit on why here.

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 85 +++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index be23def330e9..81d7d2b09988 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -1066,45 +1066,21 @@ static void append_release(char *buf)
>  	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
>  }
>  
> -static void send_msg_fragmented(struct netconsole_target *nt,
> -				const char *msg,
> -				const char *userdata,
> -				int msg_len,
> -				int release_len)
> +static void send_fragmented_body(struct netconsole_target *nt, char *buf,
> +				 const char *msgbody, int header_len,
> +				 int msgbody_len)
>  {
> -	int header_len, msgbody_len, body_len;
> -	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
> -	int offset = 0, userdata_len = 0;
> -	const char *header, *msgbody;
> -
> -	if (userdata)
> -		userdata_len = nt->userdata_length;
> -
> -	/* need to insert extra header fields, detect header and msgbody */
> -	header = msg;
> -	msgbody = memchr(msg, ';', msg_len);
> -	if (WARN_ON_ONCE(!msgbody))
> -		return;
> -
> -	header_len = msgbody - header;
> -	msgbody_len = msg_len - header_len - 1;
> -	msgbody++;
> -
> -	/*
> -	 * Transfer multiple chunks with the following extra header.
> -	 * "ncfrag=<byte-offset>/<total-bytes>"
> -	 */
> -	if (release_len)
> -		append_release(buf);
> +	int body_len, offset = 0;
> +	const char *userdata = NULL;
> +	int userdata_len = 0;
>  
> -	/* Copy the header into the buffer */
> -	memcpy(buf + release_len, header, header_len);
> -	header_len += release_len;
> +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> +	userdata = nt->userdata_complete;
> +	userdata_len = nt->userdata_length;
> +#endif

I think that dropping the userdata parameter of send_msg_fragmented() ought
to part of an earlier patch or separate patch. It doesn't seem strictly
related to this patch.

>  
>  	body_len = msgbody_len + userdata_len;
> -	/* for now on, the header will be persisted, and the msgbody
> -	 * will be replaced
> -	 */
> +
>  	while (offset < body_len) {
>  		int this_header = header_len;
>  		bool msgbody_written = false;

...

> @@ -1161,6 +1137,41 @@ static void send_msg_fragmented(struct netconsole_target *nt,
>  	}
>  }
>  
> +static void send_msg_fragmented(struct netconsole_target *nt,
> +				const char *msg,
> +				int msg_len,
> +				int release_len)

...

