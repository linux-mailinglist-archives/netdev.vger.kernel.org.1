Return-Path: <netdev+bounces-133208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E29954D1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBF61C25A62
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418A1E0DC3;
	Tue,  8 Oct 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwwP3xYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD181DF98F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406051; cv=none; b=G6mL9RbwtlGKKhpl59q5qOublXRwRJWyg8CR0zVkqmgv5kjB0SCA/0z0thfEV5AIQV+NFB1BYtGd5N/DiBsTdC0RKT0a2C+LhOyFratV/qDJOvCCR7C6dQ68B3PuOFwnjwNTFj51McjqnQEvJPmWacllYntL1LYx7gY0QTZrRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406051; c=relaxed/simple;
	bh=7/Eb9fWJlEN7/MHJkVOKGtCvuqhzmLDj9GFtyQkGyTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t37RzQkRWLhNqmF8bLlMmIG52BhDOYY6zVxw9XARJmPH/nx0dmyyKHEqr9odH6JbNU7giwt5BYHsPu5UDM+ffFnXrdKEq/wJcAfWDhB37oETJB2eTmmXfMc+0BImGv16t2McbXulEhWBdATs6QYcFkJvWTnLKPvY48ELvMP9LtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwwP3xYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109F1C4CEC7;
	Tue,  8 Oct 2024 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728406050;
	bh=7/Eb9fWJlEN7/MHJkVOKGtCvuqhzmLDj9GFtyQkGyTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwwP3xYb7n8hPolshnlhWizhfuSJKAx6/hQIhWkgRR85q/x4LhXmLy+08eFC/tyfI
	 iTvdCNrLahpEYa5dFkBYqKchJsRkH6gkzjC8R5uid6mZBw0RoFS8Qhwsz46De9iHtm
	 DHfSnrnE9ZsBBlYAiLwOxSncAnd7YZ3rrlSD3hiOWmFFYXXVIDX8exOGhms0/VH+Bw
	 yLNuaP97IfUcxR7ODTrR/2cjFQnYfkiTjTtPR0XZ8azdHQ2VM2EEK/T/0CKvjRXcPW
	 CxK2/MSvTwjbMRwycKqSZh0BE5IxoyFFIOWIRF63zs7laOH58NLOg/mdCuMH9KO7y6
	 ClBXsd9xRXv3w==
Date: Tue, 8 Oct 2024 17:47:26 +0100
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Tobias Brunner <tobias@strongswan.org>,
	Antony Antony <antony.antony@secunet.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Paul Wouters <paul@nohats.ca>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH 1/4] xfrm: Add support for per cpu xfrm state handling.
Message-ID: <20241008164726.GD99782@kernel.org>
References: <20241007064453.2171933-1-steffen.klassert@secunet.com>
 <20241007064453.2171933-2-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007064453.2171933-2-steffen.klassert@secunet.com>

On Mon, Oct 07, 2024 at 08:44:50AM +0200, Steffen Klassert wrote:
> Currently all flows for a certain SA must be processed by the same
> cpu to avoid packet reordering and lock contention of the xfrm
> state lock.
> 
> To get rid of this limitation, the IETF is about to standardize
> per cpu SAs. This patch implements the xfrm part of it:
> 
> https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/
> 
> This adds the cpu as a lookup key for xfrm states and a config option
> to generate acquire messages for each cpu.
> 
> With that, we can have on each cpu a SA with identical traffic selector
> so that flows can be processed in parallel on all cpu.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

...

> @@ -2521,6 +2547,7 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
>  	       + nla_total_size(4) /* XFRM_AE_RTHR */
>  	       + nla_total_size(4) /* XFRM_AE_ETHR */
>  	       + nla_total_size(sizeof(x->dir)); /* XFRMA_SA_DIR */
> +	       + nla_total_size(4); /* XFRMA_SA_PCPU */

Hi Steffen,

It looks like the ';' needs to be dropped from the x->dir line.
(Completely untested!)

	       + nla_total_size(sizeof(x->dir)) /* XFRMA_SA_DIR */
	       + nla_total_size(4); /* XFRMA_SA_PCPU */

Flagged by Smatch.

>  }
>  
>  static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)

...

