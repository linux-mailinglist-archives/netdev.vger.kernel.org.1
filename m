Return-Path: <netdev+bounces-187282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EEAAA60D7
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81334C4409
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3988201276;
	Thu,  1 May 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQVRT0jO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E643169;
	Thu,  1 May 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114000; cv=none; b=IDS09T1zB5RwQIhxe8xKLBcLA6+STrFnxsQ/vsULoGDCiRiD2q3DDaweSHqZrPWFBfnCgPF4s1+a3xz9gLiRug0rPb5R4sr+ZFAqpK3EPSobTN/WPLj/NDbW0BmPbhvZHs+yoN3ZHox51gXEDtu/Aw3EmRYgHDEYExFgQRaZUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114000; c=relaxed/simple;
	bh=hrEAEh3lq2I1Ox4b0R8U5WmZ/jstKflCKSTnRsjFyIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBeH1TLDjwq3Qpe/X8EyYVua1+ty+UeNhZ8XInlF04RizHKazEHAKMZcxEbV94b5C0Zqfi9VVkoaFtU8l/zMeTvB/mL1VB0ICwIvk8bIK7WZ4MfnNBUtO7UVA3e+N2UFnYsEnVqMITLOy7cxO+2zHqaoVwY8yYeHeHwkwYN0a74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQVRT0jO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54047C4CEEE;
	Thu,  1 May 2025 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746114000;
	bh=hrEAEh3lq2I1Ox4b0R8U5WmZ/jstKflCKSTnRsjFyIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQVRT0jO92x91XAng6qJVW4fWv4ftom/ULEadbNbvwGouP/j7FbvI29H1Hx0owQOq
	 Xe3P9sz3HwOSTrQmByzJl2pG3kIflELRFKm+q6fMy2FFCqHPdzdVlrmIja7Pdcu/yX
	 BL3qRXGHX+D1PHOD7EEWwwm+hOWg5hALdewj3Kns0/jpDLK5b5sOxzulLTkgHXaK5r
	 n1LDfNuzQIDxcJB0U29fXDvmQbXoBCXrA3qMrpT+tDCSnV/kgIiDxe5bhg+fPH7n/1
	 GopzIjUQmaS8Dcmz2YdhJgSstitJezfUd0RGpDR64kAej7REUUQG2KamjBQicvGzsV
	 Nse7cEIi8V71w==
Date: Thu, 1 May 2025 16:39:56 +0100
From: Simon Horman <horms@kernel.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv4: ip_tunnel: Replace strcpy use with strscpy
Message-ID: <20250501153956.GC3339421@horms.kernel.org>
References: <20250501012555.92688-1-rubenru09.ref@aol.com>
 <20250501012555.92688-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501012555.92688-1-rubenru09@aol.com>

On Thu, May 01, 2025 at 02:23:00AM +0100, Ruben Wauters wrote:
> Use of strcpy is decpreated, replaces the use of strcpy with strscpy as
> recommended.
> 
> I am aware there is an explicit bounds check above, however using
> strscpy protects against buffer overflows in any future code, and there
> is no good reason I can see to not use it.

Thanks, I agree. This patch doesn't buy us safety. But it doesn't lose
us anything. And allows the code to move towards best practice.

One thing I notices is that this change is is inconsistent with the call to
the 3-argument variant of strscpy a few lines above - it should also be hte
2-argument version. Maybe that could be changed too. Maybe in a
separate patch.

It is customary when making such changes to add a note that
strscpy() was chosen because the code expects a NUL-terminated string
without zero-padding. (Which is the case due to the call to strcat().)
Perhaps you could add some text to the commit message of v2 of this patch?

> Signed-off-by: Ruben Wauters <rubenru09@aol.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/ipv4/ip_tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 3913ec89ad20..9724bbbd0e0a 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -247,7 +247,7 @@ static struct net_device *__ip_tunnel_create(struct net *net,
>  	} else {
>  		if (strlen(ops->kind) > (IFNAMSIZ - 3))
>  			goto failed;
> -		strcpy(name, ops->kind);
> +		strscpy(name, ops->kind);
>  		strcat(name, "%d");
>  	}
>  
> -- 
> 2.48.1
> 
> 

