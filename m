Return-Path: <netdev+bounces-119254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117C2954FE1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22A0B260BC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3AE1C0DCA;
	Fri, 16 Aug 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHNFoFzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE11BF30D;
	Fri, 16 Aug 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828660; cv=none; b=k54lS+hhxOzBYKY9A8nDJJE7J4m1EfUhtigsSYZ0daKYgCS4QqZ4dfRoSO0leQwDWOgJ/GG/T2EMVK4GKWac3vAhdmIhT59+8ox9VT7J53wsVJh6kxhIUyYgV6r3hLkrzlYlZbQKeC9QmQ0UpEnWZN8cbclOuIr+5jHsIH01m/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828660; c=relaxed/simple;
	bh=SCysCikpEHkWiIKi7R82/tANYG4pvbyF053vPv6s01M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoDLzvBN2OfHJSPkhEdaSXQUBEBiKCsl1fa6yw27oj60eiaK5mLsFVbqJ7YNU3wgA0vH5E+CqB7wHmT3nkCI+voD7tgYO6Oi/m6QQ87OZt7skeAngwPKgjUv96wdon8IznO+KwaPm18VBVIceIxBAxEeydjdp/Q3ZdGuMfK9ptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHNFoFzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05143C32782;
	Fri, 16 Aug 2024 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828659;
	bh=SCysCikpEHkWiIKi7R82/tANYG4pvbyF053vPv6s01M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHNFoFzVUU4u9LJt0gzwClxGMMAhF3YAiKBHsapDnvKJs9lwe1iLKwKHp5aMZz98D
	 QSjJxZrJJsyJPQxYSjLkwaZNMs5pDyhkOx2sgqDZU/6Ng3y3ogzsrc0EN9w0bs329q
	 zMcGGNGBxQQKVCJtdMFrxFal4gm9E++dV5q0Raz7Vw2jSeeLOZ983++OTSukK7EKrU
	 /DYFu0Hg5AkVtDUNCu9RjeDJHvwmZWS2ypYD/NAuHOAhuYfv6/9VQJNVecHsXS/Y4D
	 ABj2QaTqU4/oNRqNG0tv42w/pUElBLpzzg1mnU2jRfAJm+rUz4olovBNsckg8g00Rt
	 kKz7oKfDR12nQ==
Date: Fri, 16 Aug 2024 18:17:34 +0100
From: Simon Horman <horms@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, ndabilpuram@marvell.com,
	bharatb.linux@gmail.com
Subject: Re: [net PATCH] octeontx2-af: Fix CPT AF register offset calculation
Message-ID: <20240816171734.GD632411@kernel.org>
References: <20240816103822.2091922-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816103822.2091922-1-bbhushan2@marvell.com>

On Fri, Aug 16, 2024 at 04:08:22PM +0530, Bharat Bhushan wrote:
> Some CPT AF registers are per LF and others are global.
> Translation of PF/VF local LF slot number to actual LF slot
> number is required only for accessing perf LF registers.
> CPT AF global registers access does not requires any LF
> slot number.
> 
> Also there is no reason CPT PF/VF to know actual lf's register
> offset.
> 
> Fixes: bc35e28af789 ("octeontx2-af: replace cpt slot with lf id on reg write")
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


