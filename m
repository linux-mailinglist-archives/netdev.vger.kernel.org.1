Return-Path: <netdev+bounces-145638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807B9D0408
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB768283D69
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53340193435;
	Sun, 17 Nov 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im0Kr/RL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA01714DF;
	Sun, 17 Nov 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731850128; cv=none; b=oGIM4aFwPCfdj84p69pngZRUi+kKrKXdnh7U3qOCCvbYtFHReGFsjOipEzU3/o77rSn1kKiS2cJ+jRvano19t5Z7wCza0W0OqYSmySVceofFtRxiaszIc8qZz7yq+zsGxGeoSOJ4qt6P/t3F0ZnQYDIwTQQqp9I7a5PCTnPmaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731850128; c=relaxed/simple;
	bh=wBHqyY6MjepBYQbqdq4avo9JeA5AxVmMz4YAIR6y9Ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTI0osuz9zHVe975rIjdbOfriAPQOUhnUJOsRpn6aS3qVu+WsHRBtJUqgZEwOz1EltVZDSLXfu2e94WugNeTtZcjkzRa1SHFc0bB9q+qY40de0wq43I0ry/bXVZrUPLiDC7BdOuM4nGfJFkGX8VKdMI7Oofn0pQ93MiKArfrtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im0Kr/RL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3822b77da55so1009236f8f.1;
        Sun, 17 Nov 2024 05:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731850125; x=1732454925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM0mNCtHjT+hsg9qAEDa4xZpSra1ZeG4WjgSFO0QQkI=;
        b=im0Kr/RLwK9x83AnTiLHcxQjskREHuHoVoukN1fRQERU2wIyVXlkk9/R4UvjzHGxXS
         loMrsjqm/cQdO35ysjfjHEjq/msviTXpaDisrt2LeCc6ikX/kw81GjCoNgZUCrqxnRpZ
         zEnd9s+6jtU0p5bYqREybfOHkDz6IwXmGntgQrIg1xYSYyn0JlPBB55sj3Cl6Eqh4vAH
         vnlvDhIx2N57UhQEsGcfLD4x3cte7GHFjSs1qxCnXM4SPV15n9noHjZ7Q5vFuWyJ2F8W
         PlWtbTWLOjfyqucPQW0k4fHGke56sd8zi+ZqCxE1Pf9inkzHiXW/EKP3XoK13wg7CIlC
         7A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731850125; x=1732454925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM0mNCtHjT+hsg9qAEDa4xZpSra1ZeG4WjgSFO0QQkI=;
        b=Tf02Y/P9b4zOTtnFaCxNqCXJrAWDcwGSRIAmPeElwoY12M4+mVx0+NCaoTEhGzFFzT
         WqwaGsjPWOAFvWT7CfQA9AtsG5o2JbSunUnifr1y6ZBcPwM3YZeNL7ycwNsEfU0vkeH7
         K0mpCKls6tY4dcx7+UEO5erpnDsG3mTnOyyCyNnwfA2Tr9DpKib02ilqbej9+pkuPw9u
         LJHEODRSK4ALliVUoqYvNQc9PgYkjfbyDNvLa+PX2BkRm4YjzOVAMLFuGOlAYqYr1jq9
         ziQ2bbyRUw8J+1ak4u/XeNUuhiFW9uluG/VkPbuNO+mbtIFkkE1MEnFgC21vyRIOPVhI
         qyWg==
X-Forwarded-Encrypted: i=1; AJvYcCV8JJLh4ppiuYUJloGdSl9l13qfHsv7YTeh3sl422+X/NFaZway2DTAvlVBGh2Yt+tqohZpX+Ck@vger.kernel.org, AJvYcCVkUkeMszdBeBK0SLCEdsxBmREi0DgkfkvE4MrfwN/Knh369/TKp0lBExBleDL4N8RwB1/uncDHBZsq@vger.kernel.org, AJvYcCWxoqN6rnUFZY25cdZpnqM3hz2uN8sKWtZTEE0XfvhM677O1PUje1dOdXfGYVDabQwvcSQNg958hYbGEp49@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKRw3soOQ50iBC/1oLKEZosLWuCGvil7teTtFrEVUiBD/SD9/
	W45CAQKHMVablVysEc2xTkcZdwE2Gd6Of6IfOeWDTGRqrEAWekhp
X-Google-Smtp-Source: AGHT+IHrdjSGPtd1RYJL4WbSS/mMrLJi5dM8XNBGoaq4RzeqOcoaW8OPFKdOwSlonb6azsv9OyMLaQ==
X-Received: by 2002:a5d:598f:0:b0:382:3cb8:bd4c with SMTP id ffacd0b85a97d-3823cb8c05bmr3225712f8f.12.1731850124992;
        Sun, 17 Nov 2024 05:28:44 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38229b6e2fasm6282015f8f.40.2024.11.17.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 05:28:44 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v7 1/4] net: dsa: add devm_dsa_register_switch()
Date: Sun, 17 Nov 2024 14:27:56 +0100
Message-ID: <20241117132811.67804-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241117132811.67804-1-ansuelsmth@gmail.com>
References: <20241117132811.67804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DSA driver can be simplified if devres takes care of unregistering
the DSA switch. This permits to effectively drop the remove OP from
driver that just execute the dsa_unregister_switch() and nothing else.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/net/dsa.h |  1 +
 net/dsa/dsa.c     | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 72ae65e7246a..c703d5dc3fb0 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1355,6 +1355,7 @@ static inline void dsa_tag_generic_flow_dissect(const struct sk_buff *skb,
 
 void dsa_unregister_switch(struct dsa_switch *ds);
 int dsa_register_switch(struct dsa_switch *ds);
+int devm_dsa_register_switch(struct device *dev, struct dsa_switch *ds);
 void dsa_switch_shutdown(struct dsa_switch *ds);
 struct dsa_switch *dsa_switch_find(int tree_index, int sw_index);
 void dsa_flush_workqueue(void);
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5a7c0e565a89..aca6aee68248 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1544,6 +1544,25 @@ int dsa_register_switch(struct dsa_switch *ds)
 }
 EXPORT_SYMBOL_GPL(dsa_register_switch);
 
+static void devm_dsa_unregister_switch(void *data)
+{
+	struct dsa_switch *ds = data;
+
+	dsa_unregister_switch(ds);
+}
+
+int devm_dsa_register_switch(struct device *dev, struct dsa_switch *ds)
+{
+	int err;
+
+	err = dsa_register_switch(ds);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(dev, devm_dsa_unregister_switch, ds);
+}
+EXPORT_SYMBOL_GPL(devm_dsa_register_switch);
+
 static void dsa_switch_remove(struct dsa_switch *ds)
 {
 	struct dsa_switch_tree *dst = ds->dst;
-- 
2.45.2


