Return-Path: <netdev+bounces-187738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B2AA95A7
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B353C189B257
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132A525A2C6;
	Mon,  5 May 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mw4VQ51k"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FEB1F4184;
	Mon,  5 May 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455091; cv=none; b=mKj14jLWh95B0zIbTYypHPQZfA4fHJd3pmQpNp94iE/9PJEa5k2YBAhWqFGyvvgLvyO+NoxA2qyRhxaWTZKcjqZ4q5Ky7x9Ds9l/BYl/Z5HL9T4mLzl1smQmSVgDv5xX7gjeKRjWcctU5uZKvg1ctgRYo8a1Z4IIIF6b2Dd+4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455091; c=relaxed/simple;
	bh=KJoKHWx/lkY/UNWBFeKJWjvPZawFyA7ZDHLbT+CfTHg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LaUTpM0ebFkPEO+CxNR9dkaCLc5YypGm55e1lGU7mNY+Nu/gGyGj/Ly7/a4BGHPgr8akF8tUoRJM3Hd0E8U++RgxAWbTHsszoSj/IKGq3rBMnGw2F50CJoHLDjpeH6RX6dC2pDA5QLcgpO8i4/FQU2zM1viUsc/lPsaHHYKdF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=mw4VQ51k; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746455086; x=1747059886; i=wahrenst@gmx.net;
	bh=A1k795E2lStGqdZL4Vq0xiU8akbBWmz2eRjhMWChB0Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mw4VQ51k6E5oGAPLEv7WsorKDH0xxfUvQrUIR+f0RpVVFSCbV2d/Nha4rXtrOMCl
	 eQhV1yFu+Lx6trM+wGxnxHjNPYDIMdjVKg7/YL62whfXK1e1Li8PTFb5u9x5wnxU3
	 aOoDLgS6kLHJN8ZY56K+1wG5VqEl1cjDCE2yJZIK8HwmwMchyrBzCYXJuzhmwQNEX
	 4aegnjIPGBW1hpmMQT8WRt+mX4HTPGwSp9zwmW2mKOaqVsRm88bvDTBK2/LB94lIN
	 us+tSLmG6x9LgGdvcvl+lN3lxBrZIphrZ40UAgBgUmwSd8u+bghzJ4LOmawr7CVVR
	 L9Cdtt5QzhoRquwC8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1udPmU22A0-00L3GE; Mon, 05
 May 2025 16:24:46 +0200
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
Subject: [PATCH net-next 0/5] net: vertexcom: mse102x: Improve RX handling
Date: Mon,  5 May 2025 16:24:22 +0200
Message-Id: <20250505142427.9601-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NoRKKHH9RaKV91ED9IeQ1vUJN6JJy1lN5jakLQOmbGSThYu/ydS
 LW2F94TgBcqCOnLRfAb7W2GWvIH3WIKsWaZzqgW0x/nKrfFuBSUzax9gQsHxve1f45mCzIw
 ve3I/6X+Zz3qv2uiE0qq9dNPkuU9m61igehSeEkaX/jAwj3HPNrH1aWQ5qzZE4lbWwzGTWj
 X5lf8wD9EPft0fasGbkOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W0AdGiaSmdo=;FpEDaqL+I22JEa3zkyolo5XTy9T
 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
 pIwdPKD8azRg8E/sfEPaGk=

This series is the second part of two series for the Vertexcom driver.
It contains some improvements for the RX handling of the Vertexcom MSE102x=
.

Stefan Wahren (5):
  dt-bindings: vertexcom-mse102x: Fix IRQ type in example
  net: vertexcom: mse102x: Add warning about IRQ trigger type
  net: vertexcom: mse102x: drop invalid cmd stats
  net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi
  net: vertexcom: mse102x: Simplify mse102x_rx_pkt_spi

 .../bindings/net/vertexcom-mse102x.yaml       |  2 +-
 drivers/net/ethernet/vertexcom/mse102x.c      | 65 ++++++++++---------
 2 files changed, 36 insertions(+), 31 deletions(-)

=2D-=20
2.34.1


