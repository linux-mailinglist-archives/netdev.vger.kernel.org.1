Return-Path: <netdev+bounces-152576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5529F4A91
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F8F188FC02
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECC91EE026;
	Tue, 17 Dec 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="aRrkdswT"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C961DAC88;
	Tue, 17 Dec 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437053; cv=none; b=Bhbf5y8wghQtKb9TchlqQZX5FFwyXZg0H+BkbmkicDZrQ6TH4FzV20EgoAUDlQarUFJAwHHWN4xm+wZyjP7Xidl0YzZu/76Fkks7so4NQVbQV6dopXzMJJqEvqgHYpI5XWSO7BfaADXBMHRyA+rgirXu0pXl7rshh/y67+/nSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437053; c=relaxed/simple;
	bh=MoV5dUrWpK3MUnaq34/CH85ZC5O5lbllu84Bv3WzExQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhpHnd6w0/WgYf6AGKiyK1uqI32h6gy1vQEf9u5CR3nllmAPXXIF3M1138ebWL9kkw4msaNN5cvNnQw/ca97m+Q/3T90Hbz9ZZaqBjJFqNOVM9ZJv4JexZreo+4udOh4/RHEZazWeEQwW1WIrnSHe1HcTThGW8hS5gECs7PLKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=aRrkdswT; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Kyd7fuRsvhaZ4THXfqK627NmpFPWLv9guswigQTwKtE=; b=aRrkdswTYzOyVCiVtwUn0ooP+7
	jZLrZcScMZJKK/I2HqJkeq/Lz+ygy0vXp0vPzhpn+SRsOovOar3qoARgjstjxBGx8WoNH33arWqjF
	TXUHbiICckXwdoCkdnN/ygMYZKufpiMN/oHHhAMZNjnnWq1etAdh7U/k3OqbGEFzwqgqpfCF2efEb
	pwQl9uZ/CNug5vErHXG50UxK/rrir/jXbo19aA6svYuF7Zva58B5R+I/JI0D4vmkKR+umjKZv2/ZY
	QBmawtc3lLQtj3IRiHdSg0p3ffJOFibUlG1xNB4i64a5kc6HnYnU3KN1YC7ONZQbUrj/wJ7EwoS6U
	va2+0pLA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tNW5i-0023Ji-0h;
	Tue, 17 Dec 2024 20:03:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 17 Dec 2024 20:03:38 +0800
Date: Tue, 17 Dec 2024 20:03:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] xfrm: prevent some integer overflows in verify_
 functions
Message-ID: <Z2FompbNt6NBEoln@gondor.apana.org.au>
References: <92dc4619-7598-439e-8544-4b3b2cf5e597@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92dc4619-7598-439e-8544-4b3b2cf5e597@stanley.mountain>

On Tue, Dec 17, 2024 at 11:42:31AM +0300, Dan Carpenter wrote:
>
> +	if (algp->alg_key_len > INT_MAX) {

Why not check for UINT_MAX - 7? INT_MAX seems a bit arbitrary.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

