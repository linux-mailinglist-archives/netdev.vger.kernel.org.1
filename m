Return-Path: <netdev+bounces-252827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DF8O1xjc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:02:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75375837
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E92A0304CCEB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3431332919;
	Fri, 23 Jan 2026 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB7fQxBB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEFC2D0605
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769169691; cv=none; b=iBjd6MwQzJgokD6BgsQ9NVSKnBR7bF9/hnUhYYlfSBNZzu0ks9Iy+gy7XY8LwkDm0HecfqQStB97nSl57Yaa2XcXYGTK6Kw+gLCye8wYcHt2xwlKt7grPGLxwqYsrnAj3NOucE/Bpw+b8Jax+mqxmww4NJm05aW2Mj5SMOzXMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769169691; c=relaxed/simple;
	bh=Fnr+/duoHMuPJ117ZWVuREG3eoWw7+5BDvaWy0cYXpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrlb8gVUGdLG6SPtKIfJz/l2YVVPm46YF8WZlWPb5nXKrNlSMATF9m8XnRgJHWF8xQiGtL3ux1bycsQEYFnH6OMHS21jxa44pckPXP/gT5Fr+yazMjcpCqgd2lszxprtycSK7P+gRpinOohBv+CASNQbaAZgk8Dt5zu0+1EHzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB7fQxBB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so15685725e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 04:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769169687; x=1769774487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUZVKtVy7XchFYI5S1NHzhHg7zbZAcEeTMXVgGwqlGo=;
        b=aB7fQxBBI6SgTOHJYJSApcBaXPGkqchplphT4Dga/1AF3OCQGP0rbWwC8Ldv7BKn1N
         QZSeua0kMSgMc9PJelX1P08vmlA5r9CDQj8FoMxkC98psAb0WdNxhjukHv/6dOtBJKI6
         FZl2kJC3S1RIqdlSNuRIP/qbfYBNZsjp9GLuaiA0fj6VokItPBlm3BhQEcyPiihwOF0R
         GMLw+g43JfknSiBHt2jFM5BLLrQlSjp7VWgzE8p3ePatHaeXqblv63X2KWO1uq+mzatI
         ZYM2Oefgsdlx7UiQlIAQyZH6N5vC23VRihH15fqZQ//Cinwl6zhGJSoEY5Sc4HjjptGE
         aBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769169687; x=1769774487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AUZVKtVy7XchFYI5S1NHzhHg7zbZAcEeTMXVgGwqlGo=;
        b=oehK7XiJv2eOYZztrLIMWLxTfWdo6hIPAJ5m/BgHZ+flsnXd6WNBe1VVaK6bavmnbQ
         TEKFPlh8O8fquz0xiO+dd5lexvx0ZWqGsJ6d3ohkRIqHS21EICUpeDDhTVTmjpC6aMdV
         5D7Oe3namg4SHsPphQRogXll9D2RctSA8OMkkbO8tytzIKAARF5AimH2Xl+FOTy3hrt/
         lKMqpnSg05CXLdbFvLu6nrxsugHQmZsi21f+wcAZ04J3+maps/oL3XhqKhp9UzWD0sBL
         CRfrhJ++AdL7oAUJBNqbf+FvQlbm9ck+47uyVq7ERyawdiNbGgpnuuZtbzeSk56axWW7
         rhMg==
X-Forwarded-Encrypted: i=1; AJvYcCVwh287iWM+IL5MEnil8m3grioeNh4H89sB5akXaue3toA+6pkSpt0OaGNnfBHMpYN0GdtOgYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XQJHiNoZdVddDN8O6Qks4eoyjTNdfyLnGqeqQsusFC1gLqT2
	J7+mkfiPpVXQoN+C2RKhhWGr/fMDA2gP31kJJDjBNM8Bg0nASi12hK4r
X-Gm-Gg: AZuq6aIZQalyCr/n6WY6FE+/yljQRpwRdfr+7TUv+ouYSXMRSl7G1kfEwcxiaRVx56Y
	O4VR67dJ8nU/nnA+fPnov7ugOAKOGEUicRfbtwiKp7DNkCVNVQgn+7w4QWmoaGYIyEWkyv7PipZ
	BZBU2D39JbTJhuGlxfxuVMZqOPEaB4qAkmOGSNQ0nf4Dm7vXiF8yMc6TTaXsddRt3JMI2bxJfis
	EhkGf1Qylh5NRVVEU0QT27GDsnoGj5RTU0czUhQAxA8Udbax1x6mO1TJonp+xUvHKbFLw1dMd5T
	rn2xzg91XAnX9x4IRoj6Q9HBNgJnHRi7jV63+1PZP5sIyhBvT8QjedcHgWZpYTw4LjyCllPTxwh
	w46FatJUDk5kTM7MIOpyBwfB5MsyfGPaaJ0X0oJwtVbr0Vz+DcFX10nJaIllbP0zyCM1zgjIr/l
	WJ5mz5XSHoVzVII/LvPdFOoXHMzgG4g9sP5C8MCGm79EXvhiRtC2g=
X-Received: by 2002:a05:600c:674f:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-4804c94179dmr47107775e9.1.1769169687384;
        Fri, 23 Jan 2026 04:01:27 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-88-81.ip49.fastwebnet.it. [93.34.88.81])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4804d603ac9sm21575135e9.4.2026.01.23.04.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:01:27 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 1/3] net: phy: as21xxx: save firmware version major/minor version
Date: Fri, 23 Jan 2026 13:00:29 +0100
Message-ID: <20260123120117.10883-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123120117.10883-1-ansuelsmth@gmail.com>
References: <20260123120117.10883-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252827-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8E75375837
X-Rspamd-Action: no action

On PHY probe, save the firmware version major/minor version to use it
later to validate if a command is supported in the loaded firmware.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 005277360656..a5344abde91a 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -183,6 +183,9 @@ struct as21xxx_led_pattern_info {
 };
 
 struct as21xxx_priv {
+	u8 fw_major_ver;
+	u8 fw_minor_ver;
+
 	bool parity_status;
 	/* Protect concurrent IPC access */
 	struct mutex ipc_lock;
@@ -570,6 +573,7 @@ static int aeon_ipc_sync_parity(struct phy_device *phydev,
 static int aeon_ipc_get_fw_version(struct phy_device *phydev)
 {
 	u16 ret_data[AEON_IPC_DATA_NUM_REGISTERS], data[1];
+	struct as21xxx_priv *priv = phydev->priv;
 	char fw_version[AEON_IPC_DATA_MAX + 1];
 	int ret;
 
@@ -585,6 +589,17 @@ static int aeon_ipc_get_fw_version(struct phy_device *phydev)
 	fw_version[ret] = '\0';
 
 	phydev_info(phydev, "Firmware Version: %s\n", fw_version);
+	/*
+	 * Firmware is the format x.x.x
+	 * Save in priv struct to check validate feature support
+	 * in new firmware version.
+	 */
+	ret = sscanf(fw_version, "%hhu.%hhu", &priv->fw_major_ver,
+		     &priv->fw_minor_ver);
+	if (ret < 2) {
+		priv->fw_major_ver = 0;
+		priv->fw_minor_ver = 0;
+	}
 
 	return 0;
 }
-- 
2.51.0


