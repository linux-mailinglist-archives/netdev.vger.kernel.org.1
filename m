Return-Path: <netdev+bounces-51306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26BC7FA0CA
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAA728131F
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3E2DF7E;
	Mon, 27 Nov 2023 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="eyGif5MH"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793A1A1
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 05:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=T8MHjTPoV2bXyoEjCJWFYDBnYxYLxICLXIiFovq1D5w=; b=eyGif5MHW4zIdPOB7UdTnToNbR
	ycRwoGpvzE2hHhJ5JTKQnH0+hYht/YINqksmLZIKqLWAIhokMLqsv6JPn1N64klrow/kLG9my+FXm
	AMueSzcn6QuStM3SNbboXdgqmgGOZLdbjyusVGpXLE14j1LtXkOOROBWz08Gh9MXrlr1HS4WqdGYZ
	zPIfEgxIpWSoihnkE9ovTM1/ABuO4jIxE5GtQ58sJG+hBec8qyq6GlV+kFSWuoz0pguqER3HJ3V9q
	9eVDti4+pAU2dwYggv+/B3z7oQCWN5GfaFT7Q97O++5K3Qzsnr8BoWHOJbolInC8tUrkIQPEv+Ok0
	8NgjsW5g==;
Received: from [192.168.1.4] (port=38629 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1r7bXl-0008TQ-2y;
	Mon, 27 Nov 2023 14:20:57 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 27 Nov 2023 14:20:57 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <marex@denx.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v6 0/2] net: dsa: microchip: enable setting rmii reference
Date: Mon, 27 Nov 2023 14:20:41 +0100
Message-ID: <cover.1701091042.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

KSZ88X3 devices can select between internal and external RMII reference clock.
This patch series introduces new device tree property for setting reference
clock to internal.

---
V6:
  - use dev->cpu_port and dsa_to_port() instead of parsing the device tree.
V5:
  - move rmii-clk-internal to be a port device tree property.
V4:
  - remove rmii_clk_internal from ksz_device, as its not needed any more
  - move rmii clk config as well as ksz8795_cpu_interface_select to 
    ksz8_config_cpu_port
V3: 
  - move ksz_cfg from global switch config to port config as suggested by Vladimir
    Oltean
  - reverse patch order as suggested by Vladimir Oltean
  - adapt dt schema as suggested by Conor Dooley
V2: 
  - don't rely on default register settings - enforce set/clear property as
    suggested by Andrew Lunn
  - enforce dt schema as suggested by Conor Dooley

Ante Knezic (2):
  dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
  net: dsa: microchip: add property to select internal RMII reference
    clock

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 38 +++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz8795.c                | 29 +++++++++++++----
 drivers/net/dsa/microchip/ksz8795_reg.h            |  3 ++
 3 files changed, 63 insertions(+), 7 deletions(-)

-- 
2.11.0


