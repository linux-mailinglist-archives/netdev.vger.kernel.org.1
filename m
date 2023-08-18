Return-Path: <netdev+bounces-28799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B3780B96
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1580D28239C
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19C182DF;
	Fri, 18 Aug 2023 12:14:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230F182B1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4960C433C8;
	Fri, 18 Aug 2023 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692360897;
	bh=w6FNTVBuQt9tbVAVP1ItJQdCLgQiAdvFQrWq6PaI3kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcJ3C3ny9mIZx0FXxtuJwFKaw8F61tdSt/SjB6QmDoWk6rDxJFsHMR1oUl/8KL/hg
	 rZLPVvMa1oKLNtV6LTr6h2GOupMcxQD4CQYtIaBngSFgUn18CIsfuJyf1xLa6aqu5+
	 25SWoITQRwIe1IlDTrIeII1zdclqhbptChES3erfaisJjIXBhvsj2/rvPQQbDj6pLz
	 SLVSkCRW5SQA6ndKG5pkK8kOpALN1wleFWWlTMuwc3izyKwVfujrkqGuINwvsCiJaP
	 J4d5erWPIc5q0mbY29LXC1U2AkhddHu2lcJenzpir6o90afDwNV8xdFfzxAPfW73Nm
	 vrmBtMkotoYpw==
Date: Fri, 18 Aug 2023 14:14:52 +0200
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Michael Walle <michael@walle.cc>,
	Richie Pearn <richard.pearn@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: felix: fix oversize frame dropping for
 always closed tc-taprio gates
Message-ID: <ZN9gvGTV4qXnFs3c@vergenet.net>
References: <20230817120111.3522827-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120111.3522827-1-vladimir.oltean@nxp.com>

On Thu, Aug 17, 2023 at 03:01:11PM +0300, Vladimir Oltean wrote:
> The blamed commit resolved a bug where frames would still get stuck at
> egress, even though they're smaller than the maxSDU[tc], because the
> driver did not take into account the extra 33 ns that the queue system
> needs for scheduling the frame.
> 
> It now takes that into account, but the arithmetic that we perform in
> vsc9959_tas_remaining_gate_len_ps() is buggy, because we operate on
> 64-bit unsigned integers, so gate_len_ns - VSC9959_TAS_MIN_GATE_LEN_NS
> may become a very large integer if gate_len_ns < 33 ns.
> 
> In practice, this means that we've introduced a regression where all
> traffic class gates which are permanently closed will not get detected
> by the driver, and we won't enable oversize frame dropping for them.
> 
> Before:
> mscc_felix 0000:00:00.5: port 0: max frame size 1526 needs 12400000 ps, 1152000 ps for mPackets at speed 1000
> mscc_felix 0000:00:00.5: port 0 tc 0 min gate len 1000000, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 1 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 2 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 3 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 4 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 5 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 6 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 5120 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 615 octets including FCS
> 
> After:
> mscc_felix 0000:00:00.5: port 0: max frame size 1526 needs 12400000 ps, 1152000 ps for mPackets at speed 1000
> mscc_felix 0000:00:00.5: port 0 tc 0 min gate len 1000000, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 5120 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 615 octets including FCS
> 
> Fixes: 11afdc6526de ("net: dsa: felix: tc-taprio intervals smaller than MTU should send at least one packet")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


