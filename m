Return-Path: <netdev+bounces-99620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC568D5836
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEF2B26B80
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7980E56A;
	Fri, 31 May 2024 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIr7xaUG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A92DF5B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119548; cv=none; b=YYkZu8roygD0i5NMaUIR6vmKTcHPGEsp5koSYo8bUvpbEsBgxHaGCbFuB94in1XDlSmdaW9XJ5hx1NwmAPMxVq94n1NY8uIPCyP9BkfC9/c/nQVq8GkE+34Xst58hTXIu2iRU2jpfo5IbHy/7Ved1Hwma4+7hvVsF0EQZBT38lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119548; c=relaxed/simple;
	bh=1hpSK4ZdulHSDa+Z6nQA+h2rFUeTntX+IFZ+r0yMGto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dsusr7sxgDoaDD78MprR2L7ICdua3oDIQEiJe3l3JGHtjQZZfbDoP28/304DctESmttvsO8F4gYl1UrHXMCkGEYAUG95teDdX5fMzN3JkvUE6J0poL88HvRWGzvGkUr0tgv+p+/6yCfygrcdBvlLtUPj7Y6Lvp1lA3ggiXVlCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIr7xaUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE1BC2BBFC;
	Fri, 31 May 2024 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119548;
	bh=1hpSK4ZdulHSDa+Z6nQA+h2rFUeTntX+IFZ+r0yMGto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lIr7xaUGCzVuAhZMiCMNZk3Smwx5VoYq9WRwAlE7AD57ht1QY6/qpkVGp9yXUElnH
	 OXgOsYUDrimHQQL0E9uA2HsSnu99Y1ayFWWVJCZJlfmXJOHWJKtCRj16kJzApgpEwU
	 yTLod74d2KjeMDXp1ERHzWOJe/y9q/jwG+d6TdUzk+nBemrF42GtjBMZb1FxWYmsF+
	 f5P7v35I6flNXI4dv90RqaK1fqmBdK5csxINSm4ww458rtPvSLcJtjINJoh3+KpFnY
	 4Y3SKjw5fkvbkMwPozd5dYYKU76CSstJKqwaBqoYM23+tKJ5XVE/jvuFPK+J+NTxOZ
	 bWc7tvZ+A43Uw==
Date: Thu, 30 May 2024 18:39:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240530183906.4534c029@kernel.org>
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 16:00:33 +0000 Aurelien Aptel wrote:
> These offloads are similar in nature to the packet-based NIC TLS offloads,
> which are already upstream (see net/tls/tls_device.c).
> You can read more about TLS offload here:
> https://www.kernel.org/doc/html/latest/networking/tls-offload.html

Which I had to send a fix for blindly again today:
https://lore.kernel.org/all/20240530232607.82686-1-kuba@kernel.org/
because there is no software model and none of the vendors apparently
cares enough to rigorously test it.

I'm not joking with the continuous tests.

