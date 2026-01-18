Return-Path: <netdev+bounces-250777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD80D3922D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23985300ACC6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A71DF987;
	Sun, 18 Jan 2026 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbUSK2D9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC8500972
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 02:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768703253; cv=none; b=Vz8lwgwTs4w9F8aoFpDe0Juu2yfRd+SZcff61tAXdP7DpejZkbDeOY7n4aFLAwc1mXWawJdevtoqO45k9L6L+U9ZBrk/NSnLscoarQcu24//3cpcA0Ur6z2fcxKzEWxg5YO7rqoyovvrxgpJwqOza4zqBXE7A6IZbZZMoB82a0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768703253; c=relaxed/simple;
	bh=XJx7OrWTx8CWXS5JpPnHJFl4mXuiTR+YYFBuo4cagSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIYI5+V7NLqnvyPI28cRtNtfhlMUr5XUft1f5C9J7zx0NsscobdsOLk+3BFW5v2a44ydrbqif1u9Q7pkPXmZ43xraV4lUNdeor+/P/jf4cUZqXWeGrIvOzLVp/zeqgQjx4zg/RQO+sgc8T3lgYeOuocwRKYtRWrDEyODxAFIGI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbUSK2D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDA8C4CEF7;
	Sun, 18 Jan 2026 02:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768703252;
	bh=XJx7OrWTx8CWXS5JpPnHJFl4mXuiTR+YYFBuo4cagSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbUSK2D9RQVjC03OLRLm9cUIlVWfqLNImCiZ2k4pWJSn6fsRhLtcwzpUNHy3uC6HG
	 M06lfWtLKSpNv0XM7OuBUQkbHCS8v4WdrCKoBMHmBuLRlJXNJ5capa5NY6TyAyuobO
	 yj+idvclSgLCGWzd5Ar1c/JXbebkp+jWngGO1XXaZEPkwTEHIPqQTouVFcQSs5laqL
	 l127hF1n2AYnivpDxx/tw6TmkPhgHkrepRJ0ad8cA02ZsuaJedIU2lWproEX+zr9jX
	 LfnTLPxx01y1HWVpW4mmm1TdKFbfjcKoL8gG0185XlIoawyQnkrYSJkKAVpkgc45Qb
	 Gg5zhX+kaW32Q==
From: Jakub Kicinski <kuba@kernel.org>
To: petrm@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next,5/8] net: core: neighbour: Inline neigh_update_notify() calls
Date: Sat, 17 Jan 2026 18:26:30 -0800
Message-ID: <20260118022629.1105469-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <e1528224375ebd8789994668a286fb3105dbb2c4.1768225160.git.petrm@nvidia.com>
References: <e1528224375ebd8789994668a286fb3105dbb2c4.1768225160.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm a bit behind so I haven't validated this myself TBH,
but in the interest of time perhaps you can TAL?

This is an AI-generated review of your patch.
For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: core: neighbour: Make another netlink notification atomically

This commit moves the netlink notification call in neigh_timer_handler()
earlier, into the critical section before neigh_probe() releases the lock,
to fix a race where notifications could reflect stale state.

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 635d71c6420f..5512dd7035b1 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c

[ ... ]

Earlier in the function, when max probes are exhausted, there is this code:

        if ((neigh->nud_state & (NUD_INCOMPLETE | NUD_PROBE)) &&
            atomic_read(&neigh->probes) >= neigh_max_probes(neigh)) {
                ...
                notify = 1;
                goto out;
        }

Then the new code places __neigh_notify() here:

> @@ -1180,6 +1180,10 @@ static void neigh_timer_handler(struct timer_list *t)
>  		if (!mod_timer(&neigh->timer, next))
>  			neigh_hold(neigh);
>  	}
> +
> +	if (notify)
> +		__neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
> +
>  	if (neigh->nud_state & (NUD_INCOMPLETE | NUD_PROBE)) {
>  		neigh_probe(neigh);
>  	} else {
> @@ -1187,10 +1191,8 @@ static void neigh_timer_handler(struct timer_list *t)
> out:
>  		write_unlock(&neigh->lock);
>  	}
> -
> -	if (notify) {
> -		neigh_notify(neigh, RTM_NEWNEIGH, 0, 0);
> +	if (notify)
>  		call_netevent_notifiers(NETEVENT_NEIGH_UPDATE, neigh);
> -	}

When the neighbor exhausts max probes and transitions to NUD_FAILED or
NUD_STALE, the code sets notify = 1 and then does goto out. This jumps
directly to the out: label, skipping the new __neigh_notify() call.

The old code called neigh_notify() after the out: label, so the netlink
notification was always sent when notify was set. With this change, the
goto out path no longer sends the netlink notification to userspace,
though it still calls call_netevent_notifiers() for kernel-internal
listeners.

Is this an oversight? Should the __neigh_notify() call be placed before the
goto out, or should the goto out path have its own __neigh_notify() call?

