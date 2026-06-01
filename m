Return-Path: <netdev+bounces-293534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO44F8UEHWodVAkAu9opvQ
	(envelope-from <netdev+bounces-293534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 06:04:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A26DF6195C7
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 06:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F943008A62
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 04:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52463318EC1;
	Mon,  1 Jun 2026 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHHxUbMP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67F131AF14
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780286594; cv=none; b=Wl3d+jHkuDS6mHLHUGiaSemDwM69BDG4ZUphymCtNGy9cg4j3+JMRbixfAL1OQegxSMKH48C1pkXVGpBJxP7sYwMxy7Y046noQ2IO/VXZyDFt9fGxAXEHzXASSmgZkrtImWFLhsIjm3xm7miZ8Hst1mwF43Hq84922fJ4KV/Tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780286594; c=relaxed/simple;
	bh=gT4/bA3mFwXtpHVo4W8EKkUsAtyQI2bYQnE9Nw/xqDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bP0unzhNdWXcj29wqMxMgynd+S8ZyubjOKgPDOKAXwiKUEVVRZzxZc6ZzClaFuaNC1csx0cXy7eMMJr4MSETdbTnyVD0pNPrVoGv6/hASmySGAwDE4lRufaxJEnzuUKIRTc/Y4wc29HKnWsx6jjX4h3l98WE4z/+5etocvrC14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rHHxUbMP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so5923365ad.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 21:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780286591; x=1780891391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owHuxPkmT7qUEBEcXysgUnbR9CByWLZ87e8T/EFLNtY=;
        b=rHHxUbMPvvLTyQyfvph/iLSS+Sh7QWiwTKO6O8NrzEvjQobohs2P3IemkTCeGKFYiH
         jsklLozcKK8Hxmji8uQoaBJPYZGo1Ne6Kh7Dqw/jJnMsON10PEzOciTc7I72V1IvI96K
         wLbaxb4Y2lPbtE6gf6kx0r34+mm4kGMYqkO/8ugiFHcThMffvOHtx4Xz7sdRILWJsgfN
         lm9OOkJQKhtwXYWCYxsC7mWNDEriN8q1zSC/+WHw4steCkv9YwNV25M3CcM4UyJiUuzl
         lXWeE7ehNChlJOtcsayqfK/CpzSaFz318SWzXXdTNTXQGEhDjwvYVLLOCrJILaMbGKx5
         RyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780286591; x=1780891391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owHuxPkmT7qUEBEcXysgUnbR9CByWLZ87e8T/EFLNtY=;
        b=jZF7hn2fWiDEDHxsuzBoYCYrLNey1/EwVBtBR5f5xnC6UFr4CTxCCQK0a6pLuAmHQz
         95wJ2h37OOWa/RxzEayA1bocBwNTII0tlP1VZXL0sMTTps4WoQX4Dbx+tvXhz6ilsgVi
         oiJdg8WgIaT86TwE30gkJaceFKCdRFfjBQge0vND2mLhHhxcc4hyXbdOEkJtDuSUIvOc
         /QX3qeNwh5m6cnmI5q9nX+MdKHx1RnCcH1CmMlOIzvXnhzznPOOKjYmEUaFFlsYhnani
         O4dlSI3BrmmNaBQBrZ2ZEfYpgb/xxmi9tJIIcs+ILMYNMnBlKp3jE6Mzeu0nhazcXoga
         0gYw==
X-Gm-Message-State: AOJu0Yxk0EhzuMTybopsZCJ1d95ulhKHWJKm48jnQa6PVzkO45ZvAl2p
	Kr81FVR4wXUFhz9dDbsHN+yIDmvA1XxY7ZESzxaH1Tq0K5Jd2uU7UrdlSBb/2Q==
X-Gm-Gg: Acq92OG6BeOBLXjI+zLVcOYJbQtVXiTfl2xcc8ISjBjGAe+nMQyyO1yovKujciGWcz2
	7Q1uuYpbALlAsnCkXyZM9rQJs8BZMDPZP9LIDZq20RwEjjUEbO2YNEimhaKQr4Drot/6jvMQ3gM
	ygwW2T7VyA0hM1JHX62XQMJvCwf08VAWl+i6iD7oVKs5MroMrHGzL5nW6ulD3lUBoQLH47vWfOw
	NJHHYaYRi838gip3wkTWTWvwvJvA9Td96cbjQ7r/WF7ymyjTDU2qYBytCH1URj9pWZf6xFK85Fz
	Lsys4p6AeCbjuyMSCvbuufA+eTf+TXVPh5k70h0SNx5VbEM0GDz+LeMJF+aWIIP5M4/ILTjQt2G
	EBQ3k7NgbXcbLYwVXTGyaPjnfT87FiDJUBayDwub/yESzlT4mlaM1Q6lHh6j7A5GYa0eKuCkSj2
	BnrruSbeKbySouk7+9QnrV6B5XDfr775xj8ToM8V58R5w60KHOz3FCgyc+rxcP1gq4ivx/iZ/z6
	hBpAO2YoR86P6O1W4cKOVjlp/aN5ftz5Q+l1P7dIQ6Ang==
X-Received: by 2002:a17:902:ce8c:b0:2c0:b74f:a58c with SMTP id d9443c01a7336-2c0b74fa708mr49690175ad.16.1780286590607;
        Sun, 31 May 2026 21:03:10 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c0d727sm88051055ad.59.2026.05.31.21.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 21:03:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ibm: emac: mal: fix unchecked platform_get_irq return values
Date: Sun, 31 May 2026 21:02:52 -0700
Message-ID: <20260601040252.103585-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293534-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A26DF6195C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

platform_get_irq() returns a negative errno on failure.
Commit c4f5d0454cab5 moved the platform_get_irq() calls and explicitly
removed the error checks that were previously present, claiming
devm_request_irq() can handle it. However, a negative IRQ number
passed to devm_request_irq() fails with -EINVAL instead of
propagating the real error from platform_get_irq().

Restore the missing error checks with proper errno propagation.

Fixes: c4f5d0454cab5 ("net: ibm: emac: mal: move irq maps down")
Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 7d70056e9008..63a7a32aaf72 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -635,6 +635,12 @@ static int mal_probe(struct platform_device *ofdev)
 	mal->txeob_irq = platform_get_irq(ofdev, 0);
 	mal->rxeob_irq = platform_get_irq(ofdev, 1);
 	mal->serr_irq = platform_get_irq(ofdev, 2);
+	if (mal->txeob_irq < 0 || mal->rxeob_irq < 0 || mal->serr_irq < 0) {
+		err = mal->txeob_irq < 0 ? mal->txeob_irq :
+		      mal->rxeob_irq < 0 ? mal->rxeob_irq : mal->serr_irq;
+		dev_err_probe(&ofdev->dev, err, "failed to get IRQ\n");
+		goto fail2;
+	}
 
 	if (mal_has_feature(mal, MAL_FTR_COMMON_ERR_INT)) {
 		mal->txde_irq = mal->rxde_irq = mal->serr_irq;
@@ -643,6 +649,11 @@ static int mal_probe(struct platform_device *ofdev)
 	} else {
 		mal->txde_irq = platform_get_irq(ofdev, 3);
 		mal->rxde_irq = platform_get_irq(ofdev, 4);
+		if (mal->txde_irq < 0 || mal->rxde_irq < 0) {
+			err = mal->txde_irq < 0 ? mal->txde_irq : mal->rxde_irq;
+			dev_err_probe(&ofdev->dev, err, "failed to get IRQ\n");
+			goto fail2;
+		}
 		irqflags = 0;
 		hdlr_serr = mal_serr;
 		hdlr_txde = mal_txde;
-- 
2.54.0


