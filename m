Return-Path: <netdev+bounces-281614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNLaJtAk8GnvOwEAu9opvQ
	(envelope-from <netdev+bounces-281614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722647D036
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 05:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB5A63018BEC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553FA3176FD;
	Tue, 28 Apr 2026 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/USccQc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916C15ECCC
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345728; cv=none; b=qOPVB7ZvU78cd7PFPtnTRqiQD1DnV9WgHXv7u6ZrJ62d38i653ANQTBiFjkT6O8amFkLTOxXBQn1N+ya0SSJsKfQzKwiV9T4+2mWwjDus0WCJ+fLuYFLr4PCydbDH4e/+XFeuSTfnP+pYG1ZV55bkg3zPDOLjr1aq7QOJAmTQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345728; c=relaxed/simple;
	bh=58/SxyygshXwr02hHK/RwB8HspCENne0hR9jOMX8ceE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeXzNKKNNrbKV4HkBv0G1/tjQBF9YEMokRuyjwIOHU2j+032j9dtVDrNPwAez7UygGFVpc3q+2WRLtseT+rMKq0bbvSRIGQ2IpKnnt7kRipH7JV+1UafpgqJ3aKV7TlMzMrOw6pqe5dG+4GcgepJIk5mVXt5jqdKc/XjfXA2CaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/USccQc; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12c6df0b9bbso2019892c88.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777345726; x=1777950526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFKsY0zkP8TQm+0BNdc4CTwtYvq4U2UiY8lkQgxP8es=;
        b=m/USccQcC4ufknC1/lT1zZSAVOA4i8qOS4W6Lw2pxfE9fro4Df9tjs7UUsoWmmJRB0
         becUZqlg3UT9EgoTmAcXOMd/7KSLJQmAX/mvKk8Da7CAb6zGNGAkB5JsBHsFhSl/KeZs
         a3iZ4K/8fzK6nKRisdL4v9ZDXHDrOhuzwX145EEV0mFpTlearp0S9D+lmOO7D4683h7h
         tMQ6MNtOmx73ABXpcFuFi6UAdeaTXTGuOS65iYj7Vp2Gpy+2vgrssfGBLCNzXC0jhVrz
         yneeVnIZL9B3w10jBrtAiybqzJZa9iHcsRTXoOmssQ9F1790c3lfUcSj4u0Mhb1unPNw
         op+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777345726; x=1777950526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFKsY0zkP8TQm+0BNdc4CTwtYvq4U2UiY8lkQgxP8es=;
        b=LlpxrYIOSW28ia+rcc5j8UVR7W8QZX3xqxu7wwFw87eYppQGkDVXZVLrqzKrwcKtdV
         tUkhC6CR7qPBVLLu7UbuIOgGSwSoSYUDYRiU35OQgFXZG8uhEGbMC2HmP+TItRFuhXL+
         qUWVeVu9fVdzfOsiexJTujEOidCzk/1RBBQzb7k+DLA3yllCclBoa62jX534yM9SijFA
         2N1Nh8HWtYhkb+6OGMkXREsdju/0pxq2swsB8jfk92Bn3w2uS45D+JqQNSNyRbgQeQFg
         PojNpXDnRvWQR6+TIRw8NOdWGuaUquhocJld5l/o2cw4ZEKrNGApO0iPlZL6enWVy0Xe
         LiCg==
X-Gm-Message-State: AOJu0Yyny4PDJ+beCq/TFCYffZAZG9jOISprwnYU84kFptEnNRYzWN38
	FwqSNLuiNpwh+SWcNZOd46ggoPY6CyJlLzXQuF3cMHvKa8Mc2hGk35XhQ0lOq0Lm
X-Gm-Gg: AeBDietZoL+KIXe68zxkwaBAShekxTQnDLTyKgQlfDiP49F9CRSaq1nApZJcssSDHtG
	Bw4prVXaHFIi8mdCTaD5L2diM/CnV+XhFtC0h5dRr/+iF2CpplZ8g/0LaYdhmYhEerHfvYkzmkC
	hOrfGyjS6N+YG2dgLuxRuwFSzVWH1uLn7pBLltBa5RHNzG5uGiJPmd+3QdW+cFIx/EwpQ9otmF7
	BnicyWVF4rllAARgqlRr/kdD+tLxqj56iRQSaXCo8W+tWFN29Rgyw5e0bB+dP4pO8xLuAz8RqAk
	WOhtQkopa2ahKLEzfcfoTa3lm0DY/eNRjW6dDoyhVRq2CS9mCVVjbzhljvTavJDW0fubw30fMo1
	3NQnE5riBx+cuRES0oC4hcc1Ijz/R3/yxUGV54/CnQi5Yuh+eefEExnuwiKEuNWmXQ7s3jVBd4Y
	OtT97ROjuVXqcQ5rficEREnwt0Z70oMWE/MmxwZ8aGC1BDtirhTmYlz6nmfoeTE6MUgtQWhX7pA
	qwG4o0P3jk7O6tOs0G0ECNhw9w7GHA6pRXzZJJQYN3ezGlRcgaheUy3x0Me+QeFtVkHIQc1kyDo
	WeBPJOhQQe7Pf/PDwByEWpEi1BYe
X-Received: by 2002:a05:7022:f94:b0:12d:c9b6:bbba with SMTP id a92af1059eb24-12ddd984193mr789914c88.8.1777345725911;
        Mon, 27 Apr 2026 20:08:45 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd8951edsm1256362c88.0.2026.04.27.20.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:08:45 -0700 (PDT)
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
	MD Danish Anwar <danishanwar@ti.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH v2] net: ethernet: rnpgbe: mark nonfunctional incomplete driver as BROKEN
Date: Mon, 27 Apr 2026 20:08:25 -0700
Message-ID: <20260428030826.47509-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0722647D036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,mucse.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281614-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
Changes from v1: Do not mark vendor section as BROKEN
 drivers/net/ethernet/mucse/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
index 0b3e853d625f..810fc1230d97 100644
--- a/drivers/net/ethernet/mucse/Kconfig
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -16,12 +16,14 @@ config NET_VENDOR_MUCSE
 
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


