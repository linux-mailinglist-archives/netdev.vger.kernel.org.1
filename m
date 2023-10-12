Return-Path: <netdev+bounces-40425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614297C74D6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609201C20BE6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC5636AEF;
	Thu, 12 Oct 2023 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lZ5LV6ok"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84132AB39
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 17:34:20 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084010B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:34:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46A1DFF805;
	Thu, 12 Oct 2023 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697132054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BRiYshhP7qCU0RVMJ9W0l7j4l03NliW4PnPPeVL297Y=;
	b=lZ5LV6oklBBCAbb7XWpi3qqqgnuB6au0/3wWSW2FMNAhbsf1PSlmgrySMmrsMRxhJiDUxa
	sPZGLjtcduMllJRZIxkiTnwjh1SI3tfxDEc2OxX16A7ewzJsatVlb6peDtzWR5iwhnOBaB
	Q9HY1sj+HCtPQQPBD2SJRuzX1lZ8yZI/seVTu6ZH8PzkwKNKqHXhVa8LdCNazrmddti/O7
	9vl8V+2+Sz/i19N0nzDsRgcFR4CwTbUr/gH0OdJ47d6hky1XnciTYDMuwavLEHFlDjBV5/
	4Q/85UrrtwG5n03kKdz+n3zcli4X+hdp1EuC0piQdBqlPe1buTgcA+FAhbq4vA==
Date: Thu, 12 Oct 2023 19:34:10 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Russell King <linux@armlinux.org.uk>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-imx@nxp.com, netdev@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Ethernet issue on imx6
Message-ID: <20231012193410.3d1812cf@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

I've been scratching my foreheads for weeks on a strange imx6
network issue, I need help to go further, as I feel a bit clueless now.

Here is my setup :
- Custom imx6q board
- Bootloader: U-Boot 2017.11 (also tried with a 2016.03)
- Kernel : 4.14(.69,.146,.322), v5.10 and v6.5 with the same behavior
- The MAC (fec driver) is connected to a Micrel 9031 PHY
- The PHY is connected to the link partner through an industrial cable
- Testing 100BASE-T (link is stable)

The RGMII-ID timings are probably not totally optimal but offer rather
good performance. In UDP with iperf3:
* Downlink (host to the board) runs at full speed with 0% drop
* Uplink (board to host) runs at full speed with <1% drop

However, if I ever try to limit the bandwidth in uplink (only), the drop
rate rises significantly, up to 30%:

//192.168.1.1 is my host, so the below lines are from the board:
# iperf3 -c 192.168.1.1 -u -b100M
[  5]   0.00-10.05  sec   113 MBytes  94.6 Mbits/sec  0.044 ms  467/82603 (=
0.57%)  receiver
# iperf3 -c 192.168.1.1 -u -b90M
[  5]   0.00-10.04  sec  90.5 MBytes  75.6 Mbits/sec  0.146 ms  12163/77688=
 (16%)  receiver
# iperf3 -c 192.168.1.1 -u -b80M
[  5]   0.00-10.05  sec  66.4 MBytes  55.5 Mbits/sec  0.162 ms  20937/69055=
 (30%)  receiver

One direct consequence, I believe, is that tcp transfers quickly stall
or run at an insanely low speed (~40kiB/s).

I've tried to disable all the hardware offloading reported by ethtool
with no additional success.

Last but not least, I observe another very strange behavior: when I
perform an uplink transfer at a "reduced" speed (80Mbps or below), as
said above, I observe a ~30% drop rate. But if I run a full speed UDP
transfer in downlink at the same time, the drop rate lowers to ~3-4%.
See below, this is an iperf server on my host receiving UDP traffic from
my board. After 5 seconds I start a full speed UDP transfer from the
host to the board:

[  5] local 192.168.1.1 port 5201 connected to 192.168.1.2 port 57216
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total =
Datagrams
[  5]   0.00-1.00   sec  6.29 MBytes  52.7 Mbits/sec  0.152 ms  2065/6617 (=
31%) =20
[  5]   1.00-2.00   sec  6.50 MBytes  54.6 Mbits/sec  0.118 ms  2199/6908 (=
32%) =20
[  5]   2.00-3.00   sec  6.64 MBytes  55.7 Mbits/sec  0.123 ms  2099/6904 (=
30%) =20
[  5]   3.00-4.00   sec  6.58 MBytes  55.2 Mbits/sec  0.091 ms  2141/6905 (=
31%) =20
[  5]   4.00-5.00   sec  6.59 MBytes  55.3 Mbits/sec  0.092 ms  2134/6907 (=
31%) =20
[  5]   5.00-6.00   sec  8.36 MBytes  70.1 Mbits/sec  0.088 ms  853/6904 (1=
2%) =20
[  5]   6.00-7.00   sec  9.14 MBytes  76.7 Mbits/sec  0.085 ms  281/6901 (4=
.1%) =20
[  5]   7.00-8.00   sec  9.19 MBytes  77.1 Mbits/sec  0.147 ms  255/6911 (3=
.7%) =20
[  5]   8.00-9.00   sec  9.22 MBytes  77.3 Mbits/sec  0.160 ms  233/6907 (3=
.4%) =20
[  5]   9.00-10.00  sec  9.25 MBytes  77.6 Mbits/sec  0.129 ms  211/6906 (3=
.1%) =20
[  5]  10.00-10.04  sec   392 KBytes  76.9 Mbits/sec  0.113 ms  11/288 (3.8=
%)=20

If the downlink transfer is not at full speed, I don't observe any
difference.

I've commented out the runtime_pm callbacks in the fec driver, but
nothing changed.

Any hint or idea will be highly appreciated!

Thanks a lot,
Miqu=C3=A8l

