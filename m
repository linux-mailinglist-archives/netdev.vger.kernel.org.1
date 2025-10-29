Return-Path: <netdev+bounces-233722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6BCC1783A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F11205051EB
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF0230BCB;
	Wed, 29 Oct 2025 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohPHCvG0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099E22126C;
	Wed, 29 Oct 2025 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697142; cv=none; b=cLa1YKtxKDTPxxVFfik0TJkiHD+moH+0d6p+yRk98Vv8T4uVj5ch+Rtspd32vnghe42o5dT2cTO3+rUftOylToWfQQ0XmpNtOuBYRyb0SgX0DcIaQgUPXUtuhLtCBxKWtAhOaBbWgNBoarJ1LfBALmcqOHNIUTcWLklh+iEbieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697142; c=relaxed/simple;
	bh=ujGzzSLZ9fPuiQOeQOzkkm0n9rELeoo+/MNLK3bPcMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEnbWWOq5Nu/pHzAIT1tQxtwp669nea68eO1vHSNGNOU8NSshloRvnb9FiXV/MfDgZaI3bbi5+C3M8rDjcHsnzJV4Ep+bqu2cnPO3RFavd5VSVBFmMeyumkyHjfpvCbIqHcj3Gc0HVlW99bt2xrl4dZpo0+p467lIeljM3kuflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohPHCvG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5FDC4CEE7;
	Wed, 29 Oct 2025 00:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761697141;
	bh=ujGzzSLZ9fPuiQOeQOzkkm0n9rELeoo+/MNLK3bPcMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohPHCvG0JrE/mc51mrTNg7QOcwJs0oMbOLsKxA3ct19i9iunF0VtCERMo7Zm+ExKU
	 fsjcvCCGVg339pBNTyo6wJZ0XSzEvuKb2pvJXwjty4gRZITsGGUATPrut/nZlY5hY/
	 hzFicSLVugtwm0weEBiBzcCKJpUEIODyfi7HEgyAMlZv38uCcpDzBa+OYxRslOzovB
	 1KWkHT1rzSUu4DdMUJrV4d7sjEEjFWHV5ySVigOX67bXUH+LyZoNWQpKCN7uh/yZj5
	 KOnuTfVkFnIBxU1ln9Uk2EJeuz56ojCp9b37Z0oIp3TkOeYOUa5bM+PYKhvYq/o9js
	 7aYsxrmeg6+Kw==
Date: Tue, 28 Oct 2025 17:19:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Message-ID: <20251028171900.5f0ba82c@kernel.org>
In-Reply-To: <PAXPR04MB8510AC62551ABD89E75EB97188FAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
	<20251028165757.3b7c2f96@kernel.org>
	<PAXPR04MB8510AC62551ABD89E75EB97188FAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 00:13:14 +0000 Wei Fang wrote:
> > On Mon, 27 Oct 2025 09:44:57 +0800 Wei Fang wrote:  
> > > i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
> > > can be used as a standalone network port. The other one is an internal
> > > ENETC, it connects to the CPU port of NETC switch through the pseudo
> > > MAC. Also, i.MX94 have multiple PTP Timers, which is different from
> > > i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
> > > the IERB ETBCR registers. Currently, this patch only add ENETC support
> > > and Timer support for i.MX94. The switch will be added by a separate
> > > patch set.  
> > 
> > Is there a reason to add the imx94 code after imx95?  
> 
> Actually, i.MX94 is the latest i.MX SoC, which is tapped out after
> i.MX95 (about 1 year).

I see, so there is some logic behind it.

I'm not sure this will still be clear 10 years from now to the people
who come after us. 1 year is not a long time. But up to you..

