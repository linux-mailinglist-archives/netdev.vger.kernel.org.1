Return-Path: <netdev+bounces-152454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E259F4009
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F57166B5E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EEBF9FE;
	Tue, 17 Dec 2024 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCP71Z9n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C082379CD;
	Tue, 17 Dec 2024 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734399214; cv=none; b=bgEtpeQZ4RfXmjkXyG7hyzCtlp1cXblmGoz2z1EnevGF8wqc7iaGffr5UBg8lmRd8+jrEaPOu+J8mFGgswLUtPxtrRhefbjlAYMELhYFQRS3hxkkAwnKF5xc6zXWvH24zzm3PbdpBL1+T8QeUI6URa3FLP+0R+LM2S1k8PrOuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734399214; c=relaxed/simple;
	bh=jQx59o3wR/vFzoPfSo4zsecm2GePz+OK8mpQNupeUek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wpv8BLoZYAz8ojMri/tT2Uke2tcIOygKrzp26WMWoh/UhzFuLiWYklkyZy8F0ZfXZWscFekTPxLUzMIhGvj/bAJ4TVFB4A9DoxvQbvR/6YFEQ1zJ2LM8EVBYRLz98J/4ztQoVqNmZlmQWI9gMFi+L12drHvFVmUh3Zsii9ZucdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCP71Z9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB17BC4CED0;
	Tue, 17 Dec 2024 01:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734399214;
	bh=jQx59o3wR/vFzoPfSo4zsecm2GePz+OK8mpQNupeUek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gCP71Z9nQNwt3IAPUQAkOKGdvWzMoRegQfY4Q2lItX3gZwmaSSQwC0+fbg3frju1S
	 uty3sd2bWabuzWOiFoLSvfex6vwv1+Tes8g7HDi7Ye1WqIFyKQZdYsQPQ/ktnQoSn3
	 MGw9zq6CdwIlxVFo4tcgRm2BKNqkFq/hhy6aO8r11h0/PF09mfxySUTJvlxhst1XIV
	 c6jQWxs00GjjCy/5jqfxmwc8zYxzG+Hrwi9GYwl7s5ZP+Iwh/gFLoHaS3+OG/arcR+
	 bZv+bOnwlsDQd4YYIx/JFQtKGyhGzszyxexsbIfjy7XSIqsjCJiJ7tbEIVPkelYwIo
	 1PF5qPnajJM/A==
Date: Mon, 16 Dec 2024 17:33:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-socfpga: Set interface
 modes from Lynx PCS as supported
Message-ID: <20241216173333.55e35f34@kernel.org>
In-Reply-To: <20241216094224.199e8df7@fedora.home>
References: <20241213090526.71516-1-maxime.chevallier@bootlin.com>
	<20241213090526.71516-3-maxime.chevallier@bootlin.com>
	<Z1wnFXlgEU84VX8F@shell.armlinux.org.uk>
	<20241213182904.55eb2504@fedora.home>
	<Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<20241216094224.199e8df7@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 09:42:24 +0100 Maxime Chevallier wrote:
> > I've actually already created that series!  
> 
> Woaw that was fast ! I'll review and give it a test on my setup then.
> 
> Maybe one thing to clarify with the net maintainers is that this work
> you've done doesn't replace the series this thread is replying to,
> which still makes sense (we need the
> stmmac_priv->phylink_config.supported_interfaces to be correctly
> populated on socfpga).

Ah, sorry. Should have asked. 

I assumed since Lynx PCS will have the SGMII and 1000BASEX set -
Russell's patch 5 will copy them for you to
priv->phylink_config.supported_interfaces. Your patch 1 is still needed.
Did I get it wrong?

