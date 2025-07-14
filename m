Return-Path: <netdev+bounces-206885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10827B04AA1
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B54A3480
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7427933E;
	Mon, 14 Jul 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX84jHkz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF07278E7C
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532112; cv=none; b=DAZFLRLfq17P8PlhWN1SYkF3P0cU74FbIMyNw9U+51Gty2Lgepv0q90VhqsNAvWDiMttGZ+68nIHCYF+XVftIFrF3CseDbq+zy2mulMS2/xc5CSZW5bqS2t63A+Rdf7zJL57fD6n+yY7eaOf8NULIfanfb1PxsQNB+dxw4cQsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532112; c=relaxed/simple;
	bh=hLie23F/e+ruCQvbaIR1ODG+2t72nvoLeJzAlfDHiA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPpRshY79fzixiq/2doh71Yuj7XFKNNTA8NwraWxQFHDfr3vO5vcNn4fa/ePevnA8HTIcj3xplZaJw2qlhOf7kmCCR7ivLWygSQ6v3LlpTJFp+3SbQi95uIiFNNlrVNFvWjthdgG6u5PP8Ge9JVKemFyAnvm6LxGFHTc/S00c0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX84jHkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F64DC4CEED;
	Mon, 14 Jul 2025 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532112;
	bh=hLie23F/e+ruCQvbaIR1ODG+2t72nvoLeJzAlfDHiA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HX84jHkzPP1JYygc2S7hJ2vz/rALFIdZy6qV9wkOPVxEk7OShngrGoGyigFAyKp7i
	 M2I+w/qwelzGL0rjc1jILpXCaX89KG5YrOHUtX527A8zuGzIEZMK1hcr+NA9lwCL4E
	 wMFz4ty98gpDaE+Ysby/Vkm7jdse2XGVdAdlnaESJ0a1zLbqLZGOKui6MnjiKAsELy
	 Blm8reaSiBf+vyPz1SpE+QKbXgCQwSTq54cLzerzn3mjO7ncsncguCaCiNsuF8BsCc
	 Ao9Yrynv5KfTcENchzx4Q4JLQdpPl1QbJUrMOfqYppUhaVy9fi1IC26Q8fs3CLDPtz
	 e1Cq+EhnGcDaw==
Date: Mon, 14 Jul 2025 15:28:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, gal@nvidia.com
Subject: Re: [PATCH net-next 04/11] selftests: drv-net: rss_api: test
 setting indirection table via Netlink
Message-ID: <20250714152831.4c8745de@kernel.org>
In-Reply-To: <d0d2439c-3461-4be4-9014-70c93ab9a1d2@gmail.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<20250711015303.3688717-5-kuba@kernel.org>
	<d0d2439c-3461-4be4-9014-70c93ab9a1d2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 23:19:21 +0100 Edward Cree wrote:
> > +def test_rxfh_nl_set_indir_ctx(cfg):
> > +    """
> > +    Test setting indirection table via Netlink.  
> 
> "... for custom context via Netlink"?
> 
> Apart from that LGTM.
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

Oops, just posted v2..

