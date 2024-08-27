Return-Path: <netdev+bounces-122482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F939617C9
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E43C1F21067
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB601D2F57;
	Tue, 27 Aug 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="b0nYKSim"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86081AD2;
	Tue, 27 Aug 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785845; cv=none; b=HNPMw4xHoHxhoK8EUAri3V0KdDghxP2ctBxHE/I3/wnSElBnci4mszvEvOl+eMmUNc1SzB04F85A6yu1C/Xc6gVsQQVthYVH+9U5TPKkyP3aRutwmMQHJuWa9jlli9fNj5WDfjp5wU43BtYO8xXD2o7VBTWjR5mYH7WeYw5LVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785845; c=relaxed/simple;
	bh=E5Ph32Yb/JTIfgjOxLjWjVUgTlDoSzJqMxgWq6g92nU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSQlHej+oPukBBUUdN7Ku2RP5reysYW3wQ7lWHmcw3/p+yAMpV0E1ihnG8qmpgnjxF3P8AM1E1juVQpnwTGaYaPggVN7ZZCF9jS30G0Ns5pUjXkcZNapNiqh7i0b/4Kyjg2+FMl0dHuR1319/br3WaTseutfkzzUWfyFYWtC65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=b0nYKSim; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724785829; x=1725390629; i=wahrenst@gmx.net;
	bh=fU87Wbr4Y/qBPG1mPGxt4Kn9VQhhQrrJTpfgtHIE75w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b0nYKSimY4WNac6mmmgamEOA2PqNgnQ3Npg4Nagcn5UoTOr15pxyfbaG2CMKNiWY
	 4NF20Ebap99JljOoQtekOTOXZ1YEK7S92lfiwhB52cISLfxRaZo1UI7K6F8LMl/W0
	 +dhUCsmWAwDIBrQ5HNRW/hS0cvDh9yoDB7RI4Gr6VJqCaLpEDgOygVy7e6Qn90MW8
	 LOeHZ3sFs8iAROr5MFSYWgkW7CtbkRgBLXfv6YvTXG0N0RSk6Tu5eTvB6qsuS7W8Z
	 vqFy5X4eg8eE+irrC2+lTnvc3AX0nze5PFd++d0p/ESAiH6Jvtv1aQgGZWFSAip4Z
	 rd072/k2kAfGdxOXuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1sIBHC35JC-00kqXU; Tue, 27
 Aug 2024 21:10:28 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@chargebyte.com>
Subject: [PATCH 0/5 next] net: vertexcom: mse102x: Minor clean-ups
Date: Tue, 27 Aug 2024 21:09:55 +0200
Message-Id: <20240827191000.3244-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FXFh5c6lpOdqk48VgvWpN2QUfZg6WbZOKxsFEwK6wyDj9u8/NX2
 LR+2fsxuJ+tBtaNxXWu86a3WoKHKmMb4RCAGsVbJ/rYZJCqDplesN3ZEwJnK51e3xHiI9UV
 e2vtq27f+Ixq9SSaBtdZGWLFK6BVkkp/UR4QC71sG4O1XD/ovGPKvoZFgdI7aSoEUyfNcBB
 Wqe/SOEGuywwpUJaRLH+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UxRrkYobkjs=;nfUGe0DJuEsqN/rBhr9UwUGf74A
 1/i8OjQprNT9PtDqNyVBR2SprhbhOe4ivg178eNFYyT9SgDDHXWYbWlHY+maF7j8LxaA83VRT
 gbXAtABg5qE4GsaSNqTx52NgKLDTe2kN/GUiSwF4HJsxSDSIXZmIULpanbfrR9WOqqvq5Jfcm
 fT43SKxrSjGdzOppNoRSNillH5OHMtI+diQBBc7DVln8GbIx6vjZ6ALS49EXmnD1TBTBVmTQ/
 taO0N9kMMpkLfU58i9CH36bBdvtIGl1nsmBFF7xbA+2Lt34GhyL9rV6z0Yv5g4ORKxHRtqF8J
 lAHaPARQaYIPshQfxDeFthtMQP3SVGDZrMUr0VEuu1hAs4UHHB+qB9CslSVcLNBBSQ7Lex7Ej
 cAyx+oqCw9IiKVpMHamimAE0FV4QrqXjhNTmAVKanJturL5ZG10N1UVQ8P0KQYx8CS1FCuWPy
 E4nsR+p4kDxOWR+Y6SBVVTtonzjSEOokMyj3vIywX9s9eeEEfHhAeR69yRAjHIjtJ5RkIlz4C
 yeu0xXttU8K4MJQuFFK+BHYCRvNOGWCL2b8s+gi89NURFSgpFdh0Nygn2Kxb1zalD/BXVcOZj
 GyPaFQ7EeWffuzTlgVnFhUU/cHRzca2bQ4lQoGrGxIRzE6hufgqMC6JLDKgWefdMUmbSHn8uf
 0cW9MDVb3e9MmZ+NF//DXui5Npvz6Ma07tee96NVDz7zlyCESURf0MhNFMZv/TRYN0cR4RuXL
 DWJF+xsHk0NUqabEjHQRDWTK5yCKt06VXpbbxEdLRsQiPLaKdipdZziRVBTAtR3Gk7tlq4G9j
 OxgsBdfBvn3ep9gSkGAz6XvQ==

From: Stefan Wahren <stefan.wahren@chargebyte.com>

This series provides some minor clean-ups for the Vertexcom MSE102x
driver.

Stefan Wahren (5):
  net: vertexcom: mse102x: Use DEFINE_SIMPLE_DEV_PM_OPS
  net: vertexcom: mse102x: Silence TX timeout
  net: vertexcom: mse102x: Fix random MAC address log
  net: vertexcom: mse102x: Drop log message on remove
  net: vertexcom: mse102x: Use ETH_ZLEN

 drivers/net/ethernet/vertexcom/mse102x.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

=2D-
2.34.1


