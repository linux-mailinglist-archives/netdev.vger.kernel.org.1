Return-Path: <netdev+bounces-289766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMTFJqhBDWprvAUAu9opvQ
	(envelope-from <netdev+bounces-289766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:07:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24959587B34
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC71030391F5
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FC36CDE3;
	Wed, 20 May 2026 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5sokyBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752BB3546CB
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253659; cv=none; b=fwmXW5mbp/XxjtsjnnvjnHhAWi6XgESxSzJAvCXITlooHJJUrkHcRuR8EPdbDkF8744ihmZx2QUdST/xJkDZ9uuEtfHY5DnMgajlc5rLx0zVIs1AOjAY6UyXttc850lIxVtgLb3FnKnC8kxfra/xN9vlMqFlR098ixq9bHcxvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253659; c=relaxed/simple;
	bh=5VTmq0pQUVhJbzGCPIsAQcdY2+RM/h7nWn5604rVx4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lWShIalwkzoHpQs852NgQsOt2XQqSfdSU4ZXet35Z4IRhJj/f4xdvF99C7iQdo9dxTZXwMgt+nvbIKkYu2VpKBNqmkAW3OYS0umgzGS2yOAKN3y73gd4WJZc3U/L3/qLJitGZ++xZc7bXezRmIVdW2HPrle6XdTppa0Yy9JrfRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5sokyBb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-83d31ac4017so2057288b3a.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779253656; x=1779858456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DsftlmHk5XxvL2LUl7ijPdE9313QNEaY7MNbZlADkzE=;
        b=b5sokyBbd16H5karwnkOcrZNoFc4nw1dcw0I45h/IaiU+3O6/KgXM/ZVWaEfftI3EC
         5xgDwWOrH1cKIWn7rFXQeyLA2JI6FqSo0eNYeJzt88tvOo5YPI7gB0NN+QevlM2YWmKY
         cT6I2HwWkoJMKtLWY5fG/tvhEs7cUMNFdbjYVi4lSzJYM9RzKp2/Rjv5JRw9uo2+GD8o
         S/201oNDtPnih2zN/N8dviTsCOHYCspw09IfBVBlXdPlVdA/K2VGWwug0YDMIqvO8QxX
         xxgduQOohRmZjaU67coIPo2VZ1xJ/4BPfUX2vWIiyDfai3L38VLWcRhdgu+WWhjjnSwo
         65pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253656; x=1779858456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsftlmHk5XxvL2LUl7ijPdE9313QNEaY7MNbZlADkzE=;
        b=spSatQDWwxBAPgs60OoWU9KDSvvNtdnVjgh8rG6cR+drI7uY6KpSuB1DvjjLJgePhB
         loJPHMA46SYVxe1e5H2d8j9V4inYd/EStCqvkujU2KPGRydQZ9EZCPnBeZLDGKn7Tiy8
         SBTp8rU7bfgpirpq2zBqwtkbmQ2knge1THeUl5a5xGtkN+k1aO2CQVSPgZkQJSdwY9zS
         Q8Gxzy4SLbnUMQ8G4PGWYj+a6U90vn7yZu2jq/TfVFRQqB6UWibJU1FwNR8n9vjZrwt6
         qm83jVibjiBWDPwY+myAuA1T+nlVg718gP9IYjhfZx11RDAYu7n7CUFmnkNkx/ryaNom
         uGIA==
X-Forwarded-Encrypted: i=1; AFNElJ/y9dClCieDlD1zEpektxHVL3kJWoA2z1kBF2Z1njkBfxraghkYBiBWVNzsE97p2P52WHj6pzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydISBZqBHa1I4zpeynwtgGJvXEvcQtrBOW30ME+EcyOiLTvHNu
	l4+NtouPrd0ahmwAQBZdDqSO5kv91jnwCEUK63Em7d69tTyHy/vSPgw4
X-Gm-Gg: Acq92OHhLzspkueUP0YISjl+3vS8pCz+D9JJSbZSLJnTcaQpRXqJlUxMWo2RSrysm3+
	IG6iqIgPH0PRi6BJzsAuciFwOK9vhORAwZoybsLVfAWwmZjA/GB/WhgWwj43rIvU2ZAo0biKiYs
	8F6Igj64Zc5aMZu2dKXpOhsEt9118JbicC/VkP+9wl8e3icWh7JxiXsnmaPcc17JQDX+fN9k3E7
	infan2m6ou+JMNCR70NKxXueYTCGvhdGC1mQn1pWcd0iWvEWtUCoX9nt/xkUsKK1i3wB+44lXF/
	rRPc4grrrgzZY4KsZGVvKiDMBXGOoth1u1R8gkkGpoLknbpe/tz1Y9OgJUDUoAJrtzttYGBOIm2
	+cz+zdA7GPOkj7ibrHQhT+hWEePrbcwoVZjOLVKEnV7QXBbOwktszLTg65Omxtn4P09+PM8x62A
	Jv60t3iduTGIaxO8DU4IRTUcDdERWyN1Fpyzm/T7+bltEqVGBokyV5SiszS+HY9Q==
X-Received: by 2002:a05:6a00:3e1f:b0:83d:43be:d537 with SMTP id d2e1a72fcca58-83f33cc3782mr21034334b3a.17.1779253655686;
        Tue, 19 May 2026 22:07:35 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5ce1fsm19786672b3a.35.2026.05.19.22.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 22:07:35 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH wpan v2] ieee802154: ca8210: fix pointer truncation in kfifo on 64-bit
Date: Wed, 20 May 2026 10:37:07 +0530
Message-Id: <20260520050707.38055-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289766-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,datenfreihafen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 24959587B34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ca8210_test_int_driver_write() and ca8210_test_int_user_read() exchange
a kmalloc'd buffer pointer through a struct kfifo, but pass a literal
'4' as the byte count to kfifo_in()/kfifo_out().

This is correct on 32-bit (pointer = 4 bytes), but on 64-bit only the
low 4 bytes of the 8-byte pointer are written into the FIFO. The reader
then reads back 4 bytes into an 8-byte local pointer variable, leaving
the upper 4 bytes uninitialized stack data. The first dereference of
the reconstructed pointer (fifo_buffer[1]) accesses an arbitrary kernel
address and generally results in an oops.

Use sizeof(fifo_buffer) so the byte count matches pointer width on every
architecture.

The driver has no architecture restriction in Kconfig, so any 64-bit
build with CONFIG_IEEE802154_CA8210_DEBUGFS=y is exposed. Issue has
been latent since the driver was added in 2017 because it is most
commonly deployed on 32-bit MCUs.

Found via a custom Coccinelle semantic patch hunting for short-byte
kfifo I/O on byte-mode kfifos used to shuttle pointers.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Use intermediate variable for kfifo_out() return value (Miquèl)
- Add Cc: stable@vger.kernel.org (Miquèl)
- Add Reviewed-by from Simon Horman (v1)

Link to v1: https://lore.kernel.org/linux-wpan/20260513153412.1284549-1-shitalkumar.gandhi@cambiumnetworks.com/

 drivers/net/ieee802154/ca8210.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 753215ebc67c..828cee8a6101 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -597,7 +597,7 @@ static int ca8210_test_int_driver_write(
 	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
 	if (!fifo_buffer)
 		return -ENOMEM;
-	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
+	kfifo_in(&test->up_fifo, &fifo_buffer, sizeof(fifo_buffer));
 	wake_up_interruptible(&priv->test.readq);
 
 	return 0;
@@ -2540,8 +2540,10 @@ static ssize_t ca8210_test_int_user_read(
 			!kfifo_is_empty(&priv->test.up_fifo)
 		);
 	}
+	unsigned int copied;
 
-	if (kfifo_out(&priv->test.up_fifo, &fifo_buffer, 4) != 4) {
+	copied = kfifo_out(&priv->test.up_fifo, &fifo_buffer, sizeof(fifo_buffer));
+	if (copied != sizeof(fifo_buffer)) {
 		dev_err(
 			&priv->spi->dev,
 			"test_interface: Wrong number of elements popped from upstream fifo\n"
-- 
2.25.1


