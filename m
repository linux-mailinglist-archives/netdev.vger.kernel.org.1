Return-Path: <netdev+bounces-187080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5F4AA4D87
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D5C87B87A5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A525D8F6;
	Wed, 30 Apr 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="eQGVlERx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003CA186284;
	Wed, 30 Apr 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019859; cv=none; b=jXqTMq6JDbm8+hxAHtbdFnX5c/xodiExMxpGZqcV27Mr3dppCS1yoPsiIyeWn4hpRa+MlHAcsORzSBTlUM6ZXk8+aKyoiY8CEywZ/AwXvdV6uxPAliRMwt2vwxjGGrzXem9Sv5gWxRg2alYdsMEsS4WbguGugDbZV7/d8ayYlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019859; c=relaxed/simple;
	bh=dfDvF0ggrnC2zBY3NrGojHZ/8GAKlL3vTf94NFcPNFI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gYffVVqCewQFYV+QO8419unIBueJAltBIDbmvbFU3Q5gIuDLBfJdItUTRZJ3nvcSzHd4vxMBRSBLutzL4rRVXMs68zMeuhFhd5rwkMHYy6FG4AQ6nQwyeSV7/fqpPBoP/lfGpzmuCc/0h75xmE6CW3xG4fBYksqx4xBxxUC0WVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=eQGVlERx; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746019851; x=1746624651; i=wahrenst@gmx.net;
	bh=UCteHG190M5hZBUMy0gz1Ixc+1objWj7QD6Y7kq7A7s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eQGVlERxDCx+PDSMl7ppgCU9cBYuyDhA8m16vj13VksNRem8iAU0SWMvsvTwPtKu
	 cy5d2nunXZPlCE9XSQ/yVS6ZItwO6uYQUa3Q1ia5c5L4k8fLYSir+DXWKpZJas3nV
	 ftINgLLq2UL81Mwtp4QreeEg4ZJrvtgcjBO5TWR+nH4w+g9HZ7IKsi8HgQJY4/Mif
	 cF8N7bsN5PujWGWDiuvTpXYEAJ7nn4r2hto7UbugQMHESUda2GjRt+ipqtvT6El3q
	 RKhT7vLfm20T+V1cOSWMGfetfXax+PHJI5xHKcxPHEbB/iB+lDK8COU3FT9eoODwJ
	 JrqKWTdvWtvC7NpLpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1ugjJp2ifC-00n4Am; Wed, 30
 Apr 2025 15:30:51 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH net V2 0/4] net: vertexcom: mse102x: Fix RX handling
Date: Wed, 30 Apr 2025 15:30:39 +0200
Message-Id: <20250430133043.7722-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hb+vPagaqBM5SXEHaAZmQThd+lNIU394V9kDkUkTD8UmrTiG3G8
 mx1epn/uda2P81K3+0Gmusmz2Ju5w2D6BDAnafU8corlSGCI5WC7HQadl8a8xUfNR4cujbf
 kWmZx5+UOJOick9Jmwy8Sgn/IocQMu4QXOLrQ4TsxKXRo21yUsBBriMLvjF6hxpmto0ZuoA
 MykouhUztYG7AAkZo5dqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yy4riY7wf8U=;2Yjv4S5h2wtTumBRg0xuylruVGK
 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
 n15wI4W75GTWLwZgkE86xQ=

This series is the first part of two series for the Vertexcom driver.
It contains substantial fixes for the RX handling of the Vertexcom MSE102x=
.

Changes in V2:
- clarify cover letter
- add footnote to Patch 1
- postpone DT binding changes to second series as suggested by Jakub K.

Stefan Wahren (4):
  net: vertexcom: mse102x: Fix possible stuck of SPI interrupt
  net: vertexcom: mse102x: Fix LEN_MASK
  net: vertexcom: mse102x: Add range check for CMD_RTS
  net: vertexcom: mse102x: Fix RX error handling

 drivers/net/ethernet/vertexcom/mse102x.c | 36 +++++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

=2D-=20
2.34.1


