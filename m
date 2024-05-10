Return-Path: <netdev+bounces-95420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79F8C234C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA83B212B0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA92171E45;
	Fri, 10 May 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khaIeUmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450816DED7;
	Fri, 10 May 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340317; cv=none; b=I58yYs/Ullb6iLCgP1bYMgOlqjd1NFeb5W/7cuNbiPE4OiYnfzOmfR3w4A9oB3zWlC581sPk1VMDGYgs4j6D/5rMdM7vPoH4ousKeg92C0TgzLksA67bW91h1YC8roEzYcGFUutc5IyHM3BX4mCVUjxAh6qKt3j7tx2Ce89dbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340317; c=relaxed/simple;
	bh=WG+BHitREva4mvWqnkP0ffB4OiWqF5eUwg3pXCEUjvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugZkxZzs0TgN3VeLYPaSkph2/t+O+SG/7S+pqJqbkzcrbFnBe7oU8F4d57pq5l1nu3EAMrq9aeuVR1CRQSeokRrwtJ+NvADROqD1KP9JvstGx5j78wbyqKKpMP2/xrfoO9akhhM7Znc2E7GS7fRYyDPKdD+Rg7OE2wki4MPVl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khaIeUmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF058C113CC;
	Fri, 10 May 2024 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340317;
	bh=WG+BHitREva4mvWqnkP0ffB4OiWqF5eUwg3pXCEUjvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khaIeUmp735MpQM7gD5I0uij1D5Eq+UvCjqDAKL17wDtVeCAbQh5a2nQZcVZAcanE
	 7eTy21WcNpMeCm5EFAaIweoRCu9xJcAy8IL8mYjHsGOOODHtWcW/1NtXmBEtgibk7Z
	 cBHVC7K5C2H3rjhfUTXnGaazncKGkfxzZY8S8xqIWid5RB7oMgM2fbJI4KKplAu+G0
	 xbUK+o7WcJ6LBkRNUeOLQ5PQGzs7sgj/Gtd+UayLxgPb01wKVkP7Dakz4Mc7kLouBE
	 DLRIqPeXl7BnIrzdPZfZ8z5VLHIz/HuzL05KQvL0vUQhijcQ2UTrcXaJf/Z+olhSNc
	 gHptO59JM3gGA==
Date: Fri, 10 May 2024 12:25:11 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 00/14] net: qede: convert filter code to use
 extack
Message-ID: <20240510112511.GC2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:48PM +0000, Asbjørn Sloth Tønnesen wrote:
> This series converts the filter code in the qede driver
> to use NL_SET_ERR_MSG_*(extack, ...) for error handling.
> 
> Patch 1-12 converts qede_parse_flow_attr() to use extack,
> along with all it's static helper functions.
> 
> qede_parse_flow_attr() is used in two places:
> - qede_add_tc_flower_fltr()
> - qede_flow_spec_to_rule()
> 
> In the latter call site extack is faked in the same way as
> is done in mlxsw (patch 12).
> 
> While the conversion is going on, some error messages are silenced
> in between patch 1-12. If wanted could squash patch 1-12 in a v3, but
> I felt that it would be easier to review as 12 more trivial patches.

FWIIW, I like the easy to review approach taken here :)

> Patch 13 and 14, finishes up by converting qede_parse_actions(),
> and ensures that extack is propagated to it, in both call contexts.

...

