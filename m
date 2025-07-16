Return-Path: <netdev+bounces-207339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92588B06B0D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A8C1A60A52
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF616EB42;
	Wed, 16 Jul 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEpE23j1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C24246B5
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628678; cv=none; b=TkRDBPryLOoFZi02CbuWvuRDxm1hnoZB33aN+nvgxyPQsl1RXlAkbOv6B4+/zXMyBaHD3zf3ogai1HxYVHRfMIl+HdDYL5b8erZNjB3lepNBicH7ft/WtO5f/YNbe9Gpg3e8AqEB/w+wVxy/4iuj09h7DzLrDPQLb6FzO2N2+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628678; c=relaxed/simple;
	bh=hhdLq50KAzico3id5MZoq8Oe/+59LWF+dAXnHOXLUBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qD9zZEl52+Hk9JwJmqw8uSuZu2+c9QdhGsOIwrOuHUZTClCGYOFFlqjqLXEpXciBF8mjerWyUG2GVxYmMpWlGqGYSoPkfDYIZyVhxohOIwkHsC1H97BrUL87+TgSlSIhz4ukkGsQyjIzWvbcmlzSj2KqDQCxqjwyesGTWo5EjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEpE23j1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD2BC4CEF1;
	Wed, 16 Jul 2025 01:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752628678;
	bh=hhdLq50KAzico3id5MZoq8Oe/+59LWF+dAXnHOXLUBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GEpE23j12d2LQAS/NPLsU/k0AbEA1ouBgy53LG5a3+tr7B/fFZBJe3XETd00g5LG7
	 2hp6Fw16H+V0JLYSSXAgeT+iiOLmSm2Rc08IOvgJselFmpyYPx/Vo2+hZWMRq5g4TV
	 1e5j3n2RldeWwtXkC3ET1Z0wEeiwQseVSSgaLQ/8VkjEiLG+gksrsbPsGzpYrzaf+E
	 YEPiKfSclCxZxe7IYpvgyLuEKaI4KOsceRZ9ObTvEDO25KI4dd6F1qgGGaIY2xSjYQ
	 XQnGrzH6JUixI+lc9MAJuKPtn4+FRYc5wNzG63tgOxGRuwgCjFn3oh5UromXEWwwbt
	 I+dRUR896ctUg==
Date: Tue, 15 Jul 2025 18:17:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 01/15] neighbour: Make neigh_valid_get_req()
 return ndmsg.
Message-ID: <20250715181756.3c9f91ec@kernel.org>
In-Reply-To: <20250712203515.4099110-2-kuniyu@google.com>
References: <20250712203515.4099110-1-kuniyu@google.com>
	<20250712203515.4099110-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 20:34:10 +0000 Kuniyuki Iwashima wrote:
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto err;
>  	}

nit, I guess, but why the jumps?
You could return ERR_PTR(-EINVAL); directly, lower risk someone will
forget to set err before jumping?

