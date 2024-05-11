Return-Path: <netdev+bounces-95704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F458C321E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 17:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3277B20E09
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922AE56459;
	Sat, 11 May 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW5Y3u6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E733233;
	Sat, 11 May 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715441389; cv=none; b=srKzAhSXF6EmbQYOjomlhQjXPYFoXCwy925T8k5WjqTGaNDosO+D6KN7KzPgrA8ePAgfbzhGhA6egm19UhsC5CIZWcrjhzCtE6OvSQh1q6jx2f1yGh/n3B4vL0FGZFHqTVUG6wfkWkQ4ho45/olhq7xW15TXFnQdPeBPu2SNEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715441389; c=relaxed/simple;
	bh=Z0ik06uwvxyBg4rziq0qMGAbQFzb1BP4OALENZqNiPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHD7koQ/sZFQzZ+3w+z7+iPskrIU6KN7znT6NrYaxrzwW0q1DZXZJ95gokcy25pOdy0/V0qt8bnPleRBkSKvrc+0TzGG/lrqO322L1MbOLg/OdAODlOw+6/J4OR/CIGOD0CReADBVRIxWp0jy68f6ODlz2z4TMC0eZjXXAv87Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW5Y3u6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B90DC2BBFC;
	Sat, 11 May 2024 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715441388;
	bh=Z0ik06uwvxyBg4rziq0qMGAbQFzb1BP4OALENZqNiPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YW5Y3u6LubkuRZstjNdpkPmN5LHEXa6PrY4TvZs1rzTbIefWgfadqZrXfAiGRUfZF
	 1pGgToHB4u0sOE9uAKc8aG5HH3XzY2BXpwuhvGaq7UKM2L+K/9mjcJvdxlvDR/txrE
	 pgmSYekbauKbqQX2lCSE9KsP+zJvRZu/LGJ61dWClks6Dir+DPU4DuyN6774Ddfq8b
	 5woQZOOI6FD1V0tII26rca7heZIpzqATVHCaSUZ/8xzgd65gy5rRHkiohnz/AY2LPl
	 NpajaPQNrThVIT1xBUHs6Hg+dXsDWXfWhG1Xm9ijzhonjyAEZWuLWlXve8NUHvRK+w
	 BokgaLnuR6i2w==
Date: Sat, 11 May 2024 16:29:43 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: [PATCH net-next v2] net: qede: flower: validate control flags
Message-ID: <20240511152943.GM2347895@kernel.org>
References: <20240511073705.230507-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240511073705.230507-1-ast@fiberby.net>

On Sat, May 11, 2024 at 07:37:03AM +0000, Asbjørn Sloth Tønnesen wrote:
> This driver currently doesn't support any control flags.
> 
> Use flow_rule_match_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
> 
> In case any control flags are masked, flow_rule_match_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>

