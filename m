Return-Path: <netdev+bounces-102698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C78904551
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DEDB252F0
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A7156C62;
	Tue, 11 Jun 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFq+qx36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21959156C47;
	Tue, 11 Jun 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135489; cv=none; b=d4IuZK6WOttaTu/SlNQZ8OZmbz2UWShWP42riIPGniG40BXTrKixXn/mctXpkhyHUFRb4KfKPTNeYAHCmPSyFgWvGG1WI6aPOlHkoIdXEnQVSXdnKqKQ+9yR5zlRlg8G2GAWakrJJu2FREyTPoWYc0eQnBhf8D+QKCgHQ0elisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135489; c=relaxed/simple;
	bh=X0ZPmfLloqmpVIb9TshXzGhKrVzZ8CtutBNGM8GN3qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJKGyOR7F+TwP1ajWSPvuD8wms48DQRZUKCifO4EcPF6b8cIxLKiKKej9k+k794FlXgHE6sAoiuXHNghVFlqhP49dLhVfU9UvkCDeJ4HvOEInQ1c6IyurwjtDW2wMQhtVlbAEo2w4wTXEiHu2P55leP1Owp9dNXe6sjhVenOwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFq+qx36; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so65982241fa.3;
        Tue, 11 Jun 2024 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135486; x=1718740286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eANHmQBc3AlTNfbBTeiU+zRfE2tvSTSJjYs0pCCYYY=;
        b=TFq+qx36VvgQxufz1JVjWGNw/vfNB/IPziUlYeFQosZ7WGuGmQZ0fkZ2E+ATY9Z1Vr
         jeqiON9y5Bo7+ma6Y3AuzXz5Rx+lEEpQE4SLjTWg+GHLdpHqrGZc4qZZ95roOtBpijzc
         CxR97mWS1l9USD1pRo36Kl8Xj3co9IBYP+mFCn4lyn/jo52xHNXYLuhyqWDgSyIdqAw/
         7lw2bb8VnJEiy9Bhy/mZOcGILouVY0jl6v1abQIVPxdPsmnEQv5rhFM12tV43Hnw4jt9
         pVqzyWkofRWY9DFtoCr29KmL1YWzHGFhwJC9R/mp/oEvHAVIuKK727X1aRuTdk61agJd
         ztKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135486; x=1718740286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eANHmQBc3AlTNfbBTeiU+zRfE2tvSTSJjYs0pCCYYY=;
        b=MDh8we96Va1Vm5XeEiJehntIYnUjVOA7DjNTt5UJjCSvy0urZvsmlY0D2a0QtgCT5s
         pq+qRJYOfzp9QMdJohOoDi89s9vVE3pcLc6KYQc8S2igr9xjpH1gKl9a2uvLo1w49ZVQ
         EcYORbakMwkJWT31FyEqqvZy05k/9cQCLemJiAwlyOI6eRNsA8GoYXQ3y/VXsKvNnnG8
         nmNZXWWGjpqo15f/TmTTlyxySrYGm2T17+WQ1eS+H3liXC86DhXj30Ye0/ZE62OShJqN
         HhvWxdP0mC1wTO9ngsu7kCpB1mY4iizyPstfneCEOZYrnQIPszbke4b/z1e+IvAannWl
         r4NA==
X-Forwarded-Encrypted: i=1; AJvYcCVuOnN+arinXu4nQK6qGC5KIt5JLO2nQRfGdL8i7wBCQGNgzSe3UKetXPnZDoGro5wYhjbJQkrztMmWAiDUaX1nfSrA7a2ZwnqVSx3Z
X-Gm-Message-State: AOJu0YzNDM189lJ23QBJD9Zkewob0vNVoYid6rPxz1EsciQM4f6yF2TK
	6HSJnFpKSlj5DAfPh4a33mKq2VUyzyNBDYVgeZLdyyV13HPQ6nyhIbU4ENcw6Cs=
X-Google-Smtp-Source: AGHT+IEESn7w2tsjgocoMjHbgQP//+f5JggTuvmW5T4+G2lwrGenyJaQgwJHHf5X55t123Ry/FWu3w==
X-Received: by 2002:a2e:2d01:0:b0:2ea:85f0:9165 with SMTP id 38308e7fff4ca-2eadce35604mr85032271fa.19.1718135486075;
        Tue, 11 Jun 2024 12:51:26 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:51:25 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/12] net: dsa: Define max num of bridges in tag8021q implementation
Date: Tue, 11 Jun 2024 21:50:01 +0200
Message-Id: <20240611195007.486919-10-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611195007.486919-1-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max number of bridges in tag8021q implementation is strictly limited
by VBID size: 3 bits. But zero is reserved and only 7 values can be used.

This patch adds define which describe maximum possible value.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - added 'Reviewed-by' only
v6:
  - resend only
v5:
  - added 'Reviewed-by' only
v4:
  - introduce patch

 drivers/net/dsa/sja1105/sja1105_main.c | 3 +--
 include/linux/dsa/8021q.h              | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index ee0fb1c343f1..0c55a29d7dd3 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3167,8 +3167,7 @@ static int sja1105_setup(struct dsa_switch *ds)
 	ds->vlan_filtering_is_global = true;
 	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
-	/* tag_8021q has 3 bits for the VBID, and the value 0 is reserved */
-	ds->max_num_bridges = 7;
+	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
 	/* Advertise the 8 egress queues */
 	ds->num_tx_queues = SJA1105_NUM_TC;
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index f3664ee12170..1dda2a13b832 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -8,6 +8,11 @@
 #include <net/dsa.h>
 #include <linux/types.h>
 
+/* VBID is limited to three bits only and zero is reserved.
+ * Only 7 bridges can be enumerated.
+ */
+#define DSA_TAG_8021Q_MAX_NUM_BRIDGES	7
+
 int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
-- 
2.34.1


