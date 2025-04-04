Return-Path: <netdev+bounces-179283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C289A7BAFB
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F06E3BCBE7
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F231B0413;
	Fri,  4 Apr 2025 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpN0lInk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396931AAA1A;
	Fri,  4 Apr 2025 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762866; cv=none; b=vA78alUc/JgSfukaQVe21CJ8tMvEjD+bbQCl3Ez09q/XNKG56/OIarmxnCWl379U74XVyJ37TMylJwi0lJ5nm/uBhvm4BXKq5LbSX/GswyfWGkG1EFOLhgrykFjEuXKqXe0hjdWvqHu8+c0umHb7LNqb6FPA+cSFBD33ZC4xCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762866; c=relaxed/simple;
	bh=7zKAxz382S+E6ZwfH2PoRY5GkF0aUBXWcgDHzAhyZlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSe1louCXhRqxgX8gqXA552Aq7pBw6qD3riNZ7Uk/0uSn/H23MCBp6kqrKjksLzMUaEucVZgMSkvNnPbpIkfXZkkAB/sktCAMxazesFESzS9191HQUjuo20azIfi2qWfzek5rPRgjTumOJqrxGBtdB5k6vVT99HuJK2DoMlzQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpN0lInk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C250C4CEDD;
	Fri,  4 Apr 2025 10:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743762865;
	bh=7zKAxz382S+E6ZwfH2PoRY5GkF0aUBXWcgDHzAhyZlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpN0lInkU5TwEwjiOe6YAQJdif7DWef1LfAZaiQdI+uTLq2m5B7OPWo1By4HKz5jL
	 y+Lq7dFkqkZavgP+Z+hCSL0KWyiTVG1gHm1lJMvaA6OypDbgVZV3KczQYzND7ij4vU
	 KfWXr4PQ8pRKF7k0M9S4Tma6YY5itGqvdQGgfmBdZk9UmkUCJV6uypEXjansFTlguA
	 dR0JXOmJUQR7srFiHCtEWyR2KlT47skIBGqwWHoh6Xii8pGzPUwPxLSTjecm68My8x
	 FEIhBlU/W0urxdLjttQMDDehbu0yaKUXitRjkrCn7/GdXBeRZ9EP2Kpe0PRMx4ASQs
	 KrRK2ix+/sz6Q==
Date: Fri, 4 Apr 2025 11:34:20 +0100
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Michal Kubecek <mkubecek@suse.cz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net] net: ethtool: Don't call .cleanup_data when
 prepare_data fails
Message-ID: <20250404103420.GD214849@horms.kernel.org>
References: <20250403132448.405266-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403132448.405266-1-maxime.chevallier@bootlin.com>

On Thu, Apr 03, 2025 at 03:24:46PM +0200, Maxime Chevallier wrote:
> There's a consistent pattern where the .cleanup_data() callback is
> called when .prepare_data() fails, when it should really be called to
> clean after a successfull .prepare_data() as per the documentation.

Nit, if you have to respin for some other reason: successful

> 
> Rewrite the error-handling paths to make sure we don't cleanup
> un-prepared data.
> 
> Fixes: 728480f12442 ("ethtool: default handlers for GET requests")
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I agree this makes sense and addresses all instances
of this problem in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

