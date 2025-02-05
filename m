Return-Path: <netdev+bounces-163130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C5A295EF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261AD188156B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C459192B90;
	Wed,  5 Feb 2025 16:12:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B5149C7B
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771937; cv=none; b=S/6QPhmn32kgLWtKEd5T9owjk5gAiSJSSt3Ji8Rsjpf8Dmj20v6WWyUbyOUnMlwTQE7NVAleCoYGmpDSnrVkBnaKew8lqZi5aPEUw+7DaYtF8gXhtDCsgq+lHIf4rajzsZUUXjIxuMFj4Pqnis6SqMQQUcljRa33qt19W9ZCOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771937; c=relaxed/simple;
	bh=K9irMtaEYFX//7NJpgii0w03K4sA+S9bXyBQt9yABg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptkVv3/xYK1fX2CCZmlV5RWHb/U0GfQ3cD5gOwRbur+4ym4eVoPRhmsEJI47ztvUi+nyyHBPV1S/hDO9iOKPaZDCjFFDicPGm6S68V+7wByi+ptCcrq5U5c1vi7nCAa9p76+Nyhn1ysv2V4glU5X+B/gt/M3xTq2NImssZ5O0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fa11:c14e:2df5:5273])
	by andre.telenet-ops.be with cmsmtp
	id 9sCB2E0083f221S01sCBB0; Wed, 05 Feb 2025 17:12:12 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tfi0N-0000000FwpK-029M;
	Wed, 05 Feb 2025 17:12:11 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tfi0Z-00000006dib-0MDQ;
	Wed, 05 Feb 2025 17:12:11 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next] net: renesas: rswitch: Convert to for_each_available_child_of_node()
Date: Wed,  5 Feb 2025 17:12:09 +0100
Message-ID: <54f544d573a64b96e01fd00d3481b10806f4d110.1738771798.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify rswitch_get_port_node() by using the
for_each_available_child_of_node() helper instead of manually ignoring
unavailable child nodes, and leaking a reference.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on R-Car S4 Starter Kit, which has port 2 disabled.
---
 drivers/net/ethernet/renesas/rswitch.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 84d09a8973b78ee5..aba772e14555d308 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1287,17 +1287,14 @@ static struct device_node *rswitch_get_port_node(struct rswitch_device *rdev)
 	if (!ports)
 		return NULL;
 
-	for_each_child_of_node(ports, port) {
+	for_each_available_child_of_node(ports, port) {
 		err = of_property_read_u32(port, "reg", &index);
 		if (err < 0) {
 			port = NULL;
 			goto out;
 		}
-		if (index == rdev->etha->index) {
-			if (!of_device_is_available(port))
-				port = NULL;
+		if (index == rdev->etha->index)
 			break;
-		}
 	}
 
 out:
-- 
2.43.0


