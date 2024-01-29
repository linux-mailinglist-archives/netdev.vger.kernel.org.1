Return-Path: <netdev+bounces-66871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69E841460
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 21:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AE21F230EB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593F604C5;
	Mon, 29 Jan 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR3izthK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC81241E9
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560447; cv=none; b=IRbmz5Dc/TbFF12w1M+IyR1XO4yGuHgLKo3sOTh4vQhn5MyzwT2XQce4sCefwJfqp4oaTx1ld1lBo1/02/DurY/0wjNvFliKzieOFbSrmXx6lnyUrYFfF8RtoURpw1E59VKdzIEozHoB8IN7c6AwldenQ2LfJe5LEq5SU4/1wU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560447; c=relaxed/simple;
	bh=w8BdG+fyfs0mnXTpNHbp+o504qQ4AE+q+wua4Hjj5D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA1KyxHhOxv7+utnVRIw2hxDNeQZN0H7mYudn7g2fgbYxagC5mOrtXHkkBCWRzU28B5VwNQENiwEhi/gp8jYyqyY0R04PvS0fm3BAe1kpRKyCj/Z7bEQUFfKJSbGRJEJRq6sU2x145N1J6aWv1rKjqjxlffbKN1oSDoh7GoLfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR3izthK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B420C433C7;
	Mon, 29 Jan 2024 20:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560447;
	bh=w8BdG+fyfs0mnXTpNHbp+o504qQ4AE+q+wua4Hjj5D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vR3izthKjwe+GflS69i8/UzPVj2PodVnod2c+8q0WZcD4PWQC+CGOlq4t9d8UEoos
	 GFtdUG5oT/89s/qhn0H6zm5pyVRf1JLYoZP4mTnCLUXKSSXwsji8z435ws7GPcnSQX
	 K2RUPf4cwZ4V01yugGus7XA44NymQrlMxhVKqd3RUZU4yOvOizwTXpb9nlyjSlKhva
	 nd0MzAHiYorbMZoChhcpJLUrRk1GE+Ca21DZQ9c8cS/fHDt6csCgzaxy1wdzaSkWuZ
	 M4bJ9y8a5xXFSzRHRc6/1yCyp8p8JrG4YP2UNvi8cfQjEAYsHTqEmkLKmxqWSO43xk
	 XLqiPVr0/XJxA==
Date: Mon, 29 Jan 2024 20:34:01 +0000
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v7 3/4] netdevsim: add selftest for forwarding
 skb between connected ports
Message-ID: <20240129203401.GR401354@kernel.org>
References: <20240127040354.944744-1-dw@davidwei.uk>
 <20240127040354.944744-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127040354.944744-4-dw@davidwei.uk>

On Fri, Jan 26, 2024 at 08:03:53PM -0800, David Wei wrote:
> Connect two netdevsim ports in different namespaces together, then send
> packets between them using socat.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../selftests/drivers/net/netdevsim/peer.sh   | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
> new file mode 100755
> index 000000000000..05f3cefa53f3
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
> @@ -0,0 +1,127 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +NSIM_DEV_1_ID=$((RANDOM % 1024))
> +NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
> +NSIM_DEV_1_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_1_ID
> +NSIM_DEV_2_ID=$((RANDOM % 1024))
> +NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
> +NSIM_DEV_2_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_2_ID

nit: NSIM_DEV_1_DFS and SIM_DEV_2_DFS appear to be unused.

Flagged by shellcheck.

...

