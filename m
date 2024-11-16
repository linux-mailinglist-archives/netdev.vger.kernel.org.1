Return-Path: <netdev+bounces-145574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6E9CFF1A
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 14:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1927CB20ED3
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631981AC43E;
	Sat, 16 Nov 2024 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC4Q8G6j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9919E982;
	Sat, 16 Nov 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762815; cv=none; b=A7Kz5Q+X2hadtjIGOPJG+EZw0gp/13Lz9cGN7iEouZ4eq9JMZ3HQ2Z/qGmRS/sXhjWs6AMKVc/U9eDodR57g6YwT0mEtFeIeKA/RPBkP+R9lq/SG/pKOQTqVP9IWli2hym75rv5a4GgIf9csUQ6R1QPFmGXRXVAwrfg6lE67J6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762815; c=relaxed/simple;
	bh=AjOVzPLvgnO4+JOGHLqUqcBJyzhRvZiETx4q3zARrb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFp7FQqkVHLxgw2ZMJJnjCSBZwR4IG2RcZrGQyn1sgsNzEhFgVyfLPNrxFrUA2UL1FC3vEuso6A0Y7+gN/XcQWwrxBznphN3cV6BZAtBuMd9gKClkUWLU15hF5yWx70tdsjfOAeZ3zuTXEbwoT232tiKD+ADmvjI3vRi32DmXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC4Q8G6j; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43161c0068bso4698555e9.1;
        Sat, 16 Nov 2024 05:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762812; x=1732367612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5S600OQ5nFPGkJIjgZj3AtisZep3gO6DhgEu5beaHtE=;
        b=OC4Q8G6jexZrygx7ZN9JSAHKqkWQdZ2ooGEDicjdCnTiQWqSjWVDdFJEJgkB7he+be
         fiV0ItZ5YWJyOim6A+1iBGmQnIIEGDMSmWFfciT0TYaZkn0C66hhvpQUPEylHUktnxC5
         qdRVESsYwk3P8OK6/7Hq6yHEzqtUejRNadYO7TKKce45vFbr6hf18ceFiTfYYXe8V8rd
         usZaPntrVYJ/B3jS/F0/ZHEf8Kxm5I2qWG5AnZ5+RQU4Jj03soEBm2zpdlEbaJXzoKf1
         9X+ZK0daBM1CzwKmDF+4J/mL681MOhmvW4H0ABfdbZU4wyrtDgPmdj8BFj4Q+nw9fLfw
         lw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762812; x=1732367612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S600OQ5nFPGkJIjgZj3AtisZep3gO6DhgEu5beaHtE=;
        b=USSZ31rmsz8EG/zwg7iX0xPb9CwvsFxtMrRKu66j4iUBSvs7n5hwr8Fp/StSscxsLb
         AyH4Ma3Wl4zYdTf53OFc0RkNlqy/Uzw/lN7Rw1PQsIcPtBZekXj5bO3pgmx1nQZw1XrD
         fIB+kAknqLGMfWNqYGLcvKH0qDJD5/I3FQ3FJ28Rqeq1rp9b+coZUUIv/RCY2xOlROwX
         2rrF/ZR/MyFaDISvP9QshFvE/e5p35JIrFzRPtpu1rXvOVntpan9xqNB6lTS74ri0de2
         ah763hE7bQ/8zuZmJo16PVLtrJaH6+qO6tQC1LKETgr4pjNeZsDoKEOTMsFZyJoEH40e
         weNg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+HNjV8Gzk4+1gxgNk2o17iqjgq0+0g1dXka6VX+z6KkTKeSveZS1NwKGrwRGHEIbkUwan+SozhcQ@vger.kernel.org, AJvYcCUZG+1UVM7wtAP76PPdXnpynX0qIiiocMsNNaqucBSmjRYvKkus93X7lnfmx2vsoBn5HZa3tWC+@vger.kernel.org, AJvYcCVD13hNBL6Htv+msdvSJVUlGZEXldyhn+NLzKdpnOGeXUTkeMC4OjKs4fydSxpXtzP3j9FwtqRS9jqkCpZl@vger.kernel.org
X-Gm-Message-State: AOJu0YyPECwL+0lWJAP+V/TaOqlBnkG2GjGGWXd2+KYiRVbQJEZCHGlp
	BOWdId+wA6CWCk1vqXU3lltVExl2WGxg3qluxpS3Uaz0mkxLahhr
X-Google-Smtp-Source: AGHT+IEPsaR+6e5r/v93HgKGecv+hspAsvfCMy3BdQXtK9fCxOVvt+14+FJzR41Vt6epI2YQyINaJw==
X-Received: by 2002:a05:600c:5021:b0:42c:bf94:f9a6 with SMTP id 5b1f17b1804b1-432df77a991mr46347325e9.26.1731762811932;
        Sat, 16 Nov 2024 05:13:31 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432dab7206csm87459595e9.7.2024.11.16.05.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:13:31 -0800 (PST)
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
Subject: [net-next PATCH v6 1/4] net: dsa: add devm_dsa_register_switch()
Date: Sat, 16 Nov 2024 14:12:46 +0100
Message-ID: <20241116131257.51249-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241116131257.51249-1-ansuelsmth@gmail.com>
References: <20241116131257.51249-1-ansuelsmth@gmail.com>
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
index 5a7c0e565a89..5cf1bac367ca 100644
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
+EXPORT_SYMBOL_GPL(dsa_register_switch);
+
 static void dsa_switch_remove(struct dsa_switch *ds)
 {
 	struct dsa_switch_tree *dst = ds->dst;
-- 
2.45.2


