Return-Path: <netdev+bounces-115781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD77947C3A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B811F22E5E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3455893;
	Mon,  5 Aug 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khh3UJ49"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBD4F88C
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865983; cv=none; b=H7AN7emscSmjSsX6UskAeA1z0bgEHd8IR89h1q1jHelq1ui/y6YKImN9ACB+/tCYNXIIFnAUo06Z0IGLhsilbSFEb+0Id/UkXrSWGNnHa+D4DlzO5XfYLaJnTDxoqF1iZhROJhi4IE/bgy6McyhsLh4byZNctw3NGWp52LYY1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865983; c=relaxed/simple;
	bh=PTC/TwdzZQdqeZATj3s1KwJdg6Yus2OpWccZmja8Iuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHUUvHagdM8fp6h+u3nS+I/mE2vpLLLB2eO3UDt9+YY9BjtFhrg6XVgsGF8/ocuFSLeuLemhEhVvHtwVqftGzmDVcLRNtvpuaYI3Xvxp3t1Jeu7tBzV5NVy2unElhCqF2B+bNiQMAZVM3LURVLQqXrEeuy6CyKwSHvTIPaqpMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khh3UJ49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8B8C32782;
	Mon,  5 Aug 2024 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722865982;
	bh=PTC/TwdzZQdqeZATj3s1KwJdg6Yus2OpWccZmja8Iuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khh3UJ49z3dzHf/O21mxRtSiHoK4dkjeohQPD3aMeraHSg2kf1YOnsCrOqDD+4V6p
	 Vlp0UqoAIryJsWReDGSImyn5sAZZuERkjK9+tOU+Lb/6XHE6n4WwOGNezq5n29pM+m
	 ylka0uEr0U6lFrm0P9i8mbFjgQoo3+rKBLPZqonGLF1DJ2Q9+8s1dY/i8lGfzDhkCy
	 KquriQcLt3ijnax+9Jf1aoxoLNrA28ZN0zrgpSuFgSZdaQ42LLHzyT0ZHZO1CbDGgp
	 gVeKld52M9QMg7nwYpDf2kZMEgVUxS5O9+T0AldKer+2lIZcvEFQWJ7TPM2+RLgolZ
	 mgyk9bcec3sfw==
Date: Mon, 5 Aug 2024 14:52:58 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/5] inet: constify 'struct net' parameter of
 various lookup helpers
Message-ID: <20240805135258.GC2636630@kernel.org>
References: <20240802134029.3748005-1-edumazet@google.com>
 <20240802134029.3748005-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802134029.3748005-3-edumazet@google.com>

On Fri, Aug 02, 2024 at 01:40:26PM +0000, Eric Dumazet wrote:
> Following helpers do not touch their struct net argument:
> 
> - bpf_sk_lookup_run_v4()
> - inet_lookup_reuseport()
> - inet_lhash2_lookup()
> - inet_lookup_run_sk_lookup()
> - __inet_lookup_listener()
> - __inet_lookup_established()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


