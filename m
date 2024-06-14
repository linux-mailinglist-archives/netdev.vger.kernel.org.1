Return-Path: <netdev+bounces-103582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AAC908B45
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D5BB22AF9
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673C19596D;
	Fri, 14 Jun 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po+5O8+F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117B14D29B
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367056; cv=none; b=ICmWQhQDgzVd4gIXdjmu2DP9t2D+lsfvHpx0/w/YdQ3Y0FC7m7XqhlLsrEqul+KqbavcD8ri70Vsg7j60dZCzFrt+SzOEFRkQoCoQRkK7uaqxuxFsmxbtL6WGUl5N1F8U+cOBB4oYwtfFPQ4r3++wo4lnAbEFn8m1I5H+Y1ZQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367056; c=relaxed/simple;
	bh=BNvz15RpkjVRp+kuYP/i8/GGhSNHXODgLFMS56EslaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOmiLHXyZxhN0lEPlyD0pv+Zonbk5zdpTpkY14sF9iyv1XjKpVqfdmQL3xqDk/Ct5ZquTi9yWM5Yw9mw9EgO4yuQIXSs25okB900/gTTVd96kP+qUB4XjalxcBFcnbDh6mcCVvY9Lv7TJ8MfptbfzV0ejbJ0sgTw4rg4nbIs4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po+5O8+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFD6C2BD10;
	Fri, 14 Jun 2024 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718367055;
	bh=BNvz15RpkjVRp+kuYP/i8/GGhSNHXODgLFMS56EslaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Po+5O8+FwNf+P+9g2noY0sbhS37G01bhUXTH2kP5BzBh2c+yenjH2wvxvSw84tgji
	 sVtqz8I1iX9OFgUe4cZSD8mGGXKQ8EXkMlM28ZHrjlhjC1rL9kFjp7vRwue0nfMoTV
	 sULMoA4Z4yDOw14UbAJw7wbVI6wpjTuLicJXCFIDixY8+EIUhLlfEsavJWdVf9RGyT
	 R+lNyy40jKn1UMzbZYVQH2sIV54NxFukrDYDE8Uo4fN+qeEFTXaR9cWZ0J7m5AkSFf
	 kUzw7X9uN0pEY6FetAonoyT9wHObB7ACW7+IUdUQo2tjr98zI8NBP3ecxW0SMxXB8Z
	 Ft2lBjjriuNrQ==
Date: Fri, 14 Jun 2024 13:10:51 +0100
From: Simon Horman <horms@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec 1/2] xfrm: Fix input error path memory access
Message-ID: <20240614121051.GJ8447@kernel.org>
References: <f8b541f7b9d361b951ae007e2d769f25cc9a9cdd.1718087437.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b541f7b9d361b951ae007e2d769f25cc9a9cdd.1718087437.git.antony.antony@secunet.com>

On Tue, Jun 11, 2024 at 08:31:29AM +0200, Antony Antony wrote:
> When there is a misconfiguration of input state slow path
> KASAN report error. Fix this error.

...

> Fixes: 304b44f0d5a4 ("xfrm: Add dir validation to "in" data path lookup")
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Reviewed-by: Simon Horman <horms@kernel.org>


