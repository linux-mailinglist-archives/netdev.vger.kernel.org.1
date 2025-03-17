Return-Path: <netdev+bounces-175164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2720A63C94
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 04:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CAB1883930
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566B218BBB0;
	Mon, 17 Mar 2025 02:59:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4751632CA;
	Mon, 17 Mar 2025 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180374; cv=none; b=JxYwxpLA1Wbm1+tCxgTyq/J9DHP/MWFuf9CfA1uw0ULdidxSIWejyZ1JOfJUjnC30B5VHRp1BA1NKHaxmKYkllzhhY1QrkDvC2Z73fe5uMiJ0bwuXMBKeGZDJakdC+2VcNMe76jMOkDUnLvDtufVUVZhgj0rl10D6qV+o+kfvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180374; c=relaxed/simple;
	bh=OlrK8n9wN6ZlgmgM3Qo0Mny89Cy8D8lpKSgp7NI962I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FUjtMB9yo9ivxfLPudNI0QFOEz+hFhXC0vGPvannE3TYMcirLpAiJbYp7EnrhZu36diERFvERzagx9QCFOcXUtoEwCEFXnCeNGViI7zyojdgeIndP6B1rsxhJO0LFYjLJ3KaNKQgaPWlAgIHjNc7cksAg0i8sEwvL+0sX2b1Iks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Mar
 2025 10:59:22 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Mar 2025 10:59:22 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ratbert@faraday-tech.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [net-next 0/4] Add AST2600 RGMII delay into ftgmac100
Date: Mon, 17 Mar 2025 10:59:18 +0800
Message-ID: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In AST2600, the RGMII delay is configured in SCU.
Add the properties according ethernet-controller.yaml into AST2600 dts
and dtsi, and add these in the ftgmac100 driver and yaml to configure and
describe how to use.
Now, just support for AST2600 and the other platforms will be ignored
the RGMII delay setting according to compatible.

Jacky Chou (4):
  ARM: dts: aspeed-g6:add scu to mac for RGMII delay
  ARM: dts: ast2600-evb: add default RGMII delay
  dt-bindings: net: ftgmac100: add rgmii delay properties
  net: ftgmac100: add RGMII delay for AST2600

 .../bindings/net/faraday,ftgmac100.yaml       | 16 +++-
 .../boot/dts/aspeed/aspeed-ast2600-evb.dts    | 12 +++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  4 +
 drivers/net/ethernet/faraday/ftgmac100.c      | 88 +++++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.h      | 12 +++
 5 files changed, 131 insertions(+), 1 deletion(-)

-- 
2.34.1


