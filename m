Return-Path: <netdev+bounces-264883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NCyE8AJq2k/ZgEAu9opvQ
	(envelope-from <netdev+bounces-264883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:07:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D48225A50
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D3423013D47
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9483AE708;
	Fri,  6 Mar 2026 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhi48k+K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039A285C91
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816829; cv=none; b=qGUwyTMy+WvYO/YTDNeuhZHjxJQrZeKOibRjdGGTlNfGZQHzRGD7KhRcGWeI9CII1rtEIi/Zxl3wJ7eqofJ1nY+LFtFsKmoQmkPSWDt78sOJX3vgWGYWOgxHCg8cr30r5UcuE8RlhvLL92Qx//mB6fAZuelDdowdPlIczCDh/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816829; c=relaxed/simple;
	bh=rOfy8wDuOSu8y8pr/Cvv0Qci/pxPShgpI/D6IioqFB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2adRTpDHWXEnITsuRtXbWvfuZt31GYuJ//46AlEbtE+YDNPgyWsJkCi5AeMfVqQr8nnp//YfdovceQCNL9a0gxojLwdlwdaCa+OZ6VwWYRCwfoVG08c7YIqi6RoFKlkGgM4+72KMP9Mnz7RM70U177l2FldZ8tA8P0WS+/p8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xhi48k+K; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35691a231a7so5868191a91.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 09:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772816828; x=1773421628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ExtvjVB4+EytPuBHPXzj1SFBmx/1CWZqQrsowLFQdM=;
        b=Xhi48k+KzJP++mpOHiSM8tR04+aFKaojPeQ73Z7CJryZlN9+EzmV5tjE7jdoy9w/qL
         tsOmBREU/vCoobFXMfUrrRfo1oMB8XclaN0AxwnRPb4kF/sjC4eAaVg3IKpQzov1DU8U
         yodeEDGTa6yvYc7f+EgmlHmX3NNfYCNigrTlp3W8lQ5Lcy2qJ8Rk3qjzKCPn0V/5xpIW
         2qPXnZLuUIVx5cyxH6zd06WXpauGnQrsgwCdjDceGXXUTRuTCQoC3NfrWQPZd05on23I
         vTZY3TObKXxY1ly98EZFhXj1wnfs6o9piwbj21PicGPZUXXf1/AeEooTjcE+jPXPS3ZM
         iApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772816828; x=1773421628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ExtvjVB4+EytPuBHPXzj1SFBmx/1CWZqQrsowLFQdM=;
        b=tLYnFJLZq+pqakdZ68DbTcMXR+FrfWQLiYLSUojnRDNvuHeU+x8JtHjl7NqMpbt93R
         ni9LBqGT3BcIazzeXaN5cY0XDMa3j+maI0PxW3xW9rt4oXzpP+bQsoGv7EIHvHtRiJUd
         Wk55G8DDl0Hq/0r+kh9S3TzyuVQYUeGVnrlzeSm/b3t9ePrSvLxb3tg6DEkUQ9bmdwGj
         fMDzNQhPwoXdbveLGHoHgdIVVRzGzGddchocvrBDFKSaNGhKAtq655+JbzeeM2qhu7hi
         q0v+M/qlyhEtc5Ag5Kbbv0N9he7jkn7UyfFMbXJjjOeqLs189lv8hb0fKmR31QzUbj7u
         Ilrg==
X-Forwarded-Encrypted: i=1; AJvYcCWxN+3vvM2HFnhVnC9zsCKSe+2TJN9XwnAKGLBmzBp5ildPGSEgQYF+5wN/pzEvSWnoD6cqZFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy51pP3ejdhvwbhV8cWrRYGH+njdeeu0YivnNe1hs66wuJ0gXb0
	tCEx0hMppWmozp0Qb1ANVQOK4R/If/2c/pGlOAbrXoHKgEeGh938Gzo=
X-Gm-Gg: ATEYQzxSv1I8I4zzTfMZ02S6HKZM6Da+6IDBsaa4mjoGoqr/oyGy28DAc6JsxtGyPwi
	TqMz2scnZ4siz1y+VL6RPACvPolCQNOfxgvLY5H8XlNiwWLQG6CxRMjCt3YMEPoWz3tQSkaJr/l
	ulUX2Xm46uszc2l9OsiZBm/VswbccmOjAdht5CZBXAVsSdbhSTDjKH2IQIwc6qBGXo82i59hTNt
	ISzlnLV9lQUCXp5/JQVB6xoSlr3Us4fL1bFJzAGkZVTUGKQrGkPTgp0iNIBIJJoz1lXdlFWVsxx
	w0fbcarZCCsEktooWlcyEx6hymelVmR03YsjCBiWIrKmZFvA8dXwEtd/bIVC+JiJMaD4nONR1Nz
	T0z58R7iddUhsHojdKSkh7rRl8FU97Uk4HSecjQiwmHj9CJo6BRM7UfDoRvKnRJwjTHbuTv+g6r
	CUEtMRkBg2qwiCuoPJXsntd4b5XknC34h68UFN0+SrKBJhdlxL64SiYWUcZY+sFg==
X-Received: by 2002:a17:90b:4c0b:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-359be21a64amr2430433a91.4.1772816827521;
        Fri, 06 Mar 2026 09:07:07 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([171.61.164.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de79f6sm5943996a91.9.2026.03.06.09.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 09:07:06 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Vincent MORVAN <vinc@42.fr>,
	Paul SAGE <paul.sage@42.fr>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tg3: replace placeholder MAC address with device property
Date: Fri,  6 Mar 2026 22:36:55 +0530
Message-ID: <20260306170657.39384-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4D48225A50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,42.fr,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-264883-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,42.fr:email]
X-Rspamd-Action: no action

From: Paul SAGE <paul.sage@42.fr>

On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads
a default placeholder mac address (00:10:18:00:00:00) from the
mailbox. The correct value on those systems are stored in the
'local-mac-address' property.

This patch, detect the default value and tries to retrieve
the correct address from the device_get_mac_address
function instead.

The patch has been tested on two different systems:
- iMac 20,1 (BCM57766) model which use the local-mac-address property
- iMac 13,2 (BCM57766) model which can use the mailbox,
    NVRAM or MAC control registers

Co-developed-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Paul SAGE <paul.sage@42.fr>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

---
v2:
- Wrapped commit message to 70 characters
- Removed BROADCOM_OUI constant
---
---
 drivers/net/ethernet/broadcom/tg3.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 75f66587983d..b9950651b20c 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17030,6 +17030,14 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
+static int tg3_is_default_mac_address(u8 *addr)
+{
+	u32 addr_high = (addr[0] << 16) | (addr[1] << 8) | addr[2];
+	u32 addr_low = (addr[3] << 16) | (addr[4] << 8) | addr[5];
+
+	return addr_high == 0x00001018 && addr_low == 0;
+}
+
 static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 {
 	u32 hi, lo, mac_offset;
@@ -17103,6 +17111,10 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
+
+	if (tg3_is_default_mac_address(addr))
+		device_get_mac_address(&tp->pdev->dev, addr);
+
 	return 0;
 }
 
-- 
2.43.0


