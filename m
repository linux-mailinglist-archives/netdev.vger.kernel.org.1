Return-Path: <netdev+bounces-146378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC99D32C5
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 04:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C14B229C7
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 03:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4113D6CDBA;
	Wed, 20 Nov 2024 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="hsBDctrY"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278A23CB;
	Wed, 20 Nov 2024 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732074564; cv=none; b=fNINN1hBvO/O46a6ZBLm4rQO3z9h4j0t89NvQQF/2vnWqOuSH7ftemv4f5k0auoWipoWMzPMqbAurUZHFoQ7YadkdFRNkjstjROa7mMJ2I4Z+OEDW6rG0YYaXsSPM64DgJBJ9owbLroPQoSo8x6vO9N0T6wZx4ITCPIifGrTgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732074564; c=relaxed/simple;
	bh=6hhnyrfOkv43AZpiR+qvxik7IrKH7VT4AywyLvx2aX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pj5zrjjBCc8RX486dMQPow8UJbNRQN/oQlZU7L5i8b9x/lrq/Kdbz3pReB+D+WANpdk9pBZkgnz5TBJVjhetXRnjmyDB1SjZZQnVle543HJOtRgX67aJchqoXN1BssMC547p0fcujwQUA6DgNuvgOZ1ls1C48FuAh6t20O4zYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=hsBDctrY; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jaT8mpucmu4OAW2hvt1rtUY2jnL7e8t5oSgQvR2Ordk=; b=hsBDctrYhFm1AZMUS9wQgDubPw
	Y7VgQkKzRIsdoGYGxP1P/hQSUVyxnF+AbwPbWaDmgchC1qljqg9Mh3ex51Ag9BDzvzjLUX/BhNSxc
	RDzaPiW5B36mqo5nAM8OKAWnZQ3DrrUzTSuPpVAz7dKZJ29e/Lkqlvx0/duj5Vb6ugeUN0eNz+oXa
	k19IblmhuNUa4E0GZCDL7TloVHTEIO8GzcajloqsO4O3RRX/CyhBF+IsloAgK8iVlR/YKEandoC8Y
	b97tHwsnxfpvLS+MDo6eVs4xADjZ+tGKXTDibxe59UVDee9IoyWn7lyfq4pM+M6wBrPOhhggZ9mxy
	QrJ+6EHw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tDbi5-000Piv-3B;
	Wed, 20 Nov 2024 11:48:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Nov 2024 11:48:57 +0800
Date: Wed, 20 Nov 2024 11:48:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 1/2] netpoll: Use rcu_access_pointer() in
 __netpoll_setup
Message-ID: <Zz1cKZYt1e7elibV@gondor.apana.org.au>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>
 <ZzwF4QdNch_UzMlV@gondor.apana.org.au>
 <20241119-magnetic-striped-pig-bcffa9@leitao>
 <Zz1RCAT9Ao5PsAAK@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz1RCAT9Ao5PsAAK@gondor.apana.org.au>

On Wed, Nov 20, 2024 at 11:01:28AM +0800, Herbert Xu wrote:
> 
> No, rcu_dereference_protected is actually cheaper than rcu_access_pointer:

BTW, this code should just use rtnl_dereference which does the
right thing.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

