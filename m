Return-Path: <netdev+bounces-281810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFgkOMKg8GnrWQEAu9opvQ
	(envelope-from <netdev+bounces-281810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:57:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A248464F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D35930EC0BA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BC3F54C9;
	Tue, 28 Apr 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU3BWDfB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75353F23C0
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375601; cv=none; b=ntZDj56IJIfYctUOGQ0BzBSXTEW+uLgOLL1+ctInYkaGD8D6RSBC+40qVUsN0FGGt3ojbhn2Jl3vyKMSY8C41vAvxz4j7XqCKKiXprHzXiM9r+fC0FI4xjquG3MD73a9pN1EFUwjo0705whu0M12WQJhoCqbsip/I15SLfwwHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375601; c=relaxed/simple;
	bh=pQsdsngi7xJbMC0DhlA4xDQB0AlSNkiEtvxDsUc3YJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO830oilZNNxO6/Od7/3fO8/dSpF9FvSXMUUFWxQlfDg1ltp7wfmQ+pIiA3lsDzLwPMSQ8pfLtfcFQQTa02iNJvGhgYY1WIb1x+ltzgm1dLWVvIEea7qsT5odOYGPQ0wUXPXGfYWHJJF5QEf1IG3zO6sVZtaNRcC0k4ce8aUdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU3BWDfB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso7811738b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777375599; x=1777980399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkGu6l8elNHejMOrOk+YYmlLgI6Oh4DCOBagI53T70E=;
        b=FU3BWDfBxKKzHCQ6BNaVWx7wS1vGpzDuw5DSktQ58aMz7bcxWvSF1t59uRQyiI1k+s
         ijSYQGt50Mqsll0HwixNol4FjvSGuvVWH7nOF8sVxaa0c4D2PpryAx1k4s1QStDbG+Oo
         8c3KDxdlzMeh0MQUgf3Tr2JABWwWFF+iFwNtJimmG8aNNa2z6SkmgITAVrSVREi+yr2d
         DP3LFGTcFyf5R5HqMHF+HhQJdTiwwtHbOQ3LynqrDasC0SpvZKr7UpCsaa3CEegYSckX
         NMa/xsd67b/X7NnDuletw/ybLw/FbVUE1KGMBB5iK9XHCWdaX39DUtt7AjvlIBI7kjY/
         LExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375599; x=1777980399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkGu6l8elNHejMOrOk+YYmlLgI6Oh4DCOBagI53T70E=;
        b=tG+AstDHJV7UiKvkCA+0ENv9qAlmMq0/COJnCFpQrBl2b1fq/o30pU8wn2OshxHMvE
         eb6XAB33C4kxxK+M7+0wPjpQqED0GtUPMh6zjiFmAeUvaIPnyueTwScXMgY2dwiZqwWT
         KoaiXPOvr2J5niTec56MGclonTBggxHI+ThB1a0JogwZSpHDuzDfZDNu2X9p3YzL/c4y
         spFPv6t0mAEH7/kBtmL3/WCz4WOEtU16WgJ5ApQKwTcPsmCjEh0hepJGLGP8A3dtPYop
         /fh4WFtJsrX8kvacQe7oOe8W+uTmMG73FXxIYYMHwOEjoWHD7DaHjJ9L0wt9BDr+JzU8
         9JIA==
X-Gm-Message-State: AOJu0YzPxRDS11/6LeiHIi5Iqqo0CRBAG0/o8HcWjoYfHlmB5aVizJJq
	Gvt63T3t+YJjmNxwOf9dPCd48NgPEPs0fqeDlWYBsxWSzcr3iM8fKsKedf4+eYol
X-Gm-Gg: AeBDiev56xL75r9RCjqzsrfPsP8WlfyQKQRy7Vw+TO5S70P5oSMO/8jCymYV4pQufrc
	6B6DMdeN9FxTV+YCBLU1Q0yli/vdpCqgyrNVBUtS3lgbd+r+aE+eMSY64z8H6Ay81lvy9qPV8v6
	90/Y8qfpkVl+9wqkirREsYHGjH+R8nfIpWsmqrH1NxUraIuFyjRe02HgBTGXe+RcFe+Mv4rV4h8
	oRMQfKVCmO7usKh5QLyO2DUMwElu7DImi/8X6stUZm+cws8yP05SG55RTgMdhsEIW2RakACNUFV
	iKlgfxtuM5x3FTBRkY8KLVL6bSmRyRMEVgUpzlfBkBrkhCedB7aFWJNujdGJEhdXKVxLemxTFjl
	VTHY9puojtBmM97KWBbFNhADlQ+xw999Z2Px3dwpdDomQzpDt+MwwD8TmuCBt4916QMGjUjJN75
	47IWapw4GqpSMjghc/i6ZTN1qIjhxg9LunkTv0PyI6Tg9ZTT6vR7ilQJ5kWh/e
X-Received: by 2002:a05:6a00:12c1:b0:82f:3828:a00a with SMTP id d2e1a72fcca58-834ddc581cbmr2642074b3a.41.1777375598994;
        Tue, 28 Apr 2026 04:26:38 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae36b4bsm2284327b3a.27.2026.04.28.04.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:26:38 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/3] net: dsa: pass extack to dsa_switch_ops :: port_policer_add()
Date: Tue, 28 Apr 2026 19:26:01 +0800
Message-ID: <20260428112606.1917230-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428112606.1917230-1-mmyangfl@gmail.com>
References: <20260428112606.1917230-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 559A248464F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,nxp.com,microchip.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281810-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]

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


