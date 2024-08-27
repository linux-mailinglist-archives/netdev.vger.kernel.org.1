Return-Path: <netdev+bounces-122486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDC9617CE
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956D91F215A3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E141D31BC;
	Tue, 27 Aug 2024 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="n87yQxbF"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55B1D2F45;
	Tue, 27 Aug 2024 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785847; cv=none; b=jJygha4uUZ+4CCnUnec4DhH8a3L3/qONbK1yNH55EWnPK1E0JszfMT3h2soiVSboD6ewJcZ8Crdkf8seWiN5+6IXIzqzEg+89n6o/0+S1LDFDXvUySgZObBsKOq+ajGCb2lkeHDg1GBJTWtuLkA5pP5kavHGN0sM+l0UpMhyJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785847; c=relaxed/simple;
	bh=f5M2dUbFg8SUTGwQuifAPGq+G1rs5KExKGWCR9gMGmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfmnTCOCgFV9czPY/LXfoD7ABBkbgFQmPAQA90vfGBieCKGPdqdBL/9nQvPPfMxXYqybcdc4/1d9XksWyXi7q2XOBiRWXqrKxAGVf7N00oIAs0Bnr3LVV/FOk63BO7lNLeFYRqWwbUl7mdbL1OH2yKGayjGFSRpf+HE3lajULQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=n87yQxbF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724785830; x=1725390630; i=wahrenst@gmx.net;
	bh=L8WsVaIOqQALP+jrHSgr/UBOvBBnAWPppfvzJakqsxo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n87yQxbFFF/DeSwmWS9wWanm2SMqbsCLfiYYHSVMY5zcDE4M6cIILO+CDs/St9qa
	 UVM3Vd7fFuGnP0suTBhWroqpm+KNIJp79i1cQfqr+4aPjI9qt9Rdr09GrdbCSD//Z
	 xKmmbhiNrEPsTBY+MWJDKuOcJxnEmBBKnR/4qzXQ210B3R1nJx3L89ksUsBfRMC9N
	 nyWjceGL/6uQIHeWr1yeyz4mF3hC3i9kHBhcaljt+v+NDliY5hmKsGndBfLf9V1xm
	 U5mePkM6HlGx7dKEpqSERoEA96zN+4DApBNzeV2PUrZI6aXWLmEygeVyDJMS26KbX
	 Ere7A+O1EMsVfF63vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUUm-1sJqm21DAa-00nZI2; Tue, 27
 Aug 2024 21:10:30 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 4/5 next] net: vertexcom: mse102x: Drop log message on remove
Date: Tue, 27 Aug 2024 21:09:59 +0200
Message-Id: <20240827191000.3244-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827191000.3244-1-wahrenst@gmx.net>
References: <20240827191000.3244-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GUkr1wWIGikxAmWoETg0Wjo3EgBVhYl86OZVFlfXYYPRlgkNyJ5
 ZLetNccei+iMcq+oUdIyXMHLQdxaT1mrBPZevFXg/tKEe+M7m+k9U2GoDrGJnoleqL21boU
 hup7WKin7gkvpCo6HsNwf4I/UgMhbbaIbF4Otl8cLOoxJGTiwAXokABtiR+YCnF29EiWM2S
 8z981nWY5rNZdcjivK9BQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PMvBGUrLKEQ=;reQ5yaLcz8S5QC9RZCJP7PEquME
 i61MytT69U6GYBTvw/M37iNdwZp36vnLzBioOmt1FaH9GOLGbJJSSp+mzwdH5q2xgyt+8EvHq
 kvsV9lpYRkaj6i9RNq1oDGepSrclDqfwJxO5b8w9hqoS2KTY8W6C3kWRxMrallOE0eicRSAHk
 h3UMs1RxsGlMEQYlwuGOf2i80+3z+781e20pBT96OIykcxhgeh4e0ZiGFPXI3MUmTetIjPv2j
 AB3RFv2utIDIBhxYhgu0aUG8SYdnYcMKrDpPCEbDNlmWglrnGA+x8ZXKvuU7seR8Ie2UILjIa
 WiN4BWL7zPQTK2tlBU0tkq8Qh3v/fImN9mDWJ8vRIwNaDTBYle2bN+ENl1bOjh0TPGYFMn6Na
 LEXJwUsZ89xzXodUEY+g+gvAXf6nPEcqRYckHAD1C2r3gjmfjQsQQZ7i5sIIahBsUZljCXAbA
 6QAeumhBdzwX6qab8TD+QKagN/EngFpxyxnTMf8n7j1lSOpvVZQdM66DFB41kTpus/lD1N3BG
 qbOxaYA7QPQcrZmqXSYPpPIruMvJQ3Dm+qZzfA/N0+dhG3Lovf+8fmmlYT6X4BSPMJdzz5KfE
 61wvUyR2VnXasbVZTeOkLtmdkInmoZzRlCvq2pgyjC+cYFHI3LBWOafGtSphBrTe8qC2JnBVd
 5/Bfun7zMO2OFLbXPXv2NdwJ2ifmFPisZSs3J0TZpvpevGNlsq7M6Jti77ParItTYNIU97AaB
 UHez3CpYr949bjimuXig9ZBhmehqEdBh0oC4Zv89v0n8VusdKBW8nSnqSsSQsBmYyGpQjRODj
 acUq/E41egChXNDZbmwbxNxA==

This message is a leftover from initial development. It's
unnecessary now and can be dropped.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 4ce027f8e376..8a72d8699b84 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -733,9 +733,6 @@ static void mse102x_remove_spi(struct spi_device *spi)
 	struct mse102x_net *mse =3D dev_get_drvdata(&spi->dev);
 	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);

-	if (netif_msg_drv(mse))
-		dev_info(&spi->dev, "remove\n");
-
 	mse102x_remove_device_debugfs(mses);
 	unregister_netdev(mse->ndev);
 }
=2D-
2.34.1


