Return-Path: <netdev+bounces-243346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E36FC9D7BA
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 02:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFB33A6AA9
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 01:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FE815A86D;
	Wed,  3 Dec 2025 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qxRrmZXz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D103594F;
	Wed,  3 Dec 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724543; cv=none; b=PVqTjBauqmIJb5clxRGah8S93aPOAn9cXnpRsLlQ7SXmgqbYThrcb+AETWEGQoj+R4snsJRfUFsOgR0wc+Jy6ObHXEDGIx+0CTEmQKVkg2Ob2NByC14WZUDV5Q10IbpsY71XJQXdgC+Ku+HB7j19wHGKQGw7Th8u0lU8GCvrSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724543; c=relaxed/simple;
	bh=1aAHF8PDajZXLxUp/Jk0DAZDk0VR0NNi1mMok6QLT3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X97uqO1IcFlW9sIrScPcejFk3UJwZkscP7AiUAJePsD2lGjH6Cr0EF7JnkT4Bj058p2o5OiTgJZH40k0cbV0wQzOrgxZwm5/SDX7MhO3bFRbS3TOn3orwKpyNiMnebA5a7WMnKni32sHjv0s3s/jOEi8bVAI2cvKemG8ekYaa0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qxRrmZXz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pBJVd1jAB+0hdiBgrOpaANhgGukfvnPGmFszbdpJle8=; b=qxRrmZXzaycc530UVpgXAf5tfE
	B1zFI5sC+gzwnIO29o/rmFewuf/QZVWbCUkB+V6c4QfmWeFkAsfnF9Bfi50n+l5qo1AFCsXbKPEu/
	kEj4kqYJqzAxollglZKVEGRlfr3cfL6WguvR+0gGEIktGEMYkr4HnkGu5lY7/DkeJPB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQbSn-00FkpN-9W; Wed, 03 Dec 2025 02:15:25 +0100
Date: Wed, 3 Dec 2025 02:15:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 2/3] net: dsa: add tag formats for MxL862xx
 switches
Message-ID: <531cd8e9-2b15-495d-ae77-927011dfa54d@lunn.ch>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <9ada9140d9afdf491fb2851375106ba8bc5acd8f.1764717476.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ada9140d9afdf491fb2851375106ba8bc5acd8f.1764717476.git.daniel@makrotopia.org>

> +	/* special tag ingress */
> +	mxl862_tag = dsa_etype_header_pos_tx(skb);
> +	mxl862_tag[0] = htons(ETH_P_MXLGSW);
> +	mxl862_tag[2] = htons(usr_port + 16 - cpu_port);
> +	mxl862_tag[3] = htons(FIELD_PREP(MXL862_IGP_EGP, cpu_port));

You appear to be leaving mxl862_tag[1] uninitialised. Is that
intentional?

This is a pretty odd tag format. The destination port is relative to
the CPU port? You need to include the CPU port in the tag itself? Is
this publicly documented somewhere?

	Andrew

