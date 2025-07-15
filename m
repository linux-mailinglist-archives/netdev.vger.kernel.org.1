Return-Path: <netdev+bounces-207173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F4B061A2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2EE1C41FDC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6391DE2D8;
	Tue, 15 Jul 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHbYWE7Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CE1DE2A5
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590352; cv=none; b=qr1hW4l/hmGP8+ITW+03ErWdA1nGTgEoPmQ5RtUOz4O0lPngAeWyIrw2hkzjVj34tsvd4bBH85btnORT6sShVM+KZZp8rDEGO8SNFH44fzD549pw8ilGZITVp6xGa5d4CyTXHZXBBlHZ/wOkii1Fh/4rgeHpoeZ8ETO/BuSSYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590352; c=relaxed/simple;
	bh=Ume3OLtF6GpzROfuemmCOTZfniTTZBteKIi5cGyZ41c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4h1bijvnmYgOeNXwHPoRfpsxo65N+a2pkh98WrY5RPuwDo4mW4HAlxlN2eUNylDfp5kdSMCF96Epz60PqeYcmlhoBVdsX2H4G+2YA2N4HZFF9MGPcy+nXXOun4Fo5CUzzkY9dUwkgpZIYMrHVG6pxobPiQ2YncyyoulRTrUe48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHbYWE7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B8C4CEF1;
	Tue, 15 Jul 2025 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590351;
	bh=Ume3OLtF6GpzROfuemmCOTZfniTTZBteKIi5cGyZ41c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LHbYWE7Q2zHzABbbR+zCc/Sap5uAU+7HwEj7BptpNHJaXBKYJLhF0PM7NKFn29Sqc
	 abHpjr8CgqoHfx9daw1otgU7RtB9D+fJlLtOP3MbcQ6sm1m4m9/Rkj8+ZUUqC/bz9g
	 FyAAW6xDkZyGPGMLaWHNXuSodcuexD9n8LshfrSyNko95YjkzUw6sAY5NlN8aUvc2n
	 n/ImK1XmzZBk08HLhb57GPe1UQJhY3uWTJPcpLwFf3SMPc0N1j3wZ8om221S4W2PVN
	 k0YWUWsuVWVKtJKvZABsyGpLkBQ2eJd2exLeyYr1aMisynmXP1Ofvwi3XOJm4r5TbK
	 jrlQkPm+tXSbQ==
Date: Tue, 15 Jul 2025 07:39:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 01/11] ethtool: rss: initial RSS_SET
 (indirection table handling)
Message-ID: <20250715073910.4c275711@kernel.org>
In-Reply-To: <737f0ee0-d743-497a-8247-63413060a7d8@nvidia.com>
References: <20250714222729.743282-1-kuba@kernel.org>
	<20250714222729.743282-2-kuba@kernel.org>
	<737f0ee0-d743-497a-8247-63413060a7d8@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 10:20:38 +0300 Gal Pressman wrote:
> > +	rx_rings.cmd = ETHTOOL_GRXRINGS;
> > +	err = ops->get_rxnfc(dev, &rx_rings, NULL);  
> 
> Do we need to check for NULL op?

Hm, yes.

> > +	mutex_lock(&dev->ethtool->rss_lock);
> > +	if (request->rss_context) {
> > +		ctx = xa_load(&dev->ethtool->rss_ctx, request->rss_context);
> > +		if (!ctx) {
> > +			ret = -ENOENT;
> > +			goto exit_unlock;
> > +		}
> > +	}
> > +
> > +	if (!mod)
> > +		ret = 0; /* nothing to tell the driver */
> > +	else if (!ops->set_rxfh)  
> 
> Why not do it in validate?

Because of the silly drivers which only support setting hash fields but
not the RSS basics. We'd need to duplicate the list of which fields end
up fed to ->set_rxfh in validate.

