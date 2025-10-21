Return-Path: <netdev+bounces-231057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D03BF440F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDEE405310
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C415687D;
	Tue, 21 Oct 2025 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEMww3kR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607615D1;
	Tue, 21 Oct 2025 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010369; cv=none; b=MlL+RJQ7tRQBblFqXDNz7OXB+sJVXhcNzQBC3V3/w4g/3o1nddinf61ZFxnKoSmkA+30SL3N0a/pBTfYRXm/+trEYZ9q6jNYZDtFVdb41qZzpsrFda3Bk+z54wn9P/PI2IVxI48UUuNgvHXteoV/KLHjMkI/3MwdIAWa0y3inLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010369; c=relaxed/simple;
	bh=aw35+ZdMM5XiGYvD6P/qA2I5pnziWh26pOOYn82rIWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcVz0eG/MMjkmz0c0DGlJ3KVNfLjo+A6E7zYML0t3yTueE+wWisnCyCnFhhx5o0Dzei3lruEOqflkNZDiP++VsdqTegKAA/PgnF+LzlTirnHIz+g/4F/AjZWuPlYh/AEVEDnEu+zyNeE7cE/WmvAOThTVx+qbeYW1b7Hfky+6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEMww3kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7689C4CEFB;
	Tue, 21 Oct 2025 01:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761010368;
	bh=aw35+ZdMM5XiGYvD6P/qA2I5pnziWh26pOOYn82rIWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEMww3kRkoHH7kGPjA93nlgZ/H8RiiA37RIcc9uDHnVvX1SfZADII7xi9f+xm/Lot
	 0yestpMaLbDsTHFtqtXQ0gw0OUVcFL9MntsluDqHulzLPxE6ntaFQAEpKG9snFQ7XD
	 3PSm/B7JMzuqg8pDApxzLi3op2MwWiQ2rf2RIOtYNGluzERl4ihxhbtzE19zlD9SYA
	 g7Kj8QLn5EotOtsvKaCYi/qOVQz9ir6mrk/CaaPFG4znOaNjkjBojt3aNytIz4Uzr0
	 ZOL6WvpZEbimJ2LxSka9ZWkaJ2/1A3EmlNJZRrY5svXOQ/R27FcNIq/nbb3bJgKwPI
	 DaaDcul9k9A6A==
Date: Mon, 20 Oct 2025 18:32:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Kohei Enju
 <enjuk@amazon.com>, Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next v2 13/14] ixgbe: preserve RSS indirection table
 across admin down/up
Message-ID: <20251020183246.481e08f1@kernel.org>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-13-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
	<20251016-jk-iwl-next-2025-10-15-v2-13-ff3a390d9fc6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 23:08:42 -0700 Jacob Keller wrote:
> Currently, the RSS indirection table configured by user via ethtool is
> reinitialized to default values during interface resets (e.g., admin
> down/up, MTU change). As for RSS hash key, commit 3dfbfc7ebb95 ("ixgbe:
> Check for RSS key before setting value") made it persistent across
> interface resets.
> 
> Adopt the same approach used in igc and igb drivers which reinitializes
> the RSS indirection table only when the queue count changes. Since the
> number of RETA entries can also change in ixgbe, let's make user
> configuration persistent as long as both queue count and the number of
> RETA entries remain unchanged.

We should take this a step further and also not reinitialize if 
netif_is_rxfh_configured(). Or am I missing something?

