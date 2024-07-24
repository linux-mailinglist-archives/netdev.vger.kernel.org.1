Return-Path: <netdev+bounces-112806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C193B516
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 18:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBE61F21D12
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A515ADB1;
	Wed, 24 Jul 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUKuhZRa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49F53A8C0
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838800; cv=none; b=JBGxDE4CW/B5HDmQJNqvu9ZMr0baH6jZm8ONvdnEXXMKzxfV6RV5CSGkYEy3oFUrM5FkmgNaeFx7u3G8dLcCn/KxxFrdFTwE7rXKTTUPLEVubQY6FBoUnUSDbAtufQEF1dqq6m0SrBjMDesqMdY+cOiiJSvImkzD2DM/TpC8xxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838800; c=relaxed/simple;
	bh=+YUCvPSwkdZZAhyqQy3RwcqMQGaF65dOqNgp4wMwBjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3+mUSpzLYnpk4p3XWkZ/yQ2inPCkeVMPhWUCY+M1CjuZ8qtxfM0+uexypZ32Il7FtczFgvFrOogaJRNPpyEgR7W1lwlSinYQmAKqwQhxjE0Sf8ae7m58NXTN3NaBogbndOuhyZ1mPNZoEnkHo1o0/dzejX3ZnHBph/HG1nJauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUKuhZRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6378C32781;
	Wed, 24 Jul 2024 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721838800;
	bh=+YUCvPSwkdZZAhyqQy3RwcqMQGaF65dOqNgp4wMwBjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUKuhZRaMA1TSj0+jYXVYPnkk3l4USVVabFxtozJmwOmRi07XsGqYOfNFE0jeenjX
	 Ri7eomU3EEon9CfU5BfmO4zjlQlT2pIgJAGcvP5zxUeXrgFXp1ag9MnxMU0QL/DEPR
	 rf10Aro4xxA0wJCJzBjLEYFg47JWYCyH3irKva8BP3qrdFuMvr5ip39QgjmEsTnAGz
	 oXLWoP6OGFco/NDosD7F6Eu0tkHVYkcBt/xME8bE6hMXdm+INc5jU9nCfiev27BR5v
	 S7t1FkIpnGLxg922+i9pdkUDjWSIK8KeWYK4AXro2FzbGZl2E3pKKr4bL/VXCqrR2E
	 IiEDQb9l5r5yg==
Date: Wed, 24 Jul 2024 17:33:16 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com
Subject: Re: [RFC PATCH 01/15] l2tp: lookup tunnel from socket without using
 sk_user_data
Message-ID: <20240724163316.GC97837@kernel.org>
References: <cover.1721733730.git.jchapman@katalix.com>
 <be825ed1ae6e5756e85dbae8ac0afc6c48ce86fb.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be825ed1ae6e5756e85dbae8ac0afc6c48ce86fb.1721733730.git.jchapman@katalix.com>

On Tue, Jul 23, 2024 at 02:51:29PM +0100, James Chapman wrote:
> l2tp_sk_to_tunnel derives the tunnel from sk_user_data. Instead,
> lookup the tunnel by walking the tunnel IDR for a tunnel using the
> indicated sock. This is slow but l2tp_sk_to_tunnel is not used in
> the datapath so performance isn't critical.
> 
> l2tp_tunnel_destruct needs a variant of l2tp_sk_to_tunnel which does
> not bump the tunnel refcount since the tunnel refcount is already 0.
> 
> Change l2tp_sk_to_tunnel sk arg to const since it does not modify sk.

nit: This needs a Signed-off-by line

> ---
>  net/l2tp/l2tp_core.c | 52 ++++++++++++++++++++++++++++++++++++--------
>  net/l2tp/l2tp_core.h |  5 +----
>  net/l2tp/l2tp_ip.c   |  7 ++++--
>  net/l2tp/l2tp_ip6.c  |  7 ++++--
>  4 files changed, 54 insertions(+), 17 deletions(-)

...

