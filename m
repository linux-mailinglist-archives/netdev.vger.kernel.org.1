Return-Path: <netdev+bounces-214110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 432A6B284D8
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE4C94E57E2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D972F9C34;
	Fri, 15 Aug 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P22/ntMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7B2F9C45;
	Fri, 15 Aug 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278427; cv=none; b=K3GihRNbXnvgkQ+srfXJwG0MD1YKFcM2dRg6s4VwrSwTaKMw2jjcbSXmomvDOkvbGWD0obaTsIcUtpnQ2dmzdGPHcM764UqQ6Q6akfD4U9hcqL717yb4DaOH8boypqoO1SuLEP5MzlflCBFq9VZ0kRnmckkVvy2suzFGen+ZvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278427; c=relaxed/simple;
	bh=bZHXMBWIWtOd9P3kjklQ81O4Y1/Lvowqh+ondUT2CG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Egm+EnR+LxzSCPVTJHaxAWnQUVup+b/aLNSd2zysDZXR5jx8b/dQ9SuTb8QBoYjS+l21nzJq88jerRKrIsJm0pam85yKRH2ekBxnHzVxiQJdSCx8LEDWTZGgPVejRn9Tx3f2nEoEyvgBqMlLxD2pxl1aiy4paPFin5jrWh34n2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P22/ntMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F233C4CEEB;
	Fri, 15 Aug 2025 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278426;
	bh=bZHXMBWIWtOd9P3kjklQ81O4Y1/Lvowqh+ondUT2CG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P22/ntMN9giiNcZhqYtT4CsS40bU9fSOJYWm1hQMGztJLKw14ftmUz2MZAXJm7hGJ
	 rY56i/HhF5ADh5AgMK1o3rf34KY03H0qvGWzY2QCPsuPenRX9EEstD8RMZWQp0QPzR
	 Fh3kO+sQumhKmTxtv6d/mmyQAbjuudu41HP1ZOKuao5GBGGwFrC1tSg0kuANapMrdh
	 hX9GlGQ+Vz+ysLAib6kLdq/xVa7FOaF0fHaZDfov7Id83LVZA3HNQGg505SY3Kdje2
	 WPS1aGCg5DFs1o8+xs2P/HPMjNv0zJBnZvUcR0ywK+JqJRbx6/QiUOzfTJaIzz3SXS
	 R0ItPnt7e2TZg==
Date: Fri, 15 Aug 2025 10:20:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <cratiu@nvidia.com>,
 <tariqt@nvidia.com>, <parav@nvidia.com>, Christoph Hellwig
 <hch@infradead.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 6/7] net: devmem: pre-read requested rx queues
 during bind
Message-ID: <20250815102025.202c42d3@kernel.org>
In-Reply-To: <20250815110401.2254214-8-dtatulea@nvidia.com>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
	<20250815110401.2254214-8-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 14:03:47 +0300 Dragos Tatulea wrote:
> Instead of reading the requested rx queues after binding the buffer,
> read the rx queues in advance in a bitmap and iterate over them when
> needed.
> 
> This is a preparation for fetching the DMA device for each queue.
> 
> This patch has no functional changes.

Nice!

> +	rxq_bitmap = bitmap_alloc(netdev->num_rx_queues, GFP_KERNEL);

FWIW I think you can use num_real_rx_queues since we're holding
the instance lock which prevents it from changing?

But it's just bits so doesn't matter all that much.

