Return-Path: <netdev+bounces-215986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 337BCB313DD
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1420A1D00806
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950442F6563;
	Fri, 22 Aug 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FUlBe9oD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XYDerVas";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FUlBe9oD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XYDerVas"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16C2F8BEE
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855332; cv=none; b=PaitqFT3zBWnPhfbgoh0PnH21jhwN/9Gib5AcWw7RAMglDfDNbMAGIhYD30pEtPi+zT8aMA4z/LDwqjeoHzMu1X+aEGaSfEtehJ8dGiMoSC9LXvTw35aIyKfobkuRTkVL5ry7hCtK/pDffJbFsXb3gkqhn0XAdG8bgkE1dZMoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855332; c=relaxed/simple;
	bh=eSnmXWts4lneydS0K/gTCRVPllwqwqUG5QtbWvHQzRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d36N3QXKQ5/oO09Ylx+tkiErCdqkmzv5Jfd6DCPmFwg7LTG1xA5wWi3hlUedcQIHab+T29wtvCqk/0vVF64dX6OrM0O4vlpYdbwFANK8SxB6tjCyN82aIg9/c4gvud+qGphOL2OayOuxzDFVzHJDvgzrtEMDsVHHvMTB2rTEia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FUlBe9oD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XYDerVas; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FUlBe9oD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XYDerVas; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CB4221EF7;
	Fri, 22 Aug 2025 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3cvBSh7xfmCgersmZjZ++hf/VLsBTmIFoCXCaq9iVA=;
	b=FUlBe9oD26o0XZdtDyHCgjBg62Z0OGVJO5zSxXGPr7Wz8cTYQnTti9yOvKF/S3OB/VDugC
	tunprtW+mUJyBNWWyo0gHHlZRr3ZxpTMPjaZDX7Fp6G0rdG8hEeAH9kHuxivjZFbQ9fvUk
	82Sgu1aMjrUsG9rq8MJLy0jjFDvPomg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3cvBSh7xfmCgersmZjZ++hf/VLsBTmIFoCXCaq9iVA=;
	b=XYDerVasOgVrlHTFHZVf9HKe46rgSqVEXgEyQ84aN+Nwp4pV3qm0CZK7iOMIM5f9RIg9vP
	pcFtzOSdxAjxNMDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3cvBSh7xfmCgersmZjZ++hf/VLsBTmIFoCXCaq9iVA=;
	b=FUlBe9oD26o0XZdtDyHCgjBg62Z0OGVJO5zSxXGPr7Wz8cTYQnTti9yOvKF/S3OB/VDugC
	tunprtW+mUJyBNWWyo0gHHlZRr3ZxpTMPjaZDX7Fp6G0rdG8hEeAH9kHuxivjZFbQ9fvUk
	82Sgu1aMjrUsG9rq8MJLy0jjFDvPomg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3cvBSh7xfmCgersmZjZ++hf/VLsBTmIFoCXCaq9iVA=;
	b=XYDerVasOgVrlHTFHZVf9HKe46rgSqVEXgEyQ84aN+Nwp4pV3qm0CZK7iOMIM5f9RIg9vP
	pcFtzOSdxAjxNMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4660C13A31;
	Fri, 22 Aug 2025 09:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wK3sDtI5qGihMAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 22 Aug 2025 09:35:14 +0000
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
	Stanimir Varbanov <svarbanov@suse.de>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 5/5] arm64: dts: broadcom: Enable RP1 ethernet for Raspberry Pi 5
Date: Fri, 22 Aug 2025 12:34:40 +0300
Message-ID: <20250822093440.53941-6-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250822093440.53941-1-svarbanov@suse.de>
References: <20250822093440.53941-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30

Enable RP1 ethernet DT node for Raspberry Pi 5.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index a70a9b158df3..c70d1cb7f3b6 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -23,3 +23,21 @@ &pcie1 {
 &pcie2 {
 	status = "okay";
 };
+
+&rp1_eth {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&phy1>;
+
+	mdio {
+		reg = <0x1>;
+		reset-gpios = <&rp1_gpio 32 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <5000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy1: ethernet-phy@1 {
+			reg = <0x1>;
+		};
+	};
+};
-- 
2.47.0


