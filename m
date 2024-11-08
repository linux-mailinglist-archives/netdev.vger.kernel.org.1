Return-Path: <netdev+bounces-143428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6E9C2697
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED1D284923
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097401C1F25;
	Fri,  8 Nov 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc5Ukw6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D131A9B2D
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097758; cv=none; b=jgpB7q7U2/sz/JCkcdsPBY6qEGL8VAjlt8Kuqe9D9VloLlzzgzytZZ+8hn1wvUow89bRvP50vW6mubo5K12iSj9VQ2qKFCFIY1IgFvWQ0OyenR4J2Hqcxq8xNkK+xcocxYIAhz+Reilft1KueXSSnBqr+TRdmsmyCjh435rXvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097758; c=relaxed/simple;
	bh=X1a/z7qswQ9BVqSIeeEm9McxvZ69jHUgE3oxDIPPUJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbY+lyOn0xc7QiUoYdWdNBY62RnUZh/fql5/PLmwb08Ujc1UUzvkVie+gNrjcEzAP1ScRtNZaQ7+bP9QljAFZ+HOQAIqN9PHLIN3pErvCX8guK4z+bGlgsv9h0D+/1BxjWGaT6fQoyLdGdZ6FHNiRzKQR78UquA7xJFWr0olvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc5Ukw6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BE7C4CECD;
	Fri,  8 Nov 2024 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731097758;
	bh=X1a/z7qswQ9BVqSIeeEm9McxvZ69jHUgE3oxDIPPUJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nc5Ukw6TXfteflg7OMuuhJK5u2hMXlIEs4yFLA90YDGFhOHalxgOQDxsH/YaI3Yld
	 TascRi5wFx+k03mDewZDpQGLhcLTmDwF9eXzQ1zKlJz6g1MYo12bFYXfMlW2gFH9h+
	 TGz/Hv9jwN6KDmWMej1Id7saJXXlstbfoL5pUoxlgq9ltMMfpiXp0jxWUQDYBoe6bb
	 8wq8y4bWd7ATgM2UrjZ66L26AhcUHcIXrfQot8yeoX0SOhiyin0WCKRoOTcLOZfERj
	 Bd7iCvpvXa/S1Y0zTQ3cwFRcl0EXYDKy53rSwgZLKS+M8207e1d7DmBxC7h1a2mVNA
	 mUDD8vewB7QPA==
Date: Fri, 8 Nov 2024 20:29:14 +0000
From: Simon Horman <horms@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next] geneve: Use pcpu stats to update rx_dropped
 counter.
Message-ID: <20241108202914.GJ4507@kernel.org>
References: <c9a7d3ddbe3fb890bee0c95d207f2ce431001075.1730979658.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a7d3ddbe3fb890bee0c95d207f2ce431001075.1730979658.git.gnault@redhat.com>

On Thu, Nov 07, 2024 at 12:41:44PM +0100, Guillaume Nault wrote:
> Use the core_stats rx_dropped counter to avoid the cost of atomic
> increments.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


