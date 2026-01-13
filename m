Return-Path: <netdev+bounces-249371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB3ED17744
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF0053014740
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C16C3815D5;
	Tue, 13 Jan 2026 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ROfQah8D"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F813815C2;
	Tue, 13 Jan 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294931; cv=none; b=a0sN1Rg77h5iy6hAL3b2Oqc4n28GP//laKo7WqNPFqc8epYGMrpQp5t45Pi8xBV/BIlvi/EjL4x5OuczYnFUtO6iwsSvAJO6OmDG3VkHMo40eeEZZEiXhyczwkEb0pUfzDdf7EBjhRLrl+8H2GMVaUbhu4rhVhNAe4I81mO8nMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294931; c=relaxed/simple;
	bh=nr9/IaOsQYlU/C7lAnMxfez17MlQ2jIUCG6wMu+TG1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FawajF4byJGF7EZ94uFAvKcT9O/YIKwVKocGOOwp/NwPavcq1153gL+PfsfYcmeY3S50uaIf8q11VScdldRv+xiY34nPrtzYXfepC0E8itEI79AHTHQouXABT9sv8NxqY90RLAhoxZocG1TgBIg/KTyFfLnq532sgPk+fZ0SNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ROfQah8D; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1768294903;
	bh=8Q0eeOz992UGSXugxwAvk0uVEvAvMrcHzJfCBaiSzpY=;
	h=From:Date:Subject:To:Cc;
	b=ROfQah8DqvFjaMlXBZRkw6sduPOs7SdiMZTptAUPL1HVekzmdZxrJlUNk9cu1o/bN
	 XaJ2gJteHCs0P2SA1Aiq/FjmhP/NdIdyCvDIdcCkVuq7zXEx2Boko6hh+HgtVTDgjr
	 HHcSwAb7QYewp1YHMwj4bSvJNn0ub4oAuIQUHnVXbD4xrIvLc23GQ72RNAvK6eeDY/
	 nR2+K2rhiAs0PfDtqwGwWmJsVGrxEnSdGBnuRS4mUL2JGPZpqakRnTcvSUe9f1N5eF
	 NF4NlJgqXnjgmnLRpWuz5E6uv8TOav3wYmjC9vlI4g2TKnBT0OysyUyXQf4Q+5cGwR
	 GH+ktHWgmYYFw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 9294F6775C; Tue, 13 Jan 2026 17:01:43 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Tue, 13 Jan 2026 17:01:16 +0800
Subject: [PATCH net-next] mctp i2c: initialise event handler read bytes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-mctp-read-fix-v1-1-70c4b59c741c@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIANsJZmkC/y2OSw7CMAxEr1J5jaO4DdBWCHEP1EVIDASpKSQBF
 arenfBZjkfznieIHBxHaIsJAj9cdIPPgRYFmLP2J0Znc4ZSlitJVGFv0hUDa4tHNyJTQ9Vyra1
 UDeTNNXA+f3l78JzQ85ig+zWBb/csSP/6oCOjGfrepbZ4rAQ1GIz6UHqOUX/VbbH5mWVNkuqyE
 URKKlUj4evz38VpLypZlbvDM7HV3rDIzC108/wGErWLLt0AAAA=
X-Change-ID: 20260113-mctp-read-fix-e191357ad049
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Wolfram Sang <wsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768294902; l=1673;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=nr9/IaOsQYlU/C7lAnMxfez17MlQ2jIUCG6wMu+TG1M=;
 b=XNEXjgUx2OEDYxSuNJaeIB6npzDcprMXzwtVo0jM3ac47xPzWjICRSi92H3oL4o1BFu9QEA1l
 NSGYd1YHBfTD6MxbOT7l1Glaflzb8zps5vseZrudhdwL7aVM2Vx2zck
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Set a 0xff value for i2c reads of an mctp-i2c device. Otherwise reads
will return "val" from the i2c bus driver. For i2c-aspeed and
i2c-npcm7xx that is a stack uninitialised u8.

Tested with "i2ctransfer -y 1 r10@0x34" where 0x34 is a mctp-i2c
instance, now it returns all 0xff.

Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
I'm targeting net-next since this depends on the just-committed fix
from Jian Zhang 
ae4744e173fa ("net: mctp-i2c: fix duplicate reception of old data")

That patch and this one should both be applied to stable - will that
happen automatically with "Fixes:"?

Thanks,
Matt
---
 drivers/net/mctp/mctp-i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index ecda1cc36391ce50a6b28e6a9e13c3b344f8f993..8043b57bdf25095b3b4e6bacd3abbc6f8952acfe 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -243,7 +243,10 @@ static int mctp_i2c_slave_cb(struct i2c_client *client,
 
 	switch (event) {
 	case I2C_SLAVE_READ_REQUESTED:
+	case I2C_SLAVE_READ_PROCESSED:
+		/* MCTP I2C transport only uses writes */
 		midev->rx_pos = 0;
+		*val = 0xff;
 		break;
 	case I2C_SLAVE_WRITE_RECEIVED:
 		if (midev->rx_pos < MCTP_I2C_BUFSZ) {

---
base-commit: f10c325a345fef0a688a2bcdfab1540d1c924148
change-id: 20260113-mctp-read-fix-e191357ad049
prerequisite-message-id: <20260108101829.1140448-1-zhangjian.3032@bytedance.com>
prerequisite-patch-id: 0765450364f2e9f65f6f3940d4a45598763aae8c

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


