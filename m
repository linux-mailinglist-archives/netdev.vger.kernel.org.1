Return-Path: <netdev+bounces-142609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85C9BFC43
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FAD1F23826
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DFE1DEFCD;
	Thu,  7 Nov 2024 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8LcLdnP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0B1DED6B;
	Thu,  7 Nov 2024 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944837; cv=none; b=GqsdjRihJhAa6vaF2NcP4acEObsrRXqYNuId6Gn78jKr4Pm4I+ajvSpAqXzjwQgxl3PMcYWjYn0gJC7qJRP8LoFix2H4ZBE7XeqOTMIp6M66ybu+TFm2jsP8V7IxGlDbxw1s9sLITAyqjOSYW1rLJ0bQ9snW9ox6kxhdKi+DpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944837; c=relaxed/simple;
	bh=ZOu9Ltu3rWcwXT1wD9kPsZHxxzHW75/3JYDt8JHTRfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOxgmH9fyJDBy5J0Zr/fwtRfwStZ+tHf92sj/1WCbvsdBYclSVTVQ7e0KsZ5hSueAOAqMS8QolXzBOo3X6df0qaSsx0S5mjMp0HjZoKfmmraHauMIGxEOUM+KbvGF+7I+E0fXOpQpyCB5AzxTRHraJF5YwrbR8N69I0ZQZCup7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8LcLdnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064A1C4CECC;
	Thu,  7 Nov 2024 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944837;
	bh=ZOu9Ltu3rWcwXT1wD9kPsZHxxzHW75/3JYDt8JHTRfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r8LcLdnP9SPQXS5HwOCOIG1+0F2SiuUKeqm+QpfPCwFqqC0tLeZSv2q2BQuSfGmVa
	 nZTi5pSvCElcgkYOLOeh5cIRjqNgYEJVffUoeOZF7isPjtexDc68bhu+SpDnVMnKnH
	 wsZvRrzAyiYU/msf1RpVsp9Bqhw0BSjA31IlY0QN+ewUHa1YRjUVyTPfyUadz9rU5i
	 VMt5AYyvLRST5sQPX/Qv3MvImeW/zqvcLXUWmFodcq1NzY3e0xrKBx0g5Ty0+KAPXv
	 fNgp7ssIsGozaiIa/Hpaw4nOxJr0pfCyGd/mBfB/MpbDtFeZhqK94ddqygcR7SDXKl
	 EMK4+Mj+PQGvw==
Date: Wed, 6 Nov 2024 18:00:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 net V2] net: vertexcom: mse102x: Fix tx_bytes
 calculation
Message-ID: <20241106180036.0ca3e354@kernel.org>
In-Reply-To: <20241105163545.33585-2-wahrenst@gmx.net>
References: <20241105163101.33216-1-wahrenst@gmx.net>
	<20241105163545.33585-1-wahrenst@gmx.net>
	<20241105163545.33585-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 17:35:45 +0100 Stefan Wahren wrote:
> +			mse->ndev->stats.tx_bytes += max_t(unsigned int,
> +							   txb->len, ETH_ZLEN);

Is this enough? skb->len will include 2 bytes added by
mse102x_push_header() and 2 added by mse102x_put_footer()
(unless we went to skb_copy_expand(), which is very likely)

May be easier to save the skb->len before calling mse102x_tx_pkt_spi()

