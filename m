Return-Path: <netdev+bounces-144229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F71A9C62D5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 21:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438B72836A4
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077E821A4C4;
	Tue, 12 Nov 2024 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2LJ3X7u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41650218D85;
	Tue, 12 Nov 2024 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444505; cv=none; b=fk5JVwjeg6coKY1nPYhW3j/COXXeL/jNmgBmGYe46/D2O1rM+0144+zvtUKcyF+EuS/qdbSYQDtWFCZl+dvEcDDCrCDSmijkGl0T5q1JR/C+FSP4pUmjXKhkdlxYwcjqur2oVTr2ZWBUXV4xckUGxYksvBJNsZvxsFoBQGXYSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444505; c=relaxed/simple;
	bh=AjOVzPLvgnO4+JOGHLqUqcBJyzhRvZiETx4q3zARrb0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwj+aPFwP0q+OvdrPBfUeeMWil/bby3hRTjYuZBMz4aYiCvpSX+/dpASrxruhGOUoz0gJjOUejdJLtuLBtBssfvskaWZ+OQZ3qPuOr+w15lM+3HMCjyZGzNyX4vGWjdee6SwseGuZwyu4hNSpBfbUYM5dgdPjnnJ6kHNO/msS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2LJ3X7u; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431481433bdso53995825e9.3;
        Tue, 12 Nov 2024 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731444502; x=1732049302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5S600OQ5nFPGkJIjgZj3AtisZep3gO6DhgEu5beaHtE=;
        b=g2LJ3X7uylGyQ0Tsvi6iuRoLGpuX2nSV/df/PoSwYl2dt7RyoP10BVWJq8vnarUwJT
         C1S1CbGHwBHX31LIOuas09qFvFtAh0LqEnmZUAE92M27+MEsceRGrLCTDbdeaSEzMYkm
         Qeqohu6vonK6DdIJCnAyxsvne37lUql081G8MXIxkEu/51hbPmVHEBV3K4lSZTm2qmTK
         1fhclfZpzCjjrk64h5pGmbiOHf+2+dqhombLiV/90J8p+bbCf1Rkop7oLvl4l5c9pS2+
         bdAYchN1CNaFVlq8fP5xR/ReMVR0a6+wbhsZPdFApKDvObe3s6Gqc0yQA//gX+S9oZdo
         aNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731444502; x=1732049302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S600OQ5nFPGkJIjgZj3AtisZep3gO6DhgEu5beaHtE=;
        b=li+lGWDk0kIFWUn3BunrltKIPLbI25EVGkmZuNBcriICvnjeSZ3gXZvoZQ0NaO1MZq
         jBaKG1tl7cQSVf7AQYjVMcOcKKFRNyfxTatdmHBtyB0zusQ0kxEePP7KX5u+kU/Rnsdf
         w0kFDlk/t812c2a4wI2zNKPtKebuEHEKKUvKQnVYj+43NTGctvTRAWARFoDu/Ve+J7VS
         tYcn43pHFrikXJU6QgY4KvoQ1skrmktlxtrQiL+L8rQaweeyFzAXFdILOEpWWqmiHvj5
         qusIdeSs7+8HOjZ3ymcWk/3c7tHgDABivvPWcr52aSt2REQzvNOJ04I9tTv+1jlpbSfI
         dhPw==
X-Forwarded-Encrypted: i=1; AJvYcCWEVl7y1E3ZIFZQAR8E256qUEjrlRPlYiEH9he2OorTOr31yy2CkXrrjfrFLk/a/YGUjatVpRFOUsgN@vger.kernel.org, AJvYcCWT3ZqQTfslMIJVIVWE7T7geW0LWiKhDVRG4x8Qi5WFN0ekKReJtgPUWpuixEOjj3EsU4MDUQSJ@vger.kernel.org, AJvYcCXiOC1x8IMexJ9XSGO9BS5slbODNx7F0LuP+WN5PL8BnogOrUoP1y/0HVrtiW46b6wYAMbE6SR6mM6Xzkkx@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7s/wEfkYMIJzanD6l5D8xsYUPHewrm3OEmkFthdup0GxP1GN
	0b6lUuvmLDajRSq10n08Ys+BEuPZeTMKwKzC+p2Yt/uzcCep3nQn
X-Google-Smtp-Source: AGHT+IHWD15rUbhDeGxX+d4Imrx+s08IlcvF/3k4i42ANzp0pz1zGptTDdhGT6/ns8k9Y02p2H1lyA==
X-Received: by 2002:a05:600c:3482:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-432d4ad65femr3678595e9.32.1731444502448;
        Tue, 12 Nov 2024 12:48:22 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b05c26e3sm225426715e9.33.2024.11.12.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:48:21 -0800 (PST)
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
Subject: [net-next PATCH v5 1/4] net: dsa: add devm_dsa_register_switch()
Date: Tue, 12 Nov 2024 21:47:24 +0100
Message-ID: <20241112204743.6710-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112204743.6710-1-ansuelsmth@gmail.com>
References: <20241112204743.6710-1-ansuelsmth@gmail.com>
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


