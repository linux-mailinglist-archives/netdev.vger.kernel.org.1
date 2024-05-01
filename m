Return-Path: <netdev+bounces-92760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081ED8B8B44
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E72FB20E75
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828BC12E1D5;
	Wed,  1 May 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtZ/aZYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9585C66
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570447; cv=none; b=CqGPjWMOuVPbrzeMkynhRbpaMzO7oUmkt/+H7lt7ckBX9nt6utst4jmjVatyNCWBNUH5vLnc0zrMTBaRF4dGS8bOf80wgU6iIOAQinkjc1pK4bUP2OTLVO4j/pLdP47KYC0gBbiaxi7Zx3HXvc9S/81YT/r5IXvob7i3HjbWe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570447; c=relaxed/simple;
	bh=3d3AZRXS/+JAGvOC07FXV/50Zkj/TpXMYXCHOWmteKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToxSD7lqjGq2KbEJ4DH7+FxpBC0hQZ7h6IZL6Nu1nnVd4d+Wb9KcYFhczadWBA8vV7nPgmlM/NSN+o9FNjIdGSmwCvJQ7pMdWY607PThn8cqOU0QzD+o/mc7Xhk1hclxVtTGMQoIvr2IHQnaFgcvgY6/FbrSXN2qdKX/xL6L4OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtZ/aZYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E20DC113CC;
	Wed,  1 May 2024 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714570446;
	bh=3d3AZRXS/+JAGvOC07FXV/50Zkj/TpXMYXCHOWmteKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rtZ/aZYYoQ9jM7xJQEdtvS42nkqVQZo2mSgJwL1E7XHfgL21PsXc8PrNskl6jX8Dg
	 hOBSvxq2nx3XiYtN7J5JpsC09+2G0luTyYD4tiyGC8BpqaaxyXM8OMJhuGxG9WU7iR
	 6kL7NUbAuWE9UE/XtwD+8EmrrX4EKJzvad8YmWb9XDPQQGRwv+iYrIm7uEKpK8rs4L
	 +YMCVuHbGivSaca7oBW+kwonkOmm9HX3izx3j6YP/cbeHWQbfrYQb1iBONru4fQipi
	 qvsP4Ht5SPTn/em6Q6cUVrSzM4+Az9BLmVRz7XXVa21l6RILFW8hbUGXe7e6isNTS9
	 e0k3F62qkvpsg==
Date: Wed, 1 May 2024 06:34:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v3 4/6] net: tn40xx: add basic Rx handling
Message-ID: <20240501063405.442e0225@kernel.org>
In-Reply-To: <20240501.151616.1646623450396319799.fujita.tomonori@gmail.com>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
	<20240429043827.44407-5-fujita.tomonori@gmail.com>
	<20240429202713.05a1d8fc@kernel.org>
	<20240501.151616.1646623450396319799.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 01 May 2024 15:16:16 +0900 (JST) FUJITA Tomonori wrote:
> > drivers/net/ethernet/tehuti/tn40.c:318:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >   318 |                            dm->off, (void *)dm->dma);
> >       |                                     ^  
> 
> My bad. Fixed. I should have found this warning in patchwork before.

No you shouldn't have. The patchwork warnings are for maintainers, 
it's not a public CI.

