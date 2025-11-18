Return-Path: <netdev+bounces-239683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489DC6B592
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 89741296BD
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE042EA171;
	Tue, 18 Nov 2025 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kia8R9X8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1CA2E8B7A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492761; cv=none; b=eFzlBPZd2yrXBn8syYCGBXcqP6HLTIa/hHT0Z/rY+bkliWLkI56HS+dgh47GDnL0BXJlaZ5ZSMV8p1gmowOSOiflPcmC0m6+8baR9cgBlxohWXH2F902x05Q/1F2P78fLFor7KhBuZUnQ5xcVrxIPCERgTZMkbqywqCwaFmTRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492761; c=relaxed/simple;
	bh=pju7ofIaCfEqOBR/57I3eU7P3+hZCgl1oJwiJhFZduY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+JqIFQd11qod6d2xaRF9bDT1mENxpK2v4iSkYJs/Ibnqkc4kyIVum8eQ7MTTQ+oQlLxMyfBscT6ST/3d9+QkAd60YtJlEk8PPc6azQZDtww6qMLQPApmJCN+9xQqxH4nIfYsNuvNq6sSkItb+2J01KB757xOprLty+koIOSr7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kia8R9X8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=xrJC8QIJplMqK0vd9ECzTMFETLn3A1uAp2fyDz2bmuY=; b=Ki
	a8R9X8s+EdYRPpFVkjK29m0Wp7GAfvEirU7kB8fHvsSnQLatJJC5ttTa0e+X1js75ixh6wxj+Kk53
	LH83+VLjYN1El5ICBMkqky9ePyeCIJvxBh7pODYKQwHp9Iu0z7M0xn8C9pTuShvJEZ9KhxCvkHYYX
	AVuKwucWZuzhnp0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLR1W-00EO1c-2p; Tue, 18 Nov 2025 20:05:54 +0100
Date: Tue, 18 Nov 2025 20:05:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Netdev <netdev@vger.kernel.org>,
	"inus.walleij@linaro.org" <inus.walleij@linaro.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: Do not subtract
 ifOutDiscards from rx_packets
Message-ID: <59fd46df-8eef-4c56-a528-92729ad548aa@lunn.ch>
References: <878777925.105015.1763423928520.ref@mail.yahoo.com>
 <878777925.105015.1763423928520@mail.yahoo.com>
 <a31ffe45-5457-42a2-aac5-2f2da9368408@lunn.ch>
 <527355522.9591320.1763491519924@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <527355522.9591320.1763491519924@mail.yahoo.com>

On Tue, Nov 18, 2025 at 06:45:19PM +0000, Mieczyslaw Nalewaj wrote:
> I can't pinpoint the commit that caused this error. The file's history on GitHub starts on October 18, 2021, and this error is already occurring.

Please don't top post.

commit 4af2950c50c8634ed2865cf81e607034f78b84aa
Author: Alvin Šipraga <alsi@bang-olufsen.dk>
Date:   Mon Oct 18 11:38:01 2021 +0200

    net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC

Does appear to suggest it was always broken. So use that for the
Fixes: tag.

	Andrew

