Return-Path: <netdev+bounces-65687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFDA83B58C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 00:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6A11C224EB
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 23:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3BA136647;
	Wed, 24 Jan 2024 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFBv6HtI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86F12BE97
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138595; cv=none; b=bt9hU5rtNp4hgloJ2Bp1yNdnVlJQg+FUSEtiwlW8QbmJLUEOCgvWsiwwpiR6zkUbczk846n+lCtuoEWOtEGie4YOs73HxPf1g8wpzxiWiZq3QWNg+m3G+lg4MFFeucNBYSMZz2G5j6TU88MGtExEWKUOufEawZGU53/AFFjyP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138595; c=relaxed/simple;
	bh=8WjjEPWzJnV97vOjlr20CovmkGWVlz3Ri+NvjGOyy7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPW7/2xWfqLEK7I6GM9VgXPffWcmCF2iDSz/xuZdvWk+ghJDrjI51a8YtEeB9uqvEZLi5Tqob8u9PIYZOvdPxgn4I5F3arkjSf0xwEu0Wizfl4mkkqu376P4f9XhEW/ZCdjZFkZ8PdHIuCBsfYgQjKdqIRaNt8ew8UD00DYvfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFBv6HtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F68DC433C7;
	Wed, 24 Jan 2024 23:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706138594;
	bh=8WjjEPWzJnV97vOjlr20CovmkGWVlz3Ri+NvjGOyy7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WFBv6HtI+DxrdSPagPcSyoIDCkKgVzGhNx9CC+s+ZwgUowaljEuDwg++aqoITfH5u
	 2BmqfviG/g+DYCKfThwbjGaUuszZBOIr0ydQccaWOiIRt8jUcXJ6NdFqDNy4Q+c7GS
	 eHhvwdwgJ5+ETxQnCqMyoNOstijX8Skl2ljVV1gX0U/K2XQXxqHzMv6FOBXZB306py
	 /ADr8I7Bg192gCimBZHyMozXbz7Fl6DwU2tyhAA/uSXS+44VzCR7IOFSu2YWIx8K/4
	 R7z0CZJQ07sDkNQ/3+PcESPigU1z+ZuMflkI2xE8hTjNxKXEfwXN/w39/38qbAE5ll
	 6nDM9X9Ga2WGw==
Date: Wed, 24 Jan 2024 15:23:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Leone Fernando
 <leone4fernando@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] ipmr: fix kernel panic when forwarding mcast
 packets
Message-ID: <20240124152313.506bdfab@kernel.org>
In-Reply-To: <20240124121538.3188769-1-nicolas.dichtel@6wind.com>
References: <20240124121538.3188769-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 13:15:38 +0100 Nicolas Dichtel wrote:
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1368,7 +1368,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
>   * destination in skb->cb[] before dst drop.
>   * This way, receiver doesn't make cache line misses to read rtable.
>   */
> -void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
> +void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb, bool keep_dst)

kdoc missing here:

net/ipv4/ip_sockglue.c:1373: warning: Function parameter or struct member 'keep_dst' not described in 'ipv4_pktinfo_prepare'
-- 
pw-bot: cr

