Return-Path: <netdev+bounces-245562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58378CD2021
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 22:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 445AA306818E
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 21:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD473446DA;
	Fri, 19 Dec 2025 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exx4xAj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAED2D3A60
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180077; cv=none; b=h0BUVKHLO4LY7xpSr0q002PyNzZxgobspUbLnlAFP9iO5uFSFCmAxUoLncDwRWoQutPFQJatxfOVnRnw/rUg5fvvXAbStLlLNSYJzi9wmxvigE1Fc8H5Qq32jsVEMnDuZisFyJ/e2rH4muHtxS7XgYavjD8aEV9BHhxyJyRDAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180077; c=relaxed/simple;
	bh=8FbHIXHWfLuxgf3xtxTNzDgOnCSoEu0+aZpZJeQ9mWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7nqT0P8jrwV1tOJN56PY4PBsvN3sihLKfMl+5QIUqmfD0UVzNzy1Ck1eh/ZbL789EQLK6u7E0rYOuwys25kJj0gIa7yndLopjY6RwR4Ri4eIR1cBemkx35hNyNN2PY6ugAcn6cunif9qRFNWX8HXOah6YjLGvbFmSIr1swjWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exx4xAj+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563e28a3so14487175e9.1
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 13:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766180074; x=1766784874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZLj05sYwE0LA7Tdl5LEJ2p4mWbQLxeYVPVLaNXSCeg=;
        b=exx4xAj+4LABQ8uJfDlhJh9oZ43aFxdbM44Hs3pVLoSNwCsmujKj3ZasvHcBodTyYY
         cay0HcxOc338owC1xZCzztDg7g57toE4JnbPbSyx9GPoVvIZ3pLAe3B/nNzDUTquzYOt
         JdPZaFFYjCnuPUxAm4sGAGrbxkSMGy+4McTajS51T3qHK1Y0gnocvn8Ky156Ib23lzWw
         IEsPc57Owt/w0yQWKv2bA812F3A0PdLiWs+JeWB/7sSa5hejKONwQWqJpv9aBNSbNc8i
         PTwE1q7ZTvQZNRtk3O+3Wcpyh8wt4VLkdj76mUS6xloC6SQomwCXyXdPbIWIZKv8ROHW
         3Dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180074; x=1766784874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZLj05sYwE0LA7Tdl5LEJ2p4mWbQLxeYVPVLaNXSCeg=;
        b=AR3f9deL1PISQ2hxaaN0V46IaMyTBwoSE5/aKVjoaEdcoicYX9nv4kkAH+ZXMps6fg
         s3wNvhiOzRma3xDfsw6RIvgOVEWMF+3t7P+ehvhVolVjcWgz7zl9x0JTsPEHBx194yqa
         7xT1ccoFU0lbY/+Ot9B49SPIhEXNk7lUbJEFjL8zUenOG40qkqXmltexJnr+QicOA4SD
         Iq1GJRzcuykMPtBvJ0QJ51bgDIe+/HWy5NZrvME1lY6oAn/SmvYc0jIYdFsAwi6hLHZ3
         4hEZD/tw9zruR20eu/CMem/nrVoWegnNluYr4A3KQjL/YaTj45vCyK2dk62+xie6R+Wo
         CQjg==
X-Forwarded-Encrypted: i=1; AJvYcCVIlz0R8AHTKbqhBVTyxDL7z4M2sKWPia+ZKnMcEP65XNko5omS24GEyWJJ1TOIvh/JfJTbyts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBzaZ6oCbpf0nHNRBoge9vjujUFzH3NkXeW7x3aB9iAjxGy+Q
	kYLq9HfAQ2m+/7VvpejOhfg1M0IHUmtxsUQJQRZEA9APq1C9KawtT5c/
X-Gm-Gg: AY/fxX49WEr3btMCk3y8nH6y5s8w0wsf61A/6MIKM5L3azzYzAroxYZcpPESQTeWw0B
	WC/A6NC1rB+S92U/Vj65FO2keZwdxRlfsLuVm7OdNRuQuPRfsfMikEGzFBnHPKh2Wy5SbwQ2qxV
	Aup4MTdBnW1HMaKDz9h5LCaidt8KufUqhuJG9XhanyvjeJ3MGGNB+SV5ft53JJnrbGv1Mv+wcoc
	Zyv87MjVjSNzsDspZKeDaJbAGrKKp41JnexLMeQvEcnekXzEJg7GHRl/oYjpBCrRVnvRBxW/S9f
	SzXd1V4/EyRsrQ+maKKkbeVGVljX4aw/O0Q/P4xch7C7iQak/zqPEnoQ+fBgV9QkffI5hKXwje+
	xbofvdzpHeMMxe+ORTYGqy74fc0Yyp/pu6QFZltdWOjucFCmzVNFZ7gGg7n+H78q+aU9BiXb7ds
	jdn2Su+cbyqNOZCwou6E+2
X-Google-Smtp-Source: AGHT+IFMgP/enUl1la1BBSXs4ST33XxJjubSW4ZkC2dvmsZAfgmmEbWX+svxAlb0q4PiUvjqAs9RIw==
X-Received: by 2002:a05:600c:1c85:b0:479:255f:8805 with SMTP id 5b1f17b1804b1-47d18b8307amr51508005e9.4.1766180074216;
        Fri, 19 Dec 2025 13:34:34 -0800 (PST)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723b2bsm112596665e9.3.2025.12.19.13.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:34:33 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: dsa: microchip: make read-only array ts_reg static const
Date: Fri, 19 Dec 2025 21:33:34 +0000
Message-ID: <20251219213334.492228-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array ts_reg on the stack at run time,
instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 997e4a76d0a6..839b0202076d 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1088,8 +1088,11 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
 
 static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 {
-	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
-			REG_PTP_PORT_SYNC_TS};
+	static const u16 ts_reg[] = {
+		REG_PTP_PORT_PDRESP_TS,
+		REG_PTP_PORT_XDELAY_TS,
+		REG_PTP_PORT_SYNC_TS
+	};
 	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
 					    "sync-msg"};
 	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
-- 
2.51.0


