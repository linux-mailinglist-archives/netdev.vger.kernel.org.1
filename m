Return-Path: <netdev+bounces-191155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6653AABA48E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE3F1BA219D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCFD27877B;
	Fri, 16 May 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDkqBv4O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AA22B8A6;
	Fri, 16 May 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426590; cv=none; b=irP/gQTFWjguV50EPHZI+B6rw84DUzVf7GHGtBNBVJ+Jdxn+DODVIjfW+imhSASgHxlllsPTrAuiHwDejUF40FTBsy45+2oiRZ1Y9j+p8cSPbU7gRbvxf9lDzeRSc/S57193Su78oJmbZVpj8AHFY3jqIaZ+ydotb2HpNNH3kjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426590; c=relaxed/simple;
	bh=kAYAxVN/XM+RJhs5dx72zHiddu31wxM1RPXSf4aNn3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1QYpti2xggVN1u/+pGWktj9XAVrZA2a+RQ864oU39oWIt5iu45t37/dwYaZwZJRhDycBZDsmdkqC0DssQROUJjvaX6tDoL06IUz77igy5UehZWA7TMv7OCxgin1wy1zMPY3TImHp0SebIHmxXfDhNMKBsEX/RRB15p/Kkzo5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDkqBv4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442C1C4CEEB;
	Fri, 16 May 2025 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747426589;
	bh=kAYAxVN/XM+RJhs5dx72zHiddu31wxM1RPXSf4aNn3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDkqBv4O178ZTcf1Plz6dK/m+qu+N7c/E5FVcdVPFbxl3og197zzPSE6WZSO6RQ++
	 vqh58pcKbjMFqmdHvK9O4ClqROEHvzc5dC77JOF1R8ZcidYMBwKchXO/k4Ee+VDnf3
	 6XMGd4vsJj7HooBTQetJz4G6wxshL3Je5VokIouAFrmi6gulN/parOqwDFfy83WUhM
	 3kcsm8bPcon+sR/KM4UWOmg/iv49g0jAeCtmKWqiZLIo7J82URZLgZ4VKTyhBCUTuy
	 xw5tJX0ICoi33n/oH7puYjtwZFglsxRTHxldAXl8IgLd9o40EXQHUu2aUXcWROKcIi
	 +8bCZ1mEmoOdg==
Date: Fri, 16 May 2025 21:16:25 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/4] net: airoha: Fix an error handling path in
 airoha_probe()
Message-ID: <20250516201625.GI3339421@horms.kernel.org>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
 <47910951a3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47910951a3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>

On Thu, May 15, 2025 at 09:59:36PM +0200, Christophe JAILLET wrote:
> If an error occurs after a successful airoha_hw_init() call,
> airoha_ppe_deinit() needs to be called as already done in the remove
> function.
> 
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Simon Horman <horms@kernel.org>


