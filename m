Return-Path: <netdev+bounces-148837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8A49E3415
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DA6167F90
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B587F18CC08;
	Wed,  4 Dec 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLSMf9+0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A16186E52;
	Wed,  4 Dec 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297121; cv=none; b=eZJMmIFKbJGwdQbMGZZBvYoflWIj3TqLrrGuEZrI5G73KyCDGrXCBxG/rdD0KnA/T/6zauq6ki8aieXrjQ4HcPbReVfAZngbTYRj/hU2BrkFwIYpW11XLFhcro/e3G1zpSYlaOQqYFCHT+nd//dI2rGWU/LzIPLSrtHxqL6Sg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297121; c=relaxed/simple;
	bh=wBHqyY6MjepBYQbqdq4avo9JeA5AxVmMz4YAIR6y9Ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmzPgLfyyv1btYinHiQRx8uEca4hV0h6HR7v7sio+tdynNNecM4iMleu0do2XNeFhW67M0zSY3lnC87R09rTlXw6L+LCAIpr56olcArYM5AL9kPW5jS+BZvZ1lVreEByWLOG91yfMRl6dzwVjVD32mHTrSt6wEf+pkUQvFj/HCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLSMf9+0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so58933765e9.0;
        Tue, 03 Dec 2024 23:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733297117; x=1733901917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lM0mNCtHjT+hsg9qAEDa4xZpSra1ZeG4WjgSFO0QQkI=;
        b=YLSMf9+0w/cikmv41OKRxhwWdeO3zFxxVZTEW+ndMmT8LHK4mNWNlz4+IoNegl1pXw
         7nWv4g32MWE87eiumeKuxjszy87spCS+Ib8usDOmLeW1HkaWQ3R4h2x7h9Ig2xJeU5Yq
         YjCYr/m74qJgh7Bgj3De/YJJ99Wpc7muCiNeBkOhITOzclKkqyYpbbqGsAu1ImEYaCK1
         4hA4GE3kupBDIhKr1CdUiBZgCG3YMmb4/U+LroQ9JkI3dxCmVZYeNfv9PaK/GH4LqzLb
         tbA0HptHiW0ral+K3d3vp1/O0fW1UzryFUfckiUohUQQ9nP/4m4tjfANl1Zdj70Ny4+a
         f5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733297117; x=1733901917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM0mNCtHjT+hsg9qAEDa4xZpSra1ZeG4WjgSFO0QQkI=;
        b=nsrHE3eYbx8G671MjlyEsskoBJhxd7Timnyq7lrhVrauUHjTjmbzjf8ZPyq/klRFri
         XS3cAtuR709lJLqqdgj8JHTM/vrt2qUD1PmyXSGmE9ogwWXSankY/j03PP/8sYGF0br6
         2Vhxp9+ozh/8xXQFg27N+RdCYx/zM6TDUafLN7YfO2dr3qu8bhb6KZC5CbLsVW1mNDuy
         Y7g/oWtZSIfi/XINiRlfW+WeHvTorYPHi1Ajo6YSPccbs7u2SecJoe3s1CvKM7mz9JK+
         i7rdXC61hHYenQlXXllqLTPd+cvF1T3bfrkWxmDc6ztOz9H01HV4AvQlN9zgaONGPEON
         XdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnhvJIT/1Sd98Dw0FPt+za/+07PpHtv5ZPGxLHNBZykTzKu01rbFuELYkSpD30d6oBPsWkgubOWYJj@vger.kernel.org, AJvYcCWKwaUfqww8dhXC3l+wO0IvkENqw4AafWcg2uAByYjowKi1NjqeGSTadQWT1pPD0FzneU9Xt7BFE7k1EfRL@vger.kernel.org, AJvYcCXKbnuwu3UoZeF9qBosW/ch2JmyJrIHMZfy5arZbt9ytKzjujYcPXRjp4Yd++RoE+sXlHOgz7jC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/tYCTgI1BA3+F0AjdHE+hKezTQNGyx1fZK8K/tDhWo3RFHvO
	wamd8W+9UOEOV5MyHKQ7sxM0o0IsUxyrHRjnk0FmMIVgl/96JI4e
X-Gm-Gg: ASbGncsEAkRmvwqlyhPmVOwyYeCaXCLY5r2wQxkkip3/MeNtHJasE3VQh2UEDkwCt4b
	Fo7wExpNgzLdlckpZOhw6Qfhc2D0e2zv7tPk9SdkRkdRckFv56l5ktQUUoNGNn5BPGNkHAxYhmw
	Rk7OCDW8z0AqdyyDlAVOql/3cv3K5KxH+gHaiwIpeQ7BgMM8aAi7DQlJVVWqf2ChM7qMEnnxt91
	YMrCyG3A6nWrOmFQltVJU0ZQBrnLCMncZfplLa+Elk07nUrSluw/jysQ81ULcmKAhYcJj/TC1Wm
	wz4pyTUJyUPuoWgLkLQ=
X-Google-Smtp-Source: AGHT+IEhtL7LsG4DAXwbNqLf3tFfGzBkkKQkzEXZrrUsxaZJeipMuj9IjLDyKTikR4xXJlJjRYRVNg==
X-Received: by 2002:a5d:5849:0:b0:385:fbb4:7d51 with SMTP id ffacd0b85a97d-385fd42d261mr4633208f8f.56.1733297117038;
        Tue, 03 Dec 2024 23:25:17 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434d527257dsm14396655e9.1.2024.12.03.23.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:25:16 -0800 (PST)
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
Subject: [net-next PATCH v8 1/4] net: dsa: add devm_dsa_register_switch()
Date: Wed,  4 Dec 2024 08:24:08 +0100
Message-ID: <20241204072427.17778-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204072427.17778-1-ansuelsmth@gmail.com>
References: <20241204072427.17778-1-ansuelsmth@gmail.com>
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


