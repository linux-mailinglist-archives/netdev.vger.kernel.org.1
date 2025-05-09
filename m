Return-Path: <netdev+bounces-189226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA20AB12D4
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D88F9B2500E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BA290BAC;
	Fri,  9 May 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="eZLVhL54"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7098233735;
	Fri,  9 May 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792100; cv=none; b=teS3CJc41FLGEKEik5csUOhIZTFtgGyGu9LLedP5rjViFs5rOxTJSzqvEw60hpbVnb2cKiYwcdYzZdl4wZRWDyl4fkpkxq9ppn5xCKtJ+Ia9Jj+kLNyctb11BJUJLIXhC9EHbV4PHxyTFA/vH6aOWyiWMQ1EzuMG9sWvETspXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792100; c=relaxed/simple;
	bh=mzVfl0VQkmv9mpwg909PplvfyKQarCFOcNN9mVF1U4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZpZkmawGSuau3ObXEs07eaDjfCauP9HJ2Yg/mIGjnWWREcju86wu4xu76jnm/eu1XFnuC/PgO+y5nDOIjgOiUKSn2aJ8rqEY5aQ4SG7GbPUH6J3Hsy0YjbG8ZgUPhnVQh+U8LKKc1v2bFtbMOTF15s1Eex57JS8pdf5nLfVvUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=eZLVhL54; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792089; x=1747396889; i=wahrenst@gmx.net;
	bh=0FAb3m79Y6L587WimoHZuP6cVi0UxtwlMPB5CY5f9a4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eZLVhL54/j0TOVs2yiMKEY8NSEdglt5A8fvWHXlHJeeCUyK/6/vwt2neZsrN/3fy
	 dVj+KB5E5boZ54kR0VaP3OwgEFPsTOuNJBXWn2RIWAhr/GOX/KxA7B/Nah2FQxdzn
	 Y52cSRNemLaJHVMjgP5PPMUqRUNHCbSdf6ap96+7OkdM6UhKGWNDdNWsASdRaV3YD
	 ASnlCu2f9VhIoriyl5Ma1VIjHrWuiO2wIE94cGM4DpmnoExMetOEk8sRmY3t9s5Ml
	 TmBSf7XuJY2mvMUtXyN4Lk8Em2ADPVWVWizm+7ssFq0NMcsgnx0gyxQHT56uLzP93
	 X7H9wMPJzwAz45qZHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1uXL512fBz-00MytN; Fri, 09
 May 2025 14:01:28 +0200
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
Subject: [PATCH net-next V2 0/6] net: vertexcom: mse102x: Improve RX handling
Date: Fri,  9 May 2025 14:01:11 +0200
Message-Id: <20250509120117.43318-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4eiDcLfBMyO60PqUZe5DDT4PB/hLun0lylq3F2qJ7eORWLnIcfZ
 lr0uBIZKfs6rIcRZT6E1Yt2mofSrJO4HH51ex26fCCevemWEF3kCAZYqqt8GH01SyZefDIO
 uZ19QOe2/BSPRUKjtHxbBvkyerErtgudH5XU+rMLyERDKnGKRwpoVPnH2UQn21nVoOd7H8Q
 xdQnR89GNbhWntV8EBTLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aeBGav145Rk=;waVLna/1f0OV+ylTqTRXqbPZoH9
 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

This series is the second part of two series for the Vertexcom driver.
It contains some improvements for the RX handling of the Vertexcom MSE102x=
.

Changes in V2:
- Add Andrew's Reviewed-by to patch 1-2
- Fix build issue reported by Jakub & kernel test bot in patch 2
- Use Andrew's suggestion for netdev_warn_once in patch 2
- Improve commit logs for patch 3 & 5
- Add new patch 4 to compensate loss of invalid CMD counter

Stefan Wahren (6):
  dt-bindings: vertexcom-mse102x: Fix IRQ type in example
  net: vertexcom: mse102x: Add warning about IRQ trigger type
  net: vertexcom: mse102x: Drop invalid cmd stats
  net: vertexcom: mse102x: Implement flag for valid CMD
  net: vertexcom: mse102x: Return code for mse102x_rx_pkt_spi
  net: vertexcom: mse102x: Simplify mse102x_rx_pkt_spi

 .../bindings/net/vertexcom-mse102x.yaml       |  2 +-
 drivers/net/ethernet/vertexcom/mse102x.c      | 80 +++++++++++--------
 2 files changed, 47 insertions(+), 35 deletions(-)

=2D-=20
2.34.1


