Return-Path: <netdev+bounces-258860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FguMeH3kmlx0gEAu9opvQ
	(envelope-from <netdev+bounces-258860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:56:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604ED142915
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D113028013
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B063019B0;
	Mon, 16 Feb 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhIUclho"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F82DB7A9;
	Mon, 16 Feb 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239327; cv=none; b=c80dgYTOS4OTxwcHFahb5NAZd/COWz00Zgn4hoxqfEF0x78ArRDR2iwTV8RxTPqoCn6CSIVw7YpmbeHB+pFeb42Vm9xaFfQW/Jb206IFA11/ok4TDlZXnrEAphRl3XeNTWJ7BCVOFg6C9BZnQHLO9hICjJgaHaw770iNQPzIdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239327; c=relaxed/simple;
	bh=5ktwk1QxIa0pYDfddE4JUYhwp/NGcMljRGq1S4pSjj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0BGgIPI8S8Dk4e/AH50t1slw7WeCqStgsh3JpmKkxqQz7rKjt9PcT0EybuMmEBJl1LmxtkpAMa5tXQgcU7s1AjOoDRHgZs49J5eUNyntHrYvbIlTZhLoSJgJ7XndRkKAhUwCmrsEwoTSS4plqlT1Rh+X7kvOr0qnDgxddoh/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhIUclho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5654CC116C6;
	Mon, 16 Feb 2026 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771239327;
	bh=5ktwk1QxIa0pYDfddE4JUYhwp/NGcMljRGq1S4pSjj0=;
	h=From:To:Cc:Subject:Date:From;
	b=WhIUclhomQGlf2tdjINJPFvDxeJMS1G5aCt60IkAm5MyDxAc295j+2xMo0VqmwFis
	 LyDqPsMHljvvluuKjh3Z9MWyB9zQRMBTLcXoNBa4FfihwBk/JVyXbmO7UstS16pC0/
	 kosjMVJzRWIBDduPIyL9oFoiXAcCDKrCwG3+HJd5K2qYuq4OM7Tg5EwZHeTc+eByhS
	 2A52ArRQGxhYn0UcJhEB//YOLYcNsCMsdnuol+eCmoNJiijD8joZeMJQgThGdKM9zP
	 RV86W2+8sKgqKeYZuoggEryFfTmmz7vRHsdDsje04vzQwtpqN/bGTNl9boxByz7RMe
	 a+gP7QomxK0eg==
From: Arnd Bergmann <arnd@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
Date: Mon, 16 Feb 2026 11:55:17 +0100
Message-Id: <20260216105522.2382373-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258860-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,roeck-us.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 604ED142915
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The newly added dsa driver attempts to enable the corresponding PHY driver,
but that one has additional dependencies that may not be available:

WARNING: unmet direct dependencies detected for MAXLINEAR_GPHY
  Depends on [m]: NETDEVICES [=y] && PHYLIB [=y] && (HWMON [=m] || HWMON [=m]=n [=n])
  Selected by [y]:
  - NET_DSA_MXL862 [=y] && NETDEVICES [=y] && NET_DSA [=y]
aarch64-linux-ld: drivers/net/phy/mxl-gpy.o: in function `gpy_probe':
mxl-gpy.c:(.text.gpy_probe+0x13c): undefined reference to `devm_hwmon_device_register_with_info'
aarch64-linux-ld: drivers/net/phy/mxl-gpy.o: in function `gpy_hwmon_read':
mxl-gpy.c:(.text.gpy_hwmon_read+0x48): undefined reference to `polynomial_calc'

There is actually no compile-time dependency, as DSA correctly uses the
PHY abstractions. Remove the 'select' statement to reduce the complexity.

Fixes: 23794bec1cb6 ("net: dsa: add basic initial driver for MxL862xx switches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/mxl862xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/mxl862xx/Kconfig b/drivers/net/dsa/mxl862xx/Kconfig
index 4db7bab21a71..3e772298cc89 100644
--- a/drivers/net/dsa/mxl862xx/Kconfig
+++ b/drivers/net/dsa/mxl862xx/Kconfig
@@ -2,7 +2,6 @@
 config NET_DSA_MXL862
 	tristate "MaxLinear MxL862xx"
 	depends on NET_DSA
-	select MAXLINEAR_GPHY
 	select NET_DSA_TAG_MXL_862XX
 	help
 	  This enables support for the MaxLinear MxL862xx switch family.
-- 
2.39.5


