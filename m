Return-Path: <netdev+bounces-96086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5768C444A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9241C2317A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A3154431;
	Mon, 13 May 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg9r/kC5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63414F103;
	Mon, 13 May 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614347; cv=none; b=ftL/cjnCBShE1WfTkukapAAp5PniLMBR39Gj3pVfhX/nmgn2r3+I9X0VzavestHzN4NcfLJLABMei5amrQA1pmyf7VmnrTWMT1F5QwPuhA7E8qmBvyoEDpU1pTpgaf+o7afmhIPcMyaJWy/5/PmcUWtFciQqqufJpy1LEkiwa4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614347; c=relaxed/simple;
	bh=jar4ZIkYznevo+scBPt1nRHEl+qcfb0bftbjz3Sb1yA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdKPBpMVMlhgyHzsZdDSvtBHBBGTa2kN0RgF8Dek1B8pkkXLTS9KEBP7l+I878yw4D79OwMK7+RXQw9nF0ar4N3GyVjrh4Vq8kQIHhrFbjYLVQcSdHJky3DipuH55xN5dJW/FGxGyRc74ROKlXgUipiEPJ9y7DhQfewT7DdQd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg9r/kC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C2FC2BD11;
	Mon, 13 May 2024 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715614346;
	bh=jar4ZIkYznevo+scBPt1nRHEl+qcfb0bftbjz3Sb1yA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tg9r/kC5256VEq85o6scWYVAGk1eQYr+jXLK2h0AYpcj1LmRJ2SE1CwIuOU/Z5mMM
	 8aM2jP9brEUJ4/2pYsbgYTeWmM3GL8QDRln8Y7B6O2VZqP47rOey3zz3lnN6yG+WRm
	 1PqJV5w8RAcc8xvdIyGPK6vEVON+ol+0OprF5a+6MkuMRlF3E2nOb6A0pwtGx2ZwmM
	 bkUX2JEfRuHTkcM3+AU4hTLVkNxSX6FjJsB6G2QZXaMC7r5DTusWdR1+UDDhCv/D+x
	 lcB3Ooxou2JY2kA6NnyizV4Fxig4Zrbtw7gPpQfMOrsGVmPl1sBQ7H2wPzhaXRXaRf
	 tKRD/7OMhrq7w==
Date: Mon, 13 May 2024 08:32:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mor Nagli
 <mor.nagli@solid-run.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Message-ID: <20240513083225.1043f59e@kernel.org>
In-Reply-To: <c30a0242-9c68-4930-a752-80fb4ad499d9@solid-run.com>
References: <20240505-mv88e6xxx-truncate-busid-v3-1-e70d6ec2f3db@solid-run.com>
	<A40C71BD-A733-43D2-A563-FEB1322ECB5C@gmail.com>
	<c30a0242-9c68-4930-a752-80fb4ad499d9@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 12:03:31 +0000 Josua Mayer wrote:
> > The idea and implementation is reasonable but this could affect other drivers than mv88e6xxx, why not move that logic to mdiobus_register() and tracking the truncation index globally within the MDIO bus layer?  
> Conceptually I agree, it would be nice to have a centralized
> solution to this problem, it probably can occur in multiple places.
> 
> My reasoning is that solving the problem within a single driver
> is a much smaller task, especially for sporadic contributors
> who lack a deep understanding for how all layers interact.
> 
> Perhaps agreeing on a good solution within this driver
> can inform a more general solution to be added later.

I agree with Florian, FWIW. The choice of how to truncate is a bit
arbitrary, if core does it at least it will be consistent.

