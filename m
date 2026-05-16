Return-Path: <netdev+bounces-288634-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBl9LEF3CGpOqwMAu9opvQ
	(envelope-from <netdev+bounces-288634-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:55:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D43B55BF8B
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AE5930103B6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A23C3E2AB6;
	Sat, 16 May 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOSKGSXT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC83D567E
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778939691; cv=none; b=IPfFSs/Jl2WbY6BaN6JJxzH4V0t8r6uEab6phanmreEc+B23w2eRx4hF6TtRd2CBL+j/t5X6udD4FmDtma7j5VAh/3exhaWZM/lomJAkjDaD/SHWrX0ZxAtEGVBtp3f+M9d7RYmkHEBV74fMZiPQ2G6Q8W0bBzR9bjmwgtLnxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778939691; c=relaxed/simple;
	bh=VpoQujZ9GQMnf5nQHTEp2Qyqm03Jlz6XjLvYPy3uE5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blIGvd2Kp6IpyG1993i/9qMBUeBZ5H/eQEmjfcKjgj/zJMyF5AneRDehAsBAJHXYKJtoTphWaPp9zVH+Uc9n1KjBPIgzpHioN9NcWEH6vLRptfQ4wT3q9zT4n37Njvfi5Lf20BhLw/X+rio8rSRhuKWkXcBOBIn5uIb5MDgijZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOSKGSXT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d102471a4so5362345e9.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778939688; x=1779544488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIrvNnWJICom0gFogZEpaj6AR2Yk4bcfuHPYqmXxhME=;
        b=lOSKGSXT2SXGXiLWWQI/9SlV6wS+20MbZt3iKHpOFZbM04s9URdNu5GlXYVZFqLUYd
         3GgsEf3zzmPdxH/NCDu3HqSYAx4F/q48JhzUT1/8U2rZ3bMB+ppStkh7A2SkzrsgxKHf
         jfSfJhcsdVPOWQBE90u2geodLM0MJXpwgCd02ZpUyNXZ07lKoyJuvnG9wU76syhqm9Ik
         CLgFR4Bh5BBRaS4WPtV6Zd2/TdEAmF9N7jeh5CXrh5y6vAT6cpE7R/hShYH5CNL7fQbi
         Xlry6e3SqiekDHB1gDefJb2B2PFs2RsNz0SnX7JguQpaebR6AYhcwe5jx/EMpKD1G5fp
         cgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778939688; x=1779544488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dIrvNnWJICom0gFogZEpaj6AR2Yk4bcfuHPYqmXxhME=;
        b=boNdsLaFlLoy2wImWd7J9CRQsMAc6Iajts3xDbjEjWrxRxs73QEArd3w+g/gaUH7e5
         SkdR400lIroiashTlpBPmF+6U9GX1WurwPTvvIKZHZf/hQppCrx8bR+9JzkaslgJyUQI
         sb30cj9fwyipS6x4HGqD9yDRqYZhTkPk2IEiW5Tts7rQ7P4+ySnbS7KlqQ9r77SM/Bke
         r20Wbcp7ktmJKseem8MKMGPN+x29eacU7xEQEEknaguns6tUentp/1wMHQABiN/qGlrO
         I3gnvc8gImHMijBM8drhPgiKch+6dUFcmFNQpsq8mCPOk8ZxJfGywxe2IWpL7m3w980y
         t5+Q==
X-Gm-Message-State: AOJu0YzVpagab1LO+k97STyGVwLI+ceUB9pp28gvsZALZX9d5miBRBoD
	5UUBggkyFQRhpJZay5eJsoZPLWLA1S5xkLhk7HVcDBWdi+4sxSyuVP0e
X-Gm-Gg: Acq92OGZrE2+tMnj1GgvLOL5FuQFkI8s9k4PiieUTSSPeloDr1aeyj/Vfe5+TjsutvZ
	bATy07DRlV3gHEYHxTlxoSx9mogoOFMqThQ8yBoWs5YrXsnq3cIwV57GbePK9dc78BUJzf03pkB
	kkEVE9CUn/H13/kYAQnt09tCHaHXlGMbvQ8WsjnyJsxvjn/wvDUaZeyqji1eNVCPtLPB22yOqq3
	4+5h9AKNfcosgis6H9eburSOXtg4UFJCmyodZhZew2eYL2QyKtGyH/rGPYw2CTFrmMCkelplsXU
	4cpW8szhWrwqZ2gLuUTB70gaACK1mzYOBYq+uyn1SpD7xQsDV1Yiz/0N66ddDZ5vFdcZx1N0Kl+
	/jTqoKbPJhhGm6jwSjze757qxhZyLF9CSX/8TAeqIu6vvIM7HWg89r7h7Fj6F7VKIkaX/sO64UU
	azR5Q0VXAl0jqC5QxDnl6yWWeEdg==
X-Received: by 2002:a05:600c:4685:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-48fe5fd494dmr113773895e9.1.1778939687859;
        Sat, 16 May 2026 06:54:47 -0700 (PDT)
Received: from builder ([2001:9e8:f136:a916:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm123360645e9.12.2026.05.16.06.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 06:54:47 -0700 (PDT)
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
Subject: [PATCH net-next v8 1/2] net: sfp: apply I2C adapter quirks to limit block size
Date: Sat, 16 May 2026 13:54:41 +0000
Message-ID: <20260516135442.2234729-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260516135442.2234729-1-jelonek.jonas@gmail.com>
References: <20260516135442.2234729-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D43B55BF8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-288634-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
---
 drivers/net/phy/sfp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index bd970f753beb..e58e29a1e8d2 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -807,21 +807,29 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
 
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
 	return 0;
 }
 
-- 
2.51.0


