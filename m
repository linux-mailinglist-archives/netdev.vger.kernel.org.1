Return-Path: <netdev+bounces-281098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDaFJLBA7GlGWQAAu9opvQ
	(envelope-from <netdev+bounces-281098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 06:18:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA4464EF7
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 06:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9922301AB9D
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 04:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F12A277C96;
	Sat, 25 Apr 2026 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKY2cuXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173E218E91
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777090734; cv=none; b=nULLcArfRVzxEHMuDprxKQtc1TNoy7wpyXiANmk3W4SDwVqWWinmDm9dadKxl4tfGwqkOkHV2O2BX3qoPoCxqvrm1zoA4HH6FkVpd99GBcSX+vQ1BCSDxqqOpZRZEQBUUNjSzrKtiDitaDO/DsQHqT+Xwy37vDKdIEFu242Ohzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777090734; c=relaxed/simple;
	bh=yNpT5Ea2Wr3J9GcxT267OvWgxH4/6nsG8FyfORLoFis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IR1xYUXuqV5N6DuFoqTjZgfAbgtRpeZAIElZaEW24ZQjcWt/l8QfkeQ5bkuIDgpHgZb5B2HJxaAKtsFVKd1d5FhERm0GPvCPJL4GMkjMjLkcmXvZQevFTFKG4VhyLSpzbvtcJRKpqOBNt+xUskKrZkLGd8N2owy5L01DndQqhZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKY2cuXf; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12c637089ccso9835581c88.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 21:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777090732; x=1777695532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gs44N4+hU1RqCbEeT+Y1cdqZ7dnhS0LUOUZ5KW9aaJ4=;
        b=qKY2cuXf4pXkQJTCi4pY68aJeCqEqVoQzjWR3x3DujQYZW1yRwByWMF6gvBG1R3MC2
         9M2nE3SUPN/3BaC2nWK053oSVRCSWhnF/BzfG0LZ81ETWshYsWA3/pPosAyQrZSc41UY
         HkyJGuMP3ZR7+cRtA9wFQjNamJDqQgxwGb8onwnhtAAp3ITd2L4PoRI2LnaP41AG2ntH
         +uYmrl57WYMoDeL3FWaEMTJmtNpD79EboGAUzmm7zrr1aQcN+f2q2jyfoYYMEhdBGZ/J
         GU9R+iU1F307qQY6O6KJpcjRnvQB4L3AS9ApqR/SRv9FnDT023miPwVr2Vxs1yK8Bxq4
         zIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777090732; x=1777695532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs44N4+hU1RqCbEeT+Y1cdqZ7dnhS0LUOUZ5KW9aaJ4=;
        b=gkTGEshaiUfYSCvLBXuR4amy9gFZNeCn+XFSDoatzXNU+IP5Q4uZwvJ1JJN4UfaTBl
         i9TiHBEoYUtazLGGcI1tFFSJZ6ebh+hNdegQbC/4uJqBMR7cpRiAt2jVHoB0aQ1pMQgr
         6luz9XRqXtnZpoMdnCRJnDD8Tt8Q2ZLLzeSZl9gGhMV4o2glk7KFj/4rda6rFZNc64Wp
         q3OzHx0tZpvov8AH2YZnnfa02w/Cv//3OjN1ihtb4ZG45fEDVbgRG5neM+CFcJ0Tvft+
         8vzEVSZR6DawbHxgavgMGPmdgBhY8q8lap/x1sWtndJpUZqbrquidN3QeHKov8ffhDMy
         WG1Q==
X-Gm-Message-State: AOJu0YzcpOwW2qL7JfuoLiyDnvYs/t86wS00EM9XkOCRSDWVOMZ9FjMs
	36UzcGzXV/oflDzRESQF621MnMWvNqghzn0O2rAzmlgLVxLhijSnJoQQQzf/T0al
X-Gm-Gg: AeBDieuSn6IsP34Uu26XUTha6yFMft5YWeM8bwdUko83tcPvJSudTeGwjvIbuXTWIjq
	lOXHwIApnRSvSgopL2V6sh5Lyl/BClFWpc2oWE+ImxO00Aj1jmXWk/vMN4LeUbYhTyVWBe/C5/K
	oDiKyH5koTQtxZUJnZ5JDJN0Qcs25qHASo0g+KloSZFLxwyU7XyoZIiz9NeBENnOYwAtDILjw7g
	dyYpP5MN7PE6drgcNm/YcxxcsRygI2v+CUpjoqth//puP05tuTPeJjRpq5yMiPj373e56/1pPCs
	uXGZqx9SbU7SDZoz3A4OWydIrAKE0BcWv8NKRRfBzvvGWeE+lVuCeSfLieK4eXKAeFYJcNNnbO8
	gJmERD3aCvPgu8UKeo8JRdghbpblWulRbNf9eamIpwf20IBIKhJ8vAMYVXH+UydHduK7WTyeEE8
	lln/rtmWHINzLfPm09vfDtKgssEZbeB8l/12yKwoft9jrTHmAw+6Poc5n3bJqQNWGNy3X1WUfOR
	1O1cs0snTS3NspEBehj2xtxTMFNcdJwO0iR7e+SlO5ySVvzb6mTHb/GaFc5M4OjCtLR30kdDZYu
	LRhlJoy+BACOUErpYFJ/Q28n6Q3b
X-Received: by 2002:a05:7022:ea2c:b0:128:dbbf:fd35 with SMTP id a92af1059eb24-12c73fa3c01mr19002285c88.28.1777090731805;
        Fri, 24 Apr 2026 21:18:51 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c837f7feasm39678070c88.0.2026.04.24.21.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 21:18:51 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Yibo Dong <dong100@mucse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete driver as BROKEN
Date: Fri, 24 Apr 2026 21:18:15 -0700
Message-ID: <20260425041816.19070-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00BA4464EF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,mucse.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,ti.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281098-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

The rnpgbe driver as currently shipped in the kernel is incomplete and
has no useful functionality. It will bind to a PCI device and create a
network device, but that device does not function (its .ndo_start_xmit
callback, rnpgbe_xmit_frame, just drops all packets). This situation
means that users could enable this driver and have it load and attach
to their device but not transfer any data. To remove the potential for
user confusion, mark the driver as broken until it is completed and
explain why this was done.

Fixes: ee61c10cd482 ("net: rnpgbe: Add build support for rnpgbe")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/mucse/Kconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index 0b3e853d625f..c37a90a6c808 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -3,9 +3,12 @@
 # Mucse network device configuration
 #
 
+# This section depends on BROKEN because its only child item also does;
+# see the explanation below.
 config NET_VENDOR_MUCSE
 	bool "Mucse devices"
 	default y
+	depends on BROKEN
 	help
 	  If you have a network (Ethernet) card from Mucse(R), say Y.
 
@@ -16,12 +19,14 @@ config NET_VENDOR_MUCSE
 
 if NET_VENDOR_MUCSE
 
+# This driver is marked as broken because it is incomplete; this avoids users
+# enabling it and expecting it to work.
 config MGBE
 	tristate "Mucse(R) 1GbE PCI Express adapters support"
-	depends on PCI
+	depends on PCI && BROKEN
 	help
 	  This driver supports Mucse(R) 1GbE PCI Express family of
-	  adapters.
+	  adapters. It is incomplete and currently has no useful functionality.
 
 	  More specific information on configuring the driver is in
 	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
-- 
2.43.0


