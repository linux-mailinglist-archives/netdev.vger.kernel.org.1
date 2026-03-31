Return-Path: <netdev+bounces-273631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMJTDbzIy2mnLgYAu9opvQ
	(envelope-from <netdev+bounces-273631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB04736A052
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EE74305B482
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67AD3E3C5B;
	Tue, 31 Mar 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9YZCM+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B163AA4EC;
	Tue, 31 Mar 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962648; cv=none; b=dcJLHcQN+/gHhFHpkuU6lx3olPmAaHGgmPju/dQmiFJjzYffSdbVQgVox586v3A0fyUVFNNSy+Jp2OzbLSnhxXLPB6NU31Ki1oqd1N2t6UzZsgFxrlts5uKwgxKi+ytk5CvtjG+YGkPlNRFn+l0lvtPL5sg6mejPqqNPqNU3fWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962648; c=relaxed/simple;
	bh=H0eVMKEWi51A1OOnFbl4r5rkAhTgLqp8o3RwpipEpKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBgB6qn+Z1Pfyp4/8z1TVKVeUu+pnRXSIKveEToiAg5bXp/1C/q7pUL05wSG2DbR1QCvVuGbtTSpvMCPkH5jKUsrBUkRq3gbiEuOqKEqh+B674k4STrsNWEQEjPS+cNeD1JcjCAz36uNOwf6565S75fx0viQtldl5r8ugix5Ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9YZCM+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9772FC19423;
	Tue, 31 Mar 2026 13:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774962648;
	bh=H0eVMKEWi51A1OOnFbl4r5rkAhTgLqp8o3RwpipEpKY=;
	h=From:To:Cc:Subject:Date:From;
	b=l9YZCM+puP/uyhhRfSMUh+dBedmeyvh7H4LNp9JqVQ5qaZjZdTn8TbWvfGca3nT9Q
	 U3SFo+eYmiYBwAnAJ1yPP/CsOgDcCnv/GKmkaMpPMXuGH6xtxN+vud/psvx+n26pQS
	 VQHiUoJkJJon08lc9MtZC7oHExp9x/mInpJO4snchj5o90af6jj/K44qK0R7uvIpmQ
	 zGFwuz7/6Lt9vI17D7Qip1liGsoNLUiY5zSTu/xjXN5oP7yVnVmgm57tgL4sGwm/qi
	 hulicRD8oqAewXzvJ7TYnl93wFIxArRBQ3k0UJsF4fHrqdRvVRWLNUNe7l5o/B6YIn
	 mJmxr0rhaUosw==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	kernel test robot <lkp@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH net-next v2] net: macb: fix use of at91_default_usrio without CONFIG_OF
Date: Tue, 31 Mar 2026 14:10:21 +0100
Message-ID: <20260331-enroll-sensation-50901318a419@spud>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2898; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=uqiW7t5PqCoWnIG6QJ1cWBX3j3b9KsdAUQtWJ0U1YJo=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmnj+99+qdU3kXiVJNWc5Xenb+JmWbBX3LfPjaQC1+of 7Hq4ottHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhI1yOG//kfIzWn+YYv3N8V vXBG9Z8JHwsMDL8dvfJD6drO7RfY5s9lZPjLcKGF0eXt1It2j+ue8N86oL8tsjzv3sHrl96bpH0 36GIGAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273631-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email]
X-Rspamd-Queue-Id: AB04736A052
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Conor Dooley <conor.dooley@microchip.com>

If CONFIG_OF is not enabled, at91_default_usrio is used undeclared in
gem_default_config. Move at91_default_usrio back above the CONFIG_OF
section where macb_default_usrio used to be, so that it is unconditionally
defined and defined prior to any of the users.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603280028.wQjUrIvv-lkp@intel.com/
Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
Closes: https://lore.kernel.org/all/06a701dcc014$86def5b0$949ce110$@trustnetic.com/
Fixes: a17871778ee28 ("net: macb: rename macb_default_usrio to at91_default_usrio as not all platforms have mii mode control in usrio")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
lkp also reported this over the weekend, but against the dev copy in my
tree. I had thought that CONFIG_OF was standard off on x86, but I guess
it isn't, given lkp didn't catch it until randconfigs.

Seem to have come down with some sort of bug, hopefully I haven't cocked
this v2 up somehow in my addled state.

v2:
- Do the boring thing that works... Probably worth a revisit later, cos
  there's a bunch of confusing naming here still - "default_gem_config"
  is used for cdns,macb and of course "at91_default_usrio" is used on
  things where I am reasonably confident it shouldn't, like the Xilinx
  boards.

CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
---
 drivers/net/ethernet/cadence/macb_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 12e2b2f4aaf88..3e37b0a3e7e4b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4949,6 +4949,13 @@ static int macb_init(struct platform_device *pdev,
 		return macb_init_dflt(pdev);
 }
 
+static const struct macb_usrio_config at91_default_usrio = {
+	.mii = MACB_BIT(MII),
+	.rmii = MACB_BIT(RMII),
+	.rgmii = GEM_BIT(RGMII),
+	.clken = MACB_BIT(CLKEN),
+};
+
 #if defined(CONFIG_OF)
 /* 1518 rounded up */
 #define AT91ETHER_MAX_RBUFF_SZ	0x600
@@ -5523,13 +5530,6 @@ static int eyeq5_init(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct macb_usrio_config at91_default_usrio = {
-	.mii = MACB_BIT(MII),
-	.rmii = MACB_BIT(RMII),
-	.rgmii = GEM_BIT(RGMII),
-	.clken = MACB_BIT(CLKEN),
-};
-
 static const struct macb_usrio_config mpfs_usrio = {
 	.tsu_source = 0,
 };
-- 
2.53.0


