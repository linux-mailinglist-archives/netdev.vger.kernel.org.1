Return-Path: <netdev+bounces-205430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FFEAFEA53
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8994481635
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AB276025;
	Wed,  9 Jul 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0Eb8pt1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3922C187
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068156; cv=none; b=oLs2YF8JQZDa1s+25l5ViLEeUQPbGTfRyFb3KT3BjhDxu+Lqnl+s/RzTu26oTL0ItWPJjOzfNJH6vYTsSnT+zGNQqVVwbjjFMoHqhyq37DbMSF1Ge3dWuEAbudKOp3b6lTPJhDqLML11lnRCbBwjOtlLTnOYSvT9zvDQ1XGInWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068156; c=relaxed/simple;
	bh=gKiGZ0AksMwzHB5RRv/vFdwH3Y2aHQGDuyLyd2pl6Io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEzJ8dNJi9d8cSkByJKb3iEYPrhZKSvmGbCyuzjMM3orjOjqJGwkLMG2rq/QXurd9Dft9f63/fRQbcyAnOgm9y5Zo7Sv1Cab+WaNyZp/+RbL1XrRnyHaYuDW7cMA+fH358rFlZpjPnELWG3X0+FnnS+6e7ymsn0RH3UK5OST1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0Eb8pt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C586C4CEEF;
	Wed,  9 Jul 2025 13:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752068155;
	bh=gKiGZ0AksMwzHB5RRv/vFdwH3Y2aHQGDuyLyd2pl6Io=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z0Eb8pt1bpcj917PTMIV7dERDEjIPA83VaeWi0xqf0VnWpiOJ32+AWhoKbKIf8BaC
	 6AAMcymB6tg/TVaa7hMqvpr+suQrRG3uBS5k9Xrd4yc7rn1hTwwhJD6EDA2qS2A1Jz
	 w72e06qilRUH/RqJAcKrqEsS7Q0ICsD7EEGZbzfZutGGCoXP8P/YA5/ulwigT3ZB3f
	 DFilxbP108NAqWAhYsyf++ToFBlTsRr8PKPcO8DXpLdFrx95Tdl3Zhk7j2UMxkgp4b
	 +h03B97wXt4gtEzGLW5qp3T6smdW2ZTs82gldathYfYmLMd2jdy+OjoLEuqZZiKarj
	 fFvo80qnVxCGA==
Date: Wed, 9 Jul 2025 06:35:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 5/8] net: s/__dev_set_mtu/__netif_set_mtu/
Message-ID: <20250709063554.7c771beb@kernel.org>
In-Reply-To: <20250708213829.875226-6-sdf@fomichev.me>
References: <20250708213829.875226-1-sdf@fomichev.me>
	<20250708213829.875226-6-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 14:38:26 -0700 Stanislav Fomichev wrote:
>  int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
>  		      struct netlink_ext_ack *extack)
>  {
>  	int err, orig_mtu;
>  
> +	netdev_assert_locked_or_invisible(dev);

This one fires, should it be ops-locked?

[ 3137.181693][T26830] ------------[ cut here ]------------
[ 3137.182161][T26830] WARNING: CPU: 1 PID: 26830 at ./include/net/netdev_lock.h:17 netif_set_mtu_ext+0x27f/0x5c0
[ 3137.185509][T26830] RIP: 0010:netif_set_mtu_ext+0x27f/0x5c0
[ 3137.193144][T26830]  do_setlink.constprop.0+0x6b1/0x2480
[ 3137.198661][T26830]  rtnl_newlink+0x69a/0xa60
-- 
pw-bot: cr

