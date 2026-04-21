Return-Path: <netdev+bounces-280028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGTHGmsq52mo4wEAu9opvQ
	(envelope-from <netdev+bounces-280028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97361437C50
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10071300E1B9
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904D737F010;
	Tue, 21 Apr 2026 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvB2zik+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527583368B2
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756835; cv=none; b=kUcK2PLVHPZZ5jqMn1txSNma3IVT9l5CJ3wrh52e+bEuYOg7vfT1D+IawhXOaL46/bj7eqSHBpA3fVb767NYfLOP06OaBivftFStGss/M43svHVwEOw08Wb0BdwQ/Owmds77cYdpV4L5xU76rJY7ytniImjL60KX24/Y/Q98E1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756835; c=relaxed/simple;
	bh=kacipmRh/ARA/yj251suNKvUgkiVHzItJyjKIF1jCv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FBHb5HuZRPu1dLdox3/eEl/MJ02xlRCLI+saNGogI285+eYPa7p07R5QH2pV3l74vn0f6AuJTzRqGvUvP24V2tnszJSntVwdqZ4IIeOwV7FYPKFrAZD/Vv/+0nDd6gq8Ibzenee3Rq63kmqY/z/WTsHfPESi0gJM/D7eWvVO6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvB2zik+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3614826eca4so3355216a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776756834; x=1777361634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tN5kwaSs4mUzaWaK2mJMmR2b/ZFzAdC6nGIO7bzkSw=;
        b=XvB2zik+You16ZAqXsdCCWXx9ivmehqG4NGlR1hGiIdeluO3DKYjN3qkYYmVvsBwmY
         ia6oqVGIdWrxxT2lmQ2XdbAXrEwnVvrd6mqNCA9m9+ppJUxS0qxkmRsGBcxkK9mfg7Us
         28Y26XviCjkbVV73NUsimZpofjkuaKNIqQ2Ddw1/jvG0nUceikMFUHTj5JUeGbh5aOH4
         cJ9xHok2gmQkCEYPEKDvgKZHVzsKsXAf9sGd5HviNASSqf2DTdCeP4ysicHQHRo3pNEo
         SH4Ae44vLrae0OTLGA5sWzPuzElh1NLH0OPDZpTvwksgpAEu91D0SAKK0ThdJfX2OSss
         4QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756834; x=1777361634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tN5kwaSs4mUzaWaK2mJMmR2b/ZFzAdC6nGIO7bzkSw=;
        b=JxZtboz673U83NK+cJ3HWRQ6CPTITEsh06aXxBAf9iD4hsBEwxqA0y93LPumGl4Xhx
         pCZbSHXvppJFe1TqmBloK/MG6Hwrc7u5J5YXSUfNmYjl60N3GvVxCILXdpDMsYitAHwC
         I+HipVcz6HjD3F0fLM2HK16OLH+uubnKT4rqJm4HMjWwhexkC/M4Fog6EFMUo++3piyU
         TsrmsQvaXJIcYx4fvMZM2oUkBQHRZZsL7pelKjPRdAh1LJFBAKHsU6Js0uQn+Xw12XzD
         p1zEhP5oQHEVXoaSRUFkOOX2kiAaz/W+1mR/Jl9w41W+s6gXqy9PrhplLXQzT0R2qiSS
         +p8w==
X-Forwarded-Encrypted: i=1; AFNElJ/Bb5S3tY2cPzxjGiWSK+4YpkOVJsIKFE1l5o8eY8wFAgJmdu8+2+Hf1KIZaAsyzRa7LTOSO8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPwa8OW4VXGjBvIKW3xxLZccSkfFIxriQ1+/hmgO/mWTYEpiw
	uJpTOm7xyzC6pN6bte5OVmbL1PtT0gPNH5OHEtaBeQRk5MeeyZlbPdEX
X-Gm-Gg: AeBDietqFjNm/qQRGnO1OYIHx8p6a3QJ7zTEwI5LwMk6J1JxaGCu7jlKS+Yn91/HSUl
	pSVBXSchZAHTQ3YM2SSyVcWSYIA8FJ9DXziLwQbBOunTRg7hPtaS0oCGjaFEqJZcYxQRDEF8Mij
	pof3FJy1ZlMKSMXfX568jQpcr6roPX//WprBHiH/7S5qhHX4MgUBf6LzZPyYimhleQCg6qNaPQP
	wLho/+0GdS6yOmTJVbcysZ9lBRjsfMM0P7MTZ/phM+fwMqcw6qXuOBx5FQt/35nN2HpH1pnk/rZ
	PV+E5d+MJKX1QpVyEf8BWHWq3cvUserLHPnxodH52IdDpAzw1tkuI0uHVeFy39Q+j0uOrtk4Qqk
	i3KWdJSv0iQwbtBBbxfkFlztNKtQ0wEEOKBQs+2gYW7AtG2mu6DNd6ny7VKnMHRUJ+QjaaNboSY
	T5dXUROKoIWqmHaVUvmUDHBCut/5/NQFQMrWeKoqwfk9RwUZiTYNK1dIi8NzfSXLrAGnfOz8Nhq
	6OjXUy4WZg=
X-Received: by 2002:a17:90b:5865:b0:35e:27ec:dea with SMTP id 98e67ed59e1d1-36140493410mr18530382a91.23.1776756833615;
        Tue, 21 Apr 2026 00:33:53 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a8f0sm12411902a91.12.2026.04.21.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 00:33:53 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH] ieee802154: ca8210: fix cas_ctl leak on spi_async failure
Date: Tue, 21 Apr 2026 13:02:59 +0530
Message-Id: <20260421073259.2259783-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-280028-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cambiumnetworks.com:mid,cambiumnetworks.com:email]
X-Rspamd-Queue-Id: 97361437C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ca8210_spi_transfer() allocates cas_ctl with kzalloc_obj(GFP_ATOMIC)
and relies entirely on the SPI completion callback
ca8210_spi_transfer_complete() to free it.

The spi_async() API only invokes the completion callback on successful
submission.  On failure it returns a negative error code without ever
queuing the callback, which leaves cas_ctl and its embedded spi_message
and spi_transfer orphaned.  Every kfree(cas_ctl) in the driver is
inside the completion callback, so there is no other reclamation path.

ca8210_spi_transfer() is called from ca8210_spi_exchange(), the
interrupt handler ca8210_interrupt_handler(), and from the retry path
inside the completion callback itself.  The exchange and interrupt
handler paths loop on -EBUSY, so under sustained SPI bus contention
every retry iteration leaks a fresh cas_ctl (~600 bytes per
occurrence).

Fix it by freeing cas_ctl on the spi_async() error path.  While here,
correct the misleading error string: the function calls spi_async(),
not spi_sync().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ieee802154/ca8210.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index ed4178155a5d..bf837adfebb2 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -919,9 +919,10 @@ static int ca8210_spi_transfer(
 	if (status < 0) {
 		dev_crit(
 			&spi->dev,
-			"status %d from spi_sync in write\n",
+			"status %d from spi_async in write\n",
 			status
 		);
+		kfree(cas_ctl);
 	}
 
 	return status;
-- 
2.25.1


