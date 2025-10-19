Return-Path: <netdev+bounces-230760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B6BEEE2E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 00:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E9764E3590
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BE246BAA;
	Sun, 19 Oct 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T91ZzqUH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A74A1FDE39;
	Sun, 19 Oct 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760912747; cv=none; b=a5on53ComoqLcBzADWm3RX7D5XWmSBUYnUxRwbLyLudo0O8xoHWOThdu+qiDPy7PgyC6S8LdGmh9N3/D5PCyRvAO+RLN6N6gF2xwiGw/WbdeYupuf4jI+VSa7CkcUUsvotfilO0S8Umj1Q60LdK7bc+wqTPicFcNBiYiU0rxu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760912747; c=relaxed/simple;
	bh=gAJO6XNxvcd/2gE+vHM20/r2IfLcuHET+ONuD0vyfQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stoz1ty4TmmYffXIUaPQLCcHUiqEwEVqsg9M3dsbXMUmlQOHqvCYKLHV8ZTnjl1oIx68C3rXPAfSjzIqUrH9d7O3GWImn0Zc4GZKfbcLEiS8RYbnyD/TSyLk0NF5NVo0LmxVJCTDGep1nnWhyyXd4rdFJwjIjcSj9GEutzITHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T91ZzqUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34408C4CEE7;
	Sun, 19 Oct 2025 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760912747;
	bh=gAJO6XNxvcd/2gE+vHM20/r2IfLcuHET+ONuD0vyfQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T91ZzqUHux4tfVX2iNR01ns/APtCWhjQvpCODIIMbRXmJ49utg82qiGNIziWjRa43
	 RTUXmPuIVDO2modjHnm8JkZEsWY0XorTcZLN/tHb+bgSrEow5ZAMeHhtwHOzSKp+oA
	 ws24pUhQEDEHowtY3WbRCd61KVCIJMR9vrtbzOxsaWuit05h0dD5h/rwTk2WeY13n6
	 h5mt5RWZ0yKeIHTdzUdOlsrLXMjjCCsjpBMNFIhTelpjpIwLEzBoQvXoNruUigH6Je
	 pif1oRZA9/Bo6GTK7o4rfqgTcpoOvgYEeql4zDFWoEg7M5XFpJhlvBOPmeyWZQEd7D
	 EJk15wI89eHHA==
Date: Sun, 19 Oct 2025 15:25:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Schirm
 <andreas.schirm@siemens.com>, Lukas Stockmann
 <lukas.stockmann@siemens.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Peter Christen
 <peter.christen@siemens.com>, Avinash Jayaraman <ajayaraman@maxlinear.com>,
 Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>, Juraj
 Povazanec <jpovazanec@maxlinear.com>, "Fanni (Fang-Yi) Chan"
 <fchan@maxlinear.com>, "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 4/7] net: dsa: lantiq_gswip: manually
 convert remaining uses of read accessors
Message-ID: <20251019152545.524ac596@kernel.org>
In-Reply-To: <b0cc75e63daffee27f5fdab35d49d7bfb10e48bb.1760877626.git.daniel@makrotopia.org>
References: <cover.1760877626.git.daniel@makrotopia.org>
	<b0cc75e63daffee27f5fdab35d49d7bfb10e48bb.1760877626.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Oct 2025 13:48:36 +0100 Daniel Golle wrote:
> +	for (i = 0; i < ARRAY_SIZE(tbl->key); i++) {
> +		err = regmap_read(priv->gswip, GSWIP_PCE_TBL_KEY(i), &tmp);
> +		if (err)
> +			return err;
> +		tbl->key[i] = tmp;
> +	}
> +	for (i = 0; i < ARRAY_SIZE(tbl->val); i++) {
> +		err = regmap_read(priv->gswip, GSWIP_PCE_TBL_VAL(i), &tmp);
> +		if (err)
> +			return err;
> +		tbl->val[i] = tmp;
> +	}
>  
> -	tbl->mask = gswip_switch_r(priv, GSWIP_PCE_TBL_MASK);
> +	err = regmap_read(priv->gswip, GSWIP_PCE_TBL_MASK, &tmp);
> +	if (err)
> +		return err;
>  
> -	crtl = gswip_switch_r(priv, GSWIP_PCE_TBL_CTRL);
> +	tbl->mask = tmp;
> +	err = regmap_read(priv->gswip, GSWIP_PCE_TBL_CTRL, &tmp);
> +	if (err)
> +		return err;

Coccicheck points out we're holding a mutex here, can't return directly.
-- 
pw-bot: cr

