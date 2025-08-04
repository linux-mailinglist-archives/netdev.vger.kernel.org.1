Return-Path: <netdev+bounces-211546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2AB1A059
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7534175674
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18272253F11;
	Mon,  4 Aug 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjq1UVK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F1253B67;
	Mon,  4 Aug 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306102; cv=none; b=SWjNGGf0W4rYASrmJImhBFisRFNl9gZTx5R6gRjXRkm6LgeB6gRf8v+WcVU+SEMeBcB6Gvblv/GZtzoTmnAas2cvXbkF/PRTGu3vBJFaYdc9hl3KpDHhFo8ZsoVO0avEHJoLvFhvn82607H43CK9ef0qyxlSCP5T/f7hLkmcpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306102; c=relaxed/simple;
	bh=kX/a1SPrAsrUpMgBhrDLh8cIm7TRe2YwQnKdkm9drUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I99nv/hvjJZ7nlY/KW4b6yU/l7L7pX++3fKZSM0vy4cQGHEzK6CGBU/WJzIVK+dFWwCA2ohPEwUS7T5T9llTLdQk99O6OoS51OLl9Z8FsUNHugbw/itLKguS3SFRmso/XozNIymfb5kfYUxJVEinDE1wlJmZBV7R5OgpuebE8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjq1UVK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ADCC4CEE7;
	Mon,  4 Aug 2025 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754306101;
	bh=kX/a1SPrAsrUpMgBhrDLh8cIm7TRe2YwQnKdkm9drUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjq1UVK520hOK8DhHSY15CEzCfGOwQpKJjNAnoHwZy0RWS8Fojml8ZSNbMS+Vq7NM
	 vxLbedNNCL1TSpAqUN/uvCr9is/kJNTnVjhPZ3DwHYBoJ1tu+T34mh3gJsWTvSuFbv
	 3wRLJ1Kxn+rUF/CEieuP/zYLrn6+U7jZ8jMJz8V6nMHdn4w14TH0IfMOSOTHIG1otv
	 OtdAmUX8+Yvlvit6b4yYAccRSIkyEidCHGFFpXDb4GdintPiJ9yRNmwdA8MJAdByDK
	 YqCO2OrbsqXL42TP/2MCtOGfMKCtUeyk2VirC2ZAcaDsT8bkq00AUUGAtDBEaG7qL1
	 EcugicFPlq1vw==
Date: Mon, 4 Aug 2025 12:14:56 +0100
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kernel-team@meta.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	sdf@fomichev.me, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net 1/2] eth: fbnic: Fix tx_dropped reporting
Message-ID: <20250804111456.GT8494@horms.kernel.org>
References: <20250802024636.679317-1-mohsin.bashr@gmail.com>
 <20250802024636.679317-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802024636.679317-2-mohsin.bashr@gmail.com>

On Fri, Aug 01, 2025 at 07:46:35PM -0700, Mohsin Bashir wrote:
> Correctly copy the tx_dropped stats from the fbd->hw_stats to the
> rtnl_link_stats64 struct.
> 
> Fixes: 5f8bd2ce8269 ("eth: fbnic: add support for TMI stats")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Thanks,

I note that the local variable tx_dropped was being  saved to stats64
before it's values were accumulated from hw_stats.

Reviewed-by: Simon Horman <horms@kernel.org>

