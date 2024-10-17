Return-Path: <netdev+bounces-136716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA689A2BCD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6DC1F21735
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3F1E1058;
	Thu, 17 Oct 2024 18:10:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A41E0E03;
	Thu, 17 Oct 2024 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188646; cv=none; b=rXM91iBEUvPaNKhFfWt6AQxGvjesGumd5hUFgAKCmYOT8pTJekRJcp3ts3TUEETcjfzIRYfG1i3EL04Q07E0LNxTehmOFite9xIioOJlo37RiTEw4mGzoomvze6/tdOTHja20EDXN1KBuPf8LWDJ5kkzgzbjc859fKtMrggUDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188646; c=relaxed/simple;
	bh=bFWmMAiYY/zcVTbFe2jP5n8eJScXpS2Iqf32Nw7MvmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xcuk+9gmYE5ECZqLCjhnUxl8sjaKxLwTixcpva1WUBkFQcdgdbg/Ka4A/u0Ofo1UU4/Owkb5H3BjsslCLYuZzQ4cU7bOR+6jAEXUnKUorHYUR7Ttedw2Fhr5QNpsEppCKL31PgO/cgvaY+rWni7rxuRen8XVBs7HyIWP+E0FmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t1Ux4-0006xj-5c; Thu, 17 Oct 2024 20:10:22 +0200
Date: Thu, 17 Oct 2024 20:10:22 +0200
From: Florian Westphal <fw@strlen.de>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 05/10] ip6mr: Lock RTNL before ip6mr_new_table()
 call in ip6mr_rules_init()
Message-ID: <20241017181022.GB25857@breakpoint.cc>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
 <20241017174109.85717-6-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017174109.85717-6-stefan.wiehler@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Stefan Wiehler <stefan.wiehler@nokia.com> wrote:
> +	rtnl_lock();
>  	mrt = ip6mr_new_table(net, RT6_TABLE_DFLT);
>  	if (IS_ERR(mrt)) {
>  		err = PTR_ERR(mrt);
>  		goto err1;
>  	}
> +	rtnl_unlock();
>  
>  	err = fib_default_rule_add(ops, 0x7fff, RT6_TABLE_DFLT, 0);
>  	if (err < 0)
> @@ -254,6 +256,7 @@ static int __net_init ip6mr_rules_init(struct net *net)
>  	ip6mr_free_table(mrt);
>  	rtnl_unlock();
>  err1:
> +	rtnl_unlock();

Looks like a double-unlock?

