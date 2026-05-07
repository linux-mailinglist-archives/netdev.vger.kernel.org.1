Return-Path: <netdev+bounces-285210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFy3NIJd/Gm7OwAAu9opvQ
	(envelope-from <netdev+bounces-285210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:38:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8BB4E6150
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22C373086BE0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C53C661D;
	Thu,  7 May 2026 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9J7OcNd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51383C3459
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146407; cv=none; b=k+CYZDkmJ8rV2pO0ZD29cK7bzVyUzb5WmEw4Y/7ehdyoalNRydES3JfjSXmV+iRk8x0dtt0kSukwNKiHypBiu43zj+Jw0HvLspGCORxC5mGgzKnJctvq3IrBKeeOl6RGZNq17KRN/rsEU2qVyWZGUNJDtLnJLaj4UOrohGWH0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146407; c=relaxed/simple;
	bh=XhZrXauAACb4WHe93YLAMRtIyhKDF5L0YIyHXg6C7x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oevMgHKy3dxKx8Z26jwN6w6LNDyuCTeXTUigVDrSoGIz3rHkA9jFkpvwOuwWNpx5MZiGnQ5vg8jiaO/96HThzKw6Y5wStcUHO/cq6AEJ3aE8jVXKU2f2mWnphJzz+R/x+ciq6pKwiFQ0o+6hDGgf5HJXGD/P5t3S5xKHJmTnlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9J7OcNd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38ea6a5a0b3so4904061fa.3
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778146402; x=1778751202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AGdFUHDF2nHQALLrNQHKOEqd/fvRy2bQu566xPn6As=;
        b=Y9J7OcNd8GbH0Rp4yGyFtMZgxMut0pOGsc0BPkyGg40LALT/cGiUPxNdpkTs0bVHrE
         8l27GOuHDfOundSaZ5HcWst1gJj4PwMcMbOuR1AhPGMjYRMcgJ4EupI1Uo68oSnu2j62
         yXp6fHaznxP06C+X3TUPU4sLNPMoaa9Az+HyqMekzNqx37PBh0RNABsQheEj2DI3KVn5
         pQyXliiVj4OTXbwMVSaJyun8Ka3jrdiVJ21kKUcOImvh4cBcmAQ1QIlQ6bQ8Qc8wzL94
         zg5x0v9d5bOhXBskwEZ62+Tmk++s4DFTVwmQXmjv48qcYZlCcIpcLl2s5xEMlGoZ4vtg
         s9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146402; x=1778751202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+AGdFUHDF2nHQALLrNQHKOEqd/fvRy2bQu566xPn6As=;
        b=gpj+9Wx/qkN9msXcav9yirQpcvtvS9gfb21WFF2zaVRT1uByu/aHRV3DBmD+GWQ9xq
         PXntBjPOyX7PJ7T4KkGtZ8ChTA5aE8tBeYibwy3cX6Yxwo/nCylZyZljwz+6fByQ/zbS
         oNKrB1YVm7oL079nbBfyDwBjtIghX0QpIiHsm03GR02q+WTabolRsQnbmNAEhltlsOfY
         J0zn0SmlfHiv1LCbO6z8ScmZls0ky+SU2pNqnFRy+1w0FDenXVNhiae7N/D0+y6Gaaqd
         ThHs9B0BfQRCcxPAPp8M4rZFNnbTfysDCj7YyxWkL/yuD7keYpb3z4k8nRyZ2MfvYwIy
         7T0g==
X-Gm-Message-State: AOJu0YyFzj3MaCKgSLLxuyP0ZzgfIqVccZWXflbN3T1w9PFil4y6WCXd
	92heZ/vBtgHeoydlnDoaks1Uk76Pis9Ox2QPJFEYeLY4sWm6GC8nykIT
X-Gm-Gg: AeBDiet0kZMJey8bBhk3gZhE0u0WM0H07brQeSEgVjZ4RmCaAG/zZ+kKKzJqBEY0Zcx
	NPTr6E1F30a3K7QREaB9G1ozKyDsAk02U3Byztz/63y9wdbHKwTz/tWbJpW1QrOmn8jWZAXDFrI
	KMvNIQ2oXzACM5pppPxSQqZInOOZjYzfBOjWUkMX/6bzGFsAe2w+MEsgrxYafVhY1c+kFdx+iaP
	T00620Ov73frMp+MYHe/fCKyg+Xj9tRb0Dok24n5G4N05wVRaZBIBTDLphVFKznIKf6RP4MpyBt
	OGXDD5yvKO1ItqIhZ5pzcXg4RhSAPWkITNpfUXuiGnWWs45iHtywQs6MeuqOgONXa3x0kj+E7SP
	1HHaXUTYQ3izctMMUIM8TLuFuhYuCGOscqBmYf1m1KfbfRZO0oulEDB6fQOb/8hojJsYGTVv8DQ
	3FgV9gUJPNTBPsjyakdREb7RtcPhhEOuIhatOI
X-Received: by 2002:a05:6512:318e:b0:5a8:9dc2:8a81 with SMTP id 2adb3069b0e04-5a89dc28d0bmr493127e87.17.1778146401564;
        Thu, 07 May 2026 02:33:21 -0700 (PDT)
Received: from builder ([2001:9e8:f13c:9216:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a864c6f16esm4752445e87.15.2026.05.07.02.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:33:21 -0700 (PDT)
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
Subject: [PATCH net-next v7 1/2] net: sfp: apply I2C adapter quirks to limit block size
Date: Thu,  7 May 2026 09:33:00 +0000
Message-ID: <20260507093301.1144740-2-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507093301.1144740-1-jelonek.jonas@gmail.com>
References: <20260507093301.1144740-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E8BB4E6150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-285210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mork.no,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


