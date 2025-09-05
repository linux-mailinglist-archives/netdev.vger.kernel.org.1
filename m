Return-Path: <netdev+bounces-220188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46521B44B53
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 03:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC73C1BC3517
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 01:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B834D187332;
	Fri,  5 Sep 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfe/GuOp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEC20EB;
	Fri,  5 Sep 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757036880; cv=none; b=RAdDcq1d4izBWM+b6OKndrTIle9wFlzFEb/CIMMHahtub7uHcUpcrPpbhBlEwwvtoydImxfEhYDFrfL50whZku3J2kX1QDmiRAYc3Y+m4Su85N93UaKi8p8xLnigkFUZpkt3ve28iM+O+/VDahVbWcilEjpH3Vin/v21iAG2ml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757036880; c=relaxed/simple;
	bh=nKN62gC4jkdDbMIOofqf7YTZbhCZ14cobe9mIKWrKv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFaA7/7FR7zmxUmPhnfPedEPy6ASru0wT8M/Xmdc7toBeFjf/CZFJq7twn1v7NQMDSakqhaswhvDTEXvHut2fVoevBed+1sky4DuT1vvs/uT5/o8c3ut2rbqzGZFJX26d3Nbj+K7orqIAxa4oLU73lRXGURtzh2zeGZsAMdRzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfe/GuOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B47C4CEF0;
	Fri,  5 Sep 2025 01:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757036879;
	bh=nKN62gC4jkdDbMIOofqf7YTZbhCZ14cobe9mIKWrKv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rfe/GuOpH8cuEJ12EXJjZnxs8Ao00R7lbvEgT0XnlAnjTPGcgGRTfCzYXpMwmE4re
	 JB1amUpWAPGJivhw+cKL6KuPsBTsuQbOX6PahAv8pplZuRsz/Ni6QerYmSW2QqVxTX
	 axOLcpsJsjs67pNZM8kmc7tn53I4bzAhMfSw04Pdx7w5YvtcAK33nmRv7ZvCPZBJ5m
	 LP9b0MfjoYzQwVKLI9hO+oSZ/zcJQTflFQ3sQaLFUh+0e/9roVzeGIx5lWoMueii7p
	 Hlr39DthJTA1kcp1gG4iaESqFyHc+AlGSQP880GSonx5SeeN2cvGKj08nQzQ3xrESI
	 Mcgm106muHXOA==
Date: Thu, 4 Sep 2025 18:47:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrea della Porta <andrea.porta@suse.com>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Phil Elwell <phil@raspberrypi.com>, Jonathan
 Bell <jonathan@raspberrypi.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 0/5] dd ethernet support for RPi5
Message-ID: <20250904184757.1f7fb839@kernel.org>
In-Reply-To: <06017779-f03b-4006-8902-f0eb66a1b1a1@broadcom.com>
References: <20250822093440.53941-1-svarbanov@suse.de>
	<06017779-f03b-4006-8902-f0eb66a1b1a1@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 14:07:36 -0700 Florian Fainelli wrote:
> On 8/22/25 02:34, Stanimir Varbanov wrote:
> > Hello,
> > 
> > Changes in v2:
> >   - In 1/5 updates according to review comments (Nicolas)
> >   - In 1/5 added Fixes tag (Nicolas)
> >   - Added Reviewed-by and Acked-by tags.
> > 
> > v1 can found at [1].
> > 
> > Comments are welcome!  
> 
> netdev maintainers, I took patches 4 and 5 through the Broadcom ARM SoC 
> tree, please take patches 1 through 3 inclusive, or let me know if I 
> should take patch 2 as well.

Thanks for the heads up! Let me take patch 3 right now.
I'm a bit unclear on where we landed with the parallel efforts to add
the >32b address support :(

