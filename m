Return-Path: <netdev+bounces-227999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9AABBEE46
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E95C4F0675
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877527FB05;
	Mon,  6 Oct 2025 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvkBE1bj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06956242D69;
	Mon,  6 Oct 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774334; cv=none; b=kgRmErIYcx01EYVK5Udd5SmkBC2BVS9NcYnbMLrGGy4ACsMzSPKG6mFGAbAQmiMwQKKFCPjMlSFT2JyUADL9J4kRrE6ySXIje+PpnfuqfziVEjnokLqO3vpHl96+gaTh0u0ILnzQSuBneaayPLXZcTC+9zaDvU6upJqZRdsf0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774334; c=relaxed/simple;
	bh=yqfM60pd3vm0k6dr2xJzKfQX6Cf8X1W6EHsDOhRCN1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVg0qnAMaYJdqmEnmMMBUPQg5LGiVgvudHnZGP7r6K2gkErAnIKRlZXj9yIrdiqq8Rbx4nbYHw3WUIVVM48ls/o0TFi7rWj8fq+RnELgnTQ2hUoTr6W9u3kRpt2lgL8xSVwepscZ0GKTyFK2o2UkJj9or9kLc792Yu3bPB1DQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvkBE1bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5826C4CEF5;
	Mon,  6 Oct 2025 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774333;
	bh=yqfM60pd3vm0k6dr2xJzKfQX6Cf8X1W6EHsDOhRCN1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TvkBE1bjzN2mieHNShs7LCJeqhNu7ZzmJSwLGlDbdWlJz7CjWpw6JApMMklud+WHp
	 d9+eEe76G3Dsnv2zlNRz6emhDmjsWcaBNJbB3VQBUdL1Dw8m3uRNqS44zwj3R7l5tA
	 hatTwdpJgjoBmHJzzsrhpq0sCU0l82xYRaBucuovTqpRJILmZm60I3q+i8Mw6F6jAS
	 tfNphq3mgb0uecQc1gxjan499QOHPmiAMAj2u4QJOjxd6QkqwyqejBHqJb53KRV89o
	 kZsVQVJfDMqCHMc37zuBLsZAIPajmZsGqFGwAxAwy49x3FzgmwnS6cm3RM6BpeTMpP
	 /OVm3LAqfg2TA==
Date: Mon, 6 Oct 2025 11:12:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 david.hunter.linux@gmail.com
Subject: Re: [PATCH net] net: usb: lan78xx: fix use of improperly
 initialized dev->chipid in lan78xx_reset
Message-ID: <20251006111211.28f018bc@kernel.org>
In-Reply-To: <20251001131409.155650-1-viswanathiyyappan@gmail.com>
References: <20251001131409.155650-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Oct 2025 18:44:09 +0530 I Viswanath wrote:
> dev->chipid is used in lan78xx_init_mac_address before it's initialized:
> 
> lan78xx_reset() {
>     lan78xx_init_mac_address()
>         lan78xx_read_eeprom()
>             lan78xx_read_raw_eeprom() <- dev->chipid is used here
> 
>     dev->chipid = ... <- dev->chipid is initialized correctly here
> }
> 
> Reorder initialization so that dev->chipid is set before calling
> lan78xx_init_mac_address().

We need a Fixes tag
-- 
pw-bot: cr

