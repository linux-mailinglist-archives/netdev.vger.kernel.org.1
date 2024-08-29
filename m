Return-Path: <netdev+bounces-123296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8C89646D0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97311C20F3D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21251AD417;
	Thu, 29 Aug 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un7G9jwE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC881A76A8
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938441; cv=none; b=VjdeJ9zS4EbIYw21u+wM+xqjnjlHYkl70MvuLOCH7Ko9Qu2G0OqhK14qNhB037WQlV9SdbwMCAWCJRZAuo0Fw5ei0m/mkAHpNJmMpu+KuJVZPQdZ5GJyne7Cu6gv0uZiro69YEjRAPnJrG4c18zlaldbVx0NmYGN/9pXq/Hlleo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938441; c=relaxed/simple;
	bh=AHJKd5dLgPehISXKYWW+y1oyQPw+EOVvh6mDCSQOnO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8S6yzZj5ITF7vlmYM+VUbsHWET9grLHOnlntvKzQJaHdPwxcabIH/VIWa0JAkq21L/bWvn13jEXZeIxtqwI6iGnsfq+giQSFcC2mB/S7OH0zVbKOmAy3DEmmmanDTA7HFeCg//E4ScqZ9ZpFPSvZfH3RNpxVwDNgl7Epx1Quys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un7G9jwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF294C4CEC1;
	Thu, 29 Aug 2024 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938441;
	bh=AHJKd5dLgPehISXKYWW+y1oyQPw+EOVvh6mDCSQOnO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un7G9jwETnUtHhGVimXINEcN4PW0qhhgS4izudY6wsGF1JXkZPtSqKDgATZsebCsW
	 bdozkuWmRt4R05P/xpJteC2/qjTzSYI7JV3CaaIn0G2zcfZX/LXaava9/TnWMnoINh
	 3ckyL3P6/JTy1nkXEppGVzaGt6Csdi/gaMsLX7lZxAmxSEzeyx9rUoD6xi57VrFaOc
	 b3ggWpmq618dOmL5qMTFJA2wLT9T5MpjK66fH7Cq/phCg3gomIHnr+rPWwTsNWPn+N
	 1kerVtEi8j08YcHND7VZe26XOg6OCf9TkCDp8gHerHlX6+3uprA7KZPHXNfqr+B2WS
	 JsJP7AU52i/pw==
Date: Thu, 29 Aug 2024 14:33:56 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Willy Tarreau <w@1wt.eu>,
	Keyu Man <keyu.man@email.ucr.edu>,
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/3] icmp: move icmp_global.credit and
 icmp_global.stamp to per netns storage
Message-ID: <20240829133356.GU1368797@kernel.org>
References: <20240828193948.2692476-1-edumazet@google.com>
 <20240828193948.2692476-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828193948.2692476-3-edumazet@google.com>

On Wed, Aug 28, 2024 at 07:39:47PM +0000, Eric Dumazet wrote:
> Host wide ICMP ratelimiter should be per netns, to provide better isolation.
> 
> Following patch in this series makes the sysctl per netns.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

...

> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c

...

> @@ -235,7 +230,7 @@ static struct {
>   * Returns false if we reached the limit and can not send another packet.
>   * Works in tandem with icmp_global_consume().
>   */

Hi Eric,

nit: This could be handled in a follow-up, and I'm happy to prepare it
     myself, but net should be added to the Kernel doc above.

> -bool icmp_global_allow(void)
> +bool icmp_global_allow(struct net *net)
>  {
>  	u32 delta, now, oldstamp;
>  	int incr, new, old;

