Return-Path: <netdev+bounces-111083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C649792FCF3
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8531F23D4A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5249D171650;
	Fri, 12 Jul 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6awLpSx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BF16F83D;
	Fri, 12 Jul 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796074; cv=none; b=OGQ1XiZJF4eh69GHyLkVfzbri7cMtlGcEqfzAFAB0zhBmUhpJ1NE5HiKGEOU9HGAiOt18zaNXEu1pnu4um+DGVYpsJh7NgKtSSFJ0gPBkBcWADGVf2ehV08MCuyJqjw7CrFdUj0/3psykFEEavHwJwi5/lj4vOQHIVFIPchCHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796074; c=relaxed/simple;
	bh=hP8I3f797orVBJzBp7kkg1xNkSaLIprRWAVetErYb0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAAHs/Bd7SR6ipYevmzcWoc0GoQfD1OqcW7TAJMZBlxxhV6C4vPFM84r7G9rS+IsS/liGgqCLyV6cQX6qjEMQVXe8I0LYTqAjLHRpFjzTvfjWOgIJHiDxyqQSpS0scfw27cZyhx86sGmhlrACwv6FYUtgu/djUpgQw4gWn7bFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6awLpSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D972C32782;
	Fri, 12 Jul 2024 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720796073;
	bh=hP8I3f797orVBJzBp7kkg1xNkSaLIprRWAVetErYb0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z6awLpSxcpPVaNVANT/l8L28CZbvEv6SeZl9SVaCwn7qEnUKKFiCKQAmexWHTrBD4
	 fcTtcw20d5IMiQ25ykJcyqTm3Uri3JjhnCPVIZi7mnbtd5f5e6cArFi0Cf3NfX9oft
	 RTcpzqD9T6k5Th/qZTPdiEA+QKOAFGlMcQuBAgw+4VGNuoSrTbXnf8hJ6NkQJLy5Tz
	 X85x5n/lPhk/2j6+Hrqw0/kv1MUezOxERV4zMcC75e6Y5QjbxpHWjZ5opsjdW0DbiC
	 XTvLkE5WygNO4S4OLsUtcF2+Ijh5k65hCBQVvBnA5UcpfBICW9037Vh3lAUyWHjRmD
	 +VN7XOWi1U0xw==
Date: Fri, 12 Jul 2024 07:54:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 rbc@meta.com, horms@kernel.org, virtualization@lists.linux.dev (open
 list:VIRTIO CORE AND NET DRIVERS), netdev@vger.kernel.org (open
 list:NETWORKING DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <20240712075432.7918767a@kernel.org>
In-Reply-To: <20240712115325.54175-1-leitao@debian.org>
References: <20240712115325.54175-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 04:53:25 -0700 Breno Leitao wrote:
> Subject: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning

[PATCH net] for fixes so that the bot knows what to test against :)
No need to repost (this time).

