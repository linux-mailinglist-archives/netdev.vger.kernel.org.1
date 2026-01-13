Return-Path: <netdev+bounces-249248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE0D16400
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA91C3027CC2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0D2D4805;
	Tue, 13 Jan 2026 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWBBMepc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4FD22258C;
	Tue, 13 Jan 2026 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269640; cv=none; b=E3HaZ+YDLO/24IBv/k8Crh5KhfYHAdLyt/ZRsJC94B7Y52qDBx7bzdy21ObSMR0QYKMW/dvzCeJxunC25Imh6z8vjBdsY0CKzCKnAtmtABqY0Z24wciXxU8pqidRbkGu6+UGskUrzp2Eith/4TwaCZ51Gw5ZQa6iK1j4dpCtRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269640; c=relaxed/simple;
	bh=4EMDG5MkNURT82eJloQVVgkX9mdPfR3RCLoql906wHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HH+LKZqFezBoRZILFnbGC/OGRTJ/rxNxOpM+hxjoYdRn2T/l258u8GZv9WksaLcUHSaZNyyYul9up33Bdf0UdjFBTaPmiIR4A8Fn2OnUNbwphIUAFcd2fx4iDlubmVPT4BxjS6GFunlZsOP3EmZSw0PQyufd1KrJ845b9IOdms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWBBMepc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7D0C116D0;
	Tue, 13 Jan 2026 02:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768269640;
	bh=4EMDG5MkNURT82eJloQVVgkX9mdPfR3RCLoql906wHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lWBBMepciK4CWeA+W9PZrytxuc3GkF5he3To6Ttyy7KsQcTkLfOZBfH7lQ9JRdWL9
	 lAWKDGnyoIEigQhZZYCvCrlPFNOVqZEmDSqvprvuMXvArKAR3ry4I/JcQjpKFJTAMU
	 SkBEdYdAWvhtLVI9j2QVjW9wIWwx5krEvv5CqosYP3SB/OQ0RqIXcmNIj5yNWMXJ2l
	 1fNVypha1QboN1YThvF7k3JMtzQE41b08MlQWGTGV0sHIab/EddysisXM69FUiyHO3
	 ox+KtGooyZpUmpJsppU/OAI6ZCEMskg03dzRBqtupyAsMAh21C7e2jbigsaVpU94Er
	 j0KY11SC146LQ==
Date: Mon, 12 Jan 2026 18:00:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, Stanislav Fomichev
 <sdf@fomichev.me>, asml.silence@gmail.com, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH RESEND net-next v2] net: devmem: convert binding
 refcount to percpu_ref
Message-ID: <20260112180038.0ab231ae@kernel.org>
In-Reply-To: <20260107-upstream-precpu-ref-v2-v2-1-a709f098b3dc@meta.com>
References: <20260107-upstream-precpu-ref-v2-v2-1-a709f098b3dc@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Jan 2026 17:29:38 -0800 Bobby Eshleman wrote:
> Convert net_devmem_dmabuf_binding refcount from refcount_t to percpu_ref
> to optimize common-case reference counting on the hot path.
> 
> The typical devmem workflow involves binding a dmabuf to a queue
> (acquiring the initial reference on binding->ref), followed by
> high-volume traffic where every skb fragment acquires a reference.
> Eventually traffic stops and the unbind operation releases the initial
> reference. Additionally, the high traffic hot path is often multi-core.
> This access pattern is ideal for percpu_ref as the first and last
> reference during bind/unbind normally book-ends activity in the hot
> path.

Applied, thanks!

