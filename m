Return-Path: <netdev+bounces-189628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3EAB2D8F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 04:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112CC173A04
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 02:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0AD253931;
	Mon, 12 May 2025 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dcML+b1t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00630B66E;
	Mon, 12 May 2025 02:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747017674; cv=none; b=By9f4VWGBcVVDeoQuYafVGVKopxDBI5It55BSjqTC6Wsz8qDV1ieHxkJF8CIlIYp0fiV7DExI1E9XgZcCmIzO5hhJy2bKi9fYsIC8GdmJqwiFZYozykoYzX25Ur6fwpYDPnbhTVnNMVoOorPy5XZRl87qFMXPvwELg8UX8/I7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747017674; c=relaxed/simple;
	bh=FxHW+UctdeDgas8Dnze+zBCDGpv2A3y5iTQ21Jy9Ufc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eauoqvmkioyuont4UkOirnWocrTKNMEHkgbzlpZ6hfTT6L+QuAiMH10s8eqR5EpwwmpLPT+pW+BOrijvXWoEBa/8vVsHSeg70Js6FuQy8FG41UEJSKpuS8qjdp+8sINlyQCLdafBiWCf0FG2U/VTqmFfAgGOylb02vRS/zrOrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dcML+b1t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qarCZVFjzjCzz+CntmzHGrlwRAsojDD+EKj1u4C3XWo=; b=dcML+b1ttu/2hfvPS18arsCU41
	6aY/i4YRM/Rp3EcHN9UXvqyx6v2TSY5EWWpxGLXoC4LB6PPiIt3S+OhfhrpcuES1jlHTH2BNwzDFj
	nAA+/tlbS6oh1VNcGwPq/JuK/cagneTb7iSRU2ui42RCznQmAWkp6tEqfEkljrrVDYcA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEJ6H-00CIIF-5Y; Mon, 12 May 2025 04:41:05 +0200
Date: Mon, 12 May 2025 04:41:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 04/15] net: cpc: add protocol header structure and
 API
Message-ID: <0c7a753b-cdc6-4036-84af-909ca1df3f3a@lunn.ch>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <20250512012748.79749-5-damien.riegel@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512012748.79749-5-damien.riegel@silabs.com>

> +struct cpc_header {
> +	u8 ctrl;
> +	u8 ep_id;
> +	u8 recv_wnd;
> +	u8 seq;
> +	u8 ack;
> +	union {
> +		u8 extension[3];
> +		struct __packed {
> +			__le16 mtu;
> +			u8 reserved;
> +		} syn;
> +		struct __packed {
> +			__le16 payload_len;
> +			u8 reserved;

These two le16 are unaligned for no good reason. Put the reserved byte
first, then the u16. Once you have done that, you might be able to
throw away all the __packed because it is then all naturally aligned.

	Andrew

