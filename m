Return-Path: <netdev+bounces-119206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20600954BC8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93C61F20CFE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AFB1C7B93;
	Fri, 16 Aug 2024 14:00:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E31C7B6A
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816836; cv=none; b=VyzyLvCMMKRgFEOybNr5emRfvxUY0sr6IFr45sUJu4GJa9D44TS1Rzs+TYwxLvDyVFpTm22oENEFl8HKri+tb4qu1yQ9OU2/ayEQUn5j9E47nELOrV8UGWaS6uveS1Inz7r02npgxisHCxaCUfMLkglukKB5d6Rx5qjMvTxa9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816836; c=relaxed/simple;
	bh=B2Q56HcNvOwAj4yHGR6co+HRtqtoSxh8NLyaHruwZqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3w9WJsM7XXRVWcfQqvU8fb+lg404IblxE5M7xdfkh3nfdC3TQn8IT91heRKT9AXdS8VzMGSDkeQz0Jos3EnUMYU+WUMHySDueu86M71ofPcc9FyFkw4zLbCsPCOfzyNfgi/w2TLeU2hRSo/uyin4WMSlX0nsHbxmzBgtvdaeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sexV7-0000Gb-Lu; Fri, 16 Aug 2024 16:00:21 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sexV6-000qmc-CH; Fri, 16 Aug 2024 16:00:20 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sexV6-006J54-0r;
	Fri, 16 Aug 2024 16:00:20 +0200
Date: Fri, 16 Aug 2024 16:00:20 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] phy: dp83td510: Utilize ALCD for cable
 length measurement when link is active
Message-ID: <Zr9bdJEG3sEdC6BI@pengutronix.de>
References: <20240816105155.1850795-1-o.rempel@pengutronix.de>
 <f026cabc-76d3-474c-90a1-47c355a7d673@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f026cabc-76d3-474c-90a1-47c355a7d673@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Aug 16, 2024 at 03:10:35PM +0200, Andrew Lunn wrote:
> > The DP83TD510 PHY provides an alternative through ALCD (Active Link
> > Cable Diagnostics), which allows for cable length measurement without
> > disrupting an active link. Since a live link indicates no short or open
> > cable states, ALCD can be used effectively to gather cable length
> > information.
> 
> Is this specific to TI?

It seems to be, yes. I assume they are using echo cancellation values or
some thing like this.

> Did you compare ALCD to TDR length measurement? Are they about the
> same?

Default ALCD values are about 20meters off. Which seems to be ok for
1000meter cable. TI describes calibration procedure for ALCD to provide
better measurements, but so far it was good enough. The problem with
this calibration is: it seems to be different for different cables, so
it make no sense to integrate it in kernel.

> I'm just thinking about if we want to include an additional
> attribute in ethnl_cable_test_fault_length() to indicate how the
> measurement was performed.

Sounds good. In this case user space will be able to know how to correct
this values.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

