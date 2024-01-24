Return-Path: <netdev+bounces-65499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5083AD6A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A952857A0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF337A709;
	Wed, 24 Jan 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm6o3kfV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B377F12;
	Wed, 24 Jan 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110351; cv=none; b=WKhIpNS2VaPKzUV5XirwwIO8P1f9704Qt2rzFA1Oq7U5obLfTkuHaBz+smRTLBtvGiurvFcOuqzRCP0JlXWPpfTZC017kLl1um5brtptiwR97A75W47430Ut0bE5KaN8VmqBfEbADeJQuizZ0oo6NEdA4s50fE+6X1AKcemiGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110351; c=relaxed/simple;
	bh=PxSCMMeeR1jl9YG+jX7bY1BKQnReSnfXQPCmoYXwD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhWwZZS7cf6EaZID6S10SXIPq3pbDqlYmor/YRz1pMCoBth2jzXJNKg3scm5iN5iQ3ooDQhw1y4lYvGUIlbJudeT0aqYBDzWBjcdNZd/m+iismG0GLoWA3gwaPTGCSi2UJTmdJDBd5A5btYCNMuO70sWsP73hgUfPbIJJ4MnaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm6o3kfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8E4C433F1;
	Wed, 24 Jan 2024 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706110350;
	bh=PxSCMMeeR1jl9YG+jX7bY1BKQnReSnfXQPCmoYXwD0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bm6o3kfVKhQjLtQ7sYKhcBJYUHwmN86juNOfKkI6sFDUhbOWq+9M8L2LjRbA4BzKo
	 G9375ABG23xDPq7dFid4mzFJ3c7+I8rWHZpve89UxA8lJSnWeOsQxmB45pig0C18V4
	 VcxS8mb0eAM1t7AtnIx2ZdQgt3ZxY7gQaZFbu+EMJY/Hupw8XyIdmcvxe4bBNka9hu
	 KIdrblZongFtVo93pyzaB5q5sxuCTkOP6kOJgORWxbTLjLn9kymP+WfJhDnDiLwrSZ
	 +QwyQ53URMXkkVG99vzNh44HINkrtmIw6NUEBSmLUUQoRLh9JAPCTgZp0+A0dDR61d
	 7NbOrnOTZWW6w==
Date: Wed, 24 Jan 2024 07:32:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>, Jiri Pirko
 <jiri@resnulli.us>, Alessandro Marcolini <alessandromarcolini99@gmail.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages
 in nested attribute spaces
Message-ID: <20240124073228.0e939e5c@kernel.org>
In-Reply-To: <m2ede7xeas.fsf@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
	<20240123160538.172-3-donald.hunter@gmail.com>
	<20240123161804.3573953d@kernel.org>
	<m2ede7xeas.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 09:37:31 +0000 Donald Hunter wrote:
> > Meaning if the key is not found in current scope we'll silently and
> > recursively try outer scopes? Did we already document that?
> > I remember we discussed it, can you share a link to that discussion?  
> 
> Yes, it silently tries outer scopes. The previous discussion is here:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20231130214959.27377-7-donald.hunter@gmail.com/#25622101
> 
> This is the doc patch that describes sub-messages:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20231215093720.18774-4-donald.hunter@gmail.com/
> 
> It doesn't mention searching outer scopes so I can add that to the docs.

I'm a tiny bit worried about the mis-ordered case. If the selector attr
is after the sub-msg but outer scope has an attr of the same name we'll
silently use the wrong one. It shouldn't happen in practice but can we
notice the wrong ordering and error out cleanly?

