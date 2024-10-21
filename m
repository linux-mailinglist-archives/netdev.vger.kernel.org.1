Return-Path: <netdev+bounces-137333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B439A586C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 03:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C001C20D90
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 01:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC48F5C;
	Mon, 21 Oct 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clm/DLnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341212B93;
	Mon, 21 Oct 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729472817; cv=none; b=G05D/AWfw0Bdph/a7MSJvGUD6X8rZJNW1rHyh6r7x8cMj0rRBh6nWxNrl2+U+tTZCBd9EILPdzQw6w4giS8tKKizjT9qRluWz/OWoC7FMOV521f+q+fHcuiXko46vB8iDDyzSXxaw5IQVIhX8Or4eg03xhuAk0KP5FGECABxrno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729472817; c=relaxed/simple;
	bh=0vv9hPLNvtRFOuwl73h7uDEeRWK0vc+6/IgaeAr8sQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Unbdgonw1VAQlosJI27la43KhjtHnD99L38PJRtzS8mYoLgjTq1aW8PI4+lsFXmw8IbWXBhMiL+ZPLb0ODIzox+Axn7xHyJE6vKdIUXs0yFnj4HOilbdqPc/Ps+qoUIOSvq0tIMMgvaftk/u0bR9HdH3EnmM+2EYnkGGXOL+E7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Clm/DLnx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e983487a1so2731488b3a.2;
        Sun, 20 Oct 2024 18:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729472815; x=1730077615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKVj/4gnHsB+dLQIm92eEXZ0n8CmOnVfcybAAonlqFs=;
        b=Clm/DLnxrai/Dr1f9KKv7o/kc+KnD3FTos5dyGOQfz9SeHbibjn+Kx7BJG819Cx+/c
         +2fZNjX7DAMJfGyJB8V60EUZ1wKaimeGcdAe0yv0aSwiRf+M3RuREb4/GM5KfXe1ALxR
         m5pbV1k8JYbrk1q45xZPV/Lu8oHaiSo4JbejSZhemuO+Uybh6CH+MN/eX6U01A89Qq2/
         bajUyJKQurABFoSOTp4GRJrOUQp+WHG5FFJ5eLtMFf0u5UM6HDC5rS4zMtYNGzhQtOya
         REvMI8PbeImvFxGNB+M6DE+cI0EzuEPokx09IMxiUy+KnNdMeYC52AMNXGPNrsW4/JwE
         OSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729472815; x=1730077615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKVj/4gnHsB+dLQIm92eEXZ0n8CmOnVfcybAAonlqFs=;
        b=SDIbWpZkhbhmWG8yEc1ltXKyXCd/84QWOfcRUkpFshGJdxAaB0CaZUKj21QnBN9Ksq
         t3YW+8bOLv5EFbH4zRktbiDZCbVtNnksTLMbP9MB6IjRe7x0TnaahwWJsxn6YnbD0nHT
         w32AE7uaoa6zn0N/gAeRUqIiwAZvPT4SvV8De55kSk6GG7MjL7it/sqsQUZZPTh0evlr
         S6SZHQt24Gf/LVlr1CwYT0ReHAkSW5TBW8azrnIrBMhoGPXv1daxHGSaRx8exa7uZ1pI
         CL2Hs6Txyn6q/2MHtMzfp/bZwca+vv2HVsGN1pXIPROnaXPanTu2sVRTyQoi19wlLUiE
         Ej7g==
X-Forwarded-Encrypted: i=1; AJvYcCVMQzTYJ0L2DrKwjwT4SAgrvy+pUETxj4aidrogTppi91Dp5kjtmvl46m4I3bg4ZXU83NA4jMeF7DVrwv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwErbI++Hh9wK1iyLNWbY5awsJaIAdlL2UwbfdU3zdm+K1j/VoR
	6RSAGnguBR9s+/BRGY++FLbZIz2GhS3KDFgYwRnwOC66b+eD26J1EfbkrA==
X-Google-Smtp-Source: AGHT+IG9vCtkKhdi/k226tzhfyGv9Rz2Iq9Bo0A+utO7pMS0OMkz9SddJda9cVYw1O25ZUuc+vIq+A==
X-Received: by 2002:a05:6a00:21ce:b0:71e:8023:c718 with SMTP id d2e1a72fcca58-71ea31f627bmr13023881b3a.8.1729472814607;
        Sun, 20 Oct 2024 18:06:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d7478sm1715214b3a.128.2024.10.20.18.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 18:06:54 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: mv88e6xxx: use ethtool_puts
Date: Sun, 20 Oct 2024 18:06:52 -0700
Message-ID: <20241021010652.4944-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying get_strings and avoids manual pointer manipulation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   | 7 ++-----
 drivers/net/dsa/mv88e6xxx/serdes.c | 6 ++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index fe123abf7b5b..8416b03e131d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1162,8 +1162,7 @@ static int mv88e6xxx_stats_get_strings(struct mv88e6xxx_chip *chip,
 	for (i = 0, j = 0; i < ARRAY_SIZE(mv88e6xxx_hw_stats); i++) {
 		stat = &mv88e6xxx_hw_stats[i];
 		if (stat->type & types) {
-			memcpy(data + j * ETH_GSTRING_LEN, stat->string,
-			       ETH_GSTRING_LEN);
+			ethtool_puts(&data, stat->string);
 			j++;
 		}
 	}
@@ -1204,9 +1203,7 @@ static void mv88e6xxx_atu_vtu_get_strings(uint8_t *data)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6xxx_atu_vtu_stats_strings); i++)
-		strscpy(data + i * ETH_GSTRING_LEN,
-			mv88e6xxx_atu_vtu_stats_strings[i],
-			ETH_GSTRING_LEN);
+		ethtool_puts(&data, mv88e6xxx_atu_vtu_stats_strings[i]);
 }
 
 static void mv88e6xxx_get_strings(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 01ea53940786..327831d2b547 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -144,8 +144,7 @@ int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip,
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_hw_stats); i++) {
 		stat = &mv88e6352_serdes_hw_stats[i];
-		memcpy(data + i * ETH_GSTRING_LEN, stat->string,
-		       ETH_GSTRING_LEN);
+		ethtool_puts(&data, stat->string);
 	}
 	return ARRAY_SIZE(mv88e6352_serdes_hw_stats);
 }
@@ -405,8 +404,7 @@ int mv88e6390_serdes_get_strings(struct mv88e6xxx_chip *chip,
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6390_serdes_hw_stats); i++) {
 		stat = &mv88e6390_serdes_hw_stats[i];
-		memcpy(data + i * ETH_GSTRING_LEN, stat->string,
-		       ETH_GSTRING_LEN);
+		ethtool_puts(&data, stat->string);
 	}
 	return ARRAY_SIZE(mv88e6390_serdes_hw_stats);
 }
-- 
2.47.0


