Return-Path: <netdev+bounces-214067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5885DB28118
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F303ACDE5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15733019DB;
	Fri, 15 Aug 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2OYHYrMC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WIaR5XEV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2OYHYrMC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WIaR5XEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC2301490
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266363; cv=none; b=WSjHQI6u+HR/1ja/IdY7+cIWnSxOtnBp3+sKu2lW2uGAACM9+uonDx8AlKAcRhh/lif1TAX8A/EblGbP/0QY2b3GDGBfsA2POZGCHJk6B6m/xqNOGSD9WZ+S46/Ze5GhX+kM1CZ4kZtAjaU7CSena/vleTGA7+1aGcbiPMgLCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266363; c=relaxed/simple;
	bh=AylT1EMI+auZWn/UrA5u4ddOYuCJ2yZU2jzDRl7KAOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nM+qy3XQmRXjBcHIXioqnjsvyfmpYKMzxtE3OPUbzTjMoqdEPPixxYrn0AcBXor97ZjqgBq34/ngZxFehNVdCoJ2tgbrxZ96hXGG3YuxtEC7UQyWPbPtmhAtDALC+cLgYPE4OYBGSXnCxZT3VZgjNat62MOExKFPGkVCb+45QNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2OYHYrMC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WIaR5XEV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2OYHYrMC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WIaR5XEV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C4EB1F83E;
	Fri, 15 Aug 2025 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755266360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eUeUWPqGxjDLTTrsBqDXhi7dC+CwV/JeiH2/GL5wANY=;
	b=2OYHYrMCky0gEl8GEezjU1lUB+6+cS+kSYJdzxHCgzpm/3AN3J4f433JAvwLltLML9MajP
	XHxAYGo5IjNAwP47zmC1WXVej09JlHzeIsIOL/ihBepuwOSVeAI+tvbGlJqee4jdz2xZfu
	FOARBUryNCgVauyQDq5EDARCsJ4TzuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755266360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eUeUWPqGxjDLTTrsBqDXhi7dC+CwV/JeiH2/GL5wANY=;
	b=WIaR5XEVxmwG3WY3qg4JTxvyQfD/LMJD3zAaScABW3C0EC+7HQ6FnG05xV6woKEnHqGh8l
	wBhRCWoro32gLsBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2OYHYrMC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WIaR5XEV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755266360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eUeUWPqGxjDLTTrsBqDXhi7dC+CwV/JeiH2/GL5wANY=;
	b=2OYHYrMCky0gEl8GEezjU1lUB+6+cS+kSYJdzxHCgzpm/3AN3J4f433JAvwLltLML9MajP
	XHxAYGo5IjNAwP47zmC1WXVej09JlHzeIsIOL/ihBepuwOSVeAI+tvbGlJqee4jdz2xZfu
	FOARBUryNCgVauyQDq5EDARCsJ4TzuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755266360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eUeUWPqGxjDLTTrsBqDXhi7dC+CwV/JeiH2/GL5wANY=;
	b=WIaR5XEVxmwG3WY3qg4JTxvyQfD/LMJD3zAaScABW3C0EC+7HQ6FnG05xV6woKEnHqGh8l
	wBhRCWoro32gLsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2642013876;
	Fri, 15 Aug 2025 13:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z1sKBzc9n2jMfAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 15 Aug 2025 13:59:19 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 0/5] Add ethernet support for RPi5
Date: Fri, 15 Aug 2025 16:59:06 +0300
Message-ID: <20250815135911.1383385-1-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3C4EB1F83E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51

Hello,

Few patches to enable support of ethernet on RPi5.

 - first patch is setting upper 32bits of DMA RX ring buffer in case of
   RX queue corruption.
 - second patch is adding a new compatible in cdns,macb yaml document
 - third patch adds compatible and configuration for raspberrypi,rp1-gem
 - forth and fifth patches are adding and enabling ethernet DT node on
   RPi5.

Comments are welcome!

Regards,
~Stan

Dave Stevenson (2):
  dt-bindings: net: cdns,macb: Add compatible for Raspberry Pi RP1
  net: cadence: macb: Add support for Raspberry Pi RP1 ethernet
    controller

Stanimir Varbanov (3):
  net: cadence: macb: Set upper 32bits of DMA ring buffer
  arm64: dts: rp1: Add ethernet DT node
  arm64: dts: broadcom: Enable RP1 ethernet for Raspberry Pi 5

 .../devicetree/bindings/net/cdns,macb.yaml     |  1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts      | 18 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi   | 16 ++++++++++++++++
 drivers/net/ethernet/cadence/macb_main.c       | 17 +++++++++++++++++
 4 files changed, 52 insertions(+)

-- 
2.47.0


