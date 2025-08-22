Return-Path: <netdev+bounces-215982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37EAB313C4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E07B03D8C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EAA2F6179;
	Fri, 22 Aug 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dbrWpBop";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zi0z6swT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dbrWpBop";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zi0z6swT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F1E2F616E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855318; cv=none; b=i+xTpuIavXRsBoZACeW26+YFsR6040kLA7l97W5jWxYV6MmFNKK3X1L9302JARiNn1vLy6tv1vQcEruBF7cVi+oLtP27sQmo9S6esqNtcfY2S4CQBEA9BS2cOftesrP97bkyGAIkw4oOeC05pHMkQaHajE1109oxkUDT9vt3Xag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855318; c=relaxed/simple;
	bh=0eZBISu1sy54u8q87vkl2076gxRKS5osMWVlUuR7xGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9o0EFWBZ53Z68qQ68UnYD380pEnbnYumrYuuZTywFO0oA621NmKzsEWai9hCc6Ere4Pew6ZPzAltpVU5QVSyTKsJVbtesNKT1kadqpmoVBlIBKhgZnkoHlklQT63KPUW+14wPR1mODNmtFSBjus2RwR8xWPgGiO639N92Y8x2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dbrWpBop; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zi0z6swT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dbrWpBop; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zi0z6swT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F29D621EE0;
	Fri, 22 Aug 2025 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kS6Jm0pX+9aKxSOc86DV2+DLnuxx3u12QOfeFCRH/nI=;
	b=dbrWpBopZPlvr4x0XwSrltJeh/4Ii47r80IHIQVwQWLEGSvwbvldOk1uom7cpeXZ5QEOvL
	ibivTprtyJe/kkDqWULWRHkGNbO+TiCgPYFRxL7jscSWp6bAmxK1Cw2SHo3t8KzgyyZPh/
	DXjb9ZLFhVxz5l4Z8qI5bYI8ml6qIsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kS6Jm0pX+9aKxSOc86DV2+DLnuxx3u12QOfeFCRH/nI=;
	b=Zi0z6swTrVdP2dpko2xPGrV2jM+1hQ8PKPKDWLiKa47axqMDSshh4XxBOagMq10DNXwjGr
	zHXbohDBbS6RZDAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755855312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kS6Jm0pX+9aKxSOc86DV2+DLnuxx3u12QOfeFCRH/nI=;
	b=dbrWpBopZPlvr4x0XwSrltJeh/4Ii47r80IHIQVwQWLEGSvwbvldOk1uom7cpeXZ5QEOvL
	ibivTprtyJe/kkDqWULWRHkGNbO+TiCgPYFRxL7jscSWp6bAmxK1Cw2SHo3t8KzgyyZPh/
	DXjb9ZLFhVxz5l4Z8qI5bYI8ml6qIsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755855312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kS6Jm0pX+9aKxSOc86DV2+DLnuxx3u12QOfeFCRH/nI=;
	b=Zi0z6swTrVdP2dpko2xPGrV2jM+1hQ8PKPKDWLiKa47axqMDSshh4XxBOagMq10DNXwjGr
	zHXbohDBbS6RZDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA41139B7;
	Fri, 22 Aug 2025 09:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SIqRN845qGihMAAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 22 Aug 2025 09:35:10 +0000
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
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/5] dt-bindings: net: cdns,macb: Add compatible for Raspberry Pi RP1
Date: Fri, 22 Aug 2025 12:34:37 +0300
Message-ID: <20250822093440.53941-3-svarbanov@suse.de>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,microchip.com:email];
	R_RATELIMIT(0.00)[to_ip_from(RL7mwea5a3cdyragbzqhrtit3y)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The Raspberry Pi RP1 chip has the Cadence GEM ethernet
controller, so add a compatible string for it.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 559d0f733e7e..0591da97d434 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -54,6 +54,7 @@ properties:
           - cdns,np4-macb             # NP4 SoC devices
           - microchip,sama7g5-emac    # Microchip SAMA7G5 ethernet interface
           - microchip,sama7g5-gem     # Microchip SAMA7G5 gigabit ethernet interface
+          - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit ethernet interface
           - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
           - cdns,emac                 # Generic
           - cdns,gem                  # Generic
-- 
2.47.0


