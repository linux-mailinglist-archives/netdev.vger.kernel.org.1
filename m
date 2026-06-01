Return-Path: <netdev+bounces-293533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOBLHXsEHWodVAkAu9opvQ
	(envelope-from <netdev+bounces-293533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 06:03:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C642B6195B6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 06:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E55763008A4C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFFF310779;
	Mon,  1 Jun 2026 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldYhKrbs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F93101A9
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780286541; cv=none; b=eiFZxfHcvz4nNpIj+R6wvzWaPRKrMZCqxsM/rDEqiq2dUeAPPavqoc2MO00+Fin6hMmBzrknqgaxSqF14GNAiib+IqNQxenNb1YPI8We/wD8XpU4ezV2vuY//rMnSKs2FZ1HaSAht9h5lkj0+Bh5uo5GTuMCSRiqdq/1/APaTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780286541; c=relaxed/simple;
	bh=oBWlFqSYNupq4ewBKx8UZ2w1zhEz05NH6Rf/ECMAuD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9Sx4fEntSZ+j2oIXB7rEsHvRnVJ5AMsQ3STuPnWT0XtguB701vKAsffKY6riNAUXC0qXTe7/WashnszJnZWlOefxg/r3vMtZ0ZvV7TJmse4gaSKlr/GXLfaCBfGJm30xtq8lxxJmcQTK6OPKWJjraqHp0zpFRjtbKH8imV5f0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldYhKrbs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c3315c5dso8930075ad.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 21:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780286539; x=1780891339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QihYH7Rm1RkNSAWcotfRWjgzTDwvvgHIgGXWTnmhaiE=;
        b=ldYhKrbsKXiHZoRaelilJ7TJnj0IXwX4wPNAARtMLOICBlPe3AUcxUPHDQiMFu2bsJ
         z9Cvbw6kmeoW7TL/zsqaZnPihSyTAP7BzCo58kBitNp9qtyIwobuixDqctrp4aisHKu9
         ZEBMfFfsqc65uMtoPi1UB6VxT8wUzONVkSESgd7tEyyB/uKnd0VWcQYrzQr/FiaHJswC
         8V4ZHWBAK98ifwU6Sy6Sf+JdGkPvMQVNC/ZBhZIMqBs79Ju+9dZISEbzo+Hslw2xjsb+
         1qSFbBVj58sPYwTHt2SSXI18Do0Zafu8xTVXOzCQUAbuE0Xam4ITL7/c/GAOZrkpMoHK
         Hq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780286539; x=1780891339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QihYH7Rm1RkNSAWcotfRWjgzTDwvvgHIgGXWTnmhaiE=;
        b=TIHnxJE+5RS6lkMbGe6ufqCbmBI1isRV+9MyeQktCGs+KvNcvBDZCqXVsZfhcBfvao
         qrFvj2ix3i+oTMBarBWG3TnW414kQToStc+0fXh0D16o6IV5PjoThDqs5OUygsUr1+l5
         T/IKARwzUXbWghx+Q2t2HpWMi1rebt1ayoH9hO3MANE/stR58Mss8jYgN6TDvjze1ca/
         3ayczkTF8NURruVyJLlkij6/5fG20qO7obA2t+qx0S+TAv8pEcbENBhhqftqAS0Gpjs1
         im9TqMbnMg3+dKVBsYWonDWRFfyOG2UDyjErfLotyZjPcxfXS5g5hWbzB4IyNFXoFcCJ
         dAxA==
X-Gm-Message-State: AOJu0YwGTAH2OgVxeg8qzqDlN/8ou9EKTK5e4xnlPhYAdWEvLPBrxtsR
	euedQamNO0LHll9AvXKtMt8/Uw2qIpFlUOZWsaNOioCj+0Q7QwGogFhKoFdZvA==
X-Gm-Gg: Acq92OHXtUA0TWkzygZgcsqeqVyZMhvDdlq6AbDSn/6oBSILzXeowUnpQu78eu2iqDO
	6lusk3MhPOHoBrUOMfnmxUIh9fMtotbWRPbVZE6MsYmxdvKphmf7EAZ84sXP4G4u/WecRCxJT6/
	LfKNTOkkNxgY70S5+Bof49umANVcTG4eZoEC4w1j+Bn7Tlw3pGpObfLWYoZZcuLo+ziQ90McsiG
	drhNN9NAkRMP0/cOI2b5rzONl4ZABmEW2POJJrPXkm/vkdLdCqBkz5syzJ4am3IRLgiAB0BiCrC
	WLeQ2S1HYKORdUHk7O+a7cfB6i/h/ZiK60XhAoLqZzo7czgvxzpKIdI+Fz8VKuujIRd1fz5+PQf
	8H4JK7IQx24kYRNALBt+iaLZET8I9/a+kEWWgzQczJhKDp57zVKeso5bFlVt0foKTcurDAw2NTm
	Vf+uzC3FxvMnYXAwVaxIvGHvOeNdnw6FrHgxdB2G+pB7EVD+ermxtQ25zZchCNoeu5FOgARLoWU
	fhB3KOo+YINg05oW24y7LpbdrZ2AbwcGzvOD/S29zKHQQ==
X-Received: by 2002:a17:902:e785:b0:2c0:d91d:c3e8 with SMTP id d9443c01a7336-2c0d91dc475mr30476015ad.4.1780286539433;
        Sun, 31 May 2026 21:02:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c580c6sm92091935ad.82.2026.05.31.21.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 21:02:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <sln@onemain.com>,
	Simon Horman <horms@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ibm: emac: fix unchecked platform_get_irq return value
Date: Sun, 31 May 2026 21:02:00 -0700
Message-ID: <20260601040201.103481-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,onemain.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293533-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C642B6195B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

platform_get_irq() returns a negative errno on failure.
Commit a598f66d9169 replaced irq_of_parse_and_map() (which returns 0
on failure) with platform_get_irq() but dropped the error check.
Without it, a negative IRQ number is passed to devm_request_irq(),
which fails with -EINVAL instead of propagating the real error
from platform_get_irq().

Add the missing error check and goto err_gone.

Fixes: a598f66d9169 ("net: ibm: emac: use platform_get_irq")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index e597e2ad434c..d2194b406c9e 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3035,6 +3035,11 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Setup error IRQ handler */
 	dev->emac_irq = platform_get_irq(ofdev, 0);
+	if (dev->emac_irq < 0) {
+		err = dev->emac_irq;
+		goto err_gone;
+	}
+
 	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
 			       dev);
 	if (err) {
-- 
2.54.0


