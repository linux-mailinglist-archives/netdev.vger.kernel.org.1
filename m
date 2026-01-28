Return-Path: <netdev+bounces-254263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL5QC9ETemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:49:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81DA24A6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3C6302A2D4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137D350A3B;
	Wed, 28 Jan 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="QcwLbjx4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032E35294B
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608090; cv=none; b=SCxw5zs1jZ6gOfcyDtXne8JYuHjTSKe99IRkcscfFgiN8jJH35ye0ZUOipjh5UG6HaIZX5O1sn+cw0Uwq/Rdr4CojI5W9hG+XdSMncW/Ox0CgMOwBPxoJF27gIH7ZT0jhb95P75Tvg1v07MSznCDDK3+WbXb5g7JnIuuG+HT+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608090; c=relaxed/simple;
	bh=hldVqX3Quk7giyVzykrfz86LE13bs5CDvO4VOUko7KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9FMYBqumKVBm7R3M7HnZVB4CkD0wjaVVgKt51OBPXc2S4KkfZz52CccXp+UM1q8FmtDjnm2E3pXGPFIxqc5pDLW9+rja6oWjC7xi8NDFBuA65eMIptDn8sKCtUNqcb8k+YDf3EKbQSycy/IGGfRpCrXBiPF3XS/4a+3KlPwmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=QcwLbjx4; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35BD55EAB00;
	Wed, 28 Jan 2026 14:39:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1769607545; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z68UtEQ6cKL/RoAlYP3zKb10sL5Xk9ZL0geCebXXneM=;
	b=QcwLbjx4t22x5NQJYPFxG99b2gdLWrh3FNYXVNXFSZ2ArMj7wa4LvSeUvqGNuOroKCVwL3
	fBF/JvyAEW/vomW6BQqh7p9426ntnQxmvxaNJCw2CZoPwnZa1bA5iA3EwWEbrnjV9xV3+2
	PlGDKwx2MBirWJ4SCFLwqTK71ahdjMXFb6c2Ir75x+0R9EjzDIvyPfmFJeQhaYphb8bCzw
	BXAWPpzk8V35UdqW5I0+7ELyR3nDGrfi8wjokDmgPISxaYRC0vfSxclAuxN3xPMbin89/a
	ER0siJv6NzjGQ0ajLgF4HQdToBtXx2cZRFfNYts5adBYZiFFNY4TCBP9Gwpv3g==
From: Heinrich Toews <ht@twx-software.de>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v1 2/3] net: phy: micrel: add flag for KSZ9477 LED erratum
Date: Wed, 28 Jan 2026 14:38:32 +0100
Message-ID: <20260128133842.1173406-3-ht@twx-software.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128133842.1173406-1-ht@twx-software.de>
References: <20260128133842.1173406-1-ht@twx-software.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[twx-software.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254263-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ht@twx-software.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[twx-software.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twx-software.de:email,twx-software.de:dkim,twx-software.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B81DA24A6
X-Rspamd-Action: no action

Add a new flag MICREL_KSZ9_LED_ERRATA to indicate support for a specific
LED erratum workaround on Microchip KSZ9477 switches. This flag
will be used by the DSA driver to trigger a hardware-specific register
write required for correct LED activity in single-LED mode.

Signed-off-by: Heinrich Toews <ht@twx-software.de>
---
 include/linux/micrel_phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index ca691641788b8..1dcbb0c93d9e1 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -45,6 +45,7 @@
 #define MICREL_PHY_50MHZ_CLK	BIT(0)
 #define MICREL_PHY_FXEN		BIT(1)
 #define MICREL_KSZ8_P1_ERRATA	BIT(2)
+#define MICREL_KSZ9_LED_ERRATA	BIT(3)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
-- 
2.52.0


