Return-Path: <netdev+bounces-149414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5078D9E58E5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F020F188590F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1A21C18C;
	Thu,  5 Dec 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyGNW0MJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E721A426;
	Thu,  5 Dec 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410352; cv=none; b=JwBsjHP7ZnuBJ+WDv4oZtd6ei3mZK559Tv7GBPHvCnLEbMl/nPgmomEpCULRwCv3Az5WPLGSDAGpzSGvDtZJEr4bUnMbGoNa5j1i2PpkgJGSZdKW28cNZBVaMMWBJixEDVA8hlHWBKmhqjUI6mOgwj/jtY+Tjwau4BrQa8UdIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410352; c=relaxed/simple;
	bh=wBHqyY6MjepBYQbqdq4avo9JeA5AxVmMz4YAIR6y9Ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYnmfmFSYpgznkE/y3Wc+eYyPwFuiRFlifDCLKZJltLSO98a2rJ4sb/71V7V+4LonP4DvYyTecLKQupv6R4Byj4zDS2td5A781qCLOoz02rcmJYpHjCiGlB9ef7DnbOqvqParkuKaoHRQrfOUh/fDdlBUkAOZTX0fG0cMsDrjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyGNW0MJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a1833367so6414395e9.1;
        Thu, 05 Dec 2024 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733410349; x=1734015149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM0mNCtHjT+hsg9qAEDa4xZpSra1ZeG4WjgSFO0QQkI=;
        b=dyGNW0MJ14xaapnANxRSwyEe+rAxuhGY/hKu3wC2QEPL9+siHUeZpJyGLqFmC9TEuT
         3nMITOq46mLgMS/PsY89QZZqnoEjgeL5ctg4NGCPprudglb59O1FLFlv4+G1teqO4ov+
         8avSERzDQtXDO4Mw+wdz7uN4drkqBW5tilXG1eTtOdQLlVIjl/azKJ+M9K/yI1J0v4aw
         tqdZxiF6fU3e1JGoOsnSOhBd2XLBXkTr+Ic8pvLS0qBvuISCOWZSSH0zc7Eufdd7bWA1
         CjLDls+myo9gVPo+D7hOeYoE6fTB6NCuZxD7QQwTfcTdv2pyuCm+It+5qadXWZs5e9xV
         ik3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410349; x=1734015149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM0mNCtHjT+hsg9qAEDa4xZpSra1ZeG4WjgSFO0QQkI=;
        b=Cbn6pPT4oWBx6qN+KvIvFYyrox1OBMVYaUiY5mTZwCypO17GLHrC3YkgM+Zjn2Eq2E
         vXutS8wMF73k+x5WP9EAV/Kn1b47L38WroGT+Rs6oCcwHqqhEH5K+/U5M7gnavxlMlmJ
         i7X3+z6UNjkMeJlWHZDJivOYlUrOPLHlk/cHiFtzNgeyqDx8TEKjnl+U2Eyt2wnA/jpM
         8TEFSLU2HF4mk4BYEjaMODBLax5S0M5fY6MUYDAVsDAFe2rnNk3nU3rQkcOrQxLj9XgT
         PUuAOgBzKdVhOFEldxi+YuePkEveJAh2Q/YeIFySgQoB5IVCjLoDUwXMPjZuYthg6+uN
         7G+w==
X-Forwarded-Encrypted: i=1; AJvYcCUap54OwFlyckRdm+1eUM0KYNthIIc2QdVZpjCHO9/i6yGBXiWBrgnT6BuvU7irGrK+UrmDcdmzOdEQ@vger.kernel.org, AJvYcCW+BJAzGXRo8q6HrmeG2DLWPE//vwBjso1U9GB6vkFYu8M98a08zlASMR3qD5pEZ3g/kO03WvajxaGAgNRu@vger.kernel.org, AJvYcCWZrVy7n9k8bud+hQk6bnRF72BZr9P8+MVmfxfPSBTxjHILrw77NrxLRTvd+YsV26ovFPH3uF2H@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp/H67o1Eu9tq0q1Ou0PMpuo2tw/frXar+SrFvDYYriOUC3aWm
	o3UNk3upvbiMxYxIY9ZxfKgRoVsFC2wTVs555I6/nha7ZhISBz8m
X-Gm-Gg: ASbGncv1D9rvCZSgZRRn9+V/RN6PWzmlevITAF+IrpYo4aw0vw9ccOfLYNJllCMP4M/
	blZeeH2AcfUV+u5gEexrbAEfgyUnjJ22q2s7WiR9/Gk+Gd/sITLd6vnA2yGbf6rn25V+F7pYgJ9
	vkffDJGowyWNL9GABI5frA0nN4mhS/S2WVe6iiRVWlK5TVWAoqJwzBNAS8d+QUS0zJNQA18F59m
	vYzf6uRRdzAO//NCLzGkcek1vp29z7fi6LX/51bL1Vl35BvDLvMWUyY4J63sWW200OI5NSf608T
	BwI81gb8Wnve81+JBTU=
X-Google-Smtp-Source: AGHT+IGnoyqwOOVYCV9qD7ONeMIC9R1ayJbcX/cSJOs0/DfqcFNWMmtEIiHEzgGy0mkLPSyUnS5p/w==
X-Received: by 2002:a05:600c:208:b0:434:a4d3:31f0 with SMTP id 5b1f17b1804b1-434d92699ebmr29065195e9.3.1733410348408;
        Thu, 05 Dec 2024 06:52:28 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm26728035e9.29.2024.12.05.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 06:52:28 -0800 (PST)
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
Subject: [net-next PATCH v9 1/4] net: dsa: add devm_dsa_register_switch()
Date: Thu,  5 Dec 2024 15:51:31 +0100
Message-ID: <20241205145142.29278-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205145142.29278-1-ansuelsmth@gmail.com>
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
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


