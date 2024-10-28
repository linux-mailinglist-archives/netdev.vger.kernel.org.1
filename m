Return-Path: <netdev+bounces-139637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059179B3B2C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A464F1F226AF
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14C190058;
	Mon, 28 Oct 2024 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kmxQnX35"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8D18EFC9
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146546; cv=none; b=iH15vN66NiE/WzuaOa9BXhzWa96WyXe6Nma4g2POLKJYhNeAXe0DG8MDvmnNcdpb0jG/VvDpNOLc/mBgi1pXe96/9L4F97D22Xxx19dU4YkWSwfsfWhqZykBAiArEsi8Zeg1YAQaMTMncD0qhuIXvpt7hPqxhHw5yyI3f+za+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146546; c=relaxed/simple;
	bh=JZG1Uo7l3bxxx8pCPMlI7dm71HnClJZwJVfcQiu6vgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o77+0bwpHaKsmfxQGHxyN0fQJeC1eXyVbn9PjbPU6FSL3c4T27JYUNJ1xJjrvFeuHR1p9jbLbEoyMdaVCu1lg/w4aTs6RN1CqBH9CFuqE8gQz01gwwCH8YUhQLnhVaVeEaGUuaZxLqo8eN5yDhfWrynmRoLdbdpdqcYbzpN0aZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kmxQnX35; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pue5XVFbEM6AlFeUWc/6HpzCIZftCw7bvrpdO9rgrQM=; b=kmxQnX359jE3gT4vRf6sOMzlLC
	9C0foMR9JNUBdZBw8B5Wk8bDgmiL/cruTgLZ/SX27p928v3hc7HoMnDi9acXQjWcrqFdGvxQJzEv+
	UFJUkCoCiXHG3C+TeHrf2VXcnos2Pm3q16BlnMkzjHs71Dg3vnJt/TS8RU0zmCNJNwJs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5W96-00BU3s-2y; Mon, 28 Oct 2024 21:15:24 +0100
Date: Mon, 28 Oct 2024 21:15:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Jacky Chou <jacky_chou@aspeedtech.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after free
 on unregister when using NCSI
Message-ID: <fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
 <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>

On Mon, Oct 28, 2024 at 12:54:10PM +0800, Jeremy Kerr wrote:
> When removing an active ftgmac100 netdev that is configured for NCSI, we
> have a double free of the ncsi device: We currently unregister the ncsi
> device (freeing it), then unregister the netdev itself. If the netdev is
> running, the netdev_unregister() path performs a ->ndo_stop(), which
> calls ncsi_stop_dev() on the now-free ncsi pointer.
> 
> Instead, modify ftgmac100_stop() to check the ncsi pointer before
> freeing (rather than use_ncsi, which reflects configuration intent), and
> clear the pointer once we have done the ncsi_unregister().

This seems like the wrong fix. I would expect ftgmac100_stop() to be a
mirror of ftgmac100_open(). So unregistering in ndo_stop is correct,
and the real double free bug is in ftgmac100_remove().
ftgmac100_remove() should be a mirror of ftgmac100_probe() which does
not register the ncsi device....

    Andrew

---
pw-bot: cr

