Return-Path: <netdev+bounces-70469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90384F23A
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB97285402
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872A66B55;
	Fri,  9 Feb 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THZ+COhR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F5664B1
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470680; cv=none; b=nYbPu2jRMll+H3Qv6qF8JmaYjL9IFgXiYJEneNepaWgq1ERFR5jrMMdpLBAKUYt53sAFOYxBAUkJnZHBBlXpq5QqEfvlGBeOecWon8KoW5u2uUrx7pSRvbGRfA2fDgpFplBjs9fbp6dQVxezbAHiI7oSmDs9Z/09tnatxFMMCC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470680; c=relaxed/simple;
	bh=yMsLnQS3lNnBR12LNCP0z+H5Kmt76nE+iLDqawtzJhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIDmSTrCc04XSCuf+66/dkF+mxa7ReTKqdJYfevg5+y+7/ybL9biin9uvSTa5lrXQnNK9FBqH1tb5IN8PHH93IliA6VbSSdlVzj+b8jlQVXo5ZzBXyD+9xlebSSXHbGLH4XA0bWlE0teEldAbTvV5qA1rCZvJiwdrdWuiVDxaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THZ+COhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B013AC433C7;
	Fri,  9 Feb 2024 09:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707470680;
	bh=yMsLnQS3lNnBR12LNCP0z+H5Kmt76nE+iLDqawtzJhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THZ+COhRVEi3hkHXtDWvDU4cvYQBdCHlMTNnnm1bodcRC8rwlHiI0ffs+CoSCd8y/
	 /pZLBF2ei4norC9hdim3C48w7D5hrUiH5mX7H7u2L5FJcyYcUfl8HfnpamsUwqmeH8
	 UsfsT52iNu8T2+TP4FBIk7VCU1KDVArMLA9IZ9ngmGOUT7E/rEnnmHp2+XeNjfg0K/
	 1OS1HOs1gFchknUcirVUNBiJos3bjglf1I4/f5NkLYrau0fP/Xu9x694mnpEMBCVv8
	 RXP3CiKRc4YUafzLWw+XotaZla6D0PYKVFj+q+zlu3iyYRBVuu37x2tabNvpslA+yN
	 Pb/lMWHN8IbNw==
Date: Fri, 9 Feb 2024 09:24:35 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net, vadim.fedorenko@linux.dev,
	valis <sec@valis.email>, borisp@nvidia.com,
	john.fastabend@gmail.com, vinay.yadav@chelsio.com
Subject: Re: [PATCH net 2/7] tls: fix race between async notify and socket
 close
Message-ID: <20240209092435.GO1435458@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011824.2609030-3-kuba@kernel.org>

On Tue, Feb 06, 2024 at 05:18:19PM -0800, Jakub Kicinski wrote:
> The submitting thread (one which called recvmsg/sendmsg)
> may exit as soon as the async crypto handler calls complete()
> so any code past that point risks touching already freed data.
> 
> Try to avoid the locking and extra flags altogether.
> Have the main thread hold an extra reference, this way
> we can depend solely on the atomic ref counter for
> synchronization.
> 
> Don't futz with reiniting the completion, either, we are now
> tightly controlling when completion fires.
> 
> Reported-by: valis <sec@valis.email>
> Fixes: 0cada33241d9 ("net/tls: fix race condition causing kernel panic")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


