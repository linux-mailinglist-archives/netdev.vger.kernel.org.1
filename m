Return-Path: <netdev+bounces-243586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 453B7CA4413
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE47C301E934
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FC22D3A6A;
	Thu,  4 Dec 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Aup0I71G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00F2652AF;
	Thu,  4 Dec 2025 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861752; cv=none; b=urmZECTj4+Cd9ToAk3iVtYRqLBJcWr4KwZbG/QhnhslodNFJoR3tntBWcSk6pPvTssTMbVC9rmjje8wuLRPIVf/i0FL4DfO+a+ZQySdMaplZtVqoWURY0LZGsTIFlQfRjVQbkr3Sjp3jtEZd+80QxzbalJqoDKZeyY70CN3ZJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861752; c=relaxed/simple;
	bh=7uY3CtvGSpV81jCkvMVTOqi2Jjg0nG4tbj9cDtteuMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2C9ChmnhuhittK/dPkSkQClJVwQB/Y9E8MVSTJR7+OJhwtCR7ShGAD8JxJ2NBbS9AK4VZJi112wTF3Wr2oAFcPOvIavA8cmdk+3y9X88BBkgNQXrLctVrwfJrDb1FAD/UtMdNNN74JxV6zaxGRFmlh5fb2DJg9FLgcpWKekeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Aup0I71G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CSXwppmi/1KlyaunSxcGPfEGwrM8gH9Rv/W1n4Do2uY=; b=Aup0I71GV6QggM+CaxB8OpiuFo
	tYkm3eMrKXTK9w2z5uiG17StE3nApVL8+dGEQIWkYGIJ41IkErJU033NPYFfto9IId4oMoDEL6YcT
	eH39NIoKYicYV9vnYDWSBgTiZkjwpzoTGFuTezstBvenDyRnXFDvs6z0VvRV2edtZrO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRB9m-00Fytb-Hm; Thu, 04 Dec 2025 16:22:10 +0100
Date: Thu, 4 Dec 2025 16:22:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frankwu@gmx.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <7aacc2c2-50d0-4a08-9800-dc4a572dffcb@lunn.ch>
References: <20251129234603.2544-1-ptpt52@gmail.com>
 <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204131626.upw77jncqfwxydww@skbuf>

> If this is blocking progress for new device trees, can we just construct,
> using of_machine_is_compatible(), a list of all boards where the device
> tree defines incorrect reset polarity that shouldn't be trusted by the
> driver when driving the reset GPIO? If we do this, we can also leave
> those existing device trees alone.

I've still not seen a good answer to my question, why not just leave
it 'broken', and document the fact.

Does the fact it is inverted in both DT and the driver prevent us from
making some board work?

Why do we need to fix this?

Sometimes it is better to just leave it alone, if it is not hurting
anybody.

	Andrew

