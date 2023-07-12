Return-Path: <netdev+bounces-17333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669DA7514BF
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 01:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2175C28106A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F451D300;
	Wed, 12 Jul 2023 23:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899341D2E8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 23:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6781C433C8;
	Wed, 12 Jul 2023 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689205579;
	bh=9qx22tB4mpdqCcRXiSQ1VQK+h0T6kKIZwwo2QtycCpM=;
	h=From:Date:Subject:To:Cc:From;
	b=acHeiXovv2tl8SFH5wp5Dg3dGylBw81PDDpOeHfKsmM+vktuFCBlPCNrd141EkSlc
	 1ulWf3qg9tDaQdT7SXqyDlnxp+eag6MNly5Hhf/q/35agJC/XksyLypRjPaP2afLex
	 6YKkeXGOOXQNx0a2HJmoZjBQVspra7tK6IBXC/D9OSRdbXDG7Sm0VSe+2JrXFXBDPa
	 QFePJDxEF+8I6PPwQq9hIOg56lEdJumUS9RFT630u5ExE+NfEJWGYgPWsk5AumGl+w
	 eTQgm2dW+X23RL4Z912FRpuoFqu2JUX9Zrzv/vAKjixnkWfdhnidGZt/Vac2vDLjyw
	 eaI0jnx+H1qOg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Jul 2023 00:45:58 +0100
Subject: [PATCH] net: dsa: ar9331: Use maple tree register cache
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-net-ar9331-regmap-maple-v1-1-bffed9f09da7@kernel.org>
X-B4-Tracking: v=1; b=H4sIADU7r2QC/x2MSQqEQAwAvyI5G+jFLX5l8NBo1MBMK+lBBPHvN
 h7qUIeqCxKrcIK+uED5kCRbzGLLAsY1xIVRpuzgjPOmNR1G/mNQ8t6i8vILO2a+jFTR3NhqdDU
 R5HpXnuV8z5/hvh8d4NSvaQAAAA==
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9qx22tB4mpdqCcRXiSQ1VQK+h0T6kKIZwwo2QtycCpM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrztGUqrsjUoIl/NxV2tU4RDUVFhWGGrP4TPLU
 ufyns+hLzSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK87RgAKCRAk1otyXVSH
 0ENzB/96urJr8Khttq8xAfkIYpHuZaurFBPazWX2J+rrdJ/FLjCk6O1hDwBCy4j9HBn0PzdOxXo
 Y5V2CRCoT6cSeULcbjEIVLU/gCI9AtGsJfiQXNJuWDTN4v0rq9ReZrvdj1Ca94Xyd8r7CVk0nNg
 4AkBoB9R4gco3oVIkmSDrlQBdcNjy0kEUUU23zln8ui3nOwJEQZh5pmAEmKHfS7PmZ/KV+b2WRH
 Oosf2f7tg3U1BRkGlIj6UDUONNnsh8B4ZU0s/hjzM3aiAkN7aHxvxwZl1s/SF1TsDtc01HSSDa2
 JQj9jUr7uaSjYb+rszjhRRcapkzrK4kFPMkwDJC3U/uJZWj4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We now have a regmap cache which uses a maple tree to store the register
state, this is a more modern data structure and the regmap level code
using it makes a number of assumptions better tuned for modern hardware
than those made by the rbtree cache type that the at9331 driver uses.
Switch the ar9331 driver to use the more modern data structure.

This should have minimal practical impact, it's mainly code
modernisation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/net/dsa/qca/ar9331.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index b2bf78ac485e..72730dcc9ca9 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -1010,7 +1010,7 @@ static const struct regmap_config ar9331_mdio_regmap_config = {
 	.wr_table = &ar9331_register_set,
 	.rd_table = &ar9331_register_set,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static struct regmap_bus ar9331_sw_bus = {

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230708-net-ar9331-regmap-maple-949f614c2599

Best regards,
-- 
Mark Brown <broonie@kernel.org>


