Return-Path: <netdev+bounces-202125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3AAEC5B1
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 09:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261E96E0883
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80721FF4E;
	Sat, 28 Jun 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uiBx9dcy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB71F872D;
	Sat, 28 Jun 2025 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751096743; cv=none; b=FrZK+VzkmrCA3AgtrLF24BqzKOSHVYrSJCBrFZohSNqBQxNkJM45+BT2GylK2C+802Z4LAV30qX/b00andm/nrRgdokEuhXU72Ej2/Rb2E7yKTbCqjGUSalZUYUFTQdBr1aRZpXVD77Wyee9tWeaDq0Fs4abVtEnF24j+yWtdmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751096743; c=relaxed/simple;
	bh=rCDrOeCCwBI+w/6/VRrZVFMx8Jqtg90Wft1m2q0jQHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv/TNZyF3/szWgSBYZQ/ejVkwLOBCYnVscvY4YQj30QTmlrBcH+Mfvv3ulMNPA/eJwRyncDEsmRfTuHwXZSIdRv7LJp6W0l14i0MPmjbklAl6Nwjy9OvCSY53E/mFjitX0/aPGm4dG2y4qWjK0iMwyki5uRp7smlBfrr5o0UXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uiBx9dcy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5en0Kaj+kw2e4lzOEeWUYL1+XRABVcsrt5UjiXRZbPk=; b=uiBx9dcysLAijZ6nr9fHen0bEE
	zfOltBKotGihTWnKUTVBerCU1Sz99PVIEky+erLecvYEPiPSd/mCQu9pixz+7kdXU3VTChLRDdf9o
	iw8NR2TPfI1O8x0IbKiBA4Ljjmq60EpxRN/5bQpY9LCOK3R2NWb5Ypc0DGcFDUe88Oxo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVQFc-00HDno-FP; Sat, 28 Jun 2025 09:45:28 +0200
Date: Sat, 28 Jun 2025 09:45:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
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
Subject: Re: [PATCH net/next 2/3] net: ethernet: mtk_eth_soc: fix kernel-doc
 comment
Message-ID: <bf7f8685-f51b-4b92-916d-96c1fa16fce7@lunn.ch>
References: <cover.1751072868.git.daniel@makrotopia.org>
 <00249671d424622e780f0dcafe6924f634b632ce.1751072868.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00249671d424622e780f0dcafe6924f634b632ce.1751072868.git.daniel@makrotopia.org>

On Sat, Jun 28, 2025 at 02:30:31AM +0100, Daniel Golle wrote:
> Fix and add some missing field descriptions to kernel-doc comment of
> struct mtk_eth.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

