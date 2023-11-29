Return-Path: <netdev+bounces-52072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8C7FD34A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE94AB218A5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B019464;
	Wed, 29 Nov 2023 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QknhoD+2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD5619A6;
	Wed, 29 Nov 2023 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1701251579; x=1701856379; i=wahrenst@gmx.net;
	bh=vies0F8Jg1t++keNUgRX+FOgBZdRHEdkEZpAqz4PZbo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=QknhoD+2hkn2qzX8nZoE3bSo9ITWr63co889q863jTS7usC8Y3fjFUmnOTQqVq53
	 T/8/Xi2o6rY6X2vNuDMWyleR6CpzqqFbvsjetf538hicdsrEeyUNyfM2aelbc1qfA
	 H+tVd+IDj8As/aftvVQWYHRN8uKiJC71ELiAHM6nZMzY3gP2P2iyTpTPD45qxP0H5
	 FLv4nJjRp8+sxZAc8fhdyzSEjEuyoWkfsi4olmeHlAhsbr4SMfY28G0oVw+dZpVFy
	 7u18nD2GvxnnwrIzEFdtGHy1VKktGYmPS0u3pZh5DPzZ3/1BSnR6nYyDvXcloN12b
	 WnyBA08r3lSDskC44g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1qkTl61Xrb-00WjGH; Wed, 29
 Nov 2023 10:52:59 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 3/3] qca_spi: Fix reset behavior
Date: Wed, 29 Nov 2023 10:52:41 +0100
Message-Id: <20231129095241.31302-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129095241.31302-1-wahrenst@gmx.net>
References: <20231129095241.31302-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z4/zh7el0YVAthtFzRf7pWbtQi6p4Rxm5tDQSr9kgPCtd5kJpFS
 CI/7pNcuDiVwPVRsKTmfj1gqDuCOxHtVkj2AwggxLiVzXSTyShFbdhk0TluiDlDc4ChPa0O
 AN3YgY3bwZhUbmRNUfA1gsUGQrNL30WRj9Ikme7BTFqhXJS2eDLYzz2PCHyvB6eHF63bbyc
 NGlzmp+ch9+LKlr2nb9jA==
UI-OutboundReport: notjunk:1;M01:P0:+zZhfyPFhgc=;Fif8m7WzyJ9ywa0VouETtbfU2Be
 4pkUG2z4lNKnqUuJ6YpLI3EiOWqz5m9y54NJk2XpMJAlXneZG4bOw6aahw8FPCrnkZjoxY0Pb
 E5iIE79qu0HTX7EMZClj2imp4hxEuGoj2E8q18X1zSa4PZgtJy+sLh313PQC/DZ2uuGrdYEOe
 4+zRloIDvz+vfl9AK7YzdagQGf1FxKeB1xkChnbJCT0cHPXnYxH5v8hzYlvFRQ8OgjtMClUES
 fWOdL1Fx7gfsnW/ir3W7nyLCmc+La2QYowTltXxEWDa/LhUQfmR0Tm1WmZTbel+dVfxlmjnGB
 WlbKkQOr2IFaxgaCiuifK4ob0C5TNvsJOuLF7zCtGt4rV5EaDstARFqNuccloO8J6DaHhELQr
 LW9Fj6EDsKGJQCLCL+fkmLpgVbGpAphhtOrYhULNgwjpyxcwAUvf+Ed0CHT/Vs1zCXuEZM5yC
 7tYRKQqQW+nhGeV7IcJ4lsNSBsN0PYWOKrBrio6JFEasu5gVCvA4lP/Q8k6IPNtdAxw+RTzZY
 6ApahbnNjheECaofBJ8m4/PSwXRqcBysZuiCF2wqtvQTK0lhROV5jmgdVJBT/6XohHCtx7cOY
 lqREh0e8/gY6o4ugYKCxlkcPUoeWlPWkGfZOtTYTY989550sWBU3L0bMFhI+m7RleseVbhQR/
 V9+X6ckS1TaOAKrjurm3Se1kegAn8Yy822fAcQmcSiBcUgf72N0m4m500OQrqweFvPp5ehXfV
 oH1V+smvPdNS/Hnsi2Bboir1Go0C10809veoOKr6s3dKMZ1k9dOei+cOsNvw7Qf4/VQlvVm/u
 hHz1PRVucUDWTBedpdtKDI5jUtGagJW+BNEecKb1WNtIgopv5Mr3Yaij53Wy+FxU0nAkOlGHc
 ecGrcjtrtg1sqOV98OFNgo/wgRIZ4fghLhOE8B1WSQQ4JnK/KehwYpR6lTHTg+Ts4E1WbE98H
 MtSnnA==

In case of a reset triggered by the QCA7000 itself, the behavior of the
qca_spi driver was not quite correct:
- in case of a pending RX frame decoding the drop counter must be
  incremented and decoding state machine reseted
- also the reset counter must always be incremented regardless of sync
  state

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 78317b85ad30..0fe2e24a42b2 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -613,11 +613,17 @@ qcaspi_spi_thread(void *data)
 			if (intr_cause & SPI_INT_CPU_ON) {
 				qcaspi_qca7k_sync(qca, QCASPI_EVENT_CPUON);

+				/* Frame decoding in progress */
+				if (qca->frm_handle.state !=3D qca->frm_handle.init)
+					qca->net_dev->stats.rx_dropped++;
+
+				qcafrm_fsm_init_spi(&qca->frm_handle);
+				qca->stats.device_reset++;
+
 				/* not synced. */
 				if (qca->sync !=3D QCASPI_SYNC_READY)
 					continue;

-				qca->stats.device_reset++;
 				netif_wake_queue(qca->net_dev);
 				netif_carrier_on(qca->net_dev);
 			}
=2D-
2.34.1


