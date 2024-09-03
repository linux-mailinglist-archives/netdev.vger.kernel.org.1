Return-Path: <netdev+bounces-124668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CA196A6A5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635441C20C9A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF0191477;
	Tue,  3 Sep 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5kP4FXM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D71188936
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388444; cv=none; b=c1PBbjhoU5c0wKzmsFKyBpEhq2GZHc2ru76eQq1i+NgPDqcGpfApZHnbgTjt4ZYXi/AfsQdg27vH/E9l0oeKzZoR7k+qrajujulnvYK6XsnvrKLdBb4bVWHjsiZ+5Tzt1IJxlpxtgXJao/Ocr4li0h/R7j23JsigEjzKf92oqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388444; c=relaxed/simple;
	bh=FV5AiSsJ3sdJLzmEwChGFKLOaoSe4UfpfcIr7kVOIFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uL+vxR66WAonOF6P/BeI6mS8976uJfWkieYP5BZlO2CQtJFKnlBn5KD+JR+0paMVHUujdcWF9H0iOmeJDHD5a57hw+x5XMZsS5tgnP5rPkGepygqy4g0hPFwQO0r2aeGXDDLH6bQGcQfMvJd1ioo1rD9M4mY9W8ZxrHdeMtLY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5kP4FXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62355C4CEC4;
	Tue,  3 Sep 2024 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725388443;
	bh=FV5AiSsJ3sdJLzmEwChGFKLOaoSe4UfpfcIr7kVOIFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b5kP4FXM3rUDbPgmzLpl235t+olP0Vz7V7M6Gw/anTP/cWX85acpiSXbg7EHCln8K
	 L/NClhpO5MkQtNjLsRzu6EO/LhYqfNIYyELxhKqUGWP49Auk5IWvI1MXerO/Zl4+Ll
	 OwHR7X/gwwhRlinMf2QRn+gSKRXPQMK6FaZ10+grjY9flvetZWCu9eMMDPi7C8MUZ6
	 sE8EIYb6OWDe72CvctsBLNHNT9btLlI29ocq2j8wld+vKAFOkgjJLOCe4vhw07fJoA
	 2rvggmZeY4sBXLMycc1Ae2ai5beJy9VwQ9Z6K+5vL509MoJINW3yeSmS29Z8IHzRgO
	 DhcSq37qGMZeg==
Date: Tue, 3 Sep 2024 11:34:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Martin Varghese
 <martin.varghese@nokia.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
Message-ID: <20240903113402.41d19129@kernel.org>
In-Reply-To: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 17:31:07 +0200 Guillaume Nault wrote:
> Bareudp devices update their stats concurrently.
> Therefore they need proper atomic increments.

The driver already uses struct pcpu_sw_netstats, would it make sense to
bump it up to struct pcpu_dstats and have per CPU rx drops as well?

