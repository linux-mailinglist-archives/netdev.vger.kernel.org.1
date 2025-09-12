Return-Path: <netdev+bounces-222727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F3B557E9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 22:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD47C171EAF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 20:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB62D6E4C;
	Fri, 12 Sep 2025 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0V7fcYxN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BC28D830;
	Fri, 12 Sep 2025 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710189; cv=none; b=r/vimB7XGmIXDoXS2xw9+x1jX2E7z766wJNHnIOvUA+x8gZAhmXKCsis/vNaYgz3kFfNNFjy3O04YtAy/Id2Q7YNDZ8k1+3L5yh2yLrzKVOhoy/Zxk7KGEJXzJkC0bHfCBpbtt+/e2bk9Z138sqjrNxlghnmv94MosAjgMoxlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710189; c=relaxed/simple;
	bh=2kxUcIcOQZKXRqT/5vxYUFvX8VTnfkpevdna6NZ4i0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXeJHV7csfm++3Ttozaghs69RdNwjm4j62GhLZkJ69zqw6n5xv4aJ6I+POx/zccO5BU6r/hMI98Pwf8r7wFvqTZyxb+XIY3z22DNVJ/yz2juK9vNSSZ896fEeiPSzA2HvQAAnUM9TdeWMQW3KlRn1DXNygtebLikVC4Fea601AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0V7fcYxN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qh2bs9HviW+76/HO35jHDE4EP8BmeuM9unoIVAmInxM=; b=0V7fcYxNhAsYgqZ32AMyVEdAJK
	zokvOnOBWVhtlmbjFYa3QS7yY+fYxNJxphWJCRAALvOx4OCtNV4NV79pf6Pox6CeCI4SrQaeWLhlx
	5HWODB8mVu27GqbkArpnx/DgySEl4+VvYEL82FwPgozfUEYJYn0mV5SB7rqxJ4LJNR2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxAi8-008Fuy-LO; Fri, 12 Sep 2025 22:49:36 +0200
Date: Fri, 12 Sep 2025 22:49:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH net-next v5 5/6] arm64: dts: allwinner: t527: avaota-a1:
 enable second Ethernet port
Message-ID: <862f4890-12c2-4643-ba7d-2740adfd4539@lunn.ch>
References: <20250911174032.3147192-1-wens@kernel.org>
 <20250911174032.3147192-6-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911174032.3147192-6-wens@kernel.org>

On Fri, Sep 12, 2025 at 01:40:31AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> On the Avaota A1 board, the second Ethernet controller, aka the GMAC200,
> is connected to a second external RTL8211F-CG PHY. The PHY uses an
> external 25MHz crystal, and has the SoC's PJ16 pin connected to its
> reset pin.
> 
> Enable the second Ethernet port. Also fix up the label for the existing
> external PHY connected to the first Ethernet port.
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

