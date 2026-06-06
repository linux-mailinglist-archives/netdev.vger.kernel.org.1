Return-Path: <netdev+bounces-296106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zYnZOTEYJGoz3AEAu9opvQ
	(envelope-from <netdev+bounces-296106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 14:53:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D638664D8B1
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 14:53:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ohlEaqEk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296106-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296106-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC153300C7D3
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D43AEF47;
	Sat,  6 Jun 2026 12:52:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E73ACA52
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 12:52:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750379; cv=none; b=suhPHrvxznE1s/EleJc9YHnkvhr2IMIUuVqu1LrtNXDap2wC+r+LZAQlRnn4DllhIsCcG6EijROJyN/e+DL0+zW0jobkooVge3hVkKF5G87MREtpWTIi8ToUoKE0wNyDskOVR7ZFhmrYcAy4NweQ9liyqr1brgIcPiDHyNRePg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750379; c=relaxed/simple;
	bh=XaTqpFxxwKS8yojvoQ6qdW4M4wgPwmYAuFFS3RqvR2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRcTLvhHwlKU57g2YCV8cf+gQ59gYqxDDmmeQ+oFb0MQ0M3X7NiF1kwVSGsgLZDbSzT4azQC047KxJaucZ49IUjBpCS8V171iu0ejfk/8A2qFlnlAZobgcXMumRH5G4l2YmJnTWzIXnVPZg0y2apUa8iqiG81QAMwJsESYyF9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohlEaqEk; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-842319576d5so1611640b3a.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780750377; x=1781355177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yTRs05ISCu/833adbwR/BZNotnYl1U3ybYttxpUcAg=;
        b=ohlEaqEkA/G1stN5cZWsvZ6ox8kzLkAa77PrWtMzofYb6LbzIDUe4NMvLXTvG50fOk
         FguJZCGflpKHudTwjqqEBiWa7VkNHZ/hi03urIpfxnfyRoiHNsMX3zeOrTKoUVIEt2WA
         bcIhHlck7dtrHlR9BY5w4Pi1d3wOJrBsWD4YH1Cp7SGsD5Ufe2zViB+ph2PTwGKLBoPg
         ej35k8bR5d4/d+DM72wgYaAQGARC2XKoTA/BDCBz0suzBinFTY3f0vStUmhbCxo68QhZ
         R9usW0jLckpKdYbJ6WI+PlGsz1iGspWGRlTWy4LRZlTr1QhuO4ucBSRTGAtoVksRPc52
         DffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780750377; x=1781355177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yTRs05ISCu/833adbwR/BZNotnYl1U3ybYttxpUcAg=;
        b=DKXL7F7bVzrDWNPW/Rvy3GMiQ6qcGwxr3njedksh5FS9PduNt+2GI878HLVcapKqCX
         u2gmr1NG5P7QOtvl1JEo3ICqX3i7ynUh+L7uoEcl+M7Jw3herpMbBhK0lK5yjvjwm8yF
         Qt+VxTdnsCwtsPQiDQW3CpbmVXOkJMt31lOC6WvBkXVLKljyy+XxSrM2UBuamQkPvQv9
         bB6yEApkiwmOgL976medse4cxx6CLhw6qTv3TKjAVe8WCadFrz4T+QIvmGPO0mmgQM83
         7rRu/68KOmkBzcFPxkso/vqlhw/DVS14jh5LkU88dBsI6hP0JGuUfa7Mx1eapZCDRHl2
         Jx+Q==
X-Gm-Message-State: AOJu0YykesLGzT4s7Kg2EWth7YjPiRqzKVMnGtUH2NUDowPKRWtauoFU
	HLCIngJWX12k92gKqj8G0DOM6YmXQVFwbgl+yhWTjzXHM1Zzl8QAMKSe55DY6N0R
X-Gm-Gg: Acq92OHfAIysy4Gy8rvJqvnTOn8yhlye2zr3VK7BhPfm+QNko+7U7HOWqXNQyuRERuV
	8Dv5+gMZd4CIznc+l6sqHoO1E5ac8qMqx8rPxSZOSscHd+H8FBsBRaWZap4VOkgNHoJ6jYDA8jP
	MF364oJBZELUVlNxq9Sn9KLtuYwhxBn3OxUVevZ+czR81i13zQn50b1pMqlyfB0C8Y4iN8OkfWA
	ckXq3jgUWoYRswe888XicA3hhRIx02qmH6XxfRbzG29XPUvGu05g9EIm7hq045iWnyPBi7usNVE
	q4qqCZr8KgSsEIHSVFKqoj7REcxfHqgXkpuxyszmGc0QQlhRcbfgfQCGyxxInQCHQR1E3G4FJL9
	XYNioAunQvKZWyPxxM1ETy9nKOk8koqJwQHyQ85EDf6P8w1wklXvmuer0uYv72Rfswjm4kKE1yM
	W4ZV6lJ8GSPg8KTBEcf5N+gf35waWfAP8JpOUwSUkJpRhyRqtfCCnYipk2cd9O
X-Received: by 2002:a05:6a00:ad0b:b0:82f:1b1b:e166 with SMTP id d2e1a72fcca58-842b1041871mr8509020b3a.33.1780750377375;
        Sat, 06 Jun 2026 05:52:57 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282904889sm12288621b3a.55.2026.06.06.05.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:52:56 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mscc: ocelot: validate netdev belongs to switch in .netdev_to_port()
Date: Sat,  6 Jun 2026 20:52:44 +0800
Message-ID: <20260606125247.305167-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296106-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:vladimir.oltean@nxp.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D638664D8B1

The .netdev_to_port() currently takes only a net_device and returns the
port index, without verifying the netdev actually belongs to the switch
being operated on. This can cause flower rule parsing to silently
resolve to a wrong port on the local hardware.

Update both implementations felix_netdev_to_port() and
ocelot_netdev_to_port() to validate ownership. Also update the callers
in ocelot_flower.c to pass through the ocelot context.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v1: https://lore.kernel.org/r/20260603024234.66603-1-mmyangfl@gmail.com
  - also fix ocelot_netdev_to_port()
 drivers/net/dsa/ocelot/felix.c            | 6 ++++--
 drivers/net/dsa/ocelot/felix.h            | 2 +-
 drivers/net/ethernet/mscc/ocelot.h        | 2 +-
 drivers/net/ethernet/mscc/ocelot_flower.c | 4 ++--
 drivers/net/ethernet/mscc/ocelot_net.c    | 4 +++-
 include/soc/mscc/ocelot.h                 | 2 +-
 6 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 4272ea6e9ca8..84a95007825f 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -2446,12 +2446,14 @@ struct net_device *felix_port_to_netdev(struct ocelot *ocelot, int port)
 }
 EXPORT_SYMBOL_GPL(felix_port_to_netdev);
 
-int felix_netdev_to_port(struct net_device *dev)
+int felix_netdev_to_port(struct ocelot *ocelot, struct net_device *dev)
 {
+	struct felix *felix = ocelot_to_felix(ocelot);
+	struct dsa_switch *ds = felix->ds;
 	struct dsa_port *dp;
 
 	dp = dsa_port_from_netdev(dev);
-	if (IS_ERR(dp))
+	if (IS_ERR(dp) || dp->ds != ds)
 		return -EINVAL;
 
 	return dp->index;
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index a657b190c5d7..19addcfd62be 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -104,6 +104,6 @@ int felix_register_switch(struct device *dev, resource_size_t switch_base,
 			  enum dsa_tag_protocol init_tag_proto,
 			  const struct felix_info *info);
 struct net_device *felix_port_to_netdev(struct ocelot *ocelot, int port);
-int felix_netdev_to_port(struct net_device *dev);
+int felix_netdev_to_port(struct ocelot *ocelot, struct net_device *dev);
 
 #endif
diff --git a/drivers/net/ethernet/mscc/ocelot.h b/drivers/net/ethernet/mscc/ocelot.h
index e50be508c166..42d2c456f712 100644
--- a/drivers/net/ethernet/mscc/ocelot.h
+++ b/drivers/net/ethernet/mscc/ocelot.h
@@ -92,7 +92,7 @@ int ocelot_mact_learn(struct ocelot *ocelot, int port,
 int ocelot_mact_forget(struct ocelot *ocelot,
 		       const unsigned char mac[ETH_ALEN], unsigned int vid);
 struct net_device *ocelot_port_to_netdev(struct ocelot *ocelot, int port);
-int ocelot_netdev_to_port(struct net_device *dev);
+int ocelot_netdev_to_port(struct ocelot *ocelot, struct net_device *dev);
 
 int ocelot_probe_port(struct ocelot *ocelot, int port, struct regmap *target,
 		      struct device_node *portnp);
diff --git a/drivers/net/ethernet/mscc/ocelot_flower.c b/drivers/net/ethernet/mscc/ocelot_flower.c
index 844292eb7422..c5983c56a544 100644
--- a/drivers/net/ethernet/mscc/ocelot_flower.c
+++ b/drivers/net/ethernet/mscc/ocelot_flower.c
@@ -233,8 +233,8 @@ ocelot_flower_parse_egress_port(struct ocelot *ocelot, struct flow_cls_offload *
 				const struct flow_action_entry *a, bool mirror,
 				struct netlink_ext_ack *extack)
 {
+	int egress_port = ocelot->ops->netdev_to_port(ocelot, a->dev);
 	const char *act_string = mirror ? "mirror" : "redirect";
-	int egress_port = ocelot->ops->netdev_to_port(a->dev);
 	enum flow_action_id offloadable_act_id;
 
 	offloadable_act_id = mirror ? FLOW_ACTION_MIRRED : FLOW_ACTION_REDIRECT;
@@ -580,7 +580,7 @@ static int ocelot_flower_parse_indev(struct ocelot *ocelot, int port,
 		return -ENOENT;
 	}
 
-	ingress_port = ocelot->ops->netdev_to_port(indev);
+	ingress_port = ocelot->ops->netdev_to_port(ocelot, indev);
 	if (ingress_port < 0) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Can only offload an ocelot ingress port");
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 1b8269320464..4d45e136f08f 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -984,7 +984,7 @@ static bool ocelot_netdevice_dev_check(const struct net_device *dev)
 	return dev->netdev_ops == &ocelot_port_netdev_ops;
 }
 
-int ocelot_netdev_to_port(struct net_device *dev)
+int ocelot_netdev_to_port(struct ocelot *ocelot, struct net_device *dev)
 {
 	struct ocelot_port_private *priv;
 
@@ -992,6 +992,8 @@ int ocelot_netdev_to_port(struct net_device *dev)
 		return -EINVAL;
 
 	priv = netdev_priv(dev);
+	if (priv->port.ocelot != ocelot)
+		return -EINVAL;
 
 	return priv->port.index;
 }
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 48d6deb3efd7..05a8191b148e 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -650,7 +650,7 @@ struct device_node;
 
 struct ocelot_ops {
 	struct net_device *(*port_to_netdev)(struct ocelot *ocelot, int port);
-	int (*netdev_to_port)(struct net_device *dev);
+	int (*netdev_to_port)(struct ocelot *ocelot, struct net_device *dev);
 	int (*reset)(struct ocelot *ocelot);
 	u16 (*wm_enc)(u16 value);
 	u16 (*wm_dec)(u16 value);
-- 
2.53.0


