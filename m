Return-Path: <netdev+bounces-71399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22FF85329F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F12F281425
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78D65732B;
	Tue, 13 Feb 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPDk/suI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F75731B
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833184; cv=none; b=QM5Qxd0fFmXx7U+KLf7MiB5JEwYLfFd/0Z/lqiSvO+RGUAcQ1BXTFAQszvHeS9MM09hhlto4wnkuAZTBgf4xqI2v1B3Y/0x1ScQ02P4aG9DQlWjVy9kDRZFZtF2yopnP8czyRivO0RMVLaXrjsjV1ZtrfX0bc0R4h0QhgtfMEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833184; c=relaxed/simple;
	bh=RWYJF6n294OI/zMOW9cu5Liw8tYXMjF9/NY9ciEWMF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6Exup2gp7Iufz+Xcfv/sLBP1uZ7pMWkaxYwPtHBlZIlGqgx5M6hIvo3wVViRInpTo3xLcdm+p+6WcNmwWDlE5NF9F+U9iwhzPy1j+AbWDVZ+KuNJrxBX3PgVBhCDmxO1nD52bBrtHHDulz2lXHaDd3yoR9LshxJRiNs4DmLSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPDk/suI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C60C433F1;
	Tue, 13 Feb 2024 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707833183;
	bh=RWYJF6n294OI/zMOW9cu5Liw8tYXMjF9/NY9ciEWMF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YPDk/suI+/nf1L16qXRm9azMkpq84PHUXXFzv00N6kEJLKQK9Tl6mNrFxh7KzEmvM
	 RFLPmPtGxWNl2vKnD5p3dkhYL/HiZZmkI+eFeOby6nD6HqtwVV2mINNwYl/q+lKUnT
	 yPl6aRU8QYrhvEpB13RCurN8qov2GSXfY++fS87kOtZSshrcVdSYFGThXH4XfVPjSk
	 gkFmec44xQmaHaF7T1PFTs2bsOZai4Eo2RcBcC6WztijyAQs1NeM7aflGg1ypTKozS
	 Ih5XmhWC0VsFhhnrLZYMN4ENUjXst8jZPdvO9aAWCe3t8abBtopuv+ukd5JJYU2pGO
	 7pfZ6WUpxeRrw==
Date: Tue, 13 Feb 2024 06:06:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 3/3] netdevsim: add selftest for forwarding
 skb between connected ports
Message-ID: <20240213060622.33593442@kernel.org>
In-Reply-To: <20240212220544.70546-4-dw@davidwei.uk>
References: <20240212220544.70546-1-dw@davidwei.uk>
	<20240212220544.70546-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 14:05:44 -0800 David Wei wrote:
> +	ip netns add nssv
> +	ip netns add nscl

You're missing a

	udevadm settle

somewhere between creating the devices and getting their names.
Otherwise they'll get auto-renamed while the test is running.

> +	NSIM_DEV_1_NAME=$(find $NSIM_DEV_1_SYS/net -maxdepth 1 -type d ! \
> +		-path $NSIM_DEV_1_SYS/net -exec basename {} \;)
> +	NSIM_DEV_2_NAME=$(find $NSIM_DEV_2_SYS/net -maxdepth 1 -type d ! \
> +		-path $NSIM_DEV_2_SYS/net -exec basename {} \;)
-- 
pw-bot: cr

