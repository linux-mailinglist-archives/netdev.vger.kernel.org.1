Return-Path: <netdev+bounces-144139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 765DE9C5F5B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC36EB37E8C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA6200B91;
	Tue, 12 Nov 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXYmr9Eb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE2200109
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424481; cv=none; b=GfQckF6Fhnqr228vXigov7u3zSb9m8pokxLaLDpRPwyiSN8YrwlMXfbR8DcE/GvbL23dgiSH5G+bZ2cD++cgr9pIcZd/2WuSOzMu82hmA39xNMJO69DP8QKYNMTbX+P2B8aCpXrUpBrCN6oYp3lnK1DSCUDyxorVH+aJsy+ycSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424481; c=relaxed/simple;
	bh=Kjv+dUaivCeMePY/kXKpPE1hNCsyMGa18kwndOgnkNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd8RZtm9u+zAWBdIkTa2a9jofqHe9r6CAb+nq8dgUNWr5rVc5ldYA0esfMH0Sz+m5jzs+QUZjcLEMrWn4AZik1WLajql6DwOpnkBAWosPWJlWiGP9bRjbY/fWFd8g+9G6uPpsgjqzGxFYGeN9/APoXO0tzd9GedJN7m1TmqdTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXYmr9Eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE8DC4CECD;
	Tue, 12 Nov 2024 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731424480;
	bh=Kjv+dUaivCeMePY/kXKpPE1hNCsyMGa18kwndOgnkNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aXYmr9EbHDeMHEtFIwln2PyNLjlE9oNgPM5Hr7SD6rrKLuQCz18eXeVfotWGLwdDR
	 r0JUjbQv0qTnAKYvqcBrBKz9Z6rZOUdEZpbkgHvSZtmh3SARIQ2enUeN3JfbZUmPXi
	 m2Gp6vIrImW3PKBhlhfOSLviJsgl6mrdD+QmRtQ+cmhnPCNaIDQO+evVwM9uEd8F+e
	 UKPz7CBjL7Ecbi/obzU4aKgPmQB692hFF5wlhoFUXmBdBCg1u1aN3tPMVw17dl8ZrF
	 QNyJgL9T02y/yvr2sqpabWQ2rCfgDRFwl/oMVZ6w9vf4Gexr4WsU7miL1w5Bq/mI4q
	 6wPQ2aKVKP8gA==
Date: Tue, 12 Nov 2024 07:14:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: add async notification
 handling
Message-ID: <20241112071439.5ade3b1d@kernel.org>
In-Reply-To: <m24j4cvmlp.fsf@gmail.com>
References: <20241108123816.59521-1-donald.hunter@gmail.com>
	<20241108123816.59521-3-donald.hunter@gmail.com>
	<20241109134011.560db783@kernel.org>
	<m2cyj2uj11.fsf@gmail.com>
	<20241111100325.3b09ccb8@kernel.org>
	<m24j4cvmlp.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 09:16:02 +0000 Donald Hunter wrote:
> >> I don't follow; what are you suggesting I initialise endtime to when
> >> duration is 0 ?  
> >
> > I was suggesting:
> >
> > 	def poll_nft([...], duration=0)
> >
> > 	endtime = time.time() + duration  
> 
> I want it to run forever if a duration is not provided, but here
> endtime == starttime so it would exit immediately.
> 
> I thought the original approach was fairly pythonic - if duration is not
> specified (None) then there would be no endtime (None).

Ah, makes perfect sense in hindsight, I misread the code.

