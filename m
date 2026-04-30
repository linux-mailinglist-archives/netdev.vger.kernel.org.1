Return-Path: <netdev+bounces-282810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGZJEVZC82nMywEAu9opvQ
	(envelope-from <netdev+bounces-282810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:51:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 411A24A25F3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CC263016D37
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092CF3A1686;
	Thu, 30 Apr 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4qFP17Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26EF3FCB14
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549555; cv=none; b=GbtqVvpYO9k6rqsn1IpmzRZyQyZZGP1/oBxIA9BWvcjvhLQOiGucK8GCWyQKz3t9sjCg+oGi9SLx/p9VPddJRM1XCNCWet359b40QRgghVYQkBKI8fjbMI/8o8xzvP8T5L5E5lolzjyUjktpgydyy9VK+PqwWmWO4iUrYX0Bk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549555; c=relaxed/simple;
	bh=pQsdsngi7xJbMC0DhlA4xDQB0AlSNkiEtvxDsUc3YJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sF9bzDAB0k7fFaVSaxUY2r+VZIanYSt8/NWClwL24hoNJvY/yMAYnW/M+7JUZYaON5QCa6UouyPt3tz56fTCWrlFGWFNaO+yvJmRhoVaTeKvu7PI0vcDgiw3qaRtP0DafDjEHeOBS6+EL34ST9HNEhz/B2shYDa5KHbh89PoUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4qFP17Y; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a871daa98fso4823045ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777549554; x=1778154354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkGu6l8elNHejMOrOk+YYmlLgI6Oh4DCOBagI53T70E=;
        b=V4qFP17YV0GilGt9eSRWTNzO/HkDREpevWC1SYHrsSzZCwLobdvAz0pvO1g9DGE4CN
         bK7ClmUI4Ev6oqt548RjE6LAHzMkThJIxOFxrcPA4QrATHPVCbYj7CDtDjOQ139iLSsE
         j7WAKuciis+p1RD0ttxr9MkRQ+1fOcABKr2dIazeYfOESoR0QZDN7GeyMn23medybFyB
         KyVtjOHOXYl2RFQnG1rcoxvd5i3Xz7vaQhxopFjLC1hgH3bDCPrquzqUlfINUyCYVSZ/
         rDkEdY5b6fbzcOzVoXDDMMSE9Kat8YOg2VXXbps/a6XsXQCgbY1WWE+oy6nVVKJz+YtO
         67zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777549554; x=1778154354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkGu6l8elNHejMOrOk+YYmlLgI6Oh4DCOBagI53T70E=;
        b=KGa35MlVKX5uN3Ahv7FhRl3To3pTb7xq0eMi92lUegOnw7E370UKB2GvjVzsgeqnfG
         aQbBkEV7FPi/f+ZZ9cKKjQ7LNQ71wJXBqDFV5cSSvJaj7dD3lTUyV3CWkuv30Z1BSOHT
         HGdhJdQTSzA1uaTIRPpOm+Mkt1YnZqWhQG4RHXjeLerePSD4CkcxT7Tuow0UQ7eaR3mz
         anV/9xVUYjVIF/dWgY15Eelipp4X0LQrBs0tGjm6E8T8TB3OVuCO0Pd09FkRb4Cfbt72
         910q6FDuCpkqud0Wdp0fj25eq9gNYciYz2dCoM3wgzhg5L/SroxZsX2fcOg03ZIjHY27
         LdMA==
X-Gm-Message-State: AOJu0YyluDDqPz23vR5RjLf5VD5IDRq5GkTFOLuRrDzeFHygyJoyh7IK
	mB4LVOql7VsRBq0strHjDYL1k+El36uhBAb4FeJLf/b/56FQdp5tcEQNxXdj6UCW
X-Gm-Gg: AeBDievMmU5AmQtEinX+C45yv/jGPdWfmd7qPj6lYXOSXhduw8uWZnLWL0rNqa4kD/h
	tGdYC802NdEZvmPxpanogCO7awyM1FRcP/l5mCDLWSfbHBYnE8cnitYT+Kf4IvuGcbDCkqTLDQz
	akBvkK8Ra9Fhw3IsfB/wyGM2bwikwQHzW3qFMNJSmEnphBIBdSL4VgzXicnnjb/Vp2FureKc300
	Y4QhAEdsUrpjX5QOvmU9/gPhJlRuoZ8HBrFONXxB8HPAn4MVT1jKZcXGEcB2XmfDD/BSwmW1+jV
	+bRWceboJyW3fm5FVPbGUhHJF4mA0KsDp0EJJqUmHNQ9WMvhhw2DR1LlkPGRm3OmLrHsSjbNYFD
	585rfRyzx8aCwnvogre3KhGpzK4VmwlV2CsoUqvciJRWP60CKQpse9dbOESLK4sO8acxpvZiWgK
	a/HXr0CZzLAwLM7UhEwuhs45/EJA3JL0QcKpB5NM9AzjHxc/GuhQ5pPjQvO76r
X-Received: by 2002:a17:903:3848:b0:2b9:a5be:d2f6 with SMTP id d9443c01a7336-2b9a5bed841mr24429085ad.0.1777549553973;
        Thu, 30 Apr 2026 04:45:53 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98895afaesm69245665ad.57.2026.04.30.04.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 04:45:53 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/3] net: dsa: pass extack to dsa_switch_ops :: port_policer_add()
Date: Thu, 30 Apr 2026 19:45:24 +0800
Message-ID: <20260430114529.3536911-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430114529.3536911-1-mmyangfl@gmail.com>
References: <20260430114529.3536911-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 411A24A25F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,nxp.com,microchip.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282810-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:email]

Drivers might have error messages to propagate to user space. Propagate
the netlink extack so that they can inform user space in a verbal way of
their limitations.

Make the according transformations to the two users (sja1105 and felix).

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/ocelot/felix.c         | 3 ++-
 drivers/net/dsa/sja1105/sja1105_main.c | 3 ++-
 include/net/dsa.h                      | 3 ++-
 net/dsa/user.c                         | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 84cf8e7fb17a..4272ea6e9ca8 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -2001,7 +2001,8 @@ static int felix_cls_flower_stats(struct dsa_switch *ds, int port,
 }
 
 static int felix_port_policer_add(struct dsa_switch *ds, int port,
-				  const struct flow_action_police *policer)
+				  const struct flow_action_police *policer,
+				  struct netlink_ext_ack *extack)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct ocelot_policer pol = {
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index c72c2bfdcffb..dbfa45064747 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2847,7 +2847,8 @@ static void sja1105_mirror_del(struct dsa_switch *ds, int port,
 }
 
 static int sja1105_port_policer_add(struct dsa_switch *ds, int port,
-				    const struct flow_action_police *policer)
+				    const struct flow_action_police *policer,
+				    struct netlink_ext_ack *extack)
 {
 	struct sja1105_l2_policing_entry *policing;
 	struct sja1105_private *priv = ds->priv;
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 8b6d34e8a6f0..4cc67469cf2e 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1122,7 +1122,8 @@ struct dsa_switch_ops {
 	void	(*port_mirror_del)(struct dsa_switch *ds, int port,
 				   struct dsa_mall_mirror_tc_entry *mirror);
 	int	(*port_policer_add)(struct dsa_switch *ds, int port,
-				    const struct flow_action_police *policer);
+				    const struct flow_action_police *policer,
+				    struct netlink_ext_ack *extack);
 	void	(*port_policer_del)(struct dsa_switch *ds, int port);
 	int	(*port_setup_tc)(struct dsa_switch *ds, int port,
 				 enum tc_setup_type type, void *type_data);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index c4bd6fe90b45..8704c1a3a5b7 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1499,7 +1499,7 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 	policer = &mall_tc_entry->policer;
 	*policer = act->police;
 
-	err = ds->ops->port_policer_add(ds, dp->index, policer);
+	err = ds->ops->port_policer_add(ds, dp->index, policer, extack);
 	if (err) {
 		kfree(mall_tc_entry);
 		return err;
-- 
2.53.0


