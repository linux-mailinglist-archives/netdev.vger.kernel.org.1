Return-Path: <netdev+bounces-238831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD139C5FE4C
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 647CC359FD8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EAB1E0DD8;
	Sat, 15 Nov 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCgihCz8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48111A256B
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173728; cv=none; b=ezI9TVDR4f5R4tmXZc4+IqIq3FiwGzL7Liil3sfeCsy+YAAGLL2jlBpSs+XXrskrejLAuZZi6OQHW9GWz2kCzS25BvGDyCqqE86bA3RF4187UnBCqiUrq9z/F9wUEHgGSUdUfn06SLb92MB03RnbTGSzJr1CVuuBGRxdi+28bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173728; c=relaxed/simple;
	bh=kIHrepRvh7alpS3vOVxTqyVAlkraM7g3yD+DBbuv8eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOPD9R62qjZ7H7ArbelpreWDT++VTiMP4U+f6Krovw3jLQZ+EbSvSiK7YAy/Ys/T+TWrKdRSS5N+WvHg/8ocR9E6pakAimP4GXPPIgGyF2pyUXeA6Dg+V4xzBCJN+NPqutolB0MVAi/+jbRvu7Ei2++pRY6uWWMqcIpI63bLMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCgihCz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DBAC4CEF8;
	Sat, 15 Nov 2025 02:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763173727;
	bh=kIHrepRvh7alpS3vOVxTqyVAlkraM7g3yD+DBbuv8eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iCgihCz8d5/UAe2b7VF40hsfLx9SYjeMNqZgXvEkMC+jClzjiGqSMK6YXHRL9Kz2n
	 BZmJyN1rzpVM9o5IhWqxOjc6XHeifswO8p6ubgGHFtET+ZIiC5qT1fQwnsaFsFoawe
	 j1d60ge+8akWGvvK2mfY56ZdFiDUhAQGyLO4j33EplCJdJqqqsHUivgBPdx7e/Pd4J
	 8Gqiym0fKXO7HUx6N1Ulnt8enTe7S8/HnVSqeGheEaX17YrxLiJyEBOuF0bQdQt3nj
	 DzT7IJW26H51r/kVyFICemFhH2ETST4ABYv4tiTsOP1xbHsokEIarkV6hdpZDh1sBD
	 Lj+a6k5t/mdtg==
Date: Fri, 14 Nov 2025 18:28:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Manish Chopra <manishc@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Jacob
 Keller <jacob.e.keller@intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/2] convert drivers to use ndo_hwtstamp
 callbacks part 4
Message-ID: <20251114182845.14290f8b@kernel.org>
In-Reply-To: <20251113191325.3929680-1-vadim.fedorenko@linux.dev>
References: <20251113191325.3929680-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 19:13:23 +0000 Vadim Fedorenko wrote:
> - restore netif_running() check in qede driver

bnx2x needs the same check, right? We're not deleting the ioctl code
but it used to check if the device is up.

As for the extack message:

+	if (!netif_running(netdev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device is not running");
+		return -EAGAIN;
+	}

it's probably more intuitive for the the user to say "Device is down".
-- 
pw-bot: cr

