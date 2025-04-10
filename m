Return-Path: <netdev+bounces-181352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13EA849F5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD94A59A0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08C283CB4;
	Thu, 10 Apr 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8NAJCn+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2B1EE7DD;
	Thu, 10 Apr 2025 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302657; cv=none; b=KG6aqB09tc55maTdnvqlg3H18vyKcT3qJUISxO1sfscX6F89+qW8O3tF5maBH/o1So0FjA1K6sMaLq5JIsJa7o0cm3fkTpK1OmpOQx59IU5IzaUoOB1KvnyD3kLLzdk68HSh4ccTY/Y/BCw2yui7qt4RAoei+JnfHBcBSwYQSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302657; c=relaxed/simple;
	bh=B8arKt5y0mBJQjZWMAQsUkboWOLniGJPsCAPDAVJip0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSX7Z91RCGXSBGfs/Si1CF2LsTMRncERPVVAeSTy45c5w/0ZPt4FhqzzQnBW4jegeSJyJ5+kxlfbmHeNwsblP7vNEJ8Lvb0G/fu/gYUjI0kk4Cj7YkxqY04DZyHLhaPUK695QIcHU1Ageqcqn+5jF8dOlPANkvhDy72QeD60D24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8NAJCn+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso552220f8f.2;
        Thu, 10 Apr 2025 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744302654; x=1744907454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axLOXVmnrt5e6ujgCV+4/WW/JoQqDkbI0ei5W2Ow3O0=;
        b=X8NAJCn+C3pW4QocziFeCZ+sCp6o7qIeZl0ZDscwwK57k58VW3BHkIrEBVncKUQKlN
         1mf7hdDDTee0xzsMpl/vEWnm77vUNlIAnhaGPpxSO2EkWlTebf3+Nh1MdLnxmDw6aw87
         1+r+tMScc/9pnIjhcJHCiSSY7wbzqiKULYrsMtJ5/nH3/xdE+CG04L4eqaawyPgVPGTE
         PHtfZqp949f+COmLiBin96vJPOIgk+Mu8/Mvj+5DHdwCqu/ZO7Z8Tl8IYm1TSrXyV3wF
         4IzPNYP7gxqTmp9i14Wz3GshbUZzZ1TVF+EjUHpt18D85yZQtgAau2UbDCdwrq9zyImm
         N4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744302654; x=1744907454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axLOXVmnrt5e6ujgCV+4/WW/JoQqDkbI0ei5W2Ow3O0=;
        b=AJB6uq+mf3u+ZL9Tlp2v8r576S4zhf6uxZkastzXtaBLdBMq8kPm4iNqUjcfoLQnOs
         mdJr1m7X2HGccw6II/VNIv0bUUQ1zwkaYaRPo+DgQgDNyJHwsVaYm+FVuboxV9bOnvC7
         yu3OHHK5FA0Gw6pUct8s7O/5OGt5QA2z/9rD7jLBxEjLc2D4aSTNY/sp/KQwkc6aHmYP
         4OS7+J3xATZTlkC1emB0cu4p/iXdIgj21d0sqwNW9lQTHjvLEm5cQUu+TeZ8VusS0yZ7
         Fxyk6Ud3cvpE2e6cLbTEnNxlj+Sh/wybpXF9Q/4pIfrcxneLMDRqY05wqFjYIMUw0u7N
         oebw==
X-Forwarded-Encrypted: i=1; AJvYcCUKvD9nrFVm/8dVel1SZ3trQH6MW4m8iqc7hfPDT6r07tdu0SYJmBsoGNFJ8+lzRNVht1Rwc1se@vger.kernel.org, AJvYcCV6wwQ5XwXZtkDa8qmJHlX2UVc5iqmoK5MwRp2FSKUzjOzQCtcEFP1T5hPyMJUfd9BfDYV4CT3t2Kb4cJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFi60pQuw40ldjAGowYvek95ZM6YxCW7QSadOOtczhaZ4LID/
	ZzfYRT/73KZlMmvWYYe6r6Syr7cw5VWCvfJl3UcdL/Pa2F/Te1Fi
X-Gm-Gg: ASbGncuNrx20a6OyPPEC7WQF2Iz5ChDBVJ+PlHEvb3trcE9LKbN15tyw2ZjvkW4AyZx
	2dcJC7g3VTus1ZWtDtB3XznOj22YTHPo7dDVHQVdzexUE1hM5o5TCtNjCKwLvpSrqb3+6xxUjuq
	yhlXzGuOcg6HVe4qhbfmKlOy6f4XCORmoeWPXz1gWUZr5DLlMlsPYvzXWJz+2liS7hZI14Pp9GO
	Jsr/UpW3LM/+/tkCgPDdTI6yGTfd1ejRjyZIcV8lfBMdHsbAhS8KboJWnUbjj+Op3sISPwATdeA
	pEllvoIZdS287rkp0RiN6p+C2wAajDmwGsFFc8yfnrkBFo+mFs/Ee6yAUExgTYxHT5HlO4JRaMs
	gIuQ4fgApKw==
X-Google-Smtp-Source: AGHT+IFYEtIPIXHN1PmKXXRRja4VIhg3Bfr0bEotT+71cwpTGX7+kspOZn+JoXE19bC9P/Ywz3zMQw==
X-Received: by 2002:adf:9c84:0:b0:39c:1257:dba8 with SMTP id ffacd0b85a97d-39d8fdaba5amr2282339f8f.56.1744302654265;
        Thu, 10 Apr 2025 09:30:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d893f0a75sm5374033f8f.62.2025.04.10.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:30:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 1/6] net: dsa: mt7530: generalize read port stats logic
Date: Thu, 10 Apr 2025 18:30:09 +0200
Message-ID: <20250410163022.3695-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410163022.3695-1-ansuelsmth@gmail.com>
References: <20250410163022.3695-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for migration to use of standard MIB API, generalize the
read port stats logic to a dedicated function.

This will permit to manually provide the offset and size of the MIB
counter to directly access specific counter.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/dsa/mt7530.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d70399bce5b9..85a040853194 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -789,24 +789,34 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		ethtool_puts(&data, mt7530_mib[i].name);
 }
 
+static void
+mt7530_read_port_stats(struct mt7530_priv *priv, int port,
+		       u32 offset, u8 size, uint64_t *data)
+{
+	u32 val, reg = MT7530_PORT_MIB_COUNTER(port) + offset;
+
+	val = mt7530_read(priv, reg);
+	*data = val;
+
+	if (size == 2) {
+		val = mt7530_read(priv, reg + 4);
+		*data |= (u64)val << 32;
+	}
+}
+
 static void
 mt7530_get_ethtool_stats(struct dsa_switch *ds, int port,
 			 uint64_t *data)
 {
 	struct mt7530_priv *priv = ds->priv;
 	const struct mt7530_mib_desc *mib;
-	u32 reg, i;
-	u64 hi;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++) {
 		mib = &mt7530_mib[i];
-		reg = MT7530_PORT_MIB_COUNTER(port) + mib->offset;
 
-		data[i] = mt7530_read(priv, reg);
-		if (mib->size == 2) {
-			hi = mt7530_read(priv, reg + 4);
-			data[i] |= hi << 32;
-		}
+		mt7530_read_port_stats(priv, port, mib->offset, mib->size,
+				       data + i);
 	}
 }
 
-- 
2.48.1


