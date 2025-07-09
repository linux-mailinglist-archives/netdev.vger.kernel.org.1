Return-Path: <netdev+bounces-205525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1565AFF134
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3898D567F52
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2DE23D2B9;
	Wed,  9 Jul 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj2wbpGR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847B23C4FA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087277; cv=none; b=uz3lRgunMHQM+79NZ9JQz8s6TBhjWqtFs9c++DV+txvOzAvJFdtdDv8v2gcELnEeXdMfKTvtR5/AvuHVF9JN5CuMv9XOywbr1q4gxtmQA0fXokQMWOIn8YlqSN6guzb2s8R+v6I0p/vWvZScJbx9MrLTgA++1LEPMptJtWJGFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087277; c=relaxed/simple;
	bh=CnZBjSkl711QRqr1Y7XKdUin6PoCO5Q5r+XKPkuGV1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQNppXJL6QC44z5I7DheSznNA5wIRpqsCk6CijFcfgnZmSxPhmYMEIoz0jZRESNliTMlwPO81sXEiD6fcqTl/Dj7o1QRYyv2YiUVLX9AXlFrvWvMtYGNjYjb8ri7XoDfCdKqGcWURGKbrofnOaKbHY27VxDrgk6GegE+I/GAWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj2wbpGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98EBC4CEEF;
	Wed,  9 Jul 2025 18:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752087275;
	bh=CnZBjSkl711QRqr1Y7XKdUin6PoCO5Q5r+XKPkuGV1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj2wbpGRLPFs1aCNQj6uf024LlbEfbE6evxm8CejYGOjPOPX57EjuK2PPQH5GcAJ1
	 jTC60cDim3sYiJhg85foelWjcPCu2S39CyjqUmn//gMe2lqSAy5jhmXSOIdlPgqFA6
	 Lm6JtQabg37u4jNG1g1Oj8t9iSk2tMhEZYkyW3v6pfcEZsXllZQl0AsKQafOBM4dux
	 PV3wKeJhRl/kEAmmMiVKcz9S4B7FtLYgbCAE+c3swlcdEHNHJoA7zRCIQHL73+SYFd
	 QzkzXi52eW59wDe7ddaZ0H5BJHtwVchehPoE8HsNzrv490SNWoWb+NyWQKDU01viaF
	 bD7ALFTfzZupw==
Date: Wed, 9 Jul 2025 19:54:31 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 2/3] atm: clip: Fix memory leak of struct clip_vcc.
Message-ID: <20250709185431.GL721198@horms.kernel.org>
References: <20250704062416.1613927-1-kuniyu@google.com>
 <20250704062416.1613927-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704062416.1613927-3-kuniyu@google.com>

On Fri, Jul 04, 2025 at 06:23:52AM +0000, Kuniyuki Iwashima wrote:
> ioctl(ATMARP_MKIP) allocates struct clip_vcc and set it to
> vcc->user_back.
> 
> The code assumes that vcc_destroy_socket() passes NULL skb
> to vcc->push() when the socket is close()d, and then clip_push()
> frees clip_vcc.
> 
> However, ioctl(ATMARPD_CTRL) sets NULL to vcc->push() in
> atm_init_atmarp(), resulting in memory leak.
> 
> Let's serialise two ioctl() by lock_sock() and check vcc->push()
> in atm_init_atmarp() to prevent memleak.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


