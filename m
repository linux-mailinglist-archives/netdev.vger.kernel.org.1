Return-Path: <netdev+bounces-298696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id az82MvEXLGoULQQAu9opvQ
	(envelope-from <netdev+bounces-298696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:30:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4111C67A2F1
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:30:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jS0PMIoc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298696-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298696-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC8C73197FAC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918338A722;
	Fri, 12 Jun 2026 14:28:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211C384CD6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:28:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274536; cv=none; b=G3dDQkpI4BTjcHFNoHw5D61wUDEq8Ifz4olqJoz6fIOKEnUW4zqWqO+sszYoWkdPoSgLStH9p8Etj92Qo4ueY3nMGx4DaMo0Q4hNX2uTJzPa5A6iQsN4DfXGjLEjaCBh/rlCkY2IwSEoLA41QuNE4iBESgR8hBS3ThYDY6Xk07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274536; c=relaxed/simple;
	bh=vC7gffF3nph/f7RymsI38P5G/8V/ZI0hrB57Y33Oh98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJcWUKPsiFpgYF+Z7DImzfOzrCYptT2HSx/7lH8KteeiOMpbNY1WGV3HUuCJbs7MCSkIfmurvA+5nuhNhKAPQuV4FoATyNC+VRwG1Rh9kkr162i0R3EXF0VAOkBIdauHc5Gtf8IKk8Z1Z0WLGh3WerwkWUEhOBXridwxdR4Y0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS0PMIoc; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so10969755e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781274533; x=1781879333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyKTqLVZ2GkXstSMIq5XRH7NFzj7gG6vhpUIFQhTa+U=;
        b=jS0PMIoc1Q2pWxVlSTpLSuUL5lz0R37odqre6Epg/QOPbAza2D/2fUa1p/OZFSP0gU
         RssVM+LvUU5ysGj3tJx3kbuxU0noLJUKA9J5HcZJpQv3L1GTD8UIVWeWeQ60scY7jQyu
         dBOyITszDNAqtrx+cM1p2WX/omzKHhwDaSnSzjlVK4oCgYUBIr7Q3X0Cv+mvBh9P6FWh
         fOmg6S+4m+J5NIHOwbBsxzIUdjWs+DykihhZjLWv0JGeqr8y4A29tm8sg011dYCx0dNU
         2QtRKUyBvmJNhnYuBOS0XBJl/6ETex51OJs9ltzCfQ+oDV2XXifS3+afGrIHWTp4BCqn
         RRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274533; x=1781879333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eyKTqLVZ2GkXstSMIq5XRH7NFzj7gG6vhpUIFQhTa+U=;
        b=TFP6p1wseRpohR/FNplFu9CUB1ug6keUUQbF3UFrMmYK0LJti0Cq1GEyFKqpaLa9ZT
         GNX9NC7zzewoYQFahxN7zLWBNqBEFLhumTcc/XHiiTEe1XAlHAqeKDh7RIZc0DVb3RmV
         mmhZWvsGG7ijRLQAbCOc682DLjJkM4ZjFNJJV38CoY/Uhp2z4IGMunjrKSvnSjJHOFae
         RdzrOggyTxwt2kC3ek6Ra/YCZS2p5KFIQxYCZgO8CHq1u4C09l8aJwWQvQ8GB/BdQ8di
         nfqxnfv3Rax8T2AbfOFkIqqIgsO84+UOayHiJ/wLsYT/Y49Z85PqA6gqn0GSIbr56vYL
         sxtQ==
X-Gm-Message-State: AOJu0YweG29ESRGdPgszQNMcgQ0ehJrYme94jQoNhq/i17jO0stdVok8
	D4aZT3bm5+U6XJ57rjsf4nLbTRkBX4AUK5tKHYwadVxXVNq46TBc0JVX
X-Gm-Gg: Acq92OFAPe0TvwGJlqoGIVqJwkNnf/4/Nge3w5S/A6BgyIZ7GUqXL5gc+cKLeQ/aAK/
	WF3jxNW8QqtsWCvhjQM8egBZfFaTEZw5TEuXmyz/CPpCJWLZ6MZVRL2JDeWM3B1y2O4gy7ocoEG
	aJP5lsbKkjjB+08XrOPVQZ9hx03fxTRJpBa9uWR/KjZrtmuRcqi/8LLv74Dyj3sv3q4unrVXCFG
	eRDZaz5U+8aTBHRw8jDcaIIyHoMXwCgDvYBPzoUIPvkbDbSMrcMilbkYfYqZShZFToFQ/JW2SrU
	tR1uFxyN+aT9wNki41/X3SCuMVaSd24x7zDpzWtCvGO5iy/7mm/OvNnhnEeHClYAGGuvWo5LniP
	ZTsmhlBHHrhflBgPz8xDDYob/Xlv1VkBhoLbl42T3y1aTixp2hU+TZV5JEUtiMrdc1en7fHh7bp
	I8LwQbHTzoBH8HuKJsp3RzzuSILA==
X-Received: by 2002:a05:600c:314a:b0:490:da12:f1fa with SMTP id 5b1f17b1804b1-490ec503f0cmr38320045e9.31.1781274532909;
        Fri, 12 Jun 2026 07:28:52 -0700 (PDT)
Received: from builder ([2001:9e8:f11c:fd16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c0d360sm175410705e9.0.2026.06.12.07.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:28:52 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Simon Horman <horms@kernel.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v10 1/2] net: sfp: apply I2C adapter quirks to limit block size
Date: Fri, 12 Jun 2026 14:28:39 +0000
Message-ID: <20260612142840.462664-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260612142840.462664-1-jelonek.jonas@gmail.com>
References: <20260612142840.462664-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298696-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:horms@kernel.org,m:jelonek.jonas@gmail.com,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4111C67A2F1

The SFP driver assumes all I2C adapters support reading and writing the
pre-defined block size SFP_EEPROM_BLOCK_SIZE of 16 bytes. This constant
was probably chosen based on good guesses and known limitations of a
range of I2C adapters and SFP modules.

However, I2C adapters may even support less and usually need to specify
this via I2C quirks. Theoretically, such an adapter may provide full
functionality but only support a read and write length of e.g. 8 bytes.
Currently, the SFP driver doesn't account for that.

Add handling for I2C quirks in SFP I2C configuration taking the fields
max_read_len and max_write_len in struct i2c_adapter_quirks into account
to further limit the maximum block size if needed.

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 18f2584dbe7b..3c232991faa1 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -810,21 +810,29 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
 
 static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
 {
+	size_t max_block_size;
+
 	sfp->i2c = i2c;
 
 	if (i2c_check_functionality(i2c, I2C_FUNC_I2C)) {
 		sfp->read = sfp_i2c_read;
 		sfp->write = sfp_i2c_write;
-		sfp->i2c_max_block_size = SFP_EEPROM_BLOCK_SIZE;
+		max_block_size = SFP_EEPROM_BLOCK_SIZE;
 	} else if (i2c_check_functionality(i2c, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		sfp->read = sfp_smbus_byte_read;
 		sfp->write = sfp_smbus_byte_write;
-		sfp->i2c_max_block_size = 1;
+		max_block_size = 1;
 	} else {
 		sfp->i2c = NULL;
 		return -EINVAL;
 	}
 
+	if (i2c->quirks && i2c->quirks->max_read_len)
+		max_block_size = min(max_block_size, i2c->quirks->max_read_len);
+	if (i2c->quirks && i2c->quirks->max_write_len)
+		max_block_size = min(max_block_size, i2c->quirks->max_write_len);
+
+	sfp->i2c_max_block_size = max_block_size;
 	sfp->i2c_block_size = sfp->i2c_max_block_size;
 	return 0;
 }
-- 
2.51.0


