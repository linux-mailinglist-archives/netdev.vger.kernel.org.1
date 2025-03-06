Return-Path: <netdev+bounces-172285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B868A540D4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C478916AA47
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736518FDB2;
	Thu,  6 Mar 2025 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP1HEeN2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA018DB13;
	Thu,  6 Mar 2025 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229271; cv=none; b=t098f8CQCh1mTlwNw4H7gW7ElrKkhYntZ6iXJYRUPUQ71FIWYX6z04G5/dYzdzdSpVuKr+RgMLKzX0eB5azIQpzhkuNNCpSH0BvEdwa7Fd0P1nDwJaEWbiJJ+SgzJrM7C5gcTFhiO+i4iy88Br5IOinD2f+0R2kxoMlSKHeFgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229271; c=relaxed/simple;
	bh=xKLvEuTiVxI8xYqmlOoOvu1y3DL0CNtKqe5Ki+KcoZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTMH90pay0ixTeaQzYcm2c6++netCvaeW3IPWvbGtQRA4DGPKimTFOi8mitWdJ2TkTj/0vgZhEhD8PGLsgSU1KJE+2ysZN1KUvw7vdaACynBNcc4+E6/NTj4/WtHZkEYtBig/AflHSNPEufyZ2SOjboNCZDDS7ptIRfH6fKEpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP1HEeN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F7EC4CED1;
	Thu,  6 Mar 2025 02:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741229271;
	bh=xKLvEuTiVxI8xYqmlOoOvu1y3DL0CNtKqe5Ki+KcoZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oP1HEeN29Mtk/lLYprOLObdtx7M0mbOaMpc7d4RzXBSReiw8+G9lSYSQVdgEnf567
	 6jOFoc4j3gffEyqnl5A9xNd8FlkXDAaDHPFW9bry9lsjBPcE3IS9yRw0bDFKMNuV5z
	 xpEJnwLYIPM5jVxy2NyP7KG8+ano/bB3ILbXf7p+0P7NwGbBo0VTbAwXyweqyzXX/2
	 VTlXl1s/jAXRjgj/50xW7FQzng2IQBygy93KNRATuW3swTyTLHdwdhIv+n5lmCn4LO
	 lSqRoFJxT3PveOZTirJpvdV9k4A9iilpkFqCFLHNNLswkT0E/sX2Hb2fwUgTRs2SvN
	 ZFkdrBXrirQ8A==
Date: Wed, 5 Mar 2025 18:47:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next 0/7] net: ethtool: Introduce ethnl dump helpers
Message-ID: <20250305184749.5519e7a9@kernel.org>
In-Reply-To: <20250305180252.5a0ceb86@fedora.home>
References: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
	<20250305180252.5a0ceb86@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 18:02:52 +0100 Maxime Chevallier wrote:
> This series will very likely conflict with Stanislav's netdev lock
> work [2], I'll of course be happy to rebase should it get merged :)

Also this doesn't build. Please hold off on reposting for a couple of
days - because of the large conflict radius the previous few revisions
of the locking series haven't even gotten into the selftest CI queue :(

