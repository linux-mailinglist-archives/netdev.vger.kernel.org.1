Return-Path: <netdev+bounces-220976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0F5B49B16
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 22:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262EF16FD86
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C22C327D;
	Mon,  8 Sep 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgE3b7kS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EF21ADAE;
	Mon,  8 Sep 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363422; cv=none; b=A+611OS7QQKKLThEgsMeRXqmbFVuHouDRSjjTqDT5skCdTLBhlPiKr3OW7yDbnP/+/qgv/kaVNTC4Nr1DoD/rz2X/c7rnF1rvOiKwwHqPdcOLquP1vnob+pUhqeu7GRXdgmyi+eDe4ARHbvzvYV2A37u+uJjHEP6m+Ncj1areWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363422; c=relaxed/simple;
	bh=BksOrPE+ZRN/9iJRIdByF0w7vBNmdK0mrOFP3MyN0AE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dG/vwoDJ0fTDZh8cFuoIAw5uk0DAgYvF9HU/bMqp59QoSPZku5DdmjCCj2nlrKg7+KJAqONvqiDGMj7bKBoksz8kI23RNkn3xQVhyly0CzaOh0SvKOHukPPtkaMf1oG9sc0mfRdcNQtIsmDOr//jw5S+87ybyEtAVCj35Gr+M28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgE3b7kS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E66EC4CEF1;
	Mon,  8 Sep 2025 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757363422;
	bh=BksOrPE+ZRN/9iJRIdByF0w7vBNmdK0mrOFP3MyN0AE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bgE3b7kSXL9vq7+O9vCSmc8iAqUZN0ejxhiiawV+mtPM5vBd9FJXFRZGXgYgdZWCs
	 V/Qq8/53NilKwUG9sT5mFMhz5pJZPDtAgaAh+w12kYOAw0xifOS+FU+UlnaywKUxWl
	 X6X0pTwR/dMXgNa1EaA6cvb3iSn6qBz1meYvBXbK9mq5rTB5FYPxJj2Jc0mRvAEO6H
	 DWYLVphN4mbkRs9EwtJdREFGC/uxc37agFEXN2U3zc4v8U96ptK6E28B2XIg4lA7Uq
	 lIpdKFKD4FUAJ0qWJ2QNLRM79qPIB0hvhM5q7CQXokgUs+sgFHFPclJEDuZZrwPHLw
	 GzcWwXoDwy+7g==
Date: Mon, 8 Sep 2025 13:30:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>,
 andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>,
 edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, robh
 <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, conor+dt
 <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, richardcochran
 <richardcochran@gmail.com>, m-malladi <m-malladi@ti.com>, s hauer
 <s.hauer@pengutronix.de>, afd <afd@ti.com>, michal swiatkowski
 <michal.swiatkowski@linux.intel.com>, jacob e keller
 <jacob.e.keller@intel.com>, horms <horms@kernel.org>, johan
 <johan@kernel.org>, ALOK TIWARI <alok.a.tiwari@oracle.com>, m-karicheri2
 <m-karicheri2@ti.com>, s-anna <s-anna@ti.com>, glaroque
 <glaroque@baylibre.com>, saikrishnag <saikrishnag@marvell.com>, kory
 maincent <kory.maincent@bootlin.com>, diogo ivo <diogo.ivo@siemens.com>,
 javier carrasco cruz <javier.carrasco.cruz@gmail.com>, basharath
 <basharath@couthit.com>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, netdev <netdev@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Bastien Curutchet
 <bastien.curutchet@bootlin.com>, pratheesh <pratheesh@ti.com>, Prajith
 Jayarajan <prajith@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, praneeth
 <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>, krishna
 <krishna@couthit.com>, pmohan <pmohan@couthit.com>, mohan
 <mohan@couthit.com>
Subject: Re: [PATCH net-next v15 0/5] PRU-ICSSM Ethernet Driver
Message-ID: <20250908133019.44602174@kernel.org>
In-Reply-To: <974157264.314549.1757343020136.JavaMail.zimbra@couthit.local>
References: <20250904101729.693330-1-parvathi@couthit.com>
	<20250905183151.6a0d832a@kernel.org>
	<974157264.314549.1757343020136.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 20:20:20 +0530 (IST) Parvathi Pudi wrote:
> > On Thu,  4 Sep 2025 15:45:37 +0530 Parvathi Pudi wrote:  
> >> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
> >> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
> >> Megabit ICSS (ICSSM).  
> > 
> > Looks like the new code is not covered by the existing MAINTAINERS
> > entries. Who is expected to be maintaining the new driver?
> > Please consult:
> > https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html  
> 
> We will update the MAINTAINERS information in a separate patch to
> this series and share the next version soon.

I wasn't asking if you can update the MAINTAINERS, I was asking what
you will update it with. Since that's still not clear I'm dropping
the series from pw, please repost with the MAINTAINERS entry included.

