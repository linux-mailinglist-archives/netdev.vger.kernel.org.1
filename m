Return-Path: <netdev+bounces-102024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69B9011B2
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D739E1F21EB4
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144AE159209;
	Sat,  8 Jun 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFzw6iwW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B67482F6
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717853830; cv=none; b=F6IHMPHNoRQ5RDQYWNptUl3TQAavztA0y0mch35EgiMl3K9/DQv8PBU+sg2jflhbFHrBYTvfsEZQCty3yxialNfaeukLr8sUpZr/86zU5Mp5nX1qrpI6FBnJJxJ247j11VkiDYivWzvxRIcVITHtgOPAnkZXqVGGO/JS7g7XPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717853830; c=relaxed/simple;
	bh=G/nYG75KfgMUcZLFjNqTZQU3uuJcgkN705FLIqTDJEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcK26FS2Z5/Mu/QxtpkOquhj+2wgvX4rrz19W04FlBvEjq2t5WuB24yP1QeqiK5a0agwIr3mbXZsQWxMmNZF+pODzUTG+jiVYA6yWYhjToaoR+qlANEmmkFV8UNlmWTTGwFgAjX0Um5AMuf4bD3wdpWz5Hl//wmGKebavhDlSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFzw6iwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A20C2BD11;
	Sat,  8 Jun 2024 13:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717853829;
	bh=G/nYG75KfgMUcZLFjNqTZQU3uuJcgkN705FLIqTDJEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFzw6iwW2cOvoRZ5v3mRX1odq8VdCLrHZrx58ZCGKqyp+VfVtlWEmrCW7X6zznEpD
	 jMIeYq203fEDV7KuhNcMHvGoo8JY+CbquCuCr4OO9D6UvYMQSePojgENvzY3Khxygh
	 dtoY9IWlr4IBjFEId7Mor5JBHyVbNSHhRkArVQ/cvvDrFnL/UIyo/AlA2Hgbrv3u4O
	 WXsRxa98MHqr6+l9CcIIGZdBWL+XJ5wDfDzn1innNx0OVXarjaJhD7PrLuoX4mrRCt
	 QSs7EzlIVFHmOBCGEeO8Fl9iI691dCO3whq1WfmEjMcFjESsAhC/YBORNIvt1ZZfhq
	 7KFOr0jinsToQ==
Date: Sat, 8 Jun 2024 14:37:05 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: core,vrf: Change pcpu_dstat fields
 to u64_stats_t
Message-ID: <20240608133705.GG27689@kernel.org>
References: <20240607-dstats-v3-0-cc781fe116f7@codeconstruct.com.au>
 <20240607-dstats-v3-1-cc781fe116f7@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-dstats-v3-1-cc781fe116f7@codeconstruct.com.au>

On Fri, Jun 07, 2024 at 06:25:24PM +0800, Jeremy Kerr wrote:
> The pcpu_sw_netstats and pcpu_lstats structs both contain a set of
> u64_stats_t fields for individual stats, but pcpu_dstats uses u64s
> instead.
> 
> Make this consistent by using u64_stats_t across all stats types.
> 
> The per-cpu dstats are only used by the vrf driver at present, so update
> that driver as part of this change.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> ---
> v2:
>  - use proper accessor in rx drop accounting

Reviewed-by: Simon Horman <horms@kernel.org>


