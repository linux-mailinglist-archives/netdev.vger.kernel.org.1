Return-Path: <netdev+bounces-146095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBD59D1EF7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78405B217D6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89E145323;
	Tue, 19 Nov 2024 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="sL1hcJ4W"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF81863F;
	Tue, 19 Nov 2024 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988125; cv=none; b=BnPLuIaPGtlpsqHRRxUde4qFRpRK7Vh+tzUcBYbAjyGHPlqupg3+7AUraNm3qZzMSNYCsManNKjCuYRAJvtrBC37jWhR+lMDYs8yhnrzFv2RtrECYUvBKFbOJTqExJsyYMRbVrb6f5XdXYS5NvfMbH58025VQ7KZmNawtBL9zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988125; c=relaxed/simple;
	bh=VpnRR6K+8elVIoxOFS16GECY/oQnwsJ7JYVzPhYaucY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgI5WEaZCxq0JsKRWfNeAgTdy2bn5Y9csyLqWUAkw7mHdgtrfR+yxraWCuF9PkXDDoqLSYFNlOoyuwm+bOI03pO9Zt2QXEPTE0iR8EbrK9eGAerKboEmI0L7tAn7GSDeJJvEwV6UlLOzhCD7p4mMyQiZuI07Y54gEjtgyRqeX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=sL1hcJ4W; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MA5utSwEz7H1vxVCeqgTcx1aZwAdO3vxz9WA1oQuuDo=; b=sL1hcJ4WPqJTiz3m3wx/GPmd5I
	W8nestadOZKntFCRt0Dwr8cMQv1w+joWj9096WaT2FfzGw6FxsP9BtU3FJ4X5vQ9Ue+WFuLevW2sB
	1hYUZbXllabHgTYq0SN9T6KzFF+1Irzi/94uN6tMyaiB96+kOPbTaIrah/UQGdWP2Mz+r+5lOir6g
	cpS578+3pH43s62L8bUqfcsG6vub9A2CXFlsFz1EKi3DjxxRlg41snYhoQhn3GvNQC99bzCvwhi5P
	haX6UPkCpD4I/yNnIPX1zAQ3p5qgy+9VuOtSJ0LlGHFjXMs/Rf9QjonXu9Uf66+zCLLuJBh63y+vA
	M6RtJXsQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tDFE2-000B2k-1Q;
	Tue, 19 Nov 2024 11:48:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 19 Nov 2024 11:48:26 +0800
Date: Tue, 19 Nov 2024 11:48:26 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH net 2/2] netpoll: Use rcu_access_pointer() in
 netpoll_poll_lock
Message-ID: <ZzwKipL-4Lo9L4zV@gondor.apana.org.au>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-2-a1888dcb4a02@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-netpoll_rcu-v1-2-a1888dcb4a02@debian.org>

On Mon, Nov 18, 2024 at 03:15:18AM -0800, Breno Leitao wrote:
>
> diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
> index cd4e28db0cbd77572a579aff2067b5864d1a904a..959a4daacea1f2f76536e309d198bc14407942a4 100644
> --- a/include/linux/netpoll.h
> +++ b/include/linux/netpoll.h
> @@ -72,7 +72,7 @@ static inline void *netpoll_poll_lock(struct napi_struct *napi)
>  {
>  	struct net_device *dev = napi->dev;
>  
> -	if (dev && dev->npinfo) {
> +	if (dev && rcu_access_pointer(dev->npinfo)) {

This function is only ever called in a BH context and as such
the correct primitive would be rcu_dereference.  Indeed calling
this outside of BH/RCU context would be silly.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

