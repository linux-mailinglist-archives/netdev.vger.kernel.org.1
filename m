Return-Path: <netdev+bounces-145506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 149ED9CFB27
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CABCBB2891A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED6193091;
	Fri, 15 Nov 2024 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7SKGPU8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D121C68F;
	Fri, 15 Nov 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712556; cv=none; b=FTxgKtJqP6HhfcLB491KVyYUWWWF7jTnP+ziY4JLBEJqxQT4oqUXOKNlhVWlkigbLZR6QNOU9MIaOPN9gC5SnHnZ3iO2mowQ3DEXyyDxg8H6K5E/4Sck0zlzvyB6U2slANqAftVSPx7jzzBe8pvvoKtFA2tIT1eXT0B4XMCsxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712556; c=relaxed/simple;
	bh=FUyfmapV/R+XmUaTZVZp/eGm+YQusACamSnKy2xJ+uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMelGlTG9JuI5b3ySTcx2XeokniLJ1Hf7HKV9bRXJK/oAfwbZqmBmrVNV1sBjjMXN72k1mkI80UhjtDkZM4L/1qYCuoM+biwIb/MZAvfEiWAVbOccLG9fGlKzWwpcCp2PkZiIH9LzpZJzRDVQg7oTYgIZZv32nYHZlQ2ZU3ihw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7SKGPU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F33C4CED2;
	Fri, 15 Nov 2024 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712555;
	bh=FUyfmapV/R+XmUaTZVZp/eGm+YQusACamSnKy2xJ+uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d7SKGPU8gXQCnQ5JpnZsLnhnV8NyIwhYasFz269sjVY4FEbQ6I1AHdKXSg/YP5ePK
	 au7dHtfBXJWYBIv2qyHgMnjo51bJBIgoREDucUr4dQvfRL8c8AieNhLhZFp/zP5+JH
	 uV6U80H8+z0jkPMbh1B7/7ITNe17n3A7Ji7C3nw1qwvTl2RrZGLgqDAOS26R29Tp6p
	 Aklh35ASO1T/YQNL5I5+mANT9DsBGU2Gb3JCfEaG0QMAzu6bwWLJrSkVk+/zyqo/nG
	 MzTJ9U++8tZQ6QSCORvSyKee132jG9rS3E4DljmB0F/LAo8KIL14rVyFWTFYGYdC6Q
	 7jFtdz6+VA6pA==
Date: Fri, 15 Nov 2024 15:15:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [net-next PATCH v5 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <20241115151553.71668045@kernel.org>
In-Reply-To: <6737d35f.050a0220.3d6fb4.8d89@mx.google.com>
References: <20241112204743.6710-1-ansuelsmth@gmail.com>
	<20241112204743.6710-4-ansuelsmth@gmail.com>
	<20241114192202.215869ed@kernel.org>
	<6737c439.5d0a0220.d7fe0.2221@mx.google.com>
	<20241115145918.5ed4d5ec@kernel.org>
	<6737d35f.050a0220.3d6fb4.8d89@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 00:03:55 +0100 Christian Marangi wrote:
> > > Ok I will search for this but it does sounds like something new and not
> > > used by other DSA driver, any hint on where to look for examples?  
> > 
> > It's relatively recent but I think the ops are plumbed thru to DSA.
> > Take a look at all the *_stats members of struct dsa_switch_ops, most
> > of them take a fixed format struct to fill in and the struct has some
> > extra kdoc on which field is what.  
> 
> Thanks for the follow-up, they are the get_stats64 I assume, quite
> different to the ethtools one as we need a poll logic. Ok I will check
> what to drop and rework it.

https://elixir.bootlin.com/linux/v6.12-rc1/source/include/net/dsa.h#L915-L927

am I looking in the wrong place?

