Return-Path: <netdev+bounces-181469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD6FA85189
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473238A3BD1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9D277030;
	Fri, 11 Apr 2025 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeEFXggT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3B3FD1
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338208; cv=none; b=K7LEIaW/DN/G4gXmAGMXwNaTtByOANoM2VLrA2yWA702Bz016UoSkbxyX2mt9bmWKtInDEcVUErtDR+3SzwZ+bPLsWgDuca7dTNlT9YJ4Ub1e4+8kZf8zyx99h1rAbl/ZYd294bO8lbKMQKJMCCGLPpjlDFP171zqxjzgqCh6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338208; c=relaxed/simple;
	bh=/msYS6J0X9FKkpyR/dJxeB4OzJbVxqz0aa/Q8HBKnfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqhJg1YnIvpD6xvQhszxAVSXokdRnDsl3tPe7xVvuVFJp09Br2BhPSqCwP/dTTVO0EAboJ5bIkT3IQJOQJnfhorYfuYYgdCrHicS0GRKQoBvzr1P6hXFJYdb6jFyRCigMtbmHlsRukcqqthsI388yEXAZVYJabElPvdAv+4xOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeEFXggT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECDFC4CEDD;
	Fri, 11 Apr 2025 02:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744338207;
	bh=/msYS6J0X9FKkpyR/dJxeB4OzJbVxqz0aa/Q8HBKnfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QeEFXggTzBjf2nNDTLm/7B/U5b0IVw9J/kBlXBy4+W4qQibF7unkccqHCly9xh2c/
	 jjRDok9Z+lgHAxMQ3McTAPlvIC5i7KOWa5JIew8tZBWzzWKvzRP81lt1Dpd0R2+dRB
	 0vKiFmFKnwpzgUioWxodPsdwAVJPx8ZdJzwvc3rAiaDnvwH2yIqdezAAjwogID7wuM
	 +Z6Jb98zuI77JqPJzjUPOUwHTFLUFdaw2Yl+xqvZOT2UFF6nPQ6Y/PvfrSbLeXUtkd
	 PZuz76PC+grpC4QJraQVrNJfjlNDlzPUskutfwu718DI8DCMkUYeKcyQTe9Mn05ceF
	 WbsfIjTLtHwdQ==
Date: Thu, 10 Apr 2025 19:23:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <sdf@fomichev.me>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
 <hramamurthy@google.com>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 6/8] netdev: depend on netdev->lock for xdp
 features
Message-ID: <20250410192326.0a5dbb10@kernel.org>
In-Reply-To: <20250410191028.31a0eaf2@kernel.org>
References: <20250408195956.412733-7-kuba@kernel.org>
	<20250410171019.62128-1-kuniyu@amazon.com>
	<20250410191028.31a0eaf2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 19:10:28 -0700 Jakub Kicinski wrote:
> On Thu, 10 Apr 2025 10:10:01 -0700 Kuniyuki Iwashima wrote:
> > syzkaller reported splats in register_netdevice() and
> > unregister_netdevice_many_notify().
> > 
> > In register_netdevice(), some devices cannot use
> > netdev_assert_locked().
> > 
> > In unregister_netdevice_many_notify(), maybe we need to
> > hold ops lock in UNREGISTER as you initially suggested.
> > Now do_setlink() deadlock does not happen.  
> 
> Ah...  Thank you.
> 
> Do you have a reference to use as Reported-by, or its from a
> non-public instance ?
> 
> I'll test this shortly:
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b64c614a00c4..891e2f60922f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -38,7 +38,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
>         u64 xdp_rx_meta = 0;
>         void *hdr;
>  
> -       netdev_assert_locked(netdev); /* note: rtnl_lock may not be held! */
> +       /* note: rtnl_lock may or may not be held! */
> +       netdev_assert_locked_or_invisible(netdev);
>  
>         hdr = genlmsg_iput(rsp, info);
>         if (!hdr)
> @@ -966,7 +967,9 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
>                 netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_ADD_NTF);
>                 break;
>         case NETDEV_UNREGISTER:
> +               netdev_lock(netdev);
>                 netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
> +               netdev_unlock(netdev);
>                 break;
>         case NETDEV_XDP_FEAT_CHANGE:
>                 netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_CHANGE_NTF);

Ugh, REGISTER is ops locked we'd need conditional locking here.

Stanislav, I can make the REGISTERED notifier fully locked, right?
I suspect any new object we add that's protected by the instance
lock will want to lock the dev.

