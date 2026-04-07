Return-Path: <netdev+bounces-276072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJLKIswu1WmU2AcAu9opvQ
	(envelope-from <netdev+bounces-276072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:20:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2437B3B1BAC
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF96A30AF70F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9B387372;
	Tue,  7 Apr 2026 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZTpZcQ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F743CF67C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578226; cv=none; b=gS7kb0vnCxoMKPum8/3c9Aga3VzeVjNzBMw/FG3wH7e/MazYYPyMVKb8wxmUBzRgpMvtQT/3lUT0oRohWVtuUsr9P6lZf0ptIWhEwsGLhWQwRuVCiuHecu3JwOi2/RJ2QueR4XOGX06mAAdMBEcPCtenS5uEzFa4aTgJotqnjFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578226; c=relaxed/simple;
	bh=v+E1MO93EOHLyDkpX6IzNEHlsvKdg/1FgUS+hyR8of4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXkpJXYEEf4i1JzT5NFBAUdF47lJD94ocK4sVXpxIKSzfFsk3f2AF/SKzHreWm/MvwIGCLfgjgQb+69vw0DMhcznTNMTHzO6kL2iBypfDpbXRwZXljh00PGw3wvRA6iqDd6INv1zfKCLRsvMR7JWyJqxmqQkE/mTJNdzhRFgilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZTpZcQ9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so1924228a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775578218; x=1776183018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm1sew/8xxotCRJE85MOTIviBnsMsznbuVyL8JjP6fo=;
        b=UZTpZcQ9wc+CFaMHYsyXcRlKDJGjvKxd8bgMasKI5YLKYOcKNAO8IteifxlJe46ts3
         +r7Gx++jVgej0cVmzgG1VYJuDgWrnrJKQ+y6Fk/WlENZcOS1V3304R5KxIFaSEefPjwx
         7o+lbazpNg3uAIzNl6jevvJANnYQYLW+OJkzYQs/gxzZfOj4EaTHZvU3f1E42Ze2gT+m
         A/VsR4lMKggEKSqXxI2dRK3EYmqToEHdSJZFy7FZERt4qUtf9OmqGami8ldYbR5efyiJ
         x74jXyZfqAy+F7x8+GByib0ktyM+nZxy/ZxlrWj60iQDnUoZZ3gIVs49wyIfwHcJZ9Kz
         r38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578218; x=1776183018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vm1sew/8xxotCRJE85MOTIviBnsMsznbuVyL8JjP6fo=;
        b=YYvW7rtEteXhkHAzdjVYzgHoOGpZaH8U2nkNINb3hGEREVQAqcE1MltkEeOkTCwL6V
         s3z38PUhMtKu95d1ol0TxyB/d0TiPMIily3luQtLwu8Dwb4F4NnDSNFRsU43TYE6AV7w
         3VY+BFJszgAe558CfNut5nP7ehKcxLLA9fssmKOFlw3gYMFYWZYfv55zhT4OlunYXl7J
         X6pxi9nSpk84lG9nnRBqGB08FwfLT+PsUuE732Zkjbn4utEMrFEaekOeZQx3x99y6Q66
         nwrFB3vd8niA00xAQaP92MHpRez3WYvBHjMzFVd1X4ea4kxLj+qffJQHC9zoIm37CAAe
         x63g==
X-Gm-Message-State: AOJu0Yxcu6U6x5HsxNx2j4JjYisxyT4tqPOUn1FTB5n7vRI8Ha8SrcZI
	AVopYnFj8f7ae92qb4RgrC4zCT3cOORaA4t9aATTFV45ih322QdaSIR7XsD5Sg==
X-Gm-Gg: AeBDietVSq1cTCPs7Y5drkV9I2d6hmHWe1PG2KZoqlKSfq2FhrVi5uj8/QXKhn6w6JH
	4V5qY1IUUCj/a5FEeRrZEWXSf8DwKOGBjJ1RLTHPNUQe9aXDmXOGCQ4Xm7WsO7WkvkYm/hQimtk
	Xej0iH3LM96QHJGUZG0ksMMh0Cms6oynR6RceusOpXu+arLN5Jb5f/IKQDtK/HYD4rkP9N/x+cw
	R/bbjJK1czkziSnDgPv/zf+7bcgqFAvWMx5q71vr5D3XTX/fROTFQnJb/SuB7sqtlJ1Nie+07PW
	EexSTwHWo37QcERJTF7o6dtyKEBW6VKRAxJY4fyA5uowAgFL6nRQBsLB4o4RGSSoPISrYuFrt4y
	3jLLPS04YLfFi2LuT1YApiI7vQy7lEL5lgL4RnmG2lZCgHpwxnt3O4KB1oNGeYVghsw+9VpvLIK
	bDuiW2dMPBan21QYPKB1AshuRho6SJI8tyOo2MxkkahozzZoG8
X-Received: by 2002:a05:6a20:a11a:b0:398:9301:b9ae with SMTP id adf61e73a8af0-39f2f11b8a1mr18437529637.52.1775578218119;
        Tue, 07 Apr 2026 09:10:18 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6372078sm15650238a12.0.2026.04.07.09.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:10:17 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/4] net: dsa: pass extack to user tc policers
Date: Wed,  8 Apr 2026 00:05:53 +0800
Message-ID: <20260407160559.1747616-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407160559.1747616-1-mmyangfl@gmail.com>
References: <20260407160559.1747616-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,nxp.com,microchip.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276072-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2437B3B1BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Users may use extack for a friendly error message instead of dumping
everything into dmesg.

Make the according transformations to the two users (sja1105 and
felix).

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


