Return-Path: <netdev+bounces-110263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B192BB04
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966D1B27E96
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EB15575C;
	Tue,  9 Jul 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UspMwV8E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F719E;
	Tue,  9 Jul 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531477; cv=none; b=RCtGr1l2oWaqkSALKLwBc0REIU5jbbWU7jXAPJJaBRv0rfHTMi/9ONNHQ/fom6LqVNhp3jDuK436xE1Xzz93gUqRkhVmOUWgxiL5bFAjg9bsLiiabIhdpUJm0h7CyMqWSYHUXgJU8SW/RGNQqXJ3RjxVTy4R6GtJwomKlnP1aI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531477; c=relaxed/simple;
	bh=gTdR6bvkUuYB7vnbxn9n1yUhza6OWLAXURpAoKtq8DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqNFrrfjSnFVGzFrZaSwPhPzC+V1n6dzpXYTx/a4qOTm1hW4GaEiZJJ/x27VqR6bfMmC2JcKa3Aiq1kySuaMx9RxtuLtAJFwQ+3+HtbQO+WoK4OORlvN51lRdcXAj7UEIZvLW575riwxbg/ZaJZaERuGBJcD6AJZ6QI5OIQdSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UspMwV8E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6jUkBzHiAT9bXjlf+KGNc02ub5p+yihLBXghD8K9+AE=; b=UspMwV8EMl3KqdG2EQFU4nQHhp
	IOFAFcNa5ZWeGp425gwuzFEh+6em5oN7J48sv/ATxr6R0WdAOTIuyEmLowN7CEhiAV8gYGqApmBTh
	DrsTToyWFqZFo2nBMN4pRNtfTyAgLEhdSxOYbSnfbQo8b/mqLHiwJSKcC11jJLDccRKs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sRApQ-0028zp-Ek; Tue, 09 Jul 2024 15:24:20 +0200
Date: Tue, 9 Jul 2024 15:24:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 2/7] net: stmmac: gmac4: drop FPE
 implementation for refactoring
Message-ID: <bb6398ca-9e03-486f-bcec-5b7a07367261@lunn.ch>
References: <cover.1720512888.git.0x1207@gmail.com>
 <98183e72d59cc8ce71dd9fd25a65983ff69dfcd1.1720512888.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98183e72d59cc8ce71dd9fd25a65983ff69dfcd1.1720512888.git.0x1207@gmail.com>

On Tue, Jul 09, 2024 at 04:21:20PM +0800, Furong Xu wrote:
> The FPE support for gmac4 is complete, still drop it temporarily.
> Once FPE implementation is refactored, gmac4 support will be added.

So you say this implementation does work. So sorry, no.

NACK.

What we want is lots of small patches which are obviously correct. If
this code is correct, you could simply move it to a shared
location. Code which disappears from one file and reappears in another
file, no other changes, is obviously correct. You can make this clear
in the commit message: Moving code into a shared location. No
functional changes intended.

Once moved, you can then do refactoring changes, which when combined
with a good commit message should be obviously correct.

In linux, you do not throw code away and replace it with a new
implementation. You step by step transform it.

	Andrew

---
pw-bot: cr

