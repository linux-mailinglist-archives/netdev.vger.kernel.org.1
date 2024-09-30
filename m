Return-Path: <netdev+bounces-130476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF898AA67
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F51F23E81
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5844C193418;
	Mon, 30 Sep 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhXuE3K7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290D193070
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715403; cv=none; b=OgufXifxryXb0p5wPvRh1DOKwS8xKbjQcz2Ckqvh9UrHD40MGXA9huj2EGs9zi9QQD863KxtWlWtUPPp1ZrHScrZRZPcR8wbQpIAqoy2MoEHKaGzi+NfNfX9ai1P7eiVPliorVqv8k1l6gmdFEfoKhBnMglEzGogIQ4b5b+gIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715403; c=relaxed/simple;
	bh=smJ41339DXJMcFTyUmTXVKb/FV6x2vzFLgBVAC9IMvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ingjPe8If1WBUfbUvvV38/aa7jaMZbzfd4WNaldSFf18QMhi3XNZTlRpZ47N8wNklbRR9HvKjpN7+k6eVZgyfR9s2gSw8InvGyBd1DYJfru+qk1jMQtuR/zWG+TcDBGdNbYPvfzSYBOn2iLSaTR3Uvnmc+VhgYuiAxO76Lt9jVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhXuE3K7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4430DC4CEC7;
	Mon, 30 Sep 2024 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727715401;
	bh=smJ41339DXJMcFTyUmTXVKb/FV6x2vzFLgBVAC9IMvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhXuE3K7tbg7qM/NRg1MrIViYVa0Awz/srh4rC1oMYFwuAI97JZTfoNufFXg0734R
	 38z2m5vxCtecOva9DV5J7JZJ+xZWIJHeDylmaGznqMxXxb8NvrlLTIsknJlqx2phq7
	 qdWQamFr7qs9Jo4WHqA/eMw+i5pI7JqbU1DirLgjH/tyh9ZFhhHUtJsJ/ShFeCvpfG
	 bIlUrS6SrS7Rgrv/LEkSSjLeEPxte2XxOpzujKZ15+a1dTn2fu7BsRskrdHMs/2CPr
	 FRiRaLY4+ODIoLKiVf9zbjF+3zDltgic9G9ztAHe0OzzyDOQLssaTRhVDCkkWT68Ud
	 xXiduAkRmNEAQ==
Date: Mon, 30 Sep 2024 17:56:37 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next 1/2] net: airoha: read default PSE reserved
 pages value before updating
Message-ID: <20240930165637.GI1310185@kernel.org>
References: <20240930-airoha-eth-pse-fix-v1-0-f41f2f35abb9@kernel.org>
 <20240930-airoha-eth-pse-fix-v1-1-f41f2f35abb9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-airoha-eth-pse-fix-v1-1-f41f2f35abb9@kernel.org>

On Mon, Sep 30, 2024 at 02:33:48PM +0200, Lorenzo Bianconi wrote:
> Store the default value for the number of PSE reserved pages in orig_val
> at the beginning of airoha_fe_set_pse_oq_rsv routine, before updating it
> with airoha_fe_set_pse_queue_rsv_pages().
> Introduce airoha_fe_get_pse_all_rsv utility routine.
> 
> commit 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

Sorry, but I think the above syntax is due to me not explaining things
properly. I think you want something more like. In particular, commit, is
not a tag, so you should have a blank line between it and the tags:

...

Introduce airoha_fe_get_pse_all_rsv utility routine.

Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
for EN7581 SoC").

Signed-off-by: ...

