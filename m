Return-Path: <netdev+bounces-46261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C835E7E2EE9
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 22:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF68F1C20506
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC22E645;
	Mon,  6 Nov 2023 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qvs1S35Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F502D03C
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 21:26:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F5B0;
	Mon,  6 Nov 2023 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pIAOwf/5q3SfU3vvLSflXBextpLYy07/rCzwWA9WiAA=; b=qvs1S35QXNK7Bmzn9DNlyhlA9S
	FLijoCl7tG9qguDKkeSI463d1pYF4yh7JD2gisqQvLO69t2Ais5tame0D9q6Yq4zDuU+x5vf7EkUN
	4PWwCNWDMG3TP4Rt3ODj1k81mWkq6Tj3nDWHNT2jTBV4Wa2HdJzecp/KeYy8Jqxo8vxQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r077C-0010bz-A2; Mon, 06 Nov 2023 22:26:34 +0100
Date: Mon, 6 Nov 2023 22:26:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: initialize carrier state at creation
Message-ID: <52114397-62cf-4112-9d5b-73098f25fe20@lunn.ch>
References: <20231106180506.2665-1-klaus.kudielka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106180506.2665-1-klaus.kudielka@gmail.com>

On Mon, Nov 06, 2023 at 07:05:06PM +0100, Klaus Kudielka wrote:
> Background: Turris Omnia (Armada 385); eth2 (mvneta) connected to SFP bus;
> SFP module is present, but no fiber connected, so definitely no carrier.
> 
> After booting, eth2 is down, but netdev LED trigger surprisingly reports
> link active. Then, after "ip link set eth2 up", the link indicator goes
> away - as I would have expected it from the beginning.
> 
> It turns out, that the default carrier state after netdev creation is
> "carrier ok". Some ethernet drivers explicitly call netif_carrier_off
> during probing, others (like mvneta) don't - which explains the current
> behaviour: only when the device is brought up, phylink_start calls
> netif_carrier_off.
> 
> Fix this for all drivers, by calling netif_carrier_off in phylink_create.

I would actually say: Fix this for all drivers using phylink, by
calling...

You marked this patch for net, so it should be backported. Ideally you
should include a Fixes: tag, indicating when the problem was
introduced. That is bit hard in this case. Its been broken
forever. But adding LED support made this observable. So maybe a
Fixes: tag based on when the LED trigger was added?

You should also add:

Cc: stable@vger.kernel.org

There is more about this in:

https://docs.kernel.org/process/stable-kernel-rules.html

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

