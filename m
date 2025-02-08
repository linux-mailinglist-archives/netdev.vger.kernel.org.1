Return-Path: <netdev+bounces-164303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B551A2D564
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 10:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C416AF19
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E41A83FF;
	Sat,  8 Feb 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SAQT4A7+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D82194A7C;
	Sat,  8 Feb 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739008522; cv=none; b=rxVm1VsNB+uwZRycxddpsJ88kjdP6MFliFLqHbB73AAWkBm2vRgxKO8oQYlc6/ZgVGFZmTA1C9yo0BPf+92FpbReHg9DldarSas/RsAoCX//W2iJT1in1Vru73V7dB0v8dFx8E4hc/ETx2MYRkf8D1du86Ni8QFnXOoCpxmOFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739008522; c=relaxed/simple;
	bh=LmaXLKl6381qdSKt3nz66EIX5xEP0b6LkGPJzhL/7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTDuLtWHJ1Pg6qAkUbcyh/fVTjm4KtH9gRah0IrCzvorAPL7sGfcEOfcPqkD0yuUhkJmz2V+/ArBY/ECsntwWHHbo20lqNv/3dRDhY0nyZ5TGZRr1lWINxOXSMpzVq2CWJAHy11sYScnQyNdAj3wDsEVhLe5oc7lzfaANM0VHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SAQT4A7+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6z2YuJvuFYLB1q3qrklBHPoovjtO0uF04fHOBairAc8=; b=SAQT4A7+Yf2xm56Y7XL9ySSHBb
	W5q8Ek+Po1V7nlNjnPQgQZBqildLpjUNFrF+75RYTQ7QF/ea++oIeEHlfGKphNOO6r3fKUqgVUlQQ
	sU6+mQnrvQaMsdCEH+NH5OoXM9vW0KqyUMZ4AGs+IGobVB3F5x1uhLlj6woKrPDTMSIGjjvIL314M
	NYlB4UrB9mZt5xYGSKAyT8sefDzEaM18xc5sv/7yuy9K/25IOd28RVF0XdlV08Qrm1jyI/o1vXmrY
	+RfoOLyafUkYZUSj5OwRt3uc6CYoXYca4EDVvASn942f9DUA6htoqdsmv8ox2YuTNHuKJTGkLz0lE
	UVlVIjMA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47998)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tghYK-0000JR-2D;
	Sat, 08 Feb 2025 09:55:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tghYH-0005NI-2t;
	Sat, 08 Feb 2025 09:55:05 +0000
Date: Sat, 8 Feb 2025 09:55:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mediatek: add ethtool EEE
 callbacks
Message-ID: <Z6cp-TCckCNReUPd@shell.armlinux.org.uk>
References: <20250208092732.3136629-1-dqfext@gmail.com>
 <Z6ckCZpOo1_rvmh6@shell.armlinux.org.uk>
 <CALW65jYG3vv9aCY_HDU4Wyij1kqfiOVOsZ3YnvioUf4AgSbnaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jYG3vv9aCY_HDU4Wyij1kqfiOVOsZ3YnvioUf4AgSbnaw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Feb 08, 2025 at 05:48:46PM +0800, Qingfang Deng wrote:
> On Sat, Feb 8, 2025 at 5:29 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Sat, Feb 08, 2025 at 05:27:32PM +0800, Qingfang Deng wrote:
> > > Allow users to adjust the EEE settings of an attached PHY.
> >
> > Why do you need to do this? Does the MAC support EEE?
> 
> Yes, the MAC supports EEE.

Doesn't it need a bit more code to configure the MAC?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

