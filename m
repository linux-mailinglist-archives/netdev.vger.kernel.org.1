Return-Path: <netdev+bounces-143423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12059C2605
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9126C283BE5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE9E1A9B3C;
	Fri,  8 Nov 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdGoCmbw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7D17A5BE;
	Fri,  8 Nov 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096170; cv=none; b=NsXwXespARh5VWzdkBZENJ+EG4Q2E7g6vVrX8+1i7oBj4ZvyM9TC3375+0u4mZUE7/Xt7Dd9GQ3DiXNyKbde8TqwR42oVLR3JW8uWt/ENI11yxwOLHTB6l+9vIRlqKXGh4QqqqG9xYzaDWw83Z/M7HKvAdECJdID9R82eb6laeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096170; c=relaxed/simple;
	bh=9IxIZTQigPBCCdGRlAbxA2LWPdmSedVO9RgEhrQd8Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLgpCCOG+lg1En0vO23hmUaF422S91h/gqp4wJ81tytuWBfsTzt2sLnjiFYslmFJMfgaSUlVgWFsu1YppoyqJceSAhhTtxnm+Y6yCplfmzPQi2nJzUphnL+07wcbvRSQJ9QpPHgNIF1pX60ImAUSlVIqqu3+J0h3HQmMYgfZuyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdGoCmbw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso35815631fa.3;
        Fri, 08 Nov 2024 12:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731096167; x=1731700967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=efBc980s0NSZ9N+buepZjEFdcjQ+iehyxc2MW2RnkkI=;
        b=QdGoCmbw9JQ0Y7pLNFuFfw9StK1FrAh+FPK3YyB5iJOoL9T5hjYGPd5a7KvWXrdooi
         XpzCDnRKSnPZU+FW/SRuFTOP3g81KhI7qYvgueAl8LrjVCPerMyMoaz7ixw3rHxKK655
         4D/npxlENfhR52GXC/DeEIg1KfFvLtOcKzhPX4l4Nkhlr4xbNpV/pMMJXdQo4m0b4nfD
         QypivC0v0waxX+rhGWP++jySMBiAcnUA86PaJ6zM8sGkSYk0LbKDxplp/C5yuDVyMtuk
         WWx08VnNj3qxm2390yps7ugDyxiiBB741CgkTtZt+e4WliM/HECd2AXyd0pq2vjttGyE
         Q5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731096167; x=1731700967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efBc980s0NSZ9N+buepZjEFdcjQ+iehyxc2MW2RnkkI=;
        b=KSjKyXtEtZIXpYiYyXdEdNTYUFzSfauyLdSSgxsx+qA94yzs675O8Xic9dHrMqDbEX
         ZPdTMmm/v2u64MqCo6RXq/d0eNL8K3RTtVgG6cxyF9BH7oEjm7h3C/q4kDYWqezuBVK7
         PTsKVjO99Av/xqIpDE1M5Hv3Cmg3I/wfWfsDFCk1CufKdbPQj60RPoS5T2cmCeBZn+z3
         pDyIh9iMJqNd9F3Pd5StrZ0vI3QY7XhDkkr92oDmUhfMHcIOadC6tuwMhyT5yBaPnUKw
         niGiSazOuTTQ7ekTyOIdmKriiGQnnWFycQXvvkPRiTO5nDqqkCHg+zQyz80z1ymcTewf
         iBCA==
X-Forwarded-Encrypted: i=1; AJvYcCVDcB8pC1lMCnCgNCr8R0EgjUx3FqFMjyYTlJL20nH5xikUTcg+3rUmVMh5RKzskpU3IhvIyWcs@vger.kernel.org, AJvYcCXgau08FGKbPQnF9tTbsz70VnyFQtRlhF27VF4hGs7c2KdaE5fFjTfnxLXrqShUpJpQPwYQfIwzUNz2RLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4eBcUXSzKx9sEgUJ17VI83A418AJSv0CJlYPLKAKP/38FL8c
	jI+LWM+RRYemR/zNbuevsaVwLD53hjd3YogBwag5nKiL/f5hX9eMlMWDXw==
X-Google-Smtp-Source: AGHT+IGtvyY2S8N9H8NXxhonZrHK8zzK12EnQLcYvZj7RQTllhlVsk74dShSegLQYXiYYn9WkJdHHQ==
X-Received: by 2002:a2e:b8cc:0:b0:2fa:fcf0:7c2a with SMTP id 38308e7fff4ca-2ff202079b4mr30780451fa.24.1731096166587;
        Fri, 08 Nov 2024 12:02:46 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed970713sm5879025f8f.3.2024.11.08.12.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:02:46 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [net-next PATCH] net: dsa: add devm_dsa_register_switch()
Date: Fri,  8 Nov 2024 21:02:16 +0100
Message-ID: <20241108200217.2761-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Suggested-by: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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


