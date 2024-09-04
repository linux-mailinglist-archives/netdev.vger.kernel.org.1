Return-Path: <netdev+bounces-125014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2079D96B96B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B8EFB24B16
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC041D0DF7;
	Wed,  4 Sep 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBk2v8Q8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F01D0DE9;
	Wed,  4 Sep 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447350; cv=none; b=c0Et0CA/DYONDpPHbh9UQr1E3YOflrnl4szJbHV9SQtfcrHd88312bDn8b9W+oCJTDXiIO5uJA/cSZLmbHH4ObB5kud+xNv3QRcvH11O2WmGs/7eHyVyeov8ZXovCNEIIN0aol97Ml0wr1bAPkby56BwmCuNxUlgiQZGK/0T/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447350; c=relaxed/simple;
	bh=bVbwBNlUCn1Mozs48iwcFEpHsGMsbP0mnm+mcKhC+E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxYI4eskS5b5LvzRiwQtRfR1a4yL7/WIuhNAVcjnIRROCHB01vGYsQIXfdlHICY3e3pSwDJwNrFphy8V4DPZzI8JnOsqYmVss5I0ZyFFLaHAeDndNO6/tRMSYo2hlJnTt1EExlvkNPh864pSK2lehrITWj1+Vs9plsj/r3orw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBk2v8Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBE2C4CEC2;
	Wed,  4 Sep 2024 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447350;
	bh=bVbwBNlUCn1Mozs48iwcFEpHsGMsbP0mnm+mcKhC+E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBk2v8Q847hEM6DY5AhBghHFHzPzZDYp4wSwGZ5s7HAnte1JoQkoQLPI2KVCFUd3L
	 ICAH0DSlRHjutsgVEH4IFqVbBngiGpUai/7ZXUSFKNw59ejx+1SzDHdXPfSiHvtGvU
	 K1WOoNfcXix5H+qz2o4ClVNyMMFyEnci05Ri4yVmJIGd1mbN7jAYJ9w28x+9df+m8W
	 io0TFXM6n8dEe17yuwRZ9zbMY++BiFM4Vg75UHhQnk62QEIsJrLupdkjMnXCWvNoH6
	 hxmO5r4vmMrzyLJPFRw++NQabx1DBxGvyHcZidKsFdsIRmOVuXIGwLK43W/lL5Wq6a
	 gEQaf/W8HEqqg==
Date: Wed, 4 Sep 2024 11:55:45 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 2/9] net: netconsole: split send_ext_msg_udp()
 function
Message-ID: <20240904105545.GO4792@kernel.org>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903140757.2802765-3-leitao@debian.org>

On Tue, Sep 03, 2024 at 07:07:45AM -0700, Breno Leitao wrote:
> The send_ext_msg_udp() function has become quite large, currently
> spanning 102 lines. Its complexity, along with extensive pointer and
> offset manipulation, makes it difficult to read and error-prone.
> 
> The function has evolved over time, and it’s now due for a refactor.
> 
> To improve readability and maintainability, isolate the case where no
> message fragmentation occurs into a separate function, into a new
> send_msg_no_fragmentation() function. This scenario covers about 95% of
> the messages.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks,

The nit below aside this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> @@ -1090,23 +1116,8 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  		release_len = strlen(release) + 1;
>  	}
>  
> -	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK) {
> -		/* No fragmentation needed */
> -		if (nt->release) {
> -			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
> -			msg_len += release_len;
> -		} else {
> -			memcpy(buf, msg, msg_len);
> -		}
> -
> -		if (userdata)
> -			msg_len += scnprintf(&buf[msg_len],
> -					     MAX_PRINT_CHUNK - msg_len,
> -					     "%s", userdata);
> -
> -		netpoll_send_udp(&nt->np, buf, msg_len);
> -		return;
> -	}
> +	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
> +		return send_msg_no_fragmentation(nt, msg, userdata, msg_len, release_len);

nit: This appears to be fixed in the following patch,
     but the above line could be wrapped here.

>  
>  	/* need to insert extra header fields, detect header and body */
>  	header = msg;
> -- 
> 2.43.5
> 

