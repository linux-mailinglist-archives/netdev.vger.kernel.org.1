Return-Path: <netdev+bounces-70467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC6D84F232
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8850A2833A4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F8664B1;
	Fri,  9 Feb 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpQ+9s5W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6065067A1F
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470542; cv=none; b=hvu9IQPRdXqinEs5Rz8eIb+xlhfJ6dTgE1Lc0SBPSfJeCHU+bNEv0lAKMs/XKp8psRujBWw+FD5QzhDfG8Ppg/nXJ/LfzxmoYX+fS+/r2R253DIr6xXeIqaAidBwMkb2DRfb6/epWtJ7lKNI4qIaZbvF5CDO2zyk/CBJva8DI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470542; c=relaxed/simple;
	bh=aghJByx8n/4gB3bb7QgEGKtP/2x2GuqgPZfanBSyVEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwgbxCm2hbQhWWcmu9XQEs3UloW3DNmEjbe3P90h315ex4CweTl1O5g2B+ifx4OyWLPjyi3NKGx99WoxkD8w+vwBMsjrjd3kiG6KzorvSBhmsOboV4jbk3Bqp5QYgYsIpqboiruzuVbPhJriLi98w+F/QmLybVVjUt5arwg7rF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpQ+9s5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2EEC433F1;
	Fri,  9 Feb 2024 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707470541;
	bh=aghJByx8n/4gB3bb7QgEGKtP/2x2GuqgPZfanBSyVEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpQ+9s5WjC7Nt4bl5RsdiaoLzUtp8MX69ZAJjTjc1ZCDBy+tBE6IGIDhGaKfRDCKY
	 b/Ym0ujmlQA9Nnc5ymZ9ei0515XLGSW2HMlGjPlRNebTpJ+fLElWQfQ6+AmseFbWIb
	 BKiarbeQa7opPFBVDqkKi+ogKgUbqQD6X2ljOdptSDkkrbWWNF6Rz/FuxWcd1mb25s
	 oxcJgm+9c9ASrHRdCrZELhWWChed6aWVc0Nbd3Ojo2+/h/aHb/nHLXoCYzHp7LY7Ol
	 16r4+mbvkZTqb6GSOxGGK0iKn2J5UJvZCoFTIIOT+z3vQSOVWW3YL+orWiUubGl6gg
	 2jHsOfeqHPvkQ==
Date: Fri, 9 Feb 2024 09:22:17 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net, vadim.fedorenko@linux.dev,
	borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 7/7] net: tls: fix returned read length with async
 decrypt
Message-ID: <20240209092217.GM1435458@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011824.2609030-8-kuba@kernel.org>

On Tue, Feb 06, 2024 at 05:18:24PM -0800, Jakub Kicinski wrote:
> We double count async, non-zc rx data. The previous fix was
> lucky because if we fully zc async_copy_bytes is 0 so we add 0.
> Decrypted already has all the bytes we handled, in all cases.
> We don't have to adjust anything, delete the erroneous line.
> 
> Fixes: 4d42cd6bc2ac ("tls: rx: fix return value for async crypto")
> Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


