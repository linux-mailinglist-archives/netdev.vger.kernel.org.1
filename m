Return-Path: <netdev+bounces-131224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830C98D627
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF42D1F214BC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DF1D07A6;
	Wed,  2 Oct 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc5g+HGn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640D1D0787;
	Wed,  2 Oct 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876211; cv=none; b=f2NkqfBD01yeMuP7DfXMbXL5PjU7w7t5/16/yw51G9o+3p1MsNZPhg2oaq+z9pp2fjMQk3vPfx3lYbxx+H9OAR1nvNXc2BpXV5Jx/hJH1woUg99V5vz+snDeNvgoGr2pdUdFEo1BbQw32hGphjdhNO00yOJ29+BUYYZzHoGUs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876211; c=relaxed/simple;
	bh=e80DtTRNGlb6JK3H0PZD/C34R/KjT9uvvwA0pAj4iI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU4OV/LVlnst7rYcHPPPeDycH1gubgbAGd3IMLk7pvxmBYLnclfdSdLLKQ3CWO4LwMSS5lEkXT1kKLCnCfjaBewKHalBkmwzU2hrHBOgI1uvLzYrgs/a9j0P8Nbj24Ts068v8TlWSFCYLwrkuz32tggWL5lWCh3jHWrgxLzp4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc5g+HGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AF3C4CECE;
	Wed,  2 Oct 2024 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876210;
	bh=e80DtTRNGlb6JK3H0PZD/C34R/KjT9uvvwA0pAj4iI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hc5g+HGnlt6FUcsNocu9ohdlxDWfNwgmOCzrznGlAcYFKWNojMMi1fheNC0+wFJiD
	 N/N82Z6zdbH1xv+knsFJ3u3TL0VauaD51iWV7Etg0I1oCECwHkVW+qU4tV3oY3ZadE
	 WzWX+tP+woDihSYt/b3ROwpG1WwdjaHMj3iAAgenOrh76ZI38CaIP2OaYoZM0E6C9b
	 OJp+pfP1O3t5MQ92y7rV4TA3GjtVJIcN/z4VWp4x2P0Jse1iHScbZtNpDC1X4n0Lfe
	 sS8MibORMChKC0jUtL/88vqLupqiDGIbhCN1K1DqYCQ+lkkLar6BGzf9hwjaRyh57L
	 gIdNQE4HzcVEA==
Date: Wed, 2 Oct 2024 14:36:45 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/12] net: skb: add
 pskb_network_may_pull_reason() helper
Message-ID: <20241002133645.GX1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-2-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:14PM +0800, Menglong Dong wrote:
> Introduce the function pskb_network_may_pull_reason() and make
> pskb_network_may_pull() a simple inline call to it. The drop reasons of
> it just come from pskb_may_pull_reason.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

