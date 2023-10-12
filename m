Return-Path: <netdev+bounces-40480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0267C780B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12888282AC9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73E33D394;
	Thu, 12 Oct 2023 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bHPFRdeW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE53B7BB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 20:46:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F928A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=DWtrA2QgtvRXayR+5hYsgynhn1nmu/HTIKv6wwQ53Gc=; b=bH
	PFRdeWOWBgpL8eHioYzIqp2CBjVbefzAVrVMuPRAOno96e+Bf2PnraG7hCupSX5cF9SeAHoqs1cDW
	Js2MNaE+7u4XnKOqB7mHgNgGiKGXgf3dyBdifv5/4Xa2oFFihtXQtaGGwNkhRo986fgcO/cQ/IqOs
	JJDzW6xG/xdS+iw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qr2ZN-00215O-DZ; Thu, 12 Oct 2023 22:46:09 +0200
Date: Thu, 12 Oct 2023 22:46:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Russell King <linux@armlinux.org.uk>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-imx@nxp.com, netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: Ethernet issue on imx6
Message-ID: <8e970415-4bc3-4c6f-8cd5-4bbd20d9261d@lunn.ch>
References: <20231012193410.3d1812cf@xps-13>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012193410.3d1812cf@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> //192.168.1.1 is my host, so the below lines are from the board:
> # iperf3 -c 192.168.1.1 -u -b100M
> [  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms  467/82603 (0.57%)  receiver
> # iperf3 -c 192.168.1.1 -u -b90M
> [  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms  12163/77688 (16%)  receiver
> # iperf3 -c 192.168.1.1 -u -b80M
> [  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms  20937/69055 (30%)  receiver

Have you tried playing with ‐‐pacing‐timer ?

Maybe iperf is producing a big bursts of packets and then silence for
a while. The burst is overflowing a buffer somewhere? Smooth the flow
and it might work better?

  Andrew

