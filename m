Return-Path: <netdev+bounces-181655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF80A85FDB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395A39A6D49
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F931E2847;
	Fri, 11 Apr 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2CGoqLu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A81C863E
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379928; cv=none; b=JsZikOYl58UvByDt6q1pbVgyJNNAoHeemg+Of3YJj3xLy1QHjb0aA3QZ5QG7m3I3cOoN8Jb8GSyh4qbzYzMTvccqwhS8GNLYp5YqNzo9zh0DGrf6IyUXlheTMgw62FEzFciFac3kaP4iBILKo4D28AdOo7WS5PvbhYyzBwbPXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379928; c=relaxed/simple;
	bh=POpleSMk/02TWtmXRqsrB1DxfC+XOlJkV0qhngp+XyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEhDPZWeZUn9BcdJjka87sjzrJCsADDZQdcU0FR99wQn/4Sh0bcqnsVWR70FMZNeByFtWQv7Iq1RI4N9C8OtJlNQz2WUX0o3nt2ElBFtnrq5qCZWOdQbvvt2HEdqWAplBY8ovZ/oihOALWgMVao1zSoGWmVPjbazaOwMDBFiDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2CGoqLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2842C4CEE2;
	Fri, 11 Apr 2025 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744379927;
	bh=POpleSMk/02TWtmXRqsrB1DxfC+XOlJkV0qhngp+XyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2CGoqLu7e3ibFw8Cd2muNR1DlfQ4XbRgrPohqLZP3BOCGUbKgHqEL8P/dppKyeir
	 myge/C12F75bYQTBJeRmtdYNlXsuyVZdGvWXAf/6AcF1X6LojGwWsuyssiGN7YBxeN
	 f7m1cNynGu6HHZg08XvorYntEqnBSjUl0jqXshNiQLwR9mPvUAR+FJzoPuMDrIZoFQ
	 pOYHPy7Tq0EWktmHnc3Mil39U8+ZYDk35fHIN18Hnrf5EjyRRymjZQI3X9gKC4wHQh
	 gb5J44BmNtrKK+NDH3Xuc+2S4QO3wnpvAKGlEGpz+LaEkrcmGW9AmrJUwHIN9pbQoZ
	 3gY57g3YiQbsg==
Date: Fri, 11 Apr 2025 14:58:44 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec 1/2] espintcp: fix skb leaks
Message-ID: <20250411135844.GF395307@horms.kernel.org>
References: <cover.1744206087.git.sd@queasysnail.net>
 <66e251a2e391e15a62c1026761e2076accf55db0.1744206087.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e251a2e391e15a62c1026761e2076accf55db0.1744206087.git.sd@queasysnail.net>

On Wed, Apr 09, 2025 at 03:59:56PM +0200, Sabrina Dubroca wrote:
> A few error paths are missing a kfree_skb.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


