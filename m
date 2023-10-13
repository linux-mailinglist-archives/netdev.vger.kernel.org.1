Return-Path: <netdev+bounces-40743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCC37C8920
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7DAB209B9
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099B1BDEA;
	Fri, 13 Oct 2023 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XX/fqKaj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBA13AEF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:51:33 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE8CB7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9duYZcC8POQDFwXj0vaJzf5aL5DaBxzJ4rpg/YfAsHg=; b=XX/fqKajrzWBDyHUgtdL5bGapd
	1TSC1wiQNbpfWth9aKbatzE5UUSSvIDIhWK/Q2D78eIicYjAlc4yqFCWBdj+OSNja1G3Jx/oxyS8R
	SF4uN2qaHcqCKCiLZqXo5NCdq/viXcAcrYGzy5VJeCm2DjajEDRbaAIdSKRRrtoupXj0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrKRc-0026ik-DC; Fri, 13 Oct 2023 17:51:20 +0200
Date: Fri, 13 Oct 2023 17:51:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-imx@nxp.com, netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Message-ID: <4736f0df-3db2-4342-8bc1-219cbdd996af@lunn.ch>
References: <20231012193410.3d1812cf@xps-13>
 <8e970415-4bc3-4c6f-8cd5-4bbd20d9261d@lunn.ch>
 <20231012155857.6fd51380@hermes.local>
 <20231013102718.6b3a2dfe@xps-13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013102718.6b3a2dfe@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> # ethtool -S eth0
> NIC statistics:
>      tx_dropped: 0
>      tx_packets: 10118
>      tx_broadcast: 0
>      tx_multicast: 13
>      tx_crc_errors: 0
>      tx_undersize: 0
>      tx_oversize: 0
>      tx_fragment: 0
>      tx_jabber: 0
>      tx_collision: 0
>      tx_64byte: 130
>      tx_65to127byte: 61031
>      tx_128to255byte: 19
>      tx_256to511byte: 10
>      tx_512to1023byte: 5
>      tx_1024to2047byte: 14459
>      tx_GTE2048byte: 0
>      tx_octets: 26219280

These values come from the hardware. They should reflect what actually
made it onto the wire.

Do the values match what the link peer actually received?

Also, can you compare them to what iperf says it transmitted.

From this, we can rule out the industrial cable, and should also be
able to rule out the receiver is the problem, not the transmitter.

     Andrew

