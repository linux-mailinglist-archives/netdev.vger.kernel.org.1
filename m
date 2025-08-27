Return-Path: <netdev+bounces-217428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7623B38A3C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 798F74E13B4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D82EA74A;
	Wed, 27 Aug 2025 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iquvt+hu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C17212546;
	Wed, 27 Aug 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323314; cv=none; b=csmaBvE+9eoULCUqIi4gzBGZOCJgXPffJ9aU3nZot4lam91sy9yZdHUyib4d2rXQU5qvtaM+IMX/U5G65HdM7f6kUgYR3JoHekq84uj2NU8nfHqegCL+k2rhS9lEAJIP6BEd9RKdWTkX3oa5t/cjic5oOAUKlk0cLFyWwEbJcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323314; c=relaxed/simple;
	bh=sfyI55oAd8oB6IdULzqgjK2Dw/PnJAupn5hQarovk/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egLhDLkgixKjFPa6MfpyA5okGjyfc175/L6aU3MsBLimQ8WPXQQpAjxE4pzv5iklUprBVkCkaspohNRHgYC58yGOZdmUCHQmBe8qwjGcwKmkSSFX5Pucb8JcUUE4ccry8vEQE1vQNNgw2/6anuzfRGKRT+MtdpwPAivwKoo6xa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iquvt+hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90811C4CEEB;
	Wed, 27 Aug 2025 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756323313;
	bh=sfyI55oAd8oB6IdULzqgjK2Dw/PnJAupn5hQarovk/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iquvt+huIT6XONWVcUwNT2vkn5W6gPIWBukBLzygCKONgNGtvUSuM27G+WEib84aW
	 EAEvGatLtny8ttkNeKM1B5Z3lNHaAbPeUIvezipSPN0eArNKzpYw6nJSDm4/PPweIr
	 j2SJ/5yFpVLwzv6n1ScXeUD+gAJ/rGlKIQzUo8Hmj55qm7Vg4MKffRvC91Yll0x9QE
	 KTGRtZs9OtPZ+HXPtKnDC69k54Zw2pf/N+kIJpJWkHcZehDMDG04J8UNi/0T2y6qpa
	 3KTGOWI+vTdYl8BW/3AMyhpdhVwZ60khDc1hXR+OPSKx01y5zyrmZlnpivreT0SlEt
	 X5AJ0LTThuKTw==
Date: Wed, 27 Aug 2025 20:35:09 +0100
From: Simon Horman <horms@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Piotr Warpechowski <piotr.warpechowski@intel.com>,
	Karol Jurczenia <karol.jurczenia@intel.com>
Subject: Re: [PATCH net-next 6/7] net: stmmac: enhance VLAN protocol
 detection for GRO
Message-ID: <20250827193509.GS10519@horms.kernel.org>
References: <20250826113247.3481273-1-konrad.leszczynski@intel.com>
 <20250826113247.3481273-7-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826113247.3481273-7-konrad.leszczynski@intel.com>

On Tue, Aug 26, 2025 at 01:32:46PM +0200, Konrad Leszczynski wrote:
> From: Piotr Warpechowski <piotr.warpechowski@intel.com>
> 
> Enhance protocol extraction in stmmac_has_ip_ethertype() by introducing
> MAC offset parameter and changing:
> 
> __vlan_get_protocol() ->  __vlan_get_protocol_offset()
> 
> Add correct header length for VLAN tags, which enable Generic Receive
> Offload (GRO) in VLAN.
> 
> Co-developed-by: Karol Jurczenia <karol.jurczenia@intel.com>
> Signed-off-by: Karol Jurczenia <karol.jurczenia@intel.com>
> Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
> Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
> Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>

Konrad,

As per my comment on an earlier patch, your SoB line needs to go here.

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

