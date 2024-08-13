Return-Path: <netdev+bounces-117890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F9B94FB31
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A29B21325
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C806AAD;
	Tue, 13 Aug 2024 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9J6mPha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5251862A
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513223; cv=none; b=JS4Qbo88r5V4mfr3/jb9csXhTg4ydvlZrxfuE3BZ6L4U9RIozuuFn+aHr+q032b7Rj7vzZdHwQNJiQswV7elEu9+rBZL72EcM1aFr6MtDr0LR2P9JWKE9G/Q+IOpF6bZv+t5JH0C3mp+bYhqa3ZGJebVtIssws0RN+pHj5wNp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513223; c=relaxed/simple;
	bh=iDVnqSdI2Ymq1ZB1LHM9YknCHJqSFu8XbM8B5YoVOzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcdCIlJVkdJWDeTxG93nc4e/u0sNs+kkw7GyMhCB3ewgdQdun1MdU3KdZM1zhRSI3rzfFpv+4xOHmcod8i4YdEPPv891wrO8rY9NPIxMTjjomboscgquu6AYUY/nWmiPTNdn167ZTroZMX6T4TVwxbrty7JpM+H29WsMNL577OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9J6mPha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D139C4AF11;
	Tue, 13 Aug 2024 01:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723513222;
	bh=iDVnqSdI2Ymq1ZB1LHM9YknCHJqSFu8XbM8B5YoVOzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9J6mPhaMNq8EGDFwuOFSBzjQ0ivHPcrO7jUGLQF1Vcu5eOsMby1lRNvgg/C6JvHp
	 ZTUYsPifqRUlpCSfDjX/NqJ2sm5TC0DimiRKMfk3QhwBIctYtBPlkPwAeQ7ILLR8gK
	 goA83ziKOQnuTsnXEPd227iK4UUqaahoiqbbkRdO/uNf0+H+hCLQ34XJkerFgqOvq8
	 GF3B7WXMHC8Kjru7YKAFuAWgLfjjT/2pkDSsqccpz6Ls0mipql6/CXTCg7maokDJLh
	 kLY6fiOXoqmgrOOy5o0a8bu4B3YFVefHqO5m51C3cSGkkyvprXA0AR1lDT9v1G5OWy
	 Hemn8+fV8p/fA==
Date: Mon, 12 Aug 2024 18:40:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vineeth
 Karumanchi <vineeth.karumanchi@amd.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] net: macb: Use rcu_dereference() for
 idev->ifa_list in macb_suspend().
Message-ID: <20240812184021.4a7abc18@kernel.org>
In-Reply-To: <20240808040021.6971-1-kuniyu@amazon.com>
References: <20240808040021.6971-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 21:00:21 -0700 Kuniyuki Iwashima wrote:
> In macb_suspend(), idev->ifa_list is fetched with rcu_access_pointer()
> and later the pointer is dereferenced as ifa->ifa_local.
> 
> So, idev->ifa_list must be fetched with rcu_dereference().

I don't see where this driver takes rcu_read_lock, but
__in_dev_get_rcu() will already splat so we're not making 
it any worse.

