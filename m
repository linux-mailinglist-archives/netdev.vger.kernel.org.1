Return-Path: <netdev+bounces-187837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC516AA9D0F
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078BF3A6CD3
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9092E1AF0C7;
	Mon,  5 May 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZoQNGLs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FD1862;
	Mon,  5 May 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746476173; cv=none; b=XlW1EHqpbNzkkUE5Zfu8GA0zp0+FxrVbvd+ZfhtDzuAtXgmNDcpIPxg0Ny05R+TBrEhJ1Xs9JzNMAZy7kKqrsYNTDYzicq+DYoCGnYfTWZEWLzwsk46+RM8llANIuRvryo/cVvvVeiNBJb/uAhUSBYICjXm8HAAPTcfTps51Zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746476173; c=relaxed/simple;
	bh=349bf66eeGny6rwMfg6X1fE0CZMMIkpNGVwbI75oRZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxzncp9R6JA8rquhBdX55BkFduYlqzIKkhz9tPFVrpmzygP73/WqmEPcRsGsjghMVSPFlm6jCMpYxRH7ye2wquvC/QLiqRxw0TS7PAMBfMVS9uO0/p6IYVO9negbANuWdq9hVCZs3FzkFXBtZz35KsnIyzY+8ycyd/ztaYafnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZoQNGLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB09C4CEE4;
	Mon,  5 May 2025 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746476172;
	bh=349bf66eeGny6rwMfg6X1fE0CZMMIkpNGVwbI75oRZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QZoQNGLsK0ooAHqLgBDKlX+R9oisnbhXSEsZ1oYjUlST9fwXGW8F1oZLlKUY3JwnT
	 kg3g6lHfCJ+42ocGBRjPOyc7cqrpDEyoRkKZsFCkgQnZZ45jf26knamqgC2XUrf++D
	 x0qvo/aL5HpPlE4bJ0mhBdrL3FspH/U7o8Ki1tDERBCDJESoeBrJHniWytA7UBv0iv
	 TPbIom3KLa4EnUAd1D8PIs+puObJif3OSr+qtp4+9v3bIdZZnjcn/YQFQVoqUrKKhU
	 jVlb98MzKteV5zBKz1X2TYFApyxJ2oGPjZhJljLcxdJX+ZZ8mEUQtufWaxPycyorOe
	 aIhQ/XqCEy6Qg==
Date: Mon, 5 May 2025 13:16:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v10 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250505131611.0c779894@kernel.org>
In-Reply-To: <20250504082811.4893afaa@wsk>
References: <20250502074447.2153837-1-lukma@denx.de>
	<20250502074447.2153837-5-lukma@denx.de>
	<20250502071328.069d0933@kernel.org>
	<20250504082811.4893afaa@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 May 2025 08:28:11 +0200 Lukasz Majewski wrote:
> > Now that basic build is green the series has advanced to full testing,
> > where coccicheck says:
> > 
> > drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1961:1-6: WARNING:
> > invalid free of devm_ allocated data
> > drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c:1237:16-19: ERROR:
> > bus is NULL but dereferenced.  
> 
> I'm sorry for not checking the code with coccinelle.
> 
> I do have already used sparse and checkpatch.

No worries. Not testing a build W=1 is a bit of a faux pas.
But coccinelle is finicky and slow.

