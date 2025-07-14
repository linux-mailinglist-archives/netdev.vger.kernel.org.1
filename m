Return-Path: <netdev+bounces-206773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D3B04570
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CC71893EE6
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9F25F997;
	Mon, 14 Jul 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCSR/GoL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE971F4CB3
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510481; cv=none; b=D/ZlcCJCaW4dilIbRL3h8h/zI5KXwgK7BY7NHwEcdmMbvm4fmPfH9iy8PGzLt+8qB9wRGxigBSgredzPb8PBHsflTytIEOJ7AqP6P5ZbomOnu9Rk0mE34cUiQDhWd0I20c6o833TnU0VQaatjkE7/ZTPMVIf1s4NPqkm+nYxZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510481; c=relaxed/simple;
	bh=Ir5O8j9mlh8qeFowTl4mNXBntZdrl4d1XMrBXY3cnNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rdpovj1vdQqqn2XJhTgKG2Un22nsK8eUzn8d2YdMAaeY2QIIdtyANII/P2zUIQaC0X/NWEco+HUM7M0T0yCrNvW0SIEK/GIgbfeVoLT3KlNOdW2za2Sdf+Jcw6/ze+yJxMB+ArogX+3XUIiLVaKAVLwmC7ixCnSWsAfs1y5P02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCSR/GoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814CCC4CEED;
	Mon, 14 Jul 2025 16:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752510481;
	bh=Ir5O8j9mlh8qeFowTl4mNXBntZdrl4d1XMrBXY3cnNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCSR/GoLW5m+9zcU/mwUEok3+CY/mvFSol2EFnUajuO3MY92aZDYzbqfgNln4h5kH
	 W+Jixmib+gCUxnlYYUQFHFxBM0ycoyrfsBDTttur5c/oVHMB9X7BEPozsnEgDFPZHa
	 J01ORHJ1HCNH+YYEH2dSr+vNnyI1gWvseNTShm3yWKiVk9kcCl+lo9GVhsEM5SmzAN
	 tDoJQvVhQ6Jyay2CqDJ8VViPoBsu8CceAYpnAgjn487bW4yVZapOafc9bEA/Jmo6k/
	 HEz3BjREWsNFxsS58ZB4G8e2M0YRFUffSKw128+2XpiUTgVPmBRmpQrrnBnjdIwnkF
	 LiQkUMG9hY0EA==
Date: Mon, 14 Jul 2025 09:27:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 09/11] ethtool: rss: support setting input-xfrm
 via Netlink
Message-ID: <20250714092759.3f8c77de@kernel.org>
In-Reply-To: <f894a965-3fb3-4068-9d1e-95ff62705544@nvidia.com>
References: <20250711015303.3688717-1-kuba@kernel.org>
	<20250711015303.3688717-10-kuba@kernel.org>
	<f894a965-3fb3-4068-9d1e-95ff62705544@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 14:11:34 +0300 Gal Pressman wrote:
> > +	/* xfrm_input is NO_CHANGE AKA 0xff if per-context not supported */  
> 
> Can you please explain this comment? Shouldn't we fail in this case?
> Nit: xfrm_input -> input_xfrm.
> 
> > +	if (!request->rss_context || ops->rxfh_per_ctx_key)
> > +		xfrm_sym = !!rxfh.input_xfrm;

xfrm_sym is supposed to indicate whether input_xfrm is set to symmetric.
Normally !!input_xfrm will tell us, but if we're dealing with a request
for an RSS context and driver doesn't support per ctx key input_xfrm
will be 0xff so we'd false positive xfrm_sym and most likely fail the
SET request if the field config is not symmeric. I'll rewrite this.

BTW I have a check at netdev reg time to make sure all drivers which
support xfrm_sym and contexts also support per-context xfrm_sym, but 
it will conflict with your fix so I didn't include it, yet.

