Return-Path: <netdev+bounces-151859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C99F15F0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8EA188B8B0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A01EB9E3;
	Fri, 13 Dec 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ3Kyszb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C41E0B75;
	Fri, 13 Dec 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118471; cv=none; b=I08yJUpWn9iMrqbcl2/v21XRThxyO43SdCq1pYTSDfZ9iWgAcB8zkd/4dsSSre6JnxTYJi18OU05TWhsdlYqtw1sK7vmtN5UZiDKHRAfog9g5SAmpLOpy3coQIghBEL0/1O56pqeY44NML3kSF0yM6ZVKqRw7/wEldQL0utUjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118471; c=relaxed/simple;
	bh=uazp8q3I6dRTgBXIMOo6n/VQO98UXytUK4cybDD7kcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKytqFj2vVQGJ4Xw/AFoYtBO2WvuLXHgVNLfz3y2Sxf0GwVqobR9+9bNwhXu+vskv4LmUd9hR8Qk34iN9RhWIsbUGvWdK9D+Y00oZPE3wjWXkcNwPxUc7bMwiu62Z9/Teb8N6iYzzGiHrXgrJNqqU/MY8eGmRTmFhctsedxXggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ3Kyszb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6021C4CED0;
	Fri, 13 Dec 2024 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734118471;
	bh=uazp8q3I6dRTgBXIMOo6n/VQO98UXytUK4cybDD7kcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQ3Kyszb66u4VFirEw7paQAkGi12s8Z/lWCax6qsas82QKyma0JQgYxzaVjfdEQmG
	 agrIgdhjPbUICT9CEHskftVKB4fHC9GepalJTv4d3zpc0JzCW92cy3MX+fwrEq0ckB
	 f7hA4Mb/d0yrx1kMiFi6LYwaShsD0nBI3dfZkTnkUZnEfNtopE7hiqIF2btlfFwqWD
	 9B29StxKyNIMtCzmJLkc1QkdTIHIxnN1Dg//14iIbBzIsWGf0Fnem8jdZd4NNTwjY3
	 fpfw9E/oP25OpzogBX0TebFhb8Panua8wC886MLDP/CCp5gDeH4K8rKTPiFC2rfX6I
	 H38ozCO7OpUnA==
Date: Fri, 13 Dec 2024 19:34:26 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Atul Gupta <atul.gupta@chelsio.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Zubkov <green@qrator.net>,
	Michael Werner <werner@chelsio.com>,
	Casey Leedom <leedom@chelsio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net] chelsio/chtls: prevent potential integer overflow on
 32bit
Message-ID: <20241213193426.GE561418@kernel.org>
References: <c6bfb23c-2db2-4e1b-b8ab-ba3925c82ef5@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6bfb23c-2db2-4e1b-b8ab-ba3925c82ef5@stanley.mountain>

On Fri, Dec 13, 2024 at 12:47:27PM +0300, Dan Carpenter wrote:
> The "gl->tot_len" variable is controlled by the user.  It comes from
> process_responses().  On 32bit systems, the "gl->tot_len +
> sizeof(struct cpl_pass_accept_req) + sizeof(struct rss_header)" addition
> could have an integer wrapping bug.  Use size_add() to prevent this.
> 
> Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I fixed a similar bug earlier:
> https://lore.kernel.org/all/86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain

Thanks Dan,

Reviewed-by: Simon Horman <horms@kernel.org>

