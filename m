Return-Path: <netdev+bounces-94899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A98C0F74
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8353D1C20C79
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067914BFBC;
	Thu,  9 May 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm1bEKq+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DF14BFAE
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256980; cv=none; b=OFL9N95YO1sjfvF5zCS5LH+qUUsxOHojrqKiKYb4ouWgNaoiKcFI+N1rULnRE8RQs97I6d9JpRuLpArcVwYpEKzLwT6tFJMV5RxT05Dt6oHVO5wfitl6zjcc+2E3FJc27Arcs3LzMotXQzWuQW4uz4iAVXDy2QzSKd8vISya198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256980; c=relaxed/simple;
	bh=kd1MD7upsHN/D5wW/G/4m/V5JZuud3tL/0pnSft97vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cfa7c3ODve3j/5MWkfzA4SDHeYdOVRps9DBAbodb/CaxAZPQoMWz5bvggrSMmzCrd/8iDSXIvy89OJTIaCbOCeMsG13rlCf3mM1i05uvU0PNYTxC7UDIpvaH/mxdQSJRm+v+YrS1ktaLh5cnKzKzzGJ76sU6O9TzyYII4Nn66iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm1bEKq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F0BC2BD11;
	Thu,  9 May 2024 12:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715256980;
	bh=kd1MD7upsHN/D5wW/G/4m/V5JZuud3tL/0pnSft97vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bm1bEKq+aq/qWp3lE4t9GVEbhiPfLGVOu9U71GSfLDRjItw1ZSfjlDz859Y2Z+EaM
	 bFR94BgYC40crQ+loDfTV5qktgpV4+eA9LUm2LVK3ki8sIu5MJu1DkQXUj5hW/OJT+
	 XbNKYT7cZn8ruk9+MBGCKILK82t5cCe22pP7fd34pk4I0lCpFfweN8BbOMhGo+ib4H
	 ZPj3yjBAZM0BC9xHljhPpiVl1v6BZmQGH7TmX+AfZZlWyGo2gTiFQWcdroS4Hrv9AO
	 OvQ070w64ppHDa44Gx7rmm2x1KOig8X4u08G+wWHMb1wAxAXZ+LPxtDYLAhYblMKPI
	 Jd11fTbJt943w==
Date: Thu, 9 May 2024 13:16:15 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 06/12] gtp: pass up link local traffic to
 userspace socket
Message-ID: <20240509121615.GP1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-7-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-7-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:45AM +0200, Pablo Neira Ayuso wrote:
> According to TS 29.061, it is possible to see IPv6 link-local traffic in
> the GTP tunnel, see 11.2.1.3.2 IPv6 Stateless Address Autoconfiguration
> (IPv6 SLAAC).
> 
> Pass up these packets to the userspace daemon to handle them as control
> GTP traffic.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


