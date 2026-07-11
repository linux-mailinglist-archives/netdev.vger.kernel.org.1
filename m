Return-Path: <netdev+bounces-306849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+SGOeI4UmpNNQMAu9opvQ
	(envelope-from <netdev+bounces-306849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740074187F
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 14:36:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b="q3h/pdWS";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306849-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306849-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C27330117B5
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5C3C2782;
	Sat, 11 Jul 2026 12:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303BC1547C0
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 12:36:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783773406; cv=none; b=REWJoQ439hZ4EFXYgsnoRS1egIiqsOY/6VJ6PdfwcYHOaeuznEL50DrkpD5upZ2Vt4ZoCk03Czlr+d2iYiG/venjmyFje5hsPA4XLYo1PAXXGQFxdyc5m8sRG+XVA+ml/WYtOv1oLeEZu9bLlhFWTWRRenT7XQ2deZ4VEFg707A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783773406; c=relaxed/simple;
	bh=PhVyj9qD5Z/KlbzjKtoN1G0Qg0OHJkNtCd/AmCW/7Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOhOxIaxh0Vxyha6YZlcb+P4+inVBBkSZ5o3mZXQTApaMuaWYm94IWZ2otKtzwW/9qO4epobCAg2Nso4ZHoJlZJYd5k2S96aNvwEpMVxWA+t3DdKycGh7gYfjn4F+mZOgRv5WfLbL7HiK3XGaoDPrRQK1zaJUGA/5wkDyE87ouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=q3h/pdWS; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-472326ca506so1359025f8f.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783773403; x=1784378203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEZdacI12rwF3rcHsuyG8xQf3FKIyTovs73PN6g2MOE=;
        b=q3h/pdWSeTe1k9K9MDviB3sBXlTBIgAjFetV8Dcydd4ZgT0Uk2freX/hQLdj9JXswk
         sm1sMHNs1i1h1hoqxICHlVlgAsxKNFHIRH6OcNfpfVbBF/vQ7xtt8+XB+8oG0K6sg4Fh
         FMp0s7PUqkXbBqzXJNlkWwhuITo35gcMZhFRoMolbZlPAnlDwjLjhpWIkTmHzyizuhR9
         8O1bdNLE6Dl/WfxYn30drMzppzBAfnAi2Pwrwz0hYMfOkpPJ2WYN7eOCClKPff0fb4Vr
         oXLWO5ju1x8AGdUWzIbsQB4Rf18SHiflb5JtwcvvITlLckjyTcjCX1MEJ4GRXLZXvIRQ
         4HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783773403; x=1784378203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEZdacI12rwF3rcHsuyG8xQf3FKIyTovs73PN6g2MOE=;
        b=fc3J1erqtdMDGtQIMCK0SJ0GzPuxNkANLwjfxOXAbp+6pWOBUACHZBelM8xgIIBxEh
         xNQUZRJKE3MK/f1QXSNyHb72tTv6R9gsuf3v2iSTm0x+ZVgHIhKTinpKs0Bp+QXQAiTs
         z80u/3V3V773cGsrm2FpX0XIWMxyq6n0XghIkGc4uqT8pdEs8ECqEQzDrP2mbux3B+uu
         Z5AfNjTA/AIaUfgnvhO9s+y0nYudwD0ov7n3pp/SEmzUEVrmMFZJhemXjzfgZ+QJh6uh
         hOZOp4VRQIzWXHJFiTx2nwPzgrOMqX0rq8SYi++JJ6GZ0+a43cPO4OgiufPS6hCLF+F0
         3k4g==
X-Forwarded-Encrypted: i=1; AHgh+RoGoWA3L15KxuxhueEVGWYI1q95MwgQcWPTyokOmlAgAwI95v8gyi7JtfhQrp0+c/1B6t2HM8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YykuUMdfvNygatBxsuaTlohM9tf5bIFflVWPNoo5w/Q786R+ct2
	+pmH9Lelzr/KMyOCsbSaxp/bi/o5VlH1za3sTgaotD4uiHnLU8CxI6+U1DjSbIOXSNl+H34SKle
	f7OklSf3A
X-Gm-Gg: AfdE7cknSE0NULn5FBtsbzONNiMVMfkxXR6EwJjDrk6LhFjDl4x3pW9Lu+i8msFQNd5
	czdLWkG011z1DJwabw+NkXGw7CWhcGDNX66M/3UwK8q1VTXEMnUXyfB97gz5dT7RRuNwLMas7KC
	g1IZz06p1BtIvdpoj7QOjqeIdoFIpQoAAfDal+yEeazIBREZeJ4tDwjEhnpIvP/Aae0U5F8wOcT
	6zvc5gyTe2RAGQBTdXIsouYc+wq2n98Sko8UE/fL/eNwMqwovgRXF3f1vgkFoCDn82JS1l961Gh
	A3b5QYdLna1n71+7wAu378SXur6lXITyGVr7oOc/o2ZEW0vOX4IXuv1PKfu/hYgPWdfRmZTHnDY
	N947HRgw4WkkEoFJhOI2yvPcL7Drf8FTZMH517X13+Xf8IN3inBisIc2Y4CqyRTInRln7UQ0HUJ
	b4ND9fnVvKD9EQ+LoMoD8nlLSwG+U/ub2oc7FP19uXePeL+mo8fFKGObnNqWRubEjFaeeXgJm9x
	fa1Z6MsEixAKECWvAG/0i+G4Yrj71/u7JU=
X-Received: by 2002:a5d:5849:0:b0:46d:d5db:98 with SMTP id ffacd0b85a97d-47f2dd02487mr2501924f8f.44.1783773403587;
        Sat, 11 Jul 2026 05:36:43 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960816sm66169851f8f.29.2026.07.11.05.36.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 05:36:43 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: fdp: bound the device-supplied read size in fdp_nci_i2c_read()
Date: Sat, 11 Jul 2026 14:36:41 +0200
Message-ID: <20260711123641.32502-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306849-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,0sec.ai:dkim,0sec.ai:mid,0sec.ai:from_mime,0sec.ai:url,0sec.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7740074187F

fdp_nci_i2c_read() reads a "length packet" from the FDP I2C controller and
computes the size of the next I2C transfer from two device-supplied bytes:

	phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;

next_read_size is a u16 (up to 65535) and is never bounded. On the next
loop iteration it is used directly as the length passed to

	i2c_master_recv(client, tmp, len);

which reads into the fixed 261-byte stack buffer
tmp[FDP_NCI_I2C_MAX_PAYLOAD]. A malicious or malfunctioning controller
that reports a large length thus overflows the stack buffer -- the
r != len check runs only after the read has already happened.

Reject a next-read size larger than the buffer and resynchronize.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bound is evident from source. Compile-tested.

Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/nfc/fdp/i2c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c1896a1d978c..581f85f0dfa8 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -128,7 +128,7 @@ static const struct nfc_phy_ops i2c_phy_ops = {
 
 static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 {
-	int r, len;
+	int r = -EREMOTEIO, len;
 	u8 tmp[FDP_NCI_I2C_MAX_PAYLOAD], lrc, k;
 	u16 i;
 	struct i2c_client *client = phy->i2c_dev;
@@ -140,6 +140,13 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 
 		len = phy->next_read_size;
 
+		if (len > FDP_NCI_I2C_MAX_PAYLOAD) {
+			dev_dbg(&client->dev, "%s: read size %d too large\n",
+				__func__, len);
+			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+			goto flush;
+		}
+
 		r = i2c_master_recv(client, tmp, len);
 		if (r != len) {
 			dev_dbg(&client->dev, "%s: i2c recv err: %d\n",
-- 
2.43.0


