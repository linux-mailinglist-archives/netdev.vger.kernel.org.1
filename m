Return-Path: <netdev+bounces-53854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E7804FB4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AF62816FF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFF14C3D8;
	Tue,  5 Dec 2023 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="ZX/Q5NPO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE80A9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kD9lq9aclw/T1/ArjlXbOL6jV60eKkquYPwaXOg/diI=; b=ZX/Q5NPOS06V8Fdu8bMi3Xvlao
	jdShAqs3WZ3SxVkqyuLFhKgSUfUExxGsSgvX++6S+kON7YK63qGJw3mWYtkB4LNXrb+ahamnCJ+Gx
	JSU3i3VnITAdkHKNqePXmwnmarwUwY/mSsl9aT7K3TPkQeiBhhkkL+TlLDHYgr6/TMbntFpdpXcOQ
	z3vl+EsonfsHLc9z4Ygc0VRqYVHcRuOlbSok0M8O9l6SSBSLhUArf8Eh+TlInvSu51lU5YSoVvKud
	+7T/ivGKVJ73VqHWYghvDWZlF1rkNJc03fNZ+PFsnFFHGX5VWUBE3iAMbD7pXtU/IvWKv2H8/oguv
	uFgOX6SA==;
Received: from [192.168.1.4] (port=29461 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rASHN-0005TD-34;
	Tue, 05 Dec 2023 11:03:49 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 5 Dec 2023 11:03:49 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <marex@denx.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v7 0/2] net: dsa: microchip: enable setting rmii reference
Date: Tue, 5 Dec 2023 11:03:37 +0100
Message-ID: <cover.1701770394.git.ante.knezic@helmholz.de>
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
V7:
  - adapt dt schema as suggested by Rob Herring
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

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 34 +++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz8795.c                | 29 ++++++++++++++----
 drivers/net/dsa/microchip/ksz8795_reg.h            |  3 ++
 3 files changed, 59 insertions(+), 7 deletions(-)

-- 
2.11.0


