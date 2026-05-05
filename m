Return-Path: <netdev+bounces-284576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PAwGmpQ+mm8MQMAu9opvQ
	(envelope-from <netdev+bounces-284576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:17:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D99BB4D390C
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 22:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230CC31454A4
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221E3DCD97;
	Tue,  5 May 2026 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWxCDt1R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF03DB646
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011617; cv=none; b=WXxI6aWuxCdRWjagCDeL2MudQXvH/MiLAauRomuDWU4z1KViDsK/IFobWpDnDAJjLvBXCzkazWlAOqokMKljDs3yMZwBHIJxtsOPgh82ucwjK0+rHwbDuRdQ6Gjk6j1NqPJ2nfG0VNhD9Zp3e0OHT+9bSG6vrA0s1Lf59ZrYWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011617; c=relaxed/simple;
	bh=VpoQujZ9GQMnf5nQHTEp2Qyqm03Jlz6XjLvYPy3uE5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLl+yDR2jbUeVTchQCzyrKq/kOcYkLqZMK9cSEcDMA0qwbJcAYRI2yu3lyHV97MfFq4sOV/JQAxwQuzOyV4h96jG9QLk6vTBfLvm8JUY36jsd9cCORT9sXbcqhCxrR3CAOOMQ5XEL0Q2tu1Zgst6zLbVG6kqgS3cAe2+WONO43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWxCDt1R; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso67077635e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778011614; x=1778616414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIrvNnWJICom0gFogZEpaj6AR2Yk4bcfuHPYqmXxhME=;
        b=aWxCDt1R4Rw8NEFsOYsFIaucTAbRvEtwUQ3e3rZkrfFNRWER4L0wyfSuni5c3Ai1fw
         JslgXJS0IyAFXZ7d83YglLzIyfRc85OIUMGxWLGadyw9aKd/iBqg0OAOgdfNa30EvqJX
         QQsl/KN8YPuQ0/gdAZa+fH+0gKlL4Il3GgfuxlQ4hbzc6i4tJ/xfboXEIDm5IgFLuipd
         dOwfv8NsJakbs2ampDzZywkLKKRHJX9es/R8I12UsNFUItcH+LHAeM3LYpFdgow2ffBi
         MVLxr5gMD5zQaK1Vqn1MW7qbf25YF79/bqdVUa2eMSEEM2XKx3DnUivhiq8eD127xYdB
         aLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778011614; x=1778616414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dIrvNnWJICom0gFogZEpaj6AR2Yk4bcfuHPYqmXxhME=;
        b=TPNp7zkAepwLolFlsgAUrcZQgq6N6rD50rtG96GYAjxbEqHPPd58VvyXnyUvwjlfXo
         C4WrtbPaq+7UzzkLO1zVPvnhevrT7d5TTlgiaQkk7Fx6HUP0lbLojxuXIMWspaEMJvYM
         5G1i2iK6CNm49gbO5Mow2u4mWbeJpvHNbBMgtblG9cNA9+hfSFNlE9E1CnyiIuXbE65Y
         T8TDCbLW1K9Z3SDa1jweuwr+9lWAwWmJzZBPGMJ8spuisGqwoTWRqaFUsEG4aU+JcySB
         qg/rtX1205SQUrjnf/rhvqKaRGgvQ1gc5A2mHVxbQY/c6+N1aVJzvU+dWPDbxuk72Ugo
         Lgew==
X-Gm-Message-State: AOJu0YxpKZsh04kLlCUjIEzj5eZyztq6/EtyHj+leGQoaIQH1pNmeLIs
	MGPHqZYffEx+DkPnnA8MiWm7mfstOrWOQnJt1YFs4XoEKOvbFPGfrPro
X-Gm-Gg: AeBDiesJ/0Vv+80Lc/JjWYQPi8yCCZAuYtHroSS2EYuKwLDE0ZJIeJ0oxnk4xxENp+1
	tQpFCXPQppObsKI6ahvrSV+Yo8ydLEIt9ngY12mDLgAPw+iCFZiToxPD/CDxwnnR1MO93Nk0N8+
	fYiiWix1kNDE9Sn2m84trjWxrdDmhv+t+EZw8rahJLiFCyh0tGpBE6uPe2gZril1EF17rUMtK3D
	480t1YlqJaV5EWgcSCvt3xt6YJx+W5guq9giZUq7DpqsB8bbD9YtjVBGGEKXy5xJR/iNPJi09Ms
	aFGRTp0NZKClQrsRLEJbPjNonOg58dF2JpXVia5ozNK8ckORzj3XNpvLZ/tpRsjR6GR0MROxoCC
	2XVlVWx2+LdRnfVpMnO8fphBGd2o28RkVhTlM2XHGu6rdqdXsu/5pPk+daUDA3MonyUqCYGj0/3
	gNXoFTIU8jWWtXXuNI7aqyi1VMqi99BVK15zWH
X-Received: by 2002:a05:600c:4512:b0:489:284:44ab with SMTP id 5b1f17b1804b1-48e51e1deedmr11519335e9.12.1778011614325;
        Tue, 05 May 2026 13:06:54 -0700 (PDT)
Received: from builder ([2001:9e8:f130:ed16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2203csm7049511f8f.37.2026.05.05.13.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:06:54 -0700 (PDT)
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
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v6 1/2] net: sfp: apply I2C adapter quirks to limit block size
Date: Tue,  5 May 2026 20:06:46 +0000
Message-ID: <20260505200647.1125311-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505200647.1125311-1-jelonek.jonas@gmail.com>
References: <20260505200647.1125311-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D99BB4D390C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284576-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,gmail.com];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,2001:9e8:f130:ed16:be24:11ff:fe30:5d85:server fail,209.85.128.43:server fail,172.234.253.10:server fail];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


