Return-Path: <netdev+bounces-199403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A27AE0287
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0006C5A1E18
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2F42222A8;
	Thu, 19 Jun 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HucUzwXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30121B9C3;
	Thu, 19 Jun 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328404; cv=none; b=ikf4jMth9TdaQ80T4r7qztM1aXZm5KVpeqmFl5ogfi88kWL+RHEQRI0+KN9Gld6/KNN5bDJfB1R17+XIuH6fF5urqTFpAZa90j74oaeTVmfy2oJNjtaNqMtzpgtT1KHV8CGgJ/Gmo8xWL3cOAPJp1b4LRYa7ckT4H0/EMmTJy4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328404; c=relaxed/simple;
	bh=/xxxdOXxClv+4BlH6eXnvPuhgcqk/6z8rlUMU8yyyJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv6zqVbGWUhIItQ10xRuQZLf1MxlS2lV3ChZSSv5yYnufCSAIV6tgmn5Ym9YKGKI4zRuxOf/HQnP+4UeKWgDA56RnCk41vByPWLGOSHzikt49xT4GQ47xXPmyzNDG9jja1Kr0oP+/0gM2mXLgGVwNX5kLwy+0/2M/rnfz3R1XRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HucUzwXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A7EC4CEED;
	Thu, 19 Jun 2025 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750328404;
	bh=/xxxdOXxClv+4BlH6eXnvPuhgcqk/6z8rlUMU8yyyJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HucUzwXDrAJOTLh0mIepk0Fovd/rehk1tTA/bZpmFBxAL5M2v9eewhUDCQy5rtBZG
	 jjRdVo6fKh70vGIWDSsvJcuJKGWzZj6B2lzS6twwxr6ZbLpKRvpLddVGQOB1M6LCuu
	 HYSp3fxN+TIwbc6Vzknhm3GphuOlxx9e1rOxXuJXIb5gpQWSguP34RDTz6THjUrwCF
	 KzM86t8VanCyjG5H7WyOwIxTr7I8/6HD0NB+km9pysrWFP9pzymJ9wUwEJz7p/4WJN
	 r7+4akkwqp+gsMPP52boiQQLRrERbO/caxHWhG3aJO7wzn/SsaXxDsrTESEQmgl4OM
	 is2trKMcE3N7w==
Date: Thu, 19 Jun 2025 11:20:00 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	jv@jvosburgh.ne, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH 3/3] netpoll: Extract IPv6 address retrieval function
Message-ID: <20250619102000.GG1699@horms.kernel.org>
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
 <20250618-netpoll_ip_ref-v1-3-c2ac00fe558f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-netpoll_ip_ref-v1-3-c2ac00fe558f@debian.org>

On Wed, Jun 18, 2025 at 02:32:47AM -0700, Breno Leitao wrote:
> Extract the IPv6 address retrieval logic from netpoll_setup() into
> a dedicated helper function netpoll_take_ipv6() to improve code
> organization and readability.
> 
> The function handles obtaining the local IPv6 address from the
> network device, including proper address type matching between
> local and remote addresses (link-local vs global), and includes
> appropriate error handling when IPv6 is not supported or no
> suitable address is available.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


