Return-Path: <netdev+bounces-43368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 225B97D2BDB
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538DE1C2088E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3851079B;
	Mon, 23 Oct 2023 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqR3Z07z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366D10950
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6958BC433C8;
	Mon, 23 Oct 2023 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698047404;
	bh=v2aM/kvq72VOZ3jr1hNqEC20sqhqlJwe771PUm7Sbsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HqR3Z07z0GtHMmF5bpI7wwNlVb2Kw418tFJCwKpbhmQ9oLt+gN+d7AEX/g+odrA6N
	 J0jCpTO4vl0fzwBJs/g/C+BwTwm9RxDUy+XXqhp/eSfluVTrsRzN/k0sWudpp+mpgc
	 Dm3cQ3qetvwvjem3Tai9qFLuj/jnKEwdUECc6+RQpGGvpphxgdQxGU3+YlvJ4HQw1h
	 aHvx34K+Utp3QtIiIVPIfHzoReqkF0uG6wIw9gSwMZRtHLkDLt3zbfj0ebfspWyatL
	 FmMUOYzBURQlTRP/+Y//2TWhBCKMqGeNyUIbWBM9UnqsjrwTfybLJmpzJ/O29Zvfwk
	 yE7tS1GaOO+eA==
Date: Mon, 23 Oct 2023 08:49:59 +0100
From: Simon Horman <horms@kernel.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics when
 raising allocated
Message-ID: <20231023074959.GV2100445@kernel.org>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
 <20231019120026.42215-3-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019120026.42215-3-wuyun.abel@bytedance.com>

On Thu, Oct 19, 2023 at 08:00:26PM +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
> 
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> So revert that behavior.
> 
> After reverting, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


