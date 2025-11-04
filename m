Return-Path: <netdev+bounces-235391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AE6C2FB5F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 08:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC383A8C5C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 07:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F330F93E;
	Tue,  4 Nov 2025 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu4s3CF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B530F548;
	Tue,  4 Nov 2025 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242471; cv=none; b=Sjh1UeHpVUunLHTL4LeDJOMOxkDScFnj0Jp9xBF9sOyb62ty6CNo+8BqtgbYBDLnCiJhl7dY5lMjCgTsYTvsQ3Auwte7ItFzKJ5TV/789+ZIThf2SRn69qUBk57O2j1vmPiiEeOXKMmNSqgw503WFPzCL+wXMSLZ1pnEAoGY0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242471; c=relaxed/simple;
	bh=vi62X6CCBz2Jh/pAQix367Wk8kDMTnMQ9Gp9hjPYtj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myEobvQkFwYPUhidRhNBzysgta5O743em9ABxK6/S7Creb8gtMRI9Vy/LC+EIt5YwTklmUa+4dH7gdUTDtefY5FQqt5op2H0XEG629XSyLfZFLO5XAs8y6qp/LZolAl22kxuHWL++uNpw5w71EaSu+WuA85dv2sT4ghj3JVxk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu4s3CF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B1FC4CEF8;
	Tue,  4 Nov 2025 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762242470;
	bh=vi62X6CCBz2Jh/pAQix367Wk8kDMTnMQ9Gp9hjPYtj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zu4s3CF47oMLVAa7w+TmEJUBAZZAEENpbVUR4a6lVP7c3xQdyB3HH1V7RvvATuyN1
	 uuKTzepypwkOdZzWx9SIHBMhDnogepG3F/Lp96FDnorImVkjdV1MEAG18R3bcQ3Hme
	 owjjc2D8DWJA+LJApPCYOLuUs+4vGUDJiVnB9msDqI6xxWwQrjazZ+DnvIuJdMuZ9m
	 DoZf50cwkHp+q+tjV4BA0CaazCVVFwQ+2idHTcKuYPqZn54NiO4WYiY2ZAmcwr/bga
	 Fnr4KUlgLtUwMk55qQFhm6ttwTQA2Xct0j5XMIRlxS4PvPcNs2ycTumNISzNJzqFqJ
	 9E9BHpQjTFfsQ==
Date: Tue, 4 Nov 2025 08:47:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Schirm <andreas.schirm@siemens.com>, Lukas Stockmann <lukas.stockmann@siemens.com>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Peter Christen <peter.christen@siemens.com>, 
	Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>, 
	Juraj Povazanec <jpovazanec@maxlinear.com>, "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>, 
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>, "Livia M. Rosu" <lrosu@maxlinear.com>, 
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v7 06/12] dt-bindings: net: dsa: lantiq,gswip:
 add MaxLinear RMII refclk output property
Message-ID: <20251104-voracious-badger-of-courage-c1f4aa@kuoka>
References: <cover.1762170107.git.daniel@makrotopia.org>
 <9813bb916ecce9bae366e6c50c081014fe5371ea.1762170107.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9813bb916ecce9bae366e6c50c081014fe5371ea.1762170107.git.daniel@makrotopia.org>

On Mon, Nov 03, 2025 at 12:19:34PM +0000, Daniel Golle wrote:
> Add support for the maxlinear,rmii-refclk-out boolean property on port
> nodes to configure the RMII reference clock to be an output rather than
> an input.
> 
> This property is only applicable for ports in RMII mode and allows the
> switch to provide the reference clock for RMII-connected PHYs instead
> of requiring an external clock source.
> 
> This corresponds to the driver changes that read this Device Tree
> property to configure the RMII clock direction.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


