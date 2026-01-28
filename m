Return-Path: <netdev+bounces-254264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG+6JOMTemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:49:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3576A24AD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC099302BE24
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D3935EDD2;
	Wed, 28 Jan 2026 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="bIK2GdXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A811350A3B
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608092; cv=none; b=LET0AzxV5En9HwxTDFmujDaqnLzCr8GS3WB6ylihnht7lpVtpEBiEK/MtIzwBLYW2aafLcVGU3Scy1kX7ogrUgZ+kCdAHpHJCDNL5AShYb0+4QkKCav9jlkbt1xpmbfYXSTvfv+T6Hblq52D+htsYrxwOsIRXJ/qN/zQst3WonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608092; c=relaxed/simple;
	bh=c2aLOBMj/ufy4HJDaWIuwuW9HHjACYHfUy26L4y0iNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3yuRFUtbWlXVYjmpZ7H5oKV3iD5kLqpnhkUYmWV0NPOv2M1UB24b9Cq/x1689BVJa8tolpeCTey3CIc9AZza0AeujhFy43BIOYTXexyU94I9nnFzbi3khkVBWfqnFn1MTWYgZqI/jvRBFWFFNY8LQdY11KbGjRuWqb3j5bR7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=bIK2GdXC; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3ABB5EAAF9;
	Wed, 28 Jan 2026 14:38:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1769607542; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pazKv2dYTA9HZXmk/6LbmIvOQ29ZrenFyD1Q4vFlZ2g=;
	b=bIK2GdXCkcIEU/TKkOxGV26UY5+rOMJHiDfkzhv3fhW5ikyAPG+QG2UvwrbgBg2O4QJhud
	vg8j6pJalcJWyXeLeh5xosOmt6X/49nEj4a9CriT0wpNdFQwAKyplR7VAoBjdqmzD3gHO4
	+QN3Xk+tG5hZjmfoK9KhkJpHlIVmPJMNqH4tE201E95MHC/FqWI4mQbO+HxpIs4BTty62V
	fJpscJi15aaSAR+Ewd5pKsKowWmXCDwy3b81e2o2Vlk4bEmeuuRA2UASR+Gyl1ZdkvTzvR
	eKudykc2P36WgNxZHJRVmKrx3CJ5KYXst8RxxljDBfsJggHuoxfPTEbMdAvtzQ==
From: Heinrich Toews <ht@twx-software.de>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH net-next v1 0/3] net: dsa: microchip: add single-led-mode support
Date: Wed, 28 Jan 2026 14:38:30 +0100
Message-ID: <20260128133842.1173406-1-ht@twx-software.de>
X-Mailer: git-send-email 2.52.0
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
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254264-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[twx-software.de:mid,twx-software.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3576A24AD
X-Rspamd-Action: no action

This series adds support for single LED mode to KSZ9477 switches.

The first patch adds the YAML device tree binding documentation for the
new 'microchip,single-led-mode' property.

The second patch implements the mode configuration in the ksz_common
driver, including a necessary hardware workaround for Errata Module 19
(DS80000754F), which requires an additional write to a debug register to
ensure proper LED activity.

Heinrich Toews (3):
  dt-bindings: net: dsa: microchip: add microchip,single-led-mode flag
  net: phy: micrel: add flag for KSZ9477 LED erratum
  net: dsa: microchip: add single-led-mode support for KSZ9477

 .../bindings/net/dsa/microchip,ksz.yaml       |  6 ++++
 drivers/net/dsa/microchip/ksz_common.c        | 34 +++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h        |  4 +++
 include/linux/micrel_phy.h                    |  1 +
 4 files changed, 45 insertions(+)

-- 
2.52.0


