Return-Path: <netdev+bounces-83910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7983894D63
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 10:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7324B1F21BFB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783933D977;
	Tue,  2 Apr 2024 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY9OE7ZN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFB3CF74
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046477; cv=none; b=tE5YrxkuSjE2UNF9P5ex1ACLOdD41xok7BA3sI/C2D0PVqopnNwkH+Q1N1JiM5e+OWZyK9X9HXO8ExcBHN4fUUzGNEOA5cB1lD0rwUS1u4KXnMbMk6T8vKJ5pQFrWYUPzJDqmvVHA2HjVczGHBq3DYopFFUipz2eLgWS7JiPbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046477; c=relaxed/simple;
	bh=dGLKwI91b5KGApM2KPpkhVv8HR2IlOijtY6rrQMQrIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH/gIyWakaMLyO5F1JQ6R1rgE14vP1ExE+9b7rak0a2fLPOr+ZUPqEo+SXmSljRfbU6+TWieVAhD6SJfIiHZ7PVGEeWbiraeIIHbAhdNUH0BqHrzwevZGM9tx6Eb6ddq0srygust5qwmz0nDHJ99b/o9n9NQ1xQVaBid8a+0DmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY9OE7ZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEF6C433F1;
	Tue,  2 Apr 2024 08:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712046476;
	bh=dGLKwI91b5KGApM2KPpkhVv8HR2IlOijtY6rrQMQrIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MY9OE7ZNqS99nj2S7P2YYh4UPdVZDqlvdJhiBWRnIoSneuo/OU7YxyuTaV3BEn0Us
	 bab7uVpv4lKSWLUBKeeJS/bn3ry0BE5KwhBHAgpGHZFkAJowbtJZHzFjqEYju+jyNN
	 rk7jIPjXtErqRNipwm3YLt4inGf0NwpX0TajKNEGwZuyzcjAuQ5e5nT8nZwRDbBJrB
	 vG+d8iw7j1gU7nQBY65j4qgKhZFCG4M1b2dBdtEmIUklcF9gYsqLIGGIOvrsS+4Ivo
	 aMfdwuqnL7gpGCgZnRAcJtCB2m5tgzP+3YjcOomtfYCpMjtk7SSlM+P+epVcJlEOMq
	 4XKeXAfyYy24w==
Date: Tue, 2 Apr 2024 09:27:52 +0100
From: Simon Horman <horms@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
	victor@mojatatu.com, kuba@kernel.org, pctammela@mojatatu.com,
	martin@strongswan.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v2 1/2] rtnetlink: add guard for RTNL
Message-ID: <20240402082752.GE26556@kernel.org>
References: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>

On Thu, Mar 28, 2024 at 08:27:49AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The new guard/scoped_gard can be useful for the RTNL as well,
> so add a guard definition for it. It gets used like
> 
>  {
>    guard(rtnl)();
>    // RTNL held until end of block
>  }
> 
> or
> 
>   scoped_guard(rtnl) {
>     // RTNL held in this block
>   }
> 
> as with any other guard/scoped_guard.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


