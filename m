Return-Path: <netdev+bounces-66514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE0983F98B
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 20:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E7E2824EB
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 19:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF2321B0;
	Sun, 28 Jan 2024 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uPCpuVrs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7AE1E4A8;
	Sun, 28 Jan 2024 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471516; cv=none; b=hAvwM70iS+yBqlzfOAHJJO82SpVn6KhnaAkKCOLfkQniTI+SHXQdhXc3H3MeydlE74Nk1KwiNlq1gvhK6aTeYnH+EhHbXyrLrPbpreEZJhPkDlaQEk7gJE6wspgHvLnX1PWmcV7woc1nnxFZAjxxq2sbuKF4yRrvKRyfgGy62tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471516; c=relaxed/simple;
	bh=lLilySja1+gc0vAWoFafuKa9MQjftBe1Lq4AAaEBby8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=orXgTYmq8OHMDJwlTaH+njaMVBlu2fvzKLo2atxsH3aFDZfyI1W+Mn+6vJ2xEN7jYdmytKuigSzK+5gumfQTKbEAgyrMuXzgZd0yNnYs4AjlOF6hbvySw61eOGOBj31gNxDzSxoO5Fxq7afT6nGM9P+Pa2gsEPXAujrP3vZ9qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uPCpuVrs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706471515; x=1738007515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lLilySja1+gc0vAWoFafuKa9MQjftBe1Lq4AAaEBby8=;
  b=uPCpuVrsJHf4raNSdf87QdrOG+ea0SOvRHoOB6j6/1G9FqIofDMasJLJ
   Hh4aL604EB3gXfVqAfuVyW4HYEzRj+W7daL4P0aAXbW+T+upRhlF9ozA5
   eIlGYFvUoQVazEXXRZKYWJdukcHBJCa8ilIFpv6W0t/CBuqrcQmuXXdhX
   d9zUSPFUTrg6O7LWHrsGTyb+0wSeia1yZkDB7Fy78nxY2OvCeIXSY3Ia3
   VnuBCZdcJKY5r3MejxOpLsitcYwXmUUAMeKUnZVWK4GoUhmqUzjWYZB+C
   053qiX7eykYJ0jbaNFYvaP4hjU7Xi3noneEwuIFwN1+P3oj6BtS8px3vX
   Q==;
X-CSE-ConnectionGUID: HmkKQebqTiaf2PC3A5r6Ng==
X-CSE-MsgGUID: 66EsYmfdS92wC7EMm983ng==
X-IronPort-AV: E=Sophos;i="6.05,220,1701154800"; 
   d="scan'208";a="246137979"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2024 12:51:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 12:51:39 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 12:51:38 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: lan966x: debugfs: Fix showing the port keyset
Date: Sun, 28 Jan 2024 20:51:34 +0100
Message-ID: <20240128195134.3600629-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On lan966x, it is possible to use debugfs to print different information
about the VCAPs. Information like, if it is enabled, how the ports are
configured, print the actual rules. The issue is that when printing how
the ports are configured for IS1 lookups, it was parsing the wrong
register to get this information. The fix consists in reading the
correct register that contains this information.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_vcap_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_debugfs.c b/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_debugfs.c
index ac525ff1503e6..3a01e13bd10b7 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_debugfs.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_vcap_debugfs.c
@@ -25,6 +25,8 @@ static void lan966x_vcap_is1_port_keys(struct lan966x_port *port,
 	for (int l = 0; l < admin->lookups; ++l) {
 		out->prf(out->dst, "\n    Lookup %d: ", l);
 
+		val = lan_rd(lan966x, ANA_VCAP_S1_CFG(port->chip_port, l));
+
 		out->prf(out->dst, "\n      other: ");
 		switch (ANA_VCAP_S1_CFG_KEY_OTHER_CFG_GET(val)) {
 		case VCAP_IS1_PS_OTHER_NORMAL:
-- 
2.34.1


