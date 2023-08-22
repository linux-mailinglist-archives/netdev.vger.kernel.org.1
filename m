Return-Path: <netdev+bounces-29545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B6783B3C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBC31C20A6A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA88470;
	Tue, 22 Aug 2023 07:55:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18B8466
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A98EC433C7;
	Tue, 22 Aug 2023 07:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692690943;
	bh=HgS4yGKAG70Gf+ddyrfQ4yCXJvgfhzVcU5cE2sHvA9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmeH0c00ZEtMrTSee7G6WcrDoSDkz6l1EhgHWG8XYQCpb3JTyzQv5iTt3GMmc76ne
	 i1F1KiRzfGGdgIs8m48wRn1si931WnDn7FDAkX18fj4/FPytTfgkvyE5l0ukjG/kV0
	 gGc3eOCKJeYdBy7Rz4o/jnBDaaVk4Aa0Bl3WdmeR+BpAL6Oqbiz/Uj8jk10qAw0D9t
	 VSsqXjYuXo6W1yUW1evsW1CJT0tckM3QDcfBijXoD41oZkCaYW1iKIzO6RdYoblcUN
	 BIvXBy3xB6d8jQXDNahmfXhNId5AEdPJMyOoo103N3Uv6aNDWlWGpWk9gUDsuwEezH
	 0IWLP+fv7l51Q==
Date: Tue, 22 Aug 2023 09:55:39 +0200
From: Simon Horman <horms@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
Subject: Re: [PATCH net] batman-adv: Hold rtnl lock during MTU update via
 netlink
Message-ID: <20230822075539.GU2711035@kernel.org>
References: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>

On Mon, Aug 21, 2023 at 09:48:48PM +0200, Sven Eckelmann wrote:
> The automatic recalculation of the maximum allowed MTU is usually triggered
> by code sections which are already rtnl lock protected by callers outside
> of batman-adv. But when the fragmentation setting is changed via
> batman-adv's own batadv genl family, then the rtnl lock is not yet taken.
> 
> But dev_set_mtu requires that the caller holds the rtnl lock because it
> uses netdevice notifiers. And this code will then fail the check for this
> lock:
> 
>   RTNL: assertion failed at net/core/dev.c (1953)
> 
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
> Fixes: c6a953cce8d0 ("batman-adv: Trigger events for auto adjusted MTU")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> This problem was just identified by syzbot [1]. I hope it is ok to directly
> send this patch to netdev instead of creating a single-patch PR from
> the batadv/net branch. If you still prefer a PR then we can also prepare
> it.
> 
> [1] https://lore.kernel.org/r/0000000000009bbb4b0603717cde@google.com

...

