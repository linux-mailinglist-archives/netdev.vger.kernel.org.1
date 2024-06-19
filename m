Return-Path: <netdev+bounces-105046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735290F7D7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30666285A48
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA1015FA6B;
	Wed, 19 Jun 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK0ufNg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D415F412;
	Wed, 19 Jun 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830389; cv=none; b=U3Uv92wSwgXHBvIVc1HfDXALP8NgZfuxDuAYcmxA625mOplU/lVv7jgKHjUI/OtG52qeavdwWIdMAiRjNh7nG2I8+Jm+o0NF63g4teYx+xfctcZJHX/m8yBnT6pilE6JYQhu/rUxucgdsqYPzueHDewceernVlx8PdLE+NI7zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830389; c=relaxed/simple;
	bh=nhjkwOduVWRv2nZGrxWwvNxmMCZJKhs9MlQ8oMZuzz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AekQsbI4vv5FBeP3g18juH4KcWWPvZojWXOvYjK6HCwe6wqUKdu2rr0IX96b10utALhKDmyd/QwSm/OfPfOiXEMQKCIGH+cVWMksW88hhM/VJcEDYQO7EwsR8oBcRWWEfPa+ZCokJkaLrCyl5tdJ3Iuobmry0rKG13neKUlrdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK0ufNg1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6fb507fef3so17071566b.2;
        Wed, 19 Jun 2024 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830385; x=1719435185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuO/iwF6ur7qvk/j0Z9BUw8W/6Nr6PqgyXNq0MvOId4=;
        b=bK0ufNg1iE5KdSsXzgLaoFbrEO17qf3szf5wlwLnr2+G9YVZN2kMdJ2+/m1pkLkGUB
         VTl+CSJ3nK+ivhAVCiMS0kUCGozpt+ZXOE1VAX0WtXzQOKHm/PEfTQFwUHb7rCXovswA
         6fwU+b6OumPQ2RAcsUD310TfUyQM6OIIEr1qF2q37qrhgyqa0Dt8b5Iva5t5+YlGBIFM
         s20ihvayI+1Y3cLGUTc3SQYezD2Q4TlNuSqoetGzEmzoOUxIvgd3Q/KcveIzsJIpZot9
         QyGPH8RSCa8AnSG0beCHQQTomlZQD13Pibg43QfDSZLe0oMfGZ2V4muPvoCJzsWaf4VI
         bY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830385; x=1719435185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuO/iwF6ur7qvk/j0Z9BUw8W/6Nr6PqgyXNq0MvOId4=;
        b=ClxYRV7XSMny7PzjUyxCKr/A8nmjdwu6HpcHwlrLldxqlef0mngP4j6+WweHJVOf2K
         rg9h3MBWQqt0zJ1bErgeFGXGCE9yXBgLKxH7G6Zt8CncIFJ3guMe+0TGw1CyPQiw8uRT
         SZo8l0MFrmYahmBv3GpdnsgzWcbzP0G8KqeCnJ12RpeaBZAyNIA+9ZtURRzGjPFzHG96
         9U16eZmi7qr10dZ16wx29mapD2fLMtor80mzDV958M8M2f7s7lX/8xIUp2nW0dBLnzPP
         6YZTZHwJO5xql+rO5oLRKNBPDvHJmZEAWS0bazOUerMMk0NhLjwJ7Pv6Bkv5HRxBav8P
         zgEg==
X-Forwarded-Encrypted: i=1; AJvYcCXxuDqnKSsn5t//xoCSY+Bf8zdgW2FrE0/miyOFYMMEnNK8AhrrzV9/r19ilCEJpdtIDrUqvYqs495unGotB+8ceiJKwaaLsUoeZVhk
X-Gm-Message-State: AOJu0YxDsLMAHHOhYk/AWpoobUo/biHr4wTDB3k0gNrp4InIHkCq02OQ
	hkfJjrihw3vD05e+vZTMEMbnDicEkez2WMWLnxzWPVxjmvmqyDOkfjj2jhDUPFc=
X-Google-Smtp-Source: AGHT+IG/WrCRTcg4SiHM8fY6JQr1gvCmzJoOy52RdWfwEqTHtOb5JAjY8J0o25SlNLine2CKOfh2PQ==
X-Received: by 2002:a17:907:7ea8:b0:a6c:8b01:3f78 with SMTP id a640c23a62f3a-a6fab607b67mr257969066b.9.1718830385484;
        Wed, 19 Jun 2024 13:53:05 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b2fsm697329566b.47.2024.06.19.13.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:53:05 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 09/12] net: dsa: Define max num of bridges in tag8021q implementation
Date: Wed, 19 Jun 2024 22:52:15 +0200
Message-Id: <20240619205220.965844-10-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205220.965844-1-paweldembicki@gmail.com>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
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
v2, v1:
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
---
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


