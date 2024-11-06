Return-Path: <netdev+bounces-142267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D299BE177
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D69282596
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9D1D63C2;
	Wed,  6 Nov 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NYBVGt3D"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971481922E8;
	Wed,  6 Nov 2024 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883617; cv=none; b=pNjX+Ojw+Kocsrep1IN1mPpH3TidcBokdcMYIcspbIan7kROMP6tLjynF5M4k3+PBkVgK4V8lk68IulhWfb/IcY6G9s4IaAffXMw4GOnJWoMrEPwq2sCVuoAZpAspz8e0p6hjcYBUXwmyB6kmX0o2ZeLFWdGIhM3Z9Q/i8QcbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883617; c=relaxed/simple;
	bh=MhDwj/aXGaw/VuEMXxyLuA0n3yQNHogT4PFr1hcAfc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKvxephaU2XVhti91TOdGFiZq2xaadY+qHEsqLsSL6IvlX83Q+D2iJt4lLUXwtknHPk98P2DOE/a4ZZOg76xoDtZREGhGhHOXaeh43ZndtzrMvlrLgBf5R3t/0p6vbtJEKMqBy4UCVOTrn+7yTqbNAVmXofDZNLZvYbLIG3wouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NYBVGt3D; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE518FF813;
	Wed,  6 Nov 2024 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wggt6wmbTUXS4x4tV46Izk+39B3cnS2JlZr7SjlMcMc=;
	b=NYBVGt3DiBgndrXBPVl9Dcp0UOdXQJi5EvQ7PonofETdX7a6LslGUKmGWg+JmEXFg6J1pD
	FyR/lcVrtOyxtFwamRmxUJPyyXfEYmdmwAfbKnh7KsDC1h0/7yLzOOjj2gpMp95dhRwz/y
	U00g0SRdXOhgEJZq0rGu8T3aXByEJhDW4hW+nXBF++jjIDN1ts8qCm53sryCTfxOQX8Yq2
	dKuII9OUOqM0Vzu43RL7eym79sijjZAbCZPdwdHf4gJ5f/K/SxfiWEdk9cHrJbVbD47voo
	Bwd3eAwpnG8PM+1m1aaL299H0EEnmxVWwlHcJWN8H4iRMAF+3tiDYbYvwJhVow==
Date: Wed, 6 Nov 2024 10:00:04 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/9] Support external snapshots on dwmac1000
Message-ID: <20241106100004.50ff4bb2@fedora.home>
In-Reply-To: <20241105182050.2839f1e7@kernel.org>
References: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
	<20241105182050.2839f1e7@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 5 Nov 2024 18:20:50 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon,  4 Nov 2024 18:02:40 +0100 Maxime Chevallier wrote:
> >   net: stmmac: Only update the auto-discovered PTP clock features  
> 
> Minor conflict in the context on this one, please respin.

Sure thing, I'll respin right away.

Thanks,

Maxime

