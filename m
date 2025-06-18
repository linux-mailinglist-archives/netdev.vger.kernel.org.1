Return-Path: <netdev+bounces-199149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A6ADF2C0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078543BA890
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155C2EF9B2;
	Wed, 18 Jun 2025 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS+err14"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9562EF283
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264534; cv=none; b=rs5pzB2wy4GtcH5esKC4iWVMR32JrVLNk7dLqt40GemSH+iEqV6EzeGa4pQrHfGulpDg0AksyTegRhBWXPPoPEQ1J4M4y1rQw/Z3BfFHNfDXSvOhAt2GiQH+zW47ntcKFFionzsLJWsYPPTlGkvMgfMddj7Dy+lbJfh1NsVuP1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264534; c=relaxed/simple;
	bh=TxFe6c1htu78AlW8pSUBk042YOu73xddSRufqG/XuNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpGOP4r7t3c6izYfTvMPbuMbu3Nn8kfQtwD7wTz3qajS0mrDh3767qZCEuxfl6dibAbaS+LCGxTHVxt1PGJm1HDBpTly/2l2UwTMiturt9Q0d+UaJsXiYVP4XjoHktwZ/yRFAeyTq03iKBi9y9qfYBZ+N0+X4nr724c3KXP5rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS+err14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAB9C4CEE7;
	Wed, 18 Jun 2025 16:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750264533;
	bh=TxFe6c1htu78AlW8pSUBk042YOu73xddSRufqG/XuNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WS+err14mKEvX/jOQ7z+Q/9qJWhYAW+QCzvtnLbtokjl7vebb6NXqf6S0Qy309PZt
	 /7XQ8RnBI5uBdAOy0iloelLIeCQSgiilX75/R0/IMwb1jt62+bJErtxLp3cfaZe/h9
	 WCVvqs3WhaEyR7LYHfbhnh7Xm2m+VHZp2lK4DPry5O+s/pwPpTZz1htzJvuzTH1quh
	 IlIn6AIcuntaqt3eULW4nzdW4L/Z7Y4l8pwSd2Cusg/wvMSZoOBg0vieFjgLaVJfxl
	 nsGWGokJDh4OF+HESnd335gCIaql6LQQB6Ac1OB16nhKHj8L6Ee/Tnvi/cbrv0YU+9
	 nukvYHw9U8Ahw==
Date: Wed, 18 Jun 2025 17:35:29 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: airoha: Differentiate hwfd buffer size
 for QDMA0 and QDMA1
Message-ID: <20250618163529.GS1699@horms.kernel.org>
References: <20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org>
 <20250618-airoha-hw-num-desc-v3-2-18a6487cd75e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-airoha-hw-num-desc-v3-2-18a6487cd75e@kernel.org>

On Wed, Jun 18, 2025 at 09:48:05AM +0200, Lorenzo Bianconi wrote:
> In oreder to reduce the required hwfd buffers queue size for QDMA1,

nit: order

> differentiate hwfd buffer size for QDMA0 and QDMA1 and use 2KB for QDMA0
> and 1KB for QDMA1.

I think this patch description could benefit from explaining the why.

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Code changes look good to me.

...

