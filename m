Return-Path: <netdev+bounces-168157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C432A3DCD4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E31F16ED23
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC611FE443;
	Thu, 20 Feb 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQyGA8zY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05B1FBE9E;
	Thu, 20 Feb 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061671; cv=none; b=KsBEiWDTdMGY1wXHTpddHdmiaWVRcHjjlClbVfphEfdYEl3HNZ9ekk1x6AeZyppl1L2NxlFsixfunZtgwRy/tg0PewU91B+wmWG3clXfwIst/KIOVaFWUuEhARvkTWcwAytPDa7sAoQPka6MTqrQn+GsxVOsGXpHXt1kyLPIYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061671; c=relaxed/simple;
	bh=CcFZHkvhJVv8mFkonRELBCej1lKwq1t7fxKt3ZyygZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDmxbgZRJyv/4UjUhW4lJyOhbylNnNvFotnha6uNQg0jieRErko1xUBGAepqBelwM/T4gDLO7HVzrDxSs1+uno/Y7S6fDrj8yyNRzqqGWCmYleWur4bKUfqzyg/o9s6RtleYa9anixzbyYZF81dl//LQwsov3Ox0qk3CcvEWiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQyGA8zY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89643C4CED1;
	Thu, 20 Feb 2025 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740061671;
	bh=CcFZHkvhJVv8mFkonRELBCej1lKwq1t7fxKt3ZyygZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQyGA8zYbGA3p7s6QXn/UeT3E/Zq1QxtjFKLl+atl+tpfZDOhSwpoeVChQSsOyhCY
	 +TbkBgqoDami5W985cE0/ltOWYNe3YT5uAybs3z0PRSt+2MWH9LZwBxEeQr5lY4T5j
	 E3eArfq4ltyLMx4SOH+rehuiU13lq2KQoybV4y2YsXKC+TZNYA3NIULU6UY14ei8tH
	 wPqW9IvxeizgOj0ZCQfEO1IpVjrtpdctqHdl/vD7WnzsVUUnMUJAhmdPkjC4Ofri0c
	 x7MJ8aZuVsrXfHDVGk9WXF7z4ZIiPVC2jWioWHupIJAmUAU81ahCuSbDHYc7MlPKnR
	 wdjHdsQ0P0hpg==
Date: Thu, 20 Feb 2025 06:27:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 03/29] tty: caif: do not use N_TTY_BUF_SIZE
Message-ID: <20250220062749.4ce79a86@kernel.org>
In-Reply-To: <20250220111606.138045-4-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
	<20250220111606.138045-4-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 12:15:40 +0100 Jiri Slaby (SUSE) wrote:
> N_TTY_BUF_SIZE -- as the name suggests -- is the N_TTY's buffer size.
> There is no reason to couple that to caif's tty->receive_room. Use 4096
> directly -- even though, it should be some sort of "SKB_MAX_ALLOC" or
> alike. But definitely not N_TTY_BUF_SIZE.
> 
> N_TTY_BUF_SIZE is private and will be moved to n_tty.c later.

Acked-by: Jakub Kicinski <kuba@kernel.org>

