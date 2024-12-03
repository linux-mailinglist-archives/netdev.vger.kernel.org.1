Return-Path: <netdev+bounces-148332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D589E1224
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A391280C42
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6053E15B0FE;
	Tue,  3 Dec 2024 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E32niqTd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC661547CF
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198366; cv=none; b=jdokkDDTR2qdotJkUO2HVc72U8UEw8oxHjkX5AtnRzd1DJwyNzYjtVigd8vXb+ovtRc1L5310JL0cHKdOGXwVPW7zsm6jJdNFYqC8q6strcR3FWetWwJ929y4cpMinov3u+qqioMmDPE+Q54YFpn4FOaEETy8op0CJsnYeA84Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198366; c=relaxed/simple;
	bh=E5kAmUlOGo0Te27AvXBJ5obE77Xf78EDp8dYpTq86DM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBNiwH/1/G4Js8XYTiv5bNfa86zsUa9Z4xK/3yZqljZKIxg+RvtkONIyPsx+N1fqiZW+idDf6271uNwFsrV3rcx8a2mfEKjYEgIBmJtThay1zjilNrj+gRUdUoByA4ZziJCQ7VXZVD3e2C9VyhFIxkdVVq23GkITUW6wyspR4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E32niqTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE5EC4CECF;
	Tue,  3 Dec 2024 03:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198365;
	bh=E5kAmUlOGo0Te27AvXBJ5obE77Xf78EDp8dYpTq86DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E32niqTdueZvnoGE2OG1Kh3ji/KozVQj6Rv923gzyuvXX5yxcbCoHRxEqBdgVo7Lw
	 ZvWo+LKRjNLMopyBZQ3JGZHeQkIiHgcxc2sVicZ+F5LZmjKGvDqte1C6ZeAJZ0pW1R
	 v7nVTCoBJqsuwEh8X5wyMPokp1ftNPTbChTXKUJ7uoosAEjIuRqwZnprD7ChPgbtVX
	 GD2wi6al8AOXI8zuMTak7y0qpvl7Pu2miOGwrAUFjElEHu7ZA5Xg7RqpxgbZTMtaHw
	 wfyCv1t5BCrWC3O4J5ZazExFqp4StsV5o7G8Z1qfQoML116W7bYQ2de/dA1mynQfKR
	 GnF1kxWca2/eQ==
Date: Mon, 2 Dec 2024 19:59:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/4] vrf: Make pcpu_dstats update functions
 available to other modules.
Message-ID: <20241202195924.30affd25@kernel.org>
In-Reply-To: <5e97f1e54e57b0a85e34af87062dc536a28bef34.1733175419.git.gnault@redhat.com>
References: <cover.1733175419.git.gnault@redhat.com>
	<5e97f1e54e57b0a85e34af87062dc536a28bef34.1733175419.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 22:48:48 +0100 Guillaume Nault wrote:
> -	int len = skb->len;
>  	netdev_tx_t ret = is_ip_tx_frame(skb, dev);
> +	unsigned int len = skb->len;

You can't reorder skb->len init after is_ip_tx_frame().
IDK what is_ stands for but that function xmits / frees the skb.

You're already making this code cleaner, let's take another step
forward and move that call out of line. Complex functions should not 
be called as part of variable init IMHO. It makes the code harder to
read at best and error prone at worst..
-- 
pw-bot: cr

