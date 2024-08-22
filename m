Return-Path: <netdev+bounces-121186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C595C12F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5581F2489F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D31D174A;
	Thu, 22 Aug 2024 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXnSt7Ai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47912B72
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367588; cv=none; b=I3+N4WD+qeJN3rlbPuxDc9NMH0EeAF7qzJ87omKsjIPt4/REwi5JuCtyvSlf0BBxERF+J2lfwyEAAsTQLnRigrJ4UoOTy4B1c7H/306fxBFtbEXlIhgfRKVQ26QXQq+f0ddaJLgwn5nEbj1Qo4QQhVsuNyftPoy3+/1Q7ui5K8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367588; c=relaxed/simple;
	bh=1JlqvRYSGheVn15kmOfjs/1KwuznpRsGbcr1m4DIxRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0PygDSpP60CRWzL74ItHu/jvO/WyQ2IAfwYpBMRxnSI9ZcILiXn3VzQy52rRJn2icaWaRDLEFmUSuNNhflMK/OWQJtoe/63IDoYGz3Vw24KJjsksHv97HiR9zq4dCRmXQoIeGYbkq9W8t2Nnl3/2mT6KILcdoE3Cco1P2Kvrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXnSt7Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A78C32782;
	Thu, 22 Aug 2024 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724367587;
	bh=1JlqvRYSGheVn15kmOfjs/1KwuznpRsGbcr1m4DIxRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pXnSt7AiL/a0yvB7lGg9V+RpNxshP7Lw+czObsYi2aC9pRDUfgGFzSTDLGJHJKptI
	 1AjdvIKX9tNbMmDHmQKjwGvBN0cjeN13bClaYbBErry3mgM4ZJdn0mXTftymE7Ejnd
	 7KtZApGvKexi28I+Oy9fIxjLesJwNYSPfbQvQKEPSiQql7oq7Pd0/5WpDP62pPy75C
	 gDsrdJAORMlCEsLM9yzrfWY5tp6j0XP6dKenH4gGavncUpUHyt9Wr9BGyxjhEtdYfd
	 0NRLSaiDhd67me9qZ0k5AIJ8n0mg6D30LdrO3FZel69WEPLg0uKF4LCssi7QUMNuav
	 xwvRa8DXPMeYA==
Date: Thu, 22 Aug 2024 15:59:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
 <michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>
Subject: Re: [PATCH net-next v2 1/9] unroll: add generic loop unroll helpers
Message-ID: <20240822155946.6e90fed7@kernel.org>
In-Reply-To: <66b571dc-19de-43ab-a10d-13cffdd82822@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
	<20240819223442.48013-2-anthony.l.nguyen@intel.com>
	<20240820175539.6b1cec2b@kernel.org>
	<66b571dc-19de-43ab-a10d-13cffdd82822@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 17:15:25 +0200 Alexander Lobakin wrote:
> > Please run the submissions thru get_maintainers  
> 
> I always do that. get_maintainers.pl gives nobody for linux/unroll.h.

You gotta feed it the *patch*, not the path. For keyword matching on the
contents. I wanted to print a warning when people use get_maintainer
with a path but Linus blocked it. I'm convinced 99% of such uses are
misguided.

But TBH I was directing the message at Tony as well. Please just feed
the patches to get_maintainer when posting.

