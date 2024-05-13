Return-Path: <netdev+bounces-96067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE888C4331
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DCC1F246B1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA7153BCA;
	Mon, 13 May 2024 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpFbeQBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3837153BC0;
	Mon, 13 May 2024 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715610172; cv=none; b=tcO0eNFsUinYc/lzWail3KRMttre6haCGe1GYLBeuFYvl2Y05oam0AIzU8gJckg64wExLiMpH5nVvI7IVIq5CXzbAgBtZW/4kBTxu5/eEgp8j6Kbm/GQ0OqlT2N/TfkxGqNLuyz0viMCQ9AF6Af+bmkzFU7KSU1Ha1B4wD3M7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715610172; c=relaxed/simple;
	bh=tI/WvQv46AJugXtuNIipq8toujNOpRvVaAr7krEGAnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELjeg1ptSJYglhTrLYBbbNUDGxDtYrlfph+QgCig6O54Yf8P18oDDVo3W77lcwR7FKSDtBZP8g3wQBa9TsOrkvMzGt7frw/LjauWOmbcEJ9bH6PKo/EoQL7J5rdJSK6LLKbZpt376SkKR4sEp9Ajs4JXO2K1MoBAbB9iKW230SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpFbeQBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498C4C4AF16;
	Mon, 13 May 2024 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715610171;
	bh=tI/WvQv46AJugXtuNIipq8toujNOpRvVaAr7krEGAnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MpFbeQBA5dmJRcc8KkY9woVXu4e6RFP1wuGqPDI/UFeb8VGMy9Rhm2gxGSxP47VrW
	 LK2BGQqqY3MhZLT1P3WXQISPRCqQaGHem2z3aCDhZKf5JMWGdNrg943mosK7hXDhCP
	 /jraukPs7LRGbQwH/iWA8I9GM+TOtkP7ylmDUSdy5KUnQZWs+BdcTYKvkljpiUeKwp
	 P5IzxWZEsW05YsWlfVKXqOAUD2YM7iCQ+T0z8kbbRjHHY4AyIq4fSq5VweynkrTPY9
	 np161T+Nin8f5+nAgd5+oKunYx/YqDeWPi/+cHcqaWOYduFlKd1OOBbaoz0TYYzTbQ
	 U/odJW3UbdhQg==
Date: Mon, 13 May 2024 07:22:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Jason
 Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Brett
 Creeley <bcreeley@amd.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Tal Gilboa <talgi@nvidia.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Jiri Pirko <jiri@resnulli.us>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com, donald.hunter@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim
 profile management
Message-ID: <20240513072249.7b0513b0@kernel.org>
In-Reply-To: <1715531818.6973832-3-hengqi@linux.alibaba.com>
References: <20240509044747.101237-1-hengqi@linux.alibaba.com>
	<20240509044747.101237-3-hengqi@linux.alibaba.com>
	<202405100654.5PbLQXnL-lkp@intel.com>
	<1715531818.6973832-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 00:36:58 +0800 Heng Qi wrote:
> This failed use case seems to come from this series triggering a problem that
> has not been triggered historically, namely lockdep_rtnl_is_held() is not called
> in an environment where CONFIG_NET is not configured and CONFIG_PROVE_LOCKING is
> configured:
>   If CONFIG_PROVE_LOCKING is configured as Y and CONFIG_NET is n, then
>   lockdep_rtnl_is_held is in an undefined state at this time.
> 
> So I think we should declare "CONFIG_PROVE_LOCKING depends on CONFIG_NET".
> How do you think?

Doesn't sound right, can we instead make building lib/dim/net_dim.c
dependent on CONFIG_NET? Untested but I'm thinking something like:

diff --git a/lib/dim/Makefile b/lib/dim/Makefile
index c4cc4026c451..c02c306e2975 100644
--- a/lib/dim/Makefile
+++ b/lib/dim/Makefile
@@ -4,4 +4,8 @@
 
 obj-$(CONFIG_DIMLIB) += dimlib.o
 
-dimlib-objs := dim.o net_dim.o rdma_dim.o
+dimlib-objs := dim.o rdma_dim.o
+
+ifeq ($(CONFIG_NET),y)
+dimlib-objs += net_dim.o
+endif



