Return-Path: <netdev+bounces-239367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCA6C673BB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8B9F429ADB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AD1259CB2;
	Tue, 18 Nov 2025 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwxbo6dr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3B243956
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439504; cv=none; b=Jl0UpewzdgiZP+ZVjJxosMYTXUfTEbjo7iXJ437PMoCTLS00oOJJF2bskHAigCKz7qAXDg2DUYTsOXwz3L4ze2vvLvVfUTVDXktD4gFFHEDeO/EIvRRlVMazSKTrXdyk6dqyzeZcJHQP+aKk6ApKnYhr4OZAWaA+Mhq8jutKZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439504; c=relaxed/simple;
	bh=goUGHWGdj68lwjbL58g0lOw5hwU6HKxo6zF00jCfrnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwOim2/9BJA95RQa5TASpQYswvkfWWxoQarVzgOXV+wui51x5zMJmHykLAQTYq0mhKY/fFv0sHQJ4i86HqLtYQcG8ysLfBRqUJPU+4wiY1455+iVpDPtw2AraXVkkevz3XPXyK0amGM4R+UW0bLQFTu8RDrDkcRgBdtoQqhiaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwxbo6dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C6CC4CEF5;
	Tue, 18 Nov 2025 04:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763439503;
	bh=goUGHWGdj68lwjbL58g0lOw5hwU6HKxo6zF00jCfrnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bwxbo6dr7ocrZGQoJS7FjOX+PDhzNdoZqMZWlqsOa5Ja0z8xWhQFup3m6AexRTVee
	 cajaVKYVEF/2vElNgAvmZo5Q7kMDERySXiiQeT1x8lX8R+AKO2zJcUnAg7iXhJlr9Z
	 m5c3A5OAO77wb7tgfsa4ZCncIFppAOMgKsO8Pv0CR6e+mlAAWgD0JxAta0hd/DeWuo
	 yjsRouYgi+idYp4Zt5Lh51RfVeoeLNJxTyIzoorvobXhw0GvstWLzl6wRUQyoVGVhI
	 cQSrlkQSHg2BDnuVu7b52wFWINK1vpzIOxAr62XsV1Qf14sra7/UQbHhrGy0KqUajn
	 WTzMTJ2eX2oIQ==
Date: Mon, 17 Nov 2025 20:18:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Vivian Wang <wangruikang@iscas.ac.cn>, MD Danish
 Anwar <danishanwar@ti.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v14 4/5] eea: create/destroy rx,tx queues for
 netdevice open and stop
Message-ID: <20251117201820.0acd0c5a@kernel.org>
In-Reply-To: <20251114061506.45978-5-xuanzhuo@linux.alibaba.com>
References: <20251114061506.45978-1-xuanzhuo@linux.alibaba.com>
	<20251114061506.45978-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 14:15:05 +0800 Xuan Zhuo wrote:
> +static int eea_netdev_open(struct net_device *netdev)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_net_init_ctx ctx;
> +	int err;
> +
> +	if (enet->link_err) {
> +		netdev_err(netdev, "netdev open err, because link error: %d\n",
> +			   enet->link_err);
> +		return -EBUSY;
> +	}
> +
> +	enet_init_ctx(enet, &ctx);
> +
> +	err = eea_alloc_rxtx_q_mem(&ctx);
> +	if (err)
> +		return err;
> +
> +	enet_bind_new_q_and_cfg(enet, &ctx);
> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err)
> +		return err;
> +
> +	return eea_start_rxtx(netdev);

Looks like this is missing teardown in case eea_start_rxtx() failed
-- 
pw-bot: cr

