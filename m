Return-Path: <netdev+bounces-123764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C161A96670E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F2A1F2278F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAFC199FAB;
	Fri, 30 Aug 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSISjPwb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BA13BAE2
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035861; cv=none; b=ueA3KnRSQn8kSLiqZKs6Ku7V03JUAQtRvZ36NxRLJhVcdCdHxdPR98DZ0lqYqPsH1hrc8IVPfcSk9BqDeTjMOQ7bel5DNP7XOgbyYnoIQ+Z5TOT+eZ//m7mW90bu/UEd1TDM0fLnGsR4jsZp25utC4T4Q7MrlsMEhVhJJvUdFOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035861; c=relaxed/simple;
	bh=jkusSWodp/vN1AhmF1EG2XqtpPOKMWL0X/m78Z1j9EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRScO9UMZwBtQHm3LeRIAI7Ob8dl9nj+aZHdBqkrLXpZvwpniCpCFrniRLECWlfD1PNzsIgn2v7csAd2yDcfZAiE2sclZXx7OuWVw4tKiQ3DFTw9eEDsSgwOTi/MXFq66iFLM1NQVuFvQw4Vu6E57UhomlIrJeSMstpdu6Jz9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSISjPwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25415C4CEC2;
	Fri, 30 Aug 2024 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725035861;
	bh=jkusSWodp/vN1AhmF1EG2XqtpPOKMWL0X/m78Z1j9EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSISjPwbzv/xJAvao3V7ZmSeRa8PHlIa+QofJ/0fA9PpXzkUZM5Qg953NR5KipNll
	 yVI+oDuhqGxNZSfmb+LNRRAfrBdNYNPGYnE0pU3vRl5GRW/v+/d3+RvzFXjSjm1e/g
	 +bdV9igp+346AgrlN1ND9URxZRBQvSWaoK4NithKZ9Kt+/Q8TtEwLYmFS7MYUVyZ8L
	 ORK+obBzwakzO2elOkp3W6X5eIDVhBkCAZrXISuDDE62oO6cDYzGsMCdXB9ECO31MH
	 +MyNj8JN+u7ckekEio/oJjrde/kv3aifILYp4uF0qWDcZ5VWPjWArFiJNiK9hrlMNN
	 sMx5aypgno/gg==
Date: Fri, 30 Aug 2024 17:37:37 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	Julian Wiedmann <jwiedmann.dev@gmail.com>
Subject: Re: [PATCH ipsec-next] xfrm: policy: fix null dereference
Message-ID: <20240830163737.GV1368797@kernel.org>
References: <06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com>
 <20240830143920.9478-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830143920.9478-1-fw@strlen.de>

On Fri, Aug 30, 2024 at 04:39:10PM +0200, Florian Westphal wrote:
> Julian Wiedmann says:
> > +     if (!xfrm_pol_hold_rcu(ret))
> 
> Coverity spotted that ^^^ needs a s/ret/pol fix-up:
> 
> > CID 1599386:  Null pointer dereferences  (FORWARD_NULL)
> > Passing null pointer "ret" to "xfrm_pol_hold_rcu", which dereferences it.
> 
> Ditch the bogus 'ret' variable.
> 
> Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
> Reported-by: Julian Wiedmann <jwiedmann.dev@gmail.com>
> Closes: https://lore.kernel.org/netdev/06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com/
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Simon Horman <horms@kernel.org>

