Return-Path: <netdev+bounces-249674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC57D1C1BE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 742873009850
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F621D3DC;
	Wed, 14 Jan 2026 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM0HU06w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C531373;
	Wed, 14 Jan 2026 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357020; cv=none; b=Lc7gpxf8fMb24Q/c1dgcKmHqzrfWz1WbpnWvY+e8/keqAhqJcVwr0t9lQWkbTZvu+fR2eQsIrj5m3paxtMV/M1EDLF7aD9YuOIgHXgu2+NuXQuB1EeP+cSIOyVwDqrod5x3M3ZklSy3EY5YzvlNf7dwjccLoQ6vepMKtVVgUzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357020; c=relaxed/simple;
	bh=vrYvvSPxxxKS+qRXC9HBcSZDdR6f8CDo23l/715VS6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FT03/7oUJYj9ZmlBaxEcCYQkCtSudh5Xd9RfBOxFOaCc0ReLqK3Ma7zwrDAR19hl0MD3pO7S1Wq6QgJXBbidw6keX18rQPQ4L21kL8IslBnNurHV3N6ttZRd8QUVaUOanA7Kf52GBlB9DKMS7IkOX6h+wQB3r8ehObp4hS2uE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM0HU06w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC03C116C6;
	Wed, 14 Jan 2026 02:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768357020;
	bh=vrYvvSPxxxKS+qRXC9HBcSZDdR6f8CDo23l/715VS6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PM0HU06wUcT9eRu2x+ScRPl1gTWvOWA77eXPaA9gHzW7sTJ0sYth9CHPzU/MRnNjQ
	 pMxOeFaf8sHZZxkTly9OUq22HKxm/AXsTjWlYIxmK3SFeqBJieFCnFzGiRUkRkyCY7
	 KRRi20LWEEDq25TNPYJahWtKMrxOY09uZPEubavwhpuvqep/isRt5hN//MSZ0uzy2k
	 8pCtI6eHNzWPFEa2Uo0YzYurG64Al4y8+DQRV2Gu9wLq9565ONgQuTlJKQQn1z91NG
	 esIAwaEkt1tod36g50gSA2YO0+dMGM61IASbo5f27xNoqf8uMwFI/O8UFp3PemV8yp
	 4wy9FgILreuXQ==
Date: Tue, 13 Jan 2026 18:16:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Akihiko
 Odaki <akihiko.odaki@daynix.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260113181658.0b65b96e@kernel.org>
In-Reply-To: <916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
References: <aWIItWq5dV9XTTCJ@kspp>
	<e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
	<20260113093839-mutt-send-email-mst@kernel.org>
	<916a6c1a-681e-4e5e-8d49-75d0de5c46a1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 16:06:05 +0100 Paolo Abeni wrote:
> > Probably but I'm yet to properly review it. The thing that puzzles me at
> > a first glance is how are things working right now then?  
> 
> Apparently they aren't ?!?
> 
> rss self-tests for virtio_net are failing:
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/471521/15-rss-api-py/stdout
> 
> but the result is into the CI reported as success (no idea why?!?)

To be clear this is a HW test so the fact that it shows up in CI as
green means just that the 2 sub cases (per [1]) which the CI judged 
to be stable and passing are still passing. The other 10 sub cases 
have never passed and still don't. IDK if you QEMU doesn't support 
RSS or it's something else but AFAICT this patch doesn't appear to 
make a difference to us.

[1] https://netdev.bots.linux.dev/devices.html

You can see the per-case breakdown of the history here (including 
the ignored sub-cases):
https://netdev.bots.linux.dev/flakes.html?tn-needle=drv-hw%2Fselftests-drivers-net-hw%2Frss-api-py&min-flip=0&br-pfx=net-next-hw&ld-cases=1

