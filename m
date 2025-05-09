Return-Path: <netdev+bounces-189230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151AAB12ED
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E7DA0135D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA66290BAA;
	Fri,  9 May 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="fHoepJuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C51290BA0;
	Fri,  9 May 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792289; cv=none; b=ALW3tguReN1l06gkJj86eq71O9EYSj8qaxHByBUJhqoskguO4cKhTuprMLAQGZN8m37cDHBPldhG7VNYhZAhlqdeJ37rLgQlOadyzgt1SSJkd5a45ec/pT0VY2Zd8IRNSteYyFcqRZAjQvgRhF2sRKF7E63Kuko9r1ysq0i/6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792289; c=relaxed/simple;
	bh=vmfHZSIt1ejNXSsXOb9OK4hl3H/Az8e5YvWTRNvnHco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LehHB+A7oY7m4qe9nwFU5FmtJo4zKU3kpx4EvyIuHLsvH1XMQc9EDfaINSO3UCjssqJP/hxGhZBoAOMKPDX7zr3Hey2U+JONd5R5GAxlp39EUiRlR2J3fuTYW4fqdVJoew9+o7Ly4Tzw2p6byzFWIaSzPjFNRIBzCj+CobR6oCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=fHoepJuZ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792281; x=1747397081; i=wahrenst@gmx.net;
	bh=QxpyD8wMaxzufHPxLkJGzjDohgxWzZQt3Fz5KBSlXWA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fHoepJuZ70LFp+vZioi09wU9QpWsOAcfEjkNW9/TBXtcwghEk6NxuF6YEJLdFQ9E
	 1XzMK4yaLoutdy2puYNhTyQ63wrOHdAD1t95Ci2sTy1ahbOp/6aUADXjNfFxqHHM+
	 xuh5ORmJiT6GWwUFPIR9rHv2A9OZ86JIddaMk2wyQtK3yVTSeyJy1G6DJ3NNwigZ/
	 KdBShJ4BxqraXuGklmkclocT7OH0Jua8IkkUZ616FcWRbxl5zGuVxQUHwTXCzQeRk
	 62haz2ve0cm01GeeUSOjXj0VSEa7aMfhqPOPbPcK4os6XKy9DAR5UBOrXbwXHASev
	 Z5F7xnf3paSKRhZoxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1uwnwd1mLG-00szjw; Fri, 09
 May 2025 14:04:41 +0200
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
Subject: [PATCH net-next V3 0/6] net: vertexcom: mse102x: Improve RX handling
Date: Fri,  9 May 2025 14:04:29 +0200
Message-Id: <20250509120435.43646-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fIIU0TixX7JuZNaBOzYHIoHs97yGSGYkWSCGKsaOYSmjfwkuCVp
 7CSAlRmWyf+A8gXoyZI/28Y4HkF3iYejPjuyyxbbd/kifgW/tMw0J8Ch7MzzHjT6FU9UUEX
 TKMadkToPLmkui5DmadBJMwy7j1df3DdaKszXwGYoES3GqhgRW0RjL15sYoRl+OiIERWPIy
 KuZvZpd2MszNoZar5fcLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/plVsZjKjQg=;pvdxhsm3EB11ajolSrpwWbNCLYL
 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

This series is the second part of two series for the Vertexcom driver.
It contains some improvements for the RX handling of the Vertexcom MSE102x=
.

Changes in V3:
- Fix whitespace issue in patch 4

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


