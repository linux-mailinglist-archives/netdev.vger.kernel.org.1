Return-Path: <netdev+bounces-242113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFB5C8C703
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B3CC3507D8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F362264C9;
	Thu, 27 Nov 2025 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv5cSZ2U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74341225390
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204164; cv=none; b=JuErbFVLn8a5UieDBYvrg9HrXerIcyddsaFAQNjnf8ZFEEeysz7/CiLMICrdzZMN+KwLCMv4g8nXEKe4PxT1fh1Rz1zxyckrQMo6u07O/EakRNFs6W4jDI01+WmbL0k47ehUv1yP6Rb4Aoe+VQ5jbaiyHGd/ecoOeSjgy1sQg30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204164; c=relaxed/simple;
	bh=4LRXCgKEcAB9RdevNFYrCrbBlrG2sdAiOpRkRygTD9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6X8HSit9aJ88FJRTDyL3d3/aSk3gfC6YraCjWxPg4OAfHriRlocPTXAfLMsSYdgAT09glUD4upu6j1UoIoJDfTkZwj3LwT94HukadvVcWcuLDAVFCbLw9fCw1ciT2KL2L9lnlQBKdlSpHVwbUvfjr2kwyin604lodOKNo94hV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv5cSZ2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E139C4CEF7;
	Thu, 27 Nov 2025 00:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764204164;
	bh=4LRXCgKEcAB9RdevNFYrCrbBlrG2sdAiOpRkRygTD9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gv5cSZ2UhZjkDQ/KX3BsAtXWoEIslXEI0HEdFLWb+zRIdmgR4HoUSFJ0lV/FixzBr
	 UV4BBgSPvDuGAPGf0UaBJEkZQMMsCYfmdkauo6gH99teeReFyD21wDpFyUGWPXghJo
	 LnLq86zU68YG6kvsb6jy3tVU27mPZte8+1MexOXIe34FxAPwl2MVTlO9u+xzIt4lLh
	 8dpGmL3Iuh7V2uebCD4rE3nihb3aBDXNZQDT9lvozYLjNoX3rLQEkOeqn+fBUoaDzt
	 N7urAHftT3DMjc37IuKj6TNnTs8Kf5HiMzCS+5AYOb30ff8c6LVO/z3EuXJ9tbSREq
	 9nqJWKZaKUWNA==
Date: Wed, 26 Nov 2025 16:42:42 -0800
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
Subject: Re: [PATCH net-next v16 3/5] eea: probe the netdevice and create
 adminq
Message-ID: <20251126164242.2b649c98@kernel.org>
In-Reply-To: <20251124014251.63761-4-xuanzhuo@linux.alibaba.com>
References: <20251124014251.63761-1-xuanzhuo@linux.alibaba.com>
	<20251124014251.63761-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 09:42:49 +0800 Xuan Zhuo wrote:
> +struct eea_aq_dev_status *eea_adminq_dev_status(struct eea_net *enet)
> +{
> +	struct eea_aq_queue_drv_status *drv_status;
> +	struct eea_aq_dev_status *dev_status;
> +	struct eea_ring *ering;
> +	int err, i, num, size;
> +	void *rep, *req;
> +
> +	num = enet->cfg.tx_ring_num * 2 + 1;
> +
> +	req = kcalloc(num, sizeof(struct eea_aq_queue_drv_status), GFP_KERNEL);
...
> +	drv_status = req;
> +	for (i = 0; i < enet->cfg.rx_ring_num * 2; ++i, ++drv_status) {

is the rx vs tx ring_num discrepancy here intentional ?

