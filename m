Return-Path: <netdev+bounces-221206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D0B4FB99
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18B54E37D4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D4E32CF97;
	Tue,  9 Sep 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM6ZCRil"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC127380C
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422054; cv=none; b=eOfSuXBpguHlOJBFWQVMDn/SdPprYAThdg+vJd0WQHpbI0qhjf/zltFbQWNmlQqdO+/WQvfKdRJWp2Ic1i7nYcfhet+iq2rH8EsRCGCChJ4cF66C5HjSh4AA5Tp52CUqr8PfedGWuGT7+KOwb7Lj/aiZdUWf5bsNpK/rfNcFbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422054; c=relaxed/simple;
	bh=4zg+qxTuu6Ei5289E/A3LoMNam71kQkMnpwFBL13rV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2qNGCnVlfB0IQ36MwiLo0N7Diffnze8zOtv1GZd8o9imEc/9ktiRXKcFh/+Ov4UZOZl9X+5lG4DDEWSFTYSc4ERLgw/g82VlbF8zQTyIjq/eHIB0gB6IRC3bBqrx1HdHgZJ8jiMXd6+ieVbnuoWaS1w0E8gIAXrb0cnRP0THWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM6ZCRil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027DFC4CEF4;
	Tue,  9 Sep 2025 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757422054;
	bh=4zg+qxTuu6Ei5289E/A3LoMNam71kQkMnpwFBL13rV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM6ZCRildHxfM26+MPZzFwraQuEX0EW4tKnvoyJ54jydEfQn/WMY2e6eH2BN3r7O8
	 +utxnbrVuNcFTP4wpMXXd3aEzgKyT1fcHd1Ur6/VXamW7d5jf+plgpeMUQsXE5rt7J
	 XFGllMVLdm9nB9BJ+CI8dZAflqxefqwL5NzsspCVnjk3Y4SGN3AWLTq8zierYV44YQ
	 hbKN6TIXtEz0VU3qMQncd+BYF9SYzF3QpqU+cEoErw/sbZn5bDZJKQQk2rRkPOdH9Y
	 ogjF0NJy+6jUPIduoq3B5GmMe6z5sciWUVTx9/9tEDui9plhCNe91AaC5wt40jAYVs
	 XUD+fxLghW0JQ==
Date: Tue, 9 Sep 2025 13:47:30 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: paul@paul-moore.com, davem@davemloft.net, dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: Potential null pointer dereference in
 cipso_v4_parsetag_enum
Message-ID: <20250909124730.GE14415@horms.kernel.org>
References: <20250908080315.174-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908080315.174-1-chenyufeng@iie.ac.cn>

On Mon, Sep 08, 2025 at 04:03:15PM +0800, Chen Yufeng wrote:
> While parsing CIPSO enumerated tags, secattr->flags is set to 
> NETLBL_SECATTR_MLS_CAT even if secattr->attr.mls.cat is NULL.
> If subsequent code attempts to access secattr->attr.mls.cat, 
> it may lead to a null pointer dereference, causing a system crash.
> 
> To address this issue, we add a check to ensure that before setting
> the NETLBL_SECATTR_MLS_CAT flag, secattr->attr.mls.cat is not NULL.
> 
> fixed code:
> ```
> if (secattr->attr.mls.cat)
>     secattr->flags |= NETLBL_SECATTR_MLS_CAT;
> ```
> 
> This patch is similar to eead1c2ea250("netlabel: cope with NULL catmap").

Nit: the preferred form for this citation is:

commit eead1c2ea250 ("netlabel: cope with NULL catmap")

i.e.

This patch is similar to commit eead1c2ea250 ("netlabel: cope with NULL
catmap").

> 
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
> ---
>  net/ipv4/cipso_ipv4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 740af8541d2f..2190333d78cb 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1339,8 +1339,8 @@ static int cipso_v4_parsetag_enum(const struct cipso_v4_doi *doi_def,
>  			netlbl_catmap_free(secattr->attr.mls.cat);
>  			return ret_val;
>  		}
> -
> -		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
> +		if (secattr->attr.mls.cat)
> +			secattr->flags |= NETLBL_SECATTR_MLS_CAT;
>  	}
>  
>  	return 0;
> -- 
> 2.34.1
> 
> 

