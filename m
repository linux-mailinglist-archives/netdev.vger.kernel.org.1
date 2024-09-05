Return-Path: <netdev+bounces-125699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E796E46B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE6CB22F67
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5145A199243;
	Thu,  5 Sep 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dd0dE9pi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FEC17AE11;
	Thu,  5 Sep 2024 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569469; cv=none; b=lHtch2PbLGo0Gj6/VOs+o7Be7C0/sp8jG92+ruvmpGncGNe/CkYve9xTlmmA6ZhwocPkStZSFo9Juuog5GpaQS5o6AzcPgEAO2EEVWuPkpGWGaM3x2qDEfKNEH1uhWs343yb2n34KPRvP/ZJVtHR227hLI+FVLQs/dNYpLY99vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569469; c=relaxed/simple;
	bh=VOW05Vl5JEe7fwWOagDfElyq8L+Ek9twBYYTGynJd8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz2vHAc+93SJA89LUO4fJip01xzJ+UtLPRLFHeOKVht75AKoqDvm0RhPlNQOuNwC/4fu1maTm64w4aRoLCuZrc1vMvCm4uRpqhVL7i4m1Sn/AYtggnBdr0nc3qrZzgnzkXHzGrP1GjY1aKUNZESJ9aC0TgEElaVQWQ79M1p9+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dd0dE9pi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/goCWVg+MCOji3COG+3eKFkYCBowiZkWLDEBJuoqQog=; b=Dd0dE9piIxFcGIiRJYjQEsGgjz
	fHqfGIKupphjFXlqpmolxnNCNWf1tPZN0TUNa4AUgU40yXGcO81JecAhHpcYzcxXYs22tMIlqWn7o
	M1l/GTo4DENuQC84QtHtGjM2cu033T6zfo8BJCodsEuzS5j0aMDwtCyqpUM7mNE1yhVc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJRO-006iii-KI; Thu, 05 Sep 2024 22:50:54 +0200
Date: Thu, 5 Sep 2024 22:50:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ftgmac100: Enable TX interrupt to avoid TX timeout
Message-ID: <80f1cd36-c806-4e09-9eac-a70891f50323@lunn.ch>
References: <20240904103116.4022152-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904103116.4022152-1-jacky_chou@aspeedtech.com>

On Wed, Sep 04, 2024 at 06:31:16PM +0800, Jacky Chou wrote:
> Currently, the driver only enables RX interrupt to handle RX
> packets and TX resources. Sometimes there is not RX traffic,
> so the TX resource needs to wait for RX interrupt to free.
> This situation will toggle the TX timeout watchdog when the MAC
> TX ring has no more resources to transmit packets.
> Therefore, enable TX interrupt to release TX resources at any time.

This looks reasonable. FTGMAC100_INT_ALL is used when NAPI polling is
not being used, so the extra interrupts should not cause additional
load.

Is this a fix? How easy is it to trigger the issue?

   Andrew

