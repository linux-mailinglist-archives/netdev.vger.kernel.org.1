Return-Path: <netdev+bounces-294527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CQIIAP2UH2q6nQAAu9opvQ
	(envelope-from <netdev+bounces-294527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5523B633B17
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:44:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cPkotrSr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294527-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294527-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4931307E9BD
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A353DC862;
	Wed,  3 Jun 2026 02:42:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BB3D6CDC
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 02:42:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454572; cv=none; b=Q+AX9svLHc+4kXcyzS/qwBbClPAJ59uUq2cJeRLBws90NpJrNK19ZqVuIBvAivh+kb/yEhTetBFiIUVQrHsxHr2m61obH/Pk6WsiojzczOQorboe1m46FeiyFHY9Vz9mnntK8N8Q42ccoTv62AOU/4uMagQb1ntMEH7yRNvsOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454572; c=relaxed/simple;
	bh=nk/5cRH+23kz3i5YCQ7JAJlTZAP5X4KP84ML8CoQwkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JGH929AYK7gKNHNxvLzRGiyUGaA5hNRNmT/iEcEI03qCqo0gyT7KIP4oPAkhbPS2pb99da5flkFUUgLFbloMQ+uuXmVeUMhrFbTngADQ7wah8Crl8zT+KHeEhxOwHaizPntj/ulNOyHi1s1AX8sQn6FsO854mQ2tIjXvp02XWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPkotrSr; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so5604964a91.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 19:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780454569; x=1781059369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9hGJ6zw7Uq6VFdPGEv6WZhGo5EeVEyFBc1oHCLMzjg=;
        b=cPkotrSrblMJg0VkQemG1yM2SrRRSvFa+7n8iSeIxGrPCMgj62Uuj72kSg1OFZzBeq
         IumtKeQv/zTHcpYKw++cSnMf0RpvfXNG+joFWQjxdTjYjloF077c7UtWPlqCFjZKQ4eA
         FLR1otwhA0yheoKSFmmLsiXEFDJcecELOcSbFZ2HKMR16CyhEOadW5IsIChyATVRVLJB
         DqnhDJvR74EbpSe7f/Nt3GMJNwRj5s6WHei/NSq1iGuBn+souh125mbFDFAxjmx9Ybk0
         BnAnoXYXAgyGNVl9Ma07eMJKOm60J/+m1jsakIRMwsyOVuwR9ItuQnnAHqxFSWTinCpk
         xjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780454569; x=1781059369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9hGJ6zw7Uq6VFdPGEv6WZhGo5EeVEyFBc1oHCLMzjg=;
        b=lxsLvL6QPdThUA0VNOIJNjvs8guiL46QovYh5n9gl3JoDhc7LbWASxwZMGfz/UBGqt
         PsW3J15K0IyQkqDVd+IdE5mDfbDW5vTRb+OeIkQ1Ul3aufQ77XFlg8mVbGvw6VrzPRyr
         M7yigFi2w4nBY+Mv0vBO5YMx+AExMRMrlnD9prewOszjpqL3c9u5tAZmOxhwIsfBG380
         HNEzj/0Fq0E7tkkdC5xH3rnz+Tpt/yKDWUrhgLOhhiq0JNBVgkhE47Bc3y8pofmnJzA7
         KD0LHstAXIp/8NE3W1pLhAf+hH64QaL/qG8r1b8HXJjKZ3Zmveb9Kw0Vj7SJ5/YAxjdg
         h+mw==
X-Gm-Message-State: AOJu0YzpCdYmzCJkybUXPL71dSR+KiMlNFbJqC7IdUmtz6OaarFd+b+o
	KhZhm5IcXO0h4Lv+0r77a455OPB2KZnQR2C/kwZ8AF4w/H5VhPYhKiUJiNvgiGQK
X-Gm-Gg: Acq92OEeldWXAIACVyfiq6q2qvWlWjKN1kpbTMmmDQElhr9LipS0NODgadWggpEhJHg
	7RA08/rygL5RbUCCq5MyPUrvP3F69gXamgBWoSG8BJryu3Fkt0GrVz8+Lp/pc+fJd7FmkWxBZ6F
	yp6mg+iiPtGOv/0LYnaW5XjpBSbMyRWoy6+wqz8ILkgzTZZjCpfZq8EJfiWPOACV+cZZnkUsW60
	IJcSF98ymQIhzTx6m+Noj8rb/OuM3cKoOlJBpTT+oOTsuE6uzWDV5h/nsbmIphn1ClYhQJxAgdu
	GgkHpESIsNyUFRxInhzCXpW7ab0k2gT+C+xmHVzLqu9eSjYOcqMH2U6xjss7BWZiotw+YHud8s/
	WxDn1F205cQvU25/6C3bWtv92kE4YR6cLLhYCUjgtCGmvEXt5WSNACeDbzq+apdspP84IvdxGQs
	ZHJ8+B+XDLZIjZezhvSlOgWluI6wThJk63a4A/Kb8BXcZ1931RjBgXUEIV+U2g
X-Received: by 2002:a17:90b:560c:b0:36d:bc0d:f78c with SMTP id 98e67ed59e1d1-36e34292d97mr1367654a91.21.1780454569452;
        Tue, 02 Jun 2026 19:42:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e6e9be5f2sm164384a91.4.2026.06.02.19.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:42:49 -0700 (PDT)
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
Subject: [PATCH net-next] net: dsa: felix: validate switch in .netdev_to_port() conversion
Date: Wed,  3 Jun 2026 10:42:30 +0800
Message-ID: <20260603024234.66603-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294527-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:vladimir.oltean@nxp.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5523B633B17

felix_netdev_to_port() uses dsa_port_from_netdev() without checking
whether the resulting dsa_port actually belongs to the switch being
operated on. The port index is then consumed by flower rule parsing,
silently resolving to a wrong port on the local hardware.

Add a dp->ds mismatch check and adjust struct ocelot_ops accordingly.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/ocelot/felix.c            | 6 ++++--
 drivers/net/dsa/ocelot/felix.h            | 2 +-
 drivers/net/ethernet/mscc/ocelot.h        | 2 +-
 drivers/net/ethernet/mscc/ocelot_flower.c | 4 ++--
 drivers/net/ethernet/mscc/ocelot_net.c    | 2 +-
 include/soc/mscc/ocelot.h                 | 2 +-
 6 files changed, 10 insertions(+), 8 deletions(-)

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
index 844292eb7422..0c3aa61c1413 100644
--- a/drivers/net/ethernet/mscc/ocelot_flower.c
+++ b/drivers/net/ethernet/mscc/ocelot_flower.c
@@ -234,7 +234,7 @@ ocelot_flower_parse_egress_port(struct ocelot *ocelot, struct flow_cls_offload *
 				struct netlink_ext_ack *extack)
 {
 	const char *act_string = mirror ? "mirror" : "redirect";
-	int egress_port = ocelot->ops->netdev_to_port(a->dev);
+	int egress_port = ocelot->ops->netdev_to_port(ocelot, a->dev);
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
index 1b8269320464..d2e96d065dc4 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -984,7 +984,7 @@ static bool ocelot_netdevice_dev_check(const struct net_device *dev)
 	return dev->netdev_ops == &ocelot_port_netdev_ops;
 }
 
-int ocelot_netdev_to_port(struct net_device *dev)
+int ocelot_netdev_to_port(struct ocelot *ocelot, struct net_device *dev)
 {
 	struct ocelot_port_private *priv;
 
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


