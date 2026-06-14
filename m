Return-Path: <netdev+bounces-299223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LUbIEAmuLmpZ1wQAu9opvQ
	(envelope-from <netdev+bounces-299223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:35:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F668130B
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:35:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PTv74Etg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299223-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299223-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4FE30166E9
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94453C3C1A;
	Sun, 14 Jun 2026 13:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C293C378F
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 13:34:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781444070; cv=none; b=GU/WDrVToF8ylisZGUQPcJAkZuScmjN5tPRa8wAkSApUzdqUhPLpIG38ZDcq/UVqg/rqfyBPGl28jOrDDJYshMnO/VYW3fNuWxZOIKTjpZDZrJOkiKoZHra4oXZw5K3fc72thIjopqzjmvE+v9SEIMzrJ20KRpJ352ACQYnaxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781444070; c=relaxed/simple;
	bh=vC7gffF3nph/f7RymsI38P5G/8V/ZI0hrB57Y33Oh98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8gaGR7SMPLkpoNnbtiNqXzycoRMfgi4Fcs7WWgpNvIupu8rFUmRvV52oFCnCZB6nk6RVd7JicBbxjiysCuSPeLezbsWiERfmo0W+BTkuxTV22NYf6/m7PBvBmAdN2JMVd4VHjc833fJiuVmh8HPIfcjE3x6uRZrispOpBqmQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTv74Etg; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso31693045e9.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781444067; x=1782048867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyKTqLVZ2GkXstSMIq5XRH7NFzj7gG6vhpUIFQhTa+U=;
        b=PTv74EtgR7h/IDwrdicV+UdkDb5WD//UcSf0s4FsTNhMiL7CYYvS/an1DeN7frH+kh
         Dg+hyx//17TbzPYImns4FaEMoOPJ0Qcz5AS1LRMPv6KwvUgKF2puCeAnVpkdjvUL4EVS
         4JQ/YUBRIqtIGJlkHO6NRFNFDW9DGXk+183NTsmkUZbhWLKGCaQYPgA3Sndt98CaWgJh
         m7HCMREMQveOIwu1JkctLf2AhMbhxEnPLHjVYqU6+IVCP6nr5EXJZvXqQdjMVFNWnHlt
         slkIi+7TPKqOPunOklcUgUpR3gSWOvrnVYIVNoes5CsqDb+1gRUyxzRLg14n066DjyHe
         bDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781444067; x=1782048867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eyKTqLVZ2GkXstSMIq5XRH7NFzj7gG6vhpUIFQhTa+U=;
        b=GXiSWmwrYzNhsfMjnA9Ju4uw8GKvONVkWbEqs6yfyUusxKEGRGoSWlNWyl7shfTrKJ
         Tos7BRiGxtOu5kl0je1MnSU4nnN7Mni5E0bhTqL5G61lYVtptHBlvke2w/9S2sngKinR
         yYqumZHSSeFU2mgONHvvH51vPEDB3xVq4uu34l7zWnBJo3x7SyhxAjDs7kOehj75maPV
         FQBg7OA2ZhrUXKQBzCAZjaO5ZWKf1jfKFv6gfosdoW9h/vDoxFEevZ/gccxrbyNptnra
         2N+vRB4UiTV0q32oCF4GWsVYADVHkpqTrHmTHwO7sqKudYpuNgBuzcgMu1Ww+PqwKBET
         1DDg==
X-Gm-Message-State: AOJu0Yxzd6SAJXiY9hn/w65eC8escVP4DlSaWZizZNTinlqZO9jrETxw
	gbmeRerTIlryTTiUinymbSd0Jg14SC1QjQpA0ZMPEf7ES6o6rkDmsEgx
X-Gm-Gg: Acq92OFzeE3f7fpBmrgbvBtU8cJC/OHHuYpR5zT+L+1aoIlhq8rPQeAtr8hAdp696AI
	3xI6M9gFPlMvpay0Qoq+zUqN4tKr6YupNC2aYOenu1kGUJV4ju8OCZfO96tZt8w8DsPPGT5Vm2A
	lHxUo7pxJV89aDJuPjy+3zlvdETP9Hhbv5d0oLRgYO8BLnzXPftEerSDiOjDbnr64x8Dg8194sC
	UP8lFa/wJf4Cby6yxz5/z7ASyk8tPfU1DAHIwfChSsBRNgcuuJwBgvIlR9QG2xui1XtpzU4bLVk
	V+FqZ23rArWeMzj4veQx8o3H5VCzzYXkxqJvOaFV0sQUgXNmuULQz3/IgYi/zJNOx3dCw44TOo3
	IC/Y7qc+ZzzDUtbokC/3mOBX7D1owLgklrPCvKSIn2yxSmQ6lA8hL7ZruVd4mlkG9U4GaouPvEx
	yBqMkuBB17j+b6r+4hjy2vV1km4w==
X-Received: by 2002:a05:600c:4709:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-4922007472cmr83103395e9.11.1781444067551;
        Sun, 14 Jun 2026 06:34:27 -0700 (PDT)
Received: from builder ([2001:9e8:f128:d516:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm169464295e9.13.2026.06.14.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:34:26 -0700 (PDT)
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
Subject: [PATCH net-next v11 1/2] net: sfp: apply I2C adapter quirks to limit block size
Date: Sun, 14 Jun 2026 13:34:17 +0000
Message-ID: <20260614133418.2068201-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260614133418.2068201-1-jelonek.jonas@gmail.com>
References: <20260614133418.2068201-1-jelonek.jonas@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299223-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 931F668130B

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


