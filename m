Return-Path: <netdev+bounces-201530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7EAAE9C6C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D013B7181
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362B275106;
	Thu, 26 Jun 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUqtnhnz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CA218AB9;
	Thu, 26 Jun 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936764; cv=none; b=q+8C3ZxEDpNHkLhTNt6G5TUXTtZCZdwW9ZI7ozWbgVQXf+QVOkH8ynD/vybXGn+aBI6ba/lnd+R82HtiefMfByzmcuGVk1UfQleN5gOnij55K+0lFB/cIEek4qE+lut6xFGbpEYrYyZGWWaLKZ6mWeAbaKQvJxLMHptZyZJCQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936764; c=relaxed/simple;
	bh=74yECaydFrAAaG+GBuofMEjkzPEW7SI+Ti8lcdiSM4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8Da3l0FORMZ3egHOqUcNlB9ZRM1KwHUBuz7/i1yU+2eqXTp1fcqb7A58sUv8vJVHt6d2W5jVyGOshcgr5X/OigG7gT94X80dh+N541hnLltYFw/JEermNYE25YMgzNESgvahDphO1dGkmiAYxTtW40xWZz7oE8WzeWH+4QMhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUqtnhnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E774C4CEEB;
	Thu, 26 Jun 2025 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750936764;
	bh=74yECaydFrAAaG+GBuofMEjkzPEW7SI+Ti8lcdiSM4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bUqtnhnzxEh+k9Pg+wpcE7A1G8OWKnsTDtSCCjIAsDhtG7mN8BDigFE8lYJVE9R6R
	 BQxoPhtxNQ1RpT90zIzl64rDWLuQ4yb20/IR23oq6ub0+Q+7Xws+TAbK6BJEZR/81I
	 SDPXxKNHkpO2Xo3zZA+pcXCmgTIGYGo95YZng6xLow5lFlqOexqH61cI37BN35else
	 cLHxLYB1OB0GWhPxjw5vrdHG5ULrXOYwftuS9xacKtFU7n+e7yQplFtt4pycvjF3KY
	 bULQYFyD9hfibXVS2gEeSZZwP57WenHFhrxPe8lzf7M7F8aDIn8wkA4N7gXfGUg/Kp
	 4pQmKq9SmFmqg==
Date: Thu, 26 Jun 2025 12:19:18 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v2 9/9] net: skbuff: Drop unused @skb
Message-ID: <20250626111918.GX1562@horms.kernel.org>
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
 <20250626-splice-drop-unused-v2-9-3268fac1af89@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626-splice-drop-unused-v2-9-3268fac1af89@rbox.co>

On Thu, Jun 26, 2025 at 10:33:42AM +0200, Michal Luczaj wrote:
> Since its introduction in commit 6fa01ccd8830 ("skbuff: Add pskb_extract()
> helper function"), pskb_carve_frag_list() never used the argument @skb.
> Drop it and adapt the only caller.
> 
> No functional change intended.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>


