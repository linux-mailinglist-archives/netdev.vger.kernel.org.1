Return-Path: <netdev+bounces-88947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D3A8A90F2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 04:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29818B2105D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5039FD4;
	Thu, 18 Apr 2024 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVo0sdK8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA752AC29
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405874; cv=none; b=SWYb2F5LDKb/hx1tKXd27dGXgkV7u0U0aMnikAAc+w9I6udgFF5dGW/kaHthRCyeFU92LTpVe5amZpBZcQwv27HJKxpN2I/4SfkFmAFiDazT6+02mwppaS1Tk+hy9NvF2/7XwtMGOeeE2dTOyJGQTShy60tXWssDdx8cKuWkszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405874; c=relaxed/simple;
	bh=PVhKKHJI4shrFCO/huqPgSbYfjiKakyt0Oy3vIuoxxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQFEL/kyLjTHbL/OdsrKoHJOX1+062Aurp4GNGj9xBqq/M65O6OU903XGWzbeIhHNTImG6y5SxYQveHD78NYfjV/8a87sg68wRbCBjlJrfvcqRt1hjbA5uy98euKEQesBwELJcYoIjfPzTbyBuLNbJVahSd29kLNi6c2JgeTjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVo0sdK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA2FC072AA;
	Thu, 18 Apr 2024 02:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713405873;
	bh=PVhKKHJI4shrFCO/huqPgSbYfjiKakyt0Oy3vIuoxxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BVo0sdK8sqYoJen8aUOvtXhYEuGGTfulJb2BdwYI6kIenibHzJF5Nm5KLPk5PKFit
	 zBxhWJ/Br+wCgeeWqbsJwNKupZ20Z3GZq2iZy6nAL7/GfM807e3sEk3VHjlXHLm8zr
	 WfXdIGoFZ3FWdHGhskp6frokWoIJgdU28gSQWJG0JRz+zlxu1iMoe6GcUp/av39iWb
	 VT+MS3Mquwp1CbhsJXo9MLdf+090QiEGJiZUnzyHbd7+1qxJTCDzxCQgA2VhnuF5/r
	 GJ5tAbeaxxZoKbf6hnXZx4L12nty3UpyiNB3+bNDXMGvveEFhE+LjMSIEsrplD+UWv
	 ygtbrMa2lqNtw==
Date: Wed, 17 Apr 2024 19:04:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v1 net 1/5] sit: Pull header after checking
 skb->protocol in sit_tunnel_xmit().
Message-ID: <20240417190432.5d9dc732@kernel.org>
In-Reply-To: <20240415222041.18537-2-kuniyu@amazon.com>
References: <20240415222041.18537-1-kuniyu@amazon.com>
	<20240415222041.18537-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 15:20:37 -0700 Kuniyuki Iwashima wrote:
> syzkaller crafted a GSO packet of ETH_P_8021AD + ETH_P_NSH and sent it
> over sit0.
> 
> After nsh_gso_segment(), skb->data - skb->head was 138, on the other
> hand, skb->network_header was 128.

is data offset > skb->network_header valid at this stage?
Can't we drop these packets instead?

