Return-Path: <netdev+bounces-190899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BA6AB9354
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237D91B686FA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32029DDBC;
	Fri, 16 May 2025 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpNCw2K5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024744C91;
	Fri, 16 May 2025 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747356774; cv=none; b=Hzz+DYiti/A09lvNJAIIzAN8miaBIyzr6T7hcUqp5M0jJYQIJWK5cEA/A85jdn5NLkeNwDx3nNUGj/FX1IONfEf4NsWGBJsqPoyecK1OD5P3dATcFLDQiwgV31JEBWex3lSod7yXYywWPTzVx/0MeHqgzl4x3cEC1eI3kZwSl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747356774; c=relaxed/simple;
	bh=W4XvKUUpI1NuoyrHwx51qsaD68pHRMjadUnfOiZwxE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+ZE/kMZ/7ebxBblNKST2mRz6CM2l5VIpOiYwzq3/ArwRXcgaw43Cbv6NmbP10HRqkD/noETA2ZYaBAFbedPDUmA4IHLihMFpV8L5ztIUzyaSZrNVL6qYl5OzvmWRQv5mtJ8Ys7GoZxEaPpOWk0pAAD5DkJXauOo2+Tv387D6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpNCw2K5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6926EC4CEE7;
	Fri, 16 May 2025 00:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747356773;
	bh=W4XvKUUpI1NuoyrHwx51qsaD68pHRMjadUnfOiZwxE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpNCw2K54cXl1rkR48zAeUVMW7/fudU4soX9CFb4lUusKu2f9ZpdLF+ezxUlVUShR
	 kApJXAwkj5Ft9u+K6tv2d3huqCJp0gQ+9EGddd4/TAahTkl7P+RHznu0yaMzmT6/4Q
	 qJEsGB/IZg0SMUKdofMuVQNNOH1E6Pa4QxOm4p9UQq5+/kr6AF2uehMX5rcHQ3dwYn
	 Xkj8ub/YvVOJkippnp0cUQk2GUY+SJn0CXjUwZ06cdnJJQzw5kxUhjzLoz22MAKMvx
	 rNQecW8QT0sAWW7KseycQY22QXS8mRidLknoCjaaBsvY69hst3KbAFqF2iPvv4zo9g
	 GEBrSj9ketR7g==
Date: Thu, 15 May 2025 17:52:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
 corbet@lwn.net, linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [net v1] net: wwan: t7xx: Fix napi rx poll issue
Message-ID: <20250515175251.58b5123f@kernel.org>
In-Reply-To: <20250515031743.246178-1-jinjian.song@fibocom.com>
References: <20250515031743.246178-1-jinjian.song@fibocom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 11:17:42 +0800 Jinjian Song wrote:
> diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
> index 91fa082e9cab..2116ff81728b 100644
> --- a/drivers/net/wwan/t7xx/t7xx_netdev.c
> +++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
> @@ -324,6 +324,7 @@ static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct l
>  	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
>  		return;
>  
> +	ctlb->ccmni_inst[if_id] = NULL;
>  	unregister_netdevice(dev);

I don't see any synchronization between this write and NAPI processing.
Is this safe? NAPI can be at any point of processing as we set the ptr
to NULL
-- 
pw-bot: cr

