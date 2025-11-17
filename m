Return-Path: <netdev+bounces-239113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7DFC641DB
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058593B0DC8
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2B32E73B;
	Mon, 17 Nov 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aKwAJUwI"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay15-hz2.antispameurope.com (mx-relay15-hz2.antispameurope.com [83.246.65.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2732E6AD
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383088; cv=pass; b=FMm2w1Yom99JukbyFJWVONIJw2rcc+QFvHpJC/6qMHPYywJ5D7apnSos0JSJ/Tg7mQVkKSuat0vVBxWMEkeJB2b+/LY6/tDVsOxFZuynqw9VJ5Oi7/nGcjXIDun/TpaOVZI50cuZmlcxjABquCJreA2yTiMHmCAWfZ5KuIlbTVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383088; c=relaxed/simple;
	bh=0FkXnnFLmOfEqTXhxucbtGEaFIfg84EOcO1xc43LJ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GG1JDR0a6GqRbn02r1ajoi6pz3cwX3HcCpwQPBOJX3TvtgXrKpIPMXourlpEaSYUivpWP9+LxPOljgG8lGP+21GxAJZAX1ACqtz6RrBYYjhM658elfDkSHEJwrzlEkd3f2Lv0snNaTQ9P2SOtTwukmvCD5OlFYAFcxTHgl409Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aKwAJUwI; arc=pass smtp.client-ip=83.246.65.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate15-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=+xF4bO/fTs8QrjNJoxW4GipCjwad45AsUDQqmvp/V/s=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763383027;
 b=ihBDoILBomJoX1TiFwNp5uxmaMmN2JPybAXqbyjFie+qbLA08bna06gE8yRnZYlDKs/oPZqG
 xZen5ds74fYjyVXahXoQcvTGJ++8RMP1T+l7TIuHGWkRE/Uo5CQs680nYZ1CnMIWWGePiiRJS6Z
 k295F3+nb8hRvcwU8k1gkkajRLy88OO+odkZW4XkLvirwOCfnLjK7OuyvScCrSCV3rWHXGaIoet
 r6fmWlBmrT7+sq1MAfeuCQoTFyVmYhq8xLSPp9WUyH4IFgHXamUziqGno5Zzee/Iqxv/kugPs7P
 ubOZ3MLKQVT9T/aAjP9LEmVWbFDjNZa+xEB68+kaUWDYQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763383027;
 b=pzIvvuAtsSDhtfWeSbIc37AdZxLO6+yEC//hBaL95C/TO7D/5MmbB818IUF95zNZPizuzaCv
 z5qS4X8kivPt9R6MBAmVT+pOCV1zt/in4+cxOJQpUhH9PLkETySMa8Mf8P5j/g14i5YhBHLWe4z
 YEEIDqYKGw+Yvr+m4uPYm6inFo8nu309jejgJPiiFS+03Qpz9ktFZ9J8QdfCM2EXiStVeWv40Mj
 qlkk4W4ZUv/44+RS3xnixLOwGGO9dMEgRHRWA3feQ3x5ykMsiFw84NP220JPK4qI7vP9Xy6kf0a
 mEHJrzyAVsGbNRv/1vi+n1GXj+HLAXltGXc+t9l0LJwrw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay15-hz2.antispameurope.com;
 Mon, 17 Nov 2025 13:37:07 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 1F7C8CC0DBA;
	Mon, 17 Nov 2025 13:36:48 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Martin Schmiedel <Martin.Schmiedel@tq-group.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/8] TQMa8MPxL DT fixes
Date: Mon, 17 Nov 2025 13:36:27 +0100
Message-ID: <20251117123643.711968-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay15-hz2.antispameurope.com with 4d96gh6p7Dz2FbSG
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:328a4f074a2d613aa025241cbcc29309
X-cloud-security:scantime:1.739
DKIM-Signature: a=rsa-sha256;
 bh=+xF4bO/fTs8QrjNJoxW4GipCjwad45AsUDQqmvp/V/s=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763383027; v=1;
 b=aKwAJUwIpg1EDGe7FLwU3ev5TOW4AsbfKU2LkQROcocEIOvEw755lCn/hOo+r+O8WsGqTn97
 86x+wqJOevApNgkI6oVjMRYuiLl5LeUS2SIEiQwsA+EMyBJNjA8NwUMX+5nIAliGcGuX+5B31hs
 0NOgYrDUw+dGwWdgY76C8Zm50h+tYFP+88gVl7EoDQwELBzYkCSisZ5q7M/5tLdtql07N6tZOOq
 zezqIHw9vo4Xe4kGY2h9erUAe9JaO/q4mIv9cfb8QFNGh6mMHhYe14th7t+reh1vbxNpiLu4eyl
 GTp6DH3e302msSqQI2huKtw+uFiNZ/GKAOkWZxUyHInRA==

Hi,

this seris includes small fixes for TQMa8MPxL both on MBa8MPxL and
MBa8MP-RAS314. The ethernet IRQ type has been changed to level-low and CEC
pad configuration has been fixed to use open-drain output.
For both boards the HDMI audio output support has been added as well as
the ENET event2 signal on MBa8MPxL, which can be enabled using
/sys/class/ptp/ptp1/period.

Best regards,
Alexander

Alexander Stein (8):
  arm64: dts: tqma8mpql-mba8mpxl: Adjust copyright text format
  arm64: dts: tqma8mpql-mba8mpxl: Fix Ethernet PHY IRQ support
  arm64: dts: tqma8mpql-mba8mpxl: Fix HDMI CEC pad control settings
  arm64: dts: tqma8mpql-mba8mpxl: Add HDMI audio output support
  arm64: dts: tqma8mpql-mba8mpxl: Configure IEEE 1588 event out signal
  arm64: dts: tqma8mpql-mba8mp-ras314: Fix Ethernet PHY IRQ support
  arm64: dts: tqma8mpql-mba8mp-ras314: Fix HDMI CEC pad control settings
  arm64: dts: tqma8mpql-mba8mp-ras314: Add HDMI audio output support

 .../imx8mp-tqma8mpql-mba8mp-ras314.dts        | 21 ++++++++++++--
 .../freescale/imx8mp-tqma8mpql-mba8mpxl.dts   | 29 +++++++++++++++----
 2 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.43.0


