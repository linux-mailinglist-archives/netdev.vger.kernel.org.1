Return-Path: <netdev+bounces-215985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6740B313D4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732C81CE09D8
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2FE2F068F;
	Fri, 22 Aug 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YVEY+EGo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lDGNN0xy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YVEY+EGo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lDGNN0xy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4DB2F0C5E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855326; cv=none; b=b41DUyLoW1axWXWDojGSKPORL77si3lTwXY7JEfBGnAiyhaNZXAn0vDaCCe3ceoOi0lP/nKv+RKvyPHb13tsAB6WuarXOMtwmLmsKxmJHRcny2b44uNF4/SDaF6CS0pQjC8dmzrcMNPChp/3hgULiEu2oOfst1oCdSOm9yAKsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855326; c=relaxed/simple;
	bh=OhLxGYmzLz43B+BARBrmxI4TLbEHeKkSt4JR6uQmzcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ5trDmuZnAORGsw+trlKp/XPMSbVhREfIVXMZfzarLJCbfBd34MMwEnJWZn2KQh+VX6X4KxkHI0/wo+0zyPRKptp7fmONvIFnROJxwA7eLVA9D3dp2mgFINGMqwPmp4gb7x6zlELk8g3o6q8v+lHDWaJ0+uIJ/Cr2m6nhw5GWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YVEY+EGo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lDGNN0xy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YVEY+EGo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lDGNN0xy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 382FE1F445;
	Fri, 22 Aug 2025 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/1S7DDo5ejBxzJdRig49Rht9iTPiAfim4WL9ZDXSqU=;
	b=YVEY+EGodZKOmVAVQ0gO2Ch0wCOuQ8tkiZKsZEHzP7rDC6aFp9R69INz0Q1fZBIyryz0iT
	qs5WOUDYB6VesUBZmcx7MNxFvjKcqK952rR0gBFrXQsYiSkvoFscRLOGaPW89jCoU/Bvq1
	7jqdy9kgoZYJbmOJvlyf7F3SOzGAqLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/1S7DDo5ejBxzJdRig49Rht9iTPiAfim4WL9ZDXSqU=;
	b=lDGNN0xyT0vUW7cYQ1+/IbmDMlmD6z38FKMKU2aJkdg7yD9Sa9pOE69PuRRKQPnT0BycV/
	ON0Qkf5e1ohdTdBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/1S7DDo5ejBxzJdRig49Rht9iTPiAfim4WL9ZDXSqU=;
	b=YVEY+EGodZKOmVAVQ0gO2Ch0wCOuQ8tkiZKsZEHzP7rDC6aFp9R69INz0Q1fZBIyryz0iT
	qs5WOUDYB6VesUBZmcx7MNxFvjKcqK952rR0gBFrXQsYiSkvoFscRLOGaPW89jCoU/Bvq1
	7jqdy9kgoZYJbmOJvlyf7F3SOzGAqLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/1S7DDo5ejBxzJdRig49Rht9iTPiAfim4WL9ZDXSqU=;
	b=lDGNN0xyT0vUW7cYQ1+/IbmDMlmD6z38FKMKU2aJkdg7yD9Sa9pOE69PuRRKQPnT0BycV/
	ON0Qkf5e1ohdTdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BB3B139B7;
	Fri, 22 Aug 2025 09:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AO1kCNE5qGihMAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 22 Aug 2025 09:35:13 +0000
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
Subject: [PATCH v2 4/5] arm64: dts: rp1: Add ethernet DT node
Date: Fri, 22 Aug 2025 12:34:39 +0300
Message-ID: <20250822093440.53941-5-svarbanov@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30

Add macb GEM ethernet DT node.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
index 5002a375eb0b..6bdc304c5f24 100644
--- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -39,4 +39,20 @@ rp1_gpio: pinctrl@400d0000 {
 			     <1 IRQ_TYPE_LEVEL_HIGH>,
 			     <2 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	rp1_eth: ethernet@40100000 {
+		compatible = "raspberrypi,rp1-gem";
+		reg = <0x00 0x40100000  0x0 0x4000>;
+		interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&rp1_clocks RP1_CLK_SYS>,
+			 <&rp1_clocks RP1_CLK_SYS>,
+			 <&rp1_clocks RP1_CLK_ETH>,
+			 <&rp1_clocks RP1_CLK_ETH_TSU>;
+		clock-names = "pclk", "hclk", "tx_clk", "tsu_clk";
+		local-mac-address = [00 00 00 00 00 00];
+		status = "disabled";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
 };
-- 
2.47.0


