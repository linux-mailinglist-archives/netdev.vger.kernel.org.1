Return-Path: <netdev+bounces-197726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7ADAD9B23
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340893BC08A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741E211A11;
	Sat, 14 Jun 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvIRZb8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E220E023;
	Sat, 14 Jun 2025 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888019; cv=none; b=tA20l27NPZ75jrVmwyLMytXyZxTDosEPrkFAZhCXjTnV28DfDQrhCq6v9TzZOQJ2e22iO7hKspk69z57QPyo1HyO3O9SSw8VJyOIDFiKnhK4SdoMV6iRuPu30lMxNCoTYXW2xDqCMQ3t6Qo96up1vfcHiMY51caEot1c8+zlhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888019; c=relaxed/simple;
	bh=++pmp+7AKatPjOrDxpoQf+VNxfT57hgNwfd+9yyEmz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPSw6Hf4h3kXy8zFbS7T6WZVrc6j6xhrGa5Ve2svX6S60hlI1LP24R8rn8vILgk9RTobYZaiOthTkEf8ominUwMfgOTiCCQcSc1elNyCkxvvGUTeQKv6WuS3ZI1MFq1tpfReAjyDoFMBhpZ5Mu1JhIjSfbKp2vdTKJ+OAUOV4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvIRZb8b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cfb79177so17325505e9.0;
        Sat, 14 Jun 2025 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888016; x=1750492816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5UKszGEBWsYS8aBocFaTWivMqZ6IfyHD+pXWqU60Yg=;
        b=WvIRZb8ber86fvIp7lIrEwtMgGhtYuk3d645yD3b8YJh1LUhuvpOZze8+U/FjPpFbP
         AuHf/jun3nzuOSdLSQtCb5dNs595Bsn7ELpqhl62l1CgwGyIicNA6HD2OJ9rp52/EXmI
         rpBAWCWAmLsK120zXCbK1RYLINlZFxppnBpucB9Zp/fYE4HOirTLYRp4m8mYAN9Ng+L2
         a/ebAYZdEOh/oE9WgaN5gg5cNmnk1GkxFY1GI/GGa679unbNJf7XrOdlwXdc+VK/KDK0
         tO6SoWIF2N+p4joCeb30S7vw8rtx8AiCmH2+Pb9iGnmFfhKbOlHi0E+BDuGAg39N6ygs
         FwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888016; x=1750492816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5UKszGEBWsYS8aBocFaTWivMqZ6IfyHD+pXWqU60Yg=;
        b=NSSMcTJ9lOF5uiAbRip8YhdT6Lg1MqYPzhmTsSfUQugJ4uzQnNWTj32AR48qWIsD1Z
         5iybcsI/4vTXZamxYKXktE4pGqLGkkftHZ0c2+rWbv0G3e4guwwatw7UstopEQOfoMHx
         1NBnlrtVBDpOyVtoGb7MvCGcDJU3m81B4hxjGHbroK+HEmlinbWW9wFbIfb5p1qH9dC5
         QbqptMvvAP2z05PVp56hPDmP6ozaOsn24ZcOXt+o0aQROX8fFjAMRdZ4aM7khmm9QVLN
         OsDc+DfE/ux9eaP1mM+KaUKXw5dXzMT7pzdSpdoq/l1ZfHmtzC5nCoKmQORiOGD8+fRB
         HvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh/7OU16haSjqdP7isR5qkmoO+nxShZzMlkImzISEgzqpb7NAK2hslzIciAK15JPearjrwovr7@vger.kernel.org, AJvYcCWgQG1fSi2A0zxLE1BKWk9Iv18Axba5sqak0TpQmb+zzxXkYJZ8ZlmWssJNrBoU1Ba1wcdnajsbC2nv65I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7nb8xmT16ZCF1Kb4Ho8EdtBslwg08s6xlOqWD/sL7mBBw4Rg
	wgvodaG1ZGEER5ivRJ3ts4t6EoK+R3ZyBd9wLJrvCQXZkjeAPaT0Mqnm
X-Gm-Gg: ASbGnctQopTsBUYZN4rnnUL5ULauy86g7aDpaS4B2b7cd3i7TggfXQjSwd3cSOQi6Ir
	LFeqDd77ik8CanbyM4z5eVeL1cFXaRPJG3Jn8H6h0szC15HCme/Tt0sw1vmHVb1uogmBeURRdTo
	bn/xIs6z3W0jfKu2ZJ91WiVzUhSHnafUmtBFa6nqR4Bw60B8RKsrJ/2nYSS7bErgLcVXh+a4dpe
	jjbKm14LOE1g/H3FvpqliICbdIBmtzdoIhdsOSos8FLt6rL6HyNuFj1oJ9MG7SiylZy42PUGRei
	lrlEZByZAP+PAFfyL9ih00HwcFCNKPCbUNbhlbkv4ZTu6SQSHMnyY5GlTwEP9OCO3JUmUiVR4ky
	80i9pFpTecPdKmCRQEAcH5XH2r5R0Xu0D2cf7P/GvpR21tjonfcp5U6YKLoWBFWk=
X-Google-Smtp-Source: AGHT+IG7U/y6EZq2H1U1DbQR8wdnEFKDtkzu40Z/CQvtvF5rgRBjEkpbvHcCGlshWSdfKr3oK55i+w==
X-Received: by 2002:a05:600c:3543:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-4533ca91fbfmr26688995e9.14.1749888016270;
        Sat, 14 Jun 2025 01:00:16 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:14 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 08/14] net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
Date: Sat, 14 Jun 2025 09:59:54 +0200
Message-Id: <20250614080000.1884236-9-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement B53_UC_FWD_EN, B53_MC_FWD_EN or B53_IPMC_FWD_EN.

Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 18 +++++++++++-------
 drivers/net/dsa/b53/b53_regs.h   |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

 v4: no changes

 v3: no changes

 v2: add changes proposed by Jonas:
  - Change function flow.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 24a9a0372122..c7c950127448 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -366,14 +366,18 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 		b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
 		mgmt |= B53_MII_DUMB_FWDG_EN;
 		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
-	}
 
-	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
-	 * frames should be flooded or not.
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+		/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
+		 * frames should be flooded or not.
+		 */
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	} else {
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_IP_MCAST_25;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	}
 }
 
 static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index 1f15332fb2a7..896684d7f594 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -106,6 +106,7 @@
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
+#define  B53_IP_MCAST_25		BIT(0)
 #define  B53_IPMC_FWD_EN		BIT(1)
 #define  B53_UC_FWD_EN			BIT(6)
 #define  B53_MC_FWD_EN			BIT(7)
-- 
2.39.5


