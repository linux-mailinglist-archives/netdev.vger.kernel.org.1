Return-Path: <netdev+bounces-170070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8678EA4731B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D46188C305
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E0192B71;
	Thu, 27 Feb 2025 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMHTzf3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553D17A305
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623239; cv=none; b=Oo6utpbSUYB/Y0FMiDPMtXjUp9XglLbAIFWMahlSEN9uTKvc9tOWmyYkhY58yPSFg60H1OJBuuZETFDkM7WFoj9/SGlzKHyFz/mvRxnk/87KZGRXqvIxiAQ+R1dFrxppbg9XFuRtdGi39wt3g4e88EngIJtOgrS1F648r0Z8VWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623239; c=relaxed/simple;
	bh=G0H1pZJDU0Wb0RITmkZefyTNjGvBbtJoTQEtU01PuyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLN1fyuI+a0+PjeTb9MpNYq7bvkEdikrSxpJmxHGAi+QKYi2OGZJq6K4H51LdzxoR1CrdFb0f29J+hmBx//5JeUHCaSvwrKwiy77Jf8FHfHwvG3wnIlZyX5qAwGrqUBPTQKbmuE0UoEHoApesx1n4C2BnAmeif6e6/8YaRosuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMHTzf3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFFCC4CEE2;
	Thu, 27 Feb 2025 02:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740623239;
	bh=G0H1pZJDU0Wb0RITmkZefyTNjGvBbtJoTQEtU01PuyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BMHTzf3H8iQeNur/cV6diwkGhh5l04v6PtlLvwocue/p5E7SGvvQV8oYTc3hc3BOe
	 86ohPSw6Z/3/t6VBu0j/pPKPP1xnqOoeicCH7a0TjXIKPwh/EkxLrkfOGdhNwkQcWX
	 QBdV2fVjBNFMI03LooJbUP09JzoSYb0fQrCET0555E8idQbn97aKfuBhiNfsxjHMLj
	 i6gJl/rnU92hAX3Gfxftj/zcH+cZWviV4HMtyt93G8LsrHZ84I4+KE7AMdcSFEI5ZW
	 vUZSohDGhYGwzaBWzS/tN3O7MRHrAxo9IqRbNlZd9agzfapFCGkB7B31fqwXY8gFXz
	 KN2g9XcLSfOyg==
Date: Wed, 26 Feb 2025 18:27:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context
 exists in case of context 0
Message-ID: <20250226182717.0bead94b@kernel.org>
In-Reply-To: <8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
	<20250225170128.590baea1@kernel.org>
	<8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 08:08:40 +0200 Gal Pressman wrote:
> On 26/02/2025 3:01, Jakub Kicinski wrote:
> > On Tue, 25 Feb 2025 09:13:48 +0200 Gal Pressman wrote:  
> >> Context 0 (default context) always exists, there is no need to check
> >> whether it exists or not when adding a flow steering rule.
> >>
> >> The existing check fails when creating a flow steering rule for context
> >> 0 as it is not stored in the rss_ctx xarray.  
> > 
> > But what is the use case for redirecting to context 0?  
> 
> I can think of something like redirecting all TCP traffic to context 1,
> and then a specific TCP 5-tuple to the default context.

The ordering guarantees of ntuple filters are a bit unclear.
My understanding was that first match terminates the search,
actually, so your example wouldn't work :S

> Anyway, it used to work.

To be clear unit tests don't count as "breaking real users",
and I assume the complaint comes from your QA team?

Given the weak definition of the ntuple API I'd prefer to
close this corner case. Unless someone feels strongly that
this should be allowed. If a real user complains we can both
fix and try to encode their flow into a selftest.

Let me CC Ed, too.

